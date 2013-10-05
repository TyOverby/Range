import 'dart:collection';

class RangeIterator extends Iterator<num> {
  final num start;
  final num end;
  final num interval;
  
  num _current;
  
  RangeIterator(this.start, this.end, this.interval){
    this._current = this.start - this.interval;
  }
  
  num get current => _current;
  
  bool moveNext() {
    _current += interval;
    if (interval > 0) {
      return _current < end;
    } else {
      return _current > end;
    }
  }
}

/**
  * An iterable that represents a sequence of numbers at an interval.  It
  * is named similarly to Python's `range` function.
  *
  * This class provides an easy way to create a sequence of numbers from a
  * starting point to an ending point via an interval.
*/
class Range extends Iterable<num> with IterableMixin<num> {
  num _start;
  num _end;
  num _interval;
  bool _inclusive;

/**
  * The standard way to create a [Range] with all possible options.
  *
  *     new Range(start, end, [interval])
  * returns a [Range] that has the specified start and end points and each value
  * of the iterator increases by [interval].  The range is inclusive on [start] but
  * exclusive on [end].
  *
  *     new Range(5, 10, 2); // is similar in concept to
  *     [5, 7, 9]
*/
  Range(this._start, this._end, [this._interval = 1, this._inclusive = false]) {
    if((this._end < this._start && this._interval > 0) ||
       (this._end > this._start && this._interval < 0) ||
       (this._interval == 0 || this._interval == double.INFINITY || this._interval == double.NEGATIVE_INFINITY ||
       this._start == double.INFINITY || this._start == double.NEGATIVE_INFINITY)) {
      throw new ArgumentError("Impossible range ($_start to $_end by $_interval)"
      "  Create infinite ranges with Range.infinite.");
    } else if(this._start == double.NAN) {
      throw new ArgumentError("Impossible range, start is NaN.");
    } else if(this._end == double.NAN) {
      throw new ArgumentError("Impossible range, end is NaN.");
    } else if (this._interval == double.NAN) {
      throw new ArgumentError("Impossible range, interval is NaN.");
    }
  }


/**
  * Creates an infinite [Range] that has a [start] point and an [interval] but no end.
  *
  * While this constructor can be simulated by a call to the default [Range] constructor,
  * it is a bit more complicated.  Judging by the sign of the interval the [end]  of the [Range]
  * will be either be positive or negative.
  *
  *     new Range.infinite(5, 2);
  *     // will produce:
  *     new Range(5, double.INFINITY, 2);
  *
  *     // while
  *     new Range.infinite(5, -2);
  *     // will produce:
  *     new Range(5, double.NEGATIVE_INFINITY, -2);
  *
*/
  factory Range.infinite([num start = 0, num interval = 1]){
    if(interval > 0) {
      return new Range(start, double.INFINITY, interval);
    } else {
      return new Range(start, double.NEGATIVE_INFINITY, interval);
    }
  }

  Iterator<num> get iterator {
    if(_inclusive){
      return new RangeIterator(_start, _end + _interval, _interval);
    }
    return new RangeIterator(_start, _end, _interval);
  }
}

/**
 * A port of the python range() function with the distinction that 
 * any impossible ranges (ie: 0 to 5 by -2) will error instead of providing 
 * an empty iterator.
 */
Range py_range(num a, [num b, num c]){
  // Only one number provided
  if(b == null) {
    return new Range(0, a, 1);
  } else if (c == null) {
    return new Range(a, b, 1);
  } else {
    return new Range(a, b, c);
  }
}

/**
 * A quick way to name parameters given sane defaults.
 * 
 * [start]: defaults to 0.
 * [end]: defaults to infinity or negative infinity depending on step.
 * [step]: defaults to -1 or 1 depending on if start or end is larger.
 * [inc]: defaults to false.
 */
Range range({num start, num end, num step, bool inc}) {
  if(start == null) {
    start = 0;
  }
  if(end == null) {
    if(step == null){
      end = double.INFINITY;
    } else {
      if(step > 0) {
        end = double.INFINITY;
      } else {
        end = double.NEGATIVE_INFINITY;
      }
    }    
  }
  if(step == null) {
    if(end > start) {
      step = 1;
    } else {
      step = -1;
    }
  }
  if(inc == null) {
    inc = false;
  }
  return new Range(start, end, step, inc);
}