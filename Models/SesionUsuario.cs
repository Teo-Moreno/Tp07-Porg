namespace Tp07.Models;

/// <summary>
/// Centraliza el acceso a los datos del usuario logueado guardados en Session.
/// </summary>
public static class SesionUsuario
{
    private const string ClaveId = "IdUsuario";
    private const string ClaveNombreUsuario = "NombreUsuario";

    public static void IniciarSesion(this ISession session, Usuario usuario)
    {
        session.SetInt32(ClaveId, usuario.Id);
        session.SetString(ClaveNombreUsuario, usuario.NombreUsuario);
    }

    public static void CerrarSesion(this ISession session) => session.Clear();

    public static int? ObtenerIdUsuario(this ISession session) => session.GetInt32(ClaveId);

    public static string? ObtenerNombreUsuario(this ISession session) => session.GetString(ClaveNombreUsuario);
}
