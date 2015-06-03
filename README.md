# KNN-Racket
## What is KNN?
KNN is for k-nearest-neighbors, which is a machine learning algorithm.
I learned about it [here](http://jeremykun.com/2012/08/26/k-nearest-neighbors-and-handwritten-digit-classification/).
You can learn about it [here](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm).
## How to use knn-racket
The real meat of the program is in **knn.rkt**. Require this, then pass it your data and you should be good to go.
Other files:
* **array.rkt**: A simple implementation for 2-d vectors, used in graphics.rkt
* **graphics.rkt**: A gui for using the classifier from knn-digits.rkt. In the window, r resets & g guesses. Click and drag to draw.
* **knn-digits.rkt**: A more complex example, makes a classifier for recognizing hand-written digits.
* **knn-example.rkt**: A simple example of how to make and test a knn-classifier.
* **n-smallest.rkt**: A fast implementation for finding the n-smallest elements of a list, under a function.
