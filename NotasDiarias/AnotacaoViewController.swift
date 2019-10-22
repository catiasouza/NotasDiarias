

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CONFIGURACOES INICIAIS
        self.textView.becomeFirstResponder()
        if anotacao != nil{    //ATUALIZAR
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.textView.text = String(describing: textoRecuperado)
            }
            
            
        }else{
            self.textView.text = ""
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        
      
    }
    @IBAction func salvar(_ sender: Any) {

        if anotacao != nil{   //ATUALIZAR
            self.atualizarAnotacao()
            
        }else{
            self.salvarAnotacao()
        }
        
        
        //RETORNAR A TELA INICIAL
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func atualizarAnotacao(){
        anotacao.setValue(self.textView.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar anotacao")
            
        } catch let erro  {
            print("Erro ao atualizar anotacao: " + erro.localizedDescription)
        }
    }
    func salvarAnotacao()  {
        
         //CRIA ANOTACAO
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //CONFIGURA ANOTACAO
        novaAnotacao.setValue(self.textView.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        //SALVAR DADOS
        do {
            try context.save()
            print("Sucesso ao salvar anotacao")
            
       } catch let erro  {
            print("Erro ao salvar anotacao: " + erro.localizedDescription)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
