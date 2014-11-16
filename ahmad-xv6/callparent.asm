
_callparent:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(void){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp

parent();
   9:	e8 c2 07 00 00       	call   7d0 <parent>
printf(1, "Hello World\n");
   e:	c7 44 24 04 5a 08 00 	movl   $0x85a,0x4(%esp)
  15:	00 
  16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1d:	e8 e9 03 00 00       	call   40b <printf>
exit();
  22:	e8 65 02 00 00       	call   28c <exit>
  27:	90                   	nop

00000028 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	57                   	push   %edi
  2c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  30:	8b 55 10             	mov    0x10(%ebp),%edx
  33:	8b 45 0c             	mov    0xc(%ebp),%eax
  36:	89 cb                	mov    %ecx,%ebx
  38:	89 df                	mov    %ebx,%edi
  3a:	89 d1                	mov    %edx,%ecx
  3c:	fc                   	cld    
  3d:	f3 aa                	rep stos %al,%es:(%edi)
  3f:	89 ca                	mov    %ecx,%edx
  41:	89 fb                	mov    %edi,%ebx
  43:	89 5d 08             	mov    %ebx,0x8(%ebp)
  46:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  49:	5b                   	pop    %ebx
  4a:	5f                   	pop    %edi
  4b:	5d                   	pop    %ebp
  4c:	c3                   	ret    

0000004d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  4d:	55                   	push   %ebp
  4e:	89 e5                	mov    %esp,%ebp
  50:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  53:	8b 45 08             	mov    0x8(%ebp),%eax
  56:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  59:	90                   	nop
  5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  5d:	0f b6 10             	movzbl (%eax),%edx
  60:	8b 45 08             	mov    0x8(%ebp),%eax
  63:	88 10                	mov    %dl,(%eax)
  65:	8b 45 08             	mov    0x8(%ebp),%eax
  68:	0f b6 00             	movzbl (%eax),%eax
  6b:	84 c0                	test   %al,%al
  6d:	0f 95 c0             	setne  %al
  70:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  74:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  78:	84 c0                	test   %al,%al
  7a:	75 de                	jne    5a <strcpy+0xd>
    ;
  return os;
  7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7f:	c9                   	leave  
  80:	c3                   	ret    

00000081 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  81:	55                   	push   %ebp
  82:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  84:	eb 08                	jmp    8e <strcmp+0xd>
    p++, q++;
  86:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	0f b6 00             	movzbl (%eax),%eax
  94:	84 c0                	test   %al,%al
  96:	74 10                	je     a8 <strcmp+0x27>
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	0f b6 10             	movzbl (%eax),%edx
  9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  a1:	0f b6 00             	movzbl (%eax),%eax
  a4:	38 c2                	cmp    %al,%dl
  a6:	74 de                	je     86 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	0f b6 00             	movzbl (%eax),%eax
  ae:	0f b6 d0             	movzbl %al,%edx
  b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  b4:	0f b6 00             	movzbl (%eax),%eax
  b7:	0f b6 c0             	movzbl %al,%eax
  ba:	89 d1                	mov    %edx,%ecx
  bc:	29 c1                	sub    %eax,%ecx
  be:	89 c8                	mov    %ecx,%eax
}
  c0:	5d                   	pop    %ebp
  c1:	c3                   	ret    

000000c2 <strlen>:

uint
strlen(char *s)
{
  c2:	55                   	push   %ebp
  c3:	89 e5                	mov    %esp,%ebp
  c5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cf:	eb 04                	jmp    d5 <strlen+0x13>
  d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d8:	03 45 08             	add    0x8(%ebp),%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	84 c0                	test   %al,%al
  e0:	75 ef                	jne    d1 <strlen+0xf>
    ;
  return n;
  e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e5:	c9                   	leave  
  e6:	c3                   	ret    

000000e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e7:	55                   	push   %ebp
  e8:	89 e5                	mov    %esp,%ebp
  ea:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  ed:	8b 45 10             	mov    0x10(%ebp),%eax
  f0:	89 44 24 08          	mov    %eax,0x8(%esp)
  f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  fb:	8b 45 08             	mov    0x8(%ebp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 22 ff ff ff       	call   28 <stosb>
  return dst;
 106:	8b 45 08             	mov    0x8(%ebp),%eax
}
 109:	c9                   	leave  
 10a:	c3                   	ret    

0000010b <strchr>:

char*
strchr(const char *s, char c)
{
 10b:	55                   	push   %ebp
 10c:	89 e5                	mov    %esp,%ebp
 10e:	83 ec 04             	sub    $0x4,%esp
 111:	8b 45 0c             	mov    0xc(%ebp),%eax
 114:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 117:	eb 14                	jmp    12d <strchr+0x22>
    if(*s == c)
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 122:	75 05                	jne    129 <strchr+0x1e>
      return (char*)s;
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	eb 13                	jmp    13c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 129:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	0f b6 00             	movzbl (%eax),%eax
 133:	84 c0                	test   %al,%al
 135:	75 e2                	jne    119 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 137:	b8 00 00 00 00       	mov    $0x0,%eax
}
 13c:	c9                   	leave  
 13d:	c3                   	ret    

0000013e <gets>:

char*
gets(char *buf, int max)
{
 13e:	55                   	push   %ebp
 13f:	89 e5                	mov    %esp,%ebp
 141:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 14b:	eb 44                	jmp    191 <gets+0x53>
    cc = read(0, &c, 1);
 14d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 154:	00 
 155:	8d 45 ef             	lea    -0x11(%ebp),%eax
 158:	89 44 24 04          	mov    %eax,0x4(%esp)
 15c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 163:	e8 3c 01 00 00       	call   2a4 <read>
 168:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 16b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16f:	7e 2d                	jle    19e <gets+0x60>
      break;
    buf[i++] = c;
 171:	8b 45 f4             	mov    -0xc(%ebp),%eax
 174:	03 45 08             	add    0x8(%ebp),%eax
 177:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 17b:	88 10                	mov    %dl,(%eax)
 17d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 181:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 185:	3c 0a                	cmp    $0xa,%al
 187:	74 16                	je     19f <gets+0x61>
 189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18d:	3c 0d                	cmp    $0xd,%al
 18f:	74 0e                	je     19f <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 191:	8b 45 f4             	mov    -0xc(%ebp),%eax
 194:	83 c0 01             	add    $0x1,%eax
 197:	3b 45 0c             	cmp    0xc(%ebp),%eax
 19a:	7c b1                	jl     14d <gets+0xf>
 19c:	eb 01                	jmp    19f <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 19e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a2:	03 45 08             	add    0x8(%ebp),%eax
 1a5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ab:	c9                   	leave  
 1ac:	c3                   	ret    

000001ad <stat>:

int
stat(char *n, struct stat *st)
{
 1ad:	55                   	push   %ebp
 1ae:	89 e5                	mov    %esp,%ebp
 1b0:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1ba:	00 
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	89 04 24             	mov    %eax,(%esp)
 1c1:	e8 06 01 00 00       	call   2cc <open>
 1c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1cd:	79 07                	jns    1d6 <stat+0x29>
    return -1;
 1cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d4:	eb 23                	jmp    1f9 <stat+0x4c>
  r = fstat(fd, st);
 1d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e0:	89 04 24             	mov    %eax,(%esp)
 1e3:	e8 fc 00 00 00       	call   2e4 <fstat>
 1e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ee:	89 04 24             	mov    %eax,(%esp)
 1f1:	e8 be 00 00 00       	call   2b4 <close>
  return r;
 1f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f9:	c9                   	leave  
 1fa:	c3                   	ret    

000001fb <atoi>:

int
atoi(const char *s)
{
 1fb:	55                   	push   %ebp
 1fc:	89 e5                	mov    %esp,%ebp
 1fe:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 201:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 208:	eb 23                	jmp    22d <atoi+0x32>
    n = n*10 + *s++ - '0';
 20a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20d:	89 d0                	mov    %edx,%eax
 20f:	c1 e0 02             	shl    $0x2,%eax
 212:	01 d0                	add    %edx,%eax
 214:	01 c0                	add    %eax,%eax
 216:	89 c2                	mov    %eax,%edx
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	0f b6 00             	movzbl (%eax),%eax
 21e:	0f be c0             	movsbl %al,%eax
 221:	01 d0                	add    %edx,%eax
 223:	83 e8 30             	sub    $0x30,%eax
 226:	89 45 fc             	mov    %eax,-0x4(%ebp)
 229:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	3c 2f                	cmp    $0x2f,%al
 235:	7e 0a                	jle    241 <atoi+0x46>
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	0f b6 00             	movzbl (%eax),%eax
 23d:	3c 39                	cmp    $0x39,%al
 23f:	7e c9                	jle    20a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 241:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 244:	c9                   	leave  
 245:	c3                   	ret    

00000246 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 246:	55                   	push   %ebp
 247:	89 e5                	mov    %esp,%ebp
 249:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 252:	8b 45 0c             	mov    0xc(%ebp),%eax
 255:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 258:	eb 13                	jmp    26d <memmove+0x27>
    *dst++ = *src++;
 25a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 25d:	0f b6 10             	movzbl (%eax),%edx
 260:	8b 45 fc             	mov    -0x4(%ebp),%eax
 263:	88 10                	mov    %dl,(%eax)
 265:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 269:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 271:	0f 9f c0             	setg   %al
 274:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 278:	84 c0                	test   %al,%al
 27a:	75 de                	jne    25a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27f:	c9                   	leave  
 280:	c3                   	ret    
 281:	90                   	nop
 282:	90                   	nop
 283:	90                   	nop

00000284 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 284:	b8 01 00 00 00       	mov    $0x1,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <exit>:
SYSCALL(exit)
 28c:	b8 02 00 00 00       	mov    $0x2,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <wait>:
SYSCALL(wait)
 294:	b8 03 00 00 00       	mov    $0x3,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <pipe>:
SYSCALL(pipe)
 29c:	b8 04 00 00 00       	mov    $0x4,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <read>:
SYSCALL(read)
 2a4:	b8 05 00 00 00       	mov    $0x5,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <write>:
SYSCALL(write)
 2ac:	b8 10 00 00 00       	mov    $0x10,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <close>:
SYSCALL(close)
 2b4:	b8 15 00 00 00       	mov    $0x15,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <kill>:
SYSCALL(kill)
 2bc:	b8 06 00 00 00       	mov    $0x6,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <exec>:
SYSCALL(exec)
 2c4:	b8 07 00 00 00       	mov    $0x7,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <open>:
SYSCALL(open)
 2cc:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <mknod>:
SYSCALL(mknod)
 2d4:	b8 11 00 00 00       	mov    $0x11,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <unlink>:
SYSCALL(unlink)
 2dc:	b8 12 00 00 00       	mov    $0x12,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <fstat>:
SYSCALL(fstat)
 2e4:	b8 08 00 00 00       	mov    $0x8,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <link>:
SYSCALL(link)
 2ec:	b8 13 00 00 00       	mov    $0x13,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <mkdir>:
SYSCALL(mkdir)
 2f4:	b8 14 00 00 00       	mov    $0x14,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <chdir>:
SYSCALL(chdir)
 2fc:	b8 09 00 00 00       	mov    $0x9,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <dup>:
SYSCALL(dup)
 304:	b8 0a 00 00 00       	mov    $0xa,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <getpid>:
SYSCALL(getpid)
 30c:	b8 0b 00 00 00       	mov    $0xb,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <sbrk>:
SYSCALL(sbrk)
 314:	b8 0c 00 00 00       	mov    $0xc,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <sleep>:
SYSCALL(sleep)
 31c:	b8 0d 00 00 00       	mov    $0xd,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <uptime>:
SYSCALL(uptime)
 324:	b8 0e 00 00 00       	mov    $0xe,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <getppid>:
SYSCALL(getppid)
 32c:	b8 16 00 00 00       	mov    $0x16,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	83 ec 28             	sub    $0x28,%esp
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 340:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 347:	00 
 348:	8d 45 f4             	lea    -0xc(%ebp),%eax
 34b:	89 44 24 04          	mov    %eax,0x4(%esp)
 34f:	8b 45 08             	mov    0x8(%ebp),%eax
 352:	89 04 24             	mov    %eax,(%esp)
 355:	e8 52 ff ff ff       	call   2ac <write>
}
 35a:	c9                   	leave  
 35b:	c3                   	ret    

0000035c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 35c:	55                   	push   %ebp
 35d:	89 e5                	mov    %esp,%ebp
 35f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 362:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 369:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 36d:	74 17                	je     386 <printint+0x2a>
 36f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 373:	79 11                	jns    386 <printint+0x2a>
    neg = 1;
 375:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 37c:	8b 45 0c             	mov    0xc(%ebp),%eax
 37f:	f7 d8                	neg    %eax
 381:	89 45 ec             	mov    %eax,-0x14(%ebp)
 384:	eb 06                	jmp    38c <printint+0x30>
  } else {
    x = xx;
 386:	8b 45 0c             	mov    0xc(%ebp),%eax
 389:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 38c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 393:	8b 4d 10             	mov    0x10(%ebp),%ecx
 396:	8b 45 ec             	mov    -0x14(%ebp),%eax
 399:	ba 00 00 00 00       	mov    $0x0,%edx
 39e:	f7 f1                	div    %ecx
 3a0:	89 d0                	mov    %edx,%eax
 3a2:	0f b6 90 08 0b 00 00 	movzbl 0xb08(%eax),%edx
 3a9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3ac:	03 45 f4             	add    -0xc(%ebp),%eax
 3af:	88 10                	mov    %dl,(%eax)
 3b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3b5:	8b 55 10             	mov    0x10(%ebp),%edx
 3b8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3be:	ba 00 00 00 00       	mov    $0x0,%edx
 3c3:	f7 75 d4             	divl   -0x2c(%ebp)
 3c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3cd:	75 c4                	jne    393 <printint+0x37>
  if(neg)
 3cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3d3:	74 2a                	je     3ff <printint+0xa3>
    buf[i++] = '-';
 3d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3d8:	03 45 f4             	add    -0xc(%ebp),%eax
 3db:	c6 00 2d             	movb   $0x2d,(%eax)
 3de:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 3e2:	eb 1b                	jmp    3ff <printint+0xa3>
    putc(fd, buf[i]);
 3e4:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3e7:	03 45 f4             	add    -0xc(%ebp),%eax
 3ea:	0f b6 00             	movzbl (%eax),%eax
 3ed:	0f be c0             	movsbl %al,%eax
 3f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	89 04 24             	mov    %eax,(%esp)
 3fa:	e8 35 ff ff ff       	call   334 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ff:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 403:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 407:	79 db                	jns    3e4 <printint+0x88>
    putc(fd, buf[i]);
}
 409:	c9                   	leave  
 40a:	c3                   	ret    

0000040b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 40b:	55                   	push   %ebp
 40c:	89 e5                	mov    %esp,%ebp
 40e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 411:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 418:	8d 45 0c             	lea    0xc(%ebp),%eax
 41b:	83 c0 04             	add    $0x4,%eax
 41e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 421:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 428:	e9 7d 01 00 00       	jmp    5aa <printf+0x19f>
    c = fmt[i] & 0xff;
 42d:	8b 55 0c             	mov    0xc(%ebp),%edx
 430:	8b 45 f0             	mov    -0x10(%ebp),%eax
 433:	01 d0                	add    %edx,%eax
 435:	0f b6 00             	movzbl (%eax),%eax
 438:	0f be c0             	movsbl %al,%eax
 43b:	25 ff 00 00 00       	and    $0xff,%eax
 440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 443:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 447:	75 2c                	jne    475 <printf+0x6a>
      if(c == '%'){
 449:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 44d:	75 0c                	jne    45b <printf+0x50>
        state = '%';
 44f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 456:	e9 4b 01 00 00       	jmp    5a6 <printf+0x19b>
      } else {
        putc(fd, c);
 45b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 45e:	0f be c0             	movsbl %al,%eax
 461:	89 44 24 04          	mov    %eax,0x4(%esp)
 465:	8b 45 08             	mov    0x8(%ebp),%eax
 468:	89 04 24             	mov    %eax,(%esp)
 46b:	e8 c4 fe ff ff       	call   334 <putc>
 470:	e9 31 01 00 00       	jmp    5a6 <printf+0x19b>
      }
    } else if(state == '%'){
 475:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 479:	0f 85 27 01 00 00    	jne    5a6 <printf+0x19b>
      if(c == 'd'){
 47f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 483:	75 2d                	jne    4b2 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 485:	8b 45 e8             	mov    -0x18(%ebp),%eax
 488:	8b 00                	mov    (%eax),%eax
 48a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 491:	00 
 492:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 499:	00 
 49a:	89 44 24 04          	mov    %eax,0x4(%esp)
 49e:	8b 45 08             	mov    0x8(%ebp),%eax
 4a1:	89 04 24             	mov    %eax,(%esp)
 4a4:	e8 b3 fe ff ff       	call   35c <printint>
        ap++;
 4a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ad:	e9 ed 00 00 00       	jmp    59f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4b2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4b6:	74 06                	je     4be <printf+0xb3>
 4b8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4bc:	75 2d                	jne    4eb <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4be:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c1:	8b 00                	mov    (%eax),%eax
 4c3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4ca:	00 
 4cb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4d2:	00 
 4d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d7:	8b 45 08             	mov    0x8(%ebp),%eax
 4da:	89 04 24             	mov    %eax,(%esp)
 4dd:	e8 7a fe ff ff       	call   35c <printint>
        ap++;
 4e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e6:	e9 b4 00 00 00       	jmp    59f <printf+0x194>
      } else if(c == 's'){
 4eb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4ef:	75 46                	jne    537 <printf+0x12c>
        s = (char*)*ap;
 4f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f4:	8b 00                	mov    (%eax),%eax
 4f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 501:	75 27                	jne    52a <printf+0x11f>
          s = "(null)";
 503:	c7 45 f4 67 08 00 00 	movl   $0x867,-0xc(%ebp)
        while(*s != 0){
 50a:	eb 1e                	jmp    52a <printf+0x11f>
          putc(fd, *s);
 50c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50f:	0f b6 00             	movzbl (%eax),%eax
 512:	0f be c0             	movsbl %al,%eax
 515:	89 44 24 04          	mov    %eax,0x4(%esp)
 519:	8b 45 08             	mov    0x8(%ebp),%eax
 51c:	89 04 24             	mov    %eax,(%esp)
 51f:	e8 10 fe ff ff       	call   334 <putc>
          s++;
 524:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 528:	eb 01                	jmp    52b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 52a:	90                   	nop
 52b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52e:	0f b6 00             	movzbl (%eax),%eax
 531:	84 c0                	test   %al,%al
 533:	75 d7                	jne    50c <printf+0x101>
 535:	eb 68                	jmp    59f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 537:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 53b:	75 1d                	jne    55a <printf+0x14f>
        putc(fd, *ap);
 53d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 540:	8b 00                	mov    (%eax),%eax
 542:	0f be c0             	movsbl %al,%eax
 545:	89 44 24 04          	mov    %eax,0x4(%esp)
 549:	8b 45 08             	mov    0x8(%ebp),%eax
 54c:	89 04 24             	mov    %eax,(%esp)
 54f:	e8 e0 fd ff ff       	call   334 <putc>
        ap++;
 554:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 558:	eb 45                	jmp    59f <printf+0x194>
      } else if(c == '%'){
 55a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 55e:	75 17                	jne    577 <printf+0x16c>
        putc(fd, c);
 560:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 563:	0f be c0             	movsbl %al,%eax
 566:	89 44 24 04          	mov    %eax,0x4(%esp)
 56a:	8b 45 08             	mov    0x8(%ebp),%eax
 56d:	89 04 24             	mov    %eax,(%esp)
 570:	e8 bf fd ff ff       	call   334 <putc>
 575:	eb 28                	jmp    59f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 577:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 57e:	00 
 57f:	8b 45 08             	mov    0x8(%ebp),%eax
 582:	89 04 24             	mov    %eax,(%esp)
 585:	e8 aa fd ff ff       	call   334 <putc>
        putc(fd, c);
 58a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	89 44 24 04          	mov    %eax,0x4(%esp)
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	89 04 24             	mov    %eax,(%esp)
 59a:	e8 95 fd ff ff       	call   334 <putc>
      }
      state = 0;
 59f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5aa:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b0:	01 d0                	add    %edx,%eax
 5b2:	0f b6 00             	movzbl (%eax),%eax
 5b5:	84 c0                	test   %al,%al
 5b7:	0f 85 70 fe ff ff    	jne    42d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5bd:	c9                   	leave  
 5be:	c3                   	ret    
 5bf:	90                   	nop

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
 5c9:	83 e8 08             	sub    $0x8,%eax
 5cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5cf:	a1 24 0b 00 00       	mov    0xb24,%eax
 5d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5d7:	eb 24                	jmp    5fd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e1:	77 12                	ja     5f5 <free+0x35>
 5e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e9:	77 24                	ja     60f <free+0x4f>
 5eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ee:	8b 00                	mov    (%eax),%eax
 5f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f3:	77 1a                	ja     60f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f8:	8b 00                	mov    (%eax),%eax
 5fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 600:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 603:	76 d4                	jbe    5d9 <free+0x19>
 605:	8b 45 fc             	mov    -0x4(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60d:	76 ca                	jbe    5d9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 612:	8b 40 04             	mov    0x4(%eax),%eax
 615:	c1 e0 03             	shl    $0x3,%eax
 618:	89 c2                	mov    %eax,%edx
 61a:	03 55 f8             	add    -0x8(%ebp),%edx
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	39 c2                	cmp    %eax,%edx
 624:	75 24                	jne    64a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	8b 50 04             	mov    0x4(%eax),%edx
 62c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	8b 40 04             	mov    0x4(%eax),%eax
 634:	01 c2                	add    %eax,%edx
 636:	8b 45 f8             	mov    -0x8(%ebp),%eax
 639:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 00                	mov    (%eax),%eax
 641:	8b 10                	mov    (%eax),%edx
 643:	8b 45 f8             	mov    -0x8(%ebp),%eax
 646:	89 10                	mov    %edx,(%eax)
 648:	eb 0a                	jmp    654 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 64a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64d:	8b 10                	mov    (%eax),%edx
 64f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 652:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 654:	8b 45 fc             	mov    -0x4(%ebp),%eax
 657:	8b 40 04             	mov    0x4(%eax),%eax
 65a:	c1 e0 03             	shl    $0x3,%eax
 65d:	03 45 fc             	add    -0x4(%ebp),%eax
 660:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 663:	75 20                	jne    685 <free+0xc5>
    p->s.size += bp->s.size;
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 50 04             	mov    0x4(%eax),%edx
 66b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66e:	8b 40 04             	mov    0x4(%eax),%eax
 671:	01 c2                	add    %eax,%edx
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 679:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67c:	8b 10                	mov    (%eax),%edx
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	89 10                	mov    %edx,(%eax)
 683:	eb 08                	jmp    68d <free+0xcd>
  } else
    p->s.ptr = bp;
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 55 f8             	mov    -0x8(%ebp),%edx
 68b:	89 10                	mov    %edx,(%eax)
  freep = p;
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	a3 24 0b 00 00       	mov    %eax,0xb24
}
 695:	c9                   	leave  
 696:	c3                   	ret    

00000697 <morecore>:

static Header*
morecore(uint nu)
{
 697:	55                   	push   %ebp
 698:	89 e5                	mov    %esp,%ebp
 69a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 69d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6a4:	77 07                	ja     6ad <morecore+0x16>
    nu = 4096;
 6a6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6ad:	8b 45 08             	mov    0x8(%ebp),%eax
 6b0:	c1 e0 03             	shl    $0x3,%eax
 6b3:	89 04 24             	mov    %eax,(%esp)
 6b6:	e8 59 fc ff ff       	call   314 <sbrk>
 6bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6be:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6c2:	75 07                	jne    6cb <morecore+0x34>
    return 0;
 6c4:	b8 00 00 00 00       	mov    $0x0,%eax
 6c9:	eb 22                	jmp    6ed <morecore+0x56>
  hp = (Header*)p;
 6cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d4:	8b 55 08             	mov    0x8(%ebp),%edx
 6d7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6dd:	83 c0 08             	add    $0x8,%eax
 6e0:	89 04 24             	mov    %eax,(%esp)
 6e3:	e8 d8 fe ff ff       	call   5c0 <free>
  return freep;
 6e8:	a1 24 0b 00 00       	mov    0xb24,%eax
}
 6ed:	c9                   	leave  
 6ee:	c3                   	ret    

000006ef <malloc>:

void*
malloc(uint nbytes)
{
 6ef:	55                   	push   %ebp
 6f0:	89 e5                	mov    %esp,%ebp
 6f2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f5:	8b 45 08             	mov    0x8(%ebp),%eax
 6f8:	83 c0 07             	add    $0x7,%eax
 6fb:	c1 e8 03             	shr    $0x3,%eax
 6fe:	83 c0 01             	add    $0x1,%eax
 701:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 704:	a1 24 0b 00 00       	mov    0xb24,%eax
 709:	89 45 f0             	mov    %eax,-0x10(%ebp)
 70c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 710:	75 23                	jne    735 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 712:	c7 45 f0 1c 0b 00 00 	movl   $0xb1c,-0x10(%ebp)
 719:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71c:	a3 24 0b 00 00       	mov    %eax,0xb24
 721:	a1 24 0b 00 00       	mov    0xb24,%eax
 726:	a3 1c 0b 00 00       	mov    %eax,0xb1c
    base.s.size = 0;
 72b:	c7 05 20 0b 00 00 00 	movl   $0x0,0xb20
 732:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 735:	8b 45 f0             	mov    -0x10(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 73d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 740:	8b 40 04             	mov    0x4(%eax),%eax
 743:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 746:	72 4d                	jb     795 <malloc+0xa6>
      if(p->s.size == nunits)
 748:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74b:	8b 40 04             	mov    0x4(%eax),%eax
 74e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 751:	75 0c                	jne    75f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 753:	8b 45 f4             	mov    -0xc(%ebp),%eax
 756:	8b 10                	mov    (%eax),%edx
 758:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75b:	89 10                	mov    %edx,(%eax)
 75d:	eb 26                	jmp    785 <malloc+0x96>
      else {
        p->s.size -= nunits;
 75f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 762:	8b 40 04             	mov    0x4(%eax),%eax
 765:	89 c2                	mov    %eax,%edx
 767:	2b 55 ec             	sub    -0x14(%ebp),%edx
 76a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 770:	8b 45 f4             	mov    -0xc(%ebp),%eax
 773:	8b 40 04             	mov    0x4(%eax),%eax
 776:	c1 e0 03             	shl    $0x3,%eax
 779:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 77c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 782:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 785:	8b 45 f0             	mov    -0x10(%ebp),%eax
 788:	a3 24 0b 00 00       	mov    %eax,0xb24
      return (void*)(p + 1);
 78d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 790:	83 c0 08             	add    $0x8,%eax
 793:	eb 38                	jmp    7cd <malloc+0xde>
    }
    if(p == freep)
 795:	a1 24 0b 00 00       	mov    0xb24,%eax
 79a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 79d:	75 1b                	jne    7ba <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 79f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7a2:	89 04 24             	mov    %eax,(%esp)
 7a5:	e8 ed fe ff ff       	call   697 <morecore>
 7aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b1:	75 07                	jne    7ba <malloc+0xcb>
        return 0;
 7b3:	b8 00 00 00 00       	mov    $0x0,%eax
 7b8:	eb 13                	jmp    7cd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c3:	8b 00                	mov    (%eax),%eax
 7c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7c8:	e9 70 ff ff ff       	jmp    73d <malloc+0x4e>
}
 7cd:	c9                   	leave  
 7ce:	c3                   	ret    
 7cf:	90                   	nop

000007d0 <parent>:
#include "types.h"
#include "stat.h"
#include "user.h"

void parent(void) {
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	53                   	push   %ebx
 7d4:	83 ec 24             	sub    $0x24,%esp

	int retval;

        if((retval = fork()) < 0){
 7d7:	e8 a8 fa ff ff       	call   284 <fork>
 7dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e3:	79 16                	jns    7fb <parent+0x2b>
                printf(1, "FORK FAILED!!!");
 7e5:	c7 44 24 04 6e 08 00 	movl   $0x86e,0x4(%esp)
 7ec:	00 
 7ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7f4:	e8 12 fc ff ff       	call   40b <printf>
 7f9:	eb 59                	jmp    854 <parent+0x84>
        }else if(retval > 0){
 7fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7ff:	7e 2b                	jle    82c <parent+0x5c>
                printf(1, "Me: %d MyChild: %d\n", getpid(), retval);
 801:	e8 06 fb ff ff       	call   30c <getpid>
 806:	8b 55 f4             	mov    -0xc(%ebp),%edx
 809:	89 54 24 0c          	mov    %edx,0xc(%esp)
 80d:	89 44 24 08          	mov    %eax,0x8(%esp)
 811:	c7 44 24 04 7d 08 00 	movl   $0x87d,0x4(%esp)
 818:	00 
 819:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 820:	e8 e6 fb ff ff       	call   40b <printf>
                wait();
 825:	e8 6a fa ff ff       	call   294 <wait>
 82a:	eb 28                	jmp    854 <parent+0x84>
        } else {
                printf(1, "Me: %d MyParent: %d\n", getpid(), getppid());
 82c:	e8 fb fa ff ff       	call   32c <getppid>
 831:	89 c3                	mov    %eax,%ebx
 833:	e8 d4 fa ff ff       	call   30c <getpid>
 838:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 83c:	89 44 24 08          	mov    %eax,0x8(%esp)
 840:	c7 44 24 04 91 08 00 	movl   $0x891,0x4(%esp)
 847:	00 
 848:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 84f:	e8 b7 fb ff ff       	call   40b <printf>
        }

}
 854:	83 c4 24             	add    $0x24,%esp
 857:	5b                   	pop    %ebx
 858:	5d                   	pop    %ebp
 859:	c3                   	ret    
