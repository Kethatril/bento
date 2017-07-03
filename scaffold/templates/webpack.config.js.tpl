const { config } = require("webpack-kit");

module.exports = config({
    /**
     * ------------------------------------------------------------------------
     * Paths
     * ------------------------------------------------------------------------
     * "input":     The base directory, an absolute path, for resolving
     *              entry points and loaders from configuration.
     * @see https://webpack.js.org/configuration/entry-context/#context
     *
     * "output":    The output directory as an absolute path.
     * @see https://webpack.js.org/configuration/output/#output-path
     *
     * "public":    The public URL of the output directory when referenced
     *              in a browser.
     * @see https://webpack.js.org/configuration/output/#output-publicpath
     *
     */
    "paths": {
        "input": "<%= input %>",
        "output": "<%= output %>",
        "public": "<%= public %>"
    },

    /**
     * ------------------------------------------------------------------------
     * Entry
     * ------------------------------------------------------------------------
     * "main":      The point or points to enter the application.
     *              Note: vendor static css files can be added here instead of
     *              using standard `import` to improve HMR reload speed.
     * @see https://webpack.js.org/configuration/entry-context/#context
     *
     */
    "entry": {
        "main": [
            // "normalize.css/normalize.css"
            "./scripts/main.js"
        ]
    },

    /**
     * ------------------------------------------------------------------------
     * Caching
     * ------------------------------------------------------------------------
     * "hash":      Hash length that will append to output files for
     *              long term caching.
     * @see https://webpack.js.org/guides/caching/#the-problem
     *
     */
    "caching": {
        "hash": ".[hash:8]",
    },

    /**
     * ------------------------------------------------------------------------
     * Additional options
     * ------------------------------------------------------------------------
     * "sourceMap": Enable / disable source map
     *
     */
    "enabled": {
        "sourceMap": true
    },

    /**
     * ------------------------------------------------------------------------
     * Autoprefixer
     * ------------------------------------------------------------------------
     * "browsers":  Define stack of browsers that will use for CSS vendor
     *              prefix as well as Babel polyfill
     * @see https://github.com/postcss/autoprefixer#browsers
     * @see https://github.com/babel/babel-preset-env
     *
     */
    "autoprefixer": {
        "browsers": [
            "last 1 version"
        ]
    },

    /**
     * ------------------------------------------------------------------------
     * Files
     * ------------------------------------------------------------------------
     * "watch":     Additional files to watch and reload browser if
     *              they've changed.
     *
     * "copy":      Copy files that match the pattern to the output folder.
     *
     */
    "files": {
        "watch": [
            // "{app,resources/views}/**/*.php"
        ],
        "copy": "+(images|media)/**/*"
    },

    /**
     * ------------------------------------------------------------------------
     * Dev Server
     * ------------------------------------------------------------------------
     * "backEnd":   A back-end URL to which all other requests outside
     *              of `paths.public` will be proxied, e.g Wordpress
     *
     */
    "devServer": {
        "backEnd": <%- server ? ('"' + proxy + '"') : "false" %>
    }
}, !!process.argv.indexOf('webpack-dev-server'));
