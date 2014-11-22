
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	81 ec 30 02 00 00    	sub    $0x230,%esp
  int fd, i;
  char path[] = "stressfs0";
   c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
  13:	73 74 72 65 
  17:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
  1e:	73 73 66 73 
  22:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
  29:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	c7 44 24 04 2c 0b 00 	movl   $0xb2c,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 b3 05 00 00       	call   5f3 <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  54:	89 04 24             	mov    %eax,(%esp)
  57:	e8 12 02 00 00       	call   26e <memset>

  for(i = 0; i < 4; i++)
  5c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  63:	00 00 00 00 
  67:	eb 13                	jmp    7c <main+0x7c>
    if(fork() > 0)
  69:	e8 a5 03 00 00       	call   413 <fork>
  6e:	85 c0                	test   %eax,%eax
  70:	7e 02                	jle    74 <main+0x74>
      break;
  72:	eb 12                	jmp    86 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  74:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
  7b:	01 
  7c:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
  83:	03 
  84:	7e e3                	jle    69 <main+0x69>
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  86:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  8d:	89 44 24 08          	mov    %eax,0x8(%esp)
  91:	c7 44 24 04 3f 0b 00 	movl   $0xb3f,0x4(%esp)
  98:	00 
  99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a0:	e8 4e 05 00 00       	call   5f3 <printf>

  path[8] += i;
  a5:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
  ac:	00 
  ad:	89 c2                	mov    %eax,%edx
  af:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  b6:	01 d0                	add    %edx,%eax
  b8:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  bf:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c6:	00 
  c7:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
  ce:	89 04 24             	mov    %eax,(%esp)
  d1:	e8 85 03 00 00       	call   45b <open>
  d6:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
  dd:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  e4:	00 00 00 00 
  e8:	eb 27                	jmp    111 <main+0x111>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  ea:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  f1:	00 
  f2:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  fa:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 101:	89 04 24             	mov    %eax,(%esp)
 104:	e8 32 03 00 00       	call   43b <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
 109:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 110:	01 
 111:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 118:	13 
 119:	7e cf                	jle    ea <main+0xea>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
 11b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 122:	89 04 24             	mov    %eax,(%esp)
 125:	e8 19 03 00 00       	call   443 <close>

  printf(1, "read\n");
 12a:	c7 44 24 04 49 0b 00 	movl   $0xb49,0x4(%esp)
 131:	00 
 132:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 139:	e8 b5 04 00 00       	call   5f3 <printf>

  fd = open(path, O_RDONLY);
 13e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 145:	00 
 146:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
 14d:	89 04 24             	mov    %eax,(%esp)
 150:	e8 06 03 00 00       	call   45b <open>
 155:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
 15c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
 163:	00 00 00 00 
 167:	eb 27                	jmp    190 <main+0x190>
    read(fd, data, sizeof(data));
 169:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 170:	00 
 171:	8d 44 24 1e          	lea    0x1e(%esp),%eax
 175:	89 44 24 04          	mov    %eax,0x4(%esp)
 179:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 180:	89 04 24             	mov    %eax,(%esp)
 183:	e8 ab 02 00 00       	call   433 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 188:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 18f:	01 
 190:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 197:	13 
 198:	7e cf                	jle    169 <main+0x169>
    read(fd, data, sizeof(data));
  close(fd);
 19a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 1a1:	89 04 24             	mov    %eax,(%esp)
 1a4:	e8 9a 02 00 00       	call   443 <close>

  wait();
 1a9:	e8 75 02 00 00       	call   423 <wait>
  
  exit();
 1ae:	e8 68 02 00 00       	call   41b <exit>

000001b3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	57                   	push   %edi
 1b7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bb:	8b 55 10             	mov    0x10(%ebp),%edx
 1be:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c1:	89 cb                	mov    %ecx,%ebx
 1c3:	89 df                	mov    %ebx,%edi
 1c5:	89 d1                	mov    %edx,%ecx
 1c7:	fc                   	cld    
 1c8:	f3 aa                	rep stos %al,%es:(%edi)
 1ca:	89 ca                	mov    %ecx,%edx
 1cc:	89 fb                	mov    %edi,%ebx
 1ce:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d4:	5b                   	pop    %ebx
 1d5:	5f                   	pop    %edi
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    

