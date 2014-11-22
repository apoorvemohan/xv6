
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
  1f:	b8 f7 09 00 00       	mov    $0x9f7,%eax
  24:	eb 05                	jmp    2b <main+0x2b>
  26:	b8 f9 09 00 00       	mov    $0x9f9,%eax
  2b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  2f:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  36:	8b 55 0c             	mov    0xc(%ebp),%edx
  39:	01 ca                	add    %ecx,%edx
  3b:	8b 12                	mov    (%edx),%edx
  3d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  41:	89 54 24 08          	mov    %edx,0x8(%esp)
  45:	c7 44 24 04 fb 09 00 	movl   $0x9fb,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  54:	e8 5b 04 00 00       	call   4b4 <printf>
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
SYSCALL(kthread_cond_broadcast)
 3c4:	b8 20 00 00 00       	mov    $0x20,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <kthread_exit>:
 3cc:	b8 21 00 00 00       	mov    $0x21,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	83 ec 18             	sub    $0x18,%esp
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e7:	00 
 3e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ef:	8b 45 08             	mov    0x8(%ebp),%eax
 3f2:	89 04 24             	mov    %eax,(%esp)
 3f5:	e8 fa fe ff ff       	call   2f4 <write>
}
 3fa:	c9                   	leave  
 3fb:	c3                   	ret    

000003fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3fc:	55                   	push   %ebp
 3fd:	89 e5                	mov    %esp,%ebp
 3ff:	56                   	push   %esi
 400:	53                   	push   %ebx
 401:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 404:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 40b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 40f:	74 17                	je     428 <printint+0x2c>
 411:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 415:	79 11                	jns    428 <printint+0x2c>
    neg = 1;
 417:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	f7 d8                	neg    %eax
 423:	89 45 ec             	mov    %eax,-0x14(%ebp)
 426:	eb 06                	jmp    42e <printint+0x32>
  } else {
    x = xx;
 428:	8b 45 0c             	mov    0xc(%ebp),%eax
 42b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 42e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 435:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 438:	8d 41 01             	lea    0x1(%ecx),%eax
 43b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 43e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 441:	8b 45 ec             	mov    -0x14(%ebp),%eax
 444:	ba 00 00 00 00       	mov    $0x0,%edx
 449:	f7 f3                	div    %ebx
 44b:	89 d0                	mov    %edx,%eax
 44d:	0f b6 80 f4 0d 00 00 	movzbl 0xdf4(%eax),%eax
 454:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 458:	8b 75 10             	mov    0x10(%ebp),%esi
 45b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45e:	ba 00 00 00 00       	mov    $0x0,%edx
 463:	f7 f6                	div    %esi
 465:	89 45 ec             	mov    %eax,-0x14(%ebp)
 468:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 46c:	75 c7                	jne    435 <printint+0x39>
  if(neg)
 46e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 472:	74 10                	je     484 <printint+0x88>
    buf[i++] = '-';
 474:	8b 45 f4             	mov    -0xc(%ebp),%eax
 477:	8d 50 01             	lea    0x1(%eax),%edx
 47a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 482:	eb 1f                	jmp    4a3 <printint+0xa7>
 484:	eb 1d                	jmp    4a3 <printint+0xa7>
    putc(fd, buf[i]);
 486:	8d 55 dc             	lea    -0x24(%ebp),%edx
 489:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48c:	01 d0                	add    %edx,%eax
 48e:	0f b6 00             	movzbl (%eax),%eax
 491:	0f be c0             	movsbl %al,%eax
 494:	89 44 24 04          	mov    %eax,0x4(%esp)
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	89 04 24             	mov    %eax,(%esp)
 49e:	e8 31 ff ff ff       	call   3d4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4a3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ab:	79 d9                	jns    486 <printint+0x8a>
    putc(fd, buf[i]);
}
 4ad:	83 c4 30             	add    $0x30,%esp
 4b0:	5b                   	pop    %ebx
 4b1:	5e                   	pop    %esi
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret    

