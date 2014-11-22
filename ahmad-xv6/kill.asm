
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
   f:	c7 44 24 04 e0 09 00 	movl   $0x9e0,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 84 04 00 00       	call   4a7 <printf>
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
 3bf:	b8 20 00 00 00       	mov    $0x20,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c7:	55                   	push   %ebp
 3c8:	89 e5                	mov    %esp,%ebp
 3ca:	83 ec 18             	sub    $0x18,%esp
 3cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3da:	00 
 3db:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3de:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e2:	8b 45 08             	mov    0x8(%ebp),%eax
 3e5:	89 04 24             	mov    %eax,(%esp)
 3e8:	e8 02 ff ff ff       	call   2ef <write>
}
 3ed:	c9                   	leave  
 3ee:	c3                   	ret    

000003ef <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ef:	55                   	push   %ebp
 3f0:	89 e5                	mov    %esp,%ebp
 3f2:	56                   	push   %esi
 3f3:	53                   	push   %ebx
 3f4:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3fe:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 402:	74 17                	je     41b <printint+0x2c>
 404:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 408:	79 11                	jns    41b <printint+0x2c>
    neg = 1;
 40a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 411:	8b 45 0c             	mov    0xc(%ebp),%eax
 414:	f7 d8                	neg    %eax
 416:	89 45 ec             	mov    %eax,-0x14(%ebp)
 419:	eb 06                	jmp    421 <printint+0x32>
  } else {
    x = xx;
 41b:	8b 45 0c             	mov    0xc(%ebp),%eax
 41e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 421:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 428:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 42b:	8d 41 01             	lea    0x1(%ecx),%eax
 42e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 431:	8b 5d 10             	mov    0x10(%ebp),%ebx
 434:	8b 45 ec             	mov    -0x14(%ebp),%eax
 437:	ba 00 00 00 00       	mov    $0x0,%edx
 43c:	f7 f3                	div    %ebx
 43e:	89 d0                	mov    %edx,%eax
 440:	0f b6 80 c8 0d 00 00 	movzbl 0xdc8(%eax),%eax
 447:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 44b:	8b 75 10             	mov    0x10(%ebp),%esi
 44e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 451:	ba 00 00 00 00       	mov    $0x0,%edx
 456:	f7 f6                	div    %esi
 458:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45f:	75 c7                	jne    428 <printint+0x39>
  if(neg)
 461:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 465:	74 10                	je     477 <printint+0x88>
    buf[i++] = '-';
 467:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46a:	8d 50 01             	lea    0x1(%eax),%edx
 46d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 470:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 475:	eb 1f                	jmp    496 <printint+0xa7>
 477:	eb 1d                	jmp    496 <printint+0xa7>
    putc(fd, buf[i]);
 479:	8d 55 dc             	lea    -0x24(%ebp),%edx
 47c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 47f:	01 d0                	add    %edx,%eax
 481:	0f b6 00             	movzbl (%eax),%eax
 484:	0f be c0             	movsbl %al,%eax
 487:	89 44 24 04          	mov    %eax,0x4(%esp)
 48b:	8b 45 08             	mov    0x8(%ebp),%eax
 48e:	89 04 24             	mov    %eax,(%esp)
 491:	e8 31 ff ff ff       	call   3c7 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 496:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49e:	79 d9                	jns    479 <printint+0x8a>
    putc(fd, buf[i]);
}
 4a0:	83 c4 30             	add    $0x30,%esp
 4a3:	5b                   	pop    %ebx
 4a4:	5e                   	pop    %esi
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret    

