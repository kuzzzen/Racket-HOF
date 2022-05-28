# Higher Order Functions for Racket

The task is to write implementations of the following higher order functions in Racket:

 - foldr
 - foldl
 - foldtree*  


Using these functions, implement other higher order functions:

 - map
 - reduce
 - filter


<br>
Finally, implement at least two list-sorting functions using the above.

There are no extra points for this project. If you have your own ideas, talk to your TA.

>*foldtree works directly with the tree! You can’t first serialize it to the list.
Also you shouldn’t assume specific arity of the tree, your function must be sufficiently generic - it needs to work with the tree of any arity.
Example: In the case of a tree with 4-arity - your foldr will be given a lambda which takes 5 arguments (value at the root + 4 values - one for each ancestor).

## Example usage

**Most functions are designed to be used exactly like their built-in versions.  
Their usage examples can be seen in the bottom of *hof.rkt* file under "tests" comment**  
<br>
The sorting functions are meant to be used in the following way:
### my-in-sort
 Usage: *(my-in-sort my-list)*  
 Example: `(my-in-sort '(8 6 9 10 2 5 1 7))`  
 Output: `'(1 2 5 6 7 8 9 10)`  

### my-qsort
This one lets you specify a comparator function  
Usage: *(my-qsort my-comp my-list)*  
Example: `(my-qsort (lambda (a b) (< (abs a) (abs b))) '(1 9 -7 2 4 -8 7 -6 2))`  
Output: `'(1 2 2 4 -6 -7 7 -8 9)`
