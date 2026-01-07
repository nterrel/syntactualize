// C++ basics / syntax notes
// Compile: g++ -std=c++20 -Wall -Wextra -o basics basics.cpp
// Run: ./basics

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <set>
#include <algorithm>
#include <numeric>
#include <memory>
#include <optional>
#include <variant>
#include <tuple>
#include <functional>
#include <sstream>
#include <iomanip>

using namespace std;

// --- Helper to print section headers ---
void section(const string& title) {
    cout << "\n" << string(title.length(), '=') << "\n";
    cout << title << "\n";
    cout << string(title.length(), '=') << "\n";
}

// --- Basic types and variables ---
void demo_types_and_variables() {
    section("Types and Variables");
    
    // Fundamental types
    int i = 42;
    double d = 3.14159;
    bool b = true;
    char c = 'A';
    
    cout << "int: " << i << "\n";
    cout << "double: " << d << "\n";
    cout << "bool: " << boolalpha << b << "\n";
    cout << "char: " << c << "\n";
    
    // Auto type deduction (C++11)
    auto x = 10;        // int
    auto y = 3.14;      // double
    auto s = "hello"s;  // std::string (with 's' literal)
    
    cout << "auto x: " << x << " (int)\n";
    cout << "auto y: " << y << " (double)\n";
    cout << "auto s: " << s << " (string)\n";
    
    // Constants
    const int MAX_SIZE = 100;
    constexpr int COMPILE_TIME_CONST = 50;
    
    cout << "const: " << MAX_SIZE << "\n";
    cout << "constexpr: " << COMPILE_TIME_CONST << "\n";
}

// --- References and pointers ---
void demo_references_and_pointers() {
    section("References and Pointers");
    
    int value = 42;
    
    // Reference (alias to variable)
    int& ref = value;
    ref = 100;
    cout << "After ref=100, value: " << value << "\n";
    
    // Pointer
    int* ptr = &value;
    cout << "Pointer address: " << ptr << "\n";
    cout << "Pointer value: " << *ptr << "\n";
    
    *ptr = 200;
    cout << "After *ptr=200, value: " << value << "\n";
    
    // Null pointer
    int* null_ptr = nullptr;  // C++11, prefer over NULL
    cout << "nullptr: " << null_ptr << "\n";
}

// --- Strings ---
void demo_strings() {
    section("Strings");
    
    string s1 = "Hello";
    string s2 = "World";
    
    // Concatenation
    string s3 = s1 + " " + s2;
    cout << "Concatenated: " << s3 << "\n";
    
    // Length
    cout << "Length: " << s3.length() << "\n";
    
    // Substring
    cout << "Substring [0,5): " << s3.substr(0, 5) << "\n";
    
    // Find
    size_t pos = s3.find("World");
    cout << "Position of 'World': " << pos << "\n";
    
    // String literals (C++14)
    auto str = "Raw string"s;
    auto raw = R"(Can have "quotes" and \backslashes)"s;
    cout << "Raw string: " << raw << "\n";
}

// --- Control flow ---
void demo_control_flow() {
    section("Control Flow");
    
    // If/else
    int x = 10;
    if (x > 5) {
        cout << "x > 5\n";
    } else if (x > 0) {
        cout << "x > 0\n";
    } else {
        cout << "x <= 0\n";
    }
    
    // Ternary operator
    string result = (x % 2 == 0) ? "even" : "odd";
    cout << x << " is " << result << "\n";
    
    // Switch statement
    int day = 3;
    switch (day) {
        case 1:
            cout << "Monday\n";
            break;
        case 2:
            cout << "Tuesday\n";
            break;
        case 3:
            cout << "Wednesday\n";
            break;
        default:
            cout << "Other day\n";
    }
    
    // For loop
    cout << "For loop: ";
    for (int i = 0; i < 5; i++) {
        cout << i << " ";
    }
    cout << "\n";
    
    // Range-based for loop (C++11)
    vector<int> nums = {1, 2, 3, 4, 5};
    cout << "Range-for: ";
    for (int n : nums) {
        cout << n << " ";
    }
    cout << "\n";
    
    // While loop
    int count = 0;
    cout << "While: ";
    while (count < 3) {
        cout << count << " ";
        count++;
    }
    cout << "\n";
}

