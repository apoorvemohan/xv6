
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
   f:	c7 44 24 04 d5 09 00 	movl   $0x9d5,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 7c 04 00 00       	call   49f <printf>
    exit();
  23:	e8 a0 02 00 00       	call   2c8 <exit>
  }
  for(i=1; i<argc; i++)
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 21                	jmp    53 <main+0x53>
    kill(atoi(argv[i]));
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	c1 e0 02             	shl    $0x2,%eax
  39:	03 45 0c             	add    0xc(%ebp),%eax
  3c:	8b 00                	mov    (%eax),%eax
  3e:	89 04 24             	mov    %eax,(%esp)
  41:	e8 f1 01 00 00       	call   237 <atoi>
  46:	89 04 24             	mov    %eax,(%esp)
  49:	e8 aa 02 00 00       	call   2f8 <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  4e:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  53:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  57:	3b 45 08             	cmp    0x8(%ebp),%eax
  5a:	7c d6                	jl     32 <main+0x32>
    kill(atoi(argv[i]));
  exit();
  5c:	e8 67 02 00 00       	call   2c8 <exit>
  61:	90                   	nop
  62:	90                   	nop
  63:	90                   	nop

00000064 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	57                   	push   %edi
  68:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  69:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6c:	8b 55 10             	mov    0x10(%ebp),%edx
  6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  72:	89 cb                	mov    %ecx,%ebx
  74:	89 df                	mov    %ebx,%edi
  76:	89 d1                	mov    %edx,%ecx
  78:	fc                   	cld    
  79:	f3 aa                	rep stos %al,%es:(%edi)
  7b:	89 ca                	mov    %ecx,%edx
  7d:	89 fb                	mov    %edi,%ebx
  7f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  82:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  85:	5b                   	pop    %ebx
  86:	5f                   	pop    %edi
  87:	5d                   	pop    %ebp
  88:	c3                   	ret    

00000089 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  8c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  95:	90                   	nop
  96:	8b 45 0c             	mov    0xc(%ebp),%eax
  99:	0f b6 10             	movzbl (%eax),%edx
  9c:	8b 45 08             	mov    0x8(%ebp),%eax
  9f:	88 10                	mov    %dl,(%eax)
  a1:	8b 45 08             	mov    0x8(%ebp),%eax
  a4:	0f b6 00             	movzbl (%eax),%eax
  a7:	84 c0                	test   %al,%al
  a9:	0f 95 c0             	setne  %al
  ac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  b4:	84 c0                	test   %al,%al
  b6:	75 de                	jne    96 <strcpy+0xd>
    ;
  return os;
  b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bb:	c9                   	leave  
  bc:	c3                   	ret    

000000bd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bd:	55                   	push   %ebp
  be:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c0:	eb 08                	jmp    ca <strcmp+0xd>
    p++, q++;
  c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ca:	8b 45 08             	mov    0x8(%ebp),%eax
  cd:	0f b6 00             	movzbl (%eax),%eax
  d0:	84 c0                	test   %al,%al
  d2:	74 10                	je     e4 <strcmp+0x27>
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 10             	movzbl (%eax),%edx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	0f b6 00             	movzbl (%eax),%eax
  e0:	38 c2                	cmp    %al,%dl
  e2:	74 de                	je     c2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e4:	8b 45 08             	mov    0x8(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	0f b6 d0             	movzbl %al,%edx
  ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  f0:	0f b6 00             	movzbl (%eax),%eax
  f3:	0f b6 c0             	movzbl %al,%eax
  f6:	89 d1                	mov    %edx,%ecx
  f8:	29 c1                	sub    %eax,%ecx
  fa:	89 c8                	mov    %ecx,%eax
}
  fc:	5d                   	pop    %ebp
  fd:	c3                   	ret    

000000fe <strlen>:

