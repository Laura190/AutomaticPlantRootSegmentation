//CLEANS MISSCLASSIFIED SOIL ATTACHED TO ROOTS 
CUTOFF=10;
//run("Skeletonise 3D");
rename("FULL_SKELETON");
run("Analyse Skeleton", "prune=none show");
selectWindow("Tagged skeleton");
rename("Tagged skeleton old");
setThreshold(70, 70);
setOption("BlackBackground", false);
run("Convert to Mask", "method=Default background=Default black");
imageCalculator("Subtract create stack", "FULL_SKELETON","Tagged skeleton old");
rename("NO_BRANCHES");
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
//Seeds is now an image with branches which are long enough. need to apply this to the no branch
//point skeleton to make a skeleton of all the branches we wasnt (or maybe dont want)