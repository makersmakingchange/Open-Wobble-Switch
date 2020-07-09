/*
    simplest Open Wobble Switch topper example in OpenSCAD:
        a small sphere on top of a hexagonal base
        
    scruss, 2020-07 - for Makers Making Change - CC-BY-SA
    see main project at:
https://www.makersmakingchange.com/project/open-wobble-switch/
*/

// from https://dkprojects.net/openscad-threads/
include <threads.scad>;

thread_diameter     = 12;
thread_pitch        =  1.75;
thread_length       =  7.7 + thread_pitch;
thread_extra        =  0.8;
hex_flats           = 16.5;
hex_corner_radius   =  2;
hex_diameter        = hex_flats / (sqrt(3) / 2);
hex_height          = 16;
hole_diameter       =  2.5;
hole_height         = hex_height + 2;

difference() {
    // outer envelope
    union() {
        // hexagonal prism with rounded corners
        //   to match OWS_Topper_Base
        linear_extrude(height=hex_height)rotate(90)offset(r=hex_corner_radius)circle(d=hex_diameter - 2 * hex_corner_radius, $fn=6);
        // (example) spherical topper
        translate([0, 0, hex_height])sphere(d=hex_diameter / (sqrt(3) / 2));
    }
    // negative space
    union() {
        // thread on switch body
        metric_thread(diameter=thread_diameter + thread_extra,
                        pitch=thread_pitch,
                        length=thread_length,
                        internal=true,
                        leadin=0);
        // rest of switch wire
        cylinder(h=hole_height,
                    d=hole_diameter / (sqrt(3) / 2),
                    $fn=6);
    }
}
