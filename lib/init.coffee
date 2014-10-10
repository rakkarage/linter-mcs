path = require 'path'
module.exports =
  configDefaults:
    unityEditor: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\Managed\\UnityEditor.dll"
    unityEngine: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\Managed\\UnityEngine.dll"
    unityEngineUI: "C:\\Program Files (x86)\\Unity\\Editor\\Data\\UnityExtensions\\Unity\\GUISystem\\4.6.0\\UnityEngine.UI.dll"
    unityOther: path.join atom.project.path, 'Library', 'ScriptAssemblies', 'Assembly-CSharp.dll'
  activate: ->
    console.log 'activate linter-unity'
