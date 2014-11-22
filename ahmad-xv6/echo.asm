
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
  11:	eb 4b                	jmp    5e <main+0x5e>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  13:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  17:	83 c0 01             	add    $0x1,%eax
  1a:	3b 45 08             	cmp    0x8(%ebp),%eax
  1d:	7d 07                	jge    26 <main+0x26>
  1f:	b8 e5 09 00 00       	mov    $0x9e5,%eax
  24:	eb 05                	jmp    2b <main+0x2b>
  26:	b8 e7 09 00 00       	mov    $0x9e7,%eax
  2b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  2f:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  36:	8b 55 0c             	mov    0xc(%ebp),%edx
  39:	01 ca                	add    %ecx,%edx
  3b:	8b 12                	mov    (%edx),%edx
  3d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  41:	89 54 24 08          	mov    %edx,0x8(%esp)
  45:	c7 44 24 04 e9 09 00 	movl   $0x9e9,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  54:	e8 53 04 00 00       	call   4ac <printf>
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  59:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  5e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  62:	3b 45 08             	cmp    0x8(%ebp),%eax
  65:	7c ac                	jl     13 <main+0x13>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  67:	e8 68 02 00 00       	call   2d4 <exit>

0000006c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  6c:	55                   	push   %ebp
  6d:	89 e5                	mov    %esp,%ebp
  6f:	57                   	push   %edi
  70:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  71:	8b 4d 08             	mov    0x8(%ebp),%ecx
  74:	8b 55 10             	mov    0x10(%ebp),%edx
  77:	8b 45 0c             	mov    0xc(%ebp),%eax
  7a:	89 cb                	mov    %ecx,%ebx
  7c:	89 df                	mov    %ebx,%edi
  7e:	89 d1                	mov    %edx,%ecx
  80:	fc                   	cld    
  81:	f3 aa                	rep stos %al,%es:(%edi)
  83:	89 ca                	mov    %ecx,%edx
  85:	89 fb                	mov    %edi,%ebx
  87:	89 5d 08             	mov    %ebx,0x8(%ebp)
  8a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  8d:	5b                   	pop    %ebx
  8e:	5f                   	pop    %edi
  8f:	5d                   	pop    %ebp
  90:	c3                   	ret    

00000091 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  91:	55                   	push   %ebp
  92:	89 e5                	mov    %esp,%ebp
  94:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  97:	8b 45 08             	mov    0x8(%ebp),%eax
  9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  9d:	90                   	nop
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	8d 50 01             	lea    0x1(%eax),%edx
  a4:	89 55 08             	mov    %edx,0x8(%ebp)
  a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  aa:	8d 4a 01             	lea    0x1(%edx),%ecx
  ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b0:	0f b6 12             	movzbl (%edx),%edx
  b3:	88 10                	mov    %dl,(%eax)
  b5:	0f b6 00             	movzbl (%eax),%eax
  b8:	84 c0                	test   %al,%al
  ba:	75 e2                	jne    9e <strcpy+0xd>
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
  fa:	29 c2                	sub    %eax,%edx
  fc:	89 d0                	mov    %edx,%eax
}
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10d:	eb 04                	jmp    113 <strlen+0x13>
 10f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 113:	8b 55 fc             	mov    -0x4(%ebp),%edx
 116:	8b 45 08             	mov    0x8(%ebp),%eax
 119:	01 d0                	add    %edx,%eax
 11b:	0f b6 00             	movzbl (%eax),%eax
 11e:	84 c0                	test   %al,%al
 120:	75 ed                	jne    10f <strlen+0xf>
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
 141:	e8 26 ff ff ff       	call   6c <stosb>
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
 18b:	eb 4c                	jmp    1d9 <gets+0x5b>
    cc = read(0, &c, 1);
 18d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 194:	00 
 195:	8d 45 ef             	lea    -0x11(%ebp),%eax
 198:	89 44 24 04          	mov    %eax,0x4(%esp)
 19c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1a3:	e8 44 01 00 00       	call   2ec <read>
 1a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1af:	7f 02                	jg     1b3 <gets+0x35>
      break;
 1b1:	eb 31                	jmp    1e4 <gets+0x66>
    buf[i++] = c;
 1b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b6:	8d 50 01             	lea    0x1(%eax),%edx
 1b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1bc:	89 c2                	mov    %eax,%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	01 c2                	add    %eax,%edx
 1c3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 13                	je     1e4 <gets+0x66>
 1d1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d5:	3c 0d                	cmp    $0xd,%al
 1d7:	74 0b                	je     1e4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dc:	83 c0 01             	add    $0x1,%eax
 1df:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1e2:	7c a9                	jl     18d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	01 d0                	add    %edx,%eax
 1ec:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f2:	c9                   	leave  
 1f3:	c3                   	ret    