uint
strlen(char *s)
{
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 104:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10b:	eb 04                	jmp    111 <strlen+0x13>
 10d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 111:	8b 45 fc             	mov    -0x4(%ebp),%eax
 114:	03 45 08             	add    0x8(%ebp),%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	84 c0                	test   %al,%al
 11c:	75 ef                	jne    10d <strlen+0xf>
    ;
  return n;
 11e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 121:	c9                   	leave  
 122:	c3                   	ret    

00000123 <memset>:

void*
memset(void *dst, int c, uint n)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 129:	8b 45 10             	mov    0x10(%ebp),%eax
 12c:	89 44 24 08          	mov    %eax,0x8(%esp)
 130:	8b 45 0c             	mov    0xc(%ebp),%eax
 133:	89 44 24 04          	mov    %eax,0x4(%esp)
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	89 04 24             	mov    %eax,(%esp)
 13d:	e8 22 ff ff ff       	call   64 <stosb>
  return dst;
 142:	8b 45 08             	mov    0x8(%ebp),%eax
}
 145:	c9                   	leave  
 146:	c3                   	ret    

00000147 <strchr>:

char*
strchr(const char *s, char c)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 04             	sub    $0x4,%esp
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 153:	eb 14                	jmp    169 <strchr+0x22>
    if(*s == c)
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15e:	75 05                	jne    165 <strchr+0x1e>
      return (char*)s;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	eb 13                	jmp    178 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 e2                	jne    155 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 173:	b8 00 00 00 00       	mov    $0x0,%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <gets>:

