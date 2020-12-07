pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- juego_1
-- by rogelio y carlos
function _init()
-- posicion inicial de jugador
player_x   = 64
player_y   = 110 -- este valor va a ser fijo y no se verれく afectado por movimiento
debug_mode = true
score      = 0
map_y      = 0
map_speed  = 1
enemies = {}

for i = 0,1 do 
	add_new_enemy()
end

end

function _update60()
 -- map stuff, put
 -- todo: put it in a function
 map_y -= map_speed
 if map_y <- 127 then map_y = 0 end

 -- !map stuff
 player:update()

 for enemy in all(enemies) do
  enemy:update()
 end

end


function _draw()
 cls()
 map(0,0,0,-map_y, 16, 17)
 map(0,0,0,-map_y-128, 16, 17)
 if debug_mode then show_debug() end
 -- game board stuff
 rect(0,0,127,127,1)
 
 -- game pieces stuff
 player:draw()
 
 for enemy in all(enemies) do
  enemy:draw()
 end
 
 -- score stuff
 print("score: ", 3,3,7)
 print(score, 30,3,8)

end

-->8
-- game objects
function add_new_enemy()
	add(enemies, {
 	sprite = {46,62} ,
		xpos   = flr(rnd(70) +22),
		ypos   = flr(rnd(100) - 100),
 	speed  = 3,	
 	--speed  = flr(rnd(3) + 2),	
 	
 	update = function(self)
 		self.ypos += self.speed
	 	
	 	if is_colision() then
	 		self.ypos  = -35
				self.xpos  = flr(rnd(70) +22)
				self.speed = flr(rnd(5) + 2) 
   	-- lose 1 heart
	  	score -=1
   	del(enemies,self)
   	add_new_enemy()
	 	end
	 
	 	if self.ypos >= 120 then
	  	score +=1
	 		self.ypos  = -35
				self.xpos  = flr(rnd(70) +22)
				self.speed = flr(rnd(5) + 2) 
				--self.speed = 3
   	del(enemies,self)
   	add_new_enemy()
	 	end	 
 	end,
 
 	draw = function(self)
			spr(self.sprite[1],self.xpos,self.ypos)
			spr(self.sprite[1] +1 ,self.xpos +8 ,self.ypos)
			spr(self.sprite[2],self.xpos,self.ypos + 8)
			spr(self.sprite[2] +1 ,self.xpos + 8 ,self.ypos+8)
 	end
})
end

-- player car object

player = {
 sprite = {9,0,14,16}, -- sprite corner x, corner y, width, height
 xpos = 64,  --initial xpos
 ypos = 110, --static ypos
 --colision = false, --currently unused
 
 update = function(self)
 -- player movement on x axis
    is_colision()    
    if btn(➡️) and self.xpos<112 then
        self.xpos+=2        
    end
    if btn(⬅️) and self.xpos>3 then
        self.xpos-=2
    end
 end,

 draw = function(self)
  if btn(➡️) then
  sspr(self.sprite[1]+16,
       self.sprite[2],
       self.sprite[3],
       self.sprite[4],
       self.xpos,self.ypos)
  elseif btn(⬅️) then
  sspr(self.sprite[1]+32,
       self.sprite[2],
       self.sprite[3],
       self.sprite[4],
       self.xpos,self.ypos)
  else
  sspr(self.sprite[1],
       self.sprite[2],
       self.sprite[3],
       self.sprite[4],
       self.xpos,self.ypos)
  end
 end
}

-->8
-- helper functions ♥♥

function is_colision()
-- returns bool

 for enemy in all(enemies) do
		if enemy.ypos > 102
 and enemy.ypos < 134
	and (enemy.xpos-8)<=player.xpos
 and player.xpos<=(enemy.xpos+8)
 then
  return true
 else
  return false
	end
 return false
 end
end

function show_debug()
	--prints debug information

	print("player x: ",10,10,0)
	print(player.xpos,50,10,0)
	
	if count(enemies) > 1 then
	print("enemy  y: ",10,18,0)
	print(enemies[1].ypos,50,18,0)

	print("enemy speed: ",10,26,0)
	print(enemies[1].speed,60,26,0)
end
 -- is colliding?
	print(is_colision(),100,120,0)

