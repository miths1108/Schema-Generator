#Determining data types
import xml.etree.ElementTree as ET
import os
files = os.listdir("input_2")
#sum,avg,count


def get_subquery_resultcolumn(elem):
	if elem[0][0][0][0].attrib['type'] == "simple_object_name_t":
		print elem[0][0][0][0][0].text
	elif elem[0][0][0][0].attrib['type'] == "function_t":
		print elem[0][0][0][0][0].attrib['name']
	else:
		print elem[0][0][0][0].attrib['type']

def get_comparator_type (elem):
	 if elem.attrib['type'] == "simple_object_name_t":
	 	print elem[0].text
	 elif elem.attrib['type'] == "simple_constant_t":		
		print elem[0].text
	 elif elem.attrib['type'] == "function_t":		
		print elem[0].attrib['name']
         elif elem.attrib['type'] == "subquery_t":	
		get_subquery_resultcolumn(elem)
	 else:
		print elem.attrib['type']
			
		
if __name__ == "__main__":	
	for filename in files:
		print filename
		tree = ET.parse("input_2/"+filename)
		root = tree.getroot()
		# recursively over all child 
		for element in root.getiterator():
	      	 	#print element.tag, element.attrib
			if element.tag == "TFunctionCall":
				obj = element.findall(".//TObjectName")
				for o in obj:
					print (element.attrib['name'], o.text[1:])
		 	
			if element.tag == "TExpression" and element.attrib['type'] == "simple_comparison_t":
				#print element[0], element[1].attrib['type'], element[2].attrib['type']	
				if element[1].attrib['type'] == "simple_object_name_t" or element[2].attrib['type'] == "simple_object_name_t":
					if element[1].attrib['type'] == "simple_object_name_t":
						get_comparator_type(element[2])
					else:	
						get_comparator_type(element[1])
						
			if element.tag == "TExpression" and element.attrib['type'] == "pattern_matching_t":
				print element[0][0].text
		
			if element.tag == "TExpression" and element.attrib['type'] == "between_t":
				print element[0][0].text
				if element[1].attrib['type'] == "simple_constant_t":
					print "is constant", element[1][0].text
				elif "arithmetic_" in element[1].attrib['type']:
					print "is numeric"
				else:
					print element[1].attrib['type']
			
			if element.tag == "TExpression" and element.attrib['type'] == "in_t":
				print element[0][0].text	
				if element[1].attrib['type'] == "list_t":
					print element[1][0][0][0].text
				elif element[1].attrib['type'] == "subquery_t":
					get_subquery_resultcolumn(element[1])

			if element.tag == "TExpression" and "arithmetic_" in element.attrib['type']:
				if element[0].attrib['type'] == "simple_object_name_t":
					print element[0][0].text ,"is numeric"
				elif element[1].attrib['type'] == "simple_object_name_t":
					print element[1][0].text ,"is numeric"

			


				
						
			
