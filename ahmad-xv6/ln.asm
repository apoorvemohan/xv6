
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
   f:	c7 44 24 04 04 0a 00 	movl   $0xa04,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 9e 04 00 00       	call   4c1 <printf>
    exit();
  23:	e8 b9 02 00 00       	call   2e1 <exit>
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
  3f:	e8 fd 02 00 00       	call   341 <link>
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
  60:	c7 44 24 04 17 0a 00 	movl   $0xa17,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	e8 4d 04 00 00       	call   4c1 <printf>
  exit();
  74:	e8 68 02 00 00       	call   2e1 <exit>

00000079 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  79:	55                   	push   %ebp
  7a:	89 e5                	mov    %esp,%ebp
  7c:	57                   	push   %edi
  7d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  7e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  81:	8b 55 10             	mov    0x10(%ebp),%edx
  84:	8b 45 0c             	mov    0xc(%ebp),%eax
  87:	89 cb                	mov    %ecx,%ebx
  89:	89 df                	mov    %ebx,%edi
  8b:	89 d1                	mov    %edx,%ecx
  8d:	fc                   	cld    
  8e:	f3 aa                	rep stos %al,%es:(%edi)
  90:	89 ca                	mov    %ecx,%edx
  92:	89 fb                	mov    %edi,%ebx
  94:	89 5d 08             	mov    %ebx,0x8(%ebp)
  97:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9a:	5b                   	pop    %ebx
  9b:	5f                   	pop    %edi
  9c:	5d                   	pop    %ebp
  9d:	c3                   	ret    

0000009e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9e:	55                   	push   %ebp
  9f:	89 e5                	mov    %esp,%ebp
  a1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  aa:	90                   	nop
  ab:	8b 45 08             	mov    0x8(%ebp),%eax
  ae:	8d 50 01             	lea    0x1(%eax),%edx
  b1:	89 55 08             	mov    %edx,0x8(%ebp)
  b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  b7:	8d 4a 01             	lea    0x1(%edx),%ecx
  ba:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  bd:	0f b6 12             	movzbl (%edx),%edx
  c0:	88 10                	mov    %dl,(%eax)
  c2:	0f b6 00             	movzbl (%eax),%eax
  c5:	84 c0                	test   %al,%al
  c7:	75 e2                	jne    ab <strcpy+0xd>
    ;
  return os;
  c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  cc:	c9                   	leave  
  cd:	c3                   	ret    

000000ce <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ce:	55                   	push   %ebp
  cf:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d1:	eb 08                	jmp    db <strcmp+0xd>
    p++, q++;
  d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	0f b6 00             	movzbl (%eax),%eax
  e1:	84 c0                	test   %al,%al
  e3:	74 10                	je     f5 <strcmp+0x27>
  e5:	8b 45 08             	mov    0x8(%ebp),%eax
  e8:	0f b6 10             	movzbl (%eax),%edx
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	0f b6 00             	movzbl (%eax),%eax
  f1:	38 c2                	cmp    %al,%dl
  f3:	74 de                	je     d3 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f5:	8b 45 08             	mov    0x8(%ebp),%eax
  f8:	0f b6 00             	movzbl (%eax),%eax
  fb:	0f b6 d0             	movzbl %al,%edx
  fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 101:	0f b6 00             	movzbl (%eax),%eax
 104:	0f b6 c0             	movzbl %al,%eax
 107:	29 c2                	sub    %eax,%edx
 109:	89 d0                	mov    %edx,%eax
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    

0000010d <strlen>:

uint
strlen(char *s)
{
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
 110:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 113:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 11a:	eb 04                	jmp    120 <strlen+0x13>
 11c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 120:	8b 55 fc             	mov    -0x4(%ebp),%edx
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	01 d0                	add    %edx,%eax
 128:	0f b6 00             	movzbl (%eax),%eax
 12b:	84 c0                	test   %al,%al
 12d:	75 ed                	jne    11c <strlen+0xf>
    ;
  return n;
 12f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 132:	c9                   	leave  
 133:	c3                   	ret    

00000134 <memset>:

void*
memset(void *dst, int c, uint n)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 13a:	8b 45 10             	mov    0x10(%ebp),%eax
 13d:	89 44 24 08          	mov    %eax,0x8(%esp)
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	89 44 24 04          	mov    %eax,0x4(%esp)
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	89 04 24             	mov    %eax,(%esp)
 14e:	e8 26 ff ff ff       	call   79 <stosb>
  return dst;
 153:	8b 45 08             	mov    0x8(%ebp),%eax
}
 156:	c9                   	leave  
 157:	c3                   	ret    

