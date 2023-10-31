--bulletin mystery

colors = {}
colors[0] = '1C2A2D'
colors[1] = 'F3EFEE'
colors[2] = '814733'
colors[3] = 'B1735C'

level:setuprooms()
level:reorderrooms(0,3,0,2,1)

mainroom = level.rooms[0]
overlayroom = level.rooms[3]
bgroom = level.rooms[2]
logostamproom = level.rooms[1]
faderoom = level.rooms[1]

luciarow = level.rows[0]
row1 = level.rows[1]
row2 = level.rows[2]
row3 = level.rows[3]

introlucia = level:newdecoration('lucia_woh',-100,mainroom,'introlucia')
introlucia:setvisibleatstart(false)

thefunny = level:newdecoration('NOW!.png', 69420, bgroom,'thefunny')
thefunny:setvisibleatstart(false)

row1:setvisibleatstart(false)
row2:setvisibleatstart(false)
row3:setvisibleatstart(false)


--set up ui stuff here
ui = {}
ui.top = level:newdecoration('ui_top.png',-1000,mainroom,'ui_top')
ui.log = level:newdecoration('ui_log.png',100,mainroom,'ui_log')
ui.middle = level:newdecoration('ui_middle.png',100,mainroom,'ui_middle')
ui.middleoneshotcover = level:newdecoration('ui_middleoneshotcover.png',-1000,mainroom,'ui_middleoneshotcover')

ui.town = level:newdecoration('ui_town.png',103,mainroom,'ui_town')
ui.town_solved = level:newdecoration('ui_town_solved.png',102,mainroom,'ui_town_solved')
ui.solvepopup = level:newdecoration('ui_solvepopup.png',100,mainroom,'ui_solvepopup')

ui.townlore1 = level:newdecoration('ui_townlore1.png',101,mainroom,'ui_townlore1')
ui.townlore2 = level:newdecoration('ui_townlore2.png',101,mainroom,'ui_townlore2')
ui.townlore3 = level:newdecoration('ui_townlore3.png',101,mainroom,'ui_townlore3')


ui.rest = level:newdecoration('ui_rest.png',100,mainroom,'ui_rest')

ui.investigate = level:newdecoration('ui_investigate.png',100,mainroom,'ui_investigate')
ui.investigatebg = level:newdecoration('ui_investigatebg.png',102,mainroom,'ui_investigatebg')
ui.lucia_chibi = level:newdecoration('lucia_chibi.png',101,mainroom,'lucia_chibi')

ui.event1 = level:newdecoration('event1.png',100,mainroom,'event1')
ui.event2 = level:newdecoration('event2.png',100,mainroom,'event2')
ui.event3 = level:newdecoration('event3.png',100,mainroom,'event3')

ui.precombat = level:newdecoration('ui_precombat.png',100,mainroom,'ui_precombat')

ui.combat = level:newdecoration('ui_combat.png',101,mainroom,'ui_combat')
ui.combatbg = level:newdecoration('ui_combatbg.png',100,bgroom,'ui_combatbg')
ui.gimmickwarning = level:newdecoration('ui_gimmickwarning.png',100,mainroom,'ui_gimmickwarning')

ui.victory = level:newdecoration('ui_victory.png',101,mainroom,'ui_victory')

ui.connectifia = level:newdecoration('connectifia',102,mainroom,'connectifia')

ui.decos = {}

ui.istownsolved = false
ui.showevent = 1
ui.townlore = 1

function ui:hideall(b)
	for i,v in ipairs(self.decos) do
		v:hide(b)
	end
end

