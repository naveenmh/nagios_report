#!/bin/bash
#
# Author : Sharad Kumar Chhetri
# Date : 21-aug-2015
# Version : 1.0
# Description : The script will fetch the nagios eventlog report one day old.
#
## 

#_URL="http://localhost/nagios/cgi-bin/showlog.cgi?archive=1"
#_URL="https://10.0.29.66/nagios/cgi-bin/avail.cgi?show_log_entries=&host=nagiosadmin&service=all&timeperiod=yesterday&timeperiod=24x7"
#_URL="https://10.0.29.66/nagios/cgi-bin/status.cgi?hostgroup=all&style=overview"
#_URL2="https://10.0.29.66/nagios/cgi-bin/status.cgi?servicegroup=all&style=overview"
_URL="https://10.0.29.66/nagios/cgi-bin/status.cgi?hostgroup=all&style=detail&servicestatustypes=4&hoststatustypes=15"
_USER=nagiosadmin
_PASSWORD=nagiosadmin
_REPORT_PATH=/home/kodiak/naveenmh/scripts/nagios/NagiosReport
_FILE_NAME=Nagios-Service-Status-Log-`date +%F --date="today"`.pdf
#_FILE_NAME=Nagios-HOSTGROUPLOG-`date +%F --date="yesterday"`.pdf
#_FILE_NAME2=Nagios-SERVICEGROUPLOG-`date +%F --date="yesterday"`.pdf
_TO_EMAIL=naveenkumar.mh@motorolasolutions.com,utham.hoode@motorolasolutions.com,vijayan.seralathan@motorolasolutions.com,rahul.madurwar@motorolasolutions.com
_WKHTMLTOPDF=`which wkhtmltopdf`

if [ -d $_REPORT_PATH ]
then
echo "NagiosReport directory already exist in $_REPORT_PATH "
else
mkdir -p $_REPORT_PATH
echo $(ls -ld $_REPORT_PATH)
echo "$_REPORT_PATH directory created"
fi

### Create pdf file of Nagios Event Log , Set the --page-height and --page-width as per your requirement.
$_WKHTMLTOPDF --username $_USER --password $_PASSWORD "$_URL" "$_REPORT_PATH/$_FILE_NAME"
#$_WKHTMLTOPDF --username $_USER --password $_PASSWORD "$_URL2" "$_REPORT_PATH/$_FILE_NAME2"

### Send Email with attachment
echo -e "Hello Team,\n\n		Find Nagios report dated of $(date +%F --date=today), attachment is enclosed in this email.\n\nBest Regards,\nNagios Admin"|mutt -a "$_REPORT_PATH/$_FILE_NAME" -s "Nagios Weekly Report: Nagios Service Status Log  $(date +%F --date=today)" -- $_TO_EMAIL
#echo -e "Hello Team,\n		Find Nagios report dated of $(date +%F --date=yesterday), attachment is enclosed in this email.\nBest Regardsn\nNagios Admin"|mutt -a "$_REPORT_PATH/$_FILE_NAME2" -s "Report: Nagios Event Log  $(date +%F --date=yesterday)" -- $_TO_EMAIL
