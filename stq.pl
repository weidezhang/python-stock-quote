#!/usr/bin/env python

import json
import pprint
import urllib2
import prettytable 
import time 
def get_stock_quote(ticker_symbol):   
    url = 'http://finance.google.com/finance/info?q=%s' % ticker_symbol
    #lines = urllib2.urlopen(url).read().splitlines()
    u = urllib2.urlopen(url)
    content = u.read()
    obj = json.loads(content[3:])
    return obj
#   return json.loads(''.join([x for x in lines if x not in ('// [', ']')]))


# u'c': u'+1.28',
# u'ccol': u'chg',
# u'cp': u'0.65',
# u'e': u'NYSE',
# u'id': u'18241',
# u'l': u'198.81',
# u'l_cur': u'198.81',
# u'lt': u'Mar 2, 4:03PM EST',
# u'ltt': u'4:03PM EST',
# u's': u'0',
# u't': u'IBM'}


if __name__ == '__main__':
    filename = "stocksymbol"
    FILE = open (filename, 'r')
    tickarrp = [] 
    tickarr = []
    i = 0 
    for line in FILE:
	tickarr.append(line.upper().rstrip("\n"))
        i = i + 1 # why can't use ++i  
        if i%5 ==0:
           i=0
    	   tickerstr = ','.join(tickarr)
           print tickerstr 
           tickarrp.append(tickerstr) 
           tickarr = [] 
    if i!= 0: 
        tickerstr = ','.join(tickarr)
        tickarrp.append(tickerstr)
        print tickerstr 
        tickarr = [] 
    while(1):
      print "####################################################"   
      table = [["symbol" , "abs chg","%", "price", "time"]]
      for tickerstr in tickarrp: 
    	    print tickerstr 
	    quotes = get_stock_quote(tickerstr)
	    for obj in quotes: 
		data = [] 
		data.append(obj['t']) 
		data.append(obj['c'])
		data.append(obj['cp'])
		data.append(obj['l_cur'])
		data.append(obj['lt'])
		table.append(data)
      import sys
      out = sys.stdout
      prettytable.pprint_table(out, table)
      time.sleep(10)       
      #pprint.pprint(quote)
