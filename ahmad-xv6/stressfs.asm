
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
  2c:	c7 44 24 04 25 0b 00 	movl   $0xb25,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 af 05 00 00       	call   5ef <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  54:	89 04 24             	mov    %eax,(%esp)
  57:	e8 17 02 00 00       	call   273 <memset>

  for(i = 0; i < 4; i++)
  5c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  63:	00 00 00 00 
  67:	eb 11                	jmp    7a <main+0x7a>
    if(fork() > 0)
  69:	e8 a2 03 00 00       	call   410 <fork>
  6e:	85 c0                	test   %eax,%eax
  70:	7f 14                	jg     86 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  72:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
  79:	01 
  7a:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
  81:	03 
  82:	7e e5                	jle    69 <main+0x69>
  84:	eb 01                	jmp    87 <main+0x87>
    if(fork() > 0)
      break;
  86:	90                   	nop

  printf(1, "write %d\n", i);
  87:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  8e:	89 44 24 08          	mov    %eax,0x8(%esp)
  92:	c7 44 24 04 38 0b 00 	movl   $0xb38,0x4(%esp)
  99:	00 
  9a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a1:	e8 49 05 00 00       	call   5ef <printf>

  path[8] += i;
  a6:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
  ad:	00 
  ae:	89 c2                	mov    %eax,%edx
  b0:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  b7:	01 d0                	add    %edx,%eax
  b9:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  c0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c7:	00 
  c8:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
  cf:	89 04 24             	mov    %eax,(%esp)
  d2:	e8 81 03 00 00       	call   458 <open>
  d7:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
  de:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  e5:	00 00 00 00 
  e9:	eb 27                	jmp    112 <main+0x112>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  eb:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  f2:	00 
  f3:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  fb:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 102:	89 04 24             	mov    %eax,(%esp)
 105:	e8 2e 03 00 00       	call   438 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
 10a:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 111:	01 
 112:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 119:	13 
 11a:	7e cf                	jle    eb <main+0xeb>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
 11c:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 123:	89 04 24             	mov    %eax,(%esp)
 126:	e8 15 03 00 00       	call   440 <close>

  printf(1, "read\n");
 12b:	c7 44 24 04 42 0b 00 	movl   $0xb42,0x4(%esp)
 132:	00 
 133:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13a:	e8 b0 04 00 00       	call   5ef <printf>

  fd = open(path, O_RDONLY);
 13f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 146:	00 
 147:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
 14e:	89 04 24             	mov    %eax,(%esp)
 151:	e8 02 03 00 00       	call   458 <open>
 156:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
 15d:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
 164:	00 00 00 00 
 168:	eb 27                	jmp    191 <main+0x191>
    read(fd, data, sizeof(data));
 16a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 171:	00 
 172:	8d 44 24 1e          	lea    0x1e(%esp),%eax
 176:	89 44 24 04          	mov    %eax,0x4(%esp)
 17a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 181:	89 04 24             	mov    %eax,(%esp)
 184:	e8 a7 02 00 00       	call   430 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 189:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 190:	01 
 191:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 198:	13 
 199:	7e cf                	jle    16a <main+0x16a>
    read(fd, data, sizeof(data));
  close(fd);
 19b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 1a2:	89 04 24             	mov    %eax,(%esp)
 1a5:	e8 96 02 00 00       	call   440 <close>

  wait();
 1aa:	e8 71 02 00 00       	call   420 <wait>
  
  exit();
 1af:	e8 64 02 00 00       	call   418 <exit>

000001b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bc:	8b 55 10             	mov    0x10(%ebp),%edx
 1bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c2:	89 cb                	mov    %ecx,%ebx
 1c4:	89 df                	mov    %ebx,%edi
 1c6:	89 d1                	mov    %edx,%ecx
 1c8:	fc                   	cld    
 1c9:	f3 aa                	rep stos %al,%es:(%edi)
 1cb:	89 ca                	mov    %ecx,%edx
 1cd:	89 fb                	mov    %edi,%ebx
 1cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d5:	5b                   	pop    %ebx
 1d6:	5f                   	pop    %edi
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    

000001d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
 1dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e5:	90                   	nop
 1e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e9:	0f b6 10             	movzbl (%eax),%edx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	88 10                	mov    %dl,(%eax)
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	0f b6 00             	movzbl (%eax),%eax
 1f7:	84 c0                	test   %al,%al
 1f9:	0f 95 c0             	setne  %al
 1fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 200:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 204:	84 c0                	test   %al,%al
 206:	75 de                	jne    1e6 <strcpy+0xd>
    ;
  return os;
 208:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20b:	c9                   	leave  
 20c:	c3                   	ret    