char*
gets(char *buf, int max)
{
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 187:	eb 44                	jmp    1cd <gets+0x53>
    cc = read(0, &c, 1);
 189:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 190:	00 
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	89 44 24 04          	mov    %eax,0x4(%esp)
 198:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19f:	e8 3c 01 00 00       	call   2e0 <read>
 1a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ab:	7e 2d                	jle    1da <gets+0x60>
      break;
    buf[i++] = c;
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	03 45 08             	add    0x8(%ebp),%eax
 1b3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1b7:	88 10                	mov    %dl,(%eax)
 1b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c1:	3c 0a                	cmp    $0xa,%al
 1c3:	74 16                	je     1db <gets+0x61>
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	3c 0d                	cmp    $0xd,%al
 1cb:	74 0e                	je     1db <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d6:	7c b1                	jl     189 <gets+0xf>
 1d8:	eb 01                	jmp    1db <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1da:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	03 45 08             	add    0x8(%ebp),%eax
 1e1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <stat>:

int
stat(char *n, struct stat *st)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ef:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f6:	00 
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	89 04 24             	mov    %eax,(%esp)
 1fd:	e8 06 01 00 00       	call   308 <open>
 202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 209:	79 07                	jns    212 <stat+0x29>
    return -1;
 20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 210:	eb 23                	jmp    235 <stat+0x4c>
  r = fstat(fd, st);
 212:	8b 45 0c             	mov    0xc(%ebp),%eax
 215:	89 44 24 04          	mov    %eax,0x4(%esp)
 219:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21c:	89 04 24             	mov    %eax,(%esp)
 21f:	e8 fc 00 00 00       	call   320 <fstat>
 224:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 227:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22a:	89 04 24             	mov    %eax,(%esp)
 22d:	e8 be 00 00 00       	call   2f0 <close>
  return r;
 232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 235:	c9                   	leave  
 236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
 237:	55                   	push   %ebp
 238:	89 e5                	mov    %esp,%ebp
 23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 244:	eb 23                	jmp    269 <atoi+0x32>
    n = n*10 + *s++ - '0';
 246:	8b 55 fc             	mov    -0x4(%ebp),%edx
 249:	89 d0                	mov    %edx,%eax
 24b:	c1 e0 02             	shl    $0x2,%eax
 24e:	01 d0                	add    %edx,%eax
 250:	01 c0                	add    %eax,%eax
 252:	89 c2                	mov    %eax,%edx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	0f b6 00             	movzbl (%eax),%eax
 25a:	0f be c0             	movsbl %al,%eax
 25d:	01 d0                	add    %edx,%eax
 25f:	83 e8 30             	sub    $0x30,%eax
 262:	89 45 fc             	mov    %eax,-0x4(%ebp)
 265:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	0f b6 00             	movzbl (%eax),%eax
 26f:	3c 2f                	cmp    $0x2f,%al
 271:	7e 0a                	jle    27d <atoi+0x46>
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	3c 39                	cmp    $0x39,%al
 27b:	7e c9                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 280:	c9                   	leave  
 281:	c3                   	ret    

00000282 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 282:	55                   	push   %ebp
 283:	89 e5                	mov    %esp,%ebp
 285:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 28e:	8b 45 0c             	mov    0xc(%ebp),%eax
 291:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 294:	eb 13                	jmp    2a9 <memmove+0x27>
    *dst++ = *src++;
 296:	8b 45 f8             	mov    -0x8(%ebp),%eax
 299:	0f b6 10             	movzbl (%eax),%edx
 29c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29f:	88 10                	mov    %dl,(%eax)
 2a1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2a5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2ad:	0f 9f c0             	setg   %al
 2b0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2b4:	84 c0                	test   %al,%al
 2b6:	75 de                	jne    296 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bb:	c9                   	leave  
 2bc:	c3                   	ret    
 2bd:	90                   	nop
 2be:	90                   	nop
 2bf:	90                   	nop

000002c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c0:	b8 01 00 00 00       	mov    $0x1,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <exit>:
SYSCALL(exit)
 2c8:	b8 02 00 00 00       	mov    $0x2,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <wait>:
SYSCALL(wait)
 2d0:	b8 03 00 00 00       	mov    $0x3,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <pipe>:
SYSCALL(pipe)
 2d8:	b8 04 00 00 00       	mov    $0x4,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <read>:
SYSCALL(read)
 2e0:	b8 05 00 00 00       	mov    $0x5,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <write>:
SYSCALL(write)
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <close>:
SYSCALL(close)
 2f0:	b8 15 00 00 00       	mov    $0x15,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <kill>:
SYSCALL(kill)
 2f8:	b8 06 00 00 00       	mov    $0x6,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <exec>:
SYSCALL(exec)
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <open>:
SYSCALL(open)
 308:	b8 0f 00 00 00       	mov    $0xf,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mknod>:
SYSCALL(mknod)
 310:	b8 11 00 00 00       	mov    $0x11,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <unlink>:
SYSCALL(unlink)
 318:	b8 12 00 00 00       	mov    $0x12,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <fstat>:
SYSCALL(fstat)
 320:	b8 08 00 00 00       	mov    $0x8,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <link>:
SYSCALL(link)
 328:	b8 13 00 00 00       	mov    $0x13,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mkdir>:
SYSCALL(mkdir)
 330:	b8 14 00 00 00       	mov    $0x14,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <chdir>:
SYSCALL(chdir)
 338:	b8 09 00 00 00       	mov    $0x9,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <dup>:
SYSCALL(dup)
 340:	b8 0a 00 00 00       	mov    $0xa,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <getpid>:
SYSCALL(getpid)
 348:	b8 0b 00 00 00       	mov    $0xb,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <sbrk>:
SYSCALL(sbrk)
 350:	b8 0c 00 00 00       	mov    $0xc,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sleep>:
SYSCALL(sleep)
 358:	b8 0d 00 00 00       	mov    $0xd,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <uptime>:
SYSCALL(uptime)
 360:	b8 0e 00 00 00       	mov    $0xe,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <kthread_create>:
SYSCALL(kthread_create)
 368:	b8 17 00 00 00       	mov    $0x17,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <kthread_join>:
SYSCALL(kthread_join)
 370:	b8 16 00 00 00       	mov    $0x16,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 378:	b8 18 00 00 00       	mov    $0x18,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 380:	b8 19 00 00 00       	mov    $0x19,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 388:	b8 1a 00 00 00       	mov    $0x1a,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 390:	b8 1b 00 00 00       	mov    $0x1b,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 398:	b8 1c 00 00 00       	mov    $0x1c,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3a0:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3a8:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3b0:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 3b8:	b8 20 00 00 00       	mov    $0x20,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <kthread_exit>:
 3c0:	b8 21 00 00 00       	mov    $0x21,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	83 ec 28             	sub    $0x28,%esp
 3ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3db:	00 
 3dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3df:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	89 04 24             	mov    %eax,(%esp)
 3e9:	e8 fa fe ff ff       	call   2e8 <write>
}
 3ee:	c9                   	leave  
 3ef:	c3                   	ret    

