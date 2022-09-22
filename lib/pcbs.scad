include <./connectors.scad>
include <./rounded-cube.scad>

module supports(width, length, thickness, bottom_clearance, border = 1, supports_width = 1.5, width_clearance = 10)
{
    module cliper()
    {
        translate([ 0, 0, bottom_clearance + thickness ])
        {
            $fn = 32;
            translate([ 0, 0, border / 3 ]) rotate([ 0, 90, 0 ]) cylinder(h = width + border * 2, r = border / 2);
            translate([ 0, -border, 0 ]) cube([ width + border * 2, border, border - border / 3 ]);
        }
    }

    difference()
    {
        translate([ -(width + border * 2) / 2, 0, 0 ])
        {
            difference()
            {
                translate([ 0, -border, 0 ])
                    cube([ width + border * 2, length + border * 2, bottom_clearance + thickness ]);

                translate([ border + supports_width, 0, 0 ])
                    cube([ width - supports_width * 2, length, bottom_clearance ]);

                translate([ border, 0, bottom_clearance ]) cube([ width, length, thickness ]);
            }

            cliper();
            translate([ 0, length, 0 ]) mirror([ 0, 1, 0 ]) cliper();
        }

        translate([ -width_clearance / 2, -border, 0 ])
            cube([ width_clearance, length + border * 2, bottom_clearance + thickness + border * 2 ]);

        translate([ -(width + border * 2) / 2, length / 3 * 2 - border * 2, 0 ])
            cube([ width + border * 2, border * 4, bottom_clearance + thickness + border * 2 ]);
    }
}

// https://learn.adafruit.com/adafruit-qt-py-2040
qt_py_rp2040_width = 18;
qt_py_rp2040_length = 21;
qt_py_rp2040_thickness = 1.6;
qt_py_rp2040_bottom_clearance = 1.2;
module qt_py_rp2040(cutout = false)
{
    width = qt_py_rp2040_width;
    length = qt_py_rp2040_length;
    thickness = qt_py_rp2040_thickness;
    bottom_clearance = qt_py_rp2040_bottom_clearance;

    color("black", alpha = .5) translate([ 0, length / 2, bottom_clearance / 2 ])
        cube([ width - 4, length, bottom_clearance ], center = true);
    color("black") translate([ 0, length / 2, thickness / 2 + bottom_clearance ])
        rounded_cube([ width, length, thickness ], center = true);
    translate([ 0, -1, thickness + bottom_clearance ]) usb_c(cutout);
}

module qt_py_rp2040_supports()
{
    supports(width = qt_py_rp2040_width, length = qt_py_rp2040_length, thickness = qt_py_rp2040_thickness,
             bottom_clearance = qt_py_rp2040_bottom_clearance);
}

// https://learn.adafruit.com/adafruit-kb2040
kb2040_width = 18;
kb2040_length = 33;
kb2040_thickness = 1.6;
kb2040_bottom_clearance = 0.2;
module kb2040(cutout = false)
{
    width = kb2040_width;
    length = kb2040_length;
    thickness = kb2040_thickness;
    bottom_clearance = kb2040_bottom_clearance;

    color("red", alpha = .5) translate([ 0, length / 2, bottom_clearance / 2 ])
        cube([ width - 2, length, bottom_clearance ], center = true);
    color("red") translate([ 0, length / 2, thickness / 2 + bottom_clearance ])
        cube([ width, length, thickness ], center = true);
    translate([ 0, -1, thickness + bottom_clearance ]) usb_c(cutout);
    translate([ 0, length, thickness + bottom_clearance ]) rotate([ 0, 0, 180 ]) jst_sh();
}

module kb2040_supports()
{
    supports(width = kb2040_width, length = kb2040_length, thickness = kb2040_thickness,
             bottom_clearance = kb2040_bottom_clearance);
}

wemos_d1_mini_esp8266_width = 26;
wemos_d1_mini_esp8266_length = 34.5;
wemos_d1_mini_esp8266_thickness = 1;
wemos_d1_mini_esp8266_bottom_clearance = 1.7;
module wemos_d1_mini_esp8266(cutout = false)
{
    width = wemos_d1_mini_esp8266_width;
    length = wemos_d1_mini_esp8266_length;
    thickness = wemos_d1_mini_esp8266_thickness;
    bottom_clearance = wemos_d1_mini_esp8266_bottom_clearance;

    color("blue") translate([ 0, length / 2, bottom_clearance ]) linear_extrude(thickness)
    {
        difference()
        {
            union()
            {
                $fn = 32;
                border_radius = 5;
                translate([ 0, -border_radius / 2, 0 ]) square([ width, length - border_radius ], true);
                translate([ 0, (length - border_radius * 3) / 2, 0 ]) offset(border_radius) offset(-border_radius)
                    square([ width, border_radius * 3 ], true);
            }

            translate([ -width / 2, -length / 2, 0 ]) square([ 2, 5 ]);
        }
    }

    color("blue", alpha = .5) translate([ 0, (length - 5) / 2, bottom_clearance / 2 ])
        cube([ width - 2, length - 5, bottom_clearance ], center = true);

    color("silver") translate([ -width / 2 + 2, 0, thickness + bottom_clearance ]) cube([ 2.3, 5, 2 ]);
    color("silver") translate([ 0, 0, thickness + bottom_clearance ]) usb_micro(cutout);
}

module wemos_d1_mini_esp8266_supports()
{
    supports(width = wemos_d1_mini_esp8266_width, length = wemos_d1_mini_esp8266_length,
             thickness = wemos_d1_mini_esp8266_thickness, bottom_clearance = wemos_d1_mini_esp8266_bottom_clearance);
}

// https://learn.adafruit.com/adafruit-drv2605-haptic-controller-breakout
adafruit_drv2605L_width = 18;
adafruit_drv2605L_length = 26;
adafruit_drv2605L_thickness = 1.6;
adafruit_drv2605L_bottom_clearance = 0.2;
module adafruit_drv2605L()
{
    width = adafruit_drv2605L_width;
    length = adafruit_drv2605L_length;
    thickness = adafruit_drv2605L_thickness;
    bottom_clearance = adafruit_drv2605L_bottom_clearance;

    $fn = 32;
    color("black", alpha = .5) translate([ 0, length / 2, bottom_clearance / 2 ])
        cube([ width - 2, length, bottom_clearance ], center = true);
    color("black") translate([ 0, length / 2, thickness / 2 + bottom_clearance ])
        rounded_cube([ width, length, thickness ], center = true);
    translate([ 0, 0, thickness + bottom_clearance ]) jst_sh();
    rotate([ 0, 0, 180 ]) translate([ 0, -length, thickness + bottom_clearance ]) jst_sh();
}

module adafruit_drv2605L_supports()
{
    supports(width = adafruit_drv2605L_width, length = adafruit_drv2605L_length,
             thickness = adafruit_drv2605L_thickness, bottom_clearance = adafruit_drv2605L_bottom_clearance);
}

// if ($preview)
// {
//     placeholder_width = 25;
//     translate([ 0, 0, 0 ])
//     {
//         qt_py_rp2040();
//         % qt_py_rp2040_supports();
//     }

//     translate([ placeholder_width, 0, 0 ])
//     {
//         kb2040();
//         % kb2040_supports();
//     }

//     translate([ placeholder_width * 2, 0, 0 ])
//     {
//         wemos_d1_mini_esp8266();
//         % wemos_d1_mini_esp8266_supports();
//     }

//     translate([ placeholder_width * 3, 0, 0 ])
//     {
//         adafruit_drv2605L();
//         % adafruit_drv2605L_supports();
//     }
// }