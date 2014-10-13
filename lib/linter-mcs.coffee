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
    atom.config.observe 'linter-mcs.additionalCore', @formatShellCmd
    atom.config.observe 'linter-mcs.additionalEditor', @formatShellCmd
    atom.config.observe 'linter-mcs.additionalEngine', @formatShellCmd
    atom.config.observe 'linter-mcs.additionalUI', @formatShellCmd
    atom.config.observe 'linter-mcs.additional', @formatShellCmd
    @formatShellCmd()
  destroy: ->
    atom.config.unobserve 'linter-mcs.additionalCore'
    atom.config.unobserve 'linter-mcs.additionalEditor'
    atom.config.unobserve 'linter-mcs.additionalEngine'
    atom.config.unobserve 'linter-mcs.additionalUI'
    atom.config.unobserve 'linter-mcs.additional'
  formatShellCmd: =>
    additionalCore = atom.config.get 'linter-mcs.additionalCore'
    additionalEditor = atom.config.get 'linter-mcs.additionalEditor'
    additionalEngine = atom.config.get 'linter-mcs.additionalEngine'
    additionalUI = atom.config.get 'linter-mcs.additionalUI'
    additional = atom.config.get 'linter-mcs.additional'
    @add = '-r:'
    if fs.existsSync "#{additionalCore}"
      @add += "#{additionalCore},"
    if fs.existsSync "#{additionalEditor}"
      @add += "#{additionalEditor},"
    if fs.existsSync "#{additionalEngine}"
      @add += "#{additionalEngine},"
    if fs.existsSync "#{additionalUI}"
      @add += "#{additionalUI},"
    if atom.project
      additional = path.join atom.project.getPath(), 'Library', 'ScriptAssemblies', 'Assembly-CSharp.dll'
      if fs.existsSync "#{additional}"
        @add += "#{additional}"
    @cmd = ["mcs", "-target:library", @add]
module.exports = LinterMCS
