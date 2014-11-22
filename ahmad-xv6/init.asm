
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
  11:	c7 04 24 9d 0a 00 00 	movl   $0xa9d,(%esp)
  18:	e8 9a 03 00 00       	call   3b7 <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 9d 0a 00 00 	movl   $0xa9d,(%esp)
  38:	e8 82 03 00 00       	call   3bf <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 9d 0a 00 00 	movl   $0xa9d,(%esp)
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
  69:	c7 44 24 04 a5 0a 00 	movl   $0xaa5,0x4(%esp)
  70:	00 
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 da 04 00 00       	call   557 <printf>
    pid = fork();
  7d:	e8 ed 02 00 00       	call   36f <fork>
  82:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  86:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  8b:	79 19                	jns    a6 <main+0xa6>
      printf(1, "init: fork failed\n");
  8d:	c7 44 24 04 b8 0a 00 	movl   $0xab8,0x4(%esp)
  94:	00 
  95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9c:	e8 b6 04 00 00       	call   557 <printf>
      exit();
  a1:	e8 d1 02 00 00       	call   377 <exit>
    }
    if(pid == 0){
  a6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  ab:	75 2d                	jne    da <main+0xda>
      exec("sh", argv);
  ad:	c7 44 24 04 e0 0e 00 	movl   $0xee0,0x4(%esp)
  b4:	00 
  b5:	c7 04 24 9a 0a 00 00 	movl   $0xa9a,(%esp)
  bc:	e8 ee 02 00 00       	call   3af <exec>
      printf(1, "init: exec sh failed\n");
  c1:	c7 44 24 04 cb 0a 00 	movl   $0xacb,0x4(%esp)
  c8:	00 
  c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d0:	e8 82 04 00 00       	call   557 <printf>
      exit();
  d5:	e8 9d 02 00 00       	call   377 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  da:	eb 14                	jmp    f0 <main+0xf0>
      printf(1, "zombie!\n");
  dc:	c7 44 24 04 e1 0a 00 	movl   $0xae1,0x4(%esp)
  e3:	00 
  e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  eb:	e8 67 04 00 00       	call   557 <printf>
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
SYSCALL(kthread_cond_broadcast)
 467:	b8 20 00 00 00       	mov    $0x20,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <kthread_exit>:
 46f:	b8 21 00 00 00       	mov    $0x21,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 477:	55                   	push   %ebp
 478:	89 e5                	mov    %esp,%ebp
 47a:	83 ec 18             	sub    $0x18,%esp
 47d:	8b 45 0c             	mov    0xc(%ebp),%eax
 480:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 483:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48a:	00 
 48b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 48e:	89 44 24 04          	mov    %eax,0x4(%esp)
 492:	8b 45 08             	mov    0x8(%ebp),%eax
 495:	89 04 24             	mov    %eax,(%esp)
 498:	e8 fa fe ff ff       	call   397 <write>
}
 49d:	c9                   	leave  
 49e:	c3                   	ret    

0000049f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49f:	55                   	push   %ebp
 4a0:	89 e5                	mov    %esp,%ebp
 4a2:	56                   	push   %esi
 4a3:	53                   	push   %ebx
 4a4:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4ae:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4b2:	74 17                	je     4cb <printint+0x2c>
 4b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4b8:	79 11                	jns    4cb <printint+0x2c>
    neg = 1;
 4ba:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c4:	f7 d8                	neg    %eax
 4c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c9:	eb 06                	jmp    4d1 <printint+0x32>
  } else {
    x = xx;
 4cb:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4d8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4db:	8d 41 01             	lea    0x1(%ecx),%eax
 4de:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4e1:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4e7:	ba 00 00 00 00       	mov    $0x0,%edx
 4ec:	f7 f3                	div    %ebx
 4ee:	89 d0                	mov    %edx,%eax
 4f0:	0f b6 80 e8 0e 00 00 	movzbl 0xee8(%eax),%eax
 4f7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4fb:	8b 75 10             	mov    0x10(%ebp),%esi
 4fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
 501:	ba 00 00 00 00       	mov    $0x0,%edx
 506:	f7 f6                	div    %esi
 508:	89 45 ec             	mov    %eax,-0x14(%ebp)
 50b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50f:	75 c7                	jne    4d8 <printint+0x39>
  if(neg)
 511:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 515:	74 10                	je     527 <printint+0x88>
    buf[i++] = '-';
 517:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51a:	8d 50 01             	lea    0x1(%eax),%edx
 51d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 520:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 525:	eb 1f                	jmp    546 <printint+0xa7>
 527:	eb 1d                	jmp    546 <printint+0xa7>
    putc(fd, buf[i]);
 529:	8d 55 dc             	lea    -0x24(%ebp),%edx
 52c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52f:	01 d0                	add    %edx,%eax
 531:	0f b6 00             	movzbl (%eax),%eax
 534:	0f be c0             	movsbl %al,%eax
 537:	89 44 24 04          	mov    %eax,0x4(%esp)
 53b:	8b 45 08             	mov    0x8(%ebp),%eax
 53e:	89 04 24             	mov    %eax,(%esp)
 541:	e8 31 ff ff ff       	call   477 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 546:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 54a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 54e:	79 d9                	jns    529 <printint+0x8a>
    putc(fd, buf[i]);
}
 550:	83 c4 30             	add    $0x30,%esp
 553:	5b                   	pop    %ebx
 554:	5e                   	pop    %esi
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    

