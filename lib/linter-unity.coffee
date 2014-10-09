linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
class LinterUnity extends Linter
  @syntax: 'source.cs'
  cmd: ''
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
    atom.config.observe 'linter-unity.unityEditor', @formatShellCmd
    atom.config.observe 'linter-unity.unityEngine', @formatShellCmd
    atom.config.observe 'linter-unity.unityEngineUI', @formatShellCmd
    atom.config.observe 'linter-unity.unityProject', @formatShellCmd
    @formatShellCmd()
  destroy: ->
    atom.config.unobserve 'linter-unity.unityEditor'
    atom.config.unobserve 'linter-unity.unityEngine'
    atom.config.unobserve 'linter-unity.unityEngineUI'
    atom.config.unobserve 'linter-unity.unityProject'
  formatShellCmd: =>
    unityEditor = atom.config.get 'linter-unity.unityEditor'
    unityEngine = atom.config.get 'linter-unity.unityEngine'
    unityEngineUI = atom.config.get 'linter-unity.unityEngineUI'
    unityProject = atom.config.get 'linter-unity.unityProject'
    @cmd = ["mcs","-target:library","-r:#{unityEditor},#{unityEngine},#{unityEngineUI},#{unityProject}"]
module.exports = LinterUnity
