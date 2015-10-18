// iterativno

// Funkcija vzame kot argument število iteracij, pri zadnji iteraciji izpiše seznam, pri ostalih pa sešteje zadnji dve številki in doda seznamu.

func fibIterative(iterations: Int) {
    var fibNumbersIter: [Int] = [0,1]
    for index in 2...iterations {
        if index == iterations {
            print(fibNumbersIter)
        }
        else {
            fibNumbersIter.append(fibNumbersIter[fibNumbersIter.count - 2] + fibNumbersIter[fibNumbersIter.count - 1])
        }
    }
    
}

fibIterative(6)

// rekurzivno

// Funkcija vzame kot argument število iteracij in array z defaultom [0,1], ko pride do konca, izpiše array, prej pa pokliče sebe z zmanjšanim iteratorjem in spremenjenim seznamom

func fibRecursive(iterations: Int, var fibNumbersIter: [Int] = [0,1]) {
    if iterations == 2 {
        print(fibNumbersIter)
    }
    else {
        fibNumbersIter.append(fibNumbersIter[fibNumbersIter.count-2] + fibNumbersIter[fibNumbersIter.count-1])
        fibRecursive(iterations-1, fibNumbersIter: fibNumbersIter)
    }
}

fibRecursive(6)

