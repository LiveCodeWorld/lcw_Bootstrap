script "lib_Bootstrap"
--> MetaData
-
license: GPLv3
name: lib_Bootstrap
type: library
version: 0.3


--> Bootstrap | Display | Objects
-
function bootstrap_BrowserView
   put the long id of widget 1 of cd 1 of stack "lcw_Bootstrap" into browserView
   return browserView
end bootstrap_BrowserView


--> Bootstrap | Display
-
command display_BootstrapTemplate bootstrapTemplate
   switch bootstrapTemplate
      case "bootstrap_template"
         put "Hello World!" into pageHeader
         break
      default
   end switch
   
   put scaffold_GetTemplate (bootstrapTemplate) into htmlTemplate
   put merge (htmlTemplate) into someHTML
   -- put someHTML
   display_BootstrapHTML someHTML
end display_BootstrapTemplate

command display_BootstrapHTML someHTML
   put bootstrap_BrowserView() into bootstrapBrowserView
   set the htmltext of bootstrapBrowserView to someHTML
end display_BootstrapHTML


--> Bootstrap
-
function bootstrap_ListTemplates
   put scaffold_ListShortFiles() into bootstrapTemplates
   filter bootstrapTemplates with "bootstrap_*"
   return bootstrapTemplates
end bootstrap_ListTemplates


--> Bootstrap | Install
-
command bootstrap_Download projectName, pDownloadHow
   /*
   - [Download the latest release.](https://github.com/twbs/bootstrap/archive/v4.0.0-alpha.4.zip)
   - Clone the repo: `git clone https://github.com/twbs/bootstrap.git`
   - Install with [npm](https://www.npmjs.com): `npm install bootstrap@4.0.0-alpha.4`
   */
   
   put asset_GetFolder (projectName) into assetFolder
   if there is not a folder assetFolder then
      put assetFolder
      lcw_Answer merge ("Asset folder for project '[[projectName]]' does not exist. Would you like to create it?")
      folder_CreateNested assetFolder
   end if
   
   switch pDownloadHow
      case "git"
         -- this is really slow
         revDeleteFolder assetFolder
         put "git@github.com:twbs/bootstrap.git" into gitUrl
         -- git_CloneAndReplaceFolder gitURL, assetFolder
         git_Clone gitURL, assetFolder
         put the result into shellResult
         bootstrap_MakeGitAlias projectName
         break
      default -- case "npm"
         put "npm install bootstrap@4.0.0-alpha.4" into someShell
         put shell_ExecuteAtRoot (someShell, assetFolder) into shellResult
         bootstrap_MakeNpmAlias projectName
         put shellResult
         break
   end switch
end bootstrap_Download

command bootstrap_MakeGitAlias projectName
   put asset_GetFolder (projectName) into assetFolder
   put assetFolder & "bootstrap/dist/css/" into cssFolder
   put assetFolder & "bootstrap/dist/js/" into jsFolder
   
   put the defaultfolder into oFolder
   set the defaultfolder to assetFolder
   if there is a folder cssFolder then create alias "css" to folder cssFolder
   if there is a folder jsFolder then create alias "js" to folder jsFolder
   set the defaultfolder to oFolder
end bootstrap_MakeGitAlias

on bootstrap_MakeNpmAlias projectName
   put asset_GetFolder (projectName) into assetFolder
   put assetFolder & "node_modules/bootstrap/dist/css/" into cssFolder
   put assetFolder & "node_modules/bootstrap/dist/js/" into jsFolder
   
   put the defaultfolder into oFolder
   set the defaultfolder to assetFolder
   if there is a folder cssFolder then create alias "css" to folder cssFolder
   if there is a folder jsFolder then create alias "js" to folder jsFolder
   set the defaultfolder to oFolder
end bootstrap_MakeNpmAlias

