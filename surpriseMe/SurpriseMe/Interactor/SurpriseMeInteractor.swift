//
//  SurpriseMeInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import Foundation

enum SurpriseMeFeeling: Int, CaseIterable {
    case IWantALightsaber
    case IWantToParty
    case SuitUp
    case ImThirsty
    case ImDown
}

struct IWantALightsaber {
    static private var ledZeppelin = "36QJpDe2go2KgaRleHCDTp"
    static private var frankZappa = "6ra4GIOgCZQZMOaUECftGN"
    static private var metallica = "2ye2Wgw4gimLv2eAKyk1NB"
    static private var laRenga = "30fEdZPXgWfC4sNttcyB3C"
    static private var guns = "3qm84nBOXUEQ2vnTfUTTFC"
    static private var indioSolari = "0nUGkxUncFeXt0Dr0hhrc4"
    static private var ironMaiden = "6mdiAmATAx73kdxrNrnlao"
    static private var acdc = "711MCceyCBcFnzjGY4Q7Un"
    static private var divididos = "6ZIgPKHzpcswB8zh7sRIhx"
    
    static let artistId = [ledZeppelin, frankZappa, metallica, laRenga, guns, indioSolari, ironMaiden, acdc, divididos]
}

struct IWantToParty {
    static private var kalebDiMasi = "5U5wYVqrbD6J8SK4kNhau4"
    static private var duki = "1bAftSH8umNcGZ0uyV7LMg"
    static private var emilia = "0AqlFI0tz2DsEoJlKSIiT9"
    static private var thiagoPzk = "5Y3MV9DZ0d87NnVm56qSY1"
    static private var laJoaqui = "60XHOAhvEBiV6BGBOv8ClM"
    static private var rauwAlejandro = "1mcTU81TzQhprhouKaTkpq"
    static private var badbunny = "4q3ewBCX7sLwd24euuV69X"
    static private var maluma = "1r4hJ1h58CWwUQe3MxPuau"
    static private var jbalvin = "1vyhD5VmyZ7KMfW5gqLgo5"
    static private var daddyYankee = "4VMYDCV2IEDYJArk749S6m"
    static let artistId = [kalebDiMasi, duki, emilia, thiagoPzk, laJoaqui, rauwAlejandro, badbunny, maluma, jbalvin, daddyYankee]
    
}

struct SuitUp {
    static private var joeBonamassa = "2SNzxY1OsSCHBLVi77mpPQ"
    static private var twoFeet = "5sWHDYs0csV6RS48xBl0tH"
    static private var rakefire = "6SkPs7HOnDAZmxtkf1AYIz"
    static private var mattMaeson = "7gHscNMDI8FF8pcgrV8eIn"
    static private var migrantMotel = "0T63uYYYnOxOXV7bDF0K0G"
    static private var lauraDalla = "1fySQNfTQVIzpwUCTeRM1u"
    static private var arcticMonkeys = "7Ln80lUS6He07XvHI8qqHH"
    static let artistId = [ joeBonamassa, twoFeet, rakefire, mattMaeson, migrantMotel, lauraDalla, arcticMonkeys]
}

struct ImThirsty {
    static private var arcticMonkeys = "7Ln80lUS6He07XvHI8qqHH"
    static private var luisXIV = "60NKN6tZYKbkjX1qpFQIqF"
    static private var aerosmith = "7Ey4PD4MYsKc5I2dolUwbH"
    static private var theStrokes = "0epOFNiUfyON9EYx7Tpr6V"
    static private var theKooks = "1GLtl8uqKmnyCWxHmw9tL4"
    static private var joeBonamassa = "2SNzxY1OsSCHBLVi77mpPQ"
    static private var jackWhite = "4FZ3j1oH43e7cukCALsCwf"
    static private var samSmith = "2wY79sveU1sp5g7SokKOiI"
    static let artistId = [arcticMonkeys, luisXIV, aerosmith, theStrokes, joeBonamassa, jackWhite]
}

struct ImDown {
    static private var passenger = "0gadJ2b9A4SKsB1RFkBb66"
    static private var edSheeran = "6eUKZXaKkcviH0Ku9w2n3V"
    static private var jamieLawson = "1jhdZdzOd4TJLAHqQdkUND"
    static private var tomSpeight = "02U4dXZhGSo07f66l8JZ91"
    static private var adele = "4dpARuHxo51G3z768sgnrY"
    static private var jukeRoss = "3mDo5Nv0SWpslJe9HzA2xY"
    static private var declanJDonovan = "6bh228LGC3eAzbplPWV02r"
    static private var graceCarter = "2LuHL7im4aCEmfOlD4rxBC"
    
    static let artistId = [passenger, edSheeran, jamieLawson, tomSpeight, adele, jukeRoss, declanJDonovan, graceCarter]
}

class SurpriseMeInteractor: SurpriseMeInteractorProtocol {
    var presenter: SurpriseMePresenterProtocol?

}
