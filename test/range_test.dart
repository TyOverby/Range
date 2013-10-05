import 'package:unittest/unittest.dart';
import '../lib/range.dart';

void main() {
  group("Finite range | positive increment | integer values", () {
    test("0 to 10", () {
      expect(new Range(0, 10), orderedEquals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
    });
    test("-5 to 5", () {
      expect(new Range(-5, 5), orderedEquals([-5, -4, -3, -2, -1, 0, 1, 2, 3, 4]));
    });
    test("-10 to 0", () {
      expect(new Range(-10, 0), orderedEquals([-10, -9, -8, -7, -6, -5, -4, -3, -2, -1]));
    });
  });

  group("Finite range | negative increment | integer values", () {
    test("10 to 0", () {
      expect(new Range(10, 0, -1), orderedEquals([10, 9, 8, 7, 6, 5, 4, 3, 2, 1]));
    });
    test("5 to -5", () {
      expect(new Range(5, -5, -1), orderedEquals([5, 4, 3, 2, 1, 0, -1, -2, -3, -4]));
    });
    test("0 to -10", () {
      expect(new Range(0, -10, -1), orderedEquals([0, -1, -2, -3, -4, -5, -6, -7, -8, -9]));
    });
  });

  group("Finite range | positive increment | double values", () {
    test("0 to 5 by 0.5", () {
      expect(new Range(0, 5, 0.5), orderedEquals([0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5]));
    });
    test("-2 to 2 by 0.5", () {
      expect(new Range(-2, 2, 0.5), orderedEquals([-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5]));
    });
    test("-5 to 0 by 0.5", () {
      expect(new Range(-5, 0, 0.5), orderedEquals([-5, -4.5, -4, -3.5, -3, -2.5, -2, -1.5, -1, -0.5]));
    });
  });

  group("Finite range | negative increment | integer values", () {
    test("5 to 0 by 0.5", () {
      expect(new Range(5, 0, -0.5), orderedEquals([5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1, 0.5]));
    });
    test("2 to -2 by 0.5", () {
      expect(new Range(2, -2, -0.5), orderedEquals([2, 1.5, 1, 0.5, 0, -0.5, -1, -1.5]));
    });
    test("0 to -5 by 0.5", () {
      expect(new Range(0, -5, -0.5), orderedEquals([0, -0.5, -1, -1.5, -2, -2.5, -3, -3.5, -4, -4.5]));
    });
  });

  group("Range.toInfinity", () {
    test("default parameters", () {
      expect(new Range.infinite(0, 1).take(5), orderedEquals([0, 1, 2, 3, 4]));
    });
    test("0 to infinity by two", () {
      expect(new Range.infinite(0, 2).take(5), orderedEquals([0, 2, 4, 6, 8]));
    });
    test("0 to infinity by 0.5", () {
      expect(new Range.infinite(0, 0.5).take(5), orderedEquals([0, 0.5, 1, 1.5, 2]));
    });
    test("0 to negative infinity by 1", () {
      expect(new Range.infinite(0, -1).take(5), orderedEquals([0, -1, -2, -3, -4]));
    });
    test("0 to negative infinity by 0.5", () {
      expect(new Range.infinite(0, -0.5).take(5), orderedEquals([0, -0.5, -1, -1.5, -2]));
    });
  });

  group("Range.to", (){
    test("5", () {
      expect(new Range.to(5), orderedEquals([0,1,2,3,4]));
    });
    test("-5", (){
      expect(new Range.to(-5), orderedEquals([0,-1,-2,-3,-4]));
    });

    test("5 by 2", (){
      expect(new Range.to(5, 2), orderedEquals([0,2,4]));
    });

    test("-5 by -2", (){
      expect(new Range.to(-5, -2), orderedEquals([0,-2,-4]));
    });
  });

  group("impossible range", (){
    test("a to b by negative", (){
      expect((){new Range(0, 10, -1);}, throwsA(new isInstanceOf<ArgumentError>()));
    });
    test("a to b by positive", (){
      expect((){new Range(0, -10, 1);}, throwsA(new isInstanceOf<ArgumentError>()));
    });
    test("a to b by 0", () {
      expect((){new Range(0, 10, 0);}, throwsA(new isInstanceOf<ArgumentError>()));
    });
  });

  //todo(tyoverby): Add tests for the remainder of illegal arguments
}