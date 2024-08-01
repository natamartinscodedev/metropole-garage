'use client'

import CardVeiculos from '@/components/CardVehicleList/index'
import CarCarousel from '@/components/Carrosel'
import { useEffect, useState } from 'react'
import { getVeiculos } from '@/utils/getVehicle'
import { Veiculo } from '@/types/veiculos'
import { vehicle } from '@/mocks/veiculos.json'

export default function Home() {
  const [veiculos, setVeiculos] = useState(vehicle)

  // useEffect(() => {
  //   const fetchData = async () => {
  //     try {
  //       const data: any = await getVeiculos('player123') // Substitua 'player123' pelo ID real do jogador
  //       setVeiculos(data)
  //     } catch (error) {
  //       console.error('Erro ao buscar veículos:', error)
  //     }
  //   }
  //   fetchData()
  // }, [])

  return (
    <>
      <main className="container_main">
        <section className="container_garage container">
          <h1>Garagem Metrópole GG</h1>

          <div className='card_selection'>
            <CarCarousel vehicle={veiculos} />
          </div>
        </section>
      </main>
    </>
  )
}