00000557 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 557:	55                   	push   %ebp
 558:	89 e5                	mov    %esp,%ebp
 55a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 55d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 564:	8d 45 0c             	lea    0xc(%ebp),%eax
 567:	83 c0 04             	add    $0x4,%eax
 56a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 56d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 574:	e9 7c 01 00 00       	jmp    6f5 <printf+0x19e>
    c = fmt[i] & 0xff;
 579:	8b 55 0c             	mov    0xc(%ebp),%edx
 57c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 57f:	01 d0                	add    %edx,%eax
 581:	0f b6 00             	movzbl (%eax),%eax
 584:	0f be c0             	movsbl %al,%eax
 587:	25 ff 00 00 00       	and    $0xff,%eax
 58c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 58f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 593:	75 2c                	jne    5c1 <printf+0x6a>
      if(c == '%'){
 595:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 599:	75 0c                	jne    5a7 <printf+0x50>
        state = '%';
 59b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5a2:	e9 4a 01 00 00       	jmp    6f1 <printf+0x19a>
      } else {
        putc(fd, c);
 5a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	89 04 24             	mov    %eax,(%esp)
 5b7:	e8 bb fe ff ff       	call   477 <putc>
 5bc:	e9 30 01 00 00       	jmp    6f1 <printf+0x19a>
      }
    } else if(state == '%'){
 5c1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5c5:	0f 85 26 01 00 00    	jne    6f1 <printf+0x19a>
      if(c == 'd'){
 5cb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5cf:	75 2d                	jne    5fe <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5dd:	00 
 5de:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5e5:	00 
 5e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ea:	8b 45 08             	mov    0x8(%ebp),%eax
 5ed:	89 04 24             	mov    %eax,(%esp)
 5f0:	e8 aa fe ff ff       	call   49f <printint>
        ap++;
 5f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f9:	e9 ec 00 00 00       	jmp    6ea <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5fe:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 602:	74 06                	je     60a <printf+0xb3>
 604:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 608:	75 2d                	jne    637 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 60a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60d:	8b 00                	mov    (%eax),%eax
 60f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 616:	00 
 617:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 61e:	00 
 61f:	89 44 24 04          	mov    %eax,0x4(%esp)
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	89 04 24             	mov    %eax,(%esp)
 629:	e8 71 fe ff ff       	call   49f <printint>
        ap++;
 62e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 632:	e9 b3 00 00 00       	jmp    6ea <printf+0x193>
      } else if(c == 's'){
 637:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 63b:	75 45                	jne    682 <printf+0x12b>
        s = (char*)*ap;
 63d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 645:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 649:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 64d:	75 09                	jne    658 <printf+0x101>
          s = "(null)";
 64f:	c7 45 f4 ea 0a 00 00 	movl   $0xaea,-0xc(%ebp)
        while(*s != 0){
 656:	eb 1e                	jmp    676 <printf+0x11f>
 658:	eb 1c                	jmp    676 <printf+0x11f>
          putc(fd, *s);
 65a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 65d:	0f b6 00             	movzbl (%eax),%eax
 660:	0f be c0             	movsbl %al,%eax
 663:	89 44 24 04          	mov    %eax,0x4(%esp)
 667:	8b 45 08             	mov    0x8(%ebp),%eax
 66a:	89 04 24             	mov    %eax,(%esp)
 66d:	e8 05 fe ff ff       	call   477 <putc>
          s++;
 672:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 676:	8b 45 f4             	mov    -0xc(%ebp),%eax
 679:	0f b6 00             	movzbl (%eax),%eax
 67c:	84 c0                	test   %al,%al
 67e:	75 da                	jne    65a <printf+0x103>
 680:	eb 68                	jmp    6ea <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 682:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 686:	75 1d                	jne    6a5 <printf+0x14e>
        putc(fd, *ap);
 688:	8b 45 e8             	mov    -0x18(%ebp),%eax
 68b:	8b 00                	mov    (%eax),%eax
 68d:	0f be c0             	movsbl %al,%eax
 690:	89 44 24 04          	mov    %eax,0x4(%esp)
 694:	8b 45 08             	mov    0x8(%ebp),%eax
 697:	89 04 24             	mov    %eax,(%esp)
 69a:	e8 d8 fd ff ff       	call   477 <putc>
        ap++;
 69f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6a3:	eb 45                	jmp    6ea <printf+0x193>
      } else if(c == '%'){
 6a5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6a9:	75 17                	jne    6c2 <printf+0x16b>
        putc(fd, c);
 6ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ae:	0f be c0             	movsbl %al,%eax
 6b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b5:	8b 45 08             	mov    0x8(%ebp),%eax
 6b8:	89 04 24             	mov    %eax,(%esp)
 6bb:	e8 b7 fd ff ff       	call   477 <putc>
 6c0:	eb 28                	jmp    6ea <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6c2:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6c9:	00 
 6ca:	8b 45 08             	mov    0x8(%ebp),%eax
 6cd:	89 04 24             	mov    %eax,(%esp)
 6d0:	e8 a2 fd ff ff       	call   477 <putc>
        putc(fd, c);
 6d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d8:	0f be c0             	movsbl %al,%eax
 6db:	89 44 24 04          	mov    %eax,0x4(%esp)
 6df:	8b 45 08             	mov    0x8(%ebp),%eax
 6e2:	89 04 24             	mov    %eax,(%esp)
 6e5:	e8 8d fd ff ff       	call   477 <putc>
      }
      state = 0;
 6ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6f5:	8b 55 0c             	mov    0xc(%ebp),%edx
 6f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fb:	01 d0                	add    %edx,%eax
 6fd:	0f b6 00             	movzbl (%eax),%eax
 700:	84 c0                	test   %al,%al
 702:	0f 85 71 fe ff ff    	jne    579 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 708:	c9                   	leave  
 709:	c3                   	ret    

0000070a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 70a:	55                   	push   %ebp
 70b:	89 e5                	mov    %esp,%ebp
 70d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 710:	8b 45 08             	mov    0x8(%ebp),%eax
 713:	83 e8 08             	sub    $0x8,%eax
 716:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 719:	a1 04 0f 00 00       	mov    0xf04,%eax
 71e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 721:	eb 24                	jmp    747 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	8b 00                	mov    (%eax),%eax
 728:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72b:	77 12                	ja     73f <free+0x35>
 72d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 730:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 733:	77 24                	ja     759 <free+0x4f>
 735:	8b 45 fc             	mov    -0x4(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73d:	77 1a                	ja     759 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 742:	8b 00                	mov    (%eax),%eax
 744:	89 45 fc             	mov    %eax,-0x4(%ebp)
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 74d:	76 d4                	jbe    723 <free+0x19>
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	8b 00                	mov    (%eax),%eax
 754:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 757:	76 ca                	jbe    723 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 759:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75c:	8b 40 04             	mov    0x4(%eax),%eax
 75f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 766:	8b 45 f8             	mov    -0x8(%ebp),%eax
 769:	01 c2                	add    %eax,%edx
 76b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76e:	8b 00                	mov    (%eax),%eax
 770:	39 c2                	cmp    %eax,%edx
 772:	75 24                	jne    798 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 774:	8b 45 f8             	mov    -0x8(%ebp),%eax
 777:	8b 50 04             	mov    0x4(%eax),%edx
 77a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77d:	8b 00                	mov    (%eax),%eax
 77f:	8b 40 04             	mov    0x4(%eax),%eax
 782:	01 c2                	add    %eax,%edx
 784:	8b 45 f8             	mov    -0x8(%ebp),%eax
 787:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 78a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78d:	8b 00                	mov    (%eax),%eax
 78f:	8b 10                	mov    (%eax),%edx
 791:	8b 45 f8             	mov    -0x8(%ebp),%eax
 794:	89 10                	mov    %edx,(%eax)
 796:	eb 0a                	jmp    7a2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 10                	mov    (%eax),%edx
 79d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 40 04             	mov    0x4(%eax),%eax
 7a8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b2:	01 d0                	add    %edx,%eax
 7b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7b7:	75 20                	jne    7d9 <free+0xcf>
    p->s.size += bp->s.size;
 7b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bc:	8b 50 04             	mov    0x4(%eax),%edx
 7bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c2:	8b 40 04             	mov    0x4(%eax),%eax
 7c5:	01 c2                	add    %eax,%edx
 7c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ca:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d0:	8b 10                	mov    (%eax),%edx
 7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d5:	89 10                	mov    %edx,(%eax)
 7d7:	eb 08                	jmp    7e1 <free+0xd7>
  } else
    p->s.ptr = bp;
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7df:	89 10                	mov    %edx,(%eax)
  freep = p;
 7e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e4:	a3 04 0f 00 00       	mov    %eax,0xf04
}
 7e9:	c9                   	leave  
 7ea:	c3                   	ret    

000007eb <morecore>:

static Header*
morecore(uint nu)
{
 7eb:	55                   	push   %ebp
 7ec:	89 e5                	mov    %esp,%ebp
 7ee:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7f1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7f8:	77 07                	ja     801 <morecore+0x16>
    nu = 4096;
 7fa:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 801:	8b 45 08             	mov    0x8(%ebp),%eax
 804:	c1 e0 03             	shl    $0x3,%eax
 807:	89 04 24             	mov    %eax,(%esp)
 80a:	e8 f0 fb ff ff       	call   3ff <sbrk>
 80f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 812:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 816:	75 07                	jne    81f <morecore+0x34>
    return 0;
 818:	b8 00 00 00 00       	mov    $0x0,%eax
 81d:	eb 22                	jmp    841 <morecore+0x56>
  hp = (Header*)p;
 81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 822:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 825:	8b 45 f0             	mov    -0x10(%ebp),%eax
 828:	8b 55 08             	mov    0x8(%ebp),%edx
 82b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 831:	83 c0 08             	add    $0x8,%eax
 834:	89 04 24             	mov    %eax,(%esp)
 837:	e8 ce fe ff ff       	call   70a <free>
  return freep;
 83c:	a1 04 0f 00 00       	mov    0xf04,%eax
}
 841:	c9                   	leave  
 842:	c3                   	ret    

00000843 <malloc>:

void*
malloc(uint nbytes)
{
 843:	55                   	push   %ebp
 844:	89 e5                	mov    %esp,%ebp
 846:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 849:	8b 45 08             	mov    0x8(%ebp),%eax
 84c:	83 c0 07             	add    $0x7,%eax
 84f:	c1 e8 03             	shr    $0x3,%eax
 852:	83 c0 01             	add    $0x1,%eax
 855:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 858:	a1 04 0f 00 00       	mov    0xf04,%eax
 85d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 860:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 864:	75 23                	jne    889 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 866:	c7 45 f0 fc 0e 00 00 	movl   $0xefc,-0x10(%ebp)
 86d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 870:	a3 04 0f 00 00       	mov    %eax,0xf04
 875:	a1 04 0f 00 00       	mov    0xf04,%eax
 87a:	a3 fc 0e 00 00       	mov    %eax,0xefc
    base.s.size = 0;
 87f:	c7 05 00 0f 00 00 00 	movl   $0x0,0xf00
 886:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 889:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88c:	8b 00                	mov    (%eax),%eax
 88e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 891:	8b 45 f4             	mov    -0xc(%ebp),%eax
 894:	8b 40 04             	mov    0x4(%eax),%eax
 897:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 89a:	72 4d                	jb     8e9 <malloc+0xa6>
      if(p->s.size == nunits)
 89c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89f:	8b 40 04             	mov    0x4(%eax),%eax
 8a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8a5:	75 0c                	jne    8b3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8aa:	8b 10                	mov    (%eax),%edx
 8ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8af:	89 10                	mov    %edx,(%eax)
 8b1:	eb 26                	jmp    8d9 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b6:	8b 40 04             	mov    0x4(%eax),%eax
 8b9:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8bc:	89 c2                	mov    %eax,%edx
 8be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c7:	8b 40 04             	mov    0x4(%eax),%eax
 8ca:	c1 e0 03             	shl    $0x3,%eax
 8cd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8d6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8dc:	a3 04 0f 00 00       	mov    %eax,0xf04
      return (void*)(p + 1);
 8e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e4:	83 c0 08             	add    $0x8,%eax
 8e7:	eb 38                	jmp    921 <malloc+0xde>
    }
    if(p == freep)
 8e9:	a1 04 0f 00 00       	mov    0xf04,%eax
 8ee:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8f1:	75 1b                	jne    90e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8f6:	89 04 24             	mov    %eax,(%esp)
 8f9:	e8 ed fe ff ff       	call   7eb <morecore>
 8fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
 901:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 905:	75 07                	jne    90e <malloc+0xcb>
        return 0;
 907:	b8 00 00 00 00       	mov    $0x0,%eax
 90c:	eb 13                	jmp    921 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 911:	89 45 f0             	mov    %eax,-0x10(%ebp)
 914:	8b 45 f4             	mov    -0xc(%ebp),%eax
 917:	8b 00                	mov    (%eax),%eax
 919:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 91c:	e9 70 ff ff ff       	jmp    891 <malloc+0x4e>
}
 921:	c9                   	leave  
 922:	c3                   	ret    

