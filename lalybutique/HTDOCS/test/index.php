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
        $codigo = $data->codigo;
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
            exit();
        }else{
            $sql = "INSERT INTO productos (id_Tipo,nombre_producto,stock_producto, stock_critico_producto, precio_producto, imagen_producto, estado_producto) VALUES ($codigo ,'$nombre',$stock, $stock_critico, $precio, '$imagen', '$estado')";
            $query = $conexion -> query($sql);
            if($query->rowCount()){
                echo json_encode(["success"=>1]);
                exit();
            }
        }
}
if(isset($_GET["insertar"])){
    Insertar();
}
Function InsertarV(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $data = json_decode(file_get_contents("php://input"));
    $codigo = $data->codigo;
    $nombre = $data->nombre;
    $cantidad = $data->cantidad;
    $precio = $data->precio;
    $imagen = $data->imagen;
    $sql = "INSERT INTO tipo (id_Tipo, descripcion_tipo, Cantidad, precio, imagen) VALUES ($codigo,'$nombre',$cantidad,$precio,'$imagen')";
    $query = $conexion -> query($sql);
    echo json_encode(["success"=>1,"codigo"=>$codigo]);
    exit();
}

if(isset($_GET["insertarV"])){
    InsertarV();
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
        $sql = "SELECT * FROM  usuarios WHERE email_usuario= '$username'";
        $query = $conexion-> query($sql);
        if($query->rowCount()){
            while($row = $query-> fetch(PDO::FETCH_ASSOC)){
                if(password_verify($password,$row['contrasenia_usuario'])){
                    $Boolean = TRUE;
                    $rut = $row['rut_usuario'];
                }
            }
            if($Boolean == TRUE){
                echo json_encode(["success"=>2,"token"=>bin2hex(openssl_random_pseudo_bytes(16)),"rut"=>$rut]);
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
    $sql = "SELECT id_venta from producto_pedido where id_producto = '$id'";
    $query = $conexion -> query($sql);
    if($query -> rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $id_venta = $row['id_venta'];
            $sql2 = "SELECT * FROM venta where id_venta = $id_venta and estado_de_orden = 'Pagado'";
            $query2 = $conexion -> query($sql2);
            if($query2 -> rowCount()){
                $sql4 = "UPDATE productos set estado_producto = 'No Disponible' where id_producto = '$id'";
                $query4 = $conexion -> query($sql4);
                if($query4){
                    echo json_encode(["success"=>2]);
                    exit();
                }
            }
        }
    }else{
        $sql1 = "DELETE FROM productos WHERE id_producto ='$id'";
        $query1 = $conexion -> query($sql1);
        if($query1){
            echo json_encode(["success"=>1]);
            exit();
        }else{
            echo json_encode(["success"=>0]);
        }
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
Function ModificarCodigoSeg($id){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $data = json_decode(file_get_contents("php://input"));
    $rut = $data->rut;
    $total = $data->total;
    $estado = $data->estado;
    $codSeg = $data->codSeg;
    $fecha = $data->fecha;
    $sql = "UPDATE venta SET rut_usuario='$rut', total_a_pagar_orden=$total, estado_de_orden='$estado',fecha_pedido=$fecha,codigo_seguimiento='$codSeg'where id_venta=$id";
    $query = $conexion -> query($sql);
    echo json_encode(["success"=>1]);
    exit();
}

if(isset($_GET["modCod"])){
    $id = $_GET["modCod"];
    ModificarCodigoSeg($id);
}

Function Consultar($id){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $productos = array(['producto'],['variante']);
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
            $tipo=$row['id_Tipo'];
            array_push($productos[0], $item);
        }
        if($tipo != 0){
            $sql = "SELECT * FROM tipo WHERE id_Tipo = '$tipo'";
            $query = $conexion -> query($sql);
            if($query->rowCount()){
                while($row = $query-> fetch(PDO::FETCH_ASSOC)){
                    $item = array(
                        'id' => $row['id_Tipo'],
                        'descripcion' => $row['descripcion_tipo'],
                        'cantidad' => $row['Cantidad'],
                        'precio' => $row['precio'],
                        'imagen' => $row['imagen'],
                    );
                    array_push($productos[1],$item);
                }
            }
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
Function ConsultarUsuario($rut){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $usuario = array();
    $sql = "SELECT * FROM usuarios WHERE rut_usuario ='$rut'";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $item = array(
                'rut' => $row['rut_usuario'],
                'nombre' => $row['nombre_usuario'],
                'apellido' => $row['apellido_usuario'],
                'email' => $row['email_usuario'],
                'direccion' => $row['direccion_usuario'],
                'telefono' => $row['telefono_usuario']
            );
            array_push($usuario, $item);
        }
        echo json_encode($usuario);
        exit();
        
    }else{  
        echo json_encode(["success"=>0]);
    }
}
if(isset($_GET["consultaruser"])){
    $rut = $_GET["consultaruser"];
    ConsultarUsuario($rut);
}
Function ObtenerVentas(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $ventas = array();
    $sql = "SELECT * FROM venta";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $item = array(
                'id_venta' => $row['id_venta'],
                'rut_usuario' => $row['rut_usuario'],
                'total_a_pagar' => $row['total_a_pagar_orden'],
                'estado_de_orden' => $row['estado_de_orden'],
                'fecha_pedido' => $row['fecha_pedido'],
                'cod_seguimiento' => $row['codigo_seguimiento']
            );
            array_push($ventas, $item);
        }
        echo json_encode($ventas);
        exit();
        
    }else{  
        echo json_encode(["success"=>0]);
    }
}
if(isset($_GET["ventas"])){
    ObtenerVentas();
}
Function InsertarVenta(){
    include_once 'db.php';
        $objeto = new Conexion();
        $conexion = $objeto->Conectar();
        $data = json_decode(file_get_contents("php://input"));
        $rut = $data->rut;
        $total = $data->total;
        $estado = $data->estado;
        $fecha = $data->fecha;
        $codseg = $data->codseg;
        $idventa = $data->id_venta;
        $sql = "INSERT INTO venta (id_venta, rut_usuario, total_a_pagar_orden, estado_de_orden, fecha_pedido, codigo_seguimiento) VALUES ($idventa, '$rut', $total, '$estado', '$fecha', '$codseg')";
        $query = $conexion -> query($sql);
        echo json_encode(["success"=>1]);
        exit();
        
    }
    
    
    if(isset($_GET["venta"])){
        InsertarVenta();
    }
    Function InsertarVentaM(){
    include_once 'db.php';
    $objeto = new Conexion();
        $conexion = $objeto->Conectar();
        $data = json_decode(file_get_contents("php://input"));
        $id = $data->producto_id;
        $cantidad = $data->cantidad;
        $cod_venta = $data->codigo;
        $sql = "SELECT precio_producto FROM productos where id_producto='$id'";
        $query = $conexion -> query($sql);
        $datos = $query->fetch(PDO::FETCH_ASSOC);
        $precio_u = $datos['precio_producto'];
        $sql1 = "INSERT INTO producto_pedido (id_venta,id_producto,cantidad_producto,precio_unitario) VALUES($cod_venta,$id,$cantidad,$precio_u)";
        $query1 = $conexion -> query($sql1);
        echo json_encode(["success"=>1,"precio_unitario"=>$precio_u,"cantidad"=>$cantidad]);
        exit();        
    }
    
    
