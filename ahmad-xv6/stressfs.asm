
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
  2c:	c7 44 24 04 3e 0b 00 	movl   $0xb3e,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 bb 05 00 00       	call   5fb <printf>
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
  91:	c7 44 24 04 51 0b 00 	movl   $0xb51,0x4(%esp)
  98:	00 
  99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a0:	e8 56 05 00 00       	call   5fb <printf>

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
 12a:	c7 44 24 04 5b 0b 00 	movl   $0xb5b,0x4(%esp)
 131:	00 
 132:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 139:	e8 bd 04 00 00       	call   5fb <printf>

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
SYSCALL(kthread_cond_broadcast)
 50b:	b8 20 00 00 00       	mov    $0x20,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <kthread_exit>:
 513:	b8 21 00 00 00       	mov    $0x21,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 51b:	55                   	push   %ebp
 51c:	89 e5                	mov    %esp,%ebp
 51e:	83 ec 18             	sub    $0x18,%esp
 521:	8b 45 0c             	mov    0xc(%ebp),%eax
 524:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 527:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 52e:	00 
 52f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 532:	89 44 24 04          	mov    %eax,0x4(%esp)
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	89 04 24             	mov    %eax,(%esp)
 53c:	e8 fa fe ff ff       	call   43b <write>
}
 541:	c9                   	leave  
 542:	c3                   	ret    

00000543 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 543:	55                   	push   %ebp
 544:	89 e5                	mov    %esp,%ebp
 546:	56                   	push   %esi
 547:	53                   	push   %ebx
 548:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 552:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 556:	74 17                	je     56f <printint+0x2c>
 558:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 55c:	79 11                	jns    56f <printint+0x2c>
    neg = 1;
 55e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 565:	8b 45 0c             	mov    0xc(%ebp),%eax
 568:	f7 d8                	neg    %eax
 56a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 56d:	eb 06                	jmp    575 <printint+0x32>
  } else {
    x = xx;
 56f:	8b 45 0c             	mov    0xc(%ebp),%eax
 572:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 575:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 57c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 57f:	8d 41 01             	lea    0x1(%ecx),%eax
 582:	89 45 f4             	mov    %eax,-0xc(%ebp)
 585:	8b 5d 10             	mov    0x10(%ebp),%ebx
 588:	8b 45 ec             	mov    -0x14(%ebp),%eax
 58b:	ba 00 00 00 00       	mov    $0x0,%edx
 590:	f7 f3                	div    %ebx
 592:	89 d0                	mov    %edx,%eax
 594:	0f b6 80 54 0f 00 00 	movzbl 0xf54(%eax),%eax
 59b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 59f:	8b 75 10             	mov    0x10(%ebp),%esi
 5a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a5:	ba 00 00 00 00       	mov    $0x0,%edx
 5aa:	f7 f6                	div    %esi
 5ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b3:	75 c7                	jne    57c <printint+0x39>
  if(neg)
 5b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b9:	74 10                	je     5cb <printint+0x88>
    buf[i++] = '-';
 5bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5be:	8d 50 01             	lea    0x1(%eax),%edx
 5c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5c9:	eb 1f                	jmp    5ea <printint+0xa7>
 5cb:	eb 1d                	jmp    5ea <printint+0xa7>
    putc(fd, buf[i]);
 5cd:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d3:	01 d0                	add    %edx,%eax
 5d5:	0f b6 00             	movzbl (%eax),%eax
 5d8:	0f be c0             	movsbl %al,%eax
 5db:	89 44 24 04          	mov    %eax,0x4(%esp)
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	89 04 24             	mov    %eax,(%esp)
 5e5:	e8 31 ff ff ff       	call   51b <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ea:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5f2:	79 d9                	jns    5cd <printint+0x8a>
    putc(fd, buf[i]);
}
 5f4:	83 c4 30             	add    $0x30,%esp
 5f7:	5b                   	pop    %ebx
 5f8:	5e                   	pop    %esi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    

