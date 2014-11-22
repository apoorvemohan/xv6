
_rm:     file format elf32-i386


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
    printf(2, "Usage: rm files...\n");
   f:	c7 44 24 04 1a 0a 00 	movl   $0xa1a,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 b4 04 00 00       	call   4d7 <printf>
    exit();
  23:	e8 cf 02 00 00       	call   2f7 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 4f                	jmp    81 <main+0x81>
    if(unlink(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 fb 02 00 00       	call   347 <unlink>
  4c:	85 c0                	test   %eax,%eax
  4e:	79 2c                	jns    7c <main+0x7c>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  50:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  5e:	01 d0                	add    %edx,%eax
  60:	8b 00                	mov    (%eax),%eax
  62:	89 44 24 08          	mov    %eax,0x8(%esp)
  66:	c7 44 24 04 2e 0a 00 	movl   $0xa2e,0x4(%esp)
  6d:	00 
  6e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  75:	e8 5d 04 00 00       	call   4d7 <printf>
      break;
  7a:	eb 0e                	jmp    8a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  7c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  81:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  85:	3b 45 08             	cmp    0x8(%ebp),%eax
  88:	7c a8                	jl     32 <main+0x32>
      printf(2, "rm: %s failed to delete\n", argv[i]);
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
SYSCALL(kthread_cond_broadcast)
 3e7:	b8 20 00 00 00       	mov    $0x20,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <kthread_exit>:
 3ef:	b8 21 00 00 00       	mov    $0x21,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f7:	55                   	push   %ebp
 3f8:	89 e5                	mov    %esp,%ebp
 3fa:	83 ec 18             	sub    $0x18,%esp
 3fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 400:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 403:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40a:	00 
 40b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 40e:	89 44 24 04          	mov    %eax,0x4(%esp)
 412:	8b 45 08             	mov    0x8(%ebp),%eax
 415:	89 04 24             	mov    %eax,(%esp)
 418:	e8 fa fe ff ff       	call   317 <write>
}
 41d:	c9                   	leave  
 41e:	c3                   	ret    

0000041f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41f:	55                   	push   %ebp
 420:	89 e5                	mov    %esp,%ebp
 422:	56                   	push   %esi
 423:	53                   	push   %ebx
 424:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 427:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 42e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 432:	74 17                	je     44b <printint+0x2c>
 434:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 438:	79 11                	jns    44b <printint+0x2c>
    neg = 1;
 43a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 441:	8b 45 0c             	mov    0xc(%ebp),%eax
 444:	f7 d8                	neg    %eax
 446:	89 45 ec             	mov    %eax,-0x14(%ebp)
 449:	eb 06                	jmp    451 <printint+0x32>
  } else {
    x = xx;
 44b:	8b 45 0c             	mov    0xc(%ebp),%eax
 44e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 451:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 458:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 45b:	8d 41 01             	lea    0x1(%ecx),%eax
 45e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 461:	8b 5d 10             	mov    0x10(%ebp),%ebx
 464:	8b 45 ec             	mov    -0x14(%ebp),%eax
 467:	ba 00 00 00 00       	mov    $0x0,%edx
 46c:	f7 f3                	div    %ebx
 46e:	89 d0                	mov    %edx,%eax
 470:	0f b6 80 3c 0e 00 00 	movzbl 0xe3c(%eax),%eax
 477:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 47b:	8b 75 10             	mov    0x10(%ebp),%esi
 47e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 481:	ba 00 00 00 00       	mov    $0x0,%edx
 486:	f7 f6                	div    %esi
 488:	89 45 ec             	mov    %eax,-0x14(%ebp)
 48b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48f:	75 c7                	jne    458 <printint+0x39>
  if(neg)
 491:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 495:	74 10                	je     4a7 <printint+0x88>
    buf[i++] = '-';
 497:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49a:	8d 50 01             	lea    0x1(%eax),%edx
 49d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4a5:	eb 1f                	jmp    4c6 <printint+0xa7>
 4a7:	eb 1d                	jmp    4c6 <printint+0xa7>
    putc(fd, buf[i]);
 4a9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4af:	01 d0                	add    %edx,%eax
 4b1:	0f b6 00             	movzbl (%eax),%eax
 4b4:	0f be c0             	movsbl %al,%eax
 4b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bb:	8b 45 08             	mov    0x8(%ebp),%eax
 4be:	89 04 24             	mov    %eax,(%esp)
 4c1:	e8 31 ff ff ff       	call   3f7 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4c6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ce:	79 d9                	jns    4a9 <printint+0x8a>
    putc(fd, buf[i]);
}
 4d0:	83 c4 30             	add    $0x30,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    

