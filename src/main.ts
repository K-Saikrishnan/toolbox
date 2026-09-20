import { bootstrapApplication } from '@angular/platform-browser';

import { App } from './app/app';
import { appConfig } from './app/app.config';

try {
  /* oxlint-disable-next-line node/no-top-level-await */
  await bootstrapApplication(App, appConfig);
} catch (err) {
  /* oxlint-disable-next-line no-console */
  console.error('Failed to bootstrap Angular application:', err);
}
