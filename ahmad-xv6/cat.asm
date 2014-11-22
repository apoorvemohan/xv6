
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
   f:	c7 44 24 04 20 0f 00 	movl   $0xf20,0x4(%esp)
  16:	00 
  17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1e:	e8 82 03 00 00       	call   3a5 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 20 0f 00 	movl   $0xf20,0x4(%esp)
  32:	00 
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 5f 03 00 00       	call   39d <read>
  3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  45:	7f c1                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
  4d:	c7 44 24 04 a8 0a 00 	movl   $0xaa8,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 04 05 00 00       	call   565 <printf>
    exit();
  61:	e8 1f 03 00 00       	call   385 <exit>
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
  83:	e8 fd 02 00 00       	call   385 <exit>
  }

  for(i = 1; i < argc; i++){
  88:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  8f:	00 
  90:	eb 79                	jmp    10b <main+0xa3>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  96:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  a0:	01 d0                	add    %edx,%eax
  a2:	8b 00                	mov    (%eax),%eax
  a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  ab:	00 
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 11 03 00 00       	call   3c5 <open>
  b4:	89 44 24 18          	mov    %eax,0x18(%esp)
  b8:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  bd:	79 2f                	jns    ee <main+0x86>
      printf(1, "cat: cannot open %s\n", argv[i]);
  bf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	01 d0                	add    %edx,%eax
  cf:	8b 00                	mov    (%eax),%eax
  d1:	89 44 24 08          	mov    %eax,0x8(%esp)
  d5:	c7 44 24 04 b9 0a 00 	movl   $0xab9,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e4:	e8 7c 04 00 00       	call   565 <printf>
      exit();
  e9:	e8 97 02 00 00       	call   385 <exit>
    }
    cat(fd);
  ee:	8b 44 24 18          	mov    0x18(%esp),%eax
  f2:	89 04 24             	mov    %eax,(%esp)
  f5:	e8 06 ff ff ff       	call   0 <cat>
    close(fd);
  fa:	8b 44 24 18          	mov    0x18(%esp),%eax
  fe:	89 04 24             	mov    %eax,(%esp)
 101:	e8 a7 02 00 00       	call   3ad <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
 106:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 10b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 10f:	3b 45 08             	cmp    0x8(%ebp),%eax
 112:	0f 8c 7a ff ff ff    	jl     92 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 118:	e8 68 02 00 00       	call   385 <exit>

0000011d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	57                   	push   %edi
 121:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 122:	8b 4d 08             	mov    0x8(%ebp),%ecx
 125:	8b 55 10             	mov    0x10(%ebp),%edx
 128:	8b 45 0c             	mov    0xc(%ebp),%eax
 12b:	89 cb                	mov    %ecx,%ebx
 12d:	89 df                	mov    %ebx,%edi
 12f:	89 d1                	mov    %edx,%ecx
 131:	fc                   	cld    
 132:	f3 aa                	rep stos %al,%es:(%edi)
 134:	89 ca                	mov    %ecx,%edx
 136:	89 fb                	mov    %edi,%ebx
 138:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 13e:	5b                   	pop    %ebx
 13f:	5f                   	pop    %edi
 140:	5d                   	pop    %ebp
 141:	c3                   	ret    

00000142 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 142:	55                   	push   %ebp
 143:	89 e5                	mov    %esp,%ebp
 145:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 14e:	90                   	nop
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	8d 50 01             	lea    0x1(%eax),%edx
 155:	89 55 08             	mov    %edx,0x8(%ebp)
 158:	8b 55 0c             	mov    0xc(%ebp),%edx
 15b:	8d 4a 01             	lea    0x1(%edx),%ecx
 15e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 161:	0f b6 12             	movzbl (%edx),%edx
 164:	88 10                	mov    %dl,(%eax)
 166:	0f b6 00             	movzbl (%eax),%eax
 169:	84 c0                	test   %al,%al
 16b:	75 e2                	jne    14f <strcpy+0xd>
    ;
  return os;
 16d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 170:	c9                   	leave  
 171:	c3                   	ret    

00000172 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 172:	55                   	push   %ebp
 173:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 175:	eb 08                	jmp    17f <strcmp+0xd>
    p++, q++;
 177:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	0f b6 00             	movzbl (%eax),%eax
 185:	84 c0                	test   %al,%al
 187:	74 10                	je     199 <strcmp+0x27>
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	0f b6 10             	movzbl (%eax),%edx
 18f:	8b 45 0c             	mov    0xc(%ebp),%eax
 192:	0f b6 00             	movzbl (%eax),%eax
 195:	38 c2                	cmp    %al,%dl
 197:	74 de                	je     177 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 199:	8b 45 08             	mov    0x8(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 d0             	movzbl %al,%edx
 1a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a5:	0f b6 00             	movzbl (%eax),%eax
 1a8:	0f b6 c0             	movzbl %al,%eax
 1ab:	29 c2                	sub    %eax,%edx
 1ad:	89 d0                	mov    %edx,%eax
}
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret    

