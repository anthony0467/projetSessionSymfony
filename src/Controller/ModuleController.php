<?php

namespace App\Controller;

use App\Entity\Module;
use App\Form\ModuleType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class ModuleController extends AbstractController
{
    #[Route('/module', name: 'app_module')]
    public function index(ManagerRegistry $doctrine): Response
    {
        // récupérer toutes les formations
       $modules = $doctrine->getRepository(Module::class)->findBy([], ["nomModule"=> "ASC"]);
        return $this->render('module/index.html.twig', [
            'controller_name' => 'ModuleController',
            'modules' => $modules,
        ]);
    }

    #[Route('/module/add', name: 'add_module')] // ajouter un module
    #[Route('/module/{id}/edit', name: 'edit_module')] // modifier un module
    public function add(ManagerRegistry $doctrine, Module $module = null, Request $request): Response{
        
        if(!$module){ // edit
            $module = new Module();
        } //add

        $form = $this->createForm(ModuleType::class, $module);
        $form->handleRequest($request); // analyse the request

        //$nbPlace = $module->getSessions()->count();  
    
       
        if($form->isSubmitted() && $form->isValid()){ // valid respecter les contraintes
            $module = $form->getData();
            $entityManager = $doctrine->getManager(); // on récupère les ressources

       
            $entityManager->persist($module); // on enregistre la ressource
            $entityManager->flush(); // on envoie la ressource insert into

            return $this->redirectToRoute('app_session');
        }

        return $this->render('module/add.html.twig', [
            'formAddModule' => $form->createView(), // généré le visuel du form
            "edit" => $module->getId()
        ]);
   }
}
