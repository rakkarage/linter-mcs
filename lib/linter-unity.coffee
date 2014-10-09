linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
class LinterUnity extends Linter
  @syntax: 'source.cs'
  cmd: 'mcs.exe -target:library -r:D:/lib/UnityEditor.dll,D:/lib/UnityEngine.dll,D:/lib/UnityEngine.UI.dll,D:/code/UnDeko/Library/ScriptAssemblies/Assembly-CSharp.dll'
  linterName: 'unity'
  regex:
    '^' +
    '(.+\\.cs)' +
    '\\(' +
    '(?<line>\\d+)' +
    ',' +
    '(?<col>\\d+)' +
    '\\): ' +
    '(?<level>\\w+)' +
    ' ' +
    '(?<message>.+)'
  errorStream: 'stderr'
  constructor: (editor) ->
    super(editor)
module.exports = LinterUnity
