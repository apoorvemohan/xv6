
_echo:     file format elf32-i386


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
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  for(i = 1; i < argc; i++)
   9:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  10:	00 
  11:	eb 45                	jmp    58 <main+0x58>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  13:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  17:	83 c0 01             	add    $0x1,%eax
  1a:	3b 45 08             	cmp    0x8(%ebp),%eax
  1d:	7d 07                	jge    26 <main+0x26>
  1f:	b8 d9 09 00 00       	mov    $0x9d9,%eax
  24:	eb 05                	jmp    2b <main+0x2b>
  26:	b8 db 09 00 00       	mov    $0x9db,%eax
  2b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  2f:	c1 e2 02             	shl    $0x2,%edx
  32:	03 55 0c             	add    0xc(%ebp),%edx
  35:	8b 12                	mov    (%edx),%edx
  37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  3b:	89 54 24 08          	mov    %edx,0x8(%esp)
  3f:	c7 44 24 04 dd 09 00 	movl   $0x9dd,0x4(%esp)
  46:	00 
  47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4e:	e8 50 04 00 00       	call   4a3 <printf>
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  53:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  58:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5c:	3b 45 08             	cmp    0x8(%ebp),%eax
  5f:	7c b2                	jl     13 <main+0x13>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  61:	e8 66 02 00 00       	call   2cc <exit>
  66:	90                   	nop
  67:	90                   	nop

00000068 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	57                   	push   %edi
  6c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  70:	8b 55 10             	mov    0x10(%ebp),%edx
  73:	8b 45 0c             	mov    0xc(%ebp),%eax
  76:	89 cb                	mov    %ecx,%ebx
  78:	89 df                	mov    %ebx,%edi
  7a:	89 d1                	mov    %edx,%ecx
  7c:	fc                   	cld    
  7d:	f3 aa                	rep stos %al,%es:(%edi)
  7f:	89 ca                	mov    %ecx,%edx
  81:	89 fb                	mov    %edi,%ebx
  83:	89 5d 08             	mov    %ebx,0x8(%ebp)
  86:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  89:	5b                   	pop    %ebx
  8a:	5f                   	pop    %edi
  8b:	5d                   	pop    %ebp
  8c:	c3                   	ret    

0000008d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8d:	55                   	push   %ebp
  8e:	89 e5                	mov    %esp,%ebp
  90:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  99:	90                   	nop
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 10             	movzbl (%eax),%edx
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	88 10                	mov    %dl,(%eax)
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 00             	movzbl (%eax),%eax
  ab:	84 c0                	test   %al,%al
  ad:	0f 95 c0             	setne  %al
  b0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  b8:	84 c0                	test   %al,%al
  ba:	75 de                	jne    9a <strcpy+0xd>
    ;
  return os;
  bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bf:	c9                   	leave  
  c0:	c3                   	ret    

000000c1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c4:	eb 08                	jmp    ce <strcmp+0xd>
    p++, q++;
  c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ca:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	8b 45 08             	mov    0x8(%ebp),%eax
  d1:	0f b6 00             	movzbl (%eax),%eax
  d4:	84 c0                	test   %al,%al
  d6:	74 10                	je     e8 <strcmp+0x27>
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	0f b6 10             	movzbl (%eax),%edx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	0f b6 00             	movzbl (%eax),%eax
  e4:	38 c2                	cmp    %al,%dl
  e6:	74 de                	je     c6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	0f b6 d0             	movzbl %al,%edx
  f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 c0             	movzbl %al,%eax
  fa:	89 d1                	mov    %edx,%ecx
  fc:	29 c1                	sub    %eax,%ecx
  fe:	89 c8                	mov    %ecx,%eax
}
 100:	5d                   	pop    %ebp
 101:	c3                   	ret    

00000102 <strlen>:

uint
strlen(char *s)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 108:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10f:	eb 04                	jmp    115 <strlen+0x13>
 111:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 115:	8b 45 fc             	mov    -0x4(%ebp),%eax
 118:	03 45 08             	add    0x8(%ebp),%eax
 11b:	0f b6 00             	movzbl (%eax),%eax
 11e:	84 c0                	test   %al,%al
 120:	75 ef                	jne    111 <strlen+0xf>
    ;
  return n;
 122:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 125:	c9                   	leave  
 126:	c3                   	ret    

