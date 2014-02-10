#Components

* Available Tools (Robot)
    * Syringe
    * Needle
    * Pipette
    * White background paper
    * 2 Krone (for balance)
* Camera
    * Standard USB, manual zoom
* Code
    * Camera Calibration
    * Transformation between camera and robot
    * Blob detection 
    * Statistics of speed and area of liquid
* Petri dish
    * Soap water
    * Red oil
    * Blue oil

#Requirements
##Robot

* Precise injection of liquid
* Steady handling of the needle
* Long pipette for injection of blue oil
* White paper to create background for camera recordings
* Switching between tools

##Code

* Calibrating the camera using a chessboard to un-distort recorded images
* Calculating the transformation matrix between the camera and robot view,
  done by manually selecting points in image
* Detecting blobs
    * Detecting red and blue blobs
    * Selecting the largest blob
    * Calculating instructing the robot to inject into the blob
* Generating graphs for statistical views
    * Speed and area of liquid
