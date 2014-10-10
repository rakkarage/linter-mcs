linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
fs = require 'fs'
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
      @add += "#{unityOther}"
    @cmd = ["mcs", "-target:library", @add]
module.exports = LinterUnity
