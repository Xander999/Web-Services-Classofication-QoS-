#!/usr/bin/perl
#-------------------------------------------------------------------------------#
# QWS Dataset (ver 1.0)								#
#-------------------------------------------------------------------------------#
# QWS source code code is subject to the following GNU General Public 		#
# License version 3:								#
#										#
# This program is free software; you can redistribute it and/or modify 		#
# it under the terms of the GNU General Public License version 2 as 		#
# published by the Free Software Foundation.					#
#										#
# This program is distributed in the hope that it will be useful, 		#
#  but WITHOUT ANY WARRANTY; without even the implied warranty of 		#
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 		#
#  GNU General Public License for more details.					#
#										#
#  The GNU General Public License 2.0 can be found at:				#
#  http://www.gnu.org/licenses/old-licenses/gpl-2.0.html			#
#										#
#  If you have any questions or want to help with programming, 			#
#  please write to Eyhab Al-Masri (ealmasri@uoguelph.ca)			#
#-------------------------------------------------------------------------------#
# This Perl script is an example for collecting data 				#
# from the data set. 								#
#-------------------------------------------------------------------------------#
# Details on columns:								#
# There are thirteen columns in this data set:					#
# 1: Response Time: time taken to send a request and receive a response (ms)	#
# 2: Availability: number of successful invocations/total invocations (%)	#
# 3: Throughput: total number of invocations for a given period of time (#/sec)	#
# 4: Successability: number of response / number of request messages (%)	#
# 5; Reliability: ratio of the number of error messages to total messages (%)	#
# 6: Compliance: extent a WSDL document follows WSDL spec. (%)			#
# 7: Best Practices: extent a Web service follows WS-I Basic Profile (%)	#
# 8: Latency: time taken for the server to process a given request (ms)		#
# 9: Documentation: measure of documentation (i.e. description tags) in WSDL (%)#
#10: WsRF: Web Service Relevancy Function: a rank for Web Service Quality (%)	#
#11: Class: levels representing service offering qualities (1 through 4) 	#
#12: Name: service name								#
#13: WSDL: WSDL file location							#
# For the purpose of this demo, only the selective properties are displayed	#
#-------------------------------------------------------------------------------#
# Class definition:  The 11th attribute represents various service offering 	#
# 		     differ in several Web Service Quality			#
#-------------------------------------------------------------------------------#
# Your comments and suggestions are welcome. Please send your comments by email:#
# Eyhab Al-Masri (ealmasri@uoguelph.ca) | Qusay H. Mahmoud (qmahmoud@uguelph.ca)#
#-------------------------------------------------------------------------------#
# Last updated: 2007-11-27 21:50:29 -0500					#
#-------------------------------------------------------------------------------#

print "Content-type:text/html\n\n";

print "<html><head><title>QWS Dataset display 
sample</title></head><body>";


#-------------------------------------------------------#
# Open the file called: QWS.txt				#
# File should be placed in the same folder runnning this#
# script						#
#-------------------------------------------------------#
open(INFO, "QWS.txt") || die "cannot open file\n"; $LOCK_EX = 2; $LOCK_UN = 8;


flock(INFO, $LOCK_EX);

#-------------------------------------------------------#
# Begin displaying HTML table for output data		#
# and use the split function to divide each line into 	#
# an array						#
#-------------------------------------------------------#


print <<EOF
<div align="center">
	<table border="1" width="800" cellspacing="0" cellpadding="5" id="table1" bordercolor="#808080" bgcolor="#FFFFFF">
	<tr>
		<td colspan="2">
		<p align="center"><b>
		<font face="Verdana" size="5" color="#808080">The QWS 
		Dataset</font></b></td>
	</tr>
</table></div>
<p align="center">&nbsp;</p>

<table 
border="0" width="100%" cellspacing="0" cellpadding="3" id="table1">
	<tr>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Name</font></td>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Response Time (ms)</font></td>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Throughput (hits/sec)</font></td>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Reliability (%)</font></td>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Best Practices (%)</font></td>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Documentation (%)</font></td>
		<td bgcolor="#E3E3D5"><font face="Arial" style="font-size: 8.5pt">Class</font></td>
	</tr>
EOF
;

$i = -6 ; #to skip processing the header of the data set file.
$j = 0;

while(<INFO>) 
{
   if ($i > 0)
   { 
      $record = $_;
	if ($j <= 25)
	{
	      	@ws = split(/,/, $record);
		print "<tr>\n";
		print "<td><a href=\"$ws[12]\" target=\"_blank\">$ws[11]</a></td>\n";
		print "<td>$ws[0]</td>\n";
		print "<td>$ws[2]</td>\n";
		print "<td>$ws[4]</td>\n";
		print "<td>$ws[6]</td>\n";
		print "<td>$ws[8]</td>\n";
		print "<td>$ws[10]</td>\n";
		print "</tr>\n";
	}
	$j = $j+1;
   }

$i = $i + 1;
next

}


print <<EOF
</table>
</body>
</html>
EOF
;


close(INFO);
flock(INFO, $LOCK_UN);



