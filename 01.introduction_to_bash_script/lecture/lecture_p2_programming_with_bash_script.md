Table of content:
- [0. Your first programming](#0-your-first-programming)
- [1. Variable and operator](#1-variable-and-operator)
- [2. Data type](#2-data-type)
- [3. Condition](#3-condition)
- [4. Loop](#4-loop)
- [5. Functions](#5-functions)
  * [5.1 Simple function](#51-simple-function)
  * [5.2 Function with arguments](#52-function-with-arguments)
  * [5.3 Tips and tricks](#53-tips-and-tricks)

# 0. Your first programming
```
echo "Hello world"
```
# 1. Variable and operator
| Syntax          | Meaning                                                              | Example           |
|-----------------|----------------------------------------------------------------------|-------------------|
| varname=value   | defines a variable                                                   | a=3               |
| let <operator>  | performs mathematical calculation using operators like +, -, *, /, % | let 1+2 b=let 3+4 |
| $((<operator>)) | performs mathematical calculation using operators like +, -, *, /, % | a=$((1+2))        |
Note: / will be rounded.  
  
# 2. Data type
Several data types,however,what you need to know enough in bash is number and character
Character/ String:
```
a="1"
```
Still character or string:
```
a=1  
```
Work with number:
```
echo $(("1"+"2"))
```
# 3. Condition
if [ conditions ]
    then
    commands
fi
  
| Operation             | syntax        | meaning                            |
|-----------------------|---------------|------------------------------------|
| Equality              | num1 -eq num2 | is num1 equal to num2              |
| Greater than equal to | num1 -ge num2 | is num1 greater than equal to num2 |
| Greater than          | num1 -gt num2 | is num1 greater than num2          |
| Less than equal to    | num1 -le num2 | is num1 less than equal to num2    |
| Less than             | num1 -lt num2 | is num1 less than num2             |
| Not Equal to          | num1 -ne num2 | is num1 not equal to num2          |
  
Ex:
Check weather 1 equal to 1
```
a=3
b=2
```
  
```  
if [ $a -gt $b ]
  then
  echo "1 greater than 2"
fi
```  
Note: There are spaces between the condition and []
For more advanced, it could be combined with more condition

# 4. Loop
+ Through sequence of numbers
```
for i in {1..5}
do
    echo $i
done
```
+ Through sequence of strings
```
for X in cyan magenta yellow  
do
	echo $X
done
```
  
# 5. Functions
## 5.1 Simple function
  function functname() {
  shell commands
}

Find the column name that match with you pattern and show the number of columns
```

```
Convert it into function
```
function header_finder() {
  head -n1 $1|tr "\t" "\n|nl|grep giang
} 
header_finder giang.txt
```  
## 5.2 Function with arguments  
The function refers to passed arguments by position (as if they were positional parameters), that is, $1, $2, and so forth.
$@ is equal to "$1" "$2"... "$N", where N is the number of positional parameters. $# holds the number of positional parameters.
Use it as a function without need to create a function inside
```
head -n1 $1|tr "\t" "\n|nl|grep giang	
```
Should know:	
if varname exists and isn't null, return its value; otherwise return word
${varname:-word}
if varname exists and isn't null, return its value; otherwise return word
${varname:word}              
if varname exists and isn't null, return its value; otherwise set it word and then return its value
${varname:=word}

## 5.3 Tips and tricks
set an alias
```
cd 
nano .bashrc
```
Copy and past to bashrc
```
alias gentlenode='ssh admin@gentlenode.com -p 3404'  # add your alias in .bash_profile
```	
To quickly go to a specific directory
export PATH=$PATH:<location where script is located>
```
export PATH=$PATH:/home/nguyen/bin
```