000004d7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d7:	55                   	push   %ebp
 4d8:	89 e5                	mov    %esp,%ebp
 4da:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4e4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4e7:	83 c0 04             	add    $0x4,%eax
 4ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4f4:	e9 7c 01 00 00       	jmp    675 <printf+0x19e>
    c = fmt[i] & 0xff;
 4f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ff:	01 d0                	add    %edx,%eax
 501:	0f b6 00             	movzbl (%eax),%eax
 504:	0f be c0             	movsbl %al,%eax
 507:	25 ff 00 00 00       	and    $0xff,%eax
 50c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 50f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 513:	75 2c                	jne    541 <printf+0x6a>
      if(c == '%'){
 515:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 519:	75 0c                	jne    527 <printf+0x50>
        state = '%';
 51b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 522:	e9 4a 01 00 00       	jmp    671 <printf+0x19a>
      } else {
        putc(fd, c);
 527:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 52a:	0f be c0             	movsbl %al,%eax
 52d:	89 44 24 04          	mov    %eax,0x4(%esp)
 531:	8b 45 08             	mov    0x8(%ebp),%eax
 534:	89 04 24             	mov    %eax,(%esp)
 537:	e8 bb fe ff ff       	call   3f7 <putc>
 53c:	e9 30 01 00 00       	jmp    671 <printf+0x19a>
      }
    } else if(state == '%'){
 541:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 545:	0f 85 26 01 00 00    	jne    671 <printf+0x19a>
      if(c == 'd'){
 54b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 54f:	75 2d                	jne    57e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 551:	8b 45 e8             	mov    -0x18(%ebp),%eax
 554:	8b 00                	mov    (%eax),%eax
 556:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 55d:	00 
 55e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 565:	00 
 566:	89 44 24 04          	mov    %eax,0x4(%esp)
 56a:	8b 45 08             	mov    0x8(%ebp),%eax
 56d:	89 04 24             	mov    %eax,(%esp)
 570:	e8 aa fe ff ff       	call   41f <printint>
        ap++;
 575:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 579:	e9 ec 00 00 00       	jmp    66a <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 57e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 582:	74 06                	je     58a <printf+0xb3>
 584:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 588:	75 2d                	jne    5b7 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 58a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58d:	8b 00                	mov    (%eax),%eax
 58f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 596:	00 
 597:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 59e:	00 
 59f:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	89 04 24             	mov    %eax,(%esp)
 5a9:	e8 71 fe ff ff       	call   41f <printint>
        ap++;
 5ae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b2:	e9 b3 00 00 00       	jmp    66a <printf+0x193>
      } else if(c == 's'){
 5b7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5bb:	75 45                	jne    602 <printf+0x12b>
        s = (char*)*ap;
 5bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c0:	8b 00                	mov    (%eax),%eax
 5c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5cd:	75 09                	jne    5d8 <printf+0x101>
          s = "(null)";
 5cf:	c7 45 f4 47 0a 00 00 	movl   $0xa47,-0xc(%ebp)
        while(*s != 0){
 5d6:	eb 1e                	jmp    5f6 <printf+0x11f>
 5d8:	eb 1c                	jmp    5f6 <printf+0x11f>
          putc(fd, *s);
 5da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5dd:	0f b6 00             	movzbl (%eax),%eax
 5e0:	0f be c0             	movsbl %al,%eax
 5e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ea:	89 04 24             	mov    %eax,(%esp)
 5ed:	e8 05 fe ff ff       	call   3f7 <putc>
          s++;
 5f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f9:	0f b6 00             	movzbl (%eax),%eax
 5fc:	84 c0                	test   %al,%al
 5fe:	75 da                	jne    5da <printf+0x103>
 600:	eb 68                	jmp    66a <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 602:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 606:	75 1d                	jne    625 <printf+0x14e>
        putc(fd, *ap);
 608:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60b:	8b 00                	mov    (%eax),%eax
 60d:	0f be c0             	movsbl %al,%eax
 610:	89 44 24 04          	mov    %eax,0x4(%esp)
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	89 04 24             	mov    %eax,(%esp)
 61a:	e8 d8 fd ff ff       	call   3f7 <putc>
        ap++;
 61f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 623:	eb 45                	jmp    66a <printf+0x193>
      } else if(c == '%'){
 625:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 629:	75 17                	jne    642 <printf+0x16b>
        putc(fd, c);
 62b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62e:	0f be c0             	movsbl %al,%eax
 631:	89 44 24 04          	mov    %eax,0x4(%esp)
 635:	8b 45 08             	mov    0x8(%ebp),%eax
 638:	89 04 24             	mov    %eax,(%esp)
 63b:	e8 b7 fd ff ff       	call   3f7 <putc>
 640:	eb 28                	jmp    66a <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 642:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 649:	00 
 64a:	8b 45 08             	mov    0x8(%ebp),%eax
 64d:	89 04 24             	mov    %eax,(%esp)
 650:	e8 a2 fd ff ff       	call   3f7 <putc>
        putc(fd, c);
 655:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 658:	0f be c0             	movsbl %al,%eax
 65b:	89 44 24 04          	mov    %eax,0x4(%esp)
 65f:	8b 45 08             	mov    0x8(%ebp),%eax
 662:	89 04 24             	mov    %eax,(%esp)
 665:	e8 8d fd ff ff       	call   3f7 <putc>
      }
      state = 0;
 66a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 671:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 675:	8b 55 0c             	mov    0xc(%ebp),%edx
 678:	8b 45 f0             	mov    -0x10(%ebp),%eax
 67b:	01 d0                	add    %edx,%eax
 67d:	0f b6 00             	movzbl (%eax),%eax
 680:	84 c0                	test   %al,%al
 682:	0f 85 71 fe ff ff    	jne    4f9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 688:	c9                   	leave  
 689:	c3                   	ret    

0000068a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 68a:	55                   	push   %ebp
 68b:	89 e5                	mov    %esp,%ebp
 68d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 690:	8b 45 08             	mov    0x8(%ebp),%eax
 693:	83 e8 08             	sub    $0x8,%eax
 696:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 699:	a1 58 0e 00 00       	mov    0xe58,%eax
 69e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a1:	eb 24                	jmp    6c7 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	8b 00                	mov    (%eax),%eax
 6a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ab:	77 12                	ja     6bf <free+0x35>
 6ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b3:	77 24                	ja     6d9 <free+0x4f>
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6bd:	77 1a                	ja     6d9 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c2:	8b 00                	mov    (%eax),%eax
 6c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6cd:	76 d4                	jbe    6a3 <free+0x19>
 6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d2:	8b 00                	mov    (%eax),%eax
 6d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d7:	76 ca                	jbe    6a3 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dc:	8b 40 04             	mov    0x4(%eax),%eax
 6df:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e9:	01 c2                	add    %eax,%edx
 6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ee:	8b 00                	mov    (%eax),%eax
 6f0:	39 c2                	cmp    %eax,%edx
 6f2:	75 24                	jne    718 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f7:	8b 50 04             	mov    0x4(%eax),%edx
 6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fd:	8b 00                	mov    (%eax),%eax
 6ff:	8b 40 04             	mov    0x4(%eax),%eax
 702:	01 c2                	add    %eax,%edx
 704:	8b 45 f8             	mov    -0x8(%ebp),%eax
 707:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70d:	8b 00                	mov    (%eax),%eax
 70f:	8b 10                	mov    (%eax),%edx
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	89 10                	mov    %edx,(%eax)
 716:	eb 0a                	jmp    722 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 718:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71b:	8b 10                	mov    (%eax),%edx
 71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 720:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 722:	8b 45 fc             	mov    -0x4(%ebp),%eax
 725:	8b 40 04             	mov    0x4(%eax),%eax
 728:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	01 d0                	add    %edx,%eax
 734:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 737:	75 20                	jne    759 <free+0xcf>
    p->s.size += bp->s.size;
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 50 04             	mov    0x4(%eax),%edx
 73f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 742:	8b 40 04             	mov    0x4(%eax),%eax
 745:	01 c2                	add    %eax,%edx
 747:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 74d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 750:	8b 10                	mov    (%eax),%edx
 752:	8b 45 fc             	mov    -0x4(%ebp),%eax
 755:	89 10                	mov    %edx,(%eax)
 757:	eb 08                	jmp    761 <free+0xd7>
  } else
    p->s.ptr = bp;
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 75f:	89 10                	mov    %edx,(%eax)
  freep = p;
 761:	8b 45 fc             	mov    -0x4(%ebp),%eax
 764:	a3 58 0e 00 00       	mov    %eax,0xe58
}
 769:	c9                   	leave  
 76a:	c3                   	ret    

