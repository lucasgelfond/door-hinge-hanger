hingediameter=14.68;
bracketlength=35;
bracketthickness=5;
holderfraction=5/8;
hookthickness=5;
sfn=100;



module hingeholder() {
	difference() {
		difference() {
			cylinder(r=(hingediameter+bracketthickness)/2, h=bracketlength, center=true, $fn=sfn);
			cylinder(r=hingediameter/2, h=bracketlength+2, center=true, $fn=sfn);
		}
		translate([(hingediameter+bracketthickness)*holderfraction,0, 0]) {
			cube([hingediameter+bracketthickness, hingediameter+bracketthickness, bracketlength+2], center=true);
		}
	}	
}



module hook() {
	translate([0,0,(bracketlength+hookthickness)/2]) {
		cylinder(r=(hingediameter+bracketthickness)/2, h=hookthickness, center=true, $fn=sfn);
	}

	translate([-(hingediameter+bracketthickness),0, (bracketlength+hookthickness)/2]) {
		cube([(hingediameter+bracketthickness)*2, hingediameter+bracketthickness, hookthickness], center=true);
	}

	translate([(hingediameter+bracketthickness)*-2-hookthickness, (hingediameter+bracketthickness)/-2, hingediameter+bracketthickness/2]) {
		cube([hookthickness,hingediameter+bracketthickness, hingediameter+bracketthickness]);
	}

}



hingeholder();
hook();



