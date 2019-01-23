public struct line
{
    public int x0, y0, x1, y1;
    public int dx, dy;
    public int stepX, stepY;
    public int numSteps;
    public int fraction;
    public int mask;
    public int copies;

    public line (int p1, int p2, int p3, int p4)
    {
        x0 = p1; y0 = p2; x1 = p3; y1 = p4;
        stepX = stepY = 1;
        dx = x1 - x0; dy = y1 - y0;             // delta of X,Y coords
        if (dx < 0) { dx = -dx; stepX = -1; }   // octant vector lies in
        if (dy < 0) { dy = -dy; stepY = -1; }   // octant vector lies in
        numSteps = dx > dy ? dx : dy;           // number of steps/iterations in this segment
        dx <<= 1;                               // scale dx/dy by 2 to avoid floats
        dy <<= 1;                               // scale dx/dy by 2 to avoid floats

        if (dx > dy) { fraction = dy - (dx >> 1); }
        else{ fraction = dx - (dy >> 1); }

        mask  = stepX == -1 ? 0x01 : 0;
        mask |= stepY == -1 ? 0x04 : 0;

        copies = 1;
    }
    
    // only compare #steps, dx, dy, fraction (#steps is larger of dx, dy divided by two)
    // if these are equal then segment l2 is an exact continutation of l1 and they could
    // be 'joined' / 'duplicated'. Merge start/end points and keep track of number of duplicates.
    public static bool operator == (line l1, line l2)
    {
        bool eq = (l1.x0 == l2.x0) && (l1.y0 == l2.y0)
            && (l1.dx == l2.dx) && (l1.dy == l2.dy)
            && (l1.stepX == l2.stepX) && (l1.stepY == l2.stepY)
            && (l1.fraction == l2.fraction) && (l1.mask == l2.mask);
        return eq;
        // return l1.Equals(l2);
    }

    public static bool operator != (line l1, line l2)
    {
        bool eq = (l1.x0 == l2.x0) && (l1.y0 == l2.y0)
            && (l1.dx == l2.dx) && (l1.dy == l2.dy)
            && (l1.stepX == l2.stepX) && (l1.stepY == l2.stepY)
            && (l1.fraction == l2.fraction) && (l1.mask == l2.mask);
        return !eq;
        //return !l1.Equals(l2);
    }
}

