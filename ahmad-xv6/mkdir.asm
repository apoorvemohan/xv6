
_mkdir:     file format elf32-i386


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

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
   f:	c7 44 24 04 08 0a 00 	movl   $0xa08,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 ac 04 00 00       	call   4cf <printf>
    exit();
  23:	e8 cf 02 00 00       	call   2f7 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 4f                	jmp    81 <main+0x81>
    if(mkdir(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 13 03 00 00       	call   35f <mkdir>
  4c:	85 c0                	test   %eax,%eax
  4e:	79 2c                	jns    7c <main+0x7c>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  5e:	01 d0                	add    %edx,%eax
  60:	8b 00                	mov    (%eax),%eax
  62:	89 44 24 08          	mov    %eax,0x8(%esp)
  66:	c7 44 24 04 1f 0a 00 	movl   $0xa1f,0x4(%esp)
  6d:	00 
  6e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  75:	e8 55 04 00 00       	call   4cf <printf>
      break;
  7a:	eb 0e                	jmp    8a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  7c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  81:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  85:	3b 45 08             	cmp    0x8(%ebp),%eax
  88:	7c a8                	jl     32 <main+0x32>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  8a:	e8 68 02 00 00       	call   2f7 <exit>

0000008f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8f:	55                   	push   %ebp
  90:	89 e5                	mov    %esp,%ebp
  92:	57                   	push   %edi
  93:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	8b 55 10             	mov    0x10(%ebp),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	89 cb                	mov    %ecx,%ebx
  9f:	89 df                	mov    %ebx,%edi
  a1:	89 d1                	mov    %edx,%ecx
  a3:	fc                   	cld    
  a4:	f3 aa                	rep stos %al,%es:(%edi)
  a6:	89 ca                	mov    %ecx,%edx
  a8:	89 fb                	mov    %edi,%ebx
  aa:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ad:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b0:	5b                   	pop    %ebx
  b1:	5f                   	pop    %edi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  ba:	8b 45 08             	mov    0x8(%ebp),%eax
  bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c0:	90                   	nop
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	8d 50 01             	lea    0x1(%eax),%edx
  c7:	89 55 08             	mov    %edx,0x8(%ebp)
  ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  d0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d3:	0f b6 12             	movzbl (%edx),%edx
  d6:	88 10                	mov    %dl,(%eax)
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	75 e2                	jne    c1 <strcpy+0xd>
    ;
  return os;
  df:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e2:	c9                   	leave  
  e3:	c3                   	ret    

000000e4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e7:	eb 08                	jmp    f1 <strcmp+0xd>
    p++, q++;
  e9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ed:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	84 c0                	test   %al,%al
  f9:	74 10                	je     10b <strcmp+0x27>
  fb:	8b 45 08             	mov    0x8(%ebp),%eax
  fe:	0f b6 10             	movzbl (%eax),%edx
 101:	8b 45 0c             	mov    0xc(%ebp),%eax
 104:	0f b6 00             	movzbl (%eax),%eax
 107:	38 c2                	cmp    %al,%dl
 109:	74 de                	je     e9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	0f b6 00             	movzbl (%eax),%eax
 111:	0f b6 d0             	movzbl %al,%edx
 114:	8b 45 0c             	mov    0xc(%ebp),%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	0f b6 c0             	movzbl %al,%eax
 11d:	29 c2                	sub    %eax,%edx
 11f:	89 d0                	mov    %edx,%eax
}
 121:	5d                   	pop    %ebp
 122:	c3                   	ret    

00000123 <strlen>:

uint
strlen(char *s)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 129:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 130:	eb 04                	jmp    136 <strlen+0x13>
 132:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 136:	8b 55 fc             	mov    -0x4(%ebp),%edx
 139:	8b 45 08             	mov    0x8(%ebp),%eax
 13c:	01 d0                	add    %edx,%eax
 13e:	0f b6 00             	movzbl (%eax),%eax
 141:	84 c0                	test   %al,%al
 143:	75 ed                	jne    132 <strlen+0xf>
    ;
  return n;
 145:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 148:	c9                   	leave  
 149:	c3                   	ret    

0000014a <memset>:

void*
memset(void *dst, int c, uint n)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 150:	8b 45 10             	mov    0x10(%ebp),%eax
 153:	89 44 24 08          	mov    %eax,0x8(%esp)
 157:	8b 45 0c             	mov    0xc(%ebp),%eax
 15a:	89 44 24 04          	mov    %eax,0x4(%esp)
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	89 04 24             	mov    %eax,(%esp)
 164:	e8 26 ff ff ff       	call   8f <stosb>
  return dst;
 169:	8b 45 08             	mov    0x8(%ebp),%eax
}
 16c:	c9                   	leave  
 16d:	c3                   	ret    