0000076b <morecore>:

static Header*
morecore(uint nu)
{
 76b:	55                   	push   %ebp
 76c:	89 e5                	mov    %esp,%ebp
 76e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 771:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 778:	77 07                	ja     781 <morecore+0x16>
    nu = 4096;
 77a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 781:	8b 45 08             	mov    0x8(%ebp),%eax
 784:	c1 e0 03             	shl    $0x3,%eax
 787:	89 04 24             	mov    %eax,(%esp)
 78a:	e8 f0 fb ff ff       	call   37f <sbrk>
 78f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 792:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 796:	75 07                	jne    79f <morecore+0x34>
    return 0;
 798:	b8 00 00 00 00       	mov    $0x0,%eax
 79d:	eb 22                	jmp    7c1 <morecore+0x56>
  hp = (Header*)p;
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	8b 55 08             	mov    0x8(%ebp),%edx
 7ab:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b1:	83 c0 08             	add    $0x8,%eax
 7b4:	89 04 24             	mov    %eax,(%esp)
 7b7:	e8 ce fe ff ff       	call   68a <free>
  return freep;
 7bc:	a1 58 0e 00 00       	mov    0xe58,%eax
}
 7c1:	c9                   	leave  
 7c2:	c3                   	ret    

000007c3 <malloc>:

