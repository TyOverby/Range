import 'package:unittest/unittest.dart';
import '../lib/range.dart';

void main() {
  group("Finite range | positive increment | integer values", (){
    test("0 to 10", (){
      expect(new Range(0,10).toList(), orderedEquals([0,1,2,3,4,5,6,7,8,9]));
    });
    test("-5 to 5", (){
      expect(new Range(-5, 5).toList(), orderedEquals([-5,-4,-3,-2,-1,0,1,2,3,4]));
    });
    test("-10 to 0", (){
      expect(new Range(-10, 0).toList(), orderedEquals([-10,-9,-8,-7,-6,-5,-4,-3,-2,-1]));
    });
  });
  
  group("Finite range | negative increment | integer values", () {
    test("10 to 0", () {
      expect(new Range(10, 0, -1).toList(), orderedEquals([10,9,8,7,6,5,4,3,2,1]));
    });
    test("5 to -5", (){
      expect(new Range(5, -5, -1).toList(), orderedEquals([5,4,3,2,1,0,-1,-2,-3,-4]));
    });
    test("0 to -10", (){
      expect(new Range(0, -10, -1).toList(), orderedEquals([0,-1,-2,-3,-4,-5,-6,-7,-8,-9]));
    });
  });
  
  group("Finite range | positive increment | double values", (){
    test("0 to 5 by 0.5", (){
      expect(new Range(0,5,0.5).toList(), orderedEquals([0,0.5,1,1.5,2,2.5,3,3.5,4,4.5]));
    });
    test("-2 to 2 by 0.5", (){
      expect(new Range(-2, 2, 0.5).toList(), orderedEquals([-2,-1.5, -1, -0.5,0,0.5,1,1.5]));
    });
    test("-5 to 0 by 0.5", (){
      expect(new Range(-5, 0, 0.5).toList(), orderedEquals([-5,-4.5,-4,-3.5,-3, ]));
    });
  });
}