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
end

function _update()
 player:update()
 enemy:update()
end


function _draw()
 cls()
 
 if debug_mode then show_debug() end
 -- game board stuff
 rect(0,0,127,127,1)
 
 -- game pieces stuff
 player:draw()
 enemy:draw()
 
 -- score stuff
 print("score: ", 3,3,7)
 print(score, 30,3,8)

end

-->8
-- game objects

enemy = {
 sprite = {46,62} ,
	xpos   = flr(rnd(100) +1),
	ypos   = 20,
 speed  = flr(rnd(10) + 1),	

 update = function(self)
 	self.ypos += self.speed
 	
	 if is_colision() then
	 	self.ypos  = -35
			self.xpos  = flr(rnd(100) +1)
			self.speed = flr(rnd(10) + 1) 
   -- lose 1 heart
	 end
	 
	 if self.ypos >= 120 then
	  score +=1
	 	self.ypos  = -35
			self.xpos  = flr(rnd(100) +1)
--			self.speed = flr(rnd(10) + 1) 
			self.speed = 3
	 end	 
 end,
 
 draw = function(self)
		spr(self.sprite[1],self.xpos,self.ypos)
		spr(self.sprite[1] +1 ,self.xpos +8 ,self.ypos)
		spr(self.sprite[2],self.xpos,self.ypos + 8)
		spr(self.sprite[2] +1 ,self.xpos + 8 ,self.ypos+8)
 end
}


-- player car object

player = {
 sprite = {9,0,14,16}, -- sprite corner x, corner y, width, height
 xpos = 64,  --initial xpos
 ypos = 110, --static ypos
 --colision = false, --currently unused
 
 update = function(self)
 -- player movement on x axis
        
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

	if enemy.ypos > 102
	 and enemy.ypos < 134
		and (enemy.xpos-8)<=player.xpos
	 and player.xpos<=(enemy.xpos+8)
	  then
     return true
 else
     return false
	end
end

function show_debug()
	--prints debug information

	print("player x: ",10,10,3)
	print(player_x,50,10,3)
	
	
	print("enemy  y: ",10,18,3)
	print(enemy.ypos,50,18,3)

	print("enemy speed: ",10,26,3)
	print(enemy.speed,60,26,3)

 -- is colliding?
	print(is_colision(),100,120,7)

end
__gfx__
00000000000087788778000000008778877800000000877887780000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000088888888880000008888888888000000000000000000000000000000000000000000000000000000000000000000000000000
00700700055888888888855000588888888885500558888888888500000000000000000000000000000000000000000000000000000000000000000000000000
00077000055888888888855005588888888885500558888888888550000000000000000000000000000000000000000000000000000000000000000000000000
00077000058885556558885005888556556888500588855556588850000000000000000000000000000000000000000000000000000000000000000000000000
00700700055855565565855005585565565585000058555565568550000000000000000000000000000000000000000000000000000000000000000000000000
00000000000855655655800000085655655580000008555655658000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000088888888880000008888888888000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000088888888880000008888888888000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000088888888880000008888888888000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000088888888880000008888888888000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855005588888888885500558888888888550000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855005588888888885500558888888888550000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855005588888888885500558888888888550000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855005588888888885500558888888888550000000000000000000000000000000000000000000000000000000000000000000000000
00000000000089888898000000008988889800000000898888980000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d9dddd9d0000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055dddddddddd550
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055dddddddddd550
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055dddddddddd550
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055dddddddddd550
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddddd000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddddd000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddddd000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddddd000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d55655655d000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055d56556555d550
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005ddd556555ddd50
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055dddddddddd550
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055dddddddddd550
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddddd000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d77dd77d0000
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
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002020000000000000000000000000000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001825017250172501725017250172501725017250172501725017250172501725017250172501825017250172501825018250182501825018250182501825018250182501825018250182501b2501b250