00000158 <strchr>:

char*
strchr(const char *s, char c)
{
 158:	55                   	push   %ebp
 159:	89 e5                	mov    %esp,%ebp
 15b:	83 ec 04             	sub    $0x4,%esp
 15e:	8b 45 0c             	mov    0xc(%ebp),%eax
 161:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 164:	eb 14                	jmp    17a <strchr+0x22>
    if(*s == c)
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	0f b6 00             	movzbl (%eax),%eax
 16c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 16f:	75 05                	jne    176 <strchr+0x1e>
      return (char*)s;
 171:	8b 45 08             	mov    0x8(%ebp),%eax
 174:	eb 13                	jmp    189 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 176:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	0f b6 00             	movzbl (%eax),%eax
 180:	84 c0                	test   %al,%al
 182:	75 e2                	jne    166 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 184:	b8 00 00 00 00       	mov    $0x0,%eax
}
 189:	c9                   	leave  
 18a:	c3                   	ret    

0000018b <gets>:

char*
gets(char *buf, int max)
{
 18b:	55                   	push   %ebp
 18c:	89 e5                	mov    %esp,%ebp
 18e:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 191:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 198:	eb 4c                	jmp    1e6 <gets+0x5b>
    cc = read(0, &c, 1);
 19a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a1:	00 
 1a2:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b0:	e8 44 01 00 00       	call   2f9 <read>
 1b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1bc:	7f 02                	jg     1c0 <gets+0x35>
      break;
 1be:	eb 31                	jmp    1f1 <gets+0x66>
    buf[i++] = c;
 1c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c3:	8d 50 01             	lea    0x1(%eax),%edx
 1c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1c9:	89 c2                	mov    %eax,%edx
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	01 c2                	add    %eax,%edx
 1d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1da:	3c 0a                	cmp    $0xa,%al
 1dc:	74 13                	je     1f1 <gets+0x66>
 1de:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e2:	3c 0d                	cmp    $0xd,%al
 1e4:	74 0b                	je     1f1 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e9:	83 c0 01             	add    $0x1,%eax
 1ec:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1ef:	7c a9                	jl     19a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
 1f7:	01 d0                	add    %edx,%eax
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
 215:	e8 07 01 00 00       	call   321 <open>
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
 237:	e8 fd 00 00 00       	call   339 <fstat>
 23c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 242:	89 04 24             	mov    %eax,(%esp)
 245:	e8 bf 00 00 00       	call   309 <close>
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
 25c:	eb 25                	jmp    283 <atoi+0x34>
    n = n*10 + *s++ - '0';
 25e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 261:	89 d0                	mov    %edx,%eax
 263:	c1 e0 02             	shl    $0x2,%eax
 266:	01 d0                	add    %edx,%eax
 268:	01 c0                	add    %eax,%eax
 26a:	89 c1                	mov    %eax,%ecx
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	8d 50 01             	lea    0x1(%eax),%edx
 272:	89 55 08             	mov    %edx,0x8(%ebp)
 275:	0f b6 00             	movzbl (%eax),%eax
 278:	0f be c0             	movsbl %al,%eax
 27b:	01 c8                	add    %ecx,%eax
 27d:	83 e8 30             	sub    $0x30,%eax
 280:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	0f b6 00             	movzbl (%eax),%eax
 289:	3c 2f                	cmp    $0x2f,%al
 28b:	7e 0a                	jle    297 <atoi+0x48>
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
 290:	0f b6 00             	movzbl (%eax),%eax
 293:	3c 39                	cmp    $0x39,%al
 295:	7e c7                	jle    25e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 297:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29a:	c9                   	leave  
 29b:	c3                   	ret    

0000029c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 29c:	55                   	push   %ebp
 29d:	89 e5                	mov    %esp,%ebp
 29f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2ae:	eb 17                	jmp    2c7 <memmove+0x2b>
    *dst++ = *src++;
 2b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b3:	8d 50 01             	lea    0x1(%eax),%edx
 2b6:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2bc:	8d 4a 01             	lea    0x1(%edx),%ecx
 2bf:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c2:	0f b6 12             	movzbl (%edx),%edx
 2c5:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c7:	8b 45 10             	mov    0x10(%ebp),%eax
 2ca:	8d 50 ff             	lea    -0x1(%eax),%edx
 2cd:	89 55 10             	mov    %edx,0x10(%ebp)
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7f dc                	jg     2b0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d7:	c9                   	leave  
 2d8:	c3                   	ret    

000002d9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d9:	b8 01 00 00 00       	mov    $0x1,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <exit>:
SYSCALL(exit)
 2e1:	b8 02 00 00 00       	mov    $0x2,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <wait>:
SYSCALL(wait)
 2e9:	b8 03 00 00 00       	mov    $0x3,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <pipe>:
SYSCALL(pipe)
 2f1:	b8 04 00 00 00       	mov    $0x4,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <read>:
SYSCALL(read)
 2f9:	b8 05 00 00 00       	mov    $0x5,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <write>:
SYSCALL(write)
 301:	b8 10 00 00 00       	mov    $0x10,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <close>:
SYSCALL(close)
 309:	b8 15 00 00 00       	mov    $0x15,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <kill>:
SYSCALL(kill)
 311:	b8 06 00 00 00       	mov    $0x6,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <exec>:
SYSCALL(exec)
 319:	b8 07 00 00 00       	mov    $0x7,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <open>:
SYSCALL(open)
 321:	b8 0f 00 00 00       	mov    $0xf,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <mknod>:
SYSCALL(mknod)
 329:	b8 11 00 00 00       	mov    $0x11,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <unlink>:
SYSCALL(unlink)
 331:	b8 12 00 00 00       	mov    $0x12,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <fstat>:
SYSCALL(fstat)
 339:	b8 08 00 00 00       	mov    $0x8,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <link>:
SYSCALL(link)
 341:	b8 13 00 00 00       	mov    $0x13,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <mkdir>:
SYSCALL(mkdir)
 349:	b8 14 00 00 00       	mov    $0x14,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <chdir>:
SYSCALL(chdir)
 351:	b8 09 00 00 00       	mov    $0x9,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <dup>:
SYSCALL(dup)
 359:	b8 0a 00 00 00       	mov    $0xa,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <getpid>:
SYSCALL(getpid)
 361:	b8 0b 00 00 00       	mov    $0xb,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <sbrk>:
SYSCALL(sbrk)
 369:	b8 0c 00 00 00       	mov    $0xc,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <sleep>:
SYSCALL(sleep)
 371:	b8 0d 00 00 00       	mov    $0xd,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <uptime>:
SYSCALL(uptime)
 379:	b8 0e 00 00 00       	mov    $0xe,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <kthread_create>:
SYSCALL(kthread_create)
 381:	b8 17 00 00 00       	mov    $0x17,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <kthread_join>:
SYSCALL(kthread_join)
 389:	b8 16 00 00 00       	mov    $0x16,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 391:	b8 18 00 00 00       	mov    $0x18,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 399:	b8 19 00 00 00       	mov    $0x19,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 3a1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 3a9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 3b1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3b9:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3c1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3c9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 3d1:	b8 20 00 00 00       	mov    $0x20,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <kthread_exit>:
 3d9:	b8 21 00 00 00       	mov    $0x21,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e1:	55                   	push   %ebp
 3e2:	89 e5                	mov    %esp,%ebp
 3e4:	83 ec 18             	sub    $0x18,%esp
 3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ea:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ed:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f4:	00 
 3f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fc:	8b 45 08             	mov    0x8(%ebp),%eax
 3ff:	89 04 24             	mov    %eax,(%esp)
 402:	e8 fa fe ff ff       	call   301 <write>
}
 407:	c9                   	leave  
 408:	c3                   	ret    

