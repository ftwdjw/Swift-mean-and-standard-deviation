//: Playground - noun: a place where people can play

import UIKit
import Accelerate

var str = "Hello, playground"

let testArray: [Int8] = [0, 1, 2, 3, 4]

func IntToDouble (a: [Int8] ) -> [Double] {
    
    //Converts an array of integer values to Double values
    
    
    var result = [Double](repeating:0, count: a.count)
    
    //vDSP_dotprD(a, 1, b, 1, &result, UInt(a.count))
    //vDSP_vsmulD(a, 1, &bb, &result, 1, UInt(a.count))
    //vDSP_vfixr8D(a, 1, &result, 1, UInt(a.count))
    vDSP_vflt8D( a, 1, &result, 1, UInt(a.count))
    return result
}

func meanStdDev (a: [Double] ) -> (mean: Double, standardDeviation: Double) {
    
    //Calculaltes the mean and the standar deviation of an array of Double numbers
    
    //To calculate the standard deviation of those numbers:
    /*
     Work out the Mean (the simple average of the numbers)
     Then for each number: subtract the Mean and square the result.
     Then work out the mean of those squared differences.
     Take the square root of that and we are done!*/
    
    //print("input array=\(a)")
    
    
    var myMean = 0.0
    var meanOfSquaredValues = 0.0
    var myStandardDeviation = 0.0
    var sum = 0.0
    var sumOfSquares = 0.0
    var difference = [Double](repeating:0.0, count: a.count)
    var squareOfDifference = [Double](repeating:0.0, count: a.count)
    
    //UInt(a.count)
    
    vDSP_sveD(a, 1, &sum, UInt(a.count))
    sum
    
    myMean = sum/Double(a.count)
    
    //print("mean=\(myMean)")
    
    var minusMean = -myMean
    
    
    vDSP_vsaddD(a, 1, &minusMean, &difference, 1, UInt(a.count))
    vDSP_vsqD(difference, 1, &squareOfDifference, 1, UInt(a.count))
    vDSP_sveD(squareOfDifference, 1, &sumOfSquares, UInt(a.count))
    
    meanOfSquaredValues = sumOfSquares/Double(a.count)
    
    myStandardDeviation = sqrt(meanOfSquaredValues)
    
    //print("standard deviation=\(myStandardDeviation)")
    
    return (mean: myMean, standardDeviation: myStandardDeviation)
}


let doubleTestArrray = IntToDouble(a: testArray )

print("double test array=\(doubleTestArrray)")

let (mean, standardDev) = meanStdDev(a: doubleTestArrray)




    print("mean=\(mean)")

    print("standard deviation=\(standardDev)")

func scalarProduct (a: [Double], b: Double) -> [Double] {
    //Computes the scalar product of vectors A and scalar B and leaves the result in output vector; double precision.
    var bb=b
    var result = [Double](repeating:0.0, count: a.count)
    
    //vDSP_dotprD(a, 1, b, 1, &result, UInt(a.count))
    vDSP_vsmulD(a, 1, &bb, &result, 1, UInt(a.count))
    return result
}

let timesTen = scalarProduct(a: doubleTestArrray, b: 10.0)

let (mean1, standardDev1) = meanStdDev(a: timesTen)


print("meanx10=\(mean1)")

print("standard deviationx10=\(standardDev1)")

// scaling the data by x10 scales thw mean and the standard deviation  by 10