if(isset($_GET["ventaM"])){
    InsertarVentaM();
}

Function RegistrarUser(){
    include_once 'db.php';
        $objeto = new Conexion();
        $conexion = $objeto->Conectar();
        $data = json_decode(file_get_contents("php://input"));
        $nombre = $data->nombre;
        $apellido = $data->apellido;
        $rut = $data->rut;
        $email = $data->email;
        $telefono = $data->telefono;
        $direccion = $data->direccion;
        $password1 = $data->contraseña;
        $password = password_hash($password1, PASSWORD_DEFAULT);
        $error = 0;
        //     $error = 1;
        //     echo json_encode(["success"=>2]);
        //     exit();
        // }
        $sql = "SELECT * FROM usuarios WHERE email_usuario = '$email'";
        $query = $conexion -> query($sql);
        if($query->rowCount()){
            $error = 2;
            echo json_encode(["success"=>3]);
            exit();
        }
        
            $sql1 = "SELECT * FROM usuarios WHERE rut_usuario = '$rut'";
            $query1 = $conexion -> query($sql1);
            if($query1->rowCount()){
                $datos = $query1->fetch(PDO::FETCH_ASSOC);
                $rut1 = $datos['rut_usuario'];
                $deuda = $datos['deuda_usuario'];
                $sql2 = "UPDATE usuarios SET nombre_usuario = '$nombre', apellido_usuario = '$apellido', email_usuario='$email',direccion_usuario='$direccion', contrasenia_usuario='$password',telefono_usuario='$telefono',deuda_usuario = $deuda, rut_usuario = '$rut1' where rut_usuario = '$rut'";
                $query2 = $conexion -> query($sql2);
                echo json_encode(["success"=>1,"token"=>bin2hex(openssl_random_pseudo_bytes(16))]);
                exit();
                
            }else{
                
                    $sql3 = "INSERT INTO usuarios (rut_usuario, nombre_usuario, apellido_usuario, email_usuario, direccion_usuario, contrasenia_usuario, telefono_usuario, deuda_usuario) VALUES ('$rut','$nombre','$apellido','$email','$direccion','$password','$telefono',0)";
                    $query3 = $conexion -> query($sql3);
                    echo json_encode(["success"=>1,"token"=>bin2hex(openssl_random_pseudo_bytes(16))]);
                    exit();
                
            
        }
        
    }
    

