<?php

namespace App\Form;

use App\Entity\Session;
use App\Entity\Formateur;
use App\Entity\Formation;
use App\Entity\Stagiaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class SessionType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nomSession', TextType::class)
           
            ->add('dateDebut', DateType::class, [
                'widget' =>'single_text' // calendrier
            ])
            ->add('dateFin', DateType::class, [
                'widget' =>'single_text' // calendrier
            ])
            ->add('nbPlace', IntegerType::class, [
                'attr' => [
                    'min' => 0
                ]
            ])
            ->add('formation', EntityType::class, [
                'class' => Formation::class,
                'choice_label' =>'nomFormation'
            ])
            ->add('formateur', EntityType::class, [
                'class' => Formateur::class,
            ])
          //  ->add('stagiaires')
            ->add('valider', SubmitType::class)
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Session::class,
        ]);
    }
}
