# **Time Variables**

## ***Clock Time***

`hours`, `minutes`, `seconds`

## ***Stopwatch Time***
`swMinutes`, `swSeconds`

## ***Timer Time***
`tmrMinutes`, `tmrSeconds`

# **Modes**
## ***Buttons***

### **RB0 - Mode Toggling**

*sysMode*
- **0** - CLOCK: 12H
- **1** - CLOCK: 24H
- **2** - STOPWATCH
- **3** - TIMER

### **RB4 - PAUSE / GO**

*clockState*, *swState*, *tmrState*
- **0** - GO
- **1** - PAUSE

### **RB5 - RESET**

*sysMode is **0** and **1***
- seconds = 0
- minutes = 0
- hours = 0

*sysMode is **2***
- swSeconds = 0
- swMinutes = 0

*sysMode is **3***
- tmrSeconds = 0
- tmrMinutes = 0

### **RB6 - SET**

*digitFlag*
- **0** - No digit is being set
- **1** - ***SETTING:*** *hours*, *tmrMinutes*
- **2** - ***SETTING:*** *minutes*, *tmrSeconds*

### **RB7 - INCREMENT**
- *hours* + 1
- *minutes* + 1
- *seconds* + 1
- *tmrMinutes* + 1
- *tmrSeconds* + 1