00000409 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 409:	55                   	push   %ebp
 40a:	89 e5                	mov    %esp,%ebp
 40c:	56                   	push   %esi
 40d:	53                   	push   %ebx
 40e:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 411:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 418:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41c:	74 17                	je     435 <printint+0x2c>
 41e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 422:	79 11                	jns    435 <printint+0x2c>
    neg = 1;
 424:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 42b:	8b 45 0c             	mov    0xc(%ebp),%eax
 42e:	f7 d8                	neg    %eax
 430:	89 45 ec             	mov    %eax,-0x14(%ebp)
 433:	eb 06                	jmp    43b <printint+0x32>
  } else {
    x = xx;
 435:	8b 45 0c             	mov    0xc(%ebp),%eax
 438:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 43b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 442:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 445:	8d 41 01             	lea    0x1(%ecx),%eax
 448:	89 45 f4             	mov    %eax,-0xc(%ebp)
 44b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 44e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 451:	ba 00 00 00 00       	mov    $0x0,%edx
 456:	f7 f3                	div    %ebx
 458:	89 d0                	mov    %edx,%eax
 45a:	0f b6 80 20 0e 00 00 	movzbl 0xe20(%eax),%eax
 461:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 465:	8b 75 10             	mov    0x10(%ebp),%esi
 468:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46b:	ba 00 00 00 00       	mov    $0x0,%edx
 470:	f7 f6                	div    %esi
 472:	89 45 ec             	mov    %eax,-0x14(%ebp)
 475:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 479:	75 c7                	jne    442 <printint+0x39>
  if(neg)
 47b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 47f:	74 10                	je     491 <printint+0x88>
    buf[i++] = '-';
 481:	8b 45 f4             	mov    -0xc(%ebp),%eax
 484:	8d 50 01             	lea    0x1(%eax),%edx
 487:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 48f:	eb 1f                	jmp    4b0 <printint+0xa7>
 491:	eb 1d                	jmp    4b0 <printint+0xa7>
    putc(fd, buf[i]);
 493:	8d 55 dc             	lea    -0x24(%ebp),%edx
 496:	8b 45 f4             	mov    -0xc(%ebp),%eax
 499:	01 d0                	add    %edx,%eax
 49b:	0f b6 00             	movzbl (%eax),%eax
 49e:	0f be c0             	movsbl %al,%eax
 4a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a5:	8b 45 08             	mov    0x8(%ebp),%eax
 4a8:	89 04 24             	mov    %eax,(%esp)
 4ab:	e8 31 ff ff ff       	call   3e1 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b8:	79 d9                	jns    493 <printint+0x8a>
    putc(fd, buf[i]);
}
 4ba:	83 c4 30             	add    $0x30,%esp
 4bd:	5b                   	pop    %ebx
 4be:	5e                   	pop    %esi
 4bf:	5d                   	pop    %ebp
 4c0:	c3                   	ret    

