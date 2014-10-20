import os
files = os.listdir("testset")
columns = {}
must = {}
must_not = {}
ismodified = True

def update_mustnot():
	global columns
	global must
	global must_not
	ismustnotmodified = False
	#CASE 1
	for key, val in columns.iteritems():
		if key not in must_not: 
				must_not[key] = []
	#	print val
		for  querynum, tables in val[1].iteritems():
			common_tables = list(set(tables) & set(must[key]))
			if len(common_tables)!=0:
				temp = list(set(tables) - set(common_tables))
				if set(must_not[key]) != (set(temp) | set(must_not[key])):
					ismustnotmodified = True
					must_not[key] = list(set(temp) | set(must_not[key]))	

	#CASE 2
	for key, val in columns.iteritems():
		for  querynum, tables in val[1].iteritems():
			for  querynum1, tables1 in val[1].iteritems():
				if(set(tables).issubset(set(tables1))):
					if set(must_not[key]) != ((set(tables1) - set(tables)) | set(must_not[key])):
						ismustnotmodified = True
						must_not[key] = list((set(tables1) - set(tables)) | set(must_not[key]))	

	#CASE 3
	for key, val in columns.iteritems():
		for  querynum, tables in val[1].iteritems():
			for  querynum1, tables1 in val[1].iteritems():
				if(querynum != querynum1):
					tmp = list((set(tables1) | set(tables)) - (set(tables1) & set(tables)))
					for querynum2, tables2 in val[1].iteritems():
						if((querynum2 != querynum) and (querynum2 != querynum1) and set(tmp).issubset(set(tables2))):
							if set(must_not[key]) != (set(tmp) | set(must_not[key])):
								ismustnotmodified = True
								must_not[key] = list(set(tmp) | set(must_not[key]))

#	for key, val in must_not.items():
#		print key,val
#	print must_not
	return ismustnotmodified

def update_maybe():
	global columns
	global must
	global must_not
	ismaybemodified = False
	for key, val in columns.iteritems():
		for  querynum, tables in val[0].items():
			if set(tables) and set(must_not[key]):
				tables = list(set(tables) - set(must_not[key]))
				columns[key][0][querynum] = tables
				ismaybemodified = True
		for  querynum, tables in val[1].items():
			if set(tables) and set(must_not[key]):
				tables = list(set(tables) - set(must_not[key]))
				columns[key][1][querynum] = tables
				ismaybemodified = True
		
#	print "================columns==================="
#	for key, val in columns.items():
#		print key,val
	return ismaybemodified

def update_must():
	global columns
	global must
	global must_not
	ismustmodified = False
	print "ismustmodified?", ismustmodified
	#print columns
	#CASE 2
	for key, val in columns.iteritems():
		print key, val
		for  querynum, tables in val[1].items():
			if(len(tables) == 1): 
				print "must", key, must[key]
				#print "tables", tables
				if set(must[key]) != (set(must[key]) | set(tables)):
					ismustmodified = True
					must[key] = list(set(must[key]) | set(tables))
	
	#CASE 3
	for key, val in columns.iteritems():
		for  querynum, tables in val[1].items():
			try:
				if(len(set(tables) - set(must_not[key])) == 1): 
					if set(must[key]) != (set(must[key]) | (set(tables) - set(must_not[key]))):
						must[key] = list(set(must[key]) | (set(tables) - set(must_not[key])))
						ismustmodified = True
			except:
				pass
	return ismustmodified

if __name__ == "__main__":	
	for filename in files:
	#	print filename
		if filename != '.DS_Store':
			f = open ("testset/"+filename)
			for i in range (0,3):
				f.readline()

			# List of all the tables in input query
			tables = []
			for line in f:
				if line != "Columns:\n":
					#print line
					tables.append(line[:-1])
				else: break
			# Dictionary for column table mapping
			for line in f:
				line = line.split(".")
				try:
					temp = line[1].split("(")
					col = temp[0]
					flag = temp[1].split(":")[1]
					flag = flag[:-2]
					if col not in must:
						must[col] = []
					if col not in columns:
						columns[col]={}, {}
					#print flag
					if flag == "true":
						#CASE 1
						columns[col][0][filename] = tables
						if line[0] not in must[col]:
							must[col].append(line[0])
					else:
						columns[col][1][filename] = tables
				except:
					pass
#	print "===========columns==============="
#	for key, val in columns.items():
	#	print key,val
#	print "=============must================="
#	for key, val in must.items():
	#	print key,val
#	print "===========mustnot================"
	i = 0
	while ismodified:
		print "in loop", i
		i = i + 1
		ismustmodified = update_must()
		ismustnotmodified = update_mustnot()
		ismaybemodified = update_maybe()
		ismodified = ismustmodified or ismaybemodified or ismustnotmodified
	#	print ismustnotmodified
	#	print ismaybemodified
	#	print ismustmodified
	#	print "must_not", must_not
	#	print "must", must
	#	print "maybe", columns
		