// --- Vectors (dynamic arrays) ---
void demo_vectors() {
    section("Vectors");
    
    // Create vector
    vector<int> vec = {1, 2, 3, 4, 5};
    
    // Add elements
    vec.push_back(6);
    vec.push_back(7);
    
    cout << "Vector: ";
    for (int v : vec) {
        cout << v << " ";
    }
    cout << "\n";
    
    // Size and capacity
    cout << "Size: " << vec.size() << "\n";
    cout << "Capacity: " << vec.capacity() << "\n";
    
    // Access elements
    cout << "vec[0]: " << vec[0] << "\n";
    cout << "vec.at(1): " << vec.at(1) << "\n";
    cout << "vec.front(): " << vec.front() << "\n";
    cout << "vec.back(): " << vec.back() << "\n";
    
    // Iterate with iterators
    cout << "Using iterators: ";
    for (auto it = vec.begin(); it != vec.end(); ++it) {
        cout << *it << " ";
    }
    cout << "\n";
}

// --- Maps (key-value pairs) ---
void demo_maps() {
    section("Maps");
    
    // Map (ordered by key)
    map<string, int> ages;
    ages["Alice"] = 30;
    ages["Bob"] = 25;
    ages["Charlie"] = 35;
    
    cout << "Map:\n";
    for (const auto& [name, age] : ages) {  // Structured binding (C++17)
        cout << "  " << name << ": " << age << "\n";
    }
    
    // Check if key exists
    if (ages.find("Alice") != ages.end()) {
        cout << "Alice found, age: " << ages["Alice"] << "\n";
    }
    
    // Insert with pair
    ages.insert({"David", 28});
    cout << "After insert, size: " << ages.size() << "\n";
}

// --- Sets ---
void demo_sets() {
    section("Sets");
    
    set<int> s = {3, 1, 4, 1, 5, 9, 2, 6};  // Duplicates removed, sorted
    
    cout << "Set: ";
    for (int val : s) {
        cout << val << " ";
    }
    cout << "\n";
    
    // Insert
    s.insert(7);
    s.insert(1);  // Duplicate, won't be added
    
    // Check membership
    if (s.count(5)) {
        cout << "5 is in the set\n";
    }
    
    cout << "Size: " << s.size() << "\n";
}

// --- Functions ---
int add(int a, int b) {
    return a + b;
}

// Function with default arguments
int multiply(int a, int b = 2) {
    return a * b;
}

// Function overloading
double multiply(double a, double b) {
    return a * b;
}

// Pass by reference
void increment(int& x) {
    x++;
}

// Pass by const reference (efficient for large objects)
void print_vector(const vector<int>& vec) {
    for (int v : vec) {
        cout << v << " ";
    }
    cout << "\n";
}

void demo_functions() {
    section("Functions");
    
    cout << "add(5, 3): " << add(5, 3) << "\n";
    cout << "multiply(4): " << multiply(4) << "\n";
    cout << "multiply(3, 5): " << multiply(3, 5) << "\n";
    cout << "multiply(2.5, 3.0): " << multiply(2.5, 3.0) << "\n";
    
    int x = 10;
    increment(x);
    cout << "After increment(x): " << x << "\n";
    
    vector<int> v = {1, 2, 3};
    cout << "print_vector: ";
    print_vector(v);
}

// --- Lambda expressions (C++11) ---
void demo_lambdas() {
    section("Lambda Expressions");
    
    // Simple lambda
    auto greet = []() {
        cout << "Hello from lambda!\n";
    };
    greet();
    
    // Lambda with parameters
    auto sum = [](int a, int b) {
        return a + b;
    };
    cout << "sum(3, 4): " << sum(3, 4) << "\n";
    
    // Capture by value
    int x = 10;
    auto add_x = [x](int y) {
        return x + y;
    };
    cout << "add_x(5): " << add_x(5) << "\n";
    
    // Capture by reference
    int count = 0;
    auto increment = [&count]() {
        count++;
    };
    increment();
    increment();
    cout << "After 2 increments: " << count << "\n";
    
    // Using with algorithms
    vector<int> nums = {1, 2, 3, 4, 5};
    auto doubled = nums;
    transform(doubled.begin(), doubled.end(), doubled.begin(),
              [](int n) { return n * 2; });
    cout << "Doubled: ";
    for (int n : doubled) cout << n << " ";
    cout << "\n";
}

