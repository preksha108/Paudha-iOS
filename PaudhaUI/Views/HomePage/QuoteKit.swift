//
//  QuoteKit.swift
//  PaudhaUI
//
//  Created by user1 on 19/02/24.
//

import SwiftUI

class QuoteKit {
     static var plantQuotes = [
         "In every walk with nature, one receives far more than he seeks.",
         "Plants give us oxygen for the lungs and for the soul.",
         "To plant a garden is to believe in tomorrow.",
         "The love of gardening is a seed once sown that never dies.",
         "A garden is a friend you can visit anytime.",
         "Plant dreams, pull weeds, and grow a happy life.",
         "Plants are the beauty of the earth and the poetry of the soul.",
         "To nurture a garden is to feed not just the body, but the soul.",
         "A garden is a grand teacher. It teaches patience and careful watchfulness; it teaches industry and thrift; above all, it teaches entire trust.",
         "Flowers always make people better, happier, and more helpful; they are sunshine, food, and medicine for the soul.",
         "The best time to plant a tree was 20 years ago. The second best time is now.",
         "In the garden of life, plant only love.",
         "A flower does not think of competing with the flower next to it. It just blooms.",
         "The glory of gardening: hands in the dirt, head in the sun, heart with nature.",
         "The earth laughs in flowers.",
         "To plant a seed is to believe in tomorrow.",
         "Gardening is the art that uses flowers and plants as paint, and the soil and sky as canvas.",
         "Plants are the silent guardians of our well-being.",
         "From little seeds grow mighty trees.",
         "The creation of a thousand forests is in one acorn.",
         "Gardens are not made by singing 'Oh, how beautiful,' and sitting in the shade.",
         "Plants are friends that never betray.",
         "In the garden, growth has its seasons. First comes spring and summer, but then we have fall and winter. And then we get spring and summer again.",
         "Nature always wears the colors of the spirit.",
         "To be overcome by the fragrance of flowers is a delectable form of defeat.",
         "A garden is not made in a year; indeed, it never is made in the sense of finality. It grows, and with the labor of love should go on growing.",
         "Let us be grateful to people who make us happy; they are the charming gardeners who make our souls blossom.",         "The best place to find God is in a garden. You can dig for him there.",
         "A garden must combine the poetic and the mysterious with a feeling of serenity and joy.",
         "The hum of bees is the voice of the garden.",
         "To plant a garden is to believe in the future.",
         "In the garden, growth has its seasons. There are times for flowering and times for healing, but never a time for wilting.",
         "The greatest fine art of the future will be the making of a comfortable living from a small piece of land.",
         "A garden requires patient labor and attention. Plants do not grow merely to satisfy ambitions or to fulfill good intentions. They thrive because someone expended effort on them.",
         "Flowers are the music of the ground. From earth's lips spoken without sound.",
         "The love we give away is the only love we keep.",
         "The best fertilizer is the gardener's shadow.",
         "Gardening is the art of painting in the soil without a brush.",
         "When you have only two pennies left in the world, buy a loaf of bread with one, and a lily with the other.",
         "One who plants a garden plants happiness.",
         "A weed is but an unloved flower.",
         "In the garden, the door is always open, and the spirits come and go as they wish.",
         "The best view comes after the hardest climb.",
         "In the garden of life, sow the seeds of kindness and love.",
         "Gardening is the purest of human pleasures.",
         "Plants do not grow merely to satisfy ambitions or to fulfill good intentions. They thrive because someone expended effort on them.",
         "Gardens are not made by sitting in the shade.",
         "A garden is a reflection of a man's love for nature.",
         "Plant smiles, grow laughter, harvest love.",
         "Gardeners, I think, dream bigger dreams than emperors."

     ]

     static func getDailyPlantQuote() -> String {
         // Replace this with your logic to fetch a daily quote
         // For now, let's just return a random quote
         return plantQuotes.randomElement() ?? "No quote available today."
     }
 }
