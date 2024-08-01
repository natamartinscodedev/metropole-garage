export const spawnarVeiculo = async (placa: string): Promise<void> => {
    try {
        // Supondo que o servidor FiveM tem uma API para spawnar veículos
        const res = await fetch('http://localhost:3000/spawnar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ placa }),
        })

        if (!res.ok) {
            // Se o status da resposta não for 200, lança um erro
            throw new Error(`Erro ao spawnar veículo: ${res.statusText}`);
        }
        console.log('Veículo spawnado com sucesso');
    } catch (error) {
        console.error('Erro ao spawnar veículo:', error);
        throw new Error('Erro ao spawnar veículo');
    }
};
