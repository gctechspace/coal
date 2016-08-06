
length = 13;
width = 10;
long_side = 10;
short_side = 8;
side_width = 2;
side_height = .5;

m3_hole = 2.9+0.7;
m3_nut = 6+0.5;
m3_nut_height = 2.3;

module side(extra = 0) {
    l = length / 2 - side_width/2;
    ss = (short_side + extra + side_height) / 2;
    ls = (long_side + extra + side_height) / 2;
    module side_cube () cube([side_width, side_width, side_height], center=true);
    hull() {
        translate([-l,0,-ss]) side_cube();
        translate([-l,0,ss]) side_cube();
        translate([l,0,ls]) side_cube();
        translate([l,0,-ls]) side_cube();
    }
}

module wedge (extra = 0) {
    l = length / 2 - 0.5;
    w = width / 2 - 0.5;
    ss = (short_side + extra) / 2 - 0.5;
    ls = (long_side + extra) / 2 - 0.5;
    hull() {
        // short side
        translate([-l,-w,-ss]) cube(1, center=true);
        translate([-l,w,-ss]) cube(1, center=true);
        translate([-l,-w,ss]) cube(1, center=true);
        translate([-l,w,ss]) cube(1, center=true);
        // long side
        translate([l,-w,-ls]) cube(1, center=true);
        translate([l,w,-ls]) cube(1, center=true);
        translate([l,-w,ls]) cube(1, center=true);
        translate([l,w,ls]) cube(1, center=true);
    }
    translate([0,w+0.5+side_width/2,0]) side(extra);
    translate([0,-w-0.5-side_width/2,0]) side(extra);
}

module part (extra = 0) {
    difference() {
        wedge(extra);
        rotate([0,90,0]) cylinder(d=m3_hole, h=length+0.01, center=true, $fn=30);
        translate([length/2-m3_nut_height/2,0,0]) rotate([0,90,0]) cylinder(d=m3_nut, h=m3_nut_height+0.05, center=true, $fn=6);
    }
}

part();

