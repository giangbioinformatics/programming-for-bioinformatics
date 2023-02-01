# ref: https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh

# SHORTCUTS and HISTORY
CTRL+Alt+T # open new terminal
CTRL+D     # close or deletes one character backward or logs out of current session, similar to exit

CTRL+A     # move to beginning of line
CTRL+C     # halts the current command

CTRL+E     # moves to end of line
CTRL+L     # clears screen and redisplay the line
CTRL+U     # kills backward from point to the beginning of line
<- or -> To        # move left or right
up and down arror  # show command line before and after
Tab     # Quickly use the recommend syntax
<command> --help         # shows docunmentations


# DIRECTORY AND FILES COMMANDS
mv <filename1> <dest>         # move or rename a file
cp <-r> <filename1> <dest>    # copies a file/folder with r (recursively) with files or folder in side
rm <filename>                 # removes a file
mkdir <dirname>               # makes a new directory
mkdir -p <dirname>            # makes a new directory recursively 
cd                            # changes to home
cd ..                         # changes to the parent directory
cd <dirname>                  # changes directory
cp -r <dir1> <dir2>           # copy <dir1> into <dir2> including sub-directories
pwd                           # tells you where you currently are

##############################################################################
# BASH BASICS
##############################################################################



which <program_name>  # finds locations where programs or scripts are exported
clear                 # clears content on window (hide displayed lines)
history               # shows command line history

##############################################################################
# FILE COMMANDS ONLY
##############################################################################
ls                            # lists your files in current directory, ls <dir> to print files in a specific directory
ls -lah                       # lists your files in 'long format',human readable file size and all files (even hidden files) 
ln -s <filename> <link>       # creates symbolic link to file
tree                          # show directories and subdirectories in easilly readable file tree
tree <foldername>             # show directories and subdirectories in easilly readable file tree in a folder
tree <foldername> -L <level>  # show directories and subdirectories in easilly readable file tree in a folder with level options (1,2,3) to not show all
touch <filename>              # creates or updates (edit) your file

nl <file.sh>                  # shows number of lines in file
cat <filename>                # displays file raw content (will not be interpreted)
cat filename1 > filename2     # Copy filename1 to filename2
cat filename1 filename2 >> filename2   # merge files texts together 
# Note: zcat can be used as cat but for zip file

head -n<number of line> <filename>     # outputs the first lines of file (default: 10 lines) , may skip number of line options
tail -n<number of line> <filename>     # outputs the last lines of file (useful with -f option) (default: 10 lines) may skip number of line options
wc <filename>                 # tells you how many lines, words and characters there are in a file. Use -lwc (lines, word, character) to ouput only 1 of those informations
gzip <filename>               # compresses files using gzip algorithm
gunzip <filename>             # uncompresses files compressed by gzip
gzcat <filename>              # lets you look at gzipped file without actually having to gunzip it
grep <pattern> <filenames>    # looks for the string in the files
grep -r <pattern> <dir>       # search recursively for pattern in directory
sed 's/<pattern>/<replacement>/g' <filename> # replace pattern in file with replacement value to std output the character after s (/) is the delimeter 
sed -i 's/<pattern>/<replacement>/g' <filename> # replace pattern in file with replacement value in place
tr <first pattern> <second patten> # quickly translate the value to other value.
# Should know but not use much at all
find . -name <name> <type>    # searches for a file or a directory in the current directory and all its sub-directories by its name
sort <filename>               # sorts the contents of a text file line by line in alphabetical order, use -n for numeric sort and -r for reversing order.
sort -t -k <filename>         # sorts the contents on specific sort key field starting from 1, using the field separator t.
chmod -options <filename>     # lets you change the read, write, and execute permissions on your files (more infos: SUID, GUID)
diff <filename1> <filename2>  # compares files, and shows where they differ
echo <string>                 # show line on screen, can be used with variables but have null value in stdout
printf <string>               # similar to echo, but the stdout can be put to a file     

##############################################################################
# SSH, SYSTEM INFO & NETWORK COMMANDS
##############################################################################
ssh user@host            # connects to host as user
ssh -p <port> user@host  # connects to host on specified port as user
ssh-copy-id user@host    # adds your ssh key to host for user to enable a keyed or passwordless login
whoami                   # returns your username
su <user>                # switch to a different user
sudo <command>           # execute command as the root user
passwd                   # lets you change your password
quota -v                 # shows what your disk quota is
date                     # shows the current date and time
cal                      # shows the month's calendar
df                       # shows disk usage
du <filename>            # shows the disk usage of the files and directories in filename (du -s give only a total)

ps -u yourusername       # lists your processes
kill <PID>               # kills the processes with the ID you gave
killall <processname>    # kill all processes with the name
top                      # displays your currently active processes

ping <host>              # pings host and outputs results
ifconfig                 # apply to show network configuration which is available when net-tools is installed
time <command>           # report time consumed by command execution


