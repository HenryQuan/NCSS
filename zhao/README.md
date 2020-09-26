# 1.0.0
`0x100004B64` is the right address for adding numbers. 
~~~
ADDS            X8, X20, #1
~~~
`880600B1` - `44040094880600B1C6060054E80700F9`

I simply used my [ida2br](https://github.com/HenryQuan/ida2br) script to break all possible addresses and found this one. In the future, I might write another script so that you can remove incorrect addresses easily.

The goal of this project is to find the address of `880600B1` with a longer string, `44040094880600B1C6060054E80700F9`. This should prevent duplications and it is also searching in a range so it should be fine.

# 1.0.2
`0x100009374` is the address
~~~
ADDS            X10, X9, #1
~~~
`2A0500B1` - `E94B40F92A0500B1E8779F1AEA2F00F9`

The address and the arm code all changed. That's why I couldn't find it.