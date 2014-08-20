# Bank OCR Kata

### Introduction 

This is an implementation of the Bank OCR kata in Ruby in 4 hours or less.

_Your manager has recently purchased a machine that assists in reading letters and faxes sent in by branch offices. The machine scans the paper documents, and produces a file with a number of entries. You will write a program to parse this file._

### How To Run

> ./bankocr.rb testfile 

I've provided a test file with some test inputs which yield the following results:

> ./bankocr.rb testfile

```
490067715 ERR
490867715 
49006771? ILL
123456789 
123456780 ERR
1234?678? ILL
?2?456780 ILL
711111111 
333333333 ERR
888888888 ERR
555555555 ERR
?23456789 ILL
```

### How To Run Tests (MiniTest)

> ./tests.rb

```
20 runs, 33 assertions, 0 failures, 0 errors, 0 skips
```

Alternatively you can run any test file:

> ruby ./tests_parser.rb

> ruby ./tests_recordreader.rb

> ruby ./tests_outputwriter.rb


### FAQ

_Do you even know Ruby bro?_

I used to a few years ago... bit rusty. Sorry if it doesn't look pro.

_What version of Ruby do I need?_

I developed with 2.1.1 but tested briefly on 1.9.3 and it seems OK.

_Why don't you have an account number object or digit object or similar?_

I think that's overkill for this problem, its a simple command line input output problem.

_Why is there no Gemfile or Rakefile?_

This problem is way too simple to need either.

_Why is there no lib/spec/test/bin/etc folder structure?_

This problem is way too simple, its just a kata with 3 files...

_Why do you convert the input into binary 1's and 0's?_

I have a gut feeling that it will be helfpul down the road for Userstory #4

_Why didn't you just have a massive case statement or if/thens and match hard coded 7 segment digits?_

You gotta be kidding me?


### Specification

#### User Story 1

The following format is created by the machine:

```
    _  _     _  _  _  _  _
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _| 

```
                           
Each entry is 4 lines long, and each line has 27 characters. The first 3 lines of each entry contain an account number written using pipes and underscores, and the fourth line is blank.

Each account number should have 9 digits, all of which should be in the range 0-9. A normal file contains around 500 entries.

Write a program that can take this file and parse it into actual account numbers.

#### User Story 2

You find the machine sometimes goes wrong while scanning. You will need to validate that the numbers are valid account numbers using a checksum. This can be calculated as follows:

```
account number:  3  4  5  8  8  2  8  6  5
position names:  d9 d8 d7 d6 d5 d4 d3 d2 d1
```

checksum calculation:

```
((1*d1) + (2*d2) + (3*d3) + ... + (9*d9)) mod 11 == 0
```

#### User Story 3

Your boss is keen to see your results. He asks you to write out a file of your findings, one for each input file, in this format:

```
457508000
664371495 ERR
86110??36 ILL
```

The output file has one account number per row. If some characters are illegible, they are replaced by a ?. In the case of a wrong checksum, or illegible number, this is noted in a second column indicating status.