00000127 <memset>:

void*
memset(void *dst, int c, uint n)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 12d:	8b 45 10             	mov    0x10(%ebp),%eax
 130:	89 44 24 08          	mov    %eax,0x8(%esp)
 134:	8b 45 0c             	mov    0xc(%ebp),%eax
 137:	89 44 24 04          	mov    %eax,0x4(%esp)
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 04 24             	mov    %eax,(%esp)
 141:	e8 22 ff ff ff       	call   68 <stosb>
  return dst;
 146:	8b 45 08             	mov    0x8(%ebp),%eax
}
 149:	c9                   	leave  
 14a:	c3                   	ret    

0000014b <strchr>:

char*
strchr(const char *s, char c)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 04             	sub    $0x4,%esp
 151:	8b 45 0c             	mov    0xc(%ebp),%eax
 154:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 157:	eb 14                	jmp    16d <strchr+0x22>
    if(*s == c)
 159:	8b 45 08             	mov    0x8(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 162:	75 05                	jne    169 <strchr+0x1e>
      return (char*)s;
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	eb 13                	jmp    17c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	75 e2                	jne    159 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 177:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17c:	c9                   	leave  
 17d:	c3                   	ret    

0000017e <gets>:

char*
gets(char *buf, int max)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 184:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18b:	eb 44                	jmp    1d1 <gets+0x53>
    cc = read(0, &c, 1);
 18d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 194:	00 
 195:	8d 45 ef             	lea    -0x11(%ebp),%eax
 198:	89 44 24 04          	mov    %eax,0x4(%esp)
 19c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1a3:	e8 3c 01 00 00       	call   2e4 <read>
 1a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1af:	7e 2d                	jle    1de <gets+0x60>
      break;
    buf[i++] = c;
 1b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b4:	03 45 08             	add    0x8(%ebp),%eax
 1b7:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1bb:	88 10                	mov    %dl,(%eax)
 1bd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1c1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c5:	3c 0a                	cmp    $0xa,%al
 1c7:	74 16                	je     1df <gets+0x61>
 1c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 0e                	je     1df <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1da:	7c b1                	jl     18d <gets+0xf>
 1dc:	eb 01                	jmp    1df <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1de:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e2:	03 45 08             	add    0x8(%ebp),%eax
 1e5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1eb:	c9                   	leave  
 1ec:	c3                   	ret    

000001ed <stat>:

int
stat(char *n, struct stat *st)
{
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
 1f0:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1fa:	00 
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	89 04 24             	mov    %eax,(%esp)
 201:	e8 06 01 00 00       	call   30c <open>
 206:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 209:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20d:	79 07                	jns    216 <stat+0x29>
    return -1;
 20f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 214:	eb 23                	jmp    239 <stat+0x4c>
  r = fstat(fd, st);
 216:	8b 45 0c             	mov    0xc(%ebp),%eax
 219:	89 44 24 04          	mov    %eax,0x4(%esp)
 21d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 220:	89 04 24             	mov    %eax,(%esp)
 223:	e8 fc 00 00 00       	call   324 <fstat>
 228:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22e:	89 04 24             	mov    %eax,(%esp)
 231:	e8 be 00 00 00       	call   2f4 <close>
  return r;
 236:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 239:	c9                   	leave  
 23a:	c3                   	ret    

0000023b <atoi>:

int
atoi(const char *s)
{
 23b:	55                   	push   %ebp
 23c:	89 e5                	mov    %esp,%ebp
 23e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 241:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 248:	eb 23                	jmp    26d <atoi+0x32>
    n = n*10 + *s++ - '0';
 24a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24d:	89 d0                	mov    %edx,%eax
 24f:	c1 e0 02             	shl    $0x2,%eax
 252:	01 d0                	add    %edx,%eax
 254:	01 c0                	add    %eax,%eax
 256:	89 c2                	mov    %eax,%edx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	0f b6 00             	movzbl (%eax),%eax
 25e:	0f be c0             	movsbl %al,%eax
 261:	01 d0                	add    %edx,%eax
 263:	83 e8 30             	sub    $0x30,%eax
 266:	89 45 fc             	mov    %eax,-0x4(%ebp)
 269:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x46>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c9                	jle    24a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 298:	eb 13                	jmp    2ad <memmove+0x27>
    *dst++ = *src++;
 29a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 29d:	0f b6 10             	movzbl (%eax),%edx
 2a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a3:	88 10                	mov    %dl,(%eax)
 2a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2a9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2b1:	0f 9f c0             	setg   %al
 2b4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2b8:	84 c0                	test   %al,%al
 2ba:	75 de                	jne    29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bf:	c9                   	leave  
 2c0:	c3                   	ret    
 2c1:	90                   	nop
 2c2:	90                   	nop
 2c3:	90                   	nop

000002c4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c4:	b8 01 00 00 00       	mov    $0x1,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <exit>:
SYSCALL(exit)
 2cc:	b8 02 00 00 00       	mov    $0x2,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <wait>:
SYSCALL(wait)
 2d4:	b8 03 00 00 00       	mov    $0x3,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <pipe>:
SYSCALL(pipe)
 2dc:	b8 04 00 00 00       	mov    $0x4,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <read>:
SYSCALL(read)
 2e4:	b8 05 00 00 00       	mov    $0x5,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <write>:
SYSCALL(write)
 2ec:	b8 10 00 00 00       	mov    $0x10,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <close>:
SYSCALL(close)
 2f4:	b8 15 00 00 00       	mov    $0x15,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <kill>:
SYSCALL(kill)
 2fc:	b8 06 00 00 00       	mov    $0x6,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <exec>:
SYSCALL(exec)
 304:	b8 07 00 00 00       	mov    $0x7,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <open>:
SYSCALL(open)
 30c:	b8 0f 00 00 00       	mov    $0xf,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <mknod>:
SYSCALL(mknod)
 314:	b8 11 00 00 00       	mov    $0x11,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <unlink>:
SYSCALL(unlink)
 31c:	b8 12 00 00 00       	mov    $0x12,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <fstat>:
SYSCALL(fstat)
 324:	b8 08 00 00 00       	mov    $0x8,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <link>:
SYSCALL(link)
 32c:	b8 13 00 00 00       	mov    $0x13,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <mkdir>:
SYSCALL(mkdir)
 334:	b8 14 00 00 00       	mov    $0x14,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <chdir>:
SYSCALL(chdir)
 33c:	b8 09 00 00 00       	mov    $0x9,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <dup>:
SYSCALL(dup)
 344:	b8 0a 00 00 00       	mov    $0xa,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <getpid>:
SYSCALL(getpid)
 34c:	b8 0b 00 00 00       	mov    $0xb,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <sbrk>:
SYSCALL(sbrk)
 354:	b8 0c 00 00 00       	mov    $0xc,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <sleep>:
SYSCALL(sleep)
 35c:	b8 0d 00 00 00       	mov    $0xd,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <uptime>:
SYSCALL(uptime)
 364:	b8 0e 00 00 00       	mov    $0xe,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <kthread_create>:
SYSCALL(kthread_create)
 36c:	b8 17 00 00 00       	mov    $0x17,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <kthread_join>:
SYSCALL(kthread_join)
 374:	b8 16 00 00 00       	mov    $0x16,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 37c:	b8 18 00 00 00       	mov    $0x18,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 384:	b8 19 00 00 00       	mov    $0x19,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 38c:	b8 1a 00 00 00       	mov    $0x1a,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 394:	b8 1b 00 00 00       	mov    $0x1b,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 39c:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3a4:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3ac:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3b4:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 3bc:	b8 20 00 00 00       	mov    $0x20,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <kthread_exit>:
 3c4:	b8 21 00 00 00       	mov    $0x21,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3cc:	55                   	push   %ebp
 3cd:	89 e5                	mov    %esp,%ebp
 3cf:	83 ec 28             	sub    $0x28,%esp
 3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3df:	00 
 3e0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ea:	89 04 24             	mov    %eax,(%esp)
 3ed:	e8 fa fe ff ff       	call   2ec <write>
}
 3f2:	c9                   	leave  
 3f3:	c3                   	ret    

000003f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 401:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 405:	74 17                	je     41e <printint+0x2a>
 407:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40b:	79 11                	jns    41e <printint+0x2a>
    neg = 1;
 40d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	f7 d8                	neg    %eax
 419:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41c:	eb 06                	jmp    424 <printint+0x30>
  } else {
    x = xx;
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 424:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 431:	ba 00 00 00 00       	mov    $0x0,%edx
 436:	f7 f1                	div    %ecx
 438:	89 d0                	mov    %edx,%eax
 43a:	0f b6 90 d0 0d 00 00 	movzbl 0xdd0(%eax),%edx
 441:	8d 45 dc             	lea    -0x24(%ebp),%eax
 444:	03 45 f4             	add    -0xc(%ebp),%eax
 447:	88 10                	mov    %dl,(%eax)
 449:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 44d:	8b 55 10             	mov    0x10(%ebp),%edx
 450:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 75 d4             	divl   -0x2c(%ebp)
 45e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 465:	75 c4                	jne    42b <printint+0x37>
  if(neg)
 467:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46b:	74 2a                	je     497 <printint+0xa3>
    buf[i++] = '-';
 46d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 470:	03 45 f4             	add    -0xc(%ebp),%eax
 473:	c6 00 2d             	movb   $0x2d,(%eax)
 476:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 47a:	eb 1b                	jmp    497 <printint+0xa3>
    putc(fd, buf[i]);
 47c:	8d 45 dc             	lea    -0x24(%ebp),%eax
 47f:	03 45 f4             	add    -0xc(%ebp),%eax
 482:	0f b6 00             	movzbl (%eax),%eax
 485:	0f be c0             	movsbl %al,%eax
 488:	89 44 24 04          	mov    %eax,0x4(%esp)
 48c:	8b 45 08             	mov    0x8(%ebp),%eax
 48f:	89 04 24             	mov    %eax,(%esp)
 492:	e8 35 ff ff ff       	call   3cc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 497:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49f:	79 db                	jns    47c <printint+0x88>
    putc(fd, buf[i]);
}
 4a1:	c9                   	leave  
 4a2:	c3                   	ret    

000004a3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a3:	55                   	push   %ebp
 4a4:	89 e5                	mov    %esp,%ebp
 4a6:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b3:	83 c0 04             	add    $0x4,%eax
 4b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c0:	e9 7d 01 00 00       	jmp    642 <printf+0x19f>
    c = fmt[i] & 0xff;
 4c5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4cb:	01 d0                	add    %edx,%eax
 4cd:	0f b6 00             	movzbl (%eax),%eax
 4d0:	0f be c0             	movsbl %al,%eax
 4d3:	25 ff 00 00 00       	and    $0xff,%eax
 4d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4df:	75 2c                	jne    50d <printf+0x6a>
      if(c == '%'){
 4e1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e5:	75 0c                	jne    4f3 <printf+0x50>
        state = '%';
 4e7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ee:	e9 4b 01 00 00       	jmp    63e <printf+0x19b>
      } else {
        putc(fd, c);
 4f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f6:	0f be c0             	movsbl %al,%eax
 4f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fd:	8b 45 08             	mov    0x8(%ebp),%eax
 500:	89 04 24             	mov    %eax,(%esp)
 503:	e8 c4 fe ff ff       	call   3cc <putc>
 508:	e9 31 01 00 00       	jmp    63e <printf+0x19b>
      }
    } else if(state == '%'){
 50d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 511:	0f 85 27 01 00 00    	jne    63e <printf+0x19b>
      if(c == 'd'){
 517:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 51b:	75 2d                	jne    54a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 51d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 520:	8b 00                	mov    (%eax),%eax
 522:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 529:	00 
 52a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 531:	00 
 532:	89 44 24 04          	mov    %eax,0x4(%esp)
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	89 04 24             	mov    %eax,(%esp)
 53c:	e8 b3 fe ff ff       	call   3f4 <printint>
        ap++;
 541:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 545:	e9 ed 00 00 00       	jmp    637 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 54a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54e:	74 06                	je     556 <printf+0xb3>
 550:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 554:	75 2d                	jne    583 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 556:	8b 45 e8             	mov    -0x18(%ebp),%eax
 559:	8b 00                	mov    (%eax),%eax
 55b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 562:	00 
 563:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 56a:	00 
 56b:	89 44 24 04          	mov    %eax,0x4(%esp)
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	89 04 24             	mov    %eax,(%esp)
 575:	e8 7a fe ff ff       	call   3f4 <printint>
        ap++;
 57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57e:	e9 b4 00 00 00       	jmp    637 <printf+0x194>
      } else if(c == 's'){
 583:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 587:	75 46                	jne    5cf <printf+0x12c>
        s = (char*)*ap;
 589:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58c:	8b 00                	mov    (%eax),%eax
 58e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 591:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 595:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 599:	75 27                	jne    5c2 <printf+0x11f>
          s = "(null)";
 59b:	c7 45 f4 e2 09 00 00 	movl   $0x9e2,-0xc(%ebp)
        while(*s != 0){
 5a2:	eb 1e                	jmp    5c2 <printf+0x11f>
          putc(fd, *s);
 5a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a7:	0f b6 00             	movzbl (%eax),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	89 04 24             	mov    %eax,(%esp)
 5b7:	e8 10 fe ff ff       	call   3cc <putc>
          s++;
 5bc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5c0:	eb 01                	jmp    5c3 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c2:	90                   	nop
 5c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c6:	0f b6 00             	movzbl (%eax),%eax
 5c9:	84 c0                	test   %al,%al
 5cb:	75 d7                	jne    5a4 <printf+0x101>
 5cd:	eb 68                	jmp    637 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cf:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d3:	75 1d                	jne    5f2 <printf+0x14f>
        putc(fd, *ap);
 5d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d8:	8b 00                	mov    (%eax),%eax
 5da:	0f be c0             	movsbl %al,%eax
 5dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
 5e4:	89 04 24             	mov    %eax,(%esp)
 5e7:	e8 e0 fd ff ff       	call   3cc <putc>
        ap++;
 5ec:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f0:	eb 45                	jmp    637 <printf+0x194>
      } else if(c == '%'){
 5f2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f6:	75 17                	jne    60f <printf+0x16c>
        putc(fd, c);
 5f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fb:	0f be c0             	movsbl %al,%eax
 5fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 602:	8b 45 08             	mov    0x8(%ebp),%eax
 605:	89 04 24             	mov    %eax,(%esp)
 608:	e8 bf fd ff ff       	call   3cc <putc>
 60d:	eb 28                	jmp    637 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 616:	00 
 617:	8b 45 08             	mov    0x8(%ebp),%eax
 61a:	89 04 24             	mov    %eax,(%esp)
 61d:	e8 aa fd ff ff       	call   3cc <putc>
        putc(fd, c);
 622:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 625:	0f be c0             	movsbl %al,%eax
 628:	89 44 24 04          	mov    %eax,0x4(%esp)
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	89 04 24             	mov    %eax,(%esp)
 632:	e8 95 fd ff ff       	call   3cc <putc>
      }
      state = 0;
 637:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 642:	8b 55 0c             	mov    0xc(%ebp),%edx
 645:	8b 45 f0             	mov    -0x10(%ebp),%eax
 648:	01 d0                	add    %edx,%eax
 64a:	0f b6 00             	movzbl (%eax),%eax
 64d:	84 c0                	test   %al,%al
 64f:	0f 85 70 fe ff ff    	jne    4c5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 655:	c9                   	leave  
 656:	c3                   	ret    
 657:	90                   	nop

00000658 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 658:	55                   	push   %ebp
 659:	89 e5                	mov    %esp,%ebp
 65b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65e:	8b 45 08             	mov    0x8(%ebp),%eax
 661:	83 e8 08             	sub    $0x8,%eax
 664:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 667:	a1 ec 0d 00 00       	mov    0xdec,%eax
 66c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66f:	eb 24                	jmp    695 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 679:	77 12                	ja     68d <free+0x35>
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 681:	77 24                	ja     6a7 <free+0x4f>
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68b:	77 1a                	ja     6a7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	89 45 fc             	mov    %eax,-0x4(%ebp)
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69b:	76 d4                	jbe    671 <free+0x19>
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a5:	76 ca                	jbe    671 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	8b 40 04             	mov    0x4(%eax),%eax
 6ad:	c1 e0 03             	shl    $0x3,%eax
 6b0:	89 c2                	mov    %eax,%edx
 6b2:	03 55 f8             	add    -0x8(%ebp),%edx
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	39 c2                	cmp    %eax,%edx
 6bc:	75 24                	jne    6e2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	8b 50 04             	mov    0x4(%eax),%edx
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	8b 40 04             	mov    0x4(%eax),%eax
 6cc:	01 c2                	add    %eax,%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
 6e0:	eb 0a                	jmp    6ec <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 10                	mov    (%eax),%edx
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 40 04             	mov    0x4(%eax),%eax
 6f2:	c1 e0 03             	shl    $0x3,%eax
 6f5:	03 45 fc             	add    -0x4(%ebp),%eax
 6f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6fb:	75 20                	jne    71d <free+0xc5>
    p->s.size += bp->s.size;
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 50 04             	mov    0x4(%eax),%edx
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	8b 40 04             	mov    0x4(%eax),%eax
 709:	01 c2                	add    %eax,%edx
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	8b 10                	mov    (%eax),%edx
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	89 10                	mov    %edx,(%eax)
 71b:	eb 08                	jmp    725 <free+0xcd>
  } else
    p->s.ptr = bp;
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 55 f8             	mov    -0x8(%ebp),%edx
 723:	89 10                	mov    %edx,(%eax)
  freep = p;
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	a3 ec 0d 00 00       	mov    %eax,0xdec
}
 72d:	c9                   	leave  
 72e:	c3                   	ret    

