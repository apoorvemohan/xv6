
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main()
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
hello();
   6:	e8 0d 03 00 00       	call   318 <hello>
return 0;
   b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10:	c9                   	leave  
  11:	c3                   	ret    
  12:	90                   	nop
  13:	90                   	nop

00000014 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  14:	55                   	push   %ebp
  15:	89 e5                	mov    %esp,%ebp
  17:	57                   	push   %edi
  18:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  19:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1c:	8b 55 10             	mov    0x10(%ebp),%edx
  1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  22:	89 cb                	mov    %ecx,%ebx
  24:	89 df                	mov    %ebx,%edi
  26:	89 d1                	mov    %edx,%ecx
  28:	fc                   	cld    
  29:	f3 aa                	rep stos %al,%es:(%edi)
  2b:	89 ca                	mov    %ecx,%edx
  2d:	89 fb                	mov    %edi,%ebx
  2f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  32:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  35:	5b                   	pop    %ebx
  36:	5f                   	pop    %edi
  37:	5d                   	pop    %ebp
  38:	c3                   	ret    

00000039 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  39:	55                   	push   %ebp
  3a:	89 e5                	mov    %esp,%ebp
  3c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  3f:	8b 45 08             	mov    0x8(%ebp),%eax
  42:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  45:	90                   	nop
  46:	8b 45 0c             	mov    0xc(%ebp),%eax
  49:	0f b6 10             	movzbl (%eax),%edx
  4c:	8b 45 08             	mov    0x8(%ebp),%eax
  4f:	88 10                	mov    %dl,(%eax)
  51:	8b 45 08             	mov    0x8(%ebp),%eax
  54:	0f b6 00             	movzbl (%eax),%eax
  57:	84 c0                	test   %al,%al
  59:	0f 95 c0             	setne  %al
  5c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  60:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  64:	84 c0                	test   %al,%al
  66:	75 de                	jne    46 <strcpy+0xd>
    ;
  return os;
  68:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  6b:	c9                   	leave  
  6c:	c3                   	ret    

0000006d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  6d:	55                   	push   %ebp
  6e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  70:	eb 08                	jmp    7a <strcmp+0xd>
    p++, q++;
  72:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  76:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7a:	8b 45 08             	mov    0x8(%ebp),%eax
  7d:	0f b6 00             	movzbl (%eax),%eax
  80:	84 c0                	test   %al,%al
  82:	74 10                	je     94 <strcmp+0x27>
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	0f b6 10             	movzbl (%eax),%edx
  8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  8d:	0f b6 00             	movzbl (%eax),%eax
  90:	38 c2                	cmp    %al,%dl
  92:	74 de                	je     72 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	0f b6 00             	movzbl (%eax),%eax
  9a:	0f b6 d0             	movzbl %al,%edx
  9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  a0:	0f b6 00             	movzbl (%eax),%eax
  a3:	0f b6 c0             	movzbl %al,%eax
  a6:	89 d1                	mov    %edx,%ecx
  a8:	29 c1                	sub    %eax,%ecx
  aa:	89 c8                	mov    %ecx,%eax
}
  ac:	5d                   	pop    %ebp
  ad:	c3                   	ret    

000000ae <strlen>:

