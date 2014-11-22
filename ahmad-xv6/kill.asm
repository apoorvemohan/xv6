
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 1){
   9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "usage: kill pid...\n");
   f:	c7 44 24 04 f2 09 00 	movl   $0x9f2,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 8c 04 00 00       	call   4af <printf>
    exit();
  23:	e8 a7 02 00 00       	call   2cf <exit>
  }
  for(i=1; i<argc; i++)
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 27                	jmp    59 <main+0x59>
    kill(atoi(argv[i]));
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 f1 01 00 00       	call   23d <atoi>
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 ab 02 00 00       	call   2ff <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  54:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  59:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5d:	3b 45 08             	cmp    0x8(%ebp),%eax
  60:	7c d0                	jl     32 <main+0x32>
    kill(atoi(argv[i]));
  exit();
  62:	e8 68 02 00 00       	call   2cf <exit>

00000067 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  67:	55                   	push   %ebp
  68:	89 e5                	mov    %esp,%ebp
  6a:	57                   	push   %edi
  6b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6f:	8b 55 10             	mov    0x10(%ebp),%edx
  72:	8b 45 0c             	mov    0xc(%ebp),%eax
  75:	89 cb                	mov    %ecx,%ebx
  77:	89 df                	mov    %ebx,%edi
  79:	89 d1                	mov    %edx,%ecx
  7b:	fc                   	cld    
  7c:	f3 aa                	rep stos %al,%es:(%edi)
  7e:	89 ca                	mov    %ecx,%edx
  80:	89 fb                	mov    %edi,%ebx
  82:	89 5d 08             	mov    %ebx,0x8(%ebp)
  85:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  88:	5b                   	pop    %ebx
  89:	5f                   	pop    %edi
  8a:	5d                   	pop    %ebp
  8b:	c3                   	ret    

0000008c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  92:	8b 45 08             	mov    0x8(%ebp),%eax
  95:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  98:	90                   	nop
  99:	8b 45 08             	mov    0x8(%ebp),%eax
  9c:	8d 50 01             	lea    0x1(%eax),%edx
  9f:	89 55 08             	mov    %edx,0x8(%ebp)
  a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  ab:	0f b6 12             	movzbl (%edx),%edx
  ae:	88 10                	mov    %dl,(%eax)
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	84 c0                	test   %al,%al
  b5:	75 e2                	jne    99 <strcpy+0xd>
    ;
  return os;
  b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ba:	c9                   	leave  
  bb:	c3                   	ret    

000000bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  bf:	eb 08                	jmp    c9 <strcmp+0xd>
    p++, q++;
  c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c9:	8b 45 08             	mov    0x8(%ebp),%eax
  cc:	0f b6 00             	movzbl (%eax),%eax
  cf:	84 c0                	test   %al,%al
  d1:	74 10                	je     e3 <strcmp+0x27>
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	0f b6 10             	movzbl (%eax),%edx
  d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  dc:	0f b6 00             	movzbl (%eax),%eax
  df:	38 c2                	cmp    %al,%dl
  e1:	74 de                	je     c1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 00             	movzbl (%eax),%eax
  e9:	0f b6 d0             	movzbl %al,%edx
  ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  ef:	0f b6 00             	movzbl (%eax),%eax
  f2:	0f b6 c0             	movzbl %al,%eax
  f5:	29 c2                	sub    %eax,%edx
  f7:	89 d0                	mov    %edx,%eax
}
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    

000000fb <strlen>:

uint
strlen(char *s)
{
  fb:	55                   	push   %ebp
  fc:	89 e5                	mov    %esp,%ebp
  fe:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 101:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 108:	eb 04                	jmp    10e <strlen+0x13>
 10a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	01 d0                	add    %edx,%eax
 116:	0f b6 00             	movzbl (%eax),%eax
 119:	84 c0                	test   %al,%al
 11b:	75 ed                	jne    10a <strlen+0xf>
    ;
  return n;
 11d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 120:	c9                   	leave  
 121:	c3                   	ret    

00000122 <memset>:

void*
memset(void *dst, int c, uint n)
{
 122:	55                   	push   %ebp
 123:	89 e5                	mov    %esp,%ebp
 125:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 128:	8b 45 10             	mov    0x10(%ebp),%eax
 12b:	89 44 24 08          	mov    %eax,0x8(%esp)
 12f:	8b 45 0c             	mov    0xc(%ebp),%eax
 132:	89 44 24 04          	mov    %eax,0x4(%esp)
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	89 04 24             	mov    %eax,(%esp)
 13c:	e8 26 ff ff ff       	call   67 <stosb>
  return dst;
 141:	8b 45 08             	mov    0x8(%ebp),%eax
}
 144:	c9                   	leave  
 145:	c3                   	ret    

00000146 <strchr>:

char*
strchr(const char *s, char c)
{
 146:	55                   	push   %ebp
 147:	89 e5                	mov    %esp,%ebp
 149:	83 ec 04             	sub    $0x4,%esp
 14c:	8b 45 0c             	mov    0xc(%ebp),%eax
 14f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 152:	eb 14                	jmp    168 <strchr+0x22>
    if(*s == c)
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	0f b6 00             	movzbl (%eax),%eax
 15a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15d:	75 05                	jne    164 <strchr+0x1e>
      return (char*)s;
 15f:	8b 45 08             	mov    0x8(%ebp),%eax
 162:	eb 13                	jmp    177 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 164:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	84 c0                	test   %al,%al
 170:	75 e2                	jne    154 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 172:	b8 00 00 00 00       	mov    $0x0,%eax
}
 177:	c9                   	leave  
 178:	c3                   	ret    

00000179 <gets>:

char*
gets(char *buf, int max)
{
 179:	55                   	push   %ebp
 17a:	89 e5                	mov    %esp,%ebp
 17c:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 186:	eb 4c                	jmp    1d4 <gets+0x5b>
    cc = read(0, &c, 1);
 188:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 18f:	00 
 190:	8d 45 ef             	lea    -0x11(%ebp),%eax
 193:	89 44 24 04          	mov    %eax,0x4(%esp)
 197:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19e:	e8 44 01 00 00       	call   2e7 <read>
 1a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1aa:	7f 02                	jg     1ae <gets+0x35>
      break;
 1ac:	eb 31                	jmp    1df <gets+0x66>
    buf[i++] = c;
 1ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b1:	8d 50 01             	lea    0x1(%eax),%edx
 1b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b7:	89 c2                	mov    %eax,%edx
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	01 c2                	add    %eax,%edx
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	3c 0a                	cmp    $0xa,%al
 1ca:	74 13                	je     1df <gets+0x66>
 1cc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d0:	3c 0d                	cmp    $0xd,%al
 1d2:	74 0b                	je     1df <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d7:	83 c0 01             	add    $0x1,%eax
 1da:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1dd:	7c a9                	jl     188 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1df:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	01 d0                	add    %edx,%eax
 1e7:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ed:	c9                   	leave  
 1ee:	c3                   	ret    

000001ef <stat>:

int
stat(char *n, struct stat *st)
{
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1fc:	00 
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	89 04 24             	mov    %eax,(%esp)
 203:	e8 07 01 00 00       	call   30f <open>
 208:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20f:	79 07                	jns    218 <stat+0x29>
    return -1;
 211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 216:	eb 23                	jmp    23b <stat+0x4c>
  r = fstat(fd, st);
 218:	8b 45 0c             	mov    0xc(%ebp),%eax
 21b:	89 44 24 04          	mov    %eax,0x4(%esp)
 21f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 222:	89 04 24             	mov    %eax,(%esp)
 225:	e8 fd 00 00 00       	call   327 <fstat>
 22a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 230:	89 04 24             	mov    %eax,(%esp)
 233:	e8 bf 00 00 00       	call   2f7 <close>
  return r;
 238:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23b:	c9                   	leave  
 23c:	c3                   	ret    

0000023d <atoi>:

int
atoi(const char *s)
{
 23d:	55                   	push   %ebp
 23e:	89 e5                	mov    %esp,%ebp
 240:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 243:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24a:	eb 25                	jmp    271 <atoi+0x34>
    n = n*10 + *s++ - '0';
 24c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24f:	89 d0                	mov    %edx,%eax
 251:	c1 e0 02             	shl    $0x2,%eax
 254:	01 d0                	add    %edx,%eax
 256:	01 c0                	add    %eax,%eax
 258:	89 c1                	mov    %eax,%ecx
 25a:	8b 45 08             	mov    0x8(%ebp),%eax
 25d:	8d 50 01             	lea    0x1(%eax),%edx
 260:	89 55 08             	mov    %edx,0x8(%ebp)
 263:	0f b6 00             	movzbl (%eax),%eax
 266:	0f be c0             	movsbl %al,%eax
 269:	01 c8                	add    %ecx,%eax
 26b:	83 e8 30             	sub    $0x30,%eax
 26e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	0f b6 00             	movzbl (%eax),%eax
 277:	3c 2f                	cmp    $0x2f,%al
 279:	7e 0a                	jle    285 <atoi+0x48>
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	0f b6 00             	movzbl (%eax),%eax
 281:	3c 39                	cmp    $0x39,%al
 283:	7e c7                	jle    24c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 285:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 288:	c9                   	leave  
 289:	c3                   	ret    

0000028a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28a:	55                   	push   %ebp
 28b:	89 e5                	mov    %esp,%ebp
 28d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 296:	8b 45 0c             	mov    0xc(%ebp),%eax
 299:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29c:	eb 17                	jmp    2b5 <memmove+0x2b>
    *dst++ = *src++;
 29e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a1:	8d 50 01             	lea    0x1(%eax),%edx
 2a4:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2aa:	8d 4a 01             	lea    0x1(%edx),%ecx
 2ad:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b0:	0f b6 12             	movzbl (%edx),%edx
 2b3:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b5:	8b 45 10             	mov    0x10(%ebp),%eax
 2b8:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bb:	89 55 10             	mov    %edx,0x10(%ebp)
 2be:	85 c0                	test   %eax,%eax
 2c0:	7f dc                	jg     29e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c5:	c9                   	leave  
 2c6:	c3                   	ret    

000002c7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c7:	b8 01 00 00 00       	mov    $0x1,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <exit>:
SYSCALL(exit)
 2cf:	b8 02 00 00 00       	mov    $0x2,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <wait>:
SYSCALL(wait)
 2d7:	b8 03 00 00 00       	mov    $0x3,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <pipe>:
SYSCALL(pipe)
 2df:	b8 04 00 00 00       	mov    $0x4,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <read>:
SYSCALL(read)
 2e7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <write>:
SYSCALL(write)
 2ef:	b8 10 00 00 00       	mov    $0x10,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <close>:
SYSCALL(close)
 2f7:	b8 15 00 00 00       	mov    $0x15,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <kill>:
SYSCALL(kill)
 2ff:	b8 06 00 00 00       	mov    $0x6,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <exec>:
SYSCALL(exec)
 307:	b8 07 00 00 00       	mov    $0x7,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <open>:
SYSCALL(open)
 30f:	b8 0f 00 00 00       	mov    $0xf,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <mknod>:
SYSCALL(mknod)
 317:	b8 11 00 00 00       	mov    $0x11,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <unlink>:
SYSCALL(unlink)
 31f:	b8 12 00 00 00       	mov    $0x12,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <fstat>:
SYSCALL(fstat)
 327:	b8 08 00 00 00       	mov    $0x8,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <link>:
SYSCALL(link)
 32f:	b8 13 00 00 00       	mov    $0x13,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <mkdir>:
SYSCALL(mkdir)
 337:	b8 14 00 00 00       	mov    $0x14,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <chdir>:
SYSCALL(chdir)
 33f:	b8 09 00 00 00       	mov    $0x9,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <dup>:
SYSCALL(dup)
 347:	b8 0a 00 00 00       	mov    $0xa,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <getpid>:
SYSCALL(getpid)
 34f:	b8 0b 00 00 00       	mov    $0xb,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sbrk>:
SYSCALL(sbrk)
 357:	b8 0c 00 00 00       	mov    $0xc,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <sleep>:
SYSCALL(sleep)
 35f:	b8 0d 00 00 00       	mov    $0xd,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <uptime>:
SYSCALL(uptime)
 367:	b8 0e 00 00 00       	mov    $0xe,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <kthread_create>:
SYSCALL(kthread_create)
 36f:	b8 17 00 00 00       	mov    $0x17,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <kthread_join>:
SYSCALL(kthread_join)
 377:	b8 16 00 00 00       	mov    $0x16,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 37f:	b8 18 00 00 00       	mov    $0x18,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 387:	b8 19 00 00 00       	mov    $0x19,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 38f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 397:	b8 1b 00 00 00       	mov    $0x1b,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 39f:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3a7:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3af:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3b7:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 3bf:	b8 20 00 00 00       	mov    $0x20,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <kthread_exit>:
 3c7:	b8 21 00 00 00       	mov    $0x21,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	83 ec 18             	sub    $0x18,%esp
 3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3db:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e2:	00 
 3e3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ea:	8b 45 08             	mov    0x8(%ebp),%eax
 3ed:	89 04 24             	mov    %eax,(%esp)
 3f0:	e8 fa fe ff ff       	call   2ef <write>
}
 3f5:	c9                   	leave  
 3f6:	c3                   	ret    

000003f7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f7:	55                   	push   %ebp
 3f8:	89 e5                	mov    %esp,%ebp
 3fa:	56                   	push   %esi
 3fb:	53                   	push   %ebx
 3fc:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 406:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 40a:	74 17                	je     423 <printint+0x2c>
 40c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 410:	79 11                	jns    423 <printint+0x2c>
    neg = 1;
 412:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 419:	8b 45 0c             	mov    0xc(%ebp),%eax
 41c:	f7 d8                	neg    %eax
 41e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 421:	eb 06                	jmp    429 <printint+0x32>
  } else {
    x = xx;
 423:	8b 45 0c             	mov    0xc(%ebp),%eax
 426:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 429:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 430:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 433:	8d 41 01             	lea    0x1(%ecx),%eax
 436:	89 45 f4             	mov    %eax,-0xc(%ebp)
 439:	8b 5d 10             	mov    0x10(%ebp),%ebx
 43c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43f:	ba 00 00 00 00       	mov    $0x0,%edx
 444:	f7 f3                	div    %ebx
 446:	89 d0                	mov    %edx,%eax
 448:	0f b6 80 fc 0d 00 00 	movzbl 0xdfc(%eax),%eax
 44f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 453:	8b 75 10             	mov    0x10(%ebp),%esi
 456:	8b 45 ec             	mov    -0x14(%ebp),%eax
 459:	ba 00 00 00 00       	mov    $0x0,%edx
 45e:	f7 f6                	div    %esi
 460:	89 45 ec             	mov    %eax,-0x14(%ebp)
 463:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 467:	75 c7                	jne    430 <printint+0x39>
  if(neg)
 469:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46d:	74 10                	je     47f <printint+0x88>
    buf[i++] = '-';
 46f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 472:	8d 50 01             	lea    0x1(%eax),%edx
 475:	89 55 f4             	mov    %edx,-0xc(%ebp)
 478:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47d:	eb 1f                	jmp    49e <printint+0xa7>
 47f:	eb 1d                	jmp    49e <printint+0xa7>
    putc(fd, buf[i]);
 481:	8d 55 dc             	lea    -0x24(%ebp),%edx
 484:	8b 45 f4             	mov    -0xc(%ebp),%eax
 487:	01 d0                	add    %edx,%eax
 489:	0f b6 00             	movzbl (%eax),%eax
 48c:	0f be c0             	movsbl %al,%eax
 48f:	89 44 24 04          	mov    %eax,0x4(%esp)
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	89 04 24             	mov    %eax,(%esp)
 499:	e8 31 ff ff ff       	call   3cf <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 49e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a6:	79 d9                	jns    481 <printint+0x8a>
    putc(fd, buf[i]);
}
 4a8:	83 c4 30             	add    $0x30,%esp
 4ab:	5b                   	pop    %ebx
 4ac:	5e                   	pop    %esi
 4ad:	5d                   	pop    %ebp
 4ae:	c3                   	ret    

000004af <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4af:	55                   	push   %ebp
 4b0:	89 e5                	mov    %esp,%ebp
 4b2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4bc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4bf:	83 c0 04             	add    $0x4,%eax
 4c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4cc:	e9 7c 01 00 00       	jmp    64d <printf+0x19e>
    c = fmt[i] & 0xff;
 4d1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d7:	01 d0                	add    %edx,%eax
 4d9:	0f b6 00             	movzbl (%eax),%eax
 4dc:	0f be c0             	movsbl %al,%eax
 4df:	25 ff 00 00 00       	and    $0xff,%eax
 4e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4eb:	75 2c                	jne    519 <printf+0x6a>
      if(c == '%'){
 4ed:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f1:	75 0c                	jne    4ff <printf+0x50>
        state = '%';
 4f3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4fa:	e9 4a 01 00 00       	jmp    649 <printf+0x19a>
      } else {
        putc(fd, c);
 4ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 502:	0f be c0             	movsbl %al,%eax
 505:	89 44 24 04          	mov    %eax,0x4(%esp)
 509:	8b 45 08             	mov    0x8(%ebp),%eax
 50c:	89 04 24             	mov    %eax,(%esp)
 50f:	e8 bb fe ff ff       	call   3cf <putc>
 514:	e9 30 01 00 00       	jmp    649 <printf+0x19a>
      }
    } else if(state == '%'){
 519:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 51d:	0f 85 26 01 00 00    	jne    649 <printf+0x19a>
      if(c == 'd'){
 523:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 527:	75 2d                	jne    556 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 529:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52c:	8b 00                	mov    (%eax),%eax
 52e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 535:	00 
 536:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 53d:	00 
 53e:	89 44 24 04          	mov    %eax,0x4(%esp)
 542:	8b 45 08             	mov    0x8(%ebp),%eax
 545:	89 04 24             	mov    %eax,(%esp)
 548:	e8 aa fe ff ff       	call   3f7 <printint>
        ap++;
 54d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 551:	e9 ec 00 00 00       	jmp    642 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 556:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 55a:	74 06                	je     562 <printf+0xb3>
 55c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 560:	75 2d                	jne    58f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 562:	8b 45 e8             	mov    -0x18(%ebp),%eax
 565:	8b 00                	mov    (%eax),%eax
 567:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 56e:	00 
 56f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 576:	00 
 577:	89 44 24 04          	mov    %eax,0x4(%esp)
 57b:	8b 45 08             	mov    0x8(%ebp),%eax
 57e:	89 04 24             	mov    %eax,(%esp)
 581:	e8 71 fe ff ff       	call   3f7 <printint>
        ap++;
 586:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58a:	e9 b3 00 00 00       	jmp    642 <printf+0x193>
      } else if(c == 's'){
 58f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 593:	75 45                	jne    5da <printf+0x12b>
        s = (char*)*ap;
 595:	8b 45 e8             	mov    -0x18(%ebp),%eax
 598:	8b 00                	mov    (%eax),%eax
 59a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 59d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a5:	75 09                	jne    5b0 <printf+0x101>
          s = "(null)";
 5a7:	c7 45 f4 06 0a 00 00 	movl   $0xa06,-0xc(%ebp)
        while(*s != 0){
 5ae:	eb 1e                	jmp    5ce <printf+0x11f>
 5b0:	eb 1c                	jmp    5ce <printf+0x11f>
          putc(fd, *s);
 5b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b5:	0f b6 00             	movzbl (%eax),%eax
 5b8:	0f be c0             	movsbl %al,%eax
 5bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bf:	8b 45 08             	mov    0x8(%ebp),%eax
 5c2:	89 04 24             	mov    %eax,(%esp)
 5c5:	e8 05 fe ff ff       	call   3cf <putc>
          s++;
 5ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d1:	0f b6 00             	movzbl (%eax),%eax
 5d4:	84 c0                	test   %al,%al
 5d6:	75 da                	jne    5b2 <printf+0x103>
 5d8:	eb 68                	jmp    642 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5da:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5de:	75 1d                	jne    5fd <printf+0x14e>
        putc(fd, *ap);
 5e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e3:	8b 00                	mov    (%eax),%eax
 5e5:	0f be c0             	movsbl %al,%eax
 5e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	89 04 24             	mov    %eax,(%esp)
 5f2:	e8 d8 fd ff ff       	call   3cf <putc>
        ap++;
 5f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fb:	eb 45                	jmp    642 <printf+0x193>
      } else if(c == '%'){
 5fd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 601:	75 17                	jne    61a <printf+0x16b>
        putc(fd, c);
 603:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 606:	0f be c0             	movsbl %al,%eax
 609:	89 44 24 04          	mov    %eax,0x4(%esp)
 60d:	8b 45 08             	mov    0x8(%ebp),%eax
 610:	89 04 24             	mov    %eax,(%esp)
 613:	e8 b7 fd ff ff       	call   3cf <putc>
 618:	eb 28                	jmp    642 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 621:	00 
 622:	8b 45 08             	mov    0x8(%ebp),%eax
 625:	89 04 24             	mov    %eax,(%esp)
 628:	e8 a2 fd ff ff       	call   3cf <putc>
        putc(fd, c);
 62d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 630:	0f be c0             	movsbl %al,%eax
 633:	89 44 24 04          	mov    %eax,0x4(%esp)
 637:	8b 45 08             	mov    0x8(%ebp),%eax
 63a:	89 04 24             	mov    %eax,(%esp)
 63d:	e8 8d fd ff ff       	call   3cf <putc>
      }
      state = 0;
 642:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 649:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 64d:	8b 55 0c             	mov    0xc(%ebp),%edx
 650:	8b 45 f0             	mov    -0x10(%ebp),%eax
 653:	01 d0                	add    %edx,%eax
 655:	0f b6 00             	movzbl (%eax),%eax
 658:	84 c0                	test   %al,%al
 65a:	0f 85 71 fe ff ff    	jne    4d1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 660:	c9                   	leave  
 661:	c3                   	ret    

00000662 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 662:	55                   	push   %ebp
 663:	89 e5                	mov    %esp,%ebp
 665:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 668:	8b 45 08             	mov    0x8(%ebp),%eax
 66b:	83 e8 08             	sub    $0x8,%eax
 66e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	a1 18 0e 00 00       	mov    0xe18,%eax
 676:	89 45 fc             	mov    %eax,-0x4(%ebp)
 679:	eb 24                	jmp    69f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	8b 00                	mov    (%eax),%eax
 680:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 683:	77 12                	ja     697 <free+0x35>
 685:	8b 45 f8             	mov    -0x8(%ebp),%eax
 688:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68b:	77 24                	ja     6b1 <free+0x4f>
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 695:	77 1a                	ja     6b1 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a5:	76 d4                	jbe    67b <free+0x19>
 6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6af:	76 ca                	jbe    67b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	8b 40 04             	mov    0x4(%eax),%eax
 6b7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	01 c2                	add    %eax,%edx
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	8b 00                	mov    (%eax),%eax
 6c8:	39 c2                	cmp    %eax,%edx
 6ca:	75 24                	jne    6f0 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cf:	8b 50 04             	mov    0x4(%eax),%edx
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	8b 00                	mov    (%eax),%eax
 6d7:	8b 40 04             	mov    0x4(%eax),%eax
 6da:	01 c2                	add    %eax,%edx
 6dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6df:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 00                	mov    (%eax),%eax
 6e7:	8b 10                	mov    (%eax),%edx
 6e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ec:	89 10                	mov    %edx,(%eax)
 6ee:	eb 0a                	jmp    6fa <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 10                	mov    (%eax),%edx
 6f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fd:	8b 40 04             	mov    0x4(%eax),%eax
 700:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 707:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70a:	01 d0                	add    %edx,%eax
 70c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70f:	75 20                	jne    731 <free+0xcf>
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
 72f:	eb 08                	jmp    739 <free+0xd7>
  } else
    p->s.ptr = bp;
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 55 f8             	mov    -0x8(%ebp),%edx
 737:	89 10                	mov    %edx,(%eax)
  freep = p;
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	a3 18 0e 00 00       	mov    %eax,0xe18
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
 762:	e8 f0 fb ff ff       	call   357 <sbrk>
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
 78f:	e8 ce fe ff ff       	call   662 <free>
  return freep;
 794:	a1 18 0e 00 00       	mov    0xe18,%eax
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
 7b0:	a1 18 0e 00 00       	mov    0xe18,%eax
 7b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7bc:	75 23                	jne    7e1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7be:	c7 45 f0 10 0e 00 00 	movl   $0xe10,-0x10(%ebp)
 7c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c8:	a3 18 0e 00 00       	mov    %eax,0xe18
 7cd:	a1 18 0e 00 00       	mov    0xe18,%eax
 7d2:	a3 10 0e 00 00       	mov    %eax,0xe10
    base.s.size = 0;
 7d7:	c7 05 14 0e 00 00 00 	movl   $0x0,0xe14
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
 811:	2b 45 ec             	sub    -0x14(%ebp),%eax
 814:	89 c2                	mov    %eax,%edx
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
 834:	a3 18 0e 00 00       	mov    %eax,0xe18
      return (void*)(p + 1);
 839:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83c:	83 c0 08             	add    $0x8,%eax
 83f:	eb 38                	jmp    879 <malloc+0xde>
    }
    if(p == freep)
 841:	a1 18 0e 00 00       	mov    0xe18,%eax
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

0000087b <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 87b:	55                   	push   %ebp
 87c:	89 e5                	mov    %esp,%ebp
 87e:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 881:	8b 45 0c             	mov    0xc(%ebp),%eax
 884:	89 04 24             	mov    %eax,(%esp)
 887:	8b 45 08             	mov    0x8(%ebp),%eax
 88a:	ff d0                	call   *%eax
    exit();
 88c:	e8 3e fa ff ff       	call   2cf <exit>

00000891 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 891:	55                   	push   %ebp
 892:	89 e5                	mov    %esp,%ebp
 894:	57                   	push   %edi
 895:	56                   	push   %esi
 896:	53                   	push   %ebx
 897:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 89a:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8a1:	e8 f5 fe ff ff       	call   79b <malloc>
 8a6:	8b 55 08             	mov    0x8(%ebp),%edx
 8a9:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8ab:	8b 45 10             	mov    0x10(%ebp),%eax
 8ae:	8b 38                	mov    (%eax),%edi
 8b0:	8b 75 0c             	mov    0xc(%ebp),%esi
 8b3:	bb 7b 08 00 00       	mov    $0x87b,%ebx
 8b8:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8bf:	e8 d7 fe ff ff       	call   79b <malloc>
 8c4:	05 00 10 00 00       	add    $0x1000,%eax
 8c9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8cd:	89 74 24 08          	mov    %esi,0x8(%esp)
 8d1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8d5:	89 04 24             	mov    %eax,(%esp)
 8d8:	e8 92 fa ff ff       	call   36f <kthread_create>
 8dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 8e0:	8b 45 08             	mov    0x8(%ebp),%eax
 8e3:	8b 00                	mov    (%eax),%eax
 8e5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8e8:	89 10                	mov    %edx,(%eax)
    return t_id;
 8ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8ed:	83 c4 2c             	add    $0x2c,%esp
 8f0:	5b                   	pop    %ebx
 8f1:	5e                   	pop    %esi
 8f2:	5f                   	pop    %edi
 8f3:	5d                   	pop    %ebp
 8f4:	c3                   	ret    

000008f5 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8f5:	55                   	push   %ebp
 8f6:	89 e5                	mov    %esp,%ebp
 8f8:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 8fb:	8b 55 0c             	mov    0xc(%ebp),%edx
 8fe:	8b 45 08             	mov    0x8(%ebp),%eax
 901:	8b 00                	mov    (%eax),%eax
 903:	89 54 24 04          	mov    %edx,0x4(%esp)
 907:	89 04 24             	mov    %eax,(%esp)
 90a:	e8 68 fa ff ff       	call   377 <kthread_join>
 90f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 912:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 915:	c9                   	leave  
 916:	c3                   	ret    

00000917 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 917:	55                   	push   %ebp
 918:	89 e5                	mov    %esp,%ebp
 91a:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 91d:	e8 5d fa ff ff       	call   37f <kthread_mutex_init>
 922:	8b 55 08             	mov    0x8(%ebp),%edx
 925:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 927:	8b 45 08             	mov    0x8(%ebp),%eax
 92a:	8b 00                	mov    (%eax),%eax
 92c:	85 c0                	test   %eax,%eax
 92e:	7e 07                	jle    937 <qthread_mutex_init+0x20>
		return 0;
 930:	b8 00 00 00 00       	mov    $0x0,%eax
 935:	eb 05                	jmp    93c <qthread_mutex_init+0x25>
	}
	return *mutex;
 937:	8b 45 08             	mov    0x8(%ebp),%eax
 93a:	8b 00                	mov    (%eax),%eax
}
 93c:	c9                   	leave  
 93d:	c3                   	ret    