000003f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3fd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 401:	74 17                	je     41a <printint+0x2a>
 403:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 407:	79 11                	jns    41a <printint+0x2a>
    neg = 1;
 409:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 410:	8b 45 0c             	mov    0xc(%ebp),%eax
 413:	f7 d8                	neg    %eax
 415:	89 45 ec             	mov    %eax,-0x14(%ebp)
 418:	eb 06                	jmp    420 <printint+0x30>
  } else {
    x = xx;
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 420:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 42d:	ba 00 00 00 00       	mov    $0x0,%edx
 432:	f7 f1                	div    %ecx
 434:	89 d0                	mov    %edx,%eax
 436:	0f b6 90 d4 0d 00 00 	movzbl 0xdd4(%eax),%edx
 43d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 440:	03 45 f4             	add    -0xc(%ebp),%eax
 443:	88 10                	mov    %dl,(%eax)
 445:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 449:	8b 55 10             	mov    0x10(%ebp),%edx
 44c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 44f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 452:	ba 00 00 00 00       	mov    $0x0,%edx
 457:	f7 75 d4             	divl   -0x2c(%ebp)
 45a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 461:	75 c4                	jne    427 <printint+0x37>
  if(neg)
 463:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 467:	74 2a                	je     493 <printint+0xa3>
    buf[i++] = '-';
 469:	8d 45 dc             	lea    -0x24(%ebp),%eax
 46c:	03 45 f4             	add    -0xc(%ebp),%eax
 46f:	c6 00 2d             	movb   $0x2d,(%eax)
 472:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 476:	eb 1b                	jmp    493 <printint+0xa3>
    putc(fd, buf[i]);
 478:	8d 45 dc             	lea    -0x24(%ebp),%eax
 47b:	03 45 f4             	add    -0xc(%ebp),%eax
 47e:	0f b6 00             	movzbl (%eax),%eax
 481:	0f be c0             	movsbl %al,%eax
 484:	89 44 24 04          	mov    %eax,0x4(%esp)
 488:	8b 45 08             	mov    0x8(%ebp),%eax
 48b:	89 04 24             	mov    %eax,(%esp)
 48e:	e8 35 ff ff ff       	call   3c8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 493:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 497:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49b:	79 db                	jns    478 <printint+0x88>
    putc(fd, buf[i]);
}
 49d:	c9                   	leave  
 49e:	c3                   	ret    