000005fb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5fb:	55                   	push   %ebp
 5fc:	89 e5                	mov    %esp,%ebp
 5fe:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 601:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 608:	8d 45 0c             	lea    0xc(%ebp),%eax
 60b:	83 c0 04             	add    $0x4,%eax
 60e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 611:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 618:	e9 7c 01 00 00       	jmp    799 <printf+0x19e>
    c = fmt[i] & 0xff;
 61d:	8b 55 0c             	mov    0xc(%ebp),%edx
 620:	8b 45 f0             	mov    -0x10(%ebp),%eax
 623:	01 d0                	add    %edx,%eax
 625:	0f b6 00             	movzbl (%eax),%eax
 628:	0f be c0             	movsbl %al,%eax
 62b:	25 ff 00 00 00       	and    $0xff,%eax
 630:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 633:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 637:	75 2c                	jne    665 <printf+0x6a>
      if(c == '%'){
 639:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 63d:	75 0c                	jne    64b <printf+0x50>
        state = '%';
 63f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 646:	e9 4a 01 00 00       	jmp    795 <printf+0x19a>
      } else {
        putc(fd, c);
 64b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64e:	0f be c0             	movsbl %al,%eax
 651:	89 44 24 04          	mov    %eax,0x4(%esp)
 655:	8b 45 08             	mov    0x8(%ebp),%eax
 658:	89 04 24             	mov    %eax,(%esp)
 65b:	e8 bb fe ff ff       	call   51b <putc>
 660:	e9 30 01 00 00       	jmp    795 <printf+0x19a>
      }
    } else if(state == '%'){
 665:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 669:	0f 85 26 01 00 00    	jne    795 <printf+0x19a>
      if(c == 'd'){
 66f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 673:	75 2d                	jne    6a2 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 675:	8b 45 e8             	mov    -0x18(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 681:	00 
 682:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 689:	00 
 68a:	89 44 24 04          	mov    %eax,0x4(%esp)
 68e:	8b 45 08             	mov    0x8(%ebp),%eax
 691:	89 04 24             	mov    %eax,(%esp)
 694:	e8 aa fe ff ff       	call   543 <printint>
        ap++;
 699:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69d:	e9 ec 00 00 00       	jmp    78e <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 6a2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6a6:	74 06                	je     6ae <printf+0xb3>
 6a8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6ac:	75 2d                	jne    6db <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b1:	8b 00                	mov    (%eax),%eax
 6b3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6ba:	00 
 6bb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6c2:	00 
 6c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c7:	8b 45 08             	mov    0x8(%ebp),%eax
 6ca:	89 04 24             	mov    %eax,(%esp)
 6cd:	e8 71 fe ff ff       	call   543 <printint>
        ap++;
 6d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6d6:	e9 b3 00 00 00       	jmp    78e <printf+0x193>
      } else if(c == 's'){
 6db:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6df:	75 45                	jne    726 <printf+0x12b>
        s = (char*)*ap;
 6e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e4:	8b 00                	mov    (%eax),%eax
 6e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6f1:	75 09                	jne    6fc <printf+0x101>
          s = "(null)";
 6f3:	c7 45 f4 61 0b 00 00 	movl   $0xb61,-0xc(%ebp)
        while(*s != 0){
 6fa:	eb 1e                	jmp    71a <printf+0x11f>
 6fc:	eb 1c                	jmp    71a <printf+0x11f>
          putc(fd, *s);
 6fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 701:	0f b6 00             	movzbl (%eax),%eax
 704:	0f be c0             	movsbl %al,%eax
 707:	89 44 24 04          	mov    %eax,0x4(%esp)
 70b:	8b 45 08             	mov    0x8(%ebp),%eax
 70e:	89 04 24             	mov    %eax,(%esp)
 711:	e8 05 fe ff ff       	call   51b <putc>
          s++;
 716:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 71a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71d:	0f b6 00             	movzbl (%eax),%eax
 720:	84 c0                	test   %al,%al
 722:	75 da                	jne    6fe <printf+0x103>
 724:	eb 68                	jmp    78e <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 726:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 72a:	75 1d                	jne    749 <printf+0x14e>
        putc(fd, *ap);
 72c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 72f:	8b 00                	mov    (%eax),%eax
 731:	0f be c0             	movsbl %al,%eax
 734:	89 44 24 04          	mov    %eax,0x4(%esp)
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	89 04 24             	mov    %eax,(%esp)
 73e:	e8 d8 fd ff ff       	call   51b <putc>
        ap++;
 743:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 747:	eb 45                	jmp    78e <printf+0x193>
      } else if(c == '%'){
 749:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 74d:	75 17                	jne    766 <printf+0x16b>
        putc(fd, c);
 74f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 752:	0f be c0             	movsbl %al,%eax
 755:	89 44 24 04          	mov    %eax,0x4(%esp)
 759:	8b 45 08             	mov    0x8(%ebp),%eax
 75c:	89 04 24             	mov    %eax,(%esp)
 75f:	e8 b7 fd ff ff       	call   51b <putc>
 764:	eb 28                	jmp    78e <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 766:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 76d:	00 
 76e:	8b 45 08             	mov    0x8(%ebp),%eax
 771:	89 04 24             	mov    %eax,(%esp)
 774:	e8 a2 fd ff ff       	call   51b <putc>
        putc(fd, c);
 779:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 77c:	0f be c0             	movsbl %al,%eax
 77f:	89 44 24 04          	mov    %eax,0x4(%esp)
 783:	8b 45 08             	mov    0x8(%ebp),%eax
 786:	89 04 24             	mov    %eax,(%esp)
 789:	e8 8d fd ff ff       	call   51b <putc>
      }
      state = 0;
 78e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 795:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 799:	8b 55 0c             	mov    0xc(%ebp),%edx
 79c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79f:	01 d0                	add    %edx,%eax
 7a1:	0f b6 00             	movzbl (%eax),%eax
 7a4:	84 c0                	test   %al,%al
 7a6:	0f 85 71 fe ff ff    	jne    61d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7ac:	c9                   	leave  
 7ad:	c3                   	ret    

000007ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ae:	55                   	push   %ebp
 7af:	89 e5                	mov    %esp,%ebp
 7b1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b4:	8b 45 08             	mov    0x8(%ebp),%eax
 7b7:	83 e8 08             	sub    $0x8,%eax
 7ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7bd:	a1 70 0f 00 00       	mov    0xf70,%eax
 7c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7c5:	eb 24                	jmp    7eb <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ca:	8b 00                	mov    (%eax),%eax
 7cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cf:	77 12                	ja     7e3 <free+0x35>
 7d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d7:	77 24                	ja     7fd <free+0x4f>
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7e1:	77 1a                	ja     7fd <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e6:	8b 00                	mov    (%eax),%eax
 7e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7f1:	76 d4                	jbe    7c7 <free+0x19>
 7f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f6:	8b 00                	mov    (%eax),%eax
 7f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7fb:	76 ca                	jbe    7c7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 80a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80d:	01 c2                	add    %eax,%edx
 80f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	39 c2                	cmp    %eax,%edx
 816:	75 24                	jne    83c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 818:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81b:	8b 50 04             	mov    0x4(%eax),%edx
 81e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 821:	8b 00                	mov    (%eax),%eax
 823:	8b 40 04             	mov    0x4(%eax),%eax
 826:	01 c2                	add    %eax,%edx
 828:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 82e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 831:	8b 00                	mov    (%eax),%eax
 833:	8b 10                	mov    (%eax),%edx
 835:	8b 45 f8             	mov    -0x8(%ebp),%eax
 838:	89 10                	mov    %edx,(%eax)
 83a:	eb 0a                	jmp    846 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 83c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83f:	8b 10                	mov    (%eax),%edx
 841:	8b 45 f8             	mov    -0x8(%ebp),%eax
 844:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 846:	8b 45 fc             	mov    -0x4(%ebp),%eax
 849:	8b 40 04             	mov    0x4(%eax),%eax
 84c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 853:	8b 45 fc             	mov    -0x4(%ebp),%eax
 856:	01 d0                	add    %edx,%eax
 858:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 85b:	75 20                	jne    87d <free+0xcf>
    p->s.size += bp->s.size;
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	8b 50 04             	mov    0x4(%eax),%edx
 863:	8b 45 f8             	mov    -0x8(%ebp),%eax
 866:	8b 40 04             	mov    0x4(%eax),%eax
 869:	01 c2                	add    %eax,%edx
 86b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 871:	8b 45 f8             	mov    -0x8(%ebp),%eax
 874:	8b 10                	mov    (%eax),%edx
 876:	8b 45 fc             	mov    -0x4(%ebp),%eax
 879:	89 10                	mov    %edx,(%eax)
 87b:	eb 08                	jmp    885 <free+0xd7>
  } else
    p->s.ptr = bp;
 87d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 880:	8b 55 f8             	mov    -0x8(%ebp),%edx
 883:	89 10                	mov    %edx,(%eax)
  freep = p;
 885:	8b 45 fc             	mov    -0x4(%ebp),%eax
 888:	a3 70 0f 00 00       	mov    %eax,0xf70
}
 88d:	c9                   	leave  
 88e:	c3                   	ret    

0000088f <morecore>:

static Header*
morecore(uint nu)
{
 88f:	55                   	push   %ebp
 890:	89 e5                	mov    %esp,%ebp
 892:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 895:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 89c:	77 07                	ja     8a5 <morecore+0x16>
    nu = 4096;
 89e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8a5:	8b 45 08             	mov    0x8(%ebp),%eax
 8a8:	c1 e0 03             	shl    $0x3,%eax
 8ab:	89 04 24             	mov    %eax,(%esp)
 8ae:	e8 f0 fb ff ff       	call   4a3 <sbrk>
 8b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8b6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8ba:	75 07                	jne    8c3 <morecore+0x34>
    return 0;
 8bc:	b8 00 00 00 00       	mov    $0x0,%eax
 8c1:	eb 22                	jmp    8e5 <morecore+0x56>
  hp = (Header*)p;
 8c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cc:	8b 55 08             	mov    0x8(%ebp),%edx
 8cf:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d5:	83 c0 08             	add    $0x8,%eax
 8d8:	89 04 24             	mov    %eax,(%esp)
 8db:	e8 ce fe ff ff       	call   7ae <free>
  return freep;
 8e0:	a1 70 0f 00 00       	mov    0xf70,%eax
}
 8e5:	c9                   	leave  
 8e6:	c3                   	ret    

000008e7 <malloc>:

void*
malloc(uint nbytes)
{
 8e7:	55                   	push   %ebp
 8e8:	89 e5                	mov    %esp,%ebp
 8ea:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ed:	8b 45 08             	mov    0x8(%ebp),%eax
 8f0:	83 c0 07             	add    $0x7,%eax
 8f3:	c1 e8 03             	shr    $0x3,%eax
 8f6:	83 c0 01             	add    $0x1,%eax
 8f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8fc:	a1 70 0f 00 00       	mov    0xf70,%eax
 901:	89 45 f0             	mov    %eax,-0x10(%ebp)
 904:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 908:	75 23                	jne    92d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 90a:	c7 45 f0 68 0f 00 00 	movl   $0xf68,-0x10(%ebp)
 911:	8b 45 f0             	mov    -0x10(%ebp),%eax
 914:	a3 70 0f 00 00       	mov    %eax,0xf70
 919:	a1 70 0f 00 00       	mov    0xf70,%eax
 91e:	a3 68 0f 00 00       	mov    %eax,0xf68
    base.s.size = 0;
 923:	c7 05 6c 0f 00 00 00 	movl   $0x0,0xf6c
 92a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 930:	8b 00                	mov    (%eax),%eax
 932:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 935:	8b 45 f4             	mov    -0xc(%ebp),%eax
 938:	8b 40 04             	mov    0x4(%eax),%eax
 93b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 93e:	72 4d                	jb     98d <malloc+0xa6>
      if(p->s.size == nunits)
 940:	8b 45 f4             	mov    -0xc(%ebp),%eax
 943:	8b 40 04             	mov    0x4(%eax),%eax
 946:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 949:	75 0c                	jne    957 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 94b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94e:	8b 10                	mov    (%eax),%edx
 950:	8b 45 f0             	mov    -0x10(%ebp),%eax
 953:	89 10                	mov    %edx,(%eax)
 955:	eb 26                	jmp    97d <malloc+0x96>
      else {
        p->s.size -= nunits;
 957:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95a:	8b 40 04             	mov    0x4(%eax),%eax
 95d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 960:	89 c2                	mov    %eax,%edx
 962:	8b 45 f4             	mov    -0xc(%ebp),%eax
 965:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 968:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96b:	8b 40 04             	mov    0x4(%eax),%eax
 96e:	c1 e0 03             	shl    $0x3,%eax
 971:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 974:	8b 45 f4             	mov    -0xc(%ebp),%eax
 977:	8b 55 ec             	mov    -0x14(%ebp),%edx
 97a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 97d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 980:	a3 70 0f 00 00       	mov    %eax,0xf70
      return (void*)(p + 1);
 985:	8b 45 f4             	mov    -0xc(%ebp),%eax
 988:	83 c0 08             	add    $0x8,%eax
 98b:	eb 38                	jmp    9c5 <malloc+0xde>
    }
    if(p == freep)
 98d:	a1 70 0f 00 00       	mov    0xf70,%eax
 992:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 995:	75 1b                	jne    9b2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 997:	8b 45 ec             	mov    -0x14(%ebp),%eax
 99a:	89 04 24             	mov    %eax,(%esp)
 99d:	e8 ed fe ff ff       	call   88f <morecore>
 9a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a9:	75 07                	jne    9b2 <malloc+0xcb>
        return 0;
 9ab:	b8 00 00 00 00       	mov    $0x0,%eax
 9b0:	eb 13                	jmp    9c5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bb:	8b 00                	mov    (%eax),%eax
 9bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9c0:	e9 70 ff ff ff       	jmp    935 <malloc+0x4e>
}
 9c5:	c9                   	leave  
 9c6:	c3                   	ret    

000009c7 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 9c7:	55                   	push   %ebp
 9c8:	89 e5                	mov    %esp,%ebp
 9ca:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 9cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 9d0:	89 04 24             	mov    %eax,(%esp)
 9d3:	8b 45 08             	mov    0x8(%ebp),%eax
 9d6:	ff d0                	call   *%eax
    exit();
 9d8:	e8 3e fa ff ff       	call   41b <exit>

000009dd <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 9dd:	55                   	push   %ebp
 9de:	89 e5                	mov    %esp,%ebp
 9e0:	57                   	push   %edi
 9e1:	56                   	push   %esi
 9e2:	53                   	push   %ebx
 9e3:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 9e6:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 9ed:	e8 f5 fe ff ff       	call   8e7 <malloc>
 9f2:	8b 55 08             	mov    0x8(%ebp),%edx
 9f5:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 9f7:	8b 45 10             	mov    0x10(%ebp),%eax
 9fa:	8b 38                	mov    (%eax),%edi
 9fc:	8b 75 0c             	mov    0xc(%ebp),%esi
 9ff:	bb c7 09 00 00       	mov    $0x9c7,%ebx
 a04:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a0b:	e8 d7 fe ff ff       	call   8e7 <malloc>
 a10:	05 00 10 00 00       	add    $0x1000,%eax
 a15:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 a19:	89 74 24 08          	mov    %esi,0x8(%esp)
 a1d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 a21:	89 04 24             	mov    %eax,(%esp)
 a24:	e8 92 fa ff ff       	call   4bb <kthread_create>
 a29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 a2c:	8b 45 08             	mov    0x8(%ebp),%eax
 a2f:	8b 00                	mov    (%eax),%eax
 a31:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 a34:	89 10                	mov    %edx,(%eax)
    return t_id;
 a36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 a39:	83 c4 2c             	add    $0x2c,%esp
 a3c:	5b                   	pop    %ebx
 a3d:	5e                   	pop    %esi
 a3e:	5f                   	pop    %edi
 a3f:	5d                   	pop    %ebp
 a40:	c3                   	ret    

00000a41 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 a41:	55                   	push   %ebp
 a42:	89 e5                	mov    %esp,%ebp
 a44:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 a47:	8b 55 0c             	mov    0xc(%ebp),%edx
 a4a:	8b 45 08             	mov    0x8(%ebp),%eax
 a4d:	8b 00                	mov    (%eax),%eax
 a4f:	89 54 24 04          	mov    %edx,0x4(%esp)
 a53:	89 04 24             	mov    %eax,(%esp)
 a56:	e8 68 fa ff ff       	call   4c3 <kthread_join>
 a5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 a61:	c9                   	leave  
 a62:	c3                   	ret    

00000a63 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 a63:	55                   	push   %ebp
 a64:	89 e5                	mov    %esp,%ebp
 a66:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 a69:	e8 5d fa ff ff       	call   4cb <kthread_mutex_init>
 a6e:	8b 55 08             	mov    0x8(%ebp),%edx
 a71:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a73:	8b 45 08             	mov    0x8(%ebp),%eax
 a76:	8b 00                	mov    (%eax),%eax
 a78:	85 c0                	test   %eax,%eax
 a7a:	7e 07                	jle    a83 <qthread_mutex_init+0x20>
		return 0;
 a7c:	b8 00 00 00 00       	mov    $0x0,%eax
 a81:	eb 05                	jmp    a88 <qthread_mutex_init+0x25>
	}
	return *mutex;
 a83:	8b 45 08             	mov    0x8(%ebp),%eax
 a86:	8b 00                	mov    (%eax),%eax
}
 a88:	c9                   	leave  
 a89:	c3                   	ret    

