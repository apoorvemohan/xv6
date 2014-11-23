
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
  11:	c7 04 24 88 0a 00 00 	movl   $0xa88,(%esp)
  18:	e8 9b 03 00 00       	call   3b8 <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 88 0a 00 00 	movl   $0xa88,(%esp)
  38:	e8 83 03 00 00       	call   3c0 <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 88 0a 00 00 	movl   $0xa88,(%esp)
  4c:	e8 67 03 00 00       	call   3b8 <open>
  }
  dup(0);  // stdout
  51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  58:	e8 93 03 00 00       	call   3f0 <dup>
  dup(0);  // stderr
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 87 03 00 00       	call   3f0 <dup>
  69:	eb 01                	jmp    6c <main+0x6c>
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  }
  6b:	90                   	nop
  }
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
  6c:	c7 44 24 04 90 0a 00 	movl   $0xa90,0x4(%esp)
  73:	00 
  74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7b:	e8 cf 04 00 00       	call   54f <printf>
    pid = fork();
  80:	e8 eb 02 00 00       	call   370 <fork>
  85:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  89:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  8e:	79 19                	jns    a9 <main+0xa9>
      printf(1, "init: fork failed\n");
  90:	c7 44 24 04 a3 0a 00 	movl   $0xaa3,0x4(%esp)
  97:	00 
  98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9f:	e8 ab 04 00 00       	call   54f <printf>
      exit();
  a4:	e8 cf 02 00 00       	call   378 <exit>
    }
    if(pid == 0){
  a9:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  ae:	75 41                	jne    f1 <main+0xf1>
      exec("sh", argv);
  b0:	c7 44 24 04 c0 0e 00 	movl   $0xec0,0x4(%esp)
  b7:	00 
  b8:	c7 04 24 85 0a 00 00 	movl   $0xa85,(%esp)
  bf:	e8 ec 02 00 00       	call   3b0 <exec>
      printf(1, "init: exec sh failed\n");
  c4:	c7 44 24 04 b6 0a 00 	movl   $0xab6,0x4(%esp)
  cb:	00 
  cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d3:	e8 77 04 00 00       	call   54f <printf>
      exit();
  d8:	e8 9b 02 00 00       	call   378 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  dd:	c7 44 24 04 cc 0a 00 	movl   $0xacc,0x4(%esp)
  e4:	00 
  e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ec:	e8 5e 04 00 00       	call   54f <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  f1:	e8 8a 02 00 00       	call   380 <wait>
  f6:	89 44 24 18          	mov    %eax,0x18(%esp)
  fa:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  ff:	0f 88 66 ff ff ff    	js     6b <main+0x6b>
 105:	8b 44 24 18          	mov    0x18(%esp),%eax
 109:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 10d:	75 ce                	jne    dd <main+0xdd>
      printf(1, "zombie!\n");
  }
 10f:	e9 57 ff ff ff       	jmp    6b <main+0x6b>

00000114 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 119:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11c:	8b 55 10             	mov    0x10(%ebp),%edx
 11f:	8b 45 0c             	mov    0xc(%ebp),%eax
 122:	89 cb                	mov    %ecx,%ebx
 124:	89 df                	mov    %ebx,%edi
 126:	89 d1                	mov    %edx,%ecx
 128:	fc                   	cld    
 129:	f3 aa                	rep stos %al,%es:(%edi)
 12b:	89 ca                	mov    %ecx,%edx
 12d:	89 fb                	mov    %edi,%ebx
 12f:	89 5d 08             	mov    %ebx,0x8(%ebp)
 132:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 135:	5b                   	pop    %ebx
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 145:	90                   	nop
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	0f b6 10             	movzbl (%eax),%edx
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	88 10                	mov    %dl,(%eax)
 151:	8b 45 08             	mov    0x8(%ebp),%eax
 154:	0f b6 00             	movzbl (%eax),%eax
 157:	84 c0                	test   %al,%al
 159:	0f 95 c0             	setne  %al
 15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 164:	84 c0                	test   %al,%al
 166:	75 de                	jne    146 <strcpy+0xd>
    ;
  return os;
 168:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16b:	c9                   	leave  
 16c:	c3                   	ret    

