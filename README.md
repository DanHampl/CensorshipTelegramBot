# CensorshipTelegramBot

## Run the app
### Run without GEM
```
ruby ctb.rb <token> </path/to/config.json>
ruby ctb.rb 110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw /mnt/d/FIT/CensorshipTelegramBot/CTB/config.json

or

chmod +x ./ctb.rb
./ctb.rb <token> </path/to/config.json>
./ctb.rb 110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw /mnt/d/FIT/CensorshipTelegramBot/CTB/config.json
```

### Run with GEM
```
gem build ctb.gemspec
gem install CensorshipTelegramBot-0.1.0.gem

ctb <token> </path/to/config.json>
ctb 110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw /mnt/d/FIT/CensorshipTelegramBot/CTB/config.json
```

## Tests
```
ruby -I test CTB/test/msg_match_test.rb
```

## Config
### Example
```
[
  {"user_ids": [1, 2, 3, 285629080]},
  {"and": [
    {"msg_contains": ["hello", "darkness", "my", "old", "friend"]},
    {"msg_contains": ["kek"]}
  ]}
]
```
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