function ui:setstate(b, state,fadespeed)
	self:hideall(b)
	
	self.top:show(b)
	self.log:show(b)
	self.middle:show(b)
	self.middleoneshotcover:show(b)
	
	if state == 'town' then
		self.town:show(b)
		self['townlore'..tostring(self.townlore)]:show(b)
		if self.istownsolved then
			self.town_solved:show(b)
			self.solvepopup:show(b)
		end
	end
	
	if state == 'rest' then
		self.rest:show(b)
	end
	
	if state == 'investigate' then
		self.investigate:show(b)
		self.investigatebg:show(b)
		self.lucia_chibi:show(b)
		self.lucia_chibi:move(b,{x=PX((200)/2),y=100-PY((140)/2),px=0,py=100})
		self.lucia_chibi:move(b,{x=PX((310)/2)},8)
		for i=0,6,2 do
			self.lucia_chibi:move(b+i+0,{y=100-PY((138)/2)},0.5,'outSine')
			self.lucia_chibi:move(b+i+0.5,{y=100-PY((140)/2)},0.5,'inSine')
			self.lucia_chibi:move(b+i+1,{y=100-PY((142)/2)},0.5,'outSine')
			self.lucia_chibi:move(b+i+1.5,{y=100-PY((140)/2)},0.5,'inSine')
		end
	end
	
	if state == 'event' then
		self['event'..tostring(self.showevent)]:show(b)
	end
	
	if state == 'precombat' then
		self.precombat:show(b)
	end
	
	if state == 'combat' then
		self.combat:show(b)
		self.combatbg:show(b)
		local connx = 0
		local conny = 21
		self.connectifia:move(b,{x=PX((18 + connx)/2),y=100-PY((20 + conny)/2),px=0,py=100})
		self.connectifia:show(b)
	end
	
	if state == 'victory' then
		self.victory:show(b)
		self.combatbg:show(b)
		local connx = 0
		local conny = 21
		self.connectifia:move(b,{x=PX((18 + connx)/2),y=100-PY((20 + conny)/2),px=0,py=100})
		self.connectifia:show(b)
	end
	
	fadespeed = fadespeed or 1/24
	if fadespeed ~= 0 then
		fade:fadein(b,fadespeed)
	end
	

end

for i=152,452,4 do
	ui.connectifia:playexpression(i,'0')
	ui.connectifia:playexpression(i+2,'1')
end



for k,v in pairs(ui) do
	if type(v) == 'table' and v.objecttype == 'decoration' then
		v:move(0,{sx=0.5,sy=0.5})
		v:setvisibleatstart(false)
		table.insert(ui.decos,v)
	end
end

--fade stuff

fade = {}
fade.fullfade = level:newdecoration('fullfade',1, faderoom, 'fullfade')
fade.fader = level:newdecoration('fader.png',0,faderoom,'fader')
fade.fader:setvisibleatstart(false)
fade.fullfade:move(0,{x=PX(18)/2,y=100-(PY(40)/2),sx=0.5,sy=0.5,px=0,py=100})

function fade:fadein(b,faderspeed)
	self.fullfade:playexpression(b,'fadein')
	if faderspeed then
		for i=0,36 do
			self.fader:show(b)
			self.fader:move(b+i*faderspeed,{x=PX(18)/2,y=100-(PY(40+i*8)/2),sx=0.5,sy=0.5,px=0,py=100})
		end
	end
end

function fade:fadeout(b)
	self.fullfade:playexpression(b,'fadeout')
end

--lucia handler
lucia = {}
lucia.luciacx = PX(306.5)
lucia.luciacy = PY(70)
lucia.baserowx = 3
lucia.baserowy = 23
lucia.rowscale = 0.666
lucia.luciascale = 0.5

lucia.x = 0
lucia.y = 0
lucia.sx = 1
lucia.sy = 1


function lucia:move(b,p,d,e)
	self.x = p.x or self.x
	self.y = p.y or self.y
	self.sx = p.sx or self.sx
	self.sy = p.sy or self.sy
	

	luciarow:move(b,{
		x=self.baserowx + self.x,
		y=self.baserowy + self.y,
		cx=(self.luciacx-self.x-self.baserowx)*(1/(self.rowscale * self.sx)),
		cy=(self.luciacy-self.y-self.baserowy)*(1/(self.rowscale * self.sy)),
		pivot=0,
		sx= self.rowscale * self.sx,
		sy =self.rowscale * self.sy,
		csx = (self.luciascale/(self.rowscale * self.sx)),
		csy = (self.luciascale/(self.rowscale * self.sy))
	},d,e)
end

--slow zoom in
overlaydeco = level:newdecoration('overlay.png', 0, overlayroom, 'overlay')

mainroom:move(0,{sx=200/3,sy=200/3})
logostamproom:move(0,{sx=200/3,sy=200/3})
overlaydeco:move(0,{sx=1/3,sy=1/3})

mainroom:move(0.001,{sx=100,sy=100},32,'outSine')
logostamproom:move(0.001,{sx=100,sy=100},32,'outSine')
overlaydeco:move(0.001,{sx=1/2,sy=1/2},32,'outSine')

