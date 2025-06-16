local bd={} --> #ревизия 11.05.2025
bd.d=0 --> bd.d=os.date("!*t")
bd.w, bd.h= display.contentWidth, display.contentHeight
bd.l="RUSSIAN"
bd.pathp="assets/images/"

local tf={} --> #ревизия 11.05.2025
tf.f="assets/font/mf.ttf"
tf.s=16

local t={} --> #ревизия 11.05.2025
t.s=24
t.sx=24
t.sy=4
t.x=0
t.y=bd.h-t.sx
t.d=8
t.i={"railroad1.png", "railroad2.png"}
t.n=math.ceil(bd.w/t.sx/t.d)

local f={} --> #ревизия 11.05.2025
f.q=64*4 --> trtdnt[5]="STARS: "..f.q
f.h={170/255,185/256,194/255,0.4}
f.z={210/255, 125/255, 44/255}
f.s=""

local s={} --> #ревизия 11.05.2025
s.w=false

local trtdnt={} --> #ревизия 11.05.2025
trtdnt[1]=""
trtdnt[2]="HEIGHT: "..display.actualContentHeight
trtdnt[3]="WIDTH: "..display.actualContentWidth
trtdnt[4]=""
trtdnt[5]="STARS: "..f.q
trtdnt[6]="LANGUAGE: "..bd.l
trtdnt.f=""
trtdnt.w=true
trtdnt.m={}

return {
  bd = bd,
  tf = tf,
  t = t,
  f = f,
  s = s,
  trtdnt = trtdnt
}
