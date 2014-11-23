
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 48             	sub    $0x48,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 68                	jmp    8a <wc+0x8a>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 57                	jmp    82 <wc+0x82>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 c0 0f 00 00       	add    $0xfc0,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 c0 0f 00 00       	add    $0xfc0,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	89 44 24 04          	mov    %eax,0x4(%esp)
  54:	c7 04 24 35 0b 00 00 	movl   $0xb35,(%esp)
  5b:	e8 47 02 00 00       	call   2a7 <strchr>
  60:	85 c0                	test   %eax,%eax
  62:	74 09                	je     6d <wc+0x6d>
        inword = 0;
  64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6b:	eb 11                	jmp    7e <wc+0x7e>
      else if(!inword){
  6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  71:	75 0b                	jne    7e <wc+0x7e>
        w++;
  73:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  77:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  82:	8b 45 f4             	mov    -0xc(%ebp),%eax
  85:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  88:	7c a1                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  91:	00 
  92:	c7 44 24 04 c0 0f 00 	movl   $0xfc0,0x4(%esp)
  99:	00 
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 9b 03 00 00       	call   440 <read>
  a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  ac:	0f 8f 70 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b6:	79 19                	jns    d1 <wc+0xd1>
    printf(1, "wc: read error\n");
  b8:	c7 44 24 04 3b 0b 00 	movl   $0xb3b,0x4(%esp)
  bf:	00 
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 33 05 00 00       	call   5ff <printf>
    exit();
  cc:	e8 57 03 00 00       	call   428 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  d4:	89 44 24 14          	mov    %eax,0x14(%esp)
  d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  db:	89 44 24 10          	mov    %eax,0x10(%esp)
  df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ed:	c7 44 24 04 4b 0b 00 	movl   $0xb4b,0x4(%esp)
  f4:	00 
  f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fc:	e8 fe 04 00 00       	call   5ff <printf>
}
 101:	c9                   	leave  
 102:	c3                   	ret    

00000103 <main>:

int
main(int argc, char *argv[])
{
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	83 e4 f0             	and    $0xfffffff0,%esp
 109:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
 10c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 110:	7f 19                	jg     12b <main+0x28>
    wc(0, "");
 112:	c7 44 24 04 58 0b 00 	movl   $0xb58,0x4(%esp)
 119:	00 
 11a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 121:	e8 da fe ff ff       	call   0 <wc>
    exit();
 126:	e8 fd 02 00 00       	call   428 <exit>
  }

  for(i = 1; i < argc; i++){
 12b:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 132:	00 
 133:	eb 7d                	jmp    1b2 <main+0xaf>
    if((fd = open(argv[i], 0)) < 0){
 135:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 139:	c1 e0 02             	shl    $0x2,%eax
 13c:	03 45 0c             	add    0xc(%ebp),%eax
 13f:	8b 00                	mov    (%eax),%eax
 141:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 148:	00 
 149:	89 04 24             	mov    %eax,(%esp)
 14c:	e8 17 03 00 00       	call   468 <open>
 151:	89 44 24 18          	mov    %eax,0x18(%esp)
 155:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
 15a:	79 29                	jns    185 <main+0x82>
      printf(1, "wc: cannot open %s\n", argv[i]);
 15c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 160:	c1 e0 02             	shl    $0x2,%eax
 163:	03 45 0c             	add    0xc(%ebp),%eax
 166:	8b 00                	mov    (%eax),%eax
 168:	89 44 24 08          	mov    %eax,0x8(%esp)
 16c:	c7 44 24 04 59 0b 00 	movl   $0xb59,0x4(%esp)
 173:	00 
 174:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 17b:	e8 7f 04 00 00       	call   5ff <printf>
      exit();
 180:	e8 a3 02 00 00       	call   428 <exit>
    }
    wc(fd, argv[i]);
 185:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 189:	c1 e0 02             	shl    $0x2,%eax
 18c:	03 45 0c             	add    0xc(%ebp),%eax
 18f:	8b 00                	mov    (%eax),%eax
 191:	89 44 24 04          	mov    %eax,0x4(%esp)
 195:	8b 44 24 18          	mov    0x18(%esp),%eax
 199:	89 04 24             	mov    %eax,(%esp)
 19c:	e8 5f fe ff ff       	call   0 <wc>
    close(fd);
 1a1:	8b 44 24 18          	mov    0x18(%esp),%eax
 1a5:	89 04 24             	mov    %eax,(%esp)
 1a8:	e8 a3 02 00 00       	call   450 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1ad:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1b2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1b6:	3b 45 08             	cmp    0x8(%ebp),%eax
 1b9:	0f 8c 76 ff ff ff    	jl     135 <main+0x32>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1bf:	e8 64 02 00 00       	call   428 <exit>

000001c4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	57                   	push   %edi
 1c8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1cc:	8b 55 10             	mov    0x10(%ebp),%edx
 1cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d2:	89 cb                	mov    %ecx,%ebx
 1d4:	89 df                	mov    %ebx,%edi
 1d6:	89 d1                	mov    %edx,%ecx
 1d8:	fc                   	cld    
 1d9:	f3 aa                	rep stos %al,%es:(%edi)
 1db:	89 ca                	mov    %ecx,%edx
 1dd:	89 fb                	mov    %edi,%ebx
 1df:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1e2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1e5:	5b                   	pop    %ebx
 1e6:	5f                   	pop    %edi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    

000001e9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1f5:	90                   	nop
 1f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f9:	0f b6 10             	movzbl (%eax),%edx
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	88 10                	mov    %dl,(%eax)
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	84 c0                	test   %al,%al
 209:	0f 95 c0             	setne  %al
 20c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 210:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 214:	84 c0                	test   %al,%al
 216:	75 de                	jne    1f6 <strcpy+0xd>
    ;
  return os;
 218:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 21b:	c9                   	leave  
 21c:	c3                   	ret    

0000021d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 21d:	55                   	push   %ebp
 21e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 220:	eb 08                	jmp    22a <strcmp+0xd>
    p++, q++;
 222:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 226:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	0f b6 00             	movzbl (%eax),%eax
 230:	84 c0                	test   %al,%al
 232:	74 10                	je     244 <strcmp+0x27>
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	0f b6 00             	movzbl (%eax),%eax
 240:	38 c2                	cmp    %al,%dl
 242:	74 de                	je     222 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	0f b6 00             	movzbl (%eax),%eax
 24a:	0f b6 d0             	movzbl %al,%edx
 24d:	8b 45 0c             	mov    0xc(%ebp),%eax
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	0f b6 c0             	movzbl %al,%eax
 256:	89 d1                	mov    %edx,%ecx
 258:	29 c1                	sub    %eax,%ecx
 25a:	89 c8                	mov    %ecx,%eax
}
 25c:	5d                   	pop    %ebp
 25d:	c3                   	ret    