// --- Classes and structs ---
class Rectangle {
private:
    double width;
    double height;
    
public:
    // Constructor
    Rectangle(double w, double h) : width(w), height(h) {}
    
    // Member functions
    double area() const {
        return width * height;
    }
    
    double perimeter() const {
        return 2 * (width + height);
    }
    
    // Getters
    double get_width() const { return width; }
    double get_height() const { return height; }
    
    // Setters
    void set_width(double w) { width = w; }
    void set_height(double h) { height = h; }
};

// Struct (like class but members are public by default)
struct Point {
    double x;
    double y;
    
    // Can have methods too
    double distance_from_origin() const {
        return sqrt(x * x + y * y);
    }
};

void demo_classes() {
    section("Classes and Structs");
    
    Rectangle rect(5.0, 3.0);
    cout << "Rectangle(5, 3):\n";
    cout << "  Area: " << rect.area() << "\n";
    cout << "  Perimeter: " << rect.perimeter() << "\n";
    
    rect.set_width(10.0);
    cout << "After set_width(10):\n";
    cout << "  Area: " << rect.area() << "\n";
    
    Point p{3.0, 4.0};  // Aggregate initialization
    cout << "Point(3, 4):\n";
    cout << "  Distance from origin: " << p.distance_from_origin() << "\n";
}

// --- Templates ---
template<typename T>
T maximum(T a, T b) {
    return (a > b) ? a : b;
}

template<typename T>
class Stack {
private:
    vector<T> elements;
    
public:
    void push(const T& elem) {
        elements.push_back(elem);
    }
    
    T pop() {
        if (elements.empty()) {
            throw runtime_error("Stack is empty");
        }
        T elem = elements.back();
        elements.pop_back();
        return elem;
    }
    
    bool empty() const {
        return elements.empty();
    }
    
    size_t size() const {
        return elements.size();
    }
};

void demo_templates() {
    section("Templates");
    
    cout << "maximum(5, 3): " << maximum(5, 3) << "\n";
    cout << "maximum(3.7, 2.1): " << maximum(3.7, 2.1) << "\n";
    cout << "maximum('z', 'a'): " << maximum('z', 'a') << "\n";
    
    Stack<int> int_stack;
    int_stack.push(10);
    int_stack.push(20);
    int_stack.push(30);
    
    cout << "Stack size: " << int_stack.size() << "\n";
    cout << "Popping: " << int_stack.pop() << "\n";
    cout << "Popping: " << int_stack.pop() << "\n";
}

// --- Smart pointers (C++11) ---
void demo_smart_pointers() {
    section("Smart Pointers");
    
    // unique_ptr - exclusive ownership
    unique_ptr<int> p1 = make_unique<int>(42);
    cout << "unique_ptr value: " << *p1 << "\n";
    
    // Transfer ownership with move
    unique_ptr<int> p2 = std::move(p1);
    cout << "After move, p2: " << *p2 << "\n";
    cout << "p1 is now: " << (p1 ? "valid" : "nullptr") << "\n";
    
    // shared_ptr - shared ownership
    shared_ptr<string> s1 = make_shared<string>("Hello");
    shared_ptr<string> s2 = s1;  // Both point to same object
    
    cout << "shared_ptr use_count: " << s1.use_count() << "\n";
    cout << "s1: " << *s1 << ", s2: " << *s2 << "\n";
}

// --- Optional (C++17) ---
optional<int> divide_safe(int a, int b) {
    if (b == 0) {
        return nullopt;  // Represents no value
    }
    return a / b;
}