0000016e <strchr>:

char*
strchr(const char *s, char c)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 04             	sub    $0x4,%esp
 174:	8b 45 0c             	mov    0xc(%ebp),%eax
 177:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 17a:	eb 14                	jmp    190 <strchr+0x22>
    if(*s == c)
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	0f b6 00             	movzbl (%eax),%eax
 182:	3a 45 fc             	cmp    -0x4(%ebp),%al
 185:	75 05                	jne    18c <strchr+0x1e>
      return (char*)s;
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	eb 13                	jmp    19f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 18c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	84 c0                	test   %al,%al
 198:	75 e2                	jne    17c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 19a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 19f:	c9                   	leave  
 1a0:	c3                   	ret    

000001a1 <gets>:

char*
gets(char *buf, int max)
{
 1a1:	55                   	push   %ebp
 1a2:	89 e5                	mov    %esp,%ebp
 1a4:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1ae:	eb 4c                	jmp    1fc <gets+0x5b>
    cc = read(0, &c, 1);
 1b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1b7:	00 
 1b8:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1c6:	e8 44 01 00 00       	call   30f <read>
 1cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1d2:	7f 02                	jg     1d6 <gets+0x35>
      break;
 1d4:	eb 31                	jmp    207 <gets+0x66>
    buf[i++] = c;
 1d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d9:	8d 50 01             	lea    0x1(%eax),%edx
 1dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1df:	89 c2                	mov    %eax,%edx
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	01 c2                	add    %eax,%edx
 1e6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ea:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ec:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f0:	3c 0a                	cmp    $0xa,%al
 1f2:	74 13                	je     207 <gets+0x66>
 1f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f8:	3c 0d                	cmp    $0xd,%al
 1fa:	74 0b                	je     207 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ff:	83 c0 01             	add    $0x1,%eax
 202:	3b 45 0c             	cmp    0xc(%ebp),%eax
 205:	7c a9                	jl     1b0 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 207:	8b 55 f4             	mov    -0xc(%ebp),%edx
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	01 d0                	add    %edx,%eax
 20f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 212:	8b 45 08             	mov    0x8(%ebp),%eax
}
 215:	c9                   	leave  
 216:	c3                   	ret    

00000217 <stat>:

