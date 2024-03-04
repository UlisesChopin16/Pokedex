<?php
    class Pokemon extends Conectar{
        
        public function get_pokemon(){
            $conectar = parent::conexion(); // llamamos al metodo conexion de la clase conectar para que nos devuelva la conexion
            parent::set_names(); // llamamos al metodo set_names de la clase conectar para que nos devuelva los datos con utf8
            $sql = "SELECT * FROM pokemons"; // creamos la consulta
            $sql = $conectar->prepare($sql); // preparamos la consulta
            $sql->execute(); // ejecutamos la consulta
            return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC); // devolvemos los datos en un array asociativo
        }
    }
?>