void demo_optional() {
    section("std::optional");
    
    auto result1 = divide_safe(10, 2);
    if (result1.has_value()) {
        cout << "10 / 2 = " << result1.value() << "\n";
    }
    
    auto result2 = divide_safe(10, 0);
    if (result2.has_value()) {
        cout << "10 / 0 = " << result2.value() << "\n";
    } else {
        cout << "10 / 0 = Error (division by zero)\n";
    }
    
    // Value_or provides default
    cout << "Result or default: " << result2.value_or(-1) << "\n";
}

// --- Variant (C++17) ---
void demo_variant() {
    section("std::variant");
    
    // Variant can hold one of several types
    variant<int, double, string> v;
    
    v = 42;
    cout << "Variant holds int: " << get<int>(v) << "\n";
    
    v = 3.14;
    cout << "Variant holds double: " << get<double>(v) << "\n";
    
    v = "Hello"s;
    cout << "Variant holds string: " << get<string>(v) << "\n";
    
    // Check which type is held
    cout << "Index: " << v.index() << " (string is index 2)\n";
    
    // Visit variant
    visit([](auto&& arg) {
        cout << "Visiting: " << arg << "\n";
    }, v);
}

// --- Algorithms ---
void demo_algorithms() {
    section("Algorithms");
    
    vector<int> nums = {5, 2, 8, 1, 9, 3};
    
    // Sort
    sort(nums.begin(), nums.end());
    cout << "Sorted: ";
    for (int n : nums) cout << n << " ";
    cout << "\n";
    
    // Find
    auto it = find(nums.begin(), nums.end(), 8);
    if (it != nums.end()) {
        cout << "Found 8 at position: " << distance(nums.begin(), it) << "\n";
    }
    
    // Count
    vector<int> data = {1, 2, 2, 3, 2, 4};
    int count_2 = count(data.begin(), data.end(), 2);
    cout << "Count of 2: " << count_2 << "\n";
    
    // Accumulate (sum)
    int sum = accumulate(nums.begin(), nums.end(), 0);
    cout << "Sum: " << sum << "\n";
    
    // Min/Max
    cout << "Min: " << *min_element(nums.begin(), nums.end()) << "\n";
    cout << "Max: " << *max_element(nums.begin(), nums.end()) << "\n";
    
    // All_of, any_of, none_of
    bool all_positive = all_of(nums.begin(), nums.end(), [](int n) { return n > 0; });
    cout << "All positive: " << boolalpha << all_positive << "\n";
}

// --- Exception handling ---
void demo_exceptions() {
    section("Exception Handling");
    
    try {
        vector<int> vec = {1, 2, 3};
        cout << "vec.at(1): " << vec.at(1) << "\n";
        
        // This will throw out_of_range
        cout << "vec.at(10): " << vec.at(10) << "\n";
    }
    catch (const out_of_range& e) {
        cout << "Caught exception: " << e.what() << "\n";
    }
    catch (...) {
        cout << "Caught unknown exception\n";
    }
    
    cout << "Execution continues after exception\n";
}

// --- Enums ---
enum Color { RED, GREEN, BLUE };

enum class Status {  // Scoped enum (C++11)
    SUCCESS,
    ERROR,
    PENDING
};

void demo_enums() {
    section("Enums");
    
    Color c = RED;
    cout << "Color value: " << c << "\n";
    
    Status s = Status::SUCCESS;
    if (s == Status::SUCCESS) {
        cout << "Operation successful\n";
    }
}

// --- Main function ---
int main() {
    cout << "C++ Basics Demonstration\n";
    cout << "========================\n";
    
    demo_types_and_variables();
    demo_references_and_pointers();
    demo_strings();
    demo_control_flow();
    demo_vectors();
    demo_maps();
    demo_sets();
    demo_functions();
    demo_lambdas();
    demo_classes();
    demo_templates();
    demo_smart_pointers();
    demo_optional();
    demo_variant();
    demo_algorithms();
    demo_exceptions();
    demo_enums();
    
    cout << "\nDone! This covers core C++ syntax and features.\n";
    
    return 0;
}