000004a7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a7:	55                   	push   %ebp
 4a8:	89 e5                	mov    %esp,%ebp
 4aa:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b7:	83 c0 04             	add    $0x4,%eax
 4ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c4:	e9 7c 01 00 00       	jmp    645 <printf+0x19e>
    c = fmt[i] & 0xff;
 4c9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4cf:	01 d0                	add    %edx,%eax
 4d1:	0f b6 00             	movzbl (%eax),%eax
 4d4:	0f be c0             	movsbl %al,%eax
 4d7:	25 ff 00 00 00       	and    $0xff,%eax
 4dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4df:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e3:	75 2c                	jne    511 <printf+0x6a>
      if(c == '%'){
 4e5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e9:	75 0c                	jne    4f7 <printf+0x50>
        state = '%';
 4eb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f2:	e9 4a 01 00 00       	jmp    641 <printf+0x19a>
      } else {
        putc(fd, c);
 4f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fa:	0f be c0             	movsbl %al,%eax
 4fd:	89 44 24 04          	mov    %eax,0x4(%esp)
 501:	8b 45 08             	mov    0x8(%ebp),%eax
 504:	89 04 24             	mov    %eax,(%esp)
 507:	e8 bb fe ff ff       	call   3c7 <putc>
 50c:	e9 30 01 00 00       	jmp    641 <printf+0x19a>
      }
    } else if(state == '%'){
 511:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 515:	0f 85 26 01 00 00    	jne    641 <printf+0x19a>
      if(c == 'd'){
 51b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 51f:	75 2d                	jne    54e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 521:	8b 45 e8             	mov    -0x18(%ebp),%eax
 524:	8b 00                	mov    (%eax),%eax
 526:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 52d:	00 
 52e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 535:	00 
 536:	89 44 24 04          	mov    %eax,0x4(%esp)
 53a:	8b 45 08             	mov    0x8(%ebp),%eax
 53d:	89 04 24             	mov    %eax,(%esp)
 540:	e8 aa fe ff ff       	call   3ef <printint>
        ap++;
 545:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 549:	e9 ec 00 00 00       	jmp    63a <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 54e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 552:	74 06                	je     55a <printf+0xb3>
 554:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 558:	75 2d                	jne    587 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 55a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55d:	8b 00                	mov    (%eax),%eax
 55f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 566:	00 
 567:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 56e:	00 
 56f:	89 44 24 04          	mov    %eax,0x4(%esp)
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	89 04 24             	mov    %eax,(%esp)
 579:	e8 71 fe ff ff       	call   3ef <printint>
        ap++;
 57e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 582:	e9 b3 00 00 00       	jmp    63a <printf+0x193>
      } else if(c == 's'){
 587:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 58b:	75 45                	jne    5d2 <printf+0x12b>
        s = (char*)*ap;
 58d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 590:	8b 00                	mov    (%eax),%eax
 592:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 595:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 599:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59d:	75 09                	jne    5a8 <printf+0x101>
          s = "(null)";
 59f:	c7 45 f4 f4 09 00 00 	movl   $0x9f4,-0xc(%ebp)
        while(*s != 0){
 5a6:	eb 1e                	jmp    5c6 <printf+0x11f>
 5a8:	eb 1c                	jmp    5c6 <printf+0x11f>
          putc(fd, *s);
 5aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ad:	0f b6 00             	movzbl (%eax),%eax
 5b0:	0f be c0             	movsbl %al,%eax
 5b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	89 04 24             	mov    %eax,(%esp)
 5bd:	e8 05 fe ff ff       	call   3c7 <putc>
          s++;
 5c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c9:	0f b6 00             	movzbl (%eax),%eax
 5cc:	84 c0                	test   %al,%al
 5ce:	75 da                	jne    5aa <printf+0x103>
 5d0:	eb 68                	jmp    63a <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d6:	75 1d                	jne    5f5 <printf+0x14e>
        putc(fd, *ap);
 5d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5db:	8b 00                	mov    (%eax),%eax
 5dd:	0f be c0             	movsbl %al,%eax
 5e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e4:	8b 45 08             	mov    0x8(%ebp),%eax
 5e7:	89 04 24             	mov    %eax,(%esp)
 5ea:	e8 d8 fd ff ff       	call   3c7 <putc>
        ap++;
 5ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f3:	eb 45                	jmp    63a <printf+0x193>
      } else if(c == '%'){
 5f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f9:	75 17                	jne    612 <printf+0x16b>
        putc(fd, c);
 5fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fe:	0f be c0             	movsbl %al,%eax
 601:	89 44 24 04          	mov    %eax,0x4(%esp)
 605:	8b 45 08             	mov    0x8(%ebp),%eax
 608:	89 04 24             	mov    %eax,(%esp)
 60b:	e8 b7 fd ff ff       	call   3c7 <putc>
 610:	eb 28                	jmp    63a <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 612:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 619:	00 
 61a:	8b 45 08             	mov    0x8(%ebp),%eax
 61d:	89 04 24             	mov    %eax,(%esp)
 620:	e8 a2 fd ff ff       	call   3c7 <putc>
        putc(fd, c);
 625:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 628:	0f be c0             	movsbl %al,%eax
 62b:	89 44 24 04          	mov    %eax,0x4(%esp)
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	89 04 24             	mov    %eax,(%esp)
 635:	e8 8d fd ff ff       	call   3c7 <putc>
      }
      state = 0;
 63a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 641:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 645:	8b 55 0c             	mov    0xc(%ebp),%edx
 648:	8b 45 f0             	mov    -0x10(%ebp),%eax
 64b:	01 d0                	add    %edx,%eax
 64d:	0f b6 00             	movzbl (%eax),%eax
 650:	84 c0                	test   %al,%al
 652:	0f 85 71 fe ff ff    	jne    4c9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 658:	c9                   	leave  
 659:	c3                   	ret    

0000065a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 65a:	55                   	push   %ebp
 65b:	89 e5                	mov    %esp,%ebp
 65d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 660:	8b 45 08             	mov    0x8(%ebp),%eax
 663:	83 e8 08             	sub    $0x8,%eax
 666:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 669:	a1 e4 0d 00 00       	mov    0xde4,%eax
 66e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 671:	eb 24                	jmp    697 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	8b 00                	mov    (%eax),%eax
 678:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67b:	77 12                	ja     68f <free+0x35>
 67d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 680:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 683:	77 24                	ja     6a9 <free+0x4f>
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 00                	mov    (%eax),%eax
 68a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68d:	77 1a                	ja     6a9 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	8b 00                	mov    (%eax),%eax
 694:	89 45 fc             	mov    %eax,-0x4(%ebp)
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69d:	76 d4                	jbe    673 <free+0x19>
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 00                	mov    (%eax),%eax
 6a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a7:	76 ca                	jbe    673 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ac:	8b 40 04             	mov    0x4(%eax),%eax
 6af:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	01 c2                	add    %eax,%edx
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	8b 00                	mov    (%eax),%eax
 6c0:	39 c2                	cmp    %eax,%edx
 6c2:	75 24                	jne    6e8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c7:	8b 50 04             	mov    0x4(%eax),%edx
 6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cd:	8b 00                	mov    (%eax),%eax
 6cf:	8b 40 04             	mov    0x4(%eax),%eax
 6d2:	01 c2                	add    %eax,%edx
 6d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 00                	mov    (%eax),%eax
 6df:	8b 10                	mov    (%eax),%edx
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	89 10                	mov    %edx,(%eax)
 6e6:	eb 0a                	jmp    6f2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	8b 10                	mov    (%eax),%edx
 6ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 40 04             	mov    0x4(%eax),%eax
 6f8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	01 d0                	add    %edx,%eax
 704:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 707:	75 20                	jne    729 <free+0xcf>
    p->s.size += bp->s.size;
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 50 04             	mov    0x4(%eax),%edx
 70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 712:	8b 40 04             	mov    0x4(%eax),%eax
 715:	01 c2                	add    %eax,%edx
 717:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 720:	8b 10                	mov    (%eax),%edx
 722:	8b 45 fc             	mov    -0x4(%ebp),%eax
 725:	89 10                	mov    %edx,(%eax)
 727:	eb 08                	jmp    731 <free+0xd7>
  } else
    p->s.ptr = bp;
 729:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 72f:	89 10                	mov    %edx,(%eax)
  freep = p;
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	a3 e4 0d 00 00       	mov    %eax,0xde4
}
 739:	c9                   	leave  
 73a:	c3                   	ret    

