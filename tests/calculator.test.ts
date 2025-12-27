import { describe, it, expect } from 'vitest';
import { add, subtract, multiply, divide, isEven, isPrime, factorial } from '../src/calculator.js';

describe('Calculator', () => {
  describe('add', () => {
    it('should add two positive numbers', () => {
      expect(add(2, 3)).toBe(5);
    });

    it('should add negative numbers', () => {
      expect(add(-1, -2)).toBe(-3);
    });

    it('should add zero', () => {
      expect(add(5, 0)).toBe(5);
    });
  });

  describe('subtract', () => {
    it('should subtract two numbers', () => {
      expect(subtract(5, 3)).toBe(2);
    });

    it('should handle negative result', () => {
      expect(subtract(3, 5)).toBe(-2);
    });
  });

  describe('multiply', () => {
    it('should multiply two numbers', () => {
      expect(multiply(3, 4)).toBe(12);
    });

    it('should return zero when multiplying by zero', () => {
      expect(multiply(5, 0)).toBe(0);
    });
  });

  describe('divide', () => {
    it('should divide two numbers', () => {
      expect(divide(10, 2)).toBe(5);
    });

    it('should throw error for division by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division by zero');
    });
  });

  describe('isEven', () => {
    it('should return true for even numbers', () => {
      expect(isEven(4)).toBe(true);
      expect(isEven(0)).toBe(true);
    });

    it('should return false for odd numbers', () => {
      expect(isEven(3)).toBe(false);
      expect(isEven(-1)).toBe(false);
    });
  });

  describe('isPrime', () => {
    it('should return true for prime numbers', () => {
      expect(isPrime(2)).toBe(true);
      expect(isPrime(3)).toBe(true);
      expect(isPrime(17)).toBe(true);
    });

    it('should return false for non-prime numbers', () => {
      expect(isPrime(1)).toBe(false);
      expect(isPrime(4)).toBe(false);
      expect(isPrime(9)).toBe(false);
    });
  });

  describe('factorial', () => {
    it('should return 1 for factorial(0)', () => {
      expect(factorial(0)).toBe(1);
    });

    it('should return 1 for factorial(1)', () => {
      expect(factorial(1)).toBe(1);
    });

    it('should return correct factorial for positive integers', () => {
      expect(factorial(5)).toBe(120);
      expect(factorial(10)).toBe(3628800);
    });

    it('should throw error for negative integers', () => {
      expect(() => factorial(-1)).toThrow('Factorial requires a non-negative integer');
      expect(() => factorial(-5)).toThrow('Factorial requires a non-negative integer');
    });

    it('should throw error for non-integers (decimals)', () => {
      expect(() => factorial(3.5)).toThrow('Factorial requires an integer');
      expect(() => factorial(0.1)).toThrow('Factorial requires an integer');
    });
  });
});