0000093e <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 93e:	55                   	push   %ebp
 93f:	89 e5                	mov    %esp,%ebp
 941:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 944:	8b 45 08             	mov    0x8(%ebp),%eax
 947:	89 04 24             	mov    %eax,(%esp)
 94a:	e8 38 fa ff ff       	call   387 <kthread_mutex_destroy>
 94f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 952:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 956:	79 07                	jns    95f <qthread_mutex_destroy+0x21>
    	return -1;
 958:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 95d:	eb 05                	jmp    964 <qthread_mutex_destroy+0x26>
    }
    return 0;
 95f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 964:	c9                   	leave  
 965:	c3                   	ret    

00000966 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 966:	55                   	push   %ebp
 967:	89 e5                	mov    %esp,%ebp
 969:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 96c:	8b 45 08             	mov    0x8(%ebp),%eax
 96f:	89 04 24             	mov    %eax,(%esp)
 972:	e8 18 fa ff ff       	call   38f <kthread_mutex_lock>
 977:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 97a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 97e:	79 07                	jns    987 <qthread_mutex_lock+0x21>
    	return -1;
 980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 985:	eb 05                	jmp    98c <qthread_mutex_lock+0x26>
    }
    return 0;
 987:	b8 00 00 00 00       	mov    $0x0,%eax
}
 98c:	c9                   	leave  
 98d:	c3                   	ret    

