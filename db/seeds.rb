# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.find_or_create_by!(email: "moderador@uc.cl") do |u|
  u.password              = "123456"
  u.password_confirmation = "123456"
  u.nombre                = "Moderador"
  u.admin                 = true
end

usuario = User.find_or_create_by!(email: "autor@uc.cl") do |u|
  u.password              = "123456"
  u.password_confirmation = "123456"
  u.nombre                = "Resident Evil Expert"
  u.descripcion           = "Soy un experto en Resident Evil."
  u.telefono              = "123456789"
  u.admin                 = false
end

User.find_or_create_by!(email: "melisaorchard@uc.cl") do |u|
  u.password              = "noolvidar"
  u.password_confirmation = "noolvidar"
  u.nombre                = "Coli"
  u.descripcion           = "Me gusta programar."
  u.telefono              = "42950100"
  u.admin                 = false
end

ruta_imagen = Rails.root.join("app/assets/images/landing/bg.jpg")
if File.exist?(ruta_imagen)
  usuario.imagen_perfil.attach(
    io: File.open(ruta_imagen),
    filename: "bg.jpg",
    content_type: "image/jpg"
  )
end

blog_re1 = Blog.find_or_create_by!(titulo: "Resident Evil (1996): El Origen del Survival Horror y la Pesadilla en la Mansión Spencer") do |b|
  b.descripcion          = "En 1996, Capcom lanzó Resident Evil para la PlayStation original, marcando un hito en la historia de los videojuegos al definir el género del survival horror. Desarrollado por Shinji Mikami y Tokuro Fujiwara, el juego introdujo a los jugadores en una experiencia de terror y supervivencia sin precedentes, estableciendo las bases para una franquicia que perdura hasta hoy.

                            La historia comienza el 24 de julio de 1998, cuando el equipo Bravo de S.T.A.R.S. (Special Tactics And Rescue Service) es enviado a las Montañas Arklay, cerca de Raccoon City, para investigar una serie de asesinatos caracterizados por signos de canibalismo. Tras perder contacto con ellos, el equipo Alpha es desplegado y, tras ser atacados por criaturas conocidas como Cerberus, se refugian en una mansión aparentemente abandonada. Los miembros restantes del equipo Alpha —Jill Valentine, Chris Redfield, Barry Burton y Albert Wesker— se ven atrapados en la mansión, donde descubren que la Corporación Umbrella ha estado realizando experimentos ilegales con un agente biológico conocido como Virus-T, dando lugar a zombis y otras criaturas mutantes.

                            El juego permite a los jugadores elegir entre Jill Valentine y Chris Redfield, cada uno con habilidades y desafíos únicos. La jugabilidad se caracteriza por su atmósfera tensa, recursos limitados, resolución de acertijos y enfrentamientos estratégicos con enemigos. La narrativa se desarrolla a través de documentos encontrados y encuentros con otros personajes, revelando traiciones y secretos oscuros dentro de S.T.A.R.S. y Umbrella.

                            Resident Evil no solo fue innovador en su jugabilidad y narrativa, sino que también dejó una marca indeleble en la cultura popular, inspirando numerosas secuelas, remakes y adaptaciones en otros medios. Su éxito consolidó a Capcom como un líder en el desarrollo de juegos de terror y estableció a Resident Evil como una de las franquicias más influyentes en la industria del entretenimiento."
  b.tipo_publicacion     = "noticia"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil #SurvivalHorror #MansiónSpencer #UmbrellaCorporation #JillValentine #ChrisRedfield #AlbertWesker #VirusT #Zombis #VideojuegosClásicos #Capcom"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re1.webp")
if File.exist?(ruta_imagen)
  blog_re1.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re1.webp",
    content_type: "image/webp"
  )
end