uint
strlen(char *s)
{
  ae:	55                   	push   %ebp
  af:	89 e5                	mov    %esp,%ebp
  b1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  bb:	eb 04                	jmp    c1 <strlen+0x13>
  bd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  c4:	03 45 08             	add    0x8(%ebp),%eax
  c7:	0f b6 00             	movzbl (%eax),%eax
  ca:	84 c0                	test   %al,%al
  cc:	75 ef                	jne    bd <strlen+0xf>
    ;
  return n;
  ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d1:	c9                   	leave  
  d2:	c3                   	ret    

000000d3 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d3:	55                   	push   %ebp
  d4:	89 e5                	mov    %esp,%ebp
  d6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  d9:	8b 45 10             	mov    0x10(%ebp),%eax
  dc:	89 44 24 08          	mov    %eax,0x8(%esp)
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	89 44 24 04          	mov    %eax,0x4(%esp)
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
  ea:	89 04 24             	mov    %eax,(%esp)
  ed:	e8 22 ff ff ff       	call   14 <stosb>
  return dst;
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  f5:	c9                   	leave  
  f6:	c3                   	ret    

000000f7 <strchr>:

char*
strchr(const char *s, char c)
{
  f7:	55                   	push   %ebp
  f8:	89 e5                	mov    %esp,%ebp
  fa:	83 ec 04             	sub    $0x4,%esp
  fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 100:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 103:	eb 14                	jmp    119 <strchr+0x22>
    if(*s == c)
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 10e:	75 05                	jne    115 <strchr+0x1e>
      return (char*)s;
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	eb 13                	jmp    128 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 115:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	75 e2                	jne    105 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 123:	b8 00 00 00 00       	mov    $0x0,%eax
}
 128:	c9                   	leave  
 129:	c3                   	ret    

0000012a <gets>:

char*
gets(char *buf, int max)
{
 12a:	55                   	push   %ebp
 12b:	89 e5                	mov    %esp,%ebp
 12d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 130:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 137:	eb 44                	jmp    17d <gets+0x53>
    cc = read(0, &c, 1);
 139:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 140:	00 
 141:	8d 45 ef             	lea    -0x11(%ebp),%eax
 144:	89 44 24 04          	mov    %eax,0x4(%esp)
 148:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 14f:	e8 3c 01 00 00       	call   290 <read>
 154:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 157:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 15b:	7e 2d                	jle    18a <gets+0x60>
      break;
    buf[i++] = c;
 15d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 160:	03 45 08             	add    0x8(%ebp),%eax
 163:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 167:	88 10                	mov    %dl,(%eax)
 169:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 16d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 171:	3c 0a                	cmp    $0xa,%al
 173:	74 16                	je     18b <gets+0x61>
 175:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 179:	3c 0d                	cmp    $0xd,%al
 17b:	74 0e                	je     18b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 180:	83 c0 01             	add    $0x1,%eax
 183:	3b 45 0c             	cmp    0xc(%ebp),%eax
 186:	7c b1                	jl     139 <gets+0xf>
 188:	eb 01                	jmp    18b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 18a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 18b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18e:	03 45 08             	add    0x8(%ebp),%eax
 191:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 194:	8b 45 08             	mov    0x8(%ebp),%eax
}
 197:	c9                   	leave  
 198:	c3                   	ret    

00000199 <stat>:

int
stat(char *n, struct stat *st)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1a6:	00 
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	89 04 24             	mov    %eax,(%esp)
 1ad:	e8 06 01 00 00       	call   2b8 <open>
 1b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1b9:	79 07                	jns    1c2 <stat+0x29>
    return -1;
 1bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c0:	eb 23                	jmp    1e5 <stat+0x4c>
  r = fstat(fd, st);
 1c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1cc:	89 04 24             	mov    %eax,(%esp)
 1cf:	e8 fc 00 00 00       	call   2d0 <fstat>
 1d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1da:	89 04 24             	mov    %eax,(%esp)
 1dd:	e8 be 00 00 00       	call   2a0 <close>
  return r;
 1e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1e5:	c9                   	leave  
 1e6:	c3                   	ret    

000001e7 <atoi>:

int
atoi(const char *s)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1f4:	eb 23                	jmp    219 <atoi+0x32>
    n = n*10 + *s++ - '0';
 1f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f9:	89 d0                	mov    %edx,%eax
 1fb:	c1 e0 02             	shl    $0x2,%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	01 c0                	add    %eax,%eax
 202:	89 c2                	mov    %eax,%edx
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	0f b6 00             	movzbl (%eax),%eax
 20a:	0f be c0             	movsbl %al,%eax
 20d:	01 d0                	add    %edx,%eax
 20f:	83 e8 30             	sub    $0x30,%eax
 212:	89 45 fc             	mov    %eax,-0x4(%ebp)
 215:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	0f b6 00             	movzbl (%eax),%eax
 21f:	3c 2f                	cmp    $0x2f,%al
 221:	7e 0a                	jle    22d <atoi+0x46>
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	3c 39                	cmp    $0x39,%al
 22b:	7e c9                	jle    1f6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 22d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 230:	c9                   	leave  
 231:	c3                   	ret    

00000232 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 232:	55                   	push   %ebp
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 238:	8b 45 08             	mov    0x8(%ebp),%eax
 23b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 23e:	8b 45 0c             	mov    0xc(%ebp),%eax
 241:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 244:	eb 13                	jmp    259 <memmove+0x27>
    *dst++ = *src++;
 246:	8b 45 f8             	mov    -0x8(%ebp),%eax
 249:	0f b6 10             	movzbl (%eax),%edx
 24c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 24f:	88 10                	mov    %dl,(%eax)
 251:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 255:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 259:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 25d:	0f 9f c0             	setg   %al
 260:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 264:	84 c0                	test   %al,%al
 266:	75 de                	jne    246 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 268:	8b 45 08             	mov    0x8(%ebp),%eax
}
 26b:	c9                   	leave  
 26c:	c3                   	ret    
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 270:	b8 01 00 00 00       	mov    $0x1,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <exit>:
SYSCALL(exit)
 278:	b8 02 00 00 00       	mov    $0x2,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <wait>:
SYSCALL(wait)
 280:	b8 03 00 00 00       	mov    $0x3,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <pipe>:
SYSCALL(pipe)
 288:	b8 04 00 00 00       	mov    $0x4,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <read>:
SYSCALL(read)
 290:	b8 05 00 00 00       	mov    $0x5,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <write>:
SYSCALL(write)
 298:	b8 10 00 00 00       	mov    $0x10,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <close>:
SYSCALL(close)
 2a0:	b8 15 00 00 00       	mov    $0x15,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <kill>:
SYSCALL(kill)
 2a8:	b8 06 00 00 00       	mov    $0x6,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <exec>:
SYSCALL(exec)
 2b0:	b8 07 00 00 00       	mov    $0x7,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <open>:
SYSCALL(open)
 2b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <mknod>:
SYSCALL(mknod)
 2c0:	b8 11 00 00 00       	mov    $0x11,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <unlink>:
SYSCALL(unlink)
 2c8:	b8 12 00 00 00       	mov    $0x12,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <fstat>:
SYSCALL(fstat)
 2d0:	b8 08 00 00 00       	mov    $0x8,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <link>:
SYSCALL(link)
 2d8:	b8 13 00 00 00       	mov    $0x13,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <mkdir>:
SYSCALL(mkdir)
 2e0:	b8 14 00 00 00       	mov    $0x14,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <chdir>:
SYSCALL(chdir)
 2e8:	b8 09 00 00 00       	mov    $0x9,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <dup>:
SYSCALL(dup)
 2f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <getpid>:
SYSCALL(getpid)
 2f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <sbrk>:
SYSCALL(sbrk)
 300:	b8 0c 00 00 00       	mov    $0xc,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <sleep>:
SYSCALL(sleep)
 308:	b8 0d 00 00 00       	mov    $0xd,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <uptime>:
SYSCALL(uptime)
 310:	b8 0e 00 00 00       	mov    $0xe,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <hello>:
SYSCALL(hello)
 318:	b8 16 00 00 00       	mov    $0x16,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	83 ec 28             	sub    $0x28,%esp
 326:	8b 45 0c             	mov    0xc(%ebp),%eax
 329:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 32c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 333:	00 
 334:	8d 45 f4             	lea    -0xc(%ebp),%eax
 337:	89 44 24 04          	mov    %eax,0x4(%esp)
 33b:	8b 45 08             	mov    0x8(%ebp),%eax
 33e:	89 04 24             	mov    %eax,(%esp)
 341:	e8 52 ff ff ff       	call   298 <write>
}
 346:	c9                   	leave  
 347:	c3                   	ret    

