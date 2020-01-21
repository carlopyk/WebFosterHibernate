package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import pojos.Categoria;
import pojos.Producto;
import pojos.Punto;
import util.HibernateUtil;


/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
        private ArrayList<Categoria> categorias;
	private Categoria categoria;
	private Producto productoDetalle;
	private List<Producto> productos;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                Session singleton = HibernateUtil.getSessionFactory().openSession();
		HttpSession session = request.getSession();
		String op = request.getParameter("op");
		RequestDispatcher dispatcher;
		if (op.equals("inicio")) {
			int pantalla = 0;
			session.setAttribute("pantalla", pantalla);
                        Query q = singleton.createQuery("from Categoria");
                        categorias = new ArrayList<Categoria>(q.list());
			session.setAttribute("categorias", categorias);
			dispatcher = request.getRequestDispatcher("home.jsp");
			dispatcher.forward(request, response);
			
		} else if (op.equals("dameproductos")) {
			int pantalla = 1;
			session.setAttribute("pantalla", pantalla);
			int i = Integer.parseInt(request.getParameter("i"));
			categorias =(ArrayList<Categoria>)session.getAttribute("categorias");
			categoria = categorias.get(i);
                        Set productosset = categoria.getProductos();
                        productos = new ArrayList<Producto>(productosset);
			session.setAttribute("productos", productos);
			dispatcher = request.getRequestDispatcher("home.jsp");
			dispatcher.forward(request, response);
			
		} else if (op.equals("damedetalles")) {
			int pantalla = 2;
			session.setAttribute("pantalla", pantalla);
			int iproducto = Integer.parseInt(request.getParameter("iproducto"));
			session.setAttribute("iproducto", iproducto);
			productoDetalle = productos.get(iproducto);
                        int puntos = 0;
                        if (!productoDetalle.getPuntos().isEmpty()) {
                            Query q = singleton.createQuery("select round(avg(puntos)) as media from Punto where producto.id = "+productoDetalle.getId());
                            puntos = ((List<Double>)q.list()).get(0).intValue();
                        }
			session.setAttribute("puntos", puntos);
			session.setAttribute("productoDetalle", productoDetalle);
			dispatcher = request.getRequestDispatcher("home.jsp");
			dispatcher.forward(request, response);
			
		} else if (op.equals("rating")) {
			int pantalla = 2;
			session.setAttribute("pantalla", pantalla);
			int iproducto = (int)session.getAttribute("iproducto");
			short rating = Short.parseShort(request.getParameter("rating"));
			productoDetalle = productos.get(iproducto);
                        Punto punto = new Punto();
                        punto.setId(1);
                        punto.setPuntos(rating);
                        punto.setProducto(productoDetalle);
                        Transaction t = singleton.beginTransaction();
                        singleton.persist(punto);
                        t.commit();
			Query q = singleton.createQuery("select round(avg(puntos)) as media from Punto where producto.id = "+productoDetalle.getId());
                        int puntos = ((List<Double>)q.list()).get(0).intValue();
			session.setAttribute("puntos", puntos);
			session.setAttribute("productoDetalle", productoDetalle);
			dispatcher = request.getRequestDispatcher("home.jsp");
			dispatcher.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
