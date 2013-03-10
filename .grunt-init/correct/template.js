/*
 * Create Correct static project
 */

exports.description = 'Create Correct static project';

exports.template = function(grunt, init, done) {
	init.process({}, [
		{
			'name': 'project',
			'message': 'Project name',
			'default': 'correct-static'
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