000004b4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c1:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c4:	83 c0 04             	add    $0x4,%eax
 4c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d1:	e9 7c 01 00 00       	jmp    652 <printf+0x19e>
    c = fmt[i] & 0xff;
 4d6:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4dc:	01 d0                	add    %edx,%eax
 4de:	0f b6 00             	movzbl (%eax),%eax
 4e1:	0f be c0             	movsbl %al,%eax
 4e4:	25 ff 00 00 00       	and    $0xff,%eax
 4e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f0:	75 2c                	jne    51e <printf+0x6a>
      if(c == '%'){
 4f2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f6:	75 0c                	jne    504 <printf+0x50>
        state = '%';
 4f8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ff:	e9 4a 01 00 00       	jmp    64e <printf+0x19a>
      } else {
        putc(fd, c);
 504:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 507:	0f be c0             	movsbl %al,%eax
 50a:	89 44 24 04          	mov    %eax,0x4(%esp)
 50e:	8b 45 08             	mov    0x8(%ebp),%eax
 511:	89 04 24             	mov    %eax,(%esp)
 514:	e8 bb fe ff ff       	call   3d4 <putc>
 519:	e9 30 01 00 00       	jmp    64e <printf+0x19a>
      }
    } else if(state == '%'){
 51e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 522:	0f 85 26 01 00 00    	jne    64e <printf+0x19a>
      if(c == 'd'){
 528:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 52c:	75 2d                	jne    55b <printf+0xa7>
        printint(fd, *ap, 10, 1);
 52e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 531:	8b 00                	mov    (%eax),%eax
 533:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 53a:	00 
 53b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 542:	00 
 543:	89 44 24 04          	mov    %eax,0x4(%esp)
 547:	8b 45 08             	mov    0x8(%ebp),%eax
 54a:	89 04 24             	mov    %eax,(%esp)
 54d:	e8 aa fe ff ff       	call   3fc <printint>
        ap++;
 552:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 556:	e9 ec 00 00 00       	jmp    647 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 55b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 55f:	74 06                	je     567 <printf+0xb3>
 561:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 565:	75 2d                	jne    594 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 567:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56a:	8b 00                	mov    (%eax),%eax
 56c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 573:	00 
 574:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 57b:	00 
 57c:	89 44 24 04          	mov    %eax,0x4(%esp)
 580:	8b 45 08             	mov    0x8(%ebp),%eax
 583:	89 04 24             	mov    %eax,(%esp)
 586:	e8 71 fe ff ff       	call   3fc <printint>
        ap++;
 58b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58f:	e9 b3 00 00 00       	jmp    647 <printf+0x193>
      } else if(c == 's'){
 594:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 598:	75 45                	jne    5df <printf+0x12b>
        s = (char*)*ap;
 59a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59d:	8b 00                	mov    (%eax),%eax
 59f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5aa:	75 09                	jne    5b5 <printf+0x101>
          s = "(null)";
 5ac:	c7 45 f4 00 0a 00 00 	movl   $0xa00,-0xc(%ebp)
        while(*s != 0){
 5b3:	eb 1e                	jmp    5d3 <printf+0x11f>
 5b5:	eb 1c                	jmp    5d3 <printf+0x11f>
          putc(fd, *s);
 5b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ba:	0f b6 00             	movzbl (%eax),%eax
 5bd:	0f be c0             	movsbl %al,%eax
 5c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c4:	8b 45 08             	mov    0x8(%ebp),%eax
 5c7:	89 04 24             	mov    %eax,(%esp)
 5ca:	e8 05 fe ff ff       	call   3d4 <putc>
          s++;
 5cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d6:	0f b6 00             	movzbl (%eax),%eax
 5d9:	84 c0                	test   %al,%al
 5db:	75 da                	jne    5b7 <printf+0x103>
 5dd:	eb 68                	jmp    647 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5df:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e3:	75 1d                	jne    602 <printf+0x14e>
        putc(fd, *ap);
 5e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e8:	8b 00                	mov    (%eax),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f1:	8b 45 08             	mov    0x8(%ebp),%eax
 5f4:	89 04 24             	mov    %eax,(%esp)
 5f7:	e8 d8 fd ff ff       	call   3d4 <putc>
        ap++;
 5fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 600:	eb 45                	jmp    647 <printf+0x193>
      } else if(c == '%'){
 602:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 606:	75 17                	jne    61f <printf+0x16b>
        putc(fd, c);
 608:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60b:	0f be c0             	movsbl %al,%eax
 60e:	89 44 24 04          	mov    %eax,0x4(%esp)
 612:	8b 45 08             	mov    0x8(%ebp),%eax
 615:	89 04 24             	mov    %eax,(%esp)
 618:	e8 b7 fd ff ff       	call   3d4 <putc>
 61d:	eb 28                	jmp    647 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 626:	00 
 627:	8b 45 08             	mov    0x8(%ebp),%eax
 62a:	89 04 24             	mov    %eax,(%esp)
 62d:	e8 a2 fd ff ff       	call   3d4 <putc>
        putc(fd, c);
 632:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 635:	0f be c0             	movsbl %al,%eax
 638:	89 44 24 04          	mov    %eax,0x4(%esp)
 63c:	8b 45 08             	mov    0x8(%ebp),%eax
 63f:	89 04 24             	mov    %eax,(%esp)
 642:	e8 8d fd ff ff       	call   3d4 <putc>
      }
      state = 0;
 647:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 64e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 652:	8b 55 0c             	mov    0xc(%ebp),%edx
 655:	8b 45 f0             	mov    -0x10(%ebp),%eax
 658:	01 d0                	add    %edx,%eax
 65a:	0f b6 00             	movzbl (%eax),%eax
 65d:	84 c0                	test   %al,%al
 65f:	0f 85 71 fe ff ff    	jne    4d6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 665:	c9                   	leave  
 666:	c3                   	ret    

00000667 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 667:	55                   	push   %ebp
 668:	89 e5                	mov    %esp,%ebp
 66a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
 670:	83 e8 08             	sub    $0x8,%eax
 673:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 676:	a1 10 0e 00 00       	mov    0xe10,%eax
 67b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67e:	eb 24                	jmp    6a4 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	8b 45 fc             	mov    -0x4(%ebp),%eax
 683:	8b 00                	mov    (%eax),%eax
 685:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 688:	77 12                	ja     69c <free+0x35>
 68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 690:	77 24                	ja     6b6 <free+0x4f>
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	8b 00                	mov    (%eax),%eax
 697:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69a:	77 1a                	ja     6b6 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 00                	mov    (%eax),%eax
 6a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6aa:	76 d4                	jbe    680 <free+0x19>
 6ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6af:	8b 00                	mov    (%eax),%eax
 6b1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b4:	76 ca                	jbe    680 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	8b 40 04             	mov    0x4(%eax),%eax
 6bc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	01 c2                	add    %eax,%edx
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	39 c2                	cmp    %eax,%edx
 6cf:	75 24                	jne    6f5 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d4:	8b 50 04             	mov    0x4(%eax),%edx
 6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	8b 40 04             	mov    0x4(%eax),%eax
 6df:	01 c2                	add    %eax,%edx
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ea:	8b 00                	mov    (%eax),%eax
 6ec:	8b 10                	mov    (%eax),%edx
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	89 10                	mov    %edx,(%eax)
 6f3:	eb 0a                	jmp    6ff <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 10                	mov    (%eax),%edx
 6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fd:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	8b 40 04             	mov    0x4(%eax),%eax
 705:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	01 d0                	add    %edx,%eax
 711:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 714:	75 20                	jne    736 <free+0xcf>
    p->s.size += bp->s.size;
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 50 04             	mov    0x4(%eax),%edx
 71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71f:	8b 40 04             	mov    0x4(%eax),%eax
 722:	01 c2                	add    %eax,%edx
 724:	8b 45 fc             	mov    -0x4(%ebp),%eax
 727:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72d:	8b 10                	mov    (%eax),%edx
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	89 10                	mov    %edx,(%eax)
 734:	eb 08                	jmp    73e <free+0xd7>
  } else
    p->s.ptr = bp;
 736:	8b 45 fc             	mov    -0x4(%ebp),%eax
 739:	8b 55 f8             	mov    -0x8(%ebp),%edx
 73c:	89 10                	mov    %edx,(%eax)
  freep = p;
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	a3 10 0e 00 00       	mov    %eax,0xe10
}
 746:	c9                   	leave  
 747:	c3                   	ret    