0000025e <strlen>:

uint
strlen(char *s)
{
 25e:	55                   	push   %ebp
 25f:	89 e5                	mov    %esp,%ebp
 261:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 264:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 26b:	eb 04                	jmp    271 <strlen+0x13>
 26d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 271:	8b 45 fc             	mov    -0x4(%ebp),%eax
 274:	03 45 08             	add    0x8(%ebp),%eax
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	84 c0                	test   %al,%al
 27c:	75 ef                	jne    26d <strlen+0xf>
    ;
  return n;
 27e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <memset>:

void*
memset(void *dst, int c, uint n)
{
 283:	55                   	push   %ebp
 284:	89 e5                	mov    %esp,%ebp
 286:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 289:	8b 45 10             	mov    0x10(%ebp),%eax
 28c:	89 44 24 08          	mov    %eax,0x8(%esp)
 290:	8b 45 0c             	mov    0xc(%ebp),%eax
 293:	89 44 24 04          	mov    %eax,0x4(%esp)
 297:	8b 45 08             	mov    0x8(%ebp),%eax
 29a:	89 04 24             	mov    %eax,(%esp)
 29d:	e8 22 ff ff ff       	call   1c4 <stosb>
  return dst;
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    

000002a7 <strchr>:

char*
strchr(const char *s, char c)
{
 2a7:	55                   	push   %ebp
 2a8:	89 e5                	mov    %esp,%ebp
 2aa:	83 ec 04             	sub    $0x4,%esp
 2ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2b3:	eb 14                	jmp    2c9 <strchr+0x22>
    if(*s == c)
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2be:	75 05                	jne    2c5 <strchr+0x1e>
      return (char*)s;
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
 2c3:	eb 13                	jmp    2d8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
 2cc:	0f b6 00             	movzbl (%eax),%eax
 2cf:	84 c0                	test   %al,%al
 2d1:	75 e2                	jne    2b5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2d8:	c9                   	leave  
 2d9:	c3                   	ret    

000002da <gets>:

char*
gets(char *buf, int max)
{
 2da:	55                   	push   %ebp
 2db:	89 e5                	mov    %esp,%ebp
 2dd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2e7:	eb 44                	jmp    32d <gets+0x53>
    cc = read(0, &c, 1);
 2e9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2f0:	00 
 2f1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ff:	e8 3c 01 00 00       	call   440 <read>
 304:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 307:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 30b:	7e 2d                	jle    33a <gets+0x60>
      break;
    buf[i++] = c;
 30d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 310:	03 45 08             	add    0x8(%ebp),%eax
 313:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 317:	88 10                	mov    %dl,(%eax)
 319:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 31d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 321:	3c 0a                	cmp    $0xa,%al
 323:	74 16                	je     33b <gets+0x61>
 325:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 329:	3c 0d                	cmp    $0xd,%al
 32b:	74 0e                	je     33b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 32d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 330:	83 c0 01             	add    $0x1,%eax
 333:	3b 45 0c             	cmp    0xc(%ebp),%eax
 336:	7c b1                	jl     2e9 <gets+0xf>
 338:	eb 01                	jmp    33b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 33a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 33b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 33e:	03 45 08             	add    0x8(%ebp),%eax
 341:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 344:	8b 45 08             	mov    0x8(%ebp),%eax
}
 347:	c9                   	leave  
 348:	c3                   	ret    

00000349 <stat>:

int
stat(char *n, struct stat *st)
{
 349:	55                   	push   %ebp
 34a:	89 e5                	mov    %esp,%ebp
 34c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 34f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 356:	00 
 357:	8b 45 08             	mov    0x8(%ebp),%eax
 35a:	89 04 24             	mov    %eax,(%esp)
 35d:	e8 06 01 00 00       	call   468 <open>
 362:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 365:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 369:	79 07                	jns    372 <stat+0x29>
    return -1;
 36b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 370:	eb 23                	jmp    395 <stat+0x4c>
  r = fstat(fd, st);
 372:	8b 45 0c             	mov    0xc(%ebp),%eax
 375:	89 44 24 04          	mov    %eax,0x4(%esp)
 379:	8b 45 f4             	mov    -0xc(%ebp),%eax
 37c:	89 04 24             	mov    %eax,(%esp)
 37f:	e8 fc 00 00 00       	call   480 <fstat>
 384:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 387:	8b 45 f4             	mov    -0xc(%ebp),%eax
 38a:	89 04 24             	mov    %eax,(%esp)
 38d:	e8 be 00 00 00       	call   450 <close>
  return r;
 392:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 395:	c9                   	leave  
 396:	c3                   	ret    

00000397 <atoi>:

int
atoi(const char *s)
{
 397:	55                   	push   %ebp
 398:	89 e5                	mov    %esp,%ebp
 39a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 39d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3a4:	eb 23                	jmp    3c9 <atoi+0x32>
    n = n*10 + *s++ - '0';
 3a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a9:	89 d0                	mov    %edx,%eax
 3ab:	c1 e0 02             	shl    $0x2,%eax
 3ae:	01 d0                	add    %edx,%eax
 3b0:	01 c0                	add    %eax,%eax
 3b2:	89 c2                	mov    %eax,%edx
 3b4:	8b 45 08             	mov    0x8(%ebp),%eax
 3b7:	0f b6 00             	movzbl (%eax),%eax
 3ba:	0f be c0             	movsbl %al,%eax
 3bd:	01 d0                	add    %edx,%eax
 3bf:	83 e8 30             	sub    $0x30,%eax
 3c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c9:	8b 45 08             	mov    0x8(%ebp),%eax
 3cc:	0f b6 00             	movzbl (%eax),%eax
 3cf:	3c 2f                	cmp    $0x2f,%al
 3d1:	7e 0a                	jle    3dd <atoi+0x46>
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	0f b6 00             	movzbl (%eax),%eax
 3d9:	3c 39                	cmp    $0x39,%al
 3db:	7e c9                	jle    3a6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3e0:	c9                   	leave  
 3e1:	c3                   	ret    

000003e2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3e2:	55                   	push   %ebp
 3e3:	89 e5                	mov    %esp,%ebp
 3e5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3e8:	8b 45 08             	mov    0x8(%ebp),%eax
 3eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3f4:	eb 13                	jmp    409 <memmove+0x27>
    *dst++ = *src++;
 3f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3f9:	0f b6 10             	movzbl (%eax),%edx
 3fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ff:	88 10                	mov    %dl,(%eax)
 401:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 405:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 409:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 40d:	0f 9f c0             	setg   %al
 410:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 414:	84 c0                	test   %al,%al
 416:	75 de                	jne    3f6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 418:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41b:	c9                   	leave  
 41c:	c3                   	ret    
 41d:	90                   	nop
 41e:	90                   	nop
 41f:	90                   	nop

00000420 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 420:	b8 01 00 00 00       	mov    $0x1,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <exit>:
SYSCALL(exit)
 428:	b8 02 00 00 00       	mov    $0x2,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <wait>:
SYSCALL(wait)
 430:	b8 03 00 00 00       	mov    $0x3,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <pipe>:
SYSCALL(pipe)
 438:	b8 04 00 00 00       	mov    $0x4,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <read>:
SYSCALL(read)
 440:	b8 05 00 00 00       	mov    $0x5,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <write>:
SYSCALL(write)
 448:	b8 10 00 00 00       	mov    $0x10,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <close>:
SYSCALL(close)
 450:	b8 15 00 00 00       	mov    $0x15,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <kill>:
SYSCALL(kill)
 458:	b8 06 00 00 00       	mov    $0x6,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <exec>:
SYSCALL(exec)
 460:	b8 07 00 00 00       	mov    $0x7,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <open>:
SYSCALL(open)
 468:	b8 0f 00 00 00       	mov    $0xf,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <mknod>:
SYSCALL(mknod)
 470:	b8 11 00 00 00       	mov    $0x11,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <unlink>:
SYSCALL(unlink)
 478:	b8 12 00 00 00       	mov    $0x12,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <fstat>:
SYSCALL(fstat)
 480:	b8 08 00 00 00       	mov    $0x8,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <link>:
SYSCALL(link)
 488:	b8 13 00 00 00       	mov    $0x13,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <mkdir>:
SYSCALL(mkdir)
 490:	b8 14 00 00 00       	mov    $0x14,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <chdir>:
SYSCALL(chdir)
 498:	b8 09 00 00 00       	mov    $0x9,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <dup>:
SYSCALL(dup)
 4a0:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <getpid>:
SYSCALL(getpid)
 4a8:	b8 0b 00 00 00       	mov    $0xb,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <sbrk>:
SYSCALL(sbrk)
 4b0:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <sleep>:
SYSCALL(sleep)
 4b8:	b8 0d 00 00 00       	mov    $0xd,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <uptime>:
SYSCALL(uptime)
 4c0:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <kthread_create>:
SYSCALL(kthread_create)
 4c8:	b8 17 00 00 00       	mov    $0x17,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <kthread_join>:
SYSCALL(kthread_join)
 4d0:	b8 16 00 00 00       	mov    $0x16,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 4d8:	b8 18 00 00 00       	mov    $0x18,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 4e0:	b8 19 00 00 00       	mov    $0x19,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 4e8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 4f0:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 4f8:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 500:	b8 1d 00 00 00       	mov    $0x1d,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 508:	b8 1e 00 00 00       	mov    $0x1e,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 510:	b8 1f 00 00 00       	mov    $0x1f,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 518:	b8 20 00 00 00       	mov    $0x20,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <kthread_exit>:
 520:	b8 21 00 00 00       	mov    $0x21,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 528:	55                   	push   %ebp
 529:	89 e5                	mov    %esp,%ebp
 52b:	83 ec 28             	sub    $0x28,%esp
 52e:	8b 45 0c             	mov    0xc(%ebp),%eax
 531:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 534:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53b:	00 
 53c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 53f:	89 44 24 04          	mov    %eax,0x4(%esp)
 543:	8b 45 08             	mov    0x8(%ebp),%eax
 546:	89 04 24             	mov    %eax,(%esp)
 549:	e8 fa fe ff ff       	call   448 <write>
}
 54e:	c9                   	leave  
 54f:	c3                   	ret    

00000550 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 556:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 55d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 561:	74 17                	je     57a <printint+0x2a>
 563:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 567:	79 11                	jns    57a <printint+0x2a>
    neg = 1;
 569:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 570:	8b 45 0c             	mov    0xc(%ebp),%eax
 573:	f7 d8                	neg    %eax
 575:	89 45 ec             	mov    %eax,-0x14(%ebp)
 578:	eb 06                	jmp    580 <printint+0x30>
  } else {
    x = xx;
 57a:	8b 45 0c             	mov    0xc(%ebp),%eax
 57d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 580:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 587:	8b 4d 10             	mov    0x10(%ebp),%ecx
 58a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 58d:	ba 00 00 00 00       	mov    $0x0,%edx
 592:	f7 f1                	div    %ecx
 594:	89 d0                	mov    %edx,%eax
 596:	0f b6 90 78 0f 00 00 	movzbl 0xf78(%eax),%edx
 59d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5a0:	03 45 f4             	add    -0xc(%ebp),%eax
 5a3:	88 10                	mov    %dl,(%eax)
 5a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 5a9:	8b 55 10             	mov    0x10(%ebp),%edx
 5ac:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b2:	ba 00 00 00 00       	mov    $0x0,%edx
 5b7:	f7 75 d4             	divl   -0x2c(%ebp)
 5ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c1:	75 c4                	jne    587 <printint+0x37>
  if(neg)
 5c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5c7:	74 2a                	je     5f3 <printint+0xa3>
    buf[i++] = '-';
 5c9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5cc:	03 45 f4             	add    -0xc(%ebp),%eax
 5cf:	c6 00 2d             	movb   $0x2d,(%eax)
 5d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 5d6:	eb 1b                	jmp    5f3 <printint+0xa3>
    putc(fd, buf[i]);
 5d8:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5db:	03 45 f4             	add    -0xc(%ebp),%eax
 5de:	0f b6 00             	movzbl (%eax),%eax
 5e1:	0f be c0             	movsbl %al,%eax
 5e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e8:	8b 45 08             	mov    0x8(%ebp),%eax
 5eb:	89 04 24             	mov    %eax,(%esp)
 5ee:	e8 35 ff ff ff       	call   528 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5f3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5fb:	79 db                	jns    5d8 <printint+0x88>
    putc(fd, buf[i]);
}
 5fd:	c9                   	leave  
 5fe:	c3                   	ret    

000005ff <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5ff:	55                   	push   %ebp
 600:	89 e5                	mov    %esp,%ebp
 602:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 605:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 60c:	8d 45 0c             	lea    0xc(%ebp),%eax
 60f:	83 c0 04             	add    $0x4,%eax
 612:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 615:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 61c:	e9 7d 01 00 00       	jmp    79e <printf+0x19f>
    c = fmt[i] & 0xff;
 621:	8b 55 0c             	mov    0xc(%ebp),%edx
 624:	8b 45 f0             	mov    -0x10(%ebp),%eax
 627:	01 d0                	add    %edx,%eax
 629:	0f b6 00             	movzbl (%eax),%eax
 62c:	0f be c0             	movsbl %al,%eax
 62f:	25 ff 00 00 00       	and    $0xff,%eax
 634:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 637:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 63b:	75 2c                	jne    669 <printf+0x6a>
      if(c == '%'){
 63d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 641:	75 0c                	jne    64f <printf+0x50>
        state = '%';
 643:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 64a:	e9 4b 01 00 00       	jmp    79a <printf+0x19b>
      } else {
        putc(fd, c);
 64f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	89 44 24 04          	mov    %eax,0x4(%esp)
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	89 04 24             	mov    %eax,(%esp)
 65f:	e8 c4 fe ff ff       	call   528 <putc>
 664:	e9 31 01 00 00       	jmp    79a <printf+0x19b>
      }
    } else if(state == '%'){
 669:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 66d:	0f 85 27 01 00 00    	jne    79a <printf+0x19b>
      if(c == 'd'){
 673:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 677:	75 2d                	jne    6a6 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 679:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 685:	00 
 686:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 68d:	00 
 68e:	89 44 24 04          	mov    %eax,0x4(%esp)
 692:	8b 45 08             	mov    0x8(%ebp),%eax
 695:	89 04 24             	mov    %eax,(%esp)
 698:	e8 b3 fe ff ff       	call   550 <printint>
        ap++;
 69d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6a1:	e9 ed 00 00 00       	jmp    793 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 6a6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6aa:	74 06                	je     6b2 <printf+0xb3>
 6ac:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6b0:	75 2d                	jne    6df <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b5:	8b 00                	mov    (%eax),%eax
 6b7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6be:	00 
 6bf:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6c6:	00 
 6c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cb:	8b 45 08             	mov    0x8(%ebp),%eax
 6ce:	89 04 24             	mov    %eax,(%esp)
 6d1:	e8 7a fe ff ff       	call   550 <printint>
        ap++;
 6d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6da:	e9 b4 00 00 00       	jmp    793 <printf+0x194>
      } else if(c == 's'){
 6df:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6e3:	75 46                	jne    72b <printf+0x12c>
        s = (char*)*ap;
 6e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e8:	8b 00                	mov    (%eax),%eax
 6ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6f5:	75 27                	jne    71e <printf+0x11f>
          s = "(null)";
 6f7:	c7 45 f4 6d 0b 00 00 	movl   $0xb6d,-0xc(%ebp)
        while(*s != 0){
 6fe:	eb 1e                	jmp    71e <printf+0x11f>
          putc(fd, *s);
 700:	8b 45 f4             	mov    -0xc(%ebp),%eax
 703:	0f b6 00             	movzbl (%eax),%eax
 706:	0f be c0             	movsbl %al,%eax
 709:	89 44 24 04          	mov    %eax,0x4(%esp)
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
 710:	89 04 24             	mov    %eax,(%esp)
 713:	e8 10 fe ff ff       	call   528 <putc>
          s++;
 718:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 71c:	eb 01                	jmp    71f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 71e:	90                   	nop
 71f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 722:	0f b6 00             	movzbl (%eax),%eax
 725:	84 c0                	test   %al,%al
 727:	75 d7                	jne    700 <printf+0x101>
 729:	eb 68                	jmp    793 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 72b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 72f:	75 1d                	jne    74e <printf+0x14f>
        putc(fd, *ap);
 731:	8b 45 e8             	mov    -0x18(%ebp),%eax
 734:	8b 00                	mov    (%eax),%eax
 736:	0f be c0             	movsbl %al,%eax
 739:	89 44 24 04          	mov    %eax,0x4(%esp)
 73d:	8b 45 08             	mov    0x8(%ebp),%eax
 740:	89 04 24             	mov    %eax,(%esp)
 743:	e8 e0 fd ff ff       	call   528 <putc>
        ap++;
 748:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 74c:	eb 45                	jmp    793 <printf+0x194>
      } else if(c == '%'){
 74e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 752:	75 17                	jne    76b <printf+0x16c>
        putc(fd, c);
 754:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 757:	0f be c0             	movsbl %al,%eax
 75a:	89 44 24 04          	mov    %eax,0x4(%esp)
 75e:	8b 45 08             	mov    0x8(%ebp),%eax
 761:	89 04 24             	mov    %eax,(%esp)
 764:	e8 bf fd ff ff       	call   528 <putc>
 769:	eb 28                	jmp    793 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 76b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 772:	00 
 773:	8b 45 08             	mov    0x8(%ebp),%eax
 776:	89 04 24             	mov    %eax,(%esp)
 779:	e8 aa fd ff ff       	call   528 <putc>
        putc(fd, c);
 77e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 781:	0f be c0             	movsbl %al,%eax
 784:	89 44 24 04          	mov    %eax,0x4(%esp)
 788:	8b 45 08             	mov    0x8(%ebp),%eax
 78b:	89 04 24             	mov    %eax,(%esp)
 78e:	e8 95 fd ff ff       	call   528 <putc>
      }
      state = 0;
 793:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 79a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 79e:	8b 55 0c             	mov    0xc(%ebp),%edx
 7a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a4:	01 d0                	add    %edx,%eax
 7a6:	0f b6 00             	movzbl (%eax),%eax
 7a9:	84 c0                	test   %al,%al
 7ab:	0f 85 70 fe ff ff    	jne    621 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7b1:	c9                   	leave  
 7b2:	c3                   	ret    
 7b3:	90                   	nop

000007b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b4:	55                   	push   %ebp
 7b5:	89 e5                	mov    %esp,%ebp
 7b7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ba:	8b 45 08             	mov    0x8(%ebp),%eax
 7bd:	83 e8 08             	sub    $0x8,%eax
 7c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c3:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 7c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7cb:	eb 24                	jmp    7f1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d0:	8b 00                	mov    (%eax),%eax
 7d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d5:	77 12                	ja     7e9 <free+0x35>
 7d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7da:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7dd:	77 24                	ja     803 <free+0x4f>
 7df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e2:	8b 00                	mov    (%eax),%eax
 7e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7e7:	77 1a                	ja     803 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ec:	8b 00                	mov    (%eax),%eax
 7ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7f7:	76 d4                	jbe    7cd <free+0x19>
 7f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fc:	8b 00                	mov    (%eax),%eax
 7fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 801:	76 ca                	jbe    7cd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 803:	8b 45 f8             	mov    -0x8(%ebp),%eax
 806:	8b 40 04             	mov    0x4(%eax),%eax
 809:	c1 e0 03             	shl    $0x3,%eax
 80c:	89 c2                	mov    %eax,%edx
 80e:	03 55 f8             	add    -0x8(%ebp),%edx
 811:	8b 45 fc             	mov    -0x4(%ebp),%eax
 814:	8b 00                	mov    (%eax),%eax
 816:	39 c2                	cmp    %eax,%edx
 818:	75 24                	jne    83e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 81a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81d:	8b 50 04             	mov    0x4(%eax),%edx
 820:	8b 45 fc             	mov    -0x4(%ebp),%eax
 823:	8b 00                	mov    (%eax),%eax
 825:	8b 40 04             	mov    0x4(%eax),%eax
 828:	01 c2                	add    %eax,%edx
 82a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 830:	8b 45 fc             	mov    -0x4(%ebp),%eax
 833:	8b 00                	mov    (%eax),%eax
 835:	8b 10                	mov    (%eax),%edx
 837:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83a:	89 10                	mov    %edx,(%eax)
 83c:	eb 0a                	jmp    848 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 83e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 841:	8b 10                	mov    (%eax),%edx
 843:	8b 45 f8             	mov    -0x8(%ebp),%eax
 846:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 848:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84b:	8b 40 04             	mov    0x4(%eax),%eax
 84e:	c1 e0 03             	shl    $0x3,%eax
 851:	03 45 fc             	add    -0x4(%ebp),%eax
 854:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 857:	75 20                	jne    879 <free+0xc5>
    p->s.size += bp->s.size;
 859:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85c:	8b 50 04             	mov    0x4(%eax),%edx
 85f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 862:	8b 40 04             	mov    0x4(%eax),%eax
 865:	01 c2                	add    %eax,%edx
 867:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 86d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 870:	8b 10                	mov    (%eax),%edx
 872:	8b 45 fc             	mov    -0x4(%ebp),%eax
 875:	89 10                	mov    %edx,(%eax)
 877:	eb 08                	jmp    881 <free+0xcd>
  } else
    p->s.ptr = bp;
 879:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 87f:	89 10                	mov    %edx,(%eax)
  freep = p;
 881:	8b 45 fc             	mov    -0x4(%ebp),%eax
 884:	a3 a8 0f 00 00       	mov    %eax,0xfa8
}
 889:	c9                   	leave  
 88a:	c3                   	ret    

0000088b <morecore>:

static Header*
morecore(uint nu)
{
 88b:	55                   	push   %ebp
 88c:	89 e5                	mov    %esp,%ebp
 88e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 891:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 898:	77 07                	ja     8a1 <morecore+0x16>
    nu = 4096;
 89a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8a1:	8b 45 08             	mov    0x8(%ebp),%eax
 8a4:	c1 e0 03             	shl    $0x3,%eax
 8a7:	89 04 24             	mov    %eax,(%esp)
 8aa:	e8 01 fc ff ff       	call   4b0 <sbrk>
 8af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8b2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8b6:	75 07                	jne    8bf <morecore+0x34>
    return 0;
 8b8:	b8 00 00 00 00       	mov    $0x0,%eax
 8bd:	eb 22                	jmp    8e1 <morecore+0x56>
  hp = (Header*)p;
 8bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c8:	8b 55 08             	mov    0x8(%ebp),%edx
 8cb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d1:	83 c0 08             	add    $0x8,%eax
 8d4:	89 04 24             	mov    %eax,(%esp)
 8d7:	e8 d8 fe ff ff       	call   7b4 <free>
  return freep;
 8dc:	a1 a8 0f 00 00       	mov    0xfa8,%eax
}
 8e1:	c9                   	leave  
 8e2:	c3                   	ret    

000008e3 <malloc>:

void*
malloc(uint nbytes)
{
 8e3:	55                   	push   %ebp
 8e4:	89 e5                	mov    %esp,%ebp
 8e6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e9:	8b 45 08             	mov    0x8(%ebp),%eax
 8ec:	83 c0 07             	add    $0x7,%eax
 8ef:	c1 e8 03             	shr    $0x3,%eax
 8f2:	83 c0 01             	add    $0x1,%eax
 8f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8f8:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 8fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 900:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 904:	75 23                	jne    929 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 906:	c7 45 f0 a0 0f 00 00 	movl   $0xfa0,-0x10(%ebp)
 90d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 910:	a3 a8 0f 00 00       	mov    %eax,0xfa8
 915:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 91a:	a3 a0 0f 00 00       	mov    %eax,0xfa0
    base.s.size = 0;
 91f:	c7 05 a4 0f 00 00 00 	movl   $0x0,0xfa4
 926:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 929:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92c:	8b 00                	mov    (%eax),%eax
 92e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 931:	8b 45 f4             	mov    -0xc(%ebp),%eax
 934:	8b 40 04             	mov    0x4(%eax),%eax
 937:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 93a:	72 4d                	jb     989 <malloc+0xa6>
      if(p->s.size == nunits)
 93c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93f:	8b 40 04             	mov    0x4(%eax),%eax
 942:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 945:	75 0c                	jne    953 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 947:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94a:	8b 10                	mov    (%eax),%edx
 94c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94f:	89 10                	mov    %edx,(%eax)
 951:	eb 26                	jmp    979 <malloc+0x96>
      else {
        p->s.size -= nunits;
 953:	8b 45 f4             	mov    -0xc(%ebp),%eax
 956:	8b 40 04             	mov    0x4(%eax),%eax
 959:	89 c2                	mov    %eax,%edx
 95b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 95e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 961:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 964:	8b 45 f4             	mov    -0xc(%ebp),%eax
 967:	8b 40 04             	mov    0x4(%eax),%eax
 96a:	c1 e0 03             	shl    $0x3,%eax
 96d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 970:	8b 45 f4             	mov    -0xc(%ebp),%eax
 973:	8b 55 ec             	mov    -0x14(%ebp),%edx
 976:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 979:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97c:	a3 a8 0f 00 00       	mov    %eax,0xfa8
      return (void*)(p + 1);
 981:	8b 45 f4             	mov    -0xc(%ebp),%eax
 984:	83 c0 08             	add    $0x8,%eax
 987:	eb 38                	jmp    9c1 <malloc+0xde>
    }
    if(p == freep)
 989:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 98e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 991:	75 1b                	jne    9ae <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 993:	8b 45 ec             	mov    -0x14(%ebp),%eax
 996:	89 04 24             	mov    %eax,(%esp)
 999:	e8 ed fe ff ff       	call   88b <morecore>
 99e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a5:	75 07                	jne    9ae <malloc+0xcb>
        return 0;
 9a7:	b8 00 00 00 00       	mov    $0x0,%eax
 9ac:	eb 13                	jmp    9c1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b7:	8b 00                	mov    (%eax),%eax
 9b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9bc:	e9 70 ff ff ff       	jmp    931 <malloc+0x4e>
}
 9c1:	c9                   	leave  
 9c2:	c3                   	ret    
 9c3:	90                   	nop

000009c4 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 9c4:	55                   	push   %ebp
 9c5:	89 e5                	mov    %esp,%ebp
 9c7:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 9ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 9cd:	89 04 24             	mov    %eax,(%esp)
 9d0:	8b 45 08             	mov    0x8(%ebp),%eax
 9d3:	ff d0                	call   *%eax
    exit();
 9d5:	e8 4e fa ff ff       	call   428 <exit>

000009da <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 9da:	55                   	push   %ebp
 9db:	89 e5                	mov    %esp,%ebp
 9dd:	57                   	push   %edi
 9de:	56                   	push   %esi
 9df:	53                   	push   %ebx
 9e0:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 9e3:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 9ea:	e8 f4 fe ff ff       	call   8e3 <malloc>
 9ef:	89 c2                	mov    %eax,%edx
 9f1:	8b 45 08             	mov    0x8(%ebp),%eax
 9f4:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 9f6:	8b 45 10             	mov    0x10(%ebp),%eax
 9f9:	8b 38                	mov    (%eax),%edi
 9fb:	8b 75 0c             	mov    0xc(%ebp),%esi
 9fe:	bb c4 09 00 00       	mov    $0x9c4,%ebx
 a03:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a0a:	e8 d4 fe ff ff       	call   8e3 <malloc>
 a0f:	05 00 10 00 00       	add    $0x1000,%eax
 a14:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 a18:	89 74 24 08          	mov    %esi,0x8(%esp)
 a1c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 a20:	89 04 24             	mov    %eax,(%esp)
 a23:	e8 a0 fa ff ff       	call   4c8 <kthread_create>
 a28:	8b 55 08             	mov    0x8(%ebp),%edx
 a2b:	89 02                	mov    %eax,(%edx)
    return *thread;
 a2d:	8b 45 08             	mov    0x8(%ebp),%eax
 a30:	8b 00                	mov    (%eax),%eax
}
 a32:	83 c4 1c             	add    $0x1c,%esp
 a35:	5b                   	pop    %ebx
 a36:	5e                   	pop    %esi
 a37:	5f                   	pop    %edi
 a38:	5d                   	pop    %ebp
 a39:	c3                   	ret    

00000a3a <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 a3a:	55                   	push   %ebp
 a3b:	89 e5                	mov    %esp,%ebp
 a3d:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 a40:	8b 45 0c             	mov    0xc(%ebp),%eax
 a43:	89 44 24 04          	mov    %eax,0x4(%esp)
 a47:	8b 45 08             	mov    0x8(%ebp),%eax
 a4a:	89 04 24             	mov    %eax,(%esp)
 a4d:	e8 7e fa ff ff       	call   4d0 <kthread_join>
 a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 a58:	c9                   	leave  
 a59:	c3                   	ret    

00000a5a <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 a5a:	55                   	push   %ebp
 a5b:	89 e5                	mov    %esp,%ebp
 a5d:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 a60:	e8 73 fa ff ff       	call   4d8 <kthread_mutex_init>
 a65:	8b 55 08             	mov    0x8(%ebp),%edx
 a68:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a6a:	8b 45 08             	mov    0x8(%ebp),%eax
 a6d:	8b 00                	mov    (%eax),%eax
 a6f:	85 c0                	test   %eax,%eax
 a71:	7e 07                	jle    a7a <qthread_mutex_init+0x20>
		return 0;
 a73:	b8 00 00 00 00       	mov    $0x0,%eax
 a78:	eb 05                	jmp    a7f <qthread_mutex_init+0x25>
	}
	return *mutex;
 a7a:	8b 45 08             	mov    0x8(%ebp),%eax
 a7d:	8b 00                	mov    (%eax),%eax
}
 a7f:	c9                   	leave  
 a80:	c3                   	ret    

