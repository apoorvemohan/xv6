
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
  32:	05 00 10 00 00       	add    $0x1000,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 00 10 00 00       	add    $0x1000,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	89 44 24 04          	mov    %eax,0x4(%esp)
  54:	c7 04 24 64 0b 00 00 	movl   $0xb64,(%esp)
  5b:	e8 58 02 00 00       	call   2b8 <strchr>
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
  92:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  99:	00 
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 b4 03 00 00       	call   459 <read>
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
  b8:	c7 44 24 04 6a 0b 00 	movl   $0xb6a,0x4(%esp)
  bf:	00 
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 55 05 00 00       	call   621 <printf>
    exit();
  cc:	e8 70 03 00 00       	call   441 <exit>
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
  ed:	c7 44 24 04 7a 0b 00 	movl   $0xb7a,0x4(%esp)
  f4:	00 
  f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fc:	e8 20 05 00 00       	call   621 <printf>
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
 112:	c7 44 24 04 87 0b 00 	movl   $0xb87,0x4(%esp)
 119:	00 
 11a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 121:	e8 da fe ff ff       	call   0 <wc>
    exit();
 126:	e8 16 03 00 00       	call   441 <exit>
  }

  for(i = 1; i < argc; i++){
 12b:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 132:	00 
 133:	e9 8f 00 00 00       	jmp    1c7 <main+0xc4>
    if((fd = open(argv[i], 0)) < 0){
 138:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 13c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 143:	8b 45 0c             	mov    0xc(%ebp),%eax
 146:	01 d0                	add    %edx,%eax
 148:	8b 00                	mov    (%eax),%eax
 14a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 151:	00 
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 27 03 00 00       	call   481 <open>
 15a:	89 44 24 18          	mov    %eax,0x18(%esp)
 15e:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
 163:	79 2f                	jns    194 <main+0x91>
      printf(1, "wc: cannot open %s\n", argv[i]);
 165:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 169:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 170:	8b 45 0c             	mov    0xc(%ebp),%eax
 173:	01 d0                	add    %edx,%eax
 175:	8b 00                	mov    (%eax),%eax
 177:	89 44 24 08          	mov    %eax,0x8(%esp)
 17b:	c7 44 24 04 88 0b 00 	movl   $0xb88,0x4(%esp)
 182:	00 
 183:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18a:	e8 92 04 00 00       	call   621 <printf>
      exit();
 18f:	e8 ad 02 00 00       	call   441 <exit>
    }
    wc(fd, argv[i]);
 194:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 19f:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a2:	01 d0                	add    %edx,%eax
 1a4:	8b 00                	mov    (%eax),%eax
 1a6:	89 44 24 04          	mov    %eax,0x4(%esp)
 1aa:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ae:	89 04 24             	mov    %eax,(%esp)
 1b1:	e8 4a fe ff ff       	call   0 <wc>
    close(fd);
 1b6:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ba:	89 04 24             	mov    %eax,(%esp)
 1bd:	e8 a7 02 00 00       	call   469 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1c2:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1c7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1cb:	3b 45 08             	cmp    0x8(%ebp),%eax
 1ce:	0f 8c 64 ff ff ff    	jl     138 <main+0x35>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1d4:	e8 68 02 00 00       	call   441 <exit>

000001d9 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
 1dc:	57                   	push   %edi
 1dd:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1de:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e1:	8b 55 10             	mov    0x10(%ebp),%edx
 1e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e7:	89 cb                	mov    %ecx,%ebx
 1e9:	89 df                	mov    %ebx,%edi
 1eb:	89 d1                	mov    %edx,%ecx
 1ed:	fc                   	cld    
 1ee:	f3 aa                	rep stos %al,%es:(%edi)
 1f0:	89 ca                	mov    %ecx,%edx
 1f2:	89 fb                	mov    %edi,%ebx
 1f4:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1f7:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1fa:	5b                   	pop    %ebx
 1fb:	5f                   	pop    %edi
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    

000001fe <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1fe:	55                   	push   %ebp
 1ff:	89 e5                	mov    %esp,%ebp
 201:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 20a:	90                   	nop
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	8d 50 01             	lea    0x1(%eax),%edx
 211:	89 55 08             	mov    %edx,0x8(%ebp)
 214:	8b 55 0c             	mov    0xc(%ebp),%edx
 217:	8d 4a 01             	lea    0x1(%edx),%ecx
 21a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 21d:	0f b6 12             	movzbl (%edx),%edx
 220:	88 10                	mov    %dl,(%eax)
 222:	0f b6 00             	movzbl (%eax),%eax
 225:	84 c0                	test   %al,%al
 227:	75 e2                	jne    20b <strcpy+0xd>
    ;
  return os;
 229:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 22c:	c9                   	leave  
 22d:	c3                   	ret    

0000022e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 22e:	55                   	push   %ebp
 22f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 231:	eb 08                	jmp    23b <strcmp+0xd>
    p++, q++;
 233:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 237:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	0f b6 00             	movzbl (%eax),%eax
 241:	84 c0                	test   %al,%al
 243:	74 10                	je     255 <strcmp+0x27>
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	0f b6 10             	movzbl (%eax),%edx
 24b:	8b 45 0c             	mov    0xc(%ebp),%eax
 24e:	0f b6 00             	movzbl (%eax),%eax
 251:	38 c2                	cmp    %al,%dl
 253:	74 de                	je     233 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 255:	8b 45 08             	mov    0x8(%ebp),%eax
 258:	0f b6 00             	movzbl (%eax),%eax
 25b:	0f b6 d0             	movzbl %al,%edx
 25e:	8b 45 0c             	mov    0xc(%ebp),%eax
 261:	0f b6 00             	movzbl (%eax),%eax
 264:	0f b6 c0             	movzbl %al,%eax
 267:	29 c2                	sub    %eax,%edx
 269:	89 d0                	mov    %edx,%eax
}
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    

