local list = {
  [994732206] = "https://api.luarmor.net/files/v4/loaders/e14f9ec13f826dbea8c9a1af10396ba2.lua"
}

if list[game.GameId] then
    loadstring(game:HttpGet(list[game.GameId]))();
else
  return game:GetService("Players").LocalPlayer:Kick('Invalid game')
end;
