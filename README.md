# CensorshipTelegramBot

## Config

### Keys
#### and
>All conditions need to be true
```
"and": [
    condition1,
    contition2,
    ...
]
```
#### or
>At least one of the conditions is true
```
"or": [
    condition1,
    contition2,
    ...
]
```
#### user_ids
>sender id has to be in list
```
"user_ids": [
    1,
    2,
    ...
]
```
#### user_names
>Sender name has to be in list
```
"user_names": [
    "karel",
    "pepa",
    ...
]
```
#### msg_contains
>Message contains any of the strings
```
"msg_contains": [
    "string1",
    "string2",
    ...
]
```