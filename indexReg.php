<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET,POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");




    function getAll(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
        $productos = array();
        $query = $conexion -> query('SELECT * FROM productos');
        if($query->rowCount()){
            while($row = $query-> fetch(PDO::FETCH_ASSOC)){
                $item = array(
                    'id' => $row['id'],
                    'nombre' => $row['nombre'],
                    'stock' => $row['stock'],
                    'stock_critico' => $row['stock_critico'],
                    'precio' => $row['precio'],
                    'imagen' => $row['imagen'],
                    'estado' => $row['estado']
                );
                array_push($productos, $item);
            }
    
            echo json_encode($productos);
        }else{
            echo json_encode(array('mensaje'=>'no hay elementos'));
        }

}

getAll();
?>