blog_re2 = Blog.find_or_create_by!(titulo: "Resident Evil 2 (1998): El Caos de Raccoon City y la Evolución del Survival Horror") do |b|
  b.descripcion          = "Resident Evil 2, lanzado en 1998 por Capcom para la PlayStation original, es una de las entregas más emblemáticas de la saga y un pilar fundamental en la evolución del género survival horror. Ambientado dos meses después de los eventos del primer juego, la historia se desarrolla en Raccoon City, una ciudad ficticia del Medio Oeste estadounidense que ha sido devastada por un brote del virus-T, transformando a sus habitantes en zombis y otras criaturas mutantes.

                            Los protagonistas son Leon S. Kennedy, un policía novato en su primer día de servicio, y Claire Redfield, una joven estudiante universitaria que busca a su hermano desaparecido, Chris Redfield. Ambos llegan a Raccoon City sin conocer la magnitud del desastre que les espera. Al poco tiempo de su llegada, se ven atrapados en una ciudad infestada de horrores biológicos y deben luchar por sobrevivir mientras descubren los oscuros secretos detrás del brote.

                            Una de las innovaciones más destacadas de Resident Evil 2 es el Zapping System, que permite a los jugadores experimentar la historia desde dos perspectivas diferentes: el escenario A y el escenario B. Dependiendo del orden en que se jueguen las campañas de Leon y Claire, los eventos y encuentros varían, ofreciendo una narrativa más profunda y rejugabilidad.

                            A lo largo del juego, los protagonistas se encuentran con varios personajes clave. Claire conoce a Sherry Birkin, una niña que huye de una criatura mutante. A través de su interacción, Claire descubre que Sherry es hija de William Birkin, el científico responsable de la creación del virus-G, una evolución del virus-T. William, tras ser atacado por agentes de Umbrella que intentaban robar su investigación, se inyecta el virus-G, transformándose en una criatura monstruosa que persigue a los protagonistas durante el juego.

                            Leon, por su parte, se encuentra con Ada Wong, una misteriosa mujer que afirma buscar a su novio desaparecido, John, un investigador de Umbrella. A medida que avanza la historia, se revelan las verdaderas intenciones de Ada y su conexión con organizaciones que buscan obtener el virus-G para sus propios fines.

                            El juego se desarrolla en varios escenarios icónicos, como la estación de policía de Raccoon City, las alcantarillas y un laboratorio subterráneo de Umbrella. Cada área está meticulosamente diseñada para ofrecer desafíos, acertijos y encuentros con enemigos, manteniendo una atmósfera tensa y opresiva.

                            Resident Evil 2 introdujo nuevos enemigos que se han convertido en clásicos de la serie, como los Lickers, criaturas sin piel con lenguas largas y afiladas, y el implacable Tyrant, también conocido como Mr. X, una arma biológica enviada por Umbrella para eliminar a los supervivientes y recuperar muestras del virus-G.

                            La jugabilidad combina exploración, resolución de acertijos y combate, con recursos limitados que obligan al jugador a tomar decisiones estratégicas sobre cuándo luchar o huir. La gestión del inventario y el uso de cintas de tinta para guardar el progreso añaden una capa adicional de tensión.

                            Resident Evil 2 fue un éxito comercial y crítico, vendiendo millones de copias en todo el mundo y consolidando la franquicia como una de las más importantes en la industria de los videojuegos. Su impacto ha perdurado a lo largo de los años, inspirando remakes, adaptaciones cinematográficas y una base de fans dedicada."
  b.tipo_publicacion     = "noticia"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil2 #LeonSKennedy #ClaireRedfield #RaccoonCity #UmbrellaCorporation #VirusT #VirusG #SurvivalHorror #Lickers #MrX #AdaWong #SherryBirkin #WilliamBirkin #ZappingSystem #PlayStation #Capcom #JuegosClásicos #Videojuegos"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil 2"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re2.jpg")
if File.exist?(ruta_imagen)
  blog_re2.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re2.jpg",
    content_type: "image/jpeg"
  )
end

