linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"
path = require 'path'
fs = require 'fs'
class LinterMCS extends Linter
  @syntax: 'source.cs'
  linterName: 'mcs'
  errorStream: 'stderr'
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
  constructor: (editor) ->
    super(editor)
    atom.config.observe 'linter-mcs.additional0', @formatShellCmd
    atom.config.observe 'linter-mcs.additional1', @formatShellCmd
    atom.config.observe 'linter-mcs.additional2', @formatShellCmd
    atom.config.observe 'linter-mcs.additional3', @formatShellCmd
    atom.config.observe 'linter-mcs.additional4', @formatShellCmd
    @formatShellCmd()
  destroy: ->
    atom.config.unobserve 'linter-mcs.additional0'
    atom.config.unobserve 'linter-mcs.additional1'
    atom.config.unobserve 'linter-mcs.additional2'
    atom.config.unobserve 'linter-mcs.additional3'
    atom.config.unobserve 'linter-mcs.additional4'
  formatShellCmd: =>
    additional0 = atom.config.get 'linter-mcs.additional0'
    additional1 = atom.config.get 'linter-mcs.additional1'
    additional2 = atom.config.get 'linter-mcs.additional2'
    additional3 = atom.config.get 'linter-mcs.additional3'
    additional4 = atom.config.get 'linter-mcs.additional4'
    @add = '-r:'
    if fs.existsSync "#{additional0}"
      @add += "#{additional0},"
    if fs.existsSync "#{additional1}"
      @add += "#{additional1},"
    if fs.existsSync "#{additional2}"
      @add += "#{additional2},"
    if fs.existsSync "#{additional3}"
      @add += "#{additional3},"
    if atom.project
      additional4 = path.join atom.project.getPath(), 'Library', 'ScriptAssemblies', 'Assembly-CSharp.dll'
      if fs.existsSync "#{additional4}"
        @add += "#{additional4}"
    @cmd = ["mcs", "-target:library", @add]
module.exports = LinterMCS
