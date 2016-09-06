
#include <iostream>

template< unsigned n>
struct factorial {
	static const unsigned value = n * factorial<n-1>::value;
};

template<>
struct factorial<0> {
	static const unsigned value = 1;
};

int main(){
	const struct factorial<10> n;
	std::cout << n.value << std::endl;
	
	const unsigned int gift = 20;
	const struct factorial<gift> n2;
	std::cout << n2.value << std::endl;

	return 0;
}