blog_re3 = Blog.find_or_create_by!(titulo: "Resident Evil 3: Nemesis (1999): La implacable caza en las ruinas de Raccoon City") do |b|
  b.descripcion          = "Resident Evil 3: Nemesis, lanzado en 1999 por Capcom para la PlayStation original, es una de las entregas más emblemáticas de la saga y un pilar fundamental en la evolución del género survival horror. Ambientado en Raccoon City, una ciudad ficticia del Medio Oeste estadounidense devastada por un brote del virus-T, la historia sigue a Jill Valentine, miembro de S.T.A.R.S., mientras lucha por sobrevivir y escapar de la ciudad infestada de zombis y otras criaturas mutantes.

                            La narrativa de Resident Evil 3 se desarrolla en paralelo y posteriormente a los eventos de Resident Evil 2, ofreciendo una perspectiva más amplia del desastre que asola Raccoon City. Jill Valentine, tras los sucesos en la Mansión Spencer, se encuentra atrapada en la ciudad durante el brote viral. Su objetivo es escapar mientras es perseguida por una nueva arma biológica de Umbrella: Nemesis, un Tyrant modificado con inteligencia superior y una misión específica: eliminar a todos los miembros restantes de S.T.A.R.S.

                            Una de las características más destacadas de Resident Evil 3 es la implementación de Nemesis como un enemigo persistente que puede aparecer en cualquier momento, incluso atravesando paredes o persiguiendo al jugador de una zona a otra. Esta mecánica introduce un nivel de tensión constante, ya que el jugador nunca está completamente seguro. Nemesis está armado con un lanzacohetes y posee habilidades como correr, usar tentáculos para atacar y una resistencia formidable, lo que lo convierte en una amenaza constante.

                            El juego introduce varias innovaciones en la jugabilidad. Se implementa un sistema de esquiva que permite a Jill evitar ataques enemigos si se ejecuta con el tiempo adecuado. También se añade la posibilidad de realizar un giro rápido de 180 grados, facilitando la evasión en situaciones críticas. Además, se incorpora un sistema de creación de municiones utilizando diferentes tipos de pólvora, lo que permite al jugador adaptar su arsenal según las necesidades y recursos disponibles.

                            Otro elemento novedoso es el modo de selección en vivo, donde en ciertos momentos críticos, el jugador debe tomar decisiones rápidas que afectan el desarrollo de la historia y los eventos subsiguientes. Estas elecciones pueden influir en el destino de personajes secundarios y en el final del juego, aumentando la rejugabilidad.

                            Resident Evil 3 también presenta el minijuego desbloqueable The Mercenaries - Operation Mad Jackal, en el cual el jugador puede controlar a personajes como Carlos Oliveira, Mikhail Victor y Nicholai Ginovaef. Cada uno tiene un inventario único, y el objetivo es llegar desde el teleférico hasta el almacén en un tiempo limitado, eliminando enemigos y rescatando rehenes para obtener bonificaciones de tiempo y recursos.

                            En cuanto a los enemigos, además de los zombis tradicionales, el juego introduce nuevas criaturas como los Drain Deimos, Brain Suckers, Hunter Beta y Gamma, y el enorme gusano Grave Digger. Estas criaturas, junto con la constante amenaza de Nemesis, contribuyen a una atmósfera opresiva y peligrosa.

                            La ambientación de Raccoon City está meticulosamente diseñada, con escenarios que van desde calles devastadas hasta instalaciones subterráneas de Umbrella. La música y los efectos de sonido complementan la sensación de desesperación y urgencia, sumergiendo al jugador en una experiencia intensa.

                            Resident Evil 3: Nemesis fue un éxito comercial y crítico, vendiendo millones de copias en todo el mundo. Su enfoque en la acción, combinado con elementos clásicos de survival horror, lo convirtió en una entrega memorable que expandió y enriqueció el universo de Resident Evil."
  b.tipo_publicacion     = "reseña"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil3 #Nemesis #JillValentine #RaccoonCity #UmbrellaCorporation #VirusT #SurvivalHorror #CarlosOliveira #TheMercenaries #DrainDeimos #HunterGamma #GraveDigger #VideojuegosClásicos #Capcom #PlayStation"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil 3"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re3.jpg")
if File.exist?(ruta_imagen)
  blog_re3.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re3.jpg",
    content_type: "image/jpeg"
  )
end

