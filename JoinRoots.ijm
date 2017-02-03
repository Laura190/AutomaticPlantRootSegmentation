DILATE_TIMES = 3;
setBatchMode(false);
run("Invert", "stack");
orig_slices=nSlices;
orig_height=getHeight();
orig_width=getWidth();
name=File.name;
rename("orig");
run("Duplicate...", "duplicate");
run("Scale...", "x=0.5 y=0.5 z=0.5 width=465 height=471 depth=429 interpolation=None process create");
rename("process");
run("Skeletonise 3D");
run("Analyse Skeleton", "prune=none show");
IJ.renameResults("Results");
slices=nSlices;
height=getHeight();
width=getWidth();
newImage("End_points", "8-bit black", width, height, slices);
for (row=0; row<nResults; row++) { 
     if (getResult("Branch length",row) > 7) {  
     	setSlice(getResult("V1 z",row)+1);
     	setPixel(getResult("V1 x",row)+1,getResult("V1 y",row)+1,255);

     	setSlice(getResult("V2 z",row)+1);
     	setPixel(getResult("V2 x",row)+1,getResult("V2 y",row)+1,255);
     }
  }
   	
for (i=0; i<DILATE_TIMES;i++) { 
	run("Erode (3D)", "iso=25");
}

selectWindow("Skeleton of process");
rename("S");

imageCalculator("Add create stack", "S","End_points");
rename("F");
//Would end loop here

selectWindow("F");
run("Skeletonise 3D");
selectWindow("Skeleton of F");


