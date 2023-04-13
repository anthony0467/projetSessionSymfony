<?php

namespace App\Controller;

use App\Entity\Session;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class HomeController extends AbstractController
{
    #[Route('/home', name: 'app_home')]
    public function index(ManagerRegistry $doctrine): Response
    {

         // sessions en cours
         $dateActuelle = new \DateTime();
         $sessionsActuel = $doctrine->getRepository(Session::class)->createQueryBuilder('s')
             ->where(':dateActuelle BETWEEN s.dateDebut AND s.dateFin')
             ->setParameter('dateActuelle', $dateActuelle)
             ->orderBy('s.nomSession', 'ASC')
             ->getQuery()
             ->getResult();
 
         // sessions futur
         $sessionsFutur = $doctrine->getRepository(Session::class)->createQueryBuilder('s')
             ->where(':dateActuelle < s.dateDebut')
             ->setParameter('dateActuelle', $dateActuelle)
             ->orderBy('s.nomSession', 'ASC')
             ->getQuery()
             ->getResult();
 
         //sessions passées
         $sessionsPassees = $doctrine->getRepository(Session::class)->createQueryBuilder('s')
             ->where(':dateActuelle > s.dateFin')
             ->setParameter('dateActuelle', $dateActuelle)
             ->orderBy('s.nomSession', 'ASC')
             ->getQuery()
             ->getResult();
 
 
 
         
         return $this->render('home/index.html.twig', [
             'controller_name' => 'SessionController',
             'sessionsActuel' => $sessionsActuel,
             'sessionsFutur' => $sessionsFutur,
             'sessionsPassees' => $sessionsPassees,
         ]);

        return $this->render('home/index.html.twig', []);
    }

    #[Route('/session/add', name: 'add_session')] // ajouter un session
    #[Route('/session/{id}/edit', name: 'edit_session')] // modifier un session
    public function add(ManagerRegistry $doctrine, session $session = null, Request $request): Response{

        if(!$session){ // edit
            $session = new Session();
        } //add

        $form = $this->createForm(SessionType::class, $session);
        $form->handleRequest($request); // analyse the request

        if($form->isSubmitted() && $form->isValid()){ // valid respecter les contraintes
            $session = $form->getData();
            $entityManager = $doctrine->getManager(); // on récupère les ressources
            $entityManager->persist($session); // on enregistre la ressource
            $entityManager->flush(); // on envoie la ressource insert into

            return $this->redirectToRoute('app_session');
        }

        return $this->render('session/add.html.twig', [
            'formAddSession' => $form->createView(), // généré le visuel du form
            "edit" => $session->getId()
        ]);

    }
}
