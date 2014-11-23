
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
   f:	c7 44 24 04 f5 09 00 	movl   $0x9f5,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 9c 04 00 00       	call   4bf <printf>
    exit();
  23:	e8 c0 02 00 00       	call   2e8 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 43                	jmp    75 <main+0x75>
    if(mkdir(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	c1 e0 02             	shl    $0x2,%eax
  39:	03 45 0c             	add    0xc(%ebp),%eax
  3c:	8b 00                	mov    (%eax),%eax
  3e:	89 04 24             	mov    %eax,(%esp)
  41:	e8 0a 03 00 00       	call   350 <mkdir>
  46:	85 c0                	test   %eax,%eax
  48:	79 26                	jns    70 <main+0x70>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  4a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4e:	c1 e0 02             	shl    $0x2,%eax
  51:	03 45 0c             	add    0xc(%ebp),%eax
  54:	8b 00                	mov    (%eax),%eax
  56:	89 44 24 08          	mov    %eax,0x8(%esp)
  5a:	c7 44 24 04 0c 0a 00 	movl   $0xa0c,0x4(%esp)
  61:	00 
  62:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  69:	e8 51 04 00 00       	call   4bf <printf>
      break;
  6e:	eb 0e                	jmp    7e <main+0x7e>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  70:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  75:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  79:	3b 45 08             	cmp    0x8(%ebp),%eax
  7c:	7c b4                	jl     32 <main+0x32>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  7e:	e8 65 02 00 00       	call   2e8 <exit>
  83:	90                   	nop

00000084 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	57                   	push   %edi
  88:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  89:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8c:	8b 55 10             	mov    0x10(%ebp),%edx
  8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  92:	89 cb                	mov    %ecx,%ebx
  94:	89 df                	mov    %ebx,%edi
  96:	89 d1                	mov    %edx,%ecx
  98:	fc                   	cld    
  99:	f3 aa                	rep stos %al,%es:(%edi)
  9b:	89 ca                	mov    %ecx,%edx
  9d:	89 fb                	mov    %edi,%ebx
  9f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  a2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a5:	5b                   	pop    %ebx
  a6:	5f                   	pop    %edi
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    

000000a9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a9:	55                   	push   %ebp
  aa:	89 e5                	mov    %esp,%ebp
  ac:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  af:	8b 45 08             	mov    0x8(%ebp),%eax
  b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  b5:	90                   	nop
  b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  b9:	0f b6 10             	movzbl (%eax),%edx
  bc:	8b 45 08             	mov    0x8(%ebp),%eax
  bf:	88 10                	mov    %dl,(%eax)
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	84 c0                	test   %al,%al
  c9:	0f 95 c0             	setne  %al
  cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  d4:	84 c0                	test   %al,%al
  d6:	75 de                	jne    b6 <strcpy+0xd>
    ;
  return os;
  d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  db:	c9                   	leave  
  dc:	c3                   	ret    

000000dd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e0:	eb 08                	jmp    ea <strcmp+0xd>
    p++, q++;
  e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ea:	8b 45 08             	mov    0x8(%ebp),%eax
  ed:	0f b6 00             	movzbl (%eax),%eax
  f0:	84 c0                	test   %al,%al
  f2:	74 10                	je     104 <strcmp+0x27>
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	0f b6 10             	movzbl (%eax),%edx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	38 c2                	cmp    %al,%dl
 102:	74 de                	je     e2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	0f b6 00             	movzbl (%eax),%eax
 10a:	0f b6 d0             	movzbl %al,%edx
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	0f b6 00             	movzbl (%eax),%eax
 113:	0f b6 c0             	movzbl %al,%eax
 116:	89 d1                	mov    %edx,%ecx
 118:	29 c1                	sub    %eax,%ecx
 11a:	89 c8                	mov    %ecx,%eax
}
 11c:	5d                   	pop    %ebp
 11d:	c3                   	ret    

0000011e <strlen>:

uint
strlen(char *s)
{
 11e:	55                   	push   %ebp
 11f:	89 e5                	mov    %esp,%ebp
 121:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 124:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 12b:	eb 04                	jmp    131 <strlen+0x13>
 12d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 131:	8b 45 fc             	mov    -0x4(%ebp),%eax
 134:	03 45 08             	add    0x8(%ebp),%eax
 137:	0f b6 00             	movzbl (%eax),%eax
 13a:	84 c0                	test   %al,%al
 13c:	75 ef                	jne    12d <strlen+0xf>
    ;
  return n;
 13e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 141:	c9                   	leave  
 142:	c3                   	ret    

00000143 <memset>:

void*
memset(void *dst, int c, uint n)
{
 143:	55                   	push   %ebp
 144:	89 e5                	mov    %esp,%ebp
 146:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 149:	8b 45 10             	mov    0x10(%ebp),%eax
 14c:	89 44 24 08          	mov    %eax,0x8(%esp)
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	89 44 24 04          	mov    %eax,0x4(%esp)
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	89 04 24             	mov    %eax,(%esp)
 15d:	e8 22 ff ff ff       	call   84 <stosb>
  return dst;
 162:	8b 45 08             	mov    0x8(%ebp),%eax
}
 165:	c9                   	leave  
 166:	c3                   	ret    

00000167 <strchr>:

char*
strchr(const char *s, char c)
{
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	83 ec 04             	sub    $0x4,%esp
 16d:	8b 45 0c             	mov    0xc(%ebp),%eax
 170:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 173:	eb 14                	jmp    189 <strchr+0x22>
    if(*s == c)
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	0f b6 00             	movzbl (%eax),%eax
 17b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 17e:	75 05                	jne    185 <strchr+0x1e>
      return (char*)s;
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	eb 13                	jmp    198 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 185:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	0f b6 00             	movzbl (%eax),%eax
 18f:	84 c0                	test   %al,%al
 191:	75 e2                	jne    175 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 193:	b8 00 00 00 00       	mov    $0x0,%eax
}
 198:	c9                   	leave  
 199:	c3                   	ret    

0000019a <gets>:

char*
gets(char *buf, int max)
{
 19a:	55                   	push   %ebp
 19b:	89 e5                	mov    %esp,%ebp
 19d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a7:	eb 44                	jmp    1ed <gets+0x53>
    cc = read(0, &c, 1);
 1a9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1b0:	00 
 1b1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b4:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1bf:	e8 3c 01 00 00       	call   300 <read>
 1c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1cb:	7e 2d                	jle    1fa <gets+0x60>
      break;
    buf[i++] = c;
 1cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d0:	03 45 08             	add    0x8(%ebp),%eax
 1d3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1d7:	88 10                	mov    %dl,(%eax)
 1d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e1:	3c 0a                	cmp    $0xa,%al
 1e3:	74 16                	je     1fb <gets+0x61>
 1e5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e9:	3c 0d                	cmp    $0xd,%al
 1eb:	74 0e                	je     1fb <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f6:	7c b1                	jl     1a9 <gets+0xf>
 1f8:	eb 01                	jmp    1fb <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1fa:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1fe:	03 45 08             	add    0x8(%ebp),%eax
 201:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 204:	8b 45 08             	mov    0x8(%ebp),%eax
}
 207:	c9                   	leave  
 208:	c3                   	ret    

00000209 <stat>:

int
stat(char *n, struct stat *st)
{
 209:	55                   	push   %ebp
 20a:	89 e5                	mov    %esp,%ebp
 20c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 216:	00 
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	89 04 24             	mov    %eax,(%esp)
 21d:	e8 06 01 00 00       	call   328 <open>
 222:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 225:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 229:	79 07                	jns    232 <stat+0x29>
    return -1;
 22b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 230:	eb 23                	jmp    255 <stat+0x4c>
  r = fstat(fd, st);
 232:	8b 45 0c             	mov    0xc(%ebp),%eax
 235:	89 44 24 04          	mov    %eax,0x4(%esp)
 239:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23c:	89 04 24             	mov    %eax,(%esp)
 23f:	e8 fc 00 00 00       	call   340 <fstat>
 244:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	89 04 24             	mov    %eax,(%esp)
 24d:	e8 be 00 00 00       	call   310 <close>
  return r;
 252:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 255:	c9                   	leave  
 256:	c3                   	ret    

00000257 <atoi>:

int
atoi(const char *s)
{
 257:	55                   	push   %ebp
 258:	89 e5                	mov    %esp,%ebp
 25a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 264:	eb 23                	jmp    289 <atoi+0x32>
    n = n*10 + *s++ - '0';
 266:	8b 55 fc             	mov    -0x4(%ebp),%edx
 269:	89 d0                	mov    %edx,%eax
 26b:	c1 e0 02             	shl    $0x2,%eax
 26e:	01 d0                	add    %edx,%eax
 270:	01 c0                	add    %eax,%eax
 272:	89 c2                	mov    %eax,%edx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	0f be c0             	movsbl %al,%eax
 27d:	01 d0                	add    %edx,%eax
 27f:	83 e8 30             	sub    $0x30,%eax
 282:	89 45 fc             	mov    %eax,-0x4(%ebp)
 285:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3c 2f                	cmp    $0x2f,%al
 291:	7e 0a                	jle    29d <atoi+0x46>
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 00             	movzbl (%eax),%eax
 299:	3c 39                	cmp    $0x39,%al
 29b:	7e c9                	jle    266 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a0:	c9                   	leave  
 2a1:	c3                   	ret    

000002a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a2:	55                   	push   %ebp
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b4:	eb 13                	jmp    2c9 <memmove+0x27>
    *dst++ = *src++;
 2b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2b9:	0f b6 10             	movzbl (%eax),%edx
 2bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2bf:	88 10                	mov    %dl,(%eax)
 2c1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2c5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2cd:	0f 9f c0             	setg   %al
 2d0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2d4:	84 c0                	test   %al,%al
 2d6:	75 de                	jne    2b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2db:	c9                   	leave  
 2dc:	c3                   	ret    
 2dd:	90                   	nop
 2de:	90                   	nop
 2df:	90                   	nop

000002e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2e0:	b8 01 00 00 00       	mov    $0x1,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <exit>:
SYSCALL(exit)
 2e8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <wait>:
SYSCALL(wait)
 2f0:	b8 03 00 00 00       	mov    $0x3,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <pipe>:
SYSCALL(pipe)
 2f8:	b8 04 00 00 00       	mov    $0x4,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <read>:
SYSCALL(read)
 300:	b8 05 00 00 00       	mov    $0x5,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <write>:
SYSCALL(write)
 308:	b8 10 00 00 00       	mov    $0x10,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <close>:
SYSCALL(close)
 310:	b8 15 00 00 00       	mov    $0x15,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <kill>:
SYSCALL(kill)
 318:	b8 06 00 00 00       	mov    $0x6,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <exec>:
SYSCALL(exec)
 320:	b8 07 00 00 00       	mov    $0x7,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <open>:
SYSCALL(open)
 328:	b8 0f 00 00 00       	mov    $0xf,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mknod>:
SYSCALL(mknod)
 330:	b8 11 00 00 00       	mov    $0x11,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <unlink>:
SYSCALL(unlink)
 338:	b8 12 00 00 00       	mov    $0x12,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <fstat>:
SYSCALL(fstat)
 340:	b8 08 00 00 00       	mov    $0x8,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <link>:
SYSCALL(link)
 348:	b8 13 00 00 00       	mov    $0x13,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <mkdir>:
SYSCALL(mkdir)
 350:	b8 14 00 00 00       	mov    $0x14,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <chdir>:
SYSCALL(chdir)
 358:	b8 09 00 00 00       	mov    $0x9,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <dup>:
SYSCALL(dup)
 360:	b8 0a 00 00 00       	mov    $0xa,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <getpid>:
SYSCALL(getpid)
 368:	b8 0b 00 00 00       	mov    $0xb,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <sbrk>:
SYSCALL(sbrk)
 370:	b8 0c 00 00 00       	mov    $0xc,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <sleep>:
SYSCALL(sleep)
 378:	b8 0d 00 00 00       	mov    $0xd,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <uptime>:
SYSCALL(uptime)
 380:	b8 0e 00 00 00       	mov    $0xe,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <kthread_create>:
SYSCALL(kthread_create)
 388:	b8 17 00 00 00       	mov    $0x17,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <kthread_join>:
SYSCALL(kthread_join)
 390:	b8 16 00 00 00       	mov    $0x16,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 398:	b8 18 00 00 00       	mov    $0x18,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 3a0:	b8 19 00 00 00       	mov    $0x19,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 3a8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 3b0:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 3b8:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 3c0:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 3c8:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 3d0:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 3d8:	b8 20 00 00 00       	mov    $0x20,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <kthread_exit>:
 3e0:	b8 21 00 00 00       	mov    $0x21,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	83 ec 28             	sub    $0x28,%esp
 3ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3fb:	00 
 3fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 403:	8b 45 08             	mov    0x8(%ebp),%eax
 406:	89 04 24             	mov    %eax,(%esp)
 409:	e8 fa fe ff ff       	call   308 <write>
}
 40e:	c9                   	leave  
 40f:	c3                   	ret    

00000410 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 416:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 41d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 421:	74 17                	je     43a <printint+0x2a>
 423:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 427:	79 11                	jns    43a <printint+0x2a>
    neg = 1;
 429:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 430:	8b 45 0c             	mov    0xc(%ebp),%eax
 433:	f7 d8                	neg    %eax
 435:	89 45 ec             	mov    %eax,-0x14(%ebp)
 438:	eb 06                	jmp    440 <printint+0x30>
  } else {
    x = xx;
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 440:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 447:	8b 4d 10             	mov    0x10(%ebp),%ecx
 44a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44d:	ba 00 00 00 00       	mov    $0x0,%edx
 452:	f7 f1                	div    %ecx
 454:	89 d0                	mov    %edx,%eax
 456:	0f b6 90 14 0e 00 00 	movzbl 0xe14(%eax),%edx
 45d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 460:	03 45 f4             	add    -0xc(%ebp),%eax
 463:	88 10                	mov    %dl,(%eax)
 465:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 469:	8b 55 10             	mov    0x10(%ebp),%edx
 46c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 46f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 472:	ba 00 00 00 00       	mov    $0x0,%edx
 477:	f7 75 d4             	divl   -0x2c(%ebp)
 47a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 481:	75 c4                	jne    447 <printint+0x37>
  if(neg)
 483:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 487:	74 2a                	je     4b3 <printint+0xa3>
    buf[i++] = '-';
 489:	8d 45 dc             	lea    -0x24(%ebp),%eax
 48c:	03 45 f4             	add    -0xc(%ebp),%eax
 48f:	c6 00 2d             	movb   $0x2d,(%eax)
 492:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 496:	eb 1b                	jmp    4b3 <printint+0xa3>
    putc(fd, buf[i]);
 498:	8d 45 dc             	lea    -0x24(%ebp),%eax
 49b:	03 45 f4             	add    -0xc(%ebp),%eax
 49e:	0f b6 00             	movzbl (%eax),%eax
 4a1:	0f be c0             	movsbl %al,%eax
 4a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a8:	8b 45 08             	mov    0x8(%ebp),%eax
 4ab:	89 04 24             	mov    %eax,(%esp)
 4ae:	e8 35 ff ff ff       	call   3e8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bb:	79 db                	jns    498 <printint+0x88>
    putc(fd, buf[i]);
}
 4bd:	c9                   	leave  
 4be:	c3                   	ret    

000004bf <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4bf:	55                   	push   %ebp
 4c0:	89 e5                	mov    %esp,%ebp
 4c2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4cc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4cf:	83 c0 04             	add    $0x4,%eax
 4d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4dc:	e9 7d 01 00 00       	jmp    65e <printf+0x19f>
    c = fmt[i] & 0xff;
 4e1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e7:	01 d0                	add    %edx,%eax
 4e9:	0f b6 00             	movzbl (%eax),%eax
 4ec:	0f be c0             	movsbl %al,%eax
 4ef:	25 ff 00 00 00       	and    $0xff,%eax
 4f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4fb:	75 2c                	jne    529 <printf+0x6a>
      if(c == '%'){
 4fd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 501:	75 0c                	jne    50f <printf+0x50>
        state = '%';
 503:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 50a:	e9 4b 01 00 00       	jmp    65a <printf+0x19b>
      } else {
        putc(fd, c);
 50f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 512:	0f be c0             	movsbl %al,%eax
 515:	89 44 24 04          	mov    %eax,0x4(%esp)
 519:	8b 45 08             	mov    0x8(%ebp),%eax
 51c:	89 04 24             	mov    %eax,(%esp)
 51f:	e8 c4 fe ff ff       	call   3e8 <putc>
 524:	e9 31 01 00 00       	jmp    65a <printf+0x19b>
      }
    } else if(state == '%'){
 529:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 52d:	0f 85 27 01 00 00    	jne    65a <printf+0x19b>
      if(c == 'd'){
 533:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 537:	75 2d                	jne    566 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 539:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53c:	8b 00                	mov    (%eax),%eax
 53e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 545:	00 
 546:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 54d:	00 
 54e:	89 44 24 04          	mov    %eax,0x4(%esp)
 552:	8b 45 08             	mov    0x8(%ebp),%eax
 555:	89 04 24             	mov    %eax,(%esp)
 558:	e8 b3 fe ff ff       	call   410 <printint>
        ap++;
 55d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 561:	e9 ed 00 00 00       	jmp    653 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 566:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56a:	74 06                	je     572 <printf+0xb3>
 56c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 570:	75 2d                	jne    59f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 572:	8b 45 e8             	mov    -0x18(%ebp),%eax
 575:	8b 00                	mov    (%eax),%eax
 577:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 57e:	00 
 57f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 586:	00 
 587:	89 44 24 04          	mov    %eax,0x4(%esp)
 58b:	8b 45 08             	mov    0x8(%ebp),%eax
 58e:	89 04 24             	mov    %eax,(%esp)
 591:	e8 7a fe ff ff       	call   410 <printint>
        ap++;
 596:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59a:	e9 b4 00 00 00       	jmp    653 <printf+0x194>
      } else if(c == 's'){
 59f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5a3:	75 46                	jne    5eb <printf+0x12c>
        s = (char*)*ap;
 5a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a8:	8b 00                	mov    (%eax),%eax
 5aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b5:	75 27                	jne    5de <printf+0x11f>
          s = "(null)";
 5b7:	c7 45 f4 28 0a 00 00 	movl   $0xa28,-0xc(%ebp)
        while(*s != 0){
 5be:	eb 1e                	jmp    5de <printf+0x11f>
          putc(fd, *s);
 5c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c3:	0f b6 00             	movzbl (%eax),%eax
 5c6:	0f be c0             	movsbl %al,%eax
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	8b 45 08             	mov    0x8(%ebp),%eax
 5d0:	89 04 24             	mov    %eax,(%esp)
 5d3:	e8 10 fe ff ff       	call   3e8 <putc>
          s++;
 5d8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5dc:	eb 01                	jmp    5df <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5de:	90                   	nop
 5df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e2:	0f b6 00             	movzbl (%eax),%eax
 5e5:	84 c0                	test   %al,%al
 5e7:	75 d7                	jne    5c0 <printf+0x101>
 5e9:	eb 68                	jmp    653 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5eb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ef:	75 1d                	jne    60e <printf+0x14f>
        putc(fd, *ap);
 5f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f4:	8b 00                	mov    (%eax),%eax
 5f6:	0f be c0             	movsbl %al,%eax
 5f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fd:	8b 45 08             	mov    0x8(%ebp),%eax
 600:	89 04 24             	mov    %eax,(%esp)
 603:	e8 e0 fd ff ff       	call   3e8 <putc>
        ap++;
 608:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60c:	eb 45                	jmp    653 <printf+0x194>
      } else if(c == '%'){
 60e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 612:	75 17                	jne    62b <printf+0x16c>
        putc(fd, c);
 614:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 617:	0f be c0             	movsbl %al,%eax
 61a:	89 44 24 04          	mov    %eax,0x4(%esp)
 61e:	8b 45 08             	mov    0x8(%ebp),%eax
 621:	89 04 24             	mov    %eax,(%esp)
 624:	e8 bf fd ff ff       	call   3e8 <putc>
 629:	eb 28                	jmp    653 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 62b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 632:	00 
 633:	8b 45 08             	mov    0x8(%ebp),%eax
 636:	89 04 24             	mov    %eax,(%esp)
 639:	e8 aa fd ff ff       	call   3e8 <putc>
        putc(fd, c);
 63e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 641:	0f be c0             	movsbl %al,%eax
 644:	89 44 24 04          	mov    %eax,0x4(%esp)
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	89 04 24             	mov    %eax,(%esp)
 64e:	e8 95 fd ff ff       	call   3e8 <putc>
      }
      state = 0;
 653:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 65a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 65e:	8b 55 0c             	mov    0xc(%ebp),%edx
 661:	8b 45 f0             	mov    -0x10(%ebp),%eax
 664:	01 d0                	add    %edx,%eax
 666:	0f b6 00             	movzbl (%eax),%eax
 669:	84 c0                	test   %al,%al
 66b:	0f 85 70 fe ff ff    	jne    4e1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 671:	c9                   	leave  
 672:	c3                   	ret    
 673:	90                   	nop

00000674 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 67a:	8b 45 08             	mov    0x8(%ebp),%eax
 67d:	83 e8 08             	sub    $0x8,%eax
 680:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 683:	a1 30 0e 00 00       	mov    0xe30,%eax
 688:	89 45 fc             	mov    %eax,-0x4(%ebp)
 68b:	eb 24                	jmp    6b1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 695:	77 12                	ja     6a9 <free+0x35>
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69d:	77 24                	ja     6c3 <free+0x4f>
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 00                	mov    (%eax),%eax
 6a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a7:	77 1a                	ja     6c3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b7:	76 d4                	jbe    68d <free+0x19>
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c1:	76 ca                	jbe    68d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	8b 40 04             	mov    0x4(%eax),%eax
 6c9:	c1 e0 03             	shl    $0x3,%eax
 6cc:	89 c2                	mov    %eax,%edx
 6ce:	03 55 f8             	add    -0x8(%ebp),%edx
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	8b 00                	mov    (%eax),%eax
 6d6:	39 c2                	cmp    %eax,%edx
 6d8:	75 24                	jne    6fe <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dd:	8b 50 04             	mov    0x4(%eax),%edx
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	8b 00                	mov    (%eax),%eax
 6e5:	8b 40 04             	mov    0x4(%eax),%eax
 6e8:	01 c2                	add    %eax,%edx
 6ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ed:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 00                	mov    (%eax),%eax
 6f5:	8b 10                	mov    (%eax),%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	89 10                	mov    %edx,(%eax)
 6fc:	eb 0a                	jmp    708 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 701:	8b 10                	mov    (%eax),%edx
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	8b 40 04             	mov    0x4(%eax),%eax
 70e:	c1 e0 03             	shl    $0x3,%eax
 711:	03 45 fc             	add    -0x4(%ebp),%eax
 714:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 717:	75 20                	jne    739 <free+0xc5>
    p->s.size += bp->s.size;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	8b 50 04             	mov    0x4(%eax),%edx
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	8b 40 04             	mov    0x4(%eax),%eax
 725:	01 c2                	add    %eax,%edx
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 72d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 730:	8b 10                	mov    (%eax),%edx
 732:	8b 45 fc             	mov    -0x4(%ebp),%eax
 735:	89 10                	mov    %edx,(%eax)
 737:	eb 08                	jmp    741 <free+0xcd>
  } else
    p->s.ptr = bp;
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 73f:	89 10                	mov    %edx,(%eax)
  freep = p;
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	a3 30 0e 00 00       	mov    %eax,0xe30
}
 749:	c9                   	leave  
 74a:	c3                   	ret    

0000074b <morecore>:

static Header*
morecore(uint nu)
{
 74b:	55                   	push   %ebp
 74c:	89 e5                	mov    %esp,%ebp
 74e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 751:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 758:	77 07                	ja     761 <morecore+0x16>
    nu = 4096;
 75a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 761:	8b 45 08             	mov    0x8(%ebp),%eax
 764:	c1 e0 03             	shl    $0x3,%eax
 767:	89 04 24             	mov    %eax,(%esp)
 76a:	e8 01 fc ff ff       	call   370 <sbrk>
 76f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 772:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 776:	75 07                	jne    77f <morecore+0x34>
    return 0;
 778:	b8 00 00 00 00       	mov    $0x0,%eax
 77d:	eb 22                	jmp    7a1 <morecore+0x56>
  hp = (Header*)p;
 77f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 782:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 785:	8b 45 f0             	mov    -0x10(%ebp),%eax
 788:	8b 55 08             	mov    0x8(%ebp),%edx
 78b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 78e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 791:	83 c0 08             	add    $0x8,%eax
 794:	89 04 24             	mov    %eax,(%esp)
 797:	e8 d8 fe ff ff       	call   674 <free>
  return freep;
 79c:	a1 30 0e 00 00       	mov    0xe30,%eax
}
 7a1:	c9                   	leave  
 7a2:	c3                   	ret    

000007a3 <malloc>:

void*
malloc(uint nbytes)
{
 7a3:	55                   	push   %ebp
 7a4:	89 e5                	mov    %esp,%ebp
 7a6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ac:	83 c0 07             	add    $0x7,%eax
 7af:	c1 e8 03             	shr    $0x3,%eax
 7b2:	83 c0 01             	add    $0x1,%eax
 7b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b8:	a1 30 0e 00 00       	mov    0xe30,%eax
 7bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c4:	75 23                	jne    7e9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c6:	c7 45 f0 28 0e 00 00 	movl   $0xe28,-0x10(%ebp)
 7cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d0:	a3 30 0e 00 00       	mov    %eax,0xe30
 7d5:	a1 30 0e 00 00       	mov    0xe30,%eax
 7da:	a3 28 0e 00 00       	mov    %eax,0xe28
    base.s.size = 0;
 7df:	c7 05 2c 0e 00 00 00 	movl   $0x0,0xe2c
 7e6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ec:	8b 00                	mov    (%eax),%eax
 7ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	8b 40 04             	mov    0x4(%eax),%eax
 7f7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fa:	72 4d                	jb     849 <malloc+0xa6>
      if(p->s.size == nunits)
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 40 04             	mov    0x4(%eax),%eax
 802:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 805:	75 0c                	jne    813 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 807:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80a:	8b 10                	mov    (%eax),%edx
 80c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80f:	89 10                	mov    %edx,(%eax)
 811:	eb 26                	jmp    839 <malloc+0x96>
      else {
        p->s.size -= nunits;
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	8b 40 04             	mov    0x4(%eax),%eax
 819:	89 c2                	mov    %eax,%edx
 81b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 821:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	8b 40 04             	mov    0x4(%eax),%eax
 82a:	c1 e0 03             	shl    $0x3,%eax
 82d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	8b 55 ec             	mov    -0x14(%ebp),%edx
 836:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 839:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83c:	a3 30 0e 00 00       	mov    %eax,0xe30
      return (void*)(p + 1);
 841:	8b 45 f4             	mov    -0xc(%ebp),%eax
 844:	83 c0 08             	add    $0x8,%eax
 847:	eb 38                	jmp    881 <malloc+0xde>
    }
    if(p == freep)
 849:	a1 30 0e 00 00       	mov    0xe30,%eax
 84e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 851:	75 1b                	jne    86e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 853:	8b 45 ec             	mov    -0x14(%ebp),%eax
 856:	89 04 24             	mov    %eax,(%esp)
 859:	e8 ed fe ff ff       	call   74b <morecore>
 85e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 861:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 865:	75 07                	jne    86e <malloc+0xcb>
        return 0;
 867:	b8 00 00 00 00       	mov    $0x0,%eax
 86c:	eb 13                	jmp    881 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 871:	89 45 f0             	mov    %eax,-0x10(%ebp)
 874:	8b 45 f4             	mov    -0xc(%ebp),%eax
 877:	8b 00                	mov    (%eax),%eax
 879:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 87c:	e9 70 ff ff ff       	jmp    7f1 <malloc+0x4e>
}
 881:	c9                   	leave  
 882:	c3                   	ret    
 883:	90                   	nop

00000884 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 884:	55                   	push   %ebp
 885:	89 e5                	mov    %esp,%ebp
 887:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 88a:	8b 45 0c             	mov    0xc(%ebp),%eax
 88d:	89 04 24             	mov    %eax,(%esp)
 890:	8b 45 08             	mov    0x8(%ebp),%eax
 893:	ff d0                	call   *%eax
    exit();
 895:	e8 4e fa ff ff       	call   2e8 <exit>

0000089a <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 89a:	55                   	push   %ebp
 89b:	89 e5                	mov    %esp,%ebp
 89d:	57                   	push   %edi
 89e:	56                   	push   %esi
 89f:	53                   	push   %ebx
 8a0:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 8a3:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 8aa:	e8 f4 fe ff ff       	call   7a3 <malloc>
 8af:	89 c2                	mov    %eax,%edx
 8b1:	8b 45 08             	mov    0x8(%ebp),%eax
 8b4:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 8b6:	8b 45 10             	mov    0x10(%ebp),%eax
 8b9:	8b 38                	mov    (%eax),%edi
 8bb:	8b 75 0c             	mov    0xc(%ebp),%esi
 8be:	bb 84 08 00 00       	mov    $0x884,%ebx
 8c3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8ca:	e8 d4 fe ff ff       	call   7a3 <malloc>
 8cf:	05 00 10 00 00       	add    $0x1000,%eax
 8d4:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 8d8:	89 74 24 08          	mov    %esi,0x8(%esp)
 8dc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8e0:	89 04 24             	mov    %eax,(%esp)
 8e3:	e8 a0 fa ff ff       	call   388 <kthread_create>
 8e8:	8b 55 08             	mov    0x8(%ebp),%edx
 8eb:	89 02                	mov    %eax,(%edx)
    return *thread;
 8ed:	8b 45 08             	mov    0x8(%ebp),%eax
 8f0:	8b 00                	mov    (%eax),%eax
}
 8f2:	83 c4 1c             	add    $0x1c,%esp
 8f5:	5b                   	pop    %ebx
 8f6:	5e                   	pop    %esi
 8f7:	5f                   	pop    %edi
 8f8:	5d                   	pop    %ebp
 8f9:	c3                   	ret    

