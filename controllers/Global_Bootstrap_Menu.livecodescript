script "Global_Bootstrap_Menu"
--> MetaData
-
license: GPLv3
name: Global_Bootstrap_Menu
type: controller
version: 0.3

--> Variables
-
local LocalArray


--> Global | Bootstrap | Menu
-
on menu_WatchTemplates projectName, someBoolean
   if someBoolean is false then
      watch_SetActive false
   else
      bootstrap_WatchTemplates "blah"
   end if
end menu_WatchTemplates

command watch_FileChanged bootstrapTemplate
   put merge ("Template '[[bootstrapTemplate]]' has changed!") into someMessage
   display_BootstrapTemplate bootstrapTemplate
   lcw_Notify someMessage
end watch_FileChanged

getprop watch_Templates [projectName]
   return watch_GetActive() is true
end watch_Templates

on _
end _

on menu_SaveTemplate indexView
   scaffold_SaveDisplayed indexView
   put the result into bootstrapTemplate
   
   -- put the title_Text of indexView into bootstrapTemplate
   display_BootstrapTemplate bootstrapTemplate
end menu_SaveTemplate

on _
end _

on menu_EditTemplate projectName, bootstrapTemplate
   put scaffold_GetFile (bootstrapTemplate) into someFile
   put bootstrapTemplate into someTitle
   put ",Bootstrap 4" after someTitle
   display_TextFile someFile, someTitle, "Global | Bootstrap | Menu"
   put the result into indexView
end menu_EditTemplate

on menu_EditInAtom projectName, bootstrapTemplate
   put scaffold_GetFile (bootstrapTemplate) into someFile
   launch_Atom someFile
end menu_EditInAtom

on menu_DisplayHtml projectName, bootstrapTemplate
   display_BootstrapTemplate bootstrapTemplate
end menu_DisplayHtml

on _
end _

on menu_DownloadBootstrap projectName, installHow
   switch installHow
      case "git"
         bootstrap_Download projectName, "git"
         break
      case "npm"
         bootstrap_Download projectName, "npm"
         break
   end switch
end menu_DownloadBootstrap

on _
end _

on menu_BootstrapDocumentation
   launch url "https://github.com/twbs/bootstrap/tree/v4-dev"
end menu_BootstrapDocumentation
   
on menu_RevealProjectFolder projectName
   put project_GetFolder (projectName) into projectFolder
   finder_Reveal projectFolder
end menu_RevealProjectFolder


--> Global | Bootstrap | Menu | Props
-
getprop bootstrap_Templates
    return bootstrap_ListTemplates()
 end bootstrap_Templates
 

--> Global | Bootstrap | Menu | Disabled
-
getprop disabled_SaveTemplate [indexView]
   if word 1 of indexView is "group" then
      return false
   else
      return "delete"
   end if
end disabled_SaveTemplate