000004c1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c1:	55                   	push   %ebp
 4c2:	89 e5                	mov    %esp,%ebp
 4c4:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4ce:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d1:	83 c0 04             	add    $0x4,%eax
 4d4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4de:	e9 7c 01 00 00       	jmp    65f <printf+0x19e>
    c = fmt[i] & 0xff;
 4e3:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e9:	01 d0                	add    %edx,%eax
 4eb:	0f b6 00             	movzbl (%eax),%eax
 4ee:	0f be c0             	movsbl %al,%eax
 4f1:	25 ff 00 00 00       	and    $0xff,%eax
 4f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4fd:	75 2c                	jne    52b <printf+0x6a>
      if(c == '%'){
 4ff:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 503:	75 0c                	jne    511 <printf+0x50>
        state = '%';
 505:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 50c:	e9 4a 01 00 00       	jmp    65b <printf+0x19a>
      } else {
        putc(fd, c);
 511:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 514:	0f be c0             	movsbl %al,%eax
 517:	89 44 24 04          	mov    %eax,0x4(%esp)
 51b:	8b 45 08             	mov    0x8(%ebp),%eax
 51e:	89 04 24             	mov    %eax,(%esp)
 521:	e8 bb fe ff ff       	call   3e1 <putc>
 526:	e9 30 01 00 00       	jmp    65b <printf+0x19a>
      }
    } else if(state == '%'){
 52b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 52f:	0f 85 26 01 00 00    	jne    65b <printf+0x19a>
      if(c == 'd'){
 535:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 539:	75 2d                	jne    568 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 53b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53e:	8b 00                	mov    (%eax),%eax
 540:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 547:	00 
 548:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 54f:	00 
 550:	89 44 24 04          	mov    %eax,0x4(%esp)
 554:	8b 45 08             	mov    0x8(%ebp),%eax
 557:	89 04 24             	mov    %eax,(%esp)
 55a:	e8 aa fe ff ff       	call   409 <printint>
        ap++;
 55f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 563:	e9 ec 00 00 00       	jmp    654 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 568:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56c:	74 06                	je     574 <printf+0xb3>
 56e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 572:	75 2d                	jne    5a1 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 574:	8b 45 e8             	mov    -0x18(%ebp),%eax
 577:	8b 00                	mov    (%eax),%eax
 579:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 580:	00 
 581:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 588:	00 
 589:	89 44 24 04          	mov    %eax,0x4(%esp)
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
 590:	89 04 24             	mov    %eax,(%esp)
 593:	e8 71 fe ff ff       	call   409 <printint>
        ap++;
 598:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59c:	e9 b3 00 00 00       	jmp    654 <printf+0x193>
      } else if(c == 's'){
 5a1:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5a5:	75 45                	jne    5ec <printf+0x12b>
        s = (char*)*ap;
 5a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5aa:	8b 00                	mov    (%eax),%eax
 5ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5af:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b7:	75 09                	jne    5c2 <printf+0x101>
          s = "(null)";
 5b9:	c7 45 f4 2b 0a 00 00 	movl   $0xa2b,-0xc(%ebp)
        while(*s != 0){
 5c0:	eb 1e                	jmp    5e0 <printf+0x11f>
 5c2:	eb 1c                	jmp    5e0 <printf+0x11f>
          putc(fd, *s);
 5c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c7:	0f b6 00             	movzbl (%eax),%eax
 5ca:	0f be c0             	movsbl %al,%eax
 5cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d1:	8b 45 08             	mov    0x8(%ebp),%eax
 5d4:	89 04 24             	mov    %eax,(%esp)
 5d7:	e8 05 fe ff ff       	call   3e1 <putc>
          s++;
 5dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e3:	0f b6 00             	movzbl (%eax),%eax
 5e6:	84 c0                	test   %al,%al
 5e8:	75 da                	jne    5c4 <printf+0x103>
 5ea:	eb 68                	jmp    654 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ec:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5f0:	75 1d                	jne    60f <printf+0x14e>
        putc(fd, *ap);
 5f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f5:	8b 00                	mov    (%eax),%eax
 5f7:	0f be c0             	movsbl %al,%eax
 5fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	89 04 24             	mov    %eax,(%esp)
 604:	e8 d8 fd ff ff       	call   3e1 <putc>
        ap++;
 609:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60d:	eb 45                	jmp    654 <printf+0x193>
      } else if(c == '%'){
 60f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 613:	75 17                	jne    62c <printf+0x16b>
        putc(fd, c);
 615:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 618:	0f be c0             	movsbl %al,%eax
 61b:	89 44 24 04          	mov    %eax,0x4(%esp)
 61f:	8b 45 08             	mov    0x8(%ebp),%eax
 622:	89 04 24             	mov    %eax,(%esp)
 625:	e8 b7 fd ff ff       	call   3e1 <putc>
 62a:	eb 28                	jmp    654 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 62c:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 633:	00 
 634:	8b 45 08             	mov    0x8(%ebp),%eax
 637:	89 04 24             	mov    %eax,(%esp)
 63a:	e8 a2 fd ff ff       	call   3e1 <putc>
        putc(fd, c);
 63f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 642:	0f be c0             	movsbl %al,%eax
 645:	89 44 24 04          	mov    %eax,0x4(%esp)
 649:	8b 45 08             	mov    0x8(%ebp),%eax
 64c:	89 04 24             	mov    %eax,(%esp)
 64f:	e8 8d fd ff ff       	call   3e1 <putc>
      }
      state = 0;
 654:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 65b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 65f:	8b 55 0c             	mov    0xc(%ebp),%edx
 662:	8b 45 f0             	mov    -0x10(%ebp),%eax
 665:	01 d0                	add    %edx,%eax
 667:	0f b6 00             	movzbl (%eax),%eax
 66a:	84 c0                	test   %al,%al
 66c:	0f 85 71 fe ff ff    	jne    4e3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 672:	c9                   	leave  
 673:	c3                   	ret    

00000674 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 67a:	8b 45 08             	mov    0x8(%ebp),%eax
 67d:	83 e8 08             	sub    $0x8,%eax
 680:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 683:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 688:	89 45 fc             	mov    %eax,-0x4(%ebp)
 68b:	eb 24                	jmp    6b1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 695:	77 12                	ja     6a9 <free+0x35>
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69d:	77 24                	ja     6c3 <free+0x4f>
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 00                	mov    (%eax),%eax
 6a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a7:	77 1a                	ja     6c3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b7:	76 d4                	jbe    68d <free+0x19>
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c1:	76 ca                	jbe    68d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	8b 40 04             	mov    0x4(%eax),%eax
 6c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d3:	01 c2                	add    %eax,%edx
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	8b 00                	mov    (%eax),%eax
 6da:	39 c2                	cmp    %eax,%edx
 6dc:	75 24                	jne    702 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	8b 50 04             	mov    0x4(%eax),%edx
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 00                	mov    (%eax),%eax
 6e9:	8b 40 04             	mov    0x4(%eax),%eax
 6ec:	01 c2                	add    %eax,%edx
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	8b 00                	mov    (%eax),%eax
 6f9:	8b 10                	mov    (%eax),%edx
 6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fe:	89 10                	mov    %edx,(%eax)
 700:	eb 0a                	jmp    70c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 10                	mov    (%eax),%edx
 707:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 40 04             	mov    0x4(%eax),%eax
 712:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	01 d0                	add    %edx,%eax
 71e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 721:	75 20                	jne    743 <free+0xcf>
    p->s.size += bp->s.size;
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	8b 50 04             	mov    0x4(%eax),%edx
 729:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72c:	8b 40 04             	mov    0x4(%eax),%eax
 72f:	01 c2                	add    %eax,%edx
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 737:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73a:	8b 10                	mov    (%eax),%edx
 73c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73f:	89 10                	mov    %edx,(%eax)
 741:	eb 08                	jmp    74b <free+0xd7>
  } else
    p->s.ptr = bp;
 743:	8b 45 fc             	mov    -0x4(%ebp),%eax
 746:	8b 55 f8             	mov    -0x8(%ebp),%edx
 749:	89 10                	mov    %edx,(%eax)
  freep = p;
 74b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74e:	a3 3c 0e 00 00       	mov    %eax,0xe3c
}
 753:	c9                   	leave  
 754:	c3                   	ret    

