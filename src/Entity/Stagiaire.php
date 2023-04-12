<?php

namespace App\Entity;

use App\Repository\StagiaireRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StagiaireRepository::class)]
class Stagiaire
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 50)]
    private ?string $nomStagiaire = null;

    #[ORM\Column(length: 50)]
    private ?string $prenomStagiaire = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $emailStagiaire = null;

    #[ORM\ManyToMany(targetEntity: Session::class, inversedBy: 'stagiaires')]
    private Collection $sessions;

    #[ORM\Column(type: Types::DATETIME_MUTABLE, nullable: true)]
    private ?\DateTimeInterface $dateNaissance = null;

    #[ORM\Column(length: 20, nullable: true)]
    private ?string $telephone = null;

    #[ORM\Column(length: 150, nullable: true)]
    private ?string $adresse = null;

    #[ORM\Column(length: 30)]
    private ?string $ville = null;

    public function __construct()
    {
        $this->sessions = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomStagiaire(): ?string
    {
        return $this->nomStagiaire;
    }

    public function setNomStagiaire(string $nomStagiaire): self
    {
        $this->nomStagiaire = $nomStagiaire;

        return $this;
    }

    public function getPrenomStagiaire(): ?string
    {
        return $this->prenomStagiaire;
    }

    public function setPrenomStagiaire(string $prenomStagiaire): self
    {
        $this->prenomStagiaire = $prenomStagiaire;

        return $this;
    }

    public function getEmailStagiaire(): ?string
    {
        return $this->emailStagiaire;
    }

    public function setEmailStagiaire(?string $emailStagiaire): self
    {
        $this->emailStagiaire = $emailStagiaire;

        return $this;
    }

    /**
     * @return Collection<int, Session>
     */
    public function getSessions(): Collection
    {
        return $this->sessions;
    }

    public function addSession(Session $session): self
    {
        if (!$this->sessions->contains($session)) {
            $this->sessions->add($session);
        }

        return $this;
    }

    public function removeSession(Session $session): self
    {
        $this->sessions->removeElement($session);

        return $this;
    }

    public function __toString()
    {
        return $this->nomStagiaire. ' ' . $this->prenomStagiaire;
    }

    public function getDateNaissance(): ?\DateTimeInterface
    {
        return $this->dateNaissance;
    }

    public function setDateNaissance(?\DateTimeInterface $dateNaissance): self
    {
        $this->dateNaissance = $dateNaissance;

        return $this;
    }

    public function getTelephone(): ?string
    {
        return $this->telephone;
    }

    public function setTelephone(?string $telephone): self
    {
        $this->telephone = $telephone;

        return $this;
    }

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(?string $adresse): self
    {
        $this->adresse = $adresse;

        return $this;
    }

    public function getVille(): ?string
    {
        return $this->ville;
    }

    public function setVille(string $ville): self
    {
        $this->ville = $ville;

        return $this;
    }
}
