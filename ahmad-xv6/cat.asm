
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 1b                	jmp    23 <cat+0x23>
    write(1, buf, n);
   8:	8b 45 f4             	mov    -0xc(%ebp),%eax
   b:	89 44 24 08          	mov    %eax,0x8(%esp)
   f:	c7 44 24 04 00 0f 00 	movl   $0xf00,0x4(%esp)
  16:	00 
  17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1e:	e8 71 03 00 00       	call   394 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 00 0f 00 	movl   $0xf00,0x4(%esp)
  32:	00 
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 4e 03 00 00       	call   38c <read>
  3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  45:	7f c1                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
  4d:	c7 44 24 04 81 0a 00 	movl   $0xa81,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 ea 04 00 00       	call   54b <printf>
    exit();
  61:	e8 0e 03 00 00       	call   374 <exit>
  }
}
  66:	c9                   	leave  
  67:	c3                   	ret    

00000068 <main>:

int
main(int argc, char *argv[])
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	83 e4 f0             	and    $0xfffffff0,%esp
  6e:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
  71:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  75:	7f 11                	jg     88 <main+0x20>
    cat(0);
  77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7e:	e8 7d ff ff ff       	call   0 <cat>
    exit();
  83:	e8 ec 02 00 00       	call   374 <exit>
  }

  for(i = 1; i < argc; i++){
  88:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  8f:	00 
  90:	eb 6d                	jmp    ff <main+0x97>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  96:	c1 e0 02             	shl    $0x2,%eax
  99:	03 45 0c             	add    0xc(%ebp),%eax
  9c:	8b 00                	mov    (%eax),%eax
  9e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  a5:	00 
  a6:	89 04 24             	mov    %eax,(%esp)
  a9:	e8 06 03 00 00       	call   3b4 <open>
  ae:	89 44 24 18          	mov    %eax,0x18(%esp)
  b2:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  b7:	79 29                	jns    e2 <main+0x7a>
      printf(1, "cat: cannot open %s\n", argv[i]);
  b9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  bd:	c1 e0 02             	shl    $0x2,%eax
  c0:	03 45 0c             	add    0xc(%ebp),%eax
  c3:	8b 00                	mov    (%eax),%eax
  c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  c9:	c7 44 24 04 92 0a 00 	movl   $0xa92,0x4(%esp)
  d0:	00 
  d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d8:	e8 6e 04 00 00       	call   54b <printf>
      exit();
  dd:	e8 92 02 00 00       	call   374 <exit>
    }
    cat(fd);
  e2:	8b 44 24 18          	mov    0x18(%esp),%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 12 ff ff ff       	call   0 <cat>
    close(fd);
  ee:	8b 44 24 18          	mov    0x18(%esp),%eax
  f2:	89 04 24             	mov    %eax,(%esp)
  f5:	e8 a2 02 00 00       	call   39c <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  fa:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  ff:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 103:	3b 45 08             	cmp    0x8(%ebp),%eax
 106:	7c 8a                	jl     92 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 108:	e8 67 02 00 00       	call   374 <exit>
 10d:	90                   	nop
 10e:	90                   	nop
 10f:	90                   	nop

00000110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 115:	8b 4d 08             	mov    0x8(%ebp),%ecx
 118:	8b 55 10             	mov    0x10(%ebp),%edx
 11b:	8b 45 0c             	mov    0xc(%ebp),%eax
 11e:	89 cb                	mov    %ecx,%ebx
 120:	89 df                	mov    %ebx,%edi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld    
 125:	f3 aa                	rep stos %al,%es:(%edi)
 127:	89 ca                	mov    %ecx,%edx
 129:	89 fb                	mov    %edi,%ebx
 12b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 131:	5b                   	pop    %ebx
 132:	5f                   	pop    %edi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 141:	90                   	nop
 142:	8b 45 0c             	mov    0xc(%ebp),%eax
 145:	0f b6 10             	movzbl (%eax),%edx
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	88 10                	mov    %dl,(%eax)
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	0f b6 00             	movzbl (%eax),%eax
 153:	84 c0                	test   %al,%al
 155:	0f 95 c0             	setne  %al
 158:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 160:	84 c0                	test   %al,%al
 162:	75 de                	jne    142 <strcpy+0xd>
    ;
  return os;
 164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 167:	c9                   	leave  
 168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	84 c0                	test   %al,%al
 17e:	74 10                	je     190 <strcmp+0x27>
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	38 c2                	cmp    %al,%dl
 18e:	74 de                	je     16e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 d0             	movzbl %al,%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	89 d1                	mov    %edx,%ecx
 1a4:	29 c1                	sub    %eax,%ecx
 1a6:	89 c8                	mov    %ecx,%eax
}
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    