00000348 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 34e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 355:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 359:	74 17                	je     372 <printint+0x2a>
 35b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 35f:	79 11                	jns    372 <printint+0x2a>
    neg = 1;
 361:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 368:	8b 45 0c             	mov    0xc(%ebp),%eax
 36b:	f7 d8                	neg    %eax
 36d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 370:	eb 06                	jmp    378 <printint+0x30>
  } else {
    x = xx;
 372:	8b 45 0c             	mov    0xc(%ebp),%eax
 375:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 378:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 37f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 382:	8b 45 ec             	mov    -0x14(%ebp),%eax
 385:	ba 00 00 00 00       	mov    $0x0,%edx
 38a:	f7 f1                	div    %ecx
 38c:	89 d0                	mov    %edx,%eax
 38e:	0f b6 90 04 0a 00 00 	movzbl 0xa04(%eax),%edx
 395:	8d 45 dc             	lea    -0x24(%ebp),%eax
 398:	03 45 f4             	add    -0xc(%ebp),%eax
 39b:	88 10                	mov    %dl,(%eax)
 39d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3a1:	8b 55 10             	mov    0x10(%ebp),%edx
 3a4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3aa:	ba 00 00 00 00       	mov    $0x0,%edx
 3af:	f7 75 d4             	divl   -0x2c(%ebp)
 3b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3b9:	75 c4                	jne    37f <printint+0x37>
  if(neg)
 3bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3bf:	74 2a                	je     3eb <printint+0xa3>
    buf[i++] = '-';
 3c1:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3c4:	03 45 f4             	add    -0xc(%ebp),%eax
 3c7:	c6 00 2d             	movb   $0x2d,(%eax)
 3ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 3ce:	eb 1b                	jmp    3eb <printint+0xa3>
    putc(fd, buf[i]);
 3d0:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3d3:	03 45 f4             	add    -0xc(%ebp),%eax
 3d6:	0f b6 00             	movzbl (%eax),%eax
 3d9:	0f be c0             	movsbl %al,%eax
 3dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
 3e3:	89 04 24             	mov    %eax,(%esp)
 3e6:	e8 35 ff ff ff       	call   320 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3eb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3f3:	79 db                	jns    3d0 <printint+0x88>
    putc(fd, buf[i]);
}
 3f5:	c9                   	leave  
 3f6:	c3                   	ret    

