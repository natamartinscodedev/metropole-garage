"use client"

import { useState } from 'react';
import Image from 'next/image';
import CardVehicle from '@/components/CardVehicleList/index'
import CardDetaius from '@/components/CardVehicleDetaius/index'
import { ChevronLeft, ChevronRight } from 'lucide-react';

const CarCarousel = ({ vehicle }: any) => {
    const [currentIndex, setCurrentIndex] = useState(0);

    console.log("Carrosle ==>", currentIndex)

    const handleNext = () => {
        setCurrentIndex((prevIndex) =>
            prevIndex === vehicle.length - 1 ? 0 : prevIndex + 1
        );
    };

    const handlePrev = () => {
        setCurrentIndex((prevIndex) =>
            prevIndex === 0 ? vehicle.length - 1 : prevIndex - 1
        );
    };

    return (
        <div className="carouselContainer">
            <div className="carouselContent">
                <button onClick={handlePrev} className="arrow">
                    <ChevronLeft size={80} />
                </button>
                {vehicle && vehicle.map((car: any, index: any) => (
                    <div
                        key={index}
                        className={`${"carouselItem"} ${index === currentIndex ? "active" : "hidden"
                            }`}
                    >
                        <CardDetaius vehicle={car} />
                        <CardVehicle vehicle={car} />
                    </div>
                ))}
                <button onClick={handleNext} className="arrow">
                    <ChevronRight size={80} />
                </button>
            </div>
        </div>
    );
};

export default CarCarousel;
