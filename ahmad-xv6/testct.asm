
_testct:     file format elf32-i386


Disassembly of section .text:

00000000 <test1>:
qthread_mutex_t m;
int mvar = 0;

#define THREADSTACKSIZE 4096

void test1(void){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 58             	sub    $0x58,%esp

	qthread_t t[MAX_THREADS];
    qthread_mutex_init(&m);
   6:	c7 04 24 38 0f 00 00 	movl   $0xf38,(%esp)
   d:	e8 ef 09 00 00       	call   a01 <qthread_mutex_init>

	int i,j;

    
	for(i = 0; i < MAX_THREADS; i++){
  12:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  19:	eb 56                	jmp    71 <test1+0x71>
        	int tid = qthread_create(&t[i], f2, (void*)&i);
  1b:	8b 55 c8             	mov    -0x38(%ebp),%edx
  1e:	8d 45 cc             	lea    -0x34(%ebp),%eax
  21:	c1 e2 02             	shl    $0x2,%edx
  24:	01 c2                	add    %eax,%edx
  26:	8d 45 c8             	lea    -0x38(%ebp),%eax
  29:	89 44 24 08          	mov    %eax,0x8(%esp)
  2d:	c7 44 24 04 1b 01 00 	movl   $0x11b,0x4(%esp)
  34:	00 
  35:	89 14 24             	mov    %edx,(%esp)
  38:	e8 3e 09 00 00       	call   97b <qthread_create>
  3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        	printf(1, "[%d : %d]\n", tid, t[i]->tid);
  40:	8b 45 c8             	mov    -0x38(%ebp),%eax
  43:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  47:	8b 00                	mov    (%eax),%eax
  49:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  50:	89 44 24 08          	mov    %eax,0x8(%esp)
  54:	c7 44 24 04 d2 0a 00 	movl   $0xad2,0x4(%esp)
  5b:	00 
  5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  63:	e8 31 05 00 00       	call   599 <printf>
    qthread_mutex_init(&m);

	int i,j;

    
	for(i = 0; i < MAX_THREADS; i++){
  68:	8b 45 c8             	mov    -0x38(%ebp),%eax
  6b:	83 c0 01             	add    $0x1,%eax
  6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
  71:	8b 45 c8             	mov    -0x38(%ebp),%eax
  74:	83 f8 09             	cmp    $0x9,%eax
  77:	7e a2                	jle    1b <test1+0x1b>
        	int tid = qthread_create(&t[i], f2, (void*)&i);
        	printf(1, "[%d : %d]\n", tid, t[i]->tid);
	}

	for (i = 0; i < MAX_THREADS; i++){
  79:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  80:	eb 2a                	jmp    ac <test1+0xac>
        	printf(1, "%d\n", t[i]->tid);
  82:	8b 45 c8             	mov    -0x38(%ebp),%eax
  85:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  89:	8b 00                	mov    (%eax),%eax
  8b:	89 44 24 08          	mov    %eax,0x8(%esp)
  8f:	c7 44 24 04 dd 0a 00 	movl   $0xadd,0x4(%esp)
  96:	00 
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 f6 04 00 00       	call   599 <printf>
	for(i = 0; i < MAX_THREADS; i++){
        	int tid = qthread_create(&t[i], f2, (void*)&i);
        	printf(1, "[%d : %d]\n", tid, t[i]->tid);
	}

	for (i = 0; i < MAX_THREADS; i++){
  a3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  a6:	83 c0 01             	add    $0x1,%eax
  a9:	89 45 c8             	mov    %eax,-0x38(%ebp)
  ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
  af:	83 f8 09             	cmp    $0x9,%eax
  b2:	7e ce                	jle    82 <test1+0x82>
        	printf(1, "%d\n", t[i]->tid);
    	}

  	for (i = 0; i < MAX_THREADS; i++) {
  b4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  bb:	eb 1f                	jmp    dc <test1+0xdc>
        	qthread_join(t[i], (void**)&j);
  bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
  c0:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  c4:	8d 55 c4             	lea    -0x3c(%ebp),%edx
  c7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cb:	89 04 24             	mov    %eax,(%esp)
  ce:	e8 0c 09 00 00       	call   9df <qthread_join>

	for (i = 0; i < MAX_THREADS; i++){
        	printf(1, "%d\n", t[i]->tid);
    	}

  	for (i = 0; i < MAX_THREADS; i++) {
  d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  d6:	83 c0 01             	add    $0x1,%eax
  d9:	89 45 c8             	mov    %eax,-0x38(%ebp)
  dc:	8b 45 c8             	mov    -0x38(%ebp),%eax
  df:	83 f8 09             	cmp    $0x9,%eax
  e2:	7e d9                	jle    bd <test1+0xbd>
        	qthread_join(t[i], (void**)&j);
		//        assert(i == j);
    	}
    
   printf(1,"%d\n",mvar);
  e4:	a1 28 0f 00 00       	mov    0xf28,%eax
  e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ed:	c7 44 24 04 dd 0a 00 	movl   $0xadd,0x4(%esp)
  f4:	00 
  f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fc:	e8 98 04 00 00       	call   599 <printf>
}
 101:	c9                   	leave  
 102:	c3                   	ret    

00000103 <main>:

    printf(1, "test 1 OK\n");
}
*/

int main(void){
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	83 e4 f0             	and    $0xfffffff0,%esp

test1();
 109:	e8 f2 fe ff ff       	call   0 <test1>
exit();
 10e:	e8 ae 02 00 00       	call   3c1 <exit>

00000113 <f1>:

}

void *f1(void *arg) {
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp

       // printf(1, "My PID: %d\n", getpid());
        return arg;
 116:	8b 45 08             	mov    0x8(%ebp),%eax
}
 119:	5d                   	pop    %ebp
 11a:	c3                   	ret    

0000011b <f2>:

void *f2(void *v)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	83 ec 18             	sub    $0x18,%esp
    qthread_mutex_lock(&m);
 121:	c7 04 24 38 0f 00 00 	movl   $0xf38,(%esp)
 128:	e8 23 09 00 00       	call   a50 <qthread_mutex_lock>
    mvar++;
 12d:	a1 28 0f 00 00       	mov    0xf28,%eax
 132:	83 c0 01             	add    $0x1,%eax
 135:	a3 28 0f 00 00       	mov    %eax,0xf28
    sleep(1);
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	e8 0b 03 00 00       	call   451 <sleep>
    qthread_mutex_unlock(&m);
 146:	c7 04 24 38 0f 00 00 	movl   $0xf38,(%esp)
 14d:	e8 26 09 00 00       	call   a78 <qthread_mutex_unlock>

    return 0;
 152:	b8 00 00 00 00       	mov    $0x0,%eax
}
 157:	c9                   	leave  
 158:	c3                   	ret    

00000159 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 159:	55                   	push   %ebp
 15a:	89 e5                	mov    %esp,%ebp
 15c:	57                   	push   %edi
 15d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 15e:	8b 4d 08             	mov    0x8(%ebp),%ecx
 161:	8b 55 10             	mov    0x10(%ebp),%edx
 164:	8b 45 0c             	mov    0xc(%ebp),%eax
 167:	89 cb                	mov    %ecx,%ebx
 169:	89 df                	mov    %ebx,%edi
 16b:	89 d1                	mov    %edx,%ecx
 16d:	fc                   	cld    
 16e:	f3 aa                	rep stos %al,%es:(%edi)
 170:	89 ca                	mov    %ecx,%edx
 172:	89 fb                	mov    %edi,%ebx
 174:	89 5d 08             	mov    %ebx,0x8(%ebp)
 177:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 17a:	5b                   	pop    %ebx
 17b:	5f                   	pop    %edi
 17c:	5d                   	pop    %ebp
 17d:	c3                   	ret    

0000017e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 18a:	90                   	nop
 18b:	8b 45 08             	mov    0x8(%ebp),%eax
 18e:	8d 50 01             	lea    0x1(%eax),%edx
 191:	89 55 08             	mov    %edx,0x8(%ebp)
 194:	8b 55 0c             	mov    0xc(%ebp),%edx
 197:	8d 4a 01             	lea    0x1(%edx),%ecx
 19a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 19d:	0f b6 12             	movzbl (%edx),%edx
 1a0:	88 10                	mov    %dl,(%eax)
 1a2:	0f b6 00             	movzbl (%eax),%eax
 1a5:	84 c0                	test   %al,%al
 1a7:	75 e2                	jne    18b <strcpy+0xd>
    ;
  return os;
 1a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1ac:	c9                   	leave  
 1ad:	c3                   	ret    

000001ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ae:	55                   	push   %ebp
 1af:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1b1:	eb 08                	jmp    1bb <strcmp+0xd>
    p++, q++;
 1b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	0f b6 00             	movzbl (%eax),%eax
 1c1:	84 c0                	test   %al,%al
 1c3:	74 10                	je     1d5 <strcmp+0x27>
 1c5:	8b 45 08             	mov    0x8(%ebp),%eax
 1c8:	0f b6 10             	movzbl (%eax),%edx
 1cb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ce:	0f b6 00             	movzbl (%eax),%eax
 1d1:	38 c2                	cmp    %al,%dl
 1d3:	74 de                	je     1b3 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	0f b6 00             	movzbl (%eax),%eax
 1db:	0f b6 d0             	movzbl %al,%edx
 1de:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e1:	0f b6 00             	movzbl (%eax),%eax
 1e4:	0f b6 c0             	movzbl %al,%eax
 1e7:	29 c2                	sub    %eax,%edx
 1e9:	89 d0                	mov    %edx,%eax
}
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    

