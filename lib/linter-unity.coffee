linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
class LinterUnity extends Linter
  @syntax: 'source.cs'
  cmd: 'mcs -target:library -r:"C:/Program Files (x86)/Unity/Editor/Data/Managed/UnityEditor.dll","C:/Program Files (x86)/Unity/Editor/Data/Managed/UnityEngine.dll","C:/Program Files (x86)/Unity/Editor/Data/UnityExtensions/Unity/GUISystem/4.6.0/UnityEngine.UI.dll","D:/code/UnDeko/Library/ScriptAssemblies/Assembly-CSharp.dll"'
  linterName: 'unity'
  regex:
    '^' +
    '(?<filename>.+\\.cs)' +
    '\\(' +
    '(?<line>\\d+)' +
    ',' +
    '(?<col>\\d+)' +
    '\\): ' +
    '(?<level>\\w+)' +
    ' ' +
    '(?<message>.+)'
module.exports = LinterUnity
