import js from "@eslint/js";

export default [
  js.configs.recommended,
  {
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "commonjs",   // allow require()
      globals: {
        console: "readonly",
        require: "readonly"
      }
    },
    rules: {
      semi: ["error", "always"],
      quotes: ["error", "double"]
    }
  }
];