000001f4 <stat>:

int
stat(char *n, struct stat *st)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 201:	00 
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	89 04 24             	mov    %eax,(%esp)
 208:	e8 07 01 00 00       	call   314 <open>
 20d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 210:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 214:	79 07                	jns    21d <stat+0x29>
    return -1;
 216:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 21b:	eb 23                	jmp    240 <stat+0x4c>
  r = fstat(fd, st);
 21d:	8b 45 0c             	mov    0xc(%ebp),%eax
 220:	89 44 24 04          	mov    %eax,0x4(%esp)
 224:	8b 45 f4             	mov    -0xc(%ebp),%eax
 227:	89 04 24             	mov    %eax,(%esp)
 22a:	e8 fd 00 00 00       	call   32c <fstat>
 22f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 232:	8b 45 f4             	mov    -0xc(%ebp),%eax
 235:	89 04 24             	mov    %eax,(%esp)
 238:	e8 bf 00 00 00       	call   2fc <close>
  return r;
 23d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 240:	c9                   	leave  
 241:	c3                   	ret    

00000242 <atoi>:

int
atoi(const char *s)
{
 242:	55                   	push   %ebp
 243:	89 e5                	mov    %esp,%ebp
 245:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24f:	eb 25                	jmp    276 <atoi+0x34>
    n = n*10 + *s++ - '0';
 251:	8b 55 fc             	mov    -0x4(%ebp),%edx
 254:	89 d0                	mov    %edx,%eax
 256:	c1 e0 02             	shl    $0x2,%eax
 259:	01 d0                	add    %edx,%eax
 25b:	01 c0                	add    %eax,%eax
 25d:	89 c1                	mov    %eax,%ecx
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
 262:	8d 50 01             	lea    0x1(%eax),%edx
 265:	89 55 08             	mov    %edx,0x8(%ebp)
 268:	0f b6 00             	movzbl (%eax),%eax
 26b:	0f be c0             	movsbl %al,%eax
 26e:	01 c8                	add    %ecx,%eax
 270:	83 e8 30             	sub    $0x30,%eax
 273:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	0f b6 00             	movzbl (%eax),%eax
 27c:	3c 2f                	cmp    $0x2f,%al
 27e:	7e 0a                	jle    28a <atoi+0x48>
 280:	8b 45 08             	mov    0x8(%ebp),%eax
 283:	0f b6 00             	movzbl (%eax),%eax
 286:	3c 39                	cmp    $0x39,%al
 288:	7e c7                	jle    251 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 28a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 28d:	c9                   	leave  
 28e:	c3                   	ret    

0000028f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28f:	55                   	push   %ebp
 290:	89 e5                	mov    %esp,%ebp
 292:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 295:	8b 45 08             	mov    0x8(%ebp),%eax
 298:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 29b:	8b 45 0c             	mov    0xc(%ebp),%eax
 29e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2a1:	eb 17                	jmp    2ba <memmove+0x2b>
    *dst++ = *src++;
 2a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a6:	8d 50 01             	lea    0x1(%eax),%edx
 2a9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2af:	8d 4a 01             	lea    0x1(%edx),%ecx
 2b2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b5:	0f b6 12             	movzbl (%edx),%edx
 2b8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ba:	8b 45 10             	mov    0x10(%ebp),%eax
 2bd:	8d 50 ff             	lea    -0x1(%eax),%edx
 2c0:	89 55 10             	mov    %edx,0x10(%ebp)
 2c3:	85 c0                	test   %eax,%eax
 2c5:	7f dc                	jg     2a3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ca:	c9                   	leave  
 2cb:	c3                   	ret    

000002cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cc:	b8 01 00 00 00       	mov    $0x1,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <exit>:
SYSCALL(exit)
 2d4:	b8 02 00 00 00       	mov    $0x2,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <wait>:
SYSCALL(wait)
 2dc:	b8 03 00 00 00       	mov    $0x3,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <pipe>:
SYSCALL(pipe)
 2e4:	b8 04 00 00 00       	mov    $0x4,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <read>:
SYSCALL(read)
 2ec:	b8 05 00 00 00       	mov    $0x5,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <write>:
SYSCALL(write)
 2f4:	b8 10 00 00 00       	mov    $0x10,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <close>:
SYSCALL(close)
 2fc:	b8 15 00 00 00       	mov    $0x15,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <kill>:
SYSCALL(kill)
 304:	b8 06 00 00 00       	mov    $0x6,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <exec>:
SYSCALL(exec)
 30c:	b8 07 00 00 00       	mov    $0x7,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <open>:
SYSCALL(open)
 314:	b8 0f 00 00 00       	mov    $0xf,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <mknod>:
SYSCALL(mknod)
 31c:	b8 11 00 00 00       	mov    $0x11,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <unlink>:
SYSCALL(unlink)
 324:	b8 12 00 00 00       	mov    $0x12,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <fstat>:
SYSCALL(fstat)
 32c:	b8 08 00 00 00       	mov    $0x8,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <link>:
SYSCALL(link)
 334:	b8 13 00 00 00       	mov    $0x13,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <mkdir>:
SYSCALL(mkdir)
 33c:	b8 14 00 00 00       	mov    $0x14,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <chdir>:
SYSCALL(chdir)
 344:	b8 09 00 00 00       	mov    $0x9,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <dup>:
SYSCALL(dup)
 34c:	b8 0a 00 00 00       	mov    $0xa,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <getpid>:
SYSCALL(getpid)
 354:	b8 0b 00 00 00       	mov    $0xb,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <sbrk>:
SYSCALL(sbrk)
 35c:	b8 0c 00 00 00       	mov    $0xc,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <sleep>:
SYSCALL(sleep)
 364:	b8 0d 00 00 00       	mov    $0xd,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <uptime>:
SYSCALL(uptime)
 36c:	b8 0e 00 00 00       	mov    $0xe,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <kthread_create>:
SYSCALL(kthread_create)
 374:	b8 17 00 00 00       	mov    $0x17,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <kthread_join>:
SYSCALL(kthread_join)
 37c:	b8 16 00 00 00       	mov    $0x16,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 384:	b8 18 00 00 00       	mov    $0x18,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 38c:	b8 19 00 00 00       	mov    $0x19,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 394:	b8 1a 00 00 00       	mov    $0x1a,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 39c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 3a4:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3ac:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3b4:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3bc:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <kthread_cond_broadcast>:
 3c4:	b8 20 00 00 00       	mov    $0x20,%eax
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
 3cf:	83 ec 18             	sub    $0x18,%esp
 3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3df:	00 
 3e0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ea:	89 04 24             	mov    %eax,(%esp)
 3ed:	e8 02 ff ff ff       	call   2f4 <write>
}
 3f2:	c9                   	leave  
 3f3:	c3                   	ret    