0000072f <morecore>:

static Header*
morecore(uint nu)
{
 72f:	55                   	push   %ebp
 730:	89 e5                	mov    %esp,%ebp
 732:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 735:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 73c:	77 07                	ja     745 <morecore+0x16>
    nu = 4096;
 73e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 745:	8b 45 08             	mov    0x8(%ebp),%eax
 748:	c1 e0 03             	shl    $0x3,%eax
 74b:	89 04 24             	mov    %eax,(%esp)
 74e:	e8 01 fc ff ff       	call   354 <sbrk>
 753:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 756:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 75a:	75 07                	jne    763 <morecore+0x34>
    return 0;
 75c:	b8 00 00 00 00       	mov    $0x0,%eax
 761:	eb 22                	jmp    785 <morecore+0x56>
  hp = (Header*)p;
 763:	8b 45 f4             	mov    -0xc(%ebp),%eax
 766:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 769:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76c:	8b 55 08             	mov    0x8(%ebp),%edx
 76f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 772:	8b 45 f0             	mov    -0x10(%ebp),%eax
 775:	83 c0 08             	add    $0x8,%eax
 778:	89 04 24             	mov    %eax,(%esp)
 77b:	e8 d8 fe ff ff       	call   658 <free>
  return freep;
 780:	a1 ec 0d 00 00       	mov    0xdec,%eax
}
 785:	c9                   	leave  
 786:	c3                   	ret    

