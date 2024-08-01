// import mongoose from 'mongoose';
// const MONGODBURI = process.env.MONGODB_URI;

// export const connectToDatabase = async () => {
//     if (!MONGODBURI) {
//         throw new Error(
//             'Please define the MONGODB_URI environment variable inside .env.local',
//         )
//     }

//     try {
//         const connection = await mongoose.connect(MONGODBURI)
//         console.log("MongoDB já conectado!");
//         return connection
//     } catch (error) {
//         console.error('Erro ao conectar ao MongoDB:', error);
//         throw error;
//     }
// }