000008fa <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8fa:	55                   	push   %ebp
 8fb:	89 e5                	mov    %esp,%ebp
 8fd:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 900:	8b 45 0c             	mov    0xc(%ebp),%eax
 903:	89 44 24 04          	mov    %eax,0x4(%esp)
 907:	8b 45 08             	mov    0x8(%ebp),%eax
 90a:	89 04 24             	mov    %eax,(%esp)
 90d:	e8 7e fa ff ff       	call   390 <kthread_join>
 912:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 915:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 918:	c9                   	leave  
 919:	c3                   	ret    

0000091a <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 91a:	55                   	push   %ebp
 91b:	89 e5                	mov    %esp,%ebp
 91d:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 920:	e8 73 fa ff ff       	call   398 <kthread_mutex_init>
 925:	8b 55 08             	mov    0x8(%ebp),%edx
 928:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 92a:	8b 45 08             	mov    0x8(%ebp),%eax
 92d:	8b 00                	mov    (%eax),%eax
 92f:	85 c0                	test   %eax,%eax
 931:	7e 07                	jle    93a <qthread_mutex_init+0x20>
		return 0;
 933:	b8 00 00 00 00       	mov    $0x0,%eax
 938:	eb 05                	jmp    93f <qthread_mutex_init+0x25>
	}
	return *mutex;
 93a:	8b 45 08             	mov    0x8(%ebp),%eax
 93d:	8b 00                	mov    (%eax),%eax
}
 93f:	c9                   	leave  
 940:	c3                   	ret    