00000787 <malloc>:

void*
malloc(uint nbytes)
{
 787:	55                   	push   %ebp
 788:	89 e5                	mov    %esp,%ebp
 78a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78d:	8b 45 08             	mov    0x8(%ebp),%eax
 790:	83 c0 07             	add    $0x7,%eax
 793:	c1 e8 03             	shr    $0x3,%eax
 796:	83 c0 01             	add    $0x1,%eax
 799:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 79c:	a1 ec 0d 00 00       	mov    0xdec,%eax
 7a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a8:	75 23                	jne    7cd <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7aa:	c7 45 f0 e4 0d 00 00 	movl   $0xde4,-0x10(%ebp)
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	a3 ec 0d 00 00       	mov    %eax,0xdec
 7b9:	a1 ec 0d 00 00       	mov    0xdec,%eax
 7be:	a3 e4 0d 00 00       	mov    %eax,0xde4
    base.s.size = 0;
 7c3:	c7 05 e8 0d 00 00 00 	movl   $0x0,0xde8
 7ca:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d0:	8b 00                	mov    (%eax),%eax
 7d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7de:	72 4d                	jb     82d <malloc+0xa6>
      if(p->s.size == nunits)
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 40 04             	mov    0x4(%eax),%eax
 7e6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e9:	75 0c                	jne    7f7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ee:	8b 10                	mov    (%eax),%edx
 7f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f3:	89 10                	mov    %edx,(%eax)
 7f5:	eb 26                	jmp    81d <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	89 c2                	mov    %eax,%edx
 7ff:	2b 55 ec             	sub    -0x14(%ebp),%edx
 802:	8b 45 f4             	mov    -0xc(%ebp),%eax
 805:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	8b 40 04             	mov    0x4(%eax),%eax
 80e:	c1 e0 03             	shl    $0x3,%eax
 811:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 55 ec             	mov    -0x14(%ebp),%edx
 81a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 81d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 820:	a3 ec 0d 00 00       	mov    %eax,0xdec
      return (void*)(p + 1);
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	83 c0 08             	add    $0x8,%eax
 82b:	eb 38                	jmp    865 <malloc+0xde>
    }
    if(p == freep)
 82d:	a1 ec 0d 00 00       	mov    0xdec,%eax
 832:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 835:	75 1b                	jne    852 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 837:	8b 45 ec             	mov    -0x14(%ebp),%eax
 83a:	89 04 24             	mov    %eax,(%esp)
 83d:	e8 ed fe ff ff       	call   72f <morecore>
 842:	89 45 f4             	mov    %eax,-0xc(%ebp)
 845:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 849:	75 07                	jne    852 <malloc+0xcb>
        return 0;
 84b:	b8 00 00 00 00       	mov    $0x0,%eax
 850:	eb 13                	jmp    865 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	89 45 f0             	mov    %eax,-0x10(%ebp)
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	8b 00                	mov    (%eax),%eax
 85d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 860:	e9 70 ff ff ff       	jmp    7d5 <malloc+0x4e>
}
 865:	c9                   	leave  
 866:	c3                   	ret    
 867:	90                   	nop

