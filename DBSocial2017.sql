USE [master]
GO
CREATE DATABASE [DBRedSocial]
GO
USE [DBRedSocial]
GO
/****** Object:  Table [dbo].[Comentarios]    Script Date: 22/9/2026 18:31:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comentarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPublicacion] [int] NOT NULL,
	[IdUsuarioComenta] [int] NOT NULL,
	[Texto] [text] NOT NULL,
	[FechaComentario] [datetime] NOT NULL,
 CONSTRAINT [PK_Comentarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publicaciones]    Script Date: 22/9/2026 18:31:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publicaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Titulo] [varchar](200) NULL,
	[Descripcion] [text] NULL,
	[Imagen] [varchar](50) NULL,
	[FechaPublicacion] [datetime] NULL,
 CONSTRAINT [PK_Publicaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicacionesMeGusta]    Script Date: 22/9/2026 18:31:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicacionesMeGusta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPublicación] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
 CONSTRAINT [PK_PublicacionesMeGusta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 22/9/2026 18:31:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NULL,
	[Contraseña] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Comentarios] ON 

INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (1, 1, 2, N'¡Qué lindo Bariloche! Tengo muchas ganas de volver.', CAST(N'2026-09-01T11:15:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (2, 1, 3, N'Muy buena foto. ¿Fuiste al Cerro Catedral?', CAST(N'2026-09-01T12:20:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (3, 2, 4, N'La próxima me sumo al partido.', CAST(N'2026-09-05T19:10:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (4, 3, 2, N'¡Éxitos con el proyecto!', CAST(N'2026-09-12T17:30:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (5, 3, 5, N'Después contanos de qué se trata.', CAST(N'2026-09-12T18:05:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (6, 4, 1, N'¡Qué buen recital!', CAST(N'2026-09-14T23:00:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (7, 4, 3, N'Yo también estuve. Estuvo excelente.', CAST(N'2026-09-15T09:15:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (8, 5, 4, N'Tiene muy buena pinta esa pizza.', CAST(N'2026-09-16T21:10:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (9, 6, 5, N'Excelente foto del atardecer.', CAST(N'2026-09-18T20:00:00.000' AS DateTime))
INSERT [dbo].[Comentarios] ([Id], [IdPublicacion], [IdUsuarioComenta], [Texto], [FechaComentario]) VALUES (10, 7, 2, N'¡Felicitaciones! A seguir entrenando.', CAST(N'2026-09-20T18:20:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comentarios] OFF
GO
SET IDENTITY_INSERT [dbo].[Publicaciones] ON 

INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (1, 1, N'Mi viaje a Bariloche', N'Les comparto una foto de mi viaje a Bariloche. Un lugar increíble.', N'bariloche.jpg', CAST(N'2026-09-01T10:30:00.000' AS DateTime))
INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (2, 1, N'Tarde de fútbol', N'Partido con amigos después de mucho tiempo. Terminamos agotados.', N'futbol.jpg', CAST(N'2026-09-05T18:15:00.000' AS DateTime))
INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (3, 1, N'Mi nuevo proyecto', N'Estoy comenzando un nuevo proyecto de programación y quería compartirlo.', N'proyecto.jpg', CAST(N'2026-09-12T16:40:00.000' AS DateTime))
INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (4, 2, N'Recital del fin de semana', N'Una noche increíble escuchando música en vivo.', N'recital.jpg', CAST(N'2026-09-14T22:10:00.000' AS DateTime))
INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (5, 3, N'Aprendiendo a cocinar', N'Primer intento preparando pizza casera. Salió mucho mejor de lo esperado.', N'pizza.jpg', CAST(N'2026-09-16T20:25:00.000' AS DateTime))
INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (6, 4, N'Atardecer en Buenos Aires', N'Una foto del atardecer que saqué mientras volvía a casa.', N'atardecer.jpg', CAST(N'2026-09-18T19:05:00.000' AS DateTime))
INSERT [dbo].[Publicaciones] ([Id], [IdUsuario], [Titulo], [Descripcion], [Imagen], [FechaPublicacion]) VALUES (7, 5, N'Terminando el entrenamiento', N'Después de varias semanas finalmente pude completar todo el entrenamiento.', N'entrenamiento.jpg', CAST(N'2026-09-20T17:30:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Publicaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[PublicacionesMeGusta] ON 

INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (1, 1, 2)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (2, 1, 3)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (3, 1, 4)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (4, 2, 2)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (5, 2, 5)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (6, 3, 4)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (7, 4, 1)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (8, 4, 3)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (9, 5, 1)
INSERT [dbo].[PublicacionesMeGusta] ([Id], [IdPublicación], [IdUsuario]) VALUES (10, 6, 5)
SET IDENTITY_INSERT [dbo].[PublicacionesMeGusta] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([Id], [NombreUsuario], [Contraseña], [Nombre], [Apellido]) VALUES (1, N'juanperez', N'juan123', N'Juan', N'Perez')
INSERT [dbo].[Usuarios] ([Id], [NombreUsuario], [Contraseña], [Nombre], [Apellido]) VALUES (2, N'sofiamartin', N'sofia123', N'Sofia', N'Martin')
INSERT [dbo].[Usuarios] ([Id], [NombreUsuario], [Contraseña], [Nombre], [Apellido]) VALUES (3, N'lucasgarcia', N'lucas123', N'Lucas', N'Garcia')
INSERT [dbo].[Usuarios] ([Id], [NombreUsuario], [Contraseña], [Nombre], [Apellido]) VALUES (4, N'valentinalopez', N'valen123', N'Valentina', N'Lopez')
INSERT [dbo].[Usuarios] ([Id], [NombreUsuario], [Contraseña], [Nombre], [Apellido]) VALUES (5, N'tomasrodriguez', N'tomas123', N'Tomas', N'Rodriguez')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[Comentarios]  WITH CHECK ADD  CONSTRAINT [FK_Comentarios_Publicaciones] FOREIGN KEY([IdPublicacion])
REFERENCES [dbo].[Publicaciones] ([Id])
GO
ALTER TABLE [dbo].[Comentarios] CHECK CONSTRAINT [FK_Comentarios_Publicaciones]
GO
ALTER TABLE [dbo].[Comentarios]  WITH CHECK ADD  CONSTRAINT [FK_Comentarios_Usuarios] FOREIGN KEY([IdUsuarioComenta])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Comentarios] CHECK CONSTRAINT [FK_Comentarios_Usuarios]
GO
ALTER TABLE [dbo].[Publicaciones]  WITH CHECK ADD  CONSTRAINT [FK_Publicaciones_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Publicaciones] CHECK CONSTRAINT [FK_Publicaciones_Usuarios]
GO
ALTER TABLE [dbo].[PublicacionesMeGusta]  WITH CHECK ADD  CONSTRAINT [FK_PublicacionesMeGusta_Publicaciones] FOREIGN KEY([IdPublicación])
REFERENCES [dbo].[Publicaciones] ([Id])
GO
ALTER TABLE [dbo].[PublicacionesMeGusta] CHECK CONSTRAINT [FK_PublicacionesMeGusta_Publicaciones]
GO
ALTER TABLE [dbo].[PublicacionesMeGusta]  WITH CHECK ADD  CONSTRAINT [FK_PublicacionesMeGusta_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[PublicacionesMeGusta] CHECK CONSTRAINT [FK_PublicacionesMeGusta_Usuarios]
GO