000003f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	56                   	push   %esi
 3f8:	53                   	push   %ebx
 3f9:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 403:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 407:	74 17                	je     420 <printint+0x2c>
 409:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40d:	79 11                	jns    420 <printint+0x2c>
    neg = 1;
 40f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 416:	8b 45 0c             	mov    0xc(%ebp),%eax
 419:	f7 d8                	neg    %eax
 41b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41e:	eb 06                	jmp    426 <printint+0x32>
  } else {
    x = xx;
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 426:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 430:	8d 41 01             	lea    0x1(%ecx),%eax
 433:	89 45 f4             	mov    %eax,-0xc(%ebp)
 436:	8b 5d 10             	mov    0x10(%ebp),%ebx
 439:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43c:	ba 00 00 00 00       	mov    $0x0,%edx
 441:	f7 f3                	div    %ebx
 443:	89 d0                	mov    %edx,%eax
 445:	0f b6 80 c4 0d 00 00 	movzbl 0xdc4(%eax),%eax
 44c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 450:	8b 75 10             	mov    0x10(%ebp),%esi
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 f6                	div    %esi
 45d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 460:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 464:	75 c7                	jne    42d <printint+0x39>
  if(neg)
 466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46a:	74 10                	je     47c <printint+0x88>
    buf[i++] = '-';
 46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46f:	8d 50 01             	lea    0x1(%eax),%edx
 472:	89 55 f4             	mov    %edx,-0xc(%ebp)
 475:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47a:	eb 1f                	jmp    49b <printint+0xa7>
 47c:	eb 1d                	jmp    49b <printint+0xa7>
    putc(fd, buf[i]);
 47e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 481:	8b 45 f4             	mov    -0xc(%ebp),%eax
 484:	01 d0                	add    %edx,%eax
 486:	0f b6 00             	movzbl (%eax),%eax
 489:	0f be c0             	movsbl %al,%eax
 48c:	89 44 24 04          	mov    %eax,0x4(%esp)
 490:	8b 45 08             	mov    0x8(%ebp),%eax
 493:	89 04 24             	mov    %eax,(%esp)
 496:	e8 31 ff ff ff       	call   3cc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 49b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a3:	79 d9                	jns    47e <printint+0x8a>
    putc(fd, buf[i]);
}
 4a5:	83 c4 30             	add    $0x30,%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	5d                   	pop    %ebp
 4ab:	c3                   	ret    

