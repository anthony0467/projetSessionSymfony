<?php

namespace App\Controller;

use App\Entity\Formation;
use App\Form\FormationType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class FormationController extends AbstractController
{
    #[Route('/formation', name: 'app_formation')]
    public function index(ManagerRegistry $doctrine): Response
    {
         // récupérer toutes les formations
       $formations = $doctrine->getRepository(Formation::class)->findBy([], ["nomFormation"=> "ASC"]);
        return $this->render('formation/index.html.twig', [
            'controller_name' => 'FormationController',
            'formations' => $formations,
        ]);
    }

    #[Route('/formation/add', name: 'add_formation')] // ajouter un formation
    #[Route('/formation/{id}/edit', name: 'edit_formation')] // modifier un formation
    public function add(ManagerRegistry $doctrine, formation $formation = null, Request $request): Response{

        if(!$formation){ // edit
            $formation = new Formation();
        } //add

        $form = $this->createForm(FormationType::class, $formation);
        $form->handleRequest($request); // analyse the request

        if($form->isSubmitted() && $form->isValid()){ // valid respecter les contraintes
            $formation = $form->getData();
            $entityManager = $doctrine->getManager(); // on récupère les ressources
            $entityManager->persist($formation); // on enregistre la ressource
            $entityManager->flush(); // on envoie la ressource insert into

            return $this->redirectToRoute('app_formation');
        }

        return $this->render('formation/add.html.twig', [
            'formAddFormation' => $form->createView(), // généré le visuel du form
            "edit" => $formation->getId()
        ]);

    }

    #[Route('/formation/delete/{id}', name: 'delete_formation')] // supprimer la formation
    public function delete(ManagerRegistry $doctrine, Formation $formation): Response{

        $entityManager = $doctrine->getManager();
        $entityManager->remove($formation);
        $entityManager->flush();

        return $this->redirectToRoute('app_formation');
    }
}