00000941 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 941:	55                   	push   %ebp
 942:	89 e5                	mov    %esp,%ebp
 944:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 947:	8b 45 08             	mov    0x8(%ebp),%eax
 94a:	89 04 24             	mov    %eax,(%esp)
 94d:	e8 4e fa ff ff       	call   3a0 <kthread_mutex_destroy>
 952:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 955:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 959:	79 07                	jns    962 <qthread_mutex_destroy+0x21>
    	return -1;
 95b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 960:	eb 05                	jmp    967 <qthread_mutex_destroy+0x26>
    }
    return 0;
 962:	b8 00 00 00 00       	mov    $0x0,%eax
}
 967:	c9                   	leave  
 968:	c3                   	ret    

00000969 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 969:	55                   	push   %ebp
 96a:	89 e5                	mov    %esp,%ebp
 96c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 96f:	8b 45 08             	mov    0x8(%ebp),%eax
 972:	89 04 24             	mov    %eax,(%esp)
 975:	e8 2e fa ff ff       	call   3a8 <kthread_mutex_lock>
 97a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 97d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 981:	79 07                	jns    98a <qthread_mutex_lock+0x21>
    	return -1;
 983:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 988:	eb 05                	jmp    98f <qthread_mutex_lock+0x26>
    }
    return 0;
 98a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 98f:	c9                   	leave  
 990:	c3                   	ret    