00000748 <morecore>:

static Header*
morecore(uint nu)
{
 748:	55                   	push   %ebp
 749:	89 e5                	mov    %esp,%ebp
 74b:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 74e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 755:	77 07                	ja     75e <morecore+0x16>
    nu = 4096;
 757:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 75e:	8b 45 08             	mov    0x8(%ebp),%eax
 761:	c1 e0 03             	shl    $0x3,%eax
 764:	89 04 24             	mov    %eax,(%esp)
 767:	e8 f0 fb ff ff       	call   35c <sbrk>
 76c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 76f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 773:	75 07                	jne    77c <morecore+0x34>
    return 0;
 775:	b8 00 00 00 00       	mov    $0x0,%eax
 77a:	eb 22                	jmp    79e <morecore+0x56>
  hp = (Header*)p;
 77c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 782:	8b 45 f0             	mov    -0x10(%ebp),%eax
 785:	8b 55 08             	mov    0x8(%ebp),%edx
 788:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 78b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78e:	83 c0 08             	add    $0x8,%eax
 791:	89 04 24             	mov    %eax,(%esp)
 794:	e8 ce fe ff ff       	call   667 <free>
  return freep;
 799:	a1 10 0e 00 00       	mov    0xe10,%eax
}
 79e:	c9                   	leave  
 79f:	c3                   	ret    