0000016d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16d:	55                   	push   %ebp
 16e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 170:	eb 08                	jmp    17a <strcmp+0xd>
    p++, q++;
 172:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 176:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	0f b6 00             	movzbl (%eax),%eax
 180:	84 c0                	test   %al,%al
 182:	74 10                	je     194 <strcmp+0x27>
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 10             	movzbl (%eax),%edx
 18a:	8b 45 0c             	mov    0xc(%ebp),%eax
 18d:	0f b6 00             	movzbl (%eax),%eax
 190:	38 c2                	cmp    %al,%dl
 192:	74 de                	je     172 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	0f b6 00             	movzbl (%eax),%eax
 19a:	0f b6 d0             	movzbl %al,%edx
 19d:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a0:	0f b6 00             	movzbl (%eax),%eax
 1a3:	0f b6 c0             	movzbl %al,%eax
 1a6:	89 d1                	mov    %edx,%ecx
 1a8:	29 c1                	sub    %eax,%ecx
 1aa:	89 c8                	mov    %ecx,%eax
}
 1ac:	5d                   	pop    %ebp
 1ad:	c3                   	ret    

000001ae <strlen>:

uint
strlen(char *s)
{
 1ae:	55                   	push   %ebp
 1af:	89 e5                	mov    %esp,%ebp
 1b1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1bb:	eb 04                	jmp    1c1 <strlen+0x13>
 1bd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1c4:	03 45 08             	add    0x8(%ebp),%eax
 1c7:	0f b6 00             	movzbl (%eax),%eax
 1ca:	84 c0                	test   %al,%al
 1cc:	75 ef                	jne    1bd <strlen+0xf>
    ;
  return n;
 1ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d1:	c9                   	leave  
 1d2:	c3                   	ret    

000001d3 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d3:	55                   	push   %ebp
 1d4:	89 e5                	mov    %esp,%ebp
 1d6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1d9:	8b 45 10             	mov    0x10(%ebp),%eax
 1dc:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	89 04 24             	mov    %eax,(%esp)
 1ed:	e8 22 ff ff ff       	call   114 <stosb>
  return dst;
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    

000001f7 <strchr>:

char*
strchr(const char *s, char c)
{
 1f7:	55                   	push   %ebp
 1f8:	89 e5                	mov    %esp,%ebp
 1fa:	83 ec 04             	sub    $0x4,%esp
 1fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 200:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 203:	eb 14                	jmp    219 <strchr+0x22>
    if(*s == c)
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	0f b6 00             	movzbl (%eax),%eax
 20b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 20e:	75 05                	jne    215 <strchr+0x1e>
      return (char*)s;
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	eb 13                	jmp    228 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 215:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	0f b6 00             	movzbl (%eax),%eax
 21f:	84 c0                	test   %al,%al
 221:	75 e2                	jne    205 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 223:	b8 00 00 00 00       	mov    $0x0,%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <gets>:

char*
gets(char *buf, int max)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 230:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 237:	eb 44                	jmp    27d <gets+0x53>
    cc = read(0, &c, 1);
 239:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 240:	00 
 241:	8d 45 ef             	lea    -0x11(%ebp),%eax
 244:	89 44 24 04          	mov    %eax,0x4(%esp)
 248:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 24f:	e8 3c 01 00 00       	call   390 <read>
 254:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 257:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 25b:	7e 2d                	jle    28a <gets+0x60>
      break;
    buf[i++] = c;
 25d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 260:	03 45 08             	add    0x8(%ebp),%eax
 263:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 267:	88 10                	mov    %dl,(%eax)
 269:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 26d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 271:	3c 0a                	cmp    $0xa,%al
 273:	74 16                	je     28b <gets+0x61>
 275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 279:	3c 0d                	cmp    $0xd,%al
 27b:	74 0e                	je     28b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 280:	83 c0 01             	add    $0x1,%eax
 283:	3b 45 0c             	cmp    0xc(%ebp),%eax
 286:	7c b1                	jl     239 <gets+0xf>
 288:	eb 01                	jmp    28b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 28a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 28b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28e:	03 45 08             	add    0x8(%ebp),%eax
 291:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
}
 297:	c9                   	leave  
 298:	c3                   	ret    

00000299 <stat>:

int
stat(char *n, struct stat *st)
{
 299:	55                   	push   %ebp
 29a:	89 e5                	mov    %esp,%ebp
 29c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a6:	00 
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	89 04 24             	mov    %eax,(%esp)
 2ad:	e8 06 01 00 00       	call   3b8 <open>
 2b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b9:	79 07                	jns    2c2 <stat+0x29>
    return -1;
 2bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c0:	eb 23                	jmp    2e5 <stat+0x4c>
  r = fstat(fd, st);
 2c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2cc:	89 04 24             	mov    %eax,(%esp)
 2cf:	e8 fc 00 00 00       	call   3d0 <fstat>
 2d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2da:	89 04 24             	mov    %eax,(%esp)
 2dd:	e8 be 00 00 00       	call   3a0 <close>
  return r;
 2e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e5:	c9                   	leave  
 2e6:	c3                   	ret    

000002e7 <atoi>:

int
atoi(const char *s)
{
 2e7:	55                   	push   %ebp
 2e8:	89 e5                	mov    %esp,%ebp
 2ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f4:	eb 23                	jmp    319 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f9:	89 d0                	mov    %edx,%eax
 2fb:	c1 e0 02             	shl    $0x2,%eax
 2fe:	01 d0                	add    %edx,%eax
 300:	01 c0                	add    %eax,%eax
 302:	89 c2                	mov    %eax,%edx
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	0f b6 00             	movzbl (%eax),%eax
 30a:	0f be c0             	movsbl %al,%eax
 30d:	01 d0                	add    %edx,%eax
 30f:	83 e8 30             	sub    $0x30,%eax
 312:	89 45 fc             	mov    %eax,-0x4(%ebp)
 315:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	3c 2f                	cmp    $0x2f,%al
 321:	7e 0a                	jle    32d <atoi+0x46>
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	0f b6 00             	movzbl (%eax),%eax
 329:	3c 39                	cmp    $0x39,%al
 32b:	7e c9                	jle    2f6 <atoi+0xf>
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
 344:	eb 13                	jmp    359 <memmove+0x27>
    *dst++ = *src++;
 346:	8b 45 f8             	mov    -0x8(%ebp),%eax
 349:	0f b6 10             	movzbl (%eax),%edx
 34c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 34f:	88 10                	mov    %dl,(%eax)
 351:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 355:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 359:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 35d:	0f 9f c0             	setg   %al
 360:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 364:	84 c0                	test   %al,%al
 366:	75 de                	jne    346 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 368:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36b:	c9                   	leave  
 36c:	c3                   	ret    
 36d:	90                   	nop
 36e:	90                   	nop
 36f:	90                   	nop

00000370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 370:	b8 01 00 00 00       	mov    $0x1,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exit>:
SYSCALL(exit)
 378:	b8 02 00 00 00       	mov    $0x2,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <wait>:
SYSCALL(wait)
 380:	b8 03 00 00 00       	mov    $0x3,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <pipe>:
SYSCALL(pipe)
 388:	b8 04 00 00 00       	mov    $0x4,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <read>:
SYSCALL(read)
 390:	b8 05 00 00 00       	mov    $0x5,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <write>:
SYSCALL(write)
 398:	b8 10 00 00 00       	mov    $0x10,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <close>:
SYSCALL(close)
 3a0:	b8 15 00 00 00       	mov    $0x15,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kill>:
SYSCALL(kill)
 3a8:	b8 06 00 00 00       	mov    $0x6,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <exec>:
SYSCALL(exec)
 3b0:	b8 07 00 00 00       	mov    $0x7,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <open>:
SYSCALL(open)
 3b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <mknod>:
SYSCALL(mknod)
 3c0:	b8 11 00 00 00       	mov    $0x11,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <unlink>:
SYSCALL(unlink)
 3c8:	b8 12 00 00 00       	mov    $0x12,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <fstat>:
SYSCALL(fstat)
 3d0:	b8 08 00 00 00       	mov    $0x8,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <link>:
SYSCALL(link)
 3d8:	b8 13 00 00 00       	mov    $0x13,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <mkdir>:
SYSCALL(mkdir)
 3e0:	b8 14 00 00 00       	mov    $0x14,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <chdir>:
SYSCALL(chdir)
 3e8:	b8 09 00 00 00       	mov    $0x9,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <dup>:
SYSCALL(dup)
 3f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <getpid>:
SYSCALL(getpid)
 3f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <sbrk>:
SYSCALL(sbrk)
 400:	b8 0c 00 00 00       	mov    $0xc,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <sleep>:
SYSCALL(sleep)
 408:	b8 0d 00 00 00       	mov    $0xd,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <uptime>:
SYSCALL(uptime)
 410:	b8 0e 00 00 00       	mov    $0xe,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <kthread_create>:
SYSCALL(kthread_create)
 418:	b8 17 00 00 00       	mov    $0x17,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <kthread_join>:
SYSCALL(kthread_join)
 420:	b8 16 00 00 00       	mov    $0x16,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 428:	b8 18 00 00 00       	mov    $0x18,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 430:	b8 19 00 00 00       	mov    $0x19,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 438:	b8 1a 00 00 00       	mov    $0x1a,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 440:	b8 1b 00 00 00       	mov    $0x1b,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 448:	b8 1c 00 00 00       	mov    $0x1c,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 450:	b8 1d 00 00 00       	mov    $0x1d,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 458:	b8 1e 00 00 00       	mov    $0x1e,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 460:	b8 1f 00 00 00       	mov    $0x1f,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 468:	b8 20 00 00 00       	mov    $0x20,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <kthread_exit>:
 470:	b8 21 00 00 00       	mov    $0x21,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 478:	55                   	push   %ebp
 479:	89 e5                	mov    %esp,%ebp
 47b:	83 ec 28             	sub    $0x28,%esp
 47e:	8b 45 0c             	mov    0xc(%ebp),%eax
 481:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 484:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48b:	00 
 48c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 48f:	89 44 24 04          	mov    %eax,0x4(%esp)
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	89 04 24             	mov    %eax,(%esp)
 499:	e8 fa fe ff ff       	call   398 <write>
}
 49e:	c9                   	leave  
 49f:	c3                   	ret    

000004a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4ad:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4b1:	74 17                	je     4ca <printint+0x2a>
 4b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4b7:	79 11                	jns    4ca <printint+0x2a>
    neg = 1;
 4b9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c3:	f7 d8                	neg    %eax
 4c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c8:	eb 06                	jmp    4d0 <printint+0x30>
  } else {
    x = xx;
 4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4da:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4dd:	ba 00 00 00 00       	mov    $0x0,%edx
 4e2:	f7 f1                	div    %ecx
 4e4:	89 d0                	mov    %edx,%eax
 4e6:	0f b6 90 c8 0e 00 00 	movzbl 0xec8(%eax),%edx
 4ed:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4f0:	03 45 f4             	add    -0xc(%ebp),%eax
 4f3:	88 10                	mov    %dl,(%eax)
 4f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 4f9:	8b 55 10             	mov    0x10(%ebp),%edx
 4fc:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
 502:	ba 00 00 00 00       	mov    $0x0,%edx
 507:	f7 75 d4             	divl   -0x2c(%ebp)
 50a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 50d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 511:	75 c4                	jne    4d7 <printint+0x37>
  if(neg)
 513:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 517:	74 2a                	je     543 <printint+0xa3>
    buf[i++] = '-';
 519:	8d 45 dc             	lea    -0x24(%ebp),%eax
 51c:	03 45 f4             	add    -0xc(%ebp),%eax
 51f:	c6 00 2d             	movb   $0x2d,(%eax)
 522:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 526:	eb 1b                	jmp    543 <printint+0xa3>
    putc(fd, buf[i]);
 528:	8d 45 dc             	lea    -0x24(%ebp),%eax
 52b:	03 45 f4             	add    -0xc(%ebp),%eax
 52e:	0f b6 00             	movzbl (%eax),%eax
 531:	0f be c0             	movsbl %al,%eax
 534:	89 44 24 04          	mov    %eax,0x4(%esp)
 538:	8b 45 08             	mov    0x8(%ebp),%eax
 53b:	89 04 24             	mov    %eax,(%esp)
 53e:	e8 35 ff ff ff       	call   478 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 543:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 547:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 54b:	79 db                	jns    528 <printint+0x88>
    putc(fd, buf[i]);
}
 54d:	c9                   	leave  
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
 56c:	e9 7d 01 00 00       	jmp    6ee <printf+0x19f>
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
 59a:	e9 4b 01 00 00       	jmp    6ea <printf+0x19b>
      } else {
        putc(fd, c);
 59f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a2:	0f be c0             	movsbl %al,%eax
 5a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ac:	89 04 24             	mov    %eax,(%esp)
 5af:	e8 c4 fe ff ff       	call   478 <putc>
 5b4:	e9 31 01 00 00       	jmp    6ea <printf+0x19b>
      }
    } else if(state == '%'){
 5b9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5bd:	0f 85 27 01 00 00    	jne    6ea <printf+0x19b>
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
 5e8:	e8 b3 fe ff ff       	call   4a0 <printint>
        ap++;
 5ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f1:	e9 ed 00 00 00       	jmp    6e3 <printf+0x194>
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
 621:	e8 7a fe ff ff       	call   4a0 <printint>
        ap++;
 626:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62a:	e9 b4 00 00 00       	jmp    6e3 <printf+0x194>
      } else if(c == 's'){
 62f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 633:	75 46                	jne    67b <printf+0x12c>
        s = (char*)*ap;
 635:	8b 45 e8             	mov    -0x18(%ebp),%eax
 638:	8b 00                	mov    (%eax),%eax
 63a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 63d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 641:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 645:	75 27                	jne    66e <printf+0x11f>
          s = "(null)";
 647:	c7 45 f4 d5 0a 00 00 	movl   $0xad5,-0xc(%ebp)
        while(*s != 0){
 64e:	eb 1e                	jmp    66e <printf+0x11f>
          putc(fd, *s);
 650:	8b 45 f4             	mov    -0xc(%ebp),%eax
 653:	0f b6 00             	movzbl (%eax),%eax
 656:	0f be c0             	movsbl %al,%eax
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
 660:	89 04 24             	mov    %eax,(%esp)
 663:	e8 10 fe ff ff       	call   478 <putc>
          s++;
 668:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 66c:	eb 01                	jmp    66f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 66e:	90                   	nop
 66f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 672:	0f b6 00             	movzbl (%eax),%eax
 675:	84 c0                	test   %al,%al
 677:	75 d7                	jne    650 <printf+0x101>
 679:	eb 68                	jmp    6e3 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 67b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 67f:	75 1d                	jne    69e <printf+0x14f>
        putc(fd, *ap);
 681:	8b 45 e8             	mov    -0x18(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	0f be c0             	movsbl %al,%eax
 689:	89 44 24 04          	mov    %eax,0x4(%esp)
 68d:	8b 45 08             	mov    0x8(%ebp),%eax
 690:	89 04 24             	mov    %eax,(%esp)
 693:	e8 e0 fd ff ff       	call   478 <putc>
        ap++;
 698:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69c:	eb 45                	jmp    6e3 <printf+0x194>
      } else if(c == '%'){
 69e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6a2:	75 17                	jne    6bb <printf+0x16c>
        putc(fd, c);
 6a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a7:	0f be c0             	movsbl %al,%eax
 6aa:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ae:	8b 45 08             	mov    0x8(%ebp),%eax
 6b1:	89 04 24             	mov    %eax,(%esp)
 6b4:	e8 bf fd ff ff       	call   478 <putc>
 6b9:	eb 28                	jmp    6e3 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6bb:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6c2:	00 
 6c3:	8b 45 08             	mov    0x8(%ebp),%eax
 6c6:	89 04 24             	mov    %eax,(%esp)
 6c9:	e8 aa fd ff ff       	call   478 <putc>
        putc(fd, c);
 6ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d1:	0f be c0             	movsbl %al,%eax
 6d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d8:	8b 45 08             	mov    0x8(%ebp),%eax
 6db:	89 04 24             	mov    %eax,(%esp)
 6de:	e8 95 fd ff ff       	call   478 <putc>
      }
      state = 0;
 6e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ea:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ee:	8b 55 0c             	mov    0xc(%ebp),%edx
 6f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f4:	01 d0                	add    %edx,%eax
 6f6:	0f b6 00             	movzbl (%eax),%eax
 6f9:	84 c0                	test   %al,%al
 6fb:	0f 85 70 fe ff ff    	jne    571 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 701:	c9                   	leave  
 702:	c3                   	ret    
 703:	90                   	nop

00000704 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 704:	55                   	push   %ebp
 705:	89 e5                	mov    %esp,%ebp
 707:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 70a:	8b 45 08             	mov    0x8(%ebp),%eax
 70d:	83 e8 08             	sub    $0x8,%eax
 710:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 713:	a1 e4 0e 00 00       	mov    0xee4,%eax
 718:	89 45 fc             	mov    %eax,-0x4(%ebp)
 71b:	eb 24                	jmp    741 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 00                	mov    (%eax),%eax
 722:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 725:	77 12                	ja     739 <free+0x35>
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72d:	77 24                	ja     753 <free+0x4f>
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	8b 00                	mov    (%eax),%eax
 734:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 737:	77 1a                	ja     753 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 00                	mov    (%eax),%eax
 73e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 741:	8b 45 f8             	mov    -0x8(%ebp),%eax
 744:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 747:	76 d4                	jbe    71d <free+0x19>
 749:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74c:	8b 00                	mov    (%eax),%eax
 74e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 751:	76 ca                	jbe    71d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 753:	8b 45 f8             	mov    -0x8(%ebp),%eax
 756:	8b 40 04             	mov    0x4(%eax),%eax
 759:	c1 e0 03             	shl    $0x3,%eax
 75c:	89 c2                	mov    %eax,%edx
 75e:	03 55 f8             	add    -0x8(%ebp),%edx
 761:	8b 45 fc             	mov    -0x4(%ebp),%eax
 764:	8b 00                	mov    (%eax),%eax
 766:	39 c2                	cmp    %eax,%edx
 768:	75 24                	jne    78e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 76a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8b 45 fc             	mov    -0x4(%ebp),%eax
 773:	8b 00                	mov    (%eax),%eax
 775:	8b 40 04             	mov    0x4(%eax),%eax
 778:	01 c2                	add    %eax,%edx
 77a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 780:	8b 45 fc             	mov    -0x4(%ebp),%eax
 783:	8b 00                	mov    (%eax),%eax
 785:	8b 10                	mov    (%eax),%edx
 787:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78a:	89 10                	mov    %edx,(%eax)
 78c:	eb 0a                	jmp    798 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	8b 10                	mov    (%eax),%edx
 793:	8b 45 f8             	mov    -0x8(%ebp),%eax
 796:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 40 04             	mov    0x4(%eax),%eax
 79e:	c1 e0 03             	shl    $0x3,%eax
 7a1:	03 45 fc             	add    -0x4(%ebp),%eax
 7a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a7:	75 20                	jne    7c9 <free+0xc5>
    p->s.size += bp->s.size;
 7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ac:	8b 50 04             	mov    0x4(%eax),%edx
 7af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b2:	8b 40 04             	mov    0x4(%eax),%eax
 7b5:	01 c2                	add    %eax,%edx
 7b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ba:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c0:	8b 10                	mov    (%eax),%edx
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	89 10                	mov    %edx,(%eax)
 7c7:	eb 08                	jmp    7d1 <free+0xcd>
  } else
    p->s.ptr = bp;
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7cf:	89 10                	mov    %edx,(%eax)
  freep = p;
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	a3 e4 0e 00 00       	mov    %eax,0xee4
}
 7d9:	c9                   	leave  
 7da:	c3                   	ret    

