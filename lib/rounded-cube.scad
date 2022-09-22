module rounded_cube(size, center = false, r = 2)
{
    function get_size(index) = is_list(size) ? size[index] : size;

    x = get_size(0);
    y = get_size(1);
    z = get_size(2);

    module handle_center()
    {
        if (center)
        {
            translate([ 0, 0, -z / 2 ]) children();
        }
        else
        {
            translate([ x / 2, y / 2, 0 ]) children();
        }
    }

    handle_center() linear_extrude(z) offset(r) offset(-r) square([ x, y ], center = true);
}

// if ($preview)
// {
//     $fn = 36;
//     rounded_cube([ 5, 5, 1 ], true);
// }