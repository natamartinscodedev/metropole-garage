"use client"
import Image from 'next/image'
import React from 'react'

const Index = ({ vehicle }: any) => {
    return (
        <div className='card_card'>
            <div>
                <Image
                    src={vehicle.car}
                    alt={vehicle.modelo}
                    width={1000}
                    height={1000}
                />
            </div>
            <span className='selected'>Selecionado</span>
        </div>
    )
}

export default Index