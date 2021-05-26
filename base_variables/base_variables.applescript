--for export in scptd : Open "base_variables.applescript" in a new windows and then BUILD with menu "BUILD SYSTEM => APPLESCRIPT then "command"+"maj"+"B" => SCRIPT BUNDLE"


on write_to_file(this_data, target_file, append_data)
	try
		set the target_file to the target_file as string
		set the open_target_file to open for access POSIX file target_file with write permission
		if append_data is false then set eof of the open_target_file to 0
		write this_data to the open_target_file starting at eof
	 	close access the open_target_file
 		return true
 	on error
 		try
 			close access file target_file
 		end try
 		return false
	 end try
end write_to_file



--RESSOURCES ICON (.icns) ACCES FROM NAS

property iconNVPManagerFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo Dossier NVP Manager.icns" as alias

property iconAppFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Application.icns" as alias

property iconRessourcesFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier ressources.icns" as alias

property iconVideoFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier video.icns" as alias

property iconSoundFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Son.icns" as alias

property iconRAWFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier photo.icns" as alias

set scriptPath to POSIX path of ((path to me as text) & "::" & "::")  -- create a variable for the parents folder path  of the actual script
set NVPManagerPath to (scriptPath)  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
set NVPManagerScipt to (load script NVPManagerPath) -- call of the script "base_variables.scptd" in the actual script




set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")


set NewProjectFolderPath to getNewProjectFolderPath() of NVPManagerScipt
my write_to_file("\n \n TEST TEST TEST \n \n starting script \n \n",logPath,false) -- anounce to the starting of the scrip