00000755 <morecore>:

static Header*
morecore(uint nu)
{
 755:	55                   	push   %ebp
 756:	89 e5                	mov    %esp,%ebp
 758:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 75b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 762:	77 07                	ja     76b <morecore+0x16>
    nu = 4096;
 764:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 76b:	8b 45 08             	mov    0x8(%ebp),%eax
 76e:	c1 e0 03             	shl    $0x3,%eax
 771:	89 04 24             	mov    %eax,(%esp)
 774:	e8 f0 fb ff ff       	call   369 <sbrk>
 779:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 77c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 780:	75 07                	jne    789 <morecore+0x34>
    return 0;
 782:	b8 00 00 00 00       	mov    $0x0,%eax
 787:	eb 22                	jmp    7ab <morecore+0x56>
  hp = (Header*)p;
 789:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 78f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 792:	8b 55 08             	mov    0x8(%ebp),%edx
 795:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 798:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79b:	83 c0 08             	add    $0x8,%eax
 79e:	89 04 24             	mov    %eax,(%esp)
 7a1:	e8 ce fe ff ff       	call   674 <free>
  return freep;
 7a6:	a1 3c 0e 00 00       	mov    0xe3c,%eax
}
 7ab:	c9                   	leave  
 7ac:	c3                   	ret    

