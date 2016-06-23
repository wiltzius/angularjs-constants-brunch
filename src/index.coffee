escape = require('js-string-escape');
pathlib = require('path');

module.exports = class AngularConstantsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'json'

  _default_path_transform: (path) ->
    # Default path transformation is a no-op
    path

  constructor: (config) ->
    @module = config.plugins?.angular_constants?.module or 'welkin'
#    @path_transform = config.plugins?.angular_constants?.path_transform or @_default_path_transform

  compile: (data, path, callback) ->
    constant_name = pathlib.basename(path, '.json')

    callback null, """
(function() {
    var module;

    try {
        // Get current constants module
        module = angular.module('#{@module}');
    } catch (error) {
        // Or create a new one
        module = angular.module('#{@module}', []);
    }

    module.constant(#{constant_name}, #{data});
})();
"""
