select * from employee_salary

--1.Extract those employeeID where employee salary is greater than manager salary
SELECT *
FROM employee_salary w,
     employee_salary m
WHERE w.ManagerID = m.EmpID
  AND w.Salary> m.Salary

create table customerss(
CUSTID	varchar(10),
SALES	int,
DATES date)


insert into customerss(CUSTID,SALES,DATES)
select 1011,1000,22-12-2018
union select 1012,1011, 16-05-2018
union select 1033,1081,11-01-2018
union select 1043,1056,25-09-2017
union select 1087,11111,28-09-2016
union select 10I9,1789,08-10-2015
union select 11I6,1590,17-06-2017
union select 1043,1056,25-09-2017
union select 1011,-11111,22-12-2018
union select 1012,1011,16-05-2018
union select 1033,1081,11-01-2018
union select 1043,-11056,25-09-2017
union select 1087,11111,28-09-2016
union select 10I9,1789,08-10-2015
union select 11I6,1590,17-06-2017


--2.Select Customers who have done net positive shopping in the last 2 years starting from today.

select * from customer 
where SALES > 0 AND
 DATEDIFF(month, DATES, GETDATE()) <= 24;

 select DATEDIFF(month, DATES, GETDATE()) from customer;



--3. Append CUST_INFO_TABLE1 and CUST_INFO_TABLE2 TO FORM CUSTINFO TABLE

create table CUST_INFO_TABLE1(
CUSTID	int,
CITY	varchar(20),
ADRESS varchar(20))

insert into CUST_INFO_TABLE1(CUSTID,CITY,ADRESS)
select 1011,'BANGALORE','MARATHALLI'
union select 1012,'MUMBAI','BANDRA'
union select 1033,'CHENNAI','ADYAR'
union select 1043,'KOLKATA','JADAVPUR'
union select 1087,'BUBNESHWAR','ASHOK NAGAR'
union select 1019,'BANGALORE','VIJAYNAGAR'
union select 1116,'MUMBAI','ALTAMOUNT ROAD'


create table CUST_INFO_TABLE2(
CUSTID	int,
CITY	varchar(20),
ADRESS varchar(20))

insert into CUST_INFO_TABLE2(CUSTID,CITY,ADRESS)
select  1043,'CHENNAI','BESANT NAGAR'
union select 1011,'KOLKATA','PARK STREET'
union select 1012,'BUBNESHWAR','BAPUJI NAGAR'
union select 1033,'HYDERABAD','JUBLIEE HILLS'
union select 1043,'THIRUVANANTHAPURAM','VARKALA'
union select 1087,'CHENNAI','ANNA NAGAR'
union select 1019,'BANGALORE','MALLESHWARAM'
union select 1116,'DELHI','VASANT KUNJ'

select * from customer


select * from CUST_INFO_TABLE1

union 

select * from CUST_INFO_TABLE2


select * from customer

insert into customer
select 1011,1000,'22-Dec-2018'
union select 1012,1011, '16-May-2018'
union select 1033,1081,'11-Jan-2018'
union select 1043,1056,'25-Sep-2017'
union select 1087,11111,'28-Sep-2016'
union select 10I9,1789,'08-Oct-2015'
union select 11I6,1590,'17-Jun-2017'
union select 1043,1056,'25-Sep-2017'
union select 1011,-11111,'22-Dec-2018'
union select 1012,1011,'16-May-2018'
union select 1033,1081,'11-Jan-2018'
union select 1043,-11056,'25-Sep-2017'
union select 1087,11111,'28-Sep-2016'
union select 1019,1789,'08-Oct-2015'
union select 1116,1590,'17-Jun-2017'

create table cust_ino_final(
cust_id int,
city varchar(25),
address varchar(25))




insert into cust_ino_final
select 1011,'BANGALORE','MARATHALLI'
union select 1012,'MUMBAI','BANDRA'
union select 1033,'CHENNAI','ADYAR'
union select 1043,'KOLKATA','JADAVPUR'
union select 1087,'BUBNESHWAR','ASHOK NAGAR'
union select 1019,'BANGALORE','VIJAYNAGAR'
union select 1116,'MUMBAI','ALTAMOUNT ROAD'
union select 1043,'CHENNAI','BESANT NAGAR'
union select 1011,'KOLKATA','PARK STREET'
union select 1012,'BUBNESHWAR','BAPUJI NAGAR'
union select 1033,'HYDERABAD','JUBLIEE HILLS'
union select 1043,'THIRUVANANTHAPURAM','VARKALA'
union select 1087,'CHENNAI','ANNA NAGAR'
union select 1019,'BANGALORE','MALLESHWARAM'
union select 1116,'DELHI','VASANT KUNJ'

select * from cust_ino_final
select * from customer


--4. Select customerid, address fields along with city who have done shopping in last one
--year starting from today

