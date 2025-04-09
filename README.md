# Programming Exercise - Support Engineer

The goal of this exercise is to identify rows in a CSV file that
__may__ represent the __same person__ based on a provided __Matching Type__ (definition below).

The resulting program should allow us to test at least three matching types:
 - one that matches records with the same email address
 - one that matches records with the same phone number
 - one that matches records with the same email address **OR** the same phone number

<br>

# Guidelines

## Running your program
The entry point for your code should be the `match_users.rb` file. The program should take at least two parameters:

```
ruby match_users.rb <..one_or_more_matching_types> <input_filename.csv>
```
eg. `ruby match_users.rb email input1.csv`

eg. `ruby match_users.rb email phone input2.csv`

<br>

## Implementing Matching Types

A matching type is a declaration of what logic should be used to compare the rows.

eg. A matching type named same_email might make use of an algorithm that matches rows based on email columns.

<br>

## Expected Output

The output file should be a new file containing all of the original input file's contents. Please do not overwrite the original input file. Prepend a `user_id` column to the output data and use this to group matching individuals as specified by the program's input.

<br>

# Resources

## Please **DO NOT** publically fork this repository
* Clone the repository and create a new repo as your submission
* We expect you to use Ruby, but Python or Javascript may be acceptable depending on your circumstances
* Only use code that you have license to use, but try to limit the use of external libraries/gems
* Don't hesitate to ask us any questions to clarify the project

<br>

## CSV Files

Three sample input files are included. Each file should be processed independently by the resulting code.

<br>

# Scoring Guide

## Running your program
- Does this run from command line as instructed?
- Does it run without errors?

## Implement Matching Types
- Can it match on a single column?
- Do similar columns match to one another?
- Are you able to use multiple matchers?

## Output
- Is there a csv file?
- Are there IDs prepended to each row?

## Coding Style
- Is it readable?
- Is it consistent?
