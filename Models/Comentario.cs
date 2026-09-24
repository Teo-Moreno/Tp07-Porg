namespace Tp07.Models;

public class Comentario
{
    public int Id { get; set; }
    public int IdPublicacion { get; set; }
    public int IdUsuarioComenta { get; set; }
    public string Texto { get; set; } = "";
    public DateTime FechaComentario { get; set; }

    // Dato que viene del JOIN con Usuarios
    public string NombreUsuario { get; set; } = "";

    public string FechaFormateada => FechaComentario.ToString("dd/MM/yyyy HH:mm");
}