000007db <morecore>:

static Header*
morecore(uint nu)
{
 7db:	55                   	push   %ebp
 7dc:	89 e5                	mov    %esp,%ebp
 7de:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e8:	77 07                	ja     7f1 <morecore+0x16>
    nu = 4096;
 7ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7f1:	8b 45 08             	mov    0x8(%ebp),%eax
 7f4:	c1 e0 03             	shl    $0x3,%eax
 7f7:	89 04 24             	mov    %eax,(%esp)
 7fa:	e8 01 fc ff ff       	call   400 <sbrk>
 7ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 802:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 806:	75 07                	jne    80f <morecore+0x34>
    return 0;
 808:	b8 00 00 00 00       	mov    $0x0,%eax
 80d:	eb 22                	jmp    831 <morecore+0x56>
  hp = (Header*)p;
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	8b 55 08             	mov    0x8(%ebp),%edx
 81b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 81e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 821:	83 c0 08             	add    $0x8,%eax
 824:	89 04 24             	mov    %eax,(%esp)
 827:	e8 d8 fe ff ff       	call   704 <free>
  return freep;
 82c:	a1 e4 0e 00 00       	mov    0xee4,%eax
}
 831:	c9                   	leave  
 832:	c3                   	ret    

00000833 <malloc>:

void*
malloc(uint nbytes)
{
 833:	55                   	push   %ebp
 834:	89 e5                	mov    %esp,%ebp
 836:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
 83c:	83 c0 07             	add    $0x7,%eax
 83f:	c1 e8 03             	shr    $0x3,%eax
 842:	83 c0 01             	add    $0x1,%eax
 845:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 848:	a1 e4 0e 00 00       	mov    0xee4,%eax
 84d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 850:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 854:	75 23                	jne    879 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 856:	c7 45 f0 dc 0e 00 00 	movl   $0xedc,-0x10(%ebp)
 85d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 860:	a3 e4 0e 00 00       	mov    %eax,0xee4
 865:	a1 e4 0e 00 00       	mov    0xee4,%eax
 86a:	a3 dc 0e 00 00       	mov    %eax,0xedc
    base.s.size = 0;
 86f:	c7 05 e0 0e 00 00 00 	movl   $0x0,0xee0
 876:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 879:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87c:	8b 00                	mov    (%eax),%eax
 87e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 881:	8b 45 f4             	mov    -0xc(%ebp),%eax
 884:	8b 40 04             	mov    0x4(%eax),%eax
 887:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 88a:	72 4d                	jb     8d9 <malloc+0xa6>
      if(p->s.size == nunits)
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 40 04             	mov    0x4(%eax),%eax
 892:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 895:	75 0c                	jne    8a3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 897:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89a:	8b 10                	mov    (%eax),%edx
 89c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89f:	89 10                	mov    %edx,(%eax)
 8a1:	eb 26                	jmp    8c9 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a6:	8b 40 04             	mov    0x4(%eax),%eax
 8a9:	89 c2                	mov    %eax,%edx
 8ab:	2b 55 ec             	sub    -0x14(%ebp),%edx
 8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b7:	8b 40 04             	mov    0x4(%eax),%eax
 8ba:	c1 e0 03             	shl    $0x3,%eax
 8bd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cc:	a3 e4 0e 00 00       	mov    %eax,0xee4
      return (void*)(p + 1);
 8d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d4:	83 c0 08             	add    $0x8,%eax
 8d7:	eb 38                	jmp    911 <malloc+0xde>
    }
    if(p == freep)
 8d9:	a1 e4 0e 00 00       	mov    0xee4,%eax
 8de:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e1:	75 1b                	jne    8fe <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8e6:	89 04 24             	mov    %eax,(%esp)
 8e9:	e8 ed fe ff ff       	call   7db <morecore>
 8ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f5:	75 07                	jne    8fe <malloc+0xcb>
        return 0;
 8f7:	b8 00 00 00 00       	mov    $0x0,%eax
 8fc:	eb 13                	jmp    911 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 901:	89 45 f0             	mov    %eax,-0x10(%ebp)
 904:	8b 45 f4             	mov    -0xc(%ebp),%eax
 907:	8b 00                	mov    (%eax),%eax
 909:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 90c:	e9 70 ff ff ff       	jmp    881 <malloc+0x4e>
}
 911:	c9                   	leave  
 912:	c3                   	ret    
 913:	90                   	nop

