motor_diameter = 7;
wall_width = 2;
height = 10;
floor_width = 2;

tube_diameter = 2.2;
tube_length = 7;
tube_width = 3.6;
tube_height = height - tube_width;

support_height = 3;
support_width = tube_width /2;
support_a = height - tube_width - support_height;
support_b = tube_length*0.8;
support_length = sqrt(pow(support_a,2) + pow(support_b,2));
support_arc = 90 - asin((support_a) / (support_length * 0.8));




difference(){
union(){
	cylinder(h=height, r = (motor_diameter + 0.1 + wall_width) /2);



translate([motor_diameter/2,-tube_width/2,tube_height]){
	difference(){
		union(){
			cube([tube_length, tube_width, tube_width]);
			translate([0,support_width/2,-tube_height + support_height]) rotate(a=support_arc, v=[0,1,0]) cube([1,support_width,support_length*1.2]);
			
		}

		translate([0,tube_width/2,tube_width/2]) rotate(a=90, v=[0,1,0]) cylinder(h= 20, r= tube_diameter /2, $fn=62);

	}
}





}

	translate([0,0,floor_width]) cylinder(h=height +2, r = (motor_diameter + 0.1) /2);
	translate([0,0,-1])cylinder(h=10, r=2.5);
}