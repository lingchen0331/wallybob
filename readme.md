# Assignment 1 - Financial QA System
## Chen Ling (lingchen@udel.edu)
## CISC 882 Natural Language Processing
## 09/21/2018

### 1. File Description  
My solution folder contains one perl file - assign1.pl and a readme file.

The Financial QA system is based on the concept of ELIZA (mentioned in class). The script is written in Perl without any additional package or libraries(tools).

### 2. How to Run
To run my script, simply run the command below in your terminal/cmd. You will see the program asking you to type in any questions regarding the selected article.   
> $ perl assign1.pl <financial_article>

To quit the system, just type in any goodbye words, including "quit", "bye", "goodbye", "see you", and so on.

### 3. Explanation
My program will firstly parse the input string to find all the alternative names of the indices and companies. Then, my program will determine if the input string belongs to any question categories(Did index/company rise or fall, how much did the index/company rise or fall, how much did the index/company close/open at).

Once we find the correct category, we loop through the whole article to see if we can find a match sentence by using the regular expression. If we can find the sentence, we take the keywords of the input question out and print it out. If there's no match, we return there's no information available.

### 4. Limitation
One regular expression template cannot fit all of the situations, so I have to use multiple regex templates to find match string as much as possible. Besides, my script cannot find contextual information since it loops through the article line by line.