000001b1 <strlen>:

uint
strlen(char *s)
{
 1b1:	55                   	push   %ebp
 1b2:	89 e5                	mov    %esp,%ebp
 1b4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1be:	eb 04                	jmp    1c4 <strlen+0x13>
 1c0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	01 d0                	add    %edx,%eax
 1cc:	0f b6 00             	movzbl (%eax),%eax
 1cf:	84 c0                	test   %al,%al
 1d1:	75 ed                	jne    1c0 <strlen+0xf>
    ;
  return n;
 1d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d6:	c9                   	leave  
 1d7:	c3                   	ret    

000001d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1de:	8b 45 10             	mov    0x10(%ebp),%eax
 1e1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	89 04 24             	mov    %eax,(%esp)
 1f2:	e8 26 ff ff ff       	call   11d <stosb>
  return dst;
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fa:	c9                   	leave  
 1fb:	c3                   	ret    

000001fc <strchr>:

char*
strchr(const char *s, char c)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	83 ec 04             	sub    $0x4,%esp
 202:	8b 45 0c             	mov    0xc(%ebp),%eax
 205:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 208:	eb 14                	jmp    21e <strchr+0x22>
    if(*s == c)
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	0f b6 00             	movzbl (%eax),%eax
 210:	3a 45 fc             	cmp    -0x4(%ebp),%al
 213:	75 05                	jne    21a <strchr+0x1e>
      return (char*)s;
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	eb 13                	jmp    22d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 21a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	0f b6 00             	movzbl (%eax),%eax
 224:	84 c0                	test   %al,%al
 226:	75 e2                	jne    20a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 228:	b8 00 00 00 00       	mov    $0x0,%eax
}
 22d:	c9                   	leave  
 22e:	c3                   	ret    

0000022f <gets>:

