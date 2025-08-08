#!/bin/bash

# create all .sh file into one au_alias_one.sh from source of sh in au_alias.sh

FILE_NAME="au_alias_one.sh"
ALIAS_FILE="au_alias.sh"

get_line(){
    grep -n "$1" $2 | cut -d':' -f1
}

create_file(){
    echo "#!/bin/bash" > $FILE_NAME
}

write_line(){
    echo "$1" >> $FILE_NAME
}

get_lines(){
    lineStart=$((  $(get_line "# $1" "$3") + 1  ))
    lineEnd=$((  $(get_line "# $2" "$3") - 1  ))
    sed -n "$lineStart,$lineEnd p" "$3"
}

# create au_alias_one.sh
create_file

# wirte define
write_line ""
write_line "# define"

get_lines define include $ALIAS_FILE >> $FILE_NAME

sed -i s/au_alias.sh/au_alias_one.sh/ $FILE_NAME

# get all sourced sh file define
get_lines include start $ALIAS_FILE | while read -r line; do
    files="$(echo "$line" | cut -d'/' -f2 | cut -d'"' -f1)"
    if [ -z "$files" ]; then continue; fi

    get_lines define include $files | while read -r line; do
        if [ -z "$line" ]; then continue; fi
        echo $line >> $FILE_NAME
    done
done

write_line ""
write_line "# include"

write_line ""
write_line "# start"

get_lines start help $ALIAS_FILE >> $FILE_NAME

get_lines include start $ALIAS_FILE | while read -r line; do
    files="$(echo "$line" | cut -d'/' -f2 | cut -d'"' -f1)"
    if [ -z "$files" ]; then continue; fi

    get_lines start help $files >> $FILE_NAME
done

write_line ""
write_line "# help"

get_lines help end $ALIAS_FILE >> $FILE_NAME

get_lines include start $ALIAS_FILE | while read -r line; do
    files="$(echo "$line" | cut -d'/' -f2 | cut -d'"' -f1)"
    if [ -z "$files" ]; then continue; fi

    get_lines help end $files >> $FILE_NAME
done

write_line ""
write_line "# end"