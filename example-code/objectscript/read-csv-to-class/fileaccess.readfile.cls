Class fileaccess.readfile Extends %Persistent [ DdlAllowed ]
{
/// V0.1 Antti Suomi 24.8.2022
/// here's the data that we will input to this class and later save to the db/class
/// DdlAllowed is the flag to allow dropping the table later on
/// Csv columns Id;personId;startdate;enddate;
Property Id As %Integer;

Property personId As %Integer;

Property startdate As %Integer;

Property enddate As %Integer;

/// Here we read the file line by line and try to save the data
/// No worries about the header specified the props above to Integer. Use trim to clean out the empty line.
/// Clear out the defaults below if used in production
ClassMethod saveCsv(filename As %String = "C:\gg.csv", delim As %String = ";", trim as %Integer = "0")
{
	Set adapter = ##class(%File).%New(filename)
	Set adapter2 = ##class(%File).%New(filename)
	Write "starting read, opening file",!
	Set status = adapter2.Open("R")
	///Where is the data located in the ; delimited line
	Set idpos = 1
	///Default blank values
	Set id = ""
	Set personIdpos = 2
	Set personId= ""
	Set startdatepos = 3
	Set startdate= ""
	Set enddatepos = 4
	Set enddate= ""
	///Check for total linecount
	set totalLines = 0

	while 'adapter2.AtEnd
		{
			set totalLines = totalLines + 1
			w "this is the total line count =", totalLines, !
			///this below checks out a single line from the csv
			Set line2=adapter2.ReadLine()
			w line2,!
		}
	///Close file
	Do adapter2.Close()
	///Linecount for insert
	Set linecount = 0

	/// Open your file
	Set status = adapter.Open("R")
	w "next up the while loop",!
	/// trim is meant to clean up empty lines from the file end
	while totalLines-linecount>trim
	{
		Set linecount = linecount + 1
		w "in the loop at line ", linecount,!
		Set kanta = ##class(fileaccess.readfile).%New()
		///this below checks out a single line from the csv
		Set line=adapter.ReadLine()
		//$PIECE apart 'line' with 'delim'
		Set Id = $PIECE(line,delim,idpos)
		Set personId = $PIECE(line,delim,personIdpos)
		Set startdate =$PIECE(line,delim,startdatepos)
		Set enddate =$PIECE(line,delim,enddatepos)

		w "Now storing data",!

		Set kanta.Id = Id
		w "storing id ", Id,!
		Set kanta.personId = personId
		w "storing personId ", personId,!
		/// Clean out hyphens
		set startdate = $Replace(startdate, "-","")
		Set kanta.startdate = startdate
		w "storing startdate ", startdate,!
		/// Clean out hyphens
		set enddate = $Replace(enddate, "-","")
		Set kanta.enddate= enddate
		w "storing enddate ", enddate,!
		///Save data to class.name db
		do kanta.%Save()
	}
	///Close the file being read
	Do adapter.Close()
	return $$$OK
}
}