000001d8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
 1e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e4:	90                   	nop
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	8d 50 01             	lea    0x1(%eax),%edx
 1eb:	89 55 08             	mov    %edx,0x8(%ebp)
 1ee:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f1:	8d 4a 01             	lea    0x1(%edx),%ecx
 1f4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1f7:	0f b6 12             	movzbl (%edx),%edx
 1fa:	88 10                	mov    %dl,(%eax)
 1fc:	0f b6 00             	movzbl (%eax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	75 e2                	jne    1e5 <strcpy+0xd>
    ;
  return os;
 203:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 20b:	eb 08                	jmp    215 <strcmp+0xd>
    p++, q++;
 20d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 211:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	84 c0                	test   %al,%al
 21d:	74 10                	je     22f <strcmp+0x27>
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
 222:	0f b6 10             	movzbl (%eax),%edx
 225:	8b 45 0c             	mov    0xc(%ebp),%eax
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	38 c2                	cmp    %al,%dl
 22d:	74 de                	je     20d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	0f b6 d0             	movzbl %al,%edx
 238:	8b 45 0c             	mov    0xc(%ebp),%eax
 23b:	0f b6 00             	movzbl (%eax),%eax
 23e:	0f b6 c0             	movzbl %al,%eax
 241:	29 c2                	sub    %eax,%edx
 243:	89 d0                	mov    %edx,%eax
}
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    

00000247 <strlen>:

