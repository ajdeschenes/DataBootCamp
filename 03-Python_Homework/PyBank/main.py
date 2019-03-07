import csv
import os 

budgetpath = os.path.join('budget_data.csv')

with open(budgetpath, newline = '') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    rowCount = 0

    header = next(csv_reader)

    monthCount = 0 #for counting how many months
    netTotal = 0 #to hold the total of all the amounts
    month = "" #to hold the current month for i
    amount = 0 # tohold the amount for the current i
    lastAmount = 0 #to hold the amount for the previous i
    deltas = [] #to hold all of the deltas
    delta = 0 #to determine the change in amount from last month to current month
    averageDelta = 0 #to hold the average month to month change
    greatestAmount = 0 #to hold the highest amount
    greatestMonth = "" #to hold the month of the highest amount
    lowestAmount = 0 #to hold the lowest amount
    lowestMonth = "" #to hold the month of the latest amount

    for row in csv_reader:
        #define the current variables
        month = row[0]
        amount = int(row[1])
        
        #count the months (one per row)
        monthCount += 1
        
        #add amount to the running total CORRECT
        netTotal = netTotal + amount
        # test print(f"Total {netTotal}")

        if rowCount >= 1:
            #calculate the change from last month
            delta = amount - lastAmount #how do we set the previous amount?
            # test print(f"Delta {delta}")

            #add the change to the list of changes
            deltas.append(delta)
            # test print(f"Deltas {deltas}")

        #determine if the current amount is the greatest or lowest WRONG
        if amount > greatestAmount:
            greatestAmount = amount
            greatestMonth = month
            # test print(greatestMonth)
            # test print(greatestAmount)
        elif amount < lowestAmount:
            lowestAmount = amount
            lowestMonth = month
            # test print(lowestMonth)
            # test print(lowestAmount)
        
        #set lastAmount
        lastAmount = amount

        rowCount +=1

#calculate the average month to month change WRONG
averageDelta = sum(deltas)/len(deltas)

#print findings
print("Financial Analysis")
print("----------------------------")
print(f"Total Months: {monthCount}")
print(f"Total: ${netTotal}")
print(f"Average Change: ${averageDelta}")
print(f"Greatest Increase in Profits: {greatestMonth} (${greatestAmount})")
print(f"Greatest Decrease in Profits: {lowestMonth} (${lowestAmount})")
    

#write output to file

#open files
f = open('file.txt', 'w') 

#write to file
f.write("Financial Analysis\n----------------------------\nTotal Months: "+repr(monthCount)+"\nTotal: $"+repr(netTotal)+"\nAverage Change: $"+repr(averageDelta)+"\nGreatest Increase in Profits: "+repr(greatestMonth)+" ($"+repr(greatestAmount)+"\nGreatest Decrease in Profits: "+repr(lowestMonth)+" ($"+repr(lowestAmount)+")") #this will put the info in the file

#close file
f.close()

