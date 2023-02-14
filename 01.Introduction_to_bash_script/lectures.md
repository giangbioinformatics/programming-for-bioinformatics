Acknowledgement: https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh 

Table of contents
  * [1. Shortcut and history](#1-shortcut-and-history)
  * [2. Directory and file related command](#2-directory-and-file-related-command)
  * [3. Basic bash](#3-basic-bash)
    + [3.1 Basic command](#31-basic-command)
    + [3.2 File processing only](#32-file-processing-only)
    + [3.3 Should know](#33-should-know)
## 1. Shortcut and history
| Shortcut  | Function |
| ------------- | ------------- |
| CTRL+Alt+T    | opens new terminal|
| CTRL+D  |  closes or deletes one character backward or logs out of current session, similar to exit  |
| CTRL+A   |  moves to beginning of line  |
| CTRL+C    |  halts the current command  |
| CTRL+E |  moves to end of line  |
| CTRL+L  |  clears screen and redisplay the line   |
| CTRL+U  |  kills backward from point to the beginning of line   |
| <- or ->|  move left or right on current command  |
| up and down arrow  |  show command line before and after     |
| Tab   |  Quickly use the recommend syntax     |
| < command > --help   |  shows docunmentations or manual of tools   |

## 2. Directory and file related command          
| Command                              | Function                                                               | Example                      |
|--------------------------------------|------------------------------------------------------------------------|------------------------------|
| mkdir <new directory>                | makes a new directory                                                  | mkdir giang                  |
| mkdir -p <new_directory with parent> | makes a new directory with parents                                     | mkdir -p giang/giang1/giang2 |
| mv <filename1> <dest>                | moves or renames a file                                                | mv giang/giang1/giang2 giang |
| cp <-r> <filename1> <dest>           | copies a file/folder with r (recursively) with files or folder in side | cp -r giang copied_giang     |
| rm <filename>                        | removes a file                                                         | rm giang                     |
| rm -rf                               | removes files with forces                                              | rm -rf copied_giang          |
| cd                                   | changes to home                                                        | cd                           |
| cd <dirname>                         | changes directory                                                      | cd /home                     |
| pwd                                  | tells you where you currently are                                      | pwd                         

## 3. Basic bash
### 3.1 Basic command
| Command              | Function                                               | Example |
|----------------------|--------------------------------------------------------|---------|
| which <program_name> | finds locations where programs or scripts are exported |which bash|
| clear                | clears content on window (hide displayed lines)        |clear    |
| history              | shows command line history                             |history  |

### 3.2 File processing only
| Command                              | Function                                                                                                                 | Example                      |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------|------------------------------|
| ls                                   | lists your files in current directory, to print files in a specific directory                                            |    ls                          |
| ls -lah                              | lists your files in 'long format',human readable file size and all files (even hidden files)                             | ls -lah /home/ |
| ln -s <filename> <link>              | creates symbolic link to file                                                                                            | ln -s giang2.txt giang3.txt |
| tree                                 | how directories and subdirectories in easilly readable file tree                                                         | tree giang                     |
| tree <foldername>                    | show directories and subdirectories in easilly readable file tree in a folder                                            | tree giang          |
| tree <foldername> -L <level>         | show directories and subdirectories in easilly readable file tree in a folder with level options (1,2,3) to not show all | tree giang -L 3                     |
| touch <filename>                     | creates or updates (edit) your file                                                                                      | touch demo.txt                          |
| nl <file.sh>                         | shows number of lines in file                                                                                            |               nl demo.txt               |
| cat                                  | displays file raw content (will not be interpreted)                                                                      |        cat demo.txt                |
| cat filename1 > filename2            | Copy filename1 content to filename2                                                                                      |    cat demo.txt > demo2.txt                          |
| cat filename1 filename2 >> filename2 | merge files texts together                                                                                               |  cat demo.txt demo2.txt > demo3.txt                            |
| head -n<number of line> <filename>   | outputs the first lines of file (default: 10 lines) , may skip number of line options                                    |    head -n5 demo3.txt                          |
| tail -n<number of line> <filename>   | outputs the last lines of file (useful with -f option) (default: 10 lines) may skip number of line options               |     tail -n5 demo3.txt       |
| wc <filename>                        | tells you how many lines, words and characters there are in a file. Use -lwc (lines, word, character) to ouput only 1 of |    wc -l  demo3.txt                 |
| gzip <filename>                      | compresses files using gzip algorithm                                                                                    |     gzip demo3.txt                         |
| gunzip <filename>                    | uncompresses files compressed by gzip                                                                                    |     gunzip demo3.txt.gz                         |
| gzcat                                | lets you look at gzipped file without actually having to gunzip it                                                       |    gzcat demo3.txt.gz                          |
| grep                                 | looks for the string in the files                                                                                        |   cat demo3.txt|grep giang  |
| grep -r                              | search recursively for pattern in directory                                                                              | grep -r giang               |
| grep -v                              | remove line with that pattern                                                                                            | cat demo3.txt|grep -v giang                             |
| sed 's///g'                          | replace pattern in file with replacement value to std output the character after s (/) is the delimeter                  | cat demo3| sed 's/giang/Giang/g'                             |
| sed -i 's///g'                       | replace pattern in file with replacement value in place                                                                  | sed -i 's/giang/Giang/g' demo3.txt                              |
| tr <pattern1> <pattern2>   | quickly translate the value to other value.                                                                              | tr "a" "A"                             |
                         
### 3.3 Should know
| Command                      | Function                                                                                                                  | Example |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------|---------|
| find . -name <file_name>             | searches for a file or a directory in the current directory and all its sub-directories by its name                      | find . -name giang*                             |
|cut -f< number of column >             | cut specific column                      | cat giang.txt|cut -f1                          |
|cut -f< first selected column,second selected column >             | cut specific column                      | cat giang.txt\|cut -f1,2   |
|cut -f< first selected column to second selected column >             | cut specific column                      | cat giang.txt\|cut -f1-3  |
| sort     sort demo3.txt                            | sorts the contents of a text file line by line in alphabetical order, use -n for numeric sort and -r for reversing order |                              |
| sort -t -k                           | sorts the contents on specific sort key field starting from 1, using the field separator t.                              |   sort -t -k demo3                           |
| chmod <mode> <file or folder>        | lets you change the read, write, and execute permissions on your files (more infos: SUID, GUID)                          | chmod 775 demo3.txt                              |
| diff                                 | compares files, and shows where they differ                                                                              | diff demo3.txt demo2.txt                             |
| echo                                 | show line on screen, can be used with variables but have null value in stdout                                            | echo "giang"                             |
| printf                               | similar to echo, but the stdout can be put to a file                                                                     |  printf "giang2" > demo4.txt   