000007ad <malloc>:

void*
malloc(uint nbytes)
{
 7ad:	55                   	push   %ebp
 7ae:	89 e5                	mov    %esp,%ebp
 7b0:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b3:	8b 45 08             	mov    0x8(%ebp),%eax
 7b6:	83 c0 07             	add    $0x7,%eax
 7b9:	c1 e8 03             	shr    $0x3,%eax
 7bc:	83 c0 01             	add    $0x1,%eax
 7bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7c2:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 7c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7ce:	75 23                	jne    7f3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 45 f0 34 0e 00 00 	movl   $0xe34,-0x10(%ebp)
 7d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7da:	a3 3c 0e 00 00       	mov    %eax,0xe3c
 7df:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 7e4:	a3 34 0e 00 00       	mov    %eax,0xe34
    base.s.size = 0;
 7e9:	c7 05 38 0e 00 00 00 	movl   $0x0,0xe38
 7f0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f6:	8b 00                	mov    (%eax),%eax
 7f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fe:	8b 40 04             	mov    0x4(%eax),%eax
 801:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 804:	72 4d                	jb     853 <malloc+0xa6>
      if(p->s.size == nunits)
 806:	8b 45 f4             	mov    -0xc(%ebp),%eax
 809:	8b 40 04             	mov    0x4(%eax),%eax
 80c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 80f:	75 0c                	jne    81d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	8b 10                	mov    (%eax),%edx
 816:	8b 45 f0             	mov    -0x10(%ebp),%eax
 819:	89 10                	mov    %edx,(%eax)
 81b:	eb 26                	jmp    843 <malloc+0x96>
      else {
        p->s.size -= nunits;
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	2b 45 ec             	sub    -0x14(%ebp),%eax
 826:	89 c2                	mov    %eax,%edx
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 82e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 831:	8b 40 04             	mov    0x4(%eax),%eax
 834:	c1 e0 03             	shl    $0x3,%eax
 837:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 83a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 840:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 843:	8b 45 f0             	mov    -0x10(%ebp),%eax
 846:	a3 3c 0e 00 00       	mov    %eax,0xe3c
      return (void*)(p + 1);
 84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84e:	83 c0 08             	add    $0x8,%eax
 851:	eb 38                	jmp    88b <malloc+0xde>
    }
    if(p == freep)
 853:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 858:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 85b:	75 1b                	jne    878 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 85d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 860:	89 04 24             	mov    %eax,(%esp)
 863:	e8 ed fe ff ff       	call   755 <morecore>
 868:	89 45 f4             	mov    %eax,-0xc(%ebp)
 86b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 86f:	75 07                	jne    878 <malloc+0xcb>
        return 0;
 871:	b8 00 00 00 00       	mov    $0x0,%eax
 876:	eb 13                	jmp    88b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 878:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 881:	8b 00                	mov    (%eax),%eax
 883:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 886:	e9 70 ff ff ff       	jmp    7fb <malloc+0x4e>
}
 88b:	c9                   	leave  
 88c:	c3                   	ret    

