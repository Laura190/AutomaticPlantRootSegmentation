//For small image stack to calculate means
//setBatchMode(true)
run("Set Measurements...", "mean standard limit redirect=None decimal=3");
selectWindow("OriginalStack");
TotalSlices=nSlices;
setSlice(1);
run("Duplicate...", "title=TopSlice1");
run("Duplicate...", "title=TopSlice2");
SD=6;
M=92;
run("Macro...", "code=v=(1/("+SD+"*sqrt(2*3.14)))*exp((-(v-"+M+")*(v-"+M+"))/(2*"+SD+"*"+SD+"))/(1/("+SD+"*sqrt(2*3.14)))*exp((0)/(2*("+SD+"*"+SD+")))*255");
run("Median...", "radius=6");
setOption("BlackBackground", false);
run("Make Binary");
//run("Fill Holes");
run("Remove Outliers...", "radius=8 threshold=50 which=Bright slice");
run("Invert");
selectWindow("TopSlice1");
imageCalculator("Subtract create", "TopSlice1","TopSlice2");
selectWindow("Result of TopSlice1");
setThreshold(1,255);
//call("ij.plugin.frame.ThresholdAdjuster.setMode", "Over/Under");
run("Measure");
resetThreshold();
selectWindow("TopSlice2");
rename("MaskSlice1");
selectWindow("Result of TopSlice1");
rename("ImageSlice1");
selectWindow("TopSlice1");
//close();
selectWindow("ImageSlice1");

selectWindow("OriginalStack");
setSlice(2);
run("Duplicate...", "title=Slice1");
selectWindow("OriginalStack");
setSlice(2);
run("Duplicate...", "title=Slice");
//selectWindow("Result of Slice1");
//selectWindow("ImageSlice1");
SD=getResult("StdDev");
M=getResult("Mean");
run("Macro...", "code=v=(1/("+SD+"*sqrt(2*3.14)))*exp((-(v-"+M+")*(v-"+M+"))/(2*"+SD+"*"+SD+"))/(1/("+SD+"*sqrt(2*3.14)))*exp((0)/(2*("+SD+"*"+SD+")))*255");
run("Median...", "radius=5");
setOption("BlackBackground", false);
run("Make Binary");
run("Fill Holes");
run("Invert");
rename("MaskSlice2");

selectWindow("Slice1");
selectWindow("MaskSlice2");
imageCalculator("Subtract create", "Slice1","MaskSlice2");
selectWindow("Result of Slice1");
rename("ImageSlice2");
selectWindow("MaskSlice2");
run("Duplicate...", "title=MaskSlice2-1");
//Comment out the Concatenate command that doesn't work depending on fiji version
//run("Concatenate...", "  title=Mask image1=MaskSlice1 image2=MaskSlice2 image3=[-- None --]");
run("Concatenate...", "stack1=MaskSlice1 stack2=MaskSlice2 title=Mask");
//run("Concatenate...", "  title=ImageSlices image1=ImageSlice1 image2=ImageSlice2 image3=[-- None --]");
run("Concatenate...", "stack1=ImageSlice1 stack2=ImageSlice2 title=ImageSlices");

selectWindow("ImageSlices");
setSlice(1);
setThreshold(1,255);
//call("ij.plugin.frame.ThresholdAdjuster.setMode", "Over/Under");
run("Measure");

selectWindow("OriginalStack");
setSlice(3);
run("Duplicate...", "title=Slice");
selectWindow("Slice");
SD=getResult("StdDev");
M=getResult("Mean");
run("Macro...", "code=v=(1/("+SD+"*sqrt(2*3.14)))*exp((-(v-"+M+")*(v-"+M+"))/(2*"+SD+"*"+SD+"))/(1/("+SD+"*sqrt(2*3.14)))*exp((0)/(2*("+SD+"*"+SD+")))*255");

run("Median...", "radius=5");
run("Make Binary");
//run("Fill Holes");
run("Invert");
rename("MaskSlice2");
selectWindow("OriginalStack");
setSlice(3);
run("Duplicate...", "title=Slice");
imageCalculator("Subtract create", "Slice","MaskSlice2");
rename("ImageSlice2");
//Comment out the Concatenate command that doesn't work depending on fiji version
//run("Concatenate...", "  title=Mask image1=Mask image2=MaskSlice2 image3=[-- None --]");
run("Concatenate...", "stack1=Mask stack2=MaskSlice2 title=Mask");
//run("Concatenate...", "  title=ImageSlices image1=ImageSlices image2=ImageSlice2 image3=[-- None --]");
run("Concatenate...", "stack1=ImageSlices stack2=ImageSlice2 title=ImageSlices");
selectWindow("Slice");
close();
selectWindow("Slice1");
close();
selectWindow("MaskSlice2-1");
close();
for (i=3; i<=TotalSlices; i++) {
//for (i=3; i<=300; i++) {
selectWindow("OriginalStack");
setSlice(i);
run("Duplicate...", "title=Slice");
selectWindow("Slice");
//SD1=getResult("StdDev");
M=getResult("Mean");
SD=3;
run("Macro...", "code=v=(1/("+SD+"*sqrt(2*3.14)))*exp((-(v-"+M+")*(v-"+M+"))/(2*"+SD+"*"+SD+"))/(1/("+SD+"*sqrt(2*3.14)))*exp((0)/(2*("+SD+"*"+SD+")))*255");

run("Median...", "radius=5");
run("Make Binary");
run("Remove Outliers...", "radius=8 threshold=50 which=Bright slice");
run("Invert");
rename("MaskSlice2");
selectWindow("OriginalStack");
setSlice(i);
run("Duplicate...", "title=Slice");
imageCalculator("Subtract create", "Slice","MaskSlice2");
rename("ImageSlice2");
//Comment out the Concatenate command that doesn't work depending on fiji version
//run("Concatenate...", "  title=Mask image1=Mask image2=MaskSlice2 image3=[-- None --]");
run("Concatenate...", "stack1=Mask stack2=MaskSlice2 title=Mask");
//run("Concatenate...", "  title=ImageSlices image1=ImageSlices image2=ImageSlice2 image3=[-- None --]");
run("Concatenate...", "stack1=ImageSlices stack2=ImageSlice2 title=ImageSlices");
selectWindow("Slice");
close();
selectWindow("ImageSlices");
setSlice(i+1);
setThreshold(1,255);
//call("ij.plugin.frame.ThresholdAdjuster.setMode", "Over/Under");
run("Measure");
}
setBatchMode(false)