00000923 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 923:	55                   	push   %ebp
 924:	89 e5                	mov    %esp,%ebp
 926:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 929:	8b 45 0c             	mov    0xc(%ebp),%eax
 92c:	89 04 24             	mov    %eax,(%esp)
 92f:	8b 45 08             	mov    0x8(%ebp),%eax
 932:	ff d0                	call   *%eax
    exit();
 934:	e8 3e fa ff ff       	call   377 <exit>

00000939 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 939:	55                   	push   %ebp
 93a:	89 e5                	mov    %esp,%ebp
 93c:	57                   	push   %edi
 93d:	56                   	push   %esi
 93e:	53                   	push   %ebx
 93f:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 942:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 949:	e8 f5 fe ff ff       	call   843 <malloc>
 94e:	8b 55 08             	mov    0x8(%ebp),%edx
 951:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 953:	8b 45 10             	mov    0x10(%ebp),%eax
 956:	8b 38                	mov    (%eax),%edi
 958:	8b 75 0c             	mov    0xc(%ebp),%esi
 95b:	bb 23 09 00 00       	mov    $0x923,%ebx
 960:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 967:	e8 d7 fe ff ff       	call   843 <malloc>
 96c:	05 00 10 00 00       	add    $0x1000,%eax
 971:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 975:	89 74 24 08          	mov    %esi,0x8(%esp)
 979:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 97d:	89 04 24             	mov    %eax,(%esp)
 980:	e8 92 fa ff ff       	call   417 <kthread_create>
 985:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 988:	8b 45 08             	mov    0x8(%ebp),%eax
 98b:	8b 00                	mov    (%eax),%eax
 98d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 990:	89 10                	mov    %edx,(%eax)
    return t_id;
 992:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 995:	83 c4 2c             	add    $0x2c,%esp
 998:	5b                   	pop    %ebx
 999:	5e                   	pop    %esi
 99a:	5f                   	pop    %edi
 99b:	5d                   	pop    %ebp
 99c:	c3                   	ret    