000001aa <strlen>:

uint
strlen(char *s)
{
 1aa:	55                   	push   %ebp
 1ab:	89 e5                	mov    %esp,%ebp
 1ad:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b7:	eb 04                	jmp    1bd <strlen+0x13>
 1b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1c0:	03 45 08             	add    0x8(%ebp),%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 ef                	jne    1b9 <strlen+0xf>
    ;
  return n;
 1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1d5:	8b 45 10             	mov    0x10(%ebp),%eax
 1d8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1df:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	89 04 24             	mov    %eax,(%esp)
 1e9:	e8 22 ff ff ff       	call   110 <stosb>
  return dst;
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f1:	c9                   	leave  
 1f2:	c3                   	ret    

000001f3 <strchr>:

char*
strchr(const char *s, char c)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 04             	sub    $0x4,%esp
 1f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ff:	eb 14                	jmp    215 <strchr+0x22>
    if(*s == c)
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	3a 45 fc             	cmp    -0x4(%ebp),%al
 20a:	75 05                	jne    211 <strchr+0x1e>
      return (char*)s;
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	eb 13                	jmp    224 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	84 c0                	test   %al,%al
 21d:	75 e2                	jne    201 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <gets>:

char*
gets(char *buf, int max)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 233:	eb 44                	jmp    279 <gets+0x53>
    cc = read(0, &c, 1);
 235:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 23c:	00 
 23d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 240:	89 44 24 04          	mov    %eax,0x4(%esp)
 244:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 24b:	e8 3c 01 00 00       	call   38c <read>
 250:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 253:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 257:	7e 2d                	jle    286 <gets+0x60>
      break;
    buf[i++] = c;
 259:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25c:	03 45 08             	add    0x8(%ebp),%eax
 25f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 263:	88 10                	mov    %dl,(%eax)
 265:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 269:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26d:	3c 0a                	cmp    $0xa,%al
 26f:	74 16                	je     287 <gets+0x61>
 271:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 275:	3c 0d                	cmp    $0xd,%al
 277:	74 0e                	je     287 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 279:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 282:	7c b1                	jl     235 <gets+0xf>
 284:	eb 01                	jmp    287 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 286:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 287:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28a:	03 45 08             	add    0x8(%ebp),%eax
 28d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 290:	8b 45 08             	mov    0x8(%ebp),%eax
}
 293:	c9                   	leave  
 294:	c3                   	ret    

00000295 <stat>:

int
stat(char *n, struct stat *st)
{
 295:	55                   	push   %ebp
 296:	89 e5                	mov    %esp,%ebp
 298:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a2:	00 
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	89 04 24             	mov    %eax,(%esp)
 2a9:	e8 06 01 00 00       	call   3b4 <open>
 2ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b5:	79 07                	jns    2be <stat+0x29>
    return -1;
 2b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bc:	eb 23                	jmp    2e1 <stat+0x4c>
  r = fstat(fd, st);
 2be:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c8:	89 04 24             	mov    %eax,(%esp)
 2cb:	e8 fc 00 00 00       	call   3cc <fstat>
 2d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d6:	89 04 24             	mov    %eax,(%esp)
 2d9:	e8 be 00 00 00       	call   39c <close>
  return r;
 2de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e1:	c9                   	leave  
 2e2:	c3                   	ret    

000002e3 <atoi>:

int
atoi(const char *s)
{
 2e3:	55                   	push   %ebp
 2e4:	89 e5                	mov    %esp,%ebp
 2e6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f0:	eb 23                	jmp    315 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f5:	89 d0                	mov    %edx,%eax
 2f7:	c1 e0 02             	shl    $0x2,%eax
 2fa:	01 d0                	add    %edx,%eax
 2fc:	01 c0                	add    %eax,%eax
 2fe:	89 c2                	mov    %eax,%edx
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	0f b6 00             	movzbl (%eax),%eax
 306:	0f be c0             	movsbl %al,%eax
 309:	01 d0                	add    %edx,%eax
 30b:	83 e8 30             	sub    $0x30,%eax
 30e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 311:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 315:	8b 45 08             	mov    0x8(%ebp),%eax
 318:	0f b6 00             	movzbl (%eax),%eax
 31b:	3c 2f                	cmp    $0x2f,%al
 31d:	7e 0a                	jle    329 <atoi+0x46>
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	0f b6 00             	movzbl (%eax),%eax
 325:	3c 39                	cmp    $0x39,%al
 327:	7e c9                	jle    2f2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 329:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 32c:	c9                   	leave  
 32d:	c3                   	ret    

0000032e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 32e:	55                   	push   %ebp
 32f:	89 e5                	mov    %esp,%ebp
 331:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 340:	eb 13                	jmp    355 <memmove+0x27>
    *dst++ = *src++;
 342:	8b 45 f8             	mov    -0x8(%ebp),%eax
 345:	0f b6 10             	movzbl (%eax),%edx
 348:	8b 45 fc             	mov    -0x4(%ebp),%eax
 34b:	88 10                	mov    %dl,(%eax)
 34d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 351:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 355:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 359:	0f 9f c0             	setg   %al
 35c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 360:	84 c0                	test   %al,%al
 362:	75 de                	jne    342 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 364:	8b 45 08             	mov    0x8(%ebp),%eax
}
 367:	c9                   	leave  
 368:	c3                   	ret    
 369:	90                   	nop
 36a:	90                   	nop
 36b:	90                   	nop

0000036c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36c:	b8 01 00 00 00       	mov    $0x1,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <exit>:
SYSCALL(exit)
 374:	b8 02 00 00 00       	mov    $0x2,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <wait>:
SYSCALL(wait)
 37c:	b8 03 00 00 00       	mov    $0x3,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <pipe>:
SYSCALL(pipe)
 384:	b8 04 00 00 00       	mov    $0x4,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <read>:
SYSCALL(read)
 38c:	b8 05 00 00 00       	mov    $0x5,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <write>:
SYSCALL(write)
 394:	b8 10 00 00 00       	mov    $0x10,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <close>:
SYSCALL(close)
 39c:	b8 15 00 00 00       	mov    $0x15,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <kill>:
SYSCALL(kill)
 3a4:	b8 06 00 00 00       	mov    $0x6,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <exec>:
SYSCALL(exec)
 3ac:	b8 07 00 00 00       	mov    $0x7,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <open>:
SYSCALL(open)
 3b4:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <mknod>:
SYSCALL(mknod)
 3bc:	b8 11 00 00 00       	mov    $0x11,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <unlink>:
SYSCALL(unlink)
 3c4:	b8 12 00 00 00       	mov    $0x12,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <fstat>:
SYSCALL(fstat)
 3cc:	b8 08 00 00 00       	mov    $0x8,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <link>:
SYSCALL(link)
 3d4:	b8 13 00 00 00       	mov    $0x13,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <mkdir>:
SYSCALL(mkdir)
 3dc:	b8 14 00 00 00       	mov    $0x14,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <chdir>:
SYSCALL(chdir)
 3e4:	b8 09 00 00 00       	mov    $0x9,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <dup>:
SYSCALL(dup)
 3ec:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <getpid>:
SYSCALL(getpid)
 3f4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <sbrk>:
SYSCALL(sbrk)
 3fc:	b8 0c 00 00 00       	mov    $0xc,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <sleep>:
SYSCALL(sleep)
 404:	b8 0d 00 00 00       	mov    $0xd,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <uptime>:
SYSCALL(uptime)
 40c:	b8 0e 00 00 00       	mov    $0xe,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <kthread_create>:
SYSCALL(kthread_create)
 414:	b8 17 00 00 00       	mov    $0x17,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <kthread_join>:
SYSCALL(kthread_join)
 41c:	b8 16 00 00 00       	mov    $0x16,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 424:	b8 18 00 00 00       	mov    $0x18,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 42c:	b8 19 00 00 00       	mov    $0x19,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 434:	b8 1a 00 00 00       	mov    $0x1a,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 43c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 444:	b8 1c 00 00 00       	mov    $0x1c,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 44c:	b8 1d 00 00 00       	mov    $0x1d,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 454:	b8 1e 00 00 00       	mov    $0x1e,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 45c:	b8 1f 00 00 00       	mov    $0x1f,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 464:	b8 20 00 00 00       	mov    $0x20,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <kthread_exit>:
 46c:	b8 21 00 00 00       	mov    $0x21,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	83 ec 28             	sub    $0x28,%esp
 47a:	8b 45 0c             	mov    0xc(%ebp),%eax
 47d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 480:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 487:	00 
 488:	8d 45 f4             	lea    -0xc(%ebp),%eax
 48b:	89 44 24 04          	mov    %eax,0x4(%esp)
 48f:	8b 45 08             	mov    0x8(%ebp),%eax
 492:	89 04 24             	mov    %eax,(%esp)
 495:	e8 fa fe ff ff       	call   394 <write>
}
 49a:	c9                   	leave  
 49b:	c3                   	ret    

