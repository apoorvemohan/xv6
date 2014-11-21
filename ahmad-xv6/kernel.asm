
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 1f 35 10 80       	mov    $0x8010351f,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 9c 84 10 	movl   $0x8010849c,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100049:	e8 14 4d 00 00       	call   80104d62 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 70 05 11 80 64 	movl   $0x80110564,0x80110570
80100055:	05 11 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 74 05 11 80 64 	movl   $0x80110564,0x80110574
8010005f:	05 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 74 05 11 80       	mov    0x80110574,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 74 05 11 80       	mov    %eax,0x80110574

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
801000ac:	72 bd                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ae:	c9                   	leave  
801000af:	c3                   	ret    

801000b0 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b0:	55                   	push   %ebp
801000b1:	89 e5                	mov    %esp,%ebp
801000b3:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b6:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801000bd:	e8 c1 4c 00 00       	call   80104d83 <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c2:	a1 74 05 11 80       	mov    0x80110574,%eax
801000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000ca:	eb 63                	jmp    8010012f <bget+0x7f>
    if(b->dev == dev && b->sector == sector){
801000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000cf:	8b 40 04             	mov    0x4(%eax),%eax
801000d2:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d5:	75 4f                	jne    80100126 <bget+0x76>
801000d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000da:	8b 40 08             	mov    0x8(%eax),%eax
801000dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e0:	75 44                	jne    80100126 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e5:	8b 00                	mov    (%eax),%eax
801000e7:	83 e0 01             	and    $0x1,%eax
801000ea:	85 c0                	test   %eax,%eax
801000ec:	75 23                	jne    80100111 <bget+0x61>
        b->flags |= B_BUSY;
801000ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f1:	8b 00                	mov    (%eax),%eax
801000f3:	89 c2                	mov    %eax,%edx
801000f5:	83 ca 01             	or     $0x1,%edx
801000f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fb:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fd:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100104:	e8 dc 4c 00 00       	call   80104de5 <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 60 c6 10 	movl   $0x8010c660,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 77 49 00 00       	call   80104a9b <sleep>
      goto loop;
80100124:	eb 9c                	jmp    801000c2 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 10             	mov    0x10(%eax),%eax
8010012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010012f:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100136:	75 94                	jne    801000cc <bget+0x1c>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100138:	a1 70 05 11 80       	mov    0x80110570,%eax
8010013d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100140:	eb 4d                	jmp    8010018f <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100145:	8b 00                	mov    (%eax),%eax
80100147:	83 e0 01             	and    $0x1,%eax
8010014a:	85 c0                	test   %eax,%eax
8010014c:	75 38                	jne    80100186 <bget+0xd6>
8010014e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100151:	8b 00                	mov    (%eax),%eax
80100153:	83 e0 04             	and    $0x4,%eax
80100156:	85 c0                	test   %eax,%eax
80100158:	75 2c                	jne    80100186 <bget+0xd6>
      b->dev = dev;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	8b 55 08             	mov    0x8(%ebp),%edx
80100160:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 0c             	mov    0xc(%ebp),%edx
80100169:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100175:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010017c:	e8 64 4c 00 00       	call   80104de5 <release>
      return b;
80100181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100184:	eb 1e                	jmp    801001a4 <bget+0xf4>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100189:	8b 40 0c             	mov    0xc(%eax),%eax
8010018c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010018f:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100196:	75 aa                	jne    80100142 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100198:	c7 04 24 a3 84 10 80 	movl   $0x801084a3,(%esp)
8010019f:	e8 99 03 00 00       	call   8010053d <panic>
}
801001a4:	c9                   	leave  
801001a5:	c3                   	ret    

801001a6 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001a6:	55                   	push   %ebp
801001a7:	89 e5                	mov    %esp,%ebp
801001a9:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801001af:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b3:	8b 45 08             	mov    0x8(%ebp),%eax
801001b6:	89 04 24             	mov    %eax,(%esp)
801001b9:	e8 f2 fe ff ff       	call   801000b0 <bget>
801001be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c4:	8b 00                	mov    (%eax),%eax
801001c6:	83 e0 02             	and    $0x2,%eax
801001c9:	85 c0                	test   %eax,%eax
801001cb:	75 0b                	jne    801001d8 <bread+0x32>
    iderw(b);
801001cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d0:	89 04 24             	mov    %eax,(%esp)
801001d3:	e8 e8 25 00 00       	call   801027c0 <iderw>
  return b;
801001d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001db:	c9                   	leave  
801001dc:	c3                   	ret    

801001dd <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001dd:	55                   	push   %ebp
801001de:	89 e5                	mov    %esp,%ebp
801001e0:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e3:	8b 45 08             	mov    0x8(%ebp),%eax
801001e6:	8b 00                	mov    (%eax),%eax
801001e8:	83 e0 01             	and    $0x1,%eax
801001eb:	85 c0                	test   %eax,%eax
801001ed:	75 0c                	jne    801001fb <bwrite+0x1e>
    panic("bwrite");
801001ef:	c7 04 24 b4 84 10 80 	movl   $0x801084b4,(%esp)
801001f6:	e8 42 03 00 00       	call   8010053d <panic>
  b->flags |= B_DIRTY;
801001fb:	8b 45 08             	mov    0x8(%ebp),%eax
801001fe:	8b 00                	mov    (%eax),%eax
80100200:	89 c2                	mov    %eax,%edx
80100202:	83 ca 04             	or     $0x4,%edx
80100205:	8b 45 08             	mov    0x8(%ebp),%eax
80100208:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020a:	8b 45 08             	mov    0x8(%ebp),%eax
8010020d:	89 04 24             	mov    %eax,(%esp)
80100210:	e8 ab 25 00 00       	call   801027c0 <iderw>
}
80100215:	c9                   	leave  
80100216:	c3                   	ret    

80100217 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100217:	55                   	push   %ebp
80100218:	89 e5                	mov    %esp,%ebp
8010021a:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021d:	8b 45 08             	mov    0x8(%ebp),%eax
80100220:	8b 00                	mov    (%eax),%eax
80100222:	83 e0 01             	and    $0x1,%eax
80100225:	85 c0                	test   %eax,%eax
80100227:	75 0c                	jne    80100235 <brelse+0x1e>
    panic("brelse");
80100229:	c7 04 24 bb 84 10 80 	movl   $0x801084bb,(%esp)
80100230:	e8 08 03 00 00       	call   8010053d <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010023c:	e8 42 4b 00 00       	call   80104d83 <acquire>

  b->next->prev = b->prev;
80100241:	8b 45 08             	mov    0x8(%ebp),%eax
80100244:	8b 40 10             	mov    0x10(%eax),%eax
80100247:	8b 55 08             	mov    0x8(%ebp),%edx
8010024a:	8b 52 0c             	mov    0xc(%edx),%edx
8010024d:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100250:	8b 45 08             	mov    0x8(%ebp),%eax
80100253:	8b 40 0c             	mov    0xc(%eax),%eax
80100256:	8b 55 08             	mov    0x8(%ebp),%edx
80100259:	8b 52 10             	mov    0x10(%edx),%edx
8010025c:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010025f:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100265:	8b 45 08             	mov    0x8(%ebp),%eax
80100268:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
  bcache.head.next->prev = b;
80100275:	a1 74 05 11 80       	mov    0x80110574,%eax
8010027a:	8b 55 08             	mov    0x8(%ebp),%edx
8010027d:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100280:	8b 45 08             	mov    0x8(%ebp),%eax
80100283:	a3 74 05 11 80       	mov    %eax,0x80110574

  b->flags &= ~B_BUSY;
80100288:	8b 45 08             	mov    0x8(%ebp),%eax
8010028b:	8b 00                	mov    (%eax),%eax
8010028d:	89 c2                	mov    %eax,%edx
8010028f:	83 e2 fe             	and    $0xfffffffe,%edx
80100292:	8b 45 08             	mov    0x8(%ebp),%eax
80100295:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100297:	8b 45 08             	mov    0x8(%ebp),%eax
8010029a:	89 04 24             	mov    %eax,(%esp)
8010029d:	e8 d5 48 00 00       	call   80104b77 <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801002a9:	e8 37 4b 00 00       	call   80104de5 <release>
}
801002ae:	c9                   	leave  
801002af:	c3                   	ret    

801002b0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b0:	55                   	push   %ebp
801002b1:	89 e5                	mov    %esp,%ebp
801002b3:	53                   	push   %ebx
801002b4:	83 ec 14             	sub    $0x14,%esp
801002b7:	8b 45 08             	mov    0x8(%ebp),%eax
801002ba:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002be:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
801002c2:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
801002c6:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
801002ca:	ec                   	in     (%dx),%al
801002cb:	89 c3                	mov    %eax,%ebx
801002cd:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
801002d0:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
801002d4:	83 c4 14             	add    $0x14,%esp
801002d7:	5b                   	pop    %ebx
801002d8:	5d                   	pop    %ebp
801002d9:	c3                   	ret    

801002da <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002da:	55                   	push   %ebp
801002db:	89 e5                	mov    %esp,%ebp
801002dd:	83 ec 08             	sub    $0x8,%esp
801002e0:	8b 55 08             	mov    0x8(%ebp),%edx
801002e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801002e6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002ea:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002ed:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002f1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002f5:	ee                   	out    %al,(%dx)
}
801002f6:	c9                   	leave  
801002f7:	c3                   	ret    

801002f8 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002f8:	55                   	push   %ebp
801002f9:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002fb:	fa                   	cli    
}
801002fc:	5d                   	pop    %ebp
801002fd:	c3                   	ret    

801002fe <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002fe:	55                   	push   %ebp
801002ff:	89 e5                	mov    %esp,%ebp
80100301:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100304:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100308:	74 19                	je     80100323 <printint+0x25>
8010030a:	8b 45 08             	mov    0x8(%ebp),%eax
8010030d:	c1 e8 1f             	shr    $0x1f,%eax
80100310:	89 45 10             	mov    %eax,0x10(%ebp)
80100313:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100317:	74 0a                	je     80100323 <printint+0x25>
    x = -xx;
80100319:	8b 45 08             	mov    0x8(%ebp),%eax
8010031c:	f7 d8                	neg    %eax
8010031e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100321:	eb 06                	jmp    80100329 <printint+0x2b>
  else
    x = xx;
80100323:	8b 45 08             	mov    0x8(%ebp),%eax
80100326:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100329:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100330:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100333:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100336:	ba 00 00 00 00       	mov    $0x0,%edx
8010033b:	f7 f1                	div    %ecx
8010033d:	89 d0                	mov    %edx,%eax
8010033f:	0f b6 90 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%edx
80100346:	8d 45 e0             	lea    -0x20(%ebp),%eax
80100349:	03 45 f4             	add    -0xc(%ebp),%eax
8010034c:	88 10                	mov    %dl,(%eax)
8010034e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
80100352:	8b 55 0c             	mov    0xc(%ebp),%edx
80100355:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80100358:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010035b:	ba 00 00 00 00       	mov    $0x0,%edx
80100360:	f7 75 d4             	divl   -0x2c(%ebp)
80100363:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100366:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010036a:	75 c4                	jne    80100330 <printint+0x32>

  if(sign)
8010036c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100370:	74 23                	je     80100395 <printint+0x97>
    buf[i++] = '-';
80100372:	8d 45 e0             	lea    -0x20(%ebp),%eax
80100375:	03 45 f4             	add    -0xc(%ebp),%eax
80100378:	c6 00 2d             	movb   $0x2d,(%eax)
8010037b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
8010037f:	eb 14                	jmp    80100395 <printint+0x97>
    consputc(buf[i]);
80100381:	8d 45 e0             	lea    -0x20(%ebp),%eax
80100384:	03 45 f4             	add    -0xc(%ebp),%eax
80100387:	0f b6 00             	movzbl (%eax),%eax
8010038a:	0f be c0             	movsbl %al,%eax
8010038d:	89 04 24             	mov    %eax,(%esp)
80100390:	e8 bb 03 00 00       	call   80100750 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100395:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100399:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010039d:	79 e2                	jns    80100381 <printint+0x83>
    consputc(buf[i]);
}
8010039f:	c9                   	leave  
801003a0:	c3                   	ret    

801003a1 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003a1:	55                   	push   %ebp
801003a2:	89 e5                	mov    %esp,%ebp
801003a4:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003a7:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003af:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003b3:	74 0c                	je     801003c1 <cprintf+0x20>
    acquire(&cons.lock);
801003b5:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801003bc:	e8 c2 49 00 00       	call   80104d83 <acquire>

  if (fmt == 0)
801003c1:	8b 45 08             	mov    0x8(%ebp),%eax
801003c4:	85 c0                	test   %eax,%eax
801003c6:	75 0c                	jne    801003d4 <cprintf+0x33>
    panic("null fmt");
801003c8:	c7 04 24 c2 84 10 80 	movl   $0x801084c2,(%esp)
801003cf:	e8 69 01 00 00       	call   8010053d <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003d4:	8d 45 0c             	lea    0xc(%ebp),%eax
801003d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801003e1:	e9 20 01 00 00       	jmp    80100506 <cprintf+0x165>
    if(c != '%'){
801003e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801003ea:	74 10                	je     801003fc <cprintf+0x5b>
      consputc(c);
801003ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801003ef:	89 04 24             	mov    %eax,(%esp)
801003f2:	e8 59 03 00 00       	call   80100750 <consputc>
      continue;
801003f7:	e9 06 01 00 00       	jmp    80100502 <cprintf+0x161>
    }
    c = fmt[++i] & 0xff;
801003fc:	8b 55 08             	mov    0x8(%ebp),%edx
801003ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100406:	01 d0                	add    %edx,%eax
80100408:	0f b6 00             	movzbl (%eax),%eax
8010040b:	0f be c0             	movsbl %al,%eax
8010040e:	25 ff 00 00 00       	and    $0xff,%eax
80100413:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100416:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010041a:	0f 84 08 01 00 00    	je     80100528 <cprintf+0x187>
      break;
    switch(c){
80100420:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100423:	83 f8 70             	cmp    $0x70,%eax
80100426:	74 4d                	je     80100475 <cprintf+0xd4>
80100428:	83 f8 70             	cmp    $0x70,%eax
8010042b:	7f 13                	jg     80100440 <cprintf+0x9f>
8010042d:	83 f8 25             	cmp    $0x25,%eax
80100430:	0f 84 a6 00 00 00    	je     801004dc <cprintf+0x13b>
80100436:	83 f8 64             	cmp    $0x64,%eax
80100439:	74 14                	je     8010044f <cprintf+0xae>
8010043b:	e9 aa 00 00 00       	jmp    801004ea <cprintf+0x149>
80100440:	83 f8 73             	cmp    $0x73,%eax
80100443:	74 53                	je     80100498 <cprintf+0xf7>
80100445:	83 f8 78             	cmp    $0x78,%eax
80100448:	74 2b                	je     80100475 <cprintf+0xd4>
8010044a:	e9 9b 00 00 00       	jmp    801004ea <cprintf+0x149>
    case 'd':
      printint(*argp++, 10, 1);
8010044f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100452:	8b 00                	mov    (%eax),%eax
80100454:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
80100458:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
8010045f:	00 
80100460:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100467:	00 
80100468:	89 04 24             	mov    %eax,(%esp)
8010046b:	e8 8e fe ff ff       	call   801002fe <printint>
      break;
80100470:	e9 8d 00 00 00       	jmp    80100502 <cprintf+0x161>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100475:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100478:	8b 00                	mov    (%eax),%eax
8010047a:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
8010047e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100485:	00 
80100486:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
8010048d:	00 
8010048e:	89 04 24             	mov    %eax,(%esp)
80100491:	e8 68 fe ff ff       	call   801002fe <printint>
      break;
80100496:	eb 6a                	jmp    80100502 <cprintf+0x161>
    case 's':
      if((s = (char*)*argp++) == 0)
80100498:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049b:	8b 00                	mov    (%eax),%eax
8010049d:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004a4:	0f 94 c0             	sete   %al
801004a7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
801004ab:	84 c0                	test   %al,%al
801004ad:	74 20                	je     801004cf <cprintf+0x12e>
        s = "(null)";
801004af:	c7 45 ec cb 84 10 80 	movl   $0x801084cb,-0x14(%ebp)
      for(; *s; s++)
801004b6:	eb 17                	jmp    801004cf <cprintf+0x12e>
        consputc(*s);
801004b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004bb:	0f b6 00             	movzbl (%eax),%eax
801004be:	0f be c0             	movsbl %al,%eax
801004c1:	89 04 24             	mov    %eax,(%esp)
801004c4:	e8 87 02 00 00       	call   80100750 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004c9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004cd:	eb 01                	jmp    801004d0 <cprintf+0x12f>
801004cf:	90                   	nop
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	84 c0                	test   %al,%al
801004d8:	75 de                	jne    801004b8 <cprintf+0x117>
        consputc(*s);
      break;
801004da:	eb 26                	jmp    80100502 <cprintf+0x161>
    case '%':
      consputc('%');
801004dc:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004e3:	e8 68 02 00 00       	call   80100750 <consputc>
      break;
801004e8:	eb 18                	jmp    80100502 <cprintf+0x161>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004ea:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004f1:	e8 5a 02 00 00       	call   80100750 <consputc>
      consputc(c);
801004f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801004f9:	89 04 24             	mov    %eax,(%esp)
801004fc:	e8 4f 02 00 00       	call   80100750 <consputc>
      break;
80100501:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100502:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100506:	8b 55 08             	mov    0x8(%ebp),%edx
80100509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010050c:	01 d0                	add    %edx,%eax
8010050e:	0f b6 00             	movzbl (%eax),%eax
80100511:	0f be c0             	movsbl %al,%eax
80100514:	25 ff 00 00 00       	and    $0xff,%eax
80100519:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010051c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100520:	0f 85 c0 fe ff ff    	jne    801003e6 <cprintf+0x45>
80100526:	eb 01                	jmp    80100529 <cprintf+0x188>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100528:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100529:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010052d:	74 0c                	je     8010053b <cprintf+0x19a>
    release(&cons.lock);
8010052f:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100536:	e8 aa 48 00 00       	call   80104de5 <release>
}
8010053b:	c9                   	leave  
8010053c:	c3                   	ret    

8010053d <panic>:

void
panic(char *s)
{
8010053d:	55                   	push   %ebp
8010053e:	89 e5                	mov    %esp,%ebp
80100540:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
80100543:	e8 b0 fd ff ff       	call   801002f8 <cli>
  cons.locking = 0;
80100548:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
8010054f:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100552:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100558:	0f b6 00             	movzbl (%eax),%eax
8010055b:	0f b6 c0             	movzbl %al,%eax
8010055e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100562:	c7 04 24 d2 84 10 80 	movl   $0x801084d2,(%esp)
80100569:	e8 33 fe ff ff       	call   801003a1 <cprintf>
  cprintf(s);
8010056e:	8b 45 08             	mov    0x8(%ebp),%eax
80100571:	89 04 24             	mov    %eax,(%esp)
80100574:	e8 28 fe ff ff       	call   801003a1 <cprintf>
  cprintf("\n");
80100579:	c7 04 24 e1 84 10 80 	movl   $0x801084e1,(%esp)
80100580:	e8 1c fe ff ff       	call   801003a1 <cprintf>
  getcallerpcs(&s, pcs);
80100585:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100588:	89 44 24 04          	mov    %eax,0x4(%esp)
8010058c:	8d 45 08             	lea    0x8(%ebp),%eax
8010058f:	89 04 24             	mov    %eax,(%esp)
80100592:	e8 9d 48 00 00       	call   80104e34 <getcallerpcs>
  for(i=0; i<10; i++)
80100597:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059e:	eb 1b                	jmp    801005bb <panic+0x7e>
    cprintf(" %p", pcs[i]);
801005a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a3:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801005ab:	c7 04 24 e3 84 10 80 	movl   $0x801084e3,(%esp)
801005b2:	e8 ea fd ff ff       	call   801003a1 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005bb:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005bf:	7e df                	jle    801005a0 <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005c1:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005c8:	00 00 00 
  for(;;)
    ;
801005cb:	eb fe                	jmp    801005cb <panic+0x8e>

801005cd <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005cd:	55                   	push   %ebp
801005ce:	89 e5                	mov    %esp,%ebp
801005d0:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005d3:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005da:	00 
801005db:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005e2:	e8 f3 fc ff ff       	call   801002da <outb>
  pos = inb(CRTPORT+1) << 8;
801005e7:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005ee:	e8 bd fc ff ff       	call   801002b0 <inb>
801005f3:	0f b6 c0             	movzbl %al,%eax
801005f6:	c1 e0 08             	shl    $0x8,%eax
801005f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
801005fc:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100603:	00 
80100604:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010060b:	e8 ca fc ff ff       	call   801002da <outb>
  pos |= inb(CRTPORT+1);
80100610:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100617:	e8 94 fc ff ff       	call   801002b0 <inb>
8010061c:	0f b6 c0             	movzbl %al,%eax
8010061f:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100622:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100626:	75 30                	jne    80100658 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100628:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010062b:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100630:	89 c8                	mov    %ecx,%eax
80100632:	f7 ea                	imul   %edx
80100634:	c1 fa 05             	sar    $0x5,%edx
80100637:	89 c8                	mov    %ecx,%eax
80100639:	c1 f8 1f             	sar    $0x1f,%eax
8010063c:	29 c2                	sub    %eax,%edx
8010063e:	89 d0                	mov    %edx,%eax
80100640:	c1 e0 02             	shl    $0x2,%eax
80100643:	01 d0                	add    %edx,%eax
80100645:	c1 e0 04             	shl    $0x4,%eax
80100648:	89 ca                	mov    %ecx,%edx
8010064a:	29 c2                	sub    %eax,%edx
8010064c:	b8 50 00 00 00       	mov    $0x50,%eax
80100651:	29 d0                	sub    %edx,%eax
80100653:	01 45 f4             	add    %eax,-0xc(%ebp)
80100656:	eb 32                	jmp    8010068a <cgaputc+0xbd>
  else if(c == BACKSPACE){
80100658:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065f:	75 0c                	jne    8010066d <cgaputc+0xa0>
    if(pos > 0) --pos;
80100661:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100665:	7e 23                	jle    8010068a <cgaputc+0xbd>
80100667:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010066b:	eb 1d                	jmp    8010068a <cgaputc+0xbd>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010066d:	a1 00 90 10 80       	mov    0x80109000,%eax
80100672:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100675:	01 d2                	add    %edx,%edx
80100677:	01 c2                	add    %eax,%edx
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	66 25 ff 00          	and    $0xff,%ax
80100680:	80 cc 07             	or     $0x7,%ah
80100683:	66 89 02             	mov    %ax,(%edx)
80100686:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  if((pos/80) >= 24){  // Scroll up.
8010068a:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100691:	7e 53                	jle    801006e6 <cgaputc+0x119>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100693:	a1 00 90 10 80       	mov    0x80109000,%eax
80100698:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010069e:	a1 00 90 10 80       	mov    0x80109000,%eax
801006a3:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006aa:	00 
801006ab:	89 54 24 04          	mov    %edx,0x4(%esp)
801006af:	89 04 24             	mov    %eax,(%esp)
801006b2:	e8 ee 49 00 00       	call   801050a5 <memmove>
    pos -= 80;
801006b7:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006bb:	b8 80 07 00 00       	mov    $0x780,%eax
801006c0:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006c3:	01 c0                	add    %eax,%eax
801006c5:	8b 15 00 90 10 80    	mov    0x80109000,%edx
801006cb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006ce:	01 c9                	add    %ecx,%ecx
801006d0:	01 ca                	add    %ecx,%edx
801006d2:	89 44 24 08          	mov    %eax,0x8(%esp)
801006d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801006dd:	00 
801006de:	89 14 24             	mov    %edx,(%esp)
801006e1:	e8 ec 48 00 00       	call   80104fd2 <memset>
  }
  
  outb(CRTPORT, 14);
801006e6:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801006ed:	00 
801006ee:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801006f5:	e8 e0 fb ff ff       	call   801002da <outb>
  outb(CRTPORT+1, pos>>8);
801006fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006fd:	c1 f8 08             	sar    $0x8,%eax
80100700:	0f b6 c0             	movzbl %al,%eax
80100703:	89 44 24 04          	mov    %eax,0x4(%esp)
80100707:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010070e:	e8 c7 fb ff ff       	call   801002da <outb>
  outb(CRTPORT, 15);
80100713:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010071a:	00 
8010071b:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100722:	e8 b3 fb ff ff       	call   801002da <outb>
  outb(CRTPORT+1, pos);
80100727:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010072a:	0f b6 c0             	movzbl %al,%eax
8010072d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100731:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100738:	e8 9d fb ff ff       	call   801002da <outb>
  crt[pos] = ' ' | 0x0700;
8010073d:	a1 00 90 10 80       	mov    0x80109000,%eax
80100742:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100745:	01 d2                	add    %edx,%edx
80100747:	01 d0                	add    %edx,%eax
80100749:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010074e:	c9                   	leave  
8010074f:	c3                   	ret    

80100750 <consputc>:

void
consputc(int c)
{
80100750:	55                   	push   %ebp
80100751:	89 e5                	mov    %esp,%ebp
80100753:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
80100756:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
8010075b:	85 c0                	test   %eax,%eax
8010075d:	74 07                	je     80100766 <consputc+0x16>
    cli();
8010075f:	e8 94 fb ff ff       	call   801002f8 <cli>
    for(;;)
      ;
80100764:	eb fe                	jmp    80100764 <consputc+0x14>
  }

  if(c == BACKSPACE){
80100766:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010076d:	75 26                	jne    80100795 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010076f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100776:	e8 72 63 00 00       	call   80106aed <uartputc>
8010077b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100782:	e8 66 63 00 00       	call   80106aed <uartputc>
80100787:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010078e:	e8 5a 63 00 00       	call   80106aed <uartputc>
80100793:	eb 0b                	jmp    801007a0 <consputc+0x50>
  } else
    uartputc(c);
80100795:	8b 45 08             	mov    0x8(%ebp),%eax
80100798:	89 04 24             	mov    %eax,(%esp)
8010079b:	e8 4d 63 00 00       	call   80106aed <uartputc>
  cgaputc(c);
801007a0:	8b 45 08             	mov    0x8(%ebp),%eax
801007a3:	89 04 24             	mov    %eax,(%esp)
801007a6:	e8 22 fe ff ff       	call   801005cd <cgaputc>
}
801007ab:	c9                   	leave  
801007ac:	c3                   	ret    

801007ad <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007ad:	55                   	push   %ebp
801007ae:	89 e5                	mov    %esp,%ebp
801007b0:	83 ec 28             	sub    $0x28,%esp
  int c;

  acquire(&input.lock);
801007b3:	c7 04 24 80 07 11 80 	movl   $0x80110780,(%esp)
801007ba:	e8 c4 45 00 00       	call   80104d83 <acquire>
  while((c = getc()) >= 0){
801007bf:	e9 41 01 00 00       	jmp    80100905 <consoleintr+0x158>
    switch(c){
801007c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007c7:	83 f8 10             	cmp    $0x10,%eax
801007ca:	74 1e                	je     801007ea <consoleintr+0x3d>
801007cc:	83 f8 10             	cmp    $0x10,%eax
801007cf:	7f 0a                	jg     801007db <consoleintr+0x2e>
801007d1:	83 f8 08             	cmp    $0x8,%eax
801007d4:	74 68                	je     8010083e <consoleintr+0x91>
801007d6:	e9 94 00 00 00       	jmp    8010086f <consoleintr+0xc2>
801007db:	83 f8 15             	cmp    $0x15,%eax
801007de:	74 2f                	je     8010080f <consoleintr+0x62>
801007e0:	83 f8 7f             	cmp    $0x7f,%eax
801007e3:	74 59                	je     8010083e <consoleintr+0x91>
801007e5:	e9 85 00 00 00       	jmp    8010086f <consoleintr+0xc2>
    case C('P'):  // Process listing.
      procdump();
801007ea:	e8 2e 44 00 00       	call   80104c1d <procdump>
      break;
801007ef:	e9 11 01 00 00       	jmp    80100905 <consoleintr+0x158>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801007f4:	a1 3c 08 11 80       	mov    0x8011083c,%eax
801007f9:	83 e8 01             	sub    $0x1,%eax
801007fc:	a3 3c 08 11 80       	mov    %eax,0x8011083c
        consputc(BACKSPACE);
80100801:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100808:	e8 43 ff ff ff       	call   80100750 <consputc>
8010080d:	eb 01                	jmp    80100810 <consoleintr+0x63>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010080f:	90                   	nop
80100810:	8b 15 3c 08 11 80    	mov    0x8011083c,%edx
80100816:	a1 38 08 11 80       	mov    0x80110838,%eax
8010081b:	39 c2                	cmp    %eax,%edx
8010081d:	0f 84 db 00 00 00    	je     801008fe <consoleintr+0x151>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100823:	a1 3c 08 11 80       	mov    0x8011083c,%eax
80100828:	83 e8 01             	sub    $0x1,%eax
8010082b:	83 e0 7f             	and    $0x7f,%eax
8010082e:	0f b6 80 b4 07 11 80 	movzbl -0x7feef84c(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100835:	3c 0a                	cmp    $0xa,%al
80100837:	75 bb                	jne    801007f4 <consoleintr+0x47>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100839:	e9 c0 00 00 00       	jmp    801008fe <consoleintr+0x151>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010083e:	8b 15 3c 08 11 80    	mov    0x8011083c,%edx
80100844:	a1 38 08 11 80       	mov    0x80110838,%eax
80100849:	39 c2                	cmp    %eax,%edx
8010084b:	0f 84 b0 00 00 00    	je     80100901 <consoleintr+0x154>
        input.e--;
80100851:	a1 3c 08 11 80       	mov    0x8011083c,%eax
80100856:	83 e8 01             	sub    $0x1,%eax
80100859:	a3 3c 08 11 80       	mov    %eax,0x8011083c
        consputc(BACKSPACE);
8010085e:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100865:	e8 e6 fe ff ff       	call   80100750 <consputc>
      }
      break;
8010086a:	e9 92 00 00 00       	jmp    80100901 <consoleintr+0x154>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010086f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100873:	0f 84 8b 00 00 00    	je     80100904 <consoleintr+0x157>
80100879:	8b 15 3c 08 11 80    	mov    0x8011083c,%edx
8010087f:	a1 34 08 11 80       	mov    0x80110834,%eax
80100884:	89 d1                	mov    %edx,%ecx
80100886:	29 c1                	sub    %eax,%ecx
80100888:	89 c8                	mov    %ecx,%eax
8010088a:	83 f8 7f             	cmp    $0x7f,%eax
8010088d:	77 75                	ja     80100904 <consoleintr+0x157>
        c = (c == '\r') ? '\n' : c;
8010088f:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
80100893:	74 05                	je     8010089a <consoleintr+0xed>
80100895:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100898:	eb 05                	jmp    8010089f <consoleintr+0xf2>
8010089a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010089f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008a2:	a1 3c 08 11 80       	mov    0x8011083c,%eax
801008a7:	89 c1                	mov    %eax,%ecx
801008a9:	83 e1 7f             	and    $0x7f,%ecx
801008ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008af:	88 91 b4 07 11 80    	mov    %dl,-0x7feef84c(%ecx)
801008b5:	83 c0 01             	add    $0x1,%eax
801008b8:	a3 3c 08 11 80       	mov    %eax,0x8011083c
        consputc(c);
801008bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008c0:	89 04 24             	mov    %eax,(%esp)
801008c3:	e8 88 fe ff ff       	call   80100750 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c8:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008cc:	74 18                	je     801008e6 <consoleintr+0x139>
801008ce:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
801008d2:	74 12                	je     801008e6 <consoleintr+0x139>
801008d4:	a1 3c 08 11 80       	mov    0x8011083c,%eax
801008d9:	8b 15 34 08 11 80    	mov    0x80110834,%edx
801008df:	83 ea 80             	sub    $0xffffff80,%edx
801008e2:	39 d0                	cmp    %edx,%eax
801008e4:	75 1e                	jne    80100904 <consoleintr+0x157>
          input.w = input.e;
801008e6:	a1 3c 08 11 80       	mov    0x8011083c,%eax
801008eb:	a3 38 08 11 80       	mov    %eax,0x80110838
          wakeup(&input.r);
801008f0:	c7 04 24 34 08 11 80 	movl   $0x80110834,(%esp)
801008f7:	e8 7b 42 00 00       	call   80104b77 <wakeup>
        }
      }
      break;
801008fc:	eb 06                	jmp    80100904 <consoleintr+0x157>
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
801008fe:	90                   	nop
801008ff:	eb 04                	jmp    80100905 <consoleintr+0x158>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100901:	90                   	nop
80100902:	eb 01                	jmp    80100905 <consoleintr+0x158>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
80100904:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
80100905:	8b 45 08             	mov    0x8(%ebp),%eax
80100908:	ff d0                	call   *%eax
8010090a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010090d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100911:	0f 89 ad fe ff ff    	jns    801007c4 <consoleintr+0x17>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100917:	c7 04 24 80 07 11 80 	movl   $0x80110780,(%esp)
8010091e:	e8 c2 44 00 00       	call   80104de5 <release>
}
80100923:	c9                   	leave  
80100924:	c3                   	ret    

80100925 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100925:	55                   	push   %ebp
80100926:	89 e5                	mov    %esp,%ebp
80100928:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
8010092b:	8b 45 08             	mov    0x8(%ebp),%eax
8010092e:	89 04 24             	mov    %eax,(%esp)
80100931:	e8 8c 10 00 00       	call   801019c2 <iunlock>
  target = n;
80100936:	8b 45 10             	mov    0x10(%ebp),%eax
80100939:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
8010093c:	c7 04 24 80 07 11 80 	movl   $0x80110780,(%esp)
80100943:	e8 3b 44 00 00       	call   80104d83 <acquire>
  while(n > 0){
80100948:	e9 a8 00 00 00       	jmp    801009f5 <consoleread+0xd0>
    while(input.r == input.w){
      if(proc->killed){
8010094d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100953:	8b 40 24             	mov    0x24(%eax),%eax
80100956:	85 c0                	test   %eax,%eax
80100958:	74 21                	je     8010097b <consoleread+0x56>
        release(&input.lock);
8010095a:	c7 04 24 80 07 11 80 	movl   $0x80110780,(%esp)
80100961:	e8 7f 44 00 00       	call   80104de5 <release>
        ilock(ip);
80100966:	8b 45 08             	mov    0x8(%ebp),%eax
80100969:	89 04 24             	mov    %eax,(%esp)
8010096c:	e8 03 0f 00 00       	call   80101874 <ilock>
        return -1;
80100971:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100976:	e9 a9 00 00 00       	jmp    80100a24 <consoleread+0xff>
      }
      sleep(&input.r, &input.lock);
8010097b:	c7 44 24 04 80 07 11 	movl   $0x80110780,0x4(%esp)
80100982:	80 
80100983:	c7 04 24 34 08 11 80 	movl   $0x80110834,(%esp)
8010098a:	e8 0c 41 00 00       	call   80104a9b <sleep>
8010098f:	eb 01                	jmp    80100992 <consoleread+0x6d>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
80100991:	90                   	nop
80100992:	8b 15 34 08 11 80    	mov    0x80110834,%edx
80100998:	a1 38 08 11 80       	mov    0x80110838,%eax
8010099d:	39 c2                	cmp    %eax,%edx
8010099f:	74 ac                	je     8010094d <consoleread+0x28>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009a1:	a1 34 08 11 80       	mov    0x80110834,%eax
801009a6:	89 c2                	mov    %eax,%edx
801009a8:	83 e2 7f             	and    $0x7f,%edx
801009ab:	0f b6 92 b4 07 11 80 	movzbl -0x7feef84c(%edx),%edx
801009b2:	0f be d2             	movsbl %dl,%edx
801009b5:	89 55 f0             	mov    %edx,-0x10(%ebp)
801009b8:	83 c0 01             	add    $0x1,%eax
801009bb:	a3 34 08 11 80       	mov    %eax,0x80110834
    if(c == C('D')){  // EOF
801009c0:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009c4:	75 17                	jne    801009dd <consoleread+0xb8>
      if(n < target){
801009c6:	8b 45 10             	mov    0x10(%ebp),%eax
801009c9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801009cc:	73 2f                	jae    801009fd <consoleread+0xd8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
801009ce:	a1 34 08 11 80       	mov    0x80110834,%eax
801009d3:	83 e8 01             	sub    $0x1,%eax
801009d6:	a3 34 08 11 80       	mov    %eax,0x80110834
      }
      break;
801009db:	eb 20                	jmp    801009fd <consoleread+0xd8>
    }
    *dst++ = c;
801009dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801009e0:	89 c2                	mov    %eax,%edx
801009e2:	8b 45 0c             	mov    0xc(%ebp),%eax
801009e5:	88 10                	mov    %dl,(%eax)
801009e7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    --n;
801009eb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
801009ef:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801009f3:	74 0b                	je     80100a00 <consoleread+0xdb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
801009f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801009f9:	7f 96                	jg     80100991 <consoleread+0x6c>
801009fb:	eb 04                	jmp    80100a01 <consoleread+0xdc>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
801009fd:	90                   	nop
801009fe:	eb 01                	jmp    80100a01 <consoleread+0xdc>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100a00:	90                   	nop
  }
  release(&input.lock);
80100a01:	c7 04 24 80 07 11 80 	movl   $0x80110780,(%esp)
80100a08:	e8 d8 43 00 00       	call   80104de5 <release>
  ilock(ip);
80100a0d:	8b 45 08             	mov    0x8(%ebp),%eax
80100a10:	89 04 24             	mov    %eax,(%esp)
80100a13:	e8 5c 0e 00 00       	call   80101874 <ilock>

  return target - n;
80100a18:	8b 45 10             	mov    0x10(%ebp),%eax
80100a1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a1e:	89 d1                	mov    %edx,%ecx
80100a20:	29 c1                	sub    %eax,%ecx
80100a22:	89 c8                	mov    %ecx,%eax
}
80100a24:	c9                   	leave  
80100a25:	c3                   	ret    

80100a26 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a26:	55                   	push   %ebp
80100a27:	89 e5                	mov    %esp,%ebp
80100a29:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a2c:	8b 45 08             	mov    0x8(%ebp),%eax
80100a2f:	89 04 24             	mov    %eax,(%esp)
80100a32:	e8 8b 0f 00 00       	call   801019c2 <iunlock>
  acquire(&cons.lock);
80100a37:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a3e:	e8 40 43 00 00       	call   80104d83 <acquire>
  for(i = 0; i < n; i++)
80100a43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a4a:	eb 1d                	jmp    80100a69 <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a4f:	03 45 0c             	add    0xc(%ebp),%eax
80100a52:	0f b6 00             	movzbl (%eax),%eax
80100a55:	0f be c0             	movsbl %al,%eax
80100a58:	25 ff 00 00 00       	and    $0xff,%eax
80100a5d:	89 04 24             	mov    %eax,(%esp)
80100a60:	e8 eb fc ff ff       	call   80100750 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100a65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a6c:	3b 45 10             	cmp    0x10(%ebp),%eax
80100a6f:	7c db                	jl     80100a4c <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100a71:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a78:	e8 68 43 00 00       	call   80104de5 <release>
  ilock(ip);
80100a7d:	8b 45 08             	mov    0x8(%ebp),%eax
80100a80:	89 04 24             	mov    %eax,(%esp)
80100a83:	e8 ec 0d 00 00       	call   80101874 <ilock>

  return n;
80100a88:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100a8b:	c9                   	leave  
80100a8c:	c3                   	ret    

80100a8d <consoleinit>:

void
consoleinit(void)
{
80100a8d:	55                   	push   %ebp
80100a8e:	89 e5                	mov    %esp,%ebp
80100a90:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a93:	c7 44 24 04 e7 84 10 	movl   $0x801084e7,0x4(%esp)
80100a9a:	80 
80100a9b:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100aa2:	e8 bb 42 00 00       	call   80104d62 <initlock>
  initlock(&input.lock, "input");
80100aa7:	c7 44 24 04 ef 84 10 	movl   $0x801084ef,0x4(%esp)
80100aae:	80 
80100aaf:	c7 04 24 80 07 11 80 	movl   $0x80110780,(%esp)
80100ab6:	e8 a7 42 00 00       	call   80104d62 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100abb:	c7 05 ec 11 11 80 26 	movl   $0x80100a26,0x801111ec
80100ac2:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100ac5:	c7 05 e8 11 11 80 25 	movl   $0x80100925,0x801111e8
80100acc:	09 10 80 
  cons.locking = 1;
80100acf:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100ad6:	00 00 00 

  picenable(IRQ_KBD);
80100ad9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100ae0:	e8 e4 30 00 00       	call   80103bc9 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100ae5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100aec:	00 
80100aed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100af4:	e8 89 1e 00 00       	call   80102982 <ioapicenable>
}
80100af9:	c9                   	leave  
80100afa:	c3                   	ret    
	...

80100afc <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100afc:	55                   	push   %ebp
80100afd:	89 e5                	mov    %esp,%ebp
80100aff:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b05:	e8 1f 27 00 00       	call   80103229 <begin_op>
  if((ip = namei(path)) == 0){
80100b0a:	8b 45 08             	mov    0x8(%ebp),%eax
80100b0d:	89 04 24             	mov    %eax,(%esp)
80100b10:	e8 01 19 00 00       	call   80102416 <namei>
80100b15:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b18:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b1c:	75 0f                	jne    80100b2d <exec+0x31>
    end_op();
80100b1e:	e8 87 27 00 00       	call   801032aa <end_op>
    return -1;
80100b23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b28:	e9 dd 03 00 00       	jmp    80100f0a <exec+0x40e>
  }
  ilock(ip);
80100b2d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b30:	89 04 24             	mov    %eax,(%esp)
80100b33:	e8 3c 0d 00 00       	call   80101874 <ilock>
  pgdir = 0;
80100b38:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b3f:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b46:	00 
80100b47:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b4e:	00 
80100b4f:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b55:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b5c:	89 04 24             	mov    %eax,(%esp)
80100b5f:	e8 06 12 00 00       	call   80101d6a <readi>
80100b64:	83 f8 33             	cmp    $0x33,%eax
80100b67:	0f 86 52 03 00 00    	jbe    80100ebf <exec+0x3c3>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b6d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b73:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100b78:	0f 85 44 03 00 00    	jne    80100ec2 <exec+0x3c6>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b7e:	e8 ae 70 00 00       	call   80107c31 <setupkvm>
80100b83:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100b86:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100b8a:	0f 84 35 03 00 00    	je     80100ec5 <exec+0x3c9>
    goto bad;

  // Load program into memory.
  sz = 0;
80100b90:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b97:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100b9e:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100ba4:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ba7:	e9 c5 00 00 00       	jmp    80100c71 <exec+0x175>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bac:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100baf:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100bb6:	00 
80100bb7:	89 44 24 08          	mov    %eax,0x8(%esp)
80100bbb:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bc1:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bc5:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100bc8:	89 04 24             	mov    %eax,(%esp)
80100bcb:	e8 9a 11 00 00       	call   80101d6a <readi>
80100bd0:	83 f8 20             	cmp    $0x20,%eax
80100bd3:	0f 85 ef 02 00 00    	jne    80100ec8 <exec+0x3cc>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100bd9:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100bdf:	83 f8 01             	cmp    $0x1,%eax
80100be2:	75 7f                	jne    80100c63 <exec+0x167>
      continue;
    if(ph.memsz < ph.filesz)
80100be4:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100bea:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100bf0:	39 c2                	cmp    %eax,%edx
80100bf2:	0f 82 d3 02 00 00    	jb     80100ecb <exec+0x3cf>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bf8:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100bfe:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c04:	01 d0                	add    %edx,%eax
80100c06:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c11:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c14:	89 04 24             	mov    %eax,(%esp)
80100c17:	e8 e7 73 00 00       	call   80108003 <allocuvm>
80100c1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c1f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c23:	0f 84 a5 02 00 00    	je     80100ece <exec+0x3d2>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c29:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100c2f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c35:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c3b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100c3f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c43:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100c46:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c4e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c51:	89 04 24             	mov    %eax,(%esp)
80100c54:	e8 bb 72 00 00       	call   80107f14 <loaduvm>
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 70 02 00 00    	js     80100ed1 <exec+0x3d5>
80100c61:	eb 01                	jmp    80100c64 <exec+0x168>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c63:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c64:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c68:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c6b:	83 c0 20             	add    $0x20,%eax
80100c6e:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c71:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100c78:	0f b7 c0             	movzwl %ax,%eax
80100c7b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100c7e:	0f 8f 28 ff ff ff    	jg     80100bac <exec+0xb0>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c84:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100c87:	89 04 24             	mov    %eax,(%esp)
80100c8a:	e8 69 0e 00 00       	call   80101af8 <iunlockput>
  end_op();
80100c8f:	e8 16 26 00 00       	call   801032aa <end_op>
  ip = 0;
80100c94:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100c9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c9e:	05 ff 0f 00 00       	add    $0xfff,%eax
80100ca3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100ca8:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cab:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cae:	05 00 20 00 00       	add    $0x2000,%eax
80100cb3:	89 44 24 08          	mov    %eax,0x8(%esp)
80100cb7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cba:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cbe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100cc1:	89 04 24             	mov    %eax,(%esp)
80100cc4:	e8 3a 73 00 00       	call   80108003 <allocuvm>
80100cc9:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100ccc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cd0:	0f 84 fe 01 00 00    	je     80100ed4 <exec+0x3d8>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd9:	2d 00 20 00 00       	sub    $0x2000,%eax
80100cde:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ce2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ce5:	89 04 24             	mov    %eax,(%esp)
80100ce8:	e8 3a 75 00 00       	call   80108227 <clearpteu>
  sp = sz;
80100ced:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cf0:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100cf3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100cfa:	e9 81 00 00 00       	jmp    80100d80 <exec+0x284>
    if(argc >= MAXARG)
80100cff:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d03:	0f 87 ce 01 00 00    	ja     80100ed7 <exec+0x3db>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d0c:	c1 e0 02             	shl    $0x2,%eax
80100d0f:	03 45 0c             	add    0xc(%ebp),%eax
80100d12:	8b 00                	mov    (%eax),%eax
80100d14:	89 04 24             	mov    %eax,(%esp)
80100d17:	e8 34 45 00 00       	call   80105250 <strlen>
80100d1c:	f7 d0                	not    %eax
80100d1e:	03 45 dc             	add    -0x24(%ebp),%eax
80100d21:	83 e0 fc             	and    $0xfffffffc,%eax
80100d24:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d2a:	c1 e0 02             	shl    $0x2,%eax
80100d2d:	03 45 0c             	add    0xc(%ebp),%eax
80100d30:	8b 00                	mov    (%eax),%eax
80100d32:	89 04 24             	mov    %eax,(%esp)
80100d35:	e8 16 45 00 00       	call   80105250 <strlen>
80100d3a:	83 c0 01             	add    $0x1,%eax
80100d3d:	89 c2                	mov    %eax,%edx
80100d3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d42:	c1 e0 02             	shl    $0x2,%eax
80100d45:	03 45 0c             	add    0xc(%ebp),%eax
80100d48:	8b 00                	mov    (%eax),%eax
80100d4a:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100d4e:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d52:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d55:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d59:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100d5c:	89 04 24             	mov    %eax,(%esp)
80100d5f:	e8 88 76 00 00       	call   801083ec <copyout>
80100d64:	85 c0                	test   %eax,%eax
80100d66:	0f 88 6e 01 00 00    	js     80100eda <exec+0x3de>
      goto bad;
    ustack[3+argc] = sp;
80100d6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d6f:	8d 50 03             	lea    0x3(%eax),%edx
80100d72:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d75:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d7c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100d80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d83:	c1 e0 02             	shl    $0x2,%eax
80100d86:	03 45 0c             	add    0xc(%ebp),%eax
80100d89:	8b 00                	mov    (%eax),%eax
80100d8b:	85 c0                	test   %eax,%eax
80100d8d:	0f 85 6c ff ff ff    	jne    80100cff <exec+0x203>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100d93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d96:	83 c0 03             	add    $0x3,%eax
80100d99:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100da0:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100da4:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100dab:	ff ff ff 
  ustack[1] = argc;
80100dae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db1:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100db7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dba:	83 c0 01             	add    $0x1,%eax
80100dbd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dc7:	29 d0                	sub    %edx,%eax
80100dc9:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100dcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd2:	83 c0 04             	add    $0x4,%eax
80100dd5:	c1 e0 02             	shl    $0x2,%eax
80100dd8:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ddb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dde:	83 c0 04             	add    $0x4,%eax
80100de1:	c1 e0 02             	shl    $0x2,%eax
80100de4:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100de8:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100dee:	89 44 24 08          	mov    %eax,0x8(%esp)
80100df2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100df5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100df9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100dfc:	89 04 24             	mov    %eax,(%esp)
80100dff:	e8 e8 75 00 00       	call   801083ec <copyout>
80100e04:	85 c0                	test   %eax,%eax
80100e06:	0f 88 d1 00 00 00    	js     80100edd <exec+0x3e1>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e0c:	8b 45 08             	mov    0x8(%ebp),%eax
80100e0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e15:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e18:	eb 17                	jmp    80100e31 <exec+0x335>
    if(*s == '/')
80100e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e1d:	0f b6 00             	movzbl (%eax),%eax
80100e20:	3c 2f                	cmp    $0x2f,%al
80100e22:	75 09                	jne    80100e2d <exec+0x331>
      last = s+1;
80100e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e27:	83 c0 01             	add    $0x1,%eax
80100e2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e2d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e34:	0f b6 00             	movzbl (%eax),%eax
80100e37:	84 c0                	test   %al,%al
80100e39:	75 df                	jne    80100e1a <exec+0x31e>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e3b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e41:	8d 50 6c             	lea    0x6c(%eax),%edx
80100e44:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100e4b:	00 
80100e4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e53:	89 14 24             	mov    %edx,(%esp)
80100e56:	e8 a7 43 00 00       	call   80105202 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e5b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e61:	8b 40 04             	mov    0x4(%eax),%eax
80100e64:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100e67:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e6d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100e70:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100e73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e79:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100e7c:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100e7e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e84:	8b 40 18             	mov    0x18(%eax),%eax
80100e87:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100e8d:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100e90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e96:	8b 40 18             	mov    0x18(%eax),%eax
80100e99:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100e9c:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100e9f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea5:	89 04 24             	mov    %eax,(%esp)
80100ea8:	e8 75 6e 00 00       	call   80107d22 <switchuvm>
  freevm(oldpgdir);
80100ead:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100eb0:	89 04 24             	mov    %eax,(%esp)
80100eb3:	e8 e1 72 00 00       	call   80108199 <freevm>
  return 0;
80100eb8:	b8 00 00 00 00       	mov    $0x0,%eax
80100ebd:	eb 4b                	jmp    80100f0a <exec+0x40e>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100ebf:	90                   	nop
80100ec0:	eb 1c                	jmp    80100ede <exec+0x3e2>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100ec2:	90                   	nop
80100ec3:	eb 19                	jmp    80100ede <exec+0x3e2>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100ec5:	90                   	nop
80100ec6:	eb 16                	jmp    80100ede <exec+0x3e2>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100ec8:	90                   	nop
80100ec9:	eb 13                	jmp    80100ede <exec+0x3e2>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100ecb:	90                   	nop
80100ecc:	eb 10                	jmp    80100ede <exec+0x3e2>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100ece:	90                   	nop
80100ecf:	eb 0d                	jmp    80100ede <exec+0x3e2>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100ed1:	90                   	nop
80100ed2:	eb 0a                	jmp    80100ede <exec+0x3e2>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100ed4:	90                   	nop
80100ed5:	eb 07                	jmp    80100ede <exec+0x3e2>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100ed7:	90                   	nop
80100ed8:	eb 04                	jmp    80100ede <exec+0x3e2>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100eda:	90                   	nop
80100edb:	eb 01                	jmp    80100ede <exec+0x3e2>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100edd:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100ede:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100ee2:	74 0b                	je     80100eef <exec+0x3f3>
    freevm(pgdir);
80100ee4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100ee7:	89 04 24             	mov    %eax,(%esp)
80100eea:	e8 aa 72 00 00       	call   80108199 <freevm>
  if(ip){
80100eef:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100ef3:	74 10                	je     80100f05 <exec+0x409>
    iunlockput(ip);
80100ef5:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100ef8:	89 04 24             	mov    %eax,(%esp)
80100efb:	e8 f8 0b 00 00       	call   80101af8 <iunlockput>
    end_op();
80100f00:	e8 a5 23 00 00       	call   801032aa <end_op>
  }
  return -1;
80100f05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f0a:	c9                   	leave  
80100f0b:	c3                   	ret    

80100f0c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f0c:	55                   	push   %ebp
80100f0d:	89 e5                	mov    %esp,%ebp
80100f0f:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100f12:	c7 44 24 04 f5 84 10 	movl   $0x801084f5,0x4(%esp)
80100f19:	80 
80100f1a:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100f21:	e8 3c 3e 00 00       	call   80104d62 <initlock>
}
80100f26:	c9                   	leave  
80100f27:	c3                   	ret    

80100f28 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f28:	55                   	push   %ebp
80100f29:	89 e5                	mov    %esp,%ebp
80100f2b:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f2e:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100f35:	e8 49 3e 00 00       	call   80104d83 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f3a:	c7 45 f4 74 08 11 80 	movl   $0x80110874,-0xc(%ebp)
80100f41:	eb 29                	jmp    80100f6c <filealloc+0x44>
    if(f->ref == 0){
80100f43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f46:	8b 40 04             	mov    0x4(%eax),%eax
80100f49:	85 c0                	test   %eax,%eax
80100f4b:	75 1b                	jne    80100f68 <filealloc+0x40>
      f->ref = 1;
80100f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f50:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f57:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100f5e:	e8 82 3e 00 00       	call   80104de5 <release>
      return f;
80100f63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f66:	eb 1e                	jmp    80100f86 <filealloc+0x5e>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f68:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f6c:	81 7d f4 d4 11 11 80 	cmpl   $0x801111d4,-0xc(%ebp)
80100f73:	72 ce                	jb     80100f43 <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f75:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100f7c:	e8 64 3e 00 00       	call   80104de5 <release>
  return 0;
80100f81:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100f86:	c9                   	leave  
80100f87:	c3                   	ret    

80100f88 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f88:	55                   	push   %ebp
80100f89:	89 e5                	mov    %esp,%ebp
80100f8b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
80100f8e:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100f95:	e8 e9 3d 00 00       	call   80104d83 <acquire>
  if(f->ref < 1)
80100f9a:	8b 45 08             	mov    0x8(%ebp),%eax
80100f9d:	8b 40 04             	mov    0x4(%eax),%eax
80100fa0:	85 c0                	test   %eax,%eax
80100fa2:	7f 0c                	jg     80100fb0 <filedup+0x28>
    panic("filedup");
80100fa4:	c7 04 24 fc 84 10 80 	movl   $0x801084fc,(%esp)
80100fab:	e8 8d f5 ff ff       	call   8010053d <panic>
  f->ref++;
80100fb0:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb3:	8b 40 04             	mov    0x4(%eax),%eax
80100fb6:	8d 50 01             	lea    0x1(%eax),%edx
80100fb9:	8b 45 08             	mov    0x8(%ebp),%eax
80100fbc:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fbf:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100fc6:	e8 1a 3e 00 00       	call   80104de5 <release>
  return f;
80100fcb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80100fce:	c9                   	leave  
80100fcf:	c3                   	ret    

80100fd0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
80100fd6:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80100fdd:	e8 a1 3d 00 00       	call   80104d83 <acquire>
  if(f->ref < 1)
80100fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe5:	8b 40 04             	mov    0x4(%eax),%eax
80100fe8:	85 c0                	test   %eax,%eax
80100fea:	7f 0c                	jg     80100ff8 <fileclose+0x28>
    panic("fileclose");
80100fec:	c7 04 24 04 85 10 80 	movl   $0x80108504,(%esp)
80100ff3:	e8 45 f5 ff ff       	call   8010053d <panic>
  if(--f->ref > 0){
80100ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80100ffb:	8b 40 04             	mov    0x4(%eax),%eax
80100ffe:	8d 50 ff             	lea    -0x1(%eax),%edx
80101001:	8b 45 08             	mov    0x8(%ebp),%eax
80101004:	89 50 04             	mov    %edx,0x4(%eax)
80101007:	8b 45 08             	mov    0x8(%ebp),%eax
8010100a:	8b 40 04             	mov    0x4(%eax),%eax
8010100d:	85 c0                	test   %eax,%eax
8010100f:	7e 11                	jle    80101022 <fileclose+0x52>
    release(&ftable.lock);
80101011:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80101018:	e8 c8 3d 00 00       	call   80104de5 <release>
    return;
8010101d:	e9 82 00 00 00       	jmp    801010a4 <fileclose+0xd4>
  }
  ff = *f;
80101022:	8b 45 08             	mov    0x8(%ebp),%eax
80101025:	8b 10                	mov    (%eax),%edx
80101027:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010102a:	8b 50 04             	mov    0x4(%eax),%edx
8010102d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101030:	8b 50 08             	mov    0x8(%eax),%edx
80101033:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101036:	8b 50 0c             	mov    0xc(%eax),%edx
80101039:	89 55 ec             	mov    %edx,-0x14(%ebp)
8010103c:	8b 50 10             	mov    0x10(%eax),%edx
8010103f:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101042:	8b 40 14             	mov    0x14(%eax),%eax
80101045:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101048:	8b 45 08             	mov    0x8(%ebp),%eax
8010104b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101052:	8b 45 08             	mov    0x8(%ebp),%eax
80101055:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
8010105b:	c7 04 24 40 08 11 80 	movl   $0x80110840,(%esp)
80101062:	e8 7e 3d 00 00       	call   80104de5 <release>
  
  if(ff.type == FD_PIPE)
80101067:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010106a:	83 f8 01             	cmp    $0x1,%eax
8010106d:	75 18                	jne    80101087 <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
8010106f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101073:	0f be d0             	movsbl %al,%edx
80101076:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101079:	89 54 24 04          	mov    %edx,0x4(%esp)
8010107d:	89 04 24             	mov    %eax,(%esp)
80101080:	e8 fe 2d 00 00       	call   80103e83 <pipeclose>
80101085:	eb 1d                	jmp    801010a4 <fileclose+0xd4>
  else if(ff.type == FD_INODE){
80101087:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010108a:	83 f8 02             	cmp    $0x2,%eax
8010108d:	75 15                	jne    801010a4 <fileclose+0xd4>
    begin_op();
8010108f:	e8 95 21 00 00       	call   80103229 <begin_op>
    iput(ff.ip);
80101094:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101097:	89 04 24             	mov    %eax,(%esp)
8010109a:	e8 88 09 00 00       	call   80101a27 <iput>
    end_op();
8010109f:	e8 06 22 00 00       	call   801032aa <end_op>
  }
}
801010a4:	c9                   	leave  
801010a5:	c3                   	ret    

801010a6 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010a6:	55                   	push   %ebp
801010a7:	89 e5                	mov    %esp,%ebp
801010a9:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
801010ac:	8b 45 08             	mov    0x8(%ebp),%eax
801010af:	8b 00                	mov    (%eax),%eax
801010b1:	83 f8 02             	cmp    $0x2,%eax
801010b4:	75 38                	jne    801010ee <filestat+0x48>
    ilock(f->ip);
801010b6:	8b 45 08             	mov    0x8(%ebp),%eax
801010b9:	8b 40 10             	mov    0x10(%eax),%eax
801010bc:	89 04 24             	mov    %eax,(%esp)
801010bf:	e8 b0 07 00 00       	call   80101874 <ilock>
    stati(f->ip, st);
801010c4:	8b 45 08             	mov    0x8(%ebp),%eax
801010c7:	8b 40 10             	mov    0x10(%eax),%eax
801010ca:	8b 55 0c             	mov    0xc(%ebp),%edx
801010cd:	89 54 24 04          	mov    %edx,0x4(%esp)
801010d1:	89 04 24             	mov    %eax,(%esp)
801010d4:	e8 4c 0c 00 00       	call   80101d25 <stati>
    iunlock(f->ip);
801010d9:	8b 45 08             	mov    0x8(%ebp),%eax
801010dc:	8b 40 10             	mov    0x10(%eax),%eax
801010df:	89 04 24             	mov    %eax,(%esp)
801010e2:	e8 db 08 00 00       	call   801019c2 <iunlock>
    return 0;
801010e7:	b8 00 00 00 00       	mov    $0x0,%eax
801010ec:	eb 05                	jmp    801010f3 <filestat+0x4d>
  }
  return -1;
801010ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010f3:	c9                   	leave  
801010f4:	c3                   	ret    

801010f5 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010f5:	55                   	push   %ebp
801010f6:	89 e5                	mov    %esp,%ebp
801010f8:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
801010fb:	8b 45 08             	mov    0x8(%ebp),%eax
801010fe:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101102:	84 c0                	test   %al,%al
80101104:	75 0a                	jne    80101110 <fileread+0x1b>
    return -1;
80101106:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010110b:	e9 9f 00 00 00       	jmp    801011af <fileread+0xba>
  if(f->type == FD_PIPE)
80101110:	8b 45 08             	mov    0x8(%ebp),%eax
80101113:	8b 00                	mov    (%eax),%eax
80101115:	83 f8 01             	cmp    $0x1,%eax
80101118:	75 1e                	jne    80101138 <fileread+0x43>
    return piperead(f->pipe, addr, n);
8010111a:	8b 45 08             	mov    0x8(%ebp),%eax
8010111d:	8b 40 0c             	mov    0xc(%eax),%eax
80101120:	8b 55 10             	mov    0x10(%ebp),%edx
80101123:	89 54 24 08          	mov    %edx,0x8(%esp)
80101127:	8b 55 0c             	mov    0xc(%ebp),%edx
8010112a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010112e:	89 04 24             	mov    %eax,(%esp)
80101131:	e8 cf 2e 00 00       	call   80104005 <piperead>
80101136:	eb 77                	jmp    801011af <fileread+0xba>
  if(f->type == FD_INODE){
80101138:	8b 45 08             	mov    0x8(%ebp),%eax
8010113b:	8b 00                	mov    (%eax),%eax
8010113d:	83 f8 02             	cmp    $0x2,%eax
80101140:	75 61                	jne    801011a3 <fileread+0xae>
    ilock(f->ip);
80101142:	8b 45 08             	mov    0x8(%ebp),%eax
80101145:	8b 40 10             	mov    0x10(%eax),%eax
80101148:	89 04 24             	mov    %eax,(%esp)
8010114b:	e8 24 07 00 00       	call   80101874 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101150:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101153:	8b 45 08             	mov    0x8(%ebp),%eax
80101156:	8b 50 14             	mov    0x14(%eax),%edx
80101159:	8b 45 08             	mov    0x8(%ebp),%eax
8010115c:	8b 40 10             	mov    0x10(%eax),%eax
8010115f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101163:	89 54 24 08          	mov    %edx,0x8(%esp)
80101167:	8b 55 0c             	mov    0xc(%ebp),%edx
8010116a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010116e:	89 04 24             	mov    %eax,(%esp)
80101171:	e8 f4 0b 00 00       	call   80101d6a <readi>
80101176:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101179:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010117d:	7e 11                	jle    80101190 <fileread+0x9b>
      f->off += r;
8010117f:	8b 45 08             	mov    0x8(%ebp),%eax
80101182:	8b 50 14             	mov    0x14(%eax),%edx
80101185:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101188:	01 c2                	add    %eax,%edx
8010118a:	8b 45 08             	mov    0x8(%ebp),%eax
8010118d:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101190:	8b 45 08             	mov    0x8(%ebp),%eax
80101193:	8b 40 10             	mov    0x10(%eax),%eax
80101196:	89 04 24             	mov    %eax,(%esp)
80101199:	e8 24 08 00 00       	call   801019c2 <iunlock>
    return r;
8010119e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011a1:	eb 0c                	jmp    801011af <fileread+0xba>
  }
  panic("fileread");
801011a3:	c7 04 24 0e 85 10 80 	movl   $0x8010850e,(%esp)
801011aa:	e8 8e f3 ff ff       	call   8010053d <panic>
}
801011af:	c9                   	leave  
801011b0:	c3                   	ret    

801011b1 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011b1:	55                   	push   %ebp
801011b2:	89 e5                	mov    %esp,%ebp
801011b4:	53                   	push   %ebx
801011b5:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
801011b8:	8b 45 08             	mov    0x8(%ebp),%eax
801011bb:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801011bf:	84 c0                	test   %al,%al
801011c1:	75 0a                	jne    801011cd <filewrite+0x1c>
    return -1;
801011c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011c8:	e9 23 01 00 00       	jmp    801012f0 <filewrite+0x13f>
  if(f->type == FD_PIPE)
801011cd:	8b 45 08             	mov    0x8(%ebp),%eax
801011d0:	8b 00                	mov    (%eax),%eax
801011d2:	83 f8 01             	cmp    $0x1,%eax
801011d5:	75 21                	jne    801011f8 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
801011d7:	8b 45 08             	mov    0x8(%ebp),%eax
801011da:	8b 40 0c             	mov    0xc(%eax),%eax
801011dd:	8b 55 10             	mov    0x10(%ebp),%edx
801011e0:	89 54 24 08          	mov    %edx,0x8(%esp)
801011e4:	8b 55 0c             	mov    0xc(%ebp),%edx
801011e7:	89 54 24 04          	mov    %edx,0x4(%esp)
801011eb:	89 04 24             	mov    %eax,(%esp)
801011ee:	e8 22 2d 00 00       	call   80103f15 <pipewrite>
801011f3:	e9 f8 00 00 00       	jmp    801012f0 <filewrite+0x13f>
  if(f->type == FD_INODE){
801011f8:	8b 45 08             	mov    0x8(%ebp),%eax
801011fb:	8b 00                	mov    (%eax),%eax
801011fd:	83 f8 02             	cmp    $0x2,%eax
80101200:	0f 85 de 00 00 00    	jne    801012e4 <filewrite+0x133>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101206:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
8010120d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101214:	e9 a8 00 00 00       	jmp    801012c1 <filewrite+0x110>
      int n1 = n - i;
80101219:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010121c:	8b 55 10             	mov    0x10(%ebp),%edx
8010121f:	89 d1                	mov    %edx,%ecx
80101221:	29 c1                	sub    %eax,%ecx
80101223:	89 c8                	mov    %ecx,%eax
80101225:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101228:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010122b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010122e:	7e 06                	jle    80101236 <filewrite+0x85>
        n1 = max;
80101230:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101233:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
80101236:	e8 ee 1f 00 00       	call   80103229 <begin_op>
      ilock(f->ip);
8010123b:	8b 45 08             	mov    0x8(%ebp),%eax
8010123e:	8b 40 10             	mov    0x10(%eax),%eax
80101241:	89 04 24             	mov    %eax,(%esp)
80101244:	e8 2b 06 00 00       	call   80101874 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101249:	8b 5d f0             	mov    -0x10(%ebp),%ebx
8010124c:	8b 45 08             	mov    0x8(%ebp),%eax
8010124f:	8b 48 14             	mov    0x14(%eax),%ecx
80101252:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101255:	89 c2                	mov    %eax,%edx
80101257:	03 55 0c             	add    0xc(%ebp),%edx
8010125a:	8b 45 08             	mov    0x8(%ebp),%eax
8010125d:	8b 40 10             	mov    0x10(%eax),%eax
80101260:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80101264:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101268:	89 54 24 04          	mov    %edx,0x4(%esp)
8010126c:	89 04 24             	mov    %eax,(%esp)
8010126f:	e8 61 0c 00 00       	call   80101ed5 <writei>
80101274:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101277:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010127b:	7e 11                	jle    8010128e <filewrite+0xdd>
        f->off += r;
8010127d:	8b 45 08             	mov    0x8(%ebp),%eax
80101280:	8b 50 14             	mov    0x14(%eax),%edx
80101283:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101286:	01 c2                	add    %eax,%edx
80101288:	8b 45 08             	mov    0x8(%ebp),%eax
8010128b:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
8010128e:	8b 45 08             	mov    0x8(%ebp),%eax
80101291:	8b 40 10             	mov    0x10(%eax),%eax
80101294:	89 04 24             	mov    %eax,(%esp)
80101297:	e8 26 07 00 00       	call   801019c2 <iunlock>
      end_op();
8010129c:	e8 09 20 00 00       	call   801032aa <end_op>

      if(r < 0)
801012a1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012a5:	78 28                	js     801012cf <filewrite+0x11e>
        break;
      if(r != n1)
801012a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801012ad:	74 0c                	je     801012bb <filewrite+0x10a>
        panic("short filewrite");
801012af:	c7 04 24 17 85 10 80 	movl   $0x80108517,(%esp)
801012b6:	e8 82 f2 ff ff       	call   8010053d <panic>
      i += r;
801012bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012be:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012c4:	3b 45 10             	cmp    0x10(%ebp),%eax
801012c7:	0f 8c 4c ff ff ff    	jl     80101219 <filewrite+0x68>
801012cd:	eb 01                	jmp    801012d0 <filewrite+0x11f>
        f->off += r;
      iunlock(f->ip);
      end_op();

      if(r < 0)
        break;
801012cf:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012d3:	3b 45 10             	cmp    0x10(%ebp),%eax
801012d6:	75 05                	jne    801012dd <filewrite+0x12c>
801012d8:	8b 45 10             	mov    0x10(%ebp),%eax
801012db:	eb 05                	jmp    801012e2 <filewrite+0x131>
801012dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012e2:	eb 0c                	jmp    801012f0 <filewrite+0x13f>
  }
  panic("filewrite");
801012e4:	c7 04 24 27 85 10 80 	movl   $0x80108527,(%esp)
801012eb:	e8 4d f2 ff ff       	call   8010053d <panic>
}
801012f0:	83 c4 24             	add    $0x24,%esp
801012f3:	5b                   	pop    %ebx
801012f4:	5d                   	pop    %ebp
801012f5:	c3                   	ret    
	...

801012f8 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801012f8:	55                   	push   %ebp
801012f9:	89 e5                	mov    %esp,%ebp
801012fb:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801012fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101301:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101308:	00 
80101309:	89 04 24             	mov    %eax,(%esp)
8010130c:	e8 95 ee ff ff       	call   801001a6 <bread>
80101311:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101314:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101317:	83 c0 18             	add    $0x18,%eax
8010131a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80101321:	00 
80101322:	89 44 24 04          	mov    %eax,0x4(%esp)
80101326:	8b 45 0c             	mov    0xc(%ebp),%eax
80101329:	89 04 24             	mov    %eax,(%esp)
8010132c:	e8 74 3d 00 00       	call   801050a5 <memmove>
  brelse(bp);
80101331:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101334:	89 04 24             	mov    %eax,(%esp)
80101337:	e8 db ee ff ff       	call   80100217 <brelse>
}
8010133c:	c9                   	leave  
8010133d:	c3                   	ret    

8010133e <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010133e:	55                   	push   %ebp
8010133f:	89 e5                	mov    %esp,%ebp
80101341:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101344:	8b 55 0c             	mov    0xc(%ebp),%edx
80101347:	8b 45 08             	mov    0x8(%ebp),%eax
8010134a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010134e:	89 04 24             	mov    %eax,(%esp)
80101351:	e8 50 ee ff ff       	call   801001a6 <bread>
80101356:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101359:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010135c:	83 c0 18             	add    $0x18,%eax
8010135f:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101366:	00 
80101367:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010136e:	00 
8010136f:	89 04 24             	mov    %eax,(%esp)
80101372:	e8 5b 3c 00 00       	call   80104fd2 <memset>
  log_write(bp);
80101377:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010137a:	89 04 24             	mov    %eax,(%esp)
8010137d:	e8 ac 20 00 00       	call   8010342e <log_write>
  brelse(bp);
80101382:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101385:	89 04 24             	mov    %eax,(%esp)
80101388:	e8 8a ee ff ff       	call   80100217 <brelse>
}
8010138d:	c9                   	leave  
8010138e:	c3                   	ret    

8010138f <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010138f:	55                   	push   %ebp
80101390:	89 e5                	mov    %esp,%ebp
80101392:	53                   	push   %ebx
80101393:	83 ec 34             	sub    $0x34,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
80101396:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
8010139d:	8b 45 08             	mov    0x8(%ebp),%eax
801013a0:	8d 55 d8             	lea    -0x28(%ebp),%edx
801013a3:	89 54 24 04          	mov    %edx,0x4(%esp)
801013a7:	89 04 24             	mov    %eax,(%esp)
801013aa:	e8 49 ff ff ff       	call   801012f8 <readsb>
  for(b = 0; b < sb.size; b += BPB){
801013af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013b6:	e9 11 01 00 00       	jmp    801014cc <balloc+0x13d>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801013bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013be:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801013c4:	85 c0                	test   %eax,%eax
801013c6:	0f 48 c2             	cmovs  %edx,%eax
801013c9:	c1 f8 0c             	sar    $0xc,%eax
801013cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801013cf:	c1 ea 03             	shr    $0x3,%edx
801013d2:	01 d0                	add    %edx,%eax
801013d4:	83 c0 03             	add    $0x3,%eax
801013d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801013db:	8b 45 08             	mov    0x8(%ebp),%eax
801013de:	89 04 24             	mov    %eax,(%esp)
801013e1:	e8 c0 ed ff ff       	call   801001a6 <bread>
801013e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801013f0:	e9 a7 00 00 00       	jmp    8010149c <balloc+0x10d>
      m = 1 << (bi % 8);
801013f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801013f8:	89 c2                	mov    %eax,%edx
801013fa:	c1 fa 1f             	sar    $0x1f,%edx
801013fd:	c1 ea 1d             	shr    $0x1d,%edx
80101400:	01 d0                	add    %edx,%eax
80101402:	83 e0 07             	and    $0x7,%eax
80101405:	29 d0                	sub    %edx,%eax
80101407:	ba 01 00 00 00       	mov    $0x1,%edx
8010140c:	89 d3                	mov    %edx,%ebx
8010140e:	89 c1                	mov    %eax,%ecx
80101410:	d3 e3                	shl    %cl,%ebx
80101412:	89 d8                	mov    %ebx,%eax
80101414:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101417:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010141a:	8d 50 07             	lea    0x7(%eax),%edx
8010141d:	85 c0                	test   %eax,%eax
8010141f:	0f 48 c2             	cmovs  %edx,%eax
80101422:	c1 f8 03             	sar    $0x3,%eax
80101425:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101428:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
8010142d:	0f b6 c0             	movzbl %al,%eax
80101430:	23 45 e8             	and    -0x18(%ebp),%eax
80101433:	85 c0                	test   %eax,%eax
80101435:	75 61                	jne    80101498 <balloc+0x109>
        bp->data[bi/8] |= m;  // Mark block in use.
80101437:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010143a:	8d 50 07             	lea    0x7(%eax),%edx
8010143d:	85 c0                	test   %eax,%eax
8010143f:	0f 48 c2             	cmovs  %edx,%eax
80101442:	c1 f8 03             	sar    $0x3,%eax
80101445:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101448:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
8010144d:	89 d1                	mov    %edx,%ecx
8010144f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101452:	09 ca                	or     %ecx,%edx
80101454:	89 d1                	mov    %edx,%ecx
80101456:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101459:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
8010145d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101460:	89 04 24             	mov    %eax,(%esp)
80101463:	e8 c6 1f 00 00       	call   8010342e <log_write>
        brelse(bp);
80101468:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010146b:	89 04 24             	mov    %eax,(%esp)
8010146e:	e8 a4 ed ff ff       	call   80100217 <brelse>
        bzero(dev, b + bi);
80101473:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101476:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101479:	01 c2                	add    %eax,%edx
8010147b:	8b 45 08             	mov    0x8(%ebp),%eax
8010147e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101482:	89 04 24             	mov    %eax,(%esp)
80101485:	e8 b4 fe ff ff       	call   8010133e <bzero>
        return b + bi;
8010148a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010148d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101490:	01 d0                	add    %edx,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101492:	83 c4 34             	add    $0x34,%esp
80101495:	5b                   	pop    %ebx
80101496:	5d                   	pop    %ebp
80101497:	c3                   	ret    

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101498:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010149c:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014a3:	7f 15                	jg     801014ba <balloc+0x12b>
801014a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ab:	01 d0                	add    %edx,%eax
801014ad:	89 c2                	mov    %eax,%edx
801014af:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014b2:	39 c2                	cmp    %eax,%edx
801014b4:	0f 82 3b ff ff ff    	jb     801013f5 <balloc+0x66>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014bd:	89 04 24             	mov    %eax,(%esp)
801014c0:	e8 52 ed ff ff       	call   80100217 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
801014c5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801014cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014cf:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014d2:	39 c2                	cmp    %eax,%edx
801014d4:	0f 82 e1 fe ff ff    	jb     801013bb <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801014da:	c7 04 24 31 85 10 80 	movl   $0x80108531,(%esp)
801014e1:	e8 57 f0 ff ff       	call   8010053d <panic>

801014e6 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014e6:	55                   	push   %ebp
801014e7:	89 e5                	mov    %esp,%ebp
801014e9:	53                   	push   %ebx
801014ea:	83 ec 34             	sub    $0x34,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
801014ed:	8d 45 dc             	lea    -0x24(%ebp),%eax
801014f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801014f4:	8b 45 08             	mov    0x8(%ebp),%eax
801014f7:	89 04 24             	mov    %eax,(%esp)
801014fa:	e8 f9 fd ff ff       	call   801012f8 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
801014ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80101502:	89 c2                	mov    %eax,%edx
80101504:	c1 ea 0c             	shr    $0xc,%edx
80101507:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010150a:	c1 e8 03             	shr    $0x3,%eax
8010150d:	01 d0                	add    %edx,%eax
8010150f:	8d 50 03             	lea    0x3(%eax),%edx
80101512:	8b 45 08             	mov    0x8(%ebp),%eax
80101515:	89 54 24 04          	mov    %edx,0x4(%esp)
80101519:	89 04 24             	mov    %eax,(%esp)
8010151c:	e8 85 ec ff ff       	call   801001a6 <bread>
80101521:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101524:	8b 45 0c             	mov    0xc(%ebp),%eax
80101527:	25 ff 0f 00 00       	and    $0xfff,%eax
8010152c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010152f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101532:	89 c2                	mov    %eax,%edx
80101534:	c1 fa 1f             	sar    $0x1f,%edx
80101537:	c1 ea 1d             	shr    $0x1d,%edx
8010153a:	01 d0                	add    %edx,%eax
8010153c:	83 e0 07             	and    $0x7,%eax
8010153f:	29 d0                	sub    %edx,%eax
80101541:	ba 01 00 00 00       	mov    $0x1,%edx
80101546:	89 d3                	mov    %edx,%ebx
80101548:	89 c1                	mov    %eax,%ecx
8010154a:	d3 e3                	shl    %cl,%ebx
8010154c:	89 d8                	mov    %ebx,%eax
8010154e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101551:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101554:	8d 50 07             	lea    0x7(%eax),%edx
80101557:	85 c0                	test   %eax,%eax
80101559:	0f 48 c2             	cmovs  %edx,%eax
8010155c:	c1 f8 03             	sar    $0x3,%eax
8010155f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101562:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101567:	0f b6 c0             	movzbl %al,%eax
8010156a:	23 45 ec             	and    -0x14(%ebp),%eax
8010156d:	85 c0                	test   %eax,%eax
8010156f:	75 0c                	jne    8010157d <bfree+0x97>
    panic("freeing free block");
80101571:	c7 04 24 47 85 10 80 	movl   $0x80108547,(%esp)
80101578:	e8 c0 ef ff ff       	call   8010053d <panic>
  bp->data[bi/8] &= ~m;
8010157d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101580:	8d 50 07             	lea    0x7(%eax),%edx
80101583:	85 c0                	test   %eax,%eax
80101585:	0f 48 c2             	cmovs  %edx,%eax
80101588:	c1 f8 03             	sar    $0x3,%eax
8010158b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010158e:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101593:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80101596:	f7 d1                	not    %ecx
80101598:	21 ca                	and    %ecx,%edx
8010159a:	89 d1                	mov    %edx,%ecx
8010159c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010159f:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801015a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015a6:	89 04 24             	mov    %eax,(%esp)
801015a9:	e8 80 1e 00 00       	call   8010342e <log_write>
  brelse(bp);
801015ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015b1:	89 04 24             	mov    %eax,(%esp)
801015b4:	e8 5e ec ff ff       	call   80100217 <brelse>
}
801015b9:	83 c4 34             	add    $0x34,%esp
801015bc:	5b                   	pop    %ebx
801015bd:	5d                   	pop    %ebp
801015be:	c3                   	ret    

801015bf <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
801015bf:	55                   	push   %ebp
801015c0:	89 e5                	mov    %esp,%ebp
801015c2:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
801015c5:	c7 44 24 04 5a 85 10 	movl   $0x8010855a,0x4(%esp)
801015cc:	80 
801015cd:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
801015d4:	e8 89 37 00 00       	call   80104d62 <initlock>
}
801015d9:	c9                   	leave  
801015da:	c3                   	ret    

801015db <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801015db:	55                   	push   %ebp
801015dc:	89 e5                	mov    %esp,%ebp
801015de:	83 ec 48             	sub    $0x48,%esp
801015e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801015e4:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
801015e8:	8b 45 08             	mov    0x8(%ebp),%eax
801015eb:	8d 55 dc             	lea    -0x24(%ebp),%edx
801015ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801015f2:	89 04 24             	mov    %eax,(%esp)
801015f5:	e8 fe fc ff ff       	call   801012f8 <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
801015fa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101601:	e9 98 00 00 00       	jmp    8010169e <ialloc+0xc3>
    bp = bread(dev, IBLOCK(inum));
80101606:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101609:	c1 e8 03             	shr    $0x3,%eax
8010160c:	83 c0 02             	add    $0x2,%eax
8010160f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101613:	8b 45 08             	mov    0x8(%ebp),%eax
80101616:	89 04 24             	mov    %eax,(%esp)
80101619:	e8 88 eb ff ff       	call   801001a6 <bread>
8010161e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101621:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101624:	8d 50 18             	lea    0x18(%eax),%edx
80101627:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010162a:	83 e0 07             	and    $0x7,%eax
8010162d:	c1 e0 06             	shl    $0x6,%eax
80101630:	01 d0                	add    %edx,%eax
80101632:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101635:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101638:	0f b7 00             	movzwl (%eax),%eax
8010163b:	66 85 c0             	test   %ax,%ax
8010163e:	75 4f                	jne    8010168f <ialloc+0xb4>
      memset(dip, 0, sizeof(*dip));
80101640:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101647:	00 
80101648:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010164f:	00 
80101650:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101653:	89 04 24             	mov    %eax,(%esp)
80101656:	e8 77 39 00 00       	call   80104fd2 <memset>
      dip->type = type;
8010165b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010165e:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101662:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101665:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101668:	89 04 24             	mov    %eax,(%esp)
8010166b:	e8 be 1d 00 00       	call   8010342e <log_write>
      brelse(bp);
80101670:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101673:	89 04 24             	mov    %eax,(%esp)
80101676:	e8 9c eb ff ff       	call   80100217 <brelse>
      return iget(dev, inum);
8010167b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010167e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101682:	8b 45 08             	mov    0x8(%ebp),%eax
80101685:	89 04 24             	mov    %eax,(%esp)
80101688:	e8 e3 00 00 00       	call   80101770 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
8010168d:	c9                   	leave  
8010168e:	c3                   	ret    
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
8010168f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101692:	89 04 24             	mov    %eax,(%esp)
80101695:	e8 7d eb ff ff       	call   80100217 <brelse>
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
8010169a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010169e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801016a4:	39 c2                	cmp    %eax,%edx
801016a6:	0f 82 5a ff ff ff    	jb     80101606 <ialloc+0x2b>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016ac:	c7 04 24 61 85 10 80 	movl   $0x80108561,(%esp)
801016b3:	e8 85 ee ff ff       	call   8010053d <panic>

801016b8 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801016b8:	55                   	push   %ebp
801016b9:	89 e5                	mov    %esp,%ebp
801016bb:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
801016be:	8b 45 08             	mov    0x8(%ebp),%eax
801016c1:	8b 40 04             	mov    0x4(%eax),%eax
801016c4:	c1 e8 03             	shr    $0x3,%eax
801016c7:	8d 50 02             	lea    0x2(%eax),%edx
801016ca:	8b 45 08             	mov    0x8(%ebp),%eax
801016cd:	8b 00                	mov    (%eax),%eax
801016cf:	89 54 24 04          	mov    %edx,0x4(%esp)
801016d3:	89 04 24             	mov    %eax,(%esp)
801016d6:	e8 cb ea ff ff       	call   801001a6 <bread>
801016db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016e1:	8d 50 18             	lea    0x18(%eax),%edx
801016e4:	8b 45 08             	mov    0x8(%ebp),%eax
801016e7:	8b 40 04             	mov    0x4(%eax),%eax
801016ea:	83 e0 07             	and    $0x7,%eax
801016ed:	c1 e0 06             	shl    $0x6,%eax
801016f0:	01 d0                	add    %edx,%eax
801016f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801016f5:	8b 45 08             	mov    0x8(%ebp),%eax
801016f8:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801016fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016ff:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101702:	8b 45 08             	mov    0x8(%ebp),%eax
80101705:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101709:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010170c:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101710:	8b 45 08             	mov    0x8(%ebp),%eax
80101713:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101717:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010171a:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010171e:	8b 45 08             	mov    0x8(%ebp),%eax
80101721:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101725:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101728:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010172c:	8b 45 08             	mov    0x8(%ebp),%eax
8010172f:	8b 50 18             	mov    0x18(%eax),%edx
80101732:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101735:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101738:	8b 45 08             	mov    0x8(%ebp),%eax
8010173b:	8d 50 1c             	lea    0x1c(%eax),%edx
8010173e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101741:	83 c0 0c             	add    $0xc,%eax
80101744:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010174b:	00 
8010174c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101750:	89 04 24             	mov    %eax,(%esp)
80101753:	e8 4d 39 00 00       	call   801050a5 <memmove>
  log_write(bp);
80101758:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010175b:	89 04 24             	mov    %eax,(%esp)
8010175e:	e8 cb 1c 00 00       	call   8010342e <log_write>
  brelse(bp);
80101763:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101766:	89 04 24             	mov    %eax,(%esp)
80101769:	e8 a9 ea ff ff       	call   80100217 <brelse>
}
8010176e:	c9                   	leave  
8010176f:	c3                   	ret    

80101770 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101776:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010177d:	e8 01 36 00 00       	call   80104d83 <acquire>

  // Is the inode already cached?
  empty = 0;
80101782:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101789:	c7 45 f4 74 12 11 80 	movl   $0x80111274,-0xc(%ebp)
80101790:	eb 59                	jmp    801017eb <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101792:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101795:	8b 40 08             	mov    0x8(%eax),%eax
80101798:	85 c0                	test   %eax,%eax
8010179a:	7e 35                	jle    801017d1 <iget+0x61>
8010179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010179f:	8b 00                	mov    (%eax),%eax
801017a1:	3b 45 08             	cmp    0x8(%ebp),%eax
801017a4:	75 2b                	jne    801017d1 <iget+0x61>
801017a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017a9:	8b 40 04             	mov    0x4(%eax),%eax
801017ac:	3b 45 0c             	cmp    0xc(%ebp),%eax
801017af:	75 20                	jne    801017d1 <iget+0x61>
      ip->ref++;
801017b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017b4:	8b 40 08             	mov    0x8(%eax),%eax
801017b7:	8d 50 01             	lea    0x1(%eax),%edx
801017ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017bd:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801017c0:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
801017c7:	e8 19 36 00 00       	call   80104de5 <release>
      return ip;
801017cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017cf:	eb 6f                	jmp    80101840 <iget+0xd0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801017d1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801017d5:	75 10                	jne    801017e7 <iget+0x77>
801017d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017da:	8b 40 08             	mov    0x8(%eax),%eax
801017dd:	85 c0                	test   %eax,%eax
801017df:	75 06                	jne    801017e7 <iget+0x77>
      empty = ip;
801017e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017e4:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017e7:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
801017eb:	81 7d f4 14 22 11 80 	cmpl   $0x80112214,-0xc(%ebp)
801017f2:	72 9e                	jb     80101792 <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801017f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801017f8:	75 0c                	jne    80101806 <iget+0x96>
    panic("iget: no inodes");
801017fa:	c7 04 24 73 85 10 80 	movl   $0x80108573,(%esp)
80101801:	e8 37 ed ff ff       	call   8010053d <panic>

  ip = empty;
80101806:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101809:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
8010180c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010180f:	8b 55 08             	mov    0x8(%ebp),%edx
80101812:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101814:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101817:	8b 55 0c             	mov    0xc(%ebp),%edx
8010181a:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
8010181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101820:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101827:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010182a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101831:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101838:	e8 a8 35 00 00       	call   80104de5 <release>

  return ip;
8010183d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101840:	c9                   	leave  
80101841:	c3                   	ret    

80101842 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101842:	55                   	push   %ebp
80101843:	89 e5                	mov    %esp,%ebp
80101845:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101848:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010184f:	e8 2f 35 00 00       	call   80104d83 <acquire>
  ip->ref++;
80101854:	8b 45 08             	mov    0x8(%ebp),%eax
80101857:	8b 40 08             	mov    0x8(%eax),%eax
8010185a:	8d 50 01             	lea    0x1(%eax),%edx
8010185d:	8b 45 08             	mov    0x8(%ebp),%eax
80101860:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101863:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010186a:	e8 76 35 00 00       	call   80104de5 <release>
  return ip;
8010186f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101872:	c9                   	leave  
80101873:	c3                   	ret    

80101874 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101874:	55                   	push   %ebp
80101875:	89 e5                	mov    %esp,%ebp
80101877:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010187a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010187e:	74 0a                	je     8010188a <ilock+0x16>
80101880:	8b 45 08             	mov    0x8(%ebp),%eax
80101883:	8b 40 08             	mov    0x8(%eax),%eax
80101886:	85 c0                	test   %eax,%eax
80101888:	7f 0c                	jg     80101896 <ilock+0x22>
    panic("ilock");
8010188a:	c7 04 24 83 85 10 80 	movl   $0x80108583,(%esp)
80101891:	e8 a7 ec ff ff       	call   8010053d <panic>

  acquire(&icache.lock);
80101896:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
8010189d:	e8 e1 34 00 00       	call   80104d83 <acquire>
  while(ip->flags & I_BUSY)
801018a2:	eb 13                	jmp    801018b7 <ilock+0x43>
    sleep(ip, &icache.lock);
801018a4:	c7 44 24 04 40 12 11 	movl   $0x80111240,0x4(%esp)
801018ab:	80 
801018ac:	8b 45 08             	mov    0x8(%ebp),%eax
801018af:	89 04 24             	mov    %eax,(%esp)
801018b2:	e8 e4 31 00 00       	call   80104a9b <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
801018b7:	8b 45 08             	mov    0x8(%ebp),%eax
801018ba:	8b 40 0c             	mov    0xc(%eax),%eax
801018bd:	83 e0 01             	and    $0x1,%eax
801018c0:	84 c0                	test   %al,%al
801018c2:	75 e0                	jne    801018a4 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801018c4:	8b 45 08             	mov    0x8(%ebp),%eax
801018c7:	8b 40 0c             	mov    0xc(%eax),%eax
801018ca:	89 c2                	mov    %eax,%edx
801018cc:	83 ca 01             	or     $0x1,%edx
801018cf:	8b 45 08             	mov    0x8(%ebp),%eax
801018d2:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801018d5:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
801018dc:	e8 04 35 00 00       	call   80104de5 <release>

  if(!(ip->flags & I_VALID)){
801018e1:	8b 45 08             	mov    0x8(%ebp),%eax
801018e4:	8b 40 0c             	mov    0xc(%eax),%eax
801018e7:	83 e0 02             	and    $0x2,%eax
801018ea:	85 c0                	test   %eax,%eax
801018ec:	0f 85 ce 00 00 00    	jne    801019c0 <ilock+0x14c>
    bp = bread(ip->dev, IBLOCK(ip->inum));
801018f2:	8b 45 08             	mov    0x8(%ebp),%eax
801018f5:	8b 40 04             	mov    0x4(%eax),%eax
801018f8:	c1 e8 03             	shr    $0x3,%eax
801018fb:	8d 50 02             	lea    0x2(%eax),%edx
801018fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101901:	8b 00                	mov    (%eax),%eax
80101903:	89 54 24 04          	mov    %edx,0x4(%esp)
80101907:	89 04 24             	mov    %eax,(%esp)
8010190a:	e8 97 e8 ff ff       	call   801001a6 <bread>
8010190f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101912:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101915:	8d 50 18             	lea    0x18(%eax),%edx
80101918:	8b 45 08             	mov    0x8(%ebp),%eax
8010191b:	8b 40 04             	mov    0x4(%eax),%eax
8010191e:	83 e0 07             	and    $0x7,%eax
80101921:	c1 e0 06             	shl    $0x6,%eax
80101924:	01 d0                	add    %edx,%eax
80101926:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101929:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010192c:	0f b7 10             	movzwl (%eax),%edx
8010192f:	8b 45 08             	mov    0x8(%ebp),%eax
80101932:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101936:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101939:	0f b7 50 02          	movzwl 0x2(%eax),%edx
8010193d:	8b 45 08             	mov    0x8(%ebp),%eax
80101940:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101944:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101947:	0f b7 50 04          	movzwl 0x4(%eax),%edx
8010194b:	8b 45 08             	mov    0x8(%ebp),%eax
8010194e:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101952:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101955:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101959:	8b 45 08             	mov    0x8(%ebp),%eax
8010195c:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101960:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101963:	8b 50 08             	mov    0x8(%eax),%edx
80101966:	8b 45 08             	mov    0x8(%ebp),%eax
80101969:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010196c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010196f:	8d 50 0c             	lea    0xc(%eax),%edx
80101972:	8b 45 08             	mov    0x8(%ebp),%eax
80101975:	83 c0 1c             	add    $0x1c,%eax
80101978:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010197f:	00 
80101980:	89 54 24 04          	mov    %edx,0x4(%esp)
80101984:	89 04 24             	mov    %eax,(%esp)
80101987:	e8 19 37 00 00       	call   801050a5 <memmove>
    brelse(bp);
8010198c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010198f:	89 04 24             	mov    %eax,(%esp)
80101992:	e8 80 e8 ff ff       	call   80100217 <brelse>
    ip->flags |= I_VALID;
80101997:	8b 45 08             	mov    0x8(%ebp),%eax
8010199a:	8b 40 0c             	mov    0xc(%eax),%eax
8010199d:	89 c2                	mov    %eax,%edx
8010199f:	83 ca 02             	or     $0x2,%edx
801019a2:	8b 45 08             	mov    0x8(%ebp),%eax
801019a5:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
801019a8:	8b 45 08             	mov    0x8(%ebp),%eax
801019ab:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801019af:	66 85 c0             	test   %ax,%ax
801019b2:	75 0c                	jne    801019c0 <ilock+0x14c>
      panic("ilock: no type");
801019b4:	c7 04 24 89 85 10 80 	movl   $0x80108589,(%esp)
801019bb:	e8 7d eb ff ff       	call   8010053d <panic>
  }
}
801019c0:	c9                   	leave  
801019c1:	c3                   	ret    

801019c2 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801019c2:	55                   	push   %ebp
801019c3:	89 e5                	mov    %esp,%ebp
801019c5:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
801019c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801019cc:	74 17                	je     801019e5 <iunlock+0x23>
801019ce:	8b 45 08             	mov    0x8(%ebp),%eax
801019d1:	8b 40 0c             	mov    0xc(%eax),%eax
801019d4:	83 e0 01             	and    $0x1,%eax
801019d7:	85 c0                	test   %eax,%eax
801019d9:	74 0a                	je     801019e5 <iunlock+0x23>
801019db:	8b 45 08             	mov    0x8(%ebp),%eax
801019de:	8b 40 08             	mov    0x8(%eax),%eax
801019e1:	85 c0                	test   %eax,%eax
801019e3:	7f 0c                	jg     801019f1 <iunlock+0x2f>
    panic("iunlock");
801019e5:	c7 04 24 98 85 10 80 	movl   $0x80108598,(%esp)
801019ec:	e8 4c eb ff ff       	call   8010053d <panic>

  acquire(&icache.lock);
801019f1:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
801019f8:	e8 86 33 00 00       	call   80104d83 <acquire>
  ip->flags &= ~I_BUSY;
801019fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101a00:	8b 40 0c             	mov    0xc(%eax),%eax
80101a03:	89 c2                	mov    %eax,%edx
80101a05:	83 e2 fe             	and    $0xfffffffe,%edx
80101a08:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0b:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101a0e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a11:	89 04 24             	mov    %eax,(%esp)
80101a14:	e8 5e 31 00 00       	call   80104b77 <wakeup>
  release(&icache.lock);
80101a19:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101a20:	e8 c0 33 00 00       	call   80104de5 <release>
}
80101a25:	c9                   	leave  
80101a26:	c3                   	ret    

80101a27 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101a27:	55                   	push   %ebp
80101a28:	89 e5                	mov    %esp,%ebp
80101a2a:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101a2d:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101a34:	e8 4a 33 00 00       	call   80104d83 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101a39:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3c:	8b 40 08             	mov    0x8(%eax),%eax
80101a3f:	83 f8 01             	cmp    $0x1,%eax
80101a42:	0f 85 93 00 00 00    	jne    80101adb <iput+0xb4>
80101a48:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4b:	8b 40 0c             	mov    0xc(%eax),%eax
80101a4e:	83 e0 02             	and    $0x2,%eax
80101a51:	85 c0                	test   %eax,%eax
80101a53:	0f 84 82 00 00 00    	je     80101adb <iput+0xb4>
80101a59:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101a60:	66 85 c0             	test   %ax,%ax
80101a63:	75 76                	jne    80101adb <iput+0xb4>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101a65:	8b 45 08             	mov    0x8(%ebp),%eax
80101a68:	8b 40 0c             	mov    0xc(%eax),%eax
80101a6b:	83 e0 01             	and    $0x1,%eax
80101a6e:	84 c0                	test   %al,%al
80101a70:	74 0c                	je     80101a7e <iput+0x57>
      panic("iput busy");
80101a72:	c7 04 24 a0 85 10 80 	movl   $0x801085a0,(%esp)
80101a79:	e8 bf ea ff ff       	call   8010053d <panic>
    ip->flags |= I_BUSY;
80101a7e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a81:	8b 40 0c             	mov    0xc(%eax),%eax
80101a84:	89 c2                	mov    %eax,%edx
80101a86:	83 ca 01             	or     $0x1,%edx
80101a89:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8c:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101a8f:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101a96:	e8 4a 33 00 00       	call   80104de5 <release>
    itrunc(ip);
80101a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9e:	89 04 24             	mov    %eax,(%esp)
80101aa1:	e8 72 01 00 00       	call   80101c18 <itrunc>
    ip->type = 0;
80101aa6:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa9:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101aaf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab2:	89 04 24             	mov    %eax,(%esp)
80101ab5:	e8 fe fb ff ff       	call   801016b8 <iupdate>
    acquire(&icache.lock);
80101aba:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101ac1:	e8 bd 32 00 00       	call   80104d83 <acquire>
    ip->flags = 0;
80101ac6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101ad0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad3:	89 04 24             	mov    %eax,(%esp)
80101ad6:	e8 9c 30 00 00       	call   80104b77 <wakeup>
  }
  ip->ref--;
80101adb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ade:	8b 40 08             	mov    0x8(%eax),%eax
80101ae1:	8d 50 ff             	lea    -0x1(%eax),%edx
80101ae4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae7:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101aea:	c7 04 24 40 12 11 80 	movl   $0x80111240,(%esp)
80101af1:	e8 ef 32 00 00       	call   80104de5 <release>
}
80101af6:	c9                   	leave  
80101af7:	c3                   	ret    

80101af8 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101af8:	55                   	push   %ebp
80101af9:	89 e5                	mov    %esp,%ebp
80101afb:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101afe:	8b 45 08             	mov    0x8(%ebp),%eax
80101b01:	89 04 24             	mov    %eax,(%esp)
80101b04:	e8 b9 fe ff ff       	call   801019c2 <iunlock>
  iput(ip);
80101b09:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0c:	89 04 24             	mov    %eax,(%esp)
80101b0f:	e8 13 ff ff ff       	call   80101a27 <iput>
}
80101b14:	c9                   	leave  
80101b15:	c3                   	ret    

80101b16 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101b16:	55                   	push   %ebp
80101b17:	89 e5                	mov    %esp,%ebp
80101b19:	53                   	push   %ebx
80101b1a:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101b1d:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101b21:	77 3e                	ja     80101b61 <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101b23:	8b 45 08             	mov    0x8(%ebp),%eax
80101b26:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b29:	83 c2 04             	add    $0x4,%edx
80101b2c:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101b30:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b33:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101b37:	75 20                	jne    80101b59 <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101b39:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3c:	8b 00                	mov    (%eax),%eax
80101b3e:	89 04 24             	mov    %eax,(%esp)
80101b41:	e8 49 f8 ff ff       	call   8010138f <balloc>
80101b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b49:	8b 45 08             	mov    0x8(%ebp),%eax
80101b4c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b4f:	8d 4a 04             	lea    0x4(%edx),%ecx
80101b52:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b55:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b5c:	e9 b1 00 00 00       	jmp    80101c12 <bmap+0xfc>
  }
  bn -= NDIRECT;
80101b61:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101b65:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101b69:	0f 87 97 00 00 00    	ja     80101c06 <bmap+0xf0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101b6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b72:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b75:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101b7c:	75 19                	jne    80101b97 <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101b7e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b81:	8b 00                	mov    (%eax),%eax
80101b83:	89 04 24             	mov    %eax,(%esp)
80101b86:	e8 04 f8 ff ff       	call   8010138f <balloc>
80101b8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101b8e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b91:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b94:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101b97:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9a:	8b 00                	mov    (%eax),%eax
80101b9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b9f:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ba3:	89 04 24             	mov    %eax,(%esp)
80101ba6:	e8 fb e5 ff ff       	call   801001a6 <bread>
80101bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101bae:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bb1:	83 c0 18             	add    $0x18,%eax
80101bb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101bb7:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bba:	c1 e0 02             	shl    $0x2,%eax
80101bbd:	03 45 ec             	add    -0x14(%ebp),%eax
80101bc0:	8b 00                	mov    (%eax),%eax
80101bc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bc5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bc9:	75 2b                	jne    80101bf6 <bmap+0xe0>
      a[bn] = addr = balloc(ip->dev);
80101bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bce:	c1 e0 02             	shl    $0x2,%eax
80101bd1:	89 c3                	mov    %eax,%ebx
80101bd3:	03 5d ec             	add    -0x14(%ebp),%ebx
80101bd6:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd9:	8b 00                	mov    (%eax),%eax
80101bdb:	89 04 24             	mov    %eax,(%esp)
80101bde:	e8 ac f7 ff ff       	call   8010138f <balloc>
80101be3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101be6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101be9:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101beb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bee:	89 04 24             	mov    %eax,(%esp)
80101bf1:	e8 38 18 00 00       	call   8010342e <log_write>
    }
    brelse(bp);
80101bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bf9:	89 04 24             	mov    %eax,(%esp)
80101bfc:	e8 16 e6 ff ff       	call   80100217 <brelse>
    return addr;
80101c01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c04:	eb 0c                	jmp    80101c12 <bmap+0xfc>
  }

  panic("bmap: out of range");
80101c06:	c7 04 24 aa 85 10 80 	movl   $0x801085aa,(%esp)
80101c0d:	e8 2b e9 ff ff       	call   8010053d <panic>
}
80101c12:	83 c4 24             	add    $0x24,%esp
80101c15:	5b                   	pop    %ebx
80101c16:	5d                   	pop    %ebp
80101c17:	c3                   	ret    

80101c18 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101c18:	55                   	push   %ebp
80101c19:	89 e5                	mov    %esp,%ebp
80101c1b:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101c25:	eb 44                	jmp    80101c6b <itrunc+0x53>
    if(ip->addrs[i]){
80101c27:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c2d:	83 c2 04             	add    $0x4,%edx
80101c30:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c34:	85 c0                	test   %eax,%eax
80101c36:	74 2f                	je     80101c67 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101c38:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c3e:	83 c2 04             	add    $0x4,%edx
80101c41:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101c45:	8b 45 08             	mov    0x8(%ebp),%eax
80101c48:	8b 00                	mov    (%eax),%eax
80101c4a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c4e:	89 04 24             	mov    %eax,(%esp)
80101c51:	e8 90 f8 ff ff       	call   801014e6 <bfree>
      ip->addrs[i] = 0;
80101c56:	8b 45 08             	mov    0x8(%ebp),%eax
80101c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c5c:	83 c2 04             	add    $0x4,%edx
80101c5f:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101c66:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101c6b:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101c6f:	7e b6                	jle    80101c27 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101c71:	8b 45 08             	mov    0x8(%ebp),%eax
80101c74:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c77:	85 c0                	test   %eax,%eax
80101c79:	0f 84 8f 00 00 00    	je     80101d0e <itrunc+0xf6>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c7f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c82:	8b 50 4c             	mov    0x4c(%eax),%edx
80101c85:	8b 45 08             	mov    0x8(%ebp),%eax
80101c88:	8b 00                	mov    (%eax),%eax
80101c8a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c8e:	89 04 24             	mov    %eax,(%esp)
80101c91:	e8 10 e5 ff ff       	call   801001a6 <bread>
80101c96:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101c99:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c9c:	83 c0 18             	add    $0x18,%eax
80101c9f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101ca2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101ca9:	eb 2f                	jmp    80101cda <itrunc+0xc2>
      if(a[j])
80101cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cae:	c1 e0 02             	shl    $0x2,%eax
80101cb1:	03 45 e8             	add    -0x18(%ebp),%eax
80101cb4:	8b 00                	mov    (%eax),%eax
80101cb6:	85 c0                	test   %eax,%eax
80101cb8:	74 1c                	je     80101cd6 <itrunc+0xbe>
        bfree(ip->dev, a[j]);
80101cba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cbd:	c1 e0 02             	shl    $0x2,%eax
80101cc0:	03 45 e8             	add    -0x18(%ebp),%eax
80101cc3:	8b 10                	mov    (%eax),%edx
80101cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc8:	8b 00                	mov    (%eax),%eax
80101cca:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cce:	89 04 24             	mov    %eax,(%esp)
80101cd1:	e8 10 f8 ff ff       	call   801014e6 <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101cd6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101cda:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cdd:	83 f8 7f             	cmp    $0x7f,%eax
80101ce0:	76 c9                	jbe    80101cab <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101ce2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ce5:	89 04 24             	mov    %eax,(%esp)
80101ce8:	e8 2a e5 ff ff       	call   80100217 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ced:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf0:	8b 50 4c             	mov    0x4c(%eax),%edx
80101cf3:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf6:	8b 00                	mov    (%eax),%eax
80101cf8:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cfc:	89 04 24             	mov    %eax,(%esp)
80101cff:	e8 e2 f7 ff ff       	call   801014e6 <bfree>
    ip->addrs[NDIRECT] = 0;
80101d04:	8b 45 08             	mov    0x8(%ebp),%eax
80101d07:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101d0e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d11:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101d18:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1b:	89 04 24             	mov    %eax,(%esp)
80101d1e:	e8 95 f9 ff ff       	call   801016b8 <iupdate>
}
80101d23:	c9                   	leave  
80101d24:	c3                   	ret    

80101d25 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101d25:	55                   	push   %ebp
80101d26:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101d28:	8b 45 08             	mov    0x8(%ebp),%eax
80101d2b:	8b 00                	mov    (%eax),%eax
80101d2d:	89 c2                	mov    %eax,%edx
80101d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d32:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101d35:	8b 45 08             	mov    0x8(%ebp),%eax
80101d38:	8b 50 04             	mov    0x4(%eax),%edx
80101d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d3e:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101d41:	8b 45 08             	mov    0x8(%ebp),%eax
80101d44:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101d48:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d4b:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101d4e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d51:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101d55:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d58:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101d5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5f:	8b 50 18             	mov    0x18(%eax),%edx
80101d62:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d65:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d68:	5d                   	pop    %ebp
80101d69:	c3                   	ret    

80101d6a <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d6a:	55                   	push   %ebp
80101d6b:	89 e5                	mov    %esp,%ebp
80101d6d:	53                   	push   %ebx
80101d6e:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d71:	8b 45 08             	mov    0x8(%ebp),%eax
80101d74:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101d78:	66 83 f8 03          	cmp    $0x3,%ax
80101d7c:	75 60                	jne    80101dde <readi+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d7e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d81:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d85:	66 85 c0             	test   %ax,%ax
80101d88:	78 20                	js     80101daa <readi+0x40>
80101d8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d8d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d91:	66 83 f8 09          	cmp    $0x9,%ax
80101d95:	7f 13                	jg     80101daa <readi+0x40>
80101d97:	8b 45 08             	mov    0x8(%ebp),%eax
80101d9a:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d9e:	98                   	cwtl   
80101d9f:	8b 04 c5 e0 11 11 80 	mov    -0x7feeee20(,%eax,8),%eax
80101da6:	85 c0                	test   %eax,%eax
80101da8:	75 0a                	jne    80101db4 <readi+0x4a>
      return -1;
80101daa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101daf:	e9 1b 01 00 00       	jmp    80101ecf <readi+0x165>
    return devsw[ip->major].read(ip, dst, n);
80101db4:	8b 45 08             	mov    0x8(%ebp),%eax
80101db7:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101dbb:	98                   	cwtl   
80101dbc:	8b 14 c5 e0 11 11 80 	mov    -0x7feeee20(,%eax,8),%edx
80101dc3:	8b 45 14             	mov    0x14(%ebp),%eax
80101dc6:	89 44 24 08          	mov    %eax,0x8(%esp)
80101dca:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dcd:	89 44 24 04          	mov    %eax,0x4(%esp)
80101dd1:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd4:	89 04 24             	mov    %eax,(%esp)
80101dd7:	ff d2                	call   *%edx
80101dd9:	e9 f1 00 00 00       	jmp    80101ecf <readi+0x165>
  }

  if(off > ip->size || off + n < off)
80101dde:	8b 45 08             	mov    0x8(%ebp),%eax
80101de1:	8b 40 18             	mov    0x18(%eax),%eax
80101de4:	3b 45 10             	cmp    0x10(%ebp),%eax
80101de7:	72 0d                	jb     80101df6 <readi+0x8c>
80101de9:	8b 45 14             	mov    0x14(%ebp),%eax
80101dec:	8b 55 10             	mov    0x10(%ebp),%edx
80101def:	01 d0                	add    %edx,%eax
80101df1:	3b 45 10             	cmp    0x10(%ebp),%eax
80101df4:	73 0a                	jae    80101e00 <readi+0x96>
    return -1;
80101df6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dfb:	e9 cf 00 00 00       	jmp    80101ecf <readi+0x165>
  if(off + n > ip->size)
80101e00:	8b 45 14             	mov    0x14(%ebp),%eax
80101e03:	8b 55 10             	mov    0x10(%ebp),%edx
80101e06:	01 c2                	add    %eax,%edx
80101e08:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0b:	8b 40 18             	mov    0x18(%eax),%eax
80101e0e:	39 c2                	cmp    %eax,%edx
80101e10:	76 0c                	jbe    80101e1e <readi+0xb4>
    n = ip->size - off;
80101e12:	8b 45 08             	mov    0x8(%ebp),%eax
80101e15:	8b 40 18             	mov    0x18(%eax),%eax
80101e18:	2b 45 10             	sub    0x10(%ebp),%eax
80101e1b:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101e25:	e9 96 00 00 00       	jmp    80101ec0 <readi+0x156>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e2a:	8b 45 10             	mov    0x10(%ebp),%eax
80101e2d:	c1 e8 09             	shr    $0x9,%eax
80101e30:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e34:	8b 45 08             	mov    0x8(%ebp),%eax
80101e37:	89 04 24             	mov    %eax,(%esp)
80101e3a:	e8 d7 fc ff ff       	call   80101b16 <bmap>
80101e3f:	8b 55 08             	mov    0x8(%ebp),%edx
80101e42:	8b 12                	mov    (%edx),%edx
80101e44:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e48:	89 14 24             	mov    %edx,(%esp)
80101e4b:	e8 56 e3 ff ff       	call   801001a6 <bread>
80101e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101e53:	8b 45 10             	mov    0x10(%ebp),%eax
80101e56:	89 c2                	mov    %eax,%edx
80101e58:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101e5e:	b8 00 02 00 00       	mov    $0x200,%eax
80101e63:	89 c1                	mov    %eax,%ecx
80101e65:	29 d1                	sub    %edx,%ecx
80101e67:	89 ca                	mov    %ecx,%edx
80101e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e6c:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101e6f:	89 cb                	mov    %ecx,%ebx
80101e71:	29 c3                	sub    %eax,%ebx
80101e73:	89 d8                	mov    %ebx,%eax
80101e75:	39 c2                	cmp    %eax,%edx
80101e77:	0f 46 c2             	cmovbe %edx,%eax
80101e7a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101e7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e80:	8d 50 18             	lea    0x18(%eax),%edx
80101e83:	8b 45 10             	mov    0x10(%ebp),%eax
80101e86:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e8b:	01 c2                	add    %eax,%edx
80101e8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e90:	89 44 24 08          	mov    %eax,0x8(%esp)
80101e94:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e98:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e9b:	89 04 24             	mov    %eax,(%esp)
80101e9e:	e8 02 32 00 00       	call   801050a5 <memmove>
    brelse(bp);
80101ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ea6:	89 04 24             	mov    %eax,(%esp)
80101ea9:	e8 69 e3 ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eae:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101eb1:	01 45 f4             	add    %eax,-0xc(%ebp)
80101eb4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101eb7:	01 45 10             	add    %eax,0x10(%ebp)
80101eba:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ebd:	01 45 0c             	add    %eax,0xc(%ebp)
80101ec0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ec3:	3b 45 14             	cmp    0x14(%ebp),%eax
80101ec6:	0f 82 5e ff ff ff    	jb     80101e2a <readi+0xc0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101ecc:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101ecf:	83 c4 24             	add    $0x24,%esp
80101ed2:	5b                   	pop    %ebx
80101ed3:	5d                   	pop    %ebp
80101ed4:	c3                   	ret    

80101ed5 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ed5:	55                   	push   %ebp
80101ed6:	89 e5                	mov    %esp,%ebp
80101ed8:	53                   	push   %ebx
80101ed9:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101edc:	8b 45 08             	mov    0x8(%ebp),%eax
80101edf:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ee3:	66 83 f8 03          	cmp    $0x3,%ax
80101ee7:	75 60                	jne    80101f49 <writei+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ee9:	8b 45 08             	mov    0x8(%ebp),%eax
80101eec:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ef0:	66 85 c0             	test   %ax,%ax
80101ef3:	78 20                	js     80101f15 <writei+0x40>
80101ef5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101efc:	66 83 f8 09          	cmp    $0x9,%ax
80101f00:	7f 13                	jg     80101f15 <writei+0x40>
80101f02:	8b 45 08             	mov    0x8(%ebp),%eax
80101f05:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f09:	98                   	cwtl   
80101f0a:	8b 04 c5 e4 11 11 80 	mov    -0x7feeee1c(,%eax,8),%eax
80101f11:	85 c0                	test   %eax,%eax
80101f13:	75 0a                	jne    80101f1f <writei+0x4a>
      return -1;
80101f15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f1a:	e9 46 01 00 00       	jmp    80102065 <writei+0x190>
    return devsw[ip->major].write(ip, src, n);
80101f1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f22:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f26:	98                   	cwtl   
80101f27:	8b 14 c5 e4 11 11 80 	mov    -0x7feeee1c(,%eax,8),%edx
80101f2e:	8b 45 14             	mov    0x14(%ebp),%eax
80101f31:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f35:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f38:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3f:	89 04 24             	mov    %eax,(%esp)
80101f42:	ff d2                	call   *%edx
80101f44:	e9 1c 01 00 00       	jmp    80102065 <writei+0x190>
  }

  if(off > ip->size || off + n < off)
80101f49:	8b 45 08             	mov    0x8(%ebp),%eax
80101f4c:	8b 40 18             	mov    0x18(%eax),%eax
80101f4f:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f52:	72 0d                	jb     80101f61 <writei+0x8c>
80101f54:	8b 45 14             	mov    0x14(%ebp),%eax
80101f57:	8b 55 10             	mov    0x10(%ebp),%edx
80101f5a:	01 d0                	add    %edx,%eax
80101f5c:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f5f:	73 0a                	jae    80101f6b <writei+0x96>
    return -1;
80101f61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f66:	e9 fa 00 00 00       	jmp    80102065 <writei+0x190>
  if(off + n > MAXFILE*BSIZE)
80101f6b:	8b 45 14             	mov    0x14(%ebp),%eax
80101f6e:	8b 55 10             	mov    0x10(%ebp),%edx
80101f71:	01 d0                	add    %edx,%eax
80101f73:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101f78:	76 0a                	jbe    80101f84 <writei+0xaf>
    return -1;
80101f7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f7f:	e9 e1 00 00 00       	jmp    80102065 <writei+0x190>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f8b:	e9 a1 00 00 00       	jmp    80102031 <writei+0x15c>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f90:	8b 45 10             	mov    0x10(%ebp),%eax
80101f93:	c1 e8 09             	shr    $0x9,%eax
80101f96:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f9d:	89 04 24             	mov    %eax,(%esp)
80101fa0:	e8 71 fb ff ff       	call   80101b16 <bmap>
80101fa5:	8b 55 08             	mov    0x8(%ebp),%edx
80101fa8:	8b 12                	mov    (%edx),%edx
80101faa:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fae:	89 14 24             	mov    %edx,(%esp)
80101fb1:	e8 f0 e1 ff ff       	call   801001a6 <bread>
80101fb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fb9:	8b 45 10             	mov    0x10(%ebp),%eax
80101fbc:	89 c2                	mov    %eax,%edx
80101fbe:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101fc4:	b8 00 02 00 00       	mov    $0x200,%eax
80101fc9:	89 c1                	mov    %eax,%ecx
80101fcb:	29 d1                	sub    %edx,%ecx
80101fcd:	89 ca                	mov    %ecx,%edx
80101fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fd2:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101fd5:	89 cb                	mov    %ecx,%ebx
80101fd7:	29 c3                	sub    %eax,%ebx
80101fd9:	89 d8                	mov    %ebx,%eax
80101fdb:	39 c2                	cmp    %eax,%edx
80101fdd:	0f 46 c2             	cmovbe %edx,%eax
80101fe0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80101fe3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fe6:	8d 50 18             	lea    0x18(%eax),%edx
80101fe9:	8b 45 10             	mov    0x10(%ebp),%eax
80101fec:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ff1:	01 c2                	add    %eax,%edx
80101ff3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ff6:	89 44 24 08          	mov    %eax,0x8(%esp)
80101ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ffd:	89 44 24 04          	mov    %eax,0x4(%esp)
80102001:	89 14 24             	mov    %edx,(%esp)
80102004:	e8 9c 30 00 00       	call   801050a5 <memmove>
    log_write(bp);
80102009:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010200c:	89 04 24             	mov    %eax,(%esp)
8010200f:	e8 1a 14 00 00       	call   8010342e <log_write>
    brelse(bp);
80102014:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102017:	89 04 24             	mov    %eax,(%esp)
8010201a:	e8 f8 e1 ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010201f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102022:	01 45 f4             	add    %eax,-0xc(%ebp)
80102025:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102028:	01 45 10             	add    %eax,0x10(%ebp)
8010202b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010202e:	01 45 0c             	add    %eax,0xc(%ebp)
80102031:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102034:	3b 45 14             	cmp    0x14(%ebp),%eax
80102037:	0f 82 53 ff ff ff    	jb     80101f90 <writei+0xbb>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010203d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102041:	74 1f                	je     80102062 <writei+0x18d>
80102043:	8b 45 08             	mov    0x8(%ebp),%eax
80102046:	8b 40 18             	mov    0x18(%eax),%eax
80102049:	3b 45 10             	cmp    0x10(%ebp),%eax
8010204c:	73 14                	jae    80102062 <writei+0x18d>
    ip->size = off;
8010204e:	8b 45 08             	mov    0x8(%ebp),%eax
80102051:	8b 55 10             	mov    0x10(%ebp),%edx
80102054:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102057:	8b 45 08             	mov    0x8(%ebp),%eax
8010205a:	89 04 24             	mov    %eax,(%esp)
8010205d:	e8 56 f6 ff ff       	call   801016b8 <iupdate>
  }
  return n;
80102062:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102065:	83 c4 24             	add    $0x24,%esp
80102068:	5b                   	pop    %ebx
80102069:	5d                   	pop    %ebp
8010206a:	c3                   	ret    

8010206b <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010206b:	55                   	push   %ebp
8010206c:	89 e5                	mov    %esp,%ebp
8010206e:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80102071:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102078:	00 
80102079:	8b 45 0c             	mov    0xc(%ebp),%eax
8010207c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102080:	8b 45 08             	mov    0x8(%ebp),%eax
80102083:	89 04 24             	mov    %eax,(%esp)
80102086:	e8 be 30 00 00       	call   80105149 <strncmp>
}
8010208b:	c9                   	leave  
8010208c:	c3                   	ret    

8010208d <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
8010208d:	55                   	push   %ebp
8010208e:	89 e5                	mov    %esp,%ebp
80102090:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102093:	8b 45 08             	mov    0x8(%ebp),%eax
80102096:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010209a:	66 83 f8 01          	cmp    $0x1,%ax
8010209e:	74 0c                	je     801020ac <dirlookup+0x1f>
    panic("dirlookup not DIR");
801020a0:	c7 04 24 bd 85 10 80 	movl   $0x801085bd,(%esp)
801020a7:	e8 91 e4 ff ff       	call   8010053d <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801020ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801020b3:	e9 87 00 00 00       	jmp    8010213f <dirlookup+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020b8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801020bf:	00 
801020c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020c3:	89 44 24 08          	mov    %eax,0x8(%esp)
801020c7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020ca:	89 44 24 04          	mov    %eax,0x4(%esp)
801020ce:	8b 45 08             	mov    0x8(%ebp),%eax
801020d1:	89 04 24             	mov    %eax,(%esp)
801020d4:	e8 91 fc ff ff       	call   80101d6a <readi>
801020d9:	83 f8 10             	cmp    $0x10,%eax
801020dc:	74 0c                	je     801020ea <dirlookup+0x5d>
      panic("dirlink read");
801020de:	c7 04 24 cf 85 10 80 	movl   $0x801085cf,(%esp)
801020e5:	e8 53 e4 ff ff       	call   8010053d <panic>
    if(de.inum == 0)
801020ea:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801020ee:	66 85 c0             	test   %ax,%ax
801020f1:	74 47                	je     8010213a <dirlookup+0xad>
      continue;
    if(namecmp(name, de.name) == 0){
801020f3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020f6:	83 c0 02             	add    $0x2,%eax
801020f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801020fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102100:	89 04 24             	mov    %eax,(%esp)
80102103:	e8 63 ff ff ff       	call   8010206b <namecmp>
80102108:	85 c0                	test   %eax,%eax
8010210a:	75 2f                	jne    8010213b <dirlookup+0xae>
      // entry matches path element
      if(poff)
8010210c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102110:	74 08                	je     8010211a <dirlookup+0x8d>
        *poff = off;
80102112:	8b 45 10             	mov    0x10(%ebp),%eax
80102115:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102118:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
8010211a:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010211e:	0f b7 c0             	movzwl %ax,%eax
80102121:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102124:	8b 45 08             	mov    0x8(%ebp),%eax
80102127:	8b 00                	mov    (%eax),%eax
80102129:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010212c:	89 54 24 04          	mov    %edx,0x4(%esp)
80102130:	89 04 24             	mov    %eax,(%esp)
80102133:	e8 38 f6 ff ff       	call   80101770 <iget>
80102138:	eb 19                	jmp    80102153 <dirlookup+0xc6>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
8010213a:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010213b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010213f:	8b 45 08             	mov    0x8(%ebp),%eax
80102142:	8b 40 18             	mov    0x18(%eax),%eax
80102145:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102148:	0f 87 6a ff ff ff    	ja     801020b8 <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010214e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102153:	c9                   	leave  
80102154:	c3                   	ret    

80102155 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102155:	55                   	push   %ebp
80102156:	89 e5                	mov    %esp,%ebp
80102158:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010215b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102162:	00 
80102163:	8b 45 0c             	mov    0xc(%ebp),%eax
80102166:	89 44 24 04          	mov    %eax,0x4(%esp)
8010216a:	8b 45 08             	mov    0x8(%ebp),%eax
8010216d:	89 04 24             	mov    %eax,(%esp)
80102170:	e8 18 ff ff ff       	call   8010208d <dirlookup>
80102175:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102178:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010217c:	74 15                	je     80102193 <dirlink+0x3e>
    iput(ip);
8010217e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102181:	89 04 24             	mov    %eax,(%esp)
80102184:	e8 9e f8 ff ff       	call   80101a27 <iput>
    return -1;
80102189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010218e:	e9 b8 00 00 00       	jmp    8010224b <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102193:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010219a:	eb 44                	jmp    801021e0 <dirlink+0x8b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010219c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010219f:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801021a6:	00 
801021a7:	89 44 24 08          	mov    %eax,0x8(%esp)
801021ab:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801021b2:	8b 45 08             	mov    0x8(%ebp),%eax
801021b5:	89 04 24             	mov    %eax,(%esp)
801021b8:	e8 ad fb ff ff       	call   80101d6a <readi>
801021bd:	83 f8 10             	cmp    $0x10,%eax
801021c0:	74 0c                	je     801021ce <dirlink+0x79>
      panic("dirlink read");
801021c2:	c7 04 24 cf 85 10 80 	movl   $0x801085cf,(%esp)
801021c9:	e8 6f e3 ff ff       	call   8010053d <panic>
    if(de.inum == 0)
801021ce:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021d2:	66 85 c0             	test   %ax,%ax
801021d5:	74 18                	je     801021ef <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801021d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021da:	83 c0 10             	add    $0x10,%eax
801021dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801021e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021e3:	8b 45 08             	mov    0x8(%ebp),%eax
801021e6:	8b 40 18             	mov    0x18(%eax),%eax
801021e9:	39 c2                	cmp    %eax,%edx
801021eb:	72 af                	jb     8010219c <dirlink+0x47>
801021ed:	eb 01                	jmp    801021f0 <dirlink+0x9b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801021ef:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801021f0:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801021f7:	00 
801021f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801021fb:	89 44 24 04          	mov    %eax,0x4(%esp)
801021ff:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102202:	83 c0 02             	add    $0x2,%eax
80102205:	89 04 24             	mov    %eax,(%esp)
80102208:	e8 94 2f 00 00       	call   801051a1 <strncpy>
  de.inum = inum;
8010220d:	8b 45 10             	mov    0x10(%ebp),%eax
80102210:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102214:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102217:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010221e:	00 
8010221f:	89 44 24 08          	mov    %eax,0x8(%esp)
80102223:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102226:	89 44 24 04          	mov    %eax,0x4(%esp)
8010222a:	8b 45 08             	mov    0x8(%ebp),%eax
8010222d:	89 04 24             	mov    %eax,(%esp)
80102230:	e8 a0 fc ff ff       	call   80101ed5 <writei>
80102235:	83 f8 10             	cmp    $0x10,%eax
80102238:	74 0c                	je     80102246 <dirlink+0xf1>
    panic("dirlink");
8010223a:	c7 04 24 dc 85 10 80 	movl   $0x801085dc,(%esp)
80102241:	e8 f7 e2 ff ff       	call   8010053d <panic>
  
  return 0;
80102246:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010224b:	c9                   	leave  
8010224c:	c3                   	ret    

8010224d <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010224d:	55                   	push   %ebp
8010224e:	89 e5                	mov    %esp,%ebp
80102250:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
80102253:	eb 04                	jmp    80102259 <skipelem+0xc>
    path++;
80102255:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102259:	8b 45 08             	mov    0x8(%ebp),%eax
8010225c:	0f b6 00             	movzbl (%eax),%eax
8010225f:	3c 2f                	cmp    $0x2f,%al
80102261:	74 f2                	je     80102255 <skipelem+0x8>
    path++;
  if(*path == 0)
80102263:	8b 45 08             	mov    0x8(%ebp),%eax
80102266:	0f b6 00             	movzbl (%eax),%eax
80102269:	84 c0                	test   %al,%al
8010226b:	75 0a                	jne    80102277 <skipelem+0x2a>
    return 0;
8010226d:	b8 00 00 00 00       	mov    $0x0,%eax
80102272:	e9 86 00 00 00       	jmp    801022fd <skipelem+0xb0>
  s = path;
80102277:	8b 45 08             	mov    0x8(%ebp),%eax
8010227a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010227d:	eb 04                	jmp    80102283 <skipelem+0x36>
    path++;
8010227f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102283:	8b 45 08             	mov    0x8(%ebp),%eax
80102286:	0f b6 00             	movzbl (%eax),%eax
80102289:	3c 2f                	cmp    $0x2f,%al
8010228b:	74 0a                	je     80102297 <skipelem+0x4a>
8010228d:	8b 45 08             	mov    0x8(%ebp),%eax
80102290:	0f b6 00             	movzbl (%eax),%eax
80102293:	84 c0                	test   %al,%al
80102295:	75 e8                	jne    8010227f <skipelem+0x32>
    path++;
  len = path - s;
80102297:	8b 55 08             	mov    0x8(%ebp),%edx
8010229a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010229d:	89 d1                	mov    %edx,%ecx
8010229f:	29 c1                	sub    %eax,%ecx
801022a1:	89 c8                	mov    %ecx,%eax
801022a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801022a6:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801022aa:	7e 1c                	jle    801022c8 <skipelem+0x7b>
    memmove(name, s, DIRSIZ);
801022ac:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801022b3:	00 
801022b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801022bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801022be:	89 04 24             	mov    %eax,(%esp)
801022c1:	e8 df 2d 00 00       	call   801050a5 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022c6:	eb 28                	jmp    801022f0 <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
801022c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022cb:	89 44 24 08          	mov    %eax,0x8(%esp)
801022cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801022d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801022d9:	89 04 24             	mov    %eax,(%esp)
801022dc:	e8 c4 2d 00 00       	call   801050a5 <memmove>
    name[len] = 0;
801022e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022e4:	03 45 0c             	add    0xc(%ebp),%eax
801022e7:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801022ea:	eb 04                	jmp    801022f0 <skipelem+0xa3>
    path++;
801022ec:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022f0:	8b 45 08             	mov    0x8(%ebp),%eax
801022f3:	0f b6 00             	movzbl (%eax),%eax
801022f6:	3c 2f                	cmp    $0x2f,%al
801022f8:	74 f2                	je     801022ec <skipelem+0x9f>
    path++;
  return path;
801022fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
801022fd:	c9                   	leave  
801022fe:	c3                   	ret    

801022ff <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801022ff:	55                   	push   %ebp
80102300:	89 e5                	mov    %esp,%ebp
80102302:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102305:	8b 45 08             	mov    0x8(%ebp),%eax
80102308:	0f b6 00             	movzbl (%eax),%eax
8010230b:	3c 2f                	cmp    $0x2f,%al
8010230d:	75 1c                	jne    8010232b <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
8010230f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102316:	00 
80102317:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010231e:	e8 4d f4 ff ff       	call   80101770 <iget>
80102323:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102326:	e9 af 00 00 00       	jmp    801023da <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
8010232b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102331:	8b 40 68             	mov    0x68(%eax),%eax
80102334:	89 04 24             	mov    %eax,(%esp)
80102337:	e8 06 f5 ff ff       	call   80101842 <idup>
8010233c:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010233f:	e9 96 00 00 00       	jmp    801023da <namex+0xdb>
    ilock(ip);
80102344:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102347:	89 04 24             	mov    %eax,(%esp)
8010234a:	e8 25 f5 ff ff       	call   80101874 <ilock>
    if(ip->type != T_DIR){
8010234f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102352:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102356:	66 83 f8 01          	cmp    $0x1,%ax
8010235a:	74 15                	je     80102371 <namex+0x72>
      iunlockput(ip);
8010235c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010235f:	89 04 24             	mov    %eax,(%esp)
80102362:	e8 91 f7 ff ff       	call   80101af8 <iunlockput>
      return 0;
80102367:	b8 00 00 00 00       	mov    $0x0,%eax
8010236c:	e9 a3 00 00 00       	jmp    80102414 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
80102371:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102375:	74 1d                	je     80102394 <namex+0x95>
80102377:	8b 45 08             	mov    0x8(%ebp),%eax
8010237a:	0f b6 00             	movzbl (%eax),%eax
8010237d:	84 c0                	test   %al,%al
8010237f:	75 13                	jne    80102394 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
80102381:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102384:	89 04 24             	mov    %eax,(%esp)
80102387:	e8 36 f6 ff ff       	call   801019c2 <iunlock>
      return ip;
8010238c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010238f:	e9 80 00 00 00       	jmp    80102414 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102394:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010239b:	00 
8010239c:	8b 45 10             	mov    0x10(%ebp),%eax
8010239f:	89 44 24 04          	mov    %eax,0x4(%esp)
801023a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023a6:	89 04 24             	mov    %eax,(%esp)
801023a9:	e8 df fc ff ff       	call   8010208d <dirlookup>
801023ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
801023b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801023b5:	75 12                	jne    801023c9 <namex+0xca>
      iunlockput(ip);
801023b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023ba:	89 04 24             	mov    %eax,(%esp)
801023bd:	e8 36 f7 ff ff       	call   80101af8 <iunlockput>
      return 0;
801023c2:	b8 00 00 00 00       	mov    $0x0,%eax
801023c7:	eb 4b                	jmp    80102414 <namex+0x115>
    }
    iunlockput(ip);
801023c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023cc:	89 04 24             	mov    %eax,(%esp)
801023cf:	e8 24 f7 ff ff       	call   80101af8 <iunlockput>
    ip = next;
801023d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801023da:	8b 45 10             	mov    0x10(%ebp),%eax
801023dd:	89 44 24 04          	mov    %eax,0x4(%esp)
801023e1:	8b 45 08             	mov    0x8(%ebp),%eax
801023e4:	89 04 24             	mov    %eax,(%esp)
801023e7:	e8 61 fe ff ff       	call   8010224d <skipelem>
801023ec:	89 45 08             	mov    %eax,0x8(%ebp)
801023ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801023f3:	0f 85 4b ff ff ff    	jne    80102344 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801023f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801023fd:	74 12                	je     80102411 <namex+0x112>
    iput(ip);
801023ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102402:	89 04 24             	mov    %eax,(%esp)
80102405:	e8 1d f6 ff ff       	call   80101a27 <iput>
    return 0;
8010240a:	b8 00 00 00 00       	mov    $0x0,%eax
8010240f:	eb 03                	jmp    80102414 <namex+0x115>
  }
  return ip;
80102411:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102414:	c9                   	leave  
80102415:	c3                   	ret    

80102416 <namei>:

struct inode*
namei(char *path)
{
80102416:	55                   	push   %ebp
80102417:	89 e5                	mov    %esp,%ebp
80102419:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
8010241c:	8d 45 ea             	lea    -0x16(%ebp),%eax
8010241f:	89 44 24 08          	mov    %eax,0x8(%esp)
80102423:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010242a:	00 
8010242b:	8b 45 08             	mov    0x8(%ebp),%eax
8010242e:	89 04 24             	mov    %eax,(%esp)
80102431:	e8 c9 fe ff ff       	call   801022ff <namex>
}
80102436:	c9                   	leave  
80102437:	c3                   	ret    

80102438 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102438:	55                   	push   %ebp
80102439:	89 e5                	mov    %esp,%ebp
8010243b:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
8010243e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102441:	89 44 24 08          	mov    %eax,0x8(%esp)
80102445:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010244c:	00 
8010244d:	8b 45 08             	mov    0x8(%ebp),%eax
80102450:	89 04 24             	mov    %eax,(%esp)
80102453:	e8 a7 fe ff ff       	call   801022ff <namex>
}
80102458:	c9                   	leave  
80102459:	c3                   	ret    
	...

8010245c <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010245c:	55                   	push   %ebp
8010245d:	89 e5                	mov    %esp,%ebp
8010245f:	53                   	push   %ebx
80102460:	83 ec 14             	sub    $0x14,%esp
80102463:	8b 45 08             	mov    0x8(%ebp),%eax
80102466:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010246a:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
8010246e:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80102472:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80102476:	ec                   	in     (%dx),%al
80102477:	89 c3                	mov    %eax,%ebx
80102479:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
8010247c:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80102480:	83 c4 14             	add    $0x14,%esp
80102483:	5b                   	pop    %ebx
80102484:	5d                   	pop    %ebp
80102485:	c3                   	ret    

80102486 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102486:	55                   	push   %ebp
80102487:	89 e5                	mov    %esp,%ebp
80102489:	57                   	push   %edi
8010248a:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010248b:	8b 55 08             	mov    0x8(%ebp),%edx
8010248e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102491:	8b 45 10             	mov    0x10(%ebp),%eax
80102494:	89 cb                	mov    %ecx,%ebx
80102496:	89 df                	mov    %ebx,%edi
80102498:	89 c1                	mov    %eax,%ecx
8010249a:	fc                   	cld    
8010249b:	f3 6d                	rep insl (%dx),%es:(%edi)
8010249d:	89 c8                	mov    %ecx,%eax
8010249f:	89 fb                	mov    %edi,%ebx
801024a1:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024a4:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
801024a7:	5b                   	pop    %ebx
801024a8:	5f                   	pop    %edi
801024a9:	5d                   	pop    %ebp
801024aa:	c3                   	ret    

801024ab <outb>:

static inline void
outb(ushort port, uchar data)
{
801024ab:	55                   	push   %ebp
801024ac:	89 e5                	mov    %esp,%ebp
801024ae:	83 ec 08             	sub    $0x8,%esp
801024b1:	8b 55 08             	mov    0x8(%ebp),%edx
801024b4:	8b 45 0c             	mov    0xc(%ebp),%eax
801024b7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801024bb:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024be:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801024c2:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801024c6:	ee                   	out    %al,(%dx)
}
801024c7:	c9                   	leave  
801024c8:	c3                   	ret    

801024c9 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801024c9:	55                   	push   %ebp
801024ca:	89 e5                	mov    %esp,%ebp
801024cc:	56                   	push   %esi
801024cd:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801024ce:	8b 55 08             	mov    0x8(%ebp),%edx
801024d1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801024d4:	8b 45 10             	mov    0x10(%ebp),%eax
801024d7:	89 cb                	mov    %ecx,%ebx
801024d9:	89 de                	mov    %ebx,%esi
801024db:	89 c1                	mov    %eax,%ecx
801024dd:	fc                   	cld    
801024de:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801024e0:	89 c8                	mov    %ecx,%eax
801024e2:	89 f3                	mov    %esi,%ebx
801024e4:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024e7:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801024ea:	5b                   	pop    %ebx
801024eb:	5e                   	pop    %esi
801024ec:	5d                   	pop    %ebp
801024ed:	c3                   	ret    

801024ee <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801024ee:	55                   	push   %ebp
801024ef:	89 e5                	mov    %esp,%ebp
801024f1:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801024f4:	90                   	nop
801024f5:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801024fc:	e8 5b ff ff ff       	call   8010245c <inb>
80102501:	0f b6 c0             	movzbl %al,%eax
80102504:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102507:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010250a:	25 c0 00 00 00       	and    $0xc0,%eax
8010250f:	83 f8 40             	cmp    $0x40,%eax
80102512:	75 e1                	jne    801024f5 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102514:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102518:	74 11                	je     8010252b <idewait+0x3d>
8010251a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010251d:	83 e0 21             	and    $0x21,%eax
80102520:	85 c0                	test   %eax,%eax
80102522:	74 07                	je     8010252b <idewait+0x3d>
    return -1;
80102524:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102529:	eb 05                	jmp    80102530 <idewait+0x42>
  return 0;
8010252b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102530:	c9                   	leave  
80102531:	c3                   	ret    

80102532 <ideinit>:

void
ideinit(void)
{
80102532:	55                   	push   %ebp
80102533:	89 e5                	mov    %esp,%ebp
80102535:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
80102538:	c7 44 24 04 e4 85 10 	movl   $0x801085e4,0x4(%esp)
8010253f:	80 
80102540:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102547:	e8 16 28 00 00       	call   80104d62 <initlock>
  picenable(IRQ_IDE);
8010254c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102553:	e8 71 16 00 00       	call   80103bc9 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102558:	a1 40 29 11 80       	mov    0x80112940,%eax
8010255d:	83 e8 01             	sub    $0x1,%eax
80102560:	89 44 24 04          	mov    %eax,0x4(%esp)
80102564:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010256b:	e8 12 04 00 00       	call   80102982 <ioapicenable>
  idewait(0);
80102570:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102577:	e8 72 ff ff ff       	call   801024ee <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
8010257c:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102583:	00 
80102584:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
8010258b:	e8 1b ff ff ff       	call   801024ab <outb>
  for(i=0; i<1000; i++){
80102590:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102597:	eb 20                	jmp    801025b9 <ideinit+0x87>
    if(inb(0x1f7) != 0){
80102599:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801025a0:	e8 b7 fe ff ff       	call   8010245c <inb>
801025a5:	84 c0                	test   %al,%al
801025a7:	74 0c                	je     801025b5 <ideinit+0x83>
      havedisk1 = 1;
801025a9:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
801025b0:	00 00 00 
      break;
801025b3:	eb 0d                	jmp    801025c2 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801025b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801025b9:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801025c0:	7e d7                	jle    80102599 <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801025c2:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
801025c9:	00 
801025ca:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801025d1:	e8 d5 fe ff ff       	call   801024ab <outb>
}
801025d6:	c9                   	leave  
801025d7:	c3                   	ret    

801025d8 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801025d8:	55                   	push   %ebp
801025d9:	89 e5                	mov    %esp,%ebp
801025db:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801025de:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025e2:	75 0c                	jne    801025f0 <idestart+0x18>
    panic("idestart");
801025e4:	c7 04 24 e8 85 10 80 	movl   $0x801085e8,(%esp)
801025eb:	e8 4d df ff ff       	call   8010053d <panic>

  idewait(0);
801025f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801025f7:	e8 f2 fe ff ff       	call   801024ee <idewait>
  outb(0x3f6, 0);  // generate interrupt
801025fc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102603:	00 
80102604:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
8010260b:	e8 9b fe ff ff       	call   801024ab <outb>
  outb(0x1f2, 1);  // number of sectors
80102610:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102617:	00 
80102618:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
8010261f:	e8 87 fe ff ff       	call   801024ab <outb>
  outb(0x1f3, b->sector & 0xff);
80102624:	8b 45 08             	mov    0x8(%ebp),%eax
80102627:	8b 40 08             	mov    0x8(%eax),%eax
8010262a:	0f b6 c0             	movzbl %al,%eax
8010262d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102631:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102638:	e8 6e fe ff ff       	call   801024ab <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
8010263d:	8b 45 08             	mov    0x8(%ebp),%eax
80102640:	8b 40 08             	mov    0x8(%eax),%eax
80102643:	c1 e8 08             	shr    $0x8,%eax
80102646:	0f b6 c0             	movzbl %al,%eax
80102649:	89 44 24 04          	mov    %eax,0x4(%esp)
8010264d:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102654:	e8 52 fe ff ff       	call   801024ab <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102659:	8b 45 08             	mov    0x8(%ebp),%eax
8010265c:	8b 40 08             	mov    0x8(%eax),%eax
8010265f:	c1 e8 10             	shr    $0x10,%eax
80102662:	0f b6 c0             	movzbl %al,%eax
80102665:	89 44 24 04          	mov    %eax,0x4(%esp)
80102669:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
80102670:	e8 36 fe ff ff       	call   801024ab <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102675:	8b 45 08             	mov    0x8(%ebp),%eax
80102678:	8b 40 04             	mov    0x4(%eax),%eax
8010267b:	83 e0 01             	and    $0x1,%eax
8010267e:	89 c2                	mov    %eax,%edx
80102680:	c1 e2 04             	shl    $0x4,%edx
80102683:	8b 45 08             	mov    0x8(%ebp),%eax
80102686:	8b 40 08             	mov    0x8(%eax),%eax
80102689:	c1 e8 18             	shr    $0x18,%eax
8010268c:	83 e0 0f             	and    $0xf,%eax
8010268f:	09 d0                	or     %edx,%eax
80102691:	83 c8 e0             	or     $0xffffffe0,%eax
80102694:	0f b6 c0             	movzbl %al,%eax
80102697:	89 44 24 04          	mov    %eax,0x4(%esp)
8010269b:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801026a2:	e8 04 fe ff ff       	call   801024ab <outb>
  if(b->flags & B_DIRTY){
801026a7:	8b 45 08             	mov    0x8(%ebp),%eax
801026aa:	8b 00                	mov    (%eax),%eax
801026ac:	83 e0 04             	and    $0x4,%eax
801026af:	85 c0                	test   %eax,%eax
801026b1:	74 34                	je     801026e7 <idestart+0x10f>
    outb(0x1f7, IDE_CMD_WRITE);
801026b3:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
801026ba:	00 
801026bb:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026c2:	e8 e4 fd ff ff       	call   801024ab <outb>
    outsl(0x1f0, b->data, 512/4);
801026c7:	8b 45 08             	mov    0x8(%ebp),%eax
801026ca:	83 c0 18             	add    $0x18,%eax
801026cd:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801026d4:	00 
801026d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801026d9:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801026e0:	e8 e4 fd ff ff       	call   801024c9 <outsl>
801026e5:	eb 14                	jmp    801026fb <idestart+0x123>
  } else {
    outb(0x1f7, IDE_CMD_READ);
801026e7:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
801026ee:	00 
801026ef:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026f6:	e8 b0 fd ff ff       	call   801024ab <outb>
  }
}
801026fb:	c9                   	leave  
801026fc:	c3                   	ret    

801026fd <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026fd:	55                   	push   %ebp
801026fe:	89 e5                	mov    %esp,%ebp
80102700:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102703:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010270a:	e8 74 26 00 00       	call   80104d83 <acquire>
  if((b = idequeue) == 0){
8010270f:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102714:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102717:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010271b:	75 11                	jne    8010272e <ideintr+0x31>
    release(&idelock);
8010271d:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102724:	e8 bc 26 00 00       	call   80104de5 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102729:	e9 90 00 00 00       	jmp    801027be <ideintr+0xc1>
  }
  idequeue = b->qnext;
8010272e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102731:	8b 40 14             	mov    0x14(%eax),%eax
80102734:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102739:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010273c:	8b 00                	mov    (%eax),%eax
8010273e:	83 e0 04             	and    $0x4,%eax
80102741:	85 c0                	test   %eax,%eax
80102743:	75 2e                	jne    80102773 <ideintr+0x76>
80102745:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010274c:	e8 9d fd ff ff       	call   801024ee <idewait>
80102751:	85 c0                	test   %eax,%eax
80102753:	78 1e                	js     80102773 <ideintr+0x76>
    insl(0x1f0, b->data, 512/4);
80102755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102758:	83 c0 18             	add    $0x18,%eax
8010275b:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102762:	00 
80102763:	89 44 24 04          	mov    %eax,0x4(%esp)
80102767:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
8010276e:	e8 13 fd ff ff       	call   80102486 <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102773:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102776:	8b 00                	mov    (%eax),%eax
80102778:	89 c2                	mov    %eax,%edx
8010277a:	83 ca 02             	or     $0x2,%edx
8010277d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102780:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102782:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102785:	8b 00                	mov    (%eax),%eax
80102787:	89 c2                	mov    %eax,%edx
80102789:	83 e2 fb             	and    $0xfffffffb,%edx
8010278c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010278f:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102791:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102794:	89 04 24             	mov    %eax,(%esp)
80102797:	e8 db 23 00 00       	call   80104b77 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010279c:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801027a1:	85 c0                	test   %eax,%eax
801027a3:	74 0d                	je     801027b2 <ideintr+0xb5>
    idestart(idequeue);
801027a5:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801027aa:	89 04 24             	mov    %eax,(%esp)
801027ad:	e8 26 fe ff ff       	call   801025d8 <idestart>

  release(&idelock);
801027b2:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801027b9:	e8 27 26 00 00       	call   80104de5 <release>
}
801027be:	c9                   	leave  
801027bf:	c3                   	ret    

801027c0 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801027c6:	8b 45 08             	mov    0x8(%ebp),%eax
801027c9:	8b 00                	mov    (%eax),%eax
801027cb:	83 e0 01             	and    $0x1,%eax
801027ce:	85 c0                	test   %eax,%eax
801027d0:	75 0c                	jne    801027de <iderw+0x1e>
    panic("iderw: buf not busy");
801027d2:	c7 04 24 f1 85 10 80 	movl   $0x801085f1,(%esp)
801027d9:	e8 5f dd ff ff       	call   8010053d <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027de:	8b 45 08             	mov    0x8(%ebp),%eax
801027e1:	8b 00                	mov    (%eax),%eax
801027e3:	83 e0 06             	and    $0x6,%eax
801027e6:	83 f8 02             	cmp    $0x2,%eax
801027e9:	75 0c                	jne    801027f7 <iderw+0x37>
    panic("iderw: nothing to do");
801027eb:	c7 04 24 05 86 10 80 	movl   $0x80108605,(%esp)
801027f2:	e8 46 dd ff ff       	call   8010053d <panic>
  if(b->dev != 0 && !havedisk1)
801027f7:	8b 45 08             	mov    0x8(%ebp),%eax
801027fa:	8b 40 04             	mov    0x4(%eax),%eax
801027fd:	85 c0                	test   %eax,%eax
801027ff:	74 15                	je     80102816 <iderw+0x56>
80102801:	a1 38 b6 10 80       	mov    0x8010b638,%eax
80102806:	85 c0                	test   %eax,%eax
80102808:	75 0c                	jne    80102816 <iderw+0x56>
    panic("iderw: ide disk 1 not present");
8010280a:	c7 04 24 1a 86 10 80 	movl   $0x8010861a,(%esp)
80102811:	e8 27 dd ff ff       	call   8010053d <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102816:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010281d:	e8 61 25 00 00       	call   80104d83 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102822:	8b 45 08             	mov    0x8(%ebp),%eax
80102825:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010282c:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
80102833:	eb 0b                	jmp    80102840 <iderw+0x80>
80102835:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102838:	8b 00                	mov    (%eax),%eax
8010283a:	83 c0 14             	add    $0x14,%eax
8010283d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102840:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102843:	8b 00                	mov    (%eax),%eax
80102845:	85 c0                	test   %eax,%eax
80102847:	75 ec                	jne    80102835 <iderw+0x75>
    ;
  *pp = b;
80102849:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010284c:	8b 55 08             	mov    0x8(%ebp),%edx
8010284f:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102851:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102856:	3b 45 08             	cmp    0x8(%ebp),%eax
80102859:	75 22                	jne    8010287d <iderw+0xbd>
    idestart(b);
8010285b:	8b 45 08             	mov    0x8(%ebp),%eax
8010285e:	89 04 24             	mov    %eax,(%esp)
80102861:	e8 72 fd ff ff       	call   801025d8 <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102866:	eb 15                	jmp    8010287d <iderw+0xbd>
    sleep(b, &idelock);
80102868:	c7 44 24 04 00 b6 10 	movl   $0x8010b600,0x4(%esp)
8010286f:	80 
80102870:	8b 45 08             	mov    0x8(%ebp),%eax
80102873:	89 04 24             	mov    %eax,(%esp)
80102876:	e8 20 22 00 00       	call   80104a9b <sleep>
8010287b:	eb 01                	jmp    8010287e <iderw+0xbe>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010287d:	90                   	nop
8010287e:	8b 45 08             	mov    0x8(%ebp),%eax
80102881:	8b 00                	mov    (%eax),%eax
80102883:	83 e0 06             	and    $0x6,%eax
80102886:	83 f8 02             	cmp    $0x2,%eax
80102889:	75 dd                	jne    80102868 <iderw+0xa8>
    sleep(b, &idelock);
  }

  release(&idelock);
8010288b:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102892:	e8 4e 25 00 00       	call   80104de5 <release>
}
80102897:	c9                   	leave  
80102898:	c3                   	ret    
80102899:	00 00                	add    %al,(%eax)
	...

8010289c <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
8010289c:	55                   	push   %ebp
8010289d:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010289f:	a1 14 22 11 80       	mov    0x80112214,%eax
801028a4:	8b 55 08             	mov    0x8(%ebp),%edx
801028a7:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
801028a9:	a1 14 22 11 80       	mov    0x80112214,%eax
801028ae:	8b 40 10             	mov    0x10(%eax),%eax
}
801028b1:	5d                   	pop    %ebp
801028b2:	c3                   	ret    

801028b3 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
801028b3:	55                   	push   %ebp
801028b4:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801028b6:	a1 14 22 11 80       	mov    0x80112214,%eax
801028bb:	8b 55 08             	mov    0x8(%ebp),%edx
801028be:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
801028c0:	a1 14 22 11 80       	mov    0x80112214,%eax
801028c5:	8b 55 0c             	mov    0xc(%ebp),%edx
801028c8:	89 50 10             	mov    %edx,0x10(%eax)
}
801028cb:	5d                   	pop    %ebp
801028cc:	c3                   	ret    

801028cd <ioapicinit>:

void
ioapicinit(void)
{
801028cd:	55                   	push   %ebp
801028ce:	89 e5                	mov    %esp,%ebp
801028d0:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
801028d3:	a1 44 23 11 80       	mov    0x80112344,%eax
801028d8:	85 c0                	test   %eax,%eax
801028da:	0f 84 9f 00 00 00    	je     8010297f <ioapicinit+0xb2>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801028e0:	c7 05 14 22 11 80 00 	movl   $0xfec00000,0x80112214
801028e7:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801028f1:	e8 a6 ff ff ff       	call   8010289c <ioapicread>
801028f6:	c1 e8 10             	shr    $0x10,%eax
801028f9:	25 ff 00 00 00       	and    $0xff,%eax
801028fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102901:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102908:	e8 8f ff ff ff       	call   8010289c <ioapicread>
8010290d:	c1 e8 18             	shr    $0x18,%eax
80102910:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102913:	0f b6 05 40 23 11 80 	movzbl 0x80112340,%eax
8010291a:	0f b6 c0             	movzbl %al,%eax
8010291d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102920:	74 0c                	je     8010292e <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102922:	c7 04 24 38 86 10 80 	movl   $0x80108638,(%esp)
80102929:	e8 73 da ff ff       	call   801003a1 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010292e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102935:	eb 3e                	jmp    80102975 <ioapicinit+0xa8>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102937:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010293a:	83 c0 20             	add    $0x20,%eax
8010293d:	0d 00 00 01 00       	or     $0x10000,%eax
80102942:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102945:	83 c2 08             	add    $0x8,%edx
80102948:	01 d2                	add    %edx,%edx
8010294a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010294e:	89 14 24             	mov    %edx,(%esp)
80102951:	e8 5d ff ff ff       	call   801028b3 <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102956:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102959:	83 c0 08             	add    $0x8,%eax
8010295c:	01 c0                	add    %eax,%eax
8010295e:	83 c0 01             	add    $0x1,%eax
80102961:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102968:	00 
80102969:	89 04 24             	mov    %eax,(%esp)
8010296c:	e8 42 ff ff ff       	call   801028b3 <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102971:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102978:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010297b:	7e ba                	jle    80102937 <ioapicinit+0x6a>
8010297d:	eb 01                	jmp    80102980 <ioapicinit+0xb3>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
8010297f:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102980:	c9                   	leave  
80102981:	c3                   	ret    

80102982 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102982:	55                   	push   %ebp
80102983:	89 e5                	mov    %esp,%ebp
80102985:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
80102988:	a1 44 23 11 80       	mov    0x80112344,%eax
8010298d:	85 c0                	test   %eax,%eax
8010298f:	74 39                	je     801029ca <ioapicenable+0x48>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102991:	8b 45 08             	mov    0x8(%ebp),%eax
80102994:	83 c0 20             	add    $0x20,%eax
80102997:	8b 55 08             	mov    0x8(%ebp),%edx
8010299a:	83 c2 08             	add    $0x8,%edx
8010299d:	01 d2                	add    %edx,%edx
8010299f:	89 44 24 04          	mov    %eax,0x4(%esp)
801029a3:	89 14 24             	mov    %edx,(%esp)
801029a6:	e8 08 ff ff ff       	call   801028b3 <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801029ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801029ae:	c1 e0 18             	shl    $0x18,%eax
801029b1:	8b 55 08             	mov    0x8(%ebp),%edx
801029b4:	83 c2 08             	add    $0x8,%edx
801029b7:	01 d2                	add    %edx,%edx
801029b9:	83 c2 01             	add    $0x1,%edx
801029bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801029c0:	89 14 24             	mov    %edx,(%esp)
801029c3:	e8 eb fe ff ff       	call   801028b3 <ioapicwrite>
801029c8:	eb 01                	jmp    801029cb <ioapicenable+0x49>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
801029ca:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801029cb:	c9                   	leave  
801029cc:	c3                   	ret    
801029cd:	00 00                	add    %al,(%eax)
	...

801029d0 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	8b 45 08             	mov    0x8(%ebp),%eax
801029d6:	05 00 00 00 80       	add    $0x80000000,%eax
801029db:	5d                   	pop    %ebp
801029dc:	c3                   	ret    

801029dd <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801029dd:	55                   	push   %ebp
801029de:	89 e5                	mov    %esp,%ebp
801029e0:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
801029e3:	c7 44 24 04 6a 86 10 	movl   $0x8010866a,0x4(%esp)
801029ea:	80 
801029eb:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
801029f2:	e8 6b 23 00 00       	call   80104d62 <initlock>
  kmem.use_lock = 0;
801029f7:	c7 05 54 22 11 80 00 	movl   $0x0,0x80112254
801029fe:	00 00 00 
  freerange(vstart, vend);
80102a01:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a04:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a08:	8b 45 08             	mov    0x8(%ebp),%eax
80102a0b:	89 04 24             	mov    %eax,(%esp)
80102a0e:	e8 26 00 00 00       	call   80102a39 <freerange>
}
80102a13:	c9                   	leave  
80102a14:	c3                   	ret    

80102a15 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102a15:	55                   	push   %ebp
80102a16:	89 e5                	mov    %esp,%ebp
80102a18:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a22:	8b 45 08             	mov    0x8(%ebp),%eax
80102a25:	89 04 24             	mov    %eax,(%esp)
80102a28:	e8 0c 00 00 00       	call   80102a39 <freerange>
  kmem.use_lock = 1;
80102a2d:	c7 05 54 22 11 80 01 	movl   $0x1,0x80112254
80102a34:	00 00 00 
}
80102a37:	c9                   	leave  
80102a38:	c3                   	ret    

80102a39 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102a39:	55                   	push   %ebp
80102a3a:	89 e5                	mov    %esp,%ebp
80102a3c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102a3f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a42:	05 ff 0f 00 00       	add    $0xfff,%eax
80102a47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102a4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a4f:	eb 12                	jmp    80102a63 <freerange+0x2a>
    kfree(p);
80102a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a54:	89 04 24             	mov    %eax,(%esp)
80102a57:	e8 16 00 00 00       	call   80102a72 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a5c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a66:	05 00 10 00 00       	add    $0x1000,%eax
80102a6b:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102a6e:	76 e1                	jbe    80102a51 <freerange+0x18>
    kfree(p);
}
80102a70:	c9                   	leave  
80102a71:	c3                   	ret    

80102a72 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102a72:	55                   	push   %ebp
80102a73:	89 e5                	mov    %esp,%ebp
80102a75:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102a78:	8b 45 08             	mov    0x8(%ebp),%eax
80102a7b:	25 ff 0f 00 00       	and    $0xfff,%eax
80102a80:	85 c0                	test   %eax,%eax
80102a82:	75 1b                	jne    80102a9f <kfree+0x2d>
80102a84:	81 7d 08 3c 56 11 80 	cmpl   $0x8011563c,0x8(%ebp)
80102a8b:	72 12                	jb     80102a9f <kfree+0x2d>
80102a8d:	8b 45 08             	mov    0x8(%ebp),%eax
80102a90:	89 04 24             	mov    %eax,(%esp)
80102a93:	e8 38 ff ff ff       	call   801029d0 <v2p>
80102a98:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a9d:	76 0c                	jbe    80102aab <kfree+0x39>
    panic("kfree");
80102a9f:	c7 04 24 6f 86 10 80 	movl   $0x8010866f,(%esp)
80102aa6:	e8 92 da ff ff       	call   8010053d <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102aab:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102ab2:	00 
80102ab3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102aba:	00 
80102abb:	8b 45 08             	mov    0x8(%ebp),%eax
80102abe:	89 04 24             	mov    %eax,(%esp)
80102ac1:	e8 0c 25 00 00       	call   80104fd2 <memset>

  if(kmem.use_lock)
80102ac6:	a1 54 22 11 80       	mov    0x80112254,%eax
80102acb:	85 c0                	test   %eax,%eax
80102acd:	74 0c                	je     80102adb <kfree+0x69>
    acquire(&kmem.lock);
80102acf:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102ad6:	e8 a8 22 00 00       	call   80104d83 <acquire>
  r = (struct run*)v;
80102adb:	8b 45 08             	mov    0x8(%ebp),%eax
80102ade:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102ae1:	8b 15 58 22 11 80    	mov    0x80112258,%edx
80102ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aea:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aef:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102af4:	a1 54 22 11 80       	mov    0x80112254,%eax
80102af9:	85 c0                	test   %eax,%eax
80102afb:	74 0c                	je     80102b09 <kfree+0x97>
    release(&kmem.lock);
80102afd:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102b04:	e8 dc 22 00 00       	call   80104de5 <release>
}
80102b09:	c9                   	leave  
80102b0a:	c3                   	ret    

80102b0b <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b0b:	55                   	push   %ebp
80102b0c:	89 e5                	mov    %esp,%ebp
80102b0e:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102b11:	a1 54 22 11 80       	mov    0x80112254,%eax
80102b16:	85 c0                	test   %eax,%eax
80102b18:	74 0c                	je     80102b26 <kalloc+0x1b>
    acquire(&kmem.lock);
80102b1a:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102b21:	e8 5d 22 00 00       	call   80104d83 <acquire>
  r = kmem.freelist;
80102b26:	a1 58 22 11 80       	mov    0x80112258,%eax
80102b2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102b2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102b32:	74 0a                	je     80102b3e <kalloc+0x33>
    kmem.freelist = r->next;
80102b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b37:	8b 00                	mov    (%eax),%eax
80102b39:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102b3e:	a1 54 22 11 80       	mov    0x80112254,%eax
80102b43:	85 c0                	test   %eax,%eax
80102b45:	74 0c                	je     80102b53 <kalloc+0x48>
    release(&kmem.lock);
80102b47:	c7 04 24 20 22 11 80 	movl   $0x80112220,(%esp)
80102b4e:	e8 92 22 00 00       	call   80104de5 <release>
  return (char*)r;
80102b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102b56:	c9                   	leave  
80102b57:	c3                   	ret    

80102b58 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102b58:	55                   	push   %ebp
80102b59:	89 e5                	mov    %esp,%ebp
80102b5b:	53                   	push   %ebx
80102b5c:	83 ec 14             	sub    $0x14,%esp
80102b5f:	8b 45 08             	mov    0x8(%ebp),%eax
80102b62:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b66:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80102b6a:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80102b6e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80102b72:	ec                   	in     (%dx),%al
80102b73:	89 c3                	mov    %eax,%ebx
80102b75:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80102b78:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80102b7c:	83 c4 14             	add    $0x14,%esp
80102b7f:	5b                   	pop    %ebx
80102b80:	5d                   	pop    %ebp
80102b81:	c3                   	ret    

80102b82 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102b82:	55                   	push   %ebp
80102b83:	89 e5                	mov    %esp,%ebp
80102b85:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102b88:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102b8f:	e8 c4 ff ff ff       	call   80102b58 <inb>
80102b94:	0f b6 c0             	movzbl %al,%eax
80102b97:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102b9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b9d:	83 e0 01             	and    $0x1,%eax
80102ba0:	85 c0                	test   %eax,%eax
80102ba2:	75 0a                	jne    80102bae <kbdgetc+0x2c>
    return -1;
80102ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ba9:	e9 23 01 00 00       	jmp    80102cd1 <kbdgetc+0x14f>
  data = inb(KBDATAP);
80102bae:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
80102bb5:	e8 9e ff ff ff       	call   80102b58 <inb>
80102bba:	0f b6 c0             	movzbl %al,%eax
80102bbd:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102bc0:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102bc7:	75 17                	jne    80102be0 <kbdgetc+0x5e>
    shift |= E0ESC;
80102bc9:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102bce:	83 c8 40             	or     $0x40,%eax
80102bd1:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102bd6:	b8 00 00 00 00       	mov    $0x0,%eax
80102bdb:	e9 f1 00 00 00       	jmp    80102cd1 <kbdgetc+0x14f>
  } else if(data & 0x80){
80102be0:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102be3:	25 80 00 00 00       	and    $0x80,%eax
80102be8:	85 c0                	test   %eax,%eax
80102bea:	74 45                	je     80102c31 <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102bec:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102bf1:	83 e0 40             	and    $0x40,%eax
80102bf4:	85 c0                	test   %eax,%eax
80102bf6:	75 08                	jne    80102c00 <kbdgetc+0x7e>
80102bf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102bfb:	83 e0 7f             	and    $0x7f,%eax
80102bfe:	eb 03                	jmp    80102c03 <kbdgetc+0x81>
80102c00:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c03:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102c06:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c09:	05 20 90 10 80       	add    $0x80109020,%eax
80102c0e:	0f b6 00             	movzbl (%eax),%eax
80102c11:	83 c8 40             	or     $0x40,%eax
80102c14:	0f b6 c0             	movzbl %al,%eax
80102c17:	f7 d0                	not    %eax
80102c19:	89 c2                	mov    %eax,%edx
80102c1b:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c20:	21 d0                	and    %edx,%eax
80102c22:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102c27:	b8 00 00 00 00       	mov    $0x0,%eax
80102c2c:	e9 a0 00 00 00       	jmp    80102cd1 <kbdgetc+0x14f>
  } else if(shift & E0ESC){
80102c31:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c36:	83 e0 40             	and    $0x40,%eax
80102c39:	85 c0                	test   %eax,%eax
80102c3b:	74 14                	je     80102c51 <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c3d:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102c44:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c49:	83 e0 bf             	and    $0xffffffbf,%eax
80102c4c:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102c51:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c54:	05 20 90 10 80       	add    $0x80109020,%eax
80102c59:	0f b6 00             	movzbl (%eax),%eax
80102c5c:	0f b6 d0             	movzbl %al,%edx
80102c5f:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c64:	09 d0                	or     %edx,%eax
80102c66:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102c6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c6e:	05 20 91 10 80       	add    $0x80109120,%eax
80102c73:	0f b6 00             	movzbl (%eax),%eax
80102c76:	0f b6 d0             	movzbl %al,%edx
80102c79:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c7e:	31 d0                	xor    %edx,%eax
80102c80:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102c85:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c8a:	83 e0 03             	and    $0x3,%eax
80102c8d:	8b 04 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%eax
80102c94:	03 45 fc             	add    -0x4(%ebp),%eax
80102c97:	0f b6 00             	movzbl (%eax),%eax
80102c9a:	0f b6 c0             	movzbl %al,%eax
80102c9d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102ca0:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102ca5:	83 e0 08             	and    $0x8,%eax
80102ca8:	85 c0                	test   %eax,%eax
80102caa:	74 22                	je     80102cce <kbdgetc+0x14c>
    if('a' <= c && c <= 'z')
80102cac:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102cb0:	76 0c                	jbe    80102cbe <kbdgetc+0x13c>
80102cb2:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102cb6:	77 06                	ja     80102cbe <kbdgetc+0x13c>
      c += 'A' - 'a';
80102cb8:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102cbc:	eb 10                	jmp    80102cce <kbdgetc+0x14c>
    else if('A' <= c && c <= 'Z')
80102cbe:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102cc2:	76 0a                	jbe    80102cce <kbdgetc+0x14c>
80102cc4:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102cc8:	77 04                	ja     80102cce <kbdgetc+0x14c>
      c += 'a' - 'A';
80102cca:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102cce:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102cd1:	c9                   	leave  
80102cd2:	c3                   	ret    

80102cd3 <kbdintr>:

void
kbdintr(void)
{
80102cd3:	55                   	push   %ebp
80102cd4:	89 e5                	mov    %esp,%ebp
80102cd6:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102cd9:	c7 04 24 82 2b 10 80 	movl   $0x80102b82,(%esp)
80102ce0:	e8 c8 da ff ff       	call   801007ad <consoleintr>
}
80102ce5:	c9                   	leave  
80102ce6:	c3                   	ret    
	...

80102ce8 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102ce8:	55                   	push   %ebp
80102ce9:	89 e5                	mov    %esp,%ebp
80102ceb:	83 ec 08             	sub    $0x8,%esp
80102cee:	8b 55 08             	mov    0x8(%ebp),%edx
80102cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
80102cf4:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102cf8:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cfb:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102cff:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102d03:	ee                   	out    %al,(%dx)
}
80102d04:	c9                   	leave  
80102d05:	c3                   	ret    

80102d06 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102d06:	55                   	push   %ebp
80102d07:	89 e5                	mov    %esp,%ebp
80102d09:	53                   	push   %ebx
80102d0a:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102d0d:	9c                   	pushf  
80102d0e:	5b                   	pop    %ebx
80102d0f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80102d12:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102d15:	83 c4 10             	add    $0x10,%esp
80102d18:	5b                   	pop    %ebx
80102d19:	5d                   	pop    %ebp
80102d1a:	c3                   	ret    

80102d1b <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102d1b:	55                   	push   %ebp
80102d1c:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102d1e:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102d23:	8b 55 08             	mov    0x8(%ebp),%edx
80102d26:	c1 e2 02             	shl    $0x2,%edx
80102d29:	01 c2                	add    %eax,%edx
80102d2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d2e:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102d30:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102d35:	83 c0 20             	add    $0x20,%eax
80102d38:	8b 00                	mov    (%eax),%eax
}
80102d3a:	5d                   	pop    %ebp
80102d3b:	c3                   	ret    

80102d3c <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102d3c:	55                   	push   %ebp
80102d3d:	89 e5                	mov    %esp,%ebp
80102d3f:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
80102d42:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102d47:	85 c0                	test   %eax,%eax
80102d49:	0f 84 47 01 00 00    	je     80102e96 <lapicinit+0x15a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102d4f:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102d56:	00 
80102d57:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102d5e:	e8 b8 ff ff ff       	call   80102d1b <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102d63:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102d6a:	00 
80102d6b:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102d72:	e8 a4 ff ff ff       	call   80102d1b <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102d77:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102d7e:	00 
80102d7f:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102d86:	e8 90 ff ff ff       	call   80102d1b <lapicw>
  lapicw(TICR, 10000000); 
80102d8b:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102d92:	00 
80102d93:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102d9a:	e8 7c ff ff ff       	call   80102d1b <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102d9f:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102da6:	00 
80102da7:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102dae:	e8 68 ff ff ff       	call   80102d1b <lapicw>
  lapicw(LINT1, MASKED);
80102db3:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102dba:	00 
80102dbb:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102dc2:	e8 54 ff ff ff       	call   80102d1b <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102dc7:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102dcc:	83 c0 30             	add    $0x30,%eax
80102dcf:	8b 00                	mov    (%eax),%eax
80102dd1:	c1 e8 10             	shr    $0x10,%eax
80102dd4:	25 ff 00 00 00       	and    $0xff,%eax
80102dd9:	83 f8 03             	cmp    $0x3,%eax
80102ddc:	76 14                	jbe    80102df2 <lapicinit+0xb6>
    lapicw(PCINT, MASKED);
80102dde:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102de5:	00 
80102de6:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102ded:	e8 29 ff ff ff       	call   80102d1b <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102df2:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102df9:	00 
80102dfa:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102e01:	e8 15 ff ff ff       	call   80102d1b <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102e06:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e0d:	00 
80102e0e:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102e15:	e8 01 ff ff ff       	call   80102d1b <lapicw>
  lapicw(ESR, 0);
80102e1a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e21:	00 
80102e22:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102e29:	e8 ed fe ff ff       	call   80102d1b <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102e2e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e35:	00 
80102e36:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102e3d:	e8 d9 fe ff ff       	call   80102d1b <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102e42:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e49:	00 
80102e4a:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102e51:	e8 c5 fe ff ff       	call   80102d1b <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102e56:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102e5d:	00 
80102e5e:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102e65:	e8 b1 fe ff ff       	call   80102d1b <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102e6a:	90                   	nop
80102e6b:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e70:	05 00 03 00 00       	add    $0x300,%eax
80102e75:	8b 00                	mov    (%eax),%eax
80102e77:	25 00 10 00 00       	and    $0x1000,%eax
80102e7c:	85 c0                	test   %eax,%eax
80102e7e:	75 eb                	jne    80102e6b <lapicinit+0x12f>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102e80:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e87:	00 
80102e88:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102e8f:	e8 87 fe ff ff       	call   80102d1b <lapicw>
80102e94:	eb 01                	jmp    80102e97 <lapicinit+0x15b>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80102e96:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102e97:	c9                   	leave  
80102e98:	c3                   	ret    

80102e99 <cpunum>:

int
cpunum(void)
{
80102e99:	55                   	push   %ebp
80102e9a:	89 e5                	mov    %esp,%ebp
80102e9c:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102e9f:	e8 62 fe ff ff       	call   80102d06 <readeflags>
80102ea4:	25 00 02 00 00       	and    $0x200,%eax
80102ea9:	85 c0                	test   %eax,%eax
80102eab:	74 29                	je     80102ed6 <cpunum+0x3d>
    static int n;
    if(n++ == 0)
80102ead:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102eb2:	85 c0                	test   %eax,%eax
80102eb4:	0f 94 c2             	sete   %dl
80102eb7:	83 c0 01             	add    $0x1,%eax
80102eba:	a3 40 b6 10 80       	mov    %eax,0x8010b640
80102ebf:	84 d2                	test   %dl,%dl
80102ec1:	74 13                	je     80102ed6 <cpunum+0x3d>
      cprintf("cpu called from %x with interrupts enabled\n",
80102ec3:	8b 45 04             	mov    0x4(%ebp),%eax
80102ec6:	89 44 24 04          	mov    %eax,0x4(%esp)
80102eca:	c7 04 24 78 86 10 80 	movl   $0x80108678,(%esp)
80102ed1:	e8 cb d4 ff ff       	call   801003a1 <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
80102ed6:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102edb:	85 c0                	test   %eax,%eax
80102edd:	74 0f                	je     80102eee <cpunum+0x55>
    return lapic[ID]>>24;
80102edf:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102ee4:	83 c0 20             	add    $0x20,%eax
80102ee7:	8b 00                	mov    (%eax),%eax
80102ee9:	c1 e8 18             	shr    $0x18,%eax
80102eec:	eb 05                	jmp    80102ef3 <cpunum+0x5a>
  return 0;
80102eee:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102ef3:	c9                   	leave  
80102ef4:	c3                   	ret    

80102ef5 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102ef5:	55                   	push   %ebp
80102ef6:	89 e5                	mov    %esp,%ebp
80102ef8:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80102efb:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f00:	85 c0                	test   %eax,%eax
80102f02:	74 14                	je     80102f18 <lapiceoi+0x23>
    lapicw(EOI, 0);
80102f04:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102f0b:	00 
80102f0c:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102f13:	e8 03 fe ff ff       	call   80102d1b <lapicw>
}
80102f18:	c9                   	leave  
80102f19:	c3                   	ret    

80102f1a <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f1a:	55                   	push   %ebp
80102f1b:	89 e5                	mov    %esp,%ebp
}
80102f1d:	5d                   	pop    %ebp
80102f1e:	c3                   	ret    

80102f1f <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f1f:	55                   	push   %ebp
80102f20:	89 e5                	mov    %esp,%ebp
80102f22:	83 ec 1c             	sub    $0x1c,%esp
80102f25:	8b 45 08             	mov    0x8(%ebp),%eax
80102f28:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80102f2b:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80102f32:	00 
80102f33:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80102f3a:	e8 a9 fd ff ff       	call   80102ce8 <outb>
  outb(IO_RTC+1, 0x0A);
80102f3f:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80102f46:	00 
80102f47:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80102f4e:	e8 95 fd ff ff       	call   80102ce8 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102f53:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102f5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102f5d:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102f62:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102f65:	8d 50 02             	lea    0x2(%eax),%edx
80102f68:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f6b:	c1 e8 04             	shr    $0x4,%eax
80102f6e:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f71:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102f75:	c1 e0 18             	shl    $0x18,%eax
80102f78:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f7c:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102f83:	e8 93 fd ff ff       	call   80102d1b <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102f88:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
80102f8f:	00 
80102f90:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f97:	e8 7f fd ff ff       	call   80102d1b <lapicw>
  microdelay(200);
80102f9c:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102fa3:	e8 72 ff ff ff       	call   80102f1a <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
80102fa8:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
80102faf:	00 
80102fb0:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102fb7:	e8 5f fd ff ff       	call   80102d1b <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102fbc:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102fc3:	e8 52 ff ff ff       	call   80102f1a <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102fc8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80102fcf:	eb 40                	jmp    80103011 <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
80102fd1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fd5:	c1 e0 18             	shl    $0x18,%eax
80102fd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fdc:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102fe3:	e8 33 fd ff ff       	call   80102d1b <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
80102fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
80102feb:	c1 e8 0c             	shr    $0xc,%eax
80102fee:	80 cc 06             	or     $0x6,%ah
80102ff1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff5:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102ffc:	e8 1a fd ff ff       	call   80102d1b <lapicw>
    microdelay(200);
80103001:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80103008:	e8 0d ff ff ff       	call   80102f1a <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010300d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103011:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103015:	7e ba                	jle    80102fd1 <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103017:	c9                   	leave  
80103018:	c3                   	ret    
80103019:	00 00                	add    %al,(%eax)
	...

8010301c <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(void)
{
8010301c:	55                   	push   %ebp
8010301d:	89 e5                	mov    %esp,%ebp
8010301f:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103022:	c7 44 24 04 a4 86 10 	movl   $0x801086a4,0x4(%esp)
80103029:	80 
8010302a:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103031:	e8 2c 1d 00 00       	call   80104d62 <initlock>
  readsb(ROOTDEV, &sb);
80103036:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103039:	89 44 24 04          	mov    %eax,0x4(%esp)
8010303d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103044:	e8 af e2 ff ff       	call   801012f8 <readsb>
  log.start = sb.size - sb.nlog;
80103049:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010304c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010304f:	89 d1                	mov    %edx,%ecx
80103051:	29 c1                	sub    %eax,%ecx
80103053:	89 c8                	mov    %ecx,%eax
80103055:	a3 94 22 11 80       	mov    %eax,0x80112294
  log.size = sb.nlog;
8010305a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010305d:	a3 98 22 11 80       	mov    %eax,0x80112298
  log.dev = ROOTDEV;
80103062:	c7 05 a4 22 11 80 01 	movl   $0x1,0x801122a4
80103069:	00 00 00 
  recover_from_log();
8010306c:	e8 97 01 00 00       	call   80103208 <recover_from_log>
}
80103071:	c9                   	leave  
80103072:	c3                   	ret    

80103073 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103073:	55                   	push   %ebp
80103074:	89 e5                	mov    %esp,%ebp
80103076:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103079:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103080:	e9 89 00 00 00       	jmp    8010310e <install_trans+0x9b>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103085:	a1 94 22 11 80       	mov    0x80112294,%eax
8010308a:	03 45 f4             	add    -0xc(%ebp),%eax
8010308d:	83 c0 01             	add    $0x1,%eax
80103090:	89 c2                	mov    %eax,%edx
80103092:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103097:	89 54 24 04          	mov    %edx,0x4(%esp)
8010309b:	89 04 24             	mov    %eax,(%esp)
8010309e:	e8 03 d1 ff ff       	call   801001a6 <bread>
801030a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
801030a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030a9:	83 c0 10             	add    $0x10,%eax
801030ac:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801030b3:	89 c2                	mov    %eax,%edx
801030b5:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801030ba:	89 54 24 04          	mov    %edx,0x4(%esp)
801030be:	89 04 24             	mov    %eax,(%esp)
801030c1:	e8 e0 d0 ff ff       	call   801001a6 <bread>
801030c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030cc:	8d 50 18             	lea    0x18(%eax),%edx
801030cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801030d2:	83 c0 18             	add    $0x18,%eax
801030d5:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801030dc:	00 
801030dd:	89 54 24 04          	mov    %edx,0x4(%esp)
801030e1:	89 04 24             	mov    %eax,(%esp)
801030e4:	e8 bc 1f 00 00       	call   801050a5 <memmove>
    bwrite(dbuf);  // write dst to disk
801030e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801030ec:	89 04 24             	mov    %eax,(%esp)
801030ef:	e8 e9 d0 ff ff       	call   801001dd <bwrite>
    brelse(lbuf); 
801030f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030f7:	89 04 24             	mov    %eax,(%esp)
801030fa:	e8 18 d1 ff ff       	call   80100217 <brelse>
    brelse(dbuf);
801030ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103102:	89 04 24             	mov    %eax,(%esp)
80103105:	e8 0d d1 ff ff       	call   80100217 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010310a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010310e:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103113:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103116:	0f 8f 69 ff ff ff    	jg     80103085 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
8010311c:	c9                   	leave  
8010311d:	c3                   	ret    

8010311e <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
8010311e:	55                   	push   %ebp
8010311f:	89 e5                	mov    %esp,%ebp
80103121:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103124:	a1 94 22 11 80       	mov    0x80112294,%eax
80103129:	89 c2                	mov    %eax,%edx
8010312b:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103130:	89 54 24 04          	mov    %edx,0x4(%esp)
80103134:	89 04 24             	mov    %eax,(%esp)
80103137:	e8 6a d0 ff ff       	call   801001a6 <bread>
8010313c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010313f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103142:	83 c0 18             	add    $0x18,%eax
80103145:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103148:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010314b:	8b 00                	mov    (%eax),%eax
8010314d:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  for (i = 0; i < log.lh.n; i++) {
80103152:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103159:	eb 1b                	jmp    80103176 <read_head+0x58>
    log.lh.sector[i] = lh->sector[i];
8010315b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010315e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103161:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103165:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103168:	83 c2 10             	add    $0x10,%edx
8010316b:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103172:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103176:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010317b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010317e:	7f db                	jg     8010315b <read_head+0x3d>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103180:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103183:	89 04 24             	mov    %eax,(%esp)
80103186:	e8 8c d0 ff ff       	call   80100217 <brelse>
}
8010318b:	c9                   	leave  
8010318c:	c3                   	ret    

8010318d <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010318d:	55                   	push   %ebp
8010318e:	89 e5                	mov    %esp,%ebp
80103190:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103193:	a1 94 22 11 80       	mov    0x80112294,%eax
80103198:	89 c2                	mov    %eax,%edx
8010319a:	a1 a4 22 11 80       	mov    0x801122a4,%eax
8010319f:	89 54 24 04          	mov    %edx,0x4(%esp)
801031a3:	89 04 24             	mov    %eax,(%esp)
801031a6:	e8 fb cf ff ff       	call   801001a6 <bread>
801031ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801031ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031b1:	83 c0 18             	add    $0x18,%eax
801031b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801031b7:	8b 15 a8 22 11 80    	mov    0x801122a8,%edx
801031bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031c0:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801031c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801031c9:	eb 1b                	jmp    801031e6 <write_head+0x59>
    hb->sector[i] = log.lh.sector[i];
801031cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031ce:	83 c0 10             	add    $0x10,%eax
801031d1:	8b 0c 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%ecx
801031d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031db:	8b 55 f4             	mov    -0xc(%ebp),%edx
801031de:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801031e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801031e6:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801031eb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801031ee:	7f db                	jg     801031cb <write_head+0x3e>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801031f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031f3:	89 04 24             	mov    %eax,(%esp)
801031f6:	e8 e2 cf ff ff       	call   801001dd <bwrite>
  brelse(buf);
801031fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031fe:	89 04 24             	mov    %eax,(%esp)
80103201:	e8 11 d0 ff ff       	call   80100217 <brelse>
}
80103206:	c9                   	leave  
80103207:	c3                   	ret    

80103208 <recover_from_log>:

static void
recover_from_log(void)
{
80103208:	55                   	push   %ebp
80103209:	89 e5                	mov    %esp,%ebp
8010320b:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010320e:	e8 0b ff ff ff       	call   8010311e <read_head>
  install_trans(); // if committed, copy from log to disk
80103213:	e8 5b fe ff ff       	call   80103073 <install_trans>
  log.lh.n = 0;
80103218:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
8010321f:	00 00 00 
  write_head(); // clear the log
80103222:	e8 66 ff ff ff       	call   8010318d <write_head>
}
80103227:	c9                   	leave  
80103228:	c3                   	ret    

80103229 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103229:	55                   	push   %ebp
8010322a:	89 e5                	mov    %esp,%ebp
8010322c:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
8010322f:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103236:	e8 48 1b 00 00       	call   80104d83 <acquire>
  while(1){
    if(log.committing){
8010323b:	a1 a0 22 11 80       	mov    0x801122a0,%eax
80103240:	85 c0                	test   %eax,%eax
80103242:	74 16                	je     8010325a <begin_op+0x31>
      sleep(&log, &log.lock);
80103244:	c7 44 24 04 60 22 11 	movl   $0x80112260,0x4(%esp)
8010324b:	80 
8010324c:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103253:	e8 43 18 00 00       	call   80104a9b <sleep>
    } else {
      log.outstanding += 1;
      release(&log.lock);
      break;
    }
  }
80103258:	eb e1                	jmp    8010323b <begin_op+0x12>
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010325a:	8b 0d a8 22 11 80    	mov    0x801122a8,%ecx
80103260:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103265:	8d 50 01             	lea    0x1(%eax),%edx
80103268:	89 d0                	mov    %edx,%eax
8010326a:	c1 e0 02             	shl    $0x2,%eax
8010326d:	01 d0                	add    %edx,%eax
8010326f:	01 c0                	add    %eax,%eax
80103271:	01 c8                	add    %ecx,%eax
80103273:	83 f8 1e             	cmp    $0x1e,%eax
80103276:	7e 16                	jle    8010328e <begin_op+0x65>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103278:	c7 44 24 04 60 22 11 	movl   $0x80112260,0x4(%esp)
8010327f:	80 
80103280:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103287:	e8 0f 18 00 00       	call   80104a9b <sleep>
    } else {
      log.outstanding += 1;
      release(&log.lock);
      break;
    }
  }
8010328c:	eb ad                	jmp    8010323b <begin_op+0x12>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
8010328e:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103293:	83 c0 01             	add    $0x1,%eax
80103296:	a3 9c 22 11 80       	mov    %eax,0x8011229c
      release(&log.lock);
8010329b:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
801032a2:	e8 3e 1b 00 00       	call   80104de5 <release>
      break;
801032a7:	90                   	nop
    }
  }
}
801032a8:	c9                   	leave  
801032a9:	c3                   	ret    

801032aa <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801032aa:	55                   	push   %ebp
801032ab:	89 e5                	mov    %esp,%ebp
801032ad:	83 ec 28             	sub    $0x28,%esp
  int do_commit = 0;
801032b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
801032b7:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
801032be:	e8 c0 1a 00 00       	call   80104d83 <acquire>
  log.outstanding -= 1;
801032c3:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801032c8:	83 e8 01             	sub    $0x1,%eax
801032cb:	a3 9c 22 11 80       	mov    %eax,0x8011229c
  if(log.committing)
801032d0:	a1 a0 22 11 80       	mov    0x801122a0,%eax
801032d5:	85 c0                	test   %eax,%eax
801032d7:	74 0c                	je     801032e5 <end_op+0x3b>
    panic("log.committing");
801032d9:	c7 04 24 a8 86 10 80 	movl   $0x801086a8,(%esp)
801032e0:	e8 58 d2 ff ff       	call   8010053d <panic>
  if(log.outstanding == 0){
801032e5:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801032ea:	85 c0                	test   %eax,%eax
801032ec:	75 13                	jne    80103301 <end_op+0x57>
    do_commit = 1;
801032ee:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
801032f5:	c7 05 a0 22 11 80 01 	movl   $0x1,0x801122a0
801032fc:	00 00 00 
801032ff:	eb 0c                	jmp    8010330d <end_op+0x63>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80103301:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103308:	e8 6a 18 00 00       	call   80104b77 <wakeup>
  }
  release(&log.lock);
8010330d:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103314:	e8 cc 1a 00 00       	call   80104de5 <release>

  if(do_commit){
80103319:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010331d:	74 33                	je     80103352 <end_op+0xa8>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
8010331f:	e8 db 00 00 00       	call   801033ff <commit>
    acquire(&log.lock);
80103324:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
8010332b:	e8 53 1a 00 00       	call   80104d83 <acquire>
    log.committing = 0;
80103330:	c7 05 a0 22 11 80 00 	movl   $0x0,0x801122a0
80103337:	00 00 00 
    wakeup(&log);
8010333a:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
80103341:	e8 31 18 00 00       	call   80104b77 <wakeup>
    release(&log.lock);
80103346:	c7 04 24 60 22 11 80 	movl   $0x80112260,(%esp)
8010334d:	e8 93 1a 00 00       	call   80104de5 <release>
  }
}
80103352:	c9                   	leave  
80103353:	c3                   	ret    

80103354 <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
80103354:	55                   	push   %ebp
80103355:	89 e5                	mov    %esp,%ebp
80103357:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010335a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103361:	e9 89 00 00 00       	jmp    801033ef <write_log+0x9b>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103366:	a1 94 22 11 80       	mov    0x80112294,%eax
8010336b:	03 45 f4             	add    -0xc(%ebp),%eax
8010336e:	83 c0 01             	add    $0x1,%eax
80103371:	89 c2                	mov    %eax,%edx
80103373:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103378:	89 54 24 04          	mov    %edx,0x4(%esp)
8010337c:	89 04 24             	mov    %eax,(%esp)
8010337f:	e8 22 ce ff ff       	call   801001a6 <bread>
80103384:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.sector[tail]); // cache block
80103387:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010338a:	83 c0 10             	add    $0x10,%eax
8010338d:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
80103394:	89 c2                	mov    %eax,%edx
80103396:	a1 a4 22 11 80       	mov    0x801122a4,%eax
8010339b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010339f:	89 04 24             	mov    %eax,(%esp)
801033a2:	e8 ff cd ff ff       	call   801001a6 <bread>
801033a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
801033aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033ad:	8d 50 18             	lea    0x18(%eax),%edx
801033b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033b3:	83 c0 18             	add    $0x18,%eax
801033b6:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801033bd:	00 
801033be:	89 54 24 04          	mov    %edx,0x4(%esp)
801033c2:	89 04 24             	mov    %eax,(%esp)
801033c5:	e8 db 1c 00 00       	call   801050a5 <memmove>
    bwrite(to);  // write the log
801033ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033cd:	89 04 24             	mov    %eax,(%esp)
801033d0:	e8 08 ce ff ff       	call   801001dd <bwrite>
    brelse(from); 
801033d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033d8:	89 04 24             	mov    %eax,(%esp)
801033db:	e8 37 ce ff ff       	call   80100217 <brelse>
    brelse(to);
801033e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033e3:	89 04 24             	mov    %eax,(%esp)
801033e6:	e8 2c ce ff ff       	call   80100217 <brelse>
static void 
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801033eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033ef:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801033f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033f7:	0f 8f 69 ff ff ff    	jg     80103366 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from); 
    brelse(to);
  }
}
801033fd:	c9                   	leave  
801033fe:	c3                   	ret    

801033ff <commit>:

static void
commit()
{
801033ff:	55                   	push   %ebp
80103400:	89 e5                	mov    %esp,%ebp
80103402:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103405:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010340a:	85 c0                	test   %eax,%eax
8010340c:	7e 1e                	jle    8010342c <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
8010340e:	e8 41 ff ff ff       	call   80103354 <write_log>
    write_head();    // Write header to disk -- the real commit
80103413:	e8 75 fd ff ff       	call   8010318d <write_head>
    install_trans(); // Now install writes to home locations
80103418:	e8 56 fc ff ff       	call   80103073 <install_trans>
    log.lh.n = 0; 
8010341d:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
80103424:	00 00 00 
    write_head();    // Erase the transaction from the log
80103427:	e8 61 fd ff ff       	call   8010318d <write_head>
  }
}
8010342c:	c9                   	leave  
8010342d:	c3                   	ret    

8010342e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010342e:	55                   	push   %ebp
8010342f:	89 e5                	mov    %esp,%ebp
80103431:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103434:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103439:	83 f8 1d             	cmp    $0x1d,%eax
8010343c:	7f 12                	jg     80103450 <log_write+0x22>
8010343e:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103443:	8b 15 98 22 11 80    	mov    0x80112298,%edx
80103449:	83 ea 01             	sub    $0x1,%edx
8010344c:	39 d0                	cmp    %edx,%eax
8010344e:	7c 0c                	jl     8010345c <log_write+0x2e>
    panic("too big a transaction");
80103450:	c7 04 24 b7 86 10 80 	movl   $0x801086b7,(%esp)
80103457:	e8 e1 d0 ff ff       	call   8010053d <panic>
  if (log.outstanding < 1)
8010345c:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103461:	85 c0                	test   %eax,%eax
80103463:	7f 0c                	jg     80103471 <log_write+0x43>
    panic("log_write outside of trans");
80103465:	c7 04 24 cd 86 10 80 	movl   $0x801086cd,(%esp)
8010346c:	e8 cc d0 ff ff       	call   8010053d <panic>

  for (i = 0; i < log.lh.n; i++) {
80103471:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103478:	eb 1d                	jmp    80103497 <log_write+0x69>
    if (log.lh.sector[i] == b->sector)   // log absorbtion
8010347a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010347d:	83 c0 10             	add    $0x10,%eax
80103480:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
80103487:	89 c2                	mov    %eax,%edx
80103489:	8b 45 08             	mov    0x8(%ebp),%eax
8010348c:	8b 40 08             	mov    0x8(%eax),%eax
8010348f:	39 c2                	cmp    %eax,%edx
80103491:	74 10                	je     801034a3 <log_write+0x75>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103493:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103497:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010349c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010349f:	7f d9                	jg     8010347a <log_write+0x4c>
801034a1:	eb 01                	jmp    801034a4 <log_write+0x76>
    if (log.lh.sector[i] == b->sector)   // log absorbtion
      break;
801034a3:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
801034a4:	8b 45 08             	mov    0x8(%ebp),%eax
801034a7:	8b 40 08             	mov    0x8(%eax),%eax
801034aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034ad:	83 c2 10             	add    $0x10,%edx
801034b0:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
  if (i == log.lh.n)
801034b7:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801034bc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034bf:	75 0d                	jne    801034ce <log_write+0xa0>
    log.lh.n++;
801034c1:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801034c6:	83 c0 01             	add    $0x1,%eax
801034c9:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  b->flags |= B_DIRTY; // prevent eviction
801034ce:	8b 45 08             	mov    0x8(%ebp),%eax
801034d1:	8b 00                	mov    (%eax),%eax
801034d3:	89 c2                	mov    %eax,%edx
801034d5:	83 ca 04             	or     $0x4,%edx
801034d8:	8b 45 08             	mov    0x8(%ebp),%eax
801034db:	89 10                	mov    %edx,(%eax)
}
801034dd:	c9                   	leave  
801034de:	c3                   	ret    
	...

801034e0 <v2p>:
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	8b 45 08             	mov    0x8(%ebp),%eax
801034e6:	05 00 00 00 80       	add    $0x80000000,%eax
801034eb:	5d                   	pop    %ebp
801034ec:	c3                   	ret    

801034ed <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801034ed:	55                   	push   %ebp
801034ee:	89 e5                	mov    %esp,%ebp
801034f0:	8b 45 08             	mov    0x8(%ebp),%eax
801034f3:	05 00 00 00 80       	add    $0x80000000,%eax
801034f8:	5d                   	pop    %ebp
801034f9:	c3                   	ret    

801034fa <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801034fa:	55                   	push   %ebp
801034fb:	89 e5                	mov    %esp,%ebp
801034fd:	53                   	push   %ebx
801034fe:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
80103501:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103504:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
80103507:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010350a:	89 c3                	mov    %eax,%ebx
8010350c:	89 d8                	mov    %ebx,%eax
8010350e:	f0 87 02             	lock xchg %eax,(%edx)
80103511:	89 c3                	mov    %eax,%ebx
80103513:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103516:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103519:	83 c4 10             	add    $0x10,%esp
8010351c:	5b                   	pop    %ebx
8010351d:	5d                   	pop    %ebp
8010351e:	c3                   	ret    

8010351f <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010351f:	55                   	push   %ebp
80103520:	89 e5                	mov    %esp,%ebp
80103522:	83 e4 f0             	and    $0xfffffff0,%esp
80103525:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103528:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
8010352f:	80 
80103530:	c7 04 24 3c 56 11 80 	movl   $0x8011563c,(%esp)
80103537:	e8 a1 f4 ff ff       	call   801029dd <kinit1>
  kvmalloc();      // kernel page table
8010353c:	e8 ad 47 00 00       	call   80107cee <kvmalloc>
  mpinit();        // collect info about this machine
80103541:	e8 53 04 00 00       	call   80103999 <mpinit>
  lapicinit();
80103546:	e8 f1 f7 ff ff       	call   80102d3c <lapicinit>
  seginit();       // set up segments
8010354b:	e8 41 41 00 00       	call   80107691 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103550:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103556:	0f b6 00             	movzbl (%eax),%eax
80103559:	0f b6 c0             	movzbl %al,%eax
8010355c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103560:	c7 04 24 e8 86 10 80 	movl   $0x801086e8,(%esp)
80103567:	e8 35 ce ff ff       	call   801003a1 <cprintf>
  picinit();       // interrupt controller
8010356c:	e8 8d 06 00 00       	call   80103bfe <picinit>
  ioapicinit();    // another interrupt controller
80103571:	e8 57 f3 ff ff       	call   801028cd <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103576:	e8 12 d5 ff ff       	call   80100a8d <consoleinit>
  uartinit();      // serial port
8010357b:	e8 5c 34 00 00       	call   801069dc <uartinit>
  pinit();         // process table
80103580:	e8 8e 0b 00 00       	call   80104113 <pinit>
  tvinit();        // trap vectors
80103585:	e8 f5 2f 00 00       	call   8010657f <tvinit>
  binit();         // buffer cache
8010358a:	e8 a5 ca ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010358f:	e8 78 d9 ff ff       	call   80100f0c <fileinit>
  iinit();         // inode cache
80103594:	e8 26 e0 ff ff       	call   801015bf <iinit>
  ideinit();       // disk
80103599:	e8 94 ef ff ff       	call   80102532 <ideinit>
  if(!ismp)
8010359e:	a1 44 23 11 80       	mov    0x80112344,%eax
801035a3:	85 c0                	test   %eax,%eax
801035a5:	75 05                	jne    801035ac <main+0x8d>
    timerinit();   // uniprocessor timer
801035a7:	e8 16 2f 00 00       	call   801064c2 <timerinit>
  startothers();   // start other processors
801035ac:	e8 7f 00 00 00       	call   80103630 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801035b1:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
801035b8:	8e 
801035b9:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801035c0:	e8 50 f4 ff ff       	call   80102a15 <kinit2>
  userinit();      // first user process
801035c5:	e8 67 0c 00 00       	call   80104231 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
801035ca:	e8 1a 00 00 00       	call   801035e9 <mpmain>

801035cf <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801035cf:	55                   	push   %ebp
801035d0:	89 e5                	mov    %esp,%ebp
801035d2:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801035d5:	e8 2b 47 00 00       	call   80107d05 <switchkvm>
  seginit();
801035da:	e8 b2 40 00 00       	call   80107691 <seginit>
  lapicinit();
801035df:	e8 58 f7 ff ff       	call   80102d3c <lapicinit>
  mpmain();
801035e4:	e8 00 00 00 00       	call   801035e9 <mpmain>

801035e9 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801035e9:	55                   	push   %ebp
801035ea:	89 e5                	mov    %esp,%ebp
801035ec:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801035ef:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801035f5:	0f b6 00             	movzbl (%eax),%eax
801035f8:	0f b6 c0             	movzbl %al,%eax
801035fb:	89 44 24 04          	mov    %eax,0x4(%esp)
801035ff:	c7 04 24 ff 86 10 80 	movl   $0x801086ff,(%esp)
80103606:	e8 96 cd ff ff       	call   801003a1 <cprintf>
  idtinit();       // load idt register
8010360b:	e8 e3 30 00 00       	call   801066f3 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103610:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103616:	05 a8 00 00 00       	add    $0xa8,%eax
8010361b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80103622:	00 
80103623:	89 04 24             	mov    %eax,(%esp)
80103626:	e8 cf fe ff ff       	call   801034fa <xchg>
  scheduler();     // start running processes
8010362b:	e8 bf 12 00 00       	call   801048ef <scheduler>

80103630 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	53                   	push   %ebx
80103634:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103637:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
8010363e:	e8 aa fe ff ff       	call   801034ed <p2v>
80103643:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103646:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010364b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010364f:	c7 44 24 04 0c b5 10 	movl   $0x8010b50c,0x4(%esp)
80103656:	80 
80103657:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010365a:	89 04 24             	mov    %eax,(%esp)
8010365d:	e8 43 1a 00 00       	call   801050a5 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103662:	c7 45 f4 60 23 11 80 	movl   $0x80112360,-0xc(%ebp)
80103669:	e9 86 00 00 00       	jmp    801036f4 <startothers+0xc4>
    if(c == cpus+cpunum())  // We've started already.
8010366e:	e8 26 f8 ff ff       	call   80102e99 <cpunum>
80103673:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103679:	05 60 23 11 80       	add    $0x80112360,%eax
8010367e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103681:	74 69                	je     801036ec <startothers+0xbc>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103683:	e8 83 f4 ff ff       	call   80102b0b <kalloc>
80103688:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010368b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010368e:	83 e8 04             	sub    $0x4,%eax
80103691:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103694:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010369a:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
8010369c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010369f:	83 e8 08             	sub    $0x8,%eax
801036a2:	c7 00 cf 35 10 80    	movl   $0x801035cf,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
801036a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036ab:	8d 58 f4             	lea    -0xc(%eax),%ebx
801036ae:	c7 04 24 00 a0 10 80 	movl   $0x8010a000,(%esp)
801036b5:	e8 26 fe ff ff       	call   801034e0 <v2p>
801036ba:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
801036bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036bf:	89 04 24             	mov    %eax,(%esp)
801036c2:	e8 19 fe ff ff       	call   801034e0 <v2p>
801036c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801036ca:	0f b6 12             	movzbl (%edx),%edx
801036cd:	0f b6 d2             	movzbl %dl,%edx
801036d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801036d4:	89 14 24             	mov    %edx,(%esp)
801036d7:	e8 43 f8 ff ff       	call   80102f1f <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801036dc:	90                   	nop
801036dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036e0:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801036e6:	85 c0                	test   %eax,%eax
801036e8:	74 f3                	je     801036dd <startothers+0xad>
801036ea:	eb 01                	jmp    801036ed <startothers+0xbd>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
801036ec:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801036ed:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
801036f4:	a1 40 29 11 80       	mov    0x80112940,%eax
801036f9:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801036ff:	05 60 23 11 80       	add    $0x80112360,%eax
80103704:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103707:	0f 87 61 ff ff ff    	ja     8010366e <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
8010370d:	83 c4 24             	add    $0x24,%esp
80103710:	5b                   	pop    %ebx
80103711:	5d                   	pop    %ebp
80103712:	c3                   	ret    
	...

80103714 <p2v>:
80103714:	55                   	push   %ebp
80103715:	89 e5                	mov    %esp,%ebp
80103717:	8b 45 08             	mov    0x8(%ebp),%eax
8010371a:	05 00 00 00 80       	add    $0x80000000,%eax
8010371f:	5d                   	pop    %ebp
80103720:	c3                   	ret    

80103721 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103721:	55                   	push   %ebp
80103722:	89 e5                	mov    %esp,%ebp
80103724:	53                   	push   %ebx
80103725:	83 ec 14             	sub    $0x14,%esp
80103728:	8b 45 08             	mov    0x8(%ebp),%eax
8010372b:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010372f:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80103733:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80103737:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
8010373b:	ec                   	in     (%dx),%al
8010373c:	89 c3                	mov    %eax,%ebx
8010373e:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80103741:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80103745:	83 c4 14             	add    $0x14,%esp
80103748:	5b                   	pop    %ebx
80103749:	5d                   	pop    %ebp
8010374a:	c3                   	ret    

8010374b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010374b:	55                   	push   %ebp
8010374c:	89 e5                	mov    %esp,%ebp
8010374e:	83 ec 08             	sub    $0x8,%esp
80103751:	8b 55 08             	mov    0x8(%ebp),%edx
80103754:	8b 45 0c             	mov    0xc(%ebp),%eax
80103757:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010375b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010375e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103762:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103766:	ee                   	out    %al,(%dx)
}
80103767:	c9                   	leave  
80103768:	c3                   	ret    

80103769 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103769:	55                   	push   %ebp
8010376a:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
8010376c:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80103771:	89 c2                	mov    %eax,%edx
80103773:	b8 60 23 11 80       	mov    $0x80112360,%eax
80103778:	89 d1                	mov    %edx,%ecx
8010377a:	29 c1                	sub    %eax,%ecx
8010377c:	89 c8                	mov    %ecx,%eax
8010377e:	c1 f8 02             	sar    $0x2,%eax
80103781:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103787:	5d                   	pop    %ebp
80103788:	c3                   	ret    

80103789 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103789:	55                   	push   %ebp
8010378a:	89 e5                	mov    %esp,%ebp
8010378c:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
8010378f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103796:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010379d:	eb 13                	jmp    801037b2 <sum+0x29>
    sum += addr[i];
8010379f:	8b 45 fc             	mov    -0x4(%ebp),%eax
801037a2:	03 45 08             	add    0x8(%ebp),%eax
801037a5:	0f b6 00             	movzbl (%eax),%eax
801037a8:	0f b6 c0             	movzbl %al,%eax
801037ab:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
801037ae:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801037b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801037b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
801037b8:	7c e5                	jl     8010379f <sum+0x16>
    sum += addr[i];
  return sum;
801037ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801037bd:	c9                   	leave  
801037be:	c3                   	ret    

801037bf <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801037bf:	55                   	push   %ebp
801037c0:	89 e5                	mov    %esp,%ebp
801037c2:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
801037c5:	8b 45 08             	mov    0x8(%ebp),%eax
801037c8:	89 04 24             	mov    %eax,(%esp)
801037cb:	e8 44 ff ff ff       	call   80103714 <p2v>
801037d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801037d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801037d6:	03 45 f0             	add    -0x10(%ebp),%eax
801037d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801037dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037df:	89 45 f4             	mov    %eax,-0xc(%ebp)
801037e2:	eb 3f                	jmp    80103823 <mpsearch1+0x64>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801037e4:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801037eb:	00 
801037ec:	c7 44 24 04 10 87 10 	movl   $0x80108710,0x4(%esp)
801037f3:	80 
801037f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037f7:	89 04 24             	mov    %eax,(%esp)
801037fa:	e8 4a 18 00 00       	call   80105049 <memcmp>
801037ff:	85 c0                	test   %eax,%eax
80103801:	75 1c                	jne    8010381f <mpsearch1+0x60>
80103803:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
8010380a:	00 
8010380b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010380e:	89 04 24             	mov    %eax,(%esp)
80103811:	e8 73 ff ff ff       	call   80103789 <sum>
80103816:	84 c0                	test   %al,%al
80103818:	75 05                	jne    8010381f <mpsearch1+0x60>
      return (struct mp*)p;
8010381a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010381d:	eb 11                	jmp    80103830 <mpsearch1+0x71>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
8010381f:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103826:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103829:	72 b9                	jb     801037e4 <mpsearch1+0x25>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
8010382b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103830:	c9                   	leave  
80103831:	c3                   	ret    

80103832 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103832:	55                   	push   %ebp
80103833:	89 e5                	mov    %esp,%ebp
80103835:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103838:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010383f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103842:	83 c0 0f             	add    $0xf,%eax
80103845:	0f b6 00             	movzbl (%eax),%eax
80103848:	0f b6 c0             	movzbl %al,%eax
8010384b:	89 c2                	mov    %eax,%edx
8010384d:	c1 e2 08             	shl    $0x8,%edx
80103850:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103853:	83 c0 0e             	add    $0xe,%eax
80103856:	0f b6 00             	movzbl (%eax),%eax
80103859:	0f b6 c0             	movzbl %al,%eax
8010385c:	09 d0                	or     %edx,%eax
8010385e:	c1 e0 04             	shl    $0x4,%eax
80103861:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103864:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103868:	74 21                	je     8010388b <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
8010386a:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103871:	00 
80103872:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103875:	89 04 24             	mov    %eax,(%esp)
80103878:	e8 42 ff ff ff       	call   801037bf <mpsearch1>
8010387d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103880:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103884:	74 50                	je     801038d6 <mpsearch+0xa4>
      return mp;
80103886:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103889:	eb 5f                	jmp    801038ea <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
8010388b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010388e:	83 c0 14             	add    $0x14,%eax
80103891:	0f b6 00             	movzbl (%eax),%eax
80103894:	0f b6 c0             	movzbl %al,%eax
80103897:	89 c2                	mov    %eax,%edx
80103899:	c1 e2 08             	shl    $0x8,%edx
8010389c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010389f:	83 c0 13             	add    $0x13,%eax
801038a2:	0f b6 00             	movzbl (%eax),%eax
801038a5:	0f b6 c0             	movzbl %al,%eax
801038a8:	09 d0                	or     %edx,%eax
801038aa:	c1 e0 0a             	shl    $0xa,%eax
801038ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
801038b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038b3:	2d 00 04 00 00       	sub    $0x400,%eax
801038b8:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
801038bf:	00 
801038c0:	89 04 24             	mov    %eax,(%esp)
801038c3:	e8 f7 fe ff ff       	call   801037bf <mpsearch1>
801038c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
801038cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801038cf:	74 05                	je     801038d6 <mpsearch+0xa4>
      return mp;
801038d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801038d4:	eb 14                	jmp    801038ea <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
801038d6:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
801038dd:	00 
801038de:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
801038e5:	e8 d5 fe ff ff       	call   801037bf <mpsearch1>
}
801038ea:	c9                   	leave  
801038eb:	c3                   	ret    

801038ec <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
801038ec:	55                   	push   %ebp
801038ed:	89 e5                	mov    %esp,%ebp
801038ef:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801038f2:	e8 3b ff ff ff       	call   80103832 <mpsearch>
801038f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801038fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801038fe:	74 0a                	je     8010390a <mpconfig+0x1e>
80103900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103903:	8b 40 04             	mov    0x4(%eax),%eax
80103906:	85 c0                	test   %eax,%eax
80103908:	75 0a                	jne    80103914 <mpconfig+0x28>
    return 0;
8010390a:	b8 00 00 00 00       	mov    $0x0,%eax
8010390f:	e9 83 00 00 00       	jmp    80103997 <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103914:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103917:	8b 40 04             	mov    0x4(%eax),%eax
8010391a:	89 04 24             	mov    %eax,(%esp)
8010391d:	e8 f2 fd ff ff       	call   80103714 <p2v>
80103922:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103925:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010392c:	00 
8010392d:	c7 44 24 04 15 87 10 	movl   $0x80108715,0x4(%esp)
80103934:	80 
80103935:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103938:	89 04 24             	mov    %eax,(%esp)
8010393b:	e8 09 17 00 00       	call   80105049 <memcmp>
80103940:	85 c0                	test   %eax,%eax
80103942:	74 07                	je     8010394b <mpconfig+0x5f>
    return 0;
80103944:	b8 00 00 00 00       	mov    $0x0,%eax
80103949:	eb 4c                	jmp    80103997 <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
8010394b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010394e:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103952:	3c 01                	cmp    $0x1,%al
80103954:	74 12                	je     80103968 <mpconfig+0x7c>
80103956:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103959:	0f b6 40 06          	movzbl 0x6(%eax),%eax
8010395d:	3c 04                	cmp    $0x4,%al
8010395f:	74 07                	je     80103968 <mpconfig+0x7c>
    return 0;
80103961:	b8 00 00 00 00       	mov    $0x0,%eax
80103966:	eb 2f                	jmp    80103997 <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
80103968:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010396b:	0f b7 40 04          	movzwl 0x4(%eax),%eax
8010396f:	0f b7 c0             	movzwl %ax,%eax
80103972:	89 44 24 04          	mov    %eax,0x4(%esp)
80103976:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103979:	89 04 24             	mov    %eax,(%esp)
8010397c:	e8 08 fe ff ff       	call   80103789 <sum>
80103981:	84 c0                	test   %al,%al
80103983:	74 07                	je     8010398c <mpconfig+0xa0>
    return 0;
80103985:	b8 00 00 00 00       	mov    $0x0,%eax
8010398a:	eb 0b                	jmp    80103997 <mpconfig+0xab>
  *pmp = mp;
8010398c:	8b 45 08             	mov    0x8(%ebp),%eax
8010398f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103992:	89 10                	mov    %edx,(%eax)
  return conf;
80103994:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103997:	c9                   	leave  
80103998:	c3                   	ret    

80103999 <mpinit>:

void
mpinit(void)
{
80103999:	55                   	push   %ebp
8010399a:	89 e5                	mov    %esp,%ebp
8010399c:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
8010399f:	c7 05 44 b6 10 80 60 	movl   $0x80112360,0x8010b644
801039a6:	23 11 80 
  if((conf = mpconfig(&mp)) == 0)
801039a9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801039ac:	89 04 24             	mov    %eax,(%esp)
801039af:	e8 38 ff ff ff       	call   801038ec <mpconfig>
801039b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801039b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801039bb:	0f 84 9c 01 00 00    	je     80103b5d <mpinit+0x1c4>
    return;
  ismp = 1;
801039c1:	c7 05 44 23 11 80 01 	movl   $0x1,0x80112344
801039c8:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801039cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039ce:	8b 40 24             	mov    0x24(%eax),%eax
801039d1:	a3 5c 22 11 80       	mov    %eax,0x8011225c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039d9:	83 c0 2c             	add    $0x2c,%eax
801039dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801039df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039e2:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801039e6:	0f b7 c0             	movzwl %ax,%eax
801039e9:	03 45 f0             	add    -0x10(%ebp),%eax
801039ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
801039ef:	e9 f4 00 00 00       	jmp    80103ae8 <mpinit+0x14f>
    switch(*p){
801039f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039f7:	0f b6 00             	movzbl (%eax),%eax
801039fa:	0f b6 c0             	movzbl %al,%eax
801039fd:	83 f8 04             	cmp    $0x4,%eax
80103a00:	0f 87 bf 00 00 00    	ja     80103ac5 <mpinit+0x12c>
80103a06:	8b 04 85 58 87 10 80 	mov    -0x7fef78a8(,%eax,4),%eax
80103a0d:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a12:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103a15:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103a18:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103a1c:	0f b6 d0             	movzbl %al,%edx
80103a1f:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a24:	39 c2                	cmp    %eax,%edx
80103a26:	74 2d                	je     80103a55 <mpinit+0xbc>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103a28:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103a2b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103a2f:	0f b6 d0             	movzbl %al,%edx
80103a32:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a37:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a3f:	c7 04 24 1a 87 10 80 	movl   $0x8010871a,(%esp)
80103a46:	e8 56 c9 ff ff       	call   801003a1 <cprintf>
        ismp = 0;
80103a4b:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103a52:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103a55:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103a58:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103a5c:	0f b6 c0             	movzbl %al,%eax
80103a5f:	83 e0 02             	and    $0x2,%eax
80103a62:	85 c0                	test   %eax,%eax
80103a64:	74 15                	je     80103a7b <mpinit+0xe2>
        bcpu = &cpus[ncpu];
80103a66:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a6b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a71:	05 60 23 11 80       	add    $0x80112360,%eax
80103a76:	a3 44 b6 10 80       	mov    %eax,0x8010b644
      cpus[ncpu].id = ncpu;
80103a7b:	8b 15 40 29 11 80    	mov    0x80112940,%edx
80103a81:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a86:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103a8c:	81 c2 60 23 11 80    	add    $0x80112360,%edx
80103a92:	88 02                	mov    %al,(%edx)
      ncpu++;
80103a94:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a99:	83 c0 01             	add    $0x1,%eax
80103a9c:	a3 40 29 11 80       	mov    %eax,0x80112940
      p += sizeof(struct mpproc);
80103aa1:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103aa5:	eb 41                	jmp    80103ae8 <mpinit+0x14f>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aaa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103aad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103ab0:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103ab4:	a2 40 23 11 80       	mov    %al,0x80112340
      p += sizeof(struct mpioapic);
80103ab9:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103abd:	eb 29                	jmp    80103ae8 <mpinit+0x14f>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103abf:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ac3:	eb 23                	jmp    80103ae8 <mpinit+0x14f>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ac8:	0f b6 00             	movzbl (%eax),%eax
80103acb:	0f b6 c0             	movzbl %al,%eax
80103ace:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ad2:	c7 04 24 38 87 10 80 	movl   $0x80108738,(%esp)
80103ad9:	e8 c3 c8 ff ff       	call   801003a1 <cprintf>
      ismp = 0;
80103ade:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103ae5:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ae8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aeb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103aee:	0f 82 00 ff ff ff    	jb     801039f4 <mpinit+0x5b>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103af4:	a1 44 23 11 80       	mov    0x80112344,%eax
80103af9:	85 c0                	test   %eax,%eax
80103afb:	75 1d                	jne    80103b1a <mpinit+0x181>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103afd:	c7 05 40 29 11 80 01 	movl   $0x1,0x80112940
80103b04:	00 00 00 
    lapic = 0;
80103b07:	c7 05 5c 22 11 80 00 	movl   $0x0,0x8011225c
80103b0e:	00 00 00 
    ioapicid = 0;
80103b11:	c6 05 40 23 11 80 00 	movb   $0x0,0x80112340
    return;
80103b18:	eb 44                	jmp    80103b5e <mpinit+0x1c5>
  }

  if(mp->imcrp){
80103b1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103b1d:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103b21:	84 c0                	test   %al,%al
80103b23:	74 39                	je     80103b5e <mpinit+0x1c5>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103b25:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
80103b2c:	00 
80103b2d:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
80103b34:	e8 12 fc ff ff       	call   8010374b <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103b39:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103b40:	e8 dc fb ff ff       	call   80103721 <inb>
80103b45:	83 c8 01             	or     $0x1,%eax
80103b48:	0f b6 c0             	movzbl %al,%eax
80103b4b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b4f:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103b56:	e8 f0 fb ff ff       	call   8010374b <outb>
80103b5b:	eb 01                	jmp    80103b5e <mpinit+0x1c5>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103b5d:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103b5e:	c9                   	leave  
80103b5f:	c3                   	ret    

80103b60 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 08             	sub    $0x8,%esp
80103b66:	8b 55 08             	mov    0x8(%ebp),%edx
80103b69:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b6c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103b70:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b73:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103b77:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103b7b:	ee                   	out    %al,(%dx)
}
80103b7c:	c9                   	leave  
80103b7d:	c3                   	ret    

80103b7e <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103b7e:	55                   	push   %ebp
80103b7f:	89 e5                	mov    %esp,%ebp
80103b81:	83 ec 0c             	sub    $0xc,%esp
80103b84:	8b 45 08             	mov    0x8(%ebp),%eax
80103b87:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103b8b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103b8f:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103b95:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103b99:	0f b6 c0             	movzbl %al,%eax
80103b9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ba0:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103ba7:	e8 b4 ff ff ff       	call   80103b60 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103bac:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103bb0:	66 c1 e8 08          	shr    $0x8,%ax
80103bb4:	0f b6 c0             	movzbl %al,%eax
80103bb7:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bbb:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103bc2:	e8 99 ff ff ff       	call   80103b60 <outb>
}
80103bc7:	c9                   	leave  
80103bc8:	c3                   	ret    

80103bc9 <picenable>:

void
picenable(int irq)
{
80103bc9:	55                   	push   %ebp
80103bca:	89 e5                	mov    %esp,%ebp
80103bcc:	53                   	push   %ebx
80103bcd:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103bd0:	8b 45 08             	mov    0x8(%ebp),%eax
80103bd3:	ba 01 00 00 00       	mov    $0x1,%edx
80103bd8:	89 d3                	mov    %edx,%ebx
80103bda:	89 c1                	mov    %eax,%ecx
80103bdc:	d3 e3                	shl    %cl,%ebx
80103bde:	89 d8                	mov    %ebx,%eax
80103be0:	89 c2                	mov    %eax,%edx
80103be2:	f7 d2                	not    %edx
80103be4:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103beb:	21 d0                	and    %edx,%eax
80103bed:	0f b7 c0             	movzwl %ax,%eax
80103bf0:	89 04 24             	mov    %eax,(%esp)
80103bf3:	e8 86 ff ff ff       	call   80103b7e <picsetmask>
}
80103bf8:	83 c4 04             	add    $0x4,%esp
80103bfb:	5b                   	pop    %ebx
80103bfc:	5d                   	pop    %ebp
80103bfd:	c3                   	ret    

80103bfe <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103bfe:	55                   	push   %ebp
80103bff:	89 e5                	mov    %esp,%ebp
80103c01:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103c04:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103c0b:	00 
80103c0c:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103c13:	e8 48 ff ff ff       	call   80103b60 <outb>
  outb(IO_PIC2+1, 0xFF);
80103c18:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103c1f:	00 
80103c20:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103c27:	e8 34 ff ff ff       	call   80103b60 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103c2c:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103c33:	00 
80103c34:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103c3b:	e8 20 ff ff ff       	call   80103b60 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103c40:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80103c47:	00 
80103c48:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103c4f:	e8 0c ff ff ff       	call   80103b60 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103c54:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
80103c5b:	00 
80103c5c:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103c63:	e8 f8 fe ff ff       	call   80103b60 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103c68:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103c6f:	00 
80103c70:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103c77:	e8 e4 fe ff ff       	call   80103b60 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103c7c:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103c83:	00 
80103c84:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103c8b:	e8 d0 fe ff ff       	call   80103b60 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103c90:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80103c97:	00 
80103c98:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103c9f:	e8 bc fe ff ff       	call   80103b60 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103ca4:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80103cab:	00 
80103cac:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103cb3:	e8 a8 fe ff ff       	call   80103b60 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103cb8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103cbf:	00 
80103cc0:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103cc7:	e8 94 fe ff ff       	call   80103b60 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103ccc:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103cd3:	00 
80103cd4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103cdb:	e8 80 fe ff ff       	call   80103b60 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103ce0:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103ce7:	00 
80103ce8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103cef:	e8 6c fe ff ff       	call   80103b60 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
80103cf4:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103cfb:	00 
80103cfc:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103d03:	e8 58 fe ff ff       	call   80103b60 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80103d08:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103d0f:	00 
80103d10:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103d17:	e8 44 fe ff ff       	call   80103b60 <outb>

  if(irqmask != 0xFFFF)
80103d1c:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103d23:	66 83 f8 ff          	cmp    $0xffff,%ax
80103d27:	74 12                	je     80103d3b <picinit+0x13d>
    picsetmask(irqmask);
80103d29:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103d30:	0f b7 c0             	movzwl %ax,%eax
80103d33:	89 04 24             	mov    %eax,(%esp)
80103d36:	e8 43 fe ff ff       	call   80103b7e <picsetmask>
}
80103d3b:	c9                   	leave  
80103d3c:	c3                   	ret    
80103d3d:	00 00                	add    %al,(%eax)
	...

80103d40 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80103d46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103d56:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d59:	8b 10                	mov    (%eax),%edx
80103d5b:	8b 45 08             	mov    0x8(%ebp),%eax
80103d5e:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103d60:	e8 c3 d1 ff ff       	call   80100f28 <filealloc>
80103d65:	8b 55 08             	mov    0x8(%ebp),%edx
80103d68:	89 02                	mov    %eax,(%edx)
80103d6a:	8b 45 08             	mov    0x8(%ebp),%eax
80103d6d:	8b 00                	mov    (%eax),%eax
80103d6f:	85 c0                	test   %eax,%eax
80103d71:	0f 84 c8 00 00 00    	je     80103e3f <pipealloc+0xff>
80103d77:	e8 ac d1 ff ff       	call   80100f28 <filealloc>
80103d7c:	8b 55 0c             	mov    0xc(%ebp),%edx
80103d7f:	89 02                	mov    %eax,(%edx)
80103d81:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d84:	8b 00                	mov    (%eax),%eax
80103d86:	85 c0                	test   %eax,%eax
80103d88:	0f 84 b1 00 00 00    	je     80103e3f <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103d8e:	e8 78 ed ff ff       	call   80102b0b <kalloc>
80103d93:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103d9a:	0f 84 9e 00 00 00    	je     80103e3e <pipealloc+0xfe>
    goto bad;
  p->readopen = 1;
80103da0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103da3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103daa:	00 00 00 
  p->writeopen = 1;
80103dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103db0:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103db7:	00 00 00 
  p->nwrite = 0;
80103dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dbd:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103dc4:	00 00 00 
  p->nread = 0;
80103dc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dca:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103dd1:	00 00 00 
  initlock(&p->lock, "pipe");
80103dd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dd7:	c7 44 24 04 6c 87 10 	movl   $0x8010876c,0x4(%esp)
80103dde:	80 
80103ddf:	89 04 24             	mov    %eax,(%esp)
80103de2:	e8 7b 0f 00 00       	call   80104d62 <initlock>
  (*f0)->type = FD_PIPE;
80103de7:	8b 45 08             	mov    0x8(%ebp),%eax
80103dea:	8b 00                	mov    (%eax),%eax
80103dec:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103df2:	8b 45 08             	mov    0x8(%ebp),%eax
80103df5:	8b 00                	mov    (%eax),%eax
80103df7:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103dfb:	8b 45 08             	mov    0x8(%ebp),%eax
80103dfe:	8b 00                	mov    (%eax),%eax
80103e00:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103e04:	8b 45 08             	mov    0x8(%ebp),%eax
80103e07:	8b 00                	mov    (%eax),%eax
80103e09:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e0c:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e12:	8b 00                	mov    (%eax),%eax
80103e14:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e1d:	8b 00                	mov    (%eax),%eax
80103e1f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103e23:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e26:	8b 00                	mov    (%eax),%eax
80103e28:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e2f:	8b 00                	mov    (%eax),%eax
80103e31:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e34:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103e37:	b8 00 00 00 00       	mov    $0x0,%eax
80103e3c:	eb 43                	jmp    80103e81 <pipealloc+0x141>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103e3e:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103e3f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103e43:	74 0b                	je     80103e50 <pipealloc+0x110>
    kfree((char*)p);
80103e45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e48:	89 04 24             	mov    %eax,(%esp)
80103e4b:	e8 22 ec ff ff       	call   80102a72 <kfree>
  if(*f0)
80103e50:	8b 45 08             	mov    0x8(%ebp),%eax
80103e53:	8b 00                	mov    (%eax),%eax
80103e55:	85 c0                	test   %eax,%eax
80103e57:	74 0d                	je     80103e66 <pipealloc+0x126>
    fileclose(*f0);
80103e59:	8b 45 08             	mov    0x8(%ebp),%eax
80103e5c:	8b 00                	mov    (%eax),%eax
80103e5e:	89 04 24             	mov    %eax,(%esp)
80103e61:	e8 6a d1 ff ff       	call   80100fd0 <fileclose>
  if(*f1)
80103e66:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e69:	8b 00                	mov    (%eax),%eax
80103e6b:	85 c0                	test   %eax,%eax
80103e6d:	74 0d                	je     80103e7c <pipealloc+0x13c>
    fileclose(*f1);
80103e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e72:	8b 00                	mov    (%eax),%eax
80103e74:	89 04 24             	mov    %eax,(%esp)
80103e77:	e8 54 d1 ff ff       	call   80100fd0 <fileclose>
  return -1;
80103e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103e81:	c9                   	leave  
80103e82:	c3                   	ret    

80103e83 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103e83:	55                   	push   %ebp
80103e84:	89 e5                	mov    %esp,%ebp
80103e86:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
80103e89:	8b 45 08             	mov    0x8(%ebp),%eax
80103e8c:	89 04 24             	mov    %eax,(%esp)
80103e8f:	e8 ef 0e 00 00       	call   80104d83 <acquire>
  if(writable){
80103e94:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103e98:	74 1f                	je     80103eb9 <pipeclose+0x36>
    p->writeopen = 0;
80103e9a:	8b 45 08             	mov    0x8(%ebp),%eax
80103e9d:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103ea4:	00 00 00 
    wakeup(&p->nread);
80103ea7:	8b 45 08             	mov    0x8(%ebp),%eax
80103eaa:	05 34 02 00 00       	add    $0x234,%eax
80103eaf:	89 04 24             	mov    %eax,(%esp)
80103eb2:	e8 c0 0c 00 00       	call   80104b77 <wakeup>
80103eb7:	eb 1d                	jmp    80103ed6 <pipeclose+0x53>
  } else {
    p->readopen = 0;
80103eb9:	8b 45 08             	mov    0x8(%ebp),%eax
80103ebc:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103ec3:	00 00 00 
    wakeup(&p->nwrite);
80103ec6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ec9:	05 38 02 00 00       	add    $0x238,%eax
80103ece:	89 04 24             	mov    %eax,(%esp)
80103ed1:	e8 a1 0c 00 00       	call   80104b77 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103ed6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed9:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103edf:	85 c0                	test   %eax,%eax
80103ee1:	75 25                	jne    80103f08 <pipeclose+0x85>
80103ee3:	8b 45 08             	mov    0x8(%ebp),%eax
80103ee6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103eec:	85 c0                	test   %eax,%eax
80103eee:	75 18                	jne    80103f08 <pipeclose+0x85>
    release(&p->lock);
80103ef0:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef3:	89 04 24             	mov    %eax,(%esp)
80103ef6:	e8 ea 0e 00 00       	call   80104de5 <release>
    kfree((char*)p);
80103efb:	8b 45 08             	mov    0x8(%ebp),%eax
80103efe:	89 04 24             	mov    %eax,(%esp)
80103f01:	e8 6c eb ff ff       	call   80102a72 <kfree>
80103f06:	eb 0b                	jmp    80103f13 <pipeclose+0x90>
  } else
    release(&p->lock);
80103f08:	8b 45 08             	mov    0x8(%ebp),%eax
80103f0b:	89 04 24             	mov    %eax,(%esp)
80103f0e:	e8 d2 0e 00 00       	call   80104de5 <release>
}
80103f13:	c9                   	leave  
80103f14:	c3                   	ret    

80103f15 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103f15:	55                   	push   %ebp
80103f16:	89 e5                	mov    %esp,%ebp
80103f18:	53                   	push   %ebx
80103f19:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80103f1c:	8b 45 08             	mov    0x8(%ebp),%eax
80103f1f:	89 04 24             	mov    %eax,(%esp)
80103f22:	e8 5c 0e 00 00       	call   80104d83 <acquire>
  for(i = 0; i < n; i++){
80103f27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103f2e:	e9 a6 00 00 00       	jmp    80103fd9 <pipewrite+0xc4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80103f33:	8b 45 08             	mov    0x8(%ebp),%eax
80103f36:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103f3c:	85 c0                	test   %eax,%eax
80103f3e:	74 0d                	je     80103f4d <pipewrite+0x38>
80103f40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f46:	8b 40 24             	mov    0x24(%eax),%eax
80103f49:	85 c0                	test   %eax,%eax
80103f4b:	74 15                	je     80103f62 <pipewrite+0x4d>
        release(&p->lock);
80103f4d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f50:	89 04 24             	mov    %eax,(%esp)
80103f53:	e8 8d 0e 00 00       	call   80104de5 <release>
        return -1;
80103f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f5d:	e9 9d 00 00 00       	jmp    80103fff <pipewrite+0xea>
      }
      wakeup(&p->nread);
80103f62:	8b 45 08             	mov    0x8(%ebp),%eax
80103f65:	05 34 02 00 00       	add    $0x234,%eax
80103f6a:	89 04 24             	mov    %eax,(%esp)
80103f6d:	e8 05 0c 00 00       	call   80104b77 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103f72:	8b 45 08             	mov    0x8(%ebp),%eax
80103f75:	8b 55 08             	mov    0x8(%ebp),%edx
80103f78:	81 c2 38 02 00 00    	add    $0x238,%edx
80103f7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f82:	89 14 24             	mov    %edx,(%esp)
80103f85:	e8 11 0b 00 00       	call   80104a9b <sleep>
80103f8a:	eb 01                	jmp    80103f8d <pipewrite+0x78>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103f8c:	90                   	nop
80103f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f90:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80103f96:	8b 45 08             	mov    0x8(%ebp),%eax
80103f99:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103f9f:	05 00 02 00 00       	add    $0x200,%eax
80103fa4:	39 c2                	cmp    %eax,%edx
80103fa6:	74 8b                	je     80103f33 <pipewrite+0x1e>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80103fab:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103fb1:	89 c3                	mov    %eax,%ebx
80103fb3:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80103fb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fbc:	03 55 0c             	add    0xc(%ebp),%edx
80103fbf:	0f b6 0a             	movzbl (%edx),%ecx
80103fc2:	8b 55 08             	mov    0x8(%ebp),%edx
80103fc5:	88 4c 1a 34          	mov    %cl,0x34(%edx,%ebx,1)
80103fc9:	8d 50 01             	lea    0x1(%eax),%edx
80103fcc:	8b 45 08             	mov    0x8(%ebp),%eax
80103fcf:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103fd5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103fd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fdc:	3b 45 10             	cmp    0x10(%ebp),%eax
80103fdf:	7c ab                	jl     80103f8c <pipewrite+0x77>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103fe1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fe4:	05 34 02 00 00       	add    $0x234,%eax
80103fe9:	89 04 24             	mov    %eax,(%esp)
80103fec:	e8 86 0b 00 00       	call   80104b77 <wakeup>
  release(&p->lock);
80103ff1:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff4:	89 04 24             	mov    %eax,(%esp)
80103ff7:	e8 e9 0d 00 00       	call   80104de5 <release>
  return n;
80103ffc:	8b 45 10             	mov    0x10(%ebp),%eax
}
80103fff:	83 c4 24             	add    $0x24,%esp
80104002:	5b                   	pop    %ebx
80104003:	5d                   	pop    %ebp
80104004:	c3                   	ret    

80104005 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104005:	55                   	push   %ebp
80104006:	89 e5                	mov    %esp,%ebp
80104008:	53                   	push   %ebx
80104009:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
8010400c:	8b 45 08             	mov    0x8(%ebp),%eax
8010400f:	89 04 24             	mov    %eax,(%esp)
80104012:	e8 6c 0d 00 00       	call   80104d83 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104017:	eb 3a                	jmp    80104053 <piperead+0x4e>
    if(proc->killed){
80104019:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010401f:	8b 40 24             	mov    0x24(%eax),%eax
80104022:	85 c0                	test   %eax,%eax
80104024:	74 15                	je     8010403b <piperead+0x36>
      release(&p->lock);
80104026:	8b 45 08             	mov    0x8(%ebp),%eax
80104029:	89 04 24             	mov    %eax,(%esp)
8010402c:	e8 b4 0d 00 00       	call   80104de5 <release>
      return -1;
80104031:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104036:	e9 b6 00 00 00       	jmp    801040f1 <piperead+0xec>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010403b:	8b 45 08             	mov    0x8(%ebp),%eax
8010403e:	8b 55 08             	mov    0x8(%ebp),%edx
80104041:	81 c2 34 02 00 00    	add    $0x234,%edx
80104047:	89 44 24 04          	mov    %eax,0x4(%esp)
8010404b:	89 14 24             	mov    %edx,(%esp)
8010404e:	e8 48 0a 00 00       	call   80104a9b <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104053:	8b 45 08             	mov    0x8(%ebp),%eax
80104056:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010405c:	8b 45 08             	mov    0x8(%ebp),%eax
8010405f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104065:	39 c2                	cmp    %eax,%edx
80104067:	75 0d                	jne    80104076 <piperead+0x71>
80104069:	8b 45 08             	mov    0x8(%ebp),%eax
8010406c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104072:	85 c0                	test   %eax,%eax
80104074:	75 a3                	jne    80104019 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104076:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010407d:	eb 49                	jmp    801040c8 <piperead+0xc3>
    if(p->nread == p->nwrite)
8010407f:	8b 45 08             	mov    0x8(%ebp),%eax
80104082:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104088:	8b 45 08             	mov    0x8(%ebp),%eax
8010408b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104091:	39 c2                	cmp    %eax,%edx
80104093:	74 3d                	je     801040d2 <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104095:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104098:	89 c2                	mov    %eax,%edx
8010409a:	03 55 0c             	add    0xc(%ebp),%edx
8010409d:	8b 45 08             	mov    0x8(%ebp),%eax
801040a0:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801040a6:	89 c3                	mov    %eax,%ebx
801040a8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801040ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
801040b1:	0f b6 4c 19 34       	movzbl 0x34(%ecx,%ebx,1),%ecx
801040b6:	88 0a                	mov    %cl,(%edx)
801040b8:	8d 50 01             	lea    0x1(%eax),%edx
801040bb:	8b 45 08             	mov    0x8(%ebp),%eax
801040be:	89 90 34 02 00 00    	mov    %edx,0x234(%eax)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801040c4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801040c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040cb:	3b 45 10             	cmp    0x10(%ebp),%eax
801040ce:	7c af                	jl     8010407f <piperead+0x7a>
801040d0:	eb 01                	jmp    801040d3 <piperead+0xce>
    if(p->nread == p->nwrite)
      break;
801040d2:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801040d3:	8b 45 08             	mov    0x8(%ebp),%eax
801040d6:	05 38 02 00 00       	add    $0x238,%eax
801040db:	89 04 24             	mov    %eax,(%esp)
801040de:	e8 94 0a 00 00       	call   80104b77 <wakeup>
  release(&p->lock);
801040e3:	8b 45 08             	mov    0x8(%ebp),%eax
801040e6:	89 04 24             	mov    %eax,(%esp)
801040e9:	e8 f7 0c 00 00       	call   80104de5 <release>
  return i;
801040ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801040f1:	83 c4 24             	add    $0x24,%esp
801040f4:	5b                   	pop    %ebx
801040f5:	5d                   	pop    %ebp
801040f6:	c3                   	ret    
	...

801040f8 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801040f8:	55                   	push   %ebp
801040f9:	89 e5                	mov    %esp,%ebp
801040fb:	53                   	push   %ebx
801040fc:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801040ff:	9c                   	pushf  
80104100:	5b                   	pop    %ebx
80104101:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80104104:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104107:	83 c4 10             	add    $0x10,%esp
8010410a:	5b                   	pop    %ebx
8010410b:	5d                   	pop    %ebp
8010410c:	c3                   	ret    

8010410d <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
8010410d:	55                   	push   %ebp
8010410e:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104110:	fb                   	sti    
}
80104111:	5d                   	pop    %ebp
80104112:	c3                   	ret    

80104113 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104113:	55                   	push   %ebp
80104114:	89 e5                	mov    %esp,%ebp
80104116:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80104119:	c7 44 24 04 71 87 10 	movl   $0x80108771,0x4(%esp)
80104120:	80 
80104121:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104128:	e8 35 0c 00 00       	call   80104d62 <initlock>
}
8010412d:	c9                   	leave  
8010412e:	c3                   	ret    

8010412f <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010412f:	55                   	push   %ebp
80104130:	89 e5                	mov    %esp,%ebp
80104132:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104135:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010413c:	e8 42 0c 00 00       	call   80104d83 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104141:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104148:	eb 11                	jmp    8010415b <allocproc+0x2c>
    if(p->state == UNUSED)
8010414a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010414d:	8b 40 0c             	mov    0xc(%eax),%eax
80104150:	85 c0                	test   %eax,%eax
80104152:	74 26                	je     8010417a <allocproc+0x4b>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104154:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
8010415b:	81 7d f4 94 4d 11 80 	cmpl   $0x80114d94,-0xc(%ebp)
80104162:	72 e6                	jb     8010414a <allocproc+0x1b>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104164:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010416b:	e8 75 0c 00 00       	call   80104de5 <release>
  return 0;
80104170:	b8 00 00 00 00       	mov    $0x0,%eax
80104175:	e9 b5 00 00 00       	jmp    8010422f <allocproc+0x100>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
8010417a:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010417b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010417e:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104185:	a1 04 b0 10 80       	mov    0x8010b004,%eax
8010418a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010418d:	89 42 10             	mov    %eax,0x10(%edx)
80104190:	83 c0 01             	add    $0x1,%eax
80104193:	a3 04 b0 10 80       	mov    %eax,0x8010b004
  release(&ptable.lock);
80104198:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010419f:	e8 41 0c 00 00       	call   80104de5 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801041a4:	e8 62 e9 ff ff       	call   80102b0b <kalloc>
801041a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041ac:	89 42 08             	mov    %eax,0x8(%edx)
801041af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041b2:	8b 40 08             	mov    0x8(%eax),%eax
801041b5:	85 c0                	test   %eax,%eax
801041b7:	75 11                	jne    801041ca <allocproc+0x9b>
    p->state = UNUSED;
801041b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041bc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801041c3:	b8 00 00 00 00       	mov    $0x0,%eax
801041c8:	eb 65                	jmp    8010422f <allocproc+0x100>
  }
  sp = p->kstack + KSTACKSIZE;
801041ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041cd:	8b 40 08             	mov    0x8(%eax),%eax
801041d0:	05 00 10 00 00       	add    $0x1000,%eax
801041d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801041d8:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801041dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041df:	8b 55 f0             	mov    -0x10(%ebp),%edx
801041e2:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801041e5:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801041e9:	ba 34 65 10 80       	mov    $0x80106534,%edx
801041ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801041f1:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801041f3:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801041f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041fa:	8b 55 f0             	mov    -0x10(%ebp),%edx
801041fd:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104200:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104203:	8b 40 1c             	mov    0x1c(%eax),%eax
80104206:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010420d:	00 
8010420e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104215:	00 
80104216:	89 04 24             	mov    %eax,(%esp)
80104219:	e8 b4 0d 00 00       	call   80104fd2 <memset>
  p->context->eip = (uint)forkret;
8010421e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104221:	8b 40 1c             	mov    0x1c(%eax),%eax
80104224:	ba 6f 4a 10 80       	mov    $0x80104a6f,%edx
80104229:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
8010422c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010422f:	c9                   	leave  
80104230:	c3                   	ret    

80104231 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104231:	55                   	push   %ebp
80104232:	89 e5                	mov    %esp,%ebp
80104234:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104237:	e8 f3 fe ff ff       	call   8010412f <allocproc>
8010423c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
8010423f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104242:	a3 48 b6 10 80       	mov    %eax,0x8010b648
  if((p->pgdir = setupkvm()) == 0)
80104247:	e8 e5 39 00 00       	call   80107c31 <setupkvm>
8010424c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010424f:	89 42 04             	mov    %eax,0x4(%edx)
80104252:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104255:	8b 40 04             	mov    0x4(%eax),%eax
80104258:	85 c0                	test   %eax,%eax
8010425a:	75 0c                	jne    80104268 <userinit+0x37>
    panic("userinit: out of memory?");
8010425c:	c7 04 24 78 87 10 80 	movl   $0x80108778,(%esp)
80104263:	e8 d5 c2 ff ff       	call   8010053d <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104268:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010426d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104270:	8b 40 04             	mov    0x4(%eax),%eax
80104273:	89 54 24 08          	mov    %edx,0x8(%esp)
80104277:	c7 44 24 04 e0 b4 10 	movl   $0x8010b4e0,0x4(%esp)
8010427e:	80 
8010427f:	89 04 24             	mov    %eax,(%esp)
80104282:	e8 02 3c 00 00       	call   80107e89 <inituvm>
  p->sz = PGSIZE;
80104287:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010428a:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104290:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104293:	8b 40 18             	mov    0x18(%eax),%eax
80104296:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
8010429d:	00 
8010429e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801042a5:	00 
801042a6:	89 04 24             	mov    %eax,(%esp)
801042a9:	e8 24 0d 00 00       	call   80104fd2 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801042ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042b1:	8b 40 18             	mov    0x18(%eax),%eax
801042b4:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801042ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042bd:	8b 40 18             	mov    0x18(%eax),%eax
801042c0:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801042c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042c9:	8b 40 18             	mov    0x18(%eax),%eax
801042cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042cf:	8b 52 18             	mov    0x18(%edx),%edx
801042d2:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801042d6:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801042da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042dd:	8b 40 18             	mov    0x18(%eax),%eax
801042e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042e3:	8b 52 18             	mov    0x18(%edx),%edx
801042e6:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801042ea:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801042ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042f1:	8b 40 18             	mov    0x18(%eax),%eax
801042f4:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801042fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042fe:	8b 40 18             	mov    0x18(%eax),%eax
80104301:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104308:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010430b:	8b 40 18             	mov    0x18(%eax),%eax
8010430e:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104315:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104318:	83 c0 6c             	add    $0x6c,%eax
8010431b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104322:	00 
80104323:	c7 44 24 04 91 87 10 	movl   $0x80108791,0x4(%esp)
8010432a:	80 
8010432b:	89 04 24             	mov    %eax,(%esp)
8010432e:	e8 cf 0e 00 00       	call   80105202 <safestrcpy>
  p->cwd = namei("/");
80104333:	c7 04 24 9a 87 10 80 	movl   $0x8010879a,(%esp)
8010433a:	e8 d7 e0 ff ff       	call   80102416 <namei>
8010433f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104342:	89 42 68             	mov    %eax,0x68(%edx)

  p->state = RUNNABLE;
80104345:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104348:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
8010434f:	c9                   	leave  
80104350:	c3                   	ret    

80104351 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104351:	55                   	push   %ebp
80104352:	89 e5                	mov    %esp,%ebp
80104354:	83 ec 28             	sub    $0x28,%esp
  uint sz;
  
  sz = proc->sz;
80104357:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010435d:	8b 00                	mov    (%eax),%eax
8010435f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104362:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104366:	7e 34                	jle    8010439c <growproc+0x4b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104368:	8b 45 08             	mov    0x8(%ebp),%eax
8010436b:	89 c2                	mov    %eax,%edx
8010436d:	03 55 f4             	add    -0xc(%ebp),%edx
80104370:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104376:	8b 40 04             	mov    0x4(%eax),%eax
80104379:	89 54 24 08          	mov    %edx,0x8(%esp)
8010437d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104380:	89 54 24 04          	mov    %edx,0x4(%esp)
80104384:	89 04 24             	mov    %eax,(%esp)
80104387:	e8 77 3c 00 00       	call   80108003 <allocuvm>
8010438c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010438f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104393:	75 41                	jne    801043d6 <growproc+0x85>
      return -1;
80104395:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010439a:	eb 58                	jmp    801043f4 <growproc+0xa3>
  } else if(n < 0){
8010439c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801043a0:	79 34                	jns    801043d6 <growproc+0x85>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801043a2:	8b 45 08             	mov    0x8(%ebp),%eax
801043a5:	89 c2                	mov    %eax,%edx
801043a7:	03 55 f4             	add    -0xc(%ebp),%edx
801043aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043b0:	8b 40 04             	mov    0x4(%eax),%eax
801043b3:	89 54 24 08          	mov    %edx,0x8(%esp)
801043b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043ba:	89 54 24 04          	mov    %edx,0x4(%esp)
801043be:	89 04 24             	mov    %eax,(%esp)
801043c1:	e8 17 3d 00 00       	call   801080dd <deallocuvm>
801043c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801043c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801043cd:	75 07                	jne    801043d6 <growproc+0x85>
      return -1;
801043cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043d4:	eb 1e                	jmp    801043f4 <growproc+0xa3>
  }
  proc->sz = sz;
801043d6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043df:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801043e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043e7:	89 04 24             	mov    %eax,(%esp)
801043ea:	e8 33 39 00 00       	call   80107d22 <switchuvm>
  return 0;
801043ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
801043f4:	c9                   	leave  
801043f5:	c3                   	ret    

801043f6 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(char *ustack, uint wrapperaddr, uint arg1, uint arg2)
{
801043f6:	55                   	push   %ebp
801043f7:	89 e5                	mov    %esp,%ebp
801043f9:	57                   	push   %edi
801043fa:	56                   	push   %esi
801043fb:	53                   	push   %ebx
801043fc:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801043ff:	e8 2b fd ff ff       	call   8010412f <allocproc>
80104404:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104407:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010440b:	75 0a                	jne    80104417 <fork+0x21>
    return -1;
8010440d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104412:	e9 3c 02 00 00       	jmp    80104653 <fork+0x25d>

  if(proc->ctflag){
80104417:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010441d:	8b 40 7c             	mov    0x7c(%eax),%eax
80104420:	85 c0                	test   %eax,%eax
80104422:	74 1e                	je     80104442 <fork+0x4c>

    np->pgdir = proc->pgdir;
80104424:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010442a:	8b 50 04             	mov    0x4(%eax),%edx
8010442d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104430:	89 50 04             	mov    %edx,0x4(%eax)
    //np->kstack = proc->cStack;
    np->type = 1;
80104433:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104436:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
8010443d:	00 00 00 
80104440:	eb 66                	jmp    801044a8 <fork+0xb2>


} else {

    // Copy process state from p.
    if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104442:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104448:	8b 10                	mov    (%eax),%edx
8010444a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104450:	8b 40 04             	mov    0x4(%eax),%eax
80104453:	89 54 24 04          	mov    %edx,0x4(%esp)
80104457:	89 04 24             	mov    %eax,(%esp)
8010445a:	e8 0e 3e 00 00       	call   8010826d <copyuvm>
8010445f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104462:	89 42 04             	mov    %eax,0x4(%edx)
80104465:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104468:	8b 40 04             	mov    0x4(%eax),%eax
8010446b:	85 c0                	test   %eax,%eax
8010446d:	75 2c                	jne    8010449b <fork+0xa5>
      kfree(np->kstack);
8010446f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104472:	8b 40 08             	mov    0x8(%eax),%eax
80104475:	89 04 24             	mov    %eax,(%esp)
80104478:	e8 f5 e5 ff ff       	call   80102a72 <kfree>
      np->kstack = 0;
8010447d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104480:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
      np->state = UNUSED;
80104487:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010448a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
      return -1;
80104491:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104496:	e9 b8 01 00 00       	jmp    80104653 <fork+0x25d>
    }

    np->type = 0;
8010449b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010449e:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801044a5:	00 00 00 
  }

  np->sz = proc->sz;
801044a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044ae:	8b 10                	mov    (%eax),%edx
801044b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801044b3:	89 10                	mov    %edx,(%eax)

  if(proc->type && proc->ctflag)
801044b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044bb:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
801044c1:	85 c0                	test   %eax,%eax
801044c3:	74 1e                	je     801044e3 <fork+0xed>
801044c5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044cb:	8b 40 7c             	mov    0x7c(%eax),%eax
801044ce:	85 c0                	test   %eax,%eax
801044d0:	74 11                	je     801044e3 <fork+0xed>
    np->parent = proc->parent;
801044d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044d8:	8b 50 14             	mov    0x14(%eax),%edx
801044db:	8b 45 e0             	mov    -0x20(%ebp),%eax
801044de:	89 50 14             	mov    %edx,0x14(%eax)
801044e1:	eb 0d                	jmp    801044f0 <fork+0xfa>
  else
    np->parent = proc;
801044e3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801044ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
801044ed:	89 50 14             	mov    %edx,0x14(%eax)

  *np->tf = *proc->tf;
801044f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801044f3:	8b 50 18             	mov    0x18(%eax),%edx
801044f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044fc:	8b 40 18             	mov    0x18(%eax),%eax
801044ff:	89 c3                	mov    %eax,%ebx
80104501:	b8 13 00 00 00       	mov    $0x13,%eax
80104506:	89 d7                	mov    %edx,%edi
80104508:	89 de                	mov    %ebx,%esi
8010450a:	89 c1                	mov    %eax,%ecx
8010450c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

if(proc->ctflag){
8010450e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104514:	8b 40 7c             	mov    0x7c(%eax),%eax
80104517:	85 c0                	test   %eax,%eax
80104519:	74 77                	je     80104592 <fork+0x19c>

  np->tf->eip = wrapperaddr;
8010451b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010451e:	8b 40 18             	mov    0x18(%eax),%eax
80104521:	8b 55 0c             	mov    0xc(%ebp),%edx
80104524:	89 50 38             	mov    %edx,0x38(%eax)

  proc->ustack = ustack;
80104527:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010452d:	8b 55 08             	mov    0x8(%ebp),%edx
80104530:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)

  uint *sp = (uint*)proc->ustack;
80104536:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010453c:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80104542:	89 45 dc             	mov    %eax,-0x24(%ebp)

  *(--sp) = arg2;
80104545:	83 6d dc 04          	subl   $0x4,-0x24(%ebp)
80104549:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010454c:	8b 55 14             	mov    0x14(%ebp),%edx
8010454f:	89 10                	mov    %edx,(%eax)
  *(--sp) = arg1;
80104551:	83 6d dc 04          	subl   $0x4,-0x24(%ebp)
80104555:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104558:	8b 55 10             	mov    0x10(%ebp),%edx
8010455b:	89 10                	mov    %edx,(%eax)
  *(--sp) = 0;
8010455d:	83 6d dc 04          	subl   $0x4,-0x24(%ebp)
80104561:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104564:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  np->tf->esp = (uint)sp;
8010456a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010456d:	8b 40 18             	mov    0x18(%eax),%eax
80104570:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104573:	89 50 44             	mov    %edx,0x44(%eax)
  proc->tcount+=1;
80104576:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010457c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104583:	8b 92 8c 00 00 00    	mov    0x8c(%edx),%edx
80104589:	83 c2 01             	add    $0x1,%edx
8010458c:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
}

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104592:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104595:	8b 40 18             	mov    0x18(%eax),%eax
80104598:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010459f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801045a6:	eb 3d                	jmp    801045e5 <fork+0x1ef>
    if(proc->ofile[i])
801045a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045b1:	83 c2 08             	add    $0x8,%edx
801045b4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801045b8:	85 c0                	test   %eax,%eax
801045ba:	74 25                	je     801045e1 <fork+0x1eb>
      np->ofile[i] = filedup(proc->ofile[i]);
801045bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045c5:	83 c2 08             	add    $0x8,%edx
801045c8:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801045cc:	89 04 24             	mov    %eax,(%esp)
801045cf:	e8 b4 c9 ff ff       	call   80100f88 <filedup>
801045d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
801045d7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801045da:	83 c1 08             	add    $0x8,%ecx
801045dd:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
}

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801045e1:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801045e5:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801045e9:	7e bd                	jle    801045a8 <fork+0x1b2>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801045eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045f1:	8b 40 68             	mov    0x68(%eax),%eax
801045f4:	89 04 24             	mov    %eax,(%esp)
801045f7:	e8 46 d2 ff ff       	call   80101842 <idup>
801045fc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801045ff:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104602:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104608:	8d 50 6c             	lea    0x6c(%eax),%edx
8010460b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010460e:	83 c0 6c             	add    $0x6c,%eax
80104611:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104618:	00 
80104619:	89 54 24 04          	mov    %edx,0x4(%esp)
8010461d:	89 04 24             	mov    %eax,(%esp)
80104620:	e8 dd 0b 00 00       	call   80105202 <safestrcpy>
 
  pid = np->pid;
80104625:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104628:	8b 40 10             	mov    0x10(%eax),%eax
8010462b:	89 45 d8             	mov    %eax,-0x28(%ebp)

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
8010462e:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104635:	e8 49 07 00 00       	call   80104d83 <acquire>
  np->state = RUNNABLE;
8010463a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010463d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
80104644:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010464b:	e8 95 07 00 00       	call   80104de5 <release>

  return pid;
80104650:	8b 45 d8             	mov    -0x28(%ebp),%eax

}
80104653:	83 c4 2c             	add    $0x2c,%esp
80104656:	5b                   	pop    %ebx
80104657:	5e                   	pop    %esi
80104658:	5f                   	pop    %edi
80104659:	5d                   	pop    %ebp
8010465a:	c3                   	ret    

8010465b <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
8010465b:	55                   	push   %ebp
8010465c:	89 e5                	mov    %esp,%ebp
8010465e:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104661:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104668:	a1 48 b6 10 80       	mov    0x8010b648,%eax
8010466d:	39 c2                	cmp    %eax,%edx
8010466f:	75 0c                	jne    8010467d <exit+0x22>
    panic("init exiting");
80104671:	c7 04 24 9c 87 10 80 	movl   $0x8010879c,(%esp)
80104678:	e8 c0 be ff ff       	call   8010053d <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010467d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104684:	eb 44                	jmp    801046ca <exit+0x6f>
    if(proc->ofile[fd]){
80104686:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010468c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010468f:	83 c2 08             	add    $0x8,%edx
80104692:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104696:	85 c0                	test   %eax,%eax
80104698:	74 2c                	je     801046c6 <exit+0x6b>
      fileclose(proc->ofile[fd]);
8010469a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046a3:	83 c2 08             	add    $0x8,%edx
801046a6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046aa:	89 04 24             	mov    %eax,(%esp)
801046ad:	e8 1e c9 ff ff       	call   80100fd0 <fileclose>
      proc->ofile[fd] = 0;
801046b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046bb:	83 c2 08             	add    $0x8,%edx
801046be:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801046c5:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801046c6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801046ca:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801046ce:	7e b6                	jle    80104686 <exit+0x2b>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
801046d0:	e8 54 eb ff ff       	call   80103229 <begin_op>
  iput(proc->cwd);
801046d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046db:	8b 40 68             	mov    0x68(%eax),%eax
801046de:	89 04 24             	mov    %eax,(%esp)
801046e1:	e8 41 d3 ff ff       	call   80101a27 <iput>
  end_op();
801046e6:	e8 bf eb ff ff       	call   801032aa <end_op>
  proc->cwd = 0;
801046eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f1:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801046f8:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
801046ff:	e8 7f 06 00 00       	call   80104d83 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104704:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010470a:	8b 40 14             	mov    0x14(%eax),%eax
8010470d:	89 04 24             	mov    %eax,(%esp)
80104710:	e8 21 04 00 00       	call   80104b36 <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104715:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
8010471c:	eb 3b                	jmp    80104759 <exit+0xfe>
    if(p->parent == proc){
8010471e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104721:	8b 50 14             	mov    0x14(%eax),%edx
80104724:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472a:	39 c2                	cmp    %eax,%edx
8010472c:	75 24                	jne    80104752 <exit+0xf7>
      p->parent = initproc;
8010472e:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
80104734:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104737:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010473a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010473d:	8b 40 0c             	mov    0xc(%eax),%eax
80104740:	83 f8 05             	cmp    $0x5,%eax
80104743:	75 0d                	jne    80104752 <exit+0xf7>
        wakeup1(initproc);
80104745:	a1 48 b6 10 80       	mov    0x8010b648,%eax
8010474a:	89 04 24             	mov    %eax,(%esp)
8010474d:	e8 e4 03 00 00       	call   80104b36 <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104752:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80104759:	81 7d f4 94 4d 11 80 	cmpl   $0x80114d94,-0xc(%ebp)
80104760:	72 bc                	jb     8010471e <exit+0xc3>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104762:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104768:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
8010476f:	e8 17 02 00 00       	call   8010498b <sched>
  panic("zombie exit");
80104774:	c7 04 24 a9 87 10 80 	movl   $0x801087a9,(%esp)
8010477b:	e8 bd bd ff ff       	call   8010053d <panic>

80104780 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint tid)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104786:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010478d:	e8 f1 05 00 00       	call   80104d83 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104792:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104799:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
801047a0:	e9 fa 00 00 00       	jmp    8010489f <wait+0x11f>
      if(p->parent != proc)
801047a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047a8:	8b 50 14             	mov    0x14(%eax),%edx
801047ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047b1:	39 c2                	cmp    %eax,%edx
801047b3:	0f 85 db 00 00 00    	jne    80104894 <wait+0x114>
        continue;
      
      if(tid)
801047b9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801047bd:	74 0f                	je     801047ce <wait+0x4e>
	if(tid != p->pid)
801047bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047c2:	8b 40 10             	mov    0x10(%eax),%eax
801047c5:	3b 45 08             	cmp    0x8(%ebp),%eax
801047c8:	0f 85 c9 00 00 00    	jne    80104897 <wait+0x117>
	  continue;
     
      havekids = 1;
801047ce:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 
      if(p->state == ZOMBIE){
801047d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047d8:	8b 40 0c             	mov    0xc(%eax),%eax
801047db:	83 f8 05             	cmp    $0x5,%eax
801047de:	0f 85 b4 00 00 00    	jne    80104898 <wait+0x118>
        // Found one.
        pid = p->pid;
801047e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047e7:	8b 40 10             	mov    0x10(%eax),%eax
801047ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801047ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047f0:	8b 40 08             	mov    0x8(%eax),%eax
801047f3:	89 04 24             	mov    %eax,(%esp)
801047f6:	e8 77 e2 ff ff       	call   80102a72 <kfree>
        p->kstack = 0;
801047fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047fe:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

	if(!p->type && (p->tcount == 0))
80104805:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104808:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010480e:	85 c0                	test   %eax,%eax
80104810:	75 1d                	jne    8010482f <wait+0xaf>
80104812:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104815:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010481b:	85 c0                	test   %eax,%eax
8010481d:	75 10                	jne    8010482f <wait+0xaf>
           freevm(p->pgdir);
8010481f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104822:	8b 40 04             	mov    0x4(%eax),%eax
80104825:	89 04 24             	mov    %eax,(%esp)
80104828:	e8 6c 39 00 00       	call   80108199 <freevm>
8010482d:	eb 25                	jmp    80104854 <wait+0xd4>
	else {
	   p->pgdir = 0;
8010482f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104832:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	   p->parent->tcount-=1;
80104839:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010483c:	8b 40 14             	mov    0x14(%eax),%eax
8010483f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104842:	8b 52 14             	mov    0x14(%edx),%edx
80104845:	8b 92 8c 00 00 00    	mov    0x8c(%edx),%edx
8010484b:	83 ea 01             	sub    $0x1,%edx
8010484e:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
	}

        p->state = UNUSED;
80104854:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104857:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
8010485e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104861:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104868:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010486b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104872:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104875:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104879:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010487c:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104883:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
8010488a:	e8 56 05 00 00       	call   80104de5 <release>
        return pid;
8010488f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104892:	eb 59                	jmp    801048ed <wait+0x16d>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104894:	90                   	nop
80104895:	eb 01                	jmp    80104898 <wait+0x118>
      
      if(tid)
	if(tid != p->pid)
	  continue;
80104897:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104898:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
8010489f:	81 7d f4 94 4d 11 80 	cmpl   $0x80114d94,-0xc(%ebp)
801048a6:	0f 82 f9 fe ff ff    	jb     801047a5 <wait+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
801048ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801048b0:	74 0d                	je     801048bf <wait+0x13f>
801048b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048b8:	8b 40 24             	mov    0x24(%eax),%eax
801048bb:	85 c0                	test   %eax,%eax
801048bd:	74 13                	je     801048d2 <wait+0x152>
      release(&ptable.lock);
801048bf:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
801048c6:	e8 1a 05 00 00       	call   80104de5 <release>
      return -1;
801048cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048d0:	eb 1b                	jmp    801048ed <wait+0x16d>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801048d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048d8:	c7 44 24 04 60 29 11 	movl   $0x80112960,0x4(%esp)
801048df:	80 
801048e0:	89 04 24             	mov    %eax,(%esp)
801048e3:	e8 b3 01 00 00       	call   80104a9b <sleep>
  }
801048e8:	e9 a5 fe ff ff       	jmp    80104792 <wait+0x12>
}
801048ed:	c9                   	leave  
801048ee:	c3                   	ret    

801048ef <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801048ef:	55                   	push   %ebp
801048f0:	89 e5                	mov    %esp,%ebp
801048f2:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801048f5:	e8 13 f8 ff ff       	call   8010410d <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801048fa:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104901:	e8 7d 04 00 00       	call   80104d83 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104906:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
8010490d:	eb 62                	jmp    80104971 <scheduler+0x82>
      if(p->state != RUNNABLE)
8010490f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104912:	8b 40 0c             	mov    0xc(%eax),%eax
80104915:	83 f8 03             	cmp    $0x3,%eax
80104918:	75 4f                	jne    80104969 <scheduler+0x7a>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
8010491a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010491d:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104923:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104926:	89 04 24             	mov    %eax,(%esp)
80104929:	e8 f4 33 00 00       	call   80107d22 <switchuvm>
      p->state = RUNNING;
8010492e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104931:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104938:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010493e:	8b 40 1c             	mov    0x1c(%eax),%eax
80104941:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104948:	83 c2 04             	add    $0x4,%edx
8010494b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010494f:	89 14 24             	mov    %edx,(%esp)
80104952:	e8 21 09 00 00       	call   80105278 <swtch>
      switchkvm();
80104957:	e8 a9 33 00 00       	call   80107d05 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
8010495c:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104963:	00 00 00 00 
80104967:	eb 01                	jmp    8010496a <scheduler+0x7b>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104969:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010496a:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80104971:	81 7d f4 94 4d 11 80 	cmpl   $0x80114d94,-0xc(%ebp)
80104978:	72 95                	jb     8010490f <scheduler+0x20>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
8010497a:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104981:	e8 5f 04 00 00       	call   80104de5 <release>

  }
80104986:	e9 6a ff ff ff       	jmp    801048f5 <scheduler+0x6>

8010498b <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
8010498b:	55                   	push   %ebp
8010498c:	89 e5                	mov    %esp,%ebp
8010498e:	83 ec 28             	sub    $0x28,%esp
  int intena;

  if(!holding(&ptable.lock))
80104991:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104998:	e8 04 05 00 00       	call   80104ea1 <holding>
8010499d:	85 c0                	test   %eax,%eax
8010499f:	75 0c                	jne    801049ad <sched+0x22>
    panic("sched ptable.lock");
801049a1:	c7 04 24 b5 87 10 80 	movl   $0x801087b5,(%esp)
801049a8:	e8 90 bb ff ff       	call   8010053d <panic>
  if(cpu->ncli != 1)
801049ad:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801049b3:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801049b9:	83 f8 01             	cmp    $0x1,%eax
801049bc:	74 0c                	je     801049ca <sched+0x3f>
    panic("sched locks");
801049be:	c7 04 24 c7 87 10 80 	movl   $0x801087c7,(%esp)
801049c5:	e8 73 bb ff ff       	call   8010053d <panic>
  if(proc->state == RUNNING)
801049ca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049d0:	8b 40 0c             	mov    0xc(%eax),%eax
801049d3:	83 f8 04             	cmp    $0x4,%eax
801049d6:	75 0c                	jne    801049e4 <sched+0x59>
    panic("sched running");
801049d8:	c7 04 24 d3 87 10 80 	movl   $0x801087d3,(%esp)
801049df:	e8 59 bb ff ff       	call   8010053d <panic>
  if(readeflags()&FL_IF)
801049e4:	e8 0f f7 ff ff       	call   801040f8 <readeflags>
801049e9:	25 00 02 00 00       	and    $0x200,%eax
801049ee:	85 c0                	test   %eax,%eax
801049f0:	74 0c                	je     801049fe <sched+0x73>
    panic("sched interruptible");
801049f2:	c7 04 24 e1 87 10 80 	movl   $0x801087e1,(%esp)
801049f9:	e8 3f bb ff ff       	call   8010053d <panic>
  intena = cpu->intena;
801049fe:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a04:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104a0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104a0d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a13:	8b 40 04             	mov    0x4(%eax),%eax
80104a16:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a1d:	83 c2 1c             	add    $0x1c,%edx
80104a20:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a24:	89 14 24             	mov    %edx,(%esp)
80104a27:	e8 4c 08 00 00       	call   80105278 <swtch>
  cpu->intena = intena;
80104a2c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a32:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a35:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104a3b:	c9                   	leave  
80104a3c:	c3                   	ret    

80104a3d <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104a3d:	55                   	push   %ebp
80104a3e:	89 e5                	mov    %esp,%ebp
80104a40:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104a43:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104a4a:	e8 34 03 00 00       	call   80104d83 <acquire>
  proc->state = RUNNABLE;
80104a4f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a55:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104a5c:	e8 2a ff ff ff       	call   8010498b <sched>
  release(&ptable.lock);
80104a61:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104a68:	e8 78 03 00 00       	call   80104de5 <release>
}
80104a6d:	c9                   	leave  
80104a6e:	c3                   	ret    

80104a6f <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104a6f:	55                   	push   %ebp
80104a70:	89 e5                	mov    %esp,%ebp
80104a72:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104a75:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104a7c:	e8 64 03 00 00       	call   80104de5 <release>

  if (first) {
80104a81:	a1 20 b0 10 80       	mov    0x8010b020,%eax
80104a86:	85 c0                	test   %eax,%eax
80104a88:	74 0f                	je     80104a99 <forkret+0x2a>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104a8a:	c7 05 20 b0 10 80 00 	movl   $0x0,0x8010b020
80104a91:	00 00 00 
    initlog();
80104a94:	e8 83 e5 ff ff       	call   8010301c <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104a99:	c9                   	leave  
80104a9a:	c3                   	ret    

80104a9b <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104a9b:	55                   	push   %ebp
80104a9c:	89 e5                	mov    %esp,%ebp
80104a9e:	83 ec 18             	sub    $0x18,%esp
  if(proc == 0)
80104aa1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aa7:	85 c0                	test   %eax,%eax
80104aa9:	75 0c                	jne    80104ab7 <sleep+0x1c>
    panic("sleep");
80104aab:	c7 04 24 f5 87 10 80 	movl   $0x801087f5,(%esp)
80104ab2:	e8 86 ba ff ff       	call   8010053d <panic>

  if(lk == 0)
80104ab7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104abb:	75 0c                	jne    80104ac9 <sleep+0x2e>
    panic("sleep without lk");
80104abd:	c7 04 24 fb 87 10 80 	movl   $0x801087fb,(%esp)
80104ac4:	e8 74 ba ff ff       	call   8010053d <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104ac9:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104ad0:	74 17                	je     80104ae9 <sleep+0x4e>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104ad2:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104ad9:	e8 a5 02 00 00       	call   80104d83 <acquire>
    release(lk);
80104ade:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ae1:	89 04 24             	mov    %eax,(%esp)
80104ae4:	e8 fc 02 00 00       	call   80104de5 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80104ae9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aef:	8b 55 08             	mov    0x8(%ebp),%edx
80104af2:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104af5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104afb:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104b02:	e8 84 fe ff ff       	call   8010498b <sched>

  // Tidy up.
  proc->chan = 0;
80104b07:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b0d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104b14:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104b1b:	74 17                	je     80104b34 <sleep+0x99>
    release(&ptable.lock);
80104b1d:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104b24:	e8 bc 02 00 00       	call   80104de5 <release>
    acquire(lk);
80104b29:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b2c:	89 04 24             	mov    %eax,(%esp)
80104b2f:	e8 4f 02 00 00       	call   80104d83 <acquire>
  }
}
80104b34:	c9                   	leave  
80104b35:	c3                   	ret    

80104b36 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104b36:	55                   	push   %ebp
80104b37:	89 e5                	mov    %esp,%ebp
80104b39:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b3c:	c7 45 fc 94 29 11 80 	movl   $0x80112994,-0x4(%ebp)
80104b43:	eb 27                	jmp    80104b6c <wakeup1+0x36>
    if(p->state == SLEEPING && p->chan == chan)
80104b45:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b48:	8b 40 0c             	mov    0xc(%eax),%eax
80104b4b:	83 f8 02             	cmp    $0x2,%eax
80104b4e:	75 15                	jne    80104b65 <wakeup1+0x2f>
80104b50:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b53:	8b 40 20             	mov    0x20(%eax),%eax
80104b56:	3b 45 08             	cmp    0x8(%ebp),%eax
80104b59:	75 0a                	jne    80104b65 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104b5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b5e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b65:	81 45 fc 90 00 00 00 	addl   $0x90,-0x4(%ebp)
80104b6c:	81 7d fc 94 4d 11 80 	cmpl   $0x80114d94,-0x4(%ebp)
80104b73:	72 d0                	jb     80104b45 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104b75:	c9                   	leave  
80104b76:	c3                   	ret    

80104b77 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104b77:	55                   	push   %ebp
80104b78:	89 e5                	mov    %esp,%ebp
80104b7a:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80104b7d:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104b84:	e8 fa 01 00 00       	call   80104d83 <acquire>
  wakeup1(chan);
80104b89:	8b 45 08             	mov    0x8(%ebp),%eax
80104b8c:	89 04 24             	mov    %eax,(%esp)
80104b8f:	e8 a2 ff ff ff       	call   80104b36 <wakeup1>
  release(&ptable.lock);
80104b94:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104b9b:	e8 45 02 00 00       	call   80104de5 <release>
}
80104ba0:	c9                   	leave  
80104ba1:	c3                   	ret    

80104ba2 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104ba2:	55                   	push   %ebp
80104ba3:	89 e5                	mov    %esp,%ebp
80104ba5:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104ba8:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104baf:	e8 cf 01 00 00       	call   80104d83 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bb4:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104bbb:	eb 44                	jmp    80104c01 <kill+0x5f>
    if(p->pid == pid){
80104bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc0:	8b 40 10             	mov    0x10(%eax),%eax
80104bc3:	3b 45 08             	cmp    0x8(%ebp),%eax
80104bc6:	75 32                	jne    80104bfa <kill+0x58>
      p->killed = 1;
80104bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bcb:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104bd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd5:	8b 40 0c             	mov    0xc(%eax),%eax
80104bd8:	83 f8 02             	cmp    $0x2,%eax
80104bdb:	75 0a                	jne    80104be7 <kill+0x45>
        p->state = RUNNABLE;
80104bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104be0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104be7:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104bee:	e8 f2 01 00 00       	call   80104de5 <release>
      return 0;
80104bf3:	b8 00 00 00 00       	mov    $0x0,%eax
80104bf8:	eb 21                	jmp    80104c1b <kill+0x79>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bfa:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80104c01:	81 7d f4 94 4d 11 80 	cmpl   $0x80114d94,-0xc(%ebp)
80104c08:	72 b3                	jb     80104bbd <kill+0x1b>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104c0a:	c7 04 24 60 29 11 80 	movl   $0x80112960,(%esp)
80104c11:	e8 cf 01 00 00       	call   80104de5 <release>
  return -1;
80104c16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c1b:	c9                   	leave  
80104c1c:	c3                   	ret    

80104c1d <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104c1d:	55                   	push   %ebp
80104c1e:	89 e5                	mov    %esp,%ebp
80104c20:	83 ec 58             	sub    $0x58,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c23:	c7 45 f0 94 29 11 80 	movl   $0x80112994,-0x10(%ebp)
80104c2a:	e9 db 00 00 00       	jmp    80104d0a <procdump+0xed>
    if(p->state == UNUSED)
80104c2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c32:	8b 40 0c             	mov    0xc(%eax),%eax
80104c35:	85 c0                	test   %eax,%eax
80104c37:	0f 84 c5 00 00 00    	je     80104d02 <procdump+0xe5>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c40:	8b 40 0c             	mov    0xc(%eax),%eax
80104c43:	83 f8 05             	cmp    $0x5,%eax
80104c46:	77 23                	ja     80104c6b <procdump+0x4e>
80104c48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c4b:	8b 40 0c             	mov    0xc(%eax),%eax
80104c4e:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104c55:	85 c0                	test   %eax,%eax
80104c57:	74 12                	je     80104c6b <procdump+0x4e>
      state = states[p->state];
80104c59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c5c:	8b 40 0c             	mov    0xc(%eax),%eax
80104c5f:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104c66:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104c69:	eb 07                	jmp    80104c72 <procdump+0x55>
    else
      state = "???";
80104c6b:	c7 45 ec 0c 88 10 80 	movl   $0x8010880c,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104c72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c75:	8d 50 6c             	lea    0x6c(%eax),%edx
80104c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c7b:	8b 40 10             	mov    0x10(%eax),%eax
80104c7e:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104c82:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104c85:	89 54 24 08          	mov    %edx,0x8(%esp)
80104c89:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c8d:	c7 04 24 10 88 10 80 	movl   $0x80108810,(%esp)
80104c94:	e8 08 b7 ff ff       	call   801003a1 <cprintf>
    if(p->state == SLEEPING){
80104c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c9c:	8b 40 0c             	mov    0xc(%eax),%eax
80104c9f:	83 f8 02             	cmp    $0x2,%eax
80104ca2:	75 50                	jne    80104cf4 <procdump+0xd7>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ca4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ca7:	8b 40 1c             	mov    0x1c(%eax),%eax
80104caa:	8b 40 0c             	mov    0xc(%eax),%eax
80104cad:	83 c0 08             	add    $0x8,%eax
80104cb0:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104cb3:	89 54 24 04          	mov    %edx,0x4(%esp)
80104cb7:	89 04 24             	mov    %eax,(%esp)
80104cba:	e8 75 01 00 00       	call   80104e34 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104cbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104cc6:	eb 1b                	jmp    80104ce3 <procdump+0xc6>
        cprintf(" %p", pc[i]);
80104cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ccb:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104ccf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cd3:	c7 04 24 19 88 10 80 	movl   $0x80108819,(%esp)
80104cda:	e8 c2 b6 ff ff       	call   801003a1 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104cdf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104ce3:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104ce7:	7f 0b                	jg     80104cf4 <procdump+0xd7>
80104ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cec:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104cf0:	85 c0                	test   %eax,%eax
80104cf2:	75 d4                	jne    80104cc8 <procdump+0xab>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104cf4:	c7 04 24 1d 88 10 80 	movl   $0x8010881d,(%esp)
80104cfb:	e8 a1 b6 ff ff       	call   801003a1 <cprintf>
80104d00:	eb 01                	jmp    80104d03 <procdump+0xe6>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104d02:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d03:	81 45 f0 90 00 00 00 	addl   $0x90,-0x10(%ebp)
80104d0a:	81 7d f0 94 4d 11 80 	cmpl   $0x80114d94,-0x10(%ebp)
80104d11:	0f 82 18 ff ff ff    	jb     80104c2f <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104d17:	c9                   	leave  
80104d18:	c3                   	ret    
80104d19:	00 00                	add    %al,(%eax)
	...

80104d1c <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104d1c:	55                   	push   %ebp
80104d1d:	89 e5                	mov    %esp,%ebp
80104d1f:	53                   	push   %ebx
80104d20:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104d23:	9c                   	pushf  
80104d24:	5b                   	pop    %ebx
80104d25:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80104d28:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104d2b:	83 c4 10             	add    $0x10,%esp
80104d2e:	5b                   	pop    %ebx
80104d2f:	5d                   	pop    %ebp
80104d30:	c3                   	ret    

80104d31 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104d31:	55                   	push   %ebp
80104d32:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104d34:	fa                   	cli    
}
80104d35:	5d                   	pop    %ebp
80104d36:	c3                   	ret    

80104d37 <sti>:

static inline void
sti(void)
{
80104d37:	55                   	push   %ebp
80104d38:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104d3a:	fb                   	sti    
}
80104d3b:	5d                   	pop    %ebp
80104d3c:	c3                   	ret    

80104d3d <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104d3d:	55                   	push   %ebp
80104d3e:	89 e5                	mov    %esp,%ebp
80104d40:	53                   	push   %ebx
80104d41:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
80104d44:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104d47:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
80104d4a:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104d4d:	89 c3                	mov    %eax,%ebx
80104d4f:	89 d8                	mov    %ebx,%eax
80104d51:	f0 87 02             	lock xchg %eax,(%edx)
80104d54:	89 c3                	mov    %eax,%ebx
80104d56:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104d59:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104d5c:	83 c4 10             	add    $0x10,%esp
80104d5f:	5b                   	pop    %ebx
80104d60:	5d                   	pop    %ebp
80104d61:	c3                   	ret    

80104d62 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104d62:	55                   	push   %ebp
80104d63:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104d65:	8b 45 08             	mov    0x8(%ebp),%eax
80104d68:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d6b:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104d6e:	8b 45 08             	mov    0x8(%ebp),%eax
80104d71:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104d77:	8b 45 08             	mov    0x8(%ebp),%eax
80104d7a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104d81:	5d                   	pop    %ebp
80104d82:	c3                   	ret    

80104d83 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104d83:	55                   	push   %ebp
80104d84:	89 e5                	mov    %esp,%ebp
80104d86:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104d89:	e8 3d 01 00 00       	call   80104ecb <pushcli>
  if(holding(lk))
80104d8e:	8b 45 08             	mov    0x8(%ebp),%eax
80104d91:	89 04 24             	mov    %eax,(%esp)
80104d94:	e8 08 01 00 00       	call   80104ea1 <holding>
80104d99:	85 c0                	test   %eax,%eax
80104d9b:	74 0c                	je     80104da9 <acquire+0x26>
    panic("acquire");
80104d9d:	c7 04 24 49 88 10 80 	movl   $0x80108849,(%esp)
80104da4:	e8 94 b7 ff ff       	call   8010053d <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104da9:	90                   	nop
80104daa:	8b 45 08             	mov    0x8(%ebp),%eax
80104dad:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80104db4:	00 
80104db5:	89 04 24             	mov    %eax,(%esp)
80104db8:	e8 80 ff ff ff       	call   80104d3d <xchg>
80104dbd:	85 c0                	test   %eax,%eax
80104dbf:	75 e9                	jne    80104daa <acquire+0x27>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104dc1:	8b 45 08             	mov    0x8(%ebp),%eax
80104dc4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104dcb:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104dce:	8b 45 08             	mov    0x8(%ebp),%eax
80104dd1:	83 c0 0c             	add    $0xc,%eax
80104dd4:	89 44 24 04          	mov    %eax,0x4(%esp)
80104dd8:	8d 45 08             	lea    0x8(%ebp),%eax
80104ddb:	89 04 24             	mov    %eax,(%esp)
80104dde:	e8 51 00 00 00       	call   80104e34 <getcallerpcs>
}
80104de3:	c9                   	leave  
80104de4:	c3                   	ret    

80104de5 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104de5:	55                   	push   %ebp
80104de6:	89 e5                	mov    %esp,%ebp
80104de8:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80104deb:	8b 45 08             	mov    0x8(%ebp),%eax
80104dee:	89 04 24             	mov    %eax,(%esp)
80104df1:	e8 ab 00 00 00       	call   80104ea1 <holding>
80104df6:	85 c0                	test   %eax,%eax
80104df8:	75 0c                	jne    80104e06 <release+0x21>
    panic("release");
80104dfa:	c7 04 24 51 88 10 80 	movl   $0x80108851,(%esp)
80104e01:	e8 37 b7 ff ff       	call   8010053d <panic>

  lk->pcs[0] = 0;
80104e06:	8b 45 08             	mov    0x8(%ebp),%eax
80104e09:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104e10:	8b 45 08             	mov    0x8(%ebp),%eax
80104e13:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104e1a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e1d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104e24:	00 
80104e25:	89 04 24             	mov    %eax,(%esp)
80104e28:	e8 10 ff ff ff       	call   80104d3d <xchg>

  popcli();
80104e2d:	e8 e1 00 00 00       	call   80104f13 <popcli>
}
80104e32:	c9                   	leave  
80104e33:	c3                   	ret    

80104e34 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104e34:	55                   	push   %ebp
80104e35:	89 e5                	mov    %esp,%ebp
80104e37:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104e3a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e3d:	83 e8 08             	sub    $0x8,%eax
80104e40:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104e43:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104e4a:	eb 32                	jmp    80104e7e <getcallerpcs+0x4a>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104e4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104e50:	74 47                	je     80104e99 <getcallerpcs+0x65>
80104e52:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104e59:	76 3e                	jbe    80104e99 <getcallerpcs+0x65>
80104e5b:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104e5f:	74 38                	je     80104e99 <getcallerpcs+0x65>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104e61:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104e64:	c1 e0 02             	shl    $0x2,%eax
80104e67:	03 45 0c             	add    0xc(%ebp),%eax
80104e6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104e6d:	8b 52 04             	mov    0x4(%edx),%edx
80104e70:	89 10                	mov    %edx,(%eax)
    ebp = (uint*)ebp[0]; // saved %ebp
80104e72:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104e75:	8b 00                	mov    (%eax),%eax
80104e77:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104e7a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104e7e:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104e82:	7e c8                	jle    80104e4c <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104e84:	eb 13                	jmp    80104e99 <getcallerpcs+0x65>
    pcs[i] = 0;
80104e86:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104e89:	c1 e0 02             	shl    $0x2,%eax
80104e8c:	03 45 0c             	add    0xc(%ebp),%eax
80104e8f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104e95:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104e99:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104e9d:	7e e7                	jle    80104e86 <getcallerpcs+0x52>
    pcs[i] = 0;
}
80104e9f:	c9                   	leave  
80104ea0:	c3                   	ret    

80104ea1 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104ea1:	55                   	push   %ebp
80104ea2:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104ea4:	8b 45 08             	mov    0x8(%ebp),%eax
80104ea7:	8b 00                	mov    (%eax),%eax
80104ea9:	85 c0                	test   %eax,%eax
80104eab:	74 17                	je     80104ec4 <holding+0x23>
80104ead:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb0:	8b 50 08             	mov    0x8(%eax),%edx
80104eb3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104eb9:	39 c2                	cmp    %eax,%edx
80104ebb:	75 07                	jne    80104ec4 <holding+0x23>
80104ebd:	b8 01 00 00 00       	mov    $0x1,%eax
80104ec2:	eb 05                	jmp    80104ec9 <holding+0x28>
80104ec4:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104ec9:	5d                   	pop    %ebp
80104eca:	c3                   	ret    

80104ecb <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104ecb:	55                   	push   %ebp
80104ecc:	89 e5                	mov    %esp,%ebp
80104ece:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104ed1:	e8 46 fe ff ff       	call   80104d1c <readeflags>
80104ed6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104ed9:	e8 53 fe ff ff       	call   80104d31 <cli>
  if(cpu->ncli++ == 0)
80104ede:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ee4:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104eea:	85 d2                	test   %edx,%edx
80104eec:	0f 94 c1             	sete   %cl
80104eef:	83 c2 01             	add    $0x1,%edx
80104ef2:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104ef8:	84 c9                	test   %cl,%cl
80104efa:	74 15                	je     80104f11 <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
80104efc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f02:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104f05:	81 e2 00 02 00 00    	and    $0x200,%edx
80104f0b:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104f11:	c9                   	leave  
80104f12:	c3                   	ret    

80104f13 <popcli>:

void
popcli(void)
{
80104f13:	55                   	push   %ebp
80104f14:	89 e5                	mov    %esp,%ebp
80104f16:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
80104f19:	e8 fe fd ff ff       	call   80104d1c <readeflags>
80104f1e:	25 00 02 00 00       	and    $0x200,%eax
80104f23:	85 c0                	test   %eax,%eax
80104f25:	74 0c                	je     80104f33 <popcli+0x20>
    panic("popcli - interruptible");
80104f27:	c7 04 24 59 88 10 80 	movl   $0x80108859,(%esp)
80104f2e:	e8 0a b6 ff ff       	call   8010053d <panic>
  if(--cpu->ncli < 0)
80104f33:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f39:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104f3f:	83 ea 01             	sub    $0x1,%edx
80104f42:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104f48:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104f4e:	85 c0                	test   %eax,%eax
80104f50:	79 0c                	jns    80104f5e <popcli+0x4b>
    panic("popcli");
80104f52:	c7 04 24 70 88 10 80 	movl   $0x80108870,(%esp)
80104f59:	e8 df b5 ff ff       	call   8010053d <panic>
  if(cpu->ncli == 0 && cpu->intena)
80104f5e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f64:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104f6a:	85 c0                	test   %eax,%eax
80104f6c:	75 15                	jne    80104f83 <popcli+0x70>
80104f6e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f74:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104f7a:	85 c0                	test   %eax,%eax
80104f7c:	74 05                	je     80104f83 <popcli+0x70>
    sti();
80104f7e:	e8 b4 fd ff ff       	call   80104d37 <sti>
}
80104f83:	c9                   	leave  
80104f84:	c3                   	ret    
80104f85:	00 00                	add    %al,(%eax)
	...

80104f88 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80104f88:	55                   	push   %ebp
80104f89:	89 e5                	mov    %esp,%ebp
80104f8b:	57                   	push   %edi
80104f8c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80104f8d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f90:	8b 55 10             	mov    0x10(%ebp),%edx
80104f93:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f96:	89 cb                	mov    %ecx,%ebx
80104f98:	89 df                	mov    %ebx,%edi
80104f9a:	89 d1                	mov    %edx,%ecx
80104f9c:	fc                   	cld    
80104f9d:	f3 aa                	rep stos %al,%es:(%edi)
80104f9f:	89 ca                	mov    %ecx,%edx
80104fa1:	89 fb                	mov    %edi,%ebx
80104fa3:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104fa6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104fa9:	5b                   	pop    %ebx
80104faa:	5f                   	pop    %edi
80104fab:	5d                   	pop    %ebp
80104fac:	c3                   	ret    

80104fad <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80104fad:	55                   	push   %ebp
80104fae:	89 e5                	mov    %esp,%ebp
80104fb0:	57                   	push   %edi
80104fb1:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80104fb2:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104fb5:	8b 55 10             	mov    0x10(%ebp),%edx
80104fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fbb:	89 cb                	mov    %ecx,%ebx
80104fbd:	89 df                	mov    %ebx,%edi
80104fbf:	89 d1                	mov    %edx,%ecx
80104fc1:	fc                   	cld    
80104fc2:	f3 ab                	rep stos %eax,%es:(%edi)
80104fc4:	89 ca                	mov    %ecx,%edx
80104fc6:	89 fb                	mov    %edi,%ebx
80104fc8:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104fcb:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104fce:	5b                   	pop    %ebx
80104fcf:	5f                   	pop    %edi
80104fd0:	5d                   	pop    %ebp
80104fd1:	c3                   	ret    

80104fd2 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104fd2:	55                   	push   %ebp
80104fd3:	89 e5                	mov    %esp,%ebp
80104fd5:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
80104fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80104fdb:	83 e0 03             	and    $0x3,%eax
80104fde:	85 c0                	test   %eax,%eax
80104fe0:	75 49                	jne    8010502b <memset+0x59>
80104fe2:	8b 45 10             	mov    0x10(%ebp),%eax
80104fe5:	83 e0 03             	and    $0x3,%eax
80104fe8:	85 c0                	test   %eax,%eax
80104fea:	75 3f                	jne    8010502b <memset+0x59>
    c &= 0xFF;
80104fec:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104ff3:	8b 45 10             	mov    0x10(%ebp),%eax
80104ff6:	c1 e8 02             	shr    $0x2,%eax
80104ff9:	89 c2                	mov    %eax,%edx
80104ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ffe:	89 c1                	mov    %eax,%ecx
80105000:	c1 e1 18             	shl    $0x18,%ecx
80105003:	8b 45 0c             	mov    0xc(%ebp),%eax
80105006:	c1 e0 10             	shl    $0x10,%eax
80105009:	09 c1                	or     %eax,%ecx
8010500b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010500e:	c1 e0 08             	shl    $0x8,%eax
80105011:	09 c8                	or     %ecx,%eax
80105013:	0b 45 0c             	or     0xc(%ebp),%eax
80105016:	89 54 24 08          	mov    %edx,0x8(%esp)
8010501a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010501e:	8b 45 08             	mov    0x8(%ebp),%eax
80105021:	89 04 24             	mov    %eax,(%esp)
80105024:	e8 84 ff ff ff       	call   80104fad <stosl>
80105029:	eb 19                	jmp    80105044 <memset+0x72>
  } else
    stosb(dst, c, n);
8010502b:	8b 45 10             	mov    0x10(%ebp),%eax
8010502e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105032:	8b 45 0c             	mov    0xc(%ebp),%eax
80105035:	89 44 24 04          	mov    %eax,0x4(%esp)
80105039:	8b 45 08             	mov    0x8(%ebp),%eax
8010503c:	89 04 24             	mov    %eax,(%esp)
8010503f:	e8 44 ff ff ff       	call   80104f88 <stosb>
  return dst;
80105044:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105047:	c9                   	leave  
80105048:	c3                   	ret    

80105049 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105049:	55                   	push   %ebp
8010504a:	89 e5                	mov    %esp,%ebp
8010504c:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010504f:	8b 45 08             	mov    0x8(%ebp),%eax
80105052:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105055:	8b 45 0c             	mov    0xc(%ebp),%eax
80105058:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010505b:	eb 32                	jmp    8010508f <memcmp+0x46>
    if(*s1 != *s2)
8010505d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105060:	0f b6 10             	movzbl (%eax),%edx
80105063:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105066:	0f b6 00             	movzbl (%eax),%eax
80105069:	38 c2                	cmp    %al,%dl
8010506b:	74 1a                	je     80105087 <memcmp+0x3e>
      return *s1 - *s2;
8010506d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105070:	0f b6 00             	movzbl (%eax),%eax
80105073:	0f b6 d0             	movzbl %al,%edx
80105076:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105079:	0f b6 00             	movzbl (%eax),%eax
8010507c:	0f b6 c0             	movzbl %al,%eax
8010507f:	89 d1                	mov    %edx,%ecx
80105081:	29 c1                	sub    %eax,%ecx
80105083:	89 c8                	mov    %ecx,%eax
80105085:	eb 1c                	jmp    801050a3 <memcmp+0x5a>
    s1++, s2++;
80105087:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010508b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010508f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105093:	0f 95 c0             	setne  %al
80105096:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010509a:	84 c0                	test   %al,%al
8010509c:	75 bf                	jne    8010505d <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010509e:	b8 00 00 00 00       	mov    $0x0,%eax
}
801050a3:	c9                   	leave  
801050a4:	c3                   	ret    

801050a5 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801050a5:	55                   	push   %ebp
801050a6:	89 e5                	mov    %esp,%ebp
801050a8:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801050ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801050b1:	8b 45 08             	mov    0x8(%ebp),%eax
801050b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
801050b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801050bd:	73 54                	jae    80105113 <memmove+0x6e>
801050bf:	8b 45 10             	mov    0x10(%ebp),%eax
801050c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801050c5:	01 d0                	add    %edx,%eax
801050c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801050ca:	76 47                	jbe    80105113 <memmove+0x6e>
    s += n;
801050cc:	8b 45 10             	mov    0x10(%ebp),%eax
801050cf:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
801050d2:	8b 45 10             	mov    0x10(%ebp),%eax
801050d5:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801050d8:	eb 13                	jmp    801050ed <memmove+0x48>
      *--d = *--s;
801050da:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801050de:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801050e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050e5:	0f b6 10             	movzbl (%eax),%edx
801050e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050eb:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801050ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801050f1:	0f 95 c0             	setne  %al
801050f4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801050f8:	84 c0                	test   %al,%al
801050fa:	75 de                	jne    801050da <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801050fc:	eb 25                	jmp    80105123 <memmove+0x7e>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801050fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105101:	0f b6 10             	movzbl (%eax),%edx
80105104:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105107:	88 10                	mov    %dl,(%eax)
80105109:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010510d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105111:	eb 01                	jmp    80105114 <memmove+0x6f>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105113:	90                   	nop
80105114:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105118:	0f 95 c0             	setne  %al
8010511b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010511f:	84 c0                	test   %al,%al
80105121:	75 db                	jne    801050fe <memmove+0x59>
      *d++ = *s++;

  return dst;
80105123:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105126:	c9                   	leave  
80105127:	c3                   	ret    

80105128 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105128:	55                   	push   %ebp
80105129:	89 e5                	mov    %esp,%ebp
8010512b:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
8010512e:	8b 45 10             	mov    0x10(%ebp),%eax
80105131:	89 44 24 08          	mov    %eax,0x8(%esp)
80105135:	8b 45 0c             	mov    0xc(%ebp),%eax
80105138:	89 44 24 04          	mov    %eax,0x4(%esp)
8010513c:	8b 45 08             	mov    0x8(%ebp),%eax
8010513f:	89 04 24             	mov    %eax,(%esp)
80105142:	e8 5e ff ff ff       	call   801050a5 <memmove>
}
80105147:	c9                   	leave  
80105148:	c3                   	ret    

80105149 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105149:	55                   	push   %ebp
8010514a:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010514c:	eb 0c                	jmp    8010515a <strncmp+0x11>
    n--, p++, q++;
8010514e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105152:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105156:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010515a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010515e:	74 1a                	je     8010517a <strncmp+0x31>
80105160:	8b 45 08             	mov    0x8(%ebp),%eax
80105163:	0f b6 00             	movzbl (%eax),%eax
80105166:	84 c0                	test   %al,%al
80105168:	74 10                	je     8010517a <strncmp+0x31>
8010516a:	8b 45 08             	mov    0x8(%ebp),%eax
8010516d:	0f b6 10             	movzbl (%eax),%edx
80105170:	8b 45 0c             	mov    0xc(%ebp),%eax
80105173:	0f b6 00             	movzbl (%eax),%eax
80105176:	38 c2                	cmp    %al,%dl
80105178:	74 d4                	je     8010514e <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
8010517a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010517e:	75 07                	jne    80105187 <strncmp+0x3e>
    return 0;
80105180:	b8 00 00 00 00       	mov    $0x0,%eax
80105185:	eb 18                	jmp    8010519f <strncmp+0x56>
  return (uchar)*p - (uchar)*q;
80105187:	8b 45 08             	mov    0x8(%ebp),%eax
8010518a:	0f b6 00             	movzbl (%eax),%eax
8010518d:	0f b6 d0             	movzbl %al,%edx
80105190:	8b 45 0c             	mov    0xc(%ebp),%eax
80105193:	0f b6 00             	movzbl (%eax),%eax
80105196:	0f b6 c0             	movzbl %al,%eax
80105199:	89 d1                	mov    %edx,%ecx
8010519b:	29 c1                	sub    %eax,%ecx
8010519d:	89 c8                	mov    %ecx,%eax
}
8010519f:	5d                   	pop    %ebp
801051a0:	c3                   	ret    

801051a1 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801051a1:	55                   	push   %ebp
801051a2:	89 e5                	mov    %esp,%ebp
801051a4:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801051a7:	8b 45 08             	mov    0x8(%ebp),%eax
801051aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801051ad:	90                   	nop
801051ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801051b2:	0f 9f c0             	setg   %al
801051b5:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801051b9:	84 c0                	test   %al,%al
801051bb:	74 30                	je     801051ed <strncpy+0x4c>
801051bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801051c0:	0f b6 10             	movzbl (%eax),%edx
801051c3:	8b 45 08             	mov    0x8(%ebp),%eax
801051c6:	88 10                	mov    %dl,(%eax)
801051c8:	8b 45 08             	mov    0x8(%ebp),%eax
801051cb:	0f b6 00             	movzbl (%eax),%eax
801051ce:	84 c0                	test   %al,%al
801051d0:	0f 95 c0             	setne  %al
801051d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801051d7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801051db:	84 c0                	test   %al,%al
801051dd:	75 cf                	jne    801051ae <strncpy+0xd>
    ;
  while(n-- > 0)
801051df:	eb 0c                	jmp    801051ed <strncpy+0x4c>
    *s++ = 0;
801051e1:	8b 45 08             	mov    0x8(%ebp),%eax
801051e4:	c6 00 00             	movb   $0x0,(%eax)
801051e7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801051eb:	eb 01                	jmp    801051ee <strncpy+0x4d>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801051ed:	90                   	nop
801051ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801051f2:	0f 9f c0             	setg   %al
801051f5:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801051f9:	84 c0                	test   %al,%al
801051fb:	75 e4                	jne    801051e1 <strncpy+0x40>
    *s++ = 0;
  return os;
801051fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105200:	c9                   	leave  
80105201:	c3                   	ret    

80105202 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105202:	55                   	push   %ebp
80105203:	89 e5                	mov    %esp,%ebp
80105205:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105208:	8b 45 08             	mov    0x8(%ebp),%eax
8010520b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
8010520e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105212:	7f 05                	jg     80105219 <safestrcpy+0x17>
    return os;
80105214:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105217:	eb 35                	jmp    8010524e <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
80105219:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010521d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105221:	7e 22                	jle    80105245 <safestrcpy+0x43>
80105223:	8b 45 0c             	mov    0xc(%ebp),%eax
80105226:	0f b6 10             	movzbl (%eax),%edx
80105229:	8b 45 08             	mov    0x8(%ebp),%eax
8010522c:	88 10                	mov    %dl,(%eax)
8010522e:	8b 45 08             	mov    0x8(%ebp),%eax
80105231:	0f b6 00             	movzbl (%eax),%eax
80105234:	84 c0                	test   %al,%al
80105236:	0f 95 c0             	setne  %al
80105239:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010523d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105241:	84 c0                	test   %al,%al
80105243:	75 d4                	jne    80105219 <safestrcpy+0x17>
    ;
  *s = 0;
80105245:	8b 45 08             	mov    0x8(%ebp),%eax
80105248:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010524b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010524e:	c9                   	leave  
8010524f:	c3                   	ret    

80105250 <strlen>:

int
strlen(const char *s)
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105256:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010525d:	eb 04                	jmp    80105263 <strlen+0x13>
8010525f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105263:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105266:	03 45 08             	add    0x8(%ebp),%eax
80105269:	0f b6 00             	movzbl (%eax),%eax
8010526c:	84 c0                	test   %al,%al
8010526e:	75 ef                	jne    8010525f <strlen+0xf>
    ;
  return n;
80105270:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105273:	c9                   	leave  
80105274:	c3                   	ret    
80105275:	00 00                	add    %al,(%eax)
	...

80105278 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105278:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010527c:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105280:	55                   	push   %ebp
  pushl %ebx
80105281:	53                   	push   %ebx
  pushl %esi
80105282:	56                   	push   %esi
  pushl %edi
80105283:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105284:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105286:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105288:	5f                   	pop    %edi
  popl %esi
80105289:	5e                   	pop    %esi
  popl %ebx
8010528a:	5b                   	pop    %ebx
  popl %ebp
8010528b:	5d                   	pop    %ebp
  ret
8010528c:	c3                   	ret    
8010528d:	00 00                	add    %al,(%eax)
	...

80105290 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105293:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105299:	8b 00                	mov    (%eax),%eax
8010529b:	3b 45 08             	cmp    0x8(%ebp),%eax
8010529e:	76 12                	jbe    801052b2 <fetchint+0x22>
801052a0:	8b 45 08             	mov    0x8(%ebp),%eax
801052a3:	8d 50 04             	lea    0x4(%eax),%edx
801052a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052ac:	8b 00                	mov    (%eax),%eax
801052ae:	39 c2                	cmp    %eax,%edx
801052b0:	76 07                	jbe    801052b9 <fetchint+0x29>
    return -1;
801052b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052b7:	eb 0f                	jmp    801052c8 <fetchint+0x38>
  *ip = *(int*)(addr);
801052b9:	8b 45 08             	mov    0x8(%ebp),%eax
801052bc:	8b 10                	mov    (%eax),%edx
801052be:	8b 45 0c             	mov    0xc(%ebp),%eax
801052c1:	89 10                	mov    %edx,(%eax)
  return 0;
801052c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801052c8:	5d                   	pop    %ebp
801052c9:	c3                   	ret    

801052ca <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801052ca:	55                   	push   %ebp
801052cb:	89 e5                	mov    %esp,%ebp
801052cd:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
801052d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052d6:	8b 00                	mov    (%eax),%eax
801052d8:	3b 45 08             	cmp    0x8(%ebp),%eax
801052db:	77 07                	ja     801052e4 <fetchstr+0x1a>
    return -1;
801052dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052e2:	eb 48                	jmp    8010532c <fetchstr+0x62>
  *pp = (char*)addr;
801052e4:	8b 55 08             	mov    0x8(%ebp),%edx
801052e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801052ea:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801052ec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052f2:	8b 00                	mov    (%eax),%eax
801052f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
801052f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801052fa:	8b 00                	mov    (%eax),%eax
801052fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
801052ff:	eb 1e                	jmp    8010531f <fetchstr+0x55>
    if(*s == 0)
80105301:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105304:	0f b6 00             	movzbl (%eax),%eax
80105307:	84 c0                	test   %al,%al
80105309:	75 10                	jne    8010531b <fetchstr+0x51>
      return s - *pp;
8010530b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010530e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105311:	8b 00                	mov    (%eax),%eax
80105313:	89 d1                	mov    %edx,%ecx
80105315:	29 c1                	sub    %eax,%ecx
80105317:	89 c8                	mov    %ecx,%eax
80105319:	eb 11                	jmp    8010532c <fetchstr+0x62>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010531b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010531f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105322:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105325:	72 da                	jb     80105301 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010532c:	c9                   	leave  
8010532d:	c3                   	ret    

8010532e <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010532e:	55                   	push   %ebp
8010532f:	89 e5                	mov    %esp,%ebp
80105331:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105334:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010533a:	8b 40 18             	mov    0x18(%eax),%eax
8010533d:	8b 50 44             	mov    0x44(%eax),%edx
80105340:	8b 45 08             	mov    0x8(%ebp),%eax
80105343:	c1 e0 02             	shl    $0x2,%eax
80105346:	01 d0                	add    %edx,%eax
80105348:	8d 50 04             	lea    0x4(%eax),%edx
8010534b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010534e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105352:	89 14 24             	mov    %edx,(%esp)
80105355:	e8 36 ff ff ff       	call   80105290 <fetchint>
}
8010535a:	c9                   	leave  
8010535b:	c3                   	ret    

8010535c <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
8010535c:	55                   	push   %ebp
8010535d:	89 e5                	mov    %esp,%ebp
8010535f:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105362:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105365:	89 44 24 04          	mov    %eax,0x4(%esp)
80105369:	8b 45 08             	mov    0x8(%ebp),%eax
8010536c:	89 04 24             	mov    %eax,(%esp)
8010536f:	e8 ba ff ff ff       	call   8010532e <argint>
80105374:	85 c0                	test   %eax,%eax
80105376:	79 07                	jns    8010537f <argptr+0x23>
    return -1;
80105378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537d:	eb 3d                	jmp    801053bc <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010537f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105382:	89 c2                	mov    %eax,%edx
80105384:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010538a:	8b 00                	mov    (%eax),%eax
8010538c:	39 c2                	cmp    %eax,%edx
8010538e:	73 16                	jae    801053a6 <argptr+0x4a>
80105390:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105393:	89 c2                	mov    %eax,%edx
80105395:	8b 45 10             	mov    0x10(%ebp),%eax
80105398:	01 c2                	add    %eax,%edx
8010539a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053a0:	8b 00                	mov    (%eax),%eax
801053a2:	39 c2                	cmp    %eax,%edx
801053a4:	76 07                	jbe    801053ad <argptr+0x51>
    return -1;
801053a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ab:	eb 0f                	jmp    801053bc <argptr+0x60>
  *pp = (char*)i;
801053ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053b0:	89 c2                	mov    %eax,%edx
801053b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801053b5:	89 10                	mov    %edx,(%eax)
  return 0;
801053b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801053bc:	c9                   	leave  
801053bd:	c3                   	ret    

801053be <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801053be:	55                   	push   %ebp
801053bf:	89 e5                	mov    %esp,%ebp
801053c1:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
801053c4:	8d 45 fc             	lea    -0x4(%ebp),%eax
801053c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801053cb:	8b 45 08             	mov    0x8(%ebp),%eax
801053ce:	89 04 24             	mov    %eax,(%esp)
801053d1:	e8 58 ff ff ff       	call   8010532e <argint>
801053d6:	85 c0                	test   %eax,%eax
801053d8:	79 07                	jns    801053e1 <argstr+0x23>
    return -1;
801053da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053df:	eb 12                	jmp    801053f3 <argstr+0x35>
  return fetchstr(addr, pp);
801053e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053e4:	8b 55 0c             	mov    0xc(%ebp),%edx
801053e7:	89 54 24 04          	mov    %edx,0x4(%esp)
801053eb:	89 04 24             	mov    %eax,(%esp)
801053ee:	e8 d7 fe ff ff       	call   801052ca <fetchstr>
}
801053f3:	c9                   	leave  
801053f4:	c3                   	ret    

801053f5 <syscall>:
[SYS_kthread_create] sys_kthread_create,
};

void
syscall(void)
{
801053f5:	55                   	push   %ebp
801053f6:	89 e5                	mov    %esp,%ebp
801053f8:	53                   	push   %ebx
801053f9:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
801053fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105402:	8b 40 18             	mov    0x18(%eax),%eax
80105405:	8b 40 1c             	mov    0x1c(%eax),%eax
80105408:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010540b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010540f:	7e 30                	jle    80105441 <syscall+0x4c>
80105411:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105414:	83 f8 17             	cmp    $0x17,%eax
80105417:	77 28                	ja     80105441 <syscall+0x4c>
80105419:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010541c:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105423:	85 c0                	test   %eax,%eax
80105425:	74 1a                	je     80105441 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105427:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010542d:	8b 58 18             	mov    0x18(%eax),%ebx
80105430:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105433:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010543a:	ff d0                	call   *%eax
8010543c:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010543f:	eb 3d                	jmp    8010547e <syscall+0x89>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105441:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105447:	8d 48 6c             	lea    0x6c(%eax),%ecx
8010544a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105450:	8b 40 10             	mov    0x10(%eax),%eax
80105453:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105456:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010545a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010545e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105462:	c7 04 24 77 88 10 80 	movl   $0x80108877,(%esp)
80105469:	e8 33 af ff ff       	call   801003a1 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
8010546e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105474:	8b 40 18             	mov    0x18(%eax),%eax
80105477:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010547e:	83 c4 24             	add    $0x24,%esp
80105481:	5b                   	pop    %ebx
80105482:	5d                   	pop    %ebp
80105483:	c3                   	ret    

80105484 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105484:	55                   	push   %ebp
80105485:	89 e5                	mov    %esp,%ebp
80105487:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010548a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010548d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105491:	8b 45 08             	mov    0x8(%ebp),%eax
80105494:	89 04 24             	mov    %eax,(%esp)
80105497:	e8 92 fe ff ff       	call   8010532e <argint>
8010549c:	85 c0                	test   %eax,%eax
8010549e:	79 07                	jns    801054a7 <argfd+0x23>
    return -1;
801054a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a5:	eb 50                	jmp    801054f7 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801054a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054aa:	85 c0                	test   %eax,%eax
801054ac:	78 21                	js     801054cf <argfd+0x4b>
801054ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054b1:	83 f8 0f             	cmp    $0xf,%eax
801054b4:	7f 19                	jg     801054cf <argfd+0x4b>
801054b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054bc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801054bf:	83 c2 08             	add    $0x8,%edx
801054c2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801054c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801054c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801054cd:	75 07                	jne    801054d6 <argfd+0x52>
    return -1;
801054cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054d4:	eb 21                	jmp    801054f7 <argfd+0x73>
  if(pfd)
801054d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801054da:	74 08                	je     801054e4 <argfd+0x60>
    *pfd = fd;
801054dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801054df:	8b 45 0c             	mov    0xc(%ebp),%eax
801054e2:	89 10                	mov    %edx,(%eax)
  if(pf)
801054e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054e8:	74 08                	je     801054f2 <argfd+0x6e>
    *pf = f;
801054ea:	8b 45 10             	mov    0x10(%ebp),%eax
801054ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054f0:	89 10                	mov    %edx,(%eax)
  return 0;
801054f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801054f7:	c9                   	leave  
801054f8:	c3                   	ret    

801054f9 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801054f9:	55                   	push   %ebp
801054fa:	89 e5                	mov    %esp,%ebp
801054fc:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801054ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105506:	eb 30                	jmp    80105538 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105508:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010550e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105511:	83 c2 08             	add    $0x8,%edx
80105514:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105518:	85 c0                	test   %eax,%eax
8010551a:	75 18                	jne    80105534 <fdalloc+0x3b>
      proc->ofile[fd] = f;
8010551c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105522:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105525:	8d 4a 08             	lea    0x8(%edx),%ecx
80105528:	8b 55 08             	mov    0x8(%ebp),%edx
8010552b:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
8010552f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105532:	eb 0f                	jmp    80105543 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105534:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105538:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
8010553c:	7e ca                	jle    80105508 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
8010553e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105543:	c9                   	leave  
80105544:	c3                   	ret    

80105545 <sys_dup>:

int
sys_dup(void)
{
80105545:	55                   	push   %ebp
80105546:	89 e5                	mov    %esp,%ebp
80105548:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
8010554b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010554e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105552:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105559:	00 
8010555a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105561:	e8 1e ff ff ff       	call   80105484 <argfd>
80105566:	85 c0                	test   %eax,%eax
80105568:	79 07                	jns    80105571 <sys_dup+0x2c>
    return -1;
8010556a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010556f:	eb 29                	jmp    8010559a <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105571:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105574:	89 04 24             	mov    %eax,(%esp)
80105577:	e8 7d ff ff ff       	call   801054f9 <fdalloc>
8010557c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010557f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105583:	79 07                	jns    8010558c <sys_dup+0x47>
    return -1;
80105585:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010558a:	eb 0e                	jmp    8010559a <sys_dup+0x55>
  filedup(f);
8010558c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010558f:	89 04 24             	mov    %eax,(%esp)
80105592:	e8 f1 b9 ff ff       	call   80100f88 <filedup>
  return fd;
80105597:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010559a:	c9                   	leave  
8010559b:	c3                   	ret    

8010559c <sys_read>:

int
sys_read(void)
{
8010559c:	55                   	push   %ebp
8010559d:	89 e5                	mov    %esp,%ebp
8010559f:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801055a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055a5:	89 44 24 08          	mov    %eax,0x8(%esp)
801055a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801055b0:	00 
801055b1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801055b8:	e8 c7 fe ff ff       	call   80105484 <argfd>
801055bd:	85 c0                	test   %eax,%eax
801055bf:	78 35                	js     801055f6 <sys_read+0x5a>
801055c1:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801055c8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801055cf:	e8 5a fd ff ff       	call   8010532e <argint>
801055d4:	85 c0                	test   %eax,%eax
801055d6:	78 1e                	js     801055f6 <sys_read+0x5a>
801055d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055db:	89 44 24 08          	mov    %eax,0x8(%esp)
801055df:	8d 45 ec             	lea    -0x14(%ebp),%eax
801055e2:	89 44 24 04          	mov    %eax,0x4(%esp)
801055e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055ed:	e8 6a fd ff ff       	call   8010535c <argptr>
801055f2:	85 c0                	test   %eax,%eax
801055f4:	79 07                	jns    801055fd <sys_read+0x61>
    return -1;
801055f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055fb:	eb 19                	jmp    80105616 <sys_read+0x7a>
  return fileread(f, p, n);
801055fd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105600:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105603:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105606:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010560a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010560e:	89 04 24             	mov    %eax,(%esp)
80105611:	e8 df ba ff ff       	call   801010f5 <fileread>
}
80105616:	c9                   	leave  
80105617:	c3                   	ret    

80105618 <sys_write>:

int
sys_write(void)
{
80105618:	55                   	push   %ebp
80105619:	89 e5                	mov    %esp,%ebp
8010561b:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010561e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105621:	89 44 24 08          	mov    %eax,0x8(%esp)
80105625:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010562c:	00 
8010562d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105634:	e8 4b fe ff ff       	call   80105484 <argfd>
80105639:	85 c0                	test   %eax,%eax
8010563b:	78 35                	js     80105672 <sys_write+0x5a>
8010563d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105640:	89 44 24 04          	mov    %eax,0x4(%esp)
80105644:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010564b:	e8 de fc ff ff       	call   8010532e <argint>
80105650:	85 c0                	test   %eax,%eax
80105652:	78 1e                	js     80105672 <sys_write+0x5a>
80105654:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105657:	89 44 24 08          	mov    %eax,0x8(%esp)
8010565b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010565e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105662:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105669:	e8 ee fc ff ff       	call   8010535c <argptr>
8010566e:	85 c0                	test   %eax,%eax
80105670:	79 07                	jns    80105679 <sys_write+0x61>
    return -1;
80105672:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105677:	eb 19                	jmp    80105692 <sys_write+0x7a>
  return filewrite(f, p, n);
80105679:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010567c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010567f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105682:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105686:	89 54 24 04          	mov    %edx,0x4(%esp)
8010568a:	89 04 24             	mov    %eax,(%esp)
8010568d:	e8 1f bb ff ff       	call   801011b1 <filewrite>
}
80105692:	c9                   	leave  
80105693:	c3                   	ret    

80105694 <sys_close>:

int
sys_close(void)
{
80105694:	55                   	push   %ebp
80105695:	89 e5                	mov    %esp,%ebp
80105697:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010569a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010569d:	89 44 24 08          	mov    %eax,0x8(%esp)
801056a1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801056a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056af:	e8 d0 fd ff ff       	call   80105484 <argfd>
801056b4:	85 c0                	test   %eax,%eax
801056b6:	79 07                	jns    801056bf <sys_close+0x2b>
    return -1;
801056b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056bd:	eb 24                	jmp    801056e3 <sys_close+0x4f>
  proc->ofile[fd] = 0;
801056bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056c8:	83 c2 08             	add    $0x8,%edx
801056cb:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801056d2:	00 
  fileclose(f);
801056d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056d6:	89 04 24             	mov    %eax,(%esp)
801056d9:	e8 f2 b8 ff ff       	call   80100fd0 <fileclose>
  return 0;
801056de:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056e3:	c9                   	leave  
801056e4:	c3                   	ret    

801056e5 <sys_fstat>:

int
sys_fstat(void)
{
801056e5:	55                   	push   %ebp
801056e6:	89 e5                	mov    %esp,%ebp
801056e8:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801056eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056ee:	89 44 24 08          	mov    %eax,0x8(%esp)
801056f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801056f9:	00 
801056fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105701:	e8 7e fd ff ff       	call   80105484 <argfd>
80105706:	85 c0                	test   %eax,%eax
80105708:	78 1f                	js     80105729 <sys_fstat+0x44>
8010570a:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80105711:	00 
80105712:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105715:	89 44 24 04          	mov    %eax,0x4(%esp)
80105719:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105720:	e8 37 fc ff ff       	call   8010535c <argptr>
80105725:	85 c0                	test   %eax,%eax
80105727:	79 07                	jns    80105730 <sys_fstat+0x4b>
    return -1;
80105729:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010572e:	eb 12                	jmp    80105742 <sys_fstat+0x5d>
  return filestat(f, st);
80105730:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105733:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105736:	89 54 24 04          	mov    %edx,0x4(%esp)
8010573a:	89 04 24             	mov    %eax,(%esp)
8010573d:	e8 64 b9 ff ff       	call   801010a6 <filestat>
}
80105742:	c9                   	leave  
80105743:	c3                   	ret    

80105744 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105744:	55                   	push   %ebp
80105745:	89 e5                	mov    %esp,%ebp
80105747:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010574a:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010574d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105751:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105758:	e8 61 fc ff ff       	call   801053be <argstr>
8010575d:	85 c0                	test   %eax,%eax
8010575f:	78 17                	js     80105778 <sys_link+0x34>
80105761:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105764:	89 44 24 04          	mov    %eax,0x4(%esp)
80105768:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010576f:	e8 4a fc ff ff       	call   801053be <argstr>
80105774:	85 c0                	test   %eax,%eax
80105776:	79 0a                	jns    80105782 <sys_link+0x3e>
    return -1;
80105778:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010577d:	e9 41 01 00 00       	jmp    801058c3 <sys_link+0x17f>

  begin_op();
80105782:	e8 a2 da ff ff       	call   80103229 <begin_op>
  if((ip = namei(old)) == 0){
80105787:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010578a:	89 04 24             	mov    %eax,(%esp)
8010578d:	e8 84 cc ff ff       	call   80102416 <namei>
80105792:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105795:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105799:	75 0f                	jne    801057aa <sys_link+0x66>
    end_op();
8010579b:	e8 0a db ff ff       	call   801032aa <end_op>
    return -1;
801057a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057a5:	e9 19 01 00 00       	jmp    801058c3 <sys_link+0x17f>
  }

  ilock(ip);
801057aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057ad:	89 04 24             	mov    %eax,(%esp)
801057b0:	e8 bf c0 ff ff       	call   80101874 <ilock>
  if(ip->type == T_DIR){
801057b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057b8:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801057bc:	66 83 f8 01          	cmp    $0x1,%ax
801057c0:	75 1a                	jne    801057dc <sys_link+0x98>
    iunlockput(ip);
801057c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057c5:	89 04 24             	mov    %eax,(%esp)
801057c8:	e8 2b c3 ff ff       	call   80101af8 <iunlockput>
    end_op();
801057cd:	e8 d8 da ff ff       	call   801032aa <end_op>
    return -1;
801057d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d7:	e9 e7 00 00 00       	jmp    801058c3 <sys_link+0x17f>
  }

  ip->nlink++;
801057dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057df:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801057e3:	8d 50 01             	lea    0x1(%eax),%edx
801057e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057e9:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801057ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057f0:	89 04 24             	mov    %eax,(%esp)
801057f3:	e8 c0 be ff ff       	call   801016b8 <iupdate>
  iunlock(ip);
801057f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057fb:	89 04 24             	mov    %eax,(%esp)
801057fe:	e8 bf c1 ff ff       	call   801019c2 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105803:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105806:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105809:	89 54 24 04          	mov    %edx,0x4(%esp)
8010580d:	89 04 24             	mov    %eax,(%esp)
80105810:	e8 23 cc ff ff       	call   80102438 <nameiparent>
80105815:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105818:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010581c:	74 68                	je     80105886 <sys_link+0x142>
    goto bad;
  ilock(dp);
8010581e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105821:	89 04 24             	mov    %eax,(%esp)
80105824:	e8 4b c0 ff ff       	call   80101874 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105829:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010582c:	8b 10                	mov    (%eax),%edx
8010582e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105831:	8b 00                	mov    (%eax),%eax
80105833:	39 c2                	cmp    %eax,%edx
80105835:	75 20                	jne    80105857 <sys_link+0x113>
80105837:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010583a:	8b 40 04             	mov    0x4(%eax),%eax
8010583d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105841:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105844:	89 44 24 04          	mov    %eax,0x4(%esp)
80105848:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010584b:	89 04 24             	mov    %eax,(%esp)
8010584e:	e8 02 c9 ff ff       	call   80102155 <dirlink>
80105853:	85 c0                	test   %eax,%eax
80105855:	79 0d                	jns    80105864 <sys_link+0x120>
    iunlockput(dp);
80105857:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010585a:	89 04 24             	mov    %eax,(%esp)
8010585d:	e8 96 c2 ff ff       	call   80101af8 <iunlockput>
    goto bad;
80105862:	eb 23                	jmp    80105887 <sys_link+0x143>
  }
  iunlockput(dp);
80105864:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105867:	89 04 24             	mov    %eax,(%esp)
8010586a:	e8 89 c2 ff ff       	call   80101af8 <iunlockput>
  iput(ip);
8010586f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105872:	89 04 24             	mov    %eax,(%esp)
80105875:	e8 ad c1 ff ff       	call   80101a27 <iput>

  end_op();
8010587a:	e8 2b da ff ff       	call   801032aa <end_op>

  return 0;
8010587f:	b8 00 00 00 00       	mov    $0x0,%eax
80105884:	eb 3d                	jmp    801058c3 <sys_link+0x17f>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105886:	90                   	nop
  end_op();

  return 0;

bad:
  ilock(ip);
80105887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010588a:	89 04 24             	mov    %eax,(%esp)
8010588d:	e8 e2 bf ff ff       	call   80101874 <ilock>
  ip->nlink--;
80105892:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105895:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105899:	8d 50 ff             	lea    -0x1(%eax),%edx
8010589c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010589f:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801058a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a6:	89 04 24             	mov    %eax,(%esp)
801058a9:	e8 0a be ff ff       	call   801016b8 <iupdate>
  iunlockput(ip);
801058ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058b1:	89 04 24             	mov    %eax,(%esp)
801058b4:	e8 3f c2 ff ff       	call   80101af8 <iunlockput>
  end_op();
801058b9:	e8 ec d9 ff ff       	call   801032aa <end_op>
  return -1;
801058be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058c3:	c9                   	leave  
801058c4:	c3                   	ret    

801058c5 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
801058c5:	55                   	push   %ebp
801058c6:	89 e5                	mov    %esp,%ebp
801058c8:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801058cb:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801058d2:	eb 4b                	jmp    8010591f <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801058d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058d7:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801058de:	00 
801058df:	89 44 24 08          	mov    %eax,0x8(%esp)
801058e3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801058ea:	8b 45 08             	mov    0x8(%ebp),%eax
801058ed:	89 04 24             	mov    %eax,(%esp)
801058f0:	e8 75 c4 ff ff       	call   80101d6a <readi>
801058f5:	83 f8 10             	cmp    $0x10,%eax
801058f8:	74 0c                	je     80105906 <isdirempty+0x41>
      panic("isdirempty: readi");
801058fa:	c7 04 24 93 88 10 80 	movl   $0x80108893,(%esp)
80105901:	e8 37 ac ff ff       	call   8010053d <panic>
    if(de.inum != 0)
80105906:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
8010590a:	66 85 c0             	test   %ax,%ax
8010590d:	74 07                	je     80105916 <isdirempty+0x51>
      return 0;
8010590f:	b8 00 00 00 00       	mov    $0x0,%eax
80105914:	eb 1b                	jmp    80105931 <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105919:	83 c0 10             	add    $0x10,%eax
8010591c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010591f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105922:	8b 45 08             	mov    0x8(%ebp),%eax
80105925:	8b 40 18             	mov    0x18(%eax),%eax
80105928:	39 c2                	cmp    %eax,%edx
8010592a:	72 a8                	jb     801058d4 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
8010592c:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105931:	c9                   	leave  
80105932:	c3                   	ret    

80105933 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105933:	55                   	push   %ebp
80105934:	89 e5                	mov    %esp,%ebp
80105936:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105939:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010593c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105940:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105947:	e8 72 fa ff ff       	call   801053be <argstr>
8010594c:	85 c0                	test   %eax,%eax
8010594e:	79 0a                	jns    8010595a <sys_unlink+0x27>
    return -1;
80105950:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105955:	e9 af 01 00 00       	jmp    80105b09 <sys_unlink+0x1d6>

  begin_op();
8010595a:	e8 ca d8 ff ff       	call   80103229 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
8010595f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105962:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105965:	89 54 24 04          	mov    %edx,0x4(%esp)
80105969:	89 04 24             	mov    %eax,(%esp)
8010596c:	e8 c7 ca ff ff       	call   80102438 <nameiparent>
80105971:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105974:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105978:	75 0f                	jne    80105989 <sys_unlink+0x56>
    end_op();
8010597a:	e8 2b d9 ff ff       	call   801032aa <end_op>
    return -1;
8010597f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105984:	e9 80 01 00 00       	jmp    80105b09 <sys_unlink+0x1d6>
  }

  ilock(dp);
80105989:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010598c:	89 04 24             	mov    %eax,(%esp)
8010598f:	e8 e0 be ff ff       	call   80101874 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105994:	c7 44 24 04 a5 88 10 	movl   $0x801088a5,0x4(%esp)
8010599b:	80 
8010599c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010599f:	89 04 24             	mov    %eax,(%esp)
801059a2:	e8 c4 c6 ff ff       	call   8010206b <namecmp>
801059a7:	85 c0                	test   %eax,%eax
801059a9:	0f 84 45 01 00 00    	je     80105af4 <sys_unlink+0x1c1>
801059af:	c7 44 24 04 a7 88 10 	movl   $0x801088a7,0x4(%esp)
801059b6:	80 
801059b7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801059ba:	89 04 24             	mov    %eax,(%esp)
801059bd:	e8 a9 c6 ff ff       	call   8010206b <namecmp>
801059c2:	85 c0                	test   %eax,%eax
801059c4:	0f 84 2a 01 00 00    	je     80105af4 <sys_unlink+0x1c1>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801059ca:	8d 45 c8             	lea    -0x38(%ebp),%eax
801059cd:	89 44 24 08          	mov    %eax,0x8(%esp)
801059d1:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801059d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801059d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059db:	89 04 24             	mov    %eax,(%esp)
801059de:	e8 aa c6 ff ff       	call   8010208d <dirlookup>
801059e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801059e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059ea:	0f 84 03 01 00 00    	je     80105af3 <sys_unlink+0x1c0>
    goto bad;
  ilock(ip);
801059f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059f3:	89 04 24             	mov    %eax,(%esp)
801059f6:	e8 79 be ff ff       	call   80101874 <ilock>

  if(ip->nlink < 1)
801059fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059fe:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a02:	66 85 c0             	test   %ax,%ax
80105a05:	7f 0c                	jg     80105a13 <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105a07:	c7 04 24 aa 88 10 80 	movl   $0x801088aa,(%esp)
80105a0e:	e8 2a ab ff ff       	call   8010053d <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a16:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105a1a:	66 83 f8 01          	cmp    $0x1,%ax
80105a1e:	75 1f                	jne    80105a3f <sys_unlink+0x10c>
80105a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a23:	89 04 24             	mov    %eax,(%esp)
80105a26:	e8 9a fe ff ff       	call   801058c5 <isdirempty>
80105a2b:	85 c0                	test   %eax,%eax
80105a2d:	75 10                	jne    80105a3f <sys_unlink+0x10c>
    iunlockput(ip);
80105a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a32:	89 04 24             	mov    %eax,(%esp)
80105a35:	e8 be c0 ff ff       	call   80101af8 <iunlockput>
    goto bad;
80105a3a:	e9 b5 00 00 00       	jmp    80105af4 <sys_unlink+0x1c1>
  }

  memset(&de, 0, sizeof(de));
80105a3f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80105a46:	00 
80105a47:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105a4e:	00 
80105a4f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a52:	89 04 24             	mov    %eax,(%esp)
80105a55:	e8 78 f5 ff ff       	call   80104fd2 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a5a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105a5d:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105a64:	00 
80105a65:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a69:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a73:	89 04 24             	mov    %eax,(%esp)
80105a76:	e8 5a c4 ff ff       	call   80101ed5 <writei>
80105a7b:	83 f8 10             	cmp    $0x10,%eax
80105a7e:	74 0c                	je     80105a8c <sys_unlink+0x159>
    panic("unlink: writei");
80105a80:	c7 04 24 bc 88 10 80 	movl   $0x801088bc,(%esp)
80105a87:	e8 b1 aa ff ff       	call   8010053d <panic>
  if(ip->type == T_DIR){
80105a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a8f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105a93:	66 83 f8 01          	cmp    $0x1,%ax
80105a97:	75 1c                	jne    80105ab5 <sys_unlink+0x182>
    dp->nlink--;
80105a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a9c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105aa0:	8d 50 ff             	lea    -0x1(%eax),%edx
80105aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aa6:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aad:	89 04 24             	mov    %eax,(%esp)
80105ab0:	e8 03 bc ff ff       	call   801016b8 <iupdate>
  }
  iunlockput(dp);
80105ab5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ab8:	89 04 24             	mov    %eax,(%esp)
80105abb:	e8 38 c0 ff ff       	call   80101af8 <iunlockput>

  ip->nlink--;
80105ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ac3:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105ac7:	8d 50 ff             	lea    -0x1(%eax),%edx
80105aca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105acd:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ad4:	89 04 24             	mov    %eax,(%esp)
80105ad7:	e8 dc bb ff ff       	call   801016b8 <iupdate>
  iunlockput(ip);
80105adc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105adf:	89 04 24             	mov    %eax,(%esp)
80105ae2:	e8 11 c0 ff ff       	call   80101af8 <iunlockput>

  end_op();
80105ae7:	e8 be d7 ff ff       	call   801032aa <end_op>

  return 0;
80105aec:	b8 00 00 00 00       	mov    $0x0,%eax
80105af1:	eb 16                	jmp    80105b09 <sys_unlink+0x1d6>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105af3:	90                   	nop
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105af7:	89 04 24             	mov    %eax,(%esp)
80105afa:	e8 f9 bf ff ff       	call   80101af8 <iunlockput>
  end_op();
80105aff:	e8 a6 d7 ff ff       	call   801032aa <end_op>
  return -1;
80105b04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b09:	c9                   	leave  
80105b0a:	c3                   	ret    

80105b0b <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105b0b:	55                   	push   %ebp
80105b0c:	89 e5                	mov    %esp,%ebp
80105b0e:	83 ec 48             	sub    $0x48,%esp
80105b11:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105b14:	8b 55 10             	mov    0x10(%ebp),%edx
80105b17:	8b 45 14             	mov    0x14(%ebp),%eax
80105b1a:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105b1e:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105b22:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105b26:	8d 45 de             	lea    -0x22(%ebp),%eax
80105b29:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b2d:	8b 45 08             	mov    0x8(%ebp),%eax
80105b30:	89 04 24             	mov    %eax,(%esp)
80105b33:	e8 00 c9 ff ff       	call   80102438 <nameiparent>
80105b38:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b3b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b3f:	75 0a                	jne    80105b4b <create+0x40>
    return 0;
80105b41:	b8 00 00 00 00       	mov    $0x0,%eax
80105b46:	e9 7e 01 00 00       	jmp    80105cc9 <create+0x1be>
  ilock(dp);
80105b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b4e:	89 04 24             	mov    %eax,(%esp)
80105b51:	e8 1e bd ff ff       	call   80101874 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105b56:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b59:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b5d:	8d 45 de             	lea    -0x22(%ebp),%eax
80105b60:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b67:	89 04 24             	mov    %eax,(%esp)
80105b6a:	e8 1e c5 ff ff       	call   8010208d <dirlookup>
80105b6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b72:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b76:	74 47                	je     80105bbf <create+0xb4>
    iunlockput(dp);
80105b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b7b:	89 04 24             	mov    %eax,(%esp)
80105b7e:	e8 75 bf ff ff       	call   80101af8 <iunlockput>
    ilock(ip);
80105b83:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b86:	89 04 24             	mov    %eax,(%esp)
80105b89:	e8 e6 bc ff ff       	call   80101874 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105b8e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105b93:	75 15                	jne    80105baa <create+0x9f>
80105b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b98:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b9c:	66 83 f8 02          	cmp    $0x2,%ax
80105ba0:	75 08                	jne    80105baa <create+0x9f>
      return ip;
80105ba2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ba5:	e9 1f 01 00 00       	jmp    80105cc9 <create+0x1be>
    iunlockput(ip);
80105baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bad:	89 04 24             	mov    %eax,(%esp)
80105bb0:	e8 43 bf ff ff       	call   80101af8 <iunlockput>
    return 0;
80105bb5:	b8 00 00 00 00       	mov    $0x0,%eax
80105bba:	e9 0a 01 00 00       	jmp    80105cc9 <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105bbf:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc6:	8b 00                	mov    (%eax),%eax
80105bc8:	89 54 24 04          	mov    %edx,0x4(%esp)
80105bcc:	89 04 24             	mov    %eax,(%esp)
80105bcf:	e8 07 ba ff ff       	call   801015db <ialloc>
80105bd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bd7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bdb:	75 0c                	jne    80105be9 <create+0xde>
    panic("create: ialloc");
80105bdd:	c7 04 24 cb 88 10 80 	movl   $0x801088cb,(%esp)
80105be4:	e8 54 a9 ff ff       	call   8010053d <panic>

  ilock(ip);
80105be9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bec:	89 04 24             	mov    %eax,(%esp)
80105bef:	e8 80 bc ff ff       	call   80101874 <ilock>
  ip->major = major;
80105bf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bf7:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105bfb:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105bff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c02:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105c06:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105c0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c0d:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c16:	89 04 24             	mov    %eax,(%esp)
80105c19:	e8 9a ba ff ff       	call   801016b8 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105c1e:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105c23:	75 6a                	jne    80105c8f <create+0x184>
    dp->nlink++;  // for ".."
80105c25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c28:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c2c:	8d 50 01             	lea    0x1(%eax),%edx
80105c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c32:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105c36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c39:	89 04 24             	mov    %eax,(%esp)
80105c3c:	e8 77 ba ff ff       	call   801016b8 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c44:	8b 40 04             	mov    0x4(%eax),%eax
80105c47:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c4b:	c7 44 24 04 a5 88 10 	movl   $0x801088a5,0x4(%esp)
80105c52:	80 
80105c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c56:	89 04 24             	mov    %eax,(%esp)
80105c59:	e8 f7 c4 ff ff       	call   80102155 <dirlink>
80105c5e:	85 c0                	test   %eax,%eax
80105c60:	78 21                	js     80105c83 <create+0x178>
80105c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c65:	8b 40 04             	mov    0x4(%eax),%eax
80105c68:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c6c:	c7 44 24 04 a7 88 10 	movl   $0x801088a7,0x4(%esp)
80105c73:	80 
80105c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c77:	89 04 24             	mov    %eax,(%esp)
80105c7a:	e8 d6 c4 ff ff       	call   80102155 <dirlink>
80105c7f:	85 c0                	test   %eax,%eax
80105c81:	79 0c                	jns    80105c8f <create+0x184>
      panic("create dots");
80105c83:	c7 04 24 da 88 10 80 	movl   $0x801088da,(%esp)
80105c8a:	e8 ae a8 ff ff       	call   8010053d <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c92:	8b 40 04             	mov    0x4(%eax),%eax
80105c95:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c99:	8d 45 de             	lea    -0x22(%ebp),%eax
80105c9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ca3:	89 04 24             	mov    %eax,(%esp)
80105ca6:	e8 aa c4 ff ff       	call   80102155 <dirlink>
80105cab:	85 c0                	test   %eax,%eax
80105cad:	79 0c                	jns    80105cbb <create+0x1b0>
    panic("create: dirlink");
80105caf:	c7 04 24 e6 88 10 80 	movl   $0x801088e6,(%esp)
80105cb6:	e8 82 a8 ff ff       	call   8010053d <panic>

  iunlockput(dp);
80105cbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cbe:	89 04 24             	mov    %eax,(%esp)
80105cc1:	e8 32 be ff ff       	call   80101af8 <iunlockput>

  return ip;
80105cc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105cc9:	c9                   	leave  
80105cca:	c3                   	ret    

80105ccb <sys_open>:

int
sys_open(void)
{
80105ccb:	55                   	push   %ebp
80105ccc:	89 e5                	mov    %esp,%ebp
80105cce:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105cd1:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105cd4:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cd8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105cdf:	e8 da f6 ff ff       	call   801053be <argstr>
80105ce4:	85 c0                	test   %eax,%eax
80105ce6:	78 17                	js     80105cff <sys_open+0x34>
80105ce8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ceb:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105cf6:	e8 33 f6 ff ff       	call   8010532e <argint>
80105cfb:	85 c0                	test   %eax,%eax
80105cfd:	79 0a                	jns    80105d09 <sys_open+0x3e>
    return -1;
80105cff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d04:	e9 5a 01 00 00       	jmp    80105e63 <sys_open+0x198>

  begin_op();
80105d09:	e8 1b d5 ff ff       	call   80103229 <begin_op>

  if(omode & O_CREATE){
80105d0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d11:	25 00 02 00 00       	and    $0x200,%eax
80105d16:	85 c0                	test   %eax,%eax
80105d18:	74 3b                	je     80105d55 <sys_open+0x8a>
    ip = create(path, T_FILE, 0, 0);
80105d1a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105d1d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105d24:	00 
80105d25:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105d2c:	00 
80105d2d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80105d34:	00 
80105d35:	89 04 24             	mov    %eax,(%esp)
80105d38:	e8 ce fd ff ff       	call   80105b0b <create>
80105d3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80105d40:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d44:	75 6b                	jne    80105db1 <sys_open+0xe6>
      end_op();
80105d46:	e8 5f d5 ff ff       	call   801032aa <end_op>
      return -1;
80105d4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d50:	e9 0e 01 00 00       	jmp    80105e63 <sys_open+0x198>
    }
  } else {
    if((ip = namei(path)) == 0){
80105d55:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105d58:	89 04 24             	mov    %eax,(%esp)
80105d5b:	e8 b6 c6 ff ff       	call   80102416 <namei>
80105d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d63:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d67:	75 0f                	jne    80105d78 <sys_open+0xad>
      end_op();
80105d69:	e8 3c d5 ff ff       	call   801032aa <end_op>
      return -1;
80105d6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d73:	e9 eb 00 00 00       	jmp    80105e63 <sys_open+0x198>
    }
    ilock(ip);
80105d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d7b:	89 04 24             	mov    %eax,(%esp)
80105d7e:	e8 f1 ba ff ff       	call   80101874 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d86:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d8a:	66 83 f8 01          	cmp    $0x1,%ax
80105d8e:	75 21                	jne    80105db1 <sys_open+0xe6>
80105d90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d93:	85 c0                	test   %eax,%eax
80105d95:	74 1a                	je     80105db1 <sys_open+0xe6>
      iunlockput(ip);
80105d97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d9a:	89 04 24             	mov    %eax,(%esp)
80105d9d:	e8 56 bd ff ff       	call   80101af8 <iunlockput>
      end_op();
80105da2:	e8 03 d5 ff ff       	call   801032aa <end_op>
      return -1;
80105da7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dac:	e9 b2 00 00 00       	jmp    80105e63 <sys_open+0x198>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105db1:	e8 72 b1 ff ff       	call   80100f28 <filealloc>
80105db6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105db9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105dbd:	74 14                	je     80105dd3 <sys_open+0x108>
80105dbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dc2:	89 04 24             	mov    %eax,(%esp)
80105dc5:	e8 2f f7 ff ff       	call   801054f9 <fdalloc>
80105dca:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105dcd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105dd1:	79 28                	jns    80105dfb <sys_open+0x130>
    if(f)
80105dd3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105dd7:	74 0b                	je     80105de4 <sys_open+0x119>
      fileclose(f);
80105dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ddc:	89 04 24             	mov    %eax,(%esp)
80105ddf:	e8 ec b1 ff ff       	call   80100fd0 <fileclose>
    iunlockput(ip);
80105de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105de7:	89 04 24             	mov    %eax,(%esp)
80105dea:	e8 09 bd ff ff       	call   80101af8 <iunlockput>
    end_op();
80105def:	e8 b6 d4 ff ff       	call   801032aa <end_op>
    return -1;
80105df4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df9:	eb 68                	jmp    80105e63 <sys_open+0x198>
  }
  iunlock(ip);
80105dfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dfe:	89 04 24             	mov    %eax,(%esp)
80105e01:	e8 bc bb ff ff       	call   801019c2 <iunlock>
  end_op();
80105e06:	e8 9f d4 ff ff       	call   801032aa <end_op>

  f->type = FD_INODE;
80105e0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e0e:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105e14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e17:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e1a:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105e1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e20:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105e27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e2a:	83 e0 01             	and    $0x1,%eax
80105e2d:	85 c0                	test   %eax,%eax
80105e2f:	0f 94 c2             	sete   %dl
80105e32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e35:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e3b:	83 e0 01             	and    $0x1,%eax
80105e3e:	84 c0                	test   %al,%al
80105e40:	75 0a                	jne    80105e4c <sys_open+0x181>
80105e42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e45:	83 e0 02             	and    $0x2,%eax
80105e48:	85 c0                	test   %eax,%eax
80105e4a:	74 07                	je     80105e53 <sys_open+0x188>
80105e4c:	b8 01 00 00 00       	mov    $0x1,%eax
80105e51:	eb 05                	jmp    80105e58 <sys_open+0x18d>
80105e53:	b8 00 00 00 00       	mov    $0x0,%eax
80105e58:	89 c2                	mov    %eax,%edx
80105e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e5d:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105e60:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105e63:	c9                   	leave  
80105e64:	c3                   	ret    

80105e65 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e65:	55                   	push   %ebp
80105e66:	89 e5                	mov    %esp,%ebp
80105e68:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e6b:	e8 b9 d3 ff ff       	call   80103229 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e70:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e73:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105e7e:	e8 3b f5 ff ff       	call   801053be <argstr>
80105e83:	85 c0                	test   %eax,%eax
80105e85:	78 2c                	js     80105eb3 <sys_mkdir+0x4e>
80105e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e8a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105e91:	00 
80105e92:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105e99:	00 
80105e9a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80105ea1:	00 
80105ea2:	89 04 24             	mov    %eax,(%esp)
80105ea5:	e8 61 fc ff ff       	call   80105b0b <create>
80105eaa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ead:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105eb1:	75 0c                	jne    80105ebf <sys_mkdir+0x5a>
    end_op();
80105eb3:	e8 f2 d3 ff ff       	call   801032aa <end_op>
    return -1;
80105eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ebd:	eb 15                	jmp    80105ed4 <sys_mkdir+0x6f>
  }
  iunlockput(ip);
80105ebf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ec2:	89 04 24             	mov    %eax,(%esp)
80105ec5:	e8 2e bc ff ff       	call   80101af8 <iunlockput>
  end_op();
80105eca:	e8 db d3 ff ff       	call   801032aa <end_op>
  return 0;
80105ecf:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ed4:	c9                   	leave  
80105ed5:	c3                   	ret    

80105ed6 <sys_mknod>:

int
sys_mknod(void)
{
80105ed6:	55                   	push   %ebp
80105ed7:	89 e5                	mov    %esp,%ebp
80105ed9:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
80105edc:	e8 48 d3 ff ff       	call   80103229 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80105ee1:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ee4:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ee8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105eef:	e8 ca f4 ff ff       	call   801053be <argstr>
80105ef4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ef7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105efb:	78 5e                	js     80105f5b <sys_mknod+0x85>
     argint(1, &major) < 0 ||
80105efd:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f00:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105f0b:	e8 1e f4 ff ff       	call   8010532e <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
80105f10:	85 c0                	test   %eax,%eax
80105f12:	78 47                	js     80105f5b <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f14:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f17:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105f22:	e8 07 f4 ff ff       	call   8010532e <argint>
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105f27:	85 c0                	test   %eax,%eax
80105f29:	78 30                	js     80105f5b <sys_mknod+0x85>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f2e:	0f bf c8             	movswl %ax,%ecx
80105f31:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f34:	0f bf d0             	movswl %ax,%edx
80105f37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105f3a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80105f3e:	89 54 24 08          	mov    %edx,0x8(%esp)
80105f42:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80105f49:	00 
80105f4a:	89 04 24             	mov    %eax,(%esp)
80105f4d:	e8 b9 fb ff ff       	call   80105b0b <create>
80105f52:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f55:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f59:	75 0c                	jne    80105f67 <sys_mknod+0x91>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105f5b:	e8 4a d3 ff ff       	call   801032aa <end_op>
    return -1;
80105f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f65:	eb 15                	jmp    80105f7c <sys_mknod+0xa6>
  }
  iunlockput(ip);
80105f67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f6a:	89 04 24             	mov    %eax,(%esp)
80105f6d:	e8 86 bb ff ff       	call   80101af8 <iunlockput>
  end_op();
80105f72:	e8 33 d3 ff ff       	call   801032aa <end_op>
  return 0;
80105f77:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f7c:	c9                   	leave  
80105f7d:	c3                   	ret    

80105f7e <sys_chdir>:

int
sys_chdir(void)
{
80105f7e:	55                   	push   %ebp
80105f7f:	89 e5                	mov    %esp,%ebp
80105f81:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105f84:	e8 a0 d2 ff ff       	call   80103229 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f89:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f97:	e8 22 f4 ff ff       	call   801053be <argstr>
80105f9c:	85 c0                	test   %eax,%eax
80105f9e:	78 14                	js     80105fb4 <sys_chdir+0x36>
80105fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fa3:	89 04 24             	mov    %eax,(%esp)
80105fa6:	e8 6b c4 ff ff       	call   80102416 <namei>
80105fab:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fb2:	75 0c                	jne    80105fc0 <sys_chdir+0x42>
    end_op();
80105fb4:	e8 f1 d2 ff ff       	call   801032aa <end_op>
    return -1;
80105fb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fbe:	eb 61                	jmp    80106021 <sys_chdir+0xa3>
  }
  ilock(ip);
80105fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fc3:	89 04 24             	mov    %eax,(%esp)
80105fc6:	e8 a9 b8 ff ff       	call   80101874 <ilock>
  if(ip->type != T_DIR){
80105fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fce:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105fd2:	66 83 f8 01          	cmp    $0x1,%ax
80105fd6:	74 17                	je     80105fef <sys_chdir+0x71>
    iunlockput(ip);
80105fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fdb:	89 04 24             	mov    %eax,(%esp)
80105fde:	e8 15 bb ff ff       	call   80101af8 <iunlockput>
    end_op();
80105fe3:	e8 c2 d2 ff ff       	call   801032aa <end_op>
    return -1;
80105fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fed:	eb 32                	jmp    80106021 <sys_chdir+0xa3>
  }
  iunlock(ip);
80105fef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ff2:	89 04 24             	mov    %eax,(%esp)
80105ff5:	e8 c8 b9 ff ff       	call   801019c2 <iunlock>
  iput(proc->cwd);
80105ffa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106000:	8b 40 68             	mov    0x68(%eax),%eax
80106003:	89 04 24             	mov    %eax,(%esp)
80106006:	e8 1c ba ff ff       	call   80101a27 <iput>
  end_op();
8010600b:	e8 9a d2 ff ff       	call   801032aa <end_op>
  proc->cwd = ip;
80106010:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106016:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106019:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
8010601c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106021:	c9                   	leave  
80106022:	c3                   	ret    

80106023 <sys_exec>:

int
sys_exec(void)
{
80106023:	55                   	push   %ebp
80106024:	89 e5                	mov    %esp,%ebp
80106026:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010602c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010602f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010603a:	e8 7f f3 ff ff       	call   801053be <argstr>
8010603f:	85 c0                	test   %eax,%eax
80106041:	78 1a                	js     8010605d <sys_exec+0x3a>
80106043:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106049:	89 44 24 04          	mov    %eax,0x4(%esp)
8010604d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106054:	e8 d5 f2 ff ff       	call   8010532e <argint>
80106059:	85 c0                	test   %eax,%eax
8010605b:	79 0a                	jns    80106067 <sys_exec+0x44>
    return -1;
8010605d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106062:	e9 cc 00 00 00       	jmp    80106133 <sys_exec+0x110>
  }
  memset(argv, 0, sizeof(argv));
80106067:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
8010606e:	00 
8010606f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106076:	00 
80106077:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010607d:	89 04 24             	mov    %eax,(%esp)
80106080:	e8 4d ef ff ff       	call   80104fd2 <memset>
  for(i=0;; i++){
80106085:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010608c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010608f:	83 f8 1f             	cmp    $0x1f,%eax
80106092:	76 0a                	jbe    8010609e <sys_exec+0x7b>
      return -1;
80106094:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106099:	e9 95 00 00 00       	jmp    80106133 <sys_exec+0x110>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010609e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060a1:	c1 e0 02             	shl    $0x2,%eax
801060a4:	89 c2                	mov    %eax,%edx
801060a6:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801060ac:	01 c2                	add    %eax,%edx
801060ae:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801060b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801060b8:	89 14 24             	mov    %edx,(%esp)
801060bb:	e8 d0 f1 ff ff       	call   80105290 <fetchint>
801060c0:	85 c0                	test   %eax,%eax
801060c2:	79 07                	jns    801060cb <sys_exec+0xa8>
      return -1;
801060c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060c9:	eb 68                	jmp    80106133 <sys_exec+0x110>
    if(uarg == 0){
801060cb:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801060d1:	85 c0                	test   %eax,%eax
801060d3:	75 26                	jne    801060fb <sys_exec+0xd8>
      argv[i] = 0;
801060d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060d8:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801060df:	00 00 00 00 
      break;
801060e3:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801060e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060e7:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801060ed:	89 54 24 04          	mov    %edx,0x4(%esp)
801060f1:	89 04 24             	mov    %eax,(%esp)
801060f4:	e8 03 aa ff ff       	call   80100afc <exec>
801060f9:	eb 38                	jmp    80106133 <sys_exec+0x110>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801060fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80106105:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010610b:	01 c2                	add    %eax,%edx
8010610d:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106113:	89 54 24 04          	mov    %edx,0x4(%esp)
80106117:	89 04 24             	mov    %eax,(%esp)
8010611a:	e8 ab f1 ff ff       	call   801052ca <fetchstr>
8010611f:	85 c0                	test   %eax,%eax
80106121:	79 07                	jns    8010612a <sys_exec+0x107>
      return -1;
80106123:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106128:	eb 09                	jmp    80106133 <sys_exec+0x110>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010612a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
8010612e:	e9 59 ff ff ff       	jmp    8010608c <sys_exec+0x69>
  return exec(path, argv);
}
80106133:	c9                   	leave  
80106134:	c3                   	ret    

80106135 <sys_pipe>:

int
sys_pipe(void)
{
80106135:	55                   	push   %ebp
80106136:	89 e5                	mov    %esp,%ebp
80106138:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010613b:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80106142:	00 
80106143:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106146:	89 44 24 04          	mov    %eax,0x4(%esp)
8010614a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106151:	e8 06 f2 ff ff       	call   8010535c <argptr>
80106156:	85 c0                	test   %eax,%eax
80106158:	79 0a                	jns    80106164 <sys_pipe+0x2f>
    return -1;
8010615a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010615f:	e9 9b 00 00 00       	jmp    801061ff <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80106164:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106167:	89 44 24 04          	mov    %eax,0x4(%esp)
8010616b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010616e:	89 04 24             	mov    %eax,(%esp)
80106171:	e8 ca db ff ff       	call   80103d40 <pipealloc>
80106176:	85 c0                	test   %eax,%eax
80106178:	79 07                	jns    80106181 <sys_pipe+0x4c>
    return -1;
8010617a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010617f:	eb 7e                	jmp    801061ff <sys_pipe+0xca>
  fd0 = -1;
80106181:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106188:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010618b:	89 04 24             	mov    %eax,(%esp)
8010618e:	e8 66 f3 ff ff       	call   801054f9 <fdalloc>
80106193:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106196:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010619a:	78 14                	js     801061b0 <sys_pipe+0x7b>
8010619c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010619f:	89 04 24             	mov    %eax,(%esp)
801061a2:	e8 52 f3 ff ff       	call   801054f9 <fdalloc>
801061a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801061aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801061ae:	79 37                	jns    801061e7 <sys_pipe+0xb2>
    if(fd0 >= 0)
801061b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061b4:	78 14                	js     801061ca <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
801061b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061bf:	83 c2 08             	add    $0x8,%edx
801061c2:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801061c9:	00 
    fileclose(rf);
801061ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061cd:	89 04 24             	mov    %eax,(%esp)
801061d0:	e8 fb ad ff ff       	call   80100fd0 <fileclose>
    fileclose(wf);
801061d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801061d8:	89 04 24             	mov    %eax,(%esp)
801061db:	e8 f0 ad ff ff       	call   80100fd0 <fileclose>
    return -1;
801061e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e5:	eb 18                	jmp    801061ff <sys_pipe+0xca>
  }
  fd[0] = fd0;
801061e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061ed:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
801061ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061f2:	8d 50 04             	lea    0x4(%eax),%edx
801061f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061f8:	89 02                	mov    %eax,(%edx)
  return 0;
801061fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061ff:	c9                   	leave  
80106200:	c3                   	ret    
80106201:	00 00                	add    %al,(%eax)
	...

80106204 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106204:	55                   	push   %ebp
80106205:	89 e5                	mov    %esp,%ebp
80106207:	83 ec 18             	sub    $0x18,%esp
  proc->ctflag = 0;
8010620a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106210:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
  return fork((char*)0, 0, 0, 0);
80106217:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
8010621e:	00 
8010621f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106226:	00 
80106227:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010622e:	00 
8010622f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106236:	e8 bb e1 ff ff       	call   801043f6 <fork>
}
8010623b:	c9                   	leave  
8010623c:	c3                   	ret    

8010623d <sys_exit>:

int
sys_exit(void)
{
8010623d:	55                   	push   %ebp
8010623e:	89 e5                	mov    %esp,%ebp
80106240:	83 ec 08             	sub    $0x8,%esp
  exit();
80106243:	e8 13 e4 ff ff       	call   8010465b <exit>
  return 0;  // not reached
80106248:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010624d:	c9                   	leave  
8010624e:	c3                   	ret    

8010624f <sys_wait>:

int
sys_wait(void)
{
8010624f:	55                   	push   %ebp
80106250:	89 e5                	mov    %esp,%ebp
80106252:	83 ec 18             	sub    $0x18,%esp
  return wait(0);
80106255:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010625c:	e8 1f e5 ff ff       	call   80104780 <wait>
}
80106261:	c9                   	leave  
80106262:	c3                   	ret    

80106263 <sys_kill>:

int
sys_kill(void)
{
80106263:	55                   	push   %ebp
80106264:	89 e5                	mov    %esp,%ebp
80106266:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106269:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010626c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106270:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106277:	e8 b2 f0 ff ff       	call   8010532e <argint>
8010627c:	85 c0                	test   %eax,%eax
8010627e:	79 07                	jns    80106287 <sys_kill+0x24>
    return -1;
80106280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106285:	eb 0b                	jmp    80106292 <sys_kill+0x2f>
  return kill(pid);
80106287:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010628a:	89 04 24             	mov    %eax,(%esp)
8010628d:	e8 10 e9 ff ff       	call   80104ba2 <kill>
}
80106292:	c9                   	leave  
80106293:	c3                   	ret    

80106294 <sys_getpid>:

int
sys_getpid(void)
{
80106294:	55                   	push   %ebp
80106295:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106297:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010629d:	8b 40 10             	mov    0x10(%eax),%eax
}
801062a0:	5d                   	pop    %ebp
801062a1:	c3                   	ret    

801062a2 <sys_sbrk>:

int
sys_sbrk(void)
{
801062a2:	55                   	push   %ebp
801062a3:	89 e5                	mov    %esp,%ebp
801062a5:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062a8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801062af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062b6:	e8 73 f0 ff ff       	call   8010532e <argint>
801062bb:	85 c0                	test   %eax,%eax
801062bd:	79 07                	jns    801062c6 <sys_sbrk+0x24>
    return -1;
801062bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c4:	eb 24                	jmp    801062ea <sys_sbrk+0x48>
  addr = proc->sz;
801062c6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062cc:	8b 00                	mov    (%eax),%eax
801062ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801062d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062d4:	89 04 24             	mov    %eax,(%esp)
801062d7:	e8 75 e0 ff ff       	call   80104351 <growproc>
801062dc:	85 c0                	test   %eax,%eax
801062de:	79 07                	jns    801062e7 <sys_sbrk+0x45>
    return -1;
801062e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062e5:	eb 03                	jmp    801062ea <sys_sbrk+0x48>
  return addr;
801062e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801062ea:	c9                   	leave  
801062eb:	c3                   	ret    

801062ec <sys_sleep>:

int
sys_sleep(void)
{
801062ec:	55                   	push   %ebp
801062ed:	89 e5                	mov    %esp,%ebp
801062ef:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
801062f2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062f5:	89 44 24 04          	mov    %eax,0x4(%esp)
801062f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106300:	e8 29 f0 ff ff       	call   8010532e <argint>
80106305:	85 c0                	test   %eax,%eax
80106307:	79 07                	jns    80106310 <sys_sleep+0x24>
    return -1;
80106309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010630e:	eb 6c                	jmp    8010637c <sys_sleep+0x90>
  acquire(&tickslock);
80106310:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80106317:	e8 67 ea ff ff       	call   80104d83 <acquire>
  ticks0 = ticks;
8010631c:	a1 e0 55 11 80       	mov    0x801155e0,%eax
80106321:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106324:	eb 34                	jmp    8010635a <sys_sleep+0x6e>
    if(proc->killed){
80106326:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010632c:	8b 40 24             	mov    0x24(%eax),%eax
8010632f:	85 c0                	test   %eax,%eax
80106331:	74 13                	je     80106346 <sys_sleep+0x5a>
      release(&tickslock);
80106333:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010633a:	e8 a6 ea ff ff       	call   80104de5 <release>
      return -1;
8010633f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106344:	eb 36                	jmp    8010637c <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
80106346:	c7 44 24 04 a0 4d 11 	movl   $0x80114da0,0x4(%esp)
8010634d:	80 
8010634e:	c7 04 24 e0 55 11 80 	movl   $0x801155e0,(%esp)
80106355:	e8 41 e7 ff ff       	call   80104a9b <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010635a:	a1 e0 55 11 80       	mov    0x801155e0,%eax
8010635f:	89 c2                	mov    %eax,%edx
80106361:	2b 55 f4             	sub    -0xc(%ebp),%edx
80106364:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106367:	39 c2                	cmp    %eax,%edx
80106369:	72 bb                	jb     80106326 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010636b:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80106372:	e8 6e ea ff ff       	call   80104de5 <release>
  return 0;
80106377:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010637c:	c9                   	leave  
8010637d:	c3                   	ret    

8010637e <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
8010637e:	55                   	push   %ebp
8010637f:	89 e5                	mov    %esp,%ebp
80106381:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
80106384:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010638b:	e8 f3 e9 ff ff       	call   80104d83 <acquire>
  xticks = ticks;
80106390:	a1 e0 55 11 80       	mov    0x801155e0,%eax
80106395:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106398:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010639f:	e8 41 ea ff ff       	call   80104de5 <release>
  return xticks;
801063a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801063a7:	c9                   	leave  
801063a8:	c3                   	ret    

801063a9 <sys_getppid>:

int sys_getppid(void) {
801063a9:	55                   	push   %ebp
801063aa:	89 e5                	mov    %esp,%ebp

	if(proc->parent == 0)
801063ac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801063b2:	8b 40 14             	mov    0x14(%eax),%eax
801063b5:	85 c0                	test   %eax,%eax
801063b7:	75 07                	jne    801063c0 <sys_getppid+0x17>
		return 0;
801063b9:	b8 00 00 00 00       	mov    $0x0,%eax
801063be:	eb 0c                	jmp    801063cc <sys_getppid+0x23>
	return proc->parent->pid;
801063c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801063c6:	8b 40 14             	mov    0x14(%eax),%eax
801063c9:	8b 40 10             	mov    0x10(%eax),%eax
}
801063cc:	5d                   	pop    %ebp
801063cd:	c3                   	ret    

801063ce <sys_kthread_create>:

int sys_kthread_create(void){
801063ce:	55                   	push   %ebp
801063cf:	89 e5                	mov    %esp,%ebp
801063d1:	53                   	push   %ebx
801063d2:	83 ec 24             	sub    $0x24,%esp

	int ustack = 0;
801063d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int wrapper = 0;
801063dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int arg1 = 0;
801063e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int arg2 = 0;
801063ea:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

	argint(0, &ustack);
801063f1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063f4:	89 44 24 04          	mov    %eax,0x4(%esp)
801063f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801063ff:	e8 2a ef ff ff       	call   8010532e <argint>
	argint(1, &wrapper);
80106404:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106407:	89 44 24 04          	mov    %eax,0x4(%esp)
8010640b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106412:	e8 17 ef ff ff       	call   8010532e <argint>
	argint(2, &arg1);
80106417:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010641a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010641e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106425:	e8 04 ef ff ff       	call   8010532e <argint>
	argint(3, &arg2);
8010642a:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010642d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106431:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80106438:	e8 f1 ee ff ff       	call   8010532e <argint>

	proc->ctflag = 1;
8010643d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106443:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
	return fork((char*)ustack, (uint)wrapper, (uint)arg1, (uint)arg2);
8010644a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010644d:	89 c3                	mov    %eax,%ebx
8010644f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106452:	89 c1                	mov    %eax,%ecx
80106454:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106457:	89 c2                	mov    %eax,%edx
80106459:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010645c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80106460:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106464:	89 54 24 04          	mov    %edx,0x4(%esp)
80106468:	89 04 24             	mov    %eax,(%esp)
8010646b:	e8 86 df ff ff       	call   801043f6 <fork>
}
80106470:	83 c4 24             	add    $0x24,%esp
80106473:	5b                   	pop    %ebx
80106474:	5d                   	pop    %ebp
80106475:	c3                   	ret    

80106476 <sys_kthread_join>:

int sys_kthread_join(void){
80106476:	55                   	push   %ebp
80106477:	89 e5                	mov    %esp,%ebp
80106479:	83 ec 28             	sub    $0x28,%esp

	int tid = 0;
8010647c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	argint(0, &tid);
80106483:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106486:	89 44 24 04          	mov    %eax,0x4(%esp)
8010648a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106491:	e8 98 ee ff ff       	call   8010532e <argint>
	return wait(tid);
80106496:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106499:	89 04 24             	mov    %eax,(%esp)
8010649c:	e8 df e2 ff ff       	call   80104780 <wait>

}
801064a1:	c9                   	leave  
801064a2:	c3                   	ret    
	...

801064a4 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801064a4:	55                   	push   %ebp
801064a5:	89 e5                	mov    %esp,%ebp
801064a7:	83 ec 08             	sub    $0x8,%esp
801064aa:	8b 55 08             	mov    0x8(%ebp),%edx
801064ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801064b0:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801064b4:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801064b7:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801064bb:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801064bf:	ee                   	out    %al,(%dx)
}
801064c0:	c9                   	leave  
801064c1:	c3                   	ret    

801064c2 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801064c2:	55                   	push   %ebp
801064c3:	89 e5                	mov    %esp,%ebp
801064c5:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801064c8:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
801064cf:	00 
801064d0:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
801064d7:	e8 c8 ff ff ff       	call   801064a4 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801064dc:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
801064e3:	00 
801064e4:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801064eb:	e8 b4 ff ff ff       	call   801064a4 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
801064f0:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
801064f7:	00 
801064f8:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801064ff:	e8 a0 ff ff ff       	call   801064a4 <outb>
  picenable(IRQ_TIMER);
80106504:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010650b:	e8 b9 d6 ff ff       	call   80103bc9 <picenable>
}
80106510:	c9                   	leave  
80106511:	c3                   	ret    
	...

80106514 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106514:	1e                   	push   %ds
  pushl %es
80106515:	06                   	push   %es
  pushl %fs
80106516:	0f a0                	push   %fs
  pushl %gs
80106518:	0f a8                	push   %gs
  pushal
8010651a:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
8010651b:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010651f:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106521:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106523:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106527:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106529:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
8010652b:	54                   	push   %esp
  call trap
8010652c:	e8 de 01 00 00       	call   8010670f <trap>
  addl $4, %esp
80106531:	83 c4 04             	add    $0x4,%esp

80106534 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106534:	61                   	popa   
  popl %gs
80106535:	0f a9                	pop    %gs
  popl %fs
80106537:	0f a1                	pop    %fs
  popl %es
80106539:	07                   	pop    %es
  popl %ds
8010653a:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010653b:	83 c4 08             	add    $0x8,%esp
  iret
8010653e:	cf                   	iret   
	...

80106540 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106546:	8b 45 0c             	mov    0xc(%ebp),%eax
80106549:	83 e8 01             	sub    $0x1,%eax
8010654c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106550:	8b 45 08             	mov    0x8(%ebp),%eax
80106553:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106557:	8b 45 08             	mov    0x8(%ebp),%eax
8010655a:	c1 e8 10             	shr    $0x10,%eax
8010655d:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106561:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106564:	0f 01 18             	lidtl  (%eax)
}
80106567:	c9                   	leave  
80106568:	c3                   	ret    

80106569 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106569:	55                   	push   %ebp
8010656a:	89 e5                	mov    %esp,%ebp
8010656c:	53                   	push   %ebx
8010656d:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106570:	0f 20 d3             	mov    %cr2,%ebx
80106573:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return val;
80106576:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80106579:	83 c4 10             	add    $0x10,%esp
8010657c:	5b                   	pop    %ebx
8010657d:	5d                   	pop    %ebp
8010657e:	c3                   	ret    

8010657f <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010657f:	55                   	push   %ebp
80106580:	89 e5                	mov    %esp,%ebp
80106582:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
80106585:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010658c:	e9 c3 00 00 00       	jmp    80106654 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106591:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106594:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
8010659b:	89 c2                	mov    %eax,%edx
8010659d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065a0:	66 89 14 c5 e0 4d 11 	mov    %dx,-0x7feeb220(,%eax,8)
801065a7:	80 
801065a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065ab:	66 c7 04 c5 e2 4d 11 	movw   $0x8,-0x7feeb21e(,%eax,8)
801065b2:	80 08 00 
801065b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065b8:	0f b6 14 c5 e4 4d 11 	movzbl -0x7feeb21c(,%eax,8),%edx
801065bf:	80 
801065c0:	83 e2 e0             	and    $0xffffffe0,%edx
801065c3:	88 14 c5 e4 4d 11 80 	mov    %dl,-0x7feeb21c(,%eax,8)
801065ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065cd:	0f b6 14 c5 e4 4d 11 	movzbl -0x7feeb21c(,%eax,8),%edx
801065d4:	80 
801065d5:	83 e2 1f             	and    $0x1f,%edx
801065d8:	88 14 c5 e4 4d 11 80 	mov    %dl,-0x7feeb21c(,%eax,8)
801065df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065e2:	0f b6 14 c5 e5 4d 11 	movzbl -0x7feeb21b(,%eax,8),%edx
801065e9:	80 
801065ea:	83 e2 f0             	and    $0xfffffff0,%edx
801065ed:	83 ca 0e             	or     $0xe,%edx
801065f0:	88 14 c5 e5 4d 11 80 	mov    %dl,-0x7feeb21b(,%eax,8)
801065f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065fa:	0f b6 14 c5 e5 4d 11 	movzbl -0x7feeb21b(,%eax,8),%edx
80106601:	80 
80106602:	83 e2 ef             	and    $0xffffffef,%edx
80106605:	88 14 c5 e5 4d 11 80 	mov    %dl,-0x7feeb21b(,%eax,8)
8010660c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010660f:	0f b6 14 c5 e5 4d 11 	movzbl -0x7feeb21b(,%eax,8),%edx
80106616:	80 
80106617:	83 e2 9f             	and    $0xffffff9f,%edx
8010661a:	88 14 c5 e5 4d 11 80 	mov    %dl,-0x7feeb21b(,%eax,8)
80106621:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106624:	0f b6 14 c5 e5 4d 11 	movzbl -0x7feeb21b(,%eax,8),%edx
8010662b:	80 
8010662c:	83 ca 80             	or     $0xffffff80,%edx
8010662f:	88 14 c5 e5 4d 11 80 	mov    %dl,-0x7feeb21b(,%eax,8)
80106636:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106639:	8b 04 85 a0 b0 10 80 	mov    -0x7fef4f60(,%eax,4),%eax
80106640:	c1 e8 10             	shr    $0x10,%eax
80106643:	89 c2                	mov    %eax,%edx
80106645:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106648:	66 89 14 c5 e6 4d 11 	mov    %dx,-0x7feeb21a(,%eax,8)
8010664f:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106650:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106654:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010665b:	0f 8e 30 ff ff ff    	jle    80106591 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106661:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
80106666:	66 a3 e0 4f 11 80    	mov    %ax,0x80114fe0
8010666c:	66 c7 05 e2 4f 11 80 	movw   $0x8,0x80114fe2
80106673:	08 00 
80106675:	0f b6 05 e4 4f 11 80 	movzbl 0x80114fe4,%eax
8010667c:	83 e0 e0             	and    $0xffffffe0,%eax
8010667f:	a2 e4 4f 11 80       	mov    %al,0x80114fe4
80106684:	0f b6 05 e4 4f 11 80 	movzbl 0x80114fe4,%eax
8010668b:	83 e0 1f             	and    $0x1f,%eax
8010668e:	a2 e4 4f 11 80       	mov    %al,0x80114fe4
80106693:	0f b6 05 e5 4f 11 80 	movzbl 0x80114fe5,%eax
8010669a:	83 c8 0f             	or     $0xf,%eax
8010669d:	a2 e5 4f 11 80       	mov    %al,0x80114fe5
801066a2:	0f b6 05 e5 4f 11 80 	movzbl 0x80114fe5,%eax
801066a9:	83 e0 ef             	and    $0xffffffef,%eax
801066ac:	a2 e5 4f 11 80       	mov    %al,0x80114fe5
801066b1:	0f b6 05 e5 4f 11 80 	movzbl 0x80114fe5,%eax
801066b8:	83 c8 60             	or     $0x60,%eax
801066bb:	a2 e5 4f 11 80       	mov    %al,0x80114fe5
801066c0:	0f b6 05 e5 4f 11 80 	movzbl 0x80114fe5,%eax
801066c7:	83 c8 80             	or     $0xffffff80,%eax
801066ca:	a2 e5 4f 11 80       	mov    %al,0x80114fe5
801066cf:	a1 a0 b1 10 80       	mov    0x8010b1a0,%eax
801066d4:	c1 e8 10             	shr    $0x10,%eax
801066d7:	66 a3 e6 4f 11 80    	mov    %ax,0x80114fe6
  
  initlock(&tickslock, "time");
801066dd:	c7 44 24 04 f8 88 10 	movl   $0x801088f8,0x4(%esp)
801066e4:	80 
801066e5:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801066ec:	e8 71 e6 ff ff       	call   80104d62 <initlock>
}
801066f1:	c9                   	leave  
801066f2:	c3                   	ret    

801066f3 <idtinit>:

void
idtinit(void)
{
801066f3:	55                   	push   %ebp
801066f4:	89 e5                	mov    %esp,%ebp
801066f6:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
801066f9:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
80106700:	00 
80106701:	c7 04 24 e0 4d 11 80 	movl   $0x80114de0,(%esp)
80106708:	e8 33 fe ff ff       	call   80106540 <lidt>
}
8010670d:	c9                   	leave  
8010670e:	c3                   	ret    

8010670f <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010670f:	55                   	push   %ebp
80106710:	89 e5                	mov    %esp,%ebp
80106712:	57                   	push   %edi
80106713:	56                   	push   %esi
80106714:	53                   	push   %ebx
80106715:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
80106718:	8b 45 08             	mov    0x8(%ebp),%eax
8010671b:	8b 40 30             	mov    0x30(%eax),%eax
8010671e:	83 f8 40             	cmp    $0x40,%eax
80106721:	75 3e                	jne    80106761 <trap+0x52>
    if(proc->killed)
80106723:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106729:	8b 40 24             	mov    0x24(%eax),%eax
8010672c:	85 c0                	test   %eax,%eax
8010672e:	74 05                	je     80106735 <trap+0x26>
      exit();
80106730:	e8 26 df ff ff       	call   8010465b <exit>
    proc->tf = tf;
80106735:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010673b:	8b 55 08             	mov    0x8(%ebp),%edx
8010673e:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106741:	e8 af ec ff ff       	call   801053f5 <syscall>
    if(proc->killed)
80106746:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010674c:	8b 40 24             	mov    0x24(%eax),%eax
8010674f:	85 c0                	test   %eax,%eax
80106751:	0f 84 34 02 00 00    	je     8010698b <trap+0x27c>
      exit();
80106757:	e8 ff de ff ff       	call   8010465b <exit>
    return;
8010675c:	e9 2a 02 00 00       	jmp    8010698b <trap+0x27c>
  }

  switch(tf->trapno){
80106761:	8b 45 08             	mov    0x8(%ebp),%eax
80106764:	8b 40 30             	mov    0x30(%eax),%eax
80106767:	83 e8 20             	sub    $0x20,%eax
8010676a:	83 f8 1f             	cmp    $0x1f,%eax
8010676d:	0f 87 bc 00 00 00    	ja     8010682f <trap+0x120>
80106773:	8b 04 85 a0 89 10 80 	mov    -0x7fef7660(,%eax,4),%eax
8010677a:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
8010677c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106782:	0f b6 00             	movzbl (%eax),%eax
80106785:	84 c0                	test   %al,%al
80106787:	75 31                	jne    801067ba <trap+0xab>
      acquire(&tickslock);
80106789:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80106790:	e8 ee e5 ff ff       	call   80104d83 <acquire>
      ticks++;
80106795:	a1 e0 55 11 80       	mov    0x801155e0,%eax
8010679a:	83 c0 01             	add    $0x1,%eax
8010679d:	a3 e0 55 11 80       	mov    %eax,0x801155e0
      wakeup(&ticks);
801067a2:	c7 04 24 e0 55 11 80 	movl   $0x801155e0,(%esp)
801067a9:	e8 c9 e3 ff ff       	call   80104b77 <wakeup>
      release(&tickslock);
801067ae:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801067b5:	e8 2b e6 ff ff       	call   80104de5 <release>
    }
    lapiceoi();
801067ba:	e8 36 c7 ff ff       	call   80102ef5 <lapiceoi>
    break;
801067bf:	e9 41 01 00 00       	jmp    80106905 <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801067c4:	e8 34 bf ff ff       	call   801026fd <ideintr>
    lapiceoi();
801067c9:	e8 27 c7 ff ff       	call   80102ef5 <lapiceoi>
    break;
801067ce:	e9 32 01 00 00       	jmp    80106905 <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801067d3:	e8 fb c4 ff ff       	call   80102cd3 <kbdintr>
    lapiceoi();
801067d8:	e8 18 c7 ff ff       	call   80102ef5 <lapiceoi>
    break;
801067dd:	e9 23 01 00 00       	jmp    80106905 <trap+0x1f6>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801067e2:	e8 a9 03 00 00       	call   80106b90 <uartintr>
    lapiceoi();
801067e7:	e8 09 c7 ff ff       	call   80102ef5 <lapiceoi>
    break;
801067ec:	e9 14 01 00 00       	jmp    80106905 <trap+0x1f6>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
801067f1:	8b 45 08             	mov    0x8(%ebp),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067f4:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801067f7:	8b 45 08             	mov    0x8(%ebp),%eax
801067fa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067fe:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106801:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106807:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010680a:	0f b6 c0             	movzbl %al,%eax
8010680d:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106811:	89 54 24 08          	mov    %edx,0x8(%esp)
80106815:	89 44 24 04          	mov    %eax,0x4(%esp)
80106819:	c7 04 24 00 89 10 80 	movl   $0x80108900,(%esp)
80106820:	e8 7c 9b ff ff       	call   801003a1 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106825:	e8 cb c6 ff ff       	call   80102ef5 <lapiceoi>
    break;
8010682a:	e9 d6 00 00 00       	jmp    80106905 <trap+0x1f6>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
8010682f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106835:	85 c0                	test   %eax,%eax
80106837:	74 11                	je     8010684a <trap+0x13b>
80106839:	8b 45 08             	mov    0x8(%ebp),%eax
8010683c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106840:	0f b7 c0             	movzwl %ax,%eax
80106843:	83 e0 03             	and    $0x3,%eax
80106846:	85 c0                	test   %eax,%eax
80106848:	75 46                	jne    80106890 <trap+0x181>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010684a:	e8 1a fd ff ff       	call   80106569 <rcr2>
              tf->trapno, cpu->id, tf->eip, rcr2());
8010684f:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106852:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106855:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010685c:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010685f:	0f b6 ca             	movzbl %dl,%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106862:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106865:	8b 52 30             	mov    0x30(%edx),%edx
80106868:	89 44 24 10          	mov    %eax,0x10(%esp)
8010686c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80106870:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106874:	89 54 24 04          	mov    %edx,0x4(%esp)
80106878:	c7 04 24 24 89 10 80 	movl   $0x80108924,(%esp)
8010687f:	e8 1d 9b ff ff       	call   801003a1 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106884:	c7 04 24 56 89 10 80 	movl   $0x80108956,(%esp)
8010688b:	e8 ad 9c ff ff       	call   8010053d <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106890:	e8 d4 fc ff ff       	call   80106569 <rcr2>
80106895:	89 c2                	mov    %eax,%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106897:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010689a:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010689d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801068a3:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068a6:	0f b6 f0             	movzbl %al,%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801068a9:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068ac:	8b 58 34             	mov    0x34(%eax),%ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801068af:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068b2:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801068b5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068bb:	83 c0 6c             	add    $0x6c,%eax
801068be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068c7:	8b 40 10             	mov    0x10(%eax),%eax
801068ca:	89 54 24 1c          	mov    %edx,0x1c(%esp)
801068ce:	89 7c 24 18          	mov    %edi,0x18(%esp)
801068d2:	89 74 24 14          	mov    %esi,0x14(%esp)
801068d6:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801068da:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801068de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801068e1:	89 54 24 08          	mov    %edx,0x8(%esp)
801068e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801068e9:	c7 04 24 5c 89 10 80 	movl   $0x8010895c,(%esp)
801068f0:	e8 ac 9a ff ff       	call   801003a1 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
801068f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068fb:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106902:	eb 01                	jmp    80106905 <trap+0x1f6>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106904:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106905:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010690b:	85 c0                	test   %eax,%eax
8010690d:	74 24                	je     80106933 <trap+0x224>
8010690f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106915:	8b 40 24             	mov    0x24(%eax),%eax
80106918:	85 c0                	test   %eax,%eax
8010691a:	74 17                	je     80106933 <trap+0x224>
8010691c:	8b 45 08             	mov    0x8(%ebp),%eax
8010691f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106923:	0f b7 c0             	movzwl %ax,%eax
80106926:	83 e0 03             	and    $0x3,%eax
80106929:	83 f8 03             	cmp    $0x3,%eax
8010692c:	75 05                	jne    80106933 <trap+0x224>
    exit();
8010692e:	e8 28 dd ff ff       	call   8010465b <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106933:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106939:	85 c0                	test   %eax,%eax
8010693b:	74 1e                	je     8010695b <trap+0x24c>
8010693d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106943:	8b 40 0c             	mov    0xc(%eax),%eax
80106946:	83 f8 04             	cmp    $0x4,%eax
80106949:	75 10                	jne    8010695b <trap+0x24c>
8010694b:	8b 45 08             	mov    0x8(%ebp),%eax
8010694e:	8b 40 30             	mov    0x30(%eax),%eax
80106951:	83 f8 20             	cmp    $0x20,%eax
80106954:	75 05                	jne    8010695b <trap+0x24c>
    yield();
80106956:	e8 e2 e0 ff ff       	call   80104a3d <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010695b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106961:	85 c0                	test   %eax,%eax
80106963:	74 27                	je     8010698c <trap+0x27d>
80106965:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010696b:	8b 40 24             	mov    0x24(%eax),%eax
8010696e:	85 c0                	test   %eax,%eax
80106970:	74 1a                	je     8010698c <trap+0x27d>
80106972:	8b 45 08             	mov    0x8(%ebp),%eax
80106975:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106979:	0f b7 c0             	movzwl %ax,%eax
8010697c:	83 e0 03             	and    $0x3,%eax
8010697f:	83 f8 03             	cmp    $0x3,%eax
80106982:	75 08                	jne    8010698c <trap+0x27d>
    exit();
80106984:	e8 d2 dc ff ff       	call   8010465b <exit>
80106989:	eb 01                	jmp    8010698c <trap+0x27d>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
8010698b:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
8010698c:	83 c4 3c             	add    $0x3c,%esp
8010698f:	5b                   	pop    %ebx
80106990:	5e                   	pop    %esi
80106991:	5f                   	pop    %edi
80106992:	5d                   	pop    %ebp
80106993:	c3                   	ret    

80106994 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106994:	55                   	push   %ebp
80106995:	89 e5                	mov    %esp,%ebp
80106997:	53                   	push   %ebx
80106998:	83 ec 14             	sub    $0x14,%esp
8010699b:	8b 45 08             	mov    0x8(%ebp),%eax
8010699e:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801069a2:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
801069a6:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
801069aa:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
801069ae:	ec                   	in     (%dx),%al
801069af:	89 c3                	mov    %eax,%ebx
801069b1:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
801069b4:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
801069b8:	83 c4 14             	add    $0x14,%esp
801069bb:	5b                   	pop    %ebx
801069bc:	5d                   	pop    %ebp
801069bd:	c3                   	ret    

801069be <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801069be:	55                   	push   %ebp
801069bf:	89 e5                	mov    %esp,%ebp
801069c1:	83 ec 08             	sub    $0x8,%esp
801069c4:	8b 55 08             	mov    0x8(%ebp),%edx
801069c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801069ca:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801069ce:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801069d1:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801069d5:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801069d9:	ee                   	out    %al,(%dx)
}
801069da:	c9                   	leave  
801069db:	c3                   	ret    

801069dc <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801069dc:	55                   	push   %ebp
801069dd:	89 e5                	mov    %esp,%ebp
801069df:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801069e2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801069e9:	00 
801069ea:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
801069f1:	e8 c8 ff ff ff       	call   801069be <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801069f6:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
801069fd:	00 
801069fe:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106a05:	e8 b4 ff ff ff       	call   801069be <outb>
  outb(COM1+0, 115200/9600);
80106a0a:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80106a11:	00 
80106a12:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106a19:	e8 a0 ff ff ff       	call   801069be <outb>
  outb(COM1+1, 0);
80106a1e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a25:	00 
80106a26:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106a2d:	e8 8c ff ff ff       	call   801069be <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106a32:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106a39:	00 
80106a3a:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106a41:	e8 78 ff ff ff       	call   801069be <outb>
  outb(COM1+4, 0);
80106a46:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a4d:	00 
80106a4e:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106a55:	e8 64 ff ff ff       	call   801069be <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106a5a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106a61:	00 
80106a62:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106a69:	e8 50 ff ff ff       	call   801069be <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106a6e:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106a75:	e8 1a ff ff ff       	call   80106994 <inb>
80106a7a:	3c ff                	cmp    $0xff,%al
80106a7c:	74 6c                	je     80106aea <uartinit+0x10e>
    return;
  uart = 1;
80106a7e:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
80106a85:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106a88:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106a8f:	e8 00 ff ff ff       	call   80106994 <inb>
  inb(COM1+0);
80106a94:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106a9b:	e8 f4 fe ff ff       	call   80106994 <inb>
  picenable(IRQ_COM1);
80106aa0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106aa7:	e8 1d d1 ff ff       	call   80103bc9 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106aac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106ab3:	00 
80106ab4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106abb:	e8 c2 be ff ff       	call   80102982 <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106ac0:	c7 45 f4 20 8a 10 80 	movl   $0x80108a20,-0xc(%ebp)
80106ac7:	eb 15                	jmp    80106ade <uartinit+0x102>
    uartputc(*p);
80106ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106acc:	0f b6 00             	movzbl (%eax),%eax
80106acf:	0f be c0             	movsbl %al,%eax
80106ad2:	89 04 24             	mov    %eax,(%esp)
80106ad5:	e8 13 00 00 00       	call   80106aed <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106ada:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ae1:	0f b6 00             	movzbl (%eax),%eax
80106ae4:	84 c0                	test   %al,%al
80106ae6:	75 e1                	jne    80106ac9 <uartinit+0xed>
80106ae8:	eb 01                	jmp    80106aeb <uartinit+0x10f>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106aea:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106aeb:	c9                   	leave  
80106aec:	c3                   	ret    

80106aed <uartputc>:

void
uartputc(int c)
{
80106aed:	55                   	push   %ebp
80106aee:	89 e5                	mov    %esp,%ebp
80106af0:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80106af3:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106af8:	85 c0                	test   %eax,%eax
80106afa:	74 4d                	je     80106b49 <uartputc+0x5c>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106afc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106b03:	eb 10                	jmp    80106b15 <uartputc+0x28>
    microdelay(10);
80106b05:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106b0c:	e8 09 c4 ff ff       	call   80102f1a <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106b11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106b15:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106b19:	7f 16                	jg     80106b31 <uartputc+0x44>
80106b1b:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106b22:	e8 6d fe ff ff       	call   80106994 <inb>
80106b27:	0f b6 c0             	movzbl %al,%eax
80106b2a:	83 e0 20             	and    $0x20,%eax
80106b2d:	85 c0                	test   %eax,%eax
80106b2f:	74 d4                	je     80106b05 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106b31:	8b 45 08             	mov    0x8(%ebp),%eax
80106b34:	0f b6 c0             	movzbl %al,%eax
80106b37:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b3b:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106b42:	e8 77 fe ff ff       	call   801069be <outb>
80106b47:	eb 01                	jmp    80106b4a <uartputc+0x5d>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106b49:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106b4a:	c9                   	leave  
80106b4b:	c3                   	ret    

80106b4c <uartgetc>:

static int
uartgetc(void)
{
80106b4c:	55                   	push   %ebp
80106b4d:	89 e5                	mov    %esp,%ebp
80106b4f:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80106b52:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106b57:	85 c0                	test   %eax,%eax
80106b59:	75 07                	jne    80106b62 <uartgetc+0x16>
    return -1;
80106b5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b60:	eb 2c                	jmp    80106b8e <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80106b62:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106b69:	e8 26 fe ff ff       	call   80106994 <inb>
80106b6e:	0f b6 c0             	movzbl %al,%eax
80106b71:	83 e0 01             	and    $0x1,%eax
80106b74:	85 c0                	test   %eax,%eax
80106b76:	75 07                	jne    80106b7f <uartgetc+0x33>
    return -1;
80106b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b7d:	eb 0f                	jmp    80106b8e <uartgetc+0x42>
  return inb(COM1+0);
80106b7f:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106b86:	e8 09 fe ff ff       	call   80106994 <inb>
80106b8b:	0f b6 c0             	movzbl %al,%eax
}
80106b8e:	c9                   	leave  
80106b8f:	c3                   	ret    

80106b90 <uartintr>:

void
uartintr(void)
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106b96:	c7 04 24 4c 6b 10 80 	movl   $0x80106b4c,(%esp)
80106b9d:	e8 0b 9c ff ff       	call   801007ad <consoleintr>
}
80106ba2:	c9                   	leave  
80106ba3:	c3                   	ret    

80106ba4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106ba4:	6a 00                	push   $0x0
  pushl $0
80106ba6:	6a 00                	push   $0x0
  jmp alltraps
80106ba8:	e9 67 f9 ff ff       	jmp    80106514 <alltraps>

80106bad <vector1>:
.globl vector1
vector1:
  pushl $0
80106bad:	6a 00                	push   $0x0
  pushl $1
80106baf:	6a 01                	push   $0x1
  jmp alltraps
80106bb1:	e9 5e f9 ff ff       	jmp    80106514 <alltraps>

80106bb6 <vector2>:
.globl vector2
vector2:
  pushl $0
80106bb6:	6a 00                	push   $0x0
  pushl $2
80106bb8:	6a 02                	push   $0x2
  jmp alltraps
80106bba:	e9 55 f9 ff ff       	jmp    80106514 <alltraps>

80106bbf <vector3>:
.globl vector3
vector3:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $3
80106bc1:	6a 03                	push   $0x3
  jmp alltraps
80106bc3:	e9 4c f9 ff ff       	jmp    80106514 <alltraps>

80106bc8 <vector4>:
.globl vector4
vector4:
  pushl $0
80106bc8:	6a 00                	push   $0x0
  pushl $4
80106bca:	6a 04                	push   $0x4
  jmp alltraps
80106bcc:	e9 43 f9 ff ff       	jmp    80106514 <alltraps>

80106bd1 <vector5>:
.globl vector5
vector5:
  pushl $0
80106bd1:	6a 00                	push   $0x0
  pushl $5
80106bd3:	6a 05                	push   $0x5
  jmp alltraps
80106bd5:	e9 3a f9 ff ff       	jmp    80106514 <alltraps>

80106bda <vector6>:
.globl vector6
vector6:
  pushl $0
80106bda:	6a 00                	push   $0x0
  pushl $6
80106bdc:	6a 06                	push   $0x6
  jmp alltraps
80106bde:	e9 31 f9 ff ff       	jmp    80106514 <alltraps>

80106be3 <vector7>:
.globl vector7
vector7:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $7
80106be5:	6a 07                	push   $0x7
  jmp alltraps
80106be7:	e9 28 f9 ff ff       	jmp    80106514 <alltraps>

80106bec <vector8>:
.globl vector8
vector8:
  pushl $8
80106bec:	6a 08                	push   $0x8
  jmp alltraps
80106bee:	e9 21 f9 ff ff       	jmp    80106514 <alltraps>

80106bf3 <vector9>:
.globl vector9
vector9:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $9
80106bf5:	6a 09                	push   $0x9
  jmp alltraps
80106bf7:	e9 18 f9 ff ff       	jmp    80106514 <alltraps>

80106bfc <vector10>:
.globl vector10
vector10:
  pushl $10
80106bfc:	6a 0a                	push   $0xa
  jmp alltraps
80106bfe:	e9 11 f9 ff ff       	jmp    80106514 <alltraps>

80106c03 <vector11>:
.globl vector11
vector11:
  pushl $11
80106c03:	6a 0b                	push   $0xb
  jmp alltraps
80106c05:	e9 0a f9 ff ff       	jmp    80106514 <alltraps>

80106c0a <vector12>:
.globl vector12
vector12:
  pushl $12
80106c0a:	6a 0c                	push   $0xc
  jmp alltraps
80106c0c:	e9 03 f9 ff ff       	jmp    80106514 <alltraps>

80106c11 <vector13>:
.globl vector13
vector13:
  pushl $13
80106c11:	6a 0d                	push   $0xd
  jmp alltraps
80106c13:	e9 fc f8 ff ff       	jmp    80106514 <alltraps>

80106c18 <vector14>:
.globl vector14
vector14:
  pushl $14
80106c18:	6a 0e                	push   $0xe
  jmp alltraps
80106c1a:	e9 f5 f8 ff ff       	jmp    80106514 <alltraps>

80106c1f <vector15>:
.globl vector15
vector15:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $15
80106c21:	6a 0f                	push   $0xf
  jmp alltraps
80106c23:	e9 ec f8 ff ff       	jmp    80106514 <alltraps>

80106c28 <vector16>:
.globl vector16
vector16:
  pushl $0
80106c28:	6a 00                	push   $0x0
  pushl $16
80106c2a:	6a 10                	push   $0x10
  jmp alltraps
80106c2c:	e9 e3 f8 ff ff       	jmp    80106514 <alltraps>

80106c31 <vector17>:
.globl vector17
vector17:
  pushl $17
80106c31:	6a 11                	push   $0x11
  jmp alltraps
80106c33:	e9 dc f8 ff ff       	jmp    80106514 <alltraps>

80106c38 <vector18>:
.globl vector18
vector18:
  pushl $0
80106c38:	6a 00                	push   $0x0
  pushl $18
80106c3a:	6a 12                	push   $0x12
  jmp alltraps
80106c3c:	e9 d3 f8 ff ff       	jmp    80106514 <alltraps>

80106c41 <vector19>:
.globl vector19
vector19:
  pushl $0
80106c41:	6a 00                	push   $0x0
  pushl $19
80106c43:	6a 13                	push   $0x13
  jmp alltraps
80106c45:	e9 ca f8 ff ff       	jmp    80106514 <alltraps>

80106c4a <vector20>:
.globl vector20
vector20:
  pushl $0
80106c4a:	6a 00                	push   $0x0
  pushl $20
80106c4c:	6a 14                	push   $0x14
  jmp alltraps
80106c4e:	e9 c1 f8 ff ff       	jmp    80106514 <alltraps>

80106c53 <vector21>:
.globl vector21
vector21:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $21
80106c55:	6a 15                	push   $0x15
  jmp alltraps
80106c57:	e9 b8 f8 ff ff       	jmp    80106514 <alltraps>

80106c5c <vector22>:
.globl vector22
vector22:
  pushl $0
80106c5c:	6a 00                	push   $0x0
  pushl $22
80106c5e:	6a 16                	push   $0x16
  jmp alltraps
80106c60:	e9 af f8 ff ff       	jmp    80106514 <alltraps>

80106c65 <vector23>:
.globl vector23
vector23:
  pushl $0
80106c65:	6a 00                	push   $0x0
  pushl $23
80106c67:	6a 17                	push   $0x17
  jmp alltraps
80106c69:	e9 a6 f8 ff ff       	jmp    80106514 <alltraps>

80106c6e <vector24>:
.globl vector24
vector24:
  pushl $0
80106c6e:	6a 00                	push   $0x0
  pushl $24
80106c70:	6a 18                	push   $0x18
  jmp alltraps
80106c72:	e9 9d f8 ff ff       	jmp    80106514 <alltraps>

80106c77 <vector25>:
.globl vector25
vector25:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $25
80106c79:	6a 19                	push   $0x19
  jmp alltraps
80106c7b:	e9 94 f8 ff ff       	jmp    80106514 <alltraps>

80106c80 <vector26>:
.globl vector26
vector26:
  pushl $0
80106c80:	6a 00                	push   $0x0
  pushl $26
80106c82:	6a 1a                	push   $0x1a
  jmp alltraps
80106c84:	e9 8b f8 ff ff       	jmp    80106514 <alltraps>

80106c89 <vector27>:
.globl vector27
vector27:
  pushl $0
80106c89:	6a 00                	push   $0x0
  pushl $27
80106c8b:	6a 1b                	push   $0x1b
  jmp alltraps
80106c8d:	e9 82 f8 ff ff       	jmp    80106514 <alltraps>

80106c92 <vector28>:
.globl vector28
vector28:
  pushl $0
80106c92:	6a 00                	push   $0x0
  pushl $28
80106c94:	6a 1c                	push   $0x1c
  jmp alltraps
80106c96:	e9 79 f8 ff ff       	jmp    80106514 <alltraps>

80106c9b <vector29>:
.globl vector29
vector29:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $29
80106c9d:	6a 1d                	push   $0x1d
  jmp alltraps
80106c9f:	e9 70 f8 ff ff       	jmp    80106514 <alltraps>

80106ca4 <vector30>:
.globl vector30
vector30:
  pushl $0
80106ca4:	6a 00                	push   $0x0
  pushl $30
80106ca6:	6a 1e                	push   $0x1e
  jmp alltraps
80106ca8:	e9 67 f8 ff ff       	jmp    80106514 <alltraps>

80106cad <vector31>:
.globl vector31
vector31:
  pushl $0
80106cad:	6a 00                	push   $0x0
  pushl $31
80106caf:	6a 1f                	push   $0x1f
  jmp alltraps
80106cb1:	e9 5e f8 ff ff       	jmp    80106514 <alltraps>

80106cb6 <vector32>:
.globl vector32
vector32:
  pushl $0
80106cb6:	6a 00                	push   $0x0
  pushl $32
80106cb8:	6a 20                	push   $0x20
  jmp alltraps
80106cba:	e9 55 f8 ff ff       	jmp    80106514 <alltraps>

80106cbf <vector33>:
.globl vector33
vector33:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $33
80106cc1:	6a 21                	push   $0x21
  jmp alltraps
80106cc3:	e9 4c f8 ff ff       	jmp    80106514 <alltraps>

80106cc8 <vector34>:
.globl vector34
vector34:
  pushl $0
80106cc8:	6a 00                	push   $0x0
  pushl $34
80106cca:	6a 22                	push   $0x22
  jmp alltraps
80106ccc:	e9 43 f8 ff ff       	jmp    80106514 <alltraps>

80106cd1 <vector35>:
.globl vector35
vector35:
  pushl $0
80106cd1:	6a 00                	push   $0x0
  pushl $35
80106cd3:	6a 23                	push   $0x23
  jmp alltraps
80106cd5:	e9 3a f8 ff ff       	jmp    80106514 <alltraps>

80106cda <vector36>:
.globl vector36
vector36:
  pushl $0
80106cda:	6a 00                	push   $0x0
  pushl $36
80106cdc:	6a 24                	push   $0x24
  jmp alltraps
80106cde:	e9 31 f8 ff ff       	jmp    80106514 <alltraps>

80106ce3 <vector37>:
.globl vector37
vector37:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $37
80106ce5:	6a 25                	push   $0x25
  jmp alltraps
80106ce7:	e9 28 f8 ff ff       	jmp    80106514 <alltraps>

80106cec <vector38>:
.globl vector38
vector38:
  pushl $0
80106cec:	6a 00                	push   $0x0
  pushl $38
80106cee:	6a 26                	push   $0x26
  jmp alltraps
80106cf0:	e9 1f f8 ff ff       	jmp    80106514 <alltraps>

80106cf5 <vector39>:
.globl vector39
vector39:
  pushl $0
80106cf5:	6a 00                	push   $0x0
  pushl $39
80106cf7:	6a 27                	push   $0x27
  jmp alltraps
80106cf9:	e9 16 f8 ff ff       	jmp    80106514 <alltraps>

80106cfe <vector40>:
.globl vector40
vector40:
  pushl $0
80106cfe:	6a 00                	push   $0x0
  pushl $40
80106d00:	6a 28                	push   $0x28
  jmp alltraps
80106d02:	e9 0d f8 ff ff       	jmp    80106514 <alltraps>

80106d07 <vector41>:
.globl vector41
vector41:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $41
80106d09:	6a 29                	push   $0x29
  jmp alltraps
80106d0b:	e9 04 f8 ff ff       	jmp    80106514 <alltraps>

80106d10 <vector42>:
.globl vector42
vector42:
  pushl $0
80106d10:	6a 00                	push   $0x0
  pushl $42
80106d12:	6a 2a                	push   $0x2a
  jmp alltraps
80106d14:	e9 fb f7 ff ff       	jmp    80106514 <alltraps>

80106d19 <vector43>:
.globl vector43
vector43:
  pushl $0
80106d19:	6a 00                	push   $0x0
  pushl $43
80106d1b:	6a 2b                	push   $0x2b
  jmp alltraps
80106d1d:	e9 f2 f7 ff ff       	jmp    80106514 <alltraps>

80106d22 <vector44>:
.globl vector44
vector44:
  pushl $0
80106d22:	6a 00                	push   $0x0
  pushl $44
80106d24:	6a 2c                	push   $0x2c
  jmp alltraps
80106d26:	e9 e9 f7 ff ff       	jmp    80106514 <alltraps>

80106d2b <vector45>:
.globl vector45
vector45:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $45
80106d2d:	6a 2d                	push   $0x2d
  jmp alltraps
80106d2f:	e9 e0 f7 ff ff       	jmp    80106514 <alltraps>

80106d34 <vector46>:
.globl vector46
vector46:
  pushl $0
80106d34:	6a 00                	push   $0x0
  pushl $46
80106d36:	6a 2e                	push   $0x2e
  jmp alltraps
80106d38:	e9 d7 f7 ff ff       	jmp    80106514 <alltraps>

80106d3d <vector47>:
.globl vector47
vector47:
  pushl $0
80106d3d:	6a 00                	push   $0x0
  pushl $47
80106d3f:	6a 2f                	push   $0x2f
  jmp alltraps
80106d41:	e9 ce f7 ff ff       	jmp    80106514 <alltraps>

80106d46 <vector48>:
.globl vector48
vector48:
  pushl $0
80106d46:	6a 00                	push   $0x0
  pushl $48
80106d48:	6a 30                	push   $0x30
  jmp alltraps
80106d4a:	e9 c5 f7 ff ff       	jmp    80106514 <alltraps>

80106d4f <vector49>:
.globl vector49
vector49:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $49
80106d51:	6a 31                	push   $0x31
  jmp alltraps
80106d53:	e9 bc f7 ff ff       	jmp    80106514 <alltraps>

80106d58 <vector50>:
.globl vector50
vector50:
  pushl $0
80106d58:	6a 00                	push   $0x0
  pushl $50
80106d5a:	6a 32                	push   $0x32
  jmp alltraps
80106d5c:	e9 b3 f7 ff ff       	jmp    80106514 <alltraps>

80106d61 <vector51>:
.globl vector51
vector51:
  pushl $0
80106d61:	6a 00                	push   $0x0
  pushl $51
80106d63:	6a 33                	push   $0x33
  jmp alltraps
80106d65:	e9 aa f7 ff ff       	jmp    80106514 <alltraps>

80106d6a <vector52>:
.globl vector52
vector52:
  pushl $0
80106d6a:	6a 00                	push   $0x0
  pushl $52
80106d6c:	6a 34                	push   $0x34
  jmp alltraps
80106d6e:	e9 a1 f7 ff ff       	jmp    80106514 <alltraps>

80106d73 <vector53>:
.globl vector53
vector53:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $53
80106d75:	6a 35                	push   $0x35
  jmp alltraps
80106d77:	e9 98 f7 ff ff       	jmp    80106514 <alltraps>

80106d7c <vector54>:
.globl vector54
vector54:
  pushl $0
80106d7c:	6a 00                	push   $0x0
  pushl $54
80106d7e:	6a 36                	push   $0x36
  jmp alltraps
80106d80:	e9 8f f7 ff ff       	jmp    80106514 <alltraps>

80106d85 <vector55>:
.globl vector55
vector55:
  pushl $0
80106d85:	6a 00                	push   $0x0
  pushl $55
80106d87:	6a 37                	push   $0x37
  jmp alltraps
80106d89:	e9 86 f7 ff ff       	jmp    80106514 <alltraps>

80106d8e <vector56>:
.globl vector56
vector56:
  pushl $0
80106d8e:	6a 00                	push   $0x0
  pushl $56
80106d90:	6a 38                	push   $0x38
  jmp alltraps
80106d92:	e9 7d f7 ff ff       	jmp    80106514 <alltraps>

80106d97 <vector57>:
.globl vector57
vector57:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $57
80106d99:	6a 39                	push   $0x39
  jmp alltraps
80106d9b:	e9 74 f7 ff ff       	jmp    80106514 <alltraps>

80106da0 <vector58>:
.globl vector58
vector58:
  pushl $0
80106da0:	6a 00                	push   $0x0
  pushl $58
80106da2:	6a 3a                	push   $0x3a
  jmp alltraps
80106da4:	e9 6b f7 ff ff       	jmp    80106514 <alltraps>

80106da9 <vector59>:
.globl vector59
vector59:
  pushl $0
80106da9:	6a 00                	push   $0x0
  pushl $59
80106dab:	6a 3b                	push   $0x3b
  jmp alltraps
80106dad:	e9 62 f7 ff ff       	jmp    80106514 <alltraps>

80106db2 <vector60>:
.globl vector60
vector60:
  pushl $0
80106db2:	6a 00                	push   $0x0
  pushl $60
80106db4:	6a 3c                	push   $0x3c
  jmp alltraps
80106db6:	e9 59 f7 ff ff       	jmp    80106514 <alltraps>

80106dbb <vector61>:
.globl vector61
vector61:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $61
80106dbd:	6a 3d                	push   $0x3d
  jmp alltraps
80106dbf:	e9 50 f7 ff ff       	jmp    80106514 <alltraps>

80106dc4 <vector62>:
.globl vector62
vector62:
  pushl $0
80106dc4:	6a 00                	push   $0x0
  pushl $62
80106dc6:	6a 3e                	push   $0x3e
  jmp alltraps
80106dc8:	e9 47 f7 ff ff       	jmp    80106514 <alltraps>

80106dcd <vector63>:
.globl vector63
vector63:
  pushl $0
80106dcd:	6a 00                	push   $0x0
  pushl $63
80106dcf:	6a 3f                	push   $0x3f
  jmp alltraps
80106dd1:	e9 3e f7 ff ff       	jmp    80106514 <alltraps>

80106dd6 <vector64>:
.globl vector64
vector64:
  pushl $0
80106dd6:	6a 00                	push   $0x0
  pushl $64
80106dd8:	6a 40                	push   $0x40
  jmp alltraps
80106dda:	e9 35 f7 ff ff       	jmp    80106514 <alltraps>

80106ddf <vector65>:
.globl vector65
vector65:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $65
80106de1:	6a 41                	push   $0x41
  jmp alltraps
80106de3:	e9 2c f7 ff ff       	jmp    80106514 <alltraps>

80106de8 <vector66>:
.globl vector66
vector66:
  pushl $0
80106de8:	6a 00                	push   $0x0
  pushl $66
80106dea:	6a 42                	push   $0x42
  jmp alltraps
80106dec:	e9 23 f7 ff ff       	jmp    80106514 <alltraps>

80106df1 <vector67>:
.globl vector67
vector67:
  pushl $0
80106df1:	6a 00                	push   $0x0
  pushl $67
80106df3:	6a 43                	push   $0x43
  jmp alltraps
80106df5:	e9 1a f7 ff ff       	jmp    80106514 <alltraps>

80106dfa <vector68>:
.globl vector68
vector68:
  pushl $0
80106dfa:	6a 00                	push   $0x0
  pushl $68
80106dfc:	6a 44                	push   $0x44
  jmp alltraps
80106dfe:	e9 11 f7 ff ff       	jmp    80106514 <alltraps>

80106e03 <vector69>:
.globl vector69
vector69:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $69
80106e05:	6a 45                	push   $0x45
  jmp alltraps
80106e07:	e9 08 f7 ff ff       	jmp    80106514 <alltraps>

80106e0c <vector70>:
.globl vector70
vector70:
  pushl $0
80106e0c:	6a 00                	push   $0x0
  pushl $70
80106e0e:	6a 46                	push   $0x46
  jmp alltraps
80106e10:	e9 ff f6 ff ff       	jmp    80106514 <alltraps>

80106e15 <vector71>:
.globl vector71
vector71:
  pushl $0
80106e15:	6a 00                	push   $0x0
  pushl $71
80106e17:	6a 47                	push   $0x47
  jmp alltraps
80106e19:	e9 f6 f6 ff ff       	jmp    80106514 <alltraps>

80106e1e <vector72>:
.globl vector72
vector72:
  pushl $0
80106e1e:	6a 00                	push   $0x0
  pushl $72
80106e20:	6a 48                	push   $0x48
  jmp alltraps
80106e22:	e9 ed f6 ff ff       	jmp    80106514 <alltraps>

80106e27 <vector73>:
.globl vector73
vector73:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $73
80106e29:	6a 49                	push   $0x49
  jmp alltraps
80106e2b:	e9 e4 f6 ff ff       	jmp    80106514 <alltraps>

80106e30 <vector74>:
.globl vector74
vector74:
  pushl $0
80106e30:	6a 00                	push   $0x0
  pushl $74
80106e32:	6a 4a                	push   $0x4a
  jmp alltraps
80106e34:	e9 db f6 ff ff       	jmp    80106514 <alltraps>

80106e39 <vector75>:
.globl vector75
vector75:
  pushl $0
80106e39:	6a 00                	push   $0x0
  pushl $75
80106e3b:	6a 4b                	push   $0x4b
  jmp alltraps
80106e3d:	e9 d2 f6 ff ff       	jmp    80106514 <alltraps>

80106e42 <vector76>:
.globl vector76
vector76:
  pushl $0
80106e42:	6a 00                	push   $0x0
  pushl $76
80106e44:	6a 4c                	push   $0x4c
  jmp alltraps
80106e46:	e9 c9 f6 ff ff       	jmp    80106514 <alltraps>

80106e4b <vector77>:
.globl vector77
vector77:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $77
80106e4d:	6a 4d                	push   $0x4d
  jmp alltraps
80106e4f:	e9 c0 f6 ff ff       	jmp    80106514 <alltraps>

80106e54 <vector78>:
.globl vector78
vector78:
  pushl $0
80106e54:	6a 00                	push   $0x0
  pushl $78
80106e56:	6a 4e                	push   $0x4e
  jmp alltraps
80106e58:	e9 b7 f6 ff ff       	jmp    80106514 <alltraps>

80106e5d <vector79>:
.globl vector79
vector79:
  pushl $0
80106e5d:	6a 00                	push   $0x0
  pushl $79
80106e5f:	6a 4f                	push   $0x4f
  jmp alltraps
80106e61:	e9 ae f6 ff ff       	jmp    80106514 <alltraps>

80106e66 <vector80>:
.globl vector80
vector80:
  pushl $0
80106e66:	6a 00                	push   $0x0
  pushl $80
80106e68:	6a 50                	push   $0x50
  jmp alltraps
80106e6a:	e9 a5 f6 ff ff       	jmp    80106514 <alltraps>

80106e6f <vector81>:
.globl vector81
vector81:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $81
80106e71:	6a 51                	push   $0x51
  jmp alltraps
80106e73:	e9 9c f6 ff ff       	jmp    80106514 <alltraps>

80106e78 <vector82>:
.globl vector82
vector82:
  pushl $0
80106e78:	6a 00                	push   $0x0
  pushl $82
80106e7a:	6a 52                	push   $0x52
  jmp alltraps
80106e7c:	e9 93 f6 ff ff       	jmp    80106514 <alltraps>

80106e81 <vector83>:
.globl vector83
vector83:
  pushl $0
80106e81:	6a 00                	push   $0x0
  pushl $83
80106e83:	6a 53                	push   $0x53
  jmp alltraps
80106e85:	e9 8a f6 ff ff       	jmp    80106514 <alltraps>

80106e8a <vector84>:
.globl vector84
vector84:
  pushl $0
80106e8a:	6a 00                	push   $0x0
  pushl $84
80106e8c:	6a 54                	push   $0x54
  jmp alltraps
80106e8e:	e9 81 f6 ff ff       	jmp    80106514 <alltraps>

80106e93 <vector85>:
.globl vector85
vector85:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $85
80106e95:	6a 55                	push   $0x55
  jmp alltraps
80106e97:	e9 78 f6 ff ff       	jmp    80106514 <alltraps>

80106e9c <vector86>:
.globl vector86
vector86:
  pushl $0
80106e9c:	6a 00                	push   $0x0
  pushl $86
80106e9e:	6a 56                	push   $0x56
  jmp alltraps
80106ea0:	e9 6f f6 ff ff       	jmp    80106514 <alltraps>

80106ea5 <vector87>:
.globl vector87
vector87:
  pushl $0
80106ea5:	6a 00                	push   $0x0
  pushl $87
80106ea7:	6a 57                	push   $0x57
  jmp alltraps
80106ea9:	e9 66 f6 ff ff       	jmp    80106514 <alltraps>

80106eae <vector88>:
.globl vector88
vector88:
  pushl $0
80106eae:	6a 00                	push   $0x0
  pushl $88
80106eb0:	6a 58                	push   $0x58
  jmp alltraps
80106eb2:	e9 5d f6 ff ff       	jmp    80106514 <alltraps>

80106eb7 <vector89>:
.globl vector89
vector89:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $89
80106eb9:	6a 59                	push   $0x59
  jmp alltraps
80106ebb:	e9 54 f6 ff ff       	jmp    80106514 <alltraps>

80106ec0 <vector90>:
.globl vector90
vector90:
  pushl $0
80106ec0:	6a 00                	push   $0x0
  pushl $90
80106ec2:	6a 5a                	push   $0x5a
  jmp alltraps
80106ec4:	e9 4b f6 ff ff       	jmp    80106514 <alltraps>

80106ec9 <vector91>:
.globl vector91
vector91:
  pushl $0
80106ec9:	6a 00                	push   $0x0
  pushl $91
80106ecb:	6a 5b                	push   $0x5b
  jmp alltraps
80106ecd:	e9 42 f6 ff ff       	jmp    80106514 <alltraps>

80106ed2 <vector92>:
.globl vector92
vector92:
  pushl $0
80106ed2:	6a 00                	push   $0x0
  pushl $92
80106ed4:	6a 5c                	push   $0x5c
  jmp alltraps
80106ed6:	e9 39 f6 ff ff       	jmp    80106514 <alltraps>

80106edb <vector93>:
.globl vector93
vector93:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $93
80106edd:	6a 5d                	push   $0x5d
  jmp alltraps
80106edf:	e9 30 f6 ff ff       	jmp    80106514 <alltraps>

80106ee4 <vector94>:
.globl vector94
vector94:
  pushl $0
80106ee4:	6a 00                	push   $0x0
  pushl $94
80106ee6:	6a 5e                	push   $0x5e
  jmp alltraps
80106ee8:	e9 27 f6 ff ff       	jmp    80106514 <alltraps>

80106eed <vector95>:
.globl vector95
vector95:
  pushl $0
80106eed:	6a 00                	push   $0x0
  pushl $95
80106eef:	6a 5f                	push   $0x5f
  jmp alltraps
80106ef1:	e9 1e f6 ff ff       	jmp    80106514 <alltraps>

80106ef6 <vector96>:
.globl vector96
vector96:
  pushl $0
80106ef6:	6a 00                	push   $0x0
  pushl $96
80106ef8:	6a 60                	push   $0x60
  jmp alltraps
80106efa:	e9 15 f6 ff ff       	jmp    80106514 <alltraps>

80106eff <vector97>:
.globl vector97
vector97:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $97
80106f01:	6a 61                	push   $0x61
  jmp alltraps
80106f03:	e9 0c f6 ff ff       	jmp    80106514 <alltraps>

80106f08 <vector98>:
.globl vector98
vector98:
  pushl $0
80106f08:	6a 00                	push   $0x0
  pushl $98
80106f0a:	6a 62                	push   $0x62
  jmp alltraps
80106f0c:	e9 03 f6 ff ff       	jmp    80106514 <alltraps>

80106f11 <vector99>:
.globl vector99
vector99:
  pushl $0
80106f11:	6a 00                	push   $0x0
  pushl $99
80106f13:	6a 63                	push   $0x63
  jmp alltraps
80106f15:	e9 fa f5 ff ff       	jmp    80106514 <alltraps>

80106f1a <vector100>:
.globl vector100
vector100:
  pushl $0
80106f1a:	6a 00                	push   $0x0
  pushl $100
80106f1c:	6a 64                	push   $0x64
  jmp alltraps
80106f1e:	e9 f1 f5 ff ff       	jmp    80106514 <alltraps>

80106f23 <vector101>:
.globl vector101
vector101:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $101
80106f25:	6a 65                	push   $0x65
  jmp alltraps
80106f27:	e9 e8 f5 ff ff       	jmp    80106514 <alltraps>

80106f2c <vector102>:
.globl vector102
vector102:
  pushl $0
80106f2c:	6a 00                	push   $0x0
  pushl $102
80106f2e:	6a 66                	push   $0x66
  jmp alltraps
80106f30:	e9 df f5 ff ff       	jmp    80106514 <alltraps>

80106f35 <vector103>:
.globl vector103
vector103:
  pushl $0
80106f35:	6a 00                	push   $0x0
  pushl $103
80106f37:	6a 67                	push   $0x67
  jmp alltraps
80106f39:	e9 d6 f5 ff ff       	jmp    80106514 <alltraps>

80106f3e <vector104>:
.globl vector104
vector104:
  pushl $0
80106f3e:	6a 00                	push   $0x0
  pushl $104
80106f40:	6a 68                	push   $0x68
  jmp alltraps
80106f42:	e9 cd f5 ff ff       	jmp    80106514 <alltraps>

80106f47 <vector105>:
.globl vector105
vector105:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $105
80106f49:	6a 69                	push   $0x69
  jmp alltraps
80106f4b:	e9 c4 f5 ff ff       	jmp    80106514 <alltraps>

80106f50 <vector106>:
.globl vector106
vector106:
  pushl $0
80106f50:	6a 00                	push   $0x0
  pushl $106
80106f52:	6a 6a                	push   $0x6a
  jmp alltraps
80106f54:	e9 bb f5 ff ff       	jmp    80106514 <alltraps>

80106f59 <vector107>:
.globl vector107
vector107:
  pushl $0
80106f59:	6a 00                	push   $0x0
  pushl $107
80106f5b:	6a 6b                	push   $0x6b
  jmp alltraps
80106f5d:	e9 b2 f5 ff ff       	jmp    80106514 <alltraps>

80106f62 <vector108>:
.globl vector108
vector108:
  pushl $0
80106f62:	6a 00                	push   $0x0
  pushl $108
80106f64:	6a 6c                	push   $0x6c
  jmp alltraps
80106f66:	e9 a9 f5 ff ff       	jmp    80106514 <alltraps>

80106f6b <vector109>:
.globl vector109
vector109:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $109
80106f6d:	6a 6d                	push   $0x6d
  jmp alltraps
80106f6f:	e9 a0 f5 ff ff       	jmp    80106514 <alltraps>

80106f74 <vector110>:
.globl vector110
vector110:
  pushl $0
80106f74:	6a 00                	push   $0x0
  pushl $110
80106f76:	6a 6e                	push   $0x6e
  jmp alltraps
80106f78:	e9 97 f5 ff ff       	jmp    80106514 <alltraps>

80106f7d <vector111>:
.globl vector111
vector111:
  pushl $0
80106f7d:	6a 00                	push   $0x0
  pushl $111
80106f7f:	6a 6f                	push   $0x6f
  jmp alltraps
80106f81:	e9 8e f5 ff ff       	jmp    80106514 <alltraps>

80106f86 <vector112>:
.globl vector112
vector112:
  pushl $0
80106f86:	6a 00                	push   $0x0
  pushl $112
80106f88:	6a 70                	push   $0x70
  jmp alltraps
80106f8a:	e9 85 f5 ff ff       	jmp    80106514 <alltraps>

80106f8f <vector113>:
.globl vector113
vector113:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $113
80106f91:	6a 71                	push   $0x71
  jmp alltraps
80106f93:	e9 7c f5 ff ff       	jmp    80106514 <alltraps>

80106f98 <vector114>:
.globl vector114
vector114:
  pushl $0
80106f98:	6a 00                	push   $0x0
  pushl $114
80106f9a:	6a 72                	push   $0x72
  jmp alltraps
80106f9c:	e9 73 f5 ff ff       	jmp    80106514 <alltraps>

80106fa1 <vector115>:
.globl vector115
vector115:
  pushl $0
80106fa1:	6a 00                	push   $0x0
  pushl $115
80106fa3:	6a 73                	push   $0x73
  jmp alltraps
80106fa5:	e9 6a f5 ff ff       	jmp    80106514 <alltraps>

80106faa <vector116>:
.globl vector116
vector116:
  pushl $0
80106faa:	6a 00                	push   $0x0
  pushl $116
80106fac:	6a 74                	push   $0x74
  jmp alltraps
80106fae:	e9 61 f5 ff ff       	jmp    80106514 <alltraps>

80106fb3 <vector117>:
.globl vector117
vector117:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $117
80106fb5:	6a 75                	push   $0x75
  jmp alltraps
80106fb7:	e9 58 f5 ff ff       	jmp    80106514 <alltraps>

80106fbc <vector118>:
.globl vector118
vector118:
  pushl $0
80106fbc:	6a 00                	push   $0x0
  pushl $118
80106fbe:	6a 76                	push   $0x76
  jmp alltraps
80106fc0:	e9 4f f5 ff ff       	jmp    80106514 <alltraps>

80106fc5 <vector119>:
.globl vector119
vector119:
  pushl $0
80106fc5:	6a 00                	push   $0x0
  pushl $119
80106fc7:	6a 77                	push   $0x77
  jmp alltraps
80106fc9:	e9 46 f5 ff ff       	jmp    80106514 <alltraps>

80106fce <vector120>:
.globl vector120
vector120:
  pushl $0
80106fce:	6a 00                	push   $0x0
  pushl $120
80106fd0:	6a 78                	push   $0x78
  jmp alltraps
80106fd2:	e9 3d f5 ff ff       	jmp    80106514 <alltraps>

80106fd7 <vector121>:
.globl vector121
vector121:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $121
80106fd9:	6a 79                	push   $0x79
  jmp alltraps
80106fdb:	e9 34 f5 ff ff       	jmp    80106514 <alltraps>

80106fe0 <vector122>:
.globl vector122
vector122:
  pushl $0
80106fe0:	6a 00                	push   $0x0
  pushl $122
80106fe2:	6a 7a                	push   $0x7a
  jmp alltraps
80106fe4:	e9 2b f5 ff ff       	jmp    80106514 <alltraps>

80106fe9 <vector123>:
.globl vector123
vector123:
  pushl $0
80106fe9:	6a 00                	push   $0x0
  pushl $123
80106feb:	6a 7b                	push   $0x7b
  jmp alltraps
80106fed:	e9 22 f5 ff ff       	jmp    80106514 <alltraps>

80106ff2 <vector124>:
.globl vector124
vector124:
  pushl $0
80106ff2:	6a 00                	push   $0x0
  pushl $124
80106ff4:	6a 7c                	push   $0x7c
  jmp alltraps
80106ff6:	e9 19 f5 ff ff       	jmp    80106514 <alltraps>

80106ffb <vector125>:
.globl vector125
vector125:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $125
80106ffd:	6a 7d                	push   $0x7d
  jmp alltraps
80106fff:	e9 10 f5 ff ff       	jmp    80106514 <alltraps>

80107004 <vector126>:
.globl vector126
vector126:
  pushl $0
80107004:	6a 00                	push   $0x0
  pushl $126
80107006:	6a 7e                	push   $0x7e
  jmp alltraps
80107008:	e9 07 f5 ff ff       	jmp    80106514 <alltraps>

8010700d <vector127>:
.globl vector127
vector127:
  pushl $0
8010700d:	6a 00                	push   $0x0
  pushl $127
8010700f:	6a 7f                	push   $0x7f
  jmp alltraps
80107011:	e9 fe f4 ff ff       	jmp    80106514 <alltraps>

80107016 <vector128>:
.globl vector128
vector128:
  pushl $0
80107016:	6a 00                	push   $0x0
  pushl $128
80107018:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010701d:	e9 f2 f4 ff ff       	jmp    80106514 <alltraps>

80107022 <vector129>:
.globl vector129
vector129:
  pushl $0
80107022:	6a 00                	push   $0x0
  pushl $129
80107024:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107029:	e9 e6 f4 ff ff       	jmp    80106514 <alltraps>

8010702e <vector130>:
.globl vector130
vector130:
  pushl $0
8010702e:	6a 00                	push   $0x0
  pushl $130
80107030:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107035:	e9 da f4 ff ff       	jmp    80106514 <alltraps>

8010703a <vector131>:
.globl vector131
vector131:
  pushl $0
8010703a:	6a 00                	push   $0x0
  pushl $131
8010703c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107041:	e9 ce f4 ff ff       	jmp    80106514 <alltraps>

80107046 <vector132>:
.globl vector132
vector132:
  pushl $0
80107046:	6a 00                	push   $0x0
  pushl $132
80107048:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010704d:	e9 c2 f4 ff ff       	jmp    80106514 <alltraps>

80107052 <vector133>:
.globl vector133
vector133:
  pushl $0
80107052:	6a 00                	push   $0x0
  pushl $133
80107054:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107059:	e9 b6 f4 ff ff       	jmp    80106514 <alltraps>

8010705e <vector134>:
.globl vector134
vector134:
  pushl $0
8010705e:	6a 00                	push   $0x0
  pushl $134
80107060:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107065:	e9 aa f4 ff ff       	jmp    80106514 <alltraps>

8010706a <vector135>:
.globl vector135
vector135:
  pushl $0
8010706a:	6a 00                	push   $0x0
  pushl $135
8010706c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107071:	e9 9e f4 ff ff       	jmp    80106514 <alltraps>

80107076 <vector136>:
.globl vector136
vector136:
  pushl $0
80107076:	6a 00                	push   $0x0
  pushl $136
80107078:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010707d:	e9 92 f4 ff ff       	jmp    80106514 <alltraps>

80107082 <vector137>:
.globl vector137
vector137:
  pushl $0
80107082:	6a 00                	push   $0x0
  pushl $137
80107084:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107089:	e9 86 f4 ff ff       	jmp    80106514 <alltraps>

8010708e <vector138>:
.globl vector138
vector138:
  pushl $0
8010708e:	6a 00                	push   $0x0
  pushl $138
80107090:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107095:	e9 7a f4 ff ff       	jmp    80106514 <alltraps>

8010709a <vector139>:
.globl vector139
vector139:
  pushl $0
8010709a:	6a 00                	push   $0x0
  pushl $139
8010709c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801070a1:	e9 6e f4 ff ff       	jmp    80106514 <alltraps>

801070a6 <vector140>:
.globl vector140
vector140:
  pushl $0
801070a6:	6a 00                	push   $0x0
  pushl $140
801070a8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801070ad:	e9 62 f4 ff ff       	jmp    80106514 <alltraps>

801070b2 <vector141>:
.globl vector141
vector141:
  pushl $0
801070b2:	6a 00                	push   $0x0
  pushl $141
801070b4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801070b9:	e9 56 f4 ff ff       	jmp    80106514 <alltraps>

801070be <vector142>:
.globl vector142
vector142:
  pushl $0
801070be:	6a 00                	push   $0x0
  pushl $142
801070c0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801070c5:	e9 4a f4 ff ff       	jmp    80106514 <alltraps>

801070ca <vector143>:
.globl vector143
vector143:
  pushl $0
801070ca:	6a 00                	push   $0x0
  pushl $143
801070cc:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801070d1:	e9 3e f4 ff ff       	jmp    80106514 <alltraps>

801070d6 <vector144>:
.globl vector144
vector144:
  pushl $0
801070d6:	6a 00                	push   $0x0
  pushl $144
801070d8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801070dd:	e9 32 f4 ff ff       	jmp    80106514 <alltraps>

801070e2 <vector145>:
.globl vector145
vector145:
  pushl $0
801070e2:	6a 00                	push   $0x0
  pushl $145
801070e4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801070e9:	e9 26 f4 ff ff       	jmp    80106514 <alltraps>

801070ee <vector146>:
.globl vector146
vector146:
  pushl $0
801070ee:	6a 00                	push   $0x0
  pushl $146
801070f0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801070f5:	e9 1a f4 ff ff       	jmp    80106514 <alltraps>

801070fa <vector147>:
.globl vector147
vector147:
  pushl $0
801070fa:	6a 00                	push   $0x0
  pushl $147
801070fc:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107101:	e9 0e f4 ff ff       	jmp    80106514 <alltraps>

80107106 <vector148>:
.globl vector148
vector148:
  pushl $0
80107106:	6a 00                	push   $0x0
  pushl $148
80107108:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010710d:	e9 02 f4 ff ff       	jmp    80106514 <alltraps>

80107112 <vector149>:
.globl vector149
vector149:
  pushl $0
80107112:	6a 00                	push   $0x0
  pushl $149
80107114:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107119:	e9 f6 f3 ff ff       	jmp    80106514 <alltraps>

8010711e <vector150>:
.globl vector150
vector150:
  pushl $0
8010711e:	6a 00                	push   $0x0
  pushl $150
80107120:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107125:	e9 ea f3 ff ff       	jmp    80106514 <alltraps>

8010712a <vector151>:
.globl vector151
vector151:
  pushl $0
8010712a:	6a 00                	push   $0x0
  pushl $151
8010712c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107131:	e9 de f3 ff ff       	jmp    80106514 <alltraps>

80107136 <vector152>:
.globl vector152
vector152:
  pushl $0
80107136:	6a 00                	push   $0x0
  pushl $152
80107138:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010713d:	e9 d2 f3 ff ff       	jmp    80106514 <alltraps>

80107142 <vector153>:
.globl vector153
vector153:
  pushl $0
80107142:	6a 00                	push   $0x0
  pushl $153
80107144:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107149:	e9 c6 f3 ff ff       	jmp    80106514 <alltraps>

8010714e <vector154>:
.globl vector154
vector154:
  pushl $0
8010714e:	6a 00                	push   $0x0
  pushl $154
80107150:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107155:	e9 ba f3 ff ff       	jmp    80106514 <alltraps>

8010715a <vector155>:
.globl vector155
vector155:
  pushl $0
8010715a:	6a 00                	push   $0x0
  pushl $155
8010715c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107161:	e9 ae f3 ff ff       	jmp    80106514 <alltraps>

80107166 <vector156>:
.globl vector156
vector156:
  pushl $0
80107166:	6a 00                	push   $0x0
  pushl $156
80107168:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010716d:	e9 a2 f3 ff ff       	jmp    80106514 <alltraps>

80107172 <vector157>:
.globl vector157
vector157:
  pushl $0
80107172:	6a 00                	push   $0x0
  pushl $157
80107174:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107179:	e9 96 f3 ff ff       	jmp    80106514 <alltraps>

8010717e <vector158>:
.globl vector158
vector158:
  pushl $0
8010717e:	6a 00                	push   $0x0
  pushl $158
80107180:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107185:	e9 8a f3 ff ff       	jmp    80106514 <alltraps>

8010718a <vector159>:
.globl vector159
vector159:
  pushl $0
8010718a:	6a 00                	push   $0x0
  pushl $159
8010718c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107191:	e9 7e f3 ff ff       	jmp    80106514 <alltraps>

80107196 <vector160>:
.globl vector160
vector160:
  pushl $0
80107196:	6a 00                	push   $0x0
  pushl $160
80107198:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010719d:	e9 72 f3 ff ff       	jmp    80106514 <alltraps>

801071a2 <vector161>:
.globl vector161
vector161:
  pushl $0
801071a2:	6a 00                	push   $0x0
  pushl $161
801071a4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801071a9:	e9 66 f3 ff ff       	jmp    80106514 <alltraps>

801071ae <vector162>:
.globl vector162
vector162:
  pushl $0
801071ae:	6a 00                	push   $0x0
  pushl $162
801071b0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801071b5:	e9 5a f3 ff ff       	jmp    80106514 <alltraps>

801071ba <vector163>:
.globl vector163
vector163:
  pushl $0
801071ba:	6a 00                	push   $0x0
  pushl $163
801071bc:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801071c1:	e9 4e f3 ff ff       	jmp    80106514 <alltraps>

801071c6 <vector164>:
.globl vector164
vector164:
  pushl $0
801071c6:	6a 00                	push   $0x0
  pushl $164
801071c8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801071cd:	e9 42 f3 ff ff       	jmp    80106514 <alltraps>

801071d2 <vector165>:
.globl vector165
vector165:
  pushl $0
801071d2:	6a 00                	push   $0x0
  pushl $165
801071d4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801071d9:	e9 36 f3 ff ff       	jmp    80106514 <alltraps>

801071de <vector166>:
.globl vector166
vector166:
  pushl $0
801071de:	6a 00                	push   $0x0
  pushl $166
801071e0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801071e5:	e9 2a f3 ff ff       	jmp    80106514 <alltraps>

801071ea <vector167>:
.globl vector167
vector167:
  pushl $0
801071ea:	6a 00                	push   $0x0
  pushl $167
801071ec:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801071f1:	e9 1e f3 ff ff       	jmp    80106514 <alltraps>

801071f6 <vector168>:
.globl vector168
vector168:
  pushl $0
801071f6:	6a 00                	push   $0x0
  pushl $168
801071f8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801071fd:	e9 12 f3 ff ff       	jmp    80106514 <alltraps>

80107202 <vector169>:
.globl vector169
vector169:
  pushl $0
80107202:	6a 00                	push   $0x0
  pushl $169
80107204:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107209:	e9 06 f3 ff ff       	jmp    80106514 <alltraps>

8010720e <vector170>:
.globl vector170
vector170:
  pushl $0
8010720e:	6a 00                	push   $0x0
  pushl $170
80107210:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107215:	e9 fa f2 ff ff       	jmp    80106514 <alltraps>

8010721a <vector171>:
.globl vector171
vector171:
  pushl $0
8010721a:	6a 00                	push   $0x0
  pushl $171
8010721c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107221:	e9 ee f2 ff ff       	jmp    80106514 <alltraps>

80107226 <vector172>:
.globl vector172
vector172:
  pushl $0
80107226:	6a 00                	push   $0x0
  pushl $172
80107228:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010722d:	e9 e2 f2 ff ff       	jmp    80106514 <alltraps>

80107232 <vector173>:
.globl vector173
vector173:
  pushl $0
80107232:	6a 00                	push   $0x0
  pushl $173
80107234:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107239:	e9 d6 f2 ff ff       	jmp    80106514 <alltraps>

8010723e <vector174>:
.globl vector174
vector174:
  pushl $0
8010723e:	6a 00                	push   $0x0
  pushl $174
80107240:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107245:	e9 ca f2 ff ff       	jmp    80106514 <alltraps>

8010724a <vector175>:
.globl vector175
vector175:
  pushl $0
8010724a:	6a 00                	push   $0x0
  pushl $175
8010724c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107251:	e9 be f2 ff ff       	jmp    80106514 <alltraps>

80107256 <vector176>:
.globl vector176
vector176:
  pushl $0
80107256:	6a 00                	push   $0x0
  pushl $176
80107258:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010725d:	e9 b2 f2 ff ff       	jmp    80106514 <alltraps>

80107262 <vector177>:
.globl vector177
vector177:
  pushl $0
80107262:	6a 00                	push   $0x0
  pushl $177
80107264:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107269:	e9 a6 f2 ff ff       	jmp    80106514 <alltraps>

8010726e <vector178>:
.globl vector178
vector178:
  pushl $0
8010726e:	6a 00                	push   $0x0
  pushl $178
80107270:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107275:	e9 9a f2 ff ff       	jmp    80106514 <alltraps>

8010727a <vector179>:
.globl vector179
vector179:
  pushl $0
8010727a:	6a 00                	push   $0x0
  pushl $179
8010727c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107281:	e9 8e f2 ff ff       	jmp    80106514 <alltraps>

80107286 <vector180>:
.globl vector180
vector180:
  pushl $0
80107286:	6a 00                	push   $0x0
  pushl $180
80107288:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010728d:	e9 82 f2 ff ff       	jmp    80106514 <alltraps>

80107292 <vector181>:
.globl vector181
vector181:
  pushl $0
80107292:	6a 00                	push   $0x0
  pushl $181
80107294:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107299:	e9 76 f2 ff ff       	jmp    80106514 <alltraps>

8010729e <vector182>:
.globl vector182
vector182:
  pushl $0
8010729e:	6a 00                	push   $0x0
  pushl $182
801072a0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801072a5:	e9 6a f2 ff ff       	jmp    80106514 <alltraps>

801072aa <vector183>:
.globl vector183
vector183:
  pushl $0
801072aa:	6a 00                	push   $0x0
  pushl $183
801072ac:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801072b1:	e9 5e f2 ff ff       	jmp    80106514 <alltraps>

801072b6 <vector184>:
.globl vector184
vector184:
  pushl $0
801072b6:	6a 00                	push   $0x0
  pushl $184
801072b8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801072bd:	e9 52 f2 ff ff       	jmp    80106514 <alltraps>

801072c2 <vector185>:
.globl vector185
vector185:
  pushl $0
801072c2:	6a 00                	push   $0x0
  pushl $185
801072c4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801072c9:	e9 46 f2 ff ff       	jmp    80106514 <alltraps>

801072ce <vector186>:
.globl vector186
vector186:
  pushl $0
801072ce:	6a 00                	push   $0x0
  pushl $186
801072d0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801072d5:	e9 3a f2 ff ff       	jmp    80106514 <alltraps>

801072da <vector187>:
.globl vector187
vector187:
  pushl $0
801072da:	6a 00                	push   $0x0
  pushl $187
801072dc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801072e1:	e9 2e f2 ff ff       	jmp    80106514 <alltraps>

801072e6 <vector188>:
.globl vector188
vector188:
  pushl $0
801072e6:	6a 00                	push   $0x0
  pushl $188
801072e8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801072ed:	e9 22 f2 ff ff       	jmp    80106514 <alltraps>

801072f2 <vector189>:
.globl vector189
vector189:
  pushl $0
801072f2:	6a 00                	push   $0x0
  pushl $189
801072f4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801072f9:	e9 16 f2 ff ff       	jmp    80106514 <alltraps>

801072fe <vector190>:
.globl vector190
vector190:
  pushl $0
801072fe:	6a 00                	push   $0x0
  pushl $190
80107300:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107305:	e9 0a f2 ff ff       	jmp    80106514 <alltraps>

8010730a <vector191>:
.globl vector191
vector191:
  pushl $0
8010730a:	6a 00                	push   $0x0
  pushl $191
8010730c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107311:	e9 fe f1 ff ff       	jmp    80106514 <alltraps>

80107316 <vector192>:
.globl vector192
vector192:
  pushl $0
80107316:	6a 00                	push   $0x0
  pushl $192
80107318:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010731d:	e9 f2 f1 ff ff       	jmp    80106514 <alltraps>

80107322 <vector193>:
.globl vector193
vector193:
  pushl $0
80107322:	6a 00                	push   $0x0
  pushl $193
80107324:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107329:	e9 e6 f1 ff ff       	jmp    80106514 <alltraps>

8010732e <vector194>:
.globl vector194
vector194:
  pushl $0
8010732e:	6a 00                	push   $0x0
  pushl $194
80107330:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107335:	e9 da f1 ff ff       	jmp    80106514 <alltraps>

8010733a <vector195>:
.globl vector195
vector195:
  pushl $0
8010733a:	6a 00                	push   $0x0
  pushl $195
8010733c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107341:	e9 ce f1 ff ff       	jmp    80106514 <alltraps>

80107346 <vector196>:
.globl vector196
vector196:
  pushl $0
80107346:	6a 00                	push   $0x0
  pushl $196
80107348:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010734d:	e9 c2 f1 ff ff       	jmp    80106514 <alltraps>

80107352 <vector197>:
.globl vector197
vector197:
  pushl $0
80107352:	6a 00                	push   $0x0
  pushl $197
80107354:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107359:	e9 b6 f1 ff ff       	jmp    80106514 <alltraps>

8010735e <vector198>:
.globl vector198
vector198:
  pushl $0
8010735e:	6a 00                	push   $0x0
  pushl $198
80107360:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107365:	e9 aa f1 ff ff       	jmp    80106514 <alltraps>

8010736a <vector199>:
.globl vector199
vector199:
  pushl $0
8010736a:	6a 00                	push   $0x0
  pushl $199
8010736c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107371:	e9 9e f1 ff ff       	jmp    80106514 <alltraps>

80107376 <vector200>:
.globl vector200
vector200:
  pushl $0
80107376:	6a 00                	push   $0x0
  pushl $200
80107378:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010737d:	e9 92 f1 ff ff       	jmp    80106514 <alltraps>

80107382 <vector201>:
.globl vector201
vector201:
  pushl $0
80107382:	6a 00                	push   $0x0
  pushl $201
80107384:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107389:	e9 86 f1 ff ff       	jmp    80106514 <alltraps>

8010738e <vector202>:
.globl vector202
vector202:
  pushl $0
8010738e:	6a 00                	push   $0x0
  pushl $202
80107390:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107395:	e9 7a f1 ff ff       	jmp    80106514 <alltraps>

8010739a <vector203>:
.globl vector203
vector203:
  pushl $0
8010739a:	6a 00                	push   $0x0
  pushl $203
8010739c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801073a1:	e9 6e f1 ff ff       	jmp    80106514 <alltraps>

801073a6 <vector204>:
.globl vector204
vector204:
  pushl $0
801073a6:	6a 00                	push   $0x0
  pushl $204
801073a8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801073ad:	e9 62 f1 ff ff       	jmp    80106514 <alltraps>

801073b2 <vector205>:
.globl vector205
vector205:
  pushl $0
801073b2:	6a 00                	push   $0x0
  pushl $205
801073b4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801073b9:	e9 56 f1 ff ff       	jmp    80106514 <alltraps>

801073be <vector206>:
.globl vector206
vector206:
  pushl $0
801073be:	6a 00                	push   $0x0
  pushl $206
801073c0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801073c5:	e9 4a f1 ff ff       	jmp    80106514 <alltraps>

801073ca <vector207>:
.globl vector207
vector207:
  pushl $0
801073ca:	6a 00                	push   $0x0
  pushl $207
801073cc:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801073d1:	e9 3e f1 ff ff       	jmp    80106514 <alltraps>

801073d6 <vector208>:
.globl vector208
vector208:
  pushl $0
801073d6:	6a 00                	push   $0x0
  pushl $208
801073d8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801073dd:	e9 32 f1 ff ff       	jmp    80106514 <alltraps>

801073e2 <vector209>:
.globl vector209
vector209:
  pushl $0
801073e2:	6a 00                	push   $0x0
  pushl $209
801073e4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801073e9:	e9 26 f1 ff ff       	jmp    80106514 <alltraps>

801073ee <vector210>:
.globl vector210
vector210:
  pushl $0
801073ee:	6a 00                	push   $0x0
  pushl $210
801073f0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801073f5:	e9 1a f1 ff ff       	jmp    80106514 <alltraps>

801073fa <vector211>:
.globl vector211
vector211:
  pushl $0
801073fa:	6a 00                	push   $0x0
  pushl $211
801073fc:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107401:	e9 0e f1 ff ff       	jmp    80106514 <alltraps>

80107406 <vector212>:
.globl vector212
vector212:
  pushl $0
80107406:	6a 00                	push   $0x0
  pushl $212
80107408:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010740d:	e9 02 f1 ff ff       	jmp    80106514 <alltraps>

80107412 <vector213>:
.globl vector213
vector213:
  pushl $0
80107412:	6a 00                	push   $0x0
  pushl $213
80107414:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107419:	e9 f6 f0 ff ff       	jmp    80106514 <alltraps>

8010741e <vector214>:
.globl vector214
vector214:
  pushl $0
8010741e:	6a 00                	push   $0x0
  pushl $214
80107420:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107425:	e9 ea f0 ff ff       	jmp    80106514 <alltraps>

8010742a <vector215>:
.globl vector215
vector215:
  pushl $0
8010742a:	6a 00                	push   $0x0
  pushl $215
8010742c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107431:	e9 de f0 ff ff       	jmp    80106514 <alltraps>

80107436 <vector216>:
.globl vector216
vector216:
  pushl $0
80107436:	6a 00                	push   $0x0
  pushl $216
80107438:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010743d:	e9 d2 f0 ff ff       	jmp    80106514 <alltraps>

80107442 <vector217>:
.globl vector217
vector217:
  pushl $0
80107442:	6a 00                	push   $0x0
  pushl $217
80107444:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107449:	e9 c6 f0 ff ff       	jmp    80106514 <alltraps>

8010744e <vector218>:
.globl vector218
vector218:
  pushl $0
8010744e:	6a 00                	push   $0x0
  pushl $218
80107450:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107455:	e9 ba f0 ff ff       	jmp    80106514 <alltraps>

8010745a <vector219>:
.globl vector219
vector219:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $219
8010745c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107461:	e9 ae f0 ff ff       	jmp    80106514 <alltraps>

80107466 <vector220>:
.globl vector220
vector220:
  pushl $0
80107466:	6a 00                	push   $0x0
  pushl $220
80107468:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010746d:	e9 a2 f0 ff ff       	jmp    80106514 <alltraps>

80107472 <vector221>:
.globl vector221
vector221:
  pushl $0
80107472:	6a 00                	push   $0x0
  pushl $221
80107474:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107479:	e9 96 f0 ff ff       	jmp    80106514 <alltraps>

8010747e <vector222>:
.globl vector222
vector222:
  pushl $0
8010747e:	6a 00                	push   $0x0
  pushl $222
80107480:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107485:	e9 8a f0 ff ff       	jmp    80106514 <alltraps>

8010748a <vector223>:
.globl vector223
vector223:
  pushl $0
8010748a:	6a 00                	push   $0x0
  pushl $223
8010748c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107491:	e9 7e f0 ff ff       	jmp    80106514 <alltraps>

80107496 <vector224>:
.globl vector224
vector224:
  pushl $0
80107496:	6a 00                	push   $0x0
  pushl $224
80107498:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010749d:	e9 72 f0 ff ff       	jmp    80106514 <alltraps>

801074a2 <vector225>:
.globl vector225
vector225:
  pushl $0
801074a2:	6a 00                	push   $0x0
  pushl $225
801074a4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801074a9:	e9 66 f0 ff ff       	jmp    80106514 <alltraps>

801074ae <vector226>:
.globl vector226
vector226:
  pushl $0
801074ae:	6a 00                	push   $0x0
  pushl $226
801074b0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801074b5:	e9 5a f0 ff ff       	jmp    80106514 <alltraps>

801074ba <vector227>:
.globl vector227
vector227:
  pushl $0
801074ba:	6a 00                	push   $0x0
  pushl $227
801074bc:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801074c1:	e9 4e f0 ff ff       	jmp    80106514 <alltraps>

801074c6 <vector228>:
.globl vector228
vector228:
  pushl $0
801074c6:	6a 00                	push   $0x0
  pushl $228
801074c8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801074cd:	e9 42 f0 ff ff       	jmp    80106514 <alltraps>

801074d2 <vector229>:
.globl vector229
vector229:
  pushl $0
801074d2:	6a 00                	push   $0x0
  pushl $229
801074d4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801074d9:	e9 36 f0 ff ff       	jmp    80106514 <alltraps>

801074de <vector230>:
.globl vector230
vector230:
  pushl $0
801074de:	6a 00                	push   $0x0
  pushl $230
801074e0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801074e5:	e9 2a f0 ff ff       	jmp    80106514 <alltraps>

801074ea <vector231>:
.globl vector231
vector231:
  pushl $0
801074ea:	6a 00                	push   $0x0
  pushl $231
801074ec:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801074f1:	e9 1e f0 ff ff       	jmp    80106514 <alltraps>

801074f6 <vector232>:
.globl vector232
vector232:
  pushl $0
801074f6:	6a 00                	push   $0x0
  pushl $232
801074f8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801074fd:	e9 12 f0 ff ff       	jmp    80106514 <alltraps>

80107502 <vector233>:
.globl vector233
vector233:
  pushl $0
80107502:	6a 00                	push   $0x0
  pushl $233
80107504:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107509:	e9 06 f0 ff ff       	jmp    80106514 <alltraps>

8010750e <vector234>:
.globl vector234
vector234:
  pushl $0
8010750e:	6a 00                	push   $0x0
  pushl $234
80107510:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107515:	e9 fa ef ff ff       	jmp    80106514 <alltraps>

8010751a <vector235>:
.globl vector235
vector235:
  pushl $0
8010751a:	6a 00                	push   $0x0
  pushl $235
8010751c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107521:	e9 ee ef ff ff       	jmp    80106514 <alltraps>

80107526 <vector236>:
.globl vector236
vector236:
  pushl $0
80107526:	6a 00                	push   $0x0
  pushl $236
80107528:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010752d:	e9 e2 ef ff ff       	jmp    80106514 <alltraps>

80107532 <vector237>:
.globl vector237
vector237:
  pushl $0
80107532:	6a 00                	push   $0x0
  pushl $237
80107534:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107539:	e9 d6 ef ff ff       	jmp    80106514 <alltraps>

8010753e <vector238>:
.globl vector238
vector238:
  pushl $0
8010753e:	6a 00                	push   $0x0
  pushl $238
80107540:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107545:	e9 ca ef ff ff       	jmp    80106514 <alltraps>

8010754a <vector239>:
.globl vector239
vector239:
  pushl $0
8010754a:	6a 00                	push   $0x0
  pushl $239
8010754c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107551:	e9 be ef ff ff       	jmp    80106514 <alltraps>

80107556 <vector240>:
.globl vector240
vector240:
  pushl $0
80107556:	6a 00                	push   $0x0
  pushl $240
80107558:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010755d:	e9 b2 ef ff ff       	jmp    80106514 <alltraps>

80107562 <vector241>:
.globl vector241
vector241:
  pushl $0
80107562:	6a 00                	push   $0x0
  pushl $241
80107564:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107569:	e9 a6 ef ff ff       	jmp    80106514 <alltraps>

8010756e <vector242>:
.globl vector242
vector242:
  pushl $0
8010756e:	6a 00                	push   $0x0
  pushl $242
80107570:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107575:	e9 9a ef ff ff       	jmp    80106514 <alltraps>

8010757a <vector243>:
.globl vector243
vector243:
  pushl $0
8010757a:	6a 00                	push   $0x0
  pushl $243
8010757c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107581:	e9 8e ef ff ff       	jmp    80106514 <alltraps>

80107586 <vector244>:
.globl vector244
vector244:
  pushl $0
80107586:	6a 00                	push   $0x0
  pushl $244
80107588:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010758d:	e9 82 ef ff ff       	jmp    80106514 <alltraps>

80107592 <vector245>:
.globl vector245
vector245:
  pushl $0
80107592:	6a 00                	push   $0x0
  pushl $245
80107594:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107599:	e9 76 ef ff ff       	jmp    80106514 <alltraps>

8010759e <vector246>:
.globl vector246
vector246:
  pushl $0
8010759e:	6a 00                	push   $0x0
  pushl $246
801075a0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801075a5:	e9 6a ef ff ff       	jmp    80106514 <alltraps>

801075aa <vector247>:
.globl vector247
vector247:
  pushl $0
801075aa:	6a 00                	push   $0x0
  pushl $247
801075ac:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801075b1:	e9 5e ef ff ff       	jmp    80106514 <alltraps>

801075b6 <vector248>:
.globl vector248
vector248:
  pushl $0
801075b6:	6a 00                	push   $0x0
  pushl $248
801075b8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801075bd:	e9 52 ef ff ff       	jmp    80106514 <alltraps>

801075c2 <vector249>:
.globl vector249
vector249:
  pushl $0
801075c2:	6a 00                	push   $0x0
  pushl $249
801075c4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801075c9:	e9 46 ef ff ff       	jmp    80106514 <alltraps>

801075ce <vector250>:
.globl vector250
vector250:
  pushl $0
801075ce:	6a 00                	push   $0x0
  pushl $250
801075d0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801075d5:	e9 3a ef ff ff       	jmp    80106514 <alltraps>

801075da <vector251>:
.globl vector251
vector251:
  pushl $0
801075da:	6a 00                	push   $0x0
  pushl $251
801075dc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801075e1:	e9 2e ef ff ff       	jmp    80106514 <alltraps>

801075e6 <vector252>:
.globl vector252
vector252:
  pushl $0
801075e6:	6a 00                	push   $0x0
  pushl $252
801075e8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801075ed:	e9 22 ef ff ff       	jmp    80106514 <alltraps>

801075f2 <vector253>:
.globl vector253
vector253:
  pushl $0
801075f2:	6a 00                	push   $0x0
  pushl $253
801075f4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801075f9:	e9 16 ef ff ff       	jmp    80106514 <alltraps>

801075fe <vector254>:
.globl vector254
vector254:
  pushl $0
801075fe:	6a 00                	push   $0x0
  pushl $254
80107600:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107605:	e9 0a ef ff ff       	jmp    80106514 <alltraps>

8010760a <vector255>:
.globl vector255
vector255:
  pushl $0
8010760a:	6a 00                	push   $0x0
  pushl $255
8010760c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107611:	e9 fe ee ff ff       	jmp    80106514 <alltraps>
	...

80107618 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107618:	55                   	push   %ebp
80107619:	89 e5                	mov    %esp,%ebp
8010761b:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010761e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107621:	83 e8 01             	sub    $0x1,%eax
80107624:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107628:	8b 45 08             	mov    0x8(%ebp),%eax
8010762b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010762f:	8b 45 08             	mov    0x8(%ebp),%eax
80107632:	c1 e8 10             	shr    $0x10,%eax
80107635:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107639:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010763c:	0f 01 10             	lgdtl  (%eax)
}
8010763f:	c9                   	leave  
80107640:	c3                   	ret    

80107641 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107641:	55                   	push   %ebp
80107642:	89 e5                	mov    %esp,%ebp
80107644:	83 ec 04             	sub    $0x4,%esp
80107647:	8b 45 08             	mov    0x8(%ebp),%eax
8010764a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010764e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107652:	0f 00 d8             	ltr    %ax
}
80107655:	c9                   	leave  
80107656:	c3                   	ret    

80107657 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107657:	55                   	push   %ebp
80107658:	89 e5                	mov    %esp,%ebp
8010765a:	83 ec 04             	sub    $0x4,%esp
8010765d:	8b 45 08             	mov    0x8(%ebp),%eax
80107660:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107664:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107668:	8e e8                	mov    %eax,%gs
}
8010766a:	c9                   	leave  
8010766b:	c3                   	ret    

8010766c <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010766c:	55                   	push   %ebp
8010766d:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010766f:	8b 45 08             	mov    0x8(%ebp),%eax
80107672:	0f 22 d8             	mov    %eax,%cr3
}
80107675:	5d                   	pop    %ebp
80107676:	c3                   	ret    

80107677 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107677:	55                   	push   %ebp
80107678:	89 e5                	mov    %esp,%ebp
8010767a:	8b 45 08             	mov    0x8(%ebp),%eax
8010767d:	05 00 00 00 80       	add    $0x80000000,%eax
80107682:	5d                   	pop    %ebp
80107683:	c3                   	ret    

80107684 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107684:	55                   	push   %ebp
80107685:	89 e5                	mov    %esp,%ebp
80107687:	8b 45 08             	mov    0x8(%ebp),%eax
8010768a:	05 00 00 00 80       	add    $0x80000000,%eax
8010768f:	5d                   	pop    %ebp
80107690:	c3                   	ret    

80107691 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107691:	55                   	push   %ebp
80107692:	89 e5                	mov    %esp,%ebp
80107694:	53                   	push   %ebx
80107695:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107698:	e8 fc b7 ff ff       	call   80102e99 <cpunum>
8010769d:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801076a3:	05 60 23 11 80       	add    $0x80112360,%eax
801076a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801076ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ae:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801076b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b7:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801076bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c0:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801076c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c7:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801076cb:	83 e2 f0             	and    $0xfffffff0,%edx
801076ce:	83 ca 0a             	or     $0xa,%edx
801076d1:	88 50 7d             	mov    %dl,0x7d(%eax)
801076d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d7:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801076db:	83 ca 10             	or     $0x10,%edx
801076de:	88 50 7d             	mov    %dl,0x7d(%eax)
801076e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076e4:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801076e8:	83 e2 9f             	and    $0xffffff9f,%edx
801076eb:	88 50 7d             	mov    %dl,0x7d(%eax)
801076ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076f1:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801076f5:	83 ca 80             	or     $0xffffff80,%edx
801076f8:	88 50 7d             	mov    %dl,0x7d(%eax)
801076fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076fe:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107702:	83 ca 0f             	or     $0xf,%edx
80107705:	88 50 7e             	mov    %dl,0x7e(%eax)
80107708:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010770b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010770f:	83 e2 ef             	and    $0xffffffef,%edx
80107712:	88 50 7e             	mov    %dl,0x7e(%eax)
80107715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107718:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010771c:	83 e2 df             	and    $0xffffffdf,%edx
8010771f:	88 50 7e             	mov    %dl,0x7e(%eax)
80107722:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107725:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107729:	83 ca 40             	or     $0x40,%edx
8010772c:	88 50 7e             	mov    %dl,0x7e(%eax)
8010772f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107732:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107736:	83 ca 80             	or     $0xffffff80,%edx
80107739:	88 50 7e             	mov    %dl,0x7e(%eax)
8010773c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773f:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107743:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107746:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010774d:	ff ff 
8010774f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107752:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107759:	00 00 
8010775b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010775e:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107765:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107768:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010776f:	83 e2 f0             	and    $0xfffffff0,%edx
80107772:	83 ca 02             	or     $0x2,%edx
80107775:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010777b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777e:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107785:	83 ca 10             	or     $0x10,%edx
80107788:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010778e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107791:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107798:	83 e2 9f             	and    $0xffffff9f,%edx
8010779b:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801077a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a4:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801077ab:	83 ca 80             	or     $0xffffff80,%edx
801077ae:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801077b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b7:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801077be:	83 ca 0f             	or     $0xf,%edx
801077c1:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801077c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ca:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801077d1:	83 e2 ef             	and    $0xffffffef,%edx
801077d4:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801077da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077dd:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801077e4:	83 e2 df             	and    $0xffffffdf,%edx
801077e7:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801077ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f0:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801077f7:	83 ca 40             	or     $0x40,%edx
801077fa:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107800:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107803:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010780a:	83 ca 80             	or     $0xffffff80,%edx
8010780d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107813:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107816:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010781d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107820:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107827:	ff ff 
80107829:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010782c:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107833:	00 00 
80107835:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107838:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010783f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107842:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107849:	83 e2 f0             	and    $0xfffffff0,%edx
8010784c:	83 ca 0a             	or     $0xa,%edx
8010784f:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107855:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107858:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010785f:	83 ca 10             	or     $0x10,%edx
80107862:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107868:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107872:	83 ca 60             	or     $0x60,%edx
80107875:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010787b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787e:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107885:	83 ca 80             	or     $0xffffff80,%edx
80107888:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010788e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107891:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107898:	83 ca 0f             	or     $0xf,%edx
8010789b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801078a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a4:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801078ab:	83 e2 ef             	and    $0xffffffef,%edx
801078ae:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801078b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b7:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801078be:	83 e2 df             	and    $0xffffffdf,%edx
801078c1:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801078c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ca:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801078d1:	83 ca 40             	or     $0x40,%edx
801078d4:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801078da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078dd:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801078e4:	83 ca 80             	or     $0xffffff80,%edx
801078e7:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801078ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f0:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801078f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078fa:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107901:	ff ff 
80107903:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107906:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010790d:	00 00 
8010790f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107912:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107919:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010791c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107923:	83 e2 f0             	and    $0xfffffff0,%edx
80107926:	83 ca 02             	or     $0x2,%edx
80107929:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010792f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107932:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107939:	83 ca 10             	or     $0x10,%edx
8010793c:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107942:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107945:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010794c:	83 ca 60             	or     $0x60,%edx
8010794f:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107955:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107958:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010795f:	83 ca 80             	or     $0xffffff80,%edx
80107962:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796b:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107972:	83 ca 0f             	or     $0xf,%edx
80107975:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010797b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797e:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107985:	83 e2 ef             	and    $0xffffffef,%edx
80107988:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010798e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107991:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107998:	83 e2 df             	and    $0xffffffdf,%edx
8010799b:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801079a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a4:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801079ab:	83 ca 40             	or     $0x40,%edx
801079ae:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801079b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b7:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801079be:	83 ca 80             	or     $0xffffff80,%edx
801079c1:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801079c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ca:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801079d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d4:	05 b4 00 00 00       	add    $0xb4,%eax
801079d9:	89 c3                	mov    %eax,%ebx
801079db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079de:	05 b4 00 00 00       	add    $0xb4,%eax
801079e3:	c1 e8 10             	shr    $0x10,%eax
801079e6:	89 c1                	mov    %eax,%ecx
801079e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079eb:	05 b4 00 00 00       	add    $0xb4,%eax
801079f0:	c1 e8 18             	shr    $0x18,%eax
801079f3:	89 c2                	mov    %eax,%edx
801079f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f8:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801079ff:	00 00 
80107a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a04:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107a0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a0e:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a17:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107a1e:	83 e1 f0             	and    $0xfffffff0,%ecx
80107a21:	83 c9 02             	or     $0x2,%ecx
80107a24:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2d:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107a34:	83 c9 10             	or     $0x10,%ecx
80107a37:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a40:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107a47:	83 e1 9f             	and    $0xffffff9f,%ecx
80107a4a:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a53:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107a5a:	83 c9 80             	or     $0xffffff80,%ecx
80107a5d:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a66:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107a6d:	83 e1 f0             	and    $0xfffffff0,%ecx
80107a70:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a79:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107a80:	83 e1 ef             	and    $0xffffffef,%ecx
80107a83:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a8c:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107a93:	83 e1 df             	and    $0xffffffdf,%ecx
80107a96:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a9f:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107aa6:	83 c9 40             	or     $0x40,%ecx
80107aa9:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107aaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab2:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107ab9:	83 c9 80             	or     $0xffffff80,%ecx
80107abc:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ac5:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ace:	83 c0 70             	add    $0x70,%eax
80107ad1:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
80107ad8:	00 
80107ad9:	89 04 24             	mov    %eax,(%esp)
80107adc:	e8 37 fb ff ff       	call   80107618 <lgdt>
  loadgs(SEG_KCPU << 3);
80107ae1:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
80107ae8:	e8 6a fb ff ff       	call   80107657 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
80107aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af0:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107af6:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107afd:	00 00 00 00 
}
80107b01:	83 c4 24             	add    $0x24,%esp
80107b04:	5b                   	pop    %ebx
80107b05:	5d                   	pop    %ebp
80107b06:	c3                   	ret    

80107b07 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107b07:	55                   	push   %ebp
80107b08:	89 e5                	mov    %esp,%ebp
80107b0a:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b10:	c1 e8 16             	shr    $0x16,%eax
80107b13:	c1 e0 02             	shl    $0x2,%eax
80107b16:	03 45 08             	add    0x8(%ebp),%eax
80107b19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b1f:	8b 00                	mov    (%eax),%eax
80107b21:	83 e0 01             	and    $0x1,%eax
80107b24:	84 c0                	test   %al,%al
80107b26:	74 17                	je     80107b3f <walkpgdir+0x38>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107b28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b2b:	8b 00                	mov    (%eax),%eax
80107b2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b32:	89 04 24             	mov    %eax,(%esp)
80107b35:	e8 4a fb ff ff       	call   80107684 <p2v>
80107b3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107b3d:	eb 4b                	jmp    80107b8a <walkpgdir+0x83>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107b3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107b43:	74 0e                	je     80107b53 <walkpgdir+0x4c>
80107b45:	e8 c1 af ff ff       	call   80102b0b <kalloc>
80107b4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107b4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107b51:	75 07                	jne    80107b5a <walkpgdir+0x53>
      return 0;
80107b53:	b8 00 00 00 00       	mov    $0x0,%eax
80107b58:	eb 41                	jmp    80107b9b <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107b5a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107b61:	00 
80107b62:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107b69:	00 
80107b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6d:	89 04 24             	mov    %eax,(%esp)
80107b70:	e8 5d d4 ff ff       	call   80104fd2 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b78:	89 04 24             	mov    %eax,(%esp)
80107b7b:	e8 f7 fa ff ff       	call   80107677 <v2p>
80107b80:	89 c2                	mov    %eax,%edx
80107b82:	83 ca 07             	or     $0x7,%edx
80107b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b88:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b8d:	c1 e8 0c             	shr    $0xc,%eax
80107b90:	25 ff 03 00 00       	and    $0x3ff,%eax
80107b95:	c1 e0 02             	shl    $0x2,%eax
80107b98:	03 45 f4             	add    -0xc(%ebp),%eax
}
80107b9b:	c9                   	leave  
80107b9c:	c3                   	ret    

80107b9d <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107b9d:	55                   	push   %ebp
80107b9e:	89 e5                	mov    %esp,%ebp
80107ba0:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ba6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107bae:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bb1:	03 45 10             	add    0x10(%ebp),%eax
80107bb4:	83 e8 01             	sub    $0x1,%eax
80107bb7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107bbf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80107bc6:	00 
80107bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bca:	89 44 24 04          	mov    %eax,0x4(%esp)
80107bce:	8b 45 08             	mov    0x8(%ebp),%eax
80107bd1:	89 04 24             	mov    %eax,(%esp)
80107bd4:	e8 2e ff ff ff       	call   80107b07 <walkpgdir>
80107bd9:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107bdc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107be0:	75 07                	jne    80107be9 <mappages+0x4c>
      return -1;
80107be2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107be7:	eb 46                	jmp    80107c2f <mappages+0x92>
    if(*pte & PTE_P)
80107be9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107bec:	8b 00                	mov    (%eax),%eax
80107bee:	83 e0 01             	and    $0x1,%eax
80107bf1:	84 c0                	test   %al,%al
80107bf3:	74 0c                	je     80107c01 <mappages+0x64>
      panic("remap");
80107bf5:	c7 04 24 28 8a 10 80 	movl   $0x80108a28,(%esp)
80107bfc:	e8 3c 89 ff ff       	call   8010053d <panic>
    *pte = pa | perm | PTE_P;
80107c01:	8b 45 18             	mov    0x18(%ebp),%eax
80107c04:	0b 45 14             	or     0x14(%ebp),%eax
80107c07:	89 c2                	mov    %eax,%edx
80107c09:	83 ca 01             	or     $0x1,%edx
80107c0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c0f:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c14:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107c17:	74 10                	je     80107c29 <mappages+0x8c>
      break;
    a += PGSIZE;
80107c19:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107c20:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107c27:	eb 96                	jmp    80107bbf <mappages+0x22>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107c29:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107c2a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107c2f:	c9                   	leave  
80107c30:	c3                   	ret    

80107c31 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107c31:	55                   	push   %ebp
80107c32:	89 e5                	mov    %esp,%ebp
80107c34:	53                   	push   %ebx
80107c35:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107c38:	e8 ce ae ff ff       	call   80102b0b <kalloc>
80107c3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107c40:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107c44:	75 0a                	jne    80107c50 <setupkvm+0x1f>
    return 0;
80107c46:	b8 00 00 00 00       	mov    $0x0,%eax
80107c4b:	e9 98 00 00 00       	jmp    80107ce8 <setupkvm+0xb7>
  memset(pgdir, 0, PGSIZE);
80107c50:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107c57:	00 
80107c58:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107c5f:	00 
80107c60:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c63:	89 04 24             	mov    %eax,(%esp)
80107c66:	e8 67 d3 ff ff       	call   80104fd2 <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107c6b:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80107c72:	e8 0d fa ff ff       	call   80107684 <p2v>
80107c77:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107c7c:	76 0c                	jbe    80107c8a <setupkvm+0x59>
    panic("PHYSTOP too high");
80107c7e:	c7 04 24 2e 8a 10 80 	movl   $0x80108a2e,(%esp)
80107c85:	e8 b3 88 ff ff       	call   8010053d <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c8a:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107c91:	eb 49                	jmp    80107cdc <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
80107c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107c96:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107c99:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107c9c:	8b 50 04             	mov    0x4(%eax),%edx
80107c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca2:	8b 58 08             	mov    0x8(%eax),%ebx
80107ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ca8:	8b 40 04             	mov    0x4(%eax),%eax
80107cab:	29 c3                	sub    %eax,%ebx
80107cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cb0:	8b 00                	mov    (%eax),%eax
80107cb2:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80107cb6:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107cba:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107cbe:	89 44 24 04          	mov    %eax,0x4(%esp)
80107cc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cc5:	89 04 24             	mov    %eax,(%esp)
80107cc8:	e8 d0 fe ff ff       	call   80107b9d <mappages>
80107ccd:	85 c0                	test   %eax,%eax
80107ccf:	79 07                	jns    80107cd8 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107cd1:	b8 00 00 00 00       	mov    $0x0,%eax
80107cd6:	eb 10                	jmp    80107ce8 <setupkvm+0xb7>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107cd8:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107cdc:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107ce3:	72 ae                	jb     80107c93 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107ce5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107ce8:	83 c4 34             	add    $0x34,%esp
80107ceb:	5b                   	pop    %ebx
80107cec:	5d                   	pop    %ebp
80107ced:	c3                   	ret    

80107cee <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107cee:	55                   	push   %ebp
80107cef:	89 e5                	mov    %esp,%ebp
80107cf1:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107cf4:	e8 38 ff ff ff       	call   80107c31 <setupkvm>
80107cf9:	a3 38 56 11 80       	mov    %eax,0x80115638
  switchkvm();
80107cfe:	e8 02 00 00 00       	call   80107d05 <switchkvm>
}
80107d03:	c9                   	leave  
80107d04:	c3                   	ret    

80107d05 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107d05:	55                   	push   %ebp
80107d06:	89 e5                	mov    %esp,%ebp
80107d08:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107d0b:	a1 38 56 11 80       	mov    0x80115638,%eax
80107d10:	89 04 24             	mov    %eax,(%esp)
80107d13:	e8 5f f9 ff ff       	call   80107677 <v2p>
80107d18:	89 04 24             	mov    %eax,(%esp)
80107d1b:	e8 4c f9 ff ff       	call   8010766c <lcr3>
}
80107d20:	c9                   	leave  
80107d21:	c3                   	ret    

80107d22 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107d22:	55                   	push   %ebp
80107d23:	89 e5                	mov    %esp,%ebp
80107d25:	53                   	push   %ebx
80107d26:	83 ec 14             	sub    $0x14,%esp
  pushcli();
80107d29:	e8 9d d1 ff ff       	call   80104ecb <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107d2e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d34:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107d3b:	83 c2 08             	add    $0x8,%edx
80107d3e:	89 d3                	mov    %edx,%ebx
80107d40:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107d47:	83 c2 08             	add    $0x8,%edx
80107d4a:	c1 ea 10             	shr    $0x10,%edx
80107d4d:	89 d1                	mov    %edx,%ecx
80107d4f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107d56:	83 c2 08             	add    $0x8,%edx
80107d59:	c1 ea 18             	shr    $0x18,%edx
80107d5c:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107d63:	67 00 
80107d65:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80107d6c:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107d72:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107d79:	83 e1 f0             	and    $0xfffffff0,%ecx
80107d7c:	83 c9 09             	or     $0x9,%ecx
80107d7f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107d85:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107d8c:	83 c9 10             	or     $0x10,%ecx
80107d8f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107d95:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107d9c:	83 e1 9f             	and    $0xffffff9f,%ecx
80107d9f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107da5:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107dac:	83 c9 80             	or     $0xffffff80,%ecx
80107daf:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107db5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107dbc:	83 e1 f0             	and    $0xfffffff0,%ecx
80107dbf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107dc5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107dcc:	83 e1 ef             	and    $0xffffffef,%ecx
80107dcf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107dd5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107ddc:	83 e1 df             	and    $0xffffffdf,%ecx
80107ddf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107de5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107dec:	83 c9 40             	or     $0x40,%ecx
80107def:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107df5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107dfc:	83 e1 7f             	and    $0x7f,%ecx
80107dff:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107e05:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107e0b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e11:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107e18:	83 e2 ef             	and    $0xffffffef,%edx
80107e1b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107e21:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e27:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107e2d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e33:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107e3a:	8b 52 08             	mov    0x8(%edx),%edx
80107e3d:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107e43:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107e46:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
80107e4d:	e8 ef f7 ff ff       	call   80107641 <ltr>
  if(p->pgdir == 0)
80107e52:	8b 45 08             	mov    0x8(%ebp),%eax
80107e55:	8b 40 04             	mov    0x4(%eax),%eax
80107e58:	85 c0                	test   %eax,%eax
80107e5a:	75 0c                	jne    80107e68 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
80107e5c:	c7 04 24 3f 8a 10 80 	movl   $0x80108a3f,(%esp)
80107e63:	e8 d5 86 ff ff       	call   8010053d <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107e68:	8b 45 08             	mov    0x8(%ebp),%eax
80107e6b:	8b 40 04             	mov    0x4(%eax),%eax
80107e6e:	89 04 24             	mov    %eax,(%esp)
80107e71:	e8 01 f8 ff ff       	call   80107677 <v2p>
80107e76:	89 04 24             	mov    %eax,(%esp)
80107e79:	e8 ee f7 ff ff       	call   8010766c <lcr3>
  popcli();
80107e7e:	e8 90 d0 ff ff       	call   80104f13 <popcli>
}
80107e83:	83 c4 14             	add    $0x14,%esp
80107e86:	5b                   	pop    %ebx
80107e87:	5d                   	pop    %ebp
80107e88:	c3                   	ret    

80107e89 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107e89:	55                   	push   %ebp
80107e8a:	89 e5                	mov    %esp,%ebp
80107e8c:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107e8f:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107e96:	76 0c                	jbe    80107ea4 <inituvm+0x1b>
    panic("inituvm: more than a page");
80107e98:	c7 04 24 53 8a 10 80 	movl   $0x80108a53,(%esp)
80107e9f:	e8 99 86 ff ff       	call   8010053d <panic>
  mem = kalloc();
80107ea4:	e8 62 ac ff ff       	call   80102b0b <kalloc>
80107ea9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107eac:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107eb3:	00 
80107eb4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107ebb:	00 
80107ebc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ebf:	89 04 24             	mov    %eax,(%esp)
80107ec2:	e8 0b d1 ff ff       	call   80104fd2 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107ec7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eca:	89 04 24             	mov    %eax,(%esp)
80107ecd:	e8 a5 f7 ff ff       	call   80107677 <v2p>
80107ed2:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80107ed9:	00 
80107eda:	89 44 24 0c          	mov    %eax,0xc(%esp)
80107ede:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107ee5:	00 
80107ee6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107eed:	00 
80107eee:	8b 45 08             	mov    0x8(%ebp),%eax
80107ef1:	89 04 24             	mov    %eax,(%esp)
80107ef4:	e8 a4 fc ff ff       	call   80107b9d <mappages>
  memmove(mem, init, sz);
80107ef9:	8b 45 10             	mov    0x10(%ebp),%eax
80107efc:	89 44 24 08          	mov    %eax,0x8(%esp)
80107f00:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f03:	89 44 24 04          	mov    %eax,0x4(%esp)
80107f07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f0a:	89 04 24             	mov    %eax,(%esp)
80107f0d:	e8 93 d1 ff ff       	call   801050a5 <memmove>
}
80107f12:	c9                   	leave  
80107f13:	c3                   	ret    

80107f14 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107f14:	55                   	push   %ebp
80107f15:	89 e5                	mov    %esp,%ebp
80107f17:	53                   	push   %ebx
80107f18:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f1e:	25 ff 0f 00 00       	and    $0xfff,%eax
80107f23:	85 c0                	test   %eax,%eax
80107f25:	74 0c                	je     80107f33 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80107f27:	c7 04 24 70 8a 10 80 	movl   $0x80108a70,(%esp)
80107f2e:	e8 0a 86 ff ff       	call   8010053d <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107f33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107f3a:	e9 ad 00 00 00       	jmp    80107fec <loaduvm+0xd8>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107f3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f42:	8b 55 0c             	mov    0xc(%ebp),%edx
80107f45:	01 d0                	add    %edx,%eax
80107f47:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80107f4e:	00 
80107f4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80107f53:	8b 45 08             	mov    0x8(%ebp),%eax
80107f56:	89 04 24             	mov    %eax,(%esp)
80107f59:	e8 a9 fb ff ff       	call   80107b07 <walkpgdir>
80107f5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107f61:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107f65:	75 0c                	jne    80107f73 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80107f67:	c7 04 24 93 8a 10 80 	movl   $0x80108a93,(%esp)
80107f6e:	e8 ca 85 ff ff       	call   8010053d <panic>
    pa = PTE_ADDR(*pte);
80107f73:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107f76:	8b 00                	mov    (%eax),%eax
80107f78:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f7d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f83:	8b 55 18             	mov    0x18(%ebp),%edx
80107f86:	89 d1                	mov    %edx,%ecx
80107f88:	29 c1                	sub    %eax,%ecx
80107f8a:	89 c8                	mov    %ecx,%eax
80107f8c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107f91:	77 11                	ja     80107fa4 <loaduvm+0x90>
      n = sz - i;
80107f93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f96:	8b 55 18             	mov    0x18(%ebp),%edx
80107f99:	89 d1                	mov    %edx,%ecx
80107f9b:	29 c1                	sub    %eax,%ecx
80107f9d:	89 c8                	mov    %ecx,%eax
80107f9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107fa2:	eb 07                	jmp    80107fab <loaduvm+0x97>
    else
      n = PGSIZE;
80107fa4:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107fab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fae:	8b 55 14             	mov    0x14(%ebp),%edx
80107fb1:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107fb4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107fb7:	89 04 24             	mov    %eax,(%esp)
80107fba:	e8 c5 f6 ff ff       	call   80107684 <p2v>
80107fbf:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107fc2:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107fc6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107fca:	89 44 24 04          	mov    %eax,0x4(%esp)
80107fce:	8b 45 10             	mov    0x10(%ebp),%eax
80107fd1:	89 04 24             	mov    %eax,(%esp)
80107fd4:	e8 91 9d ff ff       	call   80101d6a <readi>
80107fd9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107fdc:	74 07                	je     80107fe5 <loaduvm+0xd1>
      return -1;
80107fde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107fe3:	eb 18                	jmp    80107ffd <loaduvm+0xe9>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107fe5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107fec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fef:	3b 45 18             	cmp    0x18(%ebp),%eax
80107ff2:	0f 82 47 ff ff ff    	jb     80107f3f <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107ff8:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107ffd:	83 c4 24             	add    $0x24,%esp
80108000:	5b                   	pop    %ebx
80108001:	5d                   	pop    %ebp
80108002:	c3                   	ret    

80108003 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108003:	55                   	push   %ebp
80108004:	89 e5                	mov    %esp,%ebp
80108006:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108009:	8b 45 10             	mov    0x10(%ebp),%eax
8010800c:	85 c0                	test   %eax,%eax
8010800e:	79 0a                	jns    8010801a <allocuvm+0x17>
    return 0;
80108010:	b8 00 00 00 00       	mov    $0x0,%eax
80108015:	e9 c1 00 00 00       	jmp    801080db <allocuvm+0xd8>
  if(newsz < oldsz)
8010801a:	8b 45 10             	mov    0x10(%ebp),%eax
8010801d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108020:	73 08                	jae    8010802a <allocuvm+0x27>
    return oldsz;
80108022:	8b 45 0c             	mov    0xc(%ebp),%eax
80108025:	e9 b1 00 00 00       	jmp    801080db <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
8010802a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010802d:	05 ff 0f 00 00       	add    $0xfff,%eax
80108032:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108037:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010803a:	e9 8d 00 00 00       	jmp    801080cc <allocuvm+0xc9>
    mem = kalloc();
8010803f:	e8 c7 aa ff ff       	call   80102b0b <kalloc>
80108044:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108047:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010804b:	75 2c                	jne    80108079 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
8010804d:	c7 04 24 b1 8a 10 80 	movl   $0x80108ab1,(%esp)
80108054:	e8 48 83 ff ff       	call   801003a1 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80108059:	8b 45 0c             	mov    0xc(%ebp),%eax
8010805c:	89 44 24 08          	mov    %eax,0x8(%esp)
80108060:	8b 45 10             	mov    0x10(%ebp),%eax
80108063:	89 44 24 04          	mov    %eax,0x4(%esp)
80108067:	8b 45 08             	mov    0x8(%ebp),%eax
8010806a:	89 04 24             	mov    %eax,(%esp)
8010806d:	e8 6b 00 00 00       	call   801080dd <deallocuvm>
      return 0;
80108072:	b8 00 00 00 00       	mov    $0x0,%eax
80108077:	eb 62                	jmp    801080db <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
80108079:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108080:	00 
80108081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108088:	00 
80108089:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010808c:	89 04 24             	mov    %eax,(%esp)
8010808f:	e8 3e cf ff ff       	call   80104fd2 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108094:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108097:	89 04 24             	mov    %eax,(%esp)
8010809a:	e8 d8 f5 ff ff       	call   80107677 <v2p>
8010809f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801080a2:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
801080a9:	00 
801080aa:	89 44 24 0c          	mov    %eax,0xc(%esp)
801080ae:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801080b5:	00 
801080b6:	89 54 24 04          	mov    %edx,0x4(%esp)
801080ba:	8b 45 08             	mov    0x8(%ebp),%eax
801080bd:	89 04 24             	mov    %eax,(%esp)
801080c0:	e8 d8 fa ff ff       	call   80107b9d <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801080c5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801080cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080cf:	3b 45 10             	cmp    0x10(%ebp),%eax
801080d2:	0f 82 67 ff ff ff    	jb     8010803f <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
801080d8:	8b 45 10             	mov    0x10(%ebp),%eax
}
801080db:	c9                   	leave  
801080dc:	c3                   	ret    

801080dd <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801080dd:	55                   	push   %ebp
801080de:	89 e5                	mov    %esp,%ebp
801080e0:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801080e3:	8b 45 10             	mov    0x10(%ebp),%eax
801080e6:	3b 45 0c             	cmp    0xc(%ebp),%eax
801080e9:	72 08                	jb     801080f3 <deallocuvm+0x16>
    return oldsz;
801080eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801080ee:	e9 a4 00 00 00       	jmp    80108197 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
801080f3:	8b 45 10             	mov    0x10(%ebp),%eax
801080f6:	05 ff 0f 00 00       	add    $0xfff,%eax
801080fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108100:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108103:	e9 80 00 00 00       	jmp    80108188 <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108108:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010810b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108112:	00 
80108113:	89 44 24 04          	mov    %eax,0x4(%esp)
80108117:	8b 45 08             	mov    0x8(%ebp),%eax
8010811a:	89 04 24             	mov    %eax,(%esp)
8010811d:	e8 e5 f9 ff ff       	call   80107b07 <walkpgdir>
80108122:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108125:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108129:	75 09                	jne    80108134 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
8010812b:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108132:	eb 4d                	jmp    80108181 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80108134:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108137:	8b 00                	mov    (%eax),%eax
80108139:	83 e0 01             	and    $0x1,%eax
8010813c:	84 c0                	test   %al,%al
8010813e:	74 41                	je     80108181 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
80108140:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108143:	8b 00                	mov    (%eax),%eax
80108145:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010814a:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010814d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108151:	75 0c                	jne    8010815f <deallocuvm+0x82>
        panic("kfree");
80108153:	c7 04 24 c9 8a 10 80 	movl   $0x80108ac9,(%esp)
8010815a:	e8 de 83 ff ff       	call   8010053d <panic>
      char *v = p2v(pa);
8010815f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108162:	89 04 24             	mov    %eax,(%esp)
80108165:	e8 1a f5 ff ff       	call   80107684 <p2v>
8010816a:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010816d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108170:	89 04 24             	mov    %eax,(%esp)
80108173:	e8 fa a8 ff ff       	call   80102a72 <kfree>
      *pte = 0;
80108178:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010817b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108181:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108188:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010818b:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010818e:	0f 82 74 ff ff ff    	jb     80108108 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80108194:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108197:	c9                   	leave  
80108198:	c3                   	ret    

80108199 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108199:	55                   	push   %ebp
8010819a:	89 e5                	mov    %esp,%ebp
8010819c:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
8010819f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801081a3:	75 0c                	jne    801081b1 <freevm+0x18>
    panic("freevm: no pgdir");
801081a5:	c7 04 24 cf 8a 10 80 	movl   $0x80108acf,(%esp)
801081ac:	e8 8c 83 ff ff       	call   8010053d <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801081b1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801081b8:	00 
801081b9:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
801081c0:	80 
801081c1:	8b 45 08             	mov    0x8(%ebp),%eax
801081c4:	89 04 24             	mov    %eax,(%esp)
801081c7:	e8 11 ff ff ff       	call   801080dd <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
801081cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801081d3:	eb 3c                	jmp    80108211 <freevm+0x78>
    if(pgdir[i] & PTE_P){
801081d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081d8:	c1 e0 02             	shl    $0x2,%eax
801081db:	03 45 08             	add    0x8(%ebp),%eax
801081de:	8b 00                	mov    (%eax),%eax
801081e0:	83 e0 01             	and    $0x1,%eax
801081e3:	84 c0                	test   %al,%al
801081e5:	74 26                	je     8010820d <freevm+0x74>
      char * v = p2v(PTE_ADDR(pgdir[i]));
801081e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081ea:	c1 e0 02             	shl    $0x2,%eax
801081ed:	03 45 08             	add    0x8(%ebp),%eax
801081f0:	8b 00                	mov    (%eax),%eax
801081f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081f7:	89 04 24             	mov    %eax,(%esp)
801081fa:	e8 85 f4 ff ff       	call   80107684 <p2v>
801081ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108202:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108205:	89 04 24             	mov    %eax,(%esp)
80108208:	e8 65 a8 ff ff       	call   80102a72 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010820d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108211:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108218:	76 bb                	jbe    801081d5 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010821a:	8b 45 08             	mov    0x8(%ebp),%eax
8010821d:	89 04 24             	mov    %eax,(%esp)
80108220:	e8 4d a8 ff ff       	call   80102a72 <kfree>
}
80108225:	c9                   	leave  
80108226:	c3                   	ret    

80108227 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108227:	55                   	push   %ebp
80108228:	89 e5                	mov    %esp,%ebp
8010822a:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010822d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108234:	00 
80108235:	8b 45 0c             	mov    0xc(%ebp),%eax
80108238:	89 44 24 04          	mov    %eax,0x4(%esp)
8010823c:	8b 45 08             	mov    0x8(%ebp),%eax
8010823f:	89 04 24             	mov    %eax,(%esp)
80108242:	e8 c0 f8 ff ff       	call   80107b07 <walkpgdir>
80108247:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010824a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010824e:	75 0c                	jne    8010825c <clearpteu+0x35>
    panic("clearpteu");
80108250:	c7 04 24 e0 8a 10 80 	movl   $0x80108ae0,(%esp)
80108257:	e8 e1 82 ff ff       	call   8010053d <panic>
  *pte &= ~PTE_U;
8010825c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010825f:	8b 00                	mov    (%eax),%eax
80108261:	89 c2                	mov    %eax,%edx
80108263:	83 e2 fb             	and    $0xfffffffb,%edx
80108266:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108269:	89 10                	mov    %edx,(%eax)
}
8010826b:	c9                   	leave  
8010826c:	c3                   	ret    

8010826d <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010826d:	55                   	push   %ebp
8010826e:	89 e5                	mov    %esp,%ebp
80108270:	53                   	push   %ebx
80108271:	83 ec 44             	sub    $0x44,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108274:	e8 b8 f9 ff ff       	call   80107c31 <setupkvm>
80108279:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010827c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108280:	75 0a                	jne    8010828c <copyuvm+0x1f>
    return 0;
80108282:	b8 00 00 00 00       	mov    $0x0,%eax
80108287:	e9 fd 00 00 00       	jmp    80108389 <copyuvm+0x11c>
  for(i = 0; i < sz; i += PGSIZE){
8010828c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108293:	e9 cc 00 00 00       	jmp    80108364 <copyuvm+0xf7>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108298:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010829b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801082a2:	00 
801082a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801082a7:	8b 45 08             	mov    0x8(%ebp),%eax
801082aa:	89 04 24             	mov    %eax,(%esp)
801082ad:	e8 55 f8 ff ff       	call   80107b07 <walkpgdir>
801082b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
801082b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801082b9:	75 0c                	jne    801082c7 <copyuvm+0x5a>
      panic("copyuvm: pte should exist");
801082bb:	c7 04 24 ea 8a 10 80 	movl   $0x80108aea,(%esp)
801082c2:	e8 76 82 ff ff       	call   8010053d <panic>
    if(!(*pte & PTE_P))
801082c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082ca:	8b 00                	mov    (%eax),%eax
801082cc:	83 e0 01             	and    $0x1,%eax
801082cf:	85 c0                	test   %eax,%eax
801082d1:	75 0c                	jne    801082df <copyuvm+0x72>
      panic("copyuvm: page not present");
801082d3:	c7 04 24 04 8b 10 80 	movl   $0x80108b04,(%esp)
801082da:	e8 5e 82 ff ff       	call   8010053d <panic>
    pa = PTE_ADDR(*pte);
801082df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082e2:	8b 00                	mov    (%eax),%eax
801082e4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
801082ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082ef:	8b 00                	mov    (%eax),%eax
801082f1:	25 ff 0f 00 00       	and    $0xfff,%eax
801082f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801082f9:	e8 0d a8 ff ff       	call   80102b0b <kalloc>
801082fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108301:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108305:	74 6e                	je     80108375 <copyuvm+0x108>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108307:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010830a:	89 04 24             	mov    %eax,(%esp)
8010830d:	e8 72 f3 ff ff       	call   80107684 <p2v>
80108312:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108319:	00 
8010831a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010831e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108321:	89 04 24             	mov    %eax,(%esp)
80108324:	e8 7c cd ff ff       	call   801050a5 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
80108329:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010832c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010832f:	89 04 24             	mov    %eax,(%esp)
80108332:	e8 40 f3 ff ff       	call   80107677 <v2p>
80108337:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010833a:	89 5c 24 10          	mov    %ebx,0x10(%esp)
8010833e:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108342:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108349:	00 
8010834a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010834e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108351:	89 04 24             	mov    %eax,(%esp)
80108354:	e8 44 f8 ff ff       	call   80107b9d <mappages>
80108359:	85 c0                	test   %eax,%eax
8010835b:	78 1b                	js     80108378 <copyuvm+0x10b>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010835d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108364:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108367:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010836a:	0f 82 28 ff ff ff    	jb     80108298 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
80108370:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108373:	eb 14                	jmp    80108389 <copyuvm+0x11c>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108375:	90                   	nop
80108376:	eb 01                	jmp    80108379 <copyuvm+0x10c>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
80108378:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108379:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010837c:	89 04 24             	mov    %eax,(%esp)
8010837f:	e8 15 fe ff ff       	call   80108199 <freevm>
  return 0;
80108384:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108389:	83 c4 44             	add    $0x44,%esp
8010838c:	5b                   	pop    %ebx
8010838d:	5d                   	pop    %ebp
8010838e:	c3                   	ret    

8010838f <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010838f:	55                   	push   %ebp
80108390:	89 e5                	mov    %esp,%ebp
80108392:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108395:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010839c:	00 
8010839d:	8b 45 0c             	mov    0xc(%ebp),%eax
801083a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801083a4:	8b 45 08             	mov    0x8(%ebp),%eax
801083a7:	89 04 24             	mov    %eax,(%esp)
801083aa:	e8 58 f7 ff ff       	call   80107b07 <walkpgdir>
801083af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801083b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083b5:	8b 00                	mov    (%eax),%eax
801083b7:	83 e0 01             	and    $0x1,%eax
801083ba:	85 c0                	test   %eax,%eax
801083bc:	75 07                	jne    801083c5 <uva2ka+0x36>
    return 0;
801083be:	b8 00 00 00 00       	mov    $0x0,%eax
801083c3:	eb 25                	jmp    801083ea <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
801083c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083c8:	8b 00                	mov    (%eax),%eax
801083ca:	83 e0 04             	and    $0x4,%eax
801083cd:	85 c0                	test   %eax,%eax
801083cf:	75 07                	jne    801083d8 <uva2ka+0x49>
    return 0;
801083d1:	b8 00 00 00 00       	mov    $0x0,%eax
801083d6:	eb 12                	jmp    801083ea <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
801083d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083db:	8b 00                	mov    (%eax),%eax
801083dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083e2:	89 04 24             	mov    %eax,(%esp)
801083e5:	e8 9a f2 ff ff       	call   80107684 <p2v>
}
801083ea:	c9                   	leave  
801083eb:	c3                   	ret    

801083ec <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801083ec:	55                   	push   %ebp
801083ed:	89 e5                	mov    %esp,%ebp
801083ef:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801083f2:	8b 45 10             	mov    0x10(%ebp),%eax
801083f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801083f8:	e9 8b 00 00 00       	jmp    80108488 <copyout+0x9c>
    va0 = (uint)PGROUNDDOWN(va);
801083fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80108400:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108405:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108408:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010840b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010840f:	8b 45 08             	mov    0x8(%ebp),%eax
80108412:	89 04 24             	mov    %eax,(%esp)
80108415:	e8 75 ff ff ff       	call   8010838f <uva2ka>
8010841a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010841d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108421:	75 07                	jne    8010842a <copyout+0x3e>
      return -1;
80108423:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108428:	eb 6d                	jmp    80108497 <copyout+0xab>
    n = PGSIZE - (va - va0);
8010842a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010842d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80108430:	89 d1                	mov    %edx,%ecx
80108432:	29 c1                	sub    %eax,%ecx
80108434:	89 c8                	mov    %ecx,%eax
80108436:	05 00 10 00 00       	add    $0x1000,%eax
8010843b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010843e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108441:	3b 45 14             	cmp    0x14(%ebp),%eax
80108444:	76 06                	jbe    8010844c <copyout+0x60>
      n = len;
80108446:	8b 45 14             	mov    0x14(%ebp),%eax
80108449:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010844c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010844f:	8b 55 0c             	mov    0xc(%ebp),%edx
80108452:	89 d1                	mov    %edx,%ecx
80108454:	29 c1                	sub    %eax,%ecx
80108456:	89 c8                	mov    %ecx,%eax
80108458:	03 45 e8             	add    -0x18(%ebp),%eax
8010845b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010845e:	89 54 24 08          	mov    %edx,0x8(%esp)
80108462:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108465:	89 54 24 04          	mov    %edx,0x4(%esp)
80108469:	89 04 24             	mov    %eax,(%esp)
8010846c:	e8 34 cc ff ff       	call   801050a5 <memmove>
    len -= n;
80108471:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108474:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108477:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010847a:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
8010847d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108480:	05 00 10 00 00       	add    $0x1000,%eax
80108485:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108488:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010848c:	0f 85 6b ff ff ff    	jne    801083fd <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108492:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108497:	c9                   	leave  
80108498:	c3                   	ret    
