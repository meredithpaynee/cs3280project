import mysql.connector
import datetime

#open database
conn = mysql.connector.connect(
        host='localhost',
        password= 'Georgia112203!!',
        user= 'root',
        database = "phase_3")

#check connection
if conn.is_connected():
        print("connection established...")

def createReport(Employee_Number, ISBN, Card_Number, Current_Date):
        #this function creates a report of the title being checked out and includes who checked it out and the required return date. It accesses REPORT and ADMIN tables
        #Input: Employee number, ISBN number, card number, current date

        cursor = conn.cursor()

        #1. Access the title of the book and required return date (calculated by adding 30 days to current date)
        cursor.execute("SELECT Title FROM Book WHERE ISBN = %s", (ISBN,))
        Title = cursor.fetchone()[0]
        Return_Date = Current_Date + datetime.timedelta(days = 30)

        #2. Compile card number, ISBN number, title and required return date
        Report_Info = (Card_Number, ISBN, Title, Return_Date, Employee_Number)
        Creates_Report_Info = (Employee_Number, Card_Number, ISBN)

        #3. Insert the report into the report table
        cursor.execute("INSERT INTO Report(Report_Num, Card_Num, ISBN, Title, Return_Date, Employee_Num) VALUES (DEFAULT, %s, %s, %s, %s, %s)", Report_Info)
        cursor.execute("INSERT INTO Creates_Report (Employee_Num, Card_Num, ISBN) VALUES (%s, %s, %s)", Creates_Report_Info)
        conn.commit()

        #4. Display title and “successful report”
        print("\nReport Created - Title: ", Title, "\nSuccessful Report.")

        

def reserveBook(ISBN, Card_Number, Employee_Number, Current_Date):
        #this function lets the user check out a title. It accesses USER, ADMIN, and BOOK tables
	#Input: ISBN number, card number, employee number, current date
        
        cursor = conn.cursor()

        #1. Check availability of the title in the BOOK table
        cursor.execute("SELECT Num_Available FROM Book WHERE ISBN = %s ", (ISBN,))
        Result = cursor.fetchone()

        if Result and Result[0] > 0:
                
                #2. Access the library card number in the USER table
                cursor.execute("Select First_Name, Last_Name FROM Library_User WHERE Card_Num = %s", (Card_Number,))
                User_Info = cursor.fetchone()

                if User_Info:
                        User_Name = User_Info[0] + " " + User_Info[1]

                        #3. Check out the book, subtract one from number available
                        cursor.execute("UPDATE Book SET Num_Available = Num_Available - 1 WHERE ISBN = %s", (ISBN,))
                        conn.commit()
                        Return_Date = Current_Date + datetime.timedelta(days = 30)
                        Reserves_Info = (Card_Number, Employee_Number, ISBN, Return_Date)
                        cursor.execute("INSERT INTO Reserves(Card_Num, Employee_Num, ISBN, Return_Date) VALUES (%s, %s, %s, %s)", Reserves_Info)
                        conn.commit()
                        
                        #4. Display title of book, first and last name of the user, and return date
                        cursor.execute("SELECT Book.Title FROM Book WHERE Book.ISBN = %s", (ISBN,))
                        Book_Title = cursor.fetchone()
                        print("\nBook Reserved - Title: ", Book_Title, "\nUser: ", User_Name, "\nReturn Date: ", Return_Date)

                        #5. Call Create_Report in order to document that a book has been checked ou
                        createReport(Employee_Number, ISBN, Card_Number, Current_Date)
                else:
                        print("\nUser not found.\n")
        else:
                print("\nBook not available.\n")



def addBookToLibrary(Title, ISBN, Author, Publisher_ID):
        #This function adds a book to a library if a publisher contacts admin in order to get their title added. It accesses ADMIN and PUBLISHER tables
        #Input: Title, ISBN number, author, publisher ID

        cursor = conn.cursor()

        #1. Check if book is already in library.
        cursor.execute("SELECT * FROM Book WHERE ISBN = %s", (ISBN,))
        Result = cursor.fetchone()
        if Result:
                #If it is, add one to num_total
                cursor.execute("UPDATE Book SET Num_Total = Num_Total + 1 WHERE ISBN = %s", (ISBN,))
                conn.commit()
        else:
                #2. If it is not, compile title, number available, number total, ISBN number, author, and publisher id. Set num_total to 1 and num_borrowed to 0.
                Book_Info = (ISBN, 1, 1, Author, Title, Publisher_ID)
                
                #3. Add book to BOOK table
                cursor.execute("INSERT INTO Book (ISBN, Num_Total, Num_Available, Author, Title, Publisher_ID) VALUES (%s, %s, %s, %s, %s, %s)", Book_Info)
                conn.commit()
                
        #4. Display title, publisher name, and author
        print("\nBook Added - Title: ", Title, "\nAuthor: ", Author, "\nPublisher ID: ", Publisher_ID)

from datetime import date
today = date.today()

#createReport(Employee_Number, ISBN, Card_Number, Current_Date)
createReport(102, 1345678901, 502176, today)
#reserveBook(ISBN, Card_Number, Employee_Number, Current_Date)
reserveBook(1234567890, 931845, 103, today)
reserveBook(1567890123, 784329, 105, today)
#AddBookToLibrary(Title, ISBN, Author, Publisher_ID)
addBookToLibrary("1984", 2034586202, "George Orwell", 1002)

conn.close()
              