void*
malloc(uint nbytes)
{
 7c3:	55                   	push   %ebp
 7c4:	89 e5                	mov    %esp,%ebp
 7c6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
 7cc:	83 c0 07             	add    $0x7,%eax
 7cf:	c1 e8 03             	shr    $0x3,%eax
 7d2:	83 c0 01             	add    $0x1,%eax
 7d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d8:	a1 58 0e 00 00       	mov    0xe58,%eax
 7dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e4:	75 23                	jne    809 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7e6:	c7 45 f0 50 0e 00 00 	movl   $0xe50,-0x10(%ebp)
 7ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f0:	a3 58 0e 00 00       	mov    %eax,0xe58
 7f5:	a1 58 0e 00 00       	mov    0xe58,%eax
 7fa:	a3 50 0e 00 00       	mov    %eax,0xe50
    base.s.size = 0;
 7ff:	c7 05 54 0e 00 00 00 	movl   $0x0,0xe54
 806:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80c:	8b 00                	mov    (%eax),%eax
 80e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	8b 40 04             	mov    0x4(%eax),%eax
 817:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81a:	72 4d                	jb     869 <malloc+0xa6>
      if(p->s.size == nunits)
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	8b 40 04             	mov    0x4(%eax),%eax
 822:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 825:	75 0c                	jne    833 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	8b 10                	mov    (%eax),%edx
 82c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82f:	89 10                	mov    %edx,(%eax)
 831:	eb 26                	jmp    859 <malloc+0x96>
      else {
        p->s.size -= nunits;
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 40 04             	mov    0x4(%eax),%eax
 839:	2b 45 ec             	sub    -0x14(%ebp),%eax
 83c:	89 c2                	mov    %eax,%edx
 83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 841:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	8b 40 04             	mov    0x4(%eax),%eax
 84a:	c1 e0 03             	shl    $0x3,%eax
 84d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 55 ec             	mov    -0x14(%ebp),%edx
 856:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 859:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85c:	a3 58 0e 00 00       	mov    %eax,0xe58
      return (void*)(p + 1);
 861:	8b 45 f4             	mov    -0xc(%ebp),%eax
 864:	83 c0 08             	add    $0x8,%eax
 867:	eb 38                	jmp    8a1 <malloc+0xde>
    }
    if(p == freep)
 869:	a1 58 0e 00 00       	mov    0xe58,%eax
 86e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 871:	75 1b                	jne    88e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 873:	8b 45 ec             	mov    -0x14(%ebp),%eax
 876:	89 04 24             	mov    %eax,(%esp)
 879:	e8 ed fe ff ff       	call   76b <morecore>
 87e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 881:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 885:	75 07                	jne    88e <malloc+0xcb>
        return 0;
 887:	b8 00 00 00 00       	mov    $0x0,%eax
 88c:	eb 13                	jmp    8a1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 891:	89 45 f0             	mov    %eax,-0x10(%ebp)
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	8b 00                	mov    (%eax),%eax
 899:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 89c:	e9 70 ff ff ff       	jmp    811 <malloc+0x4e>
}
 8a1:	c9                   	leave  
 8a2:	c3                   	ret    