00000914 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 914:	55                   	push   %ebp
 915:	89 e5                	mov    %esp,%ebp
 917:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 91a:	8b 45 0c             	mov    0xc(%ebp),%eax
 91d:	89 04 24             	mov    %eax,(%esp)
 920:	8b 45 08             	mov    0x8(%ebp),%eax
 923:	ff d0                	call   *%eax
    exit();
 925:	e8 4e fa ff ff       	call   378 <exit>

0000092a <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 92a:	55                   	push   %ebp
 92b:	89 e5                	mov    %esp,%ebp
 92d:	57                   	push   %edi
 92e:	56                   	push   %esi
 92f:	53                   	push   %ebx
 930:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 933:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 93a:	e8 f4 fe ff ff       	call   833 <malloc>
 93f:	89 c2                	mov    %eax,%edx
 941:	8b 45 08             	mov    0x8(%ebp),%eax
 944:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 946:	8b 45 10             	mov    0x10(%ebp),%eax
 949:	8b 38                	mov    (%eax),%edi
 94b:	8b 75 0c             	mov    0xc(%ebp),%esi
 94e:	bb 14 09 00 00       	mov    $0x914,%ebx
 953:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 95a:	e8 d4 fe ff ff       	call   833 <malloc>
 95f:	05 00 10 00 00       	add    $0x1000,%eax
 964:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 968:	89 74 24 08          	mov    %esi,0x8(%esp)
 96c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 970:	89 04 24             	mov    %eax,(%esp)
 973:	e8 a0 fa ff ff       	call   418 <kthread_create>
 978:	8b 55 08             	mov    0x8(%ebp),%edx
 97b:	89 02                	mov    %eax,(%edx)
    return *thread;
 97d:	8b 45 08             	mov    0x8(%ebp),%eax
 980:	8b 00                	mov    (%eax),%eax
}
 982:	83 c4 1c             	add    $0x1c,%esp
 985:	5b                   	pop    %ebx
 986:	5e                   	pop    %esi
 987:	5f                   	pop    %edi
 988:	5d                   	pop    %ebp
 989:	c3                   	ret    

