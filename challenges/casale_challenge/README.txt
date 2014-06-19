

This README will describe how domain_stats.pl is used, please read this fill file for instructions.

##############################################
####### IMPORTANT FILES ######################
##############################################
domain_stats.pl   <---- this holds the solution to the challenge
build_tables.sql  <---- used for building the database and tables
testbench.pl        <---- used for testing domain_stats.pl

##############################################
####### INVOKING TESTBENCH ###################
##############################################
To start testbench.pl:
perl testbench.pl

The testbench's constants can be used to change how many email address are inserted

##############################################
####### INVOKING SCRIPT ######################
##############################################

Before using the script:
1. make sure that the database is constructed:
     mysql -u root -p < build_tables.pl
2. make sure the the constructed tables are empty


The command to invoke the script is:
perl domain_stats.pl --addr=<email_address> [--stats=<boolean>] [--dbg=<boolean>]

--addr is manditory
--stats is used to determine if the script should output the top 50 domains with the highest growth rate in the last 30 days, is optional
--dbg is optional and should only be used by testbench.pl

for example, to invoke with no statistical output:
perl domain_stats.pl --addr=123@abc.net

to invoke with statistical output:
perl domain_stats.pl --addr=123@xyz.com --stats=1

#############################################
####### SCRIPT BEHAVIOUR ####################
#############################################
domain_stats.pl takes in an email address as input, 
insert it into the necessary tables, 
and output the proper statistics if the --stats flag is raised during it's command line call.

An assumption for dealing with duplicate email address, example:
if abc@gmail.com used as input mutiple times, mailings table will only have one instance of abc@gmail.com, 
but the count for the number of times it's inserted will increase for every insert.

#############################################
####### BUILDING THE DATABASE ###############
#############################################
The file "build_tables.sql" is used to construct the database.
The database is called "test"
The tables are "mailing", "domains", and "domain_stats"

In DB.pm, it is assumed that the database user is "root" and database password is "8888"

To build the database:
mysql -u <user> -p < build_tables.sql

############################################
######### DEBUG MODE BEHAVIOUR #############
############################################
In debug mode, instead of the growth rate of the last 30 days, only 2 days is used.
In debug mode, only the past 5 days will have emails inserted

