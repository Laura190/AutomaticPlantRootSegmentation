selectWindow("OriginalStack");
run("Duplicate...", "title=OriginalStack-1");
run("Median...", "radius=2");
run("Duplicate...", "title=OriginalStack-2");
selectWindow("OriginalStack-1");

//setTool("line");
makeLine(179, 413, 188, 403);
makeLine(179, 413, 189, 403);
run("Plot Profile");
selectWindow("OriginalStack-2");
run("Find Edges");
selectWindow("OriginalStack-1");

//run("Threshold...");
setAutoThreshold("Default dark");
selectWindow("OriginalStack-2");
setAutoThreshold("Default dark");
resetThreshold();
selectWindow("OriginalStack-1");
resetThreshold();
selectWindow("OriginalStack-2");
//run("Threshold...");
setAutoThreshold("Default dark");
setThreshold(98, 255);
run("Convert to Mask");
run("Invert LUT");
makeLine(0, 0, 0, 0);
makeLine(0, 0, 0, 0);

makeLine(335, 378, 335, 380);
makeLine(336, 369, 336, 369);
run("Duplicate...", "title=OriginalStack-3");
run("Erode");
makeLine(0, 0, 0, 0);

makeLine(262, 312, 262, 318);
makeLine(261, 312, 261, 312);

imageCalculator("Subtract create", "OriginalStack-1","OriginalStack-3");