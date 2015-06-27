//Variables


//Percent of tolerance for the printer and such. Chances are the hinge holes are not going to fit if they are the exact same size, and considering the innacuracies of printers, tolerance is essential. By adding this printer tolerance (and just tolerance in general), you allow yourself to input exact variables in the variables and not worry about things being too small (because that is factored in). 
printertolerancepercent=10;

//The diameter of the hinge
diameterofhinge=11.46;

//Length of the hinge holder piece. Past a certain point is unnecesary
lengthofbracket=35;


//Fraction of remaining hinge holder piece. 
fractionofholderremains=1/2;

//The overall thickness of the hook and the bracket.
overallthickness=3.5;

//Length of the hook
lengthofhook=35;

//Height of the hook ending
heightofhook=11.46;

//Detail of circles (higher=more, but more circle detail equals longer render time)
sfn=100;

//IGNORE (variables with percent error added in; these variables are the ones utilized by the modules below)

printertolerance=(printertolerancepercent+100)/100;

//Variable to have a back piece to hold onto the hinge. O=no, 1=yes.
backpiece=1;

//Fraction of the backpiece that is still showing. Does not apply if there is no backpiece. 
backpiecefraction=1/8;


//Modules



//The piece that hangs on the hinge
module hingeholder() {
	difference() {
		difference() {
			cylinder(r=(diameterofhinge+overallthickness)/2, h=lengthofbracket, center=true, $fn=sfn);
			cylinder(r=diameterofhinge/2, h=lengthofbracket+2, center=true, $fn=sfn);
		}
		translate([(diameterofhinge+overallthickness)*fractionofholderremains,0, 0]) {
			cube([diameterofhinge+overallthickness, diameterofhinge+overallthickness, lengthofbracket+2], center=true);
		}
	}	

	scale([backpiece, backpiece, backpiece]) {
		difference() {
			difference() {
				cylinder(r=(diameterofhinge+overallthickness)/2, h=lengthofbracket, center=true, $fn=sfn);
				cylinder(r=diameterofhinge/2, h=lengthofbracket+2, center=true, $fn=sfn);
			}
			translate([(diameterofhinge+overallthickness)*-backpiecefraction,0, 0]) {
				cube([diameterofhinge+overallthickness, diameterofhinge+overallthickness, lengthofbracket+2], center=true);
			}
		}	
	}
}



//The hook that is connected to the hinge holder
module hook() {

	//Since the hook coverup is centered, we have to move it up to compensate for the length of the bracket and the thickness of the hook. We divide by two because it is in the center, and to get to the right place it only needs to go halfway. 
    translate([0,0,(lengthofbracket+overallthickness)/2]) {
//We make the radius the diameter of the hinge plus the bracket thickness divided by two because wee need a radius that matches the hingeholder, and that is not the inside diameter, but the outside diameter, which can be found by adding the thickness of the bracket and the hinge diameter. 
        cylinder(r=(diameterofhinge+overallthickness)/2, h=overallthickness, center=true, $fn=sfn);
    }

	//This is the physical hook. We start by moving it over to compensate by the length of the hook (which is currently centered) and raise it to compensate for the length of said braket and thickness of the hook. 
    translate([(lengthofhook)/-2,0, (lengthofbracket+overallthickness)/2]) {
		//This cube is the length of the hook. Is the same thickness as all other parts and its dimensions are as such. 
        cube([lengthofhook, diameterofhinge+overallthickness, overallthickness], center=true);
    }

//Before the translation, the cube (actually rectangular prism) is in the middle. We  have to move it over so that it is halfway touching the sphere to make it blend in.
    translate([(lengthofhook+overallthickness)/-1, (diameterofhinge+overallthickness)/-2, lengthofbracket/2]) {
        cube([overallthickness,diameterofhinge+overallthickness, heightofhook+overallthickness*1.5]);
    }

}



module final() {
	scale([1+printertolerancepercent/100,1+printertolerancepercent/100,1+printertolerancepercent/100]) {
		rotate([90,0,0]) {
			hook();
			hingeholder();
		}
	}
}

final();