0000099d <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 99d:	55                   	push   %ebp
 99e:	89 e5                	mov    %esp,%ebp
 9a0:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 9a3:	8b 55 0c             	mov    0xc(%ebp),%edx
 9a6:	8b 45 08             	mov    0x8(%ebp),%eax
 9a9:	8b 00                	mov    (%eax),%eax
 9ab:	89 54 24 04          	mov    %edx,0x4(%esp)
 9af:	89 04 24             	mov    %eax,(%esp)
 9b2:	e8 68 fa ff ff       	call   41f <kthread_join>
 9b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9bd:	c9                   	leave  
 9be:	c3                   	ret    

000009bf <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 9bf:	55                   	push   %ebp
 9c0:	89 e5                	mov    %esp,%ebp
 9c2:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 9c5:	e8 5d fa ff ff       	call   427 <kthread_mutex_init>
 9ca:	8b 55 08             	mov    0x8(%ebp),%edx
 9cd:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 9cf:	8b 45 08             	mov    0x8(%ebp),%eax
 9d2:	8b 00                	mov    (%eax),%eax
 9d4:	85 c0                	test   %eax,%eax
 9d6:	7e 07                	jle    9df <qthread_mutex_init+0x20>
		return 0;
 9d8:	b8 00 00 00 00       	mov    $0x0,%eax
 9dd:	eb 05                	jmp    9e4 <qthread_mutex_init+0x25>
	}
	return *mutex;
 9df:	8b 45 08             	mov    0x8(%ebp),%eax
 9e2:	8b 00                	mov    (%eax),%eax
}
 9e4:	c9                   	leave  
 9e5:	c3                   	ret    

