<%-- 
    Document   : home
    Created on : 14-ene-2020, 10:47:07
    Author     : Carlopyk
--%>

<%@page import="pojos.Producto"%>
<%@page import="pojos.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    <link rel="stylesheet" href="css/mycss.css">
    
    <title>FosterWeb</title>
  </head>
  <body>
      <div class="container">
        <header>
            <img src="img/logo.png" alt="logo" />
        </header>
        <%
         	ArrayList<Categoria> categorias = (ArrayList<Categoria>)session.getAttribute("categorias");
            ArrayList<Producto> productos = (ArrayList<Producto>)session.getAttribute("productos");
    		
        	int posCategoria = 0;
        	int pantalla = (int)(session.getAttribute("pantalla"));
        	switch(pantalla) {
        	  case 0:%>
				 <!-- Primera pantalla -->
        <div class="row bg-light">
            <div class="col-sm-12 mr-1 ml-1" id="fotos">
                <div class="slider">
                    <ul>
                        <li> <img src="img/slider1.png" alt="img1"> </li>
                        <li> <img src="img/slider2.png" alt="img2"> </li>
                        <li> <img src="img/slider3.png" alt="img3"> </li>
                    </ul>
                </div>
            </div>
	           <%
	           	for (int i=0 ; i < categorias.size(); i++){
	           %>
	            <div class="col-sm-12 col-md-6 col-lg-4 mt-2">
                    <div class="card">
                        <a href="Controller?op=dameproductos&i=<%=i%>">
                        	<img src="img/<%=categorias.get(i).getNombre()%>.png" class="card-img-top" alt="<%=categorias.get(i).getNombre()%>">
                        </a>
                        <div class="card-body">
                            <h5 class="card-title text-center"><%=categorias.get(i).getNombre()%></h5>
                        </div>
                    </div>
	            </div>
               <%
               	}
               %>
        </div>
        	    <%break;
        	  case 1:%>
        	    <!-- Segunda pantalla -->
        <div class="row bg-light">
            <div class="col-sm-12 mr-1 ml-1" id="fotos">
                <div class="slider">
                    <ul>
                        <li> <img src="img/slider1.png" alt="img1"> </li>
                        <li> <img src="img/slider2.png" alt="img2"> </li>
                        <li> <img src="img/slider3.png" alt="img3"> </li>
                    </ul>
                </div>
            </div>
           <%
           if(productos!= null){
	           	for (int i=0 ; i < productos.size(); i++){
	           %>
	            <div class="col-sm-12 col-md-6 col-lg-4 mt-2 ">
	                <div class="card">
	                 	<a href="Controller?op=damedetalles&iproducto=<%=i%>">
	                      	 <img src="<%=productos.get(i).getImagen() %>" class="card-img-top" alt="<%=productos.get(i).getTitulo()%>">
	                    </a>
	                   <div class="card-body">
	                       <h5 class="card-title"><%=productos.get(i).getTitulo()%></h5>
	                   </div>
	                </div>
	            </div>
	        	<%
	           	}   
           }
            %>
        </div>
        	    <%break;
        	  case 2:%>
    <!-- Tercera pantalla -->
    	<% 
    		Producto productoDetalle = (Producto)session.getAttribute("productoDetalle");
    		int puntos = (int)session.getAttribute("puntos");
    		
    		if (productoDetalle!=null){
    	%>
        <div class="row" style="background: color url(<%=productoDetalle.getFondo() %>);">
            <div class="col-sm-12 mr-1 ml-1" id="fotos">
                <div class="slider">
                    <ul>
                        <li> <img src="img/slider1.png" alt="img1"> </li>
                        <li> <img src="img/slider2.png" alt="img2"> </li>
                        <li> <img src="img/slider3.png" alt="img3"> </li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-8 offset-sm-2">
                <div class="text-center">
                    <% for (int i = 0; i < puntos; i++) { %>
                  	     <span class="display-4">&#9733;</span>                    	
                    <%
                    }
                    %>
                </div></br>
                <div class="text-center">
                    <img src="<%=productoDetalle.getImagen() %>" class="card-img-top" alt="<%=productoDetalle.getTitulo()%>"></br>
                    <span><%=productoDetalle.getTitulo()%></span></br>
                    <span><%=productoDetalle.getBody()%></span></br>
                    <span class="rating">
                        <a href="Controller?op=rating&rating=1">&#9733;</a>
                        <a href="Controller?op=rating&rating=2">&#9733;</a>
                        <a href="Controller?op=rating&rating=3">&#9733;</a>
                        <a href="Controller?op=rating&rating=4">&#9733;</a>
                        <a href="Controller?op=rating&rating=5">&#9733;</a>
                        </span>
                </div>
            </div>
        </div>
        <%	
    		} %>
        	    <%break;
        	}
         %>

        
        <footer class="text-center text-white">
            Foster Hollywood
        </footer>
      </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>