100 open 2,2,0,chr$(6)
205 print chr$(14); chr$(147)
210 lk=0 : lb=0 : cs=0 : im=0 : pr=0 : kn=0 : k$=""
300 print "Meshterm"
500 get#2,a$ : if a$="" then im=0 : goto 1000
602 if im=0 and a$=chr$(13) then 500
615 gosub 6000 : gosub 5000
622 if a$="" then 500
625 gosub 2100
626 if pr=1 then print chr$(20); chr$(20); : pr=0 : goto 630
627 if im=0 then print chr$(13);
630 print a$; : im=1
640 goto 500
1000 if pr=0 then print chr$(13); "> "; : pr=1
1010 if kn=0 or ti-lk<400 then 1140
1015 if ((peek(667)-peek(668)) and 255)<128 then 1140
1020 print " ***"; chr$(13); : goto 1260
1140 get a$ : if a$<>"" then lk=ti
1142 gosub 4000 : gosub 3000
1144 if a$="" and kn=0 then 500
1145 if a$="" then 1000
1150 if a$=chr$(20) then 1160
1152 if a$=chr$(13) then 1200
1154 print a$; : if a$=chr$(34) then poke 212,0
1155 kn=kn+1 : k$=k$+a$
1157 if kn=200 then 1200
1158 goto 1000
1160 gosub 4500
1170 if kn>1 then print chr$(20); : kn=kn-1 : k$=left$(k$,kn) : goto 1000
1175 if kn=1 then print chr$(20); : kn=0 : k$="" : goto 500
1180 goto 500
1200 gosub 4500
1212 print chr$(13);
1213 if kn=0 then 1260
1215 for i=1 to kn : a$=mid$(k$,i,1) : gosub 2500 : print#2,a$; : next i
1260 kn=0 : k$="" : pr=0 : goto 500
2100 if a$>=chr$(97) and a$<=chr$(122) then a$=chr$(asc(a$)-32) : return
2110 if a$>=chr$(65) and a$<=chr$(90) then a$=chr$(asc(a$)+128) : return
2115 if a$=chr$(13) then return
2120 if a$>=chr$(32) and a$<=chr$(64) then return
2125 if a$>=chr$(91) and a$<=chr$(94) then return
2130 if a$=chr$(95) then a$=chr$(164) : return
2135 a$="?"
2195 return
2500 if a$>=chr$(65) and a$<=chr$(90) then a$=chr$(asc(a$)+32) : return
2510 if a$>=chr$(193) and a$<=chr$(218) then a$=chr$(asc(a$)-128) : return
2515 if a$>=chr$(32) and a$<=chr$(64) then return
2520 if a$>=chr$(91) and a$<=chr$(95) then return
2525 if a$=chr$(164) then a$=chr$(95) : return
2530 a$="?"
2595 return
3000 if a$="" then return
3010 if a$=chr$(20) then return
3020 if a$=chr$(13) then return
3100 if a$<chr$(32) then a$="" : return
3200 if a$>chr$(127) and a$<chr$(160) then a$="" : return
3300 return
4000 if ti-lb<20 then return
4300 lb=ti
4400 if cs=0 then print chr$(18); chr$(160); chr$(146); chr$(157); : cs=1 : return
4500 print chr$(160); chr$(157); : cs=0 : return
5000 if a$=chr$(13) then return
5100 if a$<chr$(32) then a$="" : return
5200 if a$>chr$(126) then a$="" : return
5300 return
6000 b1=asc(a$)
6110 if b1<128 then return
6200 if b1<>226 then 6300
6205 get#2,b2$ : b2=asc(b2$)
6210 get#2,b3$ : b3=asc(b3$)
6215 if b2<>128 then 6295
6220 if b3=147 then a$=chr$(45) : return
6225 if b3=148 then a$=chr$(45) : return
6230 if b3=152 then a$=chr$(39) : return
6235 if b3=153 then a$=chr$(39) : return
6240 if b3=156 then a$=chr$(34) : return
6245 if b3=157 then a$=chr$(34) : return
6250 if b3=162 then a$=chr$(42) : return
6295 goto 6600
6300 if b1<>194 then 6400
6305 get#2,b2$ : b2=asc(b2$)
6310 if b2=160 then a$=chr$(32) : return
6395 goto 6600
6400 if b1<>195 then 6600
6405 get#2,b2$ : b2=asc(b2$)
6600 a$=chr$(63) : return
