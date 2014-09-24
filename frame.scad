width = 30;
height = 1;

middle_width = 4;
outer_width = 1;
strobe_width = 1;

tube_height = 3;
hole_diameter = 2.2;
middle_hole_diameter = 2.5;
outer_tube_length = 8;
inner_tube_length = 7;
tube_faces = 32;

inner_size = middle_width + inner_tube_length;
outer_size = width - outer_tube_length;


cube_size = (width - outer_width * 2 - middle_width) /2;

//thanks to nophead http://hydraraptor.blogspot.de/2011/02/polyholes.html
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n*2);
}


module groundPlate(){

union(){
	difference(){
		cube([width, width, height]);

	
		for(i = [0, 1]){
			for(j = [0, 1]){
				union(){
					translate([outer_width + i* (cube_size + middle_width),outer_width + j * (cube_size + middle_width),-1]){
						cube([cube_size, cube_size, height + 2]);
					}
				}
			}
		}
	}

	for(i = [-1, 1]){
		translate([width/2, width/2, height/2])  rotate(a = 45 *i, v =[0,0,1])  cube([strobe_width, width * sqrt(2) - strobe_width *2 , height], center =true);
	}

}

}


module tubes(){

difference(){
	translate([0,0,height]){
		union(){
			translate([0, width/2 - middle_width/2, 0])cube([width, middle_width,tube_height]);
			translate([width/2 - middle_width/2, 0, 0]) cube([middle_width, width,tube_height]);
		}
	}

translate([-5,width/2,height + tube_height*0.8/2]) rotate(a=90, v=[0,1,0]) cylinder(h =width +10, r = hole_diameter /2, $fn = tube_faces)	;
translate([width/2,width +5,height + tube_height*0.8/2]) rotate(a=90, v=[1,0,0]) cylinder(h = width + 10, d = hole_diameter /2, $fn = tube_faces);

	translate([width/2,width/2,0]){
		difference(){
			cube([outer_size, outer_size,20], center = true);
			
			cube([inner_size , inner_size,30], center = true);
		}
	}

}
}



translate([-15,-15,0]) {
	difference(){
		union(){
			groundPlate();
			tubes();
		}
		translate([width/2,width/2,-1]){
			polyhole(h=height + tube_height + 5, d = middle_hole_diameter);
		}
	}



}