0000020d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 210:	eb 08                	jmp    21a <strcmp+0xd>
    p++, q++;
 212:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 216:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	84 c0                	test   %al,%al
 222:	74 10                	je     234 <strcmp+0x27>
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	0f b6 10             	movzbl (%eax),%edx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	0f b6 00             	movzbl (%eax),%eax
 230:	38 c2                	cmp    %al,%dl
 232:	74 de                	je     212 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 00             	movzbl (%eax),%eax
 23a:	0f b6 d0             	movzbl %al,%edx
 23d:	8b 45 0c             	mov    0xc(%ebp),%eax
 240:	0f b6 00             	movzbl (%eax),%eax
 243:	0f b6 c0             	movzbl %al,%eax
 246:	89 d1                	mov    %edx,%ecx
 248:	29 c1                	sub    %eax,%ecx
 24a:	89 c8                	mov    %ecx,%eax
}
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    

0000024e <strlen>:

uint
strlen(char *s)
{
 24e:	55                   	push   %ebp
 24f:	89 e5                	mov    %esp,%ebp
 251:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25b:	eb 04                	jmp    261 <strlen+0x13>
 25d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 261:	8b 45 fc             	mov    -0x4(%ebp),%eax
 264:	03 45 08             	add    0x8(%ebp),%eax
 267:	0f b6 00             	movzbl (%eax),%eax
 26a:	84 c0                	test   %al,%al
 26c:	75 ef                	jne    25d <strlen+0xf>
    ;
  return n;
 26e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 271:	c9                   	leave  
 272:	c3                   	ret    

00000273 <memset>:

void*
memset(void *dst, int c, uint n)
{
 273:	55                   	push   %ebp
 274:	89 e5                	mov    %esp,%ebp
 276:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 279:	8b 45 10             	mov    0x10(%ebp),%eax
 27c:	89 44 24 08          	mov    %eax,0x8(%esp)
 280:	8b 45 0c             	mov    0xc(%ebp),%eax
 283:	89 44 24 04          	mov    %eax,0x4(%esp)
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	89 04 24             	mov    %eax,(%esp)
 28d:	e8 22 ff ff ff       	call   1b4 <stosb>
  return dst;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <strchr>:

char*
strchr(const char *s, char c)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 04             	sub    $0x4,%esp
 29d:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2a3:	eb 14                	jmp    2b9 <strchr+0x22>
    if(*s == c)
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2ae:	75 05                	jne    2b5 <strchr+0x1e>
      return (char*)s;
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	eb 13                	jmp    2c8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 00             	movzbl (%eax),%eax
 2bf:	84 c0                	test   %al,%al
 2c1:	75 e2                	jne    2a5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c8:	c9                   	leave  
 2c9:	c3                   	ret    

000002ca <gets>:

char*
gets(char *buf, int max)
{
 2ca:	55                   	push   %ebp
 2cb:	89 e5                	mov    %esp,%ebp
 2cd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d7:	eb 44                	jmp    31d <gets+0x53>
    cc = read(0, &c, 1);
 2d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e0:	00 
 2e1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ef:	e8 3c 01 00 00       	call   430 <read>
 2f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2fb:	7e 2d                	jle    32a <gets+0x60>
      break;
    buf[i++] = c;
 2fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 300:	03 45 08             	add    0x8(%ebp),%eax
 303:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 307:	88 10                	mov    %dl,(%eax)
 309:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 30d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 311:	3c 0a                	cmp    $0xa,%al
 313:	74 16                	je     32b <gets+0x61>
 315:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 319:	3c 0d                	cmp    $0xd,%al
 31b:	74 0e                	je     32b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 320:	83 c0 01             	add    $0x1,%eax
 323:	3b 45 0c             	cmp    0xc(%ebp),%eax
 326:	7c b1                	jl     2d9 <gets+0xf>
 328:	eb 01                	jmp    32b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 32a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 32e:	03 45 08             	add    0x8(%ebp),%eax
 331:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 334:	8b 45 08             	mov    0x8(%ebp),%eax
}
 337:	c9                   	leave  
 338:	c3                   	ret    

00000339 <stat>:

int
stat(char *n, struct stat *st)
{
 339:	55                   	push   %ebp
 33a:	89 e5                	mov    %esp,%ebp
 33c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 346:	00 
 347:	8b 45 08             	mov    0x8(%ebp),%eax
 34a:	89 04 24             	mov    %eax,(%esp)
 34d:	e8 06 01 00 00       	call   458 <open>
 352:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 355:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 359:	79 07                	jns    362 <stat+0x29>
    return -1;
 35b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 360:	eb 23                	jmp    385 <stat+0x4c>
  r = fstat(fd, st);
 362:	8b 45 0c             	mov    0xc(%ebp),%eax
 365:	89 44 24 04          	mov    %eax,0x4(%esp)
 369:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36c:	89 04 24             	mov    %eax,(%esp)
 36f:	e8 fc 00 00 00       	call   470 <fstat>
 374:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 377:	8b 45 f4             	mov    -0xc(%ebp),%eax
 37a:	89 04 24             	mov    %eax,(%esp)
 37d:	e8 be 00 00 00       	call   440 <close>
  return r;
 382:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 385:	c9                   	leave  
 386:	c3                   	ret    

00000387 <atoi>:

int
atoi(const char *s)
{
 387:	55                   	push   %ebp
 388:	89 e5                	mov    %esp,%ebp
 38a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 38d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 394:	eb 23                	jmp    3b9 <atoi+0x32>
    n = n*10 + *s++ - '0';
 396:	8b 55 fc             	mov    -0x4(%ebp),%edx
 399:	89 d0                	mov    %edx,%eax
 39b:	c1 e0 02             	shl    $0x2,%eax
 39e:	01 d0                	add    %edx,%eax
 3a0:	01 c0                	add    %eax,%eax
 3a2:	89 c2                	mov    %eax,%edx
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	0f b6 00             	movzbl (%eax),%eax
 3aa:	0f be c0             	movsbl %al,%eax
 3ad:	01 d0                	add    %edx,%eax
 3af:	83 e8 30             	sub    $0x30,%eax
 3b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b9:	8b 45 08             	mov    0x8(%ebp),%eax
 3bc:	0f b6 00             	movzbl (%eax),%eax
 3bf:	3c 2f                	cmp    $0x2f,%al
 3c1:	7e 0a                	jle    3cd <atoi+0x46>
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	0f b6 00             	movzbl (%eax),%eax
 3c9:	3c 39                	cmp    $0x39,%al
 3cb:	7e c9                	jle    396 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d0:	c9                   	leave  
 3d1:	c3                   	ret    

000003d2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d2:	55                   	push   %ebp
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3d8:	8b 45 08             	mov    0x8(%ebp),%eax
 3db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3de:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e4:	eb 13                	jmp    3f9 <memmove+0x27>
    *dst++ = *src++;
 3e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3e9:	0f b6 10             	movzbl (%eax),%edx
 3ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ef:	88 10                	mov    %dl,(%eax)
 3f1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3f5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 3fd:	0f 9f c0             	setg   %al
 400:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 404:	84 c0                	test   %al,%al
 406:	75 de                	jne    3e6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 408:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40b:	c9                   	leave  
 40c:	c3                   	ret    
 40d:	90                   	nop
 40e:	90                   	nop
 40f:	90                   	nop

00000410 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 410:	b8 01 00 00 00       	mov    $0x1,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <exit>:
SYSCALL(exit)
 418:	b8 02 00 00 00       	mov    $0x2,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <wait>:
SYSCALL(wait)
 420:	b8 03 00 00 00       	mov    $0x3,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <pipe>:
SYSCALL(pipe)
 428:	b8 04 00 00 00       	mov    $0x4,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <read>:
SYSCALL(read)
 430:	b8 05 00 00 00       	mov    $0x5,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <write>:
SYSCALL(write)
 438:	b8 10 00 00 00       	mov    $0x10,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <close>:
SYSCALL(close)
 440:	b8 15 00 00 00       	mov    $0x15,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <kill>:
SYSCALL(kill)
 448:	b8 06 00 00 00       	mov    $0x6,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <exec>:
SYSCALL(exec)
 450:	b8 07 00 00 00       	mov    $0x7,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <open>:
SYSCALL(open)
 458:	b8 0f 00 00 00       	mov    $0xf,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <mknod>:
SYSCALL(mknod)
 460:	b8 11 00 00 00       	mov    $0x11,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <unlink>:
SYSCALL(unlink)
 468:	b8 12 00 00 00       	mov    $0x12,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <fstat>:
SYSCALL(fstat)
 470:	b8 08 00 00 00       	mov    $0x8,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <link>:
SYSCALL(link)
 478:	b8 13 00 00 00       	mov    $0x13,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <mkdir>:
SYSCALL(mkdir)
 480:	b8 14 00 00 00       	mov    $0x14,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <chdir>:
SYSCALL(chdir)
 488:	b8 09 00 00 00       	mov    $0x9,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <dup>:
SYSCALL(dup)
 490:	b8 0a 00 00 00       	mov    $0xa,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <getpid>:
SYSCALL(getpid)
 498:	b8 0b 00 00 00       	mov    $0xb,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <sbrk>:
SYSCALL(sbrk)
 4a0:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <sleep>:
SYSCALL(sleep)
 4a8:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <uptime>:
SYSCALL(uptime)
 4b0:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <kthread_create>:
SYSCALL(kthread_create)
 4b8:	b8 17 00 00 00       	mov    $0x17,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <kthread_join>:
SYSCALL(kthread_join)
 4c0:	b8 16 00 00 00       	mov    $0x16,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 4c8:	b8 18 00 00 00       	mov    $0x18,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 4d0:	b8 19 00 00 00       	mov    $0x19,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 4d8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 4e0:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 4e8:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 4f0:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 4f8:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 500:	b8 1f 00 00 00       	mov    $0x1f,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 508:	b8 20 00 00 00       	mov    $0x20,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <kthread_exit>:
 510:	b8 21 00 00 00       	mov    $0x21,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 518:	55                   	push   %ebp
 519:	89 e5                	mov    %esp,%ebp
 51b:	83 ec 28             	sub    $0x28,%esp
 51e:	8b 45 0c             	mov    0xc(%ebp),%eax
 521:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 524:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 52b:	00 
 52c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 52f:	89 44 24 04          	mov    %eax,0x4(%esp)
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	89 04 24             	mov    %eax,(%esp)
 539:	e8 fa fe ff ff       	call   438 <write>
}
 53e:	c9                   	leave  
 53f:	c3                   	ret    

00000540 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 546:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 54d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 551:	74 17                	je     56a <printint+0x2a>
 553:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 557:	79 11                	jns    56a <printint+0x2a>
    neg = 1;
 559:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 560:	8b 45 0c             	mov    0xc(%ebp),%eax
 563:	f7 d8                	neg    %eax
 565:	89 45 ec             	mov    %eax,-0x14(%ebp)
 568:	eb 06                	jmp    570 <printint+0x30>
  } else {
    x = xx;
 56a:	8b 45 0c             	mov    0xc(%ebp),%eax
 56d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 570:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 577:	8b 4d 10             	mov    0x10(%ebp),%ecx
 57a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 57d:	ba 00 00 00 00       	mov    $0x0,%edx
 582:	f7 f1                	div    %ecx
 584:	89 d0                	mov    %edx,%eax
 586:	0f b6 90 34 0f 00 00 	movzbl 0xf34(%eax),%edx
 58d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 590:	03 45 f4             	add    -0xc(%ebp),%eax
 593:	88 10                	mov    %dl,(%eax)
 595:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 599:	8b 55 10             	mov    0x10(%ebp),%edx
 59c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 59f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a2:	ba 00 00 00 00       	mov    $0x0,%edx
 5a7:	f7 75 d4             	divl   -0x2c(%ebp)
 5aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b1:	75 c4                	jne    577 <printint+0x37>
  if(neg)
 5b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b7:	74 2a                	je     5e3 <printint+0xa3>
    buf[i++] = '-';
 5b9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5bc:	03 45 f4             	add    -0xc(%ebp),%eax
 5bf:	c6 00 2d             	movb   $0x2d,(%eax)
 5c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 5c6:	eb 1b                	jmp    5e3 <printint+0xa3>
    putc(fd, buf[i]);
 5c8:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5cb:	03 45 f4             	add    -0xc(%ebp),%eax
 5ce:	0f b6 00             	movzbl (%eax),%eax
 5d1:	0f be c0             	movsbl %al,%eax
 5d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
 5db:	89 04 24             	mov    %eax,(%esp)
 5de:	e8 35 ff ff ff       	call   518 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5e3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5eb:	79 db                	jns    5c8 <printint+0x88>
    putc(fd, buf[i]);
}
 5ed:	c9                   	leave  
 5ee:	c3                   	ret    

000005ef <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5ef:	55                   	push   %ebp
 5f0:	89 e5                	mov    %esp,%ebp
 5f2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5f5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5fc:	8d 45 0c             	lea    0xc(%ebp),%eax
 5ff:	83 c0 04             	add    $0x4,%eax
 602:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 605:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 60c:	e9 7d 01 00 00       	jmp    78e <printf+0x19f>
    c = fmt[i] & 0xff;
 611:	8b 55 0c             	mov    0xc(%ebp),%edx
 614:	8b 45 f0             	mov    -0x10(%ebp),%eax
 617:	01 d0                	add    %edx,%eax
 619:	0f b6 00             	movzbl (%eax),%eax
 61c:	0f be c0             	movsbl %al,%eax
 61f:	25 ff 00 00 00       	and    $0xff,%eax
 624:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 627:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 62b:	75 2c                	jne    659 <printf+0x6a>
      if(c == '%'){
 62d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 631:	75 0c                	jne    63f <printf+0x50>
        state = '%';
 633:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 63a:	e9 4b 01 00 00       	jmp    78a <printf+0x19b>
      } else {
        putc(fd, c);
 63f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 642:	0f be c0             	movsbl %al,%eax
 645:	89 44 24 04          	mov    %eax,0x4(%esp)
 649:	8b 45 08             	mov    0x8(%ebp),%eax
 64c:	89 04 24             	mov    %eax,(%esp)
 64f:	e8 c4 fe ff ff       	call   518 <putc>
 654:	e9 31 01 00 00       	jmp    78a <printf+0x19b>
      }
    } else if(state == '%'){
 659:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 65d:	0f 85 27 01 00 00    	jne    78a <printf+0x19b>
      if(c == 'd'){
 663:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 667:	75 2d                	jne    696 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 669:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66c:	8b 00                	mov    (%eax),%eax
 66e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 675:	00 
 676:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 67d:	00 
 67e:	89 44 24 04          	mov    %eax,0x4(%esp)
 682:	8b 45 08             	mov    0x8(%ebp),%eax
 685:	89 04 24             	mov    %eax,(%esp)
 688:	e8 b3 fe ff ff       	call   540 <printint>
        ap++;
 68d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 691:	e9 ed 00 00 00       	jmp    783 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 696:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 69a:	74 06                	je     6a2 <printf+0xb3>
 69c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6a0:	75 2d                	jne    6cf <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a5:	8b 00                	mov    (%eax),%eax
 6a7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6ae:	00 
 6af:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6b6:	00 
 6b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	89 04 24             	mov    %eax,(%esp)
 6c1:	e8 7a fe ff ff       	call   540 <printint>
        ap++;
 6c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6ca:	e9 b4 00 00 00       	jmp    783 <printf+0x194>
      } else if(c == 's'){
 6cf:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d3:	75 46                	jne    71b <printf+0x12c>
        s = (char*)*ap;
 6d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d8:	8b 00                	mov    (%eax),%eax
 6da:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e5:	75 27                	jne    70e <printf+0x11f>
          s = "(null)";
 6e7:	c7 45 f4 48 0b 00 00 	movl   $0xb48,-0xc(%ebp)
        while(*s != 0){
 6ee:	eb 1e                	jmp    70e <printf+0x11f>
          putc(fd, *s);
 6f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f3:	0f b6 00             	movzbl (%eax),%eax
 6f6:	0f be c0             	movsbl %al,%eax
 6f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6fd:	8b 45 08             	mov    0x8(%ebp),%eax
 700:	89 04 24             	mov    %eax,(%esp)
 703:	e8 10 fe ff ff       	call   518 <putc>
          s++;
 708:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 70c:	eb 01                	jmp    70f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 70e:	90                   	nop
 70f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 712:	0f b6 00             	movzbl (%eax),%eax
 715:	84 c0                	test   %al,%al
 717:	75 d7                	jne    6f0 <printf+0x101>
 719:	eb 68                	jmp    783 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 71f:	75 1d                	jne    73e <printf+0x14f>
        putc(fd, *ap);
 721:	8b 45 e8             	mov    -0x18(%ebp),%eax
 724:	8b 00                	mov    (%eax),%eax
 726:	0f be c0             	movsbl %al,%eax
 729:	89 44 24 04          	mov    %eax,0x4(%esp)
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
 730:	89 04 24             	mov    %eax,(%esp)
 733:	e8 e0 fd ff ff       	call   518 <putc>
        ap++;
 738:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73c:	eb 45                	jmp    783 <printf+0x194>
      } else if(c == '%'){
 73e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 742:	75 17                	jne    75b <printf+0x16c>
        putc(fd, c);
 744:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 747:	0f be c0             	movsbl %al,%eax
 74a:	89 44 24 04          	mov    %eax,0x4(%esp)
 74e:	8b 45 08             	mov    0x8(%ebp),%eax
 751:	89 04 24             	mov    %eax,(%esp)
 754:	e8 bf fd ff ff       	call   518 <putc>
 759:	eb 28                	jmp    783 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 75b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 762:	00 
 763:	8b 45 08             	mov    0x8(%ebp),%eax
 766:	89 04 24             	mov    %eax,(%esp)
 769:	e8 aa fd ff ff       	call   518 <putc>
        putc(fd, c);
 76e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 771:	0f be c0             	movsbl %al,%eax
 774:	89 44 24 04          	mov    %eax,0x4(%esp)
 778:	8b 45 08             	mov    0x8(%ebp),%eax
 77b:	89 04 24             	mov    %eax,(%esp)
 77e:	e8 95 fd ff ff       	call   518 <putc>
      }
      state = 0;
 783:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 78a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 78e:	8b 55 0c             	mov    0xc(%ebp),%edx
 791:	8b 45 f0             	mov    -0x10(%ebp),%eax
 794:	01 d0                	add    %edx,%eax
 796:	0f b6 00             	movzbl (%eax),%eax
 799:	84 c0                	test   %al,%al
 79b:	0f 85 70 fe ff ff    	jne    611 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a1:	c9                   	leave  
 7a2:	c3                   	ret    
 7a3:	90                   	nop

000007a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a4:	55                   	push   %ebp
 7a5:	89 e5                	mov    %esp,%ebp
 7a7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7aa:	8b 45 08             	mov    0x8(%ebp),%eax
 7ad:	83 e8 08             	sub    $0x8,%eax
 7b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	a1 50 0f 00 00       	mov    0xf50,%eax
 7b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7bb:	eb 24                	jmp    7e1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 00                	mov    (%eax),%eax
 7c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c5:	77 12                	ja     7d9 <free+0x35>
 7c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cd:	77 24                	ja     7f3 <free+0x4f>
 7cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d2:	8b 00                	mov    (%eax),%eax
 7d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d7:	77 1a                	ja     7f3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e7:	76 d4                	jbe    7bd <free+0x19>
 7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ec:	8b 00                	mov    (%eax),%eax
 7ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f1:	76 ca                	jbe    7bd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	c1 e0 03             	shl    $0x3,%eax
 7fc:	89 c2                	mov    %eax,%edx
 7fe:	03 55 f8             	add    -0x8(%ebp),%edx
 801:	8b 45 fc             	mov    -0x4(%ebp),%eax
 804:	8b 00                	mov    (%eax),%eax
 806:	39 c2                	cmp    %eax,%edx
 808:	75 24                	jne    82e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 80a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80d:	8b 50 04             	mov    0x4(%eax),%edx
 810:	8b 45 fc             	mov    -0x4(%ebp),%eax
 813:	8b 00                	mov    (%eax),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	01 c2                	add    %eax,%edx
 81a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 820:	8b 45 fc             	mov    -0x4(%ebp),%eax
 823:	8b 00                	mov    (%eax),%eax
 825:	8b 10                	mov    (%eax),%edx
 827:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82a:	89 10                	mov    %edx,(%eax)
 82c:	eb 0a                	jmp    838 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 82e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 831:	8b 10                	mov    (%eax),%edx
 833:	8b 45 f8             	mov    -0x8(%ebp),%eax
 836:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 838:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83b:	8b 40 04             	mov    0x4(%eax),%eax
 83e:	c1 e0 03             	shl    $0x3,%eax
 841:	03 45 fc             	add    -0x4(%ebp),%eax
 844:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 847:	75 20                	jne    869 <free+0xc5>
    p->s.size += bp->s.size;
 849:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84c:	8b 50 04             	mov    0x4(%eax),%edx
 84f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 852:	8b 40 04             	mov    0x4(%eax),%eax
 855:	01 c2                	add    %eax,%edx
 857:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 85d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 860:	8b 10                	mov    (%eax),%edx
 862:	8b 45 fc             	mov    -0x4(%ebp),%eax
 865:	89 10                	mov    %edx,(%eax)
 867:	eb 08                	jmp    871 <free+0xcd>
  } else
    p->s.ptr = bp;
 869:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 86f:	89 10                	mov    %edx,(%eax)
  freep = p;
 871:	8b 45 fc             	mov    -0x4(%ebp),%eax
 874:	a3 50 0f 00 00       	mov    %eax,0xf50
}
 879:	c9                   	leave  
 87a:	c3                   	ret    

0000087b <morecore>:

static Header*
morecore(uint nu)
{
 87b:	55                   	push   %ebp
 87c:	89 e5                	mov    %esp,%ebp
 87e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 881:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 888:	77 07                	ja     891 <morecore+0x16>
    nu = 4096;
 88a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 891:	8b 45 08             	mov    0x8(%ebp),%eax
 894:	c1 e0 03             	shl    $0x3,%eax
 897:	89 04 24             	mov    %eax,(%esp)
 89a:	e8 01 fc ff ff       	call   4a0 <sbrk>
 89f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8a2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8a6:	75 07                	jne    8af <morecore+0x34>
    return 0;
 8a8:	b8 00 00 00 00       	mov    $0x0,%eax
 8ad:	eb 22                	jmp    8d1 <morecore+0x56>
  hp = (Header*)p;
 8af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b8:	8b 55 08             	mov    0x8(%ebp),%edx
 8bb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c1:	83 c0 08             	add    $0x8,%eax
 8c4:	89 04 24             	mov    %eax,(%esp)
 8c7:	e8 d8 fe ff ff       	call   7a4 <free>
  return freep;
 8cc:	a1 50 0f 00 00       	mov    0xf50,%eax
}
 8d1:	c9                   	leave  
 8d2:	c3                   	ret    

000008d3 <malloc>:

void*
malloc(uint nbytes)
{
 8d3:	55                   	push   %ebp
 8d4:	89 e5                	mov    %esp,%ebp
 8d6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d9:	8b 45 08             	mov    0x8(%ebp),%eax
 8dc:	83 c0 07             	add    $0x7,%eax
 8df:	c1 e8 03             	shr    $0x3,%eax
 8e2:	83 c0 01             	add    $0x1,%eax
 8e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8e8:	a1 50 0f 00 00       	mov    0xf50,%eax
 8ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8f4:	75 23                	jne    919 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8f6:	c7 45 f0 48 0f 00 00 	movl   $0xf48,-0x10(%ebp)
 8fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 900:	a3 50 0f 00 00       	mov    %eax,0xf50
 905:	a1 50 0f 00 00       	mov    0xf50,%eax
 90a:	a3 48 0f 00 00       	mov    %eax,0xf48
    base.s.size = 0;
 90f:	c7 05 4c 0f 00 00 00 	movl   $0x0,0xf4c
 916:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 919:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91c:	8b 00                	mov    (%eax),%eax
 91e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 921:	8b 45 f4             	mov    -0xc(%ebp),%eax
 924:	8b 40 04             	mov    0x4(%eax),%eax
 927:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 92a:	72 4d                	jb     979 <malloc+0xa6>
      if(p->s.size == nunits)
 92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92f:	8b 40 04             	mov    0x4(%eax),%eax
 932:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 935:	75 0c                	jne    943 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 937:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93a:	8b 10                	mov    (%eax),%edx
 93c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93f:	89 10                	mov    %edx,(%eax)
 941:	eb 26                	jmp    969 <malloc+0x96>
      else {
        p->s.size -= nunits;
 943:	8b 45 f4             	mov    -0xc(%ebp),%eax
 946:	8b 40 04             	mov    0x4(%eax),%eax
 949:	89 c2                	mov    %eax,%edx
 94b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 94e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 951:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 954:	8b 45 f4             	mov    -0xc(%ebp),%eax
 957:	8b 40 04             	mov    0x4(%eax),%eax
 95a:	c1 e0 03             	shl    $0x3,%eax
 95d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 960:	8b 45 f4             	mov    -0xc(%ebp),%eax
 963:	8b 55 ec             	mov    -0x14(%ebp),%edx
 966:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 969:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96c:	a3 50 0f 00 00       	mov    %eax,0xf50
      return (void*)(p + 1);
 971:	8b 45 f4             	mov    -0xc(%ebp),%eax
 974:	83 c0 08             	add    $0x8,%eax
 977:	eb 38                	jmp    9b1 <malloc+0xde>
    }
    if(p == freep)
 979:	a1 50 0f 00 00       	mov    0xf50,%eax
 97e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 981:	75 1b                	jne    99e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 983:	8b 45 ec             	mov    -0x14(%ebp),%eax
 986:	89 04 24             	mov    %eax,(%esp)
 989:	e8 ed fe ff ff       	call   87b <morecore>
 98e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 991:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 995:	75 07                	jne    99e <malloc+0xcb>
        return 0;
 997:	b8 00 00 00 00       	mov    $0x0,%eax
 99c:	eb 13                	jmp    9b1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a7:	8b 00                	mov    (%eax),%eax
 9a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9ac:	e9 70 ff ff ff       	jmp    921 <malloc+0x4e>
}
 9b1:	c9                   	leave  
 9b2:	c3                   	ret    
 9b3:	90                   	nop

000009b4 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 9b4:	55                   	push   %ebp
 9b5:	89 e5                	mov    %esp,%ebp
 9b7:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 9ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 9bd:	89 04 24             	mov    %eax,(%esp)
 9c0:	8b 45 08             	mov    0x8(%ebp),%eax
 9c3:	ff d0                	call   *%eax
    exit();
 9c5:	e8 4e fa ff ff       	call   418 <exit>

000009ca <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 9ca:	55                   	push   %ebp
 9cb:	89 e5                	mov    %esp,%ebp
 9cd:	57                   	push   %edi
 9ce:	56                   	push   %esi
 9cf:	53                   	push   %ebx
 9d0:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 9d3:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 9da:	e8 f4 fe ff ff       	call   8d3 <malloc>
 9df:	89 c2                	mov    %eax,%edx
 9e1:	8b 45 08             	mov    0x8(%ebp),%eax
 9e4:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 9e6:	8b 45 10             	mov    0x10(%ebp),%eax
 9e9:	8b 38                	mov    (%eax),%edi
 9eb:	8b 75 0c             	mov    0xc(%ebp),%esi
 9ee:	bb b4 09 00 00       	mov    $0x9b4,%ebx
 9f3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9fa:	e8 d4 fe ff ff       	call   8d3 <malloc>
 9ff:	05 00 10 00 00       	add    $0x1000,%eax
 a04:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 a08:	89 74 24 08          	mov    %esi,0x8(%esp)
 a0c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 a10:	89 04 24             	mov    %eax,(%esp)
 a13:	e8 a0 fa ff ff       	call   4b8 <kthread_create>
 a18:	8b 55 08             	mov    0x8(%ebp),%edx
 a1b:	89 02                	mov    %eax,(%edx)
    return *thread;
 a1d:	8b 45 08             	mov    0x8(%ebp),%eax
 a20:	8b 00                	mov    (%eax),%eax
}
 a22:	83 c4 1c             	add    $0x1c,%esp
 a25:	5b                   	pop    %ebx
 a26:	5e                   	pop    %esi
 a27:	5f                   	pop    %edi
 a28:	5d                   	pop    %ebp
 a29:	c3                   	ret    