if(isset($_GET["RegistrarUser"])){
    RegistrarUSer();
}

Function AgregarCarrito(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $data = json_decode(file_get_contents("php://input"));
    $codigo = $data->codigo;
    $id = $data->producto_id;
    $cantidad = $data->cantidad;
    $precio = $data->precio;
    $sql = "INSERT INTO producto_pedido (id_venta, id_producto, cantidad_producto, precio_unitario) VALUES ($codigo, $id, $cantidad, $precio)";
    $query = $conexion -> query($sql);
    echo json_encode(["success"=>1,"cod_venta"=>$codigo]);
    exit();
    }

if(isset($_GET["carrito"])){
    AgregarCarrito();
}
Function InsertarDeuda(){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $data = json_decode(file_get_contents("php://input"));
    $rut = $data->rut;
    $deuda = $data->deuda;
    $sql = "SELECT * from usuarios where rut_usuario = '$rut'";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        $datos = $query->fetch(PDO::FETCH_ASSOC);
        $deudadb = $datos['deuda_usuario'];
        if($deudadb>0){
            $deuda = $deuda + $deudadb;
            $sql1 = "UPDATE usuario set deuda_usuario =$deuda WHERE rut_usuario = '$rut'";
            $query1 = $conexion -> query($sql1);
            echo json_encode(["success"=>1]);
            exit();
        }
    }else{
        $sql2 = "INSERT INTO usuarios (rut_usuario,deuda_usuario) VALUES ($rut,$deuda)";
        $query2 = $conexion -> query($sql2);
        echo json_encode(["success"=>1]);
        exit();
    }
    
    }

if(isset($_GET["insertarDeuda"])){
    InsertarDeuda();
}

Function ComprasUsuario($rut){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $compras = array();
    $sql = "SELECT * FROM venta WHERE rut_usuario ='$rut'";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $item = array(
                'id_venta' => $row['id_venta'],
                'rut_usuario' => $row['rut_usuario'],
                'total_pago' => $row['total_a_pagar_orden'],
                'estado_orden' => $row['estado_de_orden'],
                'fecha' => $row['fecha_pedido'],
                'codigo_seguimiento' => $row['codigo_seguimiento'],
            );
            array_push($compras, $item);
        }
        echo json_encode($compras);
        exit();
        
    }else{  
        echo json_encode(["success"=>0]);
    }
}
if(isset($_GET["compras"])){
    $rut = $_GET["compras"];
    ComprasUsuario($rut);
}
Function DetalleCompra($id_venta){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $compras = array();
    $sql = "SELECT * FROM producto_pedido WHERE id_venta =$id_venta";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $id = $row['id_producto'];
            $sql1 = "SELECT nombre_producto FROM productos where id_producto = $id";
            $query1 = $conexion -> query($sql1);
            $nombre = $query1->fetch(PDO::FETCH_ASSOC);
            $item = array(
                'id_venta' => $row['id_venta'],
                'id_producto' => $row['id_producto'],
                'cantidad_producto' => $row['cantidad_producto'],
                'precio_unitario' => $row['precio_unitario'],
                'nombre' => $nombre['nombre_producto'],
            );
            array_push($compras, $item);
        }
        echo json_encode($compras);
        exit();
        
    }else{  
        echo json_encode(["success"=>0]);
    }
}
if(isset($_GET["DetalleCompra"])){
    $id_venta = $_GET["DetalleCompra"];
    DetalleCompra($id_venta);
}
Function DetalleV($id_venta){
    include_once 'db.php';
    $objeto = new Conexion();
    $conexion = $objeto->Conectar();
    $detalleV = array();
    $sql = "SELECT * FROM venta WHERE id_venta ='$id_venta'";
    $query = $conexion -> query($sql);
    if($query->rowCount()){
        while($row = $query-> fetch(PDO::FETCH_ASSOC)){
            $item = array(
                'id' => $row['id_venta'],
                'rut' => $row['rut_usuario'],
                'total' => $row['total_a_pagar_orden'],
                'estado' => $row['estado_de_orden'],
                'fecha' => $row['fecha_pedido'],
                'cod_seguimiento' => $row['codigo_seguimiento'],
            );
            array_push($detalleV, $item);
        }
        echo json_encode($detalleV);
        exit();
        
    }else{  
        echo json_encode(["success"=>0]);
    }
}
if(isset($_GET["detalleV"])){
    $id_venta = $_GET["detalleV"];
    DetalleV($id_venta);
}

?>