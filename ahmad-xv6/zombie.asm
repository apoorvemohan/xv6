
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
 37b:	b8 20 00 00 00       	mov    $0x20,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 383:	55                   	push   %ebp
 384:	89 e5                	mov    %esp,%ebp
 386:	83 ec 18             	sub    $0x18,%esp
 389:	8b 45 0c             	mov    0xc(%ebp),%eax
 38c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 38f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 396:	00 
 397:	8d 45 f4             	lea    -0xc(%ebp),%eax
 39a:	89 44 24 04          	mov    %eax,0x4(%esp)
 39e:	8b 45 08             	mov    0x8(%ebp),%eax
 3a1:	89 04 24             	mov    %eax,(%esp)
 3a4:	e8 02 ff ff ff       	call   2ab <write>
}
 3a9:	c9                   	leave  
 3aa:	c3                   	ret    

000003ab <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ab:	55                   	push   %ebp
 3ac:	89 e5                	mov    %esp,%ebp
 3ae:	56                   	push   %esi
 3af:	53                   	push   %ebx
 3b0:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3ba:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3be:	74 17                	je     3d7 <printint+0x2c>
 3c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3c4:	79 11                	jns    3d7 <printint+0x2c>
    neg = 1;
 3c6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d0:	f7 d8                	neg    %eax
 3d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d5:	eb 06                	jmp    3dd <printint+0x32>
  } else {
    x = xx;
 3d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3da:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3e4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3e7:	8d 41 01             	lea    0x1(%ecx),%eax
 3ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3ed:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f3:	ba 00 00 00 00       	mov    $0x0,%edx
 3f8:	f7 f3                	div    %ebx
 3fa:	89 d0                	mov    %edx,%eax
 3fc:	0f b6 80 70 0d 00 00 	movzbl 0xd70(%eax),%eax
 403:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 407:	8b 75 10             	mov    0x10(%ebp),%esi
 40a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 40d:	ba 00 00 00 00       	mov    $0x0,%edx
 412:	f7 f6                	div    %esi
 414:	89 45 ec             	mov    %eax,-0x14(%ebp)
 417:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 41b:	75 c7                	jne    3e4 <printint+0x39>
  if(neg)
 41d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 421:	74 10                	je     433 <printint+0x88>
    buf[i++] = '-';
 423:	8b 45 f4             	mov    -0xc(%ebp),%eax
 426:	8d 50 01             	lea    0x1(%eax),%edx
 429:	89 55 f4             	mov    %edx,-0xc(%ebp)
 42c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 431:	eb 1f                	jmp    452 <printint+0xa7>
 433:	eb 1d                	jmp    452 <printint+0xa7>
    putc(fd, buf[i]);
 435:	8d 55 dc             	lea    -0x24(%ebp),%edx
 438:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43b:	01 d0                	add    %edx,%eax
 43d:	0f b6 00             	movzbl (%eax),%eax
 440:	0f be c0             	movsbl %al,%eax
 443:	89 44 24 04          	mov    %eax,0x4(%esp)
 447:	8b 45 08             	mov    0x8(%ebp),%eax
 44a:	89 04 24             	mov    %eax,(%esp)
 44d:	e8 31 ff ff ff       	call   383 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 452:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 456:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 45a:	79 d9                	jns    435 <printint+0x8a>
    putc(fd, buf[i]);
}
 45c:	83 c4 30             	add    $0x30,%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5d                   	pop    %ebp
 462:	c3                   	ret    

