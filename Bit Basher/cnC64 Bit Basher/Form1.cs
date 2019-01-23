using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace cnC64_Bit_Basher
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnGo_Click(object sender, EventArgs e)
        {
            int stepUnit = Convert.ToInt16(tbStepsUnit.Text);

            tbResult.Clear();

            lineBresenham(Convert.ToInt16(tbX0.Text)*stepUnit, Convert.ToInt16(tbY0.Text) * stepUnit,
                Convert.ToInt16(tbX1.Text) * stepUnit, Convert.ToInt16(tbY1.Text) * stepUnit);
        }

        // Axis with gretest change is leader, other axis is follower.
        // In each loop we step leader and evalvuate weather to step follower.
        // Variable 'fraction' keeps track of fractional steps of the follower,
        // if the fraction > 1/2 then follower steps (fraction is decremented).
        // The fraction increment is the slope, i.e. (y1-y0/)(x1-x0), multiply
        // by (x1-x0) and scale by 2 eliminating floats: frac_inc = 2*(y1-y0)
        // X and Y might have opposite roles depending on slope.
        private void lineBresenham(int x0, int y0, int x1, int y1)
        {
            //byte outByte = 0; // holds calcualted next output byte
            //bool xStepPulse = false; // used to display step status of each axis
            //bool yStepPulse = false;

            line descLine = new line(x0, y0, x1, y1);
            List<line> segList = new List<line>();
            segList.Add(descLine);

            int step = 0;
            int mod = Convert.ToInt16(tbMod.Text);
            // Leader/follower axis decided by deltas, leader is bigger delta
            if (descLine.dx > descLine.dy)
            {
                //xStepPulse = true;
                //if (descLine.x0 > descLine.x1) { outByte |= 0x01; } // set xdir for kicks
                //if (descLine.y0 > descLine.y1) { outByte |= 0x08; } // set xdir for kicks

                line lin;

                while (descLine.x0 != descLine.x1)
                {
                    if (step > 0 && step % mod == 0)
                    {
                        if (segList.Count == 1)
                        {
                            lin = new line(segList.Last<line>().x0, segList.Last<line>().y0, 
                                descLine.x0, descLine.y0);
                        }
                        else
                        {
                            lin = new line(segList.Last<line>().x1, segList.Last<line>().y1, 
                                descLine.x0, descLine.y0);
                            if (lin == segList.Last<line>()) { tbResult.Text += "ping" + Environment.NewLine; }
                        }
                        
                        segList.Add(lin);
                    }

                    //yStepPulse = false;
                    descLine.x0 += descLine.stepX;
                    if (descLine.fraction >= 0)
                    {
                        //yStepPulse = true;  // used for displaying step logic
                        //outByte ^= 0x04;    // toggle yStep for each step

                        descLine.y0 += descLine.stepY;        // step Y axis
                        descLine.fraction -= descLine.dx;     // dec fractional step accumulator by one full step amount
                    }
                    descLine.fraction += descLine.dy;         // increase fractinal step accumulator each loop
                    step += 1;
                }
                // add last segment here
                if (segList.Count == 1)
                {
                    lin = new line(segList.Last<line>().x0, segList.Last<line>().y0, 
                        descLine.x0, descLine.y0);
                }
                else
                {
                    lin = new line(segList.Last<line>().x1, segList.Last<line>().y1,
                        descLine.x0, descLine.y0);
                }
                segList.Add(lin);

                printSegList(segList);
            }
            else
            {
                line lin;

                while (descLine.y0 != descLine.y1)
                {

                    if (step > 0 && step % mod == 0)
                    {
                        if (segList.Count == 1)
                        {
                            lin = new line(segList.Last<line>().x0, segList.Last<line>().y0,
                                descLine.x0, descLine.y0);
                        }
                        else
                        {
                            lin = new line(segList.Last<line>().x1, segList.Last<line>().y1,
                                descLine.x0, descLine.y0);
                            if (lin == segList.Last<line>()) { tbResult.Text += "ping" + Environment.NewLine; }
                        }

                        segList.Add(lin);
                    }

                    //xStepPulse = false;
                    descLine.y0 += descLine.stepY;
                    if (descLine.fraction >= 0)
                    {
                        descLine.x0 += descLine.stepY;
                        descLine.fraction -= descLine.dy;
                        //xStepPulse = true;
                        //outByte ^= 0x01; // toggle yStep for each step (step on each edge)
                    }
                    descLine.fraction += descLine.dx;
                    step += 1;

                }

                // add last segment here
                if (segList.Count == 1)
                {
                    lin = new line(segList.Last<line>().x0, segList.Last<line>().y0,
                        descLine.x0, descLine.y0);
                }
                else
                {
                    lin = new line(segList.Last<line>().x1, segList.Last<line>().y1,
                        descLine.x0, descLine.y0);
                }
                segList.Add(lin);

                printSegList2(segList);
            }

        }

        // segList contains: x0, y0, x1, y1, dx, dy, stepY, stepY, fraction, mask
        private void printSegList(List<line> segList)
        {
            // ;   #rep#step, daLSBMSB, dbLSBMSB, frLSBMSB, acl, dir, mod
            tbResult.Text += "index\tfrom\t\tto\t\t#steps\tda\tdb\tfrac\tmask\tmode" + Environment.NewLine;

            for (int i = 0; i < segList.Count; i++)
            {
                tbResult.Text += i.ToString()+ "\t" 
                    + "(" + segList[i].x0.ToString() + "," + segList[i].y0.ToString() + ")\t\t"
                    + "(" + segList[i].x1.ToString() + "," + segList[i].y1.ToString() + ")\t\t"
                    + segList[i].numSteps.ToString("X4") + "\t"
                    + segList[i].dx.ToString("X4") + "\t" + segList[i].dy.ToString("X4") + "\t"
                    //+ segList[i].stepX.ToString() + "\t" + segList[i].stepY.ToString() + "\t"
                    + ((short)(segList[i].fraction)).ToString("X4") + "\t" + segList[0].mask.ToString("X2") + "\t"
                    + "1" + Environment.NewLine;
            }
        } // end of printSegList

        // segList contains: x0, y0, x1, y1, dx, dy, stepY, stepY, fraction, mask
        private void printSegList2(List<line> segList)
        {
            // ;   #rep#step, daLSBMSB, dbLSBMSB, frLSBMSB, acl, dir, mod
            tbResult.Text += "index\tfrom\t\tto\t\t#steps\tda\tdb\tfrac\tmask\tmode" + Environment.NewLine;

            for (int i = 0; i < segList.Count; i++)
            {
                tbResult.Text += i.ToString() + "\t"
                    + "(" + segList[i].x0.ToString() + "," + segList[i].y0.ToString() + ")\t\t"
                    + "(" + segList[i].x1.ToString() + "," + segList[i].y1.ToString() + ")\t\t"
                    + segList[i].numSteps.ToString("X4") + "\t"
                    + segList[i].dy.ToString("X4") + "\t" + segList[i].dx.ToString("X4") + "\t"
                    //+ segList[i].stepY.ToString() + "\t" + segList[i].stepX.ToString() + "\t"
                    + ((short)(segList[i].fraction)).ToString("X4") + "\t" + segList[0].mask.ToString("X2") + "\t"
                    + "2" + Environment.NewLine;
            }
        } // end of printSegList



    } // end of form1 class
}

