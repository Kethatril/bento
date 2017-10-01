import merge from "webpack-merge";
import ExtractTextPlugin from "extract-text-webpack-plugin";

export default function style(config, options) {
    config = merge(config, {
        module: {
            rules: [
                {
                    test: /\.css$/,
                    include: [/node_modules/],
                    use: ExtractTextPlugin.extract({
                        fallback: "style-loader",
                        publicPath: "../",
                        use: [
                            {
                                loader: "css-loader",
                                options: {
                                    sourceMap: options.get("enabled.sourceMap")
                                }
                            }
                        ]
                    })
                },

                {
                    test: /\.scss$/,
                    include: [options.get("paths.input")],
                    use: ExtractTextPlugin.extract({
                        fallback: "style-loader",
                        publicPath: "../",
                        use: [
                            {
                                loader: "css-loader",
                                options: {
                                    sourceMap: options.get("enabled.sourceMap")
                                }
                            },

                            {
                                loader: "postcss-loader",
                                options: {
                                    ident: "postcss",
                                    plugins: () => {
                                        const autoprefixer = require("autoprefixer");
                                        const browsers = options.get(
                                            "browserslist"
                                        );

                                        return [
                                            autoprefixer({
                                                browsers
                                            })
                                        ];
                                    },
                                    sourceMap: options.get("enabled.sourceMap")
                                }
                            },
                            {
                                loader: "resolve-url-loader",
                                options: {
                                    sourceMap: options.get("enabled.sourceMap")
                                }
                            },
                            {
                                loader: "sass-loader",
                                options: {
                                    sourceMap: options.get("enabled.sourceMap")
                                }
                            }
                        ]
                    })
                }
            ]
        },

        plugins: [
            new ExtractTextPlugin({
                filename: `styles/${options
                    .get("filename")
                    .replace("hash:", "contenthash:")}.css`,
                disable: !options.get("enabled.extractCSS")
            })
        ]
    });

    if (options.get("env.isProduction")) {
        const OptimizeCssAssetsPlugin = require("optimize-css-assets-webpack-plugin");

        config = merge(config, {
            plugins: [
                new OptimizeCssAssetsPlugin({
                    cssProcessor: require("cssnano"),
                    cssProcessorOptions: {
                        discardComments: { removeAll: true }
                    },
                    canPrint: true
                })
            ]
        });
    }

    return config;
}
