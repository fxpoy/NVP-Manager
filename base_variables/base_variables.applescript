--for export in scptd : Open "base_variables.applescript" in a new windows and then BUILD with menu "BUILD SYSTEM => APPLESCRIPT then "command"+"maj"+"B" => SCRIPT BUNDLE"





--RESSOURCES ICON (.icns) ACCES FROM NAS

property iconNVPManagerFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo Dossier NVP Manager.icns" as alias

property iconAppFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Application.icns" as alias

property iconRessourcesFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier ressources.icns" as alias

property iconVideoFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier video.icns" as alias

property iconSoundFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier Son.icns" as alias

property iconRAWFolderPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo dossier photo.icns" as alias


property iconAppDavinciResolvePpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo DaVinci Resolve.icns" as alias

property iconAppPremiereProPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo Premiere Pro.icns" as alias

property iconAppAfterEffectPpath : POSIX file "/Volumes/ECOMMERCE/ALGO_VIDEO/_00_RESSOURCES_ALGO/03_ICON_LOGO/Logo After Effect.icns" as alias



-- LOAD THE VALUE OF "NewProjectFolderPath" FROM THE NVP-MANAGER SCRIPT


set scriptPath to POSIX path of ((path to me as text) & "::" & "::")  -- create a variable for the parents folder path  of the actual script
set mainScriptPath to (scriptPath & "/NVP-Manager.applescipt")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"

set test to (load script mainScriptPath)

set choice to getChoice() of test -- recupere la variable depuis le main script


on getCHOICE1()
    set res to choice -- renvoie la variable 
    return res
end getCHOICE1