blog_re4 = Blog.find_or_create_by!(titulo: "Resident Evil 4 (2005): La revolución que redefinió el survival horror") do |b|
  b.descripcion          = "Resident Evil 4, lanzado en 2005 por Capcom, marcó un antes y un después en la industria de los videojuegos. Esta entrega no solo revitalizó una franquicia que comenzaba a mostrar signos de desgaste, sino que también estableció nuevos estándares para el género del survival horror y los juegos de acción en tercera persona.

                            Desde el inicio, el juego nos sumerge en una atmósfera tensa y opresiva. Leon S. Kennedy, ahora agente del gobierno estadounidense, es enviado a una remota aldea en España para rescatar a la hija del presidente, Ashley Graham. Lo que comienza como una misión de rescate se transforma rápidamente en una pesadilla cuando Leon se enfrenta a los Ganados, aldeanos infectados por un parásito conocido como Las Plagas.

                            Una de las innovaciones más destacadas de Resident Evil 4 es su sistema de cámara al hombro. Esta perspectiva permitió una mayor inmersión y precisión en los combates, revolucionando la forma en que se jugaban los títulos de acción en tercera persona. Esta mecánica ha influido en innumerables juegos posteriores, convirtiéndose en un estándar de la industria.

                            El diseño de niveles es otro aspecto sobresaliente. Cada escenario está meticulosamente construido para ofrecer desafíos únicos, desde aldeas rurales hasta castillos góticos y laboratorios subterráneos. La variedad de entornos mantiene la experiencia fresca y emocionante a lo largo de toda la campaña.

                            La jugabilidad combina elementos de acción y supervivencia de manera magistral. La gestión del inventario, la mejora de armas y la toma de decisiones estratégicas son fundamentales para avanzar. Además, el juego introduce eventos de acción rápida (QTE) que mantienen al jugador en constante alerta.

                            Los enemigos en Resident Evil 4 son memorables y variados. Desde los implacables Ganados hasta jefes como el temible Regenerador, cada encuentro es una prueba de habilidad y estrategia. La inteligencia artificial de los enemigos es notable, obligando al jugador a adaptarse constantemente.

                            La narrativa, aunque sencilla, es efectiva. La relación entre Leon y Ashley añade una dimensión emocional al juego, y los giros argumentales mantienen el interés hasta el final. Los personajes secundarios, como Ada Wong y Luis Sera, enriquecen la historia con sus propias motivaciones y secretos.

                            La música y los efectos de sonido contribuyen significativamente a la atmósfera del juego. Las composiciones musicales intensifican la tensión en los momentos clave, mientras que los sonidos ambientales sumergen al jugador en el mundo del juego.

                            En términos de rejugabilidad, Resident Evil 4 ofrece múltiples modos de dificultad, contenido desbloqueable y minijuegos como The Mercenaries, que extienden la vida útil del título y ofrecen nuevos desafíos para los jugadores más dedicados.

                            En conclusión, Resident Evil 4 no solo es una obra maestra del survival horror, sino también un hito en la historia de los videojuegos. Su impacto perdura hasta hoy, y su influencia se puede ver en numerosos títulos que han seguido su estela. Es un juego que todo aficionado al género debe experimentar."
  b.tipo_publicacion     = "opinión"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil4 #LeonSKennedy #SurvivalHorror #LasPlagas #Ganados #Capcom #Videojuegos #Acción #Terror #CámaraAlHombro #Revolución #Clásico"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil 4"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re4.jpg")
if File.exist?(ruta_imagen)
  blog_re4.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re4.jpg",
    content_type: "image/jpeg"
  )
end