00000a8a <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 a8a:	55                   	push   %ebp
 a8b:	89 e5                	mov    %esp,%ebp
 a8d:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 a90:	8b 45 08             	mov    0x8(%ebp),%eax
 a93:	89 04 24             	mov    %eax,(%esp)
 a96:	e8 38 fa ff ff       	call   4d3 <kthread_mutex_destroy>
 a9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aa2:	79 07                	jns    aab <qthread_mutex_destroy+0x21>
    	return -1;
 aa4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 aa9:	eb 05                	jmp    ab0 <qthread_mutex_destroy+0x26>
    }
    return 0;
 aab:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ab0:	c9                   	leave  
 ab1:	c3                   	ret    

00000ab2 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 ab2:	55                   	push   %ebp
 ab3:	89 e5                	mov    %esp,%ebp
 ab5:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 ab8:	8b 45 08             	mov    0x8(%ebp),%eax
 abb:	89 04 24             	mov    %eax,(%esp)
 abe:	e8 18 fa ff ff       	call   4db <kthread_mutex_lock>
 ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 ac6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aca:	79 07                	jns    ad3 <qthread_mutex_lock+0x21>
    	return -1;
 acc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ad1:	eb 05                	jmp    ad8 <qthread_mutex_lock+0x26>
    }
    return 0;
 ad3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ad8:	c9                   	leave  
 ad9:	c3                   	ret    