000007a0 <malloc>:

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	8b 45 08             	mov    0x8(%ebp),%eax
 7a9:	83 c0 07             	add    $0x7,%eax
 7ac:	c1 e8 03             	shr    $0x3,%eax
 7af:	83 c0 01             	add    $0x1,%eax
 7b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b5:	a1 10 0e 00 00       	mov    0xe10,%eax
 7ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c1:	75 23                	jne    7e6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c3:	c7 45 f0 08 0e 00 00 	movl   $0xe08,-0x10(%ebp)
 7ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cd:	a3 10 0e 00 00       	mov    %eax,0xe10
 7d2:	a1 10 0e 00 00       	mov    0xe10,%eax
 7d7:	a3 08 0e 00 00       	mov    %eax,0xe08
    base.s.size = 0;
 7dc:	c7 05 0c 0e 00 00 00 	movl   $0x0,0xe0c
 7e3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e9:	8b 00                	mov    (%eax),%eax
 7eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	8b 40 04             	mov    0x4(%eax),%eax
 7f4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f7:	72 4d                	jb     846 <malloc+0xa6>
      if(p->s.size == nunits)
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	8b 40 04             	mov    0x4(%eax),%eax
 7ff:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 802:	75 0c                	jne    810 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	8b 10                	mov    (%eax),%edx
 809:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80c:	89 10                	mov    %edx,(%eax)
 80e:	eb 26                	jmp    836 <malloc+0x96>
      else {
        p->s.size -= nunits;
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	8b 40 04             	mov    0x4(%eax),%eax
 816:	2b 45 ec             	sub    -0x14(%ebp),%eax
 819:	89 c2                	mov    %eax,%edx
 81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	8b 40 04             	mov    0x4(%eax),%eax
 827:	c1 e0 03             	shl    $0x3,%eax
 82a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 830:	8b 55 ec             	mov    -0x14(%ebp),%edx
 833:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 836:	8b 45 f0             	mov    -0x10(%ebp),%eax
 839:	a3 10 0e 00 00       	mov    %eax,0xe10
      return (void*)(p + 1);
 83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 841:	83 c0 08             	add    $0x8,%eax
 844:	eb 38                	jmp    87e <malloc+0xde>
    }
    if(p == freep)
 846:	a1 10 0e 00 00       	mov    0xe10,%eax
 84b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 84e:	75 1b                	jne    86b <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 850:	8b 45 ec             	mov    -0x14(%ebp),%eax
 853:	89 04 24             	mov    %eax,(%esp)
 856:	e8 ed fe ff ff       	call   748 <morecore>
 85b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 862:	75 07                	jne    86b <malloc+0xcb>
        return 0;
 864:	b8 00 00 00 00       	mov    $0x0,%eax
 869:	eb 13                	jmp    87e <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	8b 00                	mov    (%eax),%eax
 876:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 879:	e9 70 ff ff ff       	jmp    7ee <malloc+0x4e>
}
 87e:	c9                   	leave  
 87f:	c3                   	ret    