00000a81 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 a81:	55                   	push   %ebp
 a82:	89 e5                	mov    %esp,%ebp
 a84:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 a87:	8b 45 08             	mov    0x8(%ebp),%eax
 a8a:	89 04 24             	mov    %eax,(%esp)
 a8d:	e8 4e fa ff ff       	call   4e0 <kthread_mutex_destroy>
 a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a95:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a99:	79 07                	jns    aa2 <qthread_mutex_destroy+0x21>
    	return -1;
 a9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 aa0:	eb 05                	jmp    aa7 <qthread_mutex_destroy+0x26>
    }
    return 0;
 aa2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aa7:	c9                   	leave  
 aa8:	c3                   	ret    

00000aa9 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 aa9:	55                   	push   %ebp
 aaa:	89 e5                	mov    %esp,%ebp
 aac:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 aaf:	8b 45 08             	mov    0x8(%ebp),%eax
 ab2:	89 04 24             	mov    %eax,(%esp)
 ab5:	e8 2e fa ff ff       	call   4e8 <kthread_mutex_lock>
 aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 abd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ac1:	79 07                	jns    aca <qthread_mutex_lock+0x21>
    	return -1;
 ac3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ac8:	eb 05                	jmp    acf <qthread_mutex_lock+0x26>
    }
    return 0;
 aca:	b8 00 00 00 00       	mov    $0x0,%eax
}
 acf:	c9                   	leave  
 ad0:	c3                   	ret    