0000073b <morecore>:

static Header*
morecore(uint nu)
{
 73b:	55                   	push   %ebp
 73c:	89 e5                	mov    %esp,%ebp
 73e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 741:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 748:	77 07                	ja     751 <morecore+0x16>
    nu = 4096;
 74a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 751:	8b 45 08             	mov    0x8(%ebp),%eax
 754:	c1 e0 03             	shl    $0x3,%eax
 757:	89 04 24             	mov    %eax,(%esp)
 75a:	e8 f8 fb ff ff       	call   357 <sbrk>
 75f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 762:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 766:	75 07                	jne    76f <morecore+0x34>
    return 0;
 768:	b8 00 00 00 00       	mov    $0x0,%eax
 76d:	eb 22                	jmp    791 <morecore+0x56>
  hp = (Header*)p;
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	8b 55 08             	mov    0x8(%ebp),%edx
 77b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 77e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 781:	83 c0 08             	add    $0x8,%eax
 784:	89 04 24             	mov    %eax,(%esp)
 787:	e8 ce fe ff ff       	call   65a <free>
  return freep;
 78c:	a1 e4 0d 00 00       	mov    0xde4,%eax
}
 791:	c9                   	leave  
 792:	c3                   	ret    

00000793 <malloc>:

void*
malloc(uint nbytes)
{
 793:	55                   	push   %ebp
 794:	89 e5                	mov    %esp,%ebp
 796:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
 79c:	83 c0 07             	add    $0x7,%eax
 79f:	c1 e8 03             	shr    $0x3,%eax
 7a2:	83 c0 01             	add    $0x1,%eax
 7a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7a8:	a1 e4 0d 00 00       	mov    0xde4,%eax
 7ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7b4:	75 23                	jne    7d9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7b6:	c7 45 f0 dc 0d 00 00 	movl   $0xddc,-0x10(%ebp)
 7bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c0:	a3 e4 0d 00 00       	mov    %eax,0xde4
 7c5:	a1 e4 0d 00 00       	mov    0xde4,%eax
 7ca:	a3 dc 0d 00 00       	mov    %eax,0xddc
    base.s.size = 0;
 7cf:	c7 05 e0 0d 00 00 00 	movl   $0x0,0xde0
 7d6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e4:	8b 40 04             	mov    0x4(%eax),%eax
 7e7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ea:	72 4d                	jb     839 <malloc+0xa6>
      if(p->s.size == nunits)
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 40 04             	mov    0x4(%eax),%eax
 7f2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f5:	75 0c                	jne    803 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	8b 10                	mov    (%eax),%edx
 7fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ff:	89 10                	mov    %edx,(%eax)
 801:	eb 26                	jmp    829 <malloc+0x96>
      else {
        p->s.size -= nunits;
 803:	8b 45 f4             	mov    -0xc(%ebp),%eax
 806:	8b 40 04             	mov    0x4(%eax),%eax
 809:	2b 45 ec             	sub    -0x14(%ebp),%eax
 80c:	89 c2                	mov    %eax,%edx
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 40 04             	mov    0x4(%eax),%eax
 81a:	c1 e0 03             	shl    $0x3,%eax
 81d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 820:	8b 45 f4             	mov    -0xc(%ebp),%eax
 823:	8b 55 ec             	mov    -0x14(%ebp),%edx
 826:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 829:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82c:	a3 e4 0d 00 00       	mov    %eax,0xde4
      return (void*)(p + 1);
 831:	8b 45 f4             	mov    -0xc(%ebp),%eax
 834:	83 c0 08             	add    $0x8,%eax
 837:	eb 38                	jmp    871 <malloc+0xde>
    }
    if(p == freep)
 839:	a1 e4 0d 00 00       	mov    0xde4,%eax
 83e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 841:	75 1b                	jne    85e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 843:	8b 45 ec             	mov    -0x14(%ebp),%eax
 846:	89 04 24             	mov    %eax,(%esp)
 849:	e8 ed fe ff ff       	call   73b <morecore>
 84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 851:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 855:	75 07                	jne    85e <malloc+0xcb>
        return 0;
 857:	b8 00 00 00 00       	mov    $0x0,%eax
 85c:	eb 13                	jmp    871 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 861:	89 45 f0             	mov    %eax,-0x10(%ebp)
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	8b 00                	mov    (%eax),%eax
 869:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 86c:	e9 70 ff ff ff       	jmp    7e1 <malloc+0x4e>
}
 871:	c9                   	leave  
 872:	c3                   	ret    

