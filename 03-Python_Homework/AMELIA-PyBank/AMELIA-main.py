import csv
import os 

budgetpath = os.path.join('AMELIA-budget_data.csv')

with open(budgetpath, newline = '') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    rowCount = 0

    header = next(csv_reader)

    monthCount = 0 #for counting how many months
    netTotal = 0 #to hold the total of all the amounts
    month = "" #to hold the current month for i
    amount = 0 # tohold the amount for the current i
    lastAmount = 0 #to hold the amount for the previous i
    deltas = {} #to hold all of the deltas
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
            deltas[month] = delta
            

        
        
        #set lastAmount
        lastAmount = amount

        rowCount +=1

# determine the greatest or lowest amount
# test print(f"Deltas {deltas}")
greatestAmount = max(deltas.values())
lowestAmount = min(deltas.values())
greatestMonth = [month for month,amount in deltas.items() if amount == greatestAmount][0]
lowestMonth = [month for month,amount in deltas.items() if amount == lowestAmount][0]

#calculate the average month to month change WRONG
averageDelta = sum(deltas.values())/len(deltas)

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
f = open('AMELIA-budget_summary.txt', 'w') 

#write to file
f.write("Financial Analysis\n----------------------------\nTotal Months: "+repr(monthCount)+"\nTotal: $"+repr(netTotal)+"\nAverage Change: $"+repr(averageDelta)+"\nGreatest Increase in Profits: "+repr(greatestMonth)+" ($"+repr(greatestAmount)+"\nGreatest Decrease in Profits: "+repr(lowestMonth)+" ($"+repr(lowestAmount)+")") #this will put the info in the file

#close file
f.close()

