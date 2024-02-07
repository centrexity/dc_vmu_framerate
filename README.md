A small test program for Dreamcasts VMU written to try to figure out how to set/sync the framerate


on linux build with build.sh<br>
makes a folder called out<br>
inside has the vmi and vms files<br>

I have been using this emulator to test with<br>
http://evmu.elysianshadows.com/
<br><br>
Here you can see it just plows through frames despite the framerate set in the GameHeader.i<br>
![Alt text](data/playback.gif?raw=true "playback")
<br>
Its much faster in the emulator than the recording
<br><br>
I tried callf Get_Input between the frames thinking it might have some magic but no luck
<br>
Still looking for solutions
<br><br>
This is how I want it to be<br>
![Alt text](data/evmu.png?raw=true "evmu")
<br>
got this image from http://evmu.elysianshadows.com/<br>
I am looking for source code for different movies to figure out more on how the timing works<br>
Still looking for solutions<br>
