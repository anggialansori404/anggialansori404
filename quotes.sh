#!/bin/bash

export TZ=Asia/Jakarta

var() {
    arr[0]="bot: 👋 Hello Github!"
    arr[1]="bot: 🥳 Yeayyy!"
    arr[2]="bot: 😬 Working from github."
    arr[3]="bot: 👨‍💻 Work, work, work!"
    arr[4]="bot: 🥳 UPdate Quotes:)"
    arr[5]="bot: 😎 New quotes!"
    arr[6]="bot: 🙄 Running task, again."
    arr[7]="bot: 👻 New word."

    api[0]="https://api.quotable.io/random"
    api[1]="https://zenquotes.io/api/random"
    # api[2]="https://goquotes-api.herokuapp.com/api/v1/random?count=1"

    rand=$((RANDOM % ${#arr[@]}))
    rapi=$((RANDOM % ${#api[@]}))
}

main() {
    echo "## Hi, there! I'm Anggi Al'Ansori <img src=\"https://raw.githubusercontent.com/AnggaR96s/AnggaR96s/master/assets/Hi.gif\" width=\"30px\">

<p align=\"center\">
<a href=\"https://github.com/anggialansori404\"> <img src=\"https://img.shields.io/badge/-Github-000?style=flat&logo=Github&logoColor=white\" /></a>
<a href=\"https://www.instagram.com/anggialansori_\"> <img src=\"https://img.shields.io/badge/-Instagram-c13584?style=flat&labelColor=c13584&logo=instagram&logoColor=white\" /></a>
<a href=\"mailto:anggialansori.rpl4@gmail.com\"> <img src=\"https://img.shields.io/badge/-Gmail-c14438?style=flat&logo=Gmail&logoColor=white\" /></p></a>


**Here is my portofolio as follows:**
<img width=\"55%\" align=\"right\" alt=\"Github\" src=\"https://raw.githubusercontent.com/AnggaR96s/AnggaR96s/master/assets/git-header.svg\" />

- A ROM maintainer for Redmi Note 10
- Official maintainer for [Nusantara ROM](https://github.com/Nusantara-ROM)
- Official maintainer for [Ancient ROM](https://github.com/Ancient-Roms)
- Windows & Ubuntu user 

**Some programming languages that are already learned by me as follows:** 
<p>
  <a href=\"https://github.com/anggialansori404\">
    <img width=\"55%\" align=\"right\" alt=\"Anggi Al'Ansori's GitHub Stats\" src=\"https://github-readme-stats.vercel.app/api?username=anggialansori404&show_icons=true&hide_border=true\" />
  </a>

  <code><img width=\"10%\" src=\"https://www.vectorlogo.zone/logos/mysql/mysql-ar21.svg\"></code>
  <code><img width=\"10%\" src=\"https://www.vectorlogo.zone/logos/php/php-ar21.svg\"></code>
  <code><img width=\"10%\" src=\"https://www.vectorlogo.zone/logos/git-scm/git-scm-ar21.svg\"></code>

</p>
<hr>
<h3 align=\"center\">Quote of The Day</h3>
<p align=\"center\">
<blockquote>
<i>\"${quote}\"</i>
<br>
<b>- ${author}</b>
</blockquote>
</p>

<hr>
<h2 align=\"center\">Thank You 🙏🏼</h2>
<p align=\"center\"><b><i>Nothing special with me!</i></b></p>
<p align=\"center\">
</p>" > README.md
}

clean() {
    if [[ "$1" == "post" ]]; then
        rm -rf data.json
    elif [[ -z "$1" ]]; then
        rm -rf data.json README.md
    fi
}

quotes() {
    if curl -s ${api[$rapi]} > data.json; then
        cat data.json
        if jq -r '.[] .q' data.json; then
            quote=$(jq -r '.[] .q' data.json)
            author=$(jq -r '.[] .a' data.json)
        elif jq -r '.content' data.json; then
            quote=$(jq -r '.content' data.json)
            author=$(jq -r '.author' data.json)
            if [[ "$quote" == "null" ]]; then
                quote=$(jq -r '.quotes[] .text' data.json)
                author=$(jq -r '.quotes[] .author' data.json)
            fi
        fi
    else
        echo "Fetch quotes api failed!"
        exit 1
    fi

    if [[ -z "${quote}" || -z "${author}" || "$quote" == "null" ]]; then
        echo "Fetch quotes failed!"
        exit 1
    fi
}


commit() {
    git config --global user.email "anggialansori.rpl4@gmail.com"
    git config --global user.name "anggialansori404"
    git commit -asm "${arr[$rand]} (${tgl})"
}

##### START #####
tgl=$(date '+%D %R %Z')
clean
var
quotes
main
clean post
commit