end
__gfx__
0000000000008778877800000000877887780000000087788778000033333333bbbbbbb77bbbbbbb7bbbbbbbbbbbbbb7bbbbbbb700000000000000000000d77d
0000000000088888888880000008888888888000000888888888800033333333bbbbbbb77bbbbbbb7bbbbbbbbbbbbbb7bbbb3bb70000000000000000000ddddd
0070070005588888888885500058888888888550055888888888850033333333bbbbbbb77bbbbbbb7bbbbbbbbbbbbbb7bbbbbbb70000000000000000055ddddd
0007700005588888888885500558888888888550055888888888855033333333bbbbbbb77bbbbbbb7bbbbbbbbbbb3bb7bb5bbbb70000000000000000055ddddd
0007700005888555655888500588855655688850058885555658885033333333bbbbbbb77bbbbbbb7bbbbbbbbbbbbbb7bbbbb3b7000000000000000005ddd555
0070070005585556556585500558556556558500005855556556855033333333bbbbbbb77bbbbbbb7bbbbbbbbbbbbbb7bbbbbbb70000000000000000055d5556
0000000000085565565580000008565565558000000855565565800033333333bbbbbbb77bbbbbbb7bbbbbbbb3bbbbb7b3bbbbb70000000000000000000d5565
0000000000088888888880000008888888888000000888888888800033333333bbbbbbb77bbbbbbb7bbbbbbbbbbbbbb7bbbbbbb70000000000000000000ddddd
00000000000888888888800000088888888880000008888888888000bbbbbbbb333333377333333373333333333333377bbbbbbb000000000000000000000000
00000000000888888888800000088888888880000008888888888000bbbbbbbb3333333773333333733333333b3333377bbbbbbb000000000000000000000000
00000000000888888888800000088888888880000008888888888000bbbbbbbb333333377333333373333b33333333377b3bbbbb000000000000000000000000
00000000055888888888855005588888888885500558888888888550bbbbbbbb333333377333333373b33333333333377bbb3bbb000000000000000000000000
00000000055888888888855005588888888885500558888888888550bbbbbbbb33333337733333337333333333333b377bbbbbbb000000000000000000000000
00000000055888888888855005588888888885500558888888888550bbbbbbbb333333377333333373333b33333333377bbbbbbb000000000000000000000000
00000000055888888888855005588888888885500558888888888550bbbbbbbb333333377333333373333333333333377bbbb8bb000000000000000000000000
00000000000089888898000000008988889800000000898888980000bbbbbbbb333333377333333373333333333633377bbbdbbb000000000000000000000000
000000000000000000000000000000000000000000000000000000006666666600000000bbbbbbbb000000003333333700000000000000000000d77dd77d0000
000000000000000000000000000000000000000000000000000000006666666600000000bbb3bbbb000000003b3333370000000000000000000dddddddddd000
000000000000000000000000000000000000000000000000000000006666666600000000bbbbb3bb00000000333333370000000000000000055dddddddddd550
000000000000000000000000000000000000000000000000000000006666666600000000bbbbbbbb0000000033b333370000000000000000055dddddddddd550
000000000000000000000000000000000000000000000000000000006666666600000000bb3bbbbb0000000033333837000000000000000005ddd555655ddd50
000000000000000000000000000000000000000000000000000000006666666600000000bbbbbbbb0000000033b333370000000000000000055d55565565d550
000000000000000000000000000000000000000000000000000000006666666600000000bbbbb3bb00000000333333370000000000000000000d55655655d000
000000000000000000000000000000000000000000000000000000006666666600000000bbbbbbbb00000000333633370000000000000000000dddddddddd000
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbb3333333333333333333333330000000000000000000dddddddddd000
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbb3333333333333333333333330000000000000000000dddddddddd000
00000000000000000000000000000000000000000000000000000000bbbbbb3bbbbbb3bb33b3d3d3333b333333b333330000000000000000000dddddddddd000
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbb33333d3333333333333333b30000000000000000055dddddddddd550
00000000000000000000000000000000000000000000000000000000bb3bbbbbbb3bbbbb33333333333333b3333333330000000000000000055dddddddddd550
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbb333333b333b333b333333b3330000000000000000055dddddddddd550
00000000000000000000000000000000000000000000000000000000bbbb6bbbbb3bbbbb3d3333333333333333333b330000000000000000055dddddddddd550
00000000000000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbb33333333333333333333333300000000000000000000d9dddd9d0000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888eeeeee888777777888888888888888888888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88ee88eee88778887788888888888888888888888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee8eeee8eee87777787788888e88888888888888888888888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8eeee8eee8777888778888eee8888888888888888888888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee8eeee8eee87778777788888e88888888888888888888888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee8eee888ee877788877888888888888888888888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee8eeeeeeee877777777888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
111111111111111111111e1e1e1111e11e1e1e1e1e1e11111c111c1c1c111c111c11111111111111111111111111111111111111111111111111111111111111
111111111111111111111ee11ee111e11e1e1ee11e1e11111cc11ccc1c111ccc1cc1111111111111111111111111111111111111111111111111111111111111
111111111111111111111e1e1e1111e11e1e1e1e1e1e11111c111c1c1c11111c1c11111111111111111111111111111111111111111111111111111111111111
111111111111111111111e1e1eee11e111ee1e1e1e1e11111c111c1c1ccc1cc11ccc111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1ee11ee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e111e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111ee11e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111e111e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1e1e1eee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1ee11ee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1ee11e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1e1e1eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1e1e1ee111ee1eee1eee11ee1ee1111111661616116616161111166116661666161611661171117111111111111111111111111111111111111111111111
1e111e1e1e1e1e1111e111e11e1e1e1e111116111616161616161111161616111616161616111711111711111111111111111111111111111111111111111111
1ee11e1e1e1e1e1111e111e11e1e1e1e111116661666161616161111161616611661161616111711111711111111111111111111111111111111111111111111
1e111e1e1e1e1e1111e111e11e1e1e1e111111161616161616661111161616111616161616161711111711111111111111111111111111111111111111111111
1e1111ee1e1e11ee11e11eee1ee11e1e111116611616166116661666166616661666116616661171117111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111ddd1ddd1ddd1dd11ddd11dd11111dd11ddd1ddd1d1d11dd11111ddd1dd11ddd11dd1ddd1ddd1ddd1ddd1ddd11dd1dd111111111111111111111
1111111111111d1d1d1d11d11d1d11d11d1111111d1d1d111d1d1d1d1d11111111d11d1d1d111d1d1d1d1ddd1d1d11d111d11d1d1d1d11111111111111111111
11111ddd1ddd1ddd1dd111d11d1d11d11ddd11111d1d1dd11dd11d1d1d11111111d11d1d1dd11d1d1dd11d1d1ddd11d111d11d1d1d1d11111111111111111111
1111111111111d111d1d11d11d1d11d1111d11111d1d1d111d1d1d1d1d1d111111d11d1d1d111d1d1d1d1d1d1d1d11d111d11d1d1d1d11111111111111111111
1111111111111d111d1d1ddd1d1d11d11dd111111ddd1ddd1ddd11dd1ddd11111ddd1d1d1d111dd11d1d1d1d1d1d11d11ddd1dd11d1d11111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111bbb1bbb1bbb1bb11bbb11711c1c1ccc1c111ccc1c1c1ccc1ccc11111c1c111111111c1c11111cc11ccc11111cc11ccc11111ccc11711111111111111111
11111b1b1b1b11b11b1b11b117111c1c1c1c1c111c1c1c1c1c111c1c11111c1c11c111111c1c111111c11c1c111111c11c1c1111111c11171111111111111111
11111bbb1bb111b11b1b11b1171111111ccc1c111ccc1ccc1cc11cc1111111c1111111111111111111c11c1c111111c11c1c111111cc11171111111111111111
11111b111b1b11b11b1b11b1171111111c111c111c1c111c1c111c1c11111c1c11c111111111117111c11c1c117111c11c1c1171111c11171111111111111111
11111b111b1b1bbb1b1b11b1117111111c111ccc1c1c1ccc1ccc1c1c11111c1c11111111111117111ccc1ccc17111ccc1ccc17111ccc11711111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111bbb1bbb1bbb1bb11bbb11711666161116661616166616661111161611111ccc1ccc11111cc11ccc11111ccc117111111111111111111111111111111111
11111b1b1b1b11b11b1b11b117111616161116161616161116161111161611111c111c1c111111c11c1c1111111c111711111111111111111111111111111111
11111bbb1bb111b11b1b11b117111666161116661666166116611111116111111ccc1c1c111111c11c1c111111cc111711111111111111111111111111111111
11111b111b1b11b11b1b11b11711161116111616111616111616111116161171111c1c1c117111c11c1c1171111c111711111111111111111111111111111111
11111b111b1b1bbb1b1b11b111711611166616161666166616161666161617111ccc1ccc17111ccc1ccc17111ccc117111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111bbb1bbb1bbb1bb11bbb11711c1c1ccc1cc11ccc1ccc1c1c11111c1c11111ccc11cc11cc111111111c1c11111cc11ccc11111cc11ccc11111ccc11711111
11111b1b1b1b11b11b1b11b117111c1c1c111c1c1c111ccc1c1c11111c1c11111c1c1c1c1c1111c111111c1c111111c11c1c111111c11c1c1111111c11171111
11111bbb1bb111b11b1b11b1171111111cc11c1c1cc11c1c1ccc11111ccc11111ccc1c1c1ccc111111111111111111c11c1c111111c11ccc111111cc11171111
11111b111b1b11b11b1b11b1171111111c111c1c1c111c1c111c1111111c11111c111c1c111c11c111111111117111c11c1c117111c11c1c1171111c11171111
11111b111b1b1bbb1b1b11b1117111111ccc1c1c1ccc1c1c1ccc11111ccc11111c111cc11cc111111111111117111ccc1ccc17111ccc1ccc17111ccc11711111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111bbb1bbb1bbb1bb11bbb1171166616611666166616161111161616661166116611111c111ccc11111cc11ccc11111ccc1171111111111111111111111111
11111b1b1b1b11b11b1b11b11711161116161611166616161111161616161616161111111c111c1c111111c11c1c1111111c1117111111111111111111111111
11111bbb1bb111b11b1b11b11711166116161661161616661111166616661616166611111ccc1c1c111111c11ccc111111cc1117111111111111111111111111
11111b111b1b11b11b1b11b11711161116161611161611161111111616111616111611711c1c1c1c117111c11c1c1171111c1117111111111111111111111111
11111b111b1b1bbb1b1b11b11171166616161666161616661171166616111661166117111ccc1ccc17111ccc1ccc17111ccc1171111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111118888811111111111111111111111
11111bbb1bbb1bbb1bb11bbb11711c1c1ccc1cc11ccc1ccc1c1c111111cc1ccc1ccc1ccc1cc111111c1c11111cc11ccc111188888ccc11711111111111111111
11111b1b1b1b11b11b1b11b117111c1c1c111c1c1c111ccc1c1c11111c111c1c1c111c111c1c11111c1c111111c11c1c11118888811c11171111111111111111
11111bbb1bb111b11b1b11b1171111111cc11c1c1cc11c1c1ccc11111ccc1ccc1cc11cc11c1c11111111111111c11c1c1111888881cc11171111111111111111
11111b111b1b11b11b1b11b1171111111c111c1c1c111c1c111c1111111c1c111c111c111c1c11111111117111c11c1c11718878811c11171111111111111111
11111b111b1b1bbb1b1b11b1117111111ccc1c1c1ccc1c1c1ccc11111cc11c111ccc1ccc1ccc1111111117111ccc1ccc171187888ccc11711111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111bbb1bbb1bbb1bb11bbb11711666166116661666161611111166166616661666166111111ccc1c1111111ccc1ccc11111ccc117111111111111111111111
11111b1b1b1b11b11b1b11b117111611161616111666161611111611161616111611161611111c111c111111111c111c1111111c111711111111111111111111
11111bbb1bb111b11b1b11b117111661161616611616166611111666166616611661161611111ccc1ccc11111ccc11cc111111cc111711111111111111111111
11111b111b1b11b11b1b11b11711161116161611161611161111111616111611161116161171111c1c1c11711c11111c1171111c111711111111111111111111
11111b111b1b1bbb1b1b11b111711666161616661616166611711661161116661666166617111ccc1ccc17111ccc1ccc17111ccc117111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111bbb1bbb1bbb1bb11bbb1171166611661111116611661611166611661666116616611171117111111cc11ccc1ccc11111cc11ccc1ccc11111ccc11711111
11111b1b1b1b11b11b1b11b117111161161111111611161616111161161111611616161617111117111111c11c1c1c1c111111c1111c1c1c1111111c11171111
11111bbb1bb111b11b1b11b117111161166611111611161616111161166611611616161617111117111111c11c1c1c1c111111c11ccc1c1c1111111c11171111
11111b111b1b11b11b1b11b117111161111611111611161616111161111611611616161617111117117111c11c1c1c1c117111c11c111c1c1171111c11171111
11111b111b1b1bbb1b1b11b11171166616611666116616611666166616611666166116161171117117111ccc1ccc1ccc17111ccc1ccc1ccc1711111c11711111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822282888882822282228888888888888888888888888888888888888888888888888222822882228882822282288222822288866688
82888828828282888888888282888828888288828888888888888888888888888888888888888888888888888882882888828828828288288282888288888888
82888828828282288888822282228828882288228888888888888888888888888888888888888888888888888822882888828828822288288222822288822288
82888828828282888888828882828828888288828888888888888888888888888888888888888888888888888882882888828828828288288882828888888888
82228222828282228888822282228288822282228888888888888888888888888888888888888888888888888222822288828288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000002020000000000000000000000000000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
17170c272727272727272727270a171717000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
39071b272727272727272727271a073a07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17170b272727272727272727271c381717000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
073a1827272727272727272727193b3b07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3838082727272727272727272709173829000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07071b2727272727272727272719390707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1737082727272727272727272709173817000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a3b1827272727272727272727193a0707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
37170b2727272727272727272709173817000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0739182727272727272727272719070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1737082727272727272727272709373717000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707182727272727272727272719073907000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3738082727272727272727272709381717000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707182727272727272727272719070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2929082727272727272727272709382917000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
393b18272727272727272727271a3a3907000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1717082727272727272727272709171717000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707182727272727272727272719070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001825017250172501725017250172501725017250172501725017250172501725017250172501825017250172501825018250182501825018250182501825018250182501825018250182501b2501b250