0000026d <strlen>:

uint
strlen(char *s)
{
 26d:	55                   	push   %ebp
 26e:	89 e5                	mov    %esp,%ebp
 270:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 273:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 27a:	eb 04                	jmp    280 <strlen+0x13>
 27c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 280:	8b 55 fc             	mov    -0x4(%ebp),%edx
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 d0                	add    %edx,%eax
 288:	0f b6 00             	movzbl (%eax),%eax
 28b:	84 c0                	test   %al,%al
 28d:	75 ed                	jne    27c <strlen+0xf>
    ;
  return n;
 28f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 292:	c9                   	leave  
 293:	c3                   	ret    

00000294 <memset>:

void*
memset(void *dst, int c, uint n)
{
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 29a:	8b 45 10             	mov    0x10(%ebp),%eax
 29d:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 04 24             	mov    %eax,(%esp)
 2ae:	e8 26 ff ff ff       	call   1d9 <stosb>
  return dst;
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b6:	c9                   	leave  
 2b7:	c3                   	ret    

000002b8 <strchr>:

char*
strchr(const char *s, char c)
{
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	83 ec 04             	sub    $0x4,%esp
 2be:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c1:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2c4:	eb 14                	jmp    2da <strchr+0x22>
    if(*s == c)
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
 2c9:	0f b6 00             	movzbl (%eax),%eax
 2cc:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2cf:	75 05                	jne    2d6 <strchr+0x1e>
      return (char*)s;
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	eb 13                	jmp    2e9 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2d6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	0f b6 00             	movzbl (%eax),%eax
 2e0:	84 c0                	test   %al,%al
 2e2:	75 e2                	jne    2c6 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e9:	c9                   	leave  
 2ea:	c3                   	ret    

000002eb <gets>:

char*
gets(char *buf, int max)
{
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2f8:	eb 4c                	jmp    346 <gets+0x5b>
    cc = read(0, &c, 1);
 2fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 301:	00 
 302:	8d 45 ef             	lea    -0x11(%ebp),%eax
 305:	89 44 24 04          	mov    %eax,0x4(%esp)
 309:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 310:	e8 44 01 00 00       	call   459 <read>
 315:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 318:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 31c:	7f 02                	jg     320 <gets+0x35>
      break;
 31e:	eb 31                	jmp    351 <gets+0x66>
    buf[i++] = c;
 320:	8b 45 f4             	mov    -0xc(%ebp),%eax
 323:	8d 50 01             	lea    0x1(%eax),%edx
 326:	89 55 f4             	mov    %edx,-0xc(%ebp)
 329:	89 c2                	mov    %eax,%edx
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	01 c2                	add    %eax,%edx
 330:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 334:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 336:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 33a:	3c 0a                	cmp    $0xa,%al
 33c:	74 13                	je     351 <gets+0x66>
 33e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 342:	3c 0d                	cmp    $0xd,%al
 344:	74 0b                	je     351 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 346:	8b 45 f4             	mov    -0xc(%ebp),%eax
 349:	83 c0 01             	add    $0x1,%eax
 34c:	3b 45 0c             	cmp    0xc(%ebp),%eax
 34f:	7c a9                	jl     2fa <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 351:	8b 55 f4             	mov    -0xc(%ebp),%edx
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	01 d0                	add    %edx,%eax
 359:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 35c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 35f:	c9                   	leave  
 360:	c3                   	ret    

00000361 <stat>:

int
stat(char *n, struct stat *st)
{
 361:	55                   	push   %ebp
 362:	89 e5                	mov    %esp,%ebp
 364:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 367:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 36e:	00 
 36f:	8b 45 08             	mov    0x8(%ebp),%eax
 372:	89 04 24             	mov    %eax,(%esp)
 375:	e8 07 01 00 00       	call   481 <open>
 37a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 37d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 381:	79 07                	jns    38a <stat+0x29>
    return -1;
 383:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 388:	eb 23                	jmp    3ad <stat+0x4c>
  r = fstat(fd, st);
 38a:	8b 45 0c             	mov    0xc(%ebp),%eax
 38d:	89 44 24 04          	mov    %eax,0x4(%esp)
 391:	8b 45 f4             	mov    -0xc(%ebp),%eax
 394:	89 04 24             	mov    %eax,(%esp)
 397:	e8 fd 00 00 00       	call   499 <fstat>
 39c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 39f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a2:	89 04 24             	mov    %eax,(%esp)
 3a5:	e8 bf 00 00 00       	call   469 <close>
  return r;
 3aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 3ad:	c9                   	leave  
 3ae:	c3                   	ret    

000003af <atoi>:

int
atoi(const char *s)
{
 3af:	55                   	push   %ebp
 3b0:	89 e5                	mov    %esp,%ebp
 3b2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3bc:	eb 25                	jmp    3e3 <atoi+0x34>
    n = n*10 + *s++ - '0';
 3be:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c1:	89 d0                	mov    %edx,%eax
 3c3:	c1 e0 02             	shl    $0x2,%eax
 3c6:	01 d0                	add    %edx,%eax
 3c8:	01 c0                	add    %eax,%eax
 3ca:	89 c1                	mov    %eax,%ecx
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	8d 50 01             	lea    0x1(%eax),%edx
 3d2:	89 55 08             	mov    %edx,0x8(%ebp)
 3d5:	0f b6 00             	movzbl (%eax),%eax
 3d8:	0f be c0             	movsbl %al,%eax
 3db:	01 c8                	add    %ecx,%eax
 3dd:	83 e8 30             	sub    $0x30,%eax
 3e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	0f b6 00             	movzbl (%eax),%eax
 3e9:	3c 2f                	cmp    $0x2f,%al
 3eb:	7e 0a                	jle    3f7 <atoi+0x48>
 3ed:	8b 45 08             	mov    0x8(%ebp),%eax
 3f0:	0f b6 00             	movzbl (%eax),%eax
 3f3:	3c 39                	cmp    $0x39,%al
 3f5:	7e c7                	jle    3be <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fa:	c9                   	leave  
 3fb:	c3                   	ret    

000003fc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3fc:	55                   	push   %ebp
 3fd:	89 e5                	mov    %esp,%ebp
 3ff:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 402:	8b 45 08             	mov    0x8(%ebp),%eax
 405:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 408:	8b 45 0c             	mov    0xc(%ebp),%eax
 40b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 40e:	eb 17                	jmp    427 <memmove+0x2b>
    *dst++ = *src++;
 410:	8b 45 fc             	mov    -0x4(%ebp),%eax
 413:	8d 50 01             	lea    0x1(%eax),%edx
 416:	89 55 fc             	mov    %edx,-0x4(%ebp)
 419:	8b 55 f8             	mov    -0x8(%ebp),%edx
 41c:	8d 4a 01             	lea    0x1(%edx),%ecx
 41f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 422:	0f b6 12             	movzbl (%edx),%edx
 425:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 427:	8b 45 10             	mov    0x10(%ebp),%eax
 42a:	8d 50 ff             	lea    -0x1(%eax),%edx
 42d:	89 55 10             	mov    %edx,0x10(%ebp)
 430:	85 c0                	test   %eax,%eax
 432:	7f dc                	jg     410 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 434:	8b 45 08             	mov    0x8(%ebp),%eax
}
 437:	c9                   	leave  
 438:	c3                   	ret    

00000439 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 439:	b8 01 00 00 00       	mov    $0x1,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <exit>:
SYSCALL(exit)
 441:	b8 02 00 00 00       	mov    $0x2,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <wait>:
SYSCALL(wait)
 449:	b8 03 00 00 00       	mov    $0x3,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <pipe>:
SYSCALL(pipe)
 451:	b8 04 00 00 00       	mov    $0x4,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <read>:
SYSCALL(read)
 459:	b8 05 00 00 00       	mov    $0x5,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <write>:
SYSCALL(write)
 461:	b8 10 00 00 00       	mov    $0x10,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <close>:
SYSCALL(close)
 469:	b8 15 00 00 00       	mov    $0x15,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <kill>:
SYSCALL(kill)
 471:	b8 06 00 00 00       	mov    $0x6,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <exec>:
SYSCALL(exec)
 479:	b8 07 00 00 00       	mov    $0x7,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <open>:
SYSCALL(open)
 481:	b8 0f 00 00 00       	mov    $0xf,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <mknod>:
SYSCALL(mknod)
 489:	b8 11 00 00 00       	mov    $0x11,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <unlink>:
SYSCALL(unlink)
 491:	b8 12 00 00 00       	mov    $0x12,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <fstat>:
SYSCALL(fstat)
 499:	b8 08 00 00 00       	mov    $0x8,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <link>:
SYSCALL(link)
 4a1:	b8 13 00 00 00       	mov    $0x13,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <mkdir>:
SYSCALL(mkdir)
 4a9:	b8 14 00 00 00       	mov    $0x14,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <chdir>:
SYSCALL(chdir)
 4b1:	b8 09 00 00 00       	mov    $0x9,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <dup>:
SYSCALL(dup)
 4b9:	b8 0a 00 00 00       	mov    $0xa,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <getpid>:
SYSCALL(getpid)
 4c1:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <sbrk>:
SYSCALL(sbrk)
 4c9:	b8 0c 00 00 00       	mov    $0xc,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <sleep>:
SYSCALL(sleep)
 4d1:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <uptime>:
SYSCALL(uptime)
 4d9:	b8 0e 00 00 00       	mov    $0xe,%eax
 4de:	cd 40                	int    $0x40
 4e0:	c3                   	ret    

000004e1 <kthread_create>:
SYSCALL(kthread_create)
 4e1:	b8 17 00 00 00       	mov    $0x17,%eax
 4e6:	cd 40                	int    $0x40
 4e8:	c3                   	ret    

000004e9 <kthread_join>:
SYSCALL(kthread_join)
 4e9:	b8 16 00 00 00       	mov    $0x16,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret    

000004f1 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 4f1:	b8 18 00 00 00       	mov    $0x18,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret    

000004f9 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 4f9:	b8 19 00 00 00       	mov    $0x19,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret    

00000501 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 501:	b8 1a 00 00 00       	mov    $0x1a,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret    

00000509 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 509:	b8 1b 00 00 00       	mov    $0x1b,%eax
 50e:	cd 40                	int    $0x40
 510:	c3                   	ret    

00000511 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 511:	b8 1c 00 00 00       	mov    $0x1c,%eax
 516:	cd 40                	int    $0x40
 518:	c3                   	ret    

00000519 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 519:	b8 1d 00 00 00       	mov    $0x1d,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret    

00000521 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 521:	b8 1e 00 00 00       	mov    $0x1e,%eax
 526:	cd 40                	int    $0x40
 528:	c3                   	ret    

00000529 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 529:	b8 1f 00 00 00       	mov    $0x1f,%eax
 52e:	cd 40                	int    $0x40
 530:	c3                   	ret    

00000531 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 531:	b8 20 00 00 00       	mov    $0x20,%eax
 536:	cd 40                	int    $0x40
 538:	c3                   	ret    

00000539 <kthread_exit>:
 539:	b8 21 00 00 00       	mov    $0x21,%eax
 53e:	cd 40                	int    $0x40
 540:	c3                   	ret    

00000541 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 541:	55                   	push   %ebp
 542:	89 e5                	mov    %esp,%ebp
 544:	83 ec 18             	sub    $0x18,%esp
 547:	8b 45 0c             	mov    0xc(%ebp),%eax
 54a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 54d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 554:	00 
 555:	8d 45 f4             	lea    -0xc(%ebp),%eax
 558:	89 44 24 04          	mov    %eax,0x4(%esp)
 55c:	8b 45 08             	mov    0x8(%ebp),%eax
 55f:	89 04 24             	mov    %eax,(%esp)
 562:	e8 fa fe ff ff       	call   461 <write>
}
 567:	c9                   	leave  
 568:	c3                   	ret    

00000569 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 569:	55                   	push   %ebp
 56a:	89 e5                	mov    %esp,%ebp
 56c:	56                   	push   %esi
 56d:	53                   	push   %ebx
 56e:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 571:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 578:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 57c:	74 17                	je     595 <printint+0x2c>
 57e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 582:	79 11                	jns    595 <printint+0x2c>
    neg = 1;
 584:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 58b:	8b 45 0c             	mov    0xc(%ebp),%eax
 58e:	f7 d8                	neg    %eax
 590:	89 45 ec             	mov    %eax,-0x14(%ebp)
 593:	eb 06                	jmp    59b <printint+0x32>
  } else {
    x = xx;
 595:	8b 45 0c             	mov    0xc(%ebp),%eax
 598:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 59b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5a2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 5a5:	8d 41 01             	lea    0x1(%ecx),%eax
 5a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 5ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b1:	ba 00 00 00 00       	mov    $0x0,%edx
 5b6:	f7 f3                	div    %ebx
 5b8:	89 d0                	mov    %edx,%eax
 5ba:	0f b6 80 b0 0f 00 00 	movzbl 0xfb0(%eax),%eax
 5c1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 5c5:	8b 75 10             	mov    0x10(%ebp),%esi
 5c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5cb:	ba 00 00 00 00       	mov    $0x0,%edx
 5d0:	f7 f6                	div    %esi
 5d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5d9:	75 c7                	jne    5a2 <printint+0x39>
  if(neg)
 5db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5df:	74 10                	je     5f1 <printint+0x88>
    buf[i++] = '-';
 5e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e4:	8d 50 01             	lea    0x1(%eax),%edx
 5e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5ea:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5ef:	eb 1f                	jmp    610 <printint+0xa7>
 5f1:	eb 1d                	jmp    610 <printint+0xa7>
    putc(fd, buf[i]);
 5f3:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f9:	01 d0                	add    %edx,%eax
 5fb:	0f b6 00             	movzbl (%eax),%eax
 5fe:	0f be c0             	movsbl %al,%eax
 601:	89 44 24 04          	mov    %eax,0x4(%esp)
 605:	8b 45 08             	mov    0x8(%ebp),%eax
 608:	89 04 24             	mov    %eax,(%esp)
 60b:	e8 31 ff ff ff       	call   541 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 610:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 614:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 618:	79 d9                	jns    5f3 <printint+0x8a>
    putc(fd, buf[i]);
}
 61a:	83 c4 30             	add    $0x30,%esp
 61d:	5b                   	pop    %ebx
 61e:	5e                   	pop    %esi
 61f:	5d                   	pop    %ebp
 620:	c3                   	ret    

00000621 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 621:	55                   	push   %ebp
 622:	89 e5                	mov    %esp,%ebp
 624:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 627:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 62e:	8d 45 0c             	lea    0xc(%ebp),%eax
 631:	83 c0 04             	add    $0x4,%eax
 634:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 637:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 63e:	e9 7c 01 00 00       	jmp    7bf <printf+0x19e>
    c = fmt[i] & 0xff;
 643:	8b 55 0c             	mov    0xc(%ebp),%edx
 646:	8b 45 f0             	mov    -0x10(%ebp),%eax
 649:	01 d0                	add    %edx,%eax
 64b:	0f b6 00             	movzbl (%eax),%eax
 64e:	0f be c0             	movsbl %al,%eax
 651:	25 ff 00 00 00       	and    $0xff,%eax
 656:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 659:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 65d:	75 2c                	jne    68b <printf+0x6a>
      if(c == '%'){
 65f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 663:	75 0c                	jne    671 <printf+0x50>
        state = '%';
 665:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 66c:	e9 4a 01 00 00       	jmp    7bb <printf+0x19a>
      } else {
        putc(fd, c);
 671:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 674:	0f be c0             	movsbl %al,%eax
 677:	89 44 24 04          	mov    %eax,0x4(%esp)
 67b:	8b 45 08             	mov    0x8(%ebp),%eax
 67e:	89 04 24             	mov    %eax,(%esp)
 681:	e8 bb fe ff ff       	call   541 <putc>
 686:	e9 30 01 00 00       	jmp    7bb <printf+0x19a>
      }
    } else if(state == '%'){
 68b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 68f:	0f 85 26 01 00 00    	jne    7bb <printf+0x19a>
      if(c == 'd'){
 695:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 699:	75 2d                	jne    6c8 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 69b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 6a7:	00 
 6a8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 6af:	00 
 6b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b4:	8b 45 08             	mov    0x8(%ebp),%eax
 6b7:	89 04 24             	mov    %eax,(%esp)
 6ba:	e8 aa fe ff ff       	call   569 <printint>
        ap++;
 6bf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c3:	e9 ec 00 00 00       	jmp    7b4 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 6c8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6cc:	74 06                	je     6d4 <printf+0xb3>
 6ce:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6d2:	75 2d                	jne    701 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6e0:	00 
 6e1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6e8:	00 
 6e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ed:	8b 45 08             	mov    0x8(%ebp),%eax
 6f0:	89 04 24             	mov    %eax,(%esp)
 6f3:	e8 71 fe ff ff       	call   569 <printint>
        ap++;
 6f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6fc:	e9 b3 00 00 00       	jmp    7b4 <printf+0x193>
      } else if(c == 's'){
 701:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 705:	75 45                	jne    74c <printf+0x12b>
        s = (char*)*ap;
 707:	8b 45 e8             	mov    -0x18(%ebp),%eax
 70a:	8b 00                	mov    (%eax),%eax
 70c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 70f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 713:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 717:	75 09                	jne    722 <printf+0x101>
          s = "(null)";
 719:	c7 45 f4 9c 0b 00 00 	movl   $0xb9c,-0xc(%ebp)
        while(*s != 0){
 720:	eb 1e                	jmp    740 <printf+0x11f>
 722:	eb 1c                	jmp    740 <printf+0x11f>
          putc(fd, *s);
 724:	8b 45 f4             	mov    -0xc(%ebp),%eax
 727:	0f b6 00             	movzbl (%eax),%eax
 72a:	0f be c0             	movsbl %al,%eax
 72d:	89 44 24 04          	mov    %eax,0x4(%esp)
 731:	8b 45 08             	mov    0x8(%ebp),%eax
 734:	89 04 24             	mov    %eax,(%esp)
 737:	e8 05 fe ff ff       	call   541 <putc>
          s++;
 73c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 740:	8b 45 f4             	mov    -0xc(%ebp),%eax
 743:	0f b6 00             	movzbl (%eax),%eax
 746:	84 c0                	test   %al,%al
 748:	75 da                	jne    724 <printf+0x103>
 74a:	eb 68                	jmp    7b4 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 74c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 750:	75 1d                	jne    76f <printf+0x14e>
        putc(fd, *ap);
 752:	8b 45 e8             	mov    -0x18(%ebp),%eax
 755:	8b 00                	mov    (%eax),%eax
 757:	0f be c0             	movsbl %al,%eax
 75a:	89 44 24 04          	mov    %eax,0x4(%esp)
 75e:	8b 45 08             	mov    0x8(%ebp),%eax
 761:	89 04 24             	mov    %eax,(%esp)
 764:	e8 d8 fd ff ff       	call   541 <putc>
        ap++;
 769:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 76d:	eb 45                	jmp    7b4 <printf+0x193>
      } else if(c == '%'){
 76f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 773:	75 17                	jne    78c <printf+0x16b>
        putc(fd, c);
 775:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 778:	0f be c0             	movsbl %al,%eax
 77b:	89 44 24 04          	mov    %eax,0x4(%esp)
 77f:	8b 45 08             	mov    0x8(%ebp),%eax
 782:	89 04 24             	mov    %eax,(%esp)
 785:	e8 b7 fd ff ff       	call   541 <putc>
 78a:	eb 28                	jmp    7b4 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 78c:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 793:	00 
 794:	8b 45 08             	mov    0x8(%ebp),%eax
 797:	89 04 24             	mov    %eax,(%esp)
 79a:	e8 a2 fd ff ff       	call   541 <putc>
        putc(fd, c);
 79f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7a2:	0f be c0             	movsbl %al,%eax
 7a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ac:	89 04 24             	mov    %eax,(%esp)
 7af:	e8 8d fd ff ff       	call   541 <putc>
      }
      state = 0;
 7b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7bb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7bf:	8b 55 0c             	mov    0xc(%ebp),%edx
 7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c5:	01 d0                	add    %edx,%eax
 7c7:	0f b6 00             	movzbl (%eax),%eax
 7ca:	84 c0                	test   %al,%al
 7cc:	0f 85 71 fe ff ff    	jne    643 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7d2:	c9                   	leave  
 7d3:	c3                   	ret    

000007d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d4:	55                   	push   %ebp
 7d5:	89 e5                	mov    %esp,%ebp
 7d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7da:	8b 45 08             	mov    0x8(%ebp),%eax
 7dd:	83 e8 08             	sub    $0x8,%eax
 7e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e3:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 7e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7eb:	eb 24                	jmp    811 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7f5:	77 12                	ja     809 <free+0x35>
 7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7fd:	77 24                	ja     823 <free+0x4f>
 7ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 802:	8b 00                	mov    (%eax),%eax
 804:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 807:	77 1a                	ja     823 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 809:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80c:	8b 00                	mov    (%eax),%eax
 80e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 811:	8b 45 f8             	mov    -0x8(%ebp),%eax
 814:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 817:	76 d4                	jbe    7ed <free+0x19>
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	8b 00                	mov    (%eax),%eax
 81e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 821:	76 ca                	jbe    7ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 823:	8b 45 f8             	mov    -0x8(%ebp),%eax
 826:	8b 40 04             	mov    0x4(%eax),%eax
 829:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 830:	8b 45 f8             	mov    -0x8(%ebp),%eax
 833:	01 c2                	add    %eax,%edx
 835:	8b 45 fc             	mov    -0x4(%ebp),%eax
 838:	8b 00                	mov    (%eax),%eax
 83a:	39 c2                	cmp    %eax,%edx
 83c:	75 24                	jne    862 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 83e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 841:	8b 50 04             	mov    0x4(%eax),%edx
 844:	8b 45 fc             	mov    -0x4(%ebp),%eax
 847:	8b 00                	mov    (%eax),%eax
 849:	8b 40 04             	mov    0x4(%eax),%eax
 84c:	01 c2                	add    %eax,%edx
 84e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 851:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 854:	8b 45 fc             	mov    -0x4(%ebp),%eax
 857:	8b 00                	mov    (%eax),%eax
 859:	8b 10                	mov    (%eax),%edx
 85b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85e:	89 10                	mov    %edx,(%eax)
 860:	eb 0a                	jmp    86c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 862:	8b 45 fc             	mov    -0x4(%ebp),%eax
 865:	8b 10                	mov    (%eax),%edx
 867:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 86c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86f:	8b 40 04             	mov    0x4(%eax),%eax
 872:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 879:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87c:	01 d0                	add    %edx,%eax
 87e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 881:	75 20                	jne    8a3 <free+0xcf>
    p->s.size += bp->s.size;
 883:	8b 45 fc             	mov    -0x4(%ebp),%eax
 886:	8b 50 04             	mov    0x4(%eax),%edx
 889:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88c:	8b 40 04             	mov    0x4(%eax),%eax
 88f:	01 c2                	add    %eax,%edx
 891:	8b 45 fc             	mov    -0x4(%ebp),%eax
 894:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 897:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89a:	8b 10                	mov    (%eax),%edx
 89c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89f:	89 10                	mov    %edx,(%eax)
 8a1:	eb 08                	jmp    8ab <free+0xd7>
  } else
    p->s.ptr = bp;
 8a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8a9:	89 10                	mov    %edx,(%eax)
  freep = p;
 8ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ae:	a3 e8 0f 00 00       	mov    %eax,0xfe8
}
 8b3:	c9                   	leave  
 8b4:	c3                   	ret    

000008b5 <morecore>:

static Header*
morecore(uint nu)
{
 8b5:	55                   	push   %ebp
 8b6:	89 e5                	mov    %esp,%ebp
 8b8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8bb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8c2:	77 07                	ja     8cb <morecore+0x16>
    nu = 4096;
 8c4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8cb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ce:	c1 e0 03             	shl    $0x3,%eax
 8d1:	89 04 24             	mov    %eax,(%esp)
 8d4:	e8 f0 fb ff ff       	call   4c9 <sbrk>
 8d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8dc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8e0:	75 07                	jne    8e9 <morecore+0x34>
    return 0;
 8e2:	b8 00 00 00 00       	mov    $0x0,%eax
 8e7:	eb 22                	jmp    90b <morecore+0x56>
  hp = (Header*)p;
 8e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f2:	8b 55 08             	mov    0x8(%ebp),%edx
 8f5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fb:	83 c0 08             	add    $0x8,%eax
 8fe:	89 04 24             	mov    %eax,(%esp)
 901:	e8 ce fe ff ff       	call   7d4 <free>
  return freep;
 906:	a1 e8 0f 00 00       	mov    0xfe8,%eax
}
 90b:	c9                   	leave  
 90c:	c3                   	ret    

0000090d <malloc>:

void*
malloc(uint nbytes)
{
 90d:	55                   	push   %ebp
 90e:	89 e5                	mov    %esp,%ebp
 910:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 913:	8b 45 08             	mov    0x8(%ebp),%eax
 916:	83 c0 07             	add    $0x7,%eax
 919:	c1 e8 03             	shr    $0x3,%eax
 91c:	83 c0 01             	add    $0x1,%eax
 91f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 922:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 927:	89 45 f0             	mov    %eax,-0x10(%ebp)
 92a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 92e:	75 23                	jne    953 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 930:	c7 45 f0 e0 0f 00 00 	movl   $0xfe0,-0x10(%ebp)
 937:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93a:	a3 e8 0f 00 00       	mov    %eax,0xfe8
 93f:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 944:	a3 e0 0f 00 00       	mov    %eax,0xfe0
    base.s.size = 0;
 949:	c7 05 e4 0f 00 00 00 	movl   $0x0,0xfe4
 950:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 953:	8b 45 f0             	mov    -0x10(%ebp),%eax
 956:	8b 00                	mov    (%eax),%eax
 958:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 95b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95e:	8b 40 04             	mov    0x4(%eax),%eax
 961:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 964:	72 4d                	jb     9b3 <malloc+0xa6>
      if(p->s.size == nunits)
 966:	8b 45 f4             	mov    -0xc(%ebp),%eax
 969:	8b 40 04             	mov    0x4(%eax),%eax
 96c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 96f:	75 0c                	jne    97d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 971:	8b 45 f4             	mov    -0xc(%ebp),%eax
 974:	8b 10                	mov    (%eax),%edx
 976:	8b 45 f0             	mov    -0x10(%ebp),%eax
 979:	89 10                	mov    %edx,(%eax)
 97b:	eb 26                	jmp    9a3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 97d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 980:	8b 40 04             	mov    0x4(%eax),%eax
 983:	2b 45 ec             	sub    -0x14(%ebp),%eax
 986:	89 c2                	mov    %eax,%edx
 988:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 98e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 991:	8b 40 04             	mov    0x4(%eax),%eax
 994:	c1 e0 03             	shl    $0x3,%eax
 997:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 99a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9a0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a6:	a3 e8 0f 00 00       	mov    %eax,0xfe8
      return (void*)(p + 1);
 9ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ae:	83 c0 08             	add    $0x8,%eax
 9b1:	eb 38                	jmp    9eb <malloc+0xde>
    }
    if(p == freep)
 9b3:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 9b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9bb:	75 1b                	jne    9d8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 9bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9c0:	89 04 24             	mov    %eax,(%esp)
 9c3:	e8 ed fe ff ff       	call   8b5 <morecore>
 9c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9cf:	75 07                	jne    9d8 <malloc+0xcb>
        return 0;
 9d1:	b8 00 00 00 00       	mov    $0x0,%eax
 9d6:	eb 13                	jmp    9eb <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9db:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e1:	8b 00                	mov    (%eax),%eax
 9e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9e6:	e9 70 ff ff ff       	jmp    95b <malloc+0x4e>
}
 9eb:	c9                   	leave  
 9ec:	c3                   	ret    

000009ed <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 9ed:	55                   	push   %ebp
 9ee:	89 e5                	mov    %esp,%ebp
 9f0:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 9f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 9f6:	89 04 24             	mov    %eax,(%esp)
 9f9:	8b 45 08             	mov    0x8(%ebp),%eax
 9fc:	ff d0                	call   *%eax
    exit();
 9fe:	e8 3e fa ff ff       	call   441 <exit>

00000a03 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 a03:	55                   	push   %ebp
 a04:	89 e5                	mov    %esp,%ebp
 a06:	57                   	push   %edi
 a07:	56                   	push   %esi
 a08:	53                   	push   %ebx
 a09:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 a0c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 a13:	e8 f5 fe ff ff       	call   90d <malloc>
 a18:	8b 55 08             	mov    0x8(%ebp),%edx
 a1b:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 a1d:	8b 45 10             	mov    0x10(%ebp),%eax
 a20:	8b 38                	mov    (%eax),%edi
 a22:	8b 75 0c             	mov    0xc(%ebp),%esi
 a25:	bb ed 09 00 00       	mov    $0x9ed,%ebx
 a2a:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a31:	e8 d7 fe ff ff       	call   90d <malloc>
 a36:	05 00 10 00 00       	add    $0x1000,%eax
 a3b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 a3f:	89 74 24 08          	mov    %esi,0x8(%esp)
 a43:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 a47:	89 04 24             	mov    %eax,(%esp)
 a4a:	e8 92 fa ff ff       	call   4e1 <kthread_create>
 a4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 a52:	8b 45 08             	mov    0x8(%ebp),%eax
 a55:	8b 00                	mov    (%eax),%eax
 a57:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 a5a:	89 10                	mov    %edx,(%eax)
    return t_id;
 a5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 a5f:	83 c4 2c             	add    $0x2c,%esp
 a62:	5b                   	pop    %ebx
 a63:	5e                   	pop    %esi
 a64:	5f                   	pop    %edi
 a65:	5d                   	pop    %ebp
 a66:	c3                   	ret    

00000a67 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 a67:	55                   	push   %ebp
 a68:	89 e5                	mov    %esp,%ebp
 a6a:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 a6d:	8b 55 0c             	mov    0xc(%ebp),%edx
 a70:	8b 45 08             	mov    0x8(%ebp),%eax
 a73:	8b 00                	mov    (%eax),%eax
 a75:	89 54 24 04          	mov    %edx,0x4(%esp)
 a79:	89 04 24             	mov    %eax,(%esp)
 a7c:	e8 68 fa ff ff       	call   4e9 <kthread_join>
 a81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 a87:	c9                   	leave  
 a88:	c3                   	ret    

00000a89 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 a89:	55                   	push   %ebp
 a8a:	89 e5                	mov    %esp,%ebp
 a8c:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 a8f:	e8 5d fa ff ff       	call   4f1 <kthread_mutex_init>
 a94:	8b 55 08             	mov    0x8(%ebp),%edx
 a97:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
 a9c:	8b 00                	mov    (%eax),%eax
 a9e:	85 c0                	test   %eax,%eax
 aa0:	7e 07                	jle    aa9 <qthread_mutex_init+0x20>
		return 0;
 aa2:	b8 00 00 00 00       	mov    $0x0,%eax
 aa7:	eb 05                	jmp    aae <qthread_mutex_init+0x25>
	}
	return *mutex;
 aa9:	8b 45 08             	mov    0x8(%ebp),%eax
 aac:	8b 00                	mov    (%eax),%eax
}
 aae:	c9                   	leave  
 aaf:	c3                   	ret    

