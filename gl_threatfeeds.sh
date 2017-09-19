#! /bin/bash
#OpenSource Threat Feed Downloader
#GITHUB: BREAKANDINSPECT
#Use: ./gl_threatfeeds.sh
#     should be run from /etc/graylog/feeds 
#     will require SUDO; could be CRON'd with modification 
#Last Updated: 9/19/2017
FEEDDIR="/etc/graylog/feeds"

convert_feed () {
 echo "Converting $1 to CSV ($2) using delimeter: '$3'"
 i=0
 cat $1 | while read line
 do
  let i++
  echo "$i$3$line" >> $2
 done 
}
cd $FEEDDIR
rm -rf *.tmp
rm -rf *.csv

echo "Downloading Abuse.ch Feeds"

wget https://spyeyetracker.abuse.ch/blocklist.php?download=domainblocklist -O feed_abuse_domain.tmp

wget https://spyeyetracker.abuse.ch/blocklist.php?download=ipblocklist -O feed_abuse_IP.tmp

wget https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist -O feed_zeus_domain.tmp

echo "INDEX,URL" >> feed_zeus_domain.csv
convert_feed feed_zeus_domain.tmp feed_zeus_domain.csv ","

wget https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist -O feed_zeus_IP.tmp

echo "INDEX,IPADDR" >> feed_zeus_IP.csv
convert_feed feed_zeus_IP.tmp feed_zeus_IP.csv ","

echo "Downloading AlienVault Feeds"

wget https://reputation.alienvault.com/reputation.data -O feed_alienvault_IP.tmp

echo "INDEX#IPADDR#Q1#Q2#DESCRIPTION#CC#LOCATION#GEO#Q3" >> feed_alienvault.csv
convert_feed  feed_alienvault_IP.tmp feed_alienvault.csv "#"
echo "Downloading MalwareDomains Feeds"

wget http://mirror1.malwaredomains.com/files/justdomains -O feed_mwd_domain.tmp

echo "INDEX,URL" >> feed_mwd_domain.csv
convert_feed  feed_mwd_domain.tmp feed_mwd_domain.csv ","

echo "Downloading MalwarePatrol Feeds"

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=clamav_basic" -O feed_mwp_clamav.tmp

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=mozilla_adblock" -O feed_mwp_mozilla.tmp

echo "INDEX,URL" >> feed_mwp_mozilla.csv
convert_feed  feed_mwp_mozilla.tmp feed_mwp_mozilla.csv ","

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=dansguardian" -O feed_mwp_dansguardian.tmp

echo "INDEX,URL" >> feed_mwp_dansguardian.csv
convert_feed feed_mwp_dansguardian.tmp feed_mwp_dansguardian.csv ","

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=mailwasher" -O feed_mwp_mailwasher.tmp

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=postfix" -O feed_mwp_postfix.tmp

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=smoothwall" -O feed_mwp_smoothwall.tmp

echo "INDEX,URL" >> feed_mwp_smoothwall.csv
convert_feed  feed_mwp_smoothwall.tmp feed_mwp_smoothwall.csv ","

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=spamassassin" -O feed_mwp_spamassassin.tmp

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=symantec_smtp_security" -O feed_mwp_symc-smtp.tmp

echo "INDEX:STATUS:URL" >> feed_mwp_symc-smtp.csv
convert_feed feed_mwp_symc-smtp.tmp feed_mwp_symc-smtp.csv ":"

wget "https://lists.malwarepatrol.net/cgi/getfile?receipt=CHANGE_ME_MWP_PASSWORD&product=8&list=symantec_websecurity" -O feed_mwp_symc-web.tmp

echo "INDEX,URL" >> feed_mwp_symc-web.csv
convert_feed feed_mwp_symc-web.tmp feed_mwp_symc-web.csv ","

#echo "Downloading SRI Feeds"
#wget http://mtc.sri.com/live_data/attackers/ -O feed_sri_ip.csv

echo "Downloading TOR Feeds"

wget http://torstatus.blutmagie.de/ip_list_exit.php/Tor_ip_list_EXIT.csv -O feed_tor-exit_IP.tmp

echo "INDEX,IPADDR" >> feed_tor-exit_IP.csv
convert_feed feed_tor-exit_IP.tmp feed_tor-exit_IP.csv ","

wget http://torstatus.blutmagie.de/ip_list_all.php/Tor_ip_list_ALL.csv -O feed_tor-all_IP.tmp

echo "INDEX,IPADDR" >> feed_tor-all_IP.csv
convert_feed feed_tor-all_IP.tmp feed_tor-all_IP.csv ","

echo "Threat Feed Downloads ... Complete!" 
