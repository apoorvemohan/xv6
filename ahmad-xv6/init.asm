
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10:	00 
  11:	c7 04 24 8b 0a 00 00 	movl   $0xa8b,(%esp)
  18:	e8 9a 03 00 00       	call   3b7 <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 8b 0a 00 00 	movl   $0xa8b,(%esp)
  38:	e8 82 03 00 00       	call   3bf <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 8b 0a 00 00 	movl   $0xa8b,(%esp)
  4c:	e8 66 03 00 00       	call   3b7 <open>
  }
  dup(0);  // stdout
  51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  58:	e8 92 03 00 00       	call   3ef <dup>
  dup(0);  // stderr
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 86 03 00 00       	call   3ef <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  69:	c7 44 24 04 93 0a 00 	movl   $0xa93,0x4(%esp)
  70:	00 
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 d2 04 00 00       	call   54f <printf>
    pid = fork();
  7d:	e8 ed 02 00 00       	call   36f <fork>
  82:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  86:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  8b:	79 19                	jns    a6 <main+0xa6>
      printf(1, "init: fork failed\n");
  8d:	c7 44 24 04 a6 0a 00 	movl   $0xaa6,0x4(%esp)
  94:	00 
  95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9c:	e8 ae 04 00 00       	call   54f <printf>
      exit();
  a1:	e8 d1 02 00 00       	call   377 <exit>
    }
    if(pid == 0){
  a6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  ab:	75 2d                	jne    da <main+0xda>
      exec("sh", argv);
  ad:	c7 44 24 04 ac 0e 00 	movl   $0xeac,0x4(%esp)
  b4:	00 
  b5:	c7 04 24 88 0a 00 00 	movl   $0xa88,(%esp)
  bc:	e8 ee 02 00 00       	call   3af <exec>
      printf(1, "init: exec sh failed\n");
  c1:	c7 44 24 04 b9 0a 00 	movl   $0xab9,0x4(%esp)
  c8:	00 
  c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d0:	e8 7a 04 00 00       	call   54f <printf>
      exit();
  d5:	e8 9d 02 00 00       	call   377 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  da:	eb 14                	jmp    f0 <main+0xf0>
      printf(1, "zombie!\n");
  dc:	c7 44 24 04 cf 0a 00 	movl   $0xacf,0x4(%esp)
  e3:	00 
  e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  eb:	e8 5f 04 00 00       	call   54f <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  f0:	e8 8a 02 00 00       	call   37f <wait>
  f5:	89 44 24 18          	mov    %eax,0x18(%esp)
  f9:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  fe:	78 0a                	js     10a <main+0x10a>
 100:	8b 44 24 18          	mov    0x18(%esp),%eax
 104:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 108:	75 d2                	jne    dc <main+0xdc>
      printf(1, "zombie!\n");
  }
 10a:	e9 5a ff ff ff       	jmp    69 <main+0x69>

0000010f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	57                   	push   %edi
 113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 114:	8b 4d 08             	mov    0x8(%ebp),%ecx
 117:	8b 55 10             	mov    0x10(%ebp),%edx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 cb                	mov    %ecx,%ebx
 11f:	89 df                	mov    %ebx,%edi
 121:	89 d1                	mov    %edx,%ecx
 123:	fc                   	cld    
 124:	f3 aa                	rep stos %al,%es:(%edi)
 126:	89 ca                	mov    %ecx,%edx
 128:	89 fb                	mov    %edi,%ebx
 12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 130:	5b                   	pop    %ebx
 131:	5f                   	pop    %edi
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    

00000134 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 140:	90                   	nop
 141:	8b 45 08             	mov    0x8(%ebp),%eax
 144:	8d 50 01             	lea    0x1(%eax),%edx
 147:	89 55 08             	mov    %edx,0x8(%ebp)
 14a:	8b 55 0c             	mov    0xc(%ebp),%edx
 14d:	8d 4a 01             	lea    0x1(%edx),%ecx
 150:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 153:	0f b6 12             	movzbl (%edx),%edx
 156:	88 10                	mov    %dl,(%eax)
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	84 c0                	test   %al,%al
 15d:	75 e2                	jne    141 <strcpy+0xd>
    ;
  return os;
 15f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 162:	c9                   	leave  
 163:	c3                   	ret    