int
stat(char *n, struct stat *st)
{
 217:	55                   	push   %ebp
 218:	89 e5                	mov    %esp,%ebp
 21a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 224:	00 
 225:	8b 45 08             	mov    0x8(%ebp),%eax
 228:	89 04 24             	mov    %eax,(%esp)
 22b:	e8 07 01 00 00       	call   337 <open>
 230:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 233:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 237:	79 07                	jns    240 <stat+0x29>
    return -1;
 239:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23e:	eb 23                	jmp    263 <stat+0x4c>
  r = fstat(fd, st);
 240:	8b 45 0c             	mov    0xc(%ebp),%eax
 243:	89 44 24 04          	mov    %eax,0x4(%esp)
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	89 04 24             	mov    %eax,(%esp)
 24d:	e8 fd 00 00 00       	call   34f <fstat>
 252:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 255:	8b 45 f4             	mov    -0xc(%ebp),%eax
 258:	89 04 24             	mov    %eax,(%esp)
 25b:	e8 bf 00 00 00       	call   31f <close>
  return r;
 260:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 263:	c9                   	leave  
 264:	c3                   	ret    

00000265 <atoi>:

int
atoi(const char *s)
{
 265:	55                   	push   %ebp
 266:	89 e5                	mov    %esp,%ebp
 268:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 26b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 272:	eb 25                	jmp    299 <atoi+0x34>
    n = n*10 + *s++ - '0';
 274:	8b 55 fc             	mov    -0x4(%ebp),%edx
 277:	89 d0                	mov    %edx,%eax
 279:	c1 e0 02             	shl    $0x2,%eax
 27c:	01 d0                	add    %edx,%eax
 27e:	01 c0                	add    %eax,%eax
 280:	89 c1                	mov    %eax,%ecx
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	8d 50 01             	lea    0x1(%eax),%edx
 288:	89 55 08             	mov    %edx,0x8(%ebp)
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	0f be c0             	movsbl %al,%eax
 291:	01 c8                	add    %ecx,%eax
 293:	83 e8 30             	sub    $0x30,%eax
 296:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	0f b6 00             	movzbl (%eax),%eax
 29f:	3c 2f                	cmp    $0x2f,%al
 2a1:	7e 0a                	jle    2ad <atoi+0x48>
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 00             	movzbl (%eax),%eax
 2a9:	3c 39                	cmp    $0x39,%al
 2ab:	7e c7                	jle    274 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b0:	c9                   	leave  
 2b1:	c3                   	ret    

000002b2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b2:	55                   	push   %ebp
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
 2bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2be:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2c4:	eb 17                	jmp    2dd <memmove+0x2b>
    *dst++ = *src++;
 2c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c9:	8d 50 01             	lea    0x1(%eax),%edx
 2cc:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2cf:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2d2:	8d 4a 01             	lea    0x1(%edx),%ecx
 2d5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2d8:	0f b6 12             	movzbl (%edx),%edx
 2db:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2dd:	8b 45 10             	mov    0x10(%ebp),%eax
 2e0:	8d 50 ff             	lea    -0x1(%eax),%edx
 2e3:	89 55 10             	mov    %edx,0x10(%ebp)
 2e6:	85 c0                	test   %eax,%eax
 2e8:	7f dc                	jg     2c6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ed:	c9                   	leave  
 2ee:	c3                   	ret    

000002ef <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ef:	b8 01 00 00 00       	mov    $0x1,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <exit>:
SYSCALL(exit)
 2f7:	b8 02 00 00 00       	mov    $0x2,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <wait>:
SYSCALL(wait)
 2ff:	b8 03 00 00 00       	mov    $0x3,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <pipe>:
SYSCALL(pipe)
 307:	b8 04 00 00 00       	mov    $0x4,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <read>:
SYSCALL(read)
 30f:	b8 05 00 00 00       	mov    $0x5,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <write>:
SYSCALL(write)
 317:	b8 10 00 00 00       	mov    $0x10,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <close>:
SYSCALL(close)
 31f:	b8 15 00 00 00       	mov    $0x15,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <kill>:
SYSCALL(kill)
 327:	b8 06 00 00 00       	mov    $0x6,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <exec>:
SYSCALL(exec)
 32f:	b8 07 00 00 00       	mov    $0x7,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <open>:
SYSCALL(open)
 337:	b8 0f 00 00 00       	mov    $0xf,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <mknod>:
SYSCALL(mknod)
 33f:	b8 11 00 00 00       	mov    $0x11,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <unlink>:
SYSCALL(unlink)
 347:	b8 12 00 00 00       	mov    $0x12,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <fstat>:
SYSCALL(fstat)
 34f:	b8 08 00 00 00       	mov    $0x8,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <link>:
SYSCALL(link)
 357:	b8 13 00 00 00       	mov    $0x13,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <mkdir>:
SYSCALL(mkdir)
 35f:	b8 14 00 00 00       	mov    $0x14,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <chdir>:
SYSCALL(chdir)
 367:	b8 09 00 00 00       	mov    $0x9,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <dup>:
SYSCALL(dup)
 36f:	b8 0a 00 00 00       	mov    $0xa,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <getpid>:
SYSCALL(getpid)
 377:	b8 0b 00 00 00       	mov    $0xb,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <sbrk>:
SYSCALL(sbrk)
 37f:	b8 0c 00 00 00       	mov    $0xc,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <sleep>:
SYSCALL(sleep)
 387:	b8 0d 00 00 00       	mov    $0xd,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <uptime>:
SYSCALL(uptime)
 38f:	b8 0e 00 00 00       	mov    $0xe,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <kthread_create>:
SYSCALL(kthread_create)
 397:	b8 17 00 00 00       	mov    $0x17,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <kthread_join>:
SYSCALL(kthread_join)
 39f:	b8 16 00 00 00       	mov    $0x16,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 3a7:	b8 18 00 00 00       	mov    $0x18,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 3af:	b8 19 00 00 00       	mov    $0x19,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 3b7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 3bf:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 3c7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3cf:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3d7:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3df:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <kthread_cond_broadcast>:
 3e7:	b8 20 00 00 00       	mov    $0x20,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ef:	55                   	push   %ebp
 3f0:	89 e5                	mov    %esp,%ebp
 3f2:	83 ec 18             	sub    $0x18,%esp
 3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3fb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 402:	00 
 403:	8d 45 f4             	lea    -0xc(%ebp),%eax
 406:	89 44 24 04          	mov    %eax,0x4(%esp)
 40a:	8b 45 08             	mov    0x8(%ebp),%eax
 40d:	89 04 24             	mov    %eax,(%esp)
 410:	e8 02 ff ff ff       	call   317 <write>
}
 415:	c9                   	leave  
 416:	c3                   	ret    

00000417 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 417:	55                   	push   %ebp
 418:	89 e5                	mov    %esp,%ebp
 41a:	56                   	push   %esi
 41b:	53                   	push   %ebx
 41c:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 41f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 426:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 42a:	74 17                	je     443 <printint+0x2c>
 42c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 430:	79 11                	jns    443 <printint+0x2c>
    neg = 1;
 432:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 439:	8b 45 0c             	mov    0xc(%ebp),%eax
 43c:	f7 d8                	neg    %eax
 43e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 441:	eb 06                	jmp    449 <printint+0x32>
  } else {
    x = xx;
 443:	8b 45 0c             	mov    0xc(%ebp),%eax
 446:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 449:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 450:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 453:	8d 41 01             	lea    0x1(%ecx),%eax
 456:	89 45 f4             	mov    %eax,-0xc(%ebp)
 459:	8b 5d 10             	mov    0x10(%ebp),%ebx
 45c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45f:	ba 00 00 00 00       	mov    $0x0,%edx
 464:	f7 f3                	div    %ebx
 466:	89 d0                	mov    %edx,%eax
 468:	0f b6 80 10 0e 00 00 	movzbl 0xe10(%eax),%eax
 46f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 473:	8b 75 10             	mov    0x10(%ebp),%esi
 476:	8b 45 ec             	mov    -0x14(%ebp),%eax
 479:	ba 00 00 00 00       	mov    $0x0,%edx
 47e:	f7 f6                	div    %esi
 480:	89 45 ec             	mov    %eax,-0x14(%ebp)
 483:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 487:	75 c7                	jne    450 <printint+0x39>
  if(neg)
 489:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 48d:	74 10                	je     49f <printint+0x88>
    buf[i++] = '-';
 48f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 492:	8d 50 01             	lea    0x1(%eax),%edx
 495:	89 55 f4             	mov    %edx,-0xc(%ebp)
 498:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 49d:	eb 1f                	jmp    4be <printint+0xa7>
 49f:	eb 1d                	jmp    4be <printint+0xa7>
    putc(fd, buf[i]);
 4a1:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a7:	01 d0                	add    %edx,%eax
 4a9:	0f b6 00             	movzbl (%eax),%eax
 4ac:	0f be c0             	movsbl %al,%eax
 4af:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b3:	8b 45 08             	mov    0x8(%ebp),%eax
 4b6:	89 04 24             	mov    %eax,(%esp)
 4b9:	e8 31 ff ff ff       	call   3ef <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4be:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c6:	79 d9                	jns    4a1 <printint+0x8a>
    putc(fd, buf[i]);
}
 4c8:	83 c4 30             	add    $0x30,%esp
 4cb:	5b                   	pop    %ebx
 4cc:	5e                   	pop    %esi
 4cd:	5d                   	pop    %ebp
 4ce:	c3                   	ret    

