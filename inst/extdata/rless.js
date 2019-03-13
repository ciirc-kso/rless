var rlessParse = function(toParse, resultParamName) {
  less.render(toParse.replace(/[\n\r]/g, ""), {}, function(error, output) {
    if (error) {
      console.r.call("stop('less parsing error: \n" + error.message + "')");
    }
    console.r.assign(resultParamName || "output", output.css);
  });
};