00000ad1 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 ad1:	55                   	push   %ebp
 ad2:	89 e5                	mov    %esp,%ebp
 ad4:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 ad7:	8b 45 08             	mov    0x8(%ebp),%eax
 ada:	89 04 24             	mov    %eax,(%esp)
 add:	e8 0e fa ff ff       	call   4f0 <kthread_mutex_unlock>
 ae2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 ae5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ae9:	79 07                	jns    af2 <qthread_mutex_unlock+0x21>
    	return -1;
 aeb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 af0:	eb 05                	jmp    af7 <qthread_mutex_unlock+0x26>
    }
    return 0;
 af2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 af7:	c9                   	leave  
 af8:	c3                   	ret    

00000af9 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 af9:	55                   	push   %ebp
 afa:	89 e5                	mov    %esp,%ebp

	return 0;
 afc:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b01:	5d                   	pop    %ebp
 b02:	c3                   	ret    

00000b03 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 b03:	55                   	push   %ebp
 b04:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b06:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b0b:	5d                   	pop    %ebp
 b0c:	c3                   	ret    

00000b0d <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 b0d:	55                   	push   %ebp
 b0e:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b10:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b15:	5d                   	pop    %ebp
 b16:	c3                   	ret    

00000b17 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 b17:	55                   	push   %ebp
 b18:	89 e5                	mov    %esp,%ebp
	return 0;
 b1a:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b1f:	5d                   	pop    %ebp
 b20:	c3                   	ret    

00000b21 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 b21:	55                   	push   %ebp
 b22:	89 e5                	mov    %esp,%ebp
	return 0;
 b24:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b29:	5d                   	pop    %ebp
 b2a:	c3                   	ret    

00000b2b <qthread_exit>:

int qthread_exit(){
 b2b:	55                   	push   %ebp
 b2c:	89 e5                	mov    %esp,%ebp
	return 0;
 b2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b33:	5d                   	pop    %ebp
 b34:	c3                   	ret    
