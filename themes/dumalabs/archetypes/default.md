+++
title = "{{ replace .Name "-" " " | title }}"
date = '{{ .Date }}'
draft = true
menu:
  main:
    identifier: "{{ lower (replace .Name "-" "")  }}"
    weight: 100 
    parent: ""
+++

<h1> {{ .Name }} </h1>