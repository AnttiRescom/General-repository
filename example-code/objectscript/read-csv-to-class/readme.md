# A simple implementation of reading a csv file to Intersystems' class database

Executing 'do ##class(fileaccess.readfile).readCsv("c:\foo.csv",",","0")' in console will parse through a csv file reading values to hardcoded columns.

Can be easily modified to accept file content as streams, as a part of a Business Production, instead of reading a static file.

https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=EFIL_inbound
