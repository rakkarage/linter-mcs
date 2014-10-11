linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
path = require 'path'
fs = require 'fs'
class LinterMCS extends Linter
  @syntax: 'source.cs'
  cmd: ''
  linterName: 'mcs'
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
    atom.config.observe 'linter-mcs.additional0', @formatShellCmd
    atom.config.observe 'linter-mcs.additional1', @formatShellCmd
    atom.config.observe 'linter-mcs.additional2', @formatShellCmd
    atom.config.observe 'linter-mcs.additional3', @formatShellCmd
    @formatShellCmd()
  destroy: ->
    atom.config.unobserve 'linter-mcs.additional0'
    atom.config.unobserve 'linter-mcs.additional1'
    atom.config.unobserve 'linter-mcs.additional2'
    atom.config.unobserve 'linter-mcs.additional3'
  formatShellCmd: =>
    additional0 = atom.config.get 'linter-mcs.additional0'
    additional1 = atom.config.get 'linter-mcs.additional1'
    additional2 = atom.config.get 'linter-mcs.additional2'
    additional3 = atom.config.get 'linter-mcs.additional3'
    @add = '-r:'
    if fs.existsSync "#{additional0}"
      @add += "#{additional0},"
    if fs.existsSync "#{additional1}"
      @add += "#{additional1},"
    if fs.existsSync "#{additional2}"
      @add += "#{additional2},"
    if atom.project
      additional3 = path.join atom.project.getPath(), 'Library', 'ScriptAssemblies', 'Assembly-CSharp.dll'
      if fs.existsSync "#{additional3}"
        @add += "#{additional3}"
    @cmd = ["mcs", "-target:library", @add]
module.exports = LinterMCS
