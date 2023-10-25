--bulletin mystery

colors = {}
colors[0] = '1C2A2D'
colors[1] = 'F3EFEE'
colors[2] = '814733'
colors[3] = 'B1735C'

level:setuprooms()
level:reorderrooms(0,3,0,1,2)

mainroom = level.rooms[0]
overlayroom = level.rooms[3]
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

ui.investigate = level:newdecoration('ui_investigate.png',100,mainroom,'ui_investigate')
ui.investigatebg = level:newdecoration('ui_investigatebg.png',101,mainroom,'ui_investigatebg')

ui.combat = level:newdecoration('ui_combat.png',100,mainroom,'ui_combat')
ui.combatbg = level:newdecoration('ui_combatbg.png',102,mainroom,'ui_combatbg')

ui.connectifia = level:newdecoration('connectifia',101,mainroom,'connectifia')

ui.decos = {}

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
	
	if state == 'investigate' then
		self.investigate:show(b)
		self.investigatebg:show(b)
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

for i=0,464,4 do
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

level:offset(32)
mainroom:flash(0,colors[1],100,colors[1],0,1)
ui:setstate(0)

local luciacx = 85
local luciacy = 25
local rowx = 3
local rowy = 25
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


ui:setstate(8,'investigate')
ui:setstate(16,'combat')