0000049c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49c:	55                   	push   %ebp
 49d:	89 e5                	mov    %esp,%ebp
 49f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4a9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4ad:	74 17                	je     4c6 <printint+0x2a>
 4af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4b3:	79 11                	jns    4c6 <printint+0x2a>
    neg = 1;
 4b5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bf:	f7 d8                	neg    %eax
 4c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c4:	eb 06                	jmp    4cc <printint+0x30>
  } else {
    x = xx;
 4c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d9:	ba 00 00 00 00       	mov    $0x0,%edx
 4de:	f7 f1                	div    %ecx
 4e0:	89 d0                	mov    %edx,%eax
 4e2:	0f b6 90 b4 0e 00 00 	movzbl 0xeb4(%eax),%edx
 4e9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4ec:	03 45 f4             	add    -0xc(%ebp),%eax
 4ef:	88 10                	mov    %dl,(%eax)
 4f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 4f5:	8b 55 10             	mov    0x10(%ebp),%edx
 4f8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4fe:	ba 00 00 00 00       	mov    $0x0,%edx
 503:	f7 75 d4             	divl   -0x2c(%ebp)
 506:	89 45 ec             	mov    %eax,-0x14(%ebp)
 509:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50d:	75 c4                	jne    4d3 <printint+0x37>
  if(neg)
 50f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 513:	74 2a                	je     53f <printint+0xa3>
    buf[i++] = '-';
 515:	8d 45 dc             	lea    -0x24(%ebp),%eax
 518:	03 45 f4             	add    -0xc(%ebp),%eax
 51b:	c6 00 2d             	movb   $0x2d,(%eax)
 51e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 522:	eb 1b                	jmp    53f <printint+0xa3>
    putc(fd, buf[i]);
 524:	8d 45 dc             	lea    -0x24(%ebp),%eax
 527:	03 45 f4             	add    -0xc(%ebp),%eax
 52a:	0f b6 00             	movzbl (%eax),%eax
 52d:	0f be c0             	movsbl %al,%eax
 530:	89 44 24 04          	mov    %eax,0x4(%esp)
 534:	8b 45 08             	mov    0x8(%ebp),%eax
 537:	89 04 24             	mov    %eax,(%esp)
 53a:	e8 35 ff ff ff       	call   474 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 543:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 547:	79 db                	jns    524 <printint+0x88>
    putc(fd, buf[i]);
}
 549:	c9                   	leave  
 54a:	c3                   	ret    

