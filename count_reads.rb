#count_reads.rb

if ARGV[0]==nil
puts ""
puts ".........................................................................."
puts "... Sorry! you forgot to add the folder name which contains .bam files ..."
puts "...          try again adding this information, please                 ..."
puts ".........................................................................."
puts ""
exit
elsif ARGV[0]=~/\//
`ls "#{ARGV[0]}"* > list.txt`
else 
`ls "#{ARGV[0]}"/* > list.txt`
end

l=''
l << `wc -l list.txt`
l=l.split("\s")[0]
m=0

sample=''
out2=File.new("report_different_match.txt","w")
out3=File.new("report_different_family.txt","w")

hfam={}
hgen={}
ff=File.open("phenotypes.txt").each_line do |line|
line.chomp!
col=line.split("\t")
hfam[col[0]]=col[1]
hgen[col[0]]=col[0].split("_")[0]
genes << col[0]
end
ff.close

samples=[]
hsamples={}
ll=File.open("list.txt").each_line do |line|
line.chomp!
if line =~ /\/(.*)\.\w\w\w/
samples << $1
end
end
ll.close

genes.each_index{|a| hgenes[genes[a]]=a}
samples.each_index{|b| hsamples[samples[b]]=b}
matrix=Array.new(samples.length()){|i| Array.new(genes.length()) {|x| 0}}

aa=File.open("list.txt").each_line do |file|
file.chomp!
if file =~ /\/(.*).bam/ or file =~ /\/(.*).sam/ 
sample=$1
m+=1
puts "...processing sample #{sample} (#{m}/#{l})"
puts hsamples[sample]
`samtools sort -n "#{file}" > file1.bam`
`samtools view -h file1.bam > file2.sam`
read=''
        bb=File.open("file2.sam").each_line do |line|
 	line.chomp!
	col=line.split("\t")
	if col[0]!=read
	matrix[hsamples[sample]][hgenes[col[2]]]+=1
        elsif col[6]!="="
	out2.puts line
		if hfam[col[2]]!=hfam[col[6]]
		out3.puts "#{hfam[col[2]]}\t#{hfam[col[6]]}\t#{line}"
		matrix[hsamples[sample]][hgenes[col[2]]]+=1		
		end
	end
   end
   bb.close
end
end
aa.close

mm=-1
salida.print "Antibiotic_family\tGene\tHit"
samples.each {|i| salida.print "\t#{i}"}
salida.print "\n"
matrix.each {|i|  mm+=1
salida.print "#{hfam[genes[mm]]}\t#{hgen[genes[mm]]}\t#{genes[mm]}"
i.each {|value| salida.print "\t#{value}"}
salida.print "\n"
}

puts "---------------------------------------------------------------"
puts ""
puts " Analysis performed correctly, if you have any issue please contact to jcobd@unileon.es"
puts ""
