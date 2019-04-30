//
//  ViewController.swift
//  ondeEstou
//
//  Created by Fellipe Ricciardi Chiarello on 4/30/19.
//  Copyright © 2019 fchiarello. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    @IBOutlet weak var velocidadeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longituteLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localizacaoUsuario = locations.last!
        let latitude = localizacaoUsuario.coordinate.latitude
        let longitude = localizacaoUsuario.coordinate.longitude
        let velocidade = localizacaoUsuario.speed
        
        self.latitudeLabel.text = String (latitude)
        self.longituteLabel.text = String (longitude)
       
        if localizacaoUsuario.speed >= 0{
        velocidadeLabel.text = String (velocidade)
        }
        
        let latitudeDelta: CLLocationDegrees = 1000
        let longitudeDelta: CLLocationDegrees = 1000
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion (center: localizacao, latitudinalMeters: latitudeDelta, longitudinalMeters: longitudeDelta)
        mapa.setRegion(regiao, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario) { (detalhesLocal, erro) in
            if erro == nil {
                if let dadosLocal = detalhesLocal?.first{
                    
                    var rua = ""
                    if dadosLocal.thoroughfare != nil {
                        rua = dadosLocal.thoroughfare!
                    }
                    
                    var numero = ""
                    if dadosLocal.subThoroughfare != nil {
                        numero = dadosLocal.subThoroughfare!
                    }
                    
                    var cidade = ""
                    if dadosLocal.locality != nil {
                        cidade = dadosLocal.locality!
                    }
                    
                    var bairro = ""
                    if dadosLocal.subLocality != nil {
                        bairro = dadosLocal.subLocality!
                    }
                    
                    var cep = ""
                    if dadosLocal.postalCode != nil {
                        cep = dadosLocal.postalCode!
                    }
                    
                    var pais = ""
                    if dadosLocal.country != nil {
                        pais = dadosLocal.country!
                        
                    }
                    
                    var estado = ""
                    if dadosLocal.administrativeArea != nil {
                        estado = dadosLocal.administrativeArea!
                        
                    }
                    
                    self.enderecoLabel.text = rua + " - " +
                                         numero + " - " +
                                         bairro + " / " +
                                         cidade + " - " +
                                         estado + " / " +
                                         pais
                    
                    print("\n / thoroughfare:" + rua +
                          "\n / subthoroughfare" +  numero +
                          "\n / locality" + cidade +
                          "\n / subLocality " + bairro +
                          "\n / postalCode" + cep +
                          "\n / country" + pais +
                          "\n / adiministrative area" + estado)
                }
                
                
                
            }else{
                print("erro")
            }
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse{
            
            let alertaController = UIAlertController(title: "Permissão de acesso à localização!", message: "Precisamos da permissão de acesso para executar o app! Favor habilitar.", preferredStyle: .alert)
            
            let acaoConfigurar = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { ( altertaConfiguracoes ) in
                
                if let configuracoes = NSURL (string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open (configuracoes as URL)
                    
                }
                                
            })
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfigurar)
            alertaController.addAction(acaoCancelar)
            
            present(alertaController, animated: true, completion: nil)
            
        }
        
    }


}

