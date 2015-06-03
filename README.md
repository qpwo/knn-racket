# KNN-Racket
## What is KNN?
KNN is for k-nearest-neighbors, which is a machine learning algorithm.
I learned about it [here](http://jeremykun.com/2012/08/26/k-nearest-neighbors-and-handwritten-digit-classification/).
You can learn about it [here](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm).
## How to use knn-racket
The real meat of the program is in **knn.rkt**. It provides make-knn-classifier and test-knn-classifier. To use it, require it then pass it your data. See knn-example.rkt for an example.
Other files:
* **data/**: A folder including some hand-written-digits data.
 * **gui.txt**: The data that knn-gui.rkt generates.
 * **test.txt**: Testing data for knndigits.rkt. Came from optdigits.zip
 * **train.txt**: Training data for knndigits.rkt. Came from optdigits.zip
* **array.rkt**: A simple implementation for 2-d vectors, used in graphics.rkt
* **gui.rkt**: Uses classifier from knn-gui.rkt. In the window, r resets & g guesses. Click and drag to draw. If you enter the correct digit (e.g. press the 6 key), then it will be added to data/gui.txt and will make the program smarter.
* **knn-digits.rkt**: Makes a knn classifier (for handwritten digits) using data from data/train.txt
* **knn-example.rkt**: A simple example of how to make and test a knn-classifier.
* **knn-gui.rkt**: A knn classifier specially tailored for the gui.rkt application.
* **n-smallest.rkt**: A fast implementation for finding the n-smallest elements of a list, under a function.
* **optdigits.zip**: Some hand written digits data from [here](https://archive.ics.uci.edu/ml/machine-learning-databases/optdigits/)