0000088d <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 88d:	55                   	push   %ebp
 88e:	89 e5                	mov    %esp,%ebp
 890:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 893:	8b 45 0c             	mov    0xc(%ebp),%eax
 896:	89 04 24             	mov    %eax,(%esp)
 899:	8b 45 08             	mov    0x8(%ebp),%eax
 89c:	ff d0                	call   *%eax
    exit();
 89e:	e8 3e fa ff ff       	call   2e1 <exit>

000008a3 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 8a3:	55                   	push   %ebp
 8a4:	89 e5                	mov    %esp,%ebp
 8a6:	57                   	push   %edi
 8a7:	56                   	push   %esi
 8a8:	53                   	push   %ebx
 8a9:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 8ac:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8b3:	e8 f5 fe ff ff       	call   7ad <malloc>
 8b8:	8b 55 08             	mov    0x8(%ebp),%edx
 8bb:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8bd:	8b 45 10             	mov    0x10(%ebp),%eax
 8c0:	8b 38                	mov    (%eax),%edi
 8c2:	8b 75 0c             	mov    0xc(%ebp),%esi
 8c5:	bb 8d 08 00 00       	mov    $0x88d,%ebx
 8ca:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8d1:	e8 d7 fe ff ff       	call   7ad <malloc>
 8d6:	05 00 10 00 00       	add    $0x1000,%eax
 8db:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8df:	89 74 24 08          	mov    %esi,0x8(%esp)
 8e3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8e7:	89 04 24             	mov    %eax,(%esp)
 8ea:	e8 92 fa ff ff       	call   381 <kthread_create>
 8ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 8f2:	8b 45 08             	mov    0x8(%ebp),%eax
 8f5:	8b 00                	mov    (%eax),%eax
 8f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8fa:	89 10                	mov    %edx,(%eax)
    return t_id;
 8fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8ff:	83 c4 2c             	add    $0x2c,%esp
 902:	5b                   	pop    %ebx
 903:	5e                   	pop    %esi
 904:	5f                   	pop    %edi
 905:	5d                   	pop    %ebp
 906:	c3                   	ret    

