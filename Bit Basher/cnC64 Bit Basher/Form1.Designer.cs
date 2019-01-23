namespace cnC64_Bit_Basher
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tbResult = new System.Windows.Forms.TextBox();
            this.btnGo = new System.Windows.Forms.Button();
            this.tbX0 = new System.Windows.Forms.TextBox();
            this.tbY0 = new System.Windows.Forms.TextBox();
            this.tbX1 = new System.Windows.Forms.TextBox();
            this.tbY1 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.tbStepsUnit = new System.Windows.Forms.TextBox();
            this.tbMod = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // tbResult
            // 
            this.tbResult.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbResult.Location = new System.Drawing.Point(12, 22);
            this.tbResult.Multiline = true;
            this.tbResult.Name = "tbResult";
            this.tbResult.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.tbResult.Size = new System.Drawing.Size(831, 295);
            this.tbResult.TabIndex = 0;
            // 
            // btnGo
            // 
            this.btnGo.Location = new System.Drawing.Point(916, 287);
            this.btnGo.Name = "btnGo";
            this.btnGo.Size = new System.Drawing.Size(75, 23);
            this.btnGo.TabIndex = 1;
            this.btnGo.Text = "GO!";
            this.btnGo.UseVisualStyleBackColor = true;
            this.btnGo.Click += new System.EventHandler(this.btnGo_Click);
            // 
            // tbX0
            // 
            this.tbX0.Location = new System.Drawing.Point(916, 98);
            this.tbX0.Name = "tbX0";
            this.tbX0.Size = new System.Drawing.Size(47, 20);
            this.tbX0.TabIndex = 2;
            this.tbX0.Text = "0";
            // 
            // tbY0
            // 
            this.tbY0.Location = new System.Drawing.Point(969, 98);
            this.tbY0.Name = "tbY0";
            this.tbY0.Size = new System.Drawing.Size(47, 20);
            this.tbY0.TabIndex = 3;
            this.tbY0.Text = "0";
            // 
            // tbX1
            // 
            this.tbX1.Location = new System.Drawing.Point(916, 124);
            this.tbX1.Name = "tbX1";
            this.tbX1.Size = new System.Drawing.Size(47, 20);
            this.tbX1.TabIndex = 4;
            this.tbX1.Text = "512";
            // 
            // tbY1
            // 
            this.tbY1.Location = new System.Drawing.Point(969, 124);
            this.tbY1.Name = "tbY1";
            this.tbY1.Size = new System.Drawing.Size(47, 20);
            this.tbY1.TabIndex = 5;
            this.tbY1.Text = "128";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(870, 101);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(40, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Point 1";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(870, 127);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(40, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Point 2";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(870, 16);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(58, 13);
            this.label3.TabIndex = 8;
            this.label3.Text = "Steps/Unit";
            // 
            // tbStepsUnit
            // 
            this.tbStepsUnit.Location = new System.Drawing.Point(935, 13);
            this.tbStepsUnit.Name = "tbStepsUnit";
            this.tbStepsUnit.Size = new System.Drawing.Size(81, 20);
            this.tbStepsUnit.TabIndex = 9;
            this.tbStepsUnit.Text = "1";
            // 
            // tbMod
            // 
            this.tbMod.Location = new System.Drawing.Point(935, 39);
            this.tbMod.Name = "tbMod";
            this.tbMod.Size = new System.Drawing.Size(81, 20);
            this.tbMod.TabIndex = 11;
            this.tbMod.Text = "255";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(870, 42);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(32, 13);
            this.label4.TabIndex = 10;
            this.label4.Text = "MOD";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(932, 82);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(63, 13);
            this.label5.TabIndex = 12;
            this.label5.Text = "X              Y";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1028, 344);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.tbMod);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.tbStepsUnit);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tbY1);
            this.Controls.Add(this.tbX1);
            this.Controls.Add(this.tbY0);
            this.Controls.Add(this.tbX0);
            this.Controls.Add(this.btnGo);
            this.Controls.Add(this.tbResult);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tbResult;
        private System.Windows.Forms.Button btnGo;
        private System.Windows.Forms.TextBox tbX0;
        private System.Windows.Forms.TextBox tbY0;
        private System.Windows.Forms.TextBox tbX1;
        private System.Windows.Forms.TextBox tbY1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbStepsUnit;
        private System.Windows.Forms.TextBox tbMod;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
    }
}

