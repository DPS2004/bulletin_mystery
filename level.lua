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

luciarow = level.rows[0]
row1 = level.rows[1]
row2 = level.rows[2]
row3 = level.rows[3]

row1:setvisibleatstart(false)
row2:setvisibleatstart(false)
row3:setvisibleatstart(false)


--set up ui stuff here
ui = {}
ui.top = level:newdecoration('ui_top.png',-1000,mainroom,'ui_top')
ui.log = level:newdecoration('ui_log.png',100,mainroom,'ui_log')
ui.middle = level:newdecoration('ui_middle.png',100,mainroom,'ui_middle')
ui.middleoneshotcover = level:newdecoration('ui_middleoneshotcover.png',-1000,mainroom,'ui_middleoneshotcover')

ui.town = level:newdecoration('ui_town.png',102,mainroom,'ui_town')
ui.town_solved = level:newdecoration('ui_town_solved.png',101,mainroom,'ui_town_solved')
ui.solvepopup = level:newdecoration('ui_solvepopup.png',100,mainroom,'ui_solvepopup')

ui.rest = level:newdecoration('ui_rest.png',100,mainroom,'ui_rest')

ui.investigate = level:newdecoration('ui_investigate.png',100,mainroom,'ui_investigate')
ui.investigatebg = level:newdecoration('ui_investigatebg.png',102,mainroom,'ui_investigatebg')
ui.lucia_chibi = level:newdecoration('lucia_chibi.png',101,mainroom,'lucia_chibi')

ui.event1 = level:newdecoration('event1.png',100,mainroom,'event1')
ui.event2 = level:newdecoration('event2.png',100,mainroom,'event2')
ui.event3 = level:newdecoration('event3.png',100,mainroom,'event3')

ui.precombat = level:newdecoration('ui_precombat.png',100,mainroom,'ui_precombat')

ui.combat = level:newdecoration('ui_combat.png',100,mainroom,'ui_combat')
ui.combatbg = level:newdecoration('ui_combatbg.png',100,bgroom,'ui_combatbg')

ui.connectifia = level:newdecoration('connectifia',101,mainroom,'connectifia')

ui.decos = {}

ui.istownsolved = false
ui.showevent = 1

function ui:hideall(b)
	for i,v in ipairs(self.decos) do
		v:hide(b)
	end
end

function ui:setstate(b, state)
	self:hideall(b)
	
	self.top:show(b)
	self.log:show(b)
	self.middle:show(b)
	self.middleoneshotcover:show(b)
	
	if state == 'town' then
		self.town:show(b)
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
	

end

for i=152,464,4 do
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
	
	stamptext(b+3.75)
	stamptext(b+4.00)
	
	stamptext(b+4.50)
	stamptext(b+4.75)
	
	stamptext(b+5.25)
	stamptext(b+5.50)
	
	stamptext(b+6.00)
	stamptext(b+6.25)
	
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
row2:move(29,{y=10},2,'outExpo')

level:offset(32)
mainroom:flash(0,colors[1],100,colors[1],0,1)
--move lucia into place
local luciacx = 85
local luciacy = 25
local rowx = 3
local rowy = 20
local rowscale = 0.666
local luciascale = 1

local scaleinverse = luciascale/rowscale
luciarow:move(0,{
	x=rowx,
	y=rowy,
	cx=(luciacx-rowx)*scaleinverse,
	cy=(luciacy-rowy)*scaleinverse,
	pivot=0,
	sx=rowscale,
	sy =rowscale,
	csx = scaleinverse,
	csy = scaleinverse
})
luciarow:settint(0,true,'000000',0)
luciarow:setborder(0,'Outline', colors[0],100)
--end lucia setuprooms

--oneshot setup
row3:move(0,{x=PX(529)/2,y=100-PY(120)/2,pivot=0,sx=0.25,sy=0.5})
row3:settint(0,true,colors[0])
row3:setborder(0,'Outline', colors[0],100)
row3:show(32)
--end oneshot setup


--ui changes
ui:setstate(0,'town')
ui:setstate(16,'investigate')
ui.showevent = 3
ui:setstate(24,'event')
ui:setstate(32,'town')
ui:setstate(40,'rest')
ui:setstate(48,'town')
ui:setstate(56,'investigate')
ui.showevent = 1
ui:setstate(64,'event')
ui.showevent = 2
ui:setstate(72,'event')
ui:setstate(80,'town')
ui:setstate(88,'rest')
ui.istownsolved = true
ui:setstate(96,'town')
ui.solvepopup:hide(100)
ui:setstate(112,'investigate')
ui:setstate(120,'precombat')

--combat!

level:offset(168)

row1:move(-1,{x=rowx,y=rowy,pivot=0,sx=rowscale,sy=rowscale})

bgroom:screenwaves(0,true,50)
ui:setstate(0,'combat')


local doublerowoffset = 10/3
luciarow:move(0,{
	x=rowx,
	y=rowy-doublerowoffset,
	cx=(luciacx-rowx)*scaleinverse,
	cy=(luciacy-(rowy-doublerowoffset))*scaleinverse,
	pivot=0,
	sx=rowscale,
	sy =rowscale,
	csx = scaleinverse,
	csy = scaleinverse
},4,'outExpo')
row1:show(0)
row1:move(0,{
	y=rowy+doublerowoffset
},4,'outExpo')

luciarow:move(60,{
	x=rowx,
	y=rowy,
	cx=(luciacx-rowx)*scaleinverse,
	cy=(luciacy-(rowy-doublerowoffset))*scaleinverse,
	pivot=0,
	sx=rowscale,
	sy =rowscale,
	csx = scaleinverse,
	csy = scaleinverse
},4,'inExpo')
row1:move(60,{
	y=rowy
},4,'inExpo')
row1:hide(64)