00000907 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 907:	55                   	push   %ebp
 908:	89 e5                	mov    %esp,%ebp
 90a:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 90d:	8b 55 0c             	mov    0xc(%ebp),%edx
 910:	8b 45 08             	mov    0x8(%ebp),%eax
 913:	8b 00                	mov    (%eax),%eax
 915:	89 54 24 04          	mov    %edx,0x4(%esp)
 919:	89 04 24             	mov    %eax,(%esp)
 91c:	e8 68 fa ff ff       	call   389 <kthread_join>
 921:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 924:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 927:	c9                   	leave  
 928:	c3                   	ret    

00000929 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 929:	55                   	push   %ebp
 92a:	89 e5                	mov    %esp,%ebp
 92c:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 92f:	e8 5d fa ff ff       	call   391 <kthread_mutex_init>
 934:	8b 55 08             	mov    0x8(%ebp),%edx
 937:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 939:	8b 45 08             	mov    0x8(%ebp),%eax
 93c:	8b 00                	mov    (%eax),%eax
 93e:	85 c0                	test   %eax,%eax
 940:	7e 07                	jle    949 <qthread_mutex_init+0x20>
		return 0;
 942:	b8 00 00 00 00       	mov    $0x0,%eax
 947:	eb 05                	jmp    94e <qthread_mutex_init+0x25>
	}
	return *mutex;
 949:	8b 45 08             	mov    0x8(%ebp),%eax
 94c:	8b 00                	mov    (%eax),%eax
}
 94e:	c9                   	leave  
 94f:	c3                   	ret    

00000950 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 956:	8b 45 08             	mov    0x8(%ebp),%eax
 959:	89 04 24             	mov    %eax,(%esp)
 95c:	e8 38 fa ff ff       	call   399 <kthread_mutex_destroy>
 961:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 964:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 968:	79 07                	jns    971 <qthread_mutex_destroy+0x21>
    	return -1;
 96a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 96f:	eb 05                	jmp    976 <qthread_mutex_destroy+0x26>
    }
    return 0;
 971:	b8 00 00 00 00       	mov    $0x0,%eax
}
 976:	c9                   	leave  
 977:	c3                   	ret    

00000978 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 978:	55                   	push   %ebp
 979:	89 e5                	mov    %esp,%ebp
 97b:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 97e:	8b 45 08             	mov    0x8(%ebp),%eax
 981:	89 04 24             	mov    %eax,(%esp)
 984:	e8 18 fa ff ff       	call   3a1 <kthread_mutex_lock>
 989:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 98c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 990:	79 07                	jns    999 <qthread_mutex_lock+0x21>
    	return -1;
 992:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 997:	eb 05                	jmp    99e <qthread_mutex_lock+0x26>
    }
    return 0;
 999:	b8 00 00 00 00       	mov    $0x0,%eax
}
 99e:	c9                   	leave  
 99f:	c3                   	ret    

000009a0 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 9a6:	8b 45 08             	mov    0x8(%ebp),%eax
 9a9:	89 04 24             	mov    %eax,(%esp)
 9ac:	e8 f8 f9 ff ff       	call   3a9 <kthread_mutex_unlock>
 9b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9b8:	79 07                	jns    9c1 <qthread_mutex_unlock+0x21>
    	return -1;
 9ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9bf:	eb 05                	jmp    9c6 <qthread_mutex_unlock+0x26>
    }
    return 0;
 9c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c6:	c9                   	leave  
 9c7:	c3                   	ret    

000009c8 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9c8:	55                   	push   %ebp
 9c9:	89 e5                	mov    %esp,%ebp

	return 0;
 9cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d0:	5d                   	pop    %ebp
 9d1:	c3                   	ret    

000009d2 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9d2:	55                   	push   %ebp
 9d3:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9da:	5d                   	pop    %ebp
 9db:	c3                   	ret    

000009dc <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9dc:	55                   	push   %ebp
 9dd:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9df:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9e4:	5d                   	pop    %ebp
 9e5:	c3                   	ret    

000009e6 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9e6:	55                   	push   %ebp
 9e7:	89 e5                	mov    %esp,%ebp
	return 0;
 9e9:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9ee:	5d                   	pop    %ebp
 9ef:	c3                   	ret    

000009f0 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
	return 0;
 9f3:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9f8:	5d                   	pop    %ebp
 9f9:	c3                   	ret    

000009fa <qthread_exit>:

int qthread_exit(){
 9fa:	55                   	push   %ebp
 9fb:	89 e5                	mov    %esp,%ebp
	return 0;
 9fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a02:	5d                   	pop    %ebp
 a03:	c3                   	ret    
