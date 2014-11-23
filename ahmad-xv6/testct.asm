
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
   6:	c7 04 24 4c 0f 00 00 	movl   $0xf4c,(%esp)
   d:	e8 e0 09 00 00       	call   9f2 <qthread_mutex_init>

	int i,j;

    
	for(i = 0; i < MAX_THREADS; i++){
  12:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  19:	eb 58                	jmp    73 <test1+0x73>
        	int tid = qthread_create(&t[i], f2, (void*)&i);
  1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  1e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  25:	8d 45 cc             	lea    -0x34(%ebp),%eax
  28:	01 c2                	add    %eax,%edx
  2a:	8d 45 c8             	lea    -0x38(%ebp),%eax
  2d:	89 44 24 08          	mov    %eax,0x8(%esp)
  31:	c7 44 24 04 1b 01 00 	movl   $0x11b,0x4(%esp)
  38:	00 
  39:	89 14 24             	mov    %edx,(%esp)
  3c:	e8 31 09 00 00       	call   972 <qthread_create>
  41:	89 45 f4             	mov    %eax,-0xc(%ebp)
        	//printf(1, "[%d : %d]\n", tid, t[i]->tid);
            printf(1, "[%d : %d]\n", tid, t[i]);
  44:	8b 45 c8             	mov    -0x38(%ebp),%eax
  47:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  52:	89 44 24 08          	mov    %eax,0x8(%esp)
  56:	c7 44 24 04 cd 0a 00 	movl   $0xacd,0x4(%esp)
  5d:	00 
  5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  65:	e8 2d 05 00 00       	call   597 <printf>
    qthread_mutex_init(&m);

	int i,j;

    
	for(i = 0; i < MAX_THREADS; i++){
  6a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  6d:	83 c0 01             	add    $0x1,%eax
  70:	89 45 c8             	mov    %eax,-0x38(%ebp)
  73:	8b 45 c8             	mov    -0x38(%ebp),%eax
  76:	83 f8 09             	cmp    $0x9,%eax
  79:	7e a0                	jle    1b <test1+0x1b>
        	int tid = qthread_create(&t[i], f2, (void*)&i);
        	//printf(1, "[%d : %d]\n", tid, t[i]->tid);
            printf(1, "[%d : %d]\n", tid, t[i]);
	}

	for (i = 0; i < MAX_THREADS; i++){
  7b:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  82:	eb 28                	jmp    ac <test1+0xac>
        	//printf(1, "%d\n", t[i]->tid);
            printf(1, "%d\n", t[i]);
  84:	8b 45 c8             	mov    -0x38(%ebp),%eax
  87:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  8b:	89 44 24 08          	mov    %eax,0x8(%esp)
  8f:	c7 44 24 04 d8 0a 00 	movl   $0xad8,0x4(%esp)
  96:	00 
  97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9e:	e8 f4 04 00 00       	call   597 <printf>
        	int tid = qthread_create(&t[i], f2, (void*)&i);
        	//printf(1, "[%d : %d]\n", tid, t[i]->tid);
            printf(1, "[%d : %d]\n", tid, t[i]);
	}

	for (i = 0; i < MAX_THREADS; i++){
  a3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  a6:	83 c0 01             	add    $0x1,%eax
  a9:	89 45 c8             	mov    %eax,-0x38(%ebp)
  ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
  af:	83 f8 09             	cmp    $0x9,%eax
  b2:	7e d0                	jle    84 <test1+0x84>
        	//printf(1, "%d\n", t[i]->tid);
            printf(1, "%d\n", t[i]);
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
  ce:	e8 ff 08 00 00       	call   9d2 <qthread_join>
	for (i = 0; i < MAX_THREADS; i++){
        	//printf(1, "%d\n", t[i]->tid);
            printf(1, "%d\n", t[i]);
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
  e4:	a1 3c 0f 00 00       	mov    0xf3c,%eax
  e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ed:	c7 44 24 04 d8 0a 00 	movl   $0xad8,0x4(%esp)
  f4:	00 
  f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fc:	e8 96 04 00 00       	call   597 <printf>
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
 10e:	e8 ad 02 00 00       	call   3c0 <exit>

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
 121:	c7 04 24 4c 0f 00 00 	movl   $0xf4c,(%esp)
 128:	e8 14 09 00 00       	call   a41 <qthread_mutex_lock>
    mvar++;
 12d:	a1 3c 0f 00 00       	mov    0xf3c,%eax
 132:	83 c0 01             	add    $0x1,%eax
 135:	a3 3c 0f 00 00       	mov    %eax,0xf3c
    sleep(1);
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	e8 0a 03 00 00       	call   450 <sleep>
    qthread_mutex_unlock(&m);
 146:	c7 04 24 4c 0f 00 00 	movl   $0xf4c,(%esp)
 14d:	e8 17 09 00 00       	call   a69 <qthread_mutex_unlock>

    return 0;
 152:	b8 00 00 00 00       	mov    $0x0,%eax
}
 157:	c9                   	leave  
 158:	c3                   	ret    
 159:	90                   	nop
 15a:	90                   	nop
 15b:	90                   	nop

0000015c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	57                   	push   %edi
 160:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 161:	8b 4d 08             	mov    0x8(%ebp),%ecx
 164:	8b 55 10             	mov    0x10(%ebp),%edx
 167:	8b 45 0c             	mov    0xc(%ebp),%eax
 16a:	89 cb                	mov    %ecx,%ebx
 16c:	89 df                	mov    %ebx,%edi
 16e:	89 d1                	mov    %edx,%ecx
 170:	fc                   	cld    
 171:	f3 aa                	rep stos %al,%es:(%edi)
 173:	89 ca                	mov    %ecx,%edx
 175:	89 fb                	mov    %edi,%ebx
 177:	89 5d 08             	mov    %ebx,0x8(%ebp)
 17a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 17d:	5b                   	pop    %ebx
 17e:	5f                   	pop    %edi
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    

00000181 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 18d:	90                   	nop
 18e:	8b 45 0c             	mov    0xc(%ebp),%eax
 191:	0f b6 10             	movzbl (%eax),%edx
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	88 10                	mov    %dl,(%eax)
 199:	8b 45 08             	mov    0x8(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	84 c0                	test   %al,%al
 1a1:	0f 95 c0             	setne  %al
 1a4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 1ac:	84 c0                	test   %al,%al
 1ae:	75 de                	jne    18e <strcpy+0xd>
    ;
  return os;
 1b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1b3:	c9                   	leave  
 1b4:	c3                   	ret    

000001b5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b5:	55                   	push   %ebp
 1b6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1b8:	eb 08                	jmp    1c2 <strcmp+0xd>
    p++, q++;
 1ba:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1be:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c2:	8b 45 08             	mov    0x8(%ebp),%eax
 1c5:	0f b6 00             	movzbl (%eax),%eax
 1c8:	84 c0                	test   %al,%al
 1ca:	74 10                	je     1dc <strcmp+0x27>
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	0f b6 10             	movzbl (%eax),%edx
 1d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d5:	0f b6 00             	movzbl (%eax),%eax
 1d8:	38 c2                	cmp    %al,%dl
 1da:	74 de                	je     1ba <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
 1df:	0f b6 00             	movzbl (%eax),%eax
 1e2:	0f b6 d0             	movzbl %al,%edx
 1e5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e8:	0f b6 00             	movzbl (%eax),%eax
 1eb:	0f b6 c0             	movzbl %al,%eax
 1ee:	89 d1                	mov    %edx,%ecx
 1f0:	29 c1                	sub    %eax,%ecx
 1f2:	89 c8                	mov    %ecx,%eax
}
 1f4:	5d                   	pop    %ebp
 1f5:	c3                   	ret    

000001f6 <strlen>:

uint
strlen(char *s)
{
 1f6:	55                   	push   %ebp
 1f7:	89 e5                	mov    %esp,%ebp
 1f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 203:	eb 04                	jmp    209 <strlen+0x13>
 205:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 209:	8b 45 fc             	mov    -0x4(%ebp),%eax
 20c:	03 45 08             	add    0x8(%ebp),%eax
 20f:	0f b6 00             	movzbl (%eax),%eax
 212:	84 c0                	test   %al,%al
 214:	75 ef                	jne    205 <strlen+0xf>
    ;
  return n;
 216:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 219:	c9                   	leave  
 21a:	c3                   	ret    

0000021b <memset>:

void*
memset(void *dst, int c, uint n)
{
 21b:	55                   	push   %ebp
 21c:	89 e5                	mov    %esp,%ebp
 21e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 221:	8b 45 10             	mov    0x10(%ebp),%eax
 224:	89 44 24 08          	mov    %eax,0x8(%esp)
 228:	8b 45 0c             	mov    0xc(%ebp),%eax
 22b:	89 44 24 04          	mov    %eax,0x4(%esp)
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	89 04 24             	mov    %eax,(%esp)
 235:	e8 22 ff ff ff       	call   15c <stosb>
  return dst;
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 23d:	c9                   	leave  
 23e:	c3                   	ret    

0000023f <strchr>:

char*
strchr(const char *s, char c)
{
 23f:	55                   	push   %ebp
 240:	89 e5                	mov    %esp,%ebp
 242:	83 ec 04             	sub    $0x4,%esp
 245:	8b 45 0c             	mov    0xc(%ebp),%eax
 248:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 24b:	eb 14                	jmp    261 <strchr+0x22>
    if(*s == c)
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	3a 45 fc             	cmp    -0x4(%ebp),%al
 256:	75 05                	jne    25d <strchr+0x1e>
      return (char*)s;
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	eb 13                	jmp    270 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 25d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	84 c0                	test   %al,%al
 269:	75 e2                	jne    24d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 26b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 270:	c9                   	leave  
 271:	c3                   	ret    

00000272 <gets>:

char*
gets(char *buf, int max)
{
 272:	55                   	push   %ebp
 273:	89 e5                	mov    %esp,%ebp
 275:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 278:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 27f:	eb 44                	jmp    2c5 <gets+0x53>
    cc = read(0, &c, 1);
 281:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 288:	00 
 289:	8d 45 ef             	lea    -0x11(%ebp),%eax
 28c:	89 44 24 04          	mov    %eax,0x4(%esp)
 290:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 297:	e8 3c 01 00 00       	call   3d8 <read>
 29c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 29f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2a3:	7e 2d                	jle    2d2 <gets+0x60>
      break;
    buf[i++] = c;
 2a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a8:	03 45 08             	add    0x8(%ebp),%eax
 2ab:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 2af:	88 10                	mov    %dl,(%eax)
 2b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 2b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b9:	3c 0a                	cmp    $0xa,%al
 2bb:	74 16                	je     2d3 <gets+0x61>
 2bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2c1:	3c 0d                	cmp    $0xd,%al
 2c3:	74 0e                	je     2d3 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c8:	83 c0 01             	add    $0x1,%eax
 2cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2ce:	7c b1                	jl     281 <gets+0xf>
 2d0:	eb 01                	jmp    2d3 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 2d2:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d6:	03 45 08             	add    0x8(%ebp),%eax
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
 2f5:	e8 06 01 00 00       	call   400 <open>
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
 317:	e8 fc 00 00 00       	call   418 <fstat>
 31c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 31f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 322:	89 04 24             	mov    %eax,(%esp)
 325:	e8 be 00 00 00       	call   3e8 <close>
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
 33c:	eb 23                	jmp    361 <atoi+0x32>
    n = n*10 + *s++ - '0';
 33e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 341:	89 d0                	mov    %edx,%eax
 343:	c1 e0 02             	shl    $0x2,%eax
 346:	01 d0                	add    %edx,%eax
 348:	01 c0                	add    %eax,%eax
 34a:	89 c2                	mov    %eax,%edx
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	0f b6 00             	movzbl (%eax),%eax
 352:	0f be c0             	movsbl %al,%eax
 355:	01 d0                	add    %edx,%eax
 357:	83 e8 30             	sub    $0x30,%eax
 35a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 35d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 361:	8b 45 08             	mov    0x8(%ebp),%eax
 364:	0f b6 00             	movzbl (%eax),%eax
 367:	3c 2f                	cmp    $0x2f,%al
 369:	7e 0a                	jle    375 <atoi+0x46>
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
 36e:	0f b6 00             	movzbl (%eax),%eax
 371:	3c 39                	cmp    $0x39,%al
 373:	7e c9                	jle    33e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 375:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 378:	c9                   	leave  
 379:	c3                   	ret    

0000037a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 37a:	55                   	push   %ebp
 37b:	89 e5                	mov    %esp,%ebp
 37d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 380:	8b 45 08             	mov    0x8(%ebp),%eax
 383:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 386:	8b 45 0c             	mov    0xc(%ebp),%eax
 389:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 38c:	eb 13                	jmp    3a1 <memmove+0x27>
    *dst++ = *src++;
 38e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 391:	0f b6 10             	movzbl (%eax),%edx
 394:	8b 45 fc             	mov    -0x4(%ebp),%eax
 397:	88 10                	mov    %dl,(%eax)
 399:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 39d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 3a5:	0f 9f c0             	setg   %al
 3a8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 3ac:	84 c0                	test   %al,%al
 3ae:	75 de                	jne    38e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    
 3b5:	90                   	nop
 3b6:	90                   	nop
 3b7:	90                   	nop

000003b8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3b8:	b8 01 00 00 00       	mov    $0x1,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <exit>:
SYSCALL(exit)
 3c0:	b8 02 00 00 00       	mov    $0x2,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <wait>:
SYSCALL(wait)
 3c8:	b8 03 00 00 00       	mov    $0x3,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <pipe>:
SYSCALL(pipe)
 3d0:	b8 04 00 00 00       	mov    $0x4,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <read>:
SYSCALL(read)
 3d8:	b8 05 00 00 00       	mov    $0x5,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <write>:
SYSCALL(write)
 3e0:	b8 10 00 00 00       	mov    $0x10,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <close>:
SYSCALL(close)
 3e8:	b8 15 00 00 00       	mov    $0x15,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <kill>:
SYSCALL(kill)
 3f0:	b8 06 00 00 00       	mov    $0x6,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <exec>:
SYSCALL(exec)
 3f8:	b8 07 00 00 00       	mov    $0x7,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <open>:
SYSCALL(open)
 400:	b8 0f 00 00 00       	mov    $0xf,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <mknod>:
SYSCALL(mknod)
 408:	b8 11 00 00 00       	mov    $0x11,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <unlink>:
SYSCALL(unlink)
 410:	b8 12 00 00 00       	mov    $0x12,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <fstat>:
SYSCALL(fstat)
 418:	b8 08 00 00 00       	mov    $0x8,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <link>:
SYSCALL(link)
 420:	b8 13 00 00 00       	mov    $0x13,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <mkdir>:
SYSCALL(mkdir)
 428:	b8 14 00 00 00       	mov    $0x14,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <chdir>:
SYSCALL(chdir)
 430:	b8 09 00 00 00       	mov    $0x9,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <dup>:
SYSCALL(dup)
 438:	b8 0a 00 00 00       	mov    $0xa,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <getpid>:
SYSCALL(getpid)
 440:	b8 0b 00 00 00       	mov    $0xb,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <sbrk>:
SYSCALL(sbrk)
 448:	b8 0c 00 00 00       	mov    $0xc,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <sleep>:
SYSCALL(sleep)
 450:	b8 0d 00 00 00       	mov    $0xd,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <uptime>:
SYSCALL(uptime)
 458:	b8 0e 00 00 00       	mov    $0xe,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <kthread_create>:
SYSCALL(kthread_create)
 460:	b8 17 00 00 00       	mov    $0x17,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <kthread_join>:
SYSCALL(kthread_join)
 468:	b8 16 00 00 00       	mov    $0x16,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 470:	b8 18 00 00 00       	mov    $0x18,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 478:	b8 19 00 00 00       	mov    $0x19,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 480:	b8 1a 00 00 00       	mov    $0x1a,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 488:	b8 1b 00 00 00       	mov    $0x1b,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 490:	b8 1c 00 00 00       	mov    $0x1c,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 498:	b8 1d 00 00 00       	mov    $0x1d,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 4a0:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 4a8:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <kthread_cond_broadcast>:
SYSCALL(kthread_cond_broadcast)
 4b0:	b8 20 00 00 00       	mov    $0x20,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <kthread_exit>:
 4b8:	b8 21 00 00 00       	mov    $0x21,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	83 ec 28             	sub    $0x28,%esp
 4c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d3:	00 
 4d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4db:	8b 45 08             	mov    0x8(%ebp),%eax
 4de:	89 04 24             	mov    %eax,(%esp)
 4e1:	e8 fa fe ff ff       	call   3e0 <write>
}
 4e6:	c9                   	leave  
 4e7:	c3                   	ret    

000004e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e8:	55                   	push   %ebp
 4e9:	89 e5                	mov    %esp,%ebp
 4eb:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4f5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4f9:	74 17                	je     512 <printint+0x2a>
 4fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4ff:	79 11                	jns    512 <printint+0x2a>
    neg = 1;
 501:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 508:	8b 45 0c             	mov    0xc(%ebp),%eax
 50b:	f7 d8                	neg    %eax
 50d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 510:	eb 06                	jmp    518 <printint+0x30>
  } else {
    x = xx;
 512:	8b 45 0c             	mov    0xc(%ebp),%eax
 515:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 518:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 51f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 522:	8b 45 ec             	mov    -0x14(%ebp),%eax
 525:	ba 00 00 00 00       	mov    $0x0,%edx
 52a:	f7 f1                	div    %ecx
 52c:	89 d0                	mov    %edx,%eax
 52e:	0f b6 90 28 0f 00 00 	movzbl 0xf28(%eax),%edx
 535:	8d 45 dc             	lea    -0x24(%ebp),%eax
 538:	03 45 f4             	add    -0xc(%ebp),%eax
 53b:	88 10                	mov    %dl,(%eax)
 53d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 541:	8b 55 10             	mov    0x10(%ebp),%edx
 544:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 547:	8b 45 ec             	mov    -0x14(%ebp),%eax
 54a:	ba 00 00 00 00       	mov    $0x0,%edx
 54f:	f7 75 d4             	divl   -0x2c(%ebp)
 552:	89 45 ec             	mov    %eax,-0x14(%ebp)
 555:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 559:	75 c4                	jne    51f <printint+0x37>
  if(neg)
 55b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 55f:	74 2a                	je     58b <printint+0xa3>
    buf[i++] = '-';
 561:	8d 45 dc             	lea    -0x24(%ebp),%eax
 564:	03 45 f4             	add    -0xc(%ebp),%eax
 567:	c6 00 2d             	movb   $0x2d,(%eax)
 56a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 56e:	eb 1b                	jmp    58b <printint+0xa3>
    putc(fd, buf[i]);
 570:	8d 45 dc             	lea    -0x24(%ebp),%eax
 573:	03 45 f4             	add    -0xc(%ebp),%eax
 576:	0f b6 00             	movzbl (%eax),%eax
 579:	0f be c0             	movsbl %al,%eax
 57c:	89 44 24 04          	mov    %eax,0x4(%esp)
 580:	8b 45 08             	mov    0x8(%ebp),%eax
 583:	89 04 24             	mov    %eax,(%esp)
 586:	e8 35 ff ff ff       	call   4c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 58b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 58f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 593:	79 db                	jns    570 <printint+0x88>
    putc(fd, buf[i]);
}
 595:	c9                   	leave  
 596:	c3                   	ret    

00000597 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 597:	55                   	push   %ebp
 598:	89 e5                	mov    %esp,%ebp
 59a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 59d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5a4:	8d 45 0c             	lea    0xc(%ebp),%eax
 5a7:	83 c0 04             	add    $0x4,%eax
 5aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5b4:	e9 7d 01 00 00       	jmp    736 <printf+0x19f>
    c = fmt[i] & 0xff;
 5b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bf:	01 d0                	add    %edx,%eax
 5c1:	0f b6 00             	movzbl (%eax),%eax
 5c4:	0f be c0             	movsbl %al,%eax
 5c7:	25 ff 00 00 00       	and    $0xff,%eax
 5cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5d3:	75 2c                	jne    601 <printf+0x6a>
      if(c == '%'){
 5d5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d9:	75 0c                	jne    5e7 <printf+0x50>
        state = '%';
 5db:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5e2:	e9 4b 01 00 00       	jmp    732 <printf+0x19b>
      } else {
        putc(fd, c);
 5e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f1:	8b 45 08             	mov    0x8(%ebp),%eax
 5f4:	89 04 24             	mov    %eax,(%esp)
 5f7:	e8 c4 fe ff ff       	call   4c0 <putc>
 5fc:	e9 31 01 00 00       	jmp    732 <printf+0x19b>
      }
    } else if(state == '%'){
 601:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 605:	0f 85 27 01 00 00    	jne    732 <printf+0x19b>
      if(c == 'd'){
 60b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 60f:	75 2d                	jne    63e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 611:	8b 45 e8             	mov    -0x18(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 61d:	00 
 61e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 625:	00 
 626:	89 44 24 04          	mov    %eax,0x4(%esp)
 62a:	8b 45 08             	mov    0x8(%ebp),%eax
 62d:	89 04 24             	mov    %eax,(%esp)
 630:	e8 b3 fe ff ff       	call   4e8 <printint>
        ap++;
 635:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 639:	e9 ed 00 00 00       	jmp    72b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 63e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 642:	74 06                	je     64a <printf+0xb3>
 644:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 648:	75 2d                	jne    677 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 64a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64d:	8b 00                	mov    (%eax),%eax
 64f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 656:	00 
 657:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 65e:	00 
 65f:	89 44 24 04          	mov    %eax,0x4(%esp)
 663:	8b 45 08             	mov    0x8(%ebp),%eax
 666:	89 04 24             	mov    %eax,(%esp)
 669:	e8 7a fe ff ff       	call   4e8 <printint>
        ap++;
 66e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 672:	e9 b4 00 00 00       	jmp    72b <printf+0x194>
      } else if(c == 's'){
 677:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 67b:	75 46                	jne    6c3 <printf+0x12c>
        s = (char*)*ap;
 67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 685:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 689:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 68d:	75 27                	jne    6b6 <printf+0x11f>
          s = "(null)";
 68f:	c7 45 f4 dc 0a 00 00 	movl   $0xadc,-0xc(%ebp)
        while(*s != 0){
 696:	eb 1e                	jmp    6b6 <printf+0x11f>
          putc(fd, *s);
 698:	8b 45 f4             	mov    -0xc(%ebp),%eax
 69b:	0f b6 00             	movzbl (%eax),%eax
 69e:	0f be c0             	movsbl %al,%eax
 6a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a5:	8b 45 08             	mov    0x8(%ebp),%eax
 6a8:	89 04 24             	mov    %eax,(%esp)
 6ab:	e8 10 fe ff ff       	call   4c0 <putc>
          s++;
 6b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 6b4:	eb 01                	jmp    6b7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6b6:	90                   	nop
 6b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ba:	0f b6 00             	movzbl (%eax),%eax
 6bd:	84 c0                	test   %al,%al
 6bf:	75 d7                	jne    698 <printf+0x101>
 6c1:	eb 68                	jmp    72b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6c7:	75 1d                	jne    6e6 <printf+0x14f>
        putc(fd, *ap);
 6c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6cc:	8b 00                	mov    (%eax),%eax
 6ce:	0f be c0             	movsbl %al,%eax
 6d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d5:	8b 45 08             	mov    0x8(%ebp),%eax
 6d8:	89 04 24             	mov    %eax,(%esp)
 6db:	e8 e0 fd ff ff       	call   4c0 <putc>
        ap++;
 6e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6e4:	eb 45                	jmp    72b <printf+0x194>
      } else if(c == '%'){
 6e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6ea:	75 17                	jne    703 <printf+0x16c>
        putc(fd, c);
 6ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ef:	0f be c0             	movsbl %al,%eax
 6f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
 6f9:	89 04 24             	mov    %eax,(%esp)
 6fc:	e8 bf fd ff ff       	call   4c0 <putc>
 701:	eb 28                	jmp    72b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 703:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 70a:	00 
 70b:	8b 45 08             	mov    0x8(%ebp),%eax
 70e:	89 04 24             	mov    %eax,(%esp)
 711:	e8 aa fd ff ff       	call   4c0 <putc>
        putc(fd, c);
 716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 719:	0f be c0             	movsbl %al,%eax
 71c:	89 44 24 04          	mov    %eax,0x4(%esp)
 720:	8b 45 08             	mov    0x8(%ebp),%eax
 723:	89 04 24             	mov    %eax,(%esp)
 726:	e8 95 fd ff ff       	call   4c0 <putc>
      }
      state = 0;
 72b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 732:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 736:	8b 55 0c             	mov    0xc(%ebp),%edx
 739:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73c:	01 d0                	add    %edx,%eax
 73e:	0f b6 00             	movzbl (%eax),%eax
 741:	84 c0                	test   %al,%al
 743:	0f 85 70 fe ff ff    	jne    5b9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 749:	c9                   	leave  
 74a:	c3                   	ret    
 74b:	90                   	nop

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
 75b:	a1 48 0f 00 00       	mov    0xf48,%eax
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
 7a1:	c1 e0 03             	shl    $0x3,%eax
 7a4:	89 c2                	mov    %eax,%edx
 7a6:	03 55 f8             	add    -0x8(%ebp),%edx
 7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ac:	8b 00                	mov    (%eax),%eax
 7ae:	39 c2                	cmp    %eax,%edx
 7b0:	75 24                	jne    7d6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 7b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b5:	8b 50 04             	mov    0x4(%eax),%edx
 7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bb:	8b 00                	mov    (%eax),%eax
 7bd:	8b 40 04             	mov    0x4(%eax),%eax
 7c0:	01 c2                	add    %eax,%edx
 7c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cb:	8b 00                	mov    (%eax),%eax
 7cd:	8b 10                	mov    (%eax),%edx
 7cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d2:	89 10                	mov    %edx,(%eax)
 7d4:	eb 0a                	jmp    7e0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 7d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d9:	8b 10                	mov    (%eax),%edx
 7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7de:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e3:	8b 40 04             	mov    0x4(%eax),%eax
 7e6:	c1 e0 03             	shl    $0x3,%eax
 7e9:	03 45 fc             	add    -0x4(%ebp),%eax
 7ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ef:	75 20                	jne    811 <free+0xc5>
    p->s.size += bp->s.size;
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	8b 50 04             	mov    0x4(%eax),%edx
 7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	01 c2                	add    %eax,%edx
 7ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 802:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 805:	8b 45 f8             	mov    -0x8(%ebp),%eax
 808:	8b 10                	mov    (%eax),%edx
 80a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80d:	89 10                	mov    %edx,(%eax)
 80f:	eb 08                	jmp    819 <free+0xcd>
  } else
    p->s.ptr = bp;
 811:	8b 45 fc             	mov    -0x4(%ebp),%eax
 814:	8b 55 f8             	mov    -0x8(%ebp),%edx
 817:	89 10                	mov    %edx,(%eax)
  freep = p;
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	a3 48 0f 00 00       	mov    %eax,0xf48
}
 821:	c9                   	leave  
 822:	c3                   	ret    

00000823 <morecore>:

static Header*
morecore(uint nu)
{
 823:	55                   	push   %ebp
 824:	89 e5                	mov    %esp,%ebp
 826:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 829:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 830:	77 07                	ja     839 <morecore+0x16>
    nu = 4096;
 832:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 839:	8b 45 08             	mov    0x8(%ebp),%eax
 83c:	c1 e0 03             	shl    $0x3,%eax
 83f:	89 04 24             	mov    %eax,(%esp)
 842:	e8 01 fc ff ff       	call   448 <sbrk>
 847:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 84a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 84e:	75 07                	jne    857 <morecore+0x34>
    return 0;
 850:	b8 00 00 00 00       	mov    $0x0,%eax
 855:	eb 22                	jmp    879 <morecore+0x56>
  hp = (Header*)p;
 857:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 85d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 860:	8b 55 08             	mov    0x8(%ebp),%edx
 863:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 866:	8b 45 f0             	mov    -0x10(%ebp),%eax
 869:	83 c0 08             	add    $0x8,%eax
 86c:	89 04 24             	mov    %eax,(%esp)
 86f:	e8 d8 fe ff ff       	call   74c <free>
  return freep;
 874:	a1 48 0f 00 00       	mov    0xf48,%eax
}
 879:	c9                   	leave  
 87a:	c3                   	ret    

0000087b <malloc>:

void*
malloc(uint nbytes)
{
 87b:	55                   	push   %ebp
 87c:	89 e5                	mov    %esp,%ebp
 87e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 881:	8b 45 08             	mov    0x8(%ebp),%eax
 884:	83 c0 07             	add    $0x7,%eax
 887:	c1 e8 03             	shr    $0x3,%eax
 88a:	83 c0 01             	add    $0x1,%eax
 88d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 890:	a1 48 0f 00 00       	mov    0xf48,%eax
 895:	89 45 f0             	mov    %eax,-0x10(%ebp)
 898:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 89c:	75 23                	jne    8c1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 89e:	c7 45 f0 40 0f 00 00 	movl   $0xf40,-0x10(%ebp)
 8a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a8:	a3 48 0f 00 00       	mov    %eax,0xf48
 8ad:	a1 48 0f 00 00       	mov    0xf48,%eax
 8b2:	a3 40 0f 00 00       	mov    %eax,0xf40
    base.s.size = 0;
 8b7:	c7 05 44 0f 00 00 00 	movl   $0x0,0xf44
 8be:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c4:	8b 00                	mov    (%eax),%eax
 8c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cc:	8b 40 04             	mov    0x4(%eax),%eax
 8cf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8d2:	72 4d                	jb     921 <malloc+0xa6>
      if(p->s.size == nunits)
 8d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d7:	8b 40 04             	mov    0x4(%eax),%eax
 8da:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8dd:	75 0c                	jne    8eb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e2:	8b 10                	mov    (%eax),%edx
 8e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e7:	89 10                	mov    %edx,(%eax)
 8e9:	eb 26                	jmp    911 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ee:	8b 40 04             	mov    0x4(%eax),%eax
 8f1:	89 c2                	mov    %eax,%edx
 8f3:	2b 55 ec             	sub    -0x14(%ebp),%edx
 8f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ff:	8b 40 04             	mov    0x4(%eax),%eax
 902:	c1 e0 03             	shl    $0x3,%eax
 905:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 908:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 90e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 911:	8b 45 f0             	mov    -0x10(%ebp),%eax
 914:	a3 48 0f 00 00       	mov    %eax,0xf48
      return (void*)(p + 1);
 919:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91c:	83 c0 08             	add    $0x8,%eax
 91f:	eb 38                	jmp    959 <malloc+0xde>
    }
    if(p == freep)
 921:	a1 48 0f 00 00       	mov    0xf48,%eax
 926:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 929:	75 1b                	jne    946 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 92b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 92e:	89 04 24             	mov    %eax,(%esp)
 931:	e8 ed fe ff ff       	call   823 <morecore>
 936:	89 45 f4             	mov    %eax,-0xc(%ebp)
 939:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 93d:	75 07                	jne    946 <malloc+0xcb>
        return 0;
 93f:	b8 00 00 00 00       	mov    $0x0,%eax
 944:	eb 13                	jmp    959 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 946:	8b 45 f4             	mov    -0xc(%ebp),%eax
 949:	89 45 f0             	mov    %eax,-0x10(%ebp)
 94c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94f:	8b 00                	mov    (%eax),%eax
 951:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 954:	e9 70 ff ff ff       	jmp    8c9 <malloc+0x4e>
}
 959:	c9                   	leave  
 95a:	c3                   	ret    
 95b:	90                   	nop

0000095c <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 95c:	55                   	push   %ebp
 95d:	89 e5                	mov    %esp,%ebp
 95f:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 962:	8b 45 0c             	mov    0xc(%ebp),%eax
 965:	89 04 24             	mov    %eax,(%esp)
 968:	8b 45 08             	mov    0x8(%ebp),%eax
 96b:	ff d0                	call   *%eax
    exit();
 96d:	e8 4e fa ff ff       	call   3c0 <exit>

00000972 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 972:	55                   	push   %ebp
 973:	89 e5                	mov    %esp,%ebp
 975:	57                   	push   %edi
 976:	56                   	push   %esi
 977:	53                   	push   %ebx
 978:	83 ec 1c             	sub    $0x1c,%esp

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
 97b:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 982:	e8 f4 fe ff ff       	call   87b <malloc>
 987:	89 c2                	mov    %eax,%edx
 989:	8b 45 08             	mov    0x8(%ebp),%eax
 98c:	89 10                	mov    %edx,(%eax)
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 98e:	8b 45 10             	mov    0x10(%ebp),%eax
 991:	8b 38                	mov    (%eax),%edi
 993:	8b 75 0c             	mov    0xc(%ebp),%esi
 996:	bb 5c 09 00 00       	mov    $0x95c,%ebx
 99b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9a2:	e8 d4 fe ff ff       	call   87b <malloc>
 9a7:	05 00 10 00 00       	add    $0x1000,%eax
 9ac:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 9b0:	89 74 24 08          	mov    %esi,0x8(%esp)
 9b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 9b8:	89 04 24             	mov    %eax,(%esp)
 9bb:	e8 a0 fa ff ff       	call   460 <kthread_create>
 9c0:	8b 55 08             	mov    0x8(%ebp),%edx
 9c3:	89 02                	mov    %eax,(%edx)
    return *thread;
 9c5:	8b 45 08             	mov    0x8(%ebp),%eax
 9c8:	8b 00                	mov    (%eax),%eax
}
 9ca:	83 c4 1c             	add    $0x1c,%esp
 9cd:	5b                   	pop    %ebx
 9ce:	5e                   	pop    %esi
 9cf:	5f                   	pop    %edi
 9d0:	5d                   	pop    %ebp
 9d1:	c3                   	ret    

000009d2 <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 9d2:	55                   	push   %ebp
 9d3:	89 e5                	mov    %esp,%ebp
 9d5:	83 ec 28             	sub    $0x28,%esp

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
 9d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 9db:	89 44 24 04          	mov    %eax,0x4(%esp)
 9df:	8b 45 08             	mov    0x8(%ebp),%eax
 9e2:	89 04 24             	mov    %eax,(%esp)
 9e5:	e8 7e fa ff ff       	call   468 <kthread_join>
 9ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 9ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 9f0:	c9                   	leave  
 9f1:	c3                   	ret    

000009f2 <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 9f2:	55                   	push   %ebp
 9f3:	89 e5                	mov    %esp,%ebp
 9f5:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 9f8:	e8 73 fa ff ff       	call   470 <kthread_mutex_init>
 9fd:	8b 55 08             	mov    0x8(%ebp),%edx
 a00:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 a02:	8b 45 08             	mov    0x8(%ebp),%eax
 a05:	8b 00                	mov    (%eax),%eax
 a07:	85 c0                	test   %eax,%eax
 a09:	7e 07                	jle    a12 <qthread_mutex_init+0x20>
		return 0;
 a0b:	b8 00 00 00 00       	mov    $0x0,%eax
 a10:	eb 05                	jmp    a17 <qthread_mutex_init+0x25>
	}
	return *mutex;
 a12:	8b 45 08             	mov    0x8(%ebp),%eax
 a15:	8b 00                	mov    (%eax),%eax
}
 a17:	c9                   	leave  
 a18:	c3                   	ret    