char*
gets(char *buf, int max)
{
 22f:	55                   	push   %ebp
 230:	89 e5                	mov    %esp,%ebp
 232:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 23c:	eb 4c                	jmp    28a <gets+0x5b>
    cc = read(0, &c, 1);
 23e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 245:	00 
 246:	8d 45 ef             	lea    -0x11(%ebp),%eax
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 254:	e8 44 01 00 00       	call   39d <read>
 259:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 25c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 260:	7f 02                	jg     264 <gets+0x35>
      break;
 262:	eb 31                	jmp    295 <gets+0x66>
    buf[i++] = c;
 264:	8b 45 f4             	mov    -0xc(%ebp),%eax
 267:	8d 50 01             	lea    0x1(%eax),%edx
 26a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 26d:	89 c2                	mov    %eax,%edx
 26f:	8b 45 08             	mov    0x8(%ebp),%eax
 272:	01 c2                	add    %eax,%edx
 274:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 278:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 27a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27e:	3c 0a                	cmp    $0xa,%al
 280:	74 13                	je     295 <gets+0x66>
 282:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 286:	3c 0d                	cmp    $0xd,%al
 288:	74 0b                	je     295 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28d:	83 c0 01             	add    $0x1,%eax
 290:	3b 45 0c             	cmp    0xc(%ebp),%eax
 293:	7c a9                	jl     23e <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 295:	8b 55 f4             	mov    -0xc(%ebp),%edx
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	01 d0                	add    %edx,%eax
 29d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a3:	c9                   	leave  
 2a4:	c3                   	ret    

000002a5 <stat>:

int
stat(char *n, struct stat *st)
{
 2a5:	55                   	push   %ebp
 2a6:	89 e5                	mov    %esp,%ebp
 2a8:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b2:	00 
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	89 04 24             	mov    %eax,(%esp)
 2b9:	e8 07 01 00 00       	call   3c5 <open>
 2be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c5:	79 07                	jns    2ce <stat+0x29>
    return -1;
 2c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2cc:	eb 23                	jmp    2f1 <stat+0x4c>
  r = fstat(fd, st);
 2ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d8:	89 04 24             	mov    %eax,(%esp)
 2db:	e8 fd 00 00 00       	call   3dd <fstat>
 2e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e6:	89 04 24             	mov    %eax,(%esp)
 2e9:	e8 bf 00 00 00       	call   3ad <close>
  return r;
 2ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2f1:	c9                   	leave  
 2f2:	c3                   	ret    

000002f3 <atoi>:

int
atoi(const char *s)
{
 2f3:	55                   	push   %ebp
 2f4:	89 e5                	mov    %esp,%ebp
 2f6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 300:	eb 25                	jmp    327 <atoi+0x34>
    n = n*10 + *s++ - '0';
 302:	8b 55 fc             	mov    -0x4(%ebp),%edx
 305:	89 d0                	mov    %edx,%eax
 307:	c1 e0 02             	shl    $0x2,%eax
 30a:	01 d0                	add    %edx,%eax
 30c:	01 c0                	add    %eax,%eax
 30e:	89 c1                	mov    %eax,%ecx
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	8d 50 01             	lea    0x1(%eax),%edx
 316:	89 55 08             	mov    %edx,0x8(%ebp)
 319:	0f b6 00             	movzbl (%eax),%eax
 31c:	0f be c0             	movsbl %al,%eax
 31f:	01 c8                	add    %ecx,%eax
 321:	83 e8 30             	sub    $0x30,%eax
 324:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	8b 45 08             	mov    0x8(%ebp),%eax
 32a:	0f b6 00             	movzbl (%eax),%eax
 32d:	3c 2f                	cmp    $0x2f,%al
 32f:	7e 0a                	jle    33b <atoi+0x48>
 331:	8b 45 08             	mov    0x8(%ebp),%eax
 334:	0f b6 00             	movzbl (%eax),%eax
 337:	3c 39                	cmp    $0x39,%al
 339:	7e c7                	jle    302 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 33b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 33e:	c9                   	leave  
 33f:	c3                   	ret    

00000340 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 34c:	8b 45 0c             	mov    0xc(%ebp),%eax
 34f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 352:	eb 17                	jmp    36b <memmove+0x2b>
    *dst++ = *src++;
 354:	8b 45 fc             	mov    -0x4(%ebp),%eax
 357:	8d 50 01             	lea    0x1(%eax),%edx
 35a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 35d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 360:	8d 4a 01             	lea    0x1(%edx),%ecx
 363:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 366:	0f b6 12             	movzbl (%edx),%edx
 369:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36b:	8b 45 10             	mov    0x10(%ebp),%eax
 36e:	8d 50 ff             	lea    -0x1(%eax),%edx
 371:	89 55 10             	mov    %edx,0x10(%ebp)
 374:	85 c0                	test   %eax,%eax
 376:	7f dc                	jg     354 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 378:	8b 45 08             	mov    0x8(%ebp),%eax
}
 37b:	c9                   	leave  
 37c:	c3                   	ret    

0000037d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37d:	b8 01 00 00 00       	mov    $0x1,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <exit>:
SYSCALL(exit)
 385:	b8 02 00 00 00       	mov    $0x2,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <wait>:
SYSCALL(wait)
 38d:	b8 03 00 00 00       	mov    $0x3,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <pipe>:
SYSCALL(pipe)
 395:	b8 04 00 00 00       	mov    $0x4,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <read>:
SYSCALL(read)
 39d:	b8 05 00 00 00       	mov    $0x5,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <write>:
SYSCALL(write)
 3a5:	b8 10 00 00 00       	mov    $0x10,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <close>:
SYSCALL(close)
 3ad:	b8 15 00 00 00       	mov    $0x15,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <kill>:
SYSCALL(kill)
 3b5:	b8 06 00 00 00       	mov    $0x6,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <exec>:
SYSCALL(exec)
 3bd:	b8 07 00 00 00       	mov    $0x7,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <open>:
SYSCALL(open)
 3c5:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <mknod>:
SYSCALL(mknod)
 3cd:	b8 11 00 00 00       	mov    $0x11,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <unlink>:
SYSCALL(unlink)
 3d5:	b8 12 00 00 00       	mov    $0x12,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <fstat>:
SYSCALL(fstat)
 3dd:	b8 08 00 00 00       	mov    $0x8,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <link>:
SYSCALL(link)
 3e5:	b8 13 00 00 00       	mov    $0x13,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <mkdir>:
SYSCALL(mkdir)
 3ed:	b8 14 00 00 00       	mov    $0x14,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <chdir>:
SYSCALL(chdir)
 3f5:	b8 09 00 00 00       	mov    $0x9,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <dup>:
SYSCALL(dup)
 3fd:	b8 0a 00 00 00       	mov    $0xa,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <getpid>:
SYSCALL(getpid)
 405:	b8 0b 00 00 00       	mov    $0xb,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <sbrk>:
SYSCALL(sbrk)
 40d:	b8 0c 00 00 00       	mov    $0xc,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <sleep>:
SYSCALL(sleep)
 415:	b8 0d 00 00 00       	mov    $0xd,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <uptime>:
SYSCALL(uptime)
 41d:	b8 0e 00 00 00       	mov    $0xe,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <kthread_create>:
SYSCALL(kthread_create)
 425:	b8 17 00 00 00       	mov    $0x17,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <kthread_join>:
SYSCALL(kthread_join)
 42d:	b8 16 00 00 00       	mov    $0x16,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 435:	b8 18 00 00 00       	mov    $0x18,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 43d:	b8 19 00 00 00       	mov    $0x19,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 445:	b8 1a 00 00 00       	mov    $0x1a,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 44d:	b8 1b 00 00 00       	mov    $0x1b,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 455:	b8 1c 00 00 00       	mov    $0x1c,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 45d:	b8 1d 00 00 00       	mov    $0x1d,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 465:	b8 1e 00 00 00       	mov    $0x1e,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 46d:	b8 1f 00 00 00       	mov    $0x1f,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 475:	b8 20 00 00 00       	mov    $0x20,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <kthread_exit>:
 47d:	b8 21 00 00 00       	mov    $0x21,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 485:	55                   	push   %ebp
 486:	89 e5                	mov    %esp,%ebp
 488:	83 ec 18             	sub    $0x18,%esp
 48b:	8b 45 0c             	mov    0xc(%ebp),%eax
 48e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 491:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 498:	00 
 499:	8d 45 f4             	lea    -0xc(%ebp),%eax
 49c:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
 4a3:	89 04 24             	mov    %eax,(%esp)
 4a6:	e8 fa fe ff ff       	call   3a5 <write>
}
 4ab:	c9                   	leave  
 4ac:	c3                   	ret    

000004ad <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ad:	55                   	push   %ebp
 4ae:	89 e5                	mov    %esp,%ebp
 4b0:	56                   	push   %esi
 4b1:	53                   	push   %ebx
 4b2:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4bc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4c0:	74 17                	je     4d9 <printint+0x2c>
 4c2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4c6:	79 11                	jns    4d9 <printint+0x2c>
    neg = 1;
 4c8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d2:	f7 d8                	neg    %eax
 4d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4d7:	eb 06                	jmp    4df <printint+0x32>
  } else {
    x = xx;
 4d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4e6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4e9:	8d 41 01             	lea    0x1(%ecx),%eax
 4ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4ef:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4f5:	ba 00 00 00 00       	mov    $0x0,%edx
 4fa:	f7 f3                	div    %ebx
 4fc:	89 d0                	mov    %edx,%eax
 4fe:	0f b6 80 e4 0e 00 00 	movzbl 0xee4(%eax),%eax
 505:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 509:	8b 75 10             	mov    0x10(%ebp),%esi
 50c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 50f:	ba 00 00 00 00       	mov    $0x0,%edx
 514:	f7 f6                	div    %esi
 516:	89 45 ec             	mov    %eax,-0x14(%ebp)
 519:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 51d:	75 c7                	jne    4e6 <printint+0x39>
  if(neg)
 51f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 523:	74 10                	je     535 <printint+0x88>
    buf[i++] = '-';
 525:	8b 45 f4             	mov    -0xc(%ebp),%eax
 528:	8d 50 01             	lea    0x1(%eax),%edx
 52b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 52e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 533:	eb 1f                	jmp    554 <printint+0xa7>
 535:	eb 1d                	jmp    554 <printint+0xa7>
    putc(fd, buf[i]);
 537:	8d 55 dc             	lea    -0x24(%ebp),%edx
 53a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53d:	01 d0                	add    %edx,%eax
 53f:	0f b6 00             	movzbl (%eax),%eax
 542:	0f be c0             	movsbl %al,%eax
 545:	89 44 24 04          	mov    %eax,0x4(%esp)
 549:	8b 45 08             	mov    0x8(%ebp),%eax
 54c:	89 04 24             	mov    %eax,(%esp)
 54f:	e8 31 ff ff ff       	call   485 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 554:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 558:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 55c:	79 d9                	jns    537 <printint+0x8a>
    putc(fd, buf[i]);
}
 55e:	83 c4 30             	add    $0x30,%esp
 561:	5b                   	pop    %ebx
 562:	5e                   	pop    %esi
 563:	5d                   	pop    %ebp
 564:	c3                   	ret    

