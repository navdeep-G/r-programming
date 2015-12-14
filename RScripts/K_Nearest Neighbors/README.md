"KNN.R" determines if the classification of a point is correct by using K Nearest Neighbors (KNN): 

In a nutshell, KNN is a basic machine learning technique that determines the classification of an "object" based on
the objects (neighbors) surrounding it.  Remember the adage "...birds of a feather flock together" or how in high school, similar people hung out together in cliques, KNN works on the same principle!

There are many ways to determine the optimal number of neighbors that weigh in on the classification (K), 
but I decided to use the square root of the total number of total points that are being evaluated, rounded up to the 
nearest whole number (if that number is even, I make it an odd number, so there is never a tie).

Each point is then evaluated and the classification of it's nearest neighbors is tallied; only a simple majority is needed 
to determine the point's KNN classification.

For example, let's say that there are 1000 points, K=33, so we take a point "A" and determine the Euclidean (straight line)
distance between it and all other points.  The 33 nearest points are then tallied and the classification that ranks the 
highest among them is determined.  Out of "A"'s 33 neighbors, maybe 5 have a class of "1", 10 have a class of "2", 
18 have a class of "3", so the majority of points surrounding "A" is "3", therefore, it's KNN classification is "3".   

The classifications according to KNN are saved and compared to the original classifications in "class_v.csv"; this is done
so that each point is evaluated based on it's neighbor's original class, not the new class determined by KNN.

Inputs are two CSV files:
1. p.csv" that stores the coordinates of points (works for dimension >1)
2. "class_.v.csv" that stores the classification of each point int "p.csv"

Output (List form):
Errors Found:          (TRUE/FALSE)
Points Misclassified:  (Row Numbers of Misclassified Points) 
New Classifications:   (Classifications according to KNN)