00000868 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 868:	55                   	push   %ebp
 869:	89 e5                	mov    %esp,%ebp
 86b:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 86e:	8b 45 0c             	mov    0xc(%ebp),%eax
 871:	89 04 24             	mov    %eax,(%esp)
 874:	8b 45 08             	mov    0x8(%ebp),%eax
 877:	ff d0                	call   *%eax
    exit();
 879:	e8 4e fa ff ff       	call   2cc <exit>

0000087e <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 87e:	55                   	push   %ebp
 87f:	89 e5                	mov    %esp,%ebp
 881:	57                   	push   %edi
 882:	56                   	push   %esi
 883:	53                   	push   %ebx
 884:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 887:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 88e:	e8 f4 fe ff ff       	call   787 <malloc>
 893:	89 c2                	mov    %eax,%edx
 895:	8b 45 08             	mov    0x8(%ebp),%eax
 898:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 89a:	8b 45 10             	mov    0x10(%ebp),%eax
 89d:	8b 38                	mov    (%eax),%edi
 89f:	8b 75 0c             	mov    0xc(%ebp),%esi
 8a2:	bb 68 08 00 00       	mov    $0x868,%ebx
 8a7:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8ae:	e8 d4 fe ff ff       	call   787 <malloc>
 8b3:	05 00 10 00 00       	add    $0x1000,%eax
 8b8:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8bc:	89 74 24 08          	mov    %esi,0x8(%esp)
 8c0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8c4:	89 04 24             	mov    %eax,(%esp)
 8c7:	e8 a0 fa ff ff       	call   36c <kthread_create>
 8cc:	8b 55 08             	mov    0x8(%ebp),%edx
 8cf:	89 02                	mov    %eax,(%edx)
    return *thread;
 8d1:	8b 45 08             	mov    0x8(%ebp),%eax
 8d4:	8b 00                	mov    (%eax),%eax
}
 8d6:	83 c4 1c             	add    $0x1c,%esp
 8d9:	5b                   	pop    %ebx
 8da:	5e                   	pop    %esi
 8db:	5f                   	pop    %edi
 8dc:	5d                   	pop    %ebp
 8dd:	c3                   	ret    