00000873 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 873:	55                   	push   %ebp
 874:	89 e5                	mov    %esp,%ebp
 876:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 879:	8b 45 0c             	mov    0xc(%ebp),%eax
 87c:	89 04 24             	mov    %eax,(%esp)
 87f:	8b 45 08             	mov    0x8(%ebp),%eax
 882:	ff d0                	call   *%eax
    exit();
 884:	e8 46 fa ff ff       	call   2cf <exit>

00000889 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 889:	55                   	push   %ebp
 88a:	89 e5                	mov    %esp,%ebp
 88c:	57                   	push   %edi
 88d:	56                   	push   %esi
 88e:	53                   	push   %ebx
 88f:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 892:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 899:	e8 f5 fe ff ff       	call   793 <malloc>
 89e:	8b 55 08             	mov    0x8(%ebp),%edx
 8a1:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8a3:	8b 45 10             	mov    0x10(%ebp),%eax
 8a6:	8b 38                	mov    (%eax),%edi
 8a8:	8b 75 0c             	mov    0xc(%ebp),%esi
 8ab:	bb 73 08 00 00       	mov    $0x873,%ebx
 8b0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8b7:	e8 d7 fe ff ff       	call   793 <malloc>
 8bc:	05 00 10 00 00       	add    $0x1000,%eax
 8c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8c5:	89 74 24 08          	mov    %esi,0x8(%esp)
 8c9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8cd:	89 04 24             	mov    %eax,(%esp)
 8d0:	e8 9a fa ff ff       	call   36f <kthread_create>
 8d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 8d8:	8b 45 08             	mov    0x8(%ebp),%eax
 8db:	8b 00                	mov    (%eax),%eax
 8dd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8e0:	89 10                	mov    %edx,(%eax)
    return t_id;
 8e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8e5:	83 c4 2c             	add    $0x2c,%esp
 8e8:	5b                   	pop    %ebx
 8e9:	5e                   	pop    %esi
 8ea:	5f                   	pop    %edi
 8eb:	5d                   	pop    %ebp
 8ec:	c3                   	ret    