000003f7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f7:	55                   	push   %ebp
 3f8:	89 e5                	mov    %esp,%ebp
 3fa:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 404:	8d 45 0c             	lea    0xc(%ebp),%eax
 407:	83 c0 04             	add    $0x4,%eax
 40a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 40d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 414:	e9 7d 01 00 00       	jmp    596 <printf+0x19f>
    c = fmt[i] & 0xff;
 419:	8b 55 0c             	mov    0xc(%ebp),%edx
 41c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 41f:	01 d0                	add    %edx,%eax
 421:	0f b6 00             	movzbl (%eax),%eax
 424:	0f be c0             	movsbl %al,%eax
 427:	25 ff 00 00 00       	and    $0xff,%eax
 42c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 42f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 433:	75 2c                	jne    461 <printf+0x6a>
      if(c == '%'){
 435:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 439:	75 0c                	jne    447 <printf+0x50>
        state = '%';
 43b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 442:	e9 4b 01 00 00       	jmp    592 <printf+0x19b>
      } else {
        putc(fd, c);
 447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 44a:	0f be c0             	movsbl %al,%eax
 44d:	89 44 24 04          	mov    %eax,0x4(%esp)
 451:	8b 45 08             	mov    0x8(%ebp),%eax
 454:	89 04 24             	mov    %eax,(%esp)
 457:	e8 c4 fe ff ff       	call   320 <putc>
 45c:	e9 31 01 00 00       	jmp    592 <printf+0x19b>
      }
    } else if(state == '%'){
 461:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 465:	0f 85 27 01 00 00    	jne    592 <printf+0x19b>
      if(c == 'd'){
 46b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 46f:	75 2d                	jne    49e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 471:	8b 45 e8             	mov    -0x18(%ebp),%eax
 474:	8b 00                	mov    (%eax),%eax
 476:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 47d:	00 
 47e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 485:	00 
 486:	89 44 24 04          	mov    %eax,0x4(%esp)
 48a:	8b 45 08             	mov    0x8(%ebp),%eax
 48d:	89 04 24             	mov    %eax,(%esp)
 490:	e8 b3 fe ff ff       	call   348 <printint>
        ap++;
 495:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 499:	e9 ed 00 00 00       	jmp    58b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 49e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4a2:	74 06                	je     4aa <printf+0xb3>
 4a4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4a8:	75 2d                	jne    4d7 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ad:	8b 00                	mov    (%eax),%eax
 4af:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4b6:	00 
 4b7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4be:	00 
 4bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c3:	8b 45 08             	mov    0x8(%ebp),%eax
 4c6:	89 04 24             	mov    %eax,(%esp)
 4c9:	e8 7a fe ff ff       	call   348 <printint>
        ap++;
 4ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d2:	e9 b4 00 00 00       	jmp    58b <printf+0x194>
      } else if(c == 's'){
 4d7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4db:	75 46                	jne    523 <printf+0x12c>
        s = (char*)*ap;
 4dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e0:	8b 00                	mov    (%eax),%eax
 4e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ed:	75 27                	jne    516 <printf+0x11f>
          s = "(null)";
 4ef:	c7 45 f4 bb 07 00 00 	movl   $0x7bb,-0xc(%ebp)
        while(*s != 0){
 4f6:	eb 1e                	jmp    516 <printf+0x11f>
          putc(fd, *s);
 4f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4fb:	0f b6 00             	movzbl (%eax),%eax
 4fe:	0f be c0             	movsbl %al,%eax
 501:	89 44 24 04          	mov    %eax,0x4(%esp)
 505:	8b 45 08             	mov    0x8(%ebp),%eax
 508:	89 04 24             	mov    %eax,(%esp)
 50b:	e8 10 fe ff ff       	call   320 <putc>
          s++;
 510:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 514:	eb 01                	jmp    517 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 516:	90                   	nop
 517:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51a:	0f b6 00             	movzbl (%eax),%eax
 51d:	84 c0                	test   %al,%al
 51f:	75 d7                	jne    4f8 <printf+0x101>
 521:	eb 68                	jmp    58b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 523:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 527:	75 1d                	jne    546 <printf+0x14f>
        putc(fd, *ap);
 529:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52c:	8b 00                	mov    (%eax),%eax
 52e:	0f be c0             	movsbl %al,%eax
 531:	89 44 24 04          	mov    %eax,0x4(%esp)
 535:	8b 45 08             	mov    0x8(%ebp),%eax
 538:	89 04 24             	mov    %eax,(%esp)
 53b:	e8 e0 fd ff ff       	call   320 <putc>
        ap++;
 540:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 544:	eb 45                	jmp    58b <printf+0x194>
      } else if(c == '%'){
 546:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 54a:	75 17                	jne    563 <printf+0x16c>
        putc(fd, c);
 54c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 54f:	0f be c0             	movsbl %al,%eax
 552:	89 44 24 04          	mov    %eax,0x4(%esp)
 556:	8b 45 08             	mov    0x8(%ebp),%eax
 559:	89 04 24             	mov    %eax,(%esp)
 55c:	e8 bf fd ff ff       	call   320 <putc>
 561:	eb 28                	jmp    58b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 563:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 56a:	00 
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	89 04 24             	mov    %eax,(%esp)
 571:	e8 aa fd ff ff       	call   320 <putc>
        putc(fd, c);
 576:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 579:	0f be c0             	movsbl %al,%eax
 57c:	89 44 24 04          	mov    %eax,0x4(%esp)
 580:	8b 45 08             	mov    0x8(%ebp),%eax
 583:	89 04 24             	mov    %eax,(%esp)
 586:	e8 95 fd ff ff       	call   320 <putc>
      }
      state = 0;
 58b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 592:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 596:	8b 55 0c             	mov    0xc(%ebp),%edx
 599:	8b 45 f0             	mov    -0x10(%ebp),%eax
 59c:	01 d0                	add    %edx,%eax
 59e:	0f b6 00             	movzbl (%eax),%eax
 5a1:	84 c0                	test   %al,%al
 5a3:	0f 85 70 fe ff ff    	jne    419 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5a9:	c9                   	leave  
 5aa:	c3                   	ret    
 5ab:	90                   	nop

000005ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b2:	8b 45 08             	mov    0x8(%ebp),%eax
 5b5:	83 e8 08             	sub    $0x8,%eax
 5b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5bb:	a1 20 0a 00 00       	mov    0xa20,%eax
 5c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c3:	eb 24                	jmp    5e9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c8:	8b 00                	mov    (%eax),%eax
 5ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5cd:	77 12                	ja     5e1 <free+0x35>
 5cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d5:	77 24                	ja     5fb <free+0x4f>
 5d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5da:	8b 00                	mov    (%eax),%eax
 5dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5df:	77 1a                	ja     5fb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e4:	8b 00                	mov    (%eax),%eax
 5e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ef:	76 d4                	jbe    5c5 <free+0x19>
 5f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f4:	8b 00                	mov    (%eax),%eax
 5f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f9:	76 ca                	jbe    5c5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fe:	8b 40 04             	mov    0x4(%eax),%eax
 601:	c1 e0 03             	shl    $0x3,%eax
 604:	89 c2                	mov    %eax,%edx
 606:	03 55 f8             	add    -0x8(%ebp),%edx
 609:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60c:	8b 00                	mov    (%eax),%eax
 60e:	39 c2                	cmp    %eax,%edx
 610:	75 24                	jne    636 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 612:	8b 45 f8             	mov    -0x8(%ebp),%eax
 615:	8b 50 04             	mov    0x4(%eax),%edx
 618:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61b:	8b 00                	mov    (%eax),%eax
 61d:	8b 40 04             	mov    0x4(%eax),%eax
 620:	01 c2                	add    %eax,%edx
 622:	8b 45 f8             	mov    -0x8(%ebp),%eax
 625:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 628:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62b:	8b 00                	mov    (%eax),%eax
 62d:	8b 10                	mov    (%eax),%edx
 62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 632:	89 10                	mov    %edx,(%eax)
 634:	eb 0a                	jmp    640 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 636:	8b 45 fc             	mov    -0x4(%ebp),%eax
 639:	8b 10                	mov    (%eax),%edx
 63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	8b 40 04             	mov    0x4(%eax),%eax
 646:	c1 e0 03             	shl    $0x3,%eax
 649:	03 45 fc             	add    -0x4(%ebp),%eax
 64c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 64f:	75 20                	jne    671 <free+0xc5>
    p->s.size += bp->s.size;
 651:	8b 45 fc             	mov    -0x4(%ebp),%eax
 654:	8b 50 04             	mov    0x4(%eax),%edx
 657:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65a:	8b 40 04             	mov    0x4(%eax),%eax
 65d:	01 c2                	add    %eax,%edx
 65f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 662:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 665:	8b 45 f8             	mov    -0x8(%ebp),%eax
 668:	8b 10                	mov    (%eax),%edx
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	89 10                	mov    %edx,(%eax)
 66f:	eb 08                	jmp    679 <free+0xcd>
  } else
    p->s.ptr = bp;
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 55 f8             	mov    -0x8(%ebp),%edx
 677:	89 10                	mov    %edx,(%eax)
  freep = p;
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	a3 20 0a 00 00       	mov    %eax,0xa20
}
 681:	c9                   	leave  
 682:	c3                   	ret    