uint
strlen(char *s)
{
 247:	55                   	push   %ebp
 248:	89 e5                	mov    %esp,%ebp
 24a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 24d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 254:	eb 04                	jmp    25a <strlen+0x13>
 256:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 25a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	01 d0                	add    %edx,%eax
 262:	0f b6 00             	movzbl (%eax),%eax
 265:	84 c0                	test   %al,%al
 267:	75 ed                	jne    256 <strlen+0xf>
    ;
  return n;
 269:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26c:	c9                   	leave  
 26d:	c3                   	ret    

0000026e <memset>:

void*
memset(void *dst, int c, uint n)
{
 26e:	55                   	push   %ebp
 26f:	89 e5                	mov    %esp,%ebp
 271:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 274:	8b 45 10             	mov    0x10(%ebp),%eax
 277:	89 44 24 08          	mov    %eax,0x8(%esp)
 27b:	8b 45 0c             	mov    0xc(%ebp),%eax
 27e:	89 44 24 04          	mov    %eax,0x4(%esp)
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	89 04 24             	mov    %eax,(%esp)
 288:	e8 26 ff ff ff       	call   1b3 <stosb>
  return dst;
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 290:	c9                   	leave  
 291:	c3                   	ret    

00000292 <strchr>:

char*
strchr(const char *s, char c)
{
 292:	55                   	push   %ebp
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 04             	sub    $0x4,%esp
 298:	8b 45 0c             	mov    0xc(%ebp),%eax
 29b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 29e:	eb 14                	jmp    2b4 <strchr+0x22>
    if(*s == c)
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	0f b6 00             	movzbl (%eax),%eax
 2a6:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2a9:	75 05                	jne    2b0 <strchr+0x1e>
      return (char*)s;
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	eb 13                	jmp    2c3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	0f b6 00             	movzbl (%eax),%eax
 2ba:	84 c0                	test   %al,%al
 2bc:	75 e2                	jne    2a0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2be:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c3:	c9                   	leave  
 2c4:	c3                   	ret    

000002c5 <gets>:

char*
gets(char *buf, int max)
{
 2c5:	55                   	push   %ebp
 2c6:	89 e5                	mov    %esp,%ebp
 2c8:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d2:	eb 4c                	jmp    320 <gets+0x5b>
    cc = read(0, &c, 1);
 2d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2db:	00 
 2dc:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2df:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ea:	e8 44 01 00 00       	call   433 <read>
 2ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2f6:	7f 02                	jg     2fa <gets+0x35>
      break;
 2f8:	eb 31                	jmp    32b <gets+0x66>
    buf[i++] = c;
 2fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2fd:	8d 50 01             	lea    0x1(%eax),%edx
 300:	89 55 f4             	mov    %edx,-0xc(%ebp)
 303:	89 c2                	mov    %eax,%edx
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	01 c2                	add    %eax,%edx
 30a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 310:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 314:	3c 0a                	cmp    $0xa,%al
 316:	74 13                	je     32b <gets+0x66>
 318:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31c:	3c 0d                	cmp    $0xd,%al
 31e:	74 0b                	je     32b <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 320:	8b 45 f4             	mov    -0xc(%ebp),%eax
 323:	83 c0 01             	add    $0x1,%eax
 326:	3b 45 0c             	cmp    0xc(%ebp),%eax
 329:	7c a9                	jl     2d4 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	01 d0                	add    %edx,%eax
 333:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 336:	8b 45 08             	mov    0x8(%ebp),%eax
}
 339:	c9                   	leave  
 33a:	c3                   	ret    

0000033b <stat>:

int
stat(char *n, struct stat *st)
{
 33b:	55                   	push   %ebp
 33c:	89 e5                	mov    %esp,%ebp
 33e:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 341:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 348:	00 
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	89 04 24             	mov    %eax,(%esp)
 34f:	e8 07 01 00 00       	call   45b <open>
 354:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 357:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 35b:	79 07                	jns    364 <stat+0x29>
    return -1;
 35d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 362:	eb 23                	jmp    387 <stat+0x4c>
  r = fstat(fd, st);
 364:	8b 45 0c             	mov    0xc(%ebp),%eax
 367:	89 44 24 04          	mov    %eax,0x4(%esp)
 36b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36e:	89 04 24             	mov    %eax,(%esp)
 371:	e8 fd 00 00 00       	call   473 <fstat>
 376:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 379:	8b 45 f4             	mov    -0xc(%ebp),%eax
 37c:	89 04 24             	mov    %eax,(%esp)
 37f:	e8 bf 00 00 00       	call   443 <close>
  return r;
 384:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 387:	c9                   	leave  
 388:	c3                   	ret    

00000389 <atoi>:

int
atoi(const char *s)
{
 389:	55                   	push   %ebp
 38a:	89 e5                	mov    %esp,%ebp
 38c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 38f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 396:	eb 25                	jmp    3bd <atoi+0x34>
    n = n*10 + *s++ - '0';
 398:	8b 55 fc             	mov    -0x4(%ebp),%edx
 39b:	89 d0                	mov    %edx,%eax
 39d:	c1 e0 02             	shl    $0x2,%eax
 3a0:	01 d0                	add    %edx,%eax
 3a2:	01 c0                	add    %eax,%eax
 3a4:	89 c1                	mov    %eax,%ecx
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
 3a9:	8d 50 01             	lea    0x1(%eax),%edx
 3ac:	89 55 08             	mov    %edx,0x8(%ebp)
 3af:	0f b6 00             	movzbl (%eax),%eax
 3b2:	0f be c0             	movsbl %al,%eax
 3b5:	01 c8                	add    %ecx,%eax
 3b7:	83 e8 30             	sub    $0x30,%eax
 3ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3bd:	8b 45 08             	mov    0x8(%ebp),%eax
 3c0:	0f b6 00             	movzbl (%eax),%eax
 3c3:	3c 2f                	cmp    $0x2f,%al
 3c5:	7e 0a                	jle    3d1 <atoi+0x48>
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	3c 39                	cmp    $0x39,%al
 3cf:	7e c7                	jle    398 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d4:	c9                   	leave  
 3d5:	c3                   	ret    

000003d6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d6:	55                   	push   %ebp
 3d7:	89 e5                	mov    %esp,%ebp
 3d9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3dc:	8b 45 08             	mov    0x8(%ebp),%eax
 3df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e8:	eb 17                	jmp    401 <memmove+0x2b>
    *dst++ = *src++;
 3ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ed:	8d 50 01             	lea    0x1(%eax),%edx
 3f0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3f3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3f6:	8d 4a 01             	lea    0x1(%edx),%ecx
 3f9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3fc:	0f b6 12             	movzbl (%edx),%edx
 3ff:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 401:	8b 45 10             	mov    0x10(%ebp),%eax
 404:	8d 50 ff             	lea    -0x1(%eax),%edx
 407:	89 55 10             	mov    %edx,0x10(%ebp)
 40a:	85 c0                	test   %eax,%eax
 40c:	7f dc                	jg     3ea <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 40e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 413:	b8 01 00 00 00       	mov    $0x1,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <exit>:
SYSCALL(exit)
 41b:	b8 02 00 00 00       	mov    $0x2,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <wait>:
SYSCALL(wait)
 423:	b8 03 00 00 00       	mov    $0x3,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <pipe>:
SYSCALL(pipe)
 42b:	b8 04 00 00 00       	mov    $0x4,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <read>:
SYSCALL(read)
 433:	b8 05 00 00 00       	mov    $0x5,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <write>:
SYSCALL(write)
 43b:	b8 10 00 00 00       	mov    $0x10,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <close>:
SYSCALL(close)
 443:	b8 15 00 00 00       	mov    $0x15,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <kill>:
SYSCALL(kill)
 44b:	b8 06 00 00 00       	mov    $0x6,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <exec>:
SYSCALL(exec)
 453:	b8 07 00 00 00       	mov    $0x7,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <open>:
SYSCALL(open)
 45b:	b8 0f 00 00 00       	mov    $0xf,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <mknod>:
SYSCALL(mknod)
 463:	b8 11 00 00 00       	mov    $0x11,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <unlink>:
SYSCALL(unlink)
 46b:	b8 12 00 00 00       	mov    $0x12,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <fstat>:
SYSCALL(fstat)
 473:	b8 08 00 00 00       	mov    $0x8,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <link>:
SYSCALL(link)
 47b:	b8 13 00 00 00       	mov    $0x13,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <mkdir>:
SYSCALL(mkdir)
 483:	b8 14 00 00 00       	mov    $0x14,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <chdir>:
SYSCALL(chdir)
 48b:	b8 09 00 00 00       	mov    $0x9,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <dup>:
SYSCALL(dup)
 493:	b8 0a 00 00 00       	mov    $0xa,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <getpid>:
SYSCALL(getpid)
 49b:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <sbrk>:
SYSCALL(sbrk)
 4a3:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <sleep>:
SYSCALL(sleep)
 4ab:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <uptime>:
SYSCALL(uptime)
 4b3:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <kthread_create>:
SYSCALL(kthread_create)
 4bb:	b8 17 00 00 00       	mov    $0x17,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <kthread_join>:
SYSCALL(kthread_join)
 4c3:	b8 16 00 00 00       	mov    $0x16,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 4cb:	b8 18 00 00 00       	mov    $0x18,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 4d3:	b8 19 00 00 00       	mov    $0x19,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 4db:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 4e3:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 4eb:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 4f3:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 4fb:	b8 1e 00 00 00       	mov    $0x1e,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 503:	b8 1f 00 00 00       	mov    $0x1f,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <kthread_cond_broadcast>:
 50b:	b8 20 00 00 00       	mov    $0x20,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 513:	55                   	push   %ebp
 514:	89 e5                	mov    %esp,%ebp
 516:	83 ec 18             	sub    $0x18,%esp
 519:	8b 45 0c             	mov    0xc(%ebp),%eax
 51c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 51f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 526:	00 
 527:	8d 45 f4             	lea    -0xc(%ebp),%eax
 52a:	89 44 24 04          	mov    %eax,0x4(%esp)
 52e:	8b 45 08             	mov    0x8(%ebp),%eax
 531:	89 04 24             	mov    %eax,(%esp)
 534:	e8 02 ff ff ff       	call   43b <write>
}
 539:	c9                   	leave  
 53a:	c3                   	ret    

0000053b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 53b:	55                   	push   %ebp
 53c:	89 e5                	mov    %esp,%ebp
 53e:	56                   	push   %esi
 53f:	53                   	push   %ebx
 540:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 543:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 54a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 54e:	74 17                	je     567 <printint+0x2c>
 550:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 554:	79 11                	jns    567 <printint+0x2c>
    neg = 1;
 556:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 55d:	8b 45 0c             	mov    0xc(%ebp),%eax
 560:	f7 d8                	neg    %eax
 562:	89 45 ec             	mov    %eax,-0x14(%ebp)
 565:	eb 06                	jmp    56d <printint+0x32>
  } else {
    x = xx;
 567:	8b 45 0c             	mov    0xc(%ebp),%eax
 56a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 56d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 574:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 577:	8d 41 01             	lea    0x1(%ecx),%eax
 57a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 57d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 580:	8b 45 ec             	mov    -0x14(%ebp),%eax
 583:	ba 00 00 00 00       	mov    $0x0,%edx
 588:	f7 f3                	div    %ebx
 58a:	89 d0                	mov    %edx,%eax
 58c:	0f b6 80 24 0f 00 00 	movzbl 0xf24(%eax),%eax
 593:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 597:	8b 75 10             	mov    0x10(%ebp),%esi
 59a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 59d:	ba 00 00 00 00       	mov    $0x0,%edx
 5a2:	f7 f6                	div    %esi
 5a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5ab:	75 c7                	jne    574 <printint+0x39>
  if(neg)
 5ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b1:	74 10                	je     5c3 <printint+0x88>
    buf[i++] = '-';
 5b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b6:	8d 50 01             	lea    0x1(%eax),%edx
 5b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5bc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5c1:	eb 1f                	jmp    5e2 <printint+0xa7>
 5c3:	eb 1d                	jmp    5e2 <printint+0xa7>
    putc(fd, buf[i]);
 5c5:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5cb:	01 d0                	add    %edx,%eax
 5cd:	0f b6 00             	movzbl (%eax),%eax
 5d0:	0f be c0             	movsbl %al,%eax
 5d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d7:	8b 45 08             	mov    0x8(%ebp),%eax
 5da:	89 04 24             	mov    %eax,(%esp)
 5dd:	e8 31 ff ff ff       	call   513 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5e2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ea:	79 d9                	jns    5c5 <printint+0x8a>
    putc(fd, buf[i]);
}
 5ec:	83 c4 30             	add    $0x30,%esp
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5d                   	pop    %ebp
 5f2:	c3                   	ret    

000005f3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5f3:	55                   	push   %ebp
 5f4:	89 e5                	mov    %esp,%ebp
 5f6:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5f9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 600:	8d 45 0c             	lea    0xc(%ebp),%eax
 603:	83 c0 04             	add    $0x4,%eax
 606:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 609:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 610:	e9 7c 01 00 00       	jmp    791 <printf+0x19e>
    c = fmt[i] & 0xff;
 615:	8b 55 0c             	mov    0xc(%ebp),%edx
 618:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61b:	01 d0                	add    %edx,%eax
 61d:	0f b6 00             	movzbl (%eax),%eax
 620:	0f be c0             	movsbl %al,%eax
 623:	25 ff 00 00 00       	and    $0xff,%eax
 628:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 62b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 62f:	75 2c                	jne    65d <printf+0x6a>
      if(c == '%'){
 631:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 635:	75 0c                	jne    643 <printf+0x50>
        state = '%';
 637:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 63e:	e9 4a 01 00 00       	jmp    78d <printf+0x19a>
      } else {
        putc(fd, c);
 643:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 646:	0f be c0             	movsbl %al,%eax
 649:	89 44 24 04          	mov    %eax,0x4(%esp)
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
 650:	89 04 24             	mov    %eax,(%esp)
 653:	e8 bb fe ff ff       	call   513 <putc>
 658:	e9 30 01 00 00       	jmp    78d <printf+0x19a>
      }
    } else if(state == '%'){
 65d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 661:	0f 85 26 01 00 00    	jne    78d <printf+0x19a>
      if(c == 'd'){
 667:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 66b:	75 2d                	jne    69a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 66d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 679:	00 
 67a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 681:	00 
 682:	89 44 24 04          	mov    %eax,0x4(%esp)
 686:	8b 45 08             	mov    0x8(%ebp),%eax
 689:	89 04 24             	mov    %eax,(%esp)
 68c:	e8 aa fe ff ff       	call   53b <printint>
        ap++;
 691:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 695:	e9 ec 00 00 00       	jmp    786 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 69a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 69e:	74 06                	je     6a6 <printf+0xb3>
 6a0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6a4:	75 2d                	jne    6d3 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a9:	8b 00                	mov    (%eax),%eax
 6ab:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6b2:	00 
 6b3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6ba:	00 
 6bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bf:	8b 45 08             	mov    0x8(%ebp),%eax
 6c2:	89 04 24             	mov    %eax,(%esp)
 6c5:	e8 71 fe ff ff       	call   53b <printint>
        ap++;
 6ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6ce:	e9 b3 00 00 00       	jmp    786 <printf+0x193>
      } else if(c == 's'){
 6d3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d7:	75 45                	jne    71e <printf+0x12b>
        s = (char*)*ap;
 6d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6dc:	8b 00                	mov    (%eax),%eax
 6de:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e9:	75 09                	jne    6f4 <printf+0x101>
          s = "(null)";
 6eb:	c7 45 f4 4f 0b 00 00 	movl   $0xb4f,-0xc(%ebp)
        while(*s != 0){
 6f2:	eb 1e                	jmp    712 <printf+0x11f>
 6f4:	eb 1c                	jmp    712 <printf+0x11f>
          putc(fd, *s);
 6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f9:	0f b6 00             	movzbl (%eax),%eax
 6fc:	0f be c0             	movsbl %al,%eax
 6ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 703:	8b 45 08             	mov    0x8(%ebp),%eax
 706:	89 04 24             	mov    %eax,(%esp)
 709:	e8 05 fe ff ff       	call   513 <putc>
          s++;
 70e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 712:	8b 45 f4             	mov    -0xc(%ebp),%eax
 715:	0f b6 00             	movzbl (%eax),%eax
 718:	84 c0                	test   %al,%al
 71a:	75 da                	jne    6f6 <printf+0x103>
 71c:	eb 68                	jmp    786 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 722:	75 1d                	jne    741 <printf+0x14e>
        putc(fd, *ap);
 724:	8b 45 e8             	mov    -0x18(%ebp),%eax
 727:	8b 00                	mov    (%eax),%eax
 729:	0f be c0             	movsbl %al,%eax
 72c:	89 44 24 04          	mov    %eax,0x4(%esp)
 730:	8b 45 08             	mov    0x8(%ebp),%eax
 733:	89 04 24             	mov    %eax,(%esp)
 736:	e8 d8 fd ff ff       	call   513 <putc>
        ap++;
 73b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73f:	eb 45                	jmp    786 <printf+0x193>
      } else if(c == '%'){
 741:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 745:	75 17                	jne    75e <printf+0x16b>
        putc(fd, c);
 747:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 74a:	0f be c0             	movsbl %al,%eax
 74d:	89 44 24 04          	mov    %eax,0x4(%esp)
 751:	8b 45 08             	mov    0x8(%ebp),%eax
 754:	89 04 24             	mov    %eax,(%esp)
 757:	e8 b7 fd ff ff       	call   513 <putc>
 75c:	eb 28                	jmp    786 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 75e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 765:	00 
 766:	8b 45 08             	mov    0x8(%ebp),%eax
 769:	89 04 24             	mov    %eax,(%esp)
 76c:	e8 a2 fd ff ff       	call   513 <putc>
        putc(fd, c);
 771:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 774:	0f be c0             	movsbl %al,%eax
 777:	89 44 24 04          	mov    %eax,0x4(%esp)
 77b:	8b 45 08             	mov    0x8(%ebp),%eax
 77e:	89 04 24             	mov    %eax,(%esp)
 781:	e8 8d fd ff ff       	call   513 <putc>
      }
      state = 0;
 786:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 78d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 791:	8b 55 0c             	mov    0xc(%ebp),%edx
 794:	8b 45 f0             	mov    -0x10(%ebp),%eax
 797:	01 d0                	add    %edx,%eax
 799:	0f b6 00             	movzbl (%eax),%eax
 79c:	84 c0                	test   %al,%al
 79e:	0f 85 71 fe ff ff    	jne    615 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a4:	c9                   	leave  
 7a5:	c3                   	ret    

000007a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	55                   	push   %ebp
 7a7:	89 e5                	mov    %esp,%ebp
 7a9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ac:	8b 45 08             	mov    0x8(%ebp),%eax
 7af:	83 e8 08             	sub    $0x8,%eax
 7b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b5:	a1 40 0f 00 00       	mov    0xf40,%eax
 7ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7bd:	eb 24                	jmp    7e3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c2:	8b 00                	mov    (%eax),%eax
 7c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c7:	77 12                	ja     7db <free+0x35>
 7c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cf:	77 24                	ja     7f5 <free+0x4f>
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	8b 00                	mov    (%eax),%eax
 7d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d9:	77 1a                	ja     7f5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7de:	8b 00                	mov    (%eax),%eax
 7e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e9:	76 d4                	jbe    7bf <free+0x19>
 7eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ee:	8b 00                	mov    (%eax),%eax
 7f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f3:	76 ca                	jbe    7bf <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f8:	8b 40 04             	mov    0x4(%eax),%eax
 7fb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 802:	8b 45 f8             	mov    -0x8(%ebp),%eax
 805:	01 c2                	add    %eax,%edx
 807:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80a:	8b 00                	mov    (%eax),%eax
 80c:	39 c2                	cmp    %eax,%edx
 80e:	75 24                	jne    834 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 810:	8b 45 f8             	mov    -0x8(%ebp),%eax
 813:	8b 50 04             	mov    0x4(%eax),%edx
 816:	8b 45 fc             	mov    -0x4(%ebp),%eax
 819:	8b 00                	mov    (%eax),%eax
 81b:	8b 40 04             	mov    0x4(%eax),%eax
 81e:	01 c2                	add    %eax,%edx
 820:	8b 45 f8             	mov    -0x8(%ebp),%eax
 823:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 826:	8b 45 fc             	mov    -0x4(%ebp),%eax
 829:	8b 00                	mov    (%eax),%eax
 82b:	8b 10                	mov    (%eax),%edx
 82d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 830:	89 10                	mov    %edx,(%eax)
 832:	eb 0a                	jmp    83e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 834:	8b 45 fc             	mov    -0x4(%ebp),%eax
 837:	8b 10                	mov    (%eax),%edx
 839:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 83e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 841:	8b 40 04             	mov    0x4(%eax),%eax
 844:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 84b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84e:	01 d0                	add    %edx,%eax
 850:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 853:	75 20                	jne    875 <free+0xcf>
    p->s.size += bp->s.size;
 855:	8b 45 fc             	mov    -0x4(%ebp),%eax
 858:	8b 50 04             	mov    0x4(%eax),%edx
 85b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85e:	8b 40 04             	mov    0x4(%eax),%eax
 861:	01 c2                	add    %eax,%edx
 863:	8b 45 fc             	mov    -0x4(%ebp),%eax
 866:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 869:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86c:	8b 10                	mov    (%eax),%edx
 86e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 871:	89 10                	mov    %edx,(%eax)
 873:	eb 08                	jmp    87d <free+0xd7>
  } else
    p->s.ptr = bp;
 875:	8b 45 fc             	mov    -0x4(%ebp),%eax
 878:	8b 55 f8             	mov    -0x8(%ebp),%edx
 87b:	89 10                	mov    %edx,(%eax)
  freep = p;
 87d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 880:	a3 40 0f 00 00       	mov    %eax,0xf40
}
 885:	c9                   	leave  
 886:	c3                   	ret    

00000887 <morecore>:

static Header*
morecore(uint nu)
{
 887:	55                   	push   %ebp
 888:	89 e5                	mov    %esp,%ebp
 88a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 88d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 894:	77 07                	ja     89d <morecore+0x16>
    nu = 4096;
 896:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 89d:	8b 45 08             	mov    0x8(%ebp),%eax
 8a0:	c1 e0 03             	shl    $0x3,%eax
 8a3:	89 04 24             	mov    %eax,(%esp)
 8a6:	e8 f8 fb ff ff       	call   4a3 <sbrk>
 8ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8ae:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8b2:	75 07                	jne    8bb <morecore+0x34>
    return 0;
 8b4:	b8 00 00 00 00       	mov    $0x0,%eax
 8b9:	eb 22                	jmp    8dd <morecore+0x56>
  hp = (Header*)p;
 8bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c4:	8b 55 08             	mov    0x8(%ebp),%edx
 8c7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cd:	83 c0 08             	add    $0x8,%eax
 8d0:	89 04 24             	mov    %eax,(%esp)
 8d3:	e8 ce fe ff ff       	call   7a6 <free>
  return freep;
 8d8:	a1 40 0f 00 00       	mov    0xf40,%eax
}
 8dd:	c9                   	leave  
 8de:	c3                   	ret    

000008df <malloc>:

void*
malloc(uint nbytes)
{
 8df:	55                   	push   %ebp
 8e0:	89 e5                	mov    %esp,%ebp
 8e2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e5:	8b 45 08             	mov    0x8(%ebp),%eax
 8e8:	83 c0 07             	add    $0x7,%eax
 8eb:	c1 e8 03             	shr    $0x3,%eax
 8ee:	83 c0 01             	add    $0x1,%eax
 8f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8f4:	a1 40 0f 00 00       	mov    0xf40,%eax
 8f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 900:	75 23                	jne    925 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 902:	c7 45 f0 38 0f 00 00 	movl   $0xf38,-0x10(%ebp)
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	a3 40 0f 00 00       	mov    %eax,0xf40
 911:	a1 40 0f 00 00       	mov    0xf40,%eax
 916:	a3 38 0f 00 00       	mov    %eax,0xf38
    base.s.size = 0;
 91b:	c7 05 3c 0f 00 00 00 	movl   $0x0,0xf3c
 922:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 925:	8b 45 f0             	mov    -0x10(%ebp),%eax
 928:	8b 00                	mov    (%eax),%eax
 92a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 92d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 930:	8b 40 04             	mov    0x4(%eax),%eax
 933:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 936:	72 4d                	jb     985 <malloc+0xa6>
      if(p->s.size == nunits)
 938:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93b:	8b 40 04             	mov    0x4(%eax),%eax
 93e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 941:	75 0c                	jne    94f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 943:	8b 45 f4             	mov    -0xc(%ebp),%eax
 946:	8b 10                	mov    (%eax),%edx
 948:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94b:	89 10                	mov    %edx,(%eax)
 94d:	eb 26                	jmp    975 <malloc+0x96>
      else {
        p->s.size -= nunits;
 94f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 952:	8b 40 04             	mov    0x4(%eax),%eax
 955:	2b 45 ec             	sub    -0x14(%ebp),%eax
 958:	89 c2                	mov    %eax,%edx
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 960:	8b 45 f4             	mov    -0xc(%ebp),%eax
 963:	8b 40 04             	mov    0x4(%eax),%eax
 966:	c1 e0 03             	shl    $0x3,%eax
 969:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 96c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 972:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 975:	8b 45 f0             	mov    -0x10(%ebp),%eax
 978:	a3 40 0f 00 00       	mov    %eax,0xf40
      return (void*)(p + 1);
 97d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 980:	83 c0 08             	add    $0x8,%eax
 983:	eb 38                	jmp    9bd <malloc+0xde>
    }
    if(p == freep)
 985:	a1 40 0f 00 00       	mov    0xf40,%eax
 98a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 98d:	75 1b                	jne    9aa <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 98f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 992:	89 04 24             	mov    %eax,(%esp)
 995:	e8 ed fe ff ff       	call   887 <morecore>
 99a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 99d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a1:	75 07                	jne    9aa <malloc+0xcb>
        return 0;
 9a3:	b8 00 00 00 00       	mov    $0x0,%eax
 9a8:	eb 13                	jmp    9bd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b3:	8b 00                	mov    (%eax),%eax
 9b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9b8:	e9 70 ff ff ff       	jmp    92d <malloc+0x4e>
}
 9bd:	c9                   	leave  
 9be:	c3                   	ret    

000009bf <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 9bf:	55                   	push   %ebp
 9c0:	89 e5                	mov    %esp,%ebp
 9c2:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 9c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 9c8:	89 04 24             	mov    %eax,(%esp)
 9cb:	8b 45 08             	mov    0x8(%ebp),%eax
 9ce:	ff d0                	call   *%eax
    exit();
 9d0:	e8 46 fa ff ff       	call   41b <exit>

000009d5 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 9d5:	55                   	push   %ebp
 9d6:	89 e5                	mov    %esp,%ebp
 9d8:	57                   	push   %edi
 9d9:	56                   	push   %esi
 9da:	53                   	push   %ebx
 9db:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 9de:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 9e5:	e8 f5 fe ff ff       	call   8df <malloc>
 9ea:	8b 55 08             	mov    0x8(%ebp),%edx
 9ed:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 9ef:	8b 45 10             	mov    0x10(%ebp),%eax
 9f2:	8b 38                	mov    (%eax),%edi
 9f4:	8b 75 0c             	mov    0xc(%ebp),%esi
 9f7:	bb bf 09 00 00       	mov    $0x9bf,%ebx
 9fc:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a03:	e8 d7 fe ff ff       	call   8df <malloc>
 a08:	05 00 10 00 00       	add    $0x1000,%eax
 a0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 a11:	89 74 24 08          	mov    %esi,0x8(%esp)
 a15:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 a19:	89 04 24             	mov    %eax,(%esp)
 a1c:	e8 9a fa ff ff       	call   4bb <kthread_create>
 a21:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 a24:	8b 45 08             	mov    0x8(%ebp),%eax
 a27:	8b 00                	mov    (%eax),%eax
 a29:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 a2c:	89 10                	mov    %edx,(%eax)
    return t_id;
 a2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 a31:	83 c4 2c             	add    $0x2c,%esp
 a34:	5b                   	pop    %ebx
 a35:	5e                   	pop    %esi
 a36:	5f                   	pop    %edi
 a37:	5d                   	pop    %ebp
 a38:	c3                   	ret    

00000a39 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 a39:	55                   	push   %ebp
 a3a:	89 e5                	mov    %esp,%ebp
 a3c:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 a3f:	8b 55 0c             	mov    0xc(%ebp),%edx
 a42:	8b 45 08             	mov    0x8(%ebp),%eax
 a45:	8b 00                	mov    (%eax),%eax
 a47:	89 54 24 04          	mov    %edx,0x4(%esp)
 a4b:	89 04 24             	mov    %eax,(%esp)
 a4e:	e8 70 fa ff ff       	call   4c3 <kthread_join>
 a53:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 a59:	c9                   	leave  
 a5a:	c3                   	ret    

00000a5b <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 a5b:	55                   	push   %ebp
 a5c:	89 e5                	mov    %esp,%ebp
 a5e:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 a61:	e8 65 fa ff ff       	call   4cb <kthread_mutex_init>
 a66:	8b 55 08             	mov    0x8(%ebp),%edx
 a69:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a6b:	8b 45 08             	mov    0x8(%ebp),%eax
 a6e:	8b 00                	mov    (%eax),%eax
 a70:	85 c0                	test   %eax,%eax
 a72:	7e 07                	jle    a7b <qthread_mutex_init+0x20>
		return 0;
 a74:	b8 00 00 00 00       	mov    $0x0,%eax
 a79:	eb 05                	jmp    a80 <qthread_mutex_init+0x25>
	}
	return *mutex;
 a7b:	8b 45 08             	mov    0x8(%ebp),%eax
 a7e:	8b 00                	mov    (%eax),%eax
}
 a80:	c9                   	leave  
 a81:	c3                   	ret    