##############################################################################
# VARIABLES
##############################################################################
varname=value                # defines a variable
varname=value command        # defines a variable to be in the environment of a particular subprocess
echo $varname                # checks a variable's value
echo $$                      # prints process ID of the current shell
echo $!                      # prints process ID of the most recently invoked background job
echo $?                      # displays the exit status of the last command
read <varname>               # reads a string from the input and assigns it to a variable
read -p "prompt" <varname>   # same as above but outputs a prompt to ask user for value 
column -t <filename>         # display info in pretty columns (often used with pipe)
let <varname> = <equation>   # performs mathematical calculation using operators like +, -, *, /, %
export VARNAME=value         # defines an environment variable (will be available in subprocesses)
export -f  <funcname>        # Exports function 'funcname'
export var1="var1 value"     # Export and assign in the same statement
export <varname>             # Copy Bash variable 
declare -x <varname>         # Copy Bash variable 

array[0]=valA                # how to define an array
array[1]=valB
array[2]=valC
array=([2]=valC [0]=valA [1]=valB)  # another way
array=(valA valB valC)              # and another

${array[i]}                  # displays array's value for this index. If no index is supplied, array element 0 is assumed
${#array[i]}                 # to find out the length of any element in the array
${#array[@]}                 # to find out how many values there are in the array

declare -f                   # uses function names only

${varname:-word}             # if varname exists and isn't null, return its value; otherwise return word
${varname:word}              # if varname exists and isn't null, return its value; otherwise return word
${varname:=word}             # if varname exists and isn't null, return its value; otherwise set it word and then return its value


##############################################################################
# FUNCTIONS
##############################################################################


# The function refers to passed arguments by position (as if they were positional parameters), that is, $1, $2, and so forth.
# $@ is equal to "$1" "$2"... "$N", where N is the number of positional parameters. $# holds the number of positional parameters.


function functname() {
  shell commands
}

unset -f functname  # deletes a function definition
declare -f          # displays all defined functions in your login session


##############################################################################
# FLOW CONTROLS
##############################################################################


statement1 && statement2  # and operator
statement1 || statement2  # or operator

# STRINGS

str1 == str2               # str1 matches str2
str1 != str2               # str1 does not match str2
str1 < str2                # str1 is less than str2 (alphabetically)
str1 > str2                # str1 is greater than str2 (alphabetically)
str1 \> str2               # str1 is sorted after str2
str1 \< str2               # str1 is sorted before str2
-n str1                    # str1 is not null (has length greater than 0)
-z str1                    # str1 is null (has length 0)

# FILES

-a file                   # file exists or its compilation is successful
-d file                   # file exists and is a directory
-e file                   # file exists; same -a
-f file                   # file exists and is a regular file (i.e., not a directory or other special type of file)
-r file                   # you have read permission
-s file                   # file exists and is not empty
-w file                   # your have write permission
-x file                   # you have execute permission on file, or directory search permission if it is a directory
-N file                   # file was modified since it was last read
-O file                   # you own file
-G file                   # file's group ID matches yours (or one of yours, if you are in multiple groups)

# NUMBERS
-lt                       # less than
-le                       # less than or equal
-eq                       # equal
-ge                       # greater than or equal
-gt                       # greater than
-ne                       # not equal

if condition
then
  statements
[elif condition
  then statements...]
[else
  statements]
fi

for x in {1..10}
do
  statements
done

for name [in list]
do
  statements that can use $name
done

for (( initialisation ; ending condition ; update ))
do
  statements...
done

case expression in
  pattern1 )
    statements ;;
  pattern2 )
    statements ;;
esac

select name [in list]
do
  statements that can use $name
done

while condition; do
  statements
done

until condition; do
  statements
done

##############################################################################
# COMMAND-LINE PROCESSING CYCLE
##############################################################################


# The default order for command lookup is functions, followed by built-ins, with scripts and executables last.
# There are three built-ins that you can use to override this order: `command`, `builtin` and `enable`.

command  # removes alias and function lookup. Only built-ins and commands found in the search path are executed
builtin  # looks up only built-in commands, ignoring functions and commands found in PATH
enable   # enables and disables shell built-ins

eval     # takes arguments and run them through the command-line processing steps all over again


##############################################################################
# INPUT/OUTPUT REDIRECTORS
##############################################################################


cmd1|cmd2  # pipe; takes standard output of cmd1 as standard input to cmd2
< file     # takes standard input from file
> file     # directs standard output to file
>> file    # directs standard output to file; append to file if it already exists
|tee <file># output command to both terminal and a file (-a to append to file)


##############################################################################
# PROCESS HANDLING
##############################################################################


# To suspend a job, type CTRL+Z while it is running. You can also suspend a job with CTRL+Y.
# This is slightly different from CTRL+Z in that the process is only stopped when it attempts to read input from terminal.
# Of course, to interrupt a job, type CTRL+C.

wait                # waits until all background jobs have finished
sleep <number>      # wait # of seconds before continuing
##############################################################################
# TIPS & TRICKS
##############################################################################

# set an alias
cd; nano .bash_profile
> alias gentlenode='ssh admin@gentlenode.com -p 3404'  # add your alias in .bash_profile

# to quickly go to a specific directory
cd; nano .bashrc
> shopt -s cdable_vars
> export websites="/Users/mac/Documents/websites"

source .bashrc
cd $websites
