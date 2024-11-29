
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo_List") 
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent store: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


extension CoreDataStack {
    func saveTasks(_ tasks: [TaskCellModel]) {
        let context = self.context
        for task in tasks {
            let entity = TaskEntity(context: context)
            entity.title = task.title
            entity.taskDescription = task.description
            entity.date = task.date
            entity.isCompleted = (task.status != nil)
        }
        saveContext()
    }
}
