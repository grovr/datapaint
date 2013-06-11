module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            lib:
                src: ['src/**/*.coffee']
                dest: 'lib/all.js'
        ,            
        simplemocha:
            lib:
                src: ['lib/*.coffee', 'test/**/*Test.coffee']
                options:
                    globals: ['expect']
                    timeout: 3000
                    ui: 'bdd'  
        ,            
        watch:
            files: [
                'Gruntfile.coffee'
                'src/*.coffee'
                'test/*.coffee'
            ]
            tasks: 'default'

    grunt.loadNpmTasks('grunt-simple-mocha')
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-watch')

    grunt.registerTask('test', 'simplemocha')
    grunt.registerTask('default', ['coffee', 'simplemocha']) 