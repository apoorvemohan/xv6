
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   9:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
   d:	74 19                	je     28 <main+0x28>
    printf(2, "Usage: ln old new\n");
   f:	c7 44 24 04 ed 09 00 	movl   $0x9ed,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 94 04 00 00       	call   4b7 <printf>
    exit();
  23:	e8 b8 02 00 00       	call   2e0 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  28:	8b 45 0c             	mov    0xc(%ebp),%eax
  2b:	83 c0 08             	add    $0x8,%eax
  2e:	8b 10                	mov    (%eax),%edx
  30:	8b 45 0c             	mov    0xc(%ebp),%eax
  33:	83 c0 04             	add    $0x4,%eax
  36:	8b 00                	mov    (%eax),%eax
  38:	89 54 24 04          	mov    %edx,0x4(%esp)
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 fc 02 00 00       	call   340 <link>
  44:	85 c0                	test   %eax,%eax
  46:	79 2c                	jns    74 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	8b 45 0c             	mov    0xc(%ebp),%eax
  4b:	83 c0 08             	add    $0x8,%eax
  4e:	8b 10                	mov    (%eax),%edx
  50:	8b 45 0c             	mov    0xc(%ebp),%eax
  53:	83 c0 04             	add    $0x4,%eax
  56:	8b 00                	mov    (%eax),%eax
  58:	89 54 24 0c          	mov    %edx,0xc(%esp)
  5c:	89 44 24 08          	mov    %eax,0x8(%esp)
  60:	c7 44 24 04 00 0a 00 	movl   $0xa00,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	e8 43 04 00 00       	call   4b7 <printf>
  exit();
  74:	e8 67 02 00 00       	call   2e0 <exit>
  79:	90                   	nop
  7a:	90                   	nop
  7b:	90                   	nop

0000007c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	57                   	push   %edi
  80:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  81:	8b 4d 08             	mov    0x8(%ebp),%ecx
  84:	8b 55 10             	mov    0x10(%ebp),%edx
  87:	8b 45 0c             	mov    0xc(%ebp),%eax
  8a:	89 cb                	mov    %ecx,%ebx
  8c:	89 df                	mov    %ebx,%edi
  8e:	89 d1                	mov    %edx,%ecx
  90:	fc                   	cld    
  91:	f3 aa                	rep stos %al,%es:(%edi)
  93:	89 ca                	mov    %ecx,%edx
  95:	89 fb                	mov    %edi,%ebx
  97:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9d:	5b                   	pop    %ebx
  9e:	5f                   	pop    %edi
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    

000000a1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a1:	55                   	push   %ebp
  a2:	89 e5                	mov    %esp,%ebp
  a4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a7:	8b 45 08             	mov    0x8(%ebp),%eax
  aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ad:	90                   	nop
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	0f b6 10             	movzbl (%eax),%edx
  b4:	8b 45 08             	mov    0x8(%ebp),%eax
  b7:	88 10                	mov    %dl,(%eax)
  b9:	8b 45 08             	mov    0x8(%ebp),%eax
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	0f 95 c0             	setne  %al
  c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  cc:	84 c0                	test   %al,%al
  ce:	75 de                	jne    ae <strcpy+0xd>
    ;
  return os;
  d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d3:	c9                   	leave  
  d4:	c3                   	ret    

000000d5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d5:	55                   	push   %ebp
  d6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d8:	eb 08                	jmp    e2 <strcmp+0xd>
    p++, q++;
  da:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  de:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 00             	movzbl (%eax),%eax
  e8:	84 c0                	test   %al,%al
  ea:	74 10                	je     fc <strcmp+0x27>
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	0f b6 10             	movzbl (%eax),%edx
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	38 c2                	cmp    %al,%dl
  fa:	74 de                	je     da <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 00             	movzbl (%eax),%eax
 102:	0f b6 d0             	movzbl %al,%edx
 105:	8b 45 0c             	mov    0xc(%ebp),%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	0f b6 c0             	movzbl %al,%eax
 10e:	89 d1                	mov    %edx,%ecx
 110:	29 c1                	sub    %eax,%ecx
 112:	89 c8                	mov    %ecx,%eax
}
 114:	5d                   	pop    %ebp
 115:	c3                   	ret    

00000116 <strlen>:

uint
strlen(char *s)
{
 116:	55                   	push   %ebp
 117:	89 e5                	mov    %esp,%ebp
 119:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 11c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 123:	eb 04                	jmp    129 <strlen+0x13>
 125:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 129:	8b 45 fc             	mov    -0x4(%ebp),%eax
 12c:	03 45 08             	add    0x8(%ebp),%eax
 12f:	0f b6 00             	movzbl (%eax),%eax
 132:	84 c0                	test   %al,%al
 134:	75 ef                	jne    125 <strlen+0xf>
    ;
  return n;
 136:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 139:	c9                   	leave  
 13a:	c3                   	ret    

0000013b <memset>:

void*
memset(void *dst, int c, uint n)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 141:	8b 45 10             	mov    0x10(%ebp),%eax
 144:	89 44 24 08          	mov    %eax,0x8(%esp)
 148:	8b 45 0c             	mov    0xc(%ebp),%eax
 14b:	89 44 24 04          	mov    %eax,0x4(%esp)
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 22 ff ff ff       	call   7c <stosb>
  return dst;
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <strchr>:

char*
strchr(const char *s, char c)
{
 15f:	55                   	push   %ebp
 160:	89 e5                	mov    %esp,%ebp
 162:	83 ec 04             	sub    $0x4,%esp
 165:	8b 45 0c             	mov    0xc(%ebp),%eax
 168:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16b:	eb 14                	jmp    181 <strchr+0x22>
    if(*s == c)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	3a 45 fc             	cmp    -0x4(%ebp),%al
 176:	75 05                	jne    17d <strchr+0x1e>
      return (char*)s;
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	eb 13                	jmp    190 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 17d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 181:	8b 45 08             	mov    0x8(%ebp),%eax
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	84 c0                	test   %al,%al
 189:	75 e2                	jne    16d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 18b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 190:	c9                   	leave  
 191:	c3                   	ret    

00000192 <gets>:

char*
gets(char *buf, int max)
{
 192:	55                   	push   %ebp
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 198:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 19f:	eb 44                	jmp    1e5 <gets+0x53>
    cc = read(0, &c, 1);
 1a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a8:	00 
 1a9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b7:	e8 3c 01 00 00       	call   2f8 <read>
 1bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c3:	7e 2d                	jle    1f2 <gets+0x60>
      break;
    buf[i++] = c;
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	03 45 08             	add    0x8(%ebp),%eax
 1cb:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1cf:	88 10                	mov    %dl,(%eax)
 1d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d9:	3c 0a                	cmp    $0xa,%al
 1db:	74 16                	je     1f3 <gets+0x61>
 1dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e1:	3c 0d                	cmp    $0xd,%al
 1e3:	74 0e                	je     1f3 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e8:	83 c0 01             	add    $0x1,%eax
 1eb:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1ee:	7c b1                	jl     1a1 <gets+0xf>
 1f0:	eb 01                	jmp    1f3 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1f2:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f6:	03 45 08             	add    0x8(%ebp),%eax
 1f9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <stat>:

int
stat(char *n, struct stat *st)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 207:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 20e:	00 
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	89 04 24             	mov    %eax,(%esp)
 215:	e8 06 01 00 00       	call   320 <open>
 21a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 21d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 221:	79 07                	jns    22a <stat+0x29>
    return -1;
 223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 228:	eb 23                	jmp    24d <stat+0x4c>
  r = fstat(fd, st);
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 44 24 04          	mov    %eax,0x4(%esp)
 231:	8b 45 f4             	mov    -0xc(%ebp),%eax
 234:	89 04 24             	mov    %eax,(%esp)
 237:	e8 fc 00 00 00       	call   338 <fstat>
 23c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 242:	89 04 24             	mov    %eax,(%esp)
 245:	e8 be 00 00 00       	call   308 <close>
  return r;
 24a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 24d:	c9                   	leave  
 24e:	c3                   	ret    

0000024f <atoi>:

int
atoi(const char *s)
{
 24f:	55                   	push   %ebp
 250:	89 e5                	mov    %esp,%ebp
 252:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 255:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25c:	eb 23                	jmp    281 <atoi+0x32>
    n = n*10 + *s++ - '0';
 25e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 261:	89 d0                	mov    %edx,%eax
 263:	c1 e0 02             	shl    $0x2,%eax
 266:	01 d0                	add    %edx,%eax
 268:	01 c0                	add    %eax,%eax
 26a:	89 c2                	mov    %eax,%edx
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	0f b6 00             	movzbl (%eax),%eax
 272:	0f be c0             	movsbl %al,%eax
 275:	01 d0                	add    %edx,%eax
 277:	83 e8 30             	sub    $0x30,%eax
 27a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 27d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 281:	8b 45 08             	mov    0x8(%ebp),%eax
 284:	0f b6 00             	movzbl (%eax),%eax
 287:	3c 2f                	cmp    $0x2f,%al
 289:	7e 0a                	jle    295 <atoi+0x46>
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	0f b6 00             	movzbl (%eax),%eax
 291:	3c 39                	cmp    $0x39,%al
 293:	7e c9                	jle    25e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 295:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 298:	c9                   	leave  
 299:	c3                   	ret    

0000029a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 29a:	55                   	push   %ebp
 29b:	89 e5                	mov    %esp,%ebp
 29d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2ac:	eb 13                	jmp    2c1 <memmove+0x27>
    *dst++ = *src++;
 2ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2b1:	0f b6 10             	movzbl (%eax),%edx
 2b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b7:	88 10                	mov    %dl,(%eax)
 2b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2bd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2c5:	0f 9f c0             	setg   %al
 2c8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2cc:	84 c0                	test   %al,%al
 2ce:	75 de                	jne    2ae <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d3:	c9                   	leave  
 2d4:	c3                   	ret    
 2d5:	90                   	nop
 2d6:	90                   	nop
 2d7:	90                   	nop

000002d8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d8:	b8 01 00 00 00       	mov    $0x1,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exit>:
SYSCALL(exit)
 2e0:	b8 02 00 00 00       	mov    $0x2,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <wait>:
SYSCALL(wait)
 2e8:	b8 03 00 00 00       	mov    $0x3,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <pipe>:
SYSCALL(pipe)
 2f0:	b8 04 00 00 00       	mov    $0x4,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <read>:
SYSCALL(read)
 2f8:	b8 05 00 00 00       	mov    $0x5,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <write>:
SYSCALL(write)
 300:	b8 10 00 00 00       	mov    $0x10,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <close>:
SYSCALL(close)
 308:	b8 15 00 00 00       	mov    $0x15,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <kill>:
SYSCALL(kill)
 310:	b8 06 00 00 00       	mov    $0x6,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <exec>:
SYSCALL(exec)
 318:	b8 07 00 00 00       	mov    $0x7,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <open>:
SYSCALL(open)
 320:	b8 0f 00 00 00       	mov    $0xf,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <mknod>:
SYSCALL(mknod)
 328:	b8 11 00 00 00       	mov    $0x11,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <unlink>:
SYSCALL(unlink)
 330:	b8 12 00 00 00       	mov    $0x12,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <fstat>:
SYSCALL(fstat)
 338:	b8 08 00 00 00       	mov    $0x8,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <link>:
SYSCALL(link)
 340:	b8 13 00 00 00       	mov    $0x13,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <mkdir>:
SYSCALL(mkdir)
 348:	b8 14 00 00 00       	mov    $0x14,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <chdir>:
SYSCALL(chdir)
 350:	b8 09 00 00 00       	mov    $0x9,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <dup>:
SYSCALL(dup)
 358:	b8 0a 00 00 00       	mov    $0xa,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <getpid>:
SYSCALL(getpid)
 360:	b8 0b 00 00 00       	mov    $0xb,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <sbrk>:
SYSCALL(sbrk)
 368:	b8 0c 00 00 00       	mov    $0xc,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <sleep>:
SYSCALL(sleep)
 370:	b8 0d 00 00 00       	mov    $0xd,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <uptime>:
SYSCALL(uptime)
 378:	b8 0e 00 00 00       	mov    $0xe,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <kthread_create>:
SYSCALL(kthread_create)
 380:	b8 17 00 00 00       	mov    $0x17,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <kthread_join>:
SYSCALL(kthread_join)
 388:	b8 16 00 00 00       	mov    $0x16,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 390:	b8 18 00 00 00       	mov    $0x18,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 398:	b8 19 00 00 00       	mov    $0x19,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 3a0:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 3a8:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 3b0:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3b8:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3c0:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3c8:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 3d0:	b8 20 00 00 00       	mov    $0x20,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <kthread_exit>:
 3d8:	b8 21 00 00 00       	mov    $0x21,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 28             	sub    $0x28,%esp
 3e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f3:	00 
 3f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	89 04 24             	mov    %eax,(%esp)
 401:	e8 fa fe ff ff       	call   300 <write>
}
 406:	c9                   	leave  
 407:	c3                   	ret    

00000408 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 408:	55                   	push   %ebp
 409:	89 e5                	mov    %esp,%ebp
 40b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 40e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 415:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 419:	74 17                	je     432 <printint+0x2a>
 41b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 41f:	79 11                	jns    432 <printint+0x2a>
    neg = 1;
 421:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 428:	8b 45 0c             	mov    0xc(%ebp),%eax
 42b:	f7 d8                	neg    %eax
 42d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 430:	eb 06                	jmp    438 <printint+0x30>
  } else {
    x = xx;
 432:	8b 45 0c             	mov    0xc(%ebp),%eax
 435:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 438:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 43f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 442:	8b 45 ec             	mov    -0x14(%ebp),%eax
 445:	ba 00 00 00 00       	mov    $0x0,%edx
 44a:	f7 f1                	div    %ecx
 44c:	89 d0                	mov    %edx,%eax
 44e:	0f b6 90 00 0e 00 00 	movzbl 0xe00(%eax),%edx
 455:	8d 45 dc             	lea    -0x24(%ebp),%eax
 458:	03 45 f4             	add    -0xc(%ebp),%eax
 45b:	88 10                	mov    %dl,(%eax)
 45d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 461:	8b 55 10             	mov    0x10(%ebp),%edx
 464:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 467:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46a:	ba 00 00 00 00       	mov    $0x0,%edx
 46f:	f7 75 d4             	divl   -0x2c(%ebp)
 472:	89 45 ec             	mov    %eax,-0x14(%ebp)
 475:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 479:	75 c4                	jne    43f <printint+0x37>
  if(neg)
 47b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 47f:	74 2a                	je     4ab <printint+0xa3>
    buf[i++] = '-';
 481:	8d 45 dc             	lea    -0x24(%ebp),%eax
 484:	03 45 f4             	add    -0xc(%ebp),%eax
 487:	c6 00 2d             	movb   $0x2d,(%eax)
 48a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 48e:	eb 1b                	jmp    4ab <printint+0xa3>
    putc(fd, buf[i]);
 490:	8d 45 dc             	lea    -0x24(%ebp),%eax
 493:	03 45 f4             	add    -0xc(%ebp),%eax
 496:	0f b6 00             	movzbl (%eax),%eax
 499:	0f be c0             	movsbl %al,%eax
 49c:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
 4a3:	89 04 24             	mov    %eax,(%esp)
 4a6:	e8 35 ff ff ff       	call   3e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4ab:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b3:	79 db                	jns    490 <printint+0x88>
    putc(fd, buf[i]);
}
 4b5:	c9                   	leave  
 4b6:	c3                   	ret    

000004b7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b7:	55                   	push   %ebp
 4b8:	89 e5                	mov    %esp,%ebp
 4ba:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c7:	83 c0 04             	add    $0x4,%eax
 4ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d4:	e9 7d 01 00 00       	jmp    656 <printf+0x19f>
    c = fmt[i] & 0xff;
 4d9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4df:	01 d0                	add    %edx,%eax
 4e1:	0f b6 00             	movzbl (%eax),%eax
 4e4:	0f be c0             	movsbl %al,%eax
 4e7:	25 ff 00 00 00       	and    $0xff,%eax
 4ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f3:	75 2c                	jne    521 <printf+0x6a>
      if(c == '%'){
 4f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f9:	75 0c                	jne    507 <printf+0x50>
        state = '%';
 4fb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 502:	e9 4b 01 00 00       	jmp    652 <printf+0x19b>
      } else {
        putc(fd, c);
 507:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50a:	0f be c0             	movsbl %al,%eax
 50d:	89 44 24 04          	mov    %eax,0x4(%esp)
 511:	8b 45 08             	mov    0x8(%ebp),%eax
 514:	89 04 24             	mov    %eax,(%esp)
 517:	e8 c4 fe ff ff       	call   3e0 <putc>
 51c:	e9 31 01 00 00       	jmp    652 <printf+0x19b>
      }
    } else if(state == '%'){
 521:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 525:	0f 85 27 01 00 00    	jne    652 <printf+0x19b>
      if(c == 'd'){
 52b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 52f:	75 2d                	jne    55e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 531:	8b 45 e8             	mov    -0x18(%ebp),%eax
 534:	8b 00                	mov    (%eax),%eax
 536:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 53d:	00 
 53e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 545:	00 
 546:	89 44 24 04          	mov    %eax,0x4(%esp)
 54a:	8b 45 08             	mov    0x8(%ebp),%eax
 54d:	89 04 24             	mov    %eax,(%esp)
 550:	e8 b3 fe ff ff       	call   408 <printint>
        ap++;
 555:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 559:	e9 ed 00 00 00       	jmp    64b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 55e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 562:	74 06                	je     56a <printf+0xb3>
 564:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 568:	75 2d                	jne    597 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 56a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56d:	8b 00                	mov    (%eax),%eax
 56f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 576:	00 
 577:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 57e:	00 
 57f:	89 44 24 04          	mov    %eax,0x4(%esp)
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	89 04 24             	mov    %eax,(%esp)
 589:	e8 7a fe ff ff       	call   408 <printint>
        ap++;
 58e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 592:	e9 b4 00 00 00       	jmp    64b <printf+0x194>
      } else if(c == 's'){
 597:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 59b:	75 46                	jne    5e3 <printf+0x12c>
        s = (char*)*ap;
 59d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a0:	8b 00                	mov    (%eax),%eax
 5a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ad:	75 27                	jne    5d6 <printf+0x11f>
          s = "(null)";
 5af:	c7 45 f4 14 0a 00 00 	movl   $0xa14,-0xc(%ebp)
        while(*s != 0){
 5b6:	eb 1e                	jmp    5d6 <printf+0x11f>
          putc(fd, *s);
 5b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bb:	0f b6 00             	movzbl (%eax),%eax
 5be:	0f be c0             	movsbl %al,%eax
 5c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c5:	8b 45 08             	mov    0x8(%ebp),%eax
 5c8:	89 04 24             	mov    %eax,(%esp)
 5cb:	e8 10 fe ff ff       	call   3e0 <putc>
          s++;
 5d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5d4:	eb 01                	jmp    5d7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d6:	90                   	nop
 5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5da:	0f b6 00             	movzbl (%eax),%eax
 5dd:	84 c0                	test   %al,%al
 5df:	75 d7                	jne    5b8 <printf+0x101>
 5e1:	eb 68                	jmp    64b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5e3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e7:	75 1d                	jne    606 <printf+0x14f>
        putc(fd, *ap);
 5e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	0f be c0             	movsbl %al,%eax
 5f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f5:	8b 45 08             	mov    0x8(%ebp),%eax
 5f8:	89 04 24             	mov    %eax,(%esp)
 5fb:	e8 e0 fd ff ff       	call   3e0 <putc>
        ap++;
 600:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 604:	eb 45                	jmp    64b <printf+0x194>
      } else if(c == '%'){
 606:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 60a:	75 17                	jne    623 <printf+0x16c>
        putc(fd, c);
 60c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60f:	0f be c0             	movsbl %al,%eax
 612:	89 44 24 04          	mov    %eax,0x4(%esp)
 616:	8b 45 08             	mov    0x8(%ebp),%eax
 619:	89 04 24             	mov    %eax,(%esp)
 61c:	e8 bf fd ff ff       	call   3e0 <putc>
 621:	eb 28                	jmp    64b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 623:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 62a:	00 
 62b:	8b 45 08             	mov    0x8(%ebp),%eax
 62e:	89 04 24             	mov    %eax,(%esp)
 631:	e8 aa fd ff ff       	call   3e0 <putc>
        putc(fd, c);
 636:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 639:	0f be c0             	movsbl %al,%eax
 63c:	89 44 24 04          	mov    %eax,0x4(%esp)
 640:	8b 45 08             	mov    0x8(%ebp),%eax
 643:	89 04 24             	mov    %eax,(%esp)
 646:	e8 95 fd ff ff       	call   3e0 <putc>
      }
      state = 0;
 64b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 652:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 656:	8b 55 0c             	mov    0xc(%ebp),%edx
 659:	8b 45 f0             	mov    -0x10(%ebp),%eax
 65c:	01 d0                	add    %edx,%eax
 65e:	0f b6 00             	movzbl (%eax),%eax
 661:	84 c0                	test   %al,%al
 663:	0f 85 70 fe ff ff    	jne    4d9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 669:	c9                   	leave  
 66a:	c3                   	ret    
 66b:	90                   	nop

0000066c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 66c:	55                   	push   %ebp
 66d:	89 e5                	mov    %esp,%ebp
 66f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 672:	8b 45 08             	mov    0x8(%ebp),%eax
 675:	83 e8 08             	sub    $0x8,%eax
 678:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67b:	a1 1c 0e 00 00       	mov    0xe1c,%eax
 680:	89 45 fc             	mov    %eax,-0x4(%ebp)
 683:	eb 24                	jmp    6a9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 00                	mov    (%eax),%eax
 68a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68d:	77 12                	ja     6a1 <free+0x35>
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 695:	77 24                	ja     6bb <free+0x4f>
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69f:	77 1a                	ja     6bb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6af:	76 d4                	jbe    685 <free+0x19>
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 00                	mov    (%eax),%eax
 6b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b9:	76 ca                	jbe    685 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	8b 40 04             	mov    0x4(%eax),%eax
 6c1:	c1 e0 03             	shl    $0x3,%eax
 6c4:	89 c2                	mov    %eax,%edx
 6c6:	03 55 f8             	add    -0x8(%ebp),%edx
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 00                	mov    (%eax),%eax
 6ce:	39 c2                	cmp    %eax,%edx
 6d0:	75 24                	jne    6f6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	8b 50 04             	mov    0x4(%eax),%edx
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 00                	mov    (%eax),%eax
 6dd:	8b 40 04             	mov    0x4(%eax),%eax
 6e0:	01 c2                	add    %eax,%edx
 6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	8b 00                	mov    (%eax),%eax
 6ed:	8b 10                	mov    (%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	89 10                	mov    %edx,(%eax)
 6f4:	eb 0a                	jmp    700 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	8b 10                	mov    (%eax),%edx
 6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fe:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	8b 40 04             	mov    0x4(%eax),%eax
 706:	c1 e0 03             	shl    $0x3,%eax
 709:	03 45 fc             	add    -0x4(%ebp),%eax
 70c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70f:	75 20                	jne    731 <free+0xc5>
    p->s.size += bp->s.size;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 50 04             	mov    0x4(%eax),%edx
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	8b 40 04             	mov    0x4(%eax),%eax
 71d:	01 c2                	add    %eax,%edx
 71f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 722:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 725:	8b 45 f8             	mov    -0x8(%ebp),%eax
 728:	8b 10                	mov    (%eax),%edx
 72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72d:	89 10                	mov    %edx,(%eax)
 72f:	eb 08                	jmp    739 <free+0xcd>
  } else
    p->s.ptr = bp;
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 55 f8             	mov    -0x8(%ebp),%edx
 737:	89 10                	mov    %edx,(%eax)
  freep = p;
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	a3 1c 0e 00 00       	mov    %eax,0xe1c
}
 741:	c9                   	leave  
 742:	c3                   	ret    

00000743 <morecore>:

static Header*
morecore(uint nu)
{
 743:	55                   	push   %ebp
 744:	89 e5                	mov    %esp,%ebp
 746:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 749:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 750:	77 07                	ja     759 <morecore+0x16>
    nu = 4096;
 752:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 759:	8b 45 08             	mov    0x8(%ebp),%eax
 75c:	c1 e0 03             	shl    $0x3,%eax
 75f:	89 04 24             	mov    %eax,(%esp)
 762:	e8 01 fc ff ff       	call   368 <sbrk>
 767:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 76a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 76e:	75 07                	jne    777 <morecore+0x34>
    return 0;
 770:	b8 00 00 00 00       	mov    $0x0,%eax
 775:	eb 22                	jmp    799 <morecore+0x56>
  hp = (Header*)p;
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 780:	8b 55 08             	mov    0x8(%ebp),%edx
 783:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 786:	8b 45 f0             	mov    -0x10(%ebp),%eax
 789:	83 c0 08             	add    $0x8,%eax
 78c:	89 04 24             	mov    %eax,(%esp)
 78f:	e8 d8 fe ff ff       	call   66c <free>
  return freep;
 794:	a1 1c 0e 00 00       	mov    0xe1c,%eax
}
 799:	c9                   	leave  
 79a:	c3                   	ret    

0000079b <malloc>:

void*
malloc(uint nbytes)
{
 79b:	55                   	push   %ebp
 79c:	89 e5                	mov    %esp,%ebp
 79e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a1:	8b 45 08             	mov    0x8(%ebp),%eax
 7a4:	83 c0 07             	add    $0x7,%eax
 7a7:	c1 e8 03             	shr    $0x3,%eax
 7aa:	83 c0 01             	add    $0x1,%eax
 7ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b0:	a1 1c 0e 00 00       	mov    0xe1c,%eax
 7b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7bc:	75 23                	jne    7e1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7be:	c7 45 f0 14 0e 00 00 	movl   $0xe14,-0x10(%ebp)
 7c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c8:	a3 1c 0e 00 00       	mov    %eax,0xe1c
 7cd:	a1 1c 0e 00 00       	mov    0xe1c,%eax
 7d2:	a3 14 0e 00 00       	mov    %eax,0xe14
    base.s.size = 0;
 7d7:	c7 05 18 0e 00 00 00 	movl   $0x0,0xe18
 7de:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e4:	8b 00                	mov    (%eax),%eax
 7e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	8b 40 04             	mov    0x4(%eax),%eax
 7ef:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f2:	72 4d                	jb     841 <malloc+0xa6>
      if(p->s.size == nunits)
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fd:	75 0c                	jne    80b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 10                	mov    (%eax),%edx
 804:	8b 45 f0             	mov    -0x10(%ebp),%eax
 807:	89 10                	mov    %edx,(%eax)
 809:	eb 26                	jmp    831 <malloc+0x96>
      else {
        p->s.size -= nunits;
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	8b 40 04             	mov    0x4(%eax),%eax
 811:	89 c2                	mov    %eax,%edx
 813:	2b 55 ec             	sub    -0x14(%ebp),%edx
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	8b 40 04             	mov    0x4(%eax),%eax
 822:	c1 e0 03             	shl    $0x3,%eax
 825:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 831:	8b 45 f0             	mov    -0x10(%ebp),%eax
 834:	a3 1c 0e 00 00       	mov    %eax,0xe1c
      return (void*)(p + 1);
 839:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83c:	83 c0 08             	add    $0x8,%eax
 83f:	eb 38                	jmp    879 <malloc+0xde>
    }
    if(p == freep)
 841:	a1 1c 0e 00 00       	mov    0xe1c,%eax
 846:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 849:	75 1b                	jne    866 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 84b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84e:	89 04 24             	mov    %eax,(%esp)
 851:	e8 ed fe ff ff       	call   743 <morecore>
 856:	89 45 f4             	mov    %eax,-0xc(%ebp)
 859:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85d:	75 07                	jne    866 <malloc+0xcb>
        return 0;
 85f:	b8 00 00 00 00       	mov    $0x0,%eax
 864:	eb 13                	jmp    879 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	8b 45 f4             	mov    -0xc(%ebp),%eax
 869:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86f:	8b 00                	mov    (%eax),%eax
 871:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 874:	e9 70 ff ff ff       	jmp    7e9 <malloc+0x4e>
}
 879:	c9                   	leave  
 87a:	c3                   	ret    
 87b:	90                   	nop

0000087c <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 87c:	55                   	push   %ebp
 87d:	89 e5                	mov    %esp,%ebp
 87f:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 882:	8b 45 0c             	mov    0xc(%ebp),%eax
 885:	89 04 24             	mov    %eax,(%esp)
 888:	8b 45 08             	mov    0x8(%ebp),%eax
 88b:	ff d0                	call   *%eax
    exit();
 88d:	e8 4e fa ff ff       	call   2e0 <exit>

00000892 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 892:	55                   	push   %ebp
 893:	89 e5                	mov    %esp,%ebp
 895:	57                   	push   %edi
 896:	56                   	push   %esi
 897:	53                   	push   %ebx
 898:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 89b:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8a2:	e8 f4 fe ff ff       	call   79b <malloc>
 8a7:	89 c2                	mov    %eax,%edx
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
 8ac:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8ae:	8b 45 10             	mov    0x10(%ebp),%eax
 8b1:	8b 38                	mov    (%eax),%edi
 8b3:	8b 75 0c             	mov    0xc(%ebp),%esi
 8b6:	bb 7c 08 00 00       	mov    $0x87c,%ebx
 8bb:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8c2:	e8 d4 fe ff ff       	call   79b <malloc>
 8c7:	05 00 10 00 00       	add    $0x1000,%eax
 8cc:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8d0:	89 74 24 08          	mov    %esi,0x8(%esp)
 8d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8d8:	89 04 24             	mov    %eax,(%esp)
 8db:	e8 a0 fa ff ff       	call   380 <kthread_create>
 8e0:	8b 55 08             	mov    0x8(%ebp),%edx
 8e3:	89 02                	mov    %eax,(%edx)
    return *thread;
 8e5:	8b 45 08             	mov    0x8(%ebp),%eax
 8e8:	8b 00                	mov    (%eax),%eax
}
 8ea:	83 c4 1c             	add    $0x1c,%esp
 8ed:	5b                   	pop    %ebx
 8ee:	5e                   	pop    %esi
 8ef:	5f                   	pop    %edi
 8f0:	5d                   	pop    %ebp
 8f1:	c3                   	ret    

000008f2 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8f2:	55                   	push   %ebp
 8f3:	89 e5                	mov    %esp,%ebp
 8f5:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 8f8:	8b 45 0c             	mov    0xc(%ebp),%eax
 8fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ff:	8b 45 08             	mov    0x8(%ebp),%eax
 902:	89 04 24             	mov    %eax,(%esp)
 905:	e8 7e fa ff ff       	call   388 <kthread_join>
 90a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 90d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 910:	c9                   	leave  
 911:	c3                   	ret    

00000912 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 912:	55                   	push   %ebp
 913:	89 e5                	mov    %esp,%ebp
 915:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 918:	e8 73 fa ff ff       	call   390 <kthread_mutex_init>
 91d:	8b 55 08             	mov    0x8(%ebp),%edx
 920:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 922:	8b 45 08             	mov    0x8(%ebp),%eax
 925:	8b 00                	mov    (%eax),%eax
 927:	85 c0                	test   %eax,%eax
 929:	7e 07                	jle    932 <qthread_mutex_init+0x20>
		return 0;
 92b:	b8 00 00 00 00       	mov    $0x0,%eax
 930:	eb 05                	jmp    937 <qthread_mutex_init+0x25>
	}
	return *mutex;
 932:	8b 45 08             	mov    0x8(%ebp),%eax
 935:	8b 00                	mov    (%eax),%eax
}
 937:	c9                   	leave  
 938:	c3                   	ret    

