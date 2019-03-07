import csv
import os 

electionpath = os.path.join('AMELIA-election_data.csv')

with open(electionpath, newline = '') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    voteCount = 0

    header = next(csv_reader)

    candidates = {} #dict to hold each candidate name and number of votes
    

    for row in csv_reader:
        #define the current variables
        chosenCandidate = row[2]
        
        if chosenCandidate not in candidates:
            candidates[chosenCandidate] = 0
        
        if chosenCandidate in candidates:
            candidates[chosenCandidate] += 1


        voteCount +=1



#print findings

print("Election Results")
print("----------------------------")
print(f"Total Votes: {voteCount}")
print("----------------------------")

#print each candidate and their results
for candidate in candidates:
    candidatePercentage = candidates[candidate]/voteCount*100
    cleanPercentage = "{:.2f}".format(candidatePercentage)
    print(f"{candidate}: {cleanPercentage}% ({candidates[candidate]})")

#determine and print winner

#determines the highest value in the dictionary
mostVotes = max(candidates.values()) 

#loops through the dictionary to determine which key belongs to the highest value
winner =  [candidate for candidate,votes in candidates.items() if votes == mostVotes][0]

print("----------------------------")
print(f"Winner: {winner}")

#write to file
f = open("AMELIA-election_results.txt", "a+")

f.write("Election Results\n")
f.write("----------------------------\n")
f.write("Total Votes: "+str(voteCount)+"\n")
f.write("----------------------------\n")

#print each candidate and their results
for candidate in candidates:
    candidatePercentage = candidates[candidate]/voteCount*100
    cleanPercentage = "{:.2f}".format(candidatePercentage)
    f.write(candidate+": "+cleanPercentage+"% ("+str(candidates[candidate])+")\n")

#determine and print winner

#determines the highest value in the dictionary
mostVotes = max(candidates.values()) 

#loops through the dictionary to determine which key belongs to the highest value
winner =  [candidate for candidate,votes in candidates.items() if votes == mostVotes][0]

f.write("----------------------------\n")
f.write("Winner: "+winner+"\n")