000004ac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4ac:	55                   	push   %ebp
 4ad:	89 e5                	mov    %esp,%ebp
 4af:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b9:	8d 45 0c             	lea    0xc(%ebp),%eax
 4bc:	83 c0 04             	add    $0x4,%eax
 4bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c9:	e9 7c 01 00 00       	jmp    64a <printf+0x19e>
    c = fmt[i] & 0xff;
 4ce:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d4:	01 d0                	add    %edx,%eax
 4d6:	0f b6 00             	movzbl (%eax),%eax
 4d9:	0f be c0             	movsbl %al,%eax
 4dc:	25 ff 00 00 00       	and    $0xff,%eax
 4e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e8:	75 2c                	jne    516 <printf+0x6a>
      if(c == '%'){
 4ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ee:	75 0c                	jne    4fc <printf+0x50>
        state = '%';
 4f0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f7:	e9 4a 01 00 00       	jmp    646 <printf+0x19a>
      } else {
        putc(fd, c);
 4fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ff:	0f be c0             	movsbl %al,%eax
 502:	89 44 24 04          	mov    %eax,0x4(%esp)
 506:	8b 45 08             	mov    0x8(%ebp),%eax
 509:	89 04 24             	mov    %eax,(%esp)
 50c:	e8 bb fe ff ff       	call   3cc <putc>
 511:	e9 30 01 00 00       	jmp    646 <printf+0x19a>
      }
    } else if(state == '%'){
 516:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 51a:	0f 85 26 01 00 00    	jne    646 <printf+0x19a>
      if(c == 'd'){
 520:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 524:	75 2d                	jne    553 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 526:	8b 45 e8             	mov    -0x18(%ebp),%eax
 529:	8b 00                	mov    (%eax),%eax
 52b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 532:	00 
 533:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 53a:	00 
 53b:	89 44 24 04          	mov    %eax,0x4(%esp)
 53f:	8b 45 08             	mov    0x8(%ebp),%eax
 542:	89 04 24             	mov    %eax,(%esp)
 545:	e8 aa fe ff ff       	call   3f4 <printint>
        ap++;
 54a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54e:	e9 ec 00 00 00       	jmp    63f <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 553:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 557:	74 06                	je     55f <printf+0xb3>
 559:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 55d:	75 2d                	jne    58c <printf+0xe0>
        printint(fd, *ap, 16, 0);
 55f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 562:	8b 00                	mov    (%eax),%eax
 564:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 56b:	00 
 56c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 573:	00 
 574:	89 44 24 04          	mov    %eax,0x4(%esp)
 578:	8b 45 08             	mov    0x8(%ebp),%eax
 57b:	89 04 24             	mov    %eax,(%esp)
 57e:	e8 71 fe ff ff       	call   3f4 <printint>
        ap++;
 583:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 587:	e9 b3 00 00 00       	jmp    63f <printf+0x193>
      } else if(c == 's'){
 58c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 590:	75 45                	jne    5d7 <printf+0x12b>
        s = (char*)*ap;
 592:	8b 45 e8             	mov    -0x18(%ebp),%eax
 595:	8b 00                	mov    (%eax),%eax
 597:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 59a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 59e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a2:	75 09                	jne    5ad <printf+0x101>
          s = "(null)";
 5a4:	c7 45 f4 ee 09 00 00 	movl   $0x9ee,-0xc(%ebp)
        while(*s != 0){
 5ab:	eb 1e                	jmp    5cb <printf+0x11f>
 5ad:	eb 1c                	jmp    5cb <printf+0x11f>
          putc(fd, *s);
 5af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b2:	0f b6 00             	movzbl (%eax),%eax
 5b5:	0f be c0             	movsbl %al,%eax
 5b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bc:	8b 45 08             	mov    0x8(%ebp),%eax
 5bf:	89 04 24             	mov    %eax,(%esp)
 5c2:	e8 05 fe ff ff       	call   3cc <putc>
          s++;
 5c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ce:	0f b6 00             	movzbl (%eax),%eax
 5d1:	84 c0                	test   %al,%al
 5d3:	75 da                	jne    5af <printf+0x103>
 5d5:	eb 68                	jmp    63f <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5db:	75 1d                	jne    5fa <printf+0x14e>
        putc(fd, *ap);
 5dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e0:	8b 00                	mov    (%eax),%eax
 5e2:	0f be c0             	movsbl %al,%eax
 5e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ec:	89 04 24             	mov    %eax,(%esp)
 5ef:	e8 d8 fd ff ff       	call   3cc <putc>
        ap++;
 5f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f8:	eb 45                	jmp    63f <printf+0x193>
      } else if(c == '%'){
 5fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5fe:	75 17                	jne    617 <printf+0x16b>
        putc(fd, c);
 600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 603:	0f be c0             	movsbl %al,%eax
 606:	89 44 24 04          	mov    %eax,0x4(%esp)
 60a:	8b 45 08             	mov    0x8(%ebp),%eax
 60d:	89 04 24             	mov    %eax,(%esp)
 610:	e8 b7 fd ff ff       	call   3cc <putc>
 615:	eb 28                	jmp    63f <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 617:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 61e:	00 
 61f:	8b 45 08             	mov    0x8(%ebp),%eax
 622:	89 04 24             	mov    %eax,(%esp)
 625:	e8 a2 fd ff ff       	call   3cc <putc>
        putc(fd, c);
 62a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62d:	0f be c0             	movsbl %al,%eax
 630:	89 44 24 04          	mov    %eax,0x4(%esp)
 634:	8b 45 08             	mov    0x8(%ebp),%eax
 637:	89 04 24             	mov    %eax,(%esp)
 63a:	e8 8d fd ff ff       	call   3cc <putc>
      }
      state = 0;
 63f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 646:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 64a:	8b 55 0c             	mov    0xc(%ebp),%edx
 64d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 650:	01 d0                	add    %edx,%eax
 652:	0f b6 00             	movzbl (%eax),%eax
 655:	84 c0                	test   %al,%al
 657:	0f 85 71 fe ff ff    	jne    4ce <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 65d:	c9                   	leave  
 65e:	c3                   	ret    

0000065f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 65f:	55                   	push   %ebp
 660:	89 e5                	mov    %esp,%ebp
 662:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 665:	8b 45 08             	mov    0x8(%ebp),%eax
 668:	83 e8 08             	sub    $0x8,%eax
 66b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66e:	a1 e0 0d 00 00       	mov    0xde0,%eax
 673:	89 45 fc             	mov    %eax,-0x4(%ebp)
 676:	eb 24                	jmp    69c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67b:	8b 00                	mov    (%eax),%eax
 67d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 680:	77 12                	ja     694 <free+0x35>
 682:	8b 45 f8             	mov    -0x8(%ebp),%eax
 685:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 688:	77 24                	ja     6ae <free+0x4f>
 68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68d:	8b 00                	mov    (%eax),%eax
 68f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 692:	77 1a                	ja     6ae <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	8b 00                	mov    (%eax),%eax
 699:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a2:	76 d4                	jbe    678 <free+0x19>
 6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a7:	8b 00                	mov    (%eax),%eax
 6a9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ac:	76 ca                	jbe    678 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b1:	8b 40 04             	mov    0x4(%eax),%eax
 6b4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	01 c2                	add    %eax,%edx
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	8b 00                	mov    (%eax),%eax
 6c5:	39 c2                	cmp    %eax,%edx
 6c7:	75 24                	jne    6ed <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cc:	8b 50 04             	mov    0x4(%eax),%edx
 6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d2:	8b 00                	mov    (%eax),%eax
 6d4:	8b 40 04             	mov    0x4(%eax),%eax
 6d7:	01 c2                	add    %eax,%edx
 6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dc:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	8b 00                	mov    (%eax),%eax
 6e4:	8b 10                	mov    (%eax),%edx
 6e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e9:	89 10                	mov    %edx,(%eax)
 6eb:	eb 0a                	jmp    6f7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	8b 10                	mov    (%eax),%edx
 6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	01 d0                	add    %edx,%eax
 709:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70c:	75 20                	jne    72e <free+0xcf>
    p->s.size += bp->s.size;
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	8b 50 04             	mov    0x4(%eax),%edx
 714:	8b 45 f8             	mov    -0x8(%ebp),%eax
 717:	8b 40 04             	mov    0x4(%eax),%eax
 71a:	01 c2                	add    %eax,%edx
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 722:	8b 45 f8             	mov    -0x8(%ebp),%eax
 725:	8b 10                	mov    (%eax),%edx
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	89 10                	mov    %edx,(%eax)
 72c:	eb 08                	jmp    736 <free+0xd7>
  } else
    p->s.ptr = bp;
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 55 f8             	mov    -0x8(%ebp),%edx
 734:	89 10                	mov    %edx,(%eax)
  freep = p;
 736:	8b 45 fc             	mov    -0x4(%ebp),%eax
 739:	a3 e0 0d 00 00       	mov    %eax,0xde0
}
 73e:	c9                   	leave  
 73f:	c3                   	ret    

