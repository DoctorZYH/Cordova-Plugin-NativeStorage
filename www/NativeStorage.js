var exec = require('cordova/exec');

exports.set = function (arg0, success, error) {
    exec(success, error, 'NativeStorage', 'set', [arg0]);
};

exports.get = function (arg0, success, error) {
    exec(success, error, 'NativeStorage', 'get', [arg0]);
};