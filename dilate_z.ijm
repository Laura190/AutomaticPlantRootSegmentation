
newImage("B", "8-bit black", 200, 200, 20);
for (i=5; i<10;i++) { 
	setSlice(i);
	makeRectangle(77, 62, 63, 49);
	run("Fill", "slice");
}


run("Convolve...", "text1=[1 1 1 1 1 1 1\n]"); 


newImage("Kernel", "32-bit black", 3, 3, 19);
run("Invert", "stack");