000008ed <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8ed:	55                   	push   %ebp
 8ee:	89 e5                	mov    %esp,%ebp
 8f0:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 8f3:	8b 55 0c             	mov    0xc(%ebp),%edx
 8f6:	8b 45 08             	mov    0x8(%ebp),%eax
 8f9:	8b 00                	mov    (%eax),%eax
 8fb:	89 54 24 04          	mov    %edx,0x4(%esp)
 8ff:	89 04 24             	mov    %eax,(%esp)
 902:	e8 70 fa ff ff       	call   377 <kthread_join>
 907:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 90d:	c9                   	leave  
 90e:	c3                   	ret    

0000090f <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 90f:	55                   	push   %ebp
 910:	89 e5                	mov    %esp,%ebp
 912:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 915:	e8 65 fa ff ff       	call   37f <kthread_mutex_init>
 91a:	8b 55 08             	mov    0x8(%ebp),%edx
 91d:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 91f:	8b 45 08             	mov    0x8(%ebp),%eax
 922:	8b 00                	mov    (%eax),%eax
 924:	85 c0                	test   %eax,%eax
 926:	7e 07                	jle    92f <qthread_mutex_init+0x20>
		return 0;
 928:	b8 00 00 00 00       	mov    $0x0,%eax
 92d:	eb 05                	jmp    934 <qthread_mutex_init+0x25>
	}
	return *mutex;
 92f:	8b 45 08             	mov    0x8(%ebp),%eax
 932:	8b 00                	mov    (%eax),%eax
}
 934:	c9                   	leave  
 935:	c3                   	ret    

