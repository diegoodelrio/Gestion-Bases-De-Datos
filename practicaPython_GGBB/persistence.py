import mysql.connector
from exceptions import ErrorPopulation
from utils import inputOutput
from populations import Population
from animals import Mouse,EnumsMouse
from families import Family
from families import NormalFamily
from families import PoligamicFamily
from datetime import datetime, date
    
cnx = mysql.connector.connect(
    host = "localhost",
    user = "root",
    passwd = "Entrecot1",
    database = "animalario",
    auth_plugin='mysql_native_password'
)

def getIdNewMouse ():
    cursor = cnx.cursor()
    query = "SELECT MAX(reference) FROM Raton;"
    cursor.execute(query)
    id = cursor.fetchone()[0]
    if id == None:
        id = 1
    else:
        id = id+1
    cursor.close()
    return id

def getIdNewPopulation ():
    cursor = cnx.cursor()
    query = "SELECT MAX(reference) FROM Poblacion;"
    cursor.execute(query)
    id = cursor.fetchone()[0]
    if id == None:
        id = 1
    else:
        id = id+1
    cursor.close()
    return id

def getIdNewFamily ():
    cursor = cnx.cursor()
    query = "SELECT MAX(reference) FROM Familia;"
    cursor.execute(query)
    id = cursor.fetchone()[0]
    if id == None:
        id = 1
    else:
        id = id+1
    cursor.close()
    return id

#EJERCICIO 2 y 3

def insertPopulation (population):    
    cursor = cnx.cursor()

    insert_population = "INSERT INTO poblacion(reference, name, researcher, start_date, num_days) VALUES (%s,%s,%s,%s,%s)"
    start_date = str(population.get_start_date())                                                                               # Hago un str para que funcione sql
    values_population = (population.get_reference() ,population.get_name(), population.get_researcher(), start_date, population.get_num_days())     #Obtener los valores que se han creado previamente
    cursor.execute(insert_population, values_population)   
    cnx.commit()      
    cursor.close()

#EJERCICIO 4 LISTAR CODIGOS DE REFERENCIA DE TODOS LOS RATONES DE UNA POBLACION

def reference_code_population(Population):
    cursor = cnx.cursor()

    select_mouse = "SELECT reference FROM Raton WHERE ref_poblacion = %s"
    datos = Population.get_reference()
    cursor.execute(select_mouse, datos)
    ref_code_list = []
    for id in cursor:
        ref_code_list.append(id)
    return ref_code_list

#EJERCICIO 5 AÑADIR UN NUEVO RATON A UNA POBLACION YA EXISTENTE INDICANDO TODOS SUS DATOS

def insert_into_Mouse(population, mouse, commit = True):
    try:
        cursor = cnx.cursor()
        insert = "insert into raton(name,birthdate,weight,gender,temperature,description,chromosome1,chromosome2,ref_poblacion) values (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        birthdate = str(mouse.get_birthdate())
        gender = str(mouse.get_gender())
        chromosome1 = str(mouse.get_chromosome1())
        chromosome2 = str(mouse.get_chromosome2())
        datosRaton = (mouse.get_name(), birthdate, mouse.get_weight(), gender, mouse.get_temperature(), mouse.get_description(), chromosome1, chromosome2, population.get_reference())
        cursor.execute(insert, datosRaton)
    except Exception:
        print("Couldn't add your mouse to the database!")
        cnx.rollback()
    if (commit):
        cnx.commit()
    cursor.close()

#EJERCICIO 6 AÑADIR UN RATON A UNA POBLACION EXISTENTE CON UNA SERIE DE CARACTERISTICAS

def insert_into_Mouse1(population, mouse, commit = True):
    try:
        cursor = cnx.cursor()
        query = "insert into raton(name,birthdate,weight,gender,temperature,description,chromosome1,chromosome2,ref_poblacion) values (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        birthdate = str(mouse.get_birthdate())
        gender = str(mouse.get_gender())
        chromosome1 = str(mouse.get_chromosome1())
        chromosome2 = str(mouse.get_chromosome2())
        datosRaton = (mouse.get_name(), birthdate, mouse.get_weight(), gender, mouse.get_temperature(), mouse.get_description(), chromosome1, chromosome2, population.get_reference())
        cursor.execute(query, datosRaton)
    except Exception:
        print("Couldn't add your mouse to the database!")
        cnx.rollback()
    if (commit):
        cnx.commit()
    cursor.close()
 
