module.exports =
  configDefaults:
    unityProject: "D:/code/UnDeko/Library/ScriptAssemblies/Assembly-CSharp.dll"
    unityEditor: "D:/lib/UnityEditor.dll"
    unityEngine: "D:/lib/UnityEngine.dll"
    unityEngineUI: "D:/lib/UnityEngine.UI.dll"
  activate: ->
    console.log 'activate linter-unity'