00000936 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 936:	55                   	push   %ebp
 937:	89 e5                	mov    %esp,%ebp
 939:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 93c:	8b 45 08             	mov    0x8(%ebp),%eax
 93f:	89 04 24             	mov    %eax,(%esp)
 942:	e8 40 fa ff ff       	call   387 <kthread_mutex_destroy>
 947:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 94a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 94e:	79 07                	jns    957 <qthread_mutex_destroy+0x21>
    	return -1;
 950:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 955:	eb 05                	jmp    95c <qthread_mutex_destroy+0x26>
    }
    return 0;
 957:	b8 00 00 00 00       	mov    $0x0,%eax
}
 95c:	c9                   	leave  
 95d:	c3                   	ret    

0000095e <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 95e:	55                   	push   %ebp
 95f:	89 e5                	mov    %esp,%ebp
 961:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 964:	8b 45 08             	mov    0x8(%ebp),%eax
 967:	89 04 24             	mov    %eax,(%esp)
 96a:	e8 20 fa ff ff       	call   38f <kthread_mutex_lock>
 96f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 972:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 976:	79 07                	jns    97f <qthread_mutex_lock+0x21>
    	return -1;
 978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 97d:	eb 05                	jmp    984 <qthread_mutex_lock+0x26>
    }
    return 0;
 97f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 984:	c9                   	leave  
 985:	c3                   	ret    

00000986 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 986:	55                   	push   %ebp
 987:	89 e5                	mov    %esp,%ebp
 989:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 98c:	8b 45 08             	mov    0x8(%ebp),%eax
 98f:	89 04 24             	mov    %eax,(%esp)
 992:	e8 00 fa ff ff       	call   397 <kthread_mutex_unlock>
 997:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 99a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99e:	79 07                	jns    9a7 <qthread_mutex_unlock+0x21>
    	return -1;
 9a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9a5:	eb 05                	jmp    9ac <qthread_mutex_unlock+0x26>
    }
    return 0;
 9a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9ac:	c9                   	leave  
 9ad:	c3                   	ret    

000009ae <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9ae:	55                   	push   %ebp
 9af:	89 e5                	mov    %esp,%ebp

	return 0;
 9b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b6:	5d                   	pop    %ebp
 9b7:	c3                   	ret    

000009b8 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9b8:	55                   	push   %ebp
 9b9:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c0:	5d                   	pop    %ebp
 9c1:	c3                   	ret    

000009c2 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9c2:	55                   	push   %ebp
 9c3:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9ca:	5d                   	pop    %ebp
 9cb:	c3                   	ret    

000009cc <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9cc:	55                   	push   %ebp
 9cd:	89 e5                	mov    %esp,%ebp
	return 0;
 9cf:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9d4:	5d                   	pop    %ebp
 9d5:	c3                   	ret    

000009d6 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9d6:	55                   	push   %ebp
 9d7:	89 e5                	mov    %esp,%ebp
	return 0;
 9d9:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9de:	5d                   	pop    %ebp
 9df:	c3                   	ret    
