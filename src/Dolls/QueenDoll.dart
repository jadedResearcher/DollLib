/*

Queen dolls are a little different.

instead of set layers, like eyes, mouth etc.
they have variable ones.

Instead of the normal drop downs, they have
"prototype with X".

BUT I don't want them to not be a 'doll'. I.e. they should have the standard rendering code.

So how to do.

Let's look at how rendring works.

Maybe i should refactor so a spriteLayer knows how to fetch  it's own image? (does it already?)

yup, all i need to do is extend sprite layer.  good past jr. best friend.
 */