0000049f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 49f:	55                   	push   %ebp
 4a0:	89 e5                	mov    %esp,%ebp
 4a2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4ac:	8d 45 0c             	lea    0xc(%ebp),%eax
 4af:	83 c0 04             	add    $0x4,%eax
 4b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4bc:	e9 7d 01 00 00       	jmp    63e <printf+0x19f>
    c = fmt[i] & 0xff;
 4c1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c7:	01 d0                	add    %edx,%eax
 4c9:	0f b6 00             	movzbl (%eax),%eax
 4cc:	0f be c0             	movsbl %al,%eax
 4cf:	25 ff 00 00 00       	and    $0xff,%eax
 4d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4db:	75 2c                	jne    509 <printf+0x6a>
      if(c == '%'){
 4dd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e1:	75 0c                	jne    4ef <printf+0x50>
        state = '%';
 4e3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ea:	e9 4b 01 00 00       	jmp    63a <printf+0x19b>
      } else {
        putc(fd, c);
 4ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f2:	0f be c0             	movsbl %al,%eax
 4f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f9:	8b 45 08             	mov    0x8(%ebp),%eax
 4fc:	89 04 24             	mov    %eax,(%esp)
 4ff:	e8 c4 fe ff ff       	call   3c8 <putc>
 504:	e9 31 01 00 00       	jmp    63a <printf+0x19b>
      }
    } else if(state == '%'){
 509:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 50d:	0f 85 27 01 00 00    	jne    63a <printf+0x19b>
      if(c == 'd'){
 513:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 517:	75 2d                	jne    546 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 519:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51c:	8b 00                	mov    (%eax),%eax
 51e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 525:	00 
 526:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 52d:	00 
 52e:	89 44 24 04          	mov    %eax,0x4(%esp)
 532:	8b 45 08             	mov    0x8(%ebp),%eax
 535:	89 04 24             	mov    %eax,(%esp)
 538:	e8 b3 fe ff ff       	call   3f0 <printint>
        ap++;
 53d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 541:	e9 ed 00 00 00       	jmp    633 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 546:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54a:	74 06                	je     552 <printf+0xb3>
 54c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 550:	75 2d                	jne    57f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 552:	8b 45 e8             	mov    -0x18(%ebp),%eax
 555:	8b 00                	mov    (%eax),%eax
 557:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 55e:	00 
 55f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 566:	00 
 567:	89 44 24 04          	mov    %eax,0x4(%esp)
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	89 04 24             	mov    %eax,(%esp)
 571:	e8 7a fe ff ff       	call   3f0 <printint>
        ap++;
 576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57a:	e9 b4 00 00 00       	jmp    633 <printf+0x194>
      } else if(c == 's'){
 57f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 583:	75 46                	jne    5cb <printf+0x12c>
        s = (char*)*ap;
 585:	8b 45 e8             	mov    -0x18(%ebp),%eax
 588:	8b 00                	mov    (%eax),%eax
 58a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 58d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 591:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 595:	75 27                	jne    5be <printf+0x11f>
          s = "(null)";
 597:	c7 45 f4 e9 09 00 00 	movl   $0x9e9,-0xc(%ebp)
        while(*s != 0){
 59e:	eb 1e                	jmp    5be <printf+0x11f>
          putc(fd, *s);
 5a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a3:	0f b6 00             	movzbl (%eax),%eax
 5a6:	0f be c0             	movsbl %al,%eax
 5a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	89 04 24             	mov    %eax,(%esp)
 5b3:	e8 10 fe ff ff       	call   3c8 <putc>
          s++;
 5b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5bc:	eb 01                	jmp    5bf <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5be:	90                   	nop
 5bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c2:	0f b6 00             	movzbl (%eax),%eax
 5c5:	84 c0                	test   %al,%al
 5c7:	75 d7                	jne    5a0 <printf+0x101>
 5c9:	eb 68                	jmp    633 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5cf:	75 1d                	jne    5ee <printf+0x14f>
        putc(fd, *ap);
 5d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	0f be c0             	movsbl %al,%eax
 5d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	89 04 24             	mov    %eax,(%esp)
 5e3:	e8 e0 fd ff ff       	call   3c8 <putc>
        ap++;
 5e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ec:	eb 45                	jmp    633 <printf+0x194>
      } else if(c == '%'){
 5ee:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f2:	75 17                	jne    60b <printf+0x16c>
        putc(fd, c);
 5f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f7:	0f be c0             	movsbl %al,%eax
 5fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	89 04 24             	mov    %eax,(%esp)
 604:	e8 bf fd ff ff       	call   3c8 <putc>
 609:	eb 28                	jmp    633 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 612:	00 
 613:	8b 45 08             	mov    0x8(%ebp),%eax
 616:	89 04 24             	mov    %eax,(%esp)
 619:	e8 aa fd ff ff       	call   3c8 <putc>
        putc(fd, c);
 61e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	89 44 24 04          	mov    %eax,0x4(%esp)
 628:	8b 45 08             	mov    0x8(%ebp),%eax
 62b:	89 04 24             	mov    %eax,(%esp)
 62e:	e8 95 fd ff ff       	call   3c8 <putc>
      }
      state = 0;
 633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 63e:	8b 55 0c             	mov    0xc(%ebp),%edx
 641:	8b 45 f0             	mov    -0x10(%ebp),%eax
 644:	01 d0                	add    %edx,%eax
 646:	0f b6 00             	movzbl (%eax),%eax
 649:	84 c0                	test   %al,%al
 64b:	0f 85 70 fe ff ff    	jne    4c1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 651:	c9                   	leave  
 652:	c3                   	ret    
 653:	90                   	nop

00000654 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 654:	55                   	push   %ebp
 655:	89 e5                	mov    %esp,%ebp
 657:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	83 e8 08             	sub    $0x8,%eax
 660:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 663:	a1 f0 0d 00 00       	mov    0xdf0,%eax
 668:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66b:	eb 24                	jmp    691 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 12                	ja     689 <free+0x35>
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	77 24                	ja     6a3 <free+0x4f>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	77 1a                	ja     6a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 697:	76 d4                	jbe    66d <free+0x19>
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a1:	76 ca                	jbe    66d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	c1 e0 03             	shl    $0x3,%eax
 6ac:	89 c2                	mov    %eax,%edx
 6ae:	03 55 f8             	add    -0x8(%ebp),%edx
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 00                	mov    (%eax),%eax
 6b6:	39 c2                	cmp    %eax,%edx
 6b8:	75 24                	jne    6de <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bd:	8b 50 04             	mov    0x4(%eax),%edx
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	8b 00                	mov    (%eax),%eax
 6c5:	8b 40 04             	mov    0x4(%eax),%eax
 6c8:	01 c2                	add    %eax,%edx
 6ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d3:	8b 00                	mov    (%eax),%eax
 6d5:	8b 10                	mov    (%eax),%edx
 6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6da:	89 10                	mov    %edx,(%eax)
 6dc:	eb 0a                	jmp    6e8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e1:	8b 10                	mov    (%eax),%edx
 6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	8b 40 04             	mov    0x4(%eax),%eax
 6ee:	c1 e0 03             	shl    $0x3,%eax
 6f1:	03 45 fc             	add    -0x4(%ebp),%eax
 6f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f7:	75 20                	jne    719 <free+0xc5>
    p->s.size += bp->s.size;
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	8b 50 04             	mov    0x4(%eax),%edx
 6ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 702:	8b 40 04             	mov    0x4(%eax),%eax
 705:	01 c2                	add    %eax,%edx
 707:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 710:	8b 10                	mov    (%eax),%edx
 712:	8b 45 fc             	mov    -0x4(%ebp),%eax
 715:	89 10                	mov    %edx,(%eax)
 717:	eb 08                	jmp    721 <free+0xcd>
  } else
    p->s.ptr = bp;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71f:	89 10                	mov    %edx,(%eax)
  freep = p;
 721:	8b 45 fc             	mov    -0x4(%ebp),%eax
 724:	a3 f0 0d 00 00       	mov    %eax,0xdf0
}
 729:	c9                   	leave  
 72a:	c3                   	ret    