000008de <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8de:	55                   	push   %ebp
 8df:	89 e5                	mov    %esp,%ebp
 8e1:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 8e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 8e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 8eb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ee:	89 04 24             	mov    %eax,(%esp)
 8f1:	e8 7e fa ff ff       	call   374 <kthread_join>
 8f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 8fc:	c9                   	leave  
 8fd:	c3                   	ret    

000008fe <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 8fe:	55                   	push   %ebp
 8ff:	89 e5                	mov    %esp,%ebp
 901:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 904:	e8 73 fa ff ff       	call   37c <kthread_mutex_init>
 909:	8b 55 08             	mov    0x8(%ebp),%edx
 90c:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 90e:	8b 45 08             	mov    0x8(%ebp),%eax
 911:	8b 00                	mov    (%eax),%eax
 913:	85 c0                	test   %eax,%eax
 915:	7e 07                	jle    91e <qthread_mutex_init+0x20>
		return 0;
 917:	b8 00 00 00 00       	mov    $0x0,%eax
 91c:	eb 05                	jmp    923 <qthread_mutex_init+0x25>
	}
	return *mutex;
 91e:	8b 45 08             	mov    0x8(%ebp),%eax
 921:	8b 00                	mov    (%eax),%eax
}
 923:	c9                   	leave  
 924:	c3                   	ret    