00000463 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 463:	55                   	push   %ebp
 464:	89 e5                	mov    %esp,%ebp
 466:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 469:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 470:	8d 45 0c             	lea    0xc(%ebp),%eax
 473:	83 c0 04             	add    $0x4,%eax
 476:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 479:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 480:	e9 7c 01 00 00       	jmp    601 <printf+0x19e>
    c = fmt[i] & 0xff;
 485:	8b 55 0c             	mov    0xc(%ebp),%edx
 488:	8b 45 f0             	mov    -0x10(%ebp),%eax
 48b:	01 d0                	add    %edx,%eax
 48d:	0f b6 00             	movzbl (%eax),%eax
 490:	0f be c0             	movsbl %al,%eax
 493:	25 ff 00 00 00       	and    $0xff,%eax
 498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 49b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 49f:	75 2c                	jne    4cd <printf+0x6a>
      if(c == '%'){
 4a1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4a5:	75 0c                	jne    4b3 <printf+0x50>
        state = '%';
 4a7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ae:	e9 4a 01 00 00       	jmp    5fd <printf+0x19a>
      } else {
        putc(fd, c);
 4b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b6:	0f be c0             	movsbl %al,%eax
 4b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bd:	8b 45 08             	mov    0x8(%ebp),%eax
 4c0:	89 04 24             	mov    %eax,(%esp)
 4c3:	e8 bb fe ff ff       	call   383 <putc>
 4c8:	e9 30 01 00 00       	jmp    5fd <printf+0x19a>
      }
    } else if(state == '%'){
 4cd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d1:	0f 85 26 01 00 00    	jne    5fd <printf+0x19a>
      if(c == 'd'){
 4d7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4db:	75 2d                	jne    50a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e0:	8b 00                	mov    (%eax),%eax
 4e2:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4e9:	00 
 4ea:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4f1:	00 
 4f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f6:	8b 45 08             	mov    0x8(%ebp),%eax
 4f9:	89 04 24             	mov    %eax,(%esp)
 4fc:	e8 aa fe ff ff       	call   3ab <printint>
        ap++;
 501:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 505:	e9 ec 00 00 00       	jmp    5f6 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 50a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 50e:	74 06                	je     516 <printf+0xb3>
 510:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 514:	75 2d                	jne    543 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 516:	8b 45 e8             	mov    -0x18(%ebp),%eax
 519:	8b 00                	mov    (%eax),%eax
 51b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 522:	00 
 523:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 52a:	00 
 52b:	89 44 24 04          	mov    %eax,0x4(%esp)
 52f:	8b 45 08             	mov    0x8(%ebp),%eax
 532:	89 04 24             	mov    %eax,(%esp)
 535:	e8 71 fe ff ff       	call   3ab <printint>
        ap++;
 53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53e:	e9 b3 00 00 00       	jmp    5f6 <printf+0x193>
      } else if(c == 's'){
 543:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 547:	75 45                	jne    58e <printf+0x12b>
        s = (char*)*ap;
 549:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54c:	8b 00                	mov    (%eax),%eax
 54e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 551:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 555:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 559:	75 09                	jne    564 <printf+0x101>
          s = "(null)";
 55b:	c7 45 f4 9c 09 00 00 	movl   $0x99c,-0xc(%ebp)
        while(*s != 0){
 562:	eb 1e                	jmp    582 <printf+0x11f>
 564:	eb 1c                	jmp    582 <printf+0x11f>
          putc(fd, *s);
 566:	8b 45 f4             	mov    -0xc(%ebp),%eax
 569:	0f b6 00             	movzbl (%eax),%eax
 56c:	0f be c0             	movsbl %al,%eax
 56f:	89 44 24 04          	mov    %eax,0x4(%esp)
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	89 04 24             	mov    %eax,(%esp)
 579:	e8 05 fe ff ff       	call   383 <putc>
          s++;
 57e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 582:	8b 45 f4             	mov    -0xc(%ebp),%eax
 585:	0f b6 00             	movzbl (%eax),%eax
 588:	84 c0                	test   %al,%al
 58a:	75 da                	jne    566 <printf+0x103>
 58c:	eb 68                	jmp    5f6 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 58e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 592:	75 1d                	jne    5b1 <printf+0x14e>
        putc(fd, *ap);
 594:	8b 45 e8             	mov    -0x18(%ebp),%eax
 597:	8b 00                	mov    (%eax),%eax
 599:	0f be c0             	movsbl %al,%eax
 59c:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a0:	8b 45 08             	mov    0x8(%ebp),%eax
 5a3:	89 04 24             	mov    %eax,(%esp)
 5a6:	e8 d8 fd ff ff       	call   383 <putc>
        ap++;
 5ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5af:	eb 45                	jmp    5f6 <printf+0x193>
      } else if(c == '%'){
 5b1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5b5:	75 17                	jne    5ce <printf+0x16b>
        putc(fd, c);
 5b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ba:	0f be c0             	movsbl %al,%eax
 5bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c1:	8b 45 08             	mov    0x8(%ebp),%eax
 5c4:	89 04 24             	mov    %eax,(%esp)
 5c7:	e8 b7 fd ff ff       	call   383 <putc>
 5cc:	eb 28                	jmp    5f6 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ce:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5d5:	00 
 5d6:	8b 45 08             	mov    0x8(%ebp),%eax
 5d9:	89 04 24             	mov    %eax,(%esp)
 5dc:	e8 a2 fd ff ff       	call   383 <putc>
        putc(fd, c);
 5e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e4:	0f be c0             	movsbl %al,%eax
 5e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5eb:	8b 45 08             	mov    0x8(%ebp),%eax
 5ee:	89 04 24             	mov    %eax,(%esp)
 5f1:	e8 8d fd ff ff       	call   383 <putc>
      }
      state = 0;
 5f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 601:	8b 55 0c             	mov    0xc(%ebp),%edx
 604:	8b 45 f0             	mov    -0x10(%ebp),%eax
 607:	01 d0                	add    %edx,%eax
 609:	0f b6 00             	movzbl (%eax),%eax
 60c:	84 c0                	test   %al,%al
 60e:	0f 85 71 fe ff ff    	jne    485 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 614:	c9                   	leave  
 615:	c3                   	ret    

00000616 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 616:	55                   	push   %ebp
 617:	89 e5                	mov    %esp,%ebp
 619:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 61c:	8b 45 08             	mov    0x8(%ebp),%eax
 61f:	83 e8 08             	sub    $0x8,%eax
 622:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 625:	a1 8c 0d 00 00       	mov    0xd8c,%eax
 62a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 62d:	eb 24                	jmp    653 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 632:	8b 00                	mov    (%eax),%eax
 634:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 637:	77 12                	ja     64b <free+0x35>
 639:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63f:	77 24                	ja     665 <free+0x4f>
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	8b 00                	mov    (%eax),%eax
 646:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 649:	77 1a                	ja     665 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64e:	8b 00                	mov    (%eax),%eax
 650:	89 45 fc             	mov    %eax,-0x4(%ebp)
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 659:	76 d4                	jbe    62f <free+0x19>
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 00                	mov    (%eax),%eax
 660:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 663:	76 ca                	jbe    62f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 665:	8b 45 f8             	mov    -0x8(%ebp),%eax
 668:	8b 40 04             	mov    0x4(%eax),%eax
 66b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 672:	8b 45 f8             	mov    -0x8(%ebp),%eax
 675:	01 c2                	add    %eax,%edx
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	39 c2                	cmp    %eax,%edx
 67e:	75 24                	jne    6a4 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 680:	8b 45 f8             	mov    -0x8(%ebp),%eax
 683:	8b 50 04             	mov    0x4(%eax),%edx
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	8b 00                	mov    (%eax),%eax
 68b:	8b 40 04             	mov    0x4(%eax),%eax
 68e:	01 c2                	add    %eax,%edx
 690:	8b 45 f8             	mov    -0x8(%ebp),%eax
 693:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	8b 10                	mov    (%eax),%edx
 69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a0:	89 10                	mov    %edx,(%eax)
 6a2:	eb 0a                	jmp    6ae <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a7:	8b 10                	mov    (%eax),%edx
 6a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ac:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	8b 40 04             	mov    0x4(%eax),%eax
 6b4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	01 d0                	add    %edx,%eax
 6c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c3:	75 20                	jne    6e5 <free+0xcf>
    p->s.size += bp->s.size;
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 50 04             	mov    0x4(%eax),%edx
 6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ce:	8b 40 04             	mov    0x4(%eax),%eax
 6d1:	01 c2                	add    %eax,%edx
 6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dc:	8b 10                	mov    (%eax),%edx
 6de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e1:	89 10                	mov    %edx,(%eax)
 6e3:	eb 08                	jmp    6ed <free+0xd7>
  } else
    p->s.ptr = bp;
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6eb:	89 10                	mov    %edx,(%eax)
  freep = p;
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	a3 8c 0d 00 00       	mov    %eax,0xd8c
}
 6f5:	c9                   	leave  
 6f6:	c3                   	ret    

