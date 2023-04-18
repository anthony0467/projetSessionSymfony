<?php

namespace App\Controller;

use App\Entity\Module;
use App\Entity\Categorie;
use App\Form\CategorieType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class CategorieController extends AbstractController
{
    #[Route('/categorie', name: 'app_categorie')]
    public function index(ManagerRegistry $doctrine): Response
    {
        $categories = $doctrine->getRepository(Categorie::class)->findBy([], ["nomCategorie"=> "ASC"]);
        return $this->render('categorie/index.html.twig', [
            'controller_name' => 'CategorieController',
            'categories' => $categories,
        ]);
    }


    #[Route('/categorie/add', name: 'add_categorie')] // ajouter un categorie
    #[Route('/categorie/{id}/edit', name: 'edit_categorie')] // modifier un categorie
    public function add(ManagerRegistry $doctrine, Categorie $categorie = null, Request $request): Response{

        if(!$categorie){ // edit
            $categorie = new Categorie();
        } //add

        $form = $this->createForm(CategorieType::class, $categorie);
        $form->handleRequest($request); // analyse the request

        if($form->isSubmitted() && $form->isValid()){ // valid respecter les contraintes
            $categorie = $form->getData();
            $entityManager = $doctrine->getManager(); // on récupère les ressources
            $entityManager->persist($categorie); // on enregistre la ressource
            $entityManager->flush(); // on envoie la ressource insert into

            return $this->redirectToRoute('app_categorie');
        }

        return $this->render('categorie/add.html.twig', [
            'formAddCategorie' => $form->createView(), // généré le visuel du form
            "edit" => $categorie->getId()
        ]);

    }

    #[Route('/categorie/delete/{id}', name: 'delete_categorie')] // supprimer une categorie
    public function delete(ManagerRegistry $doctrine, Categorie $categorie): Response{

        $entityManager = $doctrine->getManager();
        $entityManager->remove($categorie);
        
           // Supprimer tous les modules associés
    
           foreach ($categorie->getModules() as $module) { // Supprimer tous les modules associés
            $categorie->removeModule($module);
            $entityManager->remove($module);

            if($module){ // Supprimer tous les programmes s'il  y a des modules associés
            foreach( $module->getProgrammes() as $programme ) { // Supprimer tous les programmes associés
                $module->removeProgramme($programme);
                $entityManager->remove($programme);
            }
         }
           
        }

       
        $entityManager->flush();

        return $this->redirectToRoute('app_categorie');
    }

    #[Route('/categorie/show/{id}', name: 'show_categorie')] // afficher modules par categorie
    public function show(Categorie $categorie): Response
    {
        $modules = $categorie->getModules(); // récupère les modules
        return $this->render('categorie/show.html.twig', [
            'categorie' => $categorie,
            'modules' => $modules,
        ]);
    }

}
