// @ts-check
import eslint from '@eslint/js';
import angular from 'angular-eslint';
import { configs as perfectionistConfigs } from 'eslint-plugin-perfectionist';
import { defineConfig } from 'eslint/config';
import tseslint from 'typescript-eslint';

/* oxlint-disable no-default-export */
export default defineConfig([
  {
    extends: [
      eslint.configs.recommended,
      tseslint.configs.recommended,
      tseslint.configs.stylistic,
      angular.configs.tsRecommended,
    ],
    files: ['**/*.ts'],
    processor: angular.processInlineTemplates,
    rules: {
      '@angular-eslint/component-selector': [
        'error',
        {
          prefix: 'app',
          style: 'kebab-case',
          type: 'element',
        },
      ],
      '@angular-eslint/directive-selector': [
        'error',
        {
          prefix: 'app',
          style: 'camelCase',
          type: 'attribute',
        },
      ],
    },
  },

  {
    extends: [angular.configs.templateRecommended, angular.configs.templateAccessibility],
    files: ['**/*.html'],
    rules: {},
  },

  perfectionistConfigs['recommended-alphabetical'],
  {
    rules: {
      'perfectionist/sort-imports': 'off',
    },
  },
]);