00000a19 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 a19:	55                   	push   %ebp
 a1a:	89 e5                	mov    %esp,%ebp
 a1c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 a1f:	8b 45 08             	mov    0x8(%ebp),%eax
 a22:	89 04 24             	mov    %eax,(%esp)
 a25:	e8 4e fa ff ff       	call   478 <kthread_mutex_destroy>
 a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a31:	79 07                	jns    a3a <qthread_mutex_destroy+0x21>
    	return -1;
 a33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a38:	eb 05                	jmp    a3f <qthread_mutex_destroy+0x26>
    }
    return 0;
 a3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a3f:	c9                   	leave  
 a40:	c3                   	ret    

00000a41 <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 a41:	55                   	push   %ebp
 a42:	89 e5                	mov    %esp,%ebp
 a44:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 a47:	8b 45 08             	mov    0x8(%ebp),%eax
 a4a:	89 04 24             	mov    %eax,(%esp)
 a4d:	e8 2e fa ff ff       	call   480 <kthread_mutex_lock>
 a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a55:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a59:	79 07                	jns    a62 <qthread_mutex_lock+0x21>
    	return -1;
 a5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a60:	eb 05                	jmp    a67 <qthread_mutex_lock+0x26>
    }
    return 0;
 a62:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a67:	c9                   	leave  
 a68:	c3                   	ret    

