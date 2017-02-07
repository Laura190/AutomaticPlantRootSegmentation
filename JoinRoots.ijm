DILATE_TIMES = 8;
setBatchMode(false);
run("Invert", "stack");
orig_slices=nSlices;
orig_height=getHeight();
orig_width=getWidth();
name=File.name;
rename("orig");
run("Duplicate...", "duplicate");
run("Scale...", "x=0.5 y=0.5 z=0.5 interpolation=None process create");
rename("process");
run("Skeletonise 3D");
selectWindow("Skeleton of process");
rename("skeleton");
run("Analyse Skeleton", "prune=none show");
IJ.renameResults("Results");
slices=nSlices;
height=getHeight();
width=getWidth();
newImage("End_points", "8-bit black", width, height, slices);
for (row=0; row<nResults; row++) { 
     if (getResult("Branch length",row) > 8) {  
     	setSlice(getResult("V1 z",row)+1);
     	setPixel(getResult("V1 x",row)+1,getResult("V1 y",row)+1,255);

     	setSlice(getResult("V2 z",row)+1);
     	setPixel(getResult("V2 x",row)+1,getResult("V2 y",row)+1,255);
     }
  }
selectWindow("End_points");
run("Duplicate...", "duplicate");
rename("End_points_orig");
selectWindow("End_points");
   	
for (i=0; i<DILATE_TIMES;i++) { 
	run("Dilate (3D)", "iso=255");
}



imageCalculator("Add create stack", "skeleton","End_points");
rename("F");
selectWindow("F");
run("Skeletonise 3D");
selectWindow("Skeleton of F");
rename("joined_skeleton");
imageCalculator("Subtract create stack","joined_skeleton","skeleton");
rename("new_roots");