0000098a <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 98a:	55                   	push   %ebp
 98b:	89 e5                	mov    %esp,%ebp
 98d:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 990:	8b 45 0c             	mov    0xc(%ebp),%eax
 993:	89 44 24 04          	mov    %eax,0x4(%esp)
 997:	8b 45 08             	mov    0x8(%ebp),%eax
 99a:	89 04 24             	mov    %eax,(%esp)
 99d:	e8 7e fa ff ff       	call   420 <kthread_join>
 9a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9a8:	c9                   	leave  
 9a9:	c3                   	ret    

000009aa <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 9aa:	55                   	push   %ebp
 9ab:	89 e5                	mov    %esp,%ebp
 9ad:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 9b0:	e8 73 fa ff ff       	call   428 <kthread_mutex_init>
 9b5:	8b 55 08             	mov    0x8(%ebp),%edx
 9b8:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 9ba:	8b 45 08             	mov    0x8(%ebp),%eax
 9bd:	8b 00                	mov    (%eax),%eax
 9bf:	85 c0                	test   %eax,%eax
 9c1:	7e 07                	jle    9ca <qthread_mutex_init+0x20>
		return 0;
 9c3:	b8 00 00 00 00       	mov    $0x0,%eax
 9c8:	eb 05                	jmp    9cf <qthread_mutex_init+0x25>
	}
	return *mutex;
 9ca:	8b 45 08             	mov    0x8(%ebp),%eax
 9cd:	8b 00                	mov    (%eax),%eax
}
 9cf:	c9                   	leave  
 9d0:	c3                   	ret    

