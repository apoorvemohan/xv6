
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 75 02 00 00       	call   283 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 fd 02 00 00       	call   31b <sleep>
  exit();
  1e:	e8 68 02 00 00       	call   28b <exit>

00000023 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  23:	55                   	push   %ebp
  24:	89 e5                	mov    %esp,%ebp
  26:	57                   	push   %edi
  27:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  28:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2b:	8b 55 10             	mov    0x10(%ebp),%edx
  2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  31:	89 cb                	mov    %ecx,%ebx
  33:	89 df                	mov    %ebx,%edi
  35:	89 d1                	mov    %edx,%ecx
  37:	fc                   	cld    
  38:	f3 aa                	rep stos %al,%es:(%edi)
  3a:	89 ca                	mov    %ecx,%edx
  3c:	89 fb                	mov    %edi,%ebx
  3e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  41:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  44:	5b                   	pop    %ebx
  45:	5f                   	pop    %edi
  46:	5d                   	pop    %ebp
  47:	c3                   	ret    

00000048 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4e:	8b 45 08             	mov    0x8(%ebp),%eax
  51:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  54:	90                   	nop
  55:	8b 45 08             	mov    0x8(%ebp),%eax
  58:	8d 50 01             	lea    0x1(%eax),%edx
  5b:	89 55 08             	mov    %edx,0x8(%ebp)
  5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  61:	8d 4a 01             	lea    0x1(%edx),%ecx
  64:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  67:	0f b6 12             	movzbl (%edx),%edx
  6a:	88 10                	mov    %dl,(%eax)
  6c:	0f b6 00             	movzbl (%eax),%eax
  6f:	84 c0                	test   %al,%al
  71:	75 e2                	jne    55 <strcpy+0xd>
    ;
  return os;
  73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  76:	c9                   	leave  
  77:	c3                   	ret    

00000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  7b:	eb 08                	jmp    85 <strcmp+0xd>
    p++, q++;
  7d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  81:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  85:	8b 45 08             	mov    0x8(%ebp),%eax
  88:	0f b6 00             	movzbl (%eax),%eax
  8b:	84 c0                	test   %al,%al
  8d:	74 10                	je     9f <strcmp+0x27>
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	0f b6 10             	movzbl (%eax),%edx
  95:	8b 45 0c             	mov    0xc(%ebp),%eax
  98:	0f b6 00             	movzbl (%eax),%eax
  9b:	38 c2                	cmp    %al,%dl
  9d:	74 de                	je     7d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  9f:	8b 45 08             	mov    0x8(%ebp),%eax
  a2:	0f b6 00             	movzbl (%eax),%eax
  a5:	0f b6 d0             	movzbl %al,%edx
  a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  ab:	0f b6 00             	movzbl (%eax),%eax
  ae:	0f b6 c0             	movzbl %al,%eax
  b1:	29 c2                	sub    %eax,%edx
  b3:	89 d0                	mov    %edx,%eax
}
  b5:	5d                   	pop    %ebp
  b6:	c3                   	ret    

000000b7 <strlen>:

uint
strlen(char *s)
{
  b7:	55                   	push   %ebp
  b8:	89 e5                	mov    %esp,%ebp
  ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c4:	eb 04                	jmp    ca <strlen+0x13>
  c6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  cd:	8b 45 08             	mov    0x8(%ebp),%eax
  d0:	01 d0                	add    %edx,%eax
  d2:	0f b6 00             	movzbl (%eax),%eax
  d5:	84 c0                	test   %al,%al
  d7:	75 ed                	jne    c6 <strlen+0xf>
    ;
  return n;
  d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  dc:	c9                   	leave  
  dd:	c3                   	ret    

000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	55                   	push   %ebp
  df:	89 e5                	mov    %esp,%ebp
  e1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  e4:	8b 45 10             	mov    0x10(%ebp),%eax
  e7:	89 44 24 08          	mov    %eax,0x8(%esp)
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
  f5:	89 04 24             	mov    %eax,(%esp)
  f8:	e8 26 ff ff ff       	call   23 <stosb>
  return dst;
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 100:	c9                   	leave  
 101:	c3                   	ret    

00000102 <strchr>:

char*
strchr(const char *s, char c)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 04             	sub    $0x4,%esp
 108:	8b 45 0c             	mov    0xc(%ebp),%eax
 10b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10e:	eb 14                	jmp    124 <strchr+0x22>
    if(*s == c)
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	0f b6 00             	movzbl (%eax),%eax
 116:	3a 45 fc             	cmp    -0x4(%ebp),%al
 119:	75 05                	jne    120 <strchr+0x1e>
      return (char*)s;
 11b:	8b 45 08             	mov    0x8(%ebp),%eax
 11e:	eb 13                	jmp    133 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 120:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	0f b6 00             	movzbl (%eax),%eax
 12a:	84 c0                	test   %al,%al
 12c:	75 e2                	jne    110 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 12e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 133:	c9                   	leave  
 134:	c3                   	ret    

00000135 <gets>:

char*
gets(char *buf, int max)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 142:	eb 4c                	jmp    190 <gets+0x5b>
    cc = read(0, &c, 1);
 144:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 14b:	00 
 14c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14f:	89 44 24 04          	mov    %eax,0x4(%esp)
 153:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15a:	e8 44 01 00 00       	call   2a3 <read>
 15f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 162:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 166:	7f 02                	jg     16a <gets+0x35>
      break;
 168:	eb 31                	jmp    19b <gets+0x66>
    buf[i++] = c;
 16a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16d:	8d 50 01             	lea    0x1(%eax),%edx
 170:	89 55 f4             	mov    %edx,-0xc(%ebp)
 173:	89 c2                	mov    %eax,%edx
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	01 c2                	add    %eax,%edx
 17a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 180:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 184:	3c 0a                	cmp    $0xa,%al
 186:	74 13                	je     19b <gets+0x66>
 188:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18c:	3c 0d                	cmp    $0xd,%al
 18e:	74 0b                	je     19b <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	8b 45 f4             	mov    -0xc(%ebp),%eax
 193:	83 c0 01             	add    $0x1,%eax
 196:	3b 45 0c             	cmp    0xc(%ebp),%eax
 199:	7c a9                	jl     144 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 19e:	8b 45 08             	mov    0x8(%ebp),%eax
 1a1:	01 d0                	add    %edx,%eax
 1a3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a9:	c9                   	leave  
 1aa:	c3                   	ret    

000001ab <stat>:

int
stat(char *n, struct stat *st)
{
 1ab:	55                   	push   %ebp
 1ac:	89 e5                	mov    %esp,%ebp
 1ae:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b8:	00 
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	89 04 24             	mov    %eax,(%esp)
 1bf:	e8 07 01 00 00       	call   2cb <open>
 1c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1cb:	79 07                	jns    1d4 <stat+0x29>
    return -1;
 1cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d2:	eb 23                	jmp    1f7 <stat+0x4c>
  r = fstat(fd, st);
 1d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	89 04 24             	mov    %eax,(%esp)
 1e1:	e8 fd 00 00 00       	call   2e3 <fstat>
 1e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ec:	89 04 24             	mov    %eax,(%esp)
 1ef:	e8 bf 00 00 00       	call   2b3 <close>
  return r;
 1f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    

000001f9 <atoi>:

int
atoi(const char *s)
{
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 206:	eb 25                	jmp    22d <atoi+0x34>
    n = n*10 + *s++ - '0';
 208:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20b:	89 d0                	mov    %edx,%eax
 20d:	c1 e0 02             	shl    $0x2,%eax
 210:	01 d0                	add    %edx,%eax
 212:	01 c0                	add    %eax,%eax
 214:	89 c1                	mov    %eax,%ecx
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	8d 50 01             	lea    0x1(%eax),%edx
 21c:	89 55 08             	mov    %edx,0x8(%ebp)
 21f:	0f b6 00             	movzbl (%eax),%eax
 222:	0f be c0             	movsbl %al,%eax
 225:	01 c8                	add    %ecx,%eax
 227:	83 e8 30             	sub    $0x30,%eax
 22a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	3c 2f                	cmp    $0x2f,%al
 235:	7e 0a                	jle    241 <atoi+0x48>
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	0f b6 00             	movzbl (%eax),%eax
 23d:	3c 39                	cmp    $0x39,%al
 23f:	7e c7                	jle    208 <atoi+0xf>
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
 258:	eb 17                	jmp    271 <memmove+0x2b>
    *dst++ = *src++;
 25a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25d:	8d 50 01             	lea    0x1(%eax),%edx
 260:	89 55 fc             	mov    %edx,-0x4(%ebp)
 263:	8b 55 f8             	mov    -0x8(%ebp),%edx
 266:	8d 4a 01             	lea    0x1(%edx),%ecx
 269:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 26c:	0f b6 12             	movzbl (%edx),%edx
 26f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 271:	8b 45 10             	mov    0x10(%ebp),%eax
 274:	8d 50 ff             	lea    -0x1(%eax),%edx
 277:	89 55 10             	mov    %edx,0x10(%ebp)
 27a:	85 c0                	test   %eax,%eax
 27c:	7f dc                	jg     25a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 283:	b8 01 00 00 00       	mov    $0x1,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <exit>:
SYSCALL(exit)
 28b:	b8 02 00 00 00       	mov    $0x2,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <wait>:
SYSCALL(wait)
 293:	b8 03 00 00 00       	mov    $0x3,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <pipe>:
SYSCALL(pipe)
 29b:	b8 04 00 00 00       	mov    $0x4,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <read>:
SYSCALL(read)
 2a3:	b8 05 00 00 00       	mov    $0x5,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <write>:
SYSCALL(write)
 2ab:	b8 10 00 00 00       	mov    $0x10,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <close>:
SYSCALL(close)
 2b3:	b8 15 00 00 00       	mov    $0x15,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <kill>:
SYSCALL(kill)
 2bb:	b8 06 00 00 00       	mov    $0x6,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <exec>:
SYSCALL(exec)
 2c3:	b8 07 00 00 00       	mov    $0x7,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <open>:
SYSCALL(open)
 2cb:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <mknod>:
SYSCALL(mknod)
 2d3:	b8 11 00 00 00       	mov    $0x11,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <unlink>:
SYSCALL(unlink)
 2db:	b8 12 00 00 00       	mov    $0x12,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <fstat>:
SYSCALL(fstat)
 2e3:	b8 08 00 00 00       	mov    $0x8,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <link>:
SYSCALL(link)
 2eb:	b8 13 00 00 00       	mov    $0x13,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <mkdir>:
SYSCALL(mkdir)
 2f3:	b8 14 00 00 00       	mov    $0x14,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <chdir>:
SYSCALL(chdir)
 2fb:	b8 09 00 00 00       	mov    $0x9,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <dup>:
SYSCALL(dup)
 303:	b8 0a 00 00 00       	mov    $0xa,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <getpid>:
SYSCALL(getpid)
 30b:	b8 0b 00 00 00       	mov    $0xb,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <sbrk>:
SYSCALL(sbrk)
 313:	b8 0c 00 00 00       	mov    $0xc,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <sleep>:
SYSCALL(sleep)
 31b:	b8 0d 00 00 00       	mov    $0xd,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <uptime>:
SYSCALL(uptime)
 323:	b8 0e 00 00 00       	mov    $0xe,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <kthread_create>:
SYSCALL(kthread_create)
 32b:	b8 17 00 00 00       	mov    $0x17,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <kthread_join>:
SYSCALL(kthread_join)
 333:	b8 16 00 00 00       	mov    $0x16,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 33b:	b8 18 00 00 00       	mov    $0x18,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 343:	b8 19 00 00 00       	mov    $0x19,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 34b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 353:	b8 1b 00 00 00       	mov    $0x1b,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 35b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 363:	b8 1d 00 00 00       	mov    $0x1d,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 36b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 373:	b8 1f 00 00 00       	mov    $0x1f,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 37b:	b8 20 00 00 00       	mov    $0x20,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <kthread_exit>:
 383:	b8 21 00 00 00       	mov    $0x21,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 38b:	55                   	push   %ebp
 38c:	89 e5                	mov    %esp,%ebp
 38e:	83 ec 18             	sub    $0x18,%esp
 391:	8b 45 0c             	mov    0xc(%ebp),%eax
 394:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 397:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 39e:	00 
 39f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
 3a9:	89 04 24             	mov    %eax,(%esp)
 3ac:	e8 fa fe ff ff       	call   2ab <write>
}
 3b1:	c9                   	leave  
 3b2:	c3                   	ret    

000003b3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b3:	55                   	push   %ebp
 3b4:	89 e5                	mov    %esp,%ebp
 3b6:	56                   	push   %esi
 3b7:	53                   	push   %ebx
 3b8:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3c2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c6:	74 17                	je     3df <printint+0x2c>
 3c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3cc:	79 11                	jns    3df <printint+0x2c>
    neg = 1;
 3ce:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d8:	f7 d8                	neg    %eax
 3da:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3dd:	eb 06                	jmp    3e5 <printint+0x32>
  } else {
    x = xx;
 3df:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ec:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ef:	8d 41 01             	lea    0x1(%ecx),%eax
 3f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fb:	ba 00 00 00 00       	mov    $0x0,%edx
 400:	f7 f3                	div    %ebx
 402:	89 d0                	mov    %edx,%eax
 404:	0f b6 80 a4 0d 00 00 	movzbl 0xda4(%eax),%eax
 40b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 40f:	8b 75 10             	mov    0x10(%ebp),%esi
 412:	8b 45 ec             	mov    -0x14(%ebp),%eax
 415:	ba 00 00 00 00       	mov    $0x0,%edx
 41a:	f7 f6                	div    %esi
 41c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 423:	75 c7                	jne    3ec <printint+0x39>
  if(neg)
 425:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 429:	74 10                	je     43b <printint+0x88>
    buf[i++] = '-';
 42b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42e:	8d 50 01             	lea    0x1(%eax),%edx
 431:	89 55 f4             	mov    %edx,-0xc(%ebp)
 434:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 439:	eb 1f                	jmp    45a <printint+0xa7>
 43b:	eb 1d                	jmp    45a <printint+0xa7>
    putc(fd, buf[i]);
 43d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 440:	8b 45 f4             	mov    -0xc(%ebp),%eax
 443:	01 d0                	add    %edx,%eax
 445:	0f b6 00             	movzbl (%eax),%eax
 448:	0f be c0             	movsbl %al,%eax
 44b:	89 44 24 04          	mov    %eax,0x4(%esp)
 44f:	8b 45 08             	mov    0x8(%ebp),%eax
 452:	89 04 24             	mov    %eax,(%esp)
 455:	e8 31 ff ff ff       	call   38b <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 45a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 45e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 462:	79 d9                	jns    43d <printint+0x8a>
    putc(fd, buf[i]);
}
 464:	83 c4 30             	add    $0x30,%esp
 467:	5b                   	pop    %ebx
 468:	5e                   	pop    %esi
 469:	5d                   	pop    %ebp
 46a:	c3                   	ret    

0000046b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 46b:	55                   	push   %ebp
 46c:	89 e5                	mov    %esp,%ebp
 46e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 471:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 478:	8d 45 0c             	lea    0xc(%ebp),%eax
 47b:	83 c0 04             	add    $0x4,%eax
 47e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 481:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 488:	e9 7c 01 00 00       	jmp    609 <printf+0x19e>
    c = fmt[i] & 0xff;
 48d:	8b 55 0c             	mov    0xc(%ebp),%edx
 490:	8b 45 f0             	mov    -0x10(%ebp),%eax
 493:	01 d0                	add    %edx,%eax
 495:	0f b6 00             	movzbl (%eax),%eax
 498:	0f be c0             	movsbl %al,%eax
 49b:	25 ff 00 00 00       	and    $0xff,%eax
 4a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a7:	75 2c                	jne    4d5 <printf+0x6a>
      if(c == '%'){
 4a9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ad:	75 0c                	jne    4bb <printf+0x50>
        state = '%';
 4af:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b6:	e9 4a 01 00 00       	jmp    605 <printf+0x19a>
      } else {
        putc(fd, c);
 4bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4be:	0f be c0             	movsbl %al,%eax
 4c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c5:	8b 45 08             	mov    0x8(%ebp),%eax
 4c8:	89 04 24             	mov    %eax,(%esp)
 4cb:	e8 bb fe ff ff       	call   38b <putc>
 4d0:	e9 30 01 00 00       	jmp    605 <printf+0x19a>
      }
    } else if(state == '%'){
 4d5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d9:	0f 85 26 01 00 00    	jne    605 <printf+0x19a>
      if(c == 'd'){
 4df:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e3:	75 2d                	jne    512 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e8:	8b 00                	mov    (%eax),%eax
 4ea:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4f1:	00 
 4f2:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4f9:	00 
 4fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	89 04 24             	mov    %eax,(%esp)
 504:	e8 aa fe ff ff       	call   3b3 <printint>
        ap++;
 509:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50d:	e9 ec 00 00 00       	jmp    5fe <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 512:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 516:	74 06                	je     51e <printf+0xb3>
 518:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 51c:	75 2d                	jne    54b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 51e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 521:	8b 00                	mov    (%eax),%eax
 523:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 52a:	00 
 52b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 532:	00 
 533:	89 44 24 04          	mov    %eax,0x4(%esp)
 537:	8b 45 08             	mov    0x8(%ebp),%eax
 53a:	89 04 24             	mov    %eax,(%esp)
 53d:	e8 71 fe ff ff       	call   3b3 <printint>
        ap++;
 542:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 546:	e9 b3 00 00 00       	jmp    5fe <printf+0x193>
      } else if(c == 's'){
 54b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 54f:	75 45                	jne    596 <printf+0x12b>
        s = (char*)*ap;
 551:	8b 45 e8             	mov    -0x18(%ebp),%eax
 554:	8b 00                	mov    (%eax),%eax
 556:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 559:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 55d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 561:	75 09                	jne    56c <printf+0x101>
          s = "(null)";
 563:	c7 45 f4 ae 09 00 00 	movl   $0x9ae,-0xc(%ebp)
        while(*s != 0){
 56a:	eb 1e                	jmp    58a <printf+0x11f>
 56c:	eb 1c                	jmp    58a <printf+0x11f>
          putc(fd, *s);
 56e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 571:	0f b6 00             	movzbl (%eax),%eax
 574:	0f be c0             	movsbl %al,%eax
 577:	89 44 24 04          	mov    %eax,0x4(%esp)
 57b:	8b 45 08             	mov    0x8(%ebp),%eax
 57e:	89 04 24             	mov    %eax,(%esp)
 581:	e8 05 fe ff ff       	call   38b <putc>
          s++;
 586:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 58a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58d:	0f b6 00             	movzbl (%eax),%eax
 590:	84 c0                	test   %al,%al
 592:	75 da                	jne    56e <printf+0x103>
 594:	eb 68                	jmp    5fe <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 596:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 59a:	75 1d                	jne    5b9 <printf+0x14e>
        putc(fd, *ap);
 59c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59f:	8b 00                	mov    (%eax),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
 5ab:	89 04 24             	mov    %eax,(%esp)
 5ae:	e8 d8 fd ff ff       	call   38b <putc>
        ap++;
 5b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b7:	eb 45                	jmp    5fe <printf+0x193>
      } else if(c == '%'){
 5b9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5bd:	75 17                	jne    5d6 <printf+0x16b>
        putc(fd, c);
 5bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c2:	0f be c0             	movsbl %al,%eax
 5c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c9:	8b 45 08             	mov    0x8(%ebp),%eax
 5cc:	89 04 24             	mov    %eax,(%esp)
 5cf:	e8 b7 fd ff ff       	call   38b <putc>
 5d4:	eb 28                	jmp    5fe <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5d6:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5dd:	00 
 5de:	8b 45 08             	mov    0x8(%ebp),%eax
 5e1:	89 04 24             	mov    %eax,(%esp)
 5e4:	e8 a2 fd ff ff       	call   38b <putc>
        putc(fd, c);
 5e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ec:	0f be c0             	movsbl %al,%eax
 5ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	89 04 24             	mov    %eax,(%esp)
 5f9:	e8 8d fd ff ff       	call   38b <putc>
      }
      state = 0;
 5fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 605:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 609:	8b 55 0c             	mov    0xc(%ebp),%edx
 60c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 60f:	01 d0                	add    %edx,%eax
 611:	0f b6 00             	movzbl (%eax),%eax
 614:	84 c0                	test   %al,%al
 616:	0f 85 71 fe ff ff    	jne    48d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 61c:	c9                   	leave  
 61d:	c3                   	ret    

0000061e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 61e:	55                   	push   %ebp
 61f:	89 e5                	mov    %esp,%ebp
 621:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 624:	8b 45 08             	mov    0x8(%ebp),%eax
 627:	83 e8 08             	sub    $0x8,%eax
 62a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62d:	a1 c0 0d 00 00       	mov    0xdc0,%eax
 632:	89 45 fc             	mov    %eax,-0x4(%ebp)
 635:	eb 24                	jmp    65b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 637:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63a:	8b 00                	mov    (%eax),%eax
 63c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63f:	77 12                	ja     653 <free+0x35>
 641:	8b 45 f8             	mov    -0x8(%ebp),%eax
 644:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 647:	77 24                	ja     66d <free+0x4f>
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 651:	77 1a                	ja     66d <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 00                	mov    (%eax),%eax
 658:	89 45 fc             	mov    %eax,-0x4(%ebp)
 65b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 661:	76 d4                	jbe    637 <free+0x19>
 663:	8b 45 fc             	mov    -0x4(%ebp),%eax
 666:	8b 00                	mov    (%eax),%eax
 668:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66b:	76 ca                	jbe    637 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 66d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 670:	8b 40 04             	mov    0x4(%eax),%eax
 673:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 67a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67d:	01 c2                	add    %eax,%edx
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	39 c2                	cmp    %eax,%edx
 686:	75 24                	jne    6ac <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 688:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68b:	8b 50 04             	mov    0x4(%eax),%edx
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	8b 00                	mov    (%eax),%eax
 693:	8b 40 04             	mov    0x4(%eax),%eax
 696:	01 c2                	add    %eax,%edx
 698:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a1:	8b 00                	mov    (%eax),%eax
 6a3:	8b 10                	mov    (%eax),%edx
 6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a8:	89 10                	mov    %edx,(%eax)
 6aa:	eb 0a                	jmp    6b6 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6af:	8b 10                	mov    (%eax),%edx
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b9:	8b 40 04             	mov    0x4(%eax),%eax
 6bc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	01 d0                	add    %edx,%eax
 6c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cb:	75 20                	jne    6ed <free+0xcf>
    p->s.size += bp->s.size;
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 50 04             	mov    0x4(%eax),%edx
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	8b 40 04             	mov    0x4(%eax),%eax
 6d9:	01 c2                	add    %eax,%edx
 6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6de:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	8b 10                	mov    (%eax),%edx
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	89 10                	mov    %edx,(%eax)
 6eb:	eb 08                	jmp    6f5 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6f3:	89 10                	mov    %edx,(%eax)
  freep = p;
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	a3 c0 0d 00 00       	mov    %eax,0xdc0
}
 6fd:	c9                   	leave  
 6fe:	c3                   	ret    

000006ff <morecore>:

static Header*
morecore(uint nu)
{
 6ff:	55                   	push   %ebp
 700:	89 e5                	mov    %esp,%ebp
 702:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 705:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 70c:	77 07                	ja     715 <morecore+0x16>
    nu = 4096;
 70e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 715:	8b 45 08             	mov    0x8(%ebp),%eax
 718:	c1 e0 03             	shl    $0x3,%eax
 71b:	89 04 24             	mov    %eax,(%esp)
 71e:	e8 f0 fb ff ff       	call   313 <sbrk>
 723:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 726:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 72a:	75 07                	jne    733 <morecore+0x34>
    return 0;
 72c:	b8 00 00 00 00       	mov    $0x0,%eax
 731:	eb 22                	jmp    755 <morecore+0x56>
  hp = (Header*)p;
 733:	8b 45 f4             	mov    -0xc(%ebp),%eax
 736:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 739:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73c:	8b 55 08             	mov    0x8(%ebp),%edx
 73f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 742:	8b 45 f0             	mov    -0x10(%ebp),%eax
 745:	83 c0 08             	add    $0x8,%eax
 748:	89 04 24             	mov    %eax,(%esp)
 74b:	e8 ce fe ff ff       	call   61e <free>
  return freep;
 750:	a1 c0 0d 00 00       	mov    0xdc0,%eax
}
 755:	c9                   	leave  
 756:	c3                   	ret    

00000757 <malloc>:

void*
malloc(uint nbytes)
{
 757:	55                   	push   %ebp
 758:	89 e5                	mov    %esp,%ebp
 75a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75d:	8b 45 08             	mov    0x8(%ebp),%eax
 760:	83 c0 07             	add    $0x7,%eax
 763:	c1 e8 03             	shr    $0x3,%eax
 766:	83 c0 01             	add    $0x1,%eax
 769:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 76c:	a1 c0 0d 00 00       	mov    0xdc0,%eax
 771:	89 45 f0             	mov    %eax,-0x10(%ebp)
 774:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 778:	75 23                	jne    79d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 77a:	c7 45 f0 b8 0d 00 00 	movl   $0xdb8,-0x10(%ebp)
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	a3 c0 0d 00 00       	mov    %eax,0xdc0
 789:	a1 c0 0d 00 00       	mov    0xdc0,%eax
 78e:	a3 b8 0d 00 00       	mov    %eax,0xdb8
    base.s.size = 0;
 793:	c7 05 bc 0d 00 00 00 	movl   $0x0,0xdbc
 79a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	8b 00                	mov    (%eax),%eax
 7a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	8b 40 04             	mov    0x4(%eax),%eax
 7ab:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ae:	72 4d                	jb     7fd <malloc+0xa6>
      if(p->s.size == nunits)
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b9:	75 0c                	jne    7c7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	8b 10                	mov    (%eax),%edx
 7c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c3:	89 10                	mov    %edx,(%eax)
 7c5:	eb 26                	jmp    7ed <malloc+0x96>
      else {
        p->s.size -= nunits;
 7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ca:	8b 40 04             	mov    0x4(%eax),%eax
 7cd:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7d0:	89 c2                	mov    %eax,%edx
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7db:	8b 40 04             	mov    0x4(%eax),%eax
 7de:	c1 e0 03             	shl    $0x3,%eax
 7e1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ea:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f0:	a3 c0 0d 00 00       	mov    %eax,0xdc0
      return (void*)(p + 1);
 7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f8:	83 c0 08             	add    $0x8,%eax
 7fb:	eb 38                	jmp    835 <malloc+0xde>
    }
    if(p == freep)
 7fd:	a1 c0 0d 00 00       	mov    0xdc0,%eax
 802:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 805:	75 1b                	jne    822 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 807:	8b 45 ec             	mov    -0x14(%ebp),%eax
 80a:	89 04 24             	mov    %eax,(%esp)
 80d:	e8 ed fe ff ff       	call   6ff <morecore>
 812:	89 45 f4             	mov    %eax,-0xc(%ebp)
 815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 819:	75 07                	jne    822 <malloc+0xcb>
        return 0;
 81b:	b8 00 00 00 00       	mov    $0x0,%eax
 820:	eb 13                	jmp    835 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 822:	8b 45 f4             	mov    -0xc(%ebp),%eax
 825:	89 45 f0             	mov    %eax,-0x10(%ebp)
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 00                	mov    (%eax),%eax
 82d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 830:	e9 70 ff ff ff       	jmp    7a5 <malloc+0x4e>
}
 835:	c9                   	leave  
 836:	c3                   	ret    

00000837 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 837:	55                   	push   %ebp
 838:	89 e5                	mov    %esp,%ebp
 83a:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 83d:	8b 45 0c             	mov    0xc(%ebp),%eax
 840:	89 04 24             	mov    %eax,(%esp)
 843:	8b 45 08             	mov    0x8(%ebp),%eax
 846:	ff d0                	call   *%eax
    exit();
 848:	e8 3e fa ff ff       	call   28b <exit>

0000084d <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 84d:	55                   	push   %ebp
 84e:	89 e5                	mov    %esp,%ebp
 850:	57                   	push   %edi
 851:	56                   	push   %esi
 852:	53                   	push   %ebx
 853:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 856:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 85d:	e8 f5 fe ff ff       	call   757 <malloc>
 862:	8b 55 08             	mov    0x8(%ebp),%edx
 865:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 867:	8b 45 10             	mov    0x10(%ebp),%eax
 86a:	8b 38                	mov    (%eax),%edi
 86c:	8b 75 0c             	mov    0xc(%ebp),%esi
 86f:	bb 37 08 00 00       	mov    $0x837,%ebx
 874:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 87b:	e8 d7 fe ff ff       	call   757 <malloc>
 880:	05 00 10 00 00       	add    $0x1000,%eax
 885:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 889:	89 74 24 08          	mov    %esi,0x8(%esp)
 88d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 891:	89 04 24             	mov    %eax,(%esp)
 894:	e8 92 fa ff ff       	call   32b <kthread_create>
 899:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 89c:	8b 45 08             	mov    0x8(%ebp),%eax
 89f:	8b 00                	mov    (%eax),%eax
 8a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8a4:	89 10                	mov    %edx,(%eax)
    return t_id;
 8a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8a9:	83 c4 2c             	add    $0x2c,%esp
 8ac:	5b                   	pop    %ebx
 8ad:	5e                   	pop    %esi
 8ae:	5f                   	pop    %edi
 8af:	5d                   	pop    %ebp
 8b0:	c3                   	ret    

000008b1 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8b1:	55                   	push   %ebp
 8b2:	89 e5                	mov    %esp,%ebp
 8b4:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 8b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 8ba:	8b 45 08             	mov    0x8(%ebp),%eax
 8bd:	8b 00                	mov    (%eax),%eax
 8bf:	89 54 24 04          	mov    %edx,0x4(%esp)
 8c3:	89 04 24             	mov    %eax,(%esp)
 8c6:	e8 68 fa ff ff       	call   333 <kthread_join>
 8cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 8ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 8d1:	c9                   	leave  
 8d2:	c3                   	ret    

000008d3 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 8d3:	55                   	push   %ebp
 8d4:	89 e5                	mov    %esp,%ebp
 8d6:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 8d9:	e8 5d fa ff ff       	call   33b <kthread_mutex_init>
 8de:	8b 55 08             	mov    0x8(%ebp),%edx
 8e1:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 8e3:	8b 45 08             	mov    0x8(%ebp),%eax
 8e6:	8b 00                	mov    (%eax),%eax
 8e8:	85 c0                	test   %eax,%eax
 8ea:	7e 07                	jle    8f3 <qthread_mutex_init+0x20>
		return 0;
 8ec:	b8 00 00 00 00       	mov    $0x0,%eax
 8f1:	eb 05                	jmp    8f8 <qthread_mutex_init+0x25>
	}
	return *mutex;
 8f3:	8b 45 08             	mov    0x8(%ebp),%eax
 8f6:	8b 00                	mov    (%eax),%eax
}
 8f8:	c9                   	leave  
 8f9:	c3                   	ret    