0000072b <morecore>:

static Header*
morecore(uint nu)
{
 72b:	55                   	push   %ebp
 72c:	89 e5                	mov    %esp,%ebp
 72e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 731:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 738:	77 07                	ja     741 <morecore+0x16>
    nu = 4096;
 73a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 741:	8b 45 08             	mov    0x8(%ebp),%eax
 744:	c1 e0 03             	shl    $0x3,%eax
 747:	89 04 24             	mov    %eax,(%esp)
 74a:	e8 01 fc ff ff       	call   350 <sbrk>
 74f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 752:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 756:	75 07                	jne    75f <morecore+0x34>
    return 0;
 758:	b8 00 00 00 00       	mov    $0x0,%eax
 75d:	eb 22                	jmp    781 <morecore+0x56>
  hp = (Header*)p;
 75f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 762:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 765:	8b 45 f0             	mov    -0x10(%ebp),%eax
 768:	8b 55 08             	mov    0x8(%ebp),%edx
 76b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 76e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 771:	83 c0 08             	add    $0x8,%eax
 774:	89 04 24             	mov    %eax,(%esp)
 777:	e8 d8 fe ff ff       	call   654 <free>
  return freep;
 77c:	a1 f0 0d 00 00       	mov    0xdf0,%eax
}
 781:	c9                   	leave  
 782:	c3                   	ret    

00000783 <malloc>:

