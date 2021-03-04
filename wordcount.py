file = open("SLURM_ARRAY_TASK_ID.txt", "rt")
data = file.read()
words = data.split()

print('Number of words in text file :', len(words))