00000880 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 886:	8b 45 0c             	mov    0xc(%ebp),%eax
 889:	89 04 24             	mov    %eax,(%esp)
 88c:	8b 45 08             	mov    0x8(%ebp),%eax
 88f:	ff d0                	call   *%eax
    exit();
 891:	e8 3e fa ff ff       	call   2d4 <exit>

00000896 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 896:	55                   	push   %ebp
 897:	89 e5                	mov    %esp,%ebp
 899:	57                   	push   %edi
 89a:	56                   	push   %esi
 89b:	53                   	push   %ebx
 89c:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 89f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8a6:	e8 f5 fe ff ff       	call   7a0 <malloc>
 8ab:	8b 55 08             	mov    0x8(%ebp),%edx
 8ae:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8b0:	8b 45 10             	mov    0x10(%ebp),%eax
 8b3:	8b 38                	mov    (%eax),%edi
 8b5:	8b 75 0c             	mov    0xc(%ebp),%esi
 8b8:	bb 80 08 00 00       	mov    $0x880,%ebx
 8bd:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8c4:	e8 d7 fe ff ff       	call   7a0 <malloc>
 8c9:	05 00 10 00 00       	add    $0x1000,%eax
 8ce:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8d2:	89 74 24 08          	mov    %esi,0x8(%esp)
 8d6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8da:	89 04 24             	mov    %eax,(%esp)
 8dd:	e8 92 fa ff ff       	call   374 <kthread_create>
 8e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 8e5:	8b 45 08             	mov    0x8(%ebp),%eax
 8e8:	8b 00                	mov    (%eax),%eax
 8ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8ed:	89 10                	mov    %edx,(%eax)
    return t_id;
 8ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8f2:	83 c4 2c             	add    $0x2c,%esp
 8f5:	5b                   	pop    %ebx
 8f6:	5e                   	pop    %esi
 8f7:	5f                   	pop    %edi
 8f8:	5d                   	pop    %ebp
 8f9:	c3                   	ret    

000008fa <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8fa:	55                   	push   %ebp
 8fb:	89 e5                	mov    %esp,%ebp
 8fd:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 900:	8b 55 0c             	mov    0xc(%ebp),%edx
 903:	8b 45 08             	mov    0x8(%ebp),%eax
 906:	8b 00                	mov    (%eax),%eax
 908:	89 54 24 04          	mov    %edx,0x4(%esp)
 90c:	89 04 24             	mov    %eax,(%esp)
 90f:	e8 68 fa ff ff       	call   37c <kthread_join>
 914:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 917:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 91a:	c9                   	leave  
 91b:	c3                   	ret    

