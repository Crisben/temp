%>%
        hc_rangeSelector(buttons=list(
          list(type= 'month',count= 1,text= '1m'),
          list(type= 'month',count= 3,text= '3m'),
          list(type= 'month',count= 6,text= '6m'),
          #list(type= 'ytd', text= 'YTD'),
          list(type= 'year',count= 1,text= '1Y'),
          list(type= 'year',count= 3,text= '3Y'),
          list(type= 'year',count= 5,text= '5Y'),
          list(type= 'year',count= 7,text= '7Y'),
          list(type= 'all',text= 'All')))
