<?php

namespace App\Repository;

use App\Entity\Module;
use App\Entity\Session;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;

/**
 * @extends ServiceEntityRepository<Session>
 *
 * @method Session|null find($id, $lockMode = null, $lockVersion = null)
 * @method Session|null findOneBy(array $criteria, array $orderBy = null)
 * @method Session[]    findAll()
 * @method Session[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SessionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Session::class);
    }

    public function save(Session $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Session $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function findNonInscrit($session_id){
        $em = $this->getEntityManager();
        $sub = $em->createQueryBuilder();

        $qb = $sub;

        //selectionner tous les stagiaires dont l'id est passé en paramètre

        $qb->select('s')
            ->from('App\Entity\Stagiaire','s')
            ->leftJoin('s.sessions', 'se')
            ->where('se.id = :id');

            $sub = $em->createQueryBuilder();
            //Selectionner tous les stagiaires qui ne sont pas dans le resultat précédent
            // On obtient donc les stagiaires non inscrit pour une session défini
            $sub->select('st')
                ->from('App\Entity\Stagiaire','st')
                ->where($sub->expr()->notIn('st.id',$qb->getDQL()))
                //requète paramétré
                ->setParameter('id', $session_id)
                //trier par non des stagiaires
                ->orderBy('st.nomStagiaire');

            //Renvoyer le resultat
            $query = $sub->getQuery();
            return $query->getResult();
    }

    public function findNonProgrammes($session_id)
{
    $em = $this->getEntityManager();

    // On commence par créer une sous-requête pour sélectionner les modules
    // qui ont déjà été programmés pour la session en question
    $sub = $em->createQueryBuilder();
    $sub->select('IDENTITY(p.module)')
        ->from('App\Entity\Programme', 'p')
        ->where('p.session = :session_id')
        ->setParameter('session_id', $session_id);

    // Ensuite, on crée la requête principale pour sélectionner les modules
    // qui n'ont pas été programmés pour la session en question
    $qb = $em->createQueryBuilder();
    $qb->select('m')
        ->from('App\Entity\Module', 'm')
        ->where($qb->expr()->notIn('m.id', $sub->getDQL()))
        ->orderBy('m.nomModule')
        ->setParameter('session_id', $session_id);

    // On renvoie le résultat
    $query = $qb->getQuery();
    return $query->getResult();
}


public function sessionActuel()
{
    
    $em = $this->getEntityManager();
    $dateActuelle = new \DateTime();

    $query = $em->createQueryBuilder();
    $query->select('s')
        ->from(Session::class, 's')
        ->where(':dateActuelle BETWEEN s.dateDebut AND s.dateFin')
        ->setParameter('dateActuelle', $dateActuelle)
        ->orderBy('s.dateDebut', 'DESC');

    return $query->getQuery()->getResult();
}


public function sessionFutur()
{
    
    $em = $this->getEntityManager();
    $dateActuelle = new \DateTime();

    $query = $em->createQueryBuilder();
    $query->select('s')
        ->from(Session::class, 's')
        ->where(':dateActuelle < s.dateDebut')
        ->setParameter('dateActuelle', $dateActuelle)
        ->orderBy('s.dateDebut', 'DESC');

    return $query->getQuery()->getResult();
}

public function sessionPassee()
{
    
    $em = $this->getEntityManager();
    $dateActuelle = new \DateTime();

    $query = $em->createQueryBuilder();
    $query->select('s')
        ->from(Session::class, 's')
        ->where(':dateActuelle > s.dateFin')
        ->setParameter('dateActuelle', $dateActuelle)
        ->orderBy('s.dateDebut', 'DESC');

    return $query->getQuery()->getResult();
}
    
    



//    /**
//     * @return Session[] Returns an array of Session objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('s')
//            ->andWhere('s.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('s.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?Session
//    {
//        return $this->createQueryBuilder('s')
//            ->andWhere('s.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