void*
malloc(uint nbytes)
{
 783:	55                   	push   %ebp
 784:	89 e5                	mov    %esp,%ebp
 786:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
 78c:	83 c0 07             	add    $0x7,%eax
 78f:	c1 e8 03             	shr    $0x3,%eax
 792:	83 c0 01             	add    $0x1,%eax
 795:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 798:	a1 f0 0d 00 00       	mov    0xdf0,%eax
 79d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a4:	75 23                	jne    7c9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a6:	c7 45 f0 e8 0d 00 00 	movl   $0xde8,-0x10(%ebp)
 7ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b0:	a3 f0 0d 00 00       	mov    %eax,0xdf0
 7b5:	a1 f0 0d 00 00       	mov    0xdf0,%eax
 7ba:	a3 e8 0d 00 00       	mov    %eax,0xde8
    base.s.size = 0;
 7bf:	c7 05 ec 0d 00 00 00 	movl   $0x0,0xdec
 7c6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cc:	8b 00                	mov    (%eax),%eax
 7ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d4:	8b 40 04             	mov    0x4(%eax),%eax
 7d7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7da:	72 4d                	jb     829 <malloc+0xa6>
      if(p->s.size == nunits)
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e5:	75 0c                	jne    7f3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	8b 10                	mov    (%eax),%edx
 7ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ef:	89 10                	mov    %edx,(%eax)
 7f1:	eb 26                	jmp    819 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	89 c2                	mov    %eax,%edx
 7fb:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	8b 40 04             	mov    0x4(%eax),%eax
 80a:	c1 e0 03             	shl    $0x3,%eax
 80d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	8b 55 ec             	mov    -0x14(%ebp),%edx
 816:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 819:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81c:	a3 f0 0d 00 00       	mov    %eax,0xdf0
      return (void*)(p + 1);
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	83 c0 08             	add    $0x8,%eax
 827:	eb 38                	jmp    861 <malloc+0xde>
    }
    if(p == freep)
 829:	a1 f0 0d 00 00       	mov    0xdf0,%eax
 82e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 831:	75 1b                	jne    84e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 833:	8b 45 ec             	mov    -0x14(%ebp),%eax
 836:	89 04 24             	mov    %eax,(%esp)
 839:	e8 ed fe ff ff       	call   72b <morecore>
 83e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 841:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 845:	75 07                	jne    84e <malloc+0xcb>
        return 0;
 847:	b8 00 00 00 00       	mov    $0x0,%eax
 84c:	eb 13                	jmp    861 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	89 45 f0             	mov    %eax,-0x10(%ebp)
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	8b 00                	mov    (%eax),%eax
 859:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 85c:	e9 70 ff ff ff       	jmp    7d1 <malloc+0x4e>
}
 861:	c9                   	leave  
 862:	c3                   	ret    
 863:	90                   	nop

00000864 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 864:	55                   	push   %ebp
 865:	89 e5                	mov    %esp,%ebp
 867:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 86a:	8b 45 0c             	mov    0xc(%ebp),%eax
 86d:	89 04 24             	mov    %eax,(%esp)
 870:	8b 45 08             	mov    0x8(%ebp),%eax
 873:	ff d0                	call   *%eax
    exit();
 875:	e8 4e fa ff ff       	call   2c8 <exit>

0000087a <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 87a:	55                   	push   %ebp
 87b:	89 e5                	mov    %esp,%ebp
 87d:	57                   	push   %edi
 87e:	56                   	push   %esi
 87f:	53                   	push   %ebx
 880:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 883:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 88a:	e8 f4 fe ff ff       	call   783 <malloc>
 88f:	89 c2                	mov    %eax,%edx
 891:	8b 45 08             	mov    0x8(%ebp),%eax
 894:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 896:	8b 45 10             	mov    0x10(%ebp),%eax
 899:	8b 38                	mov    (%eax),%edi
 89b:	8b 75 0c             	mov    0xc(%ebp),%esi
 89e:	bb 64 08 00 00       	mov    $0x864,%ebx
 8a3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8aa:	e8 d4 fe ff ff       	call   783 <malloc>
 8af:	05 00 10 00 00       	add    $0x1000,%eax
 8b4:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8b8:	89 74 24 08          	mov    %esi,0x8(%esp)
 8bc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8c0:	89 04 24             	mov    %eax,(%esp)
 8c3:	e8 a0 fa ff ff       	call   368 <kthread_create>
 8c8:	8b 55 08             	mov    0x8(%ebp),%edx
 8cb:	89 02                	mov    %eax,(%edx)
    return *thread;
 8cd:	8b 45 08             	mov    0x8(%ebp),%eax
 8d0:	8b 00                	mov    (%eax),%eax
}
 8d2:	83 c4 1c             	add    $0x1c,%esp
 8d5:	5b                   	pop    %ebx
 8d6:	5e                   	pop    %esi
 8d7:	5f                   	pop    %edi
 8d8:	5d                   	pop    %ebp
 8d9:	c3                   	ret    

000008da <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8da:	55                   	push   %ebp
 8db:	89 e5                	mov    %esp,%ebp
 8dd:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 8e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 8e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 8e7:	8b 45 08             	mov    0x8(%ebp),%eax
 8ea:	89 04 24             	mov    %eax,(%esp)
 8ed:	e8 7e fa ff ff       	call   370 <kthread_join>
 8f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 8f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 8f8:	c9                   	leave  
 8f9:	c3                   	ret    

