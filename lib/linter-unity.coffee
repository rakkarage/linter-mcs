linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
path = require 'path'
fs = require 'fs'
class LinterUnity extends Linter
  @syntax: ['source.cs', 'source.js', 'source.boo']
  cmd: ''
  linterName: 'unity'
  regex:
    '^' +
    '(?<filename>.+\\.cs)' +
    '\\(' +
    '(?<line>\\d+)' +
    ',' +
    '(?<col>\\d+)' +
    '\\): ' +
    '((?<error>error)|(?<warning>warning))' +
    ' ' +
    '(?<code>\\w+)' +
    ': ' +
    '(?<message>.+)'
  errorStream: 'stderr'
  constructor: (editor) ->
    super(editor)
    atom.config.observe 'linter-unity.unityEditor', @formatShellCmd
    atom.config.observe 'linter-unity.unityEngine', @formatShellCmd
    atom.config.observe 'linter-unity.unityEngineUI', @formatShellCmd
    atom.config.observe 'linter-unity.unityOther', @formatShellCmd
    @formatShellCmd()
  destroy: ->
    atom.config.unobserve 'linter-unity.unityEditor'
    atom.config.unobserve 'linter-unity.unityEngine'
    atom.config.unobserve 'linter-unity.unityEngineUI'
    atom.config.unobserve 'linter-unity.unityOther'
  formatShellCmd: =>
    unityEditor = atom.config.get 'linter-unity.unityEditor'
    unityEngine = atom.config.get 'linter-unity.unityEngine'
    unityEngineUI = atom.config.get 'linter-unity.unityEngineUI'
    unityOther = atom.config.get 'linter-unity.unityOther'
    @add = '-r:'
    if fs.existsSync "#{unityEditor}"
      @add += "#{unityEditor},"
    if fs.existsSync "#{unityEngine}"
      @add += "#{unityEngine},"
    if fs.existsSync "#{unityEngineUI}"
      @add += "#{unityEngineUI},"
    if fs.existsSync "#{unityOther}"
      @add += "#{unityOther},"
    if atom.project
      unityProject = path.join atom.project.getPath(), 'Library', 'ScriptAssemblies', 'Assembly-CSharp.dll'
      if fs.existsSync "#{unityProject}"
        @add += "#{unityProject}"
    @cmd = ["mcs", "-target:library", @add]
module.exports = LinterUnity