00000740 <morecore>:

static Header*
morecore(uint nu)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 746:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 74d:	77 07                	ja     756 <morecore+0x16>
    nu = 4096;
 74f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 756:	8b 45 08             	mov    0x8(%ebp),%eax
 759:	c1 e0 03             	shl    $0x3,%eax
 75c:	89 04 24             	mov    %eax,(%esp)
 75f:	e8 f8 fb ff ff       	call   35c <sbrk>
 764:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 767:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 76b:	75 07                	jne    774 <morecore+0x34>
    return 0;
 76d:	b8 00 00 00 00       	mov    $0x0,%eax
 772:	eb 22                	jmp    796 <morecore+0x56>
  hp = (Header*)p;
 774:	8b 45 f4             	mov    -0xc(%ebp),%eax
 777:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 77a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77d:	8b 55 08             	mov    0x8(%ebp),%edx
 780:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 783:	8b 45 f0             	mov    -0x10(%ebp),%eax
 786:	83 c0 08             	add    $0x8,%eax
 789:	89 04 24             	mov    %eax,(%esp)
 78c:	e8 ce fe ff ff       	call   65f <free>
  return freep;
 791:	a1 e0 0d 00 00       	mov    0xde0,%eax
}
 796:	c9                   	leave  
 797:	c3                   	ret    

