//Variables


//Percent of tolerance for the printer and such. Chances are the hinge holes are not going to fit if they are the exact same size, and considering the innacuracies of printers, tolerance is essential.
printertolerancepercent=10;

//The diameter of the hinge
diameterofhinge=14.68;

//Length of the hinge holder piece. Past a certain point is unnecesary
lengthofbracket=35;

//Thickness of hinge holder piece.
thicknessofbracket=5;

//Fraction of remaining hinge holder piece. A full circle wouldn't fit, whereas 1/4 wouldn't hold enough
fractionofholderremains=5/8;

//Thickness of all parts of the hook
thicknessofhook=5;


//Detail of circles (higher=more, but more circle detail equals longer render time)
sfn=100;

//IGNORE (variables with percent error added in; these variables are the ones utilized by the modules below)

printertolerance=(printertolerancepercent+100)/100;

hingediameter=diameterofhinge*printertolerance;
bracketlength=lengthofbracket*printertolerance;
bracketthickness=thicknessofbracket*printertolerance;
holderfraction=fractionofholderremains*printertolerance;
hookthickness=thicknessofhook*printertolerance;




//Modules



//The piece that hangs on the hinge
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



//The hook that is connected to the hinge holder
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