000004cf <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4cf:	55                   	push   %ebp
 4d0:	89 e5                	mov    %esp,%ebp
 4d2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4dc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4df:	83 c0 04             	add    $0x4,%eax
 4e2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ec:	e9 7c 01 00 00       	jmp    66d <printf+0x19e>
    c = fmt[i] & 0xff;
 4f1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4f7:	01 d0                	add    %edx,%eax
 4f9:	0f b6 00             	movzbl (%eax),%eax
 4fc:	0f be c0             	movsbl %al,%eax
 4ff:	25 ff 00 00 00       	and    $0xff,%eax
 504:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 507:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50b:	75 2c                	jne    539 <printf+0x6a>
      if(c == '%'){
 50d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 511:	75 0c                	jne    51f <printf+0x50>
        state = '%';
 513:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 51a:	e9 4a 01 00 00       	jmp    669 <printf+0x19a>
      } else {
        putc(fd, c);
 51f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 522:	0f be c0             	movsbl %al,%eax
 525:	89 44 24 04          	mov    %eax,0x4(%esp)
 529:	8b 45 08             	mov    0x8(%ebp),%eax
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 bb fe ff ff       	call   3ef <putc>
 534:	e9 30 01 00 00       	jmp    669 <printf+0x19a>
      }
    } else if(state == '%'){
 539:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 53d:	0f 85 26 01 00 00    	jne    669 <printf+0x19a>
      if(c == 'd'){
 543:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 547:	75 2d                	jne    576 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 549:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54c:	8b 00                	mov    (%eax),%eax
 54e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 555:	00 
 556:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 55d:	00 
 55e:	89 44 24 04          	mov    %eax,0x4(%esp)
 562:	8b 45 08             	mov    0x8(%ebp),%eax
 565:	89 04 24             	mov    %eax,(%esp)
 568:	e8 aa fe ff ff       	call   417 <printint>
        ap++;
 56d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 571:	e9 ec 00 00 00       	jmp    662 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 576:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 57a:	74 06                	je     582 <printf+0xb3>
 57c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 580:	75 2d                	jne    5af <printf+0xe0>
        printint(fd, *ap, 16, 0);
 582:	8b 45 e8             	mov    -0x18(%ebp),%eax
 585:	8b 00                	mov    (%eax),%eax
 587:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 58e:	00 
 58f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 596:	00 
 597:	89 44 24 04          	mov    %eax,0x4(%esp)
 59b:	8b 45 08             	mov    0x8(%ebp),%eax
 59e:	89 04 24             	mov    %eax,(%esp)
 5a1:	e8 71 fe ff ff       	call   417 <printint>
        ap++;
 5a6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5aa:	e9 b3 00 00 00       	jmp    662 <printf+0x193>
      } else if(c == 's'){
 5af:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5b3:	75 45                	jne    5fa <printf+0x12b>
        s = (char*)*ap;
 5b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b8:	8b 00                	mov    (%eax),%eax
 5ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5bd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c5:	75 09                	jne    5d0 <printf+0x101>
          s = "(null)";
 5c7:	c7 45 f4 3b 0a 00 00 	movl   $0xa3b,-0xc(%ebp)
        while(*s != 0){
 5ce:	eb 1e                	jmp    5ee <printf+0x11f>
 5d0:	eb 1c                	jmp    5ee <printf+0x11f>
          putc(fd, *s);
 5d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d5:	0f b6 00             	movzbl (%eax),%eax
 5d8:	0f be c0             	movsbl %al,%eax
 5db:	89 44 24 04          	mov    %eax,0x4(%esp)
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	89 04 24             	mov    %eax,(%esp)
 5e5:	e8 05 fe ff ff       	call   3ef <putc>
          s++;
 5ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f1:	0f b6 00             	movzbl (%eax),%eax
 5f4:	84 c0                	test   %al,%al
 5f6:	75 da                	jne    5d2 <printf+0x103>
 5f8:	eb 68                	jmp    662 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fa:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5fe:	75 1d                	jne    61d <printf+0x14e>
        putc(fd, *ap);
 600:	8b 45 e8             	mov    -0x18(%ebp),%eax
 603:	8b 00                	mov    (%eax),%eax
 605:	0f be c0             	movsbl %al,%eax
 608:	89 44 24 04          	mov    %eax,0x4(%esp)
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	89 04 24             	mov    %eax,(%esp)
 612:	e8 d8 fd ff ff       	call   3ef <putc>
        ap++;
 617:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61b:	eb 45                	jmp    662 <printf+0x193>
      } else if(c == '%'){
 61d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 621:	75 17                	jne    63a <printf+0x16b>
        putc(fd, c);
 623:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 626:	0f be c0             	movsbl %al,%eax
 629:	89 44 24 04          	mov    %eax,0x4(%esp)
 62d:	8b 45 08             	mov    0x8(%ebp),%eax
 630:	89 04 24             	mov    %eax,(%esp)
 633:	e8 b7 fd ff ff       	call   3ef <putc>
 638:	eb 28                	jmp    662 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 641:	00 
 642:	8b 45 08             	mov    0x8(%ebp),%eax
 645:	89 04 24             	mov    %eax,(%esp)
 648:	e8 a2 fd ff ff       	call   3ef <putc>
        putc(fd, c);
 64d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 650:	0f be c0             	movsbl %al,%eax
 653:	89 44 24 04          	mov    %eax,0x4(%esp)
 657:	8b 45 08             	mov    0x8(%ebp),%eax
 65a:	89 04 24             	mov    %eax,(%esp)
 65d:	e8 8d fd ff ff       	call   3ef <putc>
      }
      state = 0;
 662:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 669:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 66d:	8b 55 0c             	mov    0xc(%ebp),%edx
 670:	8b 45 f0             	mov    -0x10(%ebp),%eax
 673:	01 d0                	add    %edx,%eax
 675:	0f b6 00             	movzbl (%eax),%eax
 678:	84 c0                	test   %al,%al
 67a:	0f 85 71 fe ff ff    	jne    4f1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 680:	c9                   	leave  
 681:	c3                   	ret    

00000682 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 682:	55                   	push   %ebp
 683:	89 e5                	mov    %esp,%ebp
 685:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 688:	8b 45 08             	mov    0x8(%ebp),%eax
 68b:	83 e8 08             	sub    $0x8,%eax
 68e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 2c 0e 00 00       	mov    0xe2c,%eax
 696:	89 45 fc             	mov    %eax,-0x4(%ebp)
 699:	eb 24                	jmp    6bf <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a3:	77 12                	ja     6b7 <free+0x35>
 6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ab:	77 24                	ja     6d1 <free+0x4f>
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b5:	77 1a                	ja     6d1 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c5:	76 d4                	jbe    69b <free+0x19>
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 00                	mov    (%eax),%eax
 6cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cf:	76 ca                	jbe    69b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d4:	8b 40 04             	mov    0x4(%eax),%eax
 6d7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	01 c2                	add    %eax,%edx
 6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e6:	8b 00                	mov    (%eax),%eax
 6e8:	39 c2                	cmp    %eax,%edx
 6ea:	75 24                	jne    710 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ef:	8b 50 04             	mov    0x4(%eax),%edx
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 00                	mov    (%eax),%eax
 6f7:	8b 40 04             	mov    0x4(%eax),%eax
 6fa:	01 c2                	add    %eax,%edx
 6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	8b 10                	mov    (%eax),%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	89 10                	mov    %edx,(%eax)
 70e:	eb 0a                	jmp    71a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 710:	8b 45 fc             	mov    -0x4(%ebp),%eax
 713:	8b 10                	mov    (%eax),%edx
 715:	8b 45 f8             	mov    -0x8(%ebp),%eax
 718:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 71a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71d:	8b 40 04             	mov    0x4(%eax),%eax
 720:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	01 d0                	add    %edx,%eax
 72c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72f:	75 20                	jne    751 <free+0xcf>
    p->s.size += bp->s.size;
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 50 04             	mov    0x4(%eax),%edx
 737:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73a:	8b 40 04             	mov    0x4(%eax),%eax
 73d:	01 c2                	add    %eax,%edx
 73f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 742:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 745:	8b 45 f8             	mov    -0x8(%ebp),%eax
 748:	8b 10                	mov    (%eax),%edx
 74a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74d:	89 10                	mov    %edx,(%eax)
 74f:	eb 08                	jmp    759 <free+0xd7>
  } else
    p->s.ptr = bp;
 751:	8b 45 fc             	mov    -0x4(%ebp),%eax
 754:	8b 55 f8             	mov    -0x8(%ebp),%edx
 757:	89 10                	mov    %edx,(%eax)
  freep = p;
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	a3 2c 0e 00 00       	mov    %eax,0xe2c
}
 761:	c9                   	leave  
 762:	c3                   	ret    