00000939 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 939:	55                   	push   %ebp
 93a:	89 e5                	mov    %esp,%ebp
 93c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 93f:	8b 45 08             	mov    0x8(%ebp),%eax
 942:	89 04 24             	mov    %eax,(%esp)
 945:	e8 4e fa ff ff       	call   398 <kthread_mutex_destroy>
 94a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 94d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 951:	79 07                	jns    95a <qthread_mutex_destroy+0x21>
    	return -1;
 953:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 958:	eb 05                	jmp    95f <qthread_mutex_destroy+0x26>
    }
    return 0;
 95a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 95f:	c9                   	leave  
 960:	c3                   	ret    

00000961 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 961:	55                   	push   %ebp
 962:	89 e5                	mov    %esp,%ebp
 964:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 967:	8b 45 08             	mov    0x8(%ebp),%eax
 96a:	89 04 24             	mov    %eax,(%esp)
 96d:	e8 2e fa ff ff       	call   3a0 <kthread_mutex_lock>
 972:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 975:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 979:	79 07                	jns    982 <qthread_mutex_lock+0x21>
    	return -1;
 97b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 980:	eb 05                	jmp    987 <qthread_mutex_lock+0x26>
    }
    return 0;
 982:	b8 00 00 00 00       	mov    $0x0,%eax
}
 987:	c9                   	leave  
 988:	c3                   	ret    

