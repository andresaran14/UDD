A partir del archivos de antibiogramas, llamado antibiograma_pacientes_completo.csv se extraen con "grep" sólo aquellas lineas que correspondan a los microorganismos de Staphylococcus aureus o Pseudomonas aeruginosa, además con awk se axtrae la información correspondiente a los antibioticos de interés, en este caso Ciprofloxacino y Ciprofloxacino para S. aureus y Ciprofloxacino y Meropenem para P. aeruginosa. 

Luego desde el archivo llamado merge_data_antibiograma.csv se extrae la columna de sub_wound para hacer un merge en R con el archivo Nwounds_final_2020.csv (de éste se le extrae también la columna que indica la categoría de la herida) para, así, tener finalmente un archivo con las siguientes columnas

ID_patient - visit - antibiotico - interpretacion - sub_wound - type_EB - cat - edad

Estas tres últimas columnas se extraen del archivo Patients.csv 


De los archivos finales se extraen solo aquellas heridas que pertenezcan a las categorias 1 o 3 con el siguiente comando:


grep 'cat_1\|cat_3' final_pseudomona > final_pseudomona_cat1_cat3
grep 'cat_1\|cat_3' final_aureus > final_aureus_cat1_cat3


Finalmente, se crea una nueva columna que contiene el ID de la sub herida más el número de visita separado por un /

awk 'BEGIN{FS=OFS=","}{print $2, $4, $6, $7, $8, $21, $23, $24, $2"/"$4}' final_pseudomona_cat1_cat3 | uniq > final_file_pseudomona_wound_sub_visit
awk 'BEGIN{FS=OFS=","}{print $2, $4, $6, $7, $8, $14, $15, $16, $2"/"$4}' final_aureus_cat1_cat3 | uniq > final_file_aureus_wound_sub_visit


GGPLOT2

Aureus:

ggplot(test_final, aes(x = wound_sub_visit, y = interpretacion))+geom_point(size=2, aes(shape=category_sub_wounds, color=Type_patient))+theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=6, face="bold"))+facet_grid(Antibiotico~Age, scale="free_x", space="free_x")+labs(title="Resistencias Staphylococcus aureus")+scale_colour_manual(values=c("green","red","blue"))


Pseudomonas:

ggplot(test_final_pseudomona, aes(x = wound_sub_visit, y = interpretacion))+geom_point(size=2, aes(shape=category_sub_wounds, color=Type_patient))+theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=6, face="bold"))+facet_grid(Antibiotico~Age, scale="free_x", space="free_x")+labs(title="Resistencias Pseudomonas aeruginosa")+scale_colour_manual(values=c("green","red","blue"))