00000565 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 565:	55                   	push   %ebp
 566:	89 e5                	mov    %esp,%ebp
 568:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 56b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 572:	8d 45 0c             	lea    0xc(%ebp),%eax
 575:	83 c0 04             	add    $0x4,%eax
 578:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 57b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 582:	e9 7c 01 00 00       	jmp    703 <printf+0x19e>
    c = fmt[i] & 0xff;
 587:	8b 55 0c             	mov    0xc(%ebp),%edx
 58a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58d:	01 d0                	add    %edx,%eax
 58f:	0f b6 00             	movzbl (%eax),%eax
 592:	0f be c0             	movsbl %al,%eax
 595:	25 ff 00 00 00       	and    $0xff,%eax
 59a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 59d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a1:	75 2c                	jne    5cf <printf+0x6a>
      if(c == '%'){
 5a3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a7:	75 0c                	jne    5b5 <printf+0x50>
        state = '%';
 5a9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5b0:	e9 4a 01 00 00       	jmp    6ff <printf+0x19a>
      } else {
        putc(fd, c);
 5b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b8:	0f be c0             	movsbl %al,%eax
 5bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bf:	8b 45 08             	mov    0x8(%ebp),%eax
 5c2:	89 04 24             	mov    %eax,(%esp)
 5c5:	e8 bb fe ff ff       	call   485 <putc>
 5ca:	e9 30 01 00 00       	jmp    6ff <printf+0x19a>
      }
    } else if(state == '%'){
 5cf:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5d3:	0f 85 26 01 00 00    	jne    6ff <printf+0x19a>
      if(c == 'd'){
 5d9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5dd:	75 2d                	jne    60c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5df:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e2:	8b 00                	mov    (%eax),%eax
 5e4:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5eb:	00 
 5ec:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5f3:	00 
 5f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f8:	8b 45 08             	mov    0x8(%ebp),%eax
 5fb:	89 04 24             	mov    %eax,(%esp)
 5fe:	e8 aa fe ff ff       	call   4ad <printint>
        ap++;
 603:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 607:	e9 ec 00 00 00       	jmp    6f8 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 60c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 610:	74 06                	je     618 <printf+0xb3>
 612:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 616:	75 2d                	jne    645 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 618:	8b 45 e8             	mov    -0x18(%ebp),%eax
 61b:	8b 00                	mov    (%eax),%eax
 61d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 624:	00 
 625:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 62c:	00 
 62d:	89 44 24 04          	mov    %eax,0x4(%esp)
 631:	8b 45 08             	mov    0x8(%ebp),%eax
 634:	89 04 24             	mov    %eax,(%esp)
 637:	e8 71 fe ff ff       	call   4ad <printint>
        ap++;
 63c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 640:	e9 b3 00 00 00       	jmp    6f8 <printf+0x193>
      } else if(c == 's'){
 645:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 649:	75 45                	jne    690 <printf+0x12b>
        s = (char*)*ap;
 64b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64e:	8b 00                	mov    (%eax),%eax
 650:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 653:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 657:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 65b:	75 09                	jne    666 <printf+0x101>
          s = "(null)";
 65d:	c7 45 f4 ce 0a 00 00 	movl   $0xace,-0xc(%ebp)
        while(*s != 0){
 664:	eb 1e                	jmp    684 <printf+0x11f>
 666:	eb 1c                	jmp    684 <printf+0x11f>
          putc(fd, *s);
 668:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66b:	0f b6 00             	movzbl (%eax),%eax
 66e:	0f be c0             	movsbl %al,%eax
 671:	89 44 24 04          	mov    %eax,0x4(%esp)
 675:	8b 45 08             	mov    0x8(%ebp),%eax
 678:	89 04 24             	mov    %eax,(%esp)
 67b:	e8 05 fe ff ff       	call   485 <putc>
          s++;
 680:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 684:	8b 45 f4             	mov    -0xc(%ebp),%eax
 687:	0f b6 00             	movzbl (%eax),%eax
 68a:	84 c0                	test   %al,%al
 68c:	75 da                	jne    668 <printf+0x103>
 68e:	eb 68                	jmp    6f8 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 690:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 694:	75 1d                	jne    6b3 <printf+0x14e>
        putc(fd, *ap);
 696:	8b 45 e8             	mov    -0x18(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	0f be c0             	movsbl %al,%eax
 69e:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a2:	8b 45 08             	mov    0x8(%ebp),%eax
 6a5:	89 04 24             	mov    %eax,(%esp)
 6a8:	e8 d8 fd ff ff       	call   485 <putc>
        ap++;
 6ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b1:	eb 45                	jmp    6f8 <printf+0x193>
      } else if(c == '%'){
 6b3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6b7:	75 17                	jne    6d0 <printf+0x16b>
        putc(fd, c);
 6b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6bc:	0f be c0             	movsbl %al,%eax
 6bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c3:	8b 45 08             	mov    0x8(%ebp),%eax
 6c6:	89 04 24             	mov    %eax,(%esp)
 6c9:	e8 b7 fd ff ff       	call   485 <putc>
 6ce:	eb 28                	jmp    6f8 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6d0:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6d7:	00 
 6d8:	8b 45 08             	mov    0x8(%ebp),%eax
 6db:	89 04 24             	mov    %eax,(%esp)
 6de:	e8 a2 fd ff ff       	call   485 <putc>
        putc(fd, c);
 6e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e6:	0f be c0             	movsbl %al,%eax
 6e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ed:	8b 45 08             	mov    0x8(%ebp),%eax
 6f0:	89 04 24             	mov    %eax,(%esp)
 6f3:	e8 8d fd ff ff       	call   485 <putc>
      }
      state = 0;
 6f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 703:	8b 55 0c             	mov    0xc(%ebp),%edx
 706:	8b 45 f0             	mov    -0x10(%ebp),%eax
 709:	01 d0                	add    %edx,%eax
 70b:	0f b6 00             	movzbl (%eax),%eax
 70e:	84 c0                	test   %al,%al
 710:	0f 85 71 fe ff ff    	jne    587 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 716:	c9                   	leave  
 717:	c3                   	ret    

00000718 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 718:	55                   	push   %ebp
 719:	89 e5                	mov    %esp,%ebp
 71b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 71e:	8b 45 08             	mov    0x8(%ebp),%eax
 721:	83 e8 08             	sub    $0x8,%eax
 724:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 727:	a1 08 0f 00 00       	mov    0xf08,%eax
 72c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 72f:	eb 24                	jmp    755 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 00                	mov    (%eax),%eax
 736:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 739:	77 12                	ja     74d <free+0x35>
 73b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 741:	77 24                	ja     767 <free+0x4f>
 743:	8b 45 fc             	mov    -0x4(%ebp),%eax
 746:	8b 00                	mov    (%eax),%eax
 748:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 74b:	77 1a                	ja     767 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	8b 00                	mov    (%eax),%eax
 752:	89 45 fc             	mov    %eax,-0x4(%ebp)
 755:	8b 45 f8             	mov    -0x8(%ebp),%eax
 758:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 75b:	76 d4                	jbe    731 <free+0x19>
 75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 760:	8b 00                	mov    (%eax),%eax
 762:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 765:	76 ca                	jbe    731 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 767:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76a:	8b 40 04             	mov    0x4(%eax),%eax
 76d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 774:	8b 45 f8             	mov    -0x8(%ebp),%eax
 777:	01 c2                	add    %eax,%edx
 779:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77c:	8b 00                	mov    (%eax),%eax
 77e:	39 c2                	cmp    %eax,%edx
 780:	75 24                	jne    7a6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 782:	8b 45 f8             	mov    -0x8(%ebp),%eax
 785:	8b 50 04             	mov    0x4(%eax),%edx
 788:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78b:	8b 00                	mov    (%eax),%eax
 78d:	8b 40 04             	mov    0x4(%eax),%eax
 790:	01 c2                	add    %eax,%edx
 792:	8b 45 f8             	mov    -0x8(%ebp),%eax
 795:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 00                	mov    (%eax),%eax
 79d:	8b 10                	mov    (%eax),%edx
 79f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a2:	89 10                	mov    %edx,(%eax)
 7a4:	eb 0a                	jmp    7b0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	8b 10                	mov    (%eax),%edx
 7ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ae:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	01 d0                	add    %edx,%eax
 7c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7c5:	75 20                	jne    7e7 <free+0xcf>
    p->s.size += bp->s.size;
 7c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ca:	8b 50 04             	mov    0x4(%eax),%edx
 7cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d0:	8b 40 04             	mov    0x4(%eax),%eax
 7d3:	01 c2                	add    %eax,%edx
 7d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7de:	8b 10                	mov    (%eax),%edx
 7e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e3:	89 10                	mov    %edx,(%eax)
 7e5:	eb 08                	jmp    7ef <free+0xd7>
  } else
    p->s.ptr = bp;
 7e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ea:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ed:	89 10                	mov    %edx,(%eax)
  freep = p;
 7ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f2:	a3 08 0f 00 00       	mov    %eax,0xf08
}
 7f7:	c9                   	leave  
 7f8:	c3                   	ret    

000007f9 <morecore>:

static Header*
morecore(uint nu)
{
 7f9:	55                   	push   %ebp
 7fa:	89 e5                	mov    %esp,%ebp
 7fc:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7ff:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 806:	77 07                	ja     80f <morecore+0x16>
    nu = 4096;
 808:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 80f:	8b 45 08             	mov    0x8(%ebp),%eax
 812:	c1 e0 03             	shl    $0x3,%eax
 815:	89 04 24             	mov    %eax,(%esp)
 818:	e8 f0 fb ff ff       	call   40d <sbrk>
 81d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 820:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 824:	75 07                	jne    82d <morecore+0x34>
    return 0;
 826:	b8 00 00 00 00       	mov    $0x0,%eax
 82b:	eb 22                	jmp    84f <morecore+0x56>
  hp = (Header*)p;
 82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 830:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 833:	8b 45 f0             	mov    -0x10(%ebp),%eax
 836:	8b 55 08             	mov    0x8(%ebp),%edx
 839:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 83c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83f:	83 c0 08             	add    $0x8,%eax
 842:	89 04 24             	mov    %eax,(%esp)
 845:	e8 ce fe ff ff       	call   718 <free>
  return freep;
 84a:	a1 08 0f 00 00       	mov    0xf08,%eax
}
 84f:	c9                   	leave  
 850:	c3                   	ret    

00000851 <malloc>:

void*
malloc(uint nbytes)
{
 851:	55                   	push   %ebp
 852:	89 e5                	mov    %esp,%ebp
 854:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 857:	8b 45 08             	mov    0x8(%ebp),%eax
 85a:	83 c0 07             	add    $0x7,%eax
 85d:	c1 e8 03             	shr    $0x3,%eax
 860:	83 c0 01             	add    $0x1,%eax
 863:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 866:	a1 08 0f 00 00       	mov    0xf08,%eax
 86b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 872:	75 23                	jne    897 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 874:	c7 45 f0 00 0f 00 00 	movl   $0xf00,-0x10(%ebp)
 87b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87e:	a3 08 0f 00 00       	mov    %eax,0xf08
 883:	a1 08 0f 00 00       	mov    0xf08,%eax
 888:	a3 00 0f 00 00       	mov    %eax,0xf00
    base.s.size = 0;
 88d:	c7 05 04 0f 00 00 00 	movl   $0x0,0xf04
 894:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 897:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89a:	8b 00                	mov    (%eax),%eax
 89c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	8b 40 04             	mov    0x4(%eax),%eax
 8a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8a8:	72 4d                	jb     8f7 <malloc+0xa6>
      if(p->s.size == nunits)
 8aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ad:	8b 40 04             	mov    0x4(%eax),%eax
 8b0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8b3:	75 0c                	jne    8c1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b8:	8b 10                	mov    (%eax),%edx
 8ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bd:	89 10                	mov    %edx,(%eax)
 8bf:	eb 26                	jmp    8e7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c4:	8b 40 04             	mov    0x4(%eax),%eax
 8c7:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8ca:	89 c2                	mov    %eax,%edx
 8cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d5:	8b 40 04             	mov    0x4(%eax),%eax
 8d8:	c1 e0 03             	shl    $0x3,%eax
 8db:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8e4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ea:	a3 08 0f 00 00       	mov    %eax,0xf08
      return (void*)(p + 1);
 8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f2:	83 c0 08             	add    $0x8,%eax
 8f5:	eb 38                	jmp    92f <malloc+0xde>
    }
    if(p == freep)
 8f7:	a1 08 0f 00 00       	mov    0xf08,%eax
 8fc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8ff:	75 1b                	jne    91c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 901:	8b 45 ec             	mov    -0x14(%ebp),%eax
 904:	89 04 24             	mov    %eax,(%esp)
 907:	e8 ed fe ff ff       	call   7f9 <morecore>
 90c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 90f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 913:	75 07                	jne    91c <malloc+0xcb>
        return 0;
 915:	b8 00 00 00 00       	mov    $0x0,%eax
 91a:	eb 13                	jmp    92f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 922:	8b 45 f4             	mov    -0xc(%ebp),%eax
 925:	8b 00                	mov    (%eax),%eax
 927:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 92a:	e9 70 ff ff ff       	jmp    89f <malloc+0x4e>
}
 92f:	c9                   	leave  
 930:	c3                   	ret    

