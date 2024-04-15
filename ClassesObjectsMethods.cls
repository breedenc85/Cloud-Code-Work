/**
 * The ClassesObjectsMethods class serves as an exploration into Object Oriented Programming in Apex.
 * It covers fundamental aspects such as class instantiation, method creation, encapsulation, and object interaction.
 *
 * This class introduces developers to the concept of creating and manipulating objects in Apex. It discusses
 * how to define classes, create methods, and use objects. This class uses two example classes - Person and Book.
 * 
 * Topics covered in this class include:
 * - Understanding how to define a class in Apex.
 * - Understanding how to create methods in Apex.
 * - Understanding how to instantiate objects of a class.
 * - Understanding encapsulation and the importance of getter and setter methods.
 *
 * Users of this class can expect to gain a strong understanding of Object Oriented Programming in Apex and
 * be prepared for more advanced topics in Salesforce development.
 * 
 * The Person class is a simple representation of a person with properties like name and age, and a method
 * that allows the person to introduce themselves.
 * 
 * The Book class is a simple representation of a book with properties like title and author, and methods
 * to read and close the book.
 * 
 * Resources:
 * String class: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm
 * Date class: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_date.htm
 * Math class: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_math.htm
 * Classes: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_understanding.htm
 *
 * @author Chad Breeden
 */

