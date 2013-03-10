/*
 * Create Correct static project
 */

exports.description = 'Create HTML page';

exports.template = function(grunt, init, done) {
	init.process({}, [
		{
			'name': 'name',
			'message': 'File name',
			'default': 'index'
		},
		{
			'name': 'title',
			'message': 'Page title',
			'default': 'Title'
		}
	], function(err, props) {
		grunt.util._.defaults(props, init.defaults);

		// Files to copy (and process).
		var files = init.filesToCopy(props),
			exec = require('child_process').exec;

		// Actually copy (and process) files.
		init.copyAndProcess(files, props);

		// Run npm install
		exec('npm install', function(error, stdout, stderr) {
			console.log(stdout);
			done();
		});
	});
};