00000a69 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 a69:	55                   	push   %ebp
 a6a:	89 e5                	mov    %esp,%ebp
 a6c:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 a6f:	8b 45 08             	mov    0x8(%ebp),%eax
 a72:	89 04 24             	mov    %eax,(%esp)
 a75:	e8 0e fa ff ff       	call   488 <kthread_mutex_unlock>
 a7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 a7d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a81:	79 07                	jns    a8a <qthread_mutex_unlock+0x21>
    	return -1;
 a83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a88:	eb 05                	jmp    a8f <qthread_mutex_unlock+0x26>
    }
    return 0;
 a8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a8f:	c9                   	leave  
 a90:	c3                   	ret    

00000a91 <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 a91:	55                   	push   %ebp
 a92:	89 e5                	mov    %esp,%ebp

	return 0;
 a94:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a99:	5d                   	pop    %ebp
 a9a:	c3                   	ret    

00000a9b <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 a9b:	55                   	push   %ebp
 a9c:	89 e5                	mov    %esp,%ebp
    
    return 0;
 a9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aa3:	5d                   	pop    %ebp
 aa4:	c3                   	ret    

00000aa5 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 aa5:	55                   	push   %ebp
 aa6:	89 e5                	mov    %esp,%ebp
    
    return 0;
 aa8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aad:	5d                   	pop    %ebp
 aae:	c3                   	ret    

00000aaf <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 aaf:	55                   	push   %ebp
 ab0:	89 e5                	mov    %esp,%ebp
	return 0;
 ab2:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 ab7:	5d                   	pop    %ebp
 ab8:	c3                   	ret    

00000ab9 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 ab9:	55                   	push   %ebp
 aba:	89 e5                	mov    %esp,%ebp
	return 0;
 abc:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 ac1:	5d                   	pop    %ebp
 ac2:	c3                   	ret    

00000ac3 <qthread_exit>:

int qthread_exit(){
 ac3:	55                   	push   %ebp
 ac4:	89 e5                	mov    %esp,%ebp
	return 0;
 ac6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 acb:	5d                   	pop    %ebp
 acc:	c3                   	ret    