00000a82 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 a82:	55                   	push   %ebp
 a83:	89 e5                	mov    %esp,%ebp
 a85:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 a88:	8b 45 08             	mov    0x8(%ebp),%eax
 a8b:	89 04 24             	mov    %eax,(%esp)
 a8e:	e8 40 fa ff ff       	call   4d3 <kthread_mutex_destroy>
 a93:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a9a:	79 07                	jns    aa3 <qthread_mutex_destroy+0x21>
    	return -1;
 a9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 aa1:	eb 05                	jmp    aa8 <qthread_mutex_destroy+0x26>
    }
    return 0;
 aa3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aa8:	c9                   	leave  
 aa9:	c3                   	ret    

00000aaa <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 aaa:	55                   	push   %ebp
 aab:	89 e5                	mov    %esp,%ebp
 aad:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 ab0:	8b 45 08             	mov    0x8(%ebp),%eax
 ab3:	89 04 24             	mov    %eax,(%esp)
 ab6:	e8 20 fa ff ff       	call   4db <kthread_mutex_lock>
 abb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 abe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ac2:	79 07                	jns    acb <qthread_mutex_lock+0x21>
    	return -1;
 ac4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ac9:	eb 05                	jmp    ad0 <qthread_mutex_lock+0x26>
    }
    return 0;
 acb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ad0:	c9                   	leave  
 ad1:	c3                   	ret    

