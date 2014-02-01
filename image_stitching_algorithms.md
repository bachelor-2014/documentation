#Image stitching algorithms
This document contains thoughts about different image stitching algorithms that
might be useful in the project. Hopefully, we will at some point be able to test
these and compare them, finding the one best suited for our application.

The first two algorithms described are based on image features. The last on does
not consider the image features at all; it instead considers the relative
position of the camera when taking the images.

##OpenCV image stitching with the \texttt{Stitcher} class
OpenCV provides a high level API for doing image stitching through use of the
\texttt{Stitcher} class. It uses image features only to combine the images.

It works out of the box, requiring no prior information about the relative
position of the images as it entirely based on image features. An overview of
the stitching pipeline is given here:
http://docs.opencv.org/modules/stitching/doc/introduction.html#stitching-pipeline.

###Advantages

- Extremely easy to implement
- Fast / performance optimized by the developers of OpenCV
- Requires no camera calibration; stitching is based entirely on image features
- The actual implementation is likely to be very complex (I have not taken a
  look at it apart from the overview linked to above), and the internal workings
  of the algorithm are probably not very easy to understand or explain. This in
  turn makes it more difficult for us to adapt it according to our application

###Disadvantages

- Does not make use of the fact that we have much information about the relative
  position of the camera when each of the images are taken

##Manual stitching using SURF features, RANSAC, and homography estimation
This algorithm is also explained and implemented (though only for two images) in
this tutorial:

http://ramsrigoutham.com/2012/11/22/panorama-image-stitching-in-opencv/

It appears to be quite similar to the algorithm implemented in the
\texttt{Stitcher} class of OpenCV (at least in general terms). It consists of
the following steps (for two images):

1) Detect SURF features
2) Compute the SURF descriptors
3) Match the descriptors in the two images
4) Use the best matches to compute a homography from one image to the other
5) Use the homography to warp one image on top of the other

This is easily expandable to more than two images by combining two images which
can the be combined with a third image etc. This however requires som existing
information about which of the images that overlap. However, in the case of our
application of image stitching, this information is available, is it will be
possible to store information about which images are taken at which camera
position in the robot.

###Advantages

- Simple / easy to understand and most of the theory was covered in SIGB
- Relatively simple to implement
- Requires no camera calibration; stitching is based entirely on image features

###Disadvantages

- Does not make use of the fact that we have much information about the relative
  position of the camera when each of the images are taken

##Homemade algorithm: Image stitching based on the relative position of the camera without considering image features
This algorithm is entirely homemade based on my understanding of the theory of
geometric transformations in image processing. It differs very much from the
above two algorithms in that it does not consider the image features at all; the
stitching is based solely on prior information about the relative position of
the camera when each of the images were taken. It is therefore needed to store
this information along with the images for this algorithm to work (or make
sense even).

The algorithm is based on the precise nature of the stepper motors used for
moving the camera; between any two taken images, the number of steps moved in
the $x$ and $y$ directions is known. And further, since the stepper motors are
precise, each step as similar in the distance traveled.

The algorithm start with a calibration: A pattern with four easily recognizable
points which is small enough to be contained in a single image is placed on the
robot so it is visible to the camera, and an image is taken. The camera is then
moved a single step in the $x$ direction, and a new image is taken. It is
important that the entire pattern is visible on this second pattern as well. The
first image taken is considered the reference image, and an affine
transformation matrix is computed from the second image to the first based on
the easily detectable points. This is repeated with a step in the $y$ direction.
The result is that two affine transformation matrices have now been computed:
One describing the transformation when moving a single step in the $x$
direction, and one describing the transformation when moving a single step in
the $y$ direction.

The theory is then that it is not necessary to consider the entire
transformation matrix; only the translation is relevant, as there is no rotation
due to the camera being stationary, and there is no scaling as the orthogonal
distance from the camera to the pattern is the same at all positions (in theory
at least). The rest of each matrix can be discarded, resulting in the following
affine transformation matrix containing translation parameters only:

$$
\begin{bmatrix}
    1 & 1 & t_x \\
    1 & 1 & t_y \\
    0 & 0 & 1
\end{bmatrix}
$$

where $t_x$ is the translation in the $x$ direction and $t_y$ is the translation
in the $y$ direction.

Having these transformations available, it should be possible to stitch all
taken images together without considering the image features at all; one image
must be considered the reference image which the rest of the images are warped
to. This warping is done by considering the position of the camera when each
image was taken relative to the position of the camera when the reference image
was taken. The transformation matrix for any given image is then:

$$
\begin{bmatrix}
    1 & 1 & (tx_x \cdot \Delta x) + (ty_x \cdot \Delta y) \\
    1 & 1 & (tx_y \cdot \Delta x) + (ty_y \cdot \Delta y) \\
    0 & 0 & 1
\end{bmatrix}
$$

where:

- $tx_x$ and $tx_y$ are the calibrated translations in the $x$ and $y$
  directions for each motor step in the $x$ direction.
- $ty_x$ and $ty_y$ are the calibrated translations in the $x$ and $y$
  directions for each motor step in the $y$ direction.
- $\Delta x$ and $\Delta y$ are the number of motor steps in the $x$ and $y$
  directions relative to the reference position.

The transformation is then used to warp each image onto the reference image (of
course resulting in an image a lot larger than then reference image).

As an overview, the algorithm consists of the following steps:

1) Calibrate the setup, computing the affine transformation matrices for a step
in the $x$ and $y$ directions. This only needs to be done once for each setup
2) Choose af reference camera position for the rest of the images to be warped
to
3) For each image to stitch together, compute the affine transformation to the
reference image and warp the image on top of the reference image

It is likely that the calibration can be improved by doing multiple measurements
in each direction ($x$ and $y$) such as doing ten steps, computing the
translation parameters and dividing by ten in order to overcome minor
non-accumulating errors in movement and pattern detection that might occur. It
should be tested whether this actually improves the calibration.

###Advantages

- It is likely to be extremely fast, as the complex compution is done
  a calibration time and only once
- It is simple to understand and explained as it is based on basic theory on
  geometric transformation, making it likely that we can tune it to fit our
  application
- It is completely homemade and tailored to our application

###Disadvantages

- Whether it provides valid results is at this point unknown; it is a
  theoretical algorithm which has not yet been tested
