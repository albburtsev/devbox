module.exports = function(grunt) {
	grunt.initConfig({
		stylus: {
			compile: {
				options: {
					'compress': true,
					'paths': ['static/css/styl/']
				},
				files: {
					'static/css/styles.css': 'static/css/styl/styles.styl',
				}
			}
		},
		concat: {
			js: {
				src: [
					'static/js/src/wrap_head.js',
					/* put your scripts here */
					'static/js/src/wrap_foot.js'
				],
				dest: 'static/js/script.js'
			},
			glue: {
				src: [
					'static/js/lib/jquery-1.9.1.min.js',
					'static/js/script.js'
				],
				dest: 'static/js/script.js'
			}
		},
		watch: {
			stylus: {
				files: ['static/css/styl/*.styl'],
				tasks: ['stylus']
			},
			js: {
				files: ['<%= concat.js.src %>'],
				tasks: ['concat']
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-stylus');
	grunt.loadNpmTasks('grunt-contrib-watch');

	grunt.registerTask('default', ['stylus', 'concat:js', 'concat:glue', 'watch']);
};