0000054b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 54b:	55                   	push   %ebp
 54c:	89 e5                	mov    %esp,%ebp
 54e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 551:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 558:	8d 45 0c             	lea    0xc(%ebp),%eax
 55b:	83 c0 04             	add    $0x4,%eax
 55e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 561:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 568:	e9 7d 01 00 00       	jmp    6ea <printf+0x19f>
    c = fmt[i] & 0xff;
 56d:	8b 55 0c             	mov    0xc(%ebp),%edx
 570:	8b 45 f0             	mov    -0x10(%ebp),%eax
 573:	01 d0                	add    %edx,%eax
 575:	0f b6 00             	movzbl (%eax),%eax
 578:	0f be c0             	movsbl %al,%eax
 57b:	25 ff 00 00 00       	and    $0xff,%eax
 580:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 583:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 587:	75 2c                	jne    5b5 <printf+0x6a>
      if(c == '%'){
 589:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 58d:	75 0c                	jne    59b <printf+0x50>
        state = '%';
 58f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 596:	e9 4b 01 00 00       	jmp    6e6 <printf+0x19b>
      } else {
        putc(fd, c);
 59b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59e:	0f be c0             	movsbl %al,%eax
 5a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	89 04 24             	mov    %eax,(%esp)
 5ab:	e8 c4 fe ff ff       	call   474 <putc>
 5b0:	e9 31 01 00 00       	jmp    6e6 <printf+0x19b>
      }
    } else if(state == '%'){
 5b5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5b9:	0f 85 27 01 00 00    	jne    6e6 <printf+0x19b>
      if(c == 'd'){
 5bf:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5c3:	75 2d                	jne    5f2 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c8:	8b 00                	mov    (%eax),%eax
 5ca:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5d1:	00 
 5d2:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5d9:	00 
 5da:	89 44 24 04          	mov    %eax,0x4(%esp)
 5de:	8b 45 08             	mov    0x8(%ebp),%eax
 5e1:	89 04 24             	mov    %eax,(%esp)
 5e4:	e8 b3 fe ff ff       	call   49c <printint>
        ap++;
 5e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ed:	e9 ed 00 00 00       	jmp    6df <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 5f2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5f6:	74 06                	je     5fe <printf+0xb3>
 5f8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5fc:	75 2d                	jne    62b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
 601:	8b 00                	mov    (%eax),%eax
 603:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 60a:	00 
 60b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 612:	00 
 613:	89 44 24 04          	mov    %eax,0x4(%esp)
 617:	8b 45 08             	mov    0x8(%ebp),%eax
 61a:	89 04 24             	mov    %eax,(%esp)
 61d:	e8 7a fe ff ff       	call   49c <printint>
        ap++;
 622:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 626:	e9 b4 00 00 00       	jmp    6df <printf+0x194>
      } else if(c == 's'){
 62b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 62f:	75 46                	jne    677 <printf+0x12c>
        s = (char*)*ap;
 631:	8b 45 e8             	mov    -0x18(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 639:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 63d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 641:	75 27                	jne    66a <printf+0x11f>
          s = "(null)";
 643:	c7 45 f4 a7 0a 00 00 	movl   $0xaa7,-0xc(%ebp)
        while(*s != 0){
 64a:	eb 1e                	jmp    66a <printf+0x11f>
          putc(fd, *s);
 64c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 64f:	0f b6 00             	movzbl (%eax),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	89 44 24 04          	mov    %eax,0x4(%esp)
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	89 04 24             	mov    %eax,(%esp)
 65f:	e8 10 fe ff ff       	call   474 <putc>
          s++;
 664:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 668:	eb 01                	jmp    66b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 66a:	90                   	nop
 66b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66e:	0f b6 00             	movzbl (%eax),%eax
 671:	84 c0                	test   %al,%al
 673:	75 d7                	jne    64c <printf+0x101>
 675:	eb 68                	jmp    6df <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 677:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 67b:	75 1d                	jne    69a <printf+0x14f>
        putc(fd, *ap);
 67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	0f be c0             	movsbl %al,%eax
 685:	89 44 24 04          	mov    %eax,0x4(%esp)
 689:	8b 45 08             	mov    0x8(%ebp),%eax
 68c:	89 04 24             	mov    %eax,(%esp)
 68f:	e8 e0 fd ff ff       	call   474 <putc>
        ap++;
 694:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 698:	eb 45                	jmp    6df <printf+0x194>
      } else if(c == '%'){
 69a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 69e:	75 17                	jne    6b7 <printf+0x16c>
        putc(fd, c);
 6a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a3:	0f be c0             	movsbl %al,%eax
 6a6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6aa:	8b 45 08             	mov    0x8(%ebp),%eax
 6ad:	89 04 24             	mov    %eax,(%esp)
 6b0:	e8 bf fd ff ff       	call   474 <putc>
 6b5:	eb 28                	jmp    6df <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b7:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6be:	00 
 6bf:	8b 45 08             	mov    0x8(%ebp),%eax
 6c2:	89 04 24             	mov    %eax,(%esp)
 6c5:	e8 aa fd ff ff       	call   474 <putc>
        putc(fd, c);
 6ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6cd:	0f be c0             	movsbl %al,%eax
 6d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d4:	8b 45 08             	mov    0x8(%ebp),%eax
 6d7:	89 04 24             	mov    %eax,(%esp)
 6da:	e8 95 fd ff ff       	call   474 <putc>
      }
      state = 0;
 6df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ea:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f0:	01 d0                	add    %edx,%eax
 6f2:	0f b6 00             	movzbl (%eax),%eax
 6f5:	84 c0                	test   %al,%al
 6f7:	0f 85 70 fe ff ff    	jne    56d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6fd:	c9                   	leave  
 6fe:	c3                   	ret    
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 706:	8b 45 08             	mov    0x8(%ebp),%eax
 709:	83 e8 08             	sub    $0x8,%eax
 70c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70f:	a1 e8 0e 00 00       	mov    0xee8,%eax
 714:	89 45 fc             	mov    %eax,-0x4(%ebp)
 717:	eb 24                	jmp    73d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 00                	mov    (%eax),%eax
 71e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 721:	77 12                	ja     735 <free+0x35>
 723:	8b 45 f8             	mov    -0x8(%ebp),%eax
 726:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 729:	77 24                	ja     74f <free+0x4f>
 72b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72e:	8b 00                	mov    (%eax),%eax
 730:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 733:	77 1a                	ja     74f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 735:	8b 45 fc             	mov    -0x4(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 73d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 740:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 743:	76 d4                	jbe    719 <free+0x19>
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	8b 00                	mov    (%eax),%eax
 74a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 74d:	76 ca                	jbe    719 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 74f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 752:	8b 40 04             	mov    0x4(%eax),%eax
 755:	c1 e0 03             	shl    $0x3,%eax
 758:	89 c2                	mov    %eax,%edx
 75a:	03 55 f8             	add    -0x8(%ebp),%edx
 75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 760:	8b 00                	mov    (%eax),%eax
 762:	39 c2                	cmp    %eax,%edx
 764:	75 24                	jne    78a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 766:	8b 45 f8             	mov    -0x8(%ebp),%eax
 769:	8b 50 04             	mov    0x4(%eax),%edx
 76c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76f:	8b 00                	mov    (%eax),%eax
 771:	8b 40 04             	mov    0x4(%eax),%eax
 774:	01 c2                	add    %eax,%edx
 776:	8b 45 f8             	mov    -0x8(%ebp),%eax
 779:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 77c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77f:	8b 00                	mov    (%eax),%eax
 781:	8b 10                	mov    (%eax),%edx
 783:	8b 45 f8             	mov    -0x8(%ebp),%eax
 786:	89 10                	mov    %edx,(%eax)
 788:	eb 0a                	jmp    794 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 78a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78d:	8b 10                	mov    (%eax),%edx
 78f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 792:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 794:	8b 45 fc             	mov    -0x4(%ebp),%eax
 797:	8b 40 04             	mov    0x4(%eax),%eax
 79a:	c1 e0 03             	shl    $0x3,%eax
 79d:	03 45 fc             	add    -0x4(%ebp),%eax
 7a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a3:	75 20                	jne    7c5 <free+0xc5>
    p->s.size += bp->s.size;
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	8b 50 04             	mov    0x4(%eax),%edx
 7ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ae:	8b 40 04             	mov    0x4(%eax),%eax
 7b1:	01 c2                	add    %eax,%edx
 7b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bc:	8b 10                	mov    (%eax),%edx
 7be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c1:	89 10                	mov    %edx,(%eax)
 7c3:	eb 08                	jmp    7cd <free+0xcd>
  } else
    p->s.ptr = bp;
 7c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7cb:	89 10                	mov    %edx,(%eax)
  freep = p;
 7cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d0:	a3 e8 0e 00 00       	mov    %eax,0xee8
}
 7d5:	c9                   	leave  
 7d6:	c3                   	ret    

000007d7 <morecore>:

static Header*
morecore(uint nu)
{
 7d7:	55                   	push   %ebp
 7d8:	89 e5                	mov    %esp,%ebp
 7da:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7dd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e4:	77 07                	ja     7ed <morecore+0x16>
    nu = 4096;
 7e6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7ed:	8b 45 08             	mov    0x8(%ebp),%eax
 7f0:	c1 e0 03             	shl    $0x3,%eax
 7f3:	89 04 24             	mov    %eax,(%esp)
 7f6:	e8 01 fc ff ff       	call   3fc <sbrk>
 7fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7fe:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 802:	75 07                	jne    80b <morecore+0x34>
    return 0;
 804:	b8 00 00 00 00       	mov    $0x0,%eax
 809:	eb 22                	jmp    82d <morecore+0x56>
  hp = (Header*)p;
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 811:	8b 45 f0             	mov    -0x10(%ebp),%eax
 814:	8b 55 08             	mov    0x8(%ebp),%edx
 817:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 81a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81d:	83 c0 08             	add    $0x8,%eax
 820:	89 04 24             	mov    %eax,(%esp)
 823:	e8 d8 fe ff ff       	call   700 <free>
  return freep;
 828:	a1 e8 0e 00 00       	mov    0xee8,%eax
}
 82d:	c9                   	leave  
 82e:	c3                   	ret    

0000082f <malloc>:

void*
malloc(uint nbytes)
{
 82f:	55                   	push   %ebp
 830:	89 e5                	mov    %esp,%ebp
 832:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 835:	8b 45 08             	mov    0x8(%ebp),%eax
 838:	83 c0 07             	add    $0x7,%eax
 83b:	c1 e8 03             	shr    $0x3,%eax
 83e:	83 c0 01             	add    $0x1,%eax
 841:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 844:	a1 e8 0e 00 00       	mov    0xee8,%eax
 849:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 850:	75 23                	jne    875 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 852:	c7 45 f0 e0 0e 00 00 	movl   $0xee0,-0x10(%ebp)
 859:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85c:	a3 e8 0e 00 00       	mov    %eax,0xee8
 861:	a1 e8 0e 00 00       	mov    0xee8,%eax
 866:	a3 e0 0e 00 00       	mov    %eax,0xee0
    base.s.size = 0;
 86b:	c7 05 e4 0e 00 00 00 	movl   $0x0,0xee4
 872:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 875:	8b 45 f0             	mov    -0x10(%ebp),%eax
 878:	8b 00                	mov    (%eax),%eax
 87a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 880:	8b 40 04             	mov    0x4(%eax),%eax
 883:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 886:	72 4d                	jb     8d5 <malloc+0xa6>
      if(p->s.size == nunits)
 888:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88b:	8b 40 04             	mov    0x4(%eax),%eax
 88e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 891:	75 0c                	jne    89f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 893:	8b 45 f4             	mov    -0xc(%ebp),%eax
 896:	8b 10                	mov    (%eax),%edx
 898:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89b:	89 10                	mov    %edx,(%eax)
 89d:	eb 26                	jmp    8c5 <malloc+0x96>
      else {
        p->s.size -= nunits;
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	8b 40 04             	mov    0x4(%eax),%eax
 8a5:	89 c2                	mov    %eax,%edx
 8a7:	2b 55 ec             	sub    -0x14(%ebp),%edx
 8aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ad:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b3:	8b 40 04             	mov    0x4(%eax),%eax
 8b6:	c1 e0 03             	shl    $0x3,%eax
 8b9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bf:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c8:	a3 e8 0e 00 00       	mov    %eax,0xee8
      return (void*)(p + 1);
 8cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d0:	83 c0 08             	add    $0x8,%eax
 8d3:	eb 38                	jmp    90d <malloc+0xde>
    }
    if(p == freep)
 8d5:	a1 e8 0e 00 00       	mov    0xee8,%eax
 8da:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8dd:	75 1b                	jne    8fa <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8df:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8e2:	89 04 24             	mov    %eax,(%esp)
 8e5:	e8 ed fe ff ff       	call   7d7 <morecore>
 8ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f1:	75 07                	jne    8fa <malloc+0xcb>
        return 0;
 8f3:	b8 00 00 00 00       	mov    $0x0,%eax
 8f8:	eb 13                	jmp    90d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 900:	8b 45 f4             	mov    -0xc(%ebp),%eax
 903:	8b 00                	mov    (%eax),%eax
 905:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 908:	e9 70 ff ff ff       	jmp    87d <malloc+0x4e>
}
 90d:	c9                   	leave  
 90e:	c3                   	ret    
 90f:	90                   	nop

00000910 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 916:	8b 45 0c             	mov    0xc(%ebp),%eax
 919:	89 04 24             	mov    %eax,(%esp)
 91c:	8b 45 08             	mov    0x8(%ebp),%eax
 91f:	ff d0                	call   *%eax
    exit();
 921:	e8 4e fa ff ff       	call   374 <exit>

00000926 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 926:	55                   	push   %ebp
 927:	89 e5                	mov    %esp,%ebp
 929:	57                   	push   %edi
 92a:	56                   	push   %esi
 92b:	53                   	push   %ebx
 92c:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 92f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 936:	e8 f4 fe ff ff       	call   82f <malloc>
 93b:	89 c2                	mov    %eax,%edx
 93d:	8b 45 08             	mov    0x8(%ebp),%eax
 940:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 942:	8b 45 10             	mov    0x10(%ebp),%eax
 945:	8b 38                	mov    (%eax),%edi
 947:	8b 75 0c             	mov    0xc(%ebp),%esi
 94a:	bb 10 09 00 00       	mov    $0x910,%ebx
 94f:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 956:	e8 d4 fe ff ff       	call   82f <malloc>
 95b:	05 00 10 00 00       	add    $0x1000,%eax
 960:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 964:	89 74 24 08          	mov    %esi,0x8(%esp)
 968:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 96c:	89 04 24             	mov    %eax,(%esp)
 96f:	e8 a0 fa ff ff       	call   414 <kthread_create>
 974:	8b 55 08             	mov    0x8(%ebp),%edx
 977:	89 02                	mov    %eax,(%edx)
    return *thread;
 979:	8b 45 08             	mov    0x8(%ebp),%eax
 97c:	8b 00                	mov    (%eax),%eax
}
 97e:	83 c4 1c             	add    $0x1c,%esp
 981:	5b                   	pop    %ebx
 982:	5e                   	pop    %esi
 983:	5f                   	pop    %edi
 984:	5d                   	pop    %ebp
 985:	c3                   	ret    

00000986 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 986:	55                   	push   %ebp
 987:	89 e5                	mov    %esp,%ebp
 989:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 98c:	8b 45 0c             	mov    0xc(%ebp),%eax
 98f:	89 44 24 04          	mov    %eax,0x4(%esp)
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	89 04 24             	mov    %eax,(%esp)
 999:	e8 7e fa ff ff       	call   41c <kthread_join>
 99e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9a4:	c9                   	leave  
 9a5:	c3                   	ret    

000009a6 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 9a6:	55                   	push   %ebp
 9a7:	89 e5                	mov    %esp,%ebp
 9a9:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 9ac:	e8 73 fa ff ff       	call   424 <kthread_mutex_init>
 9b1:	8b 55 08             	mov    0x8(%ebp),%edx
 9b4:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 9b6:	8b 45 08             	mov    0x8(%ebp),%eax
 9b9:	8b 00                	mov    (%eax),%eax
 9bb:	85 c0                	test   %eax,%eax
 9bd:	7e 07                	jle    9c6 <qthread_mutex_init+0x20>
		return 0;
 9bf:	b8 00 00 00 00       	mov    $0x0,%eax
 9c4:	eb 05                	jmp    9cb <qthread_mutex_init+0x25>
	}
	return *mutex;
 9c6:	8b 45 08             	mov    0x8(%ebp),%eax
 9c9:	8b 00                	mov    (%eax),%eax
}
 9cb:	c9                   	leave  
 9cc:	c3                   	ret    