blog_re5 = Blog.find_or_create_by!(titulo: "Resident Evil 5 (2009): Acción cooperativa y el ocaso del survival horror clásico") do |b|
  b.descripcion          = "Resident Evil 5, lanzado en 2009 por Capcom, representa un punto de inflexión en la saga, alejándose de las raíces del survival horror para adentrarse en un enfoque más orientado a la acción y la cooperación. Ambientado en la ficticia región africana de Kijuju, el juego sigue a Chris Redfield, ahora miembro de la BSAA, y a su nueva compañera, Sheva Alomar, en una misión para detener una amenaza bioterrorista relacionada con un nuevo virus llamado Uroboros.

                            La jugabilidad de Resident Evil 5 se centra en la cooperación entre los dos protagonistas, permitiendo tanto el juego en solitario con inteligencia artificial como el modo cooperativo en línea o local. Esta mecánica introduce una dinámica diferente, donde la coordinación y el trabajo en equipo son esenciales para superar los desafíos.

                            El juego presenta una variedad de enemigos, desde los Majini, infectados por el parásito Las Plagas, hasta criaturas mutantes creadas por el virus Uroboros. Los enfrentamientos con jefes son intensos y requieren estrategias específicas, aprovechando las habilidades y recursos de ambos personajes.

                            A nivel narrativo, Resident Evil 5 profundiza en la historia de la saga, revelando detalles sobre la organización Umbrella y el pasado de personajes clave como Albert Wesker y Jill Valentine. La trama explora temas de traición, manipulación genética y el deseo de poder, culminando en un enfrentamiento final que cierra varios arcos argumentales.

                            Visualmente, el juego destaca por sus gráficos detallados y ambientes variados, desde pueblos rurales hasta instalaciones subterráneas. La iluminación y los efectos visuales contribuyen a crear una atmósfera tensa y envolvente.

                            Resident Evil 5 recibió críticas mixtas por su cambio de enfoque hacia la acción, pero también fue elogiado por su modo cooperativo y su narrativa envolvente. Aunque se aleja del estilo clásico de la saga, ofrece una experiencia intensa y entretenida que amplía el universo de Resident Evil."
  b.tipo_publicacion     = "reseña"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil5 #ChrisRedfield #ShevaAlomar #Kijuju #Uroboros #Majini #Cooperativo #Acción #Capcom"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil 5"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re5.jpg")
if File.exist?(ruta_imagen)
  blog_re5.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re5.jpg",
    content_type: "image/jpeg"
  )
end

blog_re6 = Blog.find_or_create_by!(titulo: "Resident Evil 6 (2012): La evolución de la acción en la saga Resident Evil") do |b|
  b.descripcion          = "Resident Evil 6, lanzado en 2012 por Capcom, representa una de las entregas más ambiciosas y divisivas de la franquicia. Con cuatro campañas interconectadas y una jugabilidad orientada a la acción, el juego busca ofrecer una experiencia cinematográfica que fusiona elementos de terror, drama y adrenalina.

                            La narrativa se desarrolla a través de las campañas de Leon S. Kennedy y Helena Harper, Chris Redfield y Piers Nivans, Jake Muller y Sherry Birkin, y finalmente Ada Wong. Cada una ofrece una perspectiva única sobre un brote global del virus C, llevando a los jugadores por escenarios que van desde la ciudad estadounidense de Tall Oaks hasta la metrópolis china de Lanshiang.

                            La jugabilidad de Resident Evil 6 se caracteriza por su enfoque en la acción. Los jugadores pueden moverse y disparar simultáneamente, realizar esquivas, contraataques y utilizar un sistema de cobertura. Además, se introducen mecánicas como el deslizamiento y los ataques cuerpo a cuerpo mejorados, ofreciendo una experiencia más dinámica y fluida.

                            Cada campaña presenta un estilo de juego distinto. La de Leon y Helena evoca el survival horror clásico, con ambientes oscuros y enemigos zombificados. La de Chris y Piers se centra en la acción militar, enfrentando a los jugadores contra enemigos más organizados y armados. La campaña de Jake y Sherry combina elementos de acción y sigilo, mientras que la de Ada ofrece desafíos de infiltración y resolución de acertijos.

                            El juego también incluye modos adicionales como Los Mercenarios, que desafía a los jugadores a eliminar enemigos en un tiempo limitado, y Agent Hunt, donde se puede controlar a las criaturas enemigas para enfrentarse a otros jugadores.

                            Visualmente, Resident Evil 6 destaca por sus gráficos detallados y efectos cinematográficos. Las escenas de acción están cuidadosamente coreografiadas, y los entornos varían desde ciudades en ruinas hasta laboratorios subterráneos, ofreciendo una amplia variedad de escenarios.

                            A pesar de sus innovaciones, Resident Evil 6 recibió críticas mixtas. Algunos elogiaron su ambición y variedad, mientras que otros señalaron que el enfoque en la acción diluía los elementos de terror que definieron las entregas anteriores.

                            En resumen, Resident Evil 6 es una entrega que busca expandir los límites de la franquicia, ofreciendo una experiencia intensa y variada que, aunque alejada de sus raíces, aporta una nueva dimensión al universo de Resident Evil."
  b.tipo_publicacion     = "reseña"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil6 #LeonSKennedy #ChrisRedfield #JakeMuller #AdaWong #VirusC #Acción #Capcom"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil 6"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re6.jpg")
