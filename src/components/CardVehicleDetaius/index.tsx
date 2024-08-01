"use client"

import React from 'react'

const Index = ({ vehicle }: any) => {

    return (
        <div className='container_detaius'>
            <div>
                <h2>Detalhes do carro</h2>
                <p>Modelo: {vehicle.modelo}</p>
                <p>Cor: <div style={{ background: `${vehicle.cor}` }} /></p>
            </div>
            <button>Spawnar</button>
        </div>
    )
}

export default Index