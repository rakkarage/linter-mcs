module.exports =
  configDefaults:
    additionalCore: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\Mono\\lib\\mono\\unity\\System.Core.dll"
    additionalEditor: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\Managed\\UnityEditor.dll"
    additionalEngine: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\Managed\\UnityEngine.dll"
    additionalUI: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\UnityExtensions\\Unity\\GUISystem\\4.6.0\\UnityEngine.UI.dll"
    additional: ""
  activate: ->
    console.log 'activate linter-mcs'
