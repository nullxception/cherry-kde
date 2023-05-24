module.exports = {
  js2svg: {
    indent: 1,
    pretty: true,
  },
  plugins: [
    "removeComments",
    "removeDesc",
    "removeDoctype",
    "removeUnknownsAndDefaults",
    "removeMetadata",
  ],
};