00000ab0 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 ab0:	55                   	push   %ebp
 ab1:	89 e5                	mov    %esp,%ebp
 ab3:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 ab6:	8b 45 08             	mov    0x8(%ebp),%eax
 ab9:	89 04 24             	mov    %eax,(%esp)
 abc:	e8 38 fa ff ff       	call   4f9 <kthread_mutex_destroy>
 ac1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 ac4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ac8:	79 07                	jns    ad1 <qthread_mutex_destroy+0x21>
    	return -1;
 aca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 acf:	eb 05                	jmp    ad6 <qthread_mutex_destroy+0x26>
    }
    return 0;
 ad1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ad6:	c9                   	leave  
 ad7:	c3                   	ret    

00000ad8 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 ad8:	55                   	push   %ebp
 ad9:	89 e5                	mov    %esp,%ebp
 adb:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 ade:	8b 45 08             	mov    0x8(%ebp),%eax
 ae1:	89 04 24             	mov    %eax,(%esp)
 ae4:	e8 18 fa ff ff       	call   501 <kthread_mutex_lock>
 ae9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 aec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 af0:	79 07                	jns    af9 <qthread_mutex_lock+0x21>
    	return -1;
 af2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 af7:	eb 05                	jmp    afe <qthread_mutex_lock+0x26>
    }
    return 0;
 af9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 afe:	c9                   	leave  
 aff:	c3                   	ret    

