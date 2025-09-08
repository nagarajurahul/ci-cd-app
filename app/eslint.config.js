import js from "@eslint/js";
import pluginN from "eslint-plugin-n";

export default [
  js.configs.recommended,
  pluginN.configs["flat/recommended"],
  {
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",   // ESM project or sourceType: "commonjs",   // allow require()
    },
    rules: {
      semi: ["error", "always"],
      quotes: ["error", "double"],
      "n/no-unsupported-features/es-syntax": "off", // we’re using ESM intentionally
      "n/no-unpublished-import": "off"
    }
  }
];