00000798 <malloc>:

void*
malloc(uint nbytes)
{
 798:	55                   	push   %ebp
 799:	89 e5                	mov    %esp,%ebp
 79b:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79e:	8b 45 08             	mov    0x8(%ebp),%eax
 7a1:	83 c0 07             	add    $0x7,%eax
 7a4:	c1 e8 03             	shr    $0x3,%eax
 7a7:	83 c0 01             	add    $0x1,%eax
 7aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7ad:	a1 e0 0d 00 00       	mov    0xde0,%eax
 7b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7b9:	75 23                	jne    7de <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7bb:	c7 45 f0 d8 0d 00 00 	movl   $0xdd8,-0x10(%ebp)
 7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c5:	a3 e0 0d 00 00       	mov    %eax,0xde0
 7ca:	a1 e0 0d 00 00       	mov    0xde0,%eax
 7cf:	a3 d8 0d 00 00       	mov    %eax,0xdd8
    base.s.size = 0;
 7d4:	c7 05 dc 0d 00 00 00 	movl   $0x0,0xddc
 7db:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7de:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e1:	8b 00                	mov    (%eax),%eax
 7e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 40 04             	mov    0x4(%eax),%eax
 7ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ef:	72 4d                	jb     83e <malloc+0xa6>
      if(p->s.size == nunits)
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	8b 40 04             	mov    0x4(%eax),%eax
 7f7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fa:	75 0c                	jne    808 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 10                	mov    (%eax),%edx
 801:	8b 45 f0             	mov    -0x10(%ebp),%eax
 804:	89 10                	mov    %edx,(%eax)
 806:	eb 26                	jmp    82e <malloc+0x96>
      else {
        p->s.size -= nunits;
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	8b 40 04             	mov    0x4(%eax),%eax
 80e:	2b 45 ec             	sub    -0x14(%ebp),%eax
 811:	89 c2                	mov    %eax,%edx
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	8b 40 04             	mov    0x4(%eax),%eax
 81f:	c1 e0 03             	shl    $0x3,%eax
 822:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 831:	a3 e0 0d 00 00       	mov    %eax,0xde0
      return (void*)(p + 1);
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	83 c0 08             	add    $0x8,%eax
 83c:	eb 38                	jmp    876 <malloc+0xde>
    }
    if(p == freep)
 83e:	a1 e0 0d 00 00       	mov    0xde0,%eax
 843:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 846:	75 1b                	jne    863 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 848:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84b:	89 04 24             	mov    %eax,(%esp)
 84e:	e8 ed fe ff ff       	call   740 <morecore>
 853:	89 45 f4             	mov    %eax,-0xc(%ebp)
 856:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85a:	75 07                	jne    863 <malloc+0xcb>
        return 0;
 85c:	b8 00 00 00 00       	mov    $0x0,%eax
 861:	eb 13                	jmp    876 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 863:	8b 45 f4             	mov    -0xc(%ebp),%eax
 866:	89 45 f0             	mov    %eax,-0x10(%ebp)
 869:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86c:	8b 00                	mov    (%eax),%eax
 86e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 871:	e9 70 ff ff ff       	jmp    7e6 <malloc+0x4e>
}
 876:	c9                   	leave  
 877:	c3                   	ret    

