pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
-- posicion inicial de jugador
player_x=64
player_y=110 -- este valor va a ser fijo y no se verれく afectado por movimiento
end

function _update()
-- movimiento de jugador en eje x
        
    if btn(➡️) and player_x<110 then
        player_x+=2        
    end
    if btn(⬅️) and player_x>3 then
        player_x-=2
    end
end

function _draw()
cls()
print("player x",10,10,3) --debug player x
print(player_x,50,10,3)
rect(0,0,127,127,1)
spr(1,player_x,player_y)
spr(2,player_x+8,player_y)
spr(17,player_x,player_y+8)
spr(18,player_x+8,player_y+8)
end

__gfx__
00000000000087788778000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700055888888888855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000055888888888855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000058885556558885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700055855565565855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000855655655800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055888888888855000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000089888898000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