0000091c <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 91c:	55                   	push   %ebp
 91d:	89 e5                	mov    %esp,%ebp
 91f:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 922:	e8 5d fa ff ff       	call   384 <kthread_mutex_init>
 927:	8b 55 08             	mov    0x8(%ebp),%edx
 92a:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 92c:	8b 45 08             	mov    0x8(%ebp),%eax
 92f:	8b 00                	mov    (%eax),%eax
 931:	85 c0                	test   %eax,%eax
 933:	7e 07                	jle    93c <qthread_mutex_init+0x20>
		return 0;
 935:	b8 00 00 00 00       	mov    $0x0,%eax
 93a:	eb 05                	jmp    941 <qthread_mutex_init+0x25>
	}
	return *mutex;
 93c:	8b 45 08             	mov    0x8(%ebp),%eax
 93f:	8b 00                	mov    (%eax),%eax
}
 941:	c9                   	leave  
 942:	c3                   	ret    

00000943 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 943:	55                   	push   %ebp
 944:	89 e5                	mov    %esp,%ebp
 946:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 949:	8b 45 08             	mov    0x8(%ebp),%eax
 94c:	89 04 24             	mov    %eax,(%esp)
 94f:	e8 38 fa ff ff       	call   38c <kthread_mutex_destroy>
 954:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 957:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 95b:	79 07                	jns    964 <qthread_mutex_destroy+0x21>
    	return -1;
 95d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 962:	eb 05                	jmp    969 <qthread_mutex_destroy+0x26>
    }
    return 0;
 964:	b8 00 00 00 00       	mov    $0x0,%eax
}
 969:	c9                   	leave  
 96a:	c3                   	ret    

0000096b <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 96b:	55                   	push   %ebp
 96c:	89 e5                	mov    %esp,%ebp
 96e:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 971:	8b 45 08             	mov    0x8(%ebp),%eax
 974:	89 04 24             	mov    %eax,(%esp)
 977:	e8 18 fa ff ff       	call   394 <kthread_mutex_lock>
 97c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 97f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 983:	79 07                	jns    98c <qthread_mutex_lock+0x21>
    	return -1;
 985:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 98a:	eb 05                	jmp    991 <qthread_mutex_lock+0x26>
    }
    return 0;
 98c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 991:	c9                   	leave  
 992:	c3                   	ret    

00000993 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 993:	55                   	push   %ebp
 994:	89 e5                	mov    %esp,%ebp
 996:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 999:	8b 45 08             	mov    0x8(%ebp),%eax
 99c:	89 04 24             	mov    %eax,(%esp)
 99f:	e8 f8 f9 ff ff       	call   39c <kthread_mutex_unlock>
 9a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9ab:	79 07                	jns    9b4 <qthread_mutex_unlock+0x21>
    	return -1;
 9ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9b2:	eb 05                	jmp    9b9 <qthread_mutex_unlock+0x26>
    }
    return 0;
 9b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b9:	c9                   	leave  
 9ba:	c3                   	ret    

000009bb <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9bb:	55                   	push   %ebp
 9bc:	89 e5                	mov    %esp,%ebp

	return 0;
 9be:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c3:	5d                   	pop    %ebp
 9c4:	c3                   	ret    

000009c5 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9c5:	55                   	push   %ebp
 9c6:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9cd:	5d                   	pop    %ebp
 9ce:	c3                   	ret    

000009cf <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9cf:	55                   	push   %ebp
 9d0:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d7:	5d                   	pop    %ebp
 9d8:	c3                   	ret    

000009d9 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9d9:	55                   	push   %ebp
 9da:	89 e5                	mov    %esp,%ebp
	return 0;
 9dc:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9e1:	5d                   	pop    %ebp
 9e2:	c3                   	ret    

000009e3 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9e3:	55                   	push   %ebp
 9e4:	89 e5                	mov    %esp,%ebp
	return 0;
 9e6:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9eb:	5d                   	pop    %ebp
 9ec:	c3                   	ret    

000009ed <qthread_exit>:

int qthread_exit(){
 9ed:	55                   	push   %ebp
 9ee:	89 e5                	mov    %esp,%ebp
	return 0;
 9f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f5:	5d                   	pop    %ebp
 9f6:	c3                   	ret    