000009cd <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 9cd:	55                   	push   %ebp
 9ce:	89 e5                	mov    %esp,%ebp
 9d0:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 9d3:	8b 45 08             	mov    0x8(%ebp),%eax
 9d6:	89 04 24             	mov    %eax,(%esp)
 9d9:	e8 4e fa ff ff       	call   42c <kthread_mutex_destroy>
 9de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9e5:	79 07                	jns    9ee <qthread_mutex_destroy+0x21>
    	return -1;
 9e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9ec:	eb 05                	jmp    9f3 <qthread_mutex_destroy+0x26>
    }
    return 0;
 9ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f3:	c9                   	leave  
 9f4:	c3                   	ret    

000009f5 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 9f5:	55                   	push   %ebp
 9f6:	89 e5                	mov    %esp,%ebp
 9f8:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 9fb:	8b 45 08             	mov    0x8(%ebp),%eax
 9fe:	89 04 24             	mov    %eax,(%esp)
 a01:	e8 2e fa ff ff       	call   434 <kthread_mutex_lock>
 a06:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a09:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a0d:	79 07                	jns    a16 <qthread_mutex_lock+0x21>
    	return -1;
 a0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a14:	eb 05                	jmp    a1b <qthread_mutex_lock+0x26>
    }
    return 0;
 a16:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a1b:	c9                   	leave  
 a1c:	c3                   	ret    

