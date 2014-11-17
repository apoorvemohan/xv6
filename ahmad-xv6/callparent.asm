
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
   9:	e8 ca 07 00 00       	call   7d8 <parent>
printf(1, "Hello World\n");
   e:	c7 44 24 04 87 08 00 	movl   $0x887,0x4(%esp)
  15:	00 
  16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1d:	e8 f1 03 00 00       	call   413 <printf>
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

00000334 <createThread>:
SYSCALL(createThread)
 334:	b8 17 00 00 00       	mov    $0x17,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 33c:	55                   	push   %ebp
 33d:	89 e5                	mov    %esp,%ebp
 33f:	83 ec 28             	sub    $0x28,%esp
 342:	8b 45 0c             	mov    0xc(%ebp),%eax
 345:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 348:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 34f:	00 
 350:	8d 45 f4             	lea    -0xc(%ebp),%eax
 353:	89 44 24 04          	mov    %eax,0x4(%esp)
 357:	8b 45 08             	mov    0x8(%ebp),%eax
 35a:	89 04 24             	mov    %eax,(%esp)
 35d:	e8 4a ff ff ff       	call   2ac <write>
}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 36a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 371:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 375:	74 17                	je     38e <printint+0x2a>
 377:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 37b:	79 11                	jns    38e <printint+0x2a>
    neg = 1;
 37d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 384:	8b 45 0c             	mov    0xc(%ebp),%eax
 387:	f7 d8                	neg    %eax
 389:	89 45 ec             	mov    %eax,-0x14(%ebp)
 38c:	eb 06                	jmp    394 <printint+0x30>
  } else {
    x = xx;
 38e:	8b 45 0c             	mov    0xc(%ebp),%eax
 391:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 394:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 39b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3a1:	ba 00 00 00 00       	mov    $0x0,%edx
 3a6:	f7 f1                	div    %ecx
 3a8:	89 d0                	mov    %edx,%eax
 3aa:	0f b6 90 60 0b 00 00 	movzbl 0xb60(%eax),%edx
 3b1:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3b4:	03 45 f4             	add    -0xc(%ebp),%eax
 3b7:	88 10                	mov    %dl,(%eax)
 3b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3bd:	8b 55 10             	mov    0x10(%ebp),%edx
 3c0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c6:	ba 00 00 00 00       	mov    $0x0,%edx
 3cb:	f7 75 d4             	divl   -0x2c(%ebp)
 3ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3d5:	75 c4                	jne    39b <printint+0x37>
  if(neg)
 3d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3db:	74 2a                	je     407 <printint+0xa3>
    buf[i++] = '-';
 3dd:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3e0:	03 45 f4             	add    -0xc(%ebp),%eax
 3e3:	c6 00 2d             	movb   $0x2d,(%eax)
 3e6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 3ea:	eb 1b                	jmp    407 <printint+0xa3>
    putc(fd, buf[i]);
 3ec:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3ef:	03 45 f4             	add    -0xc(%ebp),%eax
 3f2:	0f b6 00             	movzbl (%eax),%eax
 3f5:	0f be c0             	movsbl %al,%eax
 3f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fc:	8b 45 08             	mov    0x8(%ebp),%eax
 3ff:	89 04 24             	mov    %eax,(%esp)
 402:	e8 35 ff ff ff       	call   33c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 407:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 40b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 40f:	79 db                	jns    3ec <printint+0x88>
    putc(fd, buf[i]);
}
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 413:	55                   	push   %ebp
 414:	89 e5                	mov    %esp,%ebp
 416:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 419:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 420:	8d 45 0c             	lea    0xc(%ebp),%eax
 423:	83 c0 04             	add    $0x4,%eax
 426:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 429:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 430:	e9 7d 01 00 00       	jmp    5b2 <printf+0x19f>
    c = fmt[i] & 0xff;
 435:	8b 55 0c             	mov    0xc(%ebp),%edx
 438:	8b 45 f0             	mov    -0x10(%ebp),%eax
 43b:	01 d0                	add    %edx,%eax
 43d:	0f b6 00             	movzbl (%eax),%eax
 440:	0f be c0             	movsbl %al,%eax
 443:	25 ff 00 00 00       	and    $0xff,%eax
 448:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 44b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 44f:	75 2c                	jne    47d <printf+0x6a>
      if(c == '%'){
 451:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 455:	75 0c                	jne    463 <printf+0x50>
        state = '%';
 457:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 45e:	e9 4b 01 00 00       	jmp    5ae <printf+0x19b>
      } else {
        putc(fd, c);
 463:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 466:	0f be c0             	movsbl %al,%eax
 469:	89 44 24 04          	mov    %eax,0x4(%esp)
 46d:	8b 45 08             	mov    0x8(%ebp),%eax
 470:	89 04 24             	mov    %eax,(%esp)
 473:	e8 c4 fe ff ff       	call   33c <putc>
 478:	e9 31 01 00 00       	jmp    5ae <printf+0x19b>
      }
    } else if(state == '%'){
 47d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 481:	0f 85 27 01 00 00    	jne    5ae <printf+0x19b>
      if(c == 'd'){
 487:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 48b:	75 2d                	jne    4ba <printf+0xa7>
        printint(fd, *ap, 10, 1);
 48d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 490:	8b 00                	mov    (%eax),%eax
 492:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 499:	00 
 49a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4a1:	00 
 4a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
 4a9:	89 04 24             	mov    %eax,(%esp)
 4ac:	e8 b3 fe ff ff       	call   364 <printint>
        ap++;
 4b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b5:	e9 ed 00 00 00       	jmp    5a7 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4ba:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4be:	74 06                	je     4c6 <printf+0xb3>
 4c0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c4:	75 2d                	jne    4f3 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c9:	8b 00                	mov    (%eax),%eax
 4cb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4d2:	00 
 4d3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4da:	00 
 4db:	89 44 24 04          	mov    %eax,0x4(%esp)
 4df:	8b 45 08             	mov    0x8(%ebp),%eax
 4e2:	89 04 24             	mov    %eax,(%esp)
 4e5:	e8 7a fe ff ff       	call   364 <printint>
        ap++;
 4ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ee:	e9 b4 00 00 00       	jmp    5a7 <printf+0x194>
      } else if(c == 's'){
 4f3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4f7:	75 46                	jne    53f <printf+0x12c>
        s = (char*)*ap;
 4f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4fc:	8b 00                	mov    (%eax),%eax
 4fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 501:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 505:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 509:	75 27                	jne    532 <printf+0x11f>
          s = "(null)";
 50b:	c7 45 f4 94 08 00 00 	movl   $0x894,-0xc(%ebp)
        while(*s != 0){
 512:	eb 1e                	jmp    532 <printf+0x11f>
          putc(fd, *s);
 514:	8b 45 f4             	mov    -0xc(%ebp),%eax
 517:	0f b6 00             	movzbl (%eax),%eax
 51a:	0f be c0             	movsbl %al,%eax
 51d:	89 44 24 04          	mov    %eax,0x4(%esp)
 521:	8b 45 08             	mov    0x8(%ebp),%eax
 524:	89 04 24             	mov    %eax,(%esp)
 527:	e8 10 fe ff ff       	call   33c <putc>
          s++;
 52c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 530:	eb 01                	jmp    533 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 532:	90                   	nop
 533:	8b 45 f4             	mov    -0xc(%ebp),%eax
 536:	0f b6 00             	movzbl (%eax),%eax
 539:	84 c0                	test   %al,%al
 53b:	75 d7                	jne    514 <printf+0x101>
 53d:	eb 68                	jmp    5a7 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 543:	75 1d                	jne    562 <printf+0x14f>
        putc(fd, *ap);
 545:	8b 45 e8             	mov    -0x18(%ebp),%eax
 548:	8b 00                	mov    (%eax),%eax
 54a:	0f be c0             	movsbl %al,%eax
 54d:	89 44 24 04          	mov    %eax,0x4(%esp)
 551:	8b 45 08             	mov    0x8(%ebp),%eax
 554:	89 04 24             	mov    %eax,(%esp)
 557:	e8 e0 fd ff ff       	call   33c <putc>
        ap++;
 55c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 560:	eb 45                	jmp    5a7 <printf+0x194>
      } else if(c == '%'){
 562:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 566:	75 17                	jne    57f <printf+0x16c>
        putc(fd, c);
 568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56b:	0f be c0             	movsbl %al,%eax
 56e:	89 44 24 04          	mov    %eax,0x4(%esp)
 572:	8b 45 08             	mov    0x8(%ebp),%eax
 575:	89 04 24             	mov    %eax,(%esp)
 578:	e8 bf fd ff ff       	call   33c <putc>
 57d:	eb 28                	jmp    5a7 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 57f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 586:	00 
 587:	8b 45 08             	mov    0x8(%ebp),%eax
 58a:	89 04 24             	mov    %eax,(%esp)
 58d:	e8 aa fd ff ff       	call   33c <putc>
        putc(fd, c);
 592:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 595:	0f be c0             	movsbl %al,%eax
 598:	89 44 24 04          	mov    %eax,0x4(%esp)
 59c:	8b 45 08             	mov    0x8(%ebp),%eax
 59f:	89 04 24             	mov    %eax,(%esp)
 5a2:	e8 95 fd ff ff       	call   33c <putc>
      }
      state = 0;
 5a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ae:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5b2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b8:	01 d0                	add    %edx,%eax
 5ba:	0f b6 00             	movzbl (%eax),%eax
 5bd:	84 c0                	test   %al,%al
 5bf:	0f 85 70 fe ff ff    	jne    435 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c5:	c9                   	leave  
 5c6:	c3                   	ret    
 5c7:	90                   	nop

000005c8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c8:	55                   	push   %ebp
 5c9:	89 e5                	mov    %esp,%ebp
 5cb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5ce:	8b 45 08             	mov    0x8(%ebp),%eax
 5d1:	83 e8 08             	sub    $0x8,%eax
 5d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d7:	a1 7c 0b 00 00       	mov    0xb7c,%eax
 5dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5df:	eb 24                	jmp    605 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e4:	8b 00                	mov    (%eax),%eax
 5e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e9:	77 12                	ja     5fd <free+0x35>
 5eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f1:	77 24                	ja     617 <free+0x4f>
 5f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f6:	8b 00                	mov    (%eax),%eax
 5f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5fb:	77 1a                	ja     617 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 600:	8b 00                	mov    (%eax),%eax
 602:	89 45 fc             	mov    %eax,-0x4(%ebp)
 605:	8b 45 f8             	mov    -0x8(%ebp),%eax
 608:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 60b:	76 d4                	jbe    5e1 <free+0x19>
 60d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 615:	76 ca                	jbe    5e1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 617:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61a:	8b 40 04             	mov    0x4(%eax),%eax
 61d:	c1 e0 03             	shl    $0x3,%eax
 620:	89 c2                	mov    %eax,%edx
 622:	03 55 f8             	add    -0x8(%ebp),%edx
 625:	8b 45 fc             	mov    -0x4(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	39 c2                	cmp    %eax,%edx
 62c:	75 24                	jne    652 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 62e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 631:	8b 50 04             	mov    0x4(%eax),%edx
 634:	8b 45 fc             	mov    -0x4(%ebp),%eax
 637:	8b 00                	mov    (%eax),%eax
 639:	8b 40 04             	mov    0x4(%eax),%eax
 63c:	01 c2                	add    %eax,%edx
 63e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 641:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 644:	8b 45 fc             	mov    -0x4(%ebp),%eax
 647:	8b 00                	mov    (%eax),%eax
 649:	8b 10                	mov    (%eax),%edx
 64b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64e:	89 10                	mov    %edx,(%eax)
 650:	eb 0a                	jmp    65c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 652:	8b 45 fc             	mov    -0x4(%ebp),%eax
 655:	8b 10                	mov    (%eax),%edx
 657:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	8b 40 04             	mov    0x4(%eax),%eax
 662:	c1 e0 03             	shl    $0x3,%eax
 665:	03 45 fc             	add    -0x4(%ebp),%eax
 668:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66b:	75 20                	jne    68d <free+0xc5>
    p->s.size += bp->s.size;
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 50 04             	mov    0x4(%eax),%edx
 673:	8b 45 f8             	mov    -0x8(%ebp),%eax
 676:	8b 40 04             	mov    0x4(%eax),%eax
 679:	01 c2                	add    %eax,%edx
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	8b 10                	mov    (%eax),%edx
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	89 10                	mov    %edx,(%eax)
 68b:	eb 08                	jmp    695 <free+0xcd>
  } else
    p->s.ptr = bp;
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 55 f8             	mov    -0x8(%ebp),%edx
 693:	89 10                	mov    %edx,(%eax)
  freep = p;
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	a3 7c 0b 00 00       	mov    %eax,0xb7c
}
 69d:	c9                   	leave  
 69e:	c3                   	ret    

0000069f <morecore>:

static Header*
morecore(uint nu)
{
 69f:	55                   	push   %ebp
 6a0:	89 e5                	mov    %esp,%ebp
 6a2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6a5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ac:	77 07                	ja     6b5 <morecore+0x16>
    nu = 4096;
 6ae:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6b5:	8b 45 08             	mov    0x8(%ebp),%eax
 6b8:	c1 e0 03             	shl    $0x3,%eax
 6bb:	89 04 24             	mov    %eax,(%esp)
 6be:	e8 51 fc ff ff       	call   314 <sbrk>
 6c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6c6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ca:	75 07                	jne    6d3 <morecore+0x34>
    return 0;
 6cc:	b8 00 00 00 00       	mov    $0x0,%eax
 6d1:	eb 22                	jmp    6f5 <morecore+0x56>
  hp = (Header*)p;
 6d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6dc:	8b 55 08             	mov    0x8(%ebp),%edx
 6df:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e5:	83 c0 08             	add    $0x8,%eax
 6e8:	89 04 24             	mov    %eax,(%esp)
 6eb:	e8 d8 fe ff ff       	call   5c8 <free>
  return freep;
 6f0:	a1 7c 0b 00 00       	mov    0xb7c,%eax
}
 6f5:	c9                   	leave  
 6f6:	c3                   	ret    

000006f7 <malloc>:

void*
malloc(uint nbytes)
{
 6f7:	55                   	push   %ebp
 6f8:	89 e5                	mov    %esp,%ebp
 6fa:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6fd:	8b 45 08             	mov    0x8(%ebp),%eax
 700:	83 c0 07             	add    $0x7,%eax
 703:	c1 e8 03             	shr    $0x3,%eax
 706:	83 c0 01             	add    $0x1,%eax
 709:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 70c:	a1 7c 0b 00 00       	mov    0xb7c,%eax
 711:	89 45 f0             	mov    %eax,-0x10(%ebp)
 714:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 718:	75 23                	jne    73d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 71a:	c7 45 f0 74 0b 00 00 	movl   $0xb74,-0x10(%ebp)
 721:	8b 45 f0             	mov    -0x10(%ebp),%eax
 724:	a3 7c 0b 00 00       	mov    %eax,0xb7c
 729:	a1 7c 0b 00 00       	mov    0xb7c,%eax
 72e:	a3 74 0b 00 00       	mov    %eax,0xb74
    base.s.size = 0;
 733:	c7 05 78 0b 00 00 00 	movl   $0x0,0xb78
 73a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 73d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 740:	8b 00                	mov    (%eax),%eax
 742:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 745:	8b 45 f4             	mov    -0xc(%ebp),%eax
 748:	8b 40 04             	mov    0x4(%eax),%eax
 74b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 74e:	72 4d                	jb     79d <malloc+0xa6>
      if(p->s.size == nunits)
 750:	8b 45 f4             	mov    -0xc(%ebp),%eax
 753:	8b 40 04             	mov    0x4(%eax),%eax
 756:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 759:	75 0c                	jne    767 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 75b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75e:	8b 10                	mov    (%eax),%edx
 760:	8b 45 f0             	mov    -0x10(%ebp),%eax
 763:	89 10                	mov    %edx,(%eax)
 765:	eb 26                	jmp    78d <malloc+0x96>
      else {
        p->s.size -= nunits;
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	8b 40 04             	mov    0x4(%eax),%eax
 76d:	89 c2                	mov    %eax,%edx
 76f:	2b 55 ec             	sub    -0x14(%ebp),%edx
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 778:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77b:	8b 40 04             	mov    0x4(%eax),%eax
 77e:	c1 e0 03             	shl    $0x3,%eax
 781:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 784:	8b 45 f4             	mov    -0xc(%ebp),%eax
 787:	8b 55 ec             	mov    -0x14(%ebp),%edx
 78a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 78d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 790:	a3 7c 0b 00 00       	mov    %eax,0xb7c
      return (void*)(p + 1);
 795:	8b 45 f4             	mov    -0xc(%ebp),%eax
 798:	83 c0 08             	add    $0x8,%eax
 79b:	eb 38                	jmp    7d5 <malloc+0xde>
    }
    if(p == freep)
 79d:	a1 7c 0b 00 00       	mov    0xb7c,%eax
 7a2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7a5:	75 1b                	jne    7c2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7aa:	89 04 24             	mov    %eax,(%esp)
 7ad:	e8 ed fe ff ff       	call   69f <morecore>
 7b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b9:	75 07                	jne    7c2 <malloc+0xcb>
        return 0;
 7bb:	b8 00 00 00 00       	mov    $0x0,%eax
 7c0:	eb 13                	jmp    7d5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	8b 00                	mov    (%eax),%eax
 7cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7d0:	e9 70 ff ff ff       	jmp    745 <malloc+0x4e>
}
 7d5:	c9                   	leave  
 7d6:	c3                   	ret    
 7d7:	90                   	nop

000007d8 <parent>:
#include "types.h"
#include "stat.h"
#include "user.h"

void parent(void) {
 7d8:	55                   	push   %ebp
 7d9:	89 e5                	mov    %esp,%ebp
 7db:	53                   	push   %ebx
 7dc:	83 ec 24             	sub    $0x24,%esp

	int retval;

        if((retval = fork()) < 0){
 7df:	e8 a0 fa ff ff       	call   284 <fork>
 7e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7eb:	79 16                	jns    803 <parent+0x2b>
                printf(1, "FORK FAILED!!!");
 7ed:	c7 44 24 04 9b 08 00 	movl   $0x89b,0x4(%esp)
 7f4:	00 
 7f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7fc:	e8 12 fc ff ff       	call   413 <printf>
 801:	eb 59                	jmp    85c <parent+0x84>
        }else if(retval > 0){
 803:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 807:	7e 2b                	jle    834 <parent+0x5c>
                printf(1, "Me: %d MyChild: %d\n", getpid(), retval);
 809:	e8 fe fa ff ff       	call   30c <getpid>
 80e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 811:	89 54 24 0c          	mov    %edx,0xc(%esp)
 815:	89 44 24 08          	mov    %eax,0x8(%esp)
 819:	c7 44 24 04 aa 08 00 	movl   $0x8aa,0x4(%esp)
 820:	00 
 821:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 828:	e8 e6 fb ff ff       	call   413 <printf>
                wait();
 82d:	e8 62 fa ff ff       	call   294 <wait>
 832:	eb 28                	jmp    85c <parent+0x84>
        } else {
                printf(1, "Me: %d MyParent: %d\n", getpid(), getppid());
 834:	e8 f3 fa ff ff       	call   32c <getppid>
 839:	89 c3                	mov    %eax,%ebx
 83b:	e8 cc fa ff ff       	call   30c <getpid>
 840:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 844:	89 44 24 08          	mov    %eax,0x8(%esp)
 848:	c7 44 24 04 be 08 00 	movl   $0x8be,0x4(%esp)
 84f:	00 
 850:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 857:	e8 b7 fb ff ff       	call   413 <printf>
        }

}
 85c:	83 c4 24             	add    $0x24,%esp
 85f:	5b                   	pop    %ebx
 860:	5d                   	pop    %ebp
 861:	c3                   	ret    

00000862 <ct>:

void ct(void){
 862:	55                   	push   %ebp
 863:	89 e5                	mov    %esp,%ebp
 865:	83 ec 18             	sub    $0x18,%esp

	printf(1, "In CT: %d\n", createThread());
 868:	e8 c7 fa ff ff       	call   334 <createThread>
 86d:	89 44 24 08          	mov    %eax,0x8(%esp)
 871:	c7 44 24 04 d3 08 00 	movl   $0x8d3,0x4(%esp)
 878:	00 
 879:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 880:	e8 8e fb ff ff       	call   413 <printf>
}
 885:	c9                   	leave  
 886:	c3                   	ret    