#EJERCICIO 7 ELIMINAR UN RATON DE UNA POBLACION 

def Delete_Mouse (reference):
    cursor = cnx.cursor()

    delete_mouse = "DELETE FROM Raton WHERE reference = %s"
    datos = (reference,)
    
    cursor.execute(delete_mouse, datos)
    cnx.commit()
    cursor.close()

#EJERCICIO 8 ACTUALIZAR UN RATON.

def updateMouse (reference, NAME, WEIGHT, TEMPERATURE, DESCRIPTION):
    cursor = cnx.cursor()
    
    update = "UPDATE Raton SET name= %s, weight= %s, temperature= %s, description= %s WHERE reference = %s"
    datos = (NAME, WEIGHT, TEMPERATURE, DESCRIPTION, reference)
    
    cursor.execute(update, datos)
    cnx.commit()
    cursor.close()
    
#EJERCICIO 9 INFORMACION DETALLADA DE UN RATON, SABIENDO EL CODIGO DE REFERENCIA

def infoMouse(reference):
    cursor = cnx.cursor()
    
    informacion = "SELECT * FROM Raton WHERE reference = %s"
    datos = (reference,)

    cursor.execute(informacion, datos)
    info = cursor.fetchall()
    cnx.commit()
    cursor.close()
    return info

#EJERCICIO 10-11 FAMILIAS NORMALES Y POLIGAMICAS

def family(population, family):
    cursor = cnx.cursor()
    
    insert_family = "INSERT INTO Familia(reference, ref_poblacion, ref_padre) VALUES (%s, %s, %s)"
    padre = family.get_parent()
    values_family = (getIdNewFamily(), population.get_reference(), padre.get_reference())
    
    cursor.execute(insert_family, values_family)
    cnx.commit()
    cursor.close()

def normal_family(population, family):
    cursor = cnx.cursor()

    insert_normal_family = "INSERT INTO Familia_normal(reference, ref_madre_normal) VALUES (%s, %s)"
    values_family = (family.get_reference(), family.get_mother().get_reference())

    cursor.execute(insert_normal_family, values_family)
    cnx.commit()
    cursor.close()

def poligamous_family(family):
    cursor = cnx.cursor()

    insert_poligamous_family = "INSERT INTO Familia_poligamica(reference) VALUES (%s)"
    values_family = (family.get_reference(),)
    
    cursor.execute(insert_poligamous_family, values_family)
    cnx.commit()
    cursor.close()

def addmothers(family, mother):
    cursor = cnx.cursor()

    update_female = "UPDATE mouse SET ref_familia_poligamica = %s WHERE reference = %s"
    values = (family.get_reference(), family.get_mother().get_reference())
    
    cursor.execute(update_female, values)
    cnx.commit()
    cursor.close()

def closeConnection():
    try:
        cnx.close()
    except cnx.is_connected() == True:
        print("Sigues conectado!!")
    
def main():
    #poblacion = Population.Population(reference = getIdNewPopulation(), name="population2", researcher="researcher", start_date=date.today(), num_days=270, population_size = 30, male_percentage = 0.6, mutated_percentage = 0.4)
    #insertPopulation(poblacion)
    #mouse = Mouse.Mouse(reference=getIdNewMouse() , name='nombre ', birthdate=date.today(), weight=75, gender=EnumsMouse.Gender.MALE, temperature=38, description="" , chromosome1=EnumsMouse.Chromosome.X, chromosome2=EnumsMouse.Chromosome.Y)
    #mouse = Mouse.Mouse (name = 'nombre', probabilityMutation=0.3)
    #insert_into_Mouse(population, mouse)
    #Delete_Mouse(12)
    #update_mouse(2, "DIEGO", 88.6, 36.6, "")
    #infoMouse(2)
    closeConnection()
    if (cnx.is_connected()):
        print("Sigues conectado.")

if __name__ == "__main__":
    main()
