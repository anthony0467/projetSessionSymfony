<?php

namespace App\Form;

use App\Entity\Stagiaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class StagiaireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nomStagiaire', TextType::class)
            ->add('prenomStagiaire', TextType::class)
            ->add('emailStagiaire', TextType::class)
            ->add('dateNaissance', DateType::class, [
                'widget' =>'single_text' // calendrier
            ])
            ->add('telephone', TextType::class)
            ->add('adresse', TextType::class)
            ->add('ville', TextType::class)
            //->add('sessions')
            ->add('submit', SubmitType::class)
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Stagiaire::class,
        ]);
    }
}
