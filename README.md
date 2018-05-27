# Game of Life

I made a Conway's Game of life, with one rule added, about a cell permanent dead. Considering that, the rules would be:

- A living cell with 1 or less neighbors dies.
- A living cell with 4 or more neighbors dies.
- A living cell with 2 or 3 neighbors continues living.
- A dead cell with 3 neighbors starts to live.
- A dead cell with 4 or more neighbors becomes permanently dead.

Also, I made a small VC to show the progression of the cells, how they are re living and dying thought generations.

### Next steps:

[ ] I would like to add a more efficient way to iterate the cells, because, right now, I am interating cells that are permanently dead, which makes no sense. 