000008fa <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 8fa:	55                   	push   %ebp
 8fb:	89 e5                	mov    %esp,%ebp
 8fd:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 900:	8b 45 08             	mov    0x8(%ebp),%eax
 903:	89 04 24             	mov    %eax,(%esp)
 906:	e8 38 fa ff ff       	call   343 <kthread_mutex_destroy>
 90b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 90e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 912:	79 07                	jns    91b <qthread_mutex_destroy+0x21>
    	return -1;
 914:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 919:	eb 05                	jmp    920 <qthread_mutex_destroy+0x26>
    }
    return 0;
 91b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 920:	c9                   	leave  
 921:	c3                   	ret    

00000922 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 922:	55                   	push   %ebp
 923:	89 e5                	mov    %esp,%ebp
 925:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 928:	8b 45 08             	mov    0x8(%ebp),%eax
 92b:	89 04 24             	mov    %eax,(%esp)
 92e:	e8 18 fa ff ff       	call   34b <kthread_mutex_lock>
 933:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 936:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 93a:	79 07                	jns    943 <qthread_mutex_lock+0x21>
    	return -1;
 93c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 941:	eb 05                	jmp    948 <qthread_mutex_lock+0x26>
    }
    return 0;
 943:	b8 00 00 00 00       	mov    $0x0,%eax
}
 948:	c9                   	leave  
 949:	c3                   	ret    

