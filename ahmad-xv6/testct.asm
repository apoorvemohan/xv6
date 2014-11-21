
_testct:     file format elf32-i386


Disassembly of section .text:

00000000 <f1>:
#include "stat.h"
#include "user.h"
#include "qthread.h"


void *f1(void *arg) { return arg; }
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 45 08             	mov    0x8(%ebp),%eax
   6:	5d                   	pop    %ebp
   7:	c3                   	ret    

00000008 <test1>:
void test1(void)
{
   8:	55                   	push   %ebp
   9:	89 e5                	mov    %esp,%ebp
   b:	83 ec 48             	sub    $0x48,%esp
    qthread_t t[10];
    int i, j;
    for (i = 0; i < 10; i++)
   e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  15:	eb 2a                	jmp    41 <test1+0x39>
        qthread_create(&t[i], f1, (void*)i);
  17:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1d:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  24:	8d 55 cc             	lea    -0x34(%ebp),%edx
  27:	01 ca                	add    %ecx,%edx
  29:	89 44 24 08          	mov    %eax,0x8(%esp)
  2d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  34:	00 
  35:	89 14 24             	mov    %edx,(%esp)
  38:	e8 21 08 00 00       	call   85e <qthread_create>
void *f1(void *arg) { return arg; }
void test1(void)
{
    qthread_t t[10];
    int i, j;
    for (i = 0; i < 10; i++)
  3d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  41:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  45:	7e d0                	jle    17 <test1+0xf>
        qthread_create(&t[i], f1, (void*)i);
    for (i = 0; i < 10; i++) {
  47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  4e:	eb 1a                	jmp    6a <test1+0x62>
        qthread_join(t[i], (void**)&j);
  50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  53:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  57:	8d 55 c8             	lea    -0x38(%ebp),%edx
  5a:	89 54 24 04          	mov    %edx,0x4(%esp)
  5e:	89 04 24             	mov    %eax,(%esp)
  61:	e8 41 08 00 00       	call   8a7 <qthread_join>
{
    qthread_t t[10];
    int i, j;
    for (i = 0; i < 10; i++)
        qthread_create(&t[i], f1, (void*)i);
    for (i = 0; i < 10; i++) {
  66:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  6e:	7e e0                	jle    50 <test1+0x48>
        qthread_join(t[i], (void**)&j);
//        assert(i == j);
    }
    printf(1, "test 1 OK\n");
  70:	c7 44 24 04 c9 08 00 	movl   $0x8c9,0x4(%esp)
  77:	00 
  78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7f:	e8 ff 03 00 00       	call   483 <printf>
}
  84:	c9                   	leave  
  85:	c3                   	ret    

00000086 <main>:


int main(void){
  86:	55                   	push   %ebp
  87:	89 e5                	mov    %esp,%ebp
  89:	83 e4 f0             	and    $0xfffffff0,%esp

//ct();
//exit();

test1();
  8c:	e8 77 ff ff ff       	call   8 <test1>
exit();
  91:	e8 66 02 00 00       	call   2fc <exit>
  96:	90                   	nop
  97:	90                   	nop

00000098 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  98:	55                   	push   %ebp
  99:	89 e5                	mov    %esp,%ebp
  9b:	57                   	push   %edi
  9c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a0:	8b 55 10             	mov    0x10(%ebp),%edx
  a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  a6:	89 cb                	mov    %ecx,%ebx
  a8:	89 df                	mov    %ebx,%edi
  aa:	89 d1                	mov    %edx,%ecx
  ac:	fc                   	cld    
  ad:	f3 aa                	rep stos %al,%es:(%edi)
  af:	89 ca                	mov    %ecx,%edx
  b1:	89 fb                	mov    %edi,%ebx
  b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
  b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b9:	5b                   	pop    %ebx
  ba:	5f                   	pop    %edi
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    

000000bd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  bd:	55                   	push   %ebp
  be:	89 e5                	mov    %esp,%ebp
  c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  c3:	8b 45 08             	mov    0x8(%ebp),%eax
  c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c9:	90                   	nop
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	0f b6 10             	movzbl (%eax),%edx
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	88 10                	mov    %dl,(%eax)
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	0f 95 c0             	setne  %al
  e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  e8:	84 c0                	test   %al,%al
  ea:	75 de                	jne    ca <strcpy+0xd>
    ;
  return os;
  ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ef:	c9                   	leave  
  f0:	c3                   	ret    

000000f1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f1:	55                   	push   %ebp
  f2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  f4:	eb 08                	jmp    fe <strcmp+0xd>
    p++, q++;
  f6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  fa:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  fe:	8b 45 08             	mov    0x8(%ebp),%eax
 101:	0f b6 00             	movzbl (%eax),%eax
 104:	84 c0                	test   %al,%al
 106:	74 10                	je     118 <strcmp+0x27>
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	0f b6 10             	movzbl (%eax),%edx
 10e:	8b 45 0c             	mov    0xc(%ebp),%eax
 111:	0f b6 00             	movzbl (%eax),%eax
 114:	38 c2                	cmp    %al,%dl
 116:	74 de                	je     f6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	0f b6 00             	movzbl (%eax),%eax
 11e:	0f b6 d0             	movzbl %al,%edx
 121:	8b 45 0c             	mov    0xc(%ebp),%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	0f b6 c0             	movzbl %al,%eax
 12a:	89 d1                	mov    %edx,%ecx
 12c:	29 c1                	sub    %eax,%ecx
 12e:	89 c8                	mov    %ecx,%eax
}
 130:	5d                   	pop    %ebp
 131:	c3                   	ret    

00000132 <strlen>:

uint
strlen(char *s)
{
 132:	55                   	push   %ebp
 133:	89 e5                	mov    %esp,%ebp
 135:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 138:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 13f:	eb 04                	jmp    145 <strlen+0x13>
 141:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 145:	8b 45 fc             	mov    -0x4(%ebp),%eax
 148:	03 45 08             	add    0x8(%ebp),%eax
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	84 c0                	test   %al,%al
 150:	75 ef                	jne    141 <strlen+0xf>
    ;
  return n;
 152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 155:	c9                   	leave  
 156:	c3                   	ret    

00000157 <memset>:

void*
memset(void *dst, int c, uint n)
{
 157:	55                   	push   %ebp
 158:	89 e5                	mov    %esp,%ebp
 15a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 15d:	8b 45 10             	mov    0x10(%ebp),%eax
 160:	89 44 24 08          	mov    %eax,0x8(%esp)
 164:	8b 45 0c             	mov    0xc(%ebp),%eax
 167:	89 44 24 04          	mov    %eax,0x4(%esp)
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	89 04 24             	mov    %eax,(%esp)
 171:	e8 22 ff ff ff       	call   98 <stosb>
  return dst;
 176:	8b 45 08             	mov    0x8(%ebp),%eax
}
 179:	c9                   	leave  
 17a:	c3                   	ret    

0000017b <strchr>:

char*
strchr(const char *s, char c)
{
 17b:	55                   	push   %ebp
 17c:	89 e5                	mov    %esp,%ebp
 17e:	83 ec 04             	sub    $0x4,%esp
 181:	8b 45 0c             	mov    0xc(%ebp),%eax
 184:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 187:	eb 14                	jmp    19d <strchr+0x22>
    if(*s == c)
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	0f b6 00             	movzbl (%eax),%eax
 18f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 192:	75 05                	jne    199 <strchr+0x1e>
      return (char*)s;
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	eb 13                	jmp    1ac <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 199:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
 1a0:	0f b6 00             	movzbl (%eax),%eax
 1a3:	84 c0                	test   %al,%al
 1a5:	75 e2                	jne    189 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ac:	c9                   	leave  
 1ad:	c3                   	ret    

000001ae <gets>:

char*
gets(char *buf, int max)
{
 1ae:	55                   	push   %ebp
 1af:	89 e5                	mov    %esp,%ebp
 1b1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1bb:	eb 44                	jmp    201 <gets+0x53>
    cc = read(0, &c, 1);
 1bd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1c4:	00 
 1c5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1d3:	e8 3c 01 00 00       	call   314 <read>
 1d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1df:	7e 2d                	jle    20e <gets+0x60>
      break;
    buf[i++] = c;
 1e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e4:	03 45 08             	add    0x8(%ebp),%eax
 1e7:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1eb:	88 10                	mov    %dl,(%eax)
 1ed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1f1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f5:	3c 0a                	cmp    $0xa,%al
 1f7:	74 16                	je     20f <gets+0x61>
 1f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1fd:	3c 0d                	cmp    $0xd,%al
 1ff:	74 0e                	je     20f <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 201:	8b 45 f4             	mov    -0xc(%ebp),%eax
 204:	83 c0 01             	add    $0x1,%eax
 207:	3b 45 0c             	cmp    0xc(%ebp),%eax
 20a:	7c b1                	jl     1bd <gets+0xf>
 20c:	eb 01                	jmp    20f <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 20e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 20f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 212:	03 45 08             	add    0x8(%ebp),%eax
 215:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 218:	8b 45 08             	mov    0x8(%ebp),%eax
}
 21b:	c9                   	leave  
 21c:	c3                   	ret    

0000021d <stat>:

int
stat(char *n, struct stat *st)
{
 21d:	55                   	push   %ebp
 21e:	89 e5                	mov    %esp,%ebp
 220:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 223:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 22a:	00 
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	89 04 24             	mov    %eax,(%esp)
 231:	e8 06 01 00 00       	call   33c <open>
 236:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 239:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 23d:	79 07                	jns    246 <stat+0x29>
    return -1;
 23f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 244:	eb 23                	jmp    269 <stat+0x4c>
  r = fstat(fd, st);
 246:	8b 45 0c             	mov    0xc(%ebp),%eax
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 250:	89 04 24             	mov    %eax,(%esp)
 253:	e8 fc 00 00 00       	call   354 <fstat>
 258:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 25b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25e:	89 04 24             	mov    %eax,(%esp)
 261:	e8 be 00 00 00       	call   324 <close>
  return r;
 266:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 269:	c9                   	leave  
 26a:	c3                   	ret    

0000026b <atoi>:

int
atoi(const char *s)
{
 26b:	55                   	push   %ebp
 26c:	89 e5                	mov    %esp,%ebp
 26e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 271:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 278:	eb 23                	jmp    29d <atoi+0x32>
    n = n*10 + *s++ - '0';
 27a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 27d:	89 d0                	mov    %edx,%eax
 27f:	c1 e0 02             	shl    $0x2,%eax
 282:	01 d0                	add    %edx,%eax
 284:	01 c0                	add    %eax,%eax
 286:	89 c2                	mov    %eax,%edx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	0f be c0             	movsbl %al,%eax
 291:	01 d0                	add    %edx,%eax
 293:	83 e8 30             	sub    $0x30,%eax
 296:	89 45 fc             	mov    %eax,-0x4(%ebp)
 299:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
 2a0:	0f b6 00             	movzbl (%eax),%eax
 2a3:	3c 2f                	cmp    $0x2f,%al
 2a5:	7e 0a                	jle    2b1 <atoi+0x46>
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	0f b6 00             	movzbl (%eax),%eax
 2ad:	3c 39                	cmp    $0x39,%al
 2af:	7e c9                	jle    27a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b4:	c9                   	leave  
 2b5:	c3                   	ret    

000002b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b6:	55                   	push   %ebp
 2b7:	89 e5                	mov    %esp,%ebp
 2b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
 2bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2c8:	eb 13                	jmp    2dd <memmove+0x27>
    *dst++ = *src++;
 2ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2cd:	0f b6 10             	movzbl (%eax),%edx
 2d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2d3:	88 10                	mov    %dl,(%eax)
 2d5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2d9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2e1:	0f 9f c0             	setg   %al
 2e4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2e8:	84 c0                	test   %al,%al
 2ea:	75 de                	jne    2ca <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ef:	c9                   	leave  
 2f0:	c3                   	ret    
 2f1:	90                   	nop
 2f2:	90                   	nop
 2f3:	90                   	nop

000002f4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2f4:	b8 01 00 00 00       	mov    $0x1,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <exit>:
SYSCALL(exit)
 2fc:	b8 02 00 00 00       	mov    $0x2,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <wait>:
SYSCALL(wait)
 304:	b8 03 00 00 00       	mov    $0x3,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <pipe>:
SYSCALL(pipe)
 30c:	b8 04 00 00 00       	mov    $0x4,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <read>:
SYSCALL(read)
 314:	b8 05 00 00 00       	mov    $0x5,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <write>:
SYSCALL(write)
 31c:	b8 10 00 00 00       	mov    $0x10,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <close>:
SYSCALL(close)
 324:	b8 15 00 00 00       	mov    $0x15,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <kill>:
SYSCALL(kill)
 32c:	b8 06 00 00 00       	mov    $0x6,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <exec>:
SYSCALL(exec)
 334:	b8 07 00 00 00       	mov    $0x7,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <open>:
SYSCALL(open)
 33c:	b8 0f 00 00 00       	mov    $0xf,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <mknod>:
SYSCALL(mknod)
 344:	b8 11 00 00 00       	mov    $0x11,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <unlink>:
SYSCALL(unlink)
 34c:	b8 12 00 00 00       	mov    $0x12,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <fstat>:
SYSCALL(fstat)
 354:	b8 08 00 00 00       	mov    $0x8,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <link>:
SYSCALL(link)
 35c:	b8 13 00 00 00       	mov    $0x13,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <mkdir>:
SYSCALL(mkdir)
 364:	b8 14 00 00 00       	mov    $0x14,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <chdir>:
SYSCALL(chdir)
 36c:	b8 09 00 00 00       	mov    $0x9,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <dup>:
SYSCALL(dup)
 374:	b8 0a 00 00 00       	mov    $0xa,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <getpid>:
SYSCALL(getpid)
 37c:	b8 0b 00 00 00       	mov    $0xb,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <sbrk>:
SYSCALL(sbrk)
 384:	b8 0c 00 00 00       	mov    $0xc,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <sleep>:
SYSCALL(sleep)
 38c:	b8 0d 00 00 00       	mov    $0xd,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <uptime>:
SYSCALL(uptime)
 394:	b8 0e 00 00 00       	mov    $0xe,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <kthread_create>:
SYSCALL(kthread_create)
 39c:	b8 17 00 00 00       	mov    $0x17,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <kthread_join>:
SYSCALL(kthread_join)
 3a4:	b8 16 00 00 00       	mov    $0x16,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ac:	55                   	push   %ebp
 3ad:	89 e5                	mov    %esp,%ebp
 3af:	83 ec 28             	sub    $0x28,%esp
 3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3bf:	00 
 3c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	89 04 24             	mov    %eax,(%esp)
 3cd:	e8 4a ff ff ff       	call   31c <write>
}
 3d2:	c9                   	leave  
 3d3:	c3                   	ret    

000003d4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3e1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3e5:	74 17                	je     3fe <printint+0x2a>
 3e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3eb:	79 11                	jns    3fe <printint+0x2a>
    neg = 1;
 3ed:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3f4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f7:	f7 d8                	neg    %eax
 3f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3fc:	eb 06                	jmp    404 <printint+0x30>
  } else {
    x = xx;
 3fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 401:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 404:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 40b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 40e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 411:	ba 00 00 00 00       	mov    $0x0,%edx
 416:	f7 f1                	div    %ecx
 418:	89 d0                	mov    %edx,%eax
 41a:	0f b6 90 b4 0b 00 00 	movzbl 0xbb4(%eax),%edx
 421:	8d 45 dc             	lea    -0x24(%ebp),%eax
 424:	03 45 f4             	add    -0xc(%ebp),%eax
 427:	88 10                	mov    %dl,(%eax)
 429:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 42d:	8b 55 10             	mov    0x10(%ebp),%edx
 430:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 433:	8b 45 ec             	mov    -0x14(%ebp),%eax
 436:	ba 00 00 00 00       	mov    $0x0,%edx
 43b:	f7 75 d4             	divl   -0x2c(%ebp)
 43e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 441:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 445:	75 c4                	jne    40b <printint+0x37>
  if(neg)
 447:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 44b:	74 2a                	je     477 <printint+0xa3>
    buf[i++] = '-';
 44d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 450:	03 45 f4             	add    -0xc(%ebp),%eax
 453:	c6 00 2d             	movb   $0x2d,(%eax)
 456:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 45a:	eb 1b                	jmp    477 <printint+0xa3>
    putc(fd, buf[i]);
 45c:	8d 45 dc             	lea    -0x24(%ebp),%eax
 45f:	03 45 f4             	add    -0xc(%ebp),%eax
 462:	0f b6 00             	movzbl (%eax),%eax
 465:	0f be c0             	movsbl %al,%eax
 468:	89 44 24 04          	mov    %eax,0x4(%esp)
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
 46f:	89 04 24             	mov    %eax,(%esp)
 472:	e8 35 ff ff ff       	call   3ac <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 477:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 47b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 47f:	79 db                	jns    45c <printint+0x88>
    putc(fd, buf[i]);
}
 481:	c9                   	leave  
 482:	c3                   	ret    

00000483 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 483:	55                   	push   %ebp
 484:	89 e5                	mov    %esp,%ebp
 486:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 489:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 490:	8d 45 0c             	lea    0xc(%ebp),%eax
 493:	83 c0 04             	add    $0x4,%eax
 496:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 499:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4a0:	e9 7d 01 00 00       	jmp    622 <printf+0x19f>
    c = fmt[i] & 0xff;
 4a5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ab:	01 d0                	add    %edx,%eax
 4ad:	0f b6 00             	movzbl (%eax),%eax
 4b0:	0f be c0             	movsbl %al,%eax
 4b3:	25 ff 00 00 00       	and    $0xff,%eax
 4b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4bf:	75 2c                	jne    4ed <printf+0x6a>
      if(c == '%'){
 4c1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4c5:	75 0c                	jne    4d3 <printf+0x50>
        state = '%';
 4c7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ce:	e9 4b 01 00 00       	jmp    61e <printf+0x19b>
      } else {
        putc(fd, c);
 4d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4d6:	0f be c0             	movsbl %al,%eax
 4d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dd:	8b 45 08             	mov    0x8(%ebp),%eax
 4e0:	89 04 24             	mov    %eax,(%esp)
 4e3:	e8 c4 fe ff ff       	call   3ac <putc>
 4e8:	e9 31 01 00 00       	jmp    61e <printf+0x19b>
      }
    } else if(state == '%'){
 4ed:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4f1:	0f 85 27 01 00 00    	jne    61e <printf+0x19b>
      if(c == 'd'){
 4f7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4fb:	75 2d                	jne    52a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 500:	8b 00                	mov    (%eax),%eax
 502:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 509:	00 
 50a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 511:	00 
 512:	89 44 24 04          	mov    %eax,0x4(%esp)
 516:	8b 45 08             	mov    0x8(%ebp),%eax
 519:	89 04 24             	mov    %eax,(%esp)
 51c:	e8 b3 fe ff ff       	call   3d4 <printint>
        ap++;
 521:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 525:	e9 ed 00 00 00       	jmp    617 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 52a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 52e:	74 06                	je     536 <printf+0xb3>
 530:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 534:	75 2d                	jne    563 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 536:	8b 45 e8             	mov    -0x18(%ebp),%eax
 539:	8b 00                	mov    (%eax),%eax
 53b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 542:	00 
 543:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 54a:	00 
 54b:	89 44 24 04          	mov    %eax,0x4(%esp)
 54f:	8b 45 08             	mov    0x8(%ebp),%eax
 552:	89 04 24             	mov    %eax,(%esp)
 555:	e8 7a fe ff ff       	call   3d4 <printint>
        ap++;
 55a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55e:	e9 b4 00 00 00       	jmp    617 <printf+0x194>
      } else if(c == 's'){
 563:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 567:	75 46                	jne    5af <printf+0x12c>
        s = (char*)*ap;
 569:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56c:	8b 00                	mov    (%eax),%eax
 56e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 571:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 575:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 579:	75 27                	jne    5a2 <printf+0x11f>
          s = "(null)";
 57b:	c7 45 f4 d4 08 00 00 	movl   $0x8d4,-0xc(%ebp)
        while(*s != 0){
 582:	eb 1e                	jmp    5a2 <printf+0x11f>
          putc(fd, *s);
 584:	8b 45 f4             	mov    -0xc(%ebp),%eax
 587:	0f b6 00             	movzbl (%eax),%eax
 58a:	0f be c0             	movsbl %al,%eax
 58d:	89 44 24 04          	mov    %eax,0x4(%esp)
 591:	8b 45 08             	mov    0x8(%ebp),%eax
 594:	89 04 24             	mov    %eax,(%esp)
 597:	e8 10 fe ff ff       	call   3ac <putc>
          s++;
 59c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5a0:	eb 01                	jmp    5a3 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a2:	90                   	nop
 5a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a6:	0f b6 00             	movzbl (%eax),%eax
 5a9:	84 c0                	test   %al,%al
 5ab:	75 d7                	jne    584 <printf+0x101>
 5ad:	eb 68                	jmp    617 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5af:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b3:	75 1d                	jne    5d2 <printf+0x14f>
        putc(fd, *ap);
 5b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b8:	8b 00                	mov    (%eax),%eax
 5ba:	0f be c0             	movsbl %al,%eax
 5bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c1:	8b 45 08             	mov    0x8(%ebp),%eax
 5c4:	89 04 24             	mov    %eax,(%esp)
 5c7:	e8 e0 fd ff ff       	call   3ac <putc>
        ap++;
 5cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d0:	eb 45                	jmp    617 <printf+0x194>
      } else if(c == '%'){
 5d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d6:	75 17                	jne    5ef <printf+0x16c>
        putc(fd, c);
 5d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5db:	0f be c0             	movsbl %al,%eax
 5de:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e2:	8b 45 08             	mov    0x8(%ebp),%eax
 5e5:	89 04 24             	mov    %eax,(%esp)
 5e8:	e8 bf fd ff ff       	call   3ac <putc>
 5ed:	eb 28                	jmp    617 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ef:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5f6:	00 
 5f7:	8b 45 08             	mov    0x8(%ebp),%eax
 5fa:	89 04 24             	mov    %eax,(%esp)
 5fd:	e8 aa fd ff ff       	call   3ac <putc>
        putc(fd, c);
 602:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 605:	0f be c0             	movsbl %al,%eax
 608:	89 44 24 04          	mov    %eax,0x4(%esp)
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	89 04 24             	mov    %eax,(%esp)
 612:	e8 95 fd ff ff       	call   3ac <putc>
      }
      state = 0;
 617:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 622:	8b 55 0c             	mov    0xc(%ebp),%edx
 625:	8b 45 f0             	mov    -0x10(%ebp),%eax
 628:	01 d0                	add    %edx,%eax
 62a:	0f b6 00             	movzbl (%eax),%eax
 62d:	84 c0                	test   %al,%al
 62f:	0f 85 70 fe ff ff    	jne    4a5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 635:	c9                   	leave  
 636:	c3                   	ret    
 637:	90                   	nop

00000638 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 638:	55                   	push   %ebp
 639:	89 e5                	mov    %esp,%ebp
 63b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 63e:	8b 45 08             	mov    0x8(%ebp),%eax
 641:	83 e8 08             	sub    $0x8,%eax
 644:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 647:	a1 d0 0b 00 00       	mov    0xbd0,%eax
 64c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 64f:	eb 24                	jmp    675 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 651:	8b 45 fc             	mov    -0x4(%ebp),%eax
 654:	8b 00                	mov    (%eax),%eax
 656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 659:	77 12                	ja     66d <free+0x35>
 65b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 661:	77 24                	ja     687 <free+0x4f>
 663:	8b 45 fc             	mov    -0x4(%ebp),%eax
 666:	8b 00                	mov    (%eax),%eax
 668:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66b:	77 1a                	ja     687 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	89 45 fc             	mov    %eax,-0x4(%ebp)
 675:	8b 45 f8             	mov    -0x8(%ebp),%eax
 678:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67b:	76 d4                	jbe    651 <free+0x19>
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 685:	76 ca                	jbe    651 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	8b 40 04             	mov    0x4(%eax),%eax
 68d:	c1 e0 03             	shl    $0x3,%eax
 690:	89 c2                	mov    %eax,%edx
 692:	03 55 f8             	add    -0x8(%ebp),%edx
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	8b 00                	mov    (%eax),%eax
 69a:	39 c2                	cmp    %eax,%edx
 69c:	75 24                	jne    6c2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a1:	8b 50 04             	mov    0x4(%eax),%edx
 6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a7:	8b 00                	mov    (%eax),%eax
 6a9:	8b 40 04             	mov    0x4(%eax),%eax
 6ac:	01 c2                	add    %eax,%edx
 6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b7:	8b 00                	mov    (%eax),%eax
 6b9:	8b 10                	mov    (%eax),%edx
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	89 10                	mov    %edx,(%eax)
 6c0:	eb 0a                	jmp    6cc <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	8b 10                	mov    (%eax),%edx
 6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ca:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 40 04             	mov    0x4(%eax),%eax
 6d2:	c1 e0 03             	shl    $0x3,%eax
 6d5:	03 45 fc             	add    -0x4(%ebp),%eax
 6d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6db:	75 20                	jne    6fd <free+0xc5>
    p->s.size += bp->s.size;
 6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e0:	8b 50 04             	mov    0x4(%eax),%edx
 6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e6:	8b 40 04             	mov    0x4(%eax),%eax
 6e9:	01 c2                	add    %eax,%edx
 6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ee:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f4:	8b 10                	mov    (%eax),%edx
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	89 10                	mov    %edx,(%eax)
 6fb:	eb 08                	jmp    705 <free+0xcd>
  } else
    p->s.ptr = bp;
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 55 f8             	mov    -0x8(%ebp),%edx
 703:	89 10                	mov    %edx,(%eax)
  freep = p;
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	a3 d0 0b 00 00       	mov    %eax,0xbd0
}
 70d:	c9                   	leave  
 70e:	c3                   	ret    

0000070f <morecore>:

static Header*
morecore(uint nu)
{
 70f:	55                   	push   %ebp
 710:	89 e5                	mov    %esp,%ebp
 712:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 715:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 71c:	77 07                	ja     725 <morecore+0x16>
    nu = 4096;
 71e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 725:	8b 45 08             	mov    0x8(%ebp),%eax
 728:	c1 e0 03             	shl    $0x3,%eax
 72b:	89 04 24             	mov    %eax,(%esp)
 72e:	e8 51 fc ff ff       	call   384 <sbrk>
 733:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 736:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 73a:	75 07                	jne    743 <morecore+0x34>
    return 0;
 73c:	b8 00 00 00 00       	mov    $0x0,%eax
 741:	eb 22                	jmp    765 <morecore+0x56>
  hp = (Header*)p;
 743:	8b 45 f4             	mov    -0xc(%ebp),%eax
 746:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 749:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74c:	8b 55 08             	mov    0x8(%ebp),%edx
 74f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 752:	8b 45 f0             	mov    -0x10(%ebp),%eax
 755:	83 c0 08             	add    $0x8,%eax
 758:	89 04 24             	mov    %eax,(%esp)
 75b:	e8 d8 fe ff ff       	call   638 <free>
  return freep;
 760:	a1 d0 0b 00 00       	mov    0xbd0,%eax
}
 765:	c9                   	leave  
 766:	c3                   	ret    

00000767 <malloc>:

void*
malloc(uint nbytes)
{
 767:	55                   	push   %ebp
 768:	89 e5                	mov    %esp,%ebp
 76a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 76d:	8b 45 08             	mov    0x8(%ebp),%eax
 770:	83 c0 07             	add    $0x7,%eax
 773:	c1 e8 03             	shr    $0x3,%eax
 776:	83 c0 01             	add    $0x1,%eax
 779:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 77c:	a1 d0 0b 00 00       	mov    0xbd0,%eax
 781:	89 45 f0             	mov    %eax,-0x10(%ebp)
 784:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 788:	75 23                	jne    7ad <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 78a:	c7 45 f0 c8 0b 00 00 	movl   $0xbc8,-0x10(%ebp)
 791:	8b 45 f0             	mov    -0x10(%ebp),%eax
 794:	a3 d0 0b 00 00       	mov    %eax,0xbd0
 799:	a1 d0 0b 00 00       	mov    0xbd0,%eax
 79e:	a3 c8 0b 00 00       	mov    %eax,0xbc8
    base.s.size = 0;
 7a3:	c7 05 cc 0b 00 00 00 	movl   $0x0,0xbcc
 7aa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b0:	8b 00                	mov    (%eax),%eax
 7b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b8:	8b 40 04             	mov    0x4(%eax),%eax
 7bb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7be:	72 4d                	jb     80d <malloc+0xa6>
      if(p->s.size == nunits)
 7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c3:	8b 40 04             	mov    0x4(%eax),%eax
 7c6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7c9:	75 0c                	jne    7d7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	8b 10                	mov    (%eax),%edx
 7d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d3:	89 10                	mov    %edx,(%eax)
 7d5:	eb 26                	jmp    7fd <malloc+0x96>
      else {
        p->s.size -= nunits;
 7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7da:	8b 40 04             	mov    0x4(%eax),%eax
 7dd:	89 c2                	mov    %eax,%edx
 7df:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 40 04             	mov    0x4(%eax),%eax
 7ee:	c1 e0 03             	shl    $0x3,%eax
 7f1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7fa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 800:	a3 d0 0b 00 00       	mov    %eax,0xbd0
      return (void*)(p + 1);
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	83 c0 08             	add    $0x8,%eax
 80b:	eb 38                	jmp    845 <malloc+0xde>
    }
    if(p == freep)
 80d:	a1 d0 0b 00 00       	mov    0xbd0,%eax
 812:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 815:	75 1b                	jne    832 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 817:	8b 45 ec             	mov    -0x14(%ebp),%eax
 81a:	89 04 24             	mov    %eax,(%esp)
 81d:	e8 ed fe ff ff       	call   70f <morecore>
 822:	89 45 f4             	mov    %eax,-0xc(%ebp)
 825:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 829:	75 07                	jne    832 <malloc+0xcb>
        return 0;
 82b:	b8 00 00 00 00       	mov    $0x0,%eax
 830:	eb 13                	jmp    845 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 832:	8b 45 f4             	mov    -0xc(%ebp),%eax
 835:	89 45 f0             	mov    %eax,-0x10(%ebp)
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	8b 00                	mov    (%eax),%eax
 83d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 840:	e9 70 ff ff ff       	jmp    7b5 <malloc+0x4e>
}
 845:	c9                   	leave  
 846:	c3                   	ret    
 847:	90                   	nop

00000848 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void *wrapper(qthread_func_ptr_t func, void *arg) {
 848:	55                   	push   %ebp
 849:	89 e5                	mov    %esp,%ebp
 84b:	83 ec 18             	sub    $0x18,%esp
    func(arg);
 84e:	8b 45 0c             	mov    0xc(%ebp),%eax
 851:	89 04 24             	mov    %eax,(%esp)
 854:	8b 45 08             	mov    0x8(%ebp),%eax
 857:	ff d0                	call   *%eax
    exit();
 859:	e8 9e fa ff ff       	call   2fc <exit>

0000085e <qthread_create>:

}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 85e:	55                   	push   %ebp
 85f:	89 e5                	mov    %esp,%ebp
 861:	83 ec 28             	sub    $0x28,%esp

    int SP = (int)malloc(THREADSTACKSIZE);
 864:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 86b:	e8 f7 fe ff ff       	call   767 <malloc>
 870:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int t_id = kthread_create(SP,(int)wrapper,(int)my_func,(int)arg);
 873:	8b 4d 10             	mov    0x10(%ebp),%ecx
 876:	8b 55 0c             	mov    0xc(%ebp),%edx
 879:	b8 48 08 00 00       	mov    $0x848,%eax
 87e:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 882:	89 54 24 08          	mov    %edx,0x8(%esp)
 886:	89 44 24 04          	mov    %eax,0x4(%esp)
 88a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88d:	89 04 24             	mov    %eax,(%esp)
 890:	e8 07 fb ff ff       	call   39c <kthread_create>
 895:	89 45 f0             	mov    %eax,-0x10(%ebp)
    (*thread)->tid = t_id;
 898:	8b 45 08             	mov    0x8(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	8b 55 f0             	mov    -0x10(%ebp),%edx
 8a0:	89 10                	mov    %edx,(%eax)
    return t_id;
 8a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 8a5:	c9                   	leave  
 8a6:	c3                   	ret    

000008a7 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 8a7:	55                   	push   %ebp
 8a8:	89 e5                	mov    %esp,%ebp
 8aa:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 8ad:	8b 55 0c             	mov    0xc(%ebp),%edx
 8b0:	8b 45 08             	mov    0x8(%ebp),%eax
 8b3:	8b 00                	mov    (%eax),%eax
 8b5:	89 54 24 04          	mov    %edx,0x4(%esp)
 8b9:	89 04 24             	mov    %eax,(%esp)
 8bc:	e8 e3 fa ff ff       	call   3a4 <kthread_join>
 8c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 8c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 8c7:	c9                   	leave  
 8c8:	c3                   	ret    
