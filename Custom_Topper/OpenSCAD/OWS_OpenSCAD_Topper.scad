/*
    simplest Open Wobble Switch topper example in OpenSCAD:
        a small sphere on top of a hexagonal base
        
    scruss, 2020-07 - for Makers Making Change - CC-BY-SA
    updated 2020-10
    
    see main project at:
https://www.makersmakingchange.com/project/open-wobble-switch/

This is not intended to be a particularly useful topper, but merely
an example designed with open-source tools to interface with the 
thread on the Open Wobble Switch.

This example creates a small sphere, 22 mm in diameter,
on top of the threaded part. You may change the module topper()
to suit your application.

*/

// from https://dkprojects.net/openscad-threads/
include <threads.scad>;

// please don't change these numbers
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

// ****************
// this is the bit you can change:
// your module should be centred on the origin, or at least
// be centred in X and Y and go below the Z origin somewhat.
module topper() {
    sphere(d=22);
}
// ****************

// please don't change anything after this
difference() {
    // outer envelope
    union() {
        // hexagonal prism with rounded corners
        //   to match OWS_Topper_Base
        linear_extrude(height=hex_height)rotate(90)offset(r=hex_corner_radius)circle(d=hex_diameter - 2 * hex_corner_radius, $fn=6);
        // (example) spherical topper
        translate([0, 0, hex_height])topper();
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