00000989 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 989:	55                   	push   %ebp
 98a:	89 e5                	mov    %esp,%ebp
 98c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 98f:	8b 45 08             	mov    0x8(%ebp),%eax
 992:	89 04 24             	mov    %eax,(%esp)
 995:	e8 0e fa ff ff       	call   3a8 <kthread_mutex_unlock>
 99a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 99d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a1:	79 07                	jns    9aa <qthread_mutex_unlock+0x21>
    	return -1;
 9a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9a8:	eb 05                	jmp    9af <qthread_mutex_unlock+0x26>
    }
    return 0;
 9aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9af:	c9                   	leave  
 9b0:	c3                   	ret    

000009b1 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9b1:	55                   	push   %ebp
 9b2:	89 e5                	mov    %esp,%ebp

	return 0;
 9b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b9:	5d                   	pop    %ebp
 9ba:	c3                   	ret    

000009bb <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9bb:	55                   	push   %ebp
 9bc:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9be:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c3:	5d                   	pop    %ebp
 9c4:	c3                   	ret    

000009c5 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9c5:	55                   	push   %ebp
 9c6:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9cd:	5d                   	pop    %ebp
 9ce:	c3                   	ret    

000009cf <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9cf:	55                   	push   %ebp
 9d0:	89 e5                	mov    %esp,%ebp
	return 0;
 9d2:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9d7:	5d                   	pop    %ebp
 9d8:	c3                   	ret    

000009d9 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9d9:	55                   	push   %ebp
 9da:	89 e5                	mov    %esp,%ebp
	return 0;
 9dc:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9e1:	5d                   	pop    %ebp
 9e2:	c3                   	ret    

000009e3 <qthread_exit>:

int qthread_exit(){
 9e3:	55                   	push   %ebp
 9e4:	89 e5                	mov    %esp,%ebp
	return 0;
 9e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9eb:	5d                   	pop    %ebp
 9ec:	c3                   	ret    
