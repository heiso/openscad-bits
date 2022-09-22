module usb_c(cutout = false)
{
    l = 7.35;
    w = 8.94;
    h = 3.26;
    t = 0.4;
    flange_h = 3;
    flange_w = 8;

    module O()
    {
        $fn = 36;
        r = h / 2 - 0.5;
        translate([ 0, h / 2 ]) offset(r) offset(-r) square([ w, h ], center = true);
    }

    translate([ 0, l / 2, 0 ])
    {
        if (cutout)
            rotate([ 90, 0, 0 ]) linear_extrude(100) offset(2 * 0.2) O();
        else
            color("silver") rotate([ 90, 0, 0 ])
            {
                linear_extrude(l, center = true) difference()
                {
                    O();

                    offset(-t) O();
                }

                translate([ 0, 0, -l / 2 ]) linear_extrude(2.51) O();
            }
    }
}

module usb_micro(cutout = false)
{
    l = 6;
    iw1 = 7;
    iw2 = 5.7;
    ih1 = 1;
    ih2 = 1.85;
    h = 2.65;
    t = 0.4;
    flange_h = 3;
    flange_w = 8;

    module D()
    {
        hull()
        {
            translate([ -iw1 / 2, h - t - ih1 ]) square([ iw1, ih1 ]);

            translate([ -iw2 / 2, h - t - ih2 ]) square([ iw2, ih2 ]);
        }
    }

    translate([ 0, l / 2, 0 ])
    {
        if (cutout)
            rotate([ 90, 0, 0 ]) linear_extrude(100) offset((flange_h - ih2) / 2 + 2 * 0.2) D();
        else
            color("silver") rotate([ 90, 0, 0 ])
            {
                linear_extrude(l, center = true) difference()
                {
                    offset(t) D();

                    D();
                }

                translate([ 0, 0, -l / 2 ]) linear_extrude(1) offset(t) D();

                translate([ 0, 0, l / 2 - t ]) linear_extrude(t) difference()
                {
                    union()
                    {
                        translate([ 0, h - t - ih1 / 2 ]) square([ flange_w, ih1 ], center = true);

                        translate([ 0, h / 2 + flange_h / 4 ]) square([ iw1, flange_h / 2 ], center = true);

                        translate([ 0, h / 2 - flange_h / 4 ]) square([ iw2, flange_h / 2 ], center = true);
                    }
                    D();
                }
            }
    }
}

module jst_sh()
{
    width = 6;
    length = 4.3;
    height = 3;

    color("grey") translate([ 0, length / 2, height / 2 ]) cube([ width, length, height ], true);
}

// if ($preview)
// {
//     $fn = 36;
//     // usb_micro();
//     // % usb_micro(true);
//     // usb_c();
//     // % usb_c(true);
//     // jst_sh();
// }