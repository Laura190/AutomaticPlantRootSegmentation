for (i=100; i<300; i++) {
selectWindow("ImageSlices");
setSlice(i);
setThreshold(1,255);
call("ij.plugin.frame.ThresholdAdjuster.setMode", "Over/Under");
run("Measure");

selectWindow("OriginalStack");
setSlice(i+1);
run("Duplicate...", "title=Slice");
selectWindow("Slice");
//SD1=getResult("StdDev");
M=getResult("Mean");
SD=6;
run("Macro...", "code=v=(1/("+SD+"*sqrt(2*3.14)))*exp((-(v-"+M+")*(v-"+M+"))/(2*"+SD+"*"+SD+"))/(1/("+SD+"*sqrt(2*3.14)))*exp((0)/(2*("+SD+"*"+SD+")))*255");

run("Median...", "radius=5");
run("Make Binary");
run("Remove Outliers...", "radius=10 threshold=50 which=Bright slice");
run("Invert");
rename("MaskSlice2");
selectWindow("OriginalStack");
setSlice(i+1);
run("Duplicate...", "title=Slice");
imageCalculator("Subtract create", "Slice","MaskSlice2");
rename("ImageSlice2");
run("Concatenate...", "  title=Mask image1=Mask image2=MaskSlice2 image3=[-- None --]");
run("Concatenate...", "  title=ImageSlices image1=ImageSlices image2=ImageSlice2 image3=[-- None --]");
selectWindow("Slice");
close();
}