00000683 <morecore>:

static Header*
morecore(uint nu)
{
 683:	55                   	push   %ebp
 684:	89 e5                	mov    %esp,%ebp
 686:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 689:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 690:	77 07                	ja     699 <morecore+0x16>
    nu = 4096;
 692:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 699:	8b 45 08             	mov    0x8(%ebp),%eax
 69c:	c1 e0 03             	shl    $0x3,%eax
 69f:	89 04 24             	mov    %eax,(%esp)
 6a2:	e8 59 fc ff ff       	call   300 <sbrk>
 6a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6aa:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ae:	75 07                	jne    6b7 <morecore+0x34>
    return 0;
 6b0:	b8 00 00 00 00       	mov    $0x0,%eax
 6b5:	eb 22                	jmp    6d9 <morecore+0x56>
  hp = (Header*)p;
 6b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c0:	8b 55 08             	mov    0x8(%ebp),%edx
 6c3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c9:	83 c0 08             	add    $0x8,%eax
 6cc:	89 04 24             	mov    %eax,(%esp)
 6cf:	e8 d8 fe ff ff       	call   5ac <free>
  return freep;
 6d4:	a1 20 0a 00 00       	mov    0xa20,%eax
}
 6d9:	c9                   	leave  
 6da:	c3                   	ret    