00000925 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 925:	55                   	push   %ebp
 926:	89 e5                	mov    %esp,%ebp
 928:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 92b:	8b 45 08             	mov    0x8(%ebp),%eax
 92e:	89 04 24             	mov    %eax,(%esp)
 931:	e8 4e fa ff ff       	call   384 <kthread_mutex_destroy>
 936:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 939:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 93d:	79 07                	jns    946 <qthread_mutex_destroy+0x21>
    	return -1;
 93f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 944:	eb 05                	jmp    94b <qthread_mutex_destroy+0x26>
    }
    return 0;
 946:	b8 00 00 00 00       	mov    $0x0,%eax
}
 94b:	c9                   	leave  
 94c:	c3                   	ret    

0000094d <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 94d:	55                   	push   %ebp
 94e:	89 e5                	mov    %esp,%ebp
 950:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 953:	8b 45 08             	mov    0x8(%ebp),%eax
 956:	89 04 24             	mov    %eax,(%esp)
 959:	e8 2e fa ff ff       	call   38c <kthread_mutex_lock>
 95e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 961:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 965:	79 07                	jns    96e <qthread_mutex_lock+0x21>
    	return -1;
 967:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 96c:	eb 05                	jmp    973 <qthread_mutex_lock+0x26>
    }
    return 0;
 96e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 973:	c9                   	leave  
 974:	c3                   	ret    