000001ed <strlen>:

uint
strlen(char *s)
{
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
 1f0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1fa:	eb 04                	jmp    200 <strlen+0x13>
 1fc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 200:	8b 55 fc             	mov    -0x4(%ebp),%edx
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	01 d0                	add    %edx,%eax
 208:	0f b6 00             	movzbl (%eax),%eax
 20b:	84 c0                	test   %al,%al
 20d:	75 ed                	jne    1fc <strlen+0xf>
    ;
  return n;
 20f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 212:	c9                   	leave  
 213:	c3                   	ret    

00000214 <memset>:

void*
memset(void *dst, int c, uint n)
{
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 21a:	8b 45 10             	mov    0x10(%ebp),%eax
 21d:	89 44 24 08          	mov    %eax,0x8(%esp)
 221:	8b 45 0c             	mov    0xc(%ebp),%eax
 224:	89 44 24 04          	mov    %eax,0x4(%esp)
 228:	8b 45 08             	mov    0x8(%ebp),%eax
 22b:	89 04 24             	mov    %eax,(%esp)
 22e:	e8 26 ff ff ff       	call   159 <stosb>
  return dst;
 233:	8b 45 08             	mov    0x8(%ebp),%eax
}
 236:	c9                   	leave  
 237:	c3                   	ret    

00000238 <strchr>:

char*
strchr(const char *s, char c)
{
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	83 ec 04             	sub    $0x4,%esp
 23e:	8b 45 0c             	mov    0xc(%ebp),%eax
 241:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 244:	eb 14                	jmp    25a <strchr+0x22>
    if(*s == c)
 246:	8b 45 08             	mov    0x8(%ebp),%eax
 249:	0f b6 00             	movzbl (%eax),%eax
 24c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 24f:	75 05                	jne    256 <strchr+0x1e>
      return (char*)s;
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	eb 13                	jmp    269 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 256:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 25a:	8b 45 08             	mov    0x8(%ebp),%eax
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	84 c0                	test   %al,%al
 262:	75 e2                	jne    246 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 264:	b8 00 00 00 00       	mov    $0x0,%eax
}
 269:	c9                   	leave  
 26a:	c3                   	ret    

0000026b <gets>:

char*
gets(char *buf, int max)
{
 26b:	55                   	push   %ebp
 26c:	89 e5                	mov    %esp,%ebp
 26e:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 271:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 278:	eb 4c                	jmp    2c6 <gets+0x5b>
    cc = read(0, &c, 1);
 27a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 281:	00 
 282:	8d 45 ef             	lea    -0x11(%ebp),%eax
 285:	89 44 24 04          	mov    %eax,0x4(%esp)
 289:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 290:	e8 44 01 00 00       	call   3d9 <read>
 295:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 298:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 29c:	7f 02                	jg     2a0 <gets+0x35>
      break;
 29e:	eb 31                	jmp    2d1 <gets+0x66>
    buf[i++] = c;
 2a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a3:	8d 50 01             	lea    0x1(%eax),%edx
 2a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2a9:	89 c2                	mov    %eax,%edx
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	01 c2                	add    %eax,%edx
 2b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ba:	3c 0a                	cmp    $0xa,%al
 2bc:	74 13                	je     2d1 <gets+0x66>
 2be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2c2:	3c 0d                	cmp    $0xd,%al
 2c4:	74 0b                	je     2d1 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c9:	83 c0 01             	add    $0x1,%eax
 2cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2cf:	7c a9                	jl     27a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	01 d0                	add    %edx,%eax
 2d9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2df:	c9                   	leave  
 2e0:	c3                   	ret    

000002e1 <stat>:

int
stat(char *n, struct stat *st)
{
 2e1:	55                   	push   %ebp
 2e2:	89 e5                	mov    %esp,%ebp
 2e4:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2ee:	00 
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	89 04 24             	mov    %eax,(%esp)
 2f5:	e8 07 01 00 00       	call   401 <open>
 2fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 301:	79 07                	jns    30a <stat+0x29>
    return -1;
 303:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 308:	eb 23                	jmp    32d <stat+0x4c>
  r = fstat(fd, st);
 30a:	8b 45 0c             	mov    0xc(%ebp),%eax
 30d:	89 44 24 04          	mov    %eax,0x4(%esp)
 311:	8b 45 f4             	mov    -0xc(%ebp),%eax
 314:	89 04 24             	mov    %eax,(%esp)
 317:	e8 fd 00 00 00       	call   419 <fstat>
 31c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 31f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 322:	89 04 24             	mov    %eax,(%esp)
 325:	e8 bf 00 00 00       	call   3e9 <close>
  return r;
 32a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 32d:	c9                   	leave  
 32e:	c3                   	ret    

0000032f <atoi>:

int
atoi(const char *s)
{
 32f:	55                   	push   %ebp
 330:	89 e5                	mov    %esp,%ebp
 332:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 335:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 33c:	eb 25                	jmp    363 <atoi+0x34>
    n = n*10 + *s++ - '0';
 33e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 341:	89 d0                	mov    %edx,%eax
 343:	c1 e0 02             	shl    $0x2,%eax
 346:	01 d0                	add    %edx,%eax
 348:	01 c0                	add    %eax,%eax
 34a:	89 c1                	mov    %eax,%ecx
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	8d 50 01             	lea    0x1(%eax),%edx
 352:	89 55 08             	mov    %edx,0x8(%ebp)
 355:	0f b6 00             	movzbl (%eax),%eax
 358:	0f be c0             	movsbl %al,%eax
 35b:	01 c8                	add    %ecx,%eax
 35d:	83 e8 30             	sub    $0x30,%eax
 360:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	0f b6 00             	movzbl (%eax),%eax
 369:	3c 2f                	cmp    $0x2f,%al
 36b:	7e 0a                	jle    377 <atoi+0x48>
 36d:	8b 45 08             	mov    0x8(%ebp),%eax
 370:	0f b6 00             	movzbl (%eax),%eax
 373:	3c 39                	cmp    $0x39,%al
 375:	7e c7                	jle    33e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 377:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 37a:	c9                   	leave  
 37b:	c3                   	ret    

0000037c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 37c:	55                   	push   %ebp
 37d:	89 e5                	mov    %esp,%ebp
 37f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 388:	8b 45 0c             	mov    0xc(%ebp),%eax
 38b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 38e:	eb 17                	jmp    3a7 <memmove+0x2b>
    *dst++ = *src++;
 390:	8b 45 fc             	mov    -0x4(%ebp),%eax
 393:	8d 50 01             	lea    0x1(%eax),%edx
 396:	89 55 fc             	mov    %edx,-0x4(%ebp)
 399:	8b 55 f8             	mov    -0x8(%ebp),%edx
 39c:	8d 4a 01             	lea    0x1(%edx),%ecx
 39f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3a2:	0f b6 12             	movzbl (%edx),%edx
 3a5:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3a7:	8b 45 10             	mov    0x10(%ebp),%eax
 3aa:	8d 50 ff             	lea    -0x1(%eax),%edx
 3ad:	89 55 10             	mov    %edx,0x10(%ebp)
 3b0:	85 c0                	test   %eax,%eax
 3b2:	7f dc                	jg     390 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3b4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3b7:	c9                   	leave  
 3b8:	c3                   	ret    

000003b9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3b9:	b8 01 00 00 00       	mov    $0x1,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <exit>:
SYSCALL(exit)
 3c1:	b8 02 00 00 00       	mov    $0x2,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <wait>:
SYSCALL(wait)
 3c9:	b8 03 00 00 00       	mov    $0x3,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <pipe>:
SYSCALL(pipe)
 3d1:	b8 04 00 00 00       	mov    $0x4,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <read>:
SYSCALL(read)
 3d9:	b8 05 00 00 00       	mov    $0x5,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <write>:
SYSCALL(write)
 3e1:	b8 10 00 00 00       	mov    $0x10,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <close>:
SYSCALL(close)
 3e9:	b8 15 00 00 00       	mov    $0x15,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <kill>:
SYSCALL(kill)
 3f1:	b8 06 00 00 00       	mov    $0x6,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <exec>:
SYSCALL(exec)
 3f9:	b8 07 00 00 00       	mov    $0x7,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <open>:
SYSCALL(open)
 401:	b8 0f 00 00 00       	mov    $0xf,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <mknod>:
SYSCALL(mknod)
 409:	b8 11 00 00 00       	mov    $0x11,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <unlink>:
SYSCALL(unlink)
 411:	b8 12 00 00 00       	mov    $0x12,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <fstat>:
SYSCALL(fstat)
 419:	b8 08 00 00 00       	mov    $0x8,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <link>:
SYSCALL(link)
 421:	b8 13 00 00 00       	mov    $0x13,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <mkdir>:
SYSCALL(mkdir)
 429:	b8 14 00 00 00       	mov    $0x14,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <chdir>:
SYSCALL(chdir)
 431:	b8 09 00 00 00       	mov    $0x9,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <dup>:
SYSCALL(dup)
 439:	b8 0a 00 00 00       	mov    $0xa,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <getpid>:
SYSCALL(getpid)
 441:	b8 0b 00 00 00       	mov    $0xb,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <sbrk>:
SYSCALL(sbrk)
 449:	b8 0c 00 00 00       	mov    $0xc,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <sleep>:
SYSCALL(sleep)
 451:	b8 0d 00 00 00       	mov    $0xd,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <uptime>:
SYSCALL(uptime)
 459:	b8 0e 00 00 00       	mov    $0xe,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <kthread_create>:
SYSCALL(kthread_create)
 461:	b8 17 00 00 00       	mov    $0x17,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <kthread_join>:
SYSCALL(kthread_join)
 469:	b8 16 00 00 00       	mov    $0x16,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 471:	b8 18 00 00 00       	mov    $0x18,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 479:	b8 19 00 00 00       	mov    $0x19,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 481:	b8 1a 00 00 00       	mov    $0x1a,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 489:	b8 1b 00 00 00       	mov    $0x1b,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 491:	b8 1c 00 00 00       	mov    $0x1c,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 499:	b8 1d 00 00 00       	mov    $0x1d,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 4a1:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 4a9:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <kthread_cond_broadcast>:
 4b1:	b8 20 00 00 00       	mov    $0x20,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4b9:	55                   	push   %ebp
 4ba:	89 e5                	mov    %esp,%ebp
 4bc:	83 ec 18             	sub    $0x18,%esp
 4bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4c5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cc:	00 
 4cd:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d4:	8b 45 08             	mov    0x8(%ebp),%eax
 4d7:	89 04 24             	mov    %eax,(%esp)
 4da:	e8 02 ff ff ff       	call   3e1 <write>
}
 4df:	c9                   	leave  
 4e0:	c3                   	ret    

000004e1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e1:	55                   	push   %ebp
 4e2:	89 e5                	mov    %esp,%ebp
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4f0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4f4:	74 17                	je     50d <printint+0x2c>
 4f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4fa:	79 11                	jns    50d <printint+0x2c>
    neg = 1;
 4fc:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 503:	8b 45 0c             	mov    0xc(%ebp),%eax
 506:	f7 d8                	neg    %eax
 508:	89 45 ec             	mov    %eax,-0x14(%ebp)
 50b:	eb 06                	jmp    513 <printint+0x32>
  } else {
    x = xx;
 50d:	8b 45 0c             	mov    0xc(%ebp),%eax
 510:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 513:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 51a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 51d:	8d 41 01             	lea    0x1(%ecx),%eax
 520:	89 45 f4             	mov    %eax,-0xc(%ebp)
 523:	8b 5d 10             	mov    0x10(%ebp),%ebx
 526:	8b 45 ec             	mov    -0x14(%ebp),%eax
 529:	ba 00 00 00 00       	mov    $0x0,%edx
 52e:	f7 f3                	div    %ebx
 530:	89 d0                	mov    %edx,%eax
 532:	0f b6 80 14 0f 00 00 	movzbl 0xf14(%eax),%eax
 539:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 53d:	8b 75 10             	mov    0x10(%ebp),%esi
 540:	8b 45 ec             	mov    -0x14(%ebp),%eax
 543:	ba 00 00 00 00       	mov    $0x0,%edx
 548:	f7 f6                	div    %esi
 54a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 54d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 551:	75 c7                	jne    51a <printint+0x39>
  if(neg)
 553:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 557:	74 10                	je     569 <printint+0x88>
    buf[i++] = '-';
 559:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55c:	8d 50 01             	lea    0x1(%eax),%edx
 55f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 562:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 567:	eb 1f                	jmp    588 <printint+0xa7>
 569:	eb 1d                	jmp    588 <printint+0xa7>
    putc(fd, buf[i]);
 56b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 56e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 571:	01 d0                	add    %edx,%eax
 573:	0f b6 00             	movzbl (%eax),%eax
 576:	0f be c0             	movsbl %al,%eax
 579:	89 44 24 04          	mov    %eax,0x4(%esp)
 57d:	8b 45 08             	mov    0x8(%ebp),%eax
 580:	89 04 24             	mov    %eax,(%esp)
 583:	e8 31 ff ff ff       	call   4b9 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 588:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 58c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 590:	79 d9                	jns    56b <printint+0x8a>
    putc(fd, buf[i]);
}
 592:	83 c4 30             	add    $0x30,%esp
 595:	5b                   	pop    %ebx
 596:	5e                   	pop    %esi
 597:	5d                   	pop    %ebp
 598:	c3                   	ret    

00000599 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 599:	55                   	push   %ebp
 59a:	89 e5                	mov    %esp,%ebp
 59c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 59f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5a6:	8d 45 0c             	lea    0xc(%ebp),%eax
 5a9:	83 c0 04             	add    $0x4,%eax
 5ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5b6:	e9 7c 01 00 00       	jmp    737 <printf+0x19e>
    c = fmt[i] & 0xff;
 5bb:	8b 55 0c             	mov    0xc(%ebp),%edx
 5be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c1:	01 d0                	add    %edx,%eax
 5c3:	0f b6 00             	movzbl (%eax),%eax
 5c6:	0f be c0             	movsbl %al,%eax
 5c9:	25 ff 00 00 00       	and    $0xff,%eax
 5ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5d5:	75 2c                	jne    603 <printf+0x6a>
      if(c == '%'){
 5d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5db:	75 0c                	jne    5e9 <printf+0x50>
        state = '%';
 5dd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5e4:	e9 4a 01 00 00       	jmp    733 <printf+0x19a>
      } else {
        putc(fd, c);
 5e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ec:	0f be c0             	movsbl %al,%eax
 5ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	89 04 24             	mov    %eax,(%esp)
 5f9:	e8 bb fe ff ff       	call   4b9 <putc>
 5fe:	e9 30 01 00 00       	jmp    733 <printf+0x19a>
      }
    } else if(state == '%'){
 603:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 607:	0f 85 26 01 00 00    	jne    733 <printf+0x19a>
      if(c == 'd'){
 60d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 611:	75 2d                	jne    640 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 613:	8b 45 e8             	mov    -0x18(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 61f:	00 
 620:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 627:	00 
 628:	89 44 24 04          	mov    %eax,0x4(%esp)
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	89 04 24             	mov    %eax,(%esp)
 632:	e8 aa fe ff ff       	call   4e1 <printint>
        ap++;
 637:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 63b:	e9 ec 00 00 00       	jmp    72c <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 640:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 644:	74 06                	je     64c <printf+0xb3>
 646:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 64a:	75 2d                	jne    679 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 64c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64f:	8b 00                	mov    (%eax),%eax
 651:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 658:	00 
 659:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 660:	00 
 661:	89 44 24 04          	mov    %eax,0x4(%esp)
 665:	8b 45 08             	mov    0x8(%ebp),%eax
 668:	89 04 24             	mov    %eax,(%esp)
 66b:	e8 71 fe ff ff       	call   4e1 <printint>
        ap++;
 670:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 674:	e9 b3 00 00 00       	jmp    72c <printf+0x193>
      } else if(c == 's'){
 679:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 67d:	75 45                	jne    6c4 <printf+0x12b>
        s = (char*)*ap;
 67f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 687:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 68b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 68f:	75 09                	jne    69a <printf+0x101>
          s = "(null)";
 691:	c7 45 f4 e1 0a 00 00 	movl   $0xae1,-0xc(%ebp)
        while(*s != 0){
 698:	eb 1e                	jmp    6b8 <printf+0x11f>
 69a:	eb 1c                	jmp    6b8 <printf+0x11f>
          putc(fd, *s);
 69c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 69f:	0f b6 00             	movzbl (%eax),%eax
 6a2:	0f be c0             	movsbl %al,%eax
 6a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ac:	89 04 24             	mov    %eax,(%esp)
 6af:	e8 05 fe ff ff       	call   4b9 <putc>
          s++;
 6b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6bb:	0f b6 00             	movzbl (%eax),%eax
 6be:	84 c0                	test   %al,%al
 6c0:	75 da                	jne    69c <printf+0x103>
 6c2:	eb 68                	jmp    72c <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6c4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6c8:	75 1d                	jne    6e7 <printf+0x14e>
        putc(fd, *ap);
 6ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6cd:	8b 00                	mov    (%eax),%eax
 6cf:	0f be c0             	movsbl %al,%eax
 6d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d6:	8b 45 08             	mov    0x8(%ebp),%eax
 6d9:	89 04 24             	mov    %eax,(%esp)
 6dc:	e8 d8 fd ff ff       	call   4b9 <putc>
        ap++;
 6e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6e5:	eb 45                	jmp    72c <printf+0x193>
      } else if(c == '%'){
 6e7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6eb:	75 17                	jne    704 <printf+0x16b>
        putc(fd, c);
 6ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6f0:	0f be c0             	movsbl %al,%eax
 6f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f7:	8b 45 08             	mov    0x8(%ebp),%eax
 6fa:	89 04 24             	mov    %eax,(%esp)
 6fd:	e8 b7 fd ff ff       	call   4b9 <putc>
 702:	eb 28                	jmp    72c <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 704:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 70b:	00 
 70c:	8b 45 08             	mov    0x8(%ebp),%eax
 70f:	89 04 24             	mov    %eax,(%esp)
 712:	e8 a2 fd ff ff       	call   4b9 <putc>
        putc(fd, c);
 717:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71a:	0f be c0             	movsbl %al,%eax
 71d:	89 44 24 04          	mov    %eax,0x4(%esp)
 721:	8b 45 08             	mov    0x8(%ebp),%eax
 724:	89 04 24             	mov    %eax,(%esp)
 727:	e8 8d fd ff ff       	call   4b9 <putc>
      }
      state = 0;
 72c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 733:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 737:	8b 55 0c             	mov    0xc(%ebp),%edx
 73a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73d:	01 d0                	add    %edx,%eax
 73f:	0f b6 00             	movzbl (%eax),%eax
 742:	84 c0                	test   %al,%al
 744:	0f 85 71 fe ff ff    	jne    5bb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 74a:	c9                   	leave  
 74b:	c3                   	ret    

0000074c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 74c:	55                   	push   %ebp
 74d:	89 e5                	mov    %esp,%ebp
 74f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 752:	8b 45 08             	mov    0x8(%ebp),%eax
 755:	83 e8 08             	sub    $0x8,%eax
 758:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75b:	a1 34 0f 00 00       	mov    0xf34,%eax
 760:	89 45 fc             	mov    %eax,-0x4(%ebp)
 763:	eb 24                	jmp    789 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	8b 00                	mov    (%eax),%eax
 76a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 76d:	77 12                	ja     781 <free+0x35>
 76f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 775:	77 24                	ja     79b <free+0x4f>
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 00                	mov    (%eax),%eax
 77c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 77f:	77 1a                	ja     79b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	8b 00                	mov    (%eax),%eax
 786:	89 45 fc             	mov    %eax,-0x4(%ebp)
 789:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 78f:	76 d4                	jbe    765 <free+0x19>
 791:	8b 45 fc             	mov    -0x4(%ebp),%eax
 794:	8b 00                	mov    (%eax),%eax
 796:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 799:	76 ca                	jbe    765 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 79b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79e:	8b 40 04             	mov    0x4(%eax),%eax
 7a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ab:	01 c2                	add    %eax,%edx
 7ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b0:	8b 00                	mov    (%eax),%eax
 7b2:	39 c2                	cmp    %eax,%edx
 7b4:	75 24                	jne    7da <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b9:	8b 50 04             	mov    0x4(%eax),%edx
 7bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bf:	8b 00                	mov    (%eax),%eax
 7c1:	8b 40 04             	mov    0x4(%eax),%eax
 7c4:	01 c2                	add    %eax,%edx
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cf:	8b 00                	mov    (%eax),%eax
 7d1:	8b 10                	mov    (%eax),%edx
 7d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d6:	89 10                	mov    %edx,(%eax)
 7d8:	eb 0a                	jmp    7e4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dd:	8b 10                	mov    (%eax),%edx
 7df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e7:	8b 40 04             	mov    0x4(%eax),%eax
 7ea:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	01 d0                	add    %edx,%eax
 7f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f9:	75 20                	jne    81b <free+0xcf>
    p->s.size += bp->s.size;
 7fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fe:	8b 50 04             	mov    0x4(%eax),%edx
 801:	8b 45 f8             	mov    -0x8(%ebp),%eax
 804:	8b 40 04             	mov    0x4(%eax),%eax
 807:	01 c2                	add    %eax,%edx
 809:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 812:	8b 10                	mov    (%eax),%edx
 814:	8b 45 fc             	mov    -0x4(%ebp),%eax
 817:	89 10                	mov    %edx,(%eax)
 819:	eb 08                	jmp    823 <free+0xd7>
  } else
    p->s.ptr = bp;
 81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 821:	89 10                	mov    %edx,(%eax)
  freep = p;
 823:	8b 45 fc             	mov    -0x4(%ebp),%eax
 826:	a3 34 0f 00 00       	mov    %eax,0xf34
}
 82b:	c9                   	leave  
 82c:	c3                   	ret    

0000082d <morecore>:

static Header*
morecore(uint nu)
{
 82d:	55                   	push   %ebp
 82e:	89 e5                	mov    %esp,%ebp
 830:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 833:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 83a:	77 07                	ja     843 <morecore+0x16>
    nu = 4096;
 83c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 843:	8b 45 08             	mov    0x8(%ebp),%eax
 846:	c1 e0 03             	shl    $0x3,%eax
 849:	89 04 24             	mov    %eax,(%esp)
 84c:	e8 f8 fb ff ff       	call   449 <sbrk>
 851:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 854:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 858:	75 07                	jne    861 <morecore+0x34>
    return 0;
 85a:	b8 00 00 00 00       	mov    $0x0,%eax
 85f:	eb 22                	jmp    883 <morecore+0x56>
  hp = (Header*)p;
 861:	8b 45 f4             	mov    -0xc(%ebp),%eax
 864:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 867:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86a:	8b 55 08             	mov    0x8(%ebp),%edx
 86d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 870:	8b 45 f0             	mov    -0x10(%ebp),%eax
 873:	83 c0 08             	add    $0x8,%eax
 876:	89 04 24             	mov    %eax,(%esp)
 879:	e8 ce fe ff ff       	call   74c <free>
  return freep;
 87e:	a1 34 0f 00 00       	mov    0xf34,%eax
}
 883:	c9                   	leave  
 884:	c3                   	ret    

00000885 <malloc>:

void*
malloc(uint nbytes)
{
 885:	55                   	push   %ebp
 886:	89 e5                	mov    %esp,%ebp
 888:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88b:	8b 45 08             	mov    0x8(%ebp),%eax
 88e:	83 c0 07             	add    $0x7,%eax
 891:	c1 e8 03             	shr    $0x3,%eax
 894:	83 c0 01             	add    $0x1,%eax
 897:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 89a:	a1 34 0f 00 00       	mov    0xf34,%eax
 89f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8a6:	75 23                	jne    8cb <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8a8:	c7 45 f0 2c 0f 00 00 	movl   $0xf2c,-0x10(%ebp)
 8af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b2:	a3 34 0f 00 00       	mov    %eax,0xf34
 8b7:	a1 34 0f 00 00       	mov    0xf34,%eax
 8bc:	a3 2c 0f 00 00       	mov    %eax,0xf2c
    base.s.size = 0;
 8c1:	c7 05 30 0f 00 00 00 	movl   $0x0,0xf30
 8c8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d6:	8b 40 04             	mov    0x4(%eax),%eax
 8d9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8dc:	72 4d                	jb     92b <malloc+0xa6>
      if(p->s.size == nunits)
 8de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e1:	8b 40 04             	mov    0x4(%eax),%eax
 8e4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8e7:	75 0c                	jne    8f5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ec:	8b 10                	mov    (%eax),%edx
 8ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f1:	89 10                	mov    %edx,(%eax)
 8f3:	eb 26                	jmp    91b <malloc+0x96>
      else {
        p->s.size -= nunits;
 8f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f8:	8b 40 04             	mov    0x4(%eax),%eax
 8fb:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8fe:	89 c2                	mov    %eax,%edx
 900:	8b 45 f4             	mov    -0xc(%ebp),%eax
 903:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 906:	8b 45 f4             	mov    -0xc(%ebp),%eax
 909:	8b 40 04             	mov    0x4(%eax),%eax
 90c:	c1 e0 03             	shl    $0x3,%eax
 90f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 912:	8b 45 f4             	mov    -0xc(%ebp),%eax
 915:	8b 55 ec             	mov    -0x14(%ebp),%edx
 918:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 91b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91e:	a3 34 0f 00 00       	mov    %eax,0xf34
      return (void*)(p + 1);
 923:	8b 45 f4             	mov    -0xc(%ebp),%eax
 926:	83 c0 08             	add    $0x8,%eax
 929:	eb 38                	jmp    963 <malloc+0xde>
    }
    if(p == freep)
 92b:	a1 34 0f 00 00       	mov    0xf34,%eax
 930:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 933:	75 1b                	jne    950 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 935:	8b 45 ec             	mov    -0x14(%ebp),%eax
 938:	89 04 24             	mov    %eax,(%esp)
 93b:	e8 ed fe ff ff       	call   82d <morecore>
 940:	89 45 f4             	mov    %eax,-0xc(%ebp)
 943:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 947:	75 07                	jne    950 <malloc+0xcb>
        return 0;
 949:	b8 00 00 00 00       	mov    $0x0,%eax
 94e:	eb 13                	jmp    963 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	8b 45 f4             	mov    -0xc(%ebp),%eax
 953:	89 45 f0             	mov    %eax,-0x10(%ebp)
 956:	8b 45 f4             	mov    -0xc(%ebp),%eax
 959:	8b 00                	mov    (%eax),%eax
 95b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 95e:	e9 70 ff ff ff       	jmp    8d3 <malloc+0x4e>
}
 963:	c9                   	leave  
 964:	c3                   	ret    

00000965 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 965:	55                   	push   %ebp
 966:	89 e5                	mov    %esp,%ebp
 968:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 96b:	8b 45 0c             	mov    0xc(%ebp),%eax
 96e:	89 04 24             	mov    %eax,(%esp)
 971:	8b 45 08             	mov    0x8(%ebp),%eax
 974:	ff d0                	call   *%eax
    exit();
 976:	e8 46 fa ff ff       	call   3c1 <exit>

0000097b <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 97b:	55                   	push   %ebp
 97c:	89 e5                	mov    %esp,%ebp
 97e:	57                   	push   %edi
 97f:	56                   	push   %esi
 980:	53                   	push   %ebx
 981:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 984:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 98b:	e8 f5 fe ff ff       	call   885 <malloc>
 990:	8b 55 08             	mov    0x8(%ebp),%edx
 993:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 995:	8b 45 10             	mov    0x10(%ebp),%eax
 998:	8b 38                	mov    (%eax),%edi
 99a:	8b 75 0c             	mov    0xc(%ebp),%esi
 99d:	bb 65 09 00 00       	mov    $0x965,%ebx
 9a2:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9a9:	e8 d7 fe ff ff       	call   885 <malloc>
 9ae:	05 00 10 00 00       	add    $0x1000,%eax
 9b3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 9b7:	89 74 24 08          	mov    %esi,0x8(%esp)
 9bb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 9bf:	89 04 24             	mov    %eax,(%esp)
 9c2:	e8 9a fa ff ff       	call   461 <kthread_create>
 9c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 9ca:	8b 45 08             	mov    0x8(%ebp),%eax
 9cd:	8b 00                	mov    (%eax),%eax
 9cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 9d2:	89 10                	mov    %edx,(%eax)
    return t_id;
 9d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 9d7:	83 c4 2c             	add    $0x2c,%esp
 9da:	5b                   	pop    %ebx
 9db:	5e                   	pop    %esi
 9dc:	5f                   	pop    %edi
 9dd:	5d                   	pop    %ebp
 9de:	c3                   	ret    

000009df <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 9df:	55                   	push   %ebp
 9e0:	89 e5                	mov    %esp,%ebp
 9e2:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 9e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 9e8:	8b 45 08             	mov    0x8(%ebp),%eax
 9eb:	8b 00                	mov    (%eax),%eax
 9ed:	89 54 24 04          	mov    %edx,0x4(%esp)
 9f1:	89 04 24             	mov    %eax,(%esp)
 9f4:	e8 70 fa ff ff       	call   469 <kthread_join>
 9f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9ff:	c9                   	leave  
 a00:	c3                   	ret    

00000a01 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 a01:	55                   	push   %ebp
 a02:	89 e5                	mov    %esp,%ebp
 a04:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 a07:	e8 65 fa ff ff       	call   471 <kthread_mutex_init>
 a0c:	8b 55 08             	mov    0x8(%ebp),%edx
 a0f:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a11:	8b 45 08             	mov    0x8(%ebp),%eax
 a14:	8b 00                	mov    (%eax),%eax
 a16:	85 c0                	test   %eax,%eax
 a18:	7e 07                	jle    a21 <qthread_mutex_init+0x20>
		return 0;
 a1a:	b8 00 00 00 00       	mov    $0x0,%eax
 a1f:	eb 05                	jmp    a26 <qthread_mutex_init+0x25>
	}
	return *mutex;
 a21:	8b 45 08             	mov    0x8(%ebp),%eax
 a24:	8b 00                	mov    (%eax),%eax
}
 a26:	c9                   	leave  
 a27:	c3                   	ret    

