<?php

    require_once "../Config/conection.php";
    require_once "../Model/pokemon.php";

    $pokemons = new Pokemon();

    switch($_GET['op']){
        case 'listar':
            $datos = $pokemons->get_pokemon();
            if(is_array($datos) == true and count($datos) > 0){
                $results  = array(
                    "results" => $datos
                );
                echo json_encode($results);
            }
        break;
    }
?>