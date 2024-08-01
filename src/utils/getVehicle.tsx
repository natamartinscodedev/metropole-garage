import { Veiculo } from "@/types/veiculos";

export const getVeiculos = async (playerId: string): Promise<Veiculo[]> => {
    try {
        // Supondo que o servidor FiveM tem  uma API para obter veículos
        const response: any = await fetch(`http://localhost:3000/veiculos/${playerId}`, {
            method: 'GET'
        });
        return response.data;
    } catch (error) {
        console.error('Erro ao buscar veículos:', error);
        throw new Error('Erro ao buscar veículos');
    }
};