000006db <malloc>:

void*
malloc(uint nbytes)
{
 6db:	55                   	push   %ebp
 6dc:	89 e5                	mov    %esp,%ebp
 6de:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e1:	8b 45 08             	mov    0x8(%ebp),%eax
 6e4:	83 c0 07             	add    $0x7,%eax
 6e7:	c1 e8 03             	shr    $0x3,%eax
 6ea:	83 c0 01             	add    $0x1,%eax
 6ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f0:	a1 20 0a 00 00       	mov    0xa20,%eax
 6f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6fc:	75 23                	jne    721 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6fe:	c7 45 f0 18 0a 00 00 	movl   $0xa18,-0x10(%ebp)
 705:	8b 45 f0             	mov    -0x10(%ebp),%eax
 708:	a3 20 0a 00 00       	mov    %eax,0xa20
 70d:	a1 20 0a 00 00       	mov    0xa20,%eax
 712:	a3 18 0a 00 00       	mov    %eax,0xa18
    base.s.size = 0;
 717:	c7 05 1c 0a 00 00 00 	movl   $0x0,0xa1c
 71e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 721:	8b 45 f0             	mov    -0x10(%ebp),%eax
 724:	8b 00                	mov    (%eax),%eax
 726:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 729:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72c:	8b 40 04             	mov    0x4(%eax),%eax
 72f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 732:	72 4d                	jb     781 <malloc+0xa6>
      if(p->s.size == nunits)
 734:	8b 45 f4             	mov    -0xc(%ebp),%eax
 737:	8b 40 04             	mov    0x4(%eax),%eax
 73a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 73d:	75 0c                	jne    74b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 742:	8b 10                	mov    (%eax),%edx
 744:	8b 45 f0             	mov    -0x10(%ebp),%eax
 747:	89 10                	mov    %edx,(%eax)
 749:	eb 26                	jmp    771 <malloc+0x96>
      else {
        p->s.size -= nunits;
 74b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74e:	8b 40 04             	mov    0x4(%eax),%eax
 751:	89 c2                	mov    %eax,%edx
 753:	2b 55 ec             	sub    -0x14(%ebp),%edx
 756:	8b 45 f4             	mov    -0xc(%ebp),%eax
 759:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75f:	8b 40 04             	mov    0x4(%eax),%eax
 762:	c1 e0 03             	shl    $0x3,%eax
 765:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 76e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 771:	8b 45 f0             	mov    -0x10(%ebp),%eax
 774:	a3 20 0a 00 00       	mov    %eax,0xa20
      return (void*)(p + 1);
 779:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77c:	83 c0 08             	add    $0x8,%eax
 77f:	eb 38                	jmp    7b9 <malloc+0xde>
    }
    if(p == freep)
 781:	a1 20 0a 00 00       	mov    0xa20,%eax
 786:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 789:	75 1b                	jne    7a6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 78b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 78e:	89 04 24             	mov    %eax,(%esp)
 791:	e8 ed fe ff ff       	call   683 <morecore>
 796:	89 45 f4             	mov    %eax,-0xc(%ebp)
 799:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 79d:	75 07                	jne    7a6 <malloc+0xcb>
        return 0;
 79f:	b8 00 00 00 00       	mov    $0x0,%eax
 7a4:	eb 13                	jmp    7b9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7af:	8b 00                	mov    (%eax),%eax
 7b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7b4:	e9 70 ff ff ff       	jmp    729 <malloc+0x4e>
}
 7b9:	c9                   	leave  
 7ba:	c3                   	ret    