00000a2a <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 a2a:	55                   	push   %ebp
 a2b:	89 e5                	mov    %esp,%ebp
 a2d:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 a30:	8b 45 0c             	mov    0xc(%ebp),%eax
 a33:	89 44 24 04          	mov    %eax,0x4(%esp)
 a37:	8b 45 08             	mov    0x8(%ebp),%eax
 a3a:	89 04 24             	mov    %eax,(%esp)
 a3d:	e8 7e fa ff ff       	call   4c0 <kthread_join>
 a42:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 a48:	c9                   	leave  
 a49:	c3                   	ret    

00000a4a <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 a4a:	55                   	push   %ebp
 a4b:	89 e5                	mov    %esp,%ebp
 a4d:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 a50:	e8 73 fa ff ff       	call   4c8 <kthread_mutex_init>
 a55:	8b 55 08             	mov    0x8(%ebp),%edx
 a58:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a5a:	8b 45 08             	mov    0x8(%ebp),%eax
 a5d:	8b 00                	mov    (%eax),%eax
 a5f:	85 c0                	test   %eax,%eax
 a61:	7e 07                	jle    a6a <qthread_mutex_init+0x20>
		return 0;
 a63:	b8 00 00 00 00       	mov    $0x0,%eax
 a68:	eb 05                	jmp    a6f <qthread_mutex_init+0x25>
	}
	return *mutex;
 a6a:	8b 45 08             	mov    0x8(%ebp),%eax
 a6d:	8b 00                	mov    (%eax),%eax
}
 a6f:	c9                   	leave  
 a70:	c3                   	ret    

