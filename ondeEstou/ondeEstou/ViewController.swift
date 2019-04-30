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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse{
            
            var alertaController = UIAlertController(title: "Permissão de acesso à localização!", message: "Precisamos da permissão de acesso para executar o app! Favor habilitar.", preferredStyle: .alert)
            
            var acaoConfigurar = UIAlertAction(title: "Abrir Configurações", style: .default, handler: )
            var acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            
        }
        
    }


}