00000164 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 167:	eb 08                	jmp    171 <strcmp+0xd>
    p++, q++;
 169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 171:	8b 45 08             	mov    0x8(%ebp),%eax
 174:	0f b6 00             	movzbl (%eax),%eax
 177:	84 c0                	test   %al,%al
 179:	74 10                	je     18b <strcmp+0x27>
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	0f b6 10             	movzbl (%eax),%edx
 181:	8b 45 0c             	mov    0xc(%ebp),%eax
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	38 c2                	cmp    %al,%dl
 189:	74 de                	je     169 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 18b:	8b 45 08             	mov    0x8(%ebp),%eax
 18e:	0f b6 00             	movzbl (%eax),%eax
 191:	0f b6 d0             	movzbl %al,%edx
 194:	8b 45 0c             	mov    0xc(%ebp),%eax
 197:	0f b6 00             	movzbl (%eax),%eax
 19a:	0f b6 c0             	movzbl %al,%eax
 19d:	29 c2                	sub    %eax,%edx
 19f:	89 d0                	mov    %edx,%eax
}
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    

000001a3 <strlen>:

uint
strlen(char *s)
{
 1a3:	55                   	push   %ebp
 1a4:	89 e5                	mov    %esp,%ebp
 1a6:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b0:	eb 04                	jmp    1b6 <strlen+0x13>
 1b2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	01 d0                	add    %edx,%eax
 1be:	0f b6 00             	movzbl (%eax),%eax
 1c1:	84 c0                	test   %al,%al
 1c3:	75 ed                	jne    1b2 <strlen+0xf>
    ;
  return n;
 1c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c8:	c9                   	leave  
 1c9:	c3                   	ret    

000001ca <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ca:	55                   	push   %ebp
 1cb:	89 e5                	mov    %esp,%ebp
 1cd:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1d0:	8b 45 10             	mov    0x10(%ebp),%eax
 1d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	89 44 24 04          	mov    %eax,0x4(%esp)
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
 1e1:	89 04 24             	mov    %eax,(%esp)
 1e4:	e8 26 ff ff ff       	call   10f <stosb>
  return dst;
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ec:	c9                   	leave  
 1ed:	c3                   	ret    

000001ee <strchr>:

char*
strchr(const char *s, char c)
{
 1ee:	55                   	push   %ebp
 1ef:	89 e5                	mov    %esp,%ebp
 1f1:	83 ec 04             	sub    $0x4,%esp
 1f4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1fa:	eb 14                	jmp    210 <strchr+0x22>
    if(*s == c)
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	0f b6 00             	movzbl (%eax),%eax
 202:	3a 45 fc             	cmp    -0x4(%ebp),%al
 205:	75 05                	jne    20c <strchr+0x1e>
      return (char*)s;
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	eb 13                	jmp    21f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 20c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	0f b6 00             	movzbl (%eax),%eax
 216:	84 c0                	test   %al,%al
 218:	75 e2                	jne    1fc <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 21a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21f:	c9                   	leave  
 220:	c3                   	ret    

00000221 <gets>:

char*
gets(char *buf, int max)
{
 221:	55                   	push   %ebp
 222:	89 e5                	mov    %esp,%ebp
 224:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 227:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 22e:	eb 4c                	jmp    27c <gets+0x5b>
    cc = read(0, &c, 1);
 230:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 237:	00 
 238:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23b:	89 44 24 04          	mov    %eax,0x4(%esp)
 23f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 246:	e8 44 01 00 00       	call   38f <read>
 24b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 252:	7f 02                	jg     256 <gets+0x35>
      break;
 254:	eb 31                	jmp    287 <gets+0x66>
    buf[i++] = c;
 256:	8b 45 f4             	mov    -0xc(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25f:	89 c2                	mov    %eax,%edx
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	01 c2                	add    %eax,%edx
 266:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 270:	3c 0a                	cmp    $0xa,%al
 272:	74 13                	je     287 <gets+0x66>
 274:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 278:	3c 0d                	cmp    $0xd,%al
 27a:	74 0b                	je     287 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27f:	83 c0 01             	add    $0x1,%eax
 282:	3b 45 0c             	cmp    0xc(%ebp),%eax
 285:	7c a9                	jl     230 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 287:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	01 d0                	add    %edx,%eax
 28f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <stat>:

int
stat(char *n, struct stat *st)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a4:	00 
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	89 04 24             	mov    %eax,(%esp)
 2ab:	e8 07 01 00 00       	call   3b7 <open>
 2b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b7:	79 07                	jns    2c0 <stat+0x29>
    return -1;
 2b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2be:	eb 23                	jmp    2e3 <stat+0x4c>
  r = fstat(fd, st);
 2c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ca:	89 04 24             	mov    %eax,(%esp)
 2cd:	e8 fd 00 00 00       	call   3cf <fstat>
 2d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d8:	89 04 24             	mov    %eax,(%esp)
 2db:	e8 bf 00 00 00       	call   39f <close>
  return r;
 2e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e3:	c9                   	leave  
 2e4:	c3                   	ret    

000002e5 <atoi>:

int
atoi(const char *s)
{
 2e5:	55                   	push   %ebp
 2e6:	89 e5                	mov    %esp,%ebp
 2e8:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f2:	eb 25                	jmp    319 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f7:	89 d0                	mov    %edx,%eax
 2f9:	c1 e0 02             	shl    $0x2,%eax
 2fc:	01 d0                	add    %edx,%eax
 2fe:	01 c0                	add    %eax,%eax
 300:	89 c1                	mov    %eax,%ecx
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	8d 50 01             	lea    0x1(%eax),%edx
 308:	89 55 08             	mov    %edx,0x8(%ebp)
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	0f be c0             	movsbl %al,%eax
 311:	01 c8                	add    %ecx,%eax
 313:	83 e8 30             	sub    $0x30,%eax
 316:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	3c 2f                	cmp    $0x2f,%al
 321:	7e 0a                	jle    32d <atoi+0x48>
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	0f b6 00             	movzbl (%eax),%eax
 329:	3c 39                	cmp    $0x39,%al
 32b:	7e c7                	jle    2f4 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 32d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 330:	c9                   	leave  
 331:	c3                   	ret    

00000332 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 332:	55                   	push   %ebp
 333:	89 e5                	mov    %esp,%ebp
 335:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33e:	8b 45 0c             	mov    0xc(%ebp),%eax
 341:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 344:	eb 17                	jmp    35d <memmove+0x2b>
    *dst++ = *src++;
 346:	8b 45 fc             	mov    -0x4(%ebp),%eax
 349:	8d 50 01             	lea    0x1(%eax),%edx
 34c:	89 55 fc             	mov    %edx,-0x4(%ebp)
 34f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 352:	8d 4a 01             	lea    0x1(%edx),%ecx
 355:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 358:	0f b6 12             	movzbl (%edx),%edx
 35b:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35d:	8b 45 10             	mov    0x10(%ebp),%eax
 360:	8d 50 ff             	lea    -0x1(%eax),%edx
 363:	89 55 10             	mov    %edx,0x10(%ebp)
 366:	85 c0                	test   %eax,%eax
 368:	7f dc                	jg     346 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 36a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36d:	c9                   	leave  
 36e:	c3                   	ret    

0000036f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36f:	b8 01 00 00 00       	mov    $0x1,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <exit>:
SYSCALL(exit)
 377:	b8 02 00 00 00       	mov    $0x2,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <wait>:
SYSCALL(wait)
 37f:	b8 03 00 00 00       	mov    $0x3,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <pipe>:
SYSCALL(pipe)
 387:	b8 04 00 00 00       	mov    $0x4,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <read>:
SYSCALL(read)
 38f:	b8 05 00 00 00       	mov    $0x5,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <write>:
SYSCALL(write)
 397:	b8 10 00 00 00       	mov    $0x10,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <close>:
SYSCALL(close)
 39f:	b8 15 00 00 00       	mov    $0x15,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <kill>:
SYSCALL(kill)
 3a7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <exec>:
SYSCALL(exec)
 3af:	b8 07 00 00 00       	mov    $0x7,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <open>:
SYSCALL(open)
 3b7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <mknod>:
SYSCALL(mknod)
 3bf:	b8 11 00 00 00       	mov    $0x11,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <unlink>:
SYSCALL(unlink)
 3c7:	b8 12 00 00 00       	mov    $0x12,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <fstat>:
SYSCALL(fstat)
 3cf:	b8 08 00 00 00       	mov    $0x8,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <link>:
SYSCALL(link)
 3d7:	b8 13 00 00 00       	mov    $0x13,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <mkdir>:
SYSCALL(mkdir)
 3df:	b8 14 00 00 00       	mov    $0x14,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <chdir>:
SYSCALL(chdir)
 3e7:	b8 09 00 00 00       	mov    $0x9,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <dup>:
SYSCALL(dup)
 3ef:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <getpid>:
SYSCALL(getpid)
 3f7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <sbrk>:
SYSCALL(sbrk)
 3ff:	b8 0c 00 00 00       	mov    $0xc,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <sleep>:
SYSCALL(sleep)
 407:	b8 0d 00 00 00       	mov    $0xd,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <uptime>:
SYSCALL(uptime)
 40f:	b8 0e 00 00 00       	mov    $0xe,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <kthread_create>:
SYSCALL(kthread_create)
 417:	b8 17 00 00 00       	mov    $0x17,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <kthread_join>:
SYSCALL(kthread_join)
 41f:	b8 16 00 00 00       	mov    $0x16,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 427:	b8 18 00 00 00       	mov    $0x18,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 42f:	b8 19 00 00 00       	mov    $0x19,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 437:	b8 1a 00 00 00       	mov    $0x1a,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 43f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 447:	b8 1c 00 00 00       	mov    $0x1c,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 44f:	b8 1d 00 00 00       	mov    $0x1d,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 457:	b8 1e 00 00 00       	mov    $0x1e,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 45f:	b8 1f 00 00 00       	mov    $0x1f,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <kthread_cond_broadcast>:
 467:	b8 20 00 00 00       	mov    $0x20,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 46f:	55                   	push   %ebp
 470:	89 e5                	mov    %esp,%ebp
 472:	83 ec 18             	sub    $0x18,%esp
 475:	8b 45 0c             	mov    0xc(%ebp),%eax
 478:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 47b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 482:	00 
 483:	8d 45 f4             	lea    -0xc(%ebp),%eax
 486:	89 44 24 04          	mov    %eax,0x4(%esp)
 48a:	8b 45 08             	mov    0x8(%ebp),%eax
 48d:	89 04 24             	mov    %eax,(%esp)
 490:	e8 02 ff ff ff       	call   397 <write>
}
 495:	c9                   	leave  
 496:	c3                   	ret    

00000497 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 497:	55                   	push   %ebp
 498:	89 e5                	mov    %esp,%ebp
 49a:	56                   	push   %esi
 49b:	53                   	push   %ebx
 49c:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 49f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4a6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4aa:	74 17                	je     4c3 <printint+0x2c>
 4ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4b0:	79 11                	jns    4c3 <printint+0x2c>
    neg = 1;
 4b2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bc:	f7 d8                	neg    %eax
 4be:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c1:	eb 06                	jmp    4c9 <printint+0x32>
  } else {
    x = xx;
 4c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4d0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4d3:	8d 41 01             	lea    0x1(%ecx),%eax
 4d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4d9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4df:	ba 00 00 00 00       	mov    $0x0,%edx
 4e4:	f7 f3                	div    %ebx
 4e6:	89 d0                	mov    %edx,%eax
 4e8:	0f b6 80 b4 0e 00 00 	movzbl 0xeb4(%eax),%eax
 4ef:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4f3:	8b 75 10             	mov    0x10(%ebp),%esi
 4f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4f9:	ba 00 00 00 00       	mov    $0x0,%edx
 4fe:	f7 f6                	div    %esi
 500:	89 45 ec             	mov    %eax,-0x14(%ebp)
 503:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 507:	75 c7                	jne    4d0 <printint+0x39>
  if(neg)
 509:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 50d:	74 10                	je     51f <printint+0x88>
    buf[i++] = '-';
 50f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 512:	8d 50 01             	lea    0x1(%eax),%edx
 515:	89 55 f4             	mov    %edx,-0xc(%ebp)
 518:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 51d:	eb 1f                	jmp    53e <printint+0xa7>
 51f:	eb 1d                	jmp    53e <printint+0xa7>
    putc(fd, buf[i]);
 521:	8d 55 dc             	lea    -0x24(%ebp),%edx
 524:	8b 45 f4             	mov    -0xc(%ebp),%eax
 527:	01 d0                	add    %edx,%eax
 529:	0f b6 00             	movzbl (%eax),%eax
 52c:	0f be c0             	movsbl %al,%eax
 52f:	89 44 24 04          	mov    %eax,0x4(%esp)
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	89 04 24             	mov    %eax,(%esp)
 539:	e8 31 ff ff ff       	call   46f <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 542:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 546:	79 d9                	jns    521 <printint+0x8a>
    putc(fd, buf[i]);
}
 548:	83 c4 30             	add    $0x30,%esp
 54b:	5b                   	pop    %ebx
 54c:	5e                   	pop    %esi
 54d:	5d                   	pop    %ebp
 54e:	c3                   	ret    

0000054f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 54f:	55                   	push   %ebp
 550:	89 e5                	mov    %esp,%ebp
 552:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 555:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 55c:	8d 45 0c             	lea    0xc(%ebp),%eax
 55f:	83 c0 04             	add    $0x4,%eax
 562:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 565:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 56c:	e9 7c 01 00 00       	jmp    6ed <printf+0x19e>
    c = fmt[i] & 0xff;
 571:	8b 55 0c             	mov    0xc(%ebp),%edx
 574:	8b 45 f0             	mov    -0x10(%ebp),%eax
 577:	01 d0                	add    %edx,%eax
 579:	0f b6 00             	movzbl (%eax),%eax
 57c:	0f be c0             	movsbl %al,%eax
 57f:	25 ff 00 00 00       	and    $0xff,%eax
 584:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 587:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 58b:	75 2c                	jne    5b9 <printf+0x6a>
      if(c == '%'){
 58d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 591:	75 0c                	jne    59f <printf+0x50>
        state = '%';
 593:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 59a:	e9 4a 01 00 00       	jmp    6e9 <printf+0x19a>
      } else {
        putc(fd, c);
 59f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a2:	0f be c0             	movsbl %al,%eax
 5a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ac:	89 04 24             	mov    %eax,(%esp)
 5af:	e8 bb fe ff ff       	call   46f <putc>
 5b4:	e9 30 01 00 00       	jmp    6e9 <printf+0x19a>
      }
    } else if(state == '%'){
 5b9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5bd:	0f 85 26 01 00 00    	jne    6e9 <printf+0x19a>
      if(c == 'd'){
 5c3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5c7:	75 2d                	jne    5f6 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5d5:	00 
 5d6:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5dd:	00 
 5de:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e2:	8b 45 08             	mov    0x8(%ebp),%eax
 5e5:	89 04 24             	mov    %eax,(%esp)
 5e8:	e8 aa fe ff ff       	call   497 <printint>
        ap++;
 5ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f1:	e9 ec 00 00 00       	jmp    6e2 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5f6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5fa:	74 06                	je     602 <printf+0xb3>
 5fc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 600:	75 2d                	jne    62f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 602:	8b 45 e8             	mov    -0x18(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 60e:	00 
 60f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 616:	00 
 617:	89 44 24 04          	mov    %eax,0x4(%esp)
 61b:	8b 45 08             	mov    0x8(%ebp),%eax
 61e:	89 04 24             	mov    %eax,(%esp)
 621:	e8 71 fe ff ff       	call   497 <printint>
        ap++;
 626:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62a:	e9 b3 00 00 00       	jmp    6e2 <printf+0x193>
      } else if(c == 's'){
 62f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 633:	75 45                	jne    67a <printf+0x12b>
        s = (char*)*ap;
 635:	8b 45 e8             	mov    -0x18(%ebp),%eax
 638:	8b 00                	mov    (%eax),%eax
 63a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 63d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 641:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 645:	75 09                	jne    650 <printf+0x101>
          s = "(null)";
 647:	c7 45 f4 d8 0a 00 00 	movl   $0xad8,-0xc(%ebp)
        while(*s != 0){
 64e:	eb 1e                	jmp    66e <printf+0x11f>
 650:	eb 1c                	jmp    66e <printf+0x11f>
          putc(fd, *s);
 652:	8b 45 f4             	mov    -0xc(%ebp),%eax
 655:	0f b6 00             	movzbl (%eax),%eax
 658:	0f be c0             	movsbl %al,%eax
 65b:	89 44 24 04          	mov    %eax,0x4(%esp)
 65f:	8b 45 08             	mov    0x8(%ebp),%eax
 662:	89 04 24             	mov    %eax,(%esp)
 665:	e8 05 fe ff ff       	call   46f <putc>
          s++;
 66a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 66e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 671:	0f b6 00             	movzbl (%eax),%eax
 674:	84 c0                	test   %al,%al
 676:	75 da                	jne    652 <printf+0x103>
 678:	eb 68                	jmp    6e2 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 67a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 67e:	75 1d                	jne    69d <printf+0x14e>
        putc(fd, *ap);
 680:	8b 45 e8             	mov    -0x18(%ebp),%eax
 683:	8b 00                	mov    (%eax),%eax
 685:	0f be c0             	movsbl %al,%eax
 688:	89 44 24 04          	mov    %eax,0x4(%esp)
 68c:	8b 45 08             	mov    0x8(%ebp),%eax
 68f:	89 04 24             	mov    %eax,(%esp)
 692:	e8 d8 fd ff ff       	call   46f <putc>
        ap++;
 697:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69b:	eb 45                	jmp    6e2 <printf+0x193>
      } else if(c == '%'){
 69d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6a1:	75 17                	jne    6ba <printf+0x16b>
        putc(fd, c);
 6a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a6:	0f be c0             	movsbl %al,%eax
 6a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ad:	8b 45 08             	mov    0x8(%ebp),%eax
 6b0:	89 04 24             	mov    %eax,(%esp)
 6b3:	e8 b7 fd ff ff       	call   46f <putc>
 6b8:	eb 28                	jmp    6e2 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ba:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6c1:	00 
 6c2:	8b 45 08             	mov    0x8(%ebp),%eax
 6c5:	89 04 24             	mov    %eax,(%esp)
 6c8:	e8 a2 fd ff ff       	call   46f <putc>
        putc(fd, c);
 6cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d0:	0f be c0             	movsbl %al,%eax
 6d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d7:	8b 45 08             	mov    0x8(%ebp),%eax
 6da:	89 04 24             	mov    %eax,(%esp)
 6dd:	e8 8d fd ff ff       	call   46f <putc>
      }
      state = 0;
 6e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 6f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f3:	01 d0                	add    %edx,%eax
 6f5:	0f b6 00             	movzbl (%eax),%eax
 6f8:	84 c0                	test   %al,%al
 6fa:	0f 85 71 fe ff ff    	jne    571 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 700:	c9                   	leave  
 701:	c3                   	ret    

00000702 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 702:	55                   	push   %ebp
 703:	89 e5                	mov    %esp,%ebp
 705:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	83 e8 08             	sub    $0x8,%eax
 70e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	a1 d0 0e 00 00       	mov    0xed0,%eax
 716:	89 45 fc             	mov    %eax,-0x4(%ebp)
 719:	eb 24                	jmp    73f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71e:	8b 00                	mov    (%eax),%eax
 720:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 723:	77 12                	ja     737 <free+0x35>
 725:	8b 45 f8             	mov    -0x8(%ebp),%eax
 728:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72b:	77 24                	ja     751 <free+0x4f>
 72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 730:	8b 00                	mov    (%eax),%eax
 732:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 735:	77 1a                	ja     751 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 737:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73a:	8b 00                	mov    (%eax),%eax
 73c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 73f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 742:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 745:	76 d4                	jbe    71b <free+0x19>
 747:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74a:	8b 00                	mov    (%eax),%eax
 74c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 74f:	76 ca                	jbe    71b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 751:	8b 45 f8             	mov    -0x8(%ebp),%eax
 754:	8b 40 04             	mov    0x4(%eax),%eax
 757:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 75e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 761:	01 c2                	add    %eax,%edx
 763:	8b 45 fc             	mov    -0x4(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	39 c2                	cmp    %eax,%edx
 76a:	75 24                	jne    790 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 76c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76f:	8b 50 04             	mov    0x4(%eax),%edx
 772:	8b 45 fc             	mov    -0x4(%ebp),%eax
 775:	8b 00                	mov    (%eax),%eax
 777:	8b 40 04             	mov    0x4(%eax),%eax
 77a:	01 c2                	add    %eax,%edx
 77c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 782:	8b 45 fc             	mov    -0x4(%ebp),%eax
 785:	8b 00                	mov    (%eax),%eax
 787:	8b 10                	mov    (%eax),%edx
 789:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78c:	89 10                	mov    %edx,(%eax)
 78e:	eb 0a                	jmp    79a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 790:	8b 45 fc             	mov    -0x4(%ebp),%eax
 793:	8b 10                	mov    (%eax),%edx
 795:	8b 45 f8             	mov    -0x8(%ebp),%eax
 798:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 79a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79d:	8b 40 04             	mov    0x4(%eax),%eax
 7a0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7aa:	01 d0                	add    %edx,%eax
 7ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7af:	75 20                	jne    7d1 <free+0xcf>
    p->s.size += bp->s.size;
 7b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b4:	8b 50 04             	mov    0x4(%eax),%edx
 7b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ba:	8b 40 04             	mov    0x4(%eax),%eax
 7bd:	01 c2                	add    %eax,%edx
 7bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c8:	8b 10                	mov    (%eax),%edx
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	89 10                	mov    %edx,(%eax)
 7cf:	eb 08                	jmp    7d9 <free+0xd7>
  } else
    p->s.ptr = bp;
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7d7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	a3 d0 0e 00 00       	mov    %eax,0xed0
}
 7e1:	c9                   	leave  
 7e2:	c3                   	ret    

000007e3 <morecore>:

static Header*
morecore(uint nu)
{
 7e3:	55                   	push   %ebp
 7e4:	89 e5                	mov    %esp,%ebp
 7e6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7e9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7f0:	77 07                	ja     7f9 <morecore+0x16>
    nu = 4096;
 7f2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
 7fc:	c1 e0 03             	shl    $0x3,%eax
 7ff:	89 04 24             	mov    %eax,(%esp)
 802:	e8 f8 fb ff ff       	call   3ff <sbrk>
 807:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 80a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 80e:	75 07                	jne    817 <morecore+0x34>
    return 0;
 810:	b8 00 00 00 00       	mov    $0x0,%eax
 815:	eb 22                	jmp    839 <morecore+0x56>
  hp = (Header*)p;
 817:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 81d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 820:	8b 55 08             	mov    0x8(%ebp),%edx
 823:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 826:	8b 45 f0             	mov    -0x10(%ebp),%eax
 829:	83 c0 08             	add    $0x8,%eax
 82c:	89 04 24             	mov    %eax,(%esp)
 82f:	e8 ce fe ff ff       	call   702 <free>
  return freep;
 834:	a1 d0 0e 00 00       	mov    0xed0,%eax
}
 839:	c9                   	leave  
 83a:	c3                   	ret    

0000083b <malloc>:

void*
malloc(uint nbytes)
{
 83b:	55                   	push   %ebp
 83c:	89 e5                	mov    %esp,%ebp
 83e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 841:	8b 45 08             	mov    0x8(%ebp),%eax
 844:	83 c0 07             	add    $0x7,%eax
 847:	c1 e8 03             	shr    $0x3,%eax
 84a:	83 c0 01             	add    $0x1,%eax
 84d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 850:	a1 d0 0e 00 00       	mov    0xed0,%eax
 855:	89 45 f0             	mov    %eax,-0x10(%ebp)
 858:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 85c:	75 23                	jne    881 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 85e:	c7 45 f0 c8 0e 00 00 	movl   $0xec8,-0x10(%ebp)
 865:	8b 45 f0             	mov    -0x10(%ebp),%eax
 868:	a3 d0 0e 00 00       	mov    %eax,0xed0
 86d:	a1 d0 0e 00 00       	mov    0xed0,%eax
 872:	a3 c8 0e 00 00       	mov    %eax,0xec8
    base.s.size = 0;
 877:	c7 05 cc 0e 00 00 00 	movl   $0x0,0xecc
 87e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 881:	8b 45 f0             	mov    -0x10(%ebp),%eax
 884:	8b 00                	mov    (%eax),%eax
 886:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 889:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88c:	8b 40 04             	mov    0x4(%eax),%eax
 88f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 892:	72 4d                	jb     8e1 <malloc+0xa6>
      if(p->s.size == nunits)
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	8b 40 04             	mov    0x4(%eax),%eax
 89a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 89d:	75 0c                	jne    8ab <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	8b 10                	mov    (%eax),%edx
 8a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a7:	89 10                	mov    %edx,(%eax)
 8a9:	eb 26                	jmp    8d1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ae:	8b 40 04             	mov    0x4(%eax),%eax
 8b1:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8b4:	89 c2                	mov    %eax,%edx
 8b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bf:	8b 40 04             	mov    0x4(%eax),%eax
 8c2:	c1 e0 03             	shl    $0x3,%eax
 8c5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8ce:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d4:	a3 d0 0e 00 00       	mov    %eax,0xed0
      return (void*)(p + 1);
 8d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8dc:	83 c0 08             	add    $0x8,%eax
 8df:	eb 38                	jmp    919 <malloc+0xde>
    }
    if(p == freep)
 8e1:	a1 d0 0e 00 00       	mov    0xed0,%eax
 8e6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e9:	75 1b                	jne    906 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8ee:	89 04 24             	mov    %eax,(%esp)
 8f1:	e8 ed fe ff ff       	call   7e3 <morecore>
 8f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8fd:	75 07                	jne    906 <malloc+0xcb>
        return 0;
 8ff:	b8 00 00 00 00       	mov    $0x0,%eax
 904:	eb 13                	jmp    919 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 906:	8b 45 f4             	mov    -0xc(%ebp),%eax
 909:	89 45 f0             	mov    %eax,-0x10(%ebp)
 90c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90f:	8b 00                	mov    (%eax),%eax
 911:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 914:	e9 70 ff ff ff       	jmp    889 <malloc+0x4e>
}
 919:	c9                   	leave  
 91a:	c3                   	ret    

0000091b <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 91b:	55                   	push   %ebp
 91c:	89 e5                	mov    %esp,%ebp
 91e:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 921:	8b 45 0c             	mov    0xc(%ebp),%eax
 924:	89 04 24             	mov    %eax,(%esp)
 927:	8b 45 08             	mov    0x8(%ebp),%eax
 92a:	ff d0                	call   *%eax
    exit();
 92c:	e8 46 fa ff ff       	call   377 <exit>

00000931 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 931:	55                   	push   %ebp
 932:	89 e5                	mov    %esp,%ebp
 934:	57                   	push   %edi
 935:	56                   	push   %esi
 936:	53                   	push   %ebx
 937:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 93a:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 941:	e8 f5 fe ff ff       	call   83b <malloc>
 946:	8b 55 08             	mov    0x8(%ebp),%edx
 949:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 94b:	8b 45 10             	mov    0x10(%ebp),%eax
 94e:	8b 38                	mov    (%eax),%edi
 950:	8b 75 0c             	mov    0xc(%ebp),%esi
 953:	bb 1b 09 00 00       	mov    $0x91b,%ebx
 958:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 95f:	e8 d7 fe ff ff       	call   83b <malloc>
 964:	05 00 10 00 00       	add    $0x1000,%eax
 969:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 96d:	89 74 24 08          	mov    %esi,0x8(%esp)
 971:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 975:	89 04 24             	mov    %eax,(%esp)
 978:	e8 9a fa ff ff       	call   417 <kthread_create>
 97d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 980:	8b 45 08             	mov    0x8(%ebp),%eax
 983:	8b 00                	mov    (%eax),%eax
 985:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 988:	89 10                	mov    %edx,(%eax)
    return t_id;
 98a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 98d:	83 c4 2c             	add    $0x2c,%esp
 990:	5b                   	pop    %ebx
 991:	5e                   	pop    %esi
 992:	5f                   	pop    %edi
 993:	5d                   	pop    %ebp
 994:	c3                   	ret    

00000995 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 995:	55                   	push   %ebp
 996:	89 e5                	mov    %esp,%ebp
 998:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 99b:	8b 55 0c             	mov    0xc(%ebp),%edx
 99e:	8b 45 08             	mov    0x8(%ebp),%eax
 9a1:	8b 00                	mov    (%eax),%eax
 9a3:	89 54 24 04          	mov    %edx,0x4(%esp)
 9a7:	89 04 24             	mov    %eax,(%esp)
 9aa:	e8 70 fa ff ff       	call   41f <kthread_join>
 9af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9b5:	c9                   	leave  
 9b6:	c3                   	ret    

000009b7 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 9b7:	55                   	push   %ebp
 9b8:	89 e5                	mov    %esp,%ebp
 9ba:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 9bd:	e8 65 fa ff ff       	call   427 <kthread_mutex_init>
 9c2:	8b 55 08             	mov    0x8(%ebp),%edx
 9c5:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 9c7:	8b 45 08             	mov    0x8(%ebp),%eax
 9ca:	8b 00                	mov    (%eax),%eax
 9cc:	85 c0                	test   %eax,%eax
 9ce:	7e 07                	jle    9d7 <qthread_mutex_init+0x20>
		return 0;
 9d0:	b8 00 00 00 00       	mov    $0x0,%eax
 9d5:	eb 05                	jmp    9dc <qthread_mutex_init+0x25>
	}
	return *mutex;
 9d7:	8b 45 08             	mov    0x8(%ebp),%eax
 9da:	8b 00                	mov    (%eax),%eax
}
 9dc:	c9                   	leave  
 9dd:	c3                   	ret    

000009de <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 9de:	55                   	push   %ebp
 9df:	89 e5                	mov    %esp,%ebp
 9e1:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 9e4:	8b 45 08             	mov    0x8(%ebp),%eax
 9e7:	89 04 24             	mov    %eax,(%esp)
 9ea:	e8 40 fa ff ff       	call   42f <kthread_mutex_destroy>
 9ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9f6:	79 07                	jns    9ff <qthread_mutex_destroy+0x21>
    	return -1;
 9f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9fd:	eb 05                	jmp    a04 <qthread_mutex_destroy+0x26>
    }
    return 0;
 9ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a04:	c9                   	leave  
 a05:	c3                   	ret    