00000991 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 991:	55                   	push   %ebp
 992:	89 e5                	mov    %esp,%ebp
 994:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 997:	8b 45 08             	mov    0x8(%ebp),%eax
 99a:	89 04 24             	mov    %eax,(%esp)
 99d:	e8 0e fa ff ff       	call   3b0 <kthread_mutex_unlock>
 9a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 9a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a9:	79 07                	jns    9b2 <qthread_mutex_unlock+0x21>
    	return -1;
 9ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9b0:	eb 05                	jmp    9b7 <qthread_mutex_unlock+0x26>
    }
    return 0;
 9b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9b7:	c9                   	leave  
 9b8:	c3                   	ret    

000009b9 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 9b9:	55                   	push   %ebp
 9ba:	89 e5                	mov    %esp,%ebp

	return 0;
 9bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9c1:	5d                   	pop    %ebp
 9c2:	c3                   	ret    

000009c3 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 9c3:	55                   	push   %ebp
 9c4:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9cb:	5d                   	pop    %ebp
 9cc:	c3                   	ret    

000009cd <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 9cd:	55                   	push   %ebp
 9ce:	89 e5                	mov    %esp,%ebp
    
    return 0;
 9d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9d5:	5d                   	pop    %ebp
 9d6:	c3                   	ret    

000009d7 <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 9d7:	55                   	push   %ebp
 9d8:	89 e5                	mov    %esp,%ebp
	return 0;
 9da:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9df:	5d                   	pop    %ebp
 9e0:	c3                   	ret    

000009e1 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 9e1:	55                   	push   %ebp
 9e2:	89 e5                	mov    %esp,%ebp
	return 0;
 9e4:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 9e9:	5d                   	pop    %ebp
 9ea:	c3                   	ret    

000009eb <qthread_exit>:

int qthread_exit(){
 9eb:	55                   	push   %ebp
 9ec:	89 e5                	mov    %esp,%ebp
	return 0;
 9ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f3:	5d                   	pop    %ebp
 9f4:	c3                   	ret    