000008fa <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 8fa:	55                   	push   %ebp
 8fb:	89 e5                	mov    %esp,%ebp
 8fd:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 900:	e8 73 fa ff ff       	call   378 <kthread_mutex_init>
 905:	8b 55 08             	mov    0x8(%ebp),%edx
 908:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 90a:	8b 45 08             	mov    0x8(%ebp),%eax
 90d:	8b 00                	mov    (%eax),%eax
 90f:	85 c0                	test   %eax,%eax
 911:	7e 07                	jle    91a <qthread_mutex_init+0x20>
		return 0;
 913:	b8 00 00 00 00       	mov    $0x0,%eax
 918:	eb 05                	jmp    91f <qthread_mutex_init+0x25>
	}
	return *mutex;
 91a:	8b 45 08             	mov    0x8(%ebp),%eax
 91d:	8b 00                	mov    (%eax),%eax
}
 91f:	c9                   	leave  
 920:	c3                   	ret    

00000921 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 921:	55                   	push   %ebp
 922:	89 e5                	mov    %esp,%ebp
 924:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 927:	8b 45 08             	mov    0x8(%ebp),%eax
 92a:	89 04 24             	mov    %eax,(%esp)
 92d:	e8 4e fa ff ff       	call   380 <kthread_mutex_destroy>
 932:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 935:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 939:	79 07                	jns    942 <qthread_mutex_destroy+0x21>
    	return -1;
 93b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 940:	eb 05                	jmp    947 <qthread_mutex_destroy+0x26>
    }
    return 0;
 942:	b8 00 00 00 00       	mov    $0x0,%eax
}
 947:	c9                   	leave  
 948:	c3                   	ret    

00000949 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 949:	55                   	push   %ebp
 94a:	89 e5                	mov    %esp,%ebp
 94c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 94f:	8b 45 08             	mov    0x8(%ebp),%eax
 952:	89 04 24             	mov    %eax,(%esp)
 955:	e8 2e fa ff ff       	call   388 <kthread_mutex_lock>
 95a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 95d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 961:	79 07                	jns    96a <qthread_mutex_lock+0x21>
    	return -1;
 963:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 968:	eb 05                	jmp    96f <qthread_mutex_lock+0x26>
    }
    return 0;
 96a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 96f:	c9                   	leave  
 970:	c3                   	ret    

00000971 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 971:	55                   	push   %ebp
 972:	89 e5                	mov    %esp,%ebp
 974:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 977:	8b 45 08             	mov    0x8(%ebp),%eax
 97a:	89 04 24             	mov    %eax,(%esp)
 97d:	e8 0e fa ff ff       	call   390 <kthread_mutex_unlock>
 982:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 985:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 989:	79 07                	jns    992 <qthread_mutex_unlock+0x21>
    	return -1;
 98b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 990:	eb 05                	jmp    997 <qthread_mutex_unlock+0x26>
    }
    return 0;
 992:	b8 00 00 00 00       	mov    $0x0,%eax
}
 997:	c9                   	leave  
 998:	c3                   	ret    

00000999 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 999:	55                   	push   %ebp
 99a:	89 e5                	mov    %esp,%ebp

	return 0;
 99c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9a1:	5d                   	pop    %ebp
 9a2:	c3                   	ret    

000009a3 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9a3:	55                   	push   %ebp
 9a4:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9ab:	5d                   	pop    %ebp
 9ac:	c3                   	ret    

000009ad <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9ad:	55                   	push   %ebp
 9ae:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b5:	5d                   	pop    %ebp
 9b6:	c3                   	ret    

000009b7 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9b7:	55                   	push   %ebp
 9b8:	89 e5                	mov    %esp,%ebp
	return 0;
 9ba:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9bf:	5d                   	pop    %ebp
 9c0:	c3                   	ret    

000009c1 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9c1:	55                   	push   %ebp
 9c2:	89 e5                	mov    %esp,%ebp
	return 0;
 9c4:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9c9:	5d                   	pop    %ebp
 9ca:	c3                   	ret    

000009cb <qthread_exit>:

int qthread_exit(){
 9cb:	55                   	push   %ebp
 9cc:	89 e5                	mov    %esp,%ebp
	return 0;
 9ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d3:	5d                   	pop    %ebp
 9d4:	c3                   	ret    