000009d1 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 9d1:	55                   	push   %ebp
 9d2:	89 e5                	mov    %esp,%ebp
 9d4:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 9d7:	8b 45 08             	mov    0x8(%ebp),%eax
 9da:	89 04 24             	mov    %eax,(%esp)
 9dd:	e8 4e fa ff ff       	call   430 <kthread_mutex_destroy>
 9e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9e9:	79 07                	jns    9f2 <qthread_mutex_destroy+0x21>
    	return -1;
 9eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9f0:	eb 05                	jmp    9f7 <qthread_mutex_destroy+0x26>
    }
    return 0;
 9f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f7:	c9                   	leave  
 9f8:	c3                   	ret    

000009f9 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 9f9:	55                   	push   %ebp
 9fa:	89 e5                	mov    %esp,%ebp
 9fc:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 9ff:	8b 45 08             	mov    0x8(%ebp),%eax
 a02:	89 04 24             	mov    %eax,(%esp)
 a05:	e8 2e fa ff ff       	call   438 <kthread_mutex_lock>
 a0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a0d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a11:	79 07                	jns    a1a <qthread_mutex_lock+0x21>
    	return -1;
 a13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a18:	eb 05                	jmp    a1f <qthread_mutex_lock+0x26>
    }
    return 0;
 a1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a1f:	c9                   	leave  
 a20:	c3                   	ret    

