//CLEANS ORGANIC MATTER
setBatchMode("true");
CUTOFF=150;
name=File.name;
rename("orig");
run("Duplicate...", "duplicate");
rename("process");
run("Erode (3D)", "iso=255");
run("Erode (3D)", "iso=255");
run("Dilate (3D)", "iso=255");
run("Dilate (3D)", "iso=255");
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


run("Geodesic Reconstruction 3D", "marker=Seeds mask=orig type=[By Dilation] connectivity=26");
saveAs("Raw Data", "\\\\CSEG_2\\Literature_Database\\Scripts\\LC_20161219_RootSegmentationBirminghamWorkshop\\Root_Data_20161209\\"+CUTOFF+"_CLEANED_"+name);