00000b00 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 b06:	8b 45 08             	mov    0x8(%ebp),%eax
 b09:	89 04 24             	mov    %eax,(%esp)
 b0c:	e8 f8 f9 ff ff       	call   509 <kthread_mutex_unlock>
 b11:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 b14:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b18:	79 07                	jns    b21 <qthread_mutex_unlock+0x21>
    	return -1;
 b1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b1f:	eb 05                	jmp    b26 <qthread_mutex_unlock+0x26>
    }
    return 0;
 b21:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b26:	c9                   	leave  
 b27:	c3                   	ret    

00000b28 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 b28:	55                   	push   %ebp
 b29:	89 e5                	mov    %esp,%ebp

	return 0;
 b2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b30:	5d                   	pop    %ebp
 b31:	c3                   	ret    

00000b32 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 b32:	55                   	push   %ebp
 b33:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b35:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b3a:	5d                   	pop    %ebp
 b3b:	c3                   	ret    

00000b3c <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 b3c:	55                   	push   %ebp
 b3d:	89 e5                	mov    %esp,%ebp
    
    return 0;
 b3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b44:	5d                   	pop    %ebp
 b45:	c3                   	ret    

00000b46 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 b46:	55                   	push   %ebp
 b47:	89 e5                	mov    %esp,%ebp
	return 0;
 b49:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret    

00000b50 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
	return 0;
 b53:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 b58:	5d                   	pop    %ebp
 b59:	c3                   	ret    

00000b5a <qthread_exit>:

int qthread_exit(){
 b5a:	55                   	push   %ebp
 b5b:	89 e5                	mov    %esp,%ebp
	return 0;
 b5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b62:	5d                   	pop    %ebp
 b63:	c3                   	ret    
