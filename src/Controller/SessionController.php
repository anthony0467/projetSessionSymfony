<?php

namespace App\Controller;

use App\Entity\Session;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class SessionController extends AbstractController
{
    #[Route('/session', name: 'app_session')]
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
        
          


        
        return $this->render('session/index.html.twig', [
            'controller_name' => 'SessionController',
            'sessionsActuel' => $sessionsActuel,
            'sessionsFutur' => $sessionsFutur,
            'sessionsPassees' => $sessionsPassees,
           
        ]);
    }

       

}
