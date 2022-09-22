module clip(xmin, ymin, zmin, xmax, ymax, zmax, size = 5000)
{
    module box(xmin, ymin, zmin, xmax, ymax, zmax)
    {
        polyhedron([[xmin, ymin, zmin],  // 0
                    [xmin, ymin, zmax],  // 1
                    [xmin, ymax, zmin],  // 2
                    [xmin, ymax, zmax],  // 3
                    [xmax, ymin, zmin],  // 4
                    [xmax, ymin, zmax],  // 5
                    [xmax, ymax, zmin],  // 6
                    [xmax, ymax, zmax]], // 7
                   [
                       [ 7, 5, 1, 3 ], // top
                       [ 2, 0, 4, 6 ], // bottom
                       [ 5, 4, 0, 1 ], // front
                       [ 3, 2, 6, 7 ], // back
                       [ 5, 7, 6, 4 ], // right
                       [ 0, 2, 3, 1 ]  // left
                   ]);
    }

    function default(val) = is_undef(val) ? size : val;
    function default_min(val) = is_undef(val) ? -size : val;

    intersection()
    {
        children();
        box(default_min(xmin), default_min(ymin), default_min(zmin), default(xmax), default(ymax), default(zmax));
    }
}

// if ($preview)
// {
//     clip(xmin = 0) cube(10, true);
// }