00000a06 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 a06:	55                   	push   %ebp
 a07:	89 e5                	mov    %esp,%ebp
 a09:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 a0c:	8b 45 08             	mov    0x8(%ebp),%eax
 a0f:	89 04 24             	mov    %eax,(%esp)
 a12:	e8 20 fa ff ff       	call   437 <kthread_mutex_lock>
 a17:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a1e:	79 07                	jns    a27 <qthread_mutex_lock+0x21>
    	return -1;
 a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a25:	eb 05                	jmp    a2c <qthread_mutex_lock+0x26>
    }
    return 0;
 a27:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a2c:	c9                   	leave  
 a2d:	c3                   	ret    

00000a2e <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a2e:	55                   	push   %ebp
 a2f:	89 e5                	mov    %esp,%ebp
 a31:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a34:	8b 45 08             	mov    0x8(%ebp),%eax
 a37:	89 04 24             	mov    %eax,(%esp)
 a3a:	e8 00 fa ff ff       	call   43f <kthread_mutex_unlock>
 a3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a46:	79 07                	jns    a4f <qthread_mutex_unlock+0x21>
    	return -1;
 a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a4d:	eb 05                	jmp    a54 <qthread_mutex_unlock+0x26>
    }
    return 0;
 a4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a54:	c9                   	leave  
 a55:	c3                   	ret    

00000a56 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 a56:	55                   	push   %ebp
 a57:	89 e5                	mov    %esp,%ebp

	return 0;
 a59:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a5e:	5d                   	pop    %ebp
 a5f:	c3                   	ret    

00000a60 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a63:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a68:	5d                   	pop    %ebp
 a69:	c3                   	ret    

00000a6a <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 a6a:	55                   	push   %ebp
 a6b:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a6d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a72:	5d                   	pop    %ebp
 a73:	c3                   	ret    

00000a74 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 a74:	55                   	push   %ebp
 a75:	89 e5                	mov    %esp,%ebp
	return 0;
 a77:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a7c:	5d                   	pop    %ebp
 a7d:	c3                   	ret    

00000a7e <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 a7e:	55                   	push   %ebp
 a7f:	89 e5                	mov    %esp,%ebp
	return 0;
 a81:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a86:	5d                   	pop    %ebp
 a87:	c3                   	ret    