00000975 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 975:	55                   	push   %ebp
 976:	89 e5                	mov    %esp,%ebp
 978:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 97b:	8b 45 08             	mov    0x8(%ebp),%eax
 97e:	89 04 24             	mov    %eax,(%esp)
 981:	e8 0e fa ff ff       	call   394 <kthread_mutex_unlock>
 986:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 989:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 98d:	79 07                	jns    996 <qthread_mutex_unlock+0x21>
    	return -1;
 98f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 994:	eb 05                	jmp    99b <qthread_mutex_unlock+0x26>
    }
    return 0;
 996:	b8 00 00 00 00       	mov    $0x0,%eax
}
 99b:	c9                   	leave  
 99c:	c3                   	ret    

0000099d <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 99d:	55                   	push   %ebp
 99e:	89 e5                	mov    %esp,%ebp

	return 0;
 9a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9a5:	5d                   	pop    %ebp
 9a6:	c3                   	ret    

000009a7 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9a7:	55                   	push   %ebp
 9a8:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9af:	5d                   	pop    %ebp
 9b0:	c3                   	ret    

000009b1 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9b1:	55                   	push   %ebp
 9b2:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b9:	5d                   	pop    %ebp
 9ba:	c3                   	ret    

000009bb <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9bb:	55                   	push   %ebp
 9bc:	89 e5                	mov    %esp,%ebp
	return 0;
 9be:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9c3:	5d                   	pop    %ebp
 9c4:	c3                   	ret    

000009c5 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9c5:	55                   	push   %ebp
 9c6:	89 e5                	mov    %esp,%ebp
	return 0;
 9c8:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9cd:	5d                   	pop    %ebp
 9ce:	c3                   	ret    

000009cf <qthread_exit>:

int qthread_exit(){
 9cf:	55                   	push   %ebp
 9d0:	89 e5                	mov    %esp,%ebp
	return 0;
 9d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d7:	5d                   	pop    %ebp
 9d8:	c3                   	ret    
