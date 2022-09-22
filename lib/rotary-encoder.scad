include <./common.scad>

module rotary_encoder(distance_to_nut = 2.5, cutout = false)
{
    shaft_height = 10.20;
    shaft_radius = 3;
    shaft_base_radius = 7 / 2;
    shaft_base_height = 7;
    shaft_tolerance = 0.075;

    nut_radius = 5;
    nut_height = 1.5;

    base_width = 12;
    base_height = 10;
    base_tolerance = 0.3;

    module encoder()
    {
        // base
        translate([ 0, 0, -base_height / 2 ]) cube([ base_width, base_width, base_height ], true);

        // pin
        translate([ 0, 0, 1 / 2 ]) cube([ base_width, 2, 1 ], true);

        // shaft base
        cylinder(h = shaft_base_height, r = shaft_base_radius);

        // shaft
        translate([ 0, 0, shaft_base_height + 0.5 ]) cylinder(h = 2.5, r = shaft_radius);
        translate([ 0, 0, shaft_base_height + 3 ])
        {
            difference()
            {
                cylinder(h = shaft_height + .1, r = shaft_radius);
                translate([ -shaft_radius, shaft_radius / 1.7, 0 ]) cube([ shaft_radius * 2, 10, shaft_height + .1 ]);
            }
        }
    }

    module nut()
    {
        linear_extrude(nut_height) difference()
        {
            circle(nut_radius);
            circle(shaft_base_radius);
        }
    }

    module cutout()
    {
        // base
        translate([ 0, 0, -base_height / 2 ])
            cube([ base_width + base_tolerance, base_width + base_tolerance, base_height ], true);

        // pin
        translate([ 0, 0, 1 / 2 ]) cube([ base_width + base_tolerance, 2 + base_tolerance, 1 + base_tolerance ], true);

        // shaft base
        cylinder(h = shaft_base_height, r = shaft_base_radius + shaft_tolerance);

        // shaft
        translate([ 0, 0, shaft_base_height + 0.5 ]) cylinder(h = 2.5, r = shaft_radius + shaft_tolerance);
        translate([ 0, 0, shaft_base_height + 3 ])
        {
            difference()
            {
                cylinder(h = shaft_height + .1, r = shaft_radius + shaft_tolerance);
                translate([ -shaft_radius, shaft_radius / 1.7, 0 ]) cube([ shaft_radius * 2, 10, shaft_height + .1 ]);
            }
        }

        // nut cutout
        translate([ 0, 0, distance_to_nut ]) cylinder(h = shaft_base_height - distance_to_nut, r = base_width / 2);
    }

    if (cutout)
    {
        cutout();
    }
    else
    {
        color("silver")
        {
            encoder();
            translate([ 0, 0, distance_to_nut ]) nut();
        }
    }
}

// if ($preview)
// {
//     $fn = 36;
//     rotary_encoder();
//     % rotary_encoder(cutout = true);
// }