00000931 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 931:	55                   	push   %ebp
 932:	89 e5                	mov    %esp,%ebp
 934:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 937:	8b 45 0c             	mov    0xc(%ebp),%eax
 93a:	89 04 24             	mov    %eax,(%esp)
 93d:	8b 45 08             	mov    0x8(%ebp),%eax
 940:	ff d0                	call   *%eax
    exit();
 942:	e8 3e fa ff ff       	call   385 <exit>

00000947 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 947:	55                   	push   %ebp
 948:	89 e5                	mov    %esp,%ebp
 94a:	57                   	push   %edi
 94b:	56                   	push   %esi
 94c:	53                   	push   %ebx
 94d:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 950:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 957:	e8 f5 fe ff ff       	call   851 <malloc>
 95c:	8b 55 08             	mov    0x8(%ebp),%edx
 95f:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 961:	8b 45 10             	mov    0x10(%ebp),%eax
 964:	8b 38                	mov    (%eax),%edi
 966:	8b 75 0c             	mov    0xc(%ebp),%esi
 969:	bb 31 09 00 00       	mov    $0x931,%ebx
 96e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 975:	e8 d7 fe ff ff       	call   851 <malloc>
 97a:	05 00 10 00 00       	add    $0x1000,%eax
 97f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 983:	89 74 24 08          	mov    %esi,0x8(%esp)
 987:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 98b:	89 04 24             	mov    %eax,(%esp)
 98e:	e8 92 fa ff ff       	call   425 <kthread_create>
 993:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 996:	8b 45 08             	mov    0x8(%ebp),%eax
 999:	8b 00                	mov    (%eax),%eax
 99b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 99e:	89 10                	mov    %edx,(%eax)
    return t_id;
 9a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 9a3:	83 c4 2c             	add    $0x2c,%esp
 9a6:	5b                   	pop    %ebx
 9a7:	5e                   	pop    %esi
 9a8:	5f                   	pop    %edi
 9a9:	5d                   	pop    %ebp
 9aa:	c3                   	ret    