0000094a <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 94a:	55                   	push   %ebp
 94b:	89 e5                	mov    %esp,%ebp
 94d:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 950:	8b 45 08             	mov    0x8(%ebp),%eax
 953:	89 04 24             	mov    %eax,(%esp)
 956:	e8 f8 f9 ff ff       	call   353 <kthread_mutex_unlock>
 95b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 95e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 962:	79 07                	jns    96b <qthread_mutex_unlock+0x21>
    	return -1;
 964:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 969:	eb 05                	jmp    970 <qthread_mutex_unlock+0x26>
    }
    return 0;
 96b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 970:	c9                   	leave  
 971:	c3                   	ret    

00000972 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 972:	55                   	push   %ebp
 973:	89 e5                	mov    %esp,%ebp

	return 0;
 975:	b8 00 00 00 00       	mov    $0x0,%eax
}
 97a:	5d                   	pop    %ebp
 97b:	c3                   	ret    

0000097c <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 97c:	55                   	push   %ebp
 97d:	89 e5                	mov    %esp,%ebp
    
    return 0;
 97f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 984:	5d                   	pop    %ebp
 985:	c3                   	ret    

00000986 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 986:	55                   	push   %ebp
 987:	89 e5                	mov    %esp,%ebp
    
    return 0;
 989:	b8 00 00 00 00       	mov    $0x0,%eax
}
 98e:	5d                   	pop    %ebp
 98f:	c3                   	ret    

00000990 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
	return 0;
 993:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 998:	5d                   	pop    %ebp
 999:	c3                   	ret    

0000099a <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 99a:	55                   	push   %ebp
 99b:	89 e5                	mov    %esp,%ebp
	return 0;
 99d:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9a2:	5d                   	pop    %ebp
 9a3:	c3                   	ret    

000009a4 <qthread_exit>:

int qthread_exit(){
 9a4:	55                   	push   %ebp
 9a5:	89 e5                	mov    %esp,%ebp
	return 0;
 9a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9ac:	5d                   	pop    %ebp
 9ad:	c3                   	ret    
