--for export in scptd : Open "base_variables.applescript" in a new windows and then BUILD with menu "BUILD SYSTEM => APPLESCRIPT then "command"+"maj"+"B" => SCRIPT BUNDLE"





--RESSOURCES ICON (.icns) ACCES FROM NAS

property iconNVPManagerFolderPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo Dossier NVP Manager.icns" as alias


property iconMediaFromSetPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo From Set.icns" as alias


property iconRessourcesFolderPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier ressources.icns" as alias

property iconVideoFolderPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier video.icns" as alias

property iconSoundFolderPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Son.icns" as alias

property iconRAWFolderPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier photo.icns" as alias




property iconAppPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo Application.icns" as alias

property iconAppDavinciResolvePpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo DaVinci Resolve.icns" as alias

property iconAppPremiereProPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo Premiere Pro.icns" as alias

property iconAppAfterEffectPpath : POSIX file "/Volumes/ECOMMERCE/VIDEO_PROJECT/._00_RESSOURCES_ALGO/03_ICON_LOGO/Logo After Effect.icns" as alias



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