000009ab <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 9ab:	55                   	push   %ebp
 9ac:	89 e5                	mov    %esp,%ebp
 9ae:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 9b1:	8b 55 0c             	mov    0xc(%ebp),%edx
 9b4:	8b 45 08             	mov    0x8(%ebp),%eax
 9b7:	8b 00                	mov    (%eax),%eax
 9b9:	89 54 24 04          	mov    %edx,0x4(%esp)
 9bd:	89 04 24             	mov    %eax,(%esp)
 9c0:	e8 68 fa ff ff       	call   42d <kthread_join>
 9c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9cb:	c9                   	leave  
 9cc:	c3                   	ret    

000009cd <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 9cd:	55                   	push   %ebp
 9ce:	89 e5                	mov    %esp,%ebp
 9d0:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 9d3:	e8 5d fa ff ff       	call   435 <kthread_mutex_init>
 9d8:	8b 55 08             	mov    0x8(%ebp),%edx
 9db:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 9dd:	8b 45 08             	mov    0x8(%ebp),%eax
 9e0:	8b 00                	mov    (%eax),%eax
 9e2:	85 c0                	test   %eax,%eax
 9e4:	7e 07                	jle    9ed <qthread_mutex_init+0x20>
		return 0;
 9e6:	b8 00 00 00 00       	mov    $0x0,%eax
 9eb:	eb 05                	jmp    9f2 <qthread_mutex_init+0x25>
	}
	return *mutex;
 9ed:	8b 45 08             	mov    0x8(%ebp),%eax
 9f0:	8b 00                	mov    (%eax),%eax
}
 9f2:	c9                   	leave  
 9f3:	c3                   	ret    