00000ad2 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 ad2:	55                   	push   %ebp
 ad3:	89 e5                	mov    %esp,%ebp
 ad5:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 ad8:	8b 45 08             	mov    0x8(%ebp),%eax
 adb:	89 04 24             	mov    %eax,(%esp)
 ade:	e8 00 fa ff ff       	call   4e3 <kthread_mutex_unlock>
 ae3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 ae6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aea:	79 07                	jns    af3 <qthread_mutex_unlock+0x21>
    	return -1;
 aec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 af1:	eb 05                	jmp    af8 <qthread_mutex_unlock+0x26>
    }
    return 0;
 af3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 af8:	c9                   	leave  
 af9:	c3                   	ret    

00000afa <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 afa:	55                   	push   %ebp
 afb:	89 e5                	mov    %esp,%ebp

	return 0;
 afd:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b02:	5d                   	pop    %ebp
 b03:	c3                   	ret    

00000b04 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 b04:	55                   	push   %ebp
 b05:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b07:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b0c:	5d                   	pop    %ebp
 b0d:	c3                   	ret    

00000b0e <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 b0e:	55                   	push   %ebp
 b0f:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b11:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b16:	5d                   	pop    %ebp
 b17:	c3                   	ret    

00000b18 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 b18:	55                   	push   %ebp
 b19:	89 e5                	mov    %esp,%ebp
	return 0;
 b1b:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b20:	5d                   	pop    %ebp
 b21:	c3                   	ret    

00000b22 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 b22:	55                   	push   %ebp
 b23:	89 e5                	mov    %esp,%ebp
	return 0;
 b25:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b2a:	5d                   	pop    %ebp
 b2b:	c3                   	ret    