00000878 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 878:	55                   	push   %ebp
 879:	89 e5                	mov    %esp,%ebp
 87b:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 87e:	8b 45 0c             	mov    0xc(%ebp),%eax
 881:	89 04 24             	mov    %eax,(%esp)
 884:	8b 45 08             	mov    0x8(%ebp),%eax
 887:	ff d0                	call   *%eax
    exit();
 889:	e8 46 fa ff ff       	call   2d4 <exit>

0000088e <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 88e:	55                   	push   %ebp
 88f:	89 e5                	mov    %esp,%ebp
 891:	57                   	push   %edi
 892:	56                   	push   %esi
 893:	53                   	push   %ebx
 894:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 897:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 89e:	e8 f5 fe ff ff       	call   798 <malloc>
 8a3:	8b 55 08             	mov    0x8(%ebp),%edx
 8a6:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8a8:	8b 45 10             	mov    0x10(%ebp),%eax
 8ab:	8b 38                	mov    (%eax),%edi
 8ad:	8b 75 0c             	mov    0xc(%ebp),%esi
 8b0:	bb 78 08 00 00       	mov    $0x878,%ebx
 8b5:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8bc:	e8 d7 fe ff ff       	call   798 <malloc>
 8c1:	05 00 10 00 00       	add    $0x1000,%eax
 8c6:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8ca:	89 74 24 08          	mov    %esi,0x8(%esp)
 8ce:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8d2:	89 04 24             	mov    %eax,(%esp)
 8d5:	e8 9a fa ff ff       	call   374 <kthread_create>
 8da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 8dd:	8b 45 08             	mov    0x8(%ebp),%eax
 8e0:	8b 00                	mov    (%eax),%eax
 8e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8e5:	89 10                	mov    %edx,(%eax)
    return t_id;
 8e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8ea:	83 c4 2c             	add    $0x2c,%esp
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

    int val = kthread_join(thread->tid, (int)retval);
 8f8:	8b 55 0c             	mov    0xc(%ebp),%edx
 8fb:	8b 45 08             	mov    0x8(%ebp),%eax
 8fe:	8b 00                	mov    (%eax),%eax
 900:	89 54 24 04          	mov    %edx,0x4(%esp)
 904:	89 04 24             	mov    %eax,(%esp)
 907:	e8 70 fa ff ff       	call   37c <kthread_join>
 90c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 912:	c9                   	leave  
 913:	c3                   	ret    

