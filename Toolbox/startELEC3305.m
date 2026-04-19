toolDir = pwd ;
cd Sounds
sndDir = pwd ;
cd ..
cd exm_2014
exmDir = pwd ;
cd ..
cd standard_test_images
imageDir = pwd ;
cd ../..
addpath(toolDir,sndDir,exmDir,imageDir)
clear toolDir sndDir exmDir imageDir