00000ada <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 ada:	55                   	push   %ebp
 adb:	89 e5                	mov    %esp,%ebp
 add:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 ae0:	8b 45 08             	mov    0x8(%ebp),%eax
 ae3:	89 04 24             	mov    %eax,(%esp)
 ae6:	e8 f8 f9 ff ff       	call   4e3 <kthread_mutex_unlock>
 aeb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 aee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 af2:	79 07                	jns    afb <qthread_mutex_unlock+0x21>
    	return -1;
 af4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 af9:	eb 05                	jmp    b00 <qthread_mutex_unlock+0x26>
    }
    return 0;
 afb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b00:	c9                   	leave  
 b01:	c3                   	ret    

00000b02 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 b02:	55                   	push   %ebp
 b03:	89 e5                	mov    %esp,%ebp

	return 0;
 b05:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b0a:	5d                   	pop    %ebp
 b0b:	c3                   	ret    

00000b0c <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 b0c:	55                   	push   %ebp
 b0d:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b14:	5d                   	pop    %ebp
 b15:	c3                   	ret    

00000b16 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 b16:	55                   	push   %ebp
 b17:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b19:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b1e:	5d                   	pop    %ebp
 b1f:	c3                   	ret    

00000b20 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 b20:	55                   	push   %ebp
 b21:	89 e5                	mov    %esp,%ebp
	return 0;
 b23:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b28:	5d                   	pop    %ebp
 b29:	c3                   	ret    

00000b2a <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 b2a:	55                   	push   %ebp
 b2b:	89 e5                	mov    %esp,%ebp
	return 0;
 b2d:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b32:	5d                   	pop    %ebp
 b33:	c3                   	ret    

00000b34 <qthread_exit>:

int qthread_exit(){
 b34:	55                   	push   %ebp
 b35:	89 e5                	mov    %esp,%ebp
	return 0;
 b37:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b3c:	5d                   	pop    %ebp
 b3d:	c3                   	ret    
