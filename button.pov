
//global_settings { charset utf8 }

#include "colors.inc"
#include "shapes3.inc"

//background { color Black }

// povray -D0 +Q11 +A +UA -H688 -W688 button.pov

#default {
    pigment { color Black }
}


camera {
    up <0, 1, 0>
    right <1, 0, 0>
    location <0, 0, -5.1>
    look_at  <0, 0, 0>
    angle 60
    rotate 0
}

union {
    cylinder { <0, 0, -0.01> <0, 0, 0.1> 2.23  }
    cone {<0, 0, -0.5>, 2.6, <0, 0, 0>, 2.2 open }
    pigment { color Red }
}

union {
    Segment_of_CylinderRing(1.6, 1.2, 1, 300)
    rotate <90, 0, 120> // 90 + (360 - 300) / 2
    translate -0.02*z
}

#macro xycyl(X, Y)
  cylinder { <X, Y, -0.02> <X, Y, 0.0> 0.20 }
#end

// ends of Segment of CylinderRing
// should adjust with rotate but this good enough
xycyl(-0.74, 1.19)
xycyl(+0.74, 1.19)

// arrow to right end
xycyl(+0.90, 1.19)
xycyl(+1.10, 1.19)
xycyl(+1.30, 1.19)
xycyl(+1.50, 1.19)
// ^ horiz v vert
xycyl(+0.74, 1.03)
xycyl(+0.74, 0.83)
xycyl(+0.74, 0.63)
xycyl(+0.74, 0.43)


// vertical bar
xycyl(0, 1.6)
box { < -0.2, 1.6, -0.022 >, < 0.2, 0, 0 > }
xycyl(0, 0.0)


//light_source { <2.2, -2.2, -4.3> color White }
//light_source { <2.2, -2.2, -4.3> color rgb < 0.80, 0.75, 0.69 > }
//light_source { <2.2, -2.2, -3.3> color rgb < 0.54, 0.51, 0.47 > }
light_source { <2.2, -2.2, -3.3> color White }
//light_source { <2.2, -2.2, -4.3> color rgb < 0.25, 0.41, 0.88 > }
