

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var context: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CONFIGURACOES INICIAIS
        self.textView.becomeFirstResponder()
        self.textView.text = ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        
      
    }
    @IBAction func salvar(_ sender: Any) {
        self.salvarAnotacao()
        
        //RETORNAR A TELA INICIAL
        self.navigationController?.popToRootViewController(animated: true)
        
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
            
       } catch let erro as Error {
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
