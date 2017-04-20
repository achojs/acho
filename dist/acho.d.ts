declare class Acho {
  constructor(options?: Object);
  debug(...args: string[]): void;
  error(...args: string[]): void;
  fatal(...args: string[]): void;
  info(...args: string[]): void;
  warn(...args: string[]): void;
}

export = Acho;
