<?php

namespace App\Repository;

use App\Entity\Stagiaire;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Stagiaire>
 *
 * @method Stagiaire|null find($id, $lockMode = null, $lockVersion = null)
 * @method Stagiaire|null findOneBy(array $criteria, array $orderBy = null)
 * @method Stagiaire[]    findAll()
 * @method Stagiaire[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StagiaireRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Stagiaire::class);
    }

    public function save(Stagiaire $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Stagiaire $entity, bool $flush = false): void
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
            ->from('App\Entity\Session','s')
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



//    /**
//     * @return Stagiaire[] Returns an array of Stagiaire objects
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

//    public function findOneBySomeField($value): ?Stagiaire
//    {
//        return $this->createQueryBuilder('s')
//            ->andWhere('s.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