000008a3 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 8a3:	55                   	push   %ebp
 8a4:	89 e5                	mov    %esp,%ebp
 8a6:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 8a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 8ac:	89 04 24             	mov    %eax,(%esp)
 8af:	8b 45 08             	mov    0x8(%ebp),%eax
 8b2:	ff d0                	call   *%eax
    exit();
 8b4:	e8 3e fa ff ff       	call   2f7 <exit>

000008b9 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 8b9:	55                   	push   %ebp
 8ba:	89 e5                	mov    %esp,%ebp
 8bc:	57                   	push   %edi
 8bd:	56                   	push   %esi
 8be:	53                   	push   %ebx
 8bf:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 8c2:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8c9:	e8 f5 fe ff ff       	call   7c3 <malloc>
 8ce:	8b 55 08             	mov    0x8(%ebp),%edx
 8d1:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8d3:	8b 45 10             	mov    0x10(%ebp),%eax
 8d6:	8b 38                	mov    (%eax),%edi
 8d8:	8b 75 0c             	mov    0xc(%ebp),%esi
 8db:	bb a3 08 00 00       	mov    $0x8a3,%ebx
 8e0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8e7:	e8 d7 fe ff ff       	call   7c3 <malloc>
 8ec:	05 00 10 00 00       	add    $0x1000,%eax
 8f1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8f5:	89 74 24 08          	mov    %esi,0x8(%esp)
 8f9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8fd:	89 04 24             	mov    %eax,(%esp)
 900:	e8 92 fa ff ff       	call   397 <kthread_create>
 905:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 908:	8b 45 08             	mov    0x8(%ebp),%eax
 90b:	8b 00                	mov    (%eax),%eax
 90d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 910:	89 10                	mov    %edx,(%eax)
    return t_id;
 912:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 915:	83 c4 2c             	add    $0x2c,%esp
 918:	5b                   	pop    %ebx
 919:	5e                   	pop    %esi
 91a:	5f                   	pop    %edi
 91b:	5d                   	pop    %ebp
 91c:	c3                   	ret    

0000091d <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 91d:	55                   	push   %ebp
 91e:	89 e5                	mov    %esp,%ebp
 920:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 923:	8b 55 0c             	mov    0xc(%ebp),%edx
 926:	8b 45 08             	mov    0x8(%ebp),%eax
 929:	8b 00                	mov    (%eax),%eax
 92b:	89 54 24 04          	mov    %edx,0x4(%esp)
 92f:	89 04 24             	mov    %eax,(%esp)
 932:	e8 68 fa ff ff       	call   39f <kthread_join>
 937:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 93a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 93d:	c9                   	leave  
 93e:	c3                   	ret    