000009e6 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 9e6:	55                   	push   %ebp
 9e7:	89 e5                	mov    %esp,%ebp
 9e9:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 9ec:	8b 45 08             	mov    0x8(%ebp),%eax
 9ef:	89 04 24             	mov    %eax,(%esp)
 9f2:	e8 38 fa ff ff       	call   42f <kthread_mutex_destroy>
 9f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9fe:	79 07                	jns    a07 <qthread_mutex_destroy+0x21>
    	return -1;
 a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a05:	eb 05                	jmp    a0c <qthread_mutex_destroy+0x26>
    }
    return 0;
 a07:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a0c:	c9                   	leave  
 a0d:	c3                   	ret    

00000a0e <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 a0e:	55                   	push   %ebp
 a0f:	89 e5                	mov    %esp,%ebp
 a11:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 a14:	8b 45 08             	mov    0x8(%ebp),%eax
 a17:	89 04 24             	mov    %eax,(%esp)
 a1a:	e8 18 fa ff ff       	call   437 <kthread_mutex_lock>
 a1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a26:	79 07                	jns    a2f <qthread_mutex_lock+0x21>
    	return -1;
 a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a2d:	eb 05                	jmp    a34 <qthread_mutex_lock+0x26>
    }
    return 0;
 a2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a34:	c9                   	leave  
 a35:	c3                   	ret    