00000a1d <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a1d:	55                   	push   %ebp
 a1e:	89 e5                	mov    %esp,%ebp
 a20:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a23:	8b 45 08             	mov    0x8(%ebp),%eax
 a26:	89 04 24             	mov    %eax,(%esp)
 a29:	e8 0e fa ff ff       	call   43c <kthread_mutex_unlock>
 a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a35:	79 07                	jns    a3e <qthread_mutex_unlock+0x21>
    	return -1;
 a37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a3c:	eb 05                	jmp    a43 <qthread_mutex_unlock+0x26>
    }
    return 0;
 a3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a43:	c9                   	leave  
 a44:	c3                   	ret    

00000a45 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 a45:	55                   	push   %ebp
 a46:	89 e5                	mov    %esp,%ebp

	return 0;
 a48:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a4d:	5d                   	pop    %ebp
 a4e:	c3                   	ret    

00000a4f <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 a4f:	55                   	push   %ebp
 a50:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a52:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a57:	5d                   	pop    %ebp
 a58:	c3                   	ret    

00000a59 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 a59:	55                   	push   %ebp
 a5a:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a61:	5d                   	pop    %ebp
 a62:	c3                   	ret    

00000a63 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 a63:	55                   	push   %ebp
 a64:	89 e5                	mov    %esp,%ebp
	return 0;
 a66:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a6b:	5d                   	pop    %ebp
 a6c:	c3                   	ret    

00000a6d <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 a6d:	55                   	push   %ebp
 a6e:	89 e5                	mov    %esp,%ebp
	return 0;
 a70:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a75:	5d                   	pop    %ebp
 a76:	c3                   	ret    

00000a77 <qthread_exit>:

int qthread_exit(){
 a77:	55                   	push   %ebp
 a78:	89 e5                	mov    %esp,%ebp
	return 0;
 a7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a7f:	5d                   	pop    %ebp
 a80:	c3                   	ret    
