# Huffman-Coding
### What is a Huffman Code?
In computer science and information theory, a Huffman code is a particular type of optimal prefix code that is commonly used for lossless data compression. The process of finding or using such a code proceeds by means of Huffman coding. It is a Method for the Construction of Minimum-Redundancy Codes. 

The output from Huffman's algorithm can be viewed as a variable-length code table for encoding a source symbol (such as a character in a file). The algorithm derives this table from the estimated probability or frequency of occurrence (weight) for each possible value of the source symbol. As in other entropy encoding methods, more common symbols are generally represented using fewer bits than less common symbols. Huffman's method can be efficiently implemented, finding a code in time linear to the number of input weights if these weights are sorted. However, although optimal among methods encoding symbols separately, Huffman coding is not always optimal among all compression methods. It is replaced with arithmetic coding or asymmetric numeral systems if a better compression ratio is required.

### Algorithm
Huffman coding uses a specific method for choosing the representation for each symbol, resulting in a prefix code (sometimes called "prefix-free codes", that is, the bit string representing some particular symbol is never a prefix of the bit string representing any other symbol). Huffman coding is such a widespread method for creating prefix codes that the term "Huffman code" is widely used as a synonym for "prefix code" even when such a code is not produced by Huffman's algorithm.

The problem that we are going to solve can briefly be expressed as it's shown below:

**Given**
A set of symbols and their weights (usually proportional to probabilities).

**Find**
A prefix-free binary code (a set of codewords) with minimum expected codeword length (equivalently, a tree with minimum weighted path length from the root).

### **Formalized description**
![image](https://user-images.githubusercontent.com/125180530/220045896-e5d37984-79b6-494e-8b4d-67e7c4b32c14.png)

![image](https://user-images.githubusercontent.com/125180530/220045952-80952b92-154e-4617-a43d-9a3b5001ed8e.png)

Let's understand prefix codes with a counter-example. Let there be four characters a, b, c, and d, and their corresponding variable length codes are 00, 01, 0, and 1. This coding leads to ambiguity because the code assigned to c is the prefix of codes assigned to a and b. If the compressed bit stream is 0001, the de-compressed output may be “cccd” or “ccb” or “acd” or “ab”.

There are mainly two major parts in Huffman Coding:

1. Build a Huffman Tree from input characters.

2. Traverse the Huffman Tree and assign codes to characters.

### How to build a Huffman Tree?
Input is an array of unique characters along with their frequency of occurrences and output is Huffman Tree. 

**Step 1.** Create a leaf node for each unique character and build a min heap of all leaf nodes (Min Heap is used as a priority queue. The value of the frequency field is used to compare two nodes in the min heap. Initially, the least frequent character is at the root)

**Step 2.** Extract two nodes with the minimum frequency from the min heap.

**Step 3.** Create a new internal node with a frequency equal to the sum of the two nodes' frequencies. Make the first extracted node as its left child and the other extracted node as its right child. Add this node to the min heap.

**Step 4.** Repeat steps#2 and #3 until the heap contains only one node. The remaining node is the root node and the tree is complete.

You can see the example at https://www.geeksforgeeks.org/huffman-coding-greedy-algo-3/ for a better understanding. 

Now, for implementing the algorithm we do the followings:

* We first create a function that its input is a transition states matrix and the output is the entropy for the corresponding source. 

* Another function that is needed to be created is "average_length". It is a function that takes a chain of symbols and k as inputs and calculates the average length of Huffman code for the case in which we encode the chain as k words. 

* So, it's time to use the implementations and simulate an example:

Consider the following with-memory source:

![image](https://user-images.githubusercontent.com/125180530/220049581-fb827dab-1c1c-4953-8555-112a368084e3.png)

We have taken the following assumptions and calculated the entropy of this source:

![image](https://user-images.githubusercontent.com/125180530/220049986-554a5dcf-fcd9-46d7-9d72-1ce39100bcfa.png)

![image](https://user-images.githubusercontent.com/125180530/220050066-0d57d250-6ae6-44bc-952d-19a1e5e50575.png)

![image](https://user-images.githubusercontent.com/125180530/220050130-710386e8-3eb0-4690-89e8-08738d2418ce.png)

* We then generate 10000000 samples of this source and with the use of the previous functions created, we calculate the average length of Huffman code and Gk for k = 1,2,...,10. Then, we plot these two parameters versus k in a figure. 

**Sample Generation**
First of all, we create a random number between 0 and 1 to set the primary state randomly. For instance, if the random number is greater than 0.5, we set state = 1 and otherwise state = 0. Secondly, we pass the primary values calculated for probabilities to cumsum(), and in a for loop that repeats 10000000 times we generate a random number between 0 and 1 and compare it with cumsum() output. The output will be a logic array and can help us set the current state. The next step is to make a comparison between the current state and the previous one. By looking at the state diagram we can see that if the mentioned two states are different symbol 'A' will generate and otherwise we have the symbol 'B'. 

* Another parameter that we can report is coding gain or coding efficiency. It can be calculated from the following formula:

![image](https://user-images.githubusercontent.com/125180530/220053314-49819a6f-f6f5-482c-832d-ec9238a4ba62.png)

Now we show the plot of entropy and coding gain in a figure. 

* Consider a memoryless source called X with three output symbols with probabilities: (0.7, 0.29, 0.01)

With the use of the previous functions, we find the average length of Huffman code for the following sources: X, X^2, X^3 (X^K is a source that each message of it consists of K consecutive symbols of the source X).

Then, we plot the previous figures (entropy, average length of Huffman code, and coding gain).

For chain generating in this part we use two functions 'kron' and 'randsrc'. The 'kron' function takes the probabilities as input and then for multiply them for finding the probabilities for X^2 and we do the same thing for X^3. With the use of the calculated probabilities, we can find the entropy of each of the sources. With the following formula, we can calculate the entropy of each source:

![image](https://user-images.githubusercontent.com/125180530/220084459-b9676335-9f73-4eec-89c1-06cc7a4f947f.png)

The calculated values are:

![image](https://user-images.githubusercontent.com/125180530/220085409-483472af-45ec-46ab-b741-adbc1fa6f364.png)

### Conclusion
* By comparing the plots we can conclude that the greater the value of k, the closer the efficiency to 1. This is because we have:

![image](https://user-images.githubusercontent.com/125180530/220086851-19ea541d-ab92-421e-9409-2b08d99886a9.png)

* Another point that is worth mentioning is that with k increasing, the value of Gk converges to the entropy of the source. 

* The final point is that in memoryless sources the value of coding gain and Gk are constants and we can notice this point in the plots. (In fact, for greater values of k the graphs converge to a constant value and finally, they become stable). 
