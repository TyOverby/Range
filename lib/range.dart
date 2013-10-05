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
  Range(this._start, this._end, [this._interval = 1]) {
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
  * Creates a [Range] starting at 0 to an [end] point.
  *
  * Functionally equivalent to
  *     new Range(0, end, interval);
  *
*/
  factory Range.to(num end, [num interval]) {
    if(interval == null) {
      interval = (end > 0) ? 1 : -1;
    }
    return new Range(0, end, interval);
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
    return new RangeIterator(_start, _end, _interval);
  }
}