--logostamp

logotext = level:newdecoration('logotext', 0, logostamproom, 'logotext')
logotext:setvisibleatstart(false)
logotext:settint(0,true,colors[1],100)

luciarow:settint(0,true,colors[0],100)
luciarow:showrow(0)
introlucia:move(0,{x=10,y=50})
introlucia:show(0.001)
introlucia:settint(0,true,colors[0],100)

logostamproom:hom(0,true)
logostamproom:flash(0,colors[0],100,colors[0],100,0,'Linear',true)
logotext:show(0.001)
logostamproom:flash(0.001,colors[0],0,colors[0],0,0,'Linear',true)


function stamptext(b)
	logotext:move(b,{x=math.random(10,90),y=math.random(15,85)})
	logotext:playexpression(b,tostring(math.random(0,9)))
end

math.randomseed(7)
for i=0,3 do
	local b = i * 8
	stamptext(b+0.00)
	
	stamptext(b+0.75)
	stamptext(b+1.00)
	
	stamptext(b+1.75)
	stamptext(b+2.00)
	
	stamptext(b+2.75)
	stamptext(b+3.00)
	introlucia:playexpression(b+3,'happy')
	introlucia:playexpression(b+4,'neutral')
	
	stamptext(b+3.75)
	stamptext(b+4.00)
	
	stamptext(b+4.50)
	stamptext(b+4.75)
	
	stamptext(b+5.25)
	stamptext(b+5.50)
	
	stamptext(b+6.00)
	stamptext(b+6.25)
	introlucia:playexpression(b+6.25,'happy')
	introlucia:playexpression(b+7,'neutral')
	
	stamptext(b+6.75)
	stamptext(b+7.00)
	
	stamptext(b+7.50)
	stamptext(b+7.75)

end

--row2:classyinit(false)
--row2:showclassy(29)

row2:move(0,{x=3,y=-10,sx=0.666,sy=0.666,pivot = 0})

row2:show(29)

row2:settint(0,true,colors[1])
row2:move(29,{y=11},2,'outExpo')

level:offset(32)
--get rid of logostamp stuff
level:reorderrooms(0,3,1,0,2)
faderoom:hom(0,false)
logotext:hide(0)
faderoom:mask(0,'fademask.png')

mainroom:flash(0,colors[1],100,colors[1],0,1)
--move lucia into place
introlucia:hide(0)
lucia:move(0,{})
luciarow:settint(0,true,'000000',0)
luciarow:setborder(0,'Outline', colors[0],100)
luciarow:show(0)
--end lucia setuprooms

--oneshot setup
row3:move(0,{x=PX(529)/2,y=100-PY(120)/2,pivot=0,sx=0.25,sy=0.25})
row3:settint(0,true,colors[0])
row3:setborder(0,'Outline', colors[0],100)
row3:show(32)
--end oneshot setup


--ui changes

--town 1
--rest
--town
--investigate
--town 2
--rest
--town popup
--investigate
--town 3
--investigate
--combat

ui.townlore = 1
ui:setstate(0,'town',0)

ui:setstate(16,'rest')

ui:setstate(24,'town')

ui:setstate(32,'investigate',0)

ui.showevent = 3
ui:setstate(40,'event')

ui.townlore = 2
ui:setstate(48,'town')

ui:setstate(56,'rest')

ui.istownsolved = true
ui:setstate(64,'town')
ui.solvepopup:hide(72)

ui:setstate(80,'investigate',0)

ui.showevent = 1
ui:setstate(88,'event')
ui.showevent = 2
ui:setstate(96,'event')

ui.istownsolved = false
ui.townlore = 3
ui:setstate(104,'town')

ui:setstate(112,'investigate',0)
ui:setstate(120,'precombat',1/12)

--combat!

level:offset(168)

row1:move(-1,{x=lucia.baserowx,y=lucia.baserowy,pivot=0,sx=lucia.rowscale,sy=lucia.rowscale})

bgroom:screenwaves(0,true,50)
ui:setstate(0,'combat',0)
fade:fadein(0)


local doublerowoffset = 10/3

lucia:move(0,{y=doublerowoffset*-1},4,'outExpo')

row1:show(0)
row1:move(0,{
	y=lucia.baserowy+doublerowoffset
},4,'outExpo')

