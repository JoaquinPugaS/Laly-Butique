<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET,POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

function ObtenerProductos(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
        $productos = array();
        $query = $conexion -> query('SELECT * FROM productos');
        if($query->rowCount()){
            while($row = $query-> fetch(PDO::FETCH_ASSOC)){
                $item = array(
                    'id' => $row['id_producto'],
                    'nombre' => $row['nombre_producto'],
                    'stock' => $row['stock_producto'],
                    'stock_critico' => $row['stock_critico_producto'],
                    'precio' => $row['precio_producto'],
                    'imagen' => $row['imagen_producto'],
                    'estado' => $row['estado_producto']
                );
                array_push($productos, $item);
            }
    
            echo json_encode($productos);
        }else{
            echo json_encode(array('mensaje'=>'no hay elementos'));
        }
    }

if(isset($_GET["leer"])){
    ObtenerProductos();
}

    Function Catalogo(){
        include 'db.php';
        $objeto = new Conexion();
        $conexion = $objeto->Conectar();
            $productos = array();
            $query = $conexion -> query('SELECT * FROM productos WHERE estado_producto = "Disponible"');
            if($query->rowCount()){
                while($row = $query-> fetch(PDO::FETCH_ASSOC)){
                    $item = array(
                        'id' => $row['id_producto'],
                        'nombre' => $row['nombre_producto'],
                        'stock' => $row['stock_producto'],
                        'stock_critico' => $row['stock_critico_producto'],
                        'precio' => $row['precio_producto'],
                        'imagen' => $row['imagen_producto'],
                        'estado' => $row['estado_producto']
                    );
                    array_push($productos, $item);
                }
        
                echo json_encode($productos);
            }else{
                echo json_encode(array('mensaje'=>'no hay elementos'));
            }
}
if(isset($_GET['listar'])){
    Catalogo();
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
        $sql = "SELECT * FROM productos where nombre_producto = '$nombre'";
        $query = $conexion -> query($sql);
        if($query->rowCount()){
            echo json_encode(["success"=>0]);
        }else{
            $sql = "INSERT INTO productos (nombre_producto, stock_producto, stock_critico_producto, precio_producto, imagen_producto, estado_producto) VALUES ('$nombre', $stock, $stock_critico, $precio, '$imagen', '$estado')";
            $query = $conexion -> query($sql);
            echo json_encode(["success"=>1]);
            exit();
        }
    }
if(isset($_GET["insertar"])){
Insertar();
}
Function Login(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $Boolean = FALSE;
    $data = json_decode(file_get_contents("php://input"));
    $username = $data->username;
    $password = $data->password;
    $sql = "SELECT * FROM  admin WHERE id_admin= '$username'";
    $query = $conexion-> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            if(password_verify($password,$row['contrasenia_admin'])){
                $Boolean = TRUE;
            }
        }
        if($Boolean == TRUE){
            echo json_encode(["success"=>1,"token"=>bin2hex(openssl_random_pseudo_bytes(16))]);
            exit();
        }else{
            echo json_encode(["success"=>0]);
        }
    }else{
        $sql = "SELECT * FROM  usuarios WHERE email_usuario= '$username' and contrasenia_usuario = '$password'";
        $query = $conexion-> query($sql);
        if($query->rowCount()){
            $Boolean = TRUE;
            // while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            //     if(password_verify($password,$row['contraseña_usuario'])){
            //     }
            // }
            if($Boolean == TRUE){
                echo json_encode(["success"=>2,"token"=>bin2hex(openssl_random_pseudo_bytes(16))]);
                exit();
            }else{
                echo json_encode(["success"=>0]);
            }
        }else{
        echo json_encode(["success"=>0]);
        }
    }
}

if(isset($_GET["login"])){
    Login();
}


Function Eliminar($id){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $sql = "DELETE FROM productos WHERE id_producto ='$id'";
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
    $sql = "UPDATE productos SET nombre_producto='$nombre', stock_producto=$stock, stock_critico_producto=$stock_critico,precio_producto=$precio,imagen_producto='$imagen',estado_producto='$estado' where id_producto='$id'";
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
    $sql = "SELECT * FROM productos WHERE id_producto ='$id'";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $item = array(
                'id' => $row['id_producto'],
                'nombre' => $row['nombre_producto'],
                'stock' => $row['stock_producto'],
                'stock_critico' => $row['stock_critico_producto'],
                'precio' => $row['precio_producto'],
                'imagen' => $row['imagen_producto'],
                'estado' => $row['estado_producto']
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