0000093f <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 93f:	55                   	push   %ebp
 940:	89 e5                	mov    %esp,%ebp
 942:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 945:	e8 5d fa ff ff       	call   3a7 <kthread_mutex_init>
 94a:	8b 55 08             	mov    0x8(%ebp),%edx
 94d:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 94f:	8b 45 08             	mov    0x8(%ebp),%eax
 952:	8b 00                	mov    (%eax),%eax
 954:	85 c0                	test   %eax,%eax
 956:	7e 07                	jle    95f <qthread_mutex_init+0x20>
		return 0;
 958:	b8 00 00 00 00       	mov    $0x0,%eax
 95d:	eb 05                	jmp    964 <qthread_mutex_init+0x25>
	}
	return *mutex;
 95f:	8b 45 08             	mov    0x8(%ebp),%eax
 962:	8b 00                	mov    (%eax),%eax
}
 964:	c9                   	leave  
 965:	c3                   	ret    

00000966 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 966:	55                   	push   %ebp
 967:	89 e5                	mov    %esp,%ebp
 969:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 96c:	8b 45 08             	mov    0x8(%ebp),%eax
 96f:	89 04 24             	mov    %eax,(%esp)
 972:	e8 38 fa ff ff       	call   3af <kthread_mutex_destroy>
 977:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 97a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 97e:	79 07                	jns    987 <qthread_mutex_destroy+0x21>
    	return -1;
 980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 985:	eb 05                	jmp    98c <qthread_mutex_destroy+0x26>
    }
    return 0;
 987:	b8 00 00 00 00       	mov    $0x0,%eax
}
 98c:	c9                   	leave  
 98d:	c3                   	ret    

0000098e <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 98e:	55                   	push   %ebp
 98f:	89 e5                	mov    %esp,%ebp
 991:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 994:	8b 45 08             	mov    0x8(%ebp),%eax
 997:	89 04 24             	mov    %eax,(%esp)
 99a:	e8 18 fa ff ff       	call   3b7 <kthread_mutex_lock>
 99f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a6:	79 07                	jns    9af <qthread_mutex_lock+0x21>
    	return -1;
 9a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9ad:	eb 05                	jmp    9b4 <qthread_mutex_lock+0x26>
    }
    return 0;
 9af:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b4:	c9                   	leave  
 9b5:	c3                   	ret    

000009b6 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 9b6:	55                   	push   %ebp
 9b7:	89 e5                	mov    %esp,%ebp
 9b9:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 9bc:	8b 45 08             	mov    0x8(%ebp),%eax
 9bf:	89 04 24             	mov    %eax,(%esp)
 9c2:	e8 f8 f9 ff ff       	call   3bf <kthread_mutex_unlock>
 9c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9ce:	79 07                	jns    9d7 <qthread_mutex_unlock+0x21>
    	return -1;
 9d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9d5:	eb 05                	jmp    9dc <qthread_mutex_unlock+0x26>
    }
    return 0;
 9d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9dc:	c9                   	leave  
 9dd:	c3                   	ret    

000009de <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9de:	55                   	push   %ebp
 9df:	89 e5                	mov    %esp,%ebp

	return 0;
 9e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9e6:	5d                   	pop    %ebp
 9e7:	c3                   	ret    

000009e8 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9e8:	55                   	push   %ebp
 9e9:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f0:	5d                   	pop    %ebp
 9f1:	c3                   	ret    

000009f2 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9f2:	55                   	push   %ebp
 9f3:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9fa:	5d                   	pop    %ebp
 9fb:	c3                   	ret    

000009fc <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9fc:	55                   	push   %ebp
 9fd:	89 e5                	mov    %esp,%ebp
	return 0;
 9ff:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a04:	5d                   	pop    %ebp
 a05:	c3                   	ret    

00000a06 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 a06:	55                   	push   %ebp
 a07:	89 e5                	mov    %esp,%ebp
	return 0;
 a09:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a0e:	5d                   	pop    %ebp
 a0f:	c3                   	ret    

00000a10 <qthread_exit>:

int qthread_exit(){
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
	return 0;
 a13:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a18:	5d                   	pop    %ebp
 a19:	c3                   	ret    