00000763 <morecore>:

static Header*
morecore(uint nu)
{
 763:	55                   	push   %ebp
 764:	89 e5                	mov    %esp,%ebp
 766:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 769:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 770:	77 07                	ja     779 <morecore+0x16>
    nu = 4096;
 772:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 779:	8b 45 08             	mov    0x8(%ebp),%eax
 77c:	c1 e0 03             	shl    $0x3,%eax
 77f:	89 04 24             	mov    %eax,(%esp)
 782:	e8 f8 fb ff ff       	call   37f <sbrk>
 787:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 78a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 78e:	75 07                	jne    797 <morecore+0x34>
    return 0;
 790:	b8 00 00 00 00       	mov    $0x0,%eax
 795:	eb 22                	jmp    7b9 <morecore+0x56>
  hp = (Header*)p;
 797:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	8b 55 08             	mov    0x8(%ebp),%edx
 7a3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	83 c0 08             	add    $0x8,%eax
 7ac:	89 04 24             	mov    %eax,(%esp)
 7af:	e8 ce fe ff ff       	call   682 <free>
  return freep;
 7b4:	a1 2c 0e 00 00       	mov    0xe2c,%eax
}
 7b9:	c9                   	leave  
 7ba:	c3                   	ret    

000007bb <malloc>:

void*
malloc(uint nbytes)
{
 7bb:	55                   	push   %ebp
 7bc:	89 e5                	mov    %esp,%ebp
 7be:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c1:	8b 45 08             	mov    0x8(%ebp),%eax
 7c4:	83 c0 07             	add    $0x7,%eax
 7c7:	c1 e8 03             	shr    $0x3,%eax
 7ca:	83 c0 01             	add    $0x1,%eax
 7cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d0:	a1 2c 0e 00 00       	mov    0xe2c,%eax
 7d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7dc:	75 23                	jne    801 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7de:	c7 45 f0 24 0e 00 00 	movl   $0xe24,-0x10(%ebp)
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	a3 2c 0e 00 00       	mov    %eax,0xe2c
 7ed:	a1 2c 0e 00 00       	mov    0xe2c,%eax
 7f2:	a3 24 0e 00 00       	mov    %eax,0xe24
    base.s.size = 0;
 7f7:	c7 05 28 0e 00 00 00 	movl   $0x0,0xe28
 7fe:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 801:	8b 45 f0             	mov    -0x10(%ebp),%eax
 804:	8b 00                	mov    (%eax),%eax
 806:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	8b 40 04             	mov    0x4(%eax),%eax
 80f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 812:	72 4d                	jb     861 <malloc+0xa6>
      if(p->s.size == nunits)
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 40 04             	mov    0x4(%eax),%eax
 81a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81d:	75 0c                	jne    82b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 822:	8b 10                	mov    (%eax),%edx
 824:	8b 45 f0             	mov    -0x10(%ebp),%eax
 827:	89 10                	mov    %edx,(%eax)
 829:	eb 26                	jmp    851 <malloc+0x96>
      else {
        p->s.size -= nunits;
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	8b 40 04             	mov    0x4(%eax),%eax
 831:	2b 45 ec             	sub    -0x14(%ebp),%eax
 834:	89 c2                	mov    %eax,%edx
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	8b 40 04             	mov    0x4(%eax),%eax
 842:	c1 e0 03             	shl    $0x3,%eax
 845:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 848:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 84e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 851:	8b 45 f0             	mov    -0x10(%ebp),%eax
 854:	a3 2c 0e 00 00       	mov    %eax,0xe2c
      return (void*)(p + 1);
 859:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85c:	83 c0 08             	add    $0x8,%eax
 85f:	eb 38                	jmp    899 <malloc+0xde>
    }
    if(p == freep)
 861:	a1 2c 0e 00 00       	mov    0xe2c,%eax
 866:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 869:	75 1b                	jne    886 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 86b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 86e:	89 04 24             	mov    %eax,(%esp)
 871:	e8 ed fe ff ff       	call   763 <morecore>
 876:	89 45 f4             	mov    %eax,-0xc(%ebp)
 879:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 87d:	75 07                	jne    886 <malloc+0xcb>
        return 0;
 87f:	b8 00 00 00 00       	mov    $0x0,%eax
 884:	eb 13                	jmp    899 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 886:	8b 45 f4             	mov    -0xc(%ebp),%eax
 889:	89 45 f0             	mov    %eax,-0x10(%ebp)
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 00                	mov    (%eax),%eax
 891:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 894:	e9 70 ff ff ff       	jmp    809 <malloc+0x4e>
}
 899:	c9                   	leave  
 89a:	c3                   	ret    