000006f7 <morecore>:

static Header*
morecore(uint nu)
{
 6f7:	55                   	push   %ebp
 6f8:	89 e5                	mov    %esp,%ebp
 6fa:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6fd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 704:	77 07                	ja     70d <morecore+0x16>
    nu = 4096;
 706:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
 710:	c1 e0 03             	shl    $0x3,%eax
 713:	89 04 24             	mov    %eax,(%esp)
 716:	e8 f8 fb ff ff       	call   313 <sbrk>
 71b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 71e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 722:	75 07                	jne    72b <morecore+0x34>
    return 0;
 724:	b8 00 00 00 00       	mov    $0x0,%eax
 729:	eb 22                	jmp    74d <morecore+0x56>
  hp = (Header*)p;
 72b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 731:	8b 45 f0             	mov    -0x10(%ebp),%eax
 734:	8b 55 08             	mov    0x8(%ebp),%edx
 737:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 73a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73d:	83 c0 08             	add    $0x8,%eax
 740:	89 04 24             	mov    %eax,(%esp)
 743:	e8 ce fe ff ff       	call   616 <free>
  return freep;
 748:	a1 8c 0d 00 00       	mov    0xd8c,%eax
}
 74d:	c9                   	leave  
 74e:	c3                   	ret    

0000074f <malloc>:

void*
malloc(uint nbytes)
{
 74f:	55                   	push   %ebp
 750:	89 e5                	mov    %esp,%ebp
 752:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 755:	8b 45 08             	mov    0x8(%ebp),%eax
 758:	83 c0 07             	add    $0x7,%eax
 75b:	c1 e8 03             	shr    $0x3,%eax
 75e:	83 c0 01             	add    $0x1,%eax
 761:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 764:	a1 8c 0d 00 00       	mov    0xd8c,%eax
 769:	89 45 f0             	mov    %eax,-0x10(%ebp)
 76c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 770:	75 23                	jne    795 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 772:	c7 45 f0 84 0d 00 00 	movl   $0xd84,-0x10(%ebp)
 779:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77c:	a3 8c 0d 00 00       	mov    %eax,0xd8c
 781:	a1 8c 0d 00 00       	mov    0xd8c,%eax
 786:	a3 84 0d 00 00       	mov    %eax,0xd84
    base.s.size = 0;
 78b:	c7 05 88 0d 00 00 00 	movl   $0x0,0xd88
 792:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 795:	8b 45 f0             	mov    -0x10(%ebp),%eax
 798:	8b 00                	mov    (%eax),%eax
 79a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a0:	8b 40 04             	mov    0x4(%eax),%eax
 7a3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7a6:	72 4d                	jb     7f5 <malloc+0xa6>
      if(p->s.size == nunits)
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 40 04             	mov    0x4(%eax),%eax
 7ae:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b1:	75 0c                	jne    7bf <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	8b 10                	mov    (%eax),%edx
 7b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bb:	89 10                	mov    %edx,(%eax)
 7bd:	eb 26                	jmp    7e5 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	8b 40 04             	mov    0x4(%eax),%eax
 7c5:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7c8:	89 c2                	mov    %eax,%edx
 7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d3:	8b 40 04             	mov    0x4(%eax),%eax
 7d6:	c1 e0 03             	shl    $0x3,%eax
 7d9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7e2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	a3 8c 0d 00 00       	mov    %eax,0xd8c
      return (void*)(p + 1);
 7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f0:	83 c0 08             	add    $0x8,%eax
 7f3:	eb 38                	jmp    82d <malloc+0xde>
    }
    if(p == freep)
 7f5:	a1 8c 0d 00 00       	mov    0xd8c,%eax
 7fa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7fd:	75 1b                	jne    81a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
 802:	89 04 24             	mov    %eax,(%esp)
 805:	e8 ed fe ff ff       	call   6f7 <morecore>
 80a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 80d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 811:	75 07                	jne    81a <malloc+0xcb>
        return 0;
 813:	b8 00 00 00 00       	mov    $0x0,%eax
 818:	eb 13                	jmp    82d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 820:	8b 45 f4             	mov    -0xc(%ebp),%eax
 823:	8b 00                	mov    (%eax),%eax
 825:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 828:	e9 70 ff ff ff       	jmp    79d <malloc+0x4e>
}
 82d:	c9                   	leave  
 82e:	c3                   	ret    

