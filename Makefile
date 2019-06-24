CFLAGS = -std=c99 -g -Wall -Wshadow --pedantic -Wvla -Werror
COVFLAGS = -fprofile-arcs -ftest-coverage
PROFFLAG = -pg
GCC = gcc $(CFLAGS) # $(COVFLAGS) $(PROFFLAG)
OBJS =  pa03.o answer03.c
FUNCS = func1.o func2.o func3.o func4.o func5.o

# This Makefile can be shortened by using loop. 
# It shows all steps to explain what it does

all: pa03a pa03b

#Build pa03 using integrate1, and all five functions
#Creates 5 different executables, because of the dependences
pa03a: pa03-func1-1 pa03-func2-1 pa03-func3-1 pa03-func4-1 pa03-func5-1
	

#Build pa03 using integrate2, and all five functions
#Creates 5 different executables, because of the dependences
pa03b: pa03-func1-2 pa03-func2-2 pa03-func3-2 pa03-func4-2 pa03-func5-2
	

#build each of the executables for integrate1
pa03-func1-1: pa03a.o answer03.o func1.o
	$(GCC) pa03a.o answer03.o func1.o -o pa03-func1-1

pa03-func2-1: pa03a.o answer03.o func2.o
	$(GCC) pa03a.o answer03.o func2.o -o pa03-func2-1	

pa03-func3-1: pa03a.o answer03.o func3.o
	$(GCC) pa03a.o answer03.o func3.o -o pa03-func3-1

pa03-func4-1: pa03a.o answer03.o func4.o
	$(GCC) pa03a.o answer03.o func4.o -o pa03-func4-1 -lm

pa03-func5-1: pa03a.o answer03.o func5.o
	$(GCC) pa03a.o answer03.o func5.o -o pa03-func5-1 -lm

#build each of the executables for integrate2
pa03-func1-2: pa03b.o answer03.o func1.o
	$(GCC) pa03b.o answer03.o func1.o -o pa03-func1-2

pa03-func2-2: pa03b.o answer03.o func2.o
	$(GCC) pa03b.o answer03.o func2.o -o pa03-func2-2	

pa03-func3-2: pa03b.o answer03.o func3.o
	$(GCC) pa03b.o answer03.o func3.o -o pa03-func3-2

pa03-func4-2: pa03b.o answer03.o func4.o
	$(GCC) pa03b.o answer03.o func4.o -o pa03-func4-2 -lm

pa03-func5-2: pa03b.o answer03.o func5.o
	$(GCC) pa03b.o answer03.o func5.o -o pa03-func5-2 -lm

#build pa03 with integrate1
pa03a.o: pa03.c pa03.h
	$(GCC) -c -DINTEGRATE_1 pa03.c -o pa03a.o

#build pa03 with integrate2
pa03b.o: pa03.c pa03.h
	$(GCC) -c -DINTEGRATE_1 -DINTEGRATE_2 pa03.c -o pa03b.o

#compile answer03
answer03.o: answer03.c pa03.h
	$(GCC) -c answer03.c

#compile func1
func1.o: func1.c
	$(GCC) -c func1.c

#compile func2
func2.o: func2.c
	$(GCC) -c func2.c

#compile func3
func3.o: func3.c
	$(GCC) -c func3.c

#compile func4
func4.o: func4.c
	$(GCC) -c func4.c

#compile func5
func5.o: func5.c
	$(GCC) -c func5.c

# test integrate1 using five different functions
# each function is tested using three sets of input data
pa03-test1: pa03a
	echo "testing integrate1"
	echo "testing func1"
	./pa03-func1-1 tests/test-func1-1 
	./pa03-func1-1 tests/test-func1-2
	./pa03-func1-1 tests/test-func1-3 
	echo "testing func2"
	./pa03-func2-1 tests/test-func2-1
	./pa03-func2-1 tests/test-func2-2
	./pa03-func2-1 tests/test-func2-3
	echo "testing func3"
	./pa03-func3-1 tests/test-func3-1 
	./pa03-func3-1 tests/test-func3-2
	./pa03-func3-1 tests/test-func3-3 
	echo "testing func4"
	./pa03-func4-1 tests/test-func4-1
	./pa03-func4-1 tests/test-func4-2
	./pa03-func4-1 tests/test-func4-3
	echo "testing func5"
	./pa03-func5-1 tests/test-func5-1
	./pa03-func5-1 tests/test-func5-2
	./pa03-func5-1 tests/test-func5-3

	# test integrate2
pa03-test2: pa03b
	echo "testing integrate2"
	echo "testing func1"
	./pa03-func1-2 tests/test-func1-1 
	./pa03-func1-2 tests/test-func1-2
	./pa03-func1-2 tests/test-func1-3 
	echo "testing func2"
	./pa03-func2-2 tests/test-func2-1
	./pa03-func2-2 tests/test-func2-2
	./pa03-func2-2 tests/test-func2-3
	echo "testing func3"
	./pa03-func3-2 tests/test-func3-1 
	./pa03-func3-2 tests/test-func3-2
	./pa03-func3-2 tests/test-func3-3 
	echo "testing func4"
	./pa03-func4-2 tests/test-func4-1
	./pa03-func4-2 tests/test-func4-2
	./pa03-func4-2 tests/test-func4-3
	echo "testing func5"
	./pa03-func5-2 tests/test-func5-1
	./pa03-func5-2 tests/test-func5-2
	./pa03-func5-2 tests/test-func5-3

# generate 15 test cases: 5 functions and 3 test cases per function
testgen: testgen.c answer03.c pa03.h | testdir
	$(GCC) -DINTEGRATE_1 testgen.c answer03.c func1.c -o testgen
	./testgen test-func1-1 1.0 2.0 10000
	./testgen test-func1-2 -1.0 3.0 10000
	./testgen test-func1-3 0.8 2.9 10000
	$(GCC) -DINTEGRATE_1 testgen.c answer03.c func2.c -o testgen
	./testgen test-func2-1 11.0 22.0 5000
	./testgen test-func2-2 -15.0 3.0 10000
	./testgen test-func2-3 -0.7 12.9 10000
	$(GCC) -DINTEGRATE_1 testgen.c answer03.c func3.c -o testgen
	./testgen test-func3-1 1.5 2.6 10000
	./testgen test-func3-2 -1.0 31.0 20000
	./testgen test-func3-3 0.8 2.9 100000
	$(GCC) -DINTEGRATE_1 testgen.c answer03.c func4.c -o testgen -lm
	./testgen test-func4-1 1.0 2.0 10000
	./testgen test-func4-2 -1.0 3.0 10000
	./testgen test-func4-3 0.8 2.9 100000
	$(GCC) -DINTEGRATE_1 testgen.c answer03.c func5.c -o testgen -lm
	./testgen test-func5-1 1.0 2.0 100000
	./testgen test-func5-2 -1.0 3.0 100000
	./testgen test-func5-3 0.8 2.9 100000
	mv test-func* tests/

testdir:
	mkdir -p tests

clean:
	/bin/rm -f input*
	/bin/rm -f *.o
	/bin/rm -f testgen test??
	/bin/rm -f *.gcda *.gcno gmon.out *gcov
	/bin/rm -f pa03-func*



