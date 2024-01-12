rm -Recurse -Force export_folder
cp data_static -Recurse -Force export_folder/data_static
cp gamemodes -Recurse -Force export_folder/gamemodes
cp maps -Recurse -Force export_folder/maps
cp materials -Recurse -Force export_folder/materials
cp sound -Recurse -Force export_folder/sound
cp addon.json export_folder

D:\SteamLibrary\steamapps\common\GarrysMod\bin\gmad.exe create -folder "export_folder" -out "atomic_bombermelon.gma"