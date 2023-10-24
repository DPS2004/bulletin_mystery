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