000009f4 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 9f4:	55                   	push   %ebp
 9f5:	89 e5                	mov    %esp,%ebp
 9f7:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 9fa:	8b 45 08             	mov    0x8(%ebp),%eax
 9fd:	89 04 24             	mov    %eax,(%esp)
 a00:	e8 38 fa ff ff       	call   43d <kthread_mutex_destroy>
 a05:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a08:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a0c:	79 07                	jns    a15 <qthread_mutex_destroy+0x21>
    	return -1;
 a0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a13:	eb 05                	jmp    a1a <qthread_mutex_destroy+0x26>
    }
    return 0;
 a15:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a1a:	c9                   	leave  
 a1b:	c3                   	ret    

00000a1c <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 a1c:	55                   	push   %ebp
 a1d:	89 e5                	mov    %esp,%ebp
 a1f:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 a22:	8b 45 08             	mov    0x8(%ebp),%eax
 a25:	89 04 24             	mov    %eax,(%esp)
 a28:	e8 18 fa ff ff       	call   445 <kthread_mutex_lock>
 a2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a30:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a34:	79 07                	jns    a3d <qthread_mutex_lock+0x21>
    	return -1;
 a36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a3b:	eb 05                	jmp    a42 <qthread_mutex_lock+0x26>
    }
    return 0;
 a3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a42:	c9                   	leave  
 a43:	c3                   	ret    

