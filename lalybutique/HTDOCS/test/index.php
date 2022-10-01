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

if(isset($_GET["leer"])){
    getAll();
    
}

Function Insertar(){
    include_once 'db.php';
        $objeto = new Conexion();
        $conexion = $objeto->Conectar();
        $data = json_decode(file_get_contents("php://input"));
        $nombre = $data->nombre;
        $stock = $data->stock;
        $stock_critico = $data->stock_critico;
        $precio = $data->precio;
        $imagen = $data->imagen;
        $estado = $data->estado;
        $sql = "INSERT INTO productos (nombre, stock, stock_critico, precio, imagen, estado) VALUES ('$nombre', $stock, $stock_critico, $precio, '$imagen', '$estado')";
        $query = $conexion -> query($sql);
        echo json_encode(["success"=>1]);
        exit();
        
    }
    if(isset($_GET["insertar"])){
    Insertar();
}

Function Eliminar($id){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $sql = "DELETE FROM productos WHERE id ='$id'";
    $query = $conexion -> query($sql);
    if($query){
        echo json_encode(["success"=>1]);
        exit();
    }else{
        echo json_encode(["success"=>0]);
    }

}

if(isset($_GET["eliminar"])){
    $id = $_GET["eliminar"];
    Eliminar($id);
}

Function Modificar($id){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $data = json_decode(file_get_contents("php://input"));
    $nombre = $data->nombre;
    $stock = $data->stock;
    $stock_critico = $data->stock_critico;
    $precio = $data->precio;
    $imagen = $data->imagen;
    $estado = $data->estado;
    $sql = "UPDATE productos SET nombre='$nombre', stock=$stock, stock_critico=$stock_critico,precio=$precio,imagen='$imagen',estado=$estado where id='$id'";
    $query = $conexion -> query($sql);
    echo json_encode(["success"=>1]);
    exit();
}

if(isset($_GET["modificar"])){
    $id = $_GET["modificar"];
    Modificar($id);
}

Function Consultar($id){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $productos = array();
    $sql = "SELECT * FROM productos WHERE id ='$id'";
    $query = $conexion -> query($sql);
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
        exit();
        
        }else{  
        echo json_encode(["success"=>0]);
    }
}
if(isset($_GET["consultar"])){
    $id = $_GET["consultar"];
    Consultar($id);
}

?>