00000a28 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 a28:	55                   	push   %ebp
 a29:	89 e5                	mov    %esp,%ebp
 a2b:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 a2e:	8b 45 08             	mov    0x8(%ebp),%eax
 a31:	89 04 24             	mov    %eax,(%esp)
 a34:	e8 40 fa ff ff       	call   479 <kthread_mutex_destroy>
 a39:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a40:	79 07                	jns    a49 <qthread_mutex_destroy+0x21>
    	return -1;
 a42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a47:	eb 05                	jmp    a4e <qthread_mutex_destroy+0x26>
    }
    return 0;
 a49:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a4e:	c9                   	leave  
 a4f:	c3                   	ret    

00000a50 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 a56:	8b 45 08             	mov    0x8(%ebp),%eax
 a59:	89 04 24             	mov    %eax,(%esp)
 a5c:	e8 20 fa ff ff       	call   481 <kthread_mutex_lock>
 a61:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a64:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a68:	79 07                	jns    a71 <qthread_mutex_lock+0x21>
    	return -1;
 a6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a6f:	eb 05                	jmp    a76 <qthread_mutex_lock+0x26>
    }
    return 0;
 a71:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a76:	c9                   	leave  
 a77:	c3                   	ret    

00000a78 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a78:	55                   	push   %ebp
 a79:	89 e5                	mov    %esp,%ebp
 a7b:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a7e:	8b 45 08             	mov    0x8(%ebp),%eax
 a81:	89 04 24             	mov    %eax,(%esp)
 a84:	e8 00 fa ff ff       	call   489 <kthread_mutex_unlock>
 a89:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a8c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a90:	79 07                	jns    a99 <qthread_mutex_unlock+0x21>
    	return -1;
 a92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a97:	eb 05                	jmp    a9e <qthread_mutex_unlock+0x26>
    }
    return 0;
 a99:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a9e:	c9                   	leave  
 a9f:	c3                   	ret    

00000aa0 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp

	return 0;
 aa3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aa8:	5d                   	pop    %ebp
 aa9:	c3                   	ret    

00000aaa <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 aaa:	55                   	push   %ebp
 aab:	89 e5                	mov    %esp,%ebp
    
    return 0;
 aad:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ab2:	5d                   	pop    %ebp
 ab3:	c3                   	ret    

00000ab4 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 ab4:	55                   	push   %ebp
 ab5:	89 e5                	mov    %esp,%ebp
    
    return 0;
 ab7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 abc:	5d                   	pop    %ebp
 abd:	c3                   	ret    

00000abe <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 abe:	55                   	push   %ebp
 abf:	89 e5                	mov    %esp,%ebp
	return 0;
 ac1:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 ac6:	5d                   	pop    %ebp
 ac7:	c3                   	ret    

00000ac8 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 ac8:	55                   	push   %ebp
 ac9:	89 e5                	mov    %esp,%ebp
	return 0;
 acb:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 ad0:	5d                   	pop    %ebp
 ad1:	c3                   	ret    