lucia.baserowy = lucia.baserowy + doublerowoffset
lucia:move(60,{y=0},4,'inExpo')
row1:move(60,{
	y=lucia.baserowy
},4,'inExpo')
row1:hide(64)



for i=0,7 do
	local b = i*16 + 64
	local mul = 1
	if i%2==1 then
		mul = -1
	end
	
	lucia:move(b+0,{y=-5*mul},1,'outExpo')
	lucia:move(b+1,{y=0},1,'inExpo')
	lucia:move(b+2,{y=-10*mul},1,'outExpo')
	lucia:move(b+3,{y=0},1,'inExpo')
	lucia:move(b+4,{y=5*mul},1,'outExpo')
	lucia:move(b+5,{y=0},1,'inExpo')
	lucia:move(b+6,{y=10*mul},0.75,'outExpo')
	lucia:move(b+6.75,{y=0},0.75,'inExpo')
end

--glitch

--192
glitch = {}
glitch.groups = {}
glitch.activegroups = 0
math.randomseed(0)

function glitch:newgroup()
	local group = {}
	for i=0,8 do
		local newdeco = level:newdecoration('glitch',-1001,mainroom)
		newdeco:setvisibleatstart(false)
		newdeco:move(191,{x=PX(math.random(8,352-8)),y=PY(math.random(8,198-8)),sx=0.5,sy=0.5})
		group[i] = newdeco
	end
	table.insert(self.groups,group)
end

glitchoffsets = 
{
	{{-1,1},{0,1},{1,1},
	{-1,0},{0,0},{1,0},
	{-1,-1},{0,-1},{1,-1}},	
	
	{{-1,1},{0,1},{1,1},
	{-1,0},{0,0},{1,0},
	{-1,-1},{0,-1},{1,-1}},
	
	{{-2,1},{-1,1},{0,1},
	{-1,0},{0,0},{1,0},
	{0,-1},{1,-1},{2,-1}},
	
	{{0,1},{1,1},{2,1},
	{-1,0},{0,0},{1,0},
	{-2,-1},{-1,-1},{0,-1}}
}

function glitch:moveall(b)
	for	group_i=1,self.activegroups do
		group = self.groups[group_i]
		local x = PX(math.random(32,352-32))
		local y = PY(math.random(32,198-32))
		local offset = glitchoffsets[math.random(1,4)]
		
		for i=0,8 do
			group[i]:move(b,{x = x+PX(offset[i+1][1]*8), y=y+PY(offset[i+1][2]*8)},2,'outExpo')
		end
	end
end

function glitch:showgroup(b,g)
	self.activegroups = self.activegroups + 1
	for i=0,8 do
		self.groups[g][i]:show(b)
	end
end



movebeats = {2,5,
8.5,12,15,
18.5,21.5,
25,28,31.5,
34.5,38,
41,44.5,47}

glitch:newgroup()
glitch:showgroup(192,#glitch.groups)
glitch:moveall(192)
for r=0,1 do

	for i,v in ipairs(movebeats) do
		local b = 192+48*r+v
		if(i%3==0) then
			glitch:newgroup()
			glitch:showgroup(b,#glitch.groups)
		end
		glitch:moveall(b)
	end
end



--animate glitches 

for group_i,group in ipairs(glitch.groups) do
	for i=0,8 do
		for b=0,192 do
			local finalbeat = (b/2)+192
			if getvalue(group[i],'visible',finalbeat + 0) then
				group[i]:playexpression(finalbeat,tostring(math.random(0,127)))
			end
		end
		group[i]:hide(288)
	end
end

ui.gimmickwarning:show(188)


ui:setstate(288,'victory',0)
bgroom:screenwaves(288,false)
luciarow:showchar(288)
row2:hide(288)
row3:hide(288)

mainroom:move(288,{sx=200/3,sy=200/3},16,'inOutSine')
bgroom:move(288,{sx=200/3,sy=200/3},16,'inOutSine')
overlaydeco:move(288,{sx=1/3,sy=1/3},16,'inOutSine')

mainroom:setfg(304,'endfade0.png')
mainroom:setfg(305,'endfade1.png')
mainroom:setfg(306,'endfade2.png')
mainroom:setfg(307,'endfade3.png')
mainroom:setfg(308,'endfade4.png')
mainroom:setfg(309,'endfade5.png')