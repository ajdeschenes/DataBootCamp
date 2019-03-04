import csv

with open('budget_data.csv', newline = '') as csv_file:
    PyBank_Contents = csv.reader(csv_file, delimiter=',')
    rowCount = 0

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
        if rowCount >=1:
                #define the current variables
                month = row["Date"]
                amount = row["Profit/Losses"]
                
                #count the months (one per row)
                monthCount += 1
                
                #add amount to the running total
                netTotal = netTotal + amount

                #calculate the change from last month
                delta = amount - lastAmount #how do we set the previous amount?

                #add the change to the list of changes
                deltas.append(delta)

                #determine if the current amount is the greatest or lowest
                if amount > greatestAmount:
                    greatestAmount = amount
                    greatestMonth = month
                elif amount < lowestAmount:
                    lowestAmount = amount
                    lowestMonth = month

#calculate the average month to month change
averageDelta = sum(deltas)/len(deltas)

#print findings
print("Financial Analysis")
print("----------------------------")
print(f"Total Months: {monthCount}")
print(f"Total: {netTotal}")
print(f"Average Change: {averageDelta}")
print(f"Greatest Increase in Profits: {greatestMonth} (${greatestAmount})")
print(f"Greatest Decrease in Profits: {lowestMonth} (${lowestAmount})")
    