0000082f <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 82f:	55                   	push   %ebp
 830:	89 e5                	mov    %esp,%ebp
 832:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 835:	8b 45 0c             	mov    0xc(%ebp),%eax
 838:	89 04 24             	mov    %eax,(%esp)
 83b:	8b 45 08             	mov    0x8(%ebp),%eax
 83e:	ff d0                	call   *%eax
    exit();
 840:	e8 46 fa ff ff       	call   28b <exit>

00000845 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 845:	55                   	push   %ebp
 846:	89 e5                	mov    %esp,%ebp
 848:	57                   	push   %edi
 849:	56                   	push   %esi
 84a:	53                   	push   %ebx
 84b:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 84e:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 855:	e8 f5 fe ff ff       	call   74f <malloc>
 85a:	8b 55 08             	mov    0x8(%ebp),%edx
 85d:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 85f:	8b 45 10             	mov    0x10(%ebp),%eax
 862:	8b 38                	mov    (%eax),%edi
 864:	8b 75 0c             	mov    0xc(%ebp),%esi
 867:	bb 2f 08 00 00       	mov    $0x82f,%ebx
 86c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 873:	e8 d7 fe ff ff       	call   74f <malloc>
 878:	05 00 10 00 00       	add    $0x1000,%eax
 87d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 881:	89 74 24 08          	mov    %esi,0x8(%esp)
 885:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 889:	89 04 24             	mov    %eax,(%esp)
 88c:	e8 9a fa ff ff       	call   32b <kthread_create>
 891:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 894:	8b 45 08             	mov    0x8(%ebp),%eax
 897:	8b 00                	mov    (%eax),%eax
 899:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 89c:	89 10                	mov    %edx,(%eax)
    return t_id;
 89e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 8a1:	83 c4 2c             	add    $0x2c,%esp
 8a4:	5b                   	pop    %ebx
 8a5:	5e                   	pop    %esi
 8a6:	5f                   	pop    %edi
 8a7:	5d                   	pop    %ebp
 8a8:	c3                   	ret    

000008a9 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8a9:	55                   	push   %ebp
 8aa:	89 e5                	mov    %esp,%ebp
 8ac:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 8af:	8b 55 0c             	mov    0xc(%ebp),%edx
 8b2:	8b 45 08             	mov    0x8(%ebp),%eax
 8b5:	8b 00                	mov    (%eax),%eax
 8b7:	89 54 24 04          	mov    %edx,0x4(%esp)
 8bb:	89 04 24             	mov    %eax,(%esp)
 8be:	e8 70 fa ff ff       	call   333 <kthread_join>
 8c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 8c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 8c9:	c9                   	leave  
 8ca:	c3                   	ret    

