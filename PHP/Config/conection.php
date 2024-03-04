<?php
    class Conectar{
        protected $dbh;

        // creamos la conexion para la base de datos
        protected function Conexion(){
            $dbhost = "localhost";
            $dbname = "pokedex";
            $dbuser = "root";
            $dbpass = "123456";
            try{
                $conectar = $this->dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);
                return $conectar;  
            }catch(Exception $e){
                print "¡Error BD!:" . $e->getMessage() . "<br/>";
                die();
            }
        }

        protected function set_names(){
            return $this->dbh->query("SET NAMES 'utf8'");
        }
    }
?>