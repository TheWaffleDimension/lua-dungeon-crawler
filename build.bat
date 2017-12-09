@echo off
echo Building...

echo Compressing game...
%COMSPEC% /c 7z a -tzip ./build/game.love ./game/*
echo Done compressing!

echo Bundling exe...
%COMSPEC% /c copy /b "C:\Program Files\LOVE\love.exe"+.\build\game.love .\build\game.exe
echo Done bundling!

echo Copying DLL's...
%COMSPEC% /c xcopy /ey "C:\Program Files\LOVE\*.dll" .\build\
echo Done copying!

echo Cleaning up...
%COMSPEC% /c del .\build\game.love
echo Done cleaning!

echo Finished building!
pause > nul