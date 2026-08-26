100 open 2,2,0,chr$(6)+chr$(0) : rem 300n81
200 poke 53280,0 : poke 53281,11 : poke 646,1
205 print chr$(14); chr$(147)
207 lk=0 : rem last key pressed time
210 lb=0 : rem cursor last blink time
215 cs=0 : rem cursor state, 0=off, 1=on
220 im=0 : rem input mode, 0=waiting, 1=active
225 pr=0 : rem prompt printed
230 kn=0 : rem keyboard buffer length
235 k$="" : rem keyboard buffer
240 dim c$(5) : rem color codes
240 c$(0)=chr$(153) : rem keyboard input
245 c$(1)=chr$(153) : rem cursor
250 c$(2)=chr$(153) : rem prompt
255 c$(3)=chr$(5) : rem serial input
265 c$(4)=chr$(153) : rem title
270 c$(5)=chr$(150) : rem error
300 print c$(4); "Meshtastic 64"
500 rem serial input
600 get#2,a$ : if a$="" then im=0 : goto 1000
602 if im=0 and a$=chr$(13) then 500 : rem ignore textmsg leading cr
615 gosub 6000 : rem convert utf-8 to ascii
620 gosub 5000 : rem sanitize ascii
622 if a$="" then 500 : rem ignore invalid ascii
625 gosub 2100 : rem convert ascii to petscii
626 if pr=1 then print c$(2); chr$(20); chr$(20); : pr=0 : rem clear prompt
630 print c$(3); a$; : im=1
640 goto 500
1000 rem keyboard input
1005 if pr=0 then print c$(2); chr$(13); "> "; : pr=1 : rem print prompt
1010 if kn=0 or ti-lk<400 then 1140 : rem if no keyboard input and timer not expired, continue
1015 if ((peek(667)-peek(668)) and 255)<128 then 1140 : rem if serial buffer less than half full, continue
1020 print c$(5); " ***"; chr$(13); chr$(13); : goto 1260 : abort keyboard input
1140 get a$ : if a$<>"" then lk=ti
1142 gosub 4000 : rem blink cursor
1143 gosub 3000 : rem sanitize petscii
1144 if a$="" and kn=0 then 500
1145 if a$="" then 1000
1150 if a$=chr$(20) then 1160
1152 if a$=chr$(13) then 1200
1154 print c$(0); a$; : if a$=chr$(34) then poke 212,0 : rem turn off quote mode
1155 kn=kn+1 : k$=k$+a$
1157 if kn=200 then 1200
1158 goto 1000
1160 rem user pressed backspace
1165 gosub 4500 : rem turn off cursor
1170 if kn>1 then print c$(0); chr$(20); : kn=kn-1 : k$=left$(k$,kn) : goto 1000
1175 if kn=1 then print c$(0); chr$(20); : kn=0 : k$="" : goto 500
1180 goto 500 : rem nothing to delete
1200 rem user pressed enter or max length reached
1201 gosub 4500 : rem turn off cursor
1212 print c$(0); chr$(13);
1213 if kn=0 then 1260
1215 for i=1 to kn
1220 a$=mid$(k$,i,1)
1230 gosub 2500 : rem petscii to ascii
1240 print#2,a$;
1250 next i
1260 kn=0 : k$="" : pr=0 : goto 500
2100 rem ascii to petscii
2105 if a$=chr$(13) then return
2150 if a$>=chr$(32) and a$<=chr$(64) then return
2200 if a$>=chr$(65) and a$<=chr$(90) then a$=chr$(asc(a$)+128) : return
2300 if a$>=chr$(97) and a$<=chr$(122) then a$=chr$(asc(a$)-32) : return
2350 a$="?"
2400 return
2500 rem petscii to ascii
2510 if a$>=chr$(32) and a$<=chr$(64) then return
2600 if a$>=chr$(65) and a$<=chr$(90) then a$=chr$(asc(a$)+32) : return
2700 if a$>=chr$(193) and a$<=chr$(218) then a$=chr$(asc(a$)-128) : return
2800 a$="?"
2950 return
3000 rem sanitize petscii
3005 if a$="" then return
3010 if a$=chr$(20) then return
3020 if a$=chr$(13) then return
3100 if a$<chr$(32) then a$="" : return
3200 if a$>chr$(127) and a$<chr$(160) then a$="" : return
3300 return
4000 rem blink cursor
4200 if ti-lb<20 then return
4300 lb=ti
4400 if cs=0 then print c$(1); chr$(18); chr$(160); chr$(146); chr$(157); : cs=1 : return
4500 print c$(1); chr$(160); chr$(157); : cs=0 : return
5000 rem sanitize ascii
5105 if a$=chr$(13) then return
5100 if a$<chr$(32) then a$="" : return
5200 if a$>chr$(126) then a$="" : return
5300 return
6000 rem utf-8 to ascii
6100 b1=asc(a$)
6110 if b1<128 then return
6200 if b1<>226 then 6300
6205 get#2,b2$ : b2=asc(b2$)
6210 get#2,b3$ : b3=asc(b3$)
6215 if b2<>128 then 6295
6220 if b3=147 then a$=chr$(45) : return : rem "-"
6225 if b3=148 then a$=chr$(45) : return
6230 if b3=152 then a$=chr$(39) : return : rem "'"
6235 if b3=153 then a$=chr$(39) : return
6240 if b3=156 then a$=chr$(34) : return : rem double quote
6245 if b3=157 then a$=chr$(34) : return
6250 if b3=162 then a$=chr$(42) : return : rem "*"
6295 goto 6600
6300 if b1<>194 then 6400
6305 get#2,b2$ : b2=asc(b2$)
6310 if b2=160 then a$=chr$(32) : return : rem " "
6395 goto 6600
6400 if b1<>195 then 6600
6405 get#2,b2$ : b2=asc(b2$)
6410 if b2=160 then a$=chr$(97) : return : rem "a"
6411 if b2=161 then a$=chr$(97) : return
6412 if b2=162 then a$=chr$(97) : return
6413 if b2=163 then a$=chr$(97) : return
6414 if b2=164 then a$=chr$(97) : return
6415 if b2=165 then a$=chr$(97) : return
6416 if b2=166 then a$=chr$(97) : return
6417 if b2=167 then a$=chr$(99) : return : rem "c"
6420 if b2=168 then a$=chr$(101) : return : rem "e"
6425 if b2=169 then a$=chr$(101) : return
6430 if b2=170 then a$=chr$(101) : return
6435 if b2=171 then a$=chr$(101) : return
6440 if b2=172 then a$=chr$(105) : return : rem "i"
6445 if b2=173 then a$=chr$(105) : return
6450 if b2=174 then a$=chr$(105) : return
6455 if b2=175 then a$=chr$(105) : return
6466 if b2=177 then a$=chr$(110) : return : rem "n"
6460 if b2=178 then a$=chr$(111) : return : rem "o"
6465 if b2=179 then a$=chr$(111) : return
6470 if b2=180 then a$=chr$(111) : return
6475 if b2=181 then a$=chr$(111) : return
6480 if b2=182 then a$=chr$(111) : return
6481 if b2=183 then a$=chr$(111) : return
6485 if b2=185 then a$=chr$(117) : return : rem "u"
6490 if b2=186 then a$=chr$(117) : return
6495 if b2=187 then a$=chr$(117) : return
6496 if b2=189 then a$=chr$(121) : return : rem "y"
6500 if b2=188 then a$=chr$(117) : return
6501 if b2=191 then a$=chr$(121) : return
6600 a$=chr$(63) : return : rem "?"