select custid, address, city, DATES from customer as c join cust_ino_final as ci on c.custid=ci.cust_id
where datediff(month,dates, getdate())<=12


--5. Create 3 groups with 5 customers in each group with decreasing order of sales

select * from (select *,Ntile(3) over (order by sales desc) as salesdec 
from customer) as a

--6.update the Address to ‘INDIRANAGR’ where the city is BANGALORE

begin transaction
update cust_ino_final
set address='Indiranagr'
where city ='Bangalore'

rollback


--7.update CUSTOMER_TABLE with city from CUST_INFO_TABLE
	select * from cust_ino_final;

ALTER table customer
ADD city varchar(50);

select * from customer;

UPDATE    customer 
SET  customer.city = cust_ino_final.city
from customer
inner join cust_ino_final
on customer.custId = cust_ino_final.cust_id


--8. find cumulative sum of SALES for each custid

Select c1.CUSTID, c1.Sales, 
SUM (Sales) OVER (ORDER BY c1.CUSTID )
From customer c1
Order By c1.CUSTID Asc

--9.  Write a query to get top 1 customer with highest SALES amount per day

with first_sales as(
SELECT *, Rank() over (order by sales ASC) as ranking
from customer)
select * from first_sales where ranking=1

select * from customer;


--10.There is a CITIES table which contains population for some of the cities of India.
-- All you need to do is extract 5th most populated city of every state using SQL query. 


create table country(
State varchar(20),	
City varchar(40),
Population bigint)



