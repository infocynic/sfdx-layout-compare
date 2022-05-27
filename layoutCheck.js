try {
  require("jsdom");
} catch {
  console.log(
    "JSDOM not installed. Run npm install --save-dev jsdom from the root of the project folder."
  );
  process.exit(1);
}

const fs = require("fs");
const util = require("util");
const { JSDOM } = require("jsdom");

const layout = fs.readFileSync(process.argv[2]);

const { document } = new JSDOM(`${layout}`, { contentType: "application/xml" })
  .window;
console.log(
  util.inspect(
    Array.from(document.querySelectorAll("layoutItems field"))
      .map((e) => e.innerHTML)
      .sort(),
    { maxArrayLength: null }
  )
);