00000a71 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 a71:	55                   	push   %ebp
 a72:	89 e5                	mov    %esp,%ebp
 a74:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 a77:	8b 45 08             	mov    0x8(%ebp),%eax
 a7a:	89 04 24             	mov    %eax,(%esp)
 a7d:	e8 4e fa ff ff       	call   4d0 <kthread_mutex_destroy>
 a82:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a89:	79 07                	jns    a92 <qthread_mutex_destroy+0x21>
    	return -1;
 a8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a90:	eb 05                	jmp    a97 <qthread_mutex_destroy+0x26>
    }
    return 0;
 a92:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a97:	c9                   	leave  
 a98:	c3                   	ret    

00000a99 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 a99:	55                   	push   %ebp
 a9a:	89 e5                	mov    %esp,%ebp
 a9c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 a9f:	8b 45 08             	mov    0x8(%ebp),%eax
 aa2:	89 04 24             	mov    %eax,(%esp)
 aa5:	e8 2e fa ff ff       	call   4d8 <kthread_mutex_lock>
 aaa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 aad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ab1:	79 07                	jns    aba <qthread_mutex_lock+0x21>
    	return -1;
 ab3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ab8:	eb 05                	jmp    abf <qthread_mutex_lock+0x26>
    }
    return 0;
 aba:	b8 00 00 00 00       	mov    $0x0,%eax
}
 abf:	c9                   	leave  
 ac0:	c3                   	ret    

