<?php

namespace App\Controller;

use App\Entity\Stagiaire;
use App\Form\StagiaireType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class StagiaireController extends AbstractController
{
    #[Route('/stagiaire', name: 'app_stagiaire')] // liste stagiaire
    public function index(ManagerRegistry $doctrine): Response
    {
         // récupérer tous les stagiaires
       $stagiaires = $doctrine->getRepository(Stagiaire::class)->findBy([], ["nomStagiaire"=> "ASC"]);
        return $this->render('stagiaire/index.html.twig', [
            'controller_name' => 'StagiaireController',
            "stagiaires" => $stagiaires,
        ]);
    }

    #[Route('/stagiaire/add', name: 'add_stagiaire')] // ajouter un stagiaire
    #[Route('/stagiaire/{id}/edit', name: 'edit_stagiaire')] // modifier un stagiaire
    public function add(ManagerRegistry $doctrine, Stagiaire $stagiaire = null, Request $request): Response{
        
        if(!$stagiaire){ // edit
            $stagiaire = new Stagiaire();
        } //add

        $form = $this->createForm(StagiaireType::class, $stagiaire);
        $form->handleRequest($request); // analyse the request

        //$nbPlace = $stagiaire->getSessions()->count();  
    
       
        if($form->isSubmitted() && $form->isValid()){ // valid respecter les contraintes
            $stagiaire = $form->getData();
            $entityManager = $doctrine->getManager(); // on récupère les ressources

       

           

           

            $entityManager->persist($stagiaire); // on enregistre la ressource
            $entityManager->flush(); // on envoie la ressource insert into

            return $this->redirectToRoute('app_stagiaire');
        }

        return $this->render('stagiaire/add.html.twig', [
            'formAddStagiaire' => $form->createView(), // généré le visuel du form
            "edit" => $stagiaire->getId(),
            
            
            
        ]);

    }

    
    #[Route('/stagiaire/delete/{id}', name: 'delete_stagiaire')] // supprimer le stagiaire
    public function delete(ManagerRegistry $doctrine, Stagiaire $stagiaire): Response{

        $entityManager = $doctrine->getManager();
        $entityManager->remove($stagiaire);
        $entityManager->flush();

        return $this->redirectToRoute('app_stagiaire');
    }



    #[Route('/stagiaire/show/{id}', name: 'show_stagiaire')] // fiche detaillé stagiaire
    public function show(Stagiaire $stagiaire): Response{

        return $this->render('stagiaire/show.html.twig', [
            "stagiaire" => $stagiaire,
            "edit" => $stagiaire->getId(),
            
        ]);
    }
}