00000a21 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a21:	55                   	push   %ebp
 a22:	89 e5                	mov    %esp,%ebp
 a24:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a27:	8b 45 08             	mov    0x8(%ebp),%eax
 a2a:	89 04 24             	mov    %eax,(%esp)
 a2d:	e8 0e fa ff ff       	call   440 <kthread_mutex_unlock>
 a32:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a35:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a39:	79 07                	jns    a42 <qthread_mutex_unlock+0x21>
    	return -1;
 a3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a40:	eb 05                	jmp    a47 <qthread_mutex_unlock+0x26>
    }
    return 0;
 a42:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a47:	c9                   	leave  
 a48:	c3                   	ret    

00000a49 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 a49:	55                   	push   %ebp
 a4a:	89 e5                	mov    %esp,%ebp

	return 0;
 a4c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a51:	5d                   	pop    %ebp
 a52:	c3                   	ret    

00000a53 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 a53:	55                   	push   %ebp
 a54:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a56:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a5b:	5d                   	pop    %ebp
 a5c:	c3                   	ret    

00000a5d <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 a5d:	55                   	push   %ebp
 a5e:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a60:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a65:	5d                   	pop    %ebp
 a66:	c3                   	ret    

00000a67 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 a67:	55                   	push   %ebp
 a68:	89 e5                	mov    %esp,%ebp
	return 0;
 a6a:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a6f:	5d                   	pop    %ebp
 a70:	c3                   	ret    

00000a71 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 a71:	55                   	push   %ebp
 a72:	89 e5                	mov    %esp,%ebp
	return 0;
 a74:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a79:	5d                   	pop    %ebp
 a7a:	c3                   	ret    

00000a7b <qthread_exit>:

int qthread_exit(){
 a7b:	55                   	push   %ebp
 a7c:	89 e5                	mov    %esp,%ebp
	return 0;
 a7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a83:	5d                   	pop    %ebp
 a84:	c3                   	ret    
