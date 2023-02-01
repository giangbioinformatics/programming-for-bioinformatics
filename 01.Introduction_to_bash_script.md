# [Bashcript reference](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)

## 1.Shortcut and history
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

## 2.Directory and file related command          
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
| Command              | Function                                               | Example |
|----------------------|--------------------------------------------------------|---------|
| which <program_name> | finds locations where programs or scripts are exported |         |
| clear                | clears content on window (hide displayed lines)        |         |
| history              | shows command line history                             |         |
### 3.1 File processing only
| Command                              | Function                                                                                                                 | Example                      |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------|------------------------------|
| ls                                   | lists your files in current directory, to print files in a specific directory                                            |                              |
| ls -lah                              | lists your files in 'long format',human readable file size and all files (even hidden files)                             | mkdir -p giang/giang1/giang2 |
| ln -s <filename> <link>              | creates symbolic link to file                                                                                            | mv giang/giang1/giang2 giang |
| tree                                 | how directories and subdirectories in easilly readable file tree                                                         | rm giang                     |
| tree <foldername>                    | show directories and subdirectories in easilly readable file tree in a folder                                            | rm -rf copied_giang          |
| tree <foldername> -L <level>         | show directories and subdirectories in easilly readable file tree in a folder with level options (1,2,3) to not show all | cd /home                     |
| touch <filename>                     | creates or updates (edit) your file                                                                                      | pwd                          |
| nl <file.sh>                         | shows number of lines in file                                                                                            |                              |
| cat                                  | displays file raw content (will not be interpreted)                                                                      |                              |
| cat filename1 > filename2            | Copy filename1 content to filename2                                                                                      |                              |
| cat filename1 filename2 >> filename2 | merge files texts together                                                                                               |                              |
| head -n<number of line> <filename>   | outputs the first lines of file (default: 10 lines) , may skip number of line options                                    |                              |
| tail -n<number of line> <filename>   | outputs the last lines of file (useful with -f option) (default: 10 lines) may skip number of line options               |                              |
| wc <filename>                        | tells you how many lines, words and characters there are in a file. Use -lwc (lines, word, character) to ouput only 1 of |                              |
| gzip <filename>                      | compresses files using gzip algorithm                                                                                    |                              |
| gunzip <filename>                    | uncompresses files compressed by gzip                                                                                    |                              |
| gzcat                                | lets you look at gzipped file without actually having to gunzip it                                                       |                              |
| grep                                 | looks for the string in the files                                                                                        |                              |
| grep -r                              | search recursively for pattern in directory                                                                              |                              |
| grep -v                              | remove line with that pattern                                                                                            |                              |
| sed 's///g'                          | replace pattern in file with replacement value to std output the character after s (/) is the delimeter                  |                              |
| sed -i 's///g'                       | replace pattern in file with replacement value in place                                                                  |                              |
| <string>\|tr <pattern1> <pattern2>   | quickly translate the value to other value.                                                                              |                              |
| find . -name <file_name>             | searches for a file or a directory in the current directory and all its sub-directories by its name                      |                              |
| sort                                 | sorts the contents of a text file line by line in alphabetical order, use -n for numeric sort and -r for reversing order |                              |
| sort -t -k                           | sorts the contents on specific sort key field starting from 1, using the field separator t.                              |                              |
| chmod <mode> <file or folder>        | lets you change the read, write, and execute permissions on your files (more infos: SUID, GUID)                          |                              |
| diff                                 | compares files, and shows where they differ                                                                              |                              |
| echo                                 | show line on screen, can be used with variables but have null value in stdout                                            |                              |
| printf                               | similar to echo, but the stdout can be put to a file                                                                     |                              |
### 03.2Should know but not use much at all
```
find . -name <name> <type>    # searches for a file or a directory in the current directory and all its sub-directories by its name
```
```  
sort <filename>               # sorts the contents of a text file line by line in alphabetical order, use -n for numeric sort and -r for reversing order.
```
```  
sort -t -k <filename>         # sorts the contents on specific sort key field starting from 1, using the field separator t.
```
```
chmod -options <filename>     # lets you change the read, write, and execute permissions on your files (more infos: SUID, GUID)
```
```
diff <filename1> <filename2>  # compares files, and shows where they differ
```
```
echo <string>                 # show line on screen, can be used with variables but have null value in stdout
```
```
printf <string>               # similar to echo, but the stdout can be put to a file     