000008cb <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 8cb:	55                   	push   %ebp
 8cc:	89 e5                	mov    %esp,%ebp
 8ce:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 8d1:	e8 65 fa ff ff       	call   33b <kthread_mutex_init>
 8d6:	8b 55 08             	mov    0x8(%ebp),%edx
 8d9:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 8db:	8b 45 08             	mov    0x8(%ebp),%eax
 8de:	8b 00                	mov    (%eax),%eax
 8e0:	85 c0                	test   %eax,%eax
 8e2:	7e 07                	jle    8eb <qthread_mutex_init+0x20>
		return 0;
 8e4:	b8 00 00 00 00       	mov    $0x0,%eax
 8e9:	eb 05                	jmp    8f0 <qthread_mutex_init+0x25>
	}
	return *mutex;
 8eb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ee:	8b 00                	mov    (%eax),%eax
}
 8f0:	c9                   	leave  
 8f1:	c3                   	ret    

000008f2 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 8f2:	55                   	push   %ebp
 8f3:	89 e5                	mov    %esp,%ebp
 8f5:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 8f8:	8b 45 08             	mov    0x8(%ebp),%eax
 8fb:	89 04 24             	mov    %eax,(%esp)
 8fe:	e8 40 fa ff ff       	call   343 <kthread_mutex_destroy>
 903:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 906:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 90a:	79 07                	jns    913 <qthread_mutex_destroy+0x21>
    	return -1;
 90c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 911:	eb 05                	jmp    918 <qthread_mutex_destroy+0x26>
    }
    return 0;
 913:	b8 00 00 00 00       	mov    $0x0,%eax
}
 918:	c9                   	leave  
 919:	c3                   	ret    

0000091a <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 91a:	55                   	push   %ebp
 91b:	89 e5                	mov    %esp,%ebp
 91d:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 920:	8b 45 08             	mov    0x8(%ebp),%eax
 923:	89 04 24             	mov    %eax,(%esp)
 926:	e8 20 fa ff ff       	call   34b <kthread_mutex_lock>
 92b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 92e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 932:	79 07                	jns    93b <qthread_mutex_lock+0x21>
    	return -1;
 934:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 939:	eb 05                	jmp    940 <qthread_mutex_lock+0x26>
    }
    return 0;
 93b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 940:	c9                   	leave  
 941:	c3                   	ret    

00000942 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 942:	55                   	push   %ebp
 943:	89 e5                	mov    %esp,%ebp
 945:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 948:	8b 45 08             	mov    0x8(%ebp),%eax
 94b:	89 04 24             	mov    %eax,(%esp)
 94e:	e8 00 fa ff ff       	call   353 <kthread_mutex_unlock>
 953:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 956:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 95a:	79 07                	jns    963 <qthread_mutex_unlock+0x21>
    	return -1;
 95c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 961:	eb 05                	jmp    968 <qthread_mutex_unlock+0x26>
    }
    return 0;
 963:	b8 00 00 00 00       	mov    $0x0,%eax
}
 968:	c9                   	leave  
 969:	c3                   	ret    

0000096a <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 96a:	55                   	push   %ebp
 96b:	89 e5                	mov    %esp,%ebp

	return 0;
 96d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 972:	5d                   	pop    %ebp
 973:	c3                   	ret    

00000974 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 974:	55                   	push   %ebp
 975:	89 e5                	mov    %esp,%ebp
    
    return 0;
 977:	b8 00 00 00 00       	mov    $0x0,%eax
}
 97c:	5d                   	pop    %ebp
 97d:	c3                   	ret    

0000097e <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 97e:	55                   	push   %ebp
 97f:	89 e5                	mov    %esp,%ebp
    
    return 0;
 981:	b8 00 00 00 00       	mov    $0x0,%eax
}
 986:	5d                   	pop    %ebp
 987:	c3                   	ret    

00000988 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 988:	55                   	push   %ebp
 989:	89 e5                	mov    %esp,%ebp
	return 0;
 98b:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 990:	5d                   	pop    %ebp
 991:	c3                   	ret    

00000992 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 992:	55                   	push   %ebp
 993:	89 e5                	mov    %esp,%ebp
	return 0;
 995:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 99a:	5d                   	pop    %ebp
 99b:	c3                   	ret    
