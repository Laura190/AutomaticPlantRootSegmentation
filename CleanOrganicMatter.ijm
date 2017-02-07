//CLEANS ORGANIC MATTER
CUTOFF=10;
//SAVE_DIR ="\\\\ROOSE_GROUP\\S_I_Ahmed\\Laura_data\\20131114_HUTCH_499_SIA_5050_02\\20131114_HUTCH_499_SIA_5050_02_131x143x170x8bt";
SAVE_DIR =getDirectory("SELECT SAVE DIRECTOTY");

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

//run("Erode (3D)", "iso=255");
//run("Erode (3D)", "iso=255");
//run("Dilate (3D)", "iso=255");
//run("Dilate (3D)", "iso=255");
run("Skeletonise 3D");
run("Analyse Skeleton", "prune=none show");
IJ.renameResults("Results");


slices=nSlices;
height=getHeight();
width=getWidth();
newImage("Seeds", "8-bit black", width, height, slices);
for (row=0; row<nResults; row++) { 
     if (getResult("Branch length",row) > CUTOFF) {  
     	setSlice(getResult("V1 z",row)+1);
     	setPixel(getResult("V1 x",row)+1,getResult("V1 y",row)+1,255);
     	
     }
  } 	

selectWindow("Seeds");
run("Scale...", "x=- y=- z=- width="+orig_width+ " height="+orig_height+ " depth="+orig_slices+ " interpolation=None process create");
rename("Seeds_scaled");
run("Geodesic Reconstruction 3D", "marker=Seeds_scaled mask=orig type=[By Dilation] connectivity=26");
//saveAs("Raw Data", SAVE_DIR+CUTOFF+"_CLEANED_"+name);