00000a44 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a44:	55                   	push   %ebp
 a45:	89 e5                	mov    %esp,%ebp
 a47:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a4a:	8b 45 08             	mov    0x8(%ebp),%eax
 a4d:	89 04 24             	mov    %eax,(%esp)
 a50:	e8 f8 f9 ff ff       	call   44d <kthread_mutex_unlock>
 a55:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a58:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a5c:	79 07                	jns    a65 <qthread_mutex_unlock+0x21>
    	return -1;
 a5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a63:	eb 05                	jmp    a6a <qthread_mutex_unlock+0x26>
    }
    return 0;
 a65:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a6a:	c9                   	leave  
 a6b:	c3                   	ret    

00000a6c <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 a6c:	55                   	push   %ebp
 a6d:	89 e5                	mov    %esp,%ebp

	return 0;
 a6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a74:	5d                   	pop    %ebp
 a75:	c3                   	ret    

00000a76 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 a76:	55                   	push   %ebp
 a77:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a79:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a7e:	5d                   	pop    %ebp
 a7f:	c3                   	ret    

00000a80 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a83:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a88:	5d                   	pop    %ebp
 a89:	c3                   	ret    

00000a8a <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 a8a:	55                   	push   %ebp
 a8b:	89 e5                	mov    %esp,%ebp
	return 0;
 a8d:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a92:	5d                   	pop    %ebp
 a93:	c3                   	ret    

00000a94 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 a94:	55                   	push   %ebp
 a95:	89 e5                	mov    %esp,%ebp
	return 0;
 a97:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 a9c:	5d                   	pop    %ebp
 a9d:	c3                   	ret    

00000a9e <qthread_exit>:

int qthread_exit(){
 a9e:	55                   	push   %ebp
 a9f:	89 e5                	mov    %esp,%ebp
	return 0;
 aa1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aa6:	5d                   	pop    %ebp
 aa7:	c3                   	ret    
