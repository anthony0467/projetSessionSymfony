<?php

namespace App\Entity;

use App\Repository\FormateurRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: FormateurRepository::class)]
class Formateur
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 50)]
    private ?string $nomFormateur = null;

    #[ORM\Column(length: 50)]
    private ?string $prenomFormateur = null;

    #[ORM\Column(length: 100)]
    private ?string $emailFormateur = null;

    #[ORM\OneToMany(mappedBy: 'formateur', targetEntity: Session::class)]
    private Collection $sessions;

    public function __construct()
    {
        $this->sessions = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomFormateur(): ?string
    {
        return $this->nomFormateur;
    }

    public function setNomFormateur(string $nomFormateur): self
    {
        $this->nomFormateur = $nomFormateur;

        return $this;
    }

    public function getPrenomFormateur(): ?string
    {
        return $this->prenomFormateur;
    }

    public function setPrenomFormateur(string $prenomFormateur): self
    {
        $this->prenomFormateur = $prenomFormateur;

        return $this;
    }

    public function getEmailFormateur(): ?string
    {
        return $this->emailFormateur;
    }

    public function setEmailFormateur(string $emailFormateur): self
    {
        $this->emailFormateur = $emailFormateur;

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
            $session->setFormateur($this);
        }

        return $this;
    }

    public function removeSession(Session $session): self
    {
        if ($this->sessions->removeElement($session)) {
            // set the owning side to null (unless already changed)
            if ($session->getFormateur() === $this) {
                $session->setFormateur(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        return $this->nomFormateur. ' ' . $this->prenomFormateur;
    }
}