0000089b <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 89b:	55                   	push   %ebp
 89c:	89 e5                	mov    %esp,%ebp
 89e:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 8a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 8a4:	89 04 24             	mov    %eax,(%esp)
 8a7:	8b 45 08             	mov    0x8(%ebp),%eax
 8aa:	ff d0                	call   *%eax
    exit();
 8ac:	e8 46 fa ff ff       	call   2f7 <exit>

000008b1 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 8b1:	55                   	push   %ebp
 8b2:	89 e5                	mov    %esp,%ebp
 8b4:	57                   	push   %edi
 8b5:	56                   	push   %esi
 8b6:	53                   	push   %ebx
 8b7:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 8ba:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8c1:	e8 f5 fe ff ff       	call   7bb <malloc>
 8c6:	8b 55 08             	mov    0x8(%ebp),%edx
 8c9:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8cb:	8b 45 10             	mov    0x10(%ebp),%eax
 8ce:	8b 38                	mov    (%eax),%edi
 8d0:	8b 75 0c             	mov    0xc(%ebp),%esi
 8d3:	bb 9b 08 00 00       	mov    $0x89b,%ebx
 8d8:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8df:	e8 d7 fe ff ff       	call   7bb <malloc>
 8e4:	05 00 10 00 00       	add    $0x1000,%eax
 8e9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8ed:	89 74 24 08          	mov    %esi,0x8(%esp)
 8f1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8f5:	89 04 24             	mov    %eax,(%esp)
 8f8:	e8 9a fa ff ff       	call   397 <kthread_create>
 8fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 900:	8b 45 08             	mov    0x8(%ebp),%eax
 903:	8b 00                	mov    (%eax),%eax
 905:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 908:	89 10                	mov    %edx,(%eax)
    return t_id;
 90a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 90d:	83 c4 2c             	add    $0x2c,%esp
 910:	5b                   	pop    %ebx
 911:	5e                   	pop    %esi
 912:	5f                   	pop    %edi
 913:	5d                   	pop    %ebp
 914:	c3                   	ret    

