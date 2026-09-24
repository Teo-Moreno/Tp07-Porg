using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Tp07.Models;

namespace Tp07.Controllers;

public class HomeController : Controller
{
    public IActionResult Index()
    {
        int? idUsuario = HttpContext.Session.ObtenerIdUsuario();
        if (idUsuario == null)
            return RedirectToAction("Login", "Account");

        List<Publicacion> publicaciones = BD.ObtenerPublicaciones(0, Publicacion.CantidadPorPagina, idUsuario.Value);
        ViewBag.HayMas = BD.ContarPublicaciones() > publicaciones.Count;

        return View(publicaciones);
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