00000ac1 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 ac1:	55                   	push   %ebp
 ac2:	89 e5                	mov    %esp,%ebp
 ac4:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 ac7:	8b 45 08             	mov    0x8(%ebp),%eax
 aca:	89 04 24             	mov    %eax,(%esp)
 acd:	e8 0e fa ff ff       	call   4e0 <kthread_mutex_unlock>
 ad2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 ad5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ad9:	79 07                	jns    ae2 <qthread_mutex_unlock+0x21>
    	return -1;
 adb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ae0:	eb 05                	jmp    ae7 <qthread_mutex_unlock+0x26>
    }
    return 0;
 ae2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ae7:	c9                   	leave  
 ae8:	c3                   	ret    

00000ae9 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 ae9:	55                   	push   %ebp
 aea:	89 e5                	mov    %esp,%ebp

	return 0;
 aec:	b8 00 00 00 00       	mov    $0x0,%eax
}
 af1:	5d                   	pop    %ebp
 af2:	c3                   	ret    

00000af3 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 af3:	55                   	push   %ebp
 af4:	89 e5                	mov    %esp,%ebp
    
    return 0;
 af6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 afb:	5d                   	pop    %ebp
 afc:	c3                   	ret    

00000afd <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 afd:	55                   	push   %ebp
 afe:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b00:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b05:	5d                   	pop    %ebp
 b06:	c3                   	ret    

00000b07 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 b07:	55                   	push   %ebp
 b08:	89 e5                	mov    %esp,%ebp
	return 0;
 b0a:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b0f:	5d                   	pop    %ebp
 b10:	c3                   	ret    

00000b11 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 b11:	55                   	push   %ebp
 b12:	89 e5                	mov    %esp,%ebp
	return 0;
 b14:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b19:	5d                   	pop    %ebp
 b1a:	c3                   	ret    

00000b1b <qthread_exit>:

int qthread_exit(){
 b1b:	55                   	push   %ebp
 b1c:	89 e5                	mov    %esp,%ebp
	return 0;
 b1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b23:	5d                   	pop    %ebp
 b24:	c3                   	ret    