insert into country
select 'ANDHRA PRADESH','Greater Hyderabad (M Corp.)',6809970
union select 'ANDHRA PRADESH','GVMC (MC)',1730320
union select 'ANDHRA PRADESH','Vijayawada (M Corp.)',1048240
union select 'ANDHRA PRADESH','Guntur (M Corp.)',651382
union select 'ANDHRA PRADESH','Warangal (M Corp.)',620116
union select 'ANDHRA PRADESH','Nellore (M Corp.)',505258
union select 'ANDHRA PRADESH','Kurnool (M Corp.)',424920
union select 'ANDHRA PRADESH','Rajahmundry (M Corp.)',343903
union select 'ANDHRA PRADESH','Kadapa (M Corp.)',341823
union select 'ANDHRA PRADESH','Kakinada (M Corp.)',312255
union select 'ANDHRA PRADESH','Nizamabad (M Corp.)',310467
union select 'ANDHRA PRADESH','Tirupati (M Corp.)',287035
union select 'ANDHRA PRADESH','Anantapur (M Corp.)',262340
union select 'ANDHRA PRADESH','Karimnagar (M Corp.)',260899
union select 'ANDHRA PRADESH','Ramagundam (M)',229632
union select 'ANDHRA PRADESH','Vizianagaram (M)',227533
union select 'ANDHRA PRADESH','Eluru (M Corp.)',214414
union select 'ANDHRA PRADESH','Secunderabad (CB)',213698
union select 'ANDHRA PRADESH','Ongole (M)',202826
union select 'ANDHRA PRADESH','Nandyal (M)',200746
union select 'ANDHRA PRADESH','Khammam (M)',184252
union select 'ANDHRA PRADESH','Machilipatnam (M)',170008
union select 'ANDHRA PRADESH','Adoni (M)',166537
union select 'ANDHRA PRADESH','Tenali (M)',164649
union select 'ANDHRA PRADESH','Proddatur (M)',162816
union select 'ANDHRA PRADESH','Mahbubnagar (M)',157902
union select 'ANDHRA PRADESH','Chittoor (M)',153766
union select 'ANDHRA PRADESH','Hindupur (M)',151835
union select 'ANDHRA PRADESH','Bhimavaram (M)',142280
union select 'ANDHRA PRADESH','Madanapalle (M)',135669
union select 'ANDHRA PRADESH','Nalgonda (M)',135163
union select 'ANDHRA PRADESH','Guntakal (M)',126479
union select 'ANDHRA PRADESH','Srikakulam (M)',126003
union select 'ANDHRA PRADESH','Dharmavaram (M)',121992
union select 'ANDHRA PRADESH','Gudivada (M)',118289
union select 'ANDHRA PRADESH','Adilabad (M)',117388
union select 'ANDHRA PRADESH','Narasaraopet (M)',116329
union select 'ANDHRA PRADESH','Tadpatri (M)',108249
union select 'ANDHRA PRADESH','Suryapet (M)',105250
union select 'ANDHRA PRADESH','Miryalaguda (M)',103855
union select 'ANDHRA PRADESH','Tadepalligudem (M)',103577
union select 'ANDHRA PRADESH','Chilakaluripet (M)',101550
union select 'BIHAR','Patna (M Corp.)',1683200
union select 'BIHAR','Gaya (M Corp.)',463454
union select 'BIHAR','Bhagalpur (M Corp.)',398138
union select 'BIHAR','Muzaffarpur (M Corp.)',351838
union select 'BIHAR','Biharsharif (M Corp.)',296889
union select 'BIHAR','Darbhanga (M Corp.)',294116
union select 'BIHAR','Purnia (M Corp.)',280547
union select 'BIHAR','Arrah (M Corp.)',261099
union select 'BIHAR','Begusarai (M Corp.)',251136
union select 'BIHAR','Katihar (M Corp.)',225982
union select 'BIHAR','Munger (M Corp.)',213101
union select 'BIHAR','Chapra (NP)',201597
union select 'BIHAR','Dinapur Nizamat (NP)',182241
union select 'BIHAR','Saharsa (NP)',155175
union select 'BIHAR','Sasaram (NP)',147396
union select 'BIHAR','Hajipur (NP)',147126
union select 'BIHAR','Dehri (NP)',137068
union select 'BIHAR','Siwan (NP)',134458
union select 'BIHAR','Bettiah (NP)',132896
union select 'BIHAR','Motihari (NP)',125183
union select 'BIHAR','Bagaha (NP)',113012
union select 'BIHAR','Kishanganj (NP)',107076
union select 'BIHAR','Jamalpur (NP)',105221
union select 'BIHAR','Buxar (NP)',102591
union select 'BIHAR','Jehanabad (NP)',102456
union select 'BIHAR','Aurangabad (NP)',101520
union select 'GUJARAT','Ahmadabad (M Corp.)',5570585
union select 'GUJARAT','Surat (M Corp.)',4462002
union select 'GUJARAT','Vadodara (M Corp.)',1666703
union select 'GUJARAT','Rajkot (M. Corp)',1286995
union select 'GUJARAT','Bhavnagar (M Corp.)',593768
union select 'GUJARAT','Jamnagar (M Corp.)',529308
union select 'GUJARAT','Junagadh (M Corp.)',320250
union select 'GUJARAT','Gandhidham (M)',248705
union select 'GUJARAT','Nadiad (M)',218150
union select 'GUJARAT','Gandhinagar (NA)',208299
union select 'GUJARAT','Anand (M)',197351
union select 'GUJARAT','Morvi (M)',188278
union select 'GUJARAT','Mahesana (M)',184133
union select 'GUJARAT','Surendranagar Dudhrej (M)',177827
union select 'GUJARAT','Bharuch (M)',168729
union select 'GUJARAT','Navsari (M)',160100
union select 'GUJARAT','Veraval (M)',153696
union select 'GUJARAT','Porbandar (M)',152136
union select 'GUJARAT','Bhuj (M)',147123
union select 'GUJARAT','Godhra (M)',143126
union select 'GUJARAT','Botad (M)',130302
union select 'GUJARAT','Palanpur (M)',127125
union select 'GUJARAT','Patan (M)',125502
union select 'GUJARAT','Jetpur Navagadh (M)',118550
union select 'GUJARAT','Valsad (M)',114987
union select 'GUJARAT','Kalol (M)',112126
union select 'GUJARAT','Gondal (M)',112064
union select 'GUJARAT','Deesa (M)',111149
union select 'GUJARAT','Amreli (M)',105980
union select 'HARYANA','Faridabad (M Corp.)',1404653
union select 'HARYANA','Gurgaon (M Corp.)',876824
union select 'HARYANA','Rohtak (M Cl)',373133
union select 'HARYANA','Hisar (M Cl)',301249
union select 'HARYANA','Panipat (M Cl)',294150
union select 'HARYANA','Karnal (M Cl)',286974
union select 'HARYANA','Sonipat (M Cl)',277053
union select 'HARYANA','Yamunanagar (M Cl)',216628
union select 'HARYANA','Panchkula (M Cl) (incl.spl)',210175
union select 'HARYANA','Bhiwani (M Cl)',197662
union select 'HARYANA','Ambala (M Cl)',196216
union select 'HARYANA','Sirsa (M Cl)',183282
union select 'HARYANA','Bahadurgarh (M Cl)',170426
union select 'HARYANA','Jind (M Cl)',166225
union select 'HARYANA','Thanesar (M Cl)',154962
union select 'HARYANA','Kaithal (M Cl)',144633
union select 'HARYANA','Rewari (M Cl)',140864
union select 'HARYANA','Palwal (M Cl)',127931
union select 'HARYANA','Jagadhri (M Cl)',124915
union select 'HARYANA','Ambala Sadar (M CL)',104268
union select 'JHARKHAND','Dhanbad (M Corp.)',1161561
union select 'JHARKHAND','Ranchi (M Corp.)',1073440
union select 'JHARKHAND','Jamshedpur (NAC)',629659
union select 'JHARKHAND','Bokaro Steel City (CT)',413934
union select 'JHARKHAND','Mango (NAC)',224002
union select 'JHARKHAND','Deoghar (M Corp.)',203116
union select 'JHARKHAND','Aditya (NP)',173988
union select 'JHARKHAND','Hazaribag (NP)',142494
union select 'JHARKHAND','Chas (NP)',141618
union select 'JHARKHAND','Giridih (NP)',114447
union select 'KARNATAKA','BBMP (M Corp.)',8425970
union select 'KARNATAKA','Hubli-Dharwad *(M Corp.)',943857
union select 'KARNATAKA','Mysore (M Corp.)',887446
union select 'KARNATAKA','Gulbarga (M Corp.)',532031
union select 'KARNATAKA','Belgaum (M Corp.)',488292
union select 'KARNATAKA','Mangalore (M Corp.)',484785
union select 'KARNATAKA','Davanagere (M Corp.)',435128
union select 'KARNATAKA','Bellary (M Corp.)',409644
union select 'KARNATAKA','Bijapur (CMC)',326360
union select 'KARNATAKA','Shimoga (CMC)',322428
union select 'KARNATAKA','Tumkur (CMC)',305821
union select 'KARNATAKA','Raichur (CMC)',232456
union select 'KARNATAKA','Bidar (CMC)',211944
union select 'KARNATAKA','Hospet (CMC)',206159
union select 'KARNATAKA','Gadag-Betigeri (CMC)',172813
union select 'KARNATAKA','Bhadravati (CMC)',150776
union select 'KARNATAKA','Robertson Pet (CMC)',146428
union select 'KARNATAKA','Chitradurga (CMC)',139914
union select 'KARNATAKA','Kolar (CMC)',138553
union select 'KARNATAKA','Mandya (CMC)',137735
union select 'KARNATAKA','Hassan (CMC)',133723
union select 'KARNATAKA','Udupi (CMC)',125350
union select 'KARNATAKA','Chikmagalur (CMC)',118496
union select 'KARNATAKA','Bagalkot (CMC)',112068
union select 'KARNATAKA','Ranibennur (CMC)',106365
union select 'KARNATAKA','Gangawati (CMC)',105354
union select 'MADHYA PRADESH','Indore (M Corp.)',1960631
union select 'MADHYA PRADESH','Bhopal (M Corp.)',1795648
union select 'MADHYA PRADESH','Jabalpur (M Corp.)',1054336
union select 'MADHYA PRADESH','Gwalior (M Corp.)',1053505
union select 'MADHYA PRADESH','Ujjain (M Corp.)',515215
union select 'MADHYA PRADESH','Dewas (M Corp.)',289438
union select 'MADHYA PRADESH','Satna (M Corp.)',280248
union select 'MADHYA PRADESH','Sagar (M Corp.)',273357
union select 'MADHYA PRADESH','Ratlam (M Corp.)',264810
union select 'MADHYA PRADESH','Rewa (M Corp.)',235422
union select 'MADHYA PRADESH','Murwara (Katni) (M Corp.)',221875
union select 'MADHYA PRADESH','Singrauli (M Corp.)',220295
union select 'MADHYA PRADESH','Burhanpur (M Corp.)',210891
union select 'MADHYA PRADESH','Khandwa (M Corp.)',200681
union select 'MADHYA PRADESH','Morena (M)',200506
union select 'MADHYA PRADESH','Bhind (M)',197332
union select 'MADHYA PRADESH','Guna (M)',180978
union select 'MADHYA PRADESH','Shivpuri (M)',179972
union select 'MADHYA PRADESH','Vidisha (M)',155959
union select 'MADHYA PRADESH','Mandsaur (M)',141468
union select 'MADHYA PRADESH','Chhindwara (M)',138266
union select 'MADHYA PRADESH','Chhattarpur (M)',133626
union select 'MADHYA PRADESH','Neemuch (M)',128108
union select 'MADHYA PRADESH','Pithampur (M)',126099
union select 'MADHYA PRADESH','Damoh (M)',124979
union select 'MADHYA PRADESH','Hoshangabad (M)',117956
union select 'MADHYA PRADESH','Sehore (M)',108818
union select 'MADHYA PRADESH','Khargone (M)',106452
union select 'MADHYA PRADESH','Betul (M)',103341
union select 'MADHYA PRADESH','Seoni (M)',102377
union select 'MADHYA PRADESH','Datia (M)',100466
union select 'MADHYA PRADESH','Nagda (M)',100036
union select 'MAHARASHTRA','Greater Mumbai (M Corp.)',12478447
union select 'MAHARASHTRA','Pune (M Corp.)',3115431
union select 'MAHARASHTRA','Nagpur (M Corp.)',2405421
union select 'MAHARASHTRA','Thane (M Corp.)',1818872
union select 'MAHARASHTRA','Pimpri-Chinchwad (M Corp.)',1729359
union select 'MAHARASHTRA','Nashik (M Corp.)',1486973
union select 'MAHARASHTRA','Kalyan-Dombivali (M Corp.)',1246381
union select 'MAHARASHTRA','Vasai Virar City (M Corp.)',1221233
union select 'MAHARASHTRA','Aurangabad (M Corp.)',1171330
union select 'MAHARASHTRA','Navi Mumbai (M Corp.)',1119477
union select 'MAHARASHTRA','Solapur (M Corp.)',951118
union select 'MAHARASHTRA','Mira-Bhayander (M Corp.)',814655
union select 'MAHARASHTRA','Bhiwandi (M Corp.)',711329
union select 'MAHARASHTRA','Amravati (M Corp.)',646801
union select 'MAHARASHTRA','Nanded Waghala (M Corp.)',550564
union select 'MAHARASHTRA','Kolapur (M Corp.)',549283
union select 'MAHARASHTRA','Ulhasnagar (M Corp.)',506937
union select 'MAHARASHTRA','Sangli Miraj Kupwad (M Corp.)',502697
union select 'MAHARASHTRA','Malegoan (M Corp.)',471006
union select 'MAHARASHTRA','Jalgaon (M Corp.)',460468
union select 'MAHARASHTRA','Akola (M Corp.)',427146
union select 'MAHARASHTRA','Latur (M Cl)',382754
union select 'MAHARASHTRA','Dhule (M Corp.)',376093
union select 'MAHARASHTRA','Ahmadnagar (M Corp.)',350905
union select 'MAHARASHTRA','Chandrapur (M Cl)',321036
union select 'MAHARASHTRA','Parbhani (M Cl)',307191
union select 'MAHARASHTRA','Ichalkaranji (M Cl)',287570
union select 'MAHARASHTRA','Jalna (M Cl)',285349
union select 'MAHARASHTRA','Ambernath (M Cl)',254003
union select 'MAHARASHTRA','Navi Mumbai Panvel Raigad (CT)',194999
union select 'MAHARASHTRA','Bhusawal (M Cl)',187750
union select 'MAHARASHTRA','Panvel (M Cl)',180464
union select 'MAHARASHTRA','Badalapur (M Cl)',175516
union select 'MAHARASHTRA','Bid (M Cl)',146237
union select 'MAHARASHTRA','Gondiya (M Cl)',132889
union select 'MAHARASHTRA','Satara (M Cl)',120079
union select 'MAHARASHTRA','Barshi (M Cl)',118573
union select 'MAHARASHTRA','Yavatmal (M Cl)',116714
union select 'MAHARASHTRA','Achalpur (M Cl)',112293
union select 'MAHARASHTRA','Osmanabad (M Cl)',112085
union select 'MAHARASHTRA','Nandurbar (M Cl)',111067
union select 'MAHARASHTRA','Wardha (M Cl)',105543
union select 'MAHARASHTRA','Udgir (M Cl)',104063
union select 'MAHARASHTRA','Hinganghat (M Cl)',100416
union select 'NCT OF DELHI','DMC (U) (M Corp.)',11007835
union select 'NCT OF DELHI','Kirari Suleman Nagar (CT)',282598
union select 'NCT OF DELHI','NDMC (M Cl) Total',249998
union select 'NCT OF DELHI','Karawal Nagar (CT)',224666
union select 'NCT OF DELHI','Nangloi Jat (CT)',205497
union select 'NCT OF DELHI','Bhalswa Jahangir Pur (CT)',197150
union select 'NCT OF DELHI','Sultan Pur Majra (CT)',181624
union select 'NCT OF DELHI','Hastsal (CT)',177033
union select 'NCT OF DELHI','Deoli (CT)',169410
union select 'NCT OF DELHI','Dallo Pura (CT)',154955
union select 'NCT OF DELHI','Burari (CT)',145584
union select 'NCT OF DELHI','Mustafabad (CT)',127012
union select 'NCT OF DELHI','Gokal Pur (CT)',121938
union select 'NCT OF DELHI','Mandoli (CT)',120345
union select 'NCT OF DELHI','Delhi Cantonment (CB)',116352
union select 'ORISSA','Bhubaneswar Town (M Corp.)',837737
union select 'ORISSA','Cuttack (M Corp.)',606007
union select 'ORISSA','Brahmapur Town (M Corp.)',355823
union select 'ORISSA','Raurkela Town (M)',273217
union select 'ORISSA','Raurkela Industrial Township (IT)',210412
union select 'ORISSA','Puri Town (M)',201026
union select 'ORISSA','Sambalpur Town (M)',183383
union select 'ORISSA','Baleshwar Town (M)',118202
union select 'ORISSA','Baripada Town (M)',110058
union select 'ORISSA','Bhadrak (M)',107369
union select 'PUNJAB','Ludhiana (M Corp.)',1613878
union select 'PUNJAB','Amritsar (M Corp.)',1132761
union select 'PUNJAB','Jalandhar (M Corp.)',862196
union select 'PUNJAB','Patiala (M Corp.)',405164
union select 'PUNJAB','Bathinda (M Corp.)',285813
union select 'PUNJAB','Hoshiarpur (M Cl)',168443
union select 'PUNJAB','Batala (M Cl)',156400
union select 'PUNJAB','Moga (M Cl)',150432
union select 'PUNJAB','Pathankot (M Cl)',148357
union select 'PUNJAB','S.A.S. Nagar (M Cl)',146104
union select 'PUNJAB','Abohar (M Cl)',145238
union select 'PUNJAB','Malerkotla (M Cl)',135330
union select 'PUNJAB','Khanna (M Cl)',128130
union select 'PUNJAB','Muktsar (M Cl)',117085
union select 'PUNJAB','Barnala (M Cl)',116454
union select 'PUNJAB','Firozpur (M Cl)',110091
union select 'PUNJAB','Kapurthala (M Cl)',101654
union select 'RAJASTHAN','Jaipur (M Corp.)',3073350
union select 'RAJASTHAN','Jodhpur (M Corp.)',1033918
union select 'RAJASTHAN','Kota (M Corp.)',1001365
union select 'RAJASTHAN','Bikaner (M Corp.)',647804
union select 'RAJASTHAN','Ajmer (M Corp.)',542580
union select 'RAJASTHAN','Udaipur (M Cl)',451735
union select 'RAJASTHAN','Bhilwara (M Cl)',360009
union select 'RAJASTHAN','Alwar (M Cl)',315310
union select 'RAJASTHAN','Bharatpur (M Cl)',252109
union select 'RAJASTHAN','Sikar (M Cl)',237579
union select 'RAJASTHAN','Pali (M Cl)',229956
union select 'RAJASTHAN','Ganganagar (M Cl)',224773
union select 'RAJASTHAN','Tonk (M Cl)',165363
union select 'RAJASTHAN','Kishangarh (M Cl)',155019
union select 'RAJASTHAN','Hanumangarh (M Cl)',151104
union select 'RAJASTHAN','Beawar (M Cl)',145809
union select 'RAJASTHAN','Dhaulpur (M)',126142
union select 'RAJASTHAN','Sawai Madhopur (M)',120998
union select 'RAJASTHAN','Churu (M Cl)',119846
union select 'RAJASTHAN','Gangapur City (M)',119045
union select 'RAJASTHAN','Jhunjhunun (M Cl)',118966
union select 'RAJASTHAN','Baran (M)',118157
union select 'RAJASTHAN','Chittaurgarh (M)',116409
union select 'RAJASTHAN','Hindaun (M)',105690
union select 'RAJASTHAN','Bhiwadi (M)',104883
union select 'RAJASTHAN','Bundi (M)',102823
union select 'RAJASTHAN','Sujangarh (M)',101528
union select 'RAJASTHAN','Nagaur (M)',100618
union select 'RAJASTHAN','Banswara (M)',100128
union select 'TAMIL NADU','Chennai (M Corp.)',4681087
union select 'TAMIL NADU','Coimbatore (M Corp.)',1061447
union select 'TAMIL NADU','Madurai (M Corp.)',1016885
union select 'TAMIL NADU','Tiruchirappalli (M Corp.)',846915
union select 'TAMIL NADU','Salem (M Corp.)',831038
union select 'TAMIL NADU','Ambattur (M)',478134
union select 'TAMIL NADU','Tirunelveli (M Corp.)',474838
union select 'TAMIL NADU','Tiruppur (M Corp.)',444543
union select 'TAMIL NADU','Avadi (M)',344701
union select 'TAMIL NADU','Tiruvottiyur (M)',248059
union select 'TAMIL NADU','Thoothukkudi (M Corp.)',237374
union select 'TAMIL NADU','Nagercoil (M)',224329
union select 'TAMIL NADU','Thanjavur (M)',222619
union select 'TAMIL NADU','Pallavaram (M)',216308
union select 'TAMIL NADU','Dindigul (M)',207225
union select 'TAMIL NADU','Vellore (M Corp.)',185895
union select 'TAMIL NADU','Tambaram (M)',176807
union select 'TAMIL NADU','Cuddalore (M)',173361
union select 'TAMIL NADU','Kancheepuram (M)',164265
union select 'TAMIL NADU','Alandur (M)',164162
union select 'TAMIL NADU','Erode (M Corp.)',156953
union select 'TAMIL NADU','Tiruvannamalai (M)',144683
union select 'TAMIL NADU','Kumbakonam (M)',140113
union select 'TAMIL NADU','Rajapalayam (M)',130119
union select 'TAMIL NADU','Kurichi (M)',125800
union select 'TAMIL NADU','Madavaram (M)',118525
union select 'TAMIL NADU','Pudukkottai (M)',117215
union select 'TAMIL NADU','Hosur (M)',116821
union select 'TAMIL NADU','Ambur (M)',113856
union select 'TAMIL NADU','Karaikkudi (M)',106793
union select 'TAMIL NADU','Neyveli (TS) (CT)',105687
union select 'TAMIL NADU','Nagapattinam (M)',102838
union select 'UTTAR PRADESH','Lucknow (M Corp.)',2815601
union select 'UTTAR PRADESH','Kanpur (M Corp.)',2767031
union select 'UTTAR PRADESH','Agra (M Corp.)',1574542
union select 'UTTAR PRADESH','Meerut (M Corp.)',1309023
union select 'UTTAR PRADESH','Varanasi (M Corp.)',1201815
union select 'UTTAR PRADESH','Allahabad (M Corp.)',1117094
union select 'UTTAR PRADESH','Bareilly (M Corp.)',898167
union select 'UTTAR PRADESH','Moradabad (M Corp.)',889810
union select 'UTTAR PRADESH','Aligarh (M Corp.)',872575
union select 'UTTAR PRADESH','Saharanpur (M Corp.)',703345
union select 'UTTAR PRADESH','Gorakhpur (M Corp.)',671048
union select 'UTTAR PRADESH','Noida (CT)',642381
union select 'UTTAR PRADESH','Firozabad (NPP)',603797
union select 'UTTAR PRADESH','Loni (NPP)',512296
union select 'UTTAR PRADESH','Jhansi (M Corp.)',507293
union select 'UTTAR PRADESH','Muzaffarnagar (NPP)',392451
union select 'UTTAR PRADESH','Mathura (NPP)',349336
union select 'UTTAR PRADESH','Shahjahanpur (NPP)',327975
union select 'UTTAR PRADESH','Rampur (NPP)',325248
union select 'UTTAR PRADESH','Maunath Bhanjan (NPP)',279060
union select 'UTTAR PRADESH','Farrukhabad-cum-Fatehgarh (NPP)',275754
union select 'UTTAR PRADESH','Hapur (NPP)',262801
union select 'UTTAR PRADESH','Etawah (NPP)',256790
union select 'UTTAR PRADESH','Mirzapur-cum-Vindhyachal (NPP)',233691
union select 'UTTAR PRADESH','Bulandshahr (NPP)',222826
union select 'UTTAR PRADESH','Sambhal (NPP)',221334
union select 'UTTAR PRADESH','Amroha (NPP)',197135
union select 'UTTAR PRADESH','Fatehpur (NPP)',193801
union select 'UTTAR PRADESH','Rae Bareli (NPP)',191056
union select 'UTTAR PRADESH','Khora (CT)',189410
union select 'UTTAR PRADESH','Orai (NPP)',187185
union select 'UTTAR PRADESH','Bahraich (NPP)',186241
union select 'UTTAR PRADESH','Unnao (NPP)',178681
union select 'UTTAR PRADESH','Sitapur (NPP)',177351
union select 'UTTAR PRADESH','Jaunpur (NPP)',168128
union select 'UTTAR PRADESH','Faizabad (NPP)',167544
union select 'UTTAR PRADESH','Budaun (NPP)',159221
union select 'UTTAR PRADESH','Banda (NPP)',154388
union select 'UTTAR PRADESH','Lakhimpur (NPP)',152010
union select 'UTTAR PRADESH','Hathras (NPP)',137509
union select 'UTTAR PRADESH','Lalitpur (NPP)',133041
union select 'UTTAR PRADESH','Pilibhit (NPP)',130428
union select 'UTTAR PRADESH','Modinagar (NPP)',130161
union select 'UTTAR PRADESH','Deoria (NPP)',129570
union select 'UTTAR PRADESH','Hardoi (NPP)',126890
union select 'UTTAR PRADESH','Etah (NPP)',118632
union select 'UTTAR PRADESH','Mainpuri (NPP)',117327
union select 'UTTAR PRADESH','Basti (NPP)',114651
union select 'UTTAR PRADESH','Gonda (NPP)',114353
union select 'UTTAR PRADESH','Chandausi (NPP)',114254
union select 'UTTAR PRADESH','Akbarpur (NPP)',111594
union select 'UTTAR PRADESH','Khurja (NPP)',111089
union select 'UTTAR PRADESH','Azamgarh (NPP)',110980
union select 'UTTAR PRADESH','Ghazipur (NPP)',110698
union select 'UTTAR PRADESH','Mughalsarai (NPP)',110110
union select 'UTTAR PRADESH','Kanpur (C',108035
union select 'UTTAR PRADESH','Sultanpur (NPP)',107914
union select 'UTTAR PRADESH','Greater Noida (CT)',107676
union select 'UTTAR PRADESH','Shikohabad (NPP)',107300
union select 'UTTAR PRADESH','Shamli (NPP)',107233
union select 'UTTAR PRADESH','Ballia (NPP)',104271
union select 'UTTAR PRADESH','Baraut (NPP)',102733
union select 'UTTAR PRADESH','Kasganj (NPP)',101241
union select 'WEST BENGAL','Kolkata (M Corp.)',4486679
union select 'WEST BENGAL','Haora (M Corp.)',1072161
union select 'WEST BENGAL','Durgapur (M Corp.)',566937
union select 'WEST BENGAL','Asansol (M Corp.)',564491
union select 'WEST BENGAL','Siliguri (M Corp.)',509709
union select 'WEST BENGAL','Maheshtala (M)',449423
union select 'WEST BENGAL','Rajpur Sonarpur (M)',423806
union select 'WEST BENGAL','South Dum Dum (M)',410524
union select 'WEST BENGAL','Rajarhat Gopalpur (M)',404991
union select 'WEST BENGAL','Bhatpara (M)',390467
union select 'WEST BENGAL','Panihati (M)',383522
union select 'WEST BENGAL','Kamarhati (M)',336579
union select 'WEST BENGAL','Barddhaman (M)',314638
union select 'WEST BENGAL','Kulti (M)',313977
union select 'WEST BENGAL','Bally (M)',291972
union select 'WEST BENGAL','Barasat (M)',283443
union select 'WEST BENGAL','North Dum Dum (M)',253625
union select 'WEST BENGAL','Baranagar (M)',248466
union select 'WEST BENGAL','Uluberia (M)',222175
union select 'WEST BENGAL','Naihati (M)',221762
union select 'WEST BENGAL','Bidhan Nagar (M)',218323
union select 'WEST BENGAL','English Bazar (M)',216083
union select 'WEST BENGAL','Kharagpur (M)',206923
union select 'WEST BENGAL','Haldia (M)',200762
union select 'WEST BENGAL','Madhyamgram (M)',198964
union select 'WEST BENGAL','Baharampur (M)',195363
union select 'WEST BENGAL','Raiganj (M)',183682
union select 'WEST BENGAL','Serampore (M)',183339
union select 'WEST BENGAL','Hugli-Chinsurah (M)',177209
union select 'WEST BENGAL','Medinipur (M)',169127
union select 'WEST BENGAL','Chandannagar (M Corp.)',166949
union select 'WEST BENGAL','Uttarpara Kotrung (M)',162386
union select 'WEST BENGAL','Barrackpur (M)',154475
union select 'WEST BENGAL','Krishnanagar (M)',152203
union select 'WEST BENGAL','Santipur (M)',151774
union select 'WEST BENGAL','Balurghat (M)',151183
union select 'WEST BENGAL','Habra (M)',149675
union select 'WEST BENGAL','Jamuria (M)',144971
union select 'WEST BENGAL','Bankura (M)',138036
union select 'WEST BENGAL','North Barrackpur (M)',134825
union select 'WEST BENGAL','Raniganj (M)',128624
union select 'WEST BENGAL','Basirhat (M)',127135
union select 'WEST BENGAL','Halisahar (M)',126893
union select 'WEST BENGAL','Nabadwip (M)',125528
union select 'WEST BENGAL','Rishra (M)',124585
union select 'WEST BENGAL','Ashokenagar Kalyangarh (M)',123906
union select 'WEST BENGAL','Kanchrapara (M)',122181
union select 'WEST BENGAL','Puruliya (M)',121436
union select 'WEST BENGAL','Baidyabati (M)',121081
union select 'WEST BENGAL','Darjiling (M)',120414
union select 'WEST BENGAL','Dabgram (P) (CT)',118464
union select 'WEST BENGAL','Titagarh (M)',118426
union select 'WEST BENGAL','Dum Dum (M)',117637
union select 'WEST BENGAL','Bally (CT)',115715
union select 'WEST BENGAL','Khardaha (M)',111130
union select 'WEST BENGAL','Champdani (M)',110983
union select 'WEST BENGAL','Bongaon (M)',110668
union select 'WEST BENGAL','Jalpaiguri (M)',107351
union select 'WEST BENGAL','Bansberia (M)',103799
union select 'WEST BENGAL','Bhadreswar (M)',101334
union select 'WEST BENGAL','Kalyani (M)',100620


select * from country

with most_populus as(
SELECT *, Rank() over (partition by state order by Population ASC) as ranking
from country)
select * from most_populus where ranking=5

select * from country;
