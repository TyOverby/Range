import 'dart:collection';

class RangeIterator extends Iterator<num> {
  final num start;
  final num end;
  final num step;
  
  num _current;
  
  RangeIterator(this.start, this.end, this.step){
    this._current = this.start - this.step;  
  }
  
  num get current => _current;
  
  bool moveNext() {
    _current += step;
    if (step > 0) {
      return _current < end;
    } else {
      return _current > end;
    }
  }
}

class Range extends Iterable<num> with IterableMixin<num> {
  final num start;
  final num end;
  final num step;
  
  Range(this.start, this.end, [this.step = 1]);
  Range.to(this.end, [this.step = 1]):start = 0;
  Range.toInfinity([this.start = 0, this.step = 1]): end = double.INFINITY;

 
  Iterator<num> get iterator {
    return new RangeIterator(start, end, step);
  }  
}

void main() {
  var a = new Range(-5,5);
  a.forEach(print);
  print(a.toList());
}
