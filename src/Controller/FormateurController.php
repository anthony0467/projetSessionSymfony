<?php

namespace App\Controller;

use App\Entity\Formateur;
use App\Form\FormateurType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class FormateurController extends AbstractController
{
    #[Route('/formateur', name: 'app_formateur')]
    public function index(ManagerRegistry $doctrine): Response
    {
         // récupérer tous les formateurs
       $formateurs = $doctrine->getRepository(Formateur::class)->findBy([], ["nomFormateur"=> "ASC"]);
        return $this->render('formateur/index.html.twig', [
            'controller_name' => 'FormateurController',
            "formateurs" => $formateurs
        ]);
    }

    #[Route('/formateur/add', name: 'add_formateur')] // ajouter un formateur
    #[Route('/formateur/{id}/edit', name: 'edit_formateur')] // modifier un formateur
    public function add(ManagerRegistry $doctrine, Formateur $formateur = null, Request $request): Response{

        if(!$formateur){ // edit
            $formateur = new Formateur();
        } //add

        $form = $this->createForm(FormateurType::class, $formateur);
        $form->handleRequest($request); // analyse the request

        if($form->isSubmitted() && $form->isValid()){ // valid respecter les contraintes
            $formateur = $form->getData();
            $entityManager = $doctrine->getManager(); // on récupère les ressources
            $entityManager->persist($formateur); // on enregistre la ressource
            $entityManager->flush(); // on envoie la ressource insert into

            return $this->redirectToRoute('app_formateur');
        }

        return $this->render('formateur/add.html.twig', [
            'formAddFormateur' => $form->createView(), // généré le visuel du form
            "edit" => $formateur->getId()
        ]);

    }


    #[Route('/formateur/{id}', name: 'delete_formateur')] // fiche detaillé stagiaire
    public function delete(ManagerRegistry $doctrine, Formateur $formateur): Response{

        $entityManager = $doctrine->getManager();
        $entityManager->remove($formateur);
        $entityManager->flush();

        return $this->redirectToRoute('app_formateur');
    }


    #[Route('/formateur/{id}', name: 'show_formateur')] // fiche detaillé formateur
    public function show(Formateur $formateur): Response{

        return $this->render('formateur/show.html.twig', [
            "formateur" => $formateur
        ]);
    }
}