0000098e <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 98e:	55                   	push   %ebp
 98f:	89 e5                	mov    %esp,%ebp
 991:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 994:	8b 45 08             	mov    0x8(%ebp),%eax
 997:	89 04 24             	mov    %eax,(%esp)
 99a:	e8 f8 f9 ff ff       	call   397 <kthread_mutex_unlock>
 99f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a6:	79 07                	jns    9af <qthread_mutex_unlock+0x21>
    	return -1;
 9a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9ad:	eb 05                	jmp    9b4 <qthread_mutex_unlock+0x26>
    }
    return 0;
 9af:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b4:	c9                   	leave  
 9b5:	c3                   	ret    

000009b6 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9b6:	55                   	push   %ebp
 9b7:	89 e5                	mov    %esp,%ebp

	return 0;
 9b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9be:	5d                   	pop    %ebp
 9bf:	c3                   	ret    

000009c0 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c8:	5d                   	pop    %ebp
 9c9:	c3                   	ret    

000009ca <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9ca:	55                   	push   %ebp
 9cb:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d2:	5d                   	pop    %ebp
 9d3:	c3                   	ret    

000009d4 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9d4:	55                   	push   %ebp
 9d5:	89 e5                	mov    %esp,%ebp
	return 0;
 9d7:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9dc:	5d                   	pop    %ebp
 9dd:	c3                   	ret    

000009de <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9de:	55                   	push   %ebp
 9df:	89 e5                	mov    %esp,%ebp
	return 0;
 9e1:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9e6:	5d                   	pop    %ebp
 9e7:	c3                   	ret    

000009e8 <qthread_exit>:

int qthread_exit(){
 9e8:	55                   	push   %ebp
 9e9:	89 e5                	mov    %esp,%ebp
	return 0;
 9eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f0:	5d                   	pop    %ebp
 9f1:	c3                   	ret    