00000a36 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a36:	55                   	push   %ebp
 a37:	89 e5                	mov    %esp,%ebp
 a39:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a3c:	8b 45 08             	mov    0x8(%ebp),%eax
 a3f:	89 04 24             	mov    %eax,(%esp)
 a42:	e8 f8 f9 ff ff       	call   43f <kthread_mutex_unlock>
 a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a4a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a4e:	79 07                	jns    a57 <qthread_mutex_unlock+0x21>
    	return -1;
 a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a55:	eb 05                	jmp    a5c <qthread_mutex_unlock+0x26>
    }
    return 0;
 a57:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a5c:	c9                   	leave  
 a5d:	c3                   	ret    

00000a5e <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 a5e:	55                   	push   %ebp
 a5f:	89 e5                	mov    %esp,%ebp

	return 0;
 a61:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a66:	5d                   	pop    %ebp
 a67:	c3                   	ret    

00000a68 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 a68:	55                   	push   %ebp
 a69:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a6b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a70:	5d                   	pop    %ebp
 a71:	c3                   	ret    

00000a72 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 a72:	55                   	push   %ebp
 a73:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a75:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a7a:	5d                   	pop    %ebp
 a7b:	c3                   	ret    

00000a7c <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 a7c:	55                   	push   %ebp
 a7d:	89 e5                	mov    %esp,%ebp
	return 0;
 a7f:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a84:	5d                   	pop    %ebp
 a85:	c3                   	ret    

00000a86 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 a86:	55                   	push   %ebp
 a87:	89 e5                	mov    %esp,%ebp
	return 0;
 a89:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a8e:	5d                   	pop    %ebp
 a8f:	c3                   	ret    

00000a90 <qthread_exit>:

int qthread_exit(){
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
	return 0;
 a93:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a98:	5d                   	pop    %ebp
 a99:	c3                   	ret    
