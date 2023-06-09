<?php

namespace App\Controller;

use App\Entity\Module;
use App\Entity\Session;
use App\Entity\Programme;
use App\Entity\Stagiaire;
use App\Form\SessionType;
use App\Repository\SessionRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class SessionController extends AbstractController
{
    #[Route('/session', name: 'app_session')]
    public function index(ManagerRegistry $doctrine, SessionRepository $sr): Response
    {
       

        // sessions 
        $sessionsActuel = $sr->sessionActuel(); // requete DQL
        $sessionsFutur = $sr->sessionFutur(); // requete DQL
        $sessionsPassees = $sr->sessionPassee(); // requete DQL

          

        
        return $this->render('session/index.html.twig', [
            'controller_name' => 'SessionController',
            'sessionsActuel' => $sessionsActuel,
            'sessionsFutur' => $sessionsFutur,
            'sessionsPassees' => $sessionsPassees,
           
        ]);
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


    #[Route('/session/delete/{id}', name: 'delete_session')] // supprimer la session
    public function delete(ManagerRegistry $doctrine, Session $session = null): Response{

        if($session){

        $entityManager = $doctrine->getManager();
        $entityManager->remove($session);
        $entityManager->flush();

        return $this->redirectToRoute('app_home');
     }else{
        return $this->redirectToRoute('app_home');
     }
    }


    #[Route('/session/{idSession}/{id}/remove', name: 'remove_sessionStagiaire')] // enlever un stagiaire d'une session
    public function remove(ManagerRegistry $doctrine, Stagiaire $stagiaire = null , $idSession): Response{

        $session = $doctrine->getRepository(Session::class)->find($idSession);

            if($stagiaire && $session){
            $entityManager = $doctrine->getManager(); // on récupère les ressources

            

            // supprimer le stagiaire de la session
            $session->removeStagiaire($stagiaire);

            // enregistrer les modifications dans la base de données
            $entityManager->flush();
                
            return $this->redirectToRoute('show_session', ['id' => $idSession]);
        }else{
            return $this->redirectToRoute('app_home');
        }
    }

    #[Route('/session/{idSession}/{id}/inscrire', name: 'inscrire_sessionStagiaire')] // ajouter un stagiaire a une session
    public function inscrire(ManagerRegistry $doctrine, Stagiaire $stagiaire = null , $idSession): Response{
      
        
      
        $session = $doctrine->getRepository(Session::class)->find($idSession);

        if($stagiaire && $session->getNbPlace() > count($session->getStagiaires()) ){
            $entityManager = $doctrine->getManager(); // on récupère les ressources

            // supprimer le stagiaire de la session
            $session->addStagiaire($stagiaire);

            // enregistrer les modifications dans la base de données
            $entityManager->flush();
                
            return $this->redirectToRoute('show_session', ['id' => $idSession]);

        }else{
            return $this->redirectToRoute('app_home');
        }

    
            
    }

    #[Route('/session/{idSession}/{id}/addModule', name: 'addModule_session')] // programmer un module
    public function addModule(ManagerRegistry $doctrine, Module $module = null, $idSession, $id): Response {


        if($module){
    
        $entityManager = $doctrine->getManager(); // on récupère les ressources

        if(isset($_POST['submit'])){

            $duree = filter_input(INPUT_POST, "duree", FILTER_VALIDATE_INT);


            $session = $doctrine->getRepository(Session::class)->findOneBy(['id' => $idSession]);

            if($duree && $session){
                

       
        $module = $doctrine->getRepository(Module::class)->findOneBy(['id' => $id]);

       

        $programme = new Programme();
        $programme->setModule($module);
        $programme->setSession($session);

       
            
        $programme->setNbJourModule($duree);
            
        // ajouter le programme de la session
        $session->addProgramme($programme);
    
        // enregistrer les modifications dans la base de données
        $entityManager->persist($programme);
        $entityManager->flush();
      }
    }
                
        return $this->redirectToRoute('show_session', ['id' => $idSession]);
        }
        else{
            return $this->redirectToRoute('app_home');
        }
    }



    #[Route('/session/{idSession}/{id}/removeProgramme', name: 'remove_sessionProgramme')] // enlever un stagiaire d'une session
    public function removeProgramme(ManagerRegistry $doctrine, Programme $programme = null , $idSession): Response{

        $session = $doctrine->getRepository(Session::class)->find($idSession);
        
            if($programme && $session){

           

            $entityManager = $doctrine->getManager(); // on récupère les ressources

          

            // supprimer le stagiaire de la session
            $session->removeProgramme($programme);

            // enregistrer les modifications dans la base de données
            $entityManager->flush();
                
            return $this->redirectToRoute('show_session', ['id' => $idSession]);
        }else{
            return $this->redirectToRoute('app_home');
        }
    }


    


    #[Route('/session/show/{id}', name: 'show_session')] // fiche detaillé session
    public function show(ManagerRegistry  $doctrine, Session $session = null, SessionRepository $sr, Request $request): Response{

        if($session) {
            $session_id = $session->getId();
            $nonInscrit = $sr->findNonInscrit($session_id); // requete DQL
            $nonProgramme = $sr->findNonProgrammes($session_id); // requete DQL
           
    
            return $this->render('session/show.html.twig', [
                "session" => $session,
                "edit" => $session->getId(),
                "nonInscrits" => $nonInscrit,
                "nonProgrammes" => $nonProgramme
                
                
            ]);
        } else {
            return $this->redirectToRoute('app_session');
        }
    }



       

}