public with sharing class ClassesObjectsMethods {
    /**
     * It initializes a String to "Hello, Salesforce!" and demonstrates usage of
     * the length, substring, and toLowerCase methods of the String class.
     * Example: practiceStringMethods() should return a list like ["17", "Hello", "hello, salesforce!"].
     * @return A list containing the length of the string, a substring of the string, and the string in lower case.
     */
    public static List<String> practiceStringMethods() {
        String helloSalesforce = 'Hello, Salesforce!';
        Integer strLength = helloSalesforce.length();
        String strSubString = helloSalesforce.substring(0, 5);
        String strLower = helloSalesforce.toLowerCase();

        List <String> helloList = new List<String>();

        helloList.add(String.valueOf(strLength));
        helloList.add(strSubString);
        helloList.add(strLower);

        return helloList;
    }

    /**
     * Check if the input string starts with 'Sales', ends with 'Force', and contains 'Awesome'.
     * Example: checkStringContent('Salesforce is Awesome!') should return a list like [true, false, true].
     * @param input The input string.
     * @return A list of boolean values indicating whether the string starts with 'Sales', ends with 'Force', or contains 'Awesome'.
     */
    public static List<Boolean> checkStringContent(String input) {
        List<Boolean> result = new List<Boolean>();

        Boolean startsWith = input.startsWith('Sales');
        result.add(startsWith);

        Boolean endsWith = input.endsWith('Force');
        result.add(endsWith);

        Boolean contains = input.contains('Awesome');
        result.add(contains);
    
        return result; 
    }

    /**
     * Take a sentence then remove any duplicate words, and return the sentence with only unique words.
     * Example: removeDuplicateWords('Hello, Hello, Salesforce!') should return 'Hello, Salesforce!'.
     * @param sentence The input sentence.
     * @return A string consisting of only unique words from the input sentence.
     */
    public static String removeDuplicateWords(String sentence) {
        List<String> newList = new List<String>();
        newList = sentence.split(' ');
        Set<String> newSet = new Set<String>(newList);
        String joinedString = String.join(new List<String>(newSet), ' ');
        return joinedString; 
    }

    /**
     * This method takes a string as a parameter, and calculates the number of vowels in the string.
     * For simplicity, we will consider only five vowels: 'a', 'e', 'i', 'o', 'u', and we will ignore case.
     * Example: countVowels("Hello World!") should return 3
     * @param s The string in which to count vowels.
     * @return The number of vowels in the string.
     */
    public static Integer countVowels(String str) {
        Integer result = 0;

        for (Integer i = 0; i < str.length(); i ++) {
            String currentChar = str.substring(i, i + 1);
            if (currentChar == 'a' || currentChar == 'e' || currentChar == 'i' || currentChar == 'o' || currentChar == 'u') {
                result ++;
            }
        }
        return result; 
    }

    /**
     * Given a list of scientist names, combine their names together with a comma if it contains the letter 'g'.
     * The final string should not end with a comma.
     * Example: findTheScientist() should return "Alan Turing,Grace Hopper,Guido van Rossum,Stephen Hawking"
     * @return A string containing the names of scientists that contain the letter 'g'.
     */
    public static String findTheScientist() {
        List<String> scientistNames = new List<String>{'Tim Berners-Lee', 'Alan Turing', 'Grace Hopper', 'Donald Knuth', 'Guido van Rossum', 'Ken Thompson', 'Stephen Hawking'};

        String combinedNames = '';

        for (String name : scientistNames) {
            String lowerName = name.toLowerCase();
            if(!lowerName.contains('g')) {
                continue;
                } else {
                    combinedNames += name + ',';
                } 
        }

        combinedNames = combinedNames.removeEnd(',');
        return combinedNames;
    }

    /**
     * This method calculates the absolute value of the difference between of two input numbers that are raised to the 2nd power.
     * Example: calculateDifferenceOfSquares(3, 4) should return 7.
     * @param a The first number.
     * @param b The second number.
     * @return The absolute value of the difference
     */
    public static Double calculateDifferenceOfSquares(Double a, Double b) {
        Double doubleA = math.pow(a, 2);
        Double doubleB = math.pow(b, 2);
        Double result = math.abs(doubleA - doubleB);
        return result;
    }

    /**
     * Generate a random number between 50 and 100
     * Example: generateRandomNumber() should return a number like 75.
     * @return A integer between 50 and 100.
     */
    public static Integer generateRandomNumber() {
        Integer randomNumber = (Integer)Math.random() + 51;
        return randomNumber;
    }

    /**
     * Format the current date in the current user locale format.
     * Example: getCurrentDate() should return a string like "3/21/2001" for US locale users. Locale/String may differ depending on your location.
     * @return The current date in the current user locale format.
     */
    public static String getCurrentDate() {
        Date myDate = Date.today();
        String newDate = myDate.format();
        return newDate;
    }

    /**
     * Given a date time return the day of the week in number format
     * @param dt the current date and time
     * @return The number of the day of the week for the given date.
     */
    public static String getDayOfWeek(DateTime dt) {
        Map<String, Integer> dayMap = new Map<String, Integer>();
        dayMap.put('Monday', 1);
        dayMap.put('Tuesday', 2);
        dayMap.put('Wednesday', 3);
        dayMap.put('Thursday', 4);
        dayMap.put('Friday', 5);
        dayMap.put('Saturday', 6);
        dayMap.put('Sunday', 7);

        String dayName = dt.format('EEEE');
        Integer dayNumber = dayMap.get(dayName);
        return String.valueOf(dayNumber); 
    }

    /**
     * Calculate the difference between the years of two dates
     * For example, if the first date is 2023-01-01 and the second date is 2025-12-31, the method should return 2
     * If either of the dates is null, return null.
     * @param d1 The first date.
     * @param d2 The second date.
     * @return The a positive number years between the two dates, or null if either date is null.
     */
    public static Integer calculateYearDifference(Date d1, Date d2) {
        if(d1 == null || d2 == null) {
            return null;
        }

        Integer year1 = d1.year();
        Integer year2 = d2.year();
        Integer result = Math.abs(year1 - year2);
        return result;
    }

    /**
     * The Book class represents a book in a library. 
     * Each Book object has a title and an author, and methods to return these details.
     * This class can be used in the context of a library management system, bookstore, etc.
     * where you need to manipulate and manage book information.
     */
    public class Book {
        public String title;
        public String author;
        public Integer pages;
        
        public Book(String title, String author) {
            this.title = title;
            this.author = author;
        }
    
        public String getBookDetails() {
        return 'Title: ' + title + ', ' + 'Author: ' + author;
        }
    }
    
    /**
     * Create a Book object and returns the details of the book.
     * For example, createAndGetBookDetails() should return a string like "Title: A Brief History of Time, Author: Stephen Hawking".
     * @return A string containing the details of the book.
     */
    public static String createAndGetBookDetails() {
        Book newBook = new Book('A Brief History of Time', 'Stephen Hawking');
        String myBook = newBook.getBookDetails();
        return myBook; 
    }

    /**
     * Create and update two Book objects and returns the books.
     * For example, generateBookList(Book) should return a list like ["Title: Harry Potter and the Chamber of Secrets, Author: J.K. Rowling", "Title: A Brief History of Time, Author: Stephen Hawking"].
     * Update Book 1 values: title = "Harry Potter and the Chamber of Secrets", author = "J.K. Rowling", pages = 352
     * Book 2 values: title = "A Brief History of Time", author = "Stephen Hawking"
     * @param myBook1 The first book object.
     * @return return a list of books.
     */
    public static List<Book> generateBookList(Book myBook1) {
        List<Book> bookList = new List<Book>();

        myBook1.title = 'Harry Potter and the Chamber of Secrets';
        myBook1.author = 'J.K. Rowling';
        myBook1.pages = 352;

        Book myBook2 = new Book('A Brief History of Time', 'Stephen Hawking');
        myBook2.pages = 256;

        bookList.add(myBook1);
        bookList.add(myBook2);
        return bookList;  
    }

    /**
     * The Person class represents a person.
     * Each Person object has a name and an age, and methods to return these details.
     * This class can be used in the context of a school, college, etc.
     * where you need to manipulate and manage person information.
     */
    public class Person {
        private String name;
        private Integer age;

        public Person (String name, Integer age) {
            this.name = name;
            this.age = age;
        }

        public String introduceYourself() {
            return 'Hello, my name is ' + name + ' and I am ' + age + ' years old.';
        }

        public String getName() {
            return this.name;
        }

        public Integer getAge() {
            return this.age;
        }

        public void setName(String newName) {
            this.name = newName;
        }

        public void setAge(Integer newAge) {
            this.age = newAge;
        }
    }

    /**
     * Create a Person object and returns the details of the person.
     * For example, personDetails() should return a list like ["Hello, my name is John Doe and I am 28 years old.", "John Doe", "28"].
     * @return A string containing the details of the person.
     */

    public static List<String> personDetails() {
        List<String> results = new List<String>();
        Person newPerson = new Person('John Doe', 28);
    
        results.add(newPerson.introduceYourself());
        results.add(newPerson.getName());
        results.add(String.valueOf(newPerson.getAge()));
        return results; 
    }

    /**
     * Create a Person object with the provided name and age.
     * 
     * @param name The name of the person.
     * @param age The age of the person.
     * @return A new instance of the Person class.
     */
    public static Person createPerson(String name, Integer age) {
        Person newPerson = new Person(name, age);
        return newPerson;
    }

    /**
     * Create a method that constructs multiple Person objects.
     * You are to create a new Person object for each name in the provided List<String> of names,
     * using the same age for all Person objects. The method should return a List<Person> of all the Person objects created. 
     * @param names A list of names.
     * @param age The age to be set for all the Person objects.
     * @return A list of new Person objects.
     */
    public static List<Person> createMultiplePersons(List<String> names, Integer age) {
        List<Person> personList = new List<Person>();

        for(String name : names) {
            Person newPerson = new Person(name, age);
            personList.add(newPerson);
        }
        return personList;
    }


    /**
     * Compare two Person objects based on their ages.
     * If the first Person is older, the method should return the first Person. If the second Person is older, it should return the second Person.
     * If they are the same age, return either.
     *
     * @param person1 The first Person object.
     * @param person2 The second Person object.
     * @return The Person object of the older person.
     */
    public static Person getOlderPerson(Person person1, Person person2) {
        if(person1.age > person2.age) {
            return person1;
        } else {
            return person2;
        }
    }
}