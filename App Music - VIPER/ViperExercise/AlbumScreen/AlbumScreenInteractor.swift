//
//  AlbumScreenInteractor.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 13/11/24.
//
import UIKit

protocol AlbumScreenInteractorProtocol: AnyObject {
    func fetchDataSongs(_ tagAlbum: Int, _ tagArtist: Int)
}

class AlbumScreenInteractor: AlbumScreenInteractorProtocol {
    
    weak var presenter: AlbumScreenPresenterProtocol?
    
    var songs: [AlbumInfo] = []
    
    func fetchDataSongs(_ tagAlbum: Int, _ tagArtist: Int) {
        songs = [
            AlbumInfo(imageSelecAlbum: ["album1_N", "album2_N", "album3_N"], nameSelecAlbum: ["Nevermind", "In Utero", "MTV Unplugged in New York"],
                      infoSelecAlbum: [
                        """
                        \n\nNevermind (1991): Este álbum revolucionó la escena musical y popularizó el grunge en los 90. Contiene el himno "Smells Like Teen Spirit" y otras canciones emblemáticas como "Come as You Are".
                        """,
                        """
                        \n\nIn Utero (1993): Con un sonido más crudo y letras introspectivas, este álbum fue una respuesta de Nirvana a su éxito. Incluye temas como "Heart-Shaped Box" y "All Apologies".
                        """,
                        """
                        \n\nMTV Unplugged in New York (1994): Grabado en vivo, muestra una faceta más íntima de la banda. Destacan versiones acústicas de canciones como "About a Girl" y "The Man Who Sold the World".
                        """
                      ],
                      songsNames: [
                        ["Smells Like Teen Spirit", "Come as You Are", "Lithium", "In Bloom"],
                        ["Heart-Shaped Box", "Rape Me", "Dumb", "All Apologies"],
                        ["About a Girl", "Come as You Are", "The Man Who Sold the World", "Where Did You Sleep Last Night"]
                      ],
                      idSongs: [0, 1, 2, 3],
                      songsTimes: [
                        ["5:01", "3:39", "4:17", "4:15"],
                        ["4:41", "2:49", "2:32", "3:50"],
                        ["3:38", "4:13", "4:20", "5:08"]
                      ]),
            
            AlbumInfo(imageSelecAlbum: ["album1_GNR", "album2_GNR", "album3_GNR"], nameSelecAlbum: ["Appetite for Destruction", "Use Your Illusion I", "Use Your Illusion II"],
                      infoSelecAlbum: [
                        """
                        \n\nAppetite for Destruction (1987): El debut de Guns N' Roses y uno de los álbumes más vendidos de todos los tiempos. Incluye éxitos como "Welcome to the Jungle" y "Sweet Child o' Mine", combinando un sonido crudo con letras provocadoras.
                        """,
                        """
                        \n\nUse Your Illusion I (1991): Parte de un lanzamiento doble, este álbum presenta canciones como "November Rain" y "Don't Cry", mostrando un lado más melódico y ambicioso de la banda.
                        """,
                        """
                        \n\nUse Your Illusion II (1991): Complemento del primer volumen, con temas potentes como "Civil War" y "You Could Be Mine". Este álbum mezcla baladas emotivas con riffs enérgicos.
                        """
                      ],
                      songsNames: [
                        ["Welcome to the Jungle", "Sweet Child o' Mine", "Paradise City", "Nightrain"],
                        ["November Rain", "Don't Cry", "Live and Let Die", "Right Next Door to Hell"],
                        ["Civil War", "You Could Be Mine", "Knockin' on Heaven's Door","Estranged"]
                      ],
                      idSongs: [0, 1, 2, 3],
                      songsTimes: [
                        ["4:32", "5:56", "6:46", "4:28"],
                        ["8:57", "4:44", "3:04", "3:03"],
                        ["7:42", "5:43", "5:36", "9:24"]
                      ]),
            
            AlbumInfo(imageSelecAlbum: ["album1_IM", "album2_IM", "album3_IM"], nameSelecAlbum: ["The Number of the Beast", "Powerslave", "Somewhere in Time"],
                      infoSelecAlbum: [
                        """
                        \n\nThe Number of the Beast (1982): Este álbum es uno de los más icónicos de Iron Maiden. Marcó el debut de Bruce Dickinson como vocalista y catapultó a la banda al éxito global. Destacan canciones como "The Number of the Beast" y "Hallowed Be Thy Name".
                        """,
                        """
                        \n\nPowerslave (1984): Una obra maestra del heavy metal con temas como "Aces High" y "Rime of the Ancient Mariner". Este álbum explora temas históricos y literarios, con un sonido épico que lo convierte en un favorito de los fans.
                        """,
                        """
                        \n\nSomewhere in Time (1986): Con un sonido futurista y el uso de sintetizadores, este álbum presentó una nueva faceta de Iron Maiden. Contiene clásicos como "Wasted Years" y "Stranger in a Strange Land".",
                        """
                      ],
                      songsNames: [
                        ["The Number of the Beast", "Run to the Hills", "Hallowed Be Thy Name","22 Acacia Avenue"],
                        ["Aces High", "2 Minutes to Midnight", "Powerslave", "Rime of the Ancient Mariner"],
                        ["Caught Somewhere in Time", "Wasted Years", "Heaven Can Wait","Stranger in a Strange Land"]
                      ],
                      idSongs: [0, 1, 2, 3],
                      songsTimes: [
                        ["4:50", "3:54", "7:10", "6:34"],
                        ["4:31", "6:00", "7:12", "13:39"],
                        ["7:26", "5:07", "7:24", "5:45"]
                      ]),
            
            AlbumInfo(imageSelecAlbum: ["album1_ACDC", "album2_ACDC", "album3_ACDC"], nameSelecAlbum: ["Back in Black", "Highway to Hell", "The Razors Edge"],
                      infoSelecAlbum: [
                        """
                        \n\nBack in Black (1980): Uno de los álbumes de rock más vendidos y un tributo a Bon Scott, el fallecido vocalista de la banda. Canciones como "Back in Black" y "You Shook Me All Night Long" son clásicos del rock.
                        """,
                        """
                        \n\nHighway to Hell (1979): Este álbum catapultó a AC/DC a la fama mundial con su sonido característico. Incluye temas icónicos como "Highway to Hell" y "Girls Got Rhythm".
                        """,
                        """
                        \n\nThe Razors Edge (1990): Con canciones como "Thunderstruck" y "Moneytalks", este álbum marcó el regreso de AC/DC a la cima de las listas de popularidad en los 90.
                        """
                      ],
                      songsNames: [
                        ["Back in Black", "Hells Bells", "Shoot to Thrill", "You Shook Me All Night Long"],
                        ["Highway to Hell", "Girls Got Rhythm", "Touch Too Much", "If You Want Blood (You've Got It)"],
                        ["Thunderstruck", "Moneytalks", "Are You Ready", "Mistress for Christmas"]
                      ],
                      idSongs: [0, 1, 2, 3],
                      songsTimes: [
                        ["4:15", "5:12", "5:17", "3:30"],
                        ["3:28", "3:24", "4:29", "4:36"],
                        ["4:52", "3:46", "4:10", "4:00"]
                      ]),
            
            AlbumInfo(imageSelecAlbum: ["album1_Q", "album2_Q", "album3_Q"], nameSelecAlbum: ["A Night at the Opera", "News of the World", "The Game"],
                      infoSelecAlbum: [
                        """
                        \n\nA Night at the Opera (1975): Considerado una obra maestra, incluye "Bohemian Rhapsody", una de las canciones más innovadoras y queridas de Queen. Es una mezcla de rock, ópera y experimentación musical.
                        """,
                        """
                        \n\nNews of the World (1977): Con himnos como "We Will Rock You" y "We Are the Champions", este álbum se convirtió en un éxito mundial y es uno de los más conocidos de Queen.
                        """,
                        """
                        \n\nThe Game (1980): Presenta un cambio en el sonido de Queen, con influencias del pop y el rock. Incluye éxitos como "Another One Bites the Dust" y "Crazy Little Thing Called Love".
                        """
                      ],
                      songsNames: [
                        ["Bohemian Rhapsody", "You're My Best Friend", "Love of My Life", "I'm in Love with My Car"],
                        ["We Will Rock You", "We Are the Champions", "Sheer Heart Attack", "Spread Your Wings"],
                        ["Another One Bites the Dust", "Crazy Little Thing Called Love", "Save Me", "Play the Game"]
                      ],
                      idSongs: [0, 1, 2, 3],
                      songsTimes: [
                        ["5:5", "2:50", "3:38", "3:05"],
                        ["2:02", "2:59", "3:26", "4:32"],
                        ["3:36", "2:43", "3:49", "3:30"]
                      ])
        ]
        
        
        let informationAlbumSongs = songs[tagArtist]
        
        presenter?.viewDidLoad(infoSongs: informationAlbumSongs, tagAlbum: tagAlbum)
        
    }
    
    
}