00000914 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 914:	55                   	push   %ebp
 915:	89 e5                	mov    %esp,%ebp
 917:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 91a:	e8 65 fa ff ff       	call   384 <kthread_mutex_init>
 91f:	8b 55 08             	mov    0x8(%ebp),%edx
 922:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 924:	8b 45 08             	mov    0x8(%ebp),%eax
 927:	8b 00                	mov    (%eax),%eax
 929:	85 c0                	test   %eax,%eax
 92b:	7e 07                	jle    934 <qthread_mutex_init+0x20>
		return 0;
 92d:	b8 00 00 00 00       	mov    $0x0,%eax
 932:	eb 05                	jmp    939 <qthread_mutex_init+0x25>
	}
	return *mutex;
 934:	8b 45 08             	mov    0x8(%ebp),%eax
 937:	8b 00                	mov    (%eax),%eax
}
 939:	c9                   	leave  
 93a:	c3                   	ret    

0000093b <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 93b:	55                   	push   %ebp
 93c:	89 e5                	mov    %esp,%ebp
 93e:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 941:	8b 45 08             	mov    0x8(%ebp),%eax
 944:	89 04 24             	mov    %eax,(%esp)
 947:	e8 40 fa ff ff       	call   38c <kthread_mutex_destroy>
 94c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 94f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 953:	79 07                	jns    95c <qthread_mutex_destroy+0x21>
    	return -1;
 955:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 95a:	eb 05                	jmp    961 <qthread_mutex_destroy+0x26>
    }
    return 0;
 95c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 961:	c9                   	leave  
 962:	c3                   	ret    

00000963 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 963:	55                   	push   %ebp
 964:	89 e5                	mov    %esp,%ebp
 966:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 969:	8b 45 08             	mov    0x8(%ebp),%eax
 96c:	89 04 24             	mov    %eax,(%esp)
 96f:	e8 20 fa ff ff       	call   394 <kthread_mutex_lock>
 974:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 977:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 97b:	79 07                	jns    984 <qthread_mutex_lock+0x21>
    	return -1;
 97d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 982:	eb 05                	jmp    989 <qthread_mutex_lock+0x26>
    }
    return 0;
 984:	b8 00 00 00 00       	mov    $0x0,%eax
}
 989:	c9                   	leave  
 98a:	c3                   	ret    

0000098b <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 98b:	55                   	push   %ebp
 98c:	89 e5                	mov    %esp,%ebp
 98e:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 991:	8b 45 08             	mov    0x8(%ebp),%eax
 994:	89 04 24             	mov    %eax,(%esp)
 997:	e8 00 fa ff ff       	call   39c <kthread_mutex_unlock>
 99c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 99f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a3:	79 07                	jns    9ac <qthread_mutex_unlock+0x21>
    	return -1;
 9a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9aa:	eb 05                	jmp    9b1 <qthread_mutex_unlock+0x26>
    }
    return 0;
 9ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b1:	c9                   	leave  
 9b2:	c3                   	ret    

000009b3 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9b3:	55                   	push   %ebp
 9b4:	89 e5                	mov    %esp,%ebp

	return 0;
 9b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9bb:	5d                   	pop    %ebp
 9bc:	c3                   	ret    

000009bd <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9bd:	55                   	push   %ebp
 9be:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c5:	5d                   	pop    %ebp
 9c6:	c3                   	ret    

000009c7 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9c7:	55                   	push   %ebp
 9c8:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9cf:	5d                   	pop    %ebp
 9d0:	c3                   	ret    

000009d1 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9d1:	55                   	push   %ebp
 9d2:	89 e5                	mov    %esp,%ebp
	return 0;
 9d4:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9d9:	5d                   	pop    %ebp
 9da:	c3                   	ret    

000009db <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9db:	55                   	push   %ebp
 9dc:	89 e5                	mov    %esp,%ebp
	return 0;
 9de:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9e3:	5d                   	pop    %ebp
 9e4:	c3                   	ret    