if File.exist?(ruta_imagen)
  blog_re6.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re6.jpg",
    content_type: "image/jpeg"
  )
end

blog_re7 = Blog.find_or_create_by!(titulo: "Guía definitiva para superar Resident Evil 7 en dificultad Manicomio") do |b|
  b.descripcion          = "Resident Evil 7: Biohazard, lanzado en 2017, regresó al horror en primera persona. El modo Manicomio es el desafío máximo: enemigos más rápidos y letales, pocos puntos de guardado y cambios en ubicación de objetos.
Consejos:
- Gestión de recursos: conserva munición y curaciones, explora cada rincón.
- Enfrentamientos: aprende patrones de ataque y evita combates innecesarios.
- Uso de cintas: planifica guardados tras secciones difíciles.
- Mejoras: colecciona monedas antiguas para la Magnum y esteroides.
Estrategias:
- Casa principal: evita a Jack Baker y recolecta piezas para la escopeta.
- Casa vieja: usa lanzallamas contra insectos y apunta a Marguerite.
- Barco y mina: administra recursos y usa armas poderosas con cautela.
Recompensas: munición infinita y trofeo."
  b.tipo_publicacion     = "guía"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvil7 #ModoManicomio #Guía #SurvivalHorror #EthanWinters #FamiliaBaker"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil 7"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re7.jpg")
if File.exist?(ruta_imagen)
  blog_re7.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re7.jpg",
    content_type: "image/jpeg"
  )
end

blog_re8 = Blog.find_or_create_by!(titulo: "Resident Evil Village: Entre la tradición del horror y la innovación moderna") do |b|
  b.descripcion          = "Resident Evil Village, también conocido como Resident Evil 8, es la octava entrega principal de la aclamada franquicia de survival horror de Capcom. Lanzado en mayo de 2021, el juego continúa la historia de Ethan Winters tras los eventos de Resident Evil 7: Biohazard, sumergiendo a los jugadores en una experiencia que combina elementos clásicos del género con innovaciones modernas.

                            La narrativa se desarrolla en una remota aldea europea, donde Ethan busca a su hija secuestrada, enfrentándose a horrores inimaginables y descubriendo secretos oscuros que conectan con la historia de la serie. El juego destaca por su atmósfera opresiva, diseño de enemigos memorables y una jugabilidad que equilibra la exploración, resolución de acertijos y combates intensos.

                            Con una perspectiva en primera persona, Resident Evil Village ofrece una inmersión profunda, permitiendo a los jugadores experimentar el terror de cerca. La inclusión de personajes como Lady Dimitrescu y la diversidad de escenarios, desde castillos góticos hasta fábricas industriales, enriquecen la experiencia y mantienen la tensión constante.

                            La recepción crítica fue mayoritariamente positiva, elogiando su diseño artístico, narrativa envolvente y mecánicas de juego refinadas. Sin embargo, algunos señalaron que el enfoque en la acción en ciertas secciones podía desviar del terror puro que caracteriza a la serie.

                            En resumen, Resident Evil Village representa una evolución significativa en la franquicia, fusionando lo mejor del horror clásico con elementos contemporáneos, y consolidándose como una entrega imprescindible para los aficionados al género."
  b.tipo_publicacion     = "reseña"
  b.estado               = "aprobado"
  b.etiquetas            = "#ResidentEvilVillage #ResidentEvil8 #SurvivalHorror #EthanWinters #LadyDimitrescu"
  b.id_autor             = usuario.id
  b.mensaje_moderacion   = "¡Todo bien!"
  b.game_name            = "Resident Evil Village"
end

ruta_imagen = Rails.root.join("app/assets/images/blogs/re8.jpg")
if File.exist?(ruta_imagen)
  blog_re8.attachment.attach(
    io: File.open(ruta_imagen),
    filename: "re8.jpg",
    content_type: "image/jpeg"
  )
end