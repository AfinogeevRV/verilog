#include <stdio.h>

int atan_table[] = {11520, 6801, 3593, 1824, 916, 458, 229, 115, 57, 28, 14, 7, 4, 2, 1};
float cordic_gain = 0.607252935;

float sin_c(int dAngle);

int main(void)
{
    printf("Hello World!\n");

    printf("%f \n",sin_c(30));
    printf("%f \n",sin_c(45));
    printf("%f \n",sin_c(60));
    printf("%f \n",sin_c(89));

    return 0;
}

float sin_c(int dAngle)
{
    int angle = 0, X = 155, Y = 0, Xn, Yn;

    int i;

    dAngle*=256;

    if(dAngle>90*256) angle = 180*256;
    if(dAngle>270*256) angle = 360*256;

    for(i=0; i<15; i++)
    {
        if(dAngle>=angle)
        {
            Xn=X-(Y>>i);
            Yn=Y+(X>>i);
            angle+= atan_table[i];
        }
        else if(dAngle<angle)
        {
            Xn=X+(Y>>i);
            Yn=Y-(X>>i);
            angle-= atan_table[i];
        }
        X=Xn;
        Y=Yn;
    }

    if(dAngle>90*256 && dAngle<270*256)
    {
        X=-X;
        Y=-Y;
    }

    float sin = ((float) Y)/256;

    return sin;
}