00000915 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 915:	55                   	push   %ebp
 916:	89 e5                	mov    %esp,%ebp
 918:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 91b:	8b 55 0c             	mov    0xc(%ebp),%edx
 91e:	8b 45 08             	mov    0x8(%ebp),%eax
 921:	8b 00                	mov    (%eax),%eax
 923:	89 54 24 04          	mov    %edx,0x4(%esp)
 927:	89 04 24             	mov    %eax,(%esp)
 92a:	e8 70 fa ff ff       	call   39f <kthread_join>
 92f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 932:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 935:	c9                   	leave  
 936:	c3                   	ret    

00000937 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 937:	55                   	push   %ebp
 938:	89 e5                	mov    %esp,%ebp
 93a:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 93d:	e8 65 fa ff ff       	call   3a7 <kthread_mutex_init>
 942:	8b 55 08             	mov    0x8(%ebp),%edx
 945:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 947:	8b 45 08             	mov    0x8(%ebp),%eax
 94a:	8b 00                	mov    (%eax),%eax
 94c:	85 c0                	test   %eax,%eax
 94e:	7e 07                	jle    957 <qthread_mutex_init+0x20>
		return 0;
 950:	b8 00 00 00 00       	mov    $0x0,%eax
 955:	eb 05                	jmp    95c <qthread_mutex_init+0x25>
	}
	return *mutex;
 957:	8b 45 08             	mov    0x8(%ebp),%eax
 95a:	8b 00                	mov    (%eax),%eax
}
 95c:	c9                   	leave  
 95d:	c3                   	ret    

0000095e <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 95e:	55                   	push   %ebp
 95f:	89 e5                	mov    %esp,%ebp
 961:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 964:	8b 45 08             	mov    0x8(%ebp),%eax
 967:	89 04 24             	mov    %eax,(%esp)
 96a:	e8 40 fa ff ff       	call   3af <kthread_mutex_destroy>
 96f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 972:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 976:	79 07                	jns    97f <qthread_mutex_destroy+0x21>
    	return -1;
 978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 97d:	eb 05                	jmp    984 <qthread_mutex_destroy+0x26>
    }
    return 0;
 97f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 984:	c9                   	leave  
 985:	c3                   	ret    

00000986 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 986:	55                   	push   %ebp
 987:	89 e5                	mov    %esp,%ebp
 989:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 98c:	8b 45 08             	mov    0x8(%ebp),%eax
 98f:	89 04 24             	mov    %eax,(%esp)
 992:	e8 20 fa ff ff       	call   3b7 <kthread_mutex_lock>
 997:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 99a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99e:	79 07                	jns    9a7 <qthread_mutex_lock+0x21>
    	return -1;
 9a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9a5:	eb 05                	jmp    9ac <qthread_mutex_lock+0x26>
    }
    return 0;
 9a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9ac:	c9                   	leave  
 9ad:	c3                   	ret    

000009ae <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 9ae:	55                   	push   %ebp
 9af:	89 e5                	mov    %esp,%ebp
 9b1:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 9b4:	8b 45 08             	mov    0x8(%ebp),%eax
 9b7:	89 04 24             	mov    %eax,(%esp)
 9ba:	e8 00 fa ff ff       	call   3bf <kthread_mutex_unlock>
 9bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9c6:	79 07                	jns    9cf <qthread_mutex_unlock+0x21>
    	return -1;
 9c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9cd:	eb 05                	jmp    9d4 <qthread_mutex_unlock+0x26>
    }
    return 0;
 9cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d4:	c9                   	leave  
 9d5:	c3                   	ret    

000009d6 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9d6:	55                   	push   %ebp
 9d7:	89 e5                	mov    %esp,%ebp

	return 0;
 9d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9de:	5d                   	pop    %ebp
 9df:	c3                   	ret    

000009e0 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9e8:	5d                   	pop    %ebp
 9e9:	c3                   	ret    

000009ea <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9ea:	55                   	push   %ebp
 9eb:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f2:	5d                   	pop    %ebp
 9f3:	c3                   	ret    

000009f4 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9f4:	55                   	push   %ebp
 9f5:	89 e5                	mov    %esp,%ebp
	return 0;
 9f7:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9fc:	5d                   	pop    %ebp
 9fd:	c3                   	ret    

000009fe <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9fe:	55                   	push   %ebp
 9ff:	89 e5                	mov    %esp,%ebp
	return 0;
 a01:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a06:	5d                   	pop    %ebp
 a07:	c3                   	ret    
