
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
   d:	e9 bb 00 00 00       	jmp    cd <grep+0xcd>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
  18:	c7 45 f0 a0 11 00 00 	movl   $0x11a0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  1f:	eb 51                	jmp    72 <grep+0x72>
      *q = 0;
  21:	8b 45 e8             	mov    -0x18(%ebp),%eax
  24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  2e:	8b 45 08             	mov    0x8(%ebp),%eax
  31:	89 04 24             	mov    %eax,(%esp)
  34:	e8 bc 01 00 00       	call   1f5 <match>
  39:	85 c0                	test   %eax,%eax
  3b:	74 2c                	je     69 <grep+0x69>
        *q = '\n';
  3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  43:	8b 45 e8             	mov    -0x18(%ebp),%eax
  46:	83 c0 01             	add    $0x1,%eax
  49:	89 c2                	mov    %eax,%edx
  4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4e:	29 c2                	sub    %eax,%edx
  50:	89 d0                	mov    %edx,%eax
  52:	89 44 24 08          	mov    %eax,0x8(%esp)
  56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  59:	89 44 24 04          	mov    %eax,0x4(%esp)
  5d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  64:	e8 74 05 00 00       	call   5dd <write>
      }
      p = q+1;
  69:	8b 45 e8             	mov    -0x18(%ebp),%eax
  6c:	83 c0 01             	add    $0x1,%eax
  6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  72:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  79:	00 
  7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  7d:	89 04 24             	mov    %eax,(%esp)
  80:	e8 af 03 00 00       	call   434 <strchr>
  85:	89 45 e8             	mov    %eax,-0x18(%ebp)
  88:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8c:	75 93                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  8e:	81 7d f0 a0 11 00 00 	cmpl   $0x11a0,-0x10(%ebp)
  95:	75 07                	jne    9e <grep+0x9e>
      m = 0;
  97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a2:	7e 29                	jle    cd <grep+0xcd>
      m -= p - buf;
  a4:	ba a0 11 00 00       	mov    $0x11a0,%edx
  a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ac:	29 c2                	sub    %eax,%edx
  ae:	89 d0                	mov    %edx,%eax
  b0:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  b6:	89 44 24 08          	mov    %eax,0x8(%esp)
  ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  c1:	c7 04 24 a0 11 00 00 	movl   $0x11a0,(%esp)
  c8:	e8 ab 04 00 00       	call   578 <memmove>
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d0:	ba 00 04 00 00       	mov    $0x400,%edx
  d5:	29 c2                	sub    %eax,%edx
  d7:	89 d0                	mov    %edx,%eax
  d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  dc:	81 c2 a0 11 00 00    	add    $0x11a0,%edx
  e2:	89 44 24 08          	mov    %eax,0x8(%esp)
  e6:	89 54 24 04          	mov    %edx,0x4(%esp)
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 04 24             	mov    %eax,(%esp)
  f0:	e8 e0 04 00 00       	call   5d5 <read>
  f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  fc:	0f 8f 10 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 102:	c9                   	leave  
 103:	c3                   	ret    

00000104 <main>:

int
main(int argc, char *argv[])
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	83 e4 f0             	and    $0xfffffff0,%esp
 10a:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 10d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 111:	7f 19                	jg     12c <main+0x28>
    printf(2, "usage: grep pattern [file ...]\n");
 113:	c7 44 24 04 d0 0c 00 	movl   $0xcd0,0x4(%esp)
 11a:	00 
 11b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 122:	e8 6e 06 00 00       	call   795 <printf>
    exit();
 127:	e8 91 04 00 00       	call   5bd <exit>
  }
  pattern = argv[1];
 12c:	8b 45 0c             	mov    0xc(%ebp),%eax
 12f:	8b 40 04             	mov    0x4(%eax),%eax
 132:	89 44 24 18          	mov    %eax,0x18(%esp)
  
  if(argc <= 2){
 136:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 13a:	7f 19                	jg     155 <main+0x51>
    grep(pattern, 0);
 13c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 143:	00 
 144:	8b 44 24 18          	mov    0x18(%esp),%eax
 148:	89 04 24             	mov    %eax,(%esp)
 14b:	e8 b0 fe ff ff       	call   0 <grep>
    exit();
 150:	e8 68 04 00 00       	call   5bd <exit>
  }

  for(i = 2; i < argc; i++){
 155:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
 15c:	00 
 15d:	e9 81 00 00 00       	jmp    1e3 <main+0xdf>
    if((fd = open(argv[i], 0)) < 0){
 162:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 166:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 16d:	8b 45 0c             	mov    0xc(%ebp),%eax
 170:	01 d0                	add    %edx,%eax
 172:	8b 00                	mov    (%eax),%eax
 174:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 17b:	00 
 17c:	89 04 24             	mov    %eax,(%esp)
 17f:	e8 79 04 00 00       	call   5fd <open>
 184:	89 44 24 14          	mov    %eax,0x14(%esp)
 188:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
 18d:	79 2f                	jns    1be <main+0xba>
      printf(1, "grep: cannot open %s\n", argv[i]);
 18f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 193:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 19a:	8b 45 0c             	mov    0xc(%ebp),%eax
 19d:	01 d0                	add    %edx,%eax
 19f:	8b 00                	mov    (%eax),%eax
 1a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a5:	c7 44 24 04 f0 0c 00 	movl   $0xcf0,0x4(%esp)
 1ac:	00 
 1ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b4:	e8 dc 05 00 00       	call   795 <printf>
      exit();
 1b9:	e8 ff 03 00 00       	call   5bd <exit>
    }
    grep(pattern, fd);
 1be:	8b 44 24 14          	mov    0x14(%esp),%eax
 1c2:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c6:	8b 44 24 18          	mov    0x18(%esp),%eax
 1ca:	89 04 24             	mov    %eax,(%esp)
 1cd:	e8 2e fe ff ff       	call   0 <grep>
    close(fd);
 1d2:	8b 44 24 14          	mov    0x14(%esp),%eax
 1d6:	89 04 24             	mov    %eax,(%esp)
 1d9:	e8 07 04 00 00       	call   5e5 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1de:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1e3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1e7:	3b 45 08             	cmp    0x8(%ebp),%eax
 1ea:	0f 8c 72 ff ff ff    	jl     162 <main+0x5e>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1f0:	e8 c8 03 00 00       	call   5bd <exit>

000001f5 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1f5:	55                   	push   %ebp
 1f6:	89 e5                	mov    %esp,%ebp
 1f8:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	0f b6 00             	movzbl (%eax),%eax
 201:	3c 5e                	cmp    $0x5e,%al
 203:	75 17                	jne    21c <match+0x27>
    return matchhere(re+1, text);
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	8d 50 01             	lea    0x1(%eax),%edx
 20b:	8b 45 0c             	mov    0xc(%ebp),%eax
 20e:	89 44 24 04          	mov    %eax,0x4(%esp)
 212:	89 14 24             	mov    %edx,(%esp)
 215:	e8 36 00 00 00       	call   250 <matchhere>
 21a:	eb 32                	jmp    24e <match+0x59>
  do{  // must look at empty string
    if(matchhere(re, text))
 21c:	8b 45 0c             	mov    0xc(%ebp),%eax
 21f:	89 44 24 04          	mov    %eax,0x4(%esp)
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	89 04 24             	mov    %eax,(%esp)
 229:	e8 22 00 00 00       	call   250 <matchhere>
 22e:	85 c0                	test   %eax,%eax
 230:	74 07                	je     239 <match+0x44>
      return 1;
 232:	b8 01 00 00 00       	mov    $0x1,%eax
 237:	eb 15                	jmp    24e <match+0x59>
  }while(*text++ != '\0');
 239:	8b 45 0c             	mov    0xc(%ebp),%eax
 23c:	8d 50 01             	lea    0x1(%eax),%edx
 23f:	89 55 0c             	mov    %edx,0xc(%ebp)
 242:	0f b6 00             	movzbl (%eax),%eax
 245:	84 c0                	test   %al,%al
 247:	75 d3                	jne    21c <match+0x27>
  return 0;
 249:	b8 00 00 00 00       	mov    $0x0,%eax
}
 24e:	c9                   	leave  
 24f:	c3                   	ret    

00000250 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	0f b6 00             	movzbl (%eax),%eax
 25c:	84 c0                	test   %al,%al
 25e:	75 0a                	jne    26a <matchhere+0x1a>
    return 1;
 260:	b8 01 00 00 00       	mov    $0x1,%eax
 265:	e9 9b 00 00 00       	jmp    305 <matchhere+0xb5>
  if(re[1] == '*')
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	83 c0 01             	add    $0x1,%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2a                	cmp    $0x2a,%al
 275:	75 24                	jne    29b <matchhere+0x4b>
    return matchstar(re[0], re+2, text);
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	8d 48 02             	lea    0x2(%eax),%ecx
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	0f b6 00             	movzbl (%eax),%eax
 283:	0f be c0             	movsbl %al,%eax
 286:	8b 55 0c             	mov    0xc(%ebp),%edx
 289:	89 54 24 08          	mov    %edx,0x8(%esp)
 28d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 291:	89 04 24             	mov    %eax,(%esp)
 294:	e8 6e 00 00 00       	call   307 <matchstar>
 299:	eb 6a                	jmp    305 <matchhere+0xb5>
  if(re[0] == '$' && re[1] == '\0')
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	0f b6 00             	movzbl (%eax),%eax
 2a1:	3c 24                	cmp    $0x24,%al
 2a3:	75 1d                	jne    2c2 <matchhere+0x72>
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	83 c0 01             	add    $0x1,%eax
 2ab:	0f b6 00             	movzbl (%eax),%eax
 2ae:	84 c0                	test   %al,%al
 2b0:	75 10                	jne    2c2 <matchhere+0x72>
    return *text == '\0';
 2b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b5:	0f b6 00             	movzbl (%eax),%eax
 2b8:	84 c0                	test   %al,%al
 2ba:	0f 94 c0             	sete   %al
 2bd:	0f b6 c0             	movzbl %al,%eax
 2c0:	eb 43                	jmp    305 <matchhere+0xb5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c5:	0f b6 00             	movzbl (%eax),%eax
 2c8:	84 c0                	test   %al,%al
 2ca:	74 34                	je     300 <matchhere+0xb0>
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	0f b6 00             	movzbl (%eax),%eax
 2d2:	3c 2e                	cmp    $0x2e,%al
 2d4:	74 10                	je     2e6 <matchhere+0x96>
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	0f b6 10             	movzbl (%eax),%edx
 2dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2df:	0f b6 00             	movzbl (%eax),%eax
 2e2:	38 c2                	cmp    %al,%dl
 2e4:	75 1a                	jne    300 <matchhere+0xb0>
    return matchhere(re+1, text+1);
 2e6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e9:	8d 50 01             	lea    0x1(%eax),%edx
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
 2ef:	83 c0 01             	add    $0x1,%eax
 2f2:	89 54 24 04          	mov    %edx,0x4(%esp)
 2f6:	89 04 24             	mov    %eax,(%esp)
 2f9:	e8 52 ff ff ff       	call   250 <matchhere>
 2fe:	eb 05                	jmp    305 <matchhere+0xb5>
  return 0;
 300:	b8 00 00 00 00       	mov    $0x0,%eax
}
 305:	c9                   	leave  
 306:	c3                   	ret    

00000307 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 307:	55                   	push   %ebp
 308:	89 e5                	mov    %esp,%ebp
 30a:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 30d:	8b 45 10             	mov    0x10(%ebp),%eax
 310:	89 44 24 04          	mov    %eax,0x4(%esp)
 314:	8b 45 0c             	mov    0xc(%ebp),%eax
 317:	89 04 24             	mov    %eax,(%esp)
 31a:	e8 31 ff ff ff       	call   250 <matchhere>
 31f:	85 c0                	test   %eax,%eax
 321:	74 07                	je     32a <matchstar+0x23>
      return 1;
 323:	b8 01 00 00 00       	mov    $0x1,%eax
 328:	eb 29                	jmp    353 <matchstar+0x4c>
  }while(*text!='\0' && (*text++==c || c=='.'));
 32a:	8b 45 10             	mov    0x10(%ebp),%eax
 32d:	0f b6 00             	movzbl (%eax),%eax
 330:	84 c0                	test   %al,%al
 332:	74 1a                	je     34e <matchstar+0x47>
 334:	8b 45 10             	mov    0x10(%ebp),%eax
 337:	8d 50 01             	lea    0x1(%eax),%edx
 33a:	89 55 10             	mov    %edx,0x10(%ebp)
 33d:	0f b6 00             	movzbl (%eax),%eax
 340:	0f be c0             	movsbl %al,%eax
 343:	3b 45 08             	cmp    0x8(%ebp),%eax
 346:	74 c5                	je     30d <matchstar+0x6>
 348:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 34c:	74 bf                	je     30d <matchstar+0x6>
  return 0;
 34e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 353:	c9                   	leave  
 354:	c3                   	ret    

00000355 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 355:	55                   	push   %ebp
 356:	89 e5                	mov    %esp,%ebp
 358:	57                   	push   %edi
 359:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 35a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 35d:	8b 55 10             	mov    0x10(%ebp),%edx
 360:	8b 45 0c             	mov    0xc(%ebp),%eax
 363:	89 cb                	mov    %ecx,%ebx
 365:	89 df                	mov    %ebx,%edi
 367:	89 d1                	mov    %edx,%ecx
 369:	fc                   	cld    
 36a:	f3 aa                	rep stos %al,%es:(%edi)
 36c:	89 ca                	mov    %ecx,%edx
 36e:	89 fb                	mov    %edi,%ebx
 370:	89 5d 08             	mov    %ebx,0x8(%ebp)
 373:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 376:	5b                   	pop    %ebx
 377:	5f                   	pop    %edi
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    

0000037a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 37a:	55                   	push   %ebp
 37b:	89 e5                	mov    %esp,%ebp
 37d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 380:	8b 45 08             	mov    0x8(%ebp),%eax
 383:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 386:	90                   	nop
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	8d 50 01             	lea    0x1(%eax),%edx
 38d:	89 55 08             	mov    %edx,0x8(%ebp)
 390:	8b 55 0c             	mov    0xc(%ebp),%edx
 393:	8d 4a 01             	lea    0x1(%edx),%ecx
 396:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 399:	0f b6 12             	movzbl (%edx),%edx
 39c:	88 10                	mov    %dl,(%eax)
 39e:	0f b6 00             	movzbl (%eax),%eax
 3a1:	84 c0                	test   %al,%al
 3a3:	75 e2                	jne    387 <strcpy+0xd>
    ;
  return os;
 3a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3a8:	c9                   	leave  
 3a9:	c3                   	ret    

000003aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3aa:	55                   	push   %ebp
 3ab:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3ad:	eb 08                	jmp    3b7 <strcmp+0xd>
    p++, q++;
 3af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3b3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ba:	0f b6 00             	movzbl (%eax),%eax
 3bd:	84 c0                	test   %al,%al
 3bf:	74 10                	je     3d1 <strcmp+0x27>
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	0f b6 10             	movzbl (%eax),%edx
 3c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	38 c2                	cmp    %al,%dl
 3cf:	74 de                	je     3af <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3d1:	8b 45 08             	mov    0x8(%ebp),%eax
 3d4:	0f b6 00             	movzbl (%eax),%eax
 3d7:	0f b6 d0             	movzbl %al,%edx
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	0f b6 00             	movzbl (%eax),%eax
 3e0:	0f b6 c0             	movzbl %al,%eax
 3e3:	29 c2                	sub    %eax,%edx
 3e5:	89 d0                	mov    %edx,%eax
}
 3e7:	5d                   	pop    %ebp
 3e8:	c3                   	ret    

000003e9 <strlen>:

uint
strlen(char *s)
{
 3e9:	55                   	push   %ebp
 3ea:	89 e5                	mov    %esp,%ebp
 3ec:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3f6:	eb 04                	jmp    3fc <strlen+0x13>
 3f8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3ff:	8b 45 08             	mov    0x8(%ebp),%eax
 402:	01 d0                	add    %edx,%eax
 404:	0f b6 00             	movzbl (%eax),%eax
 407:	84 c0                	test   %al,%al
 409:	75 ed                	jne    3f8 <strlen+0xf>
    ;
  return n;
 40b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 40e:	c9                   	leave  
 40f:	c3                   	ret    

00000410 <memset>:

void*
memset(void *dst, int c, uint n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 416:	8b 45 10             	mov    0x10(%ebp),%eax
 419:	89 44 24 08          	mov    %eax,0x8(%esp)
 41d:	8b 45 0c             	mov    0xc(%ebp),%eax
 420:	89 44 24 04          	mov    %eax,0x4(%esp)
 424:	8b 45 08             	mov    0x8(%ebp),%eax
 427:	89 04 24             	mov    %eax,(%esp)
 42a:	e8 26 ff ff ff       	call   355 <stosb>
  return dst;
 42f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <strchr>:

char*
strchr(const char *s, char c)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 04             	sub    $0x4,%esp
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 440:	eb 14                	jmp    456 <strchr+0x22>
    if(*s == c)
 442:	8b 45 08             	mov    0x8(%ebp),%eax
 445:	0f b6 00             	movzbl (%eax),%eax
 448:	3a 45 fc             	cmp    -0x4(%ebp),%al
 44b:	75 05                	jne    452 <strchr+0x1e>
      return (char*)s;
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
 450:	eb 13                	jmp    465 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 452:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 456:	8b 45 08             	mov    0x8(%ebp),%eax
 459:	0f b6 00             	movzbl (%eax),%eax
 45c:	84 c0                	test   %al,%al
 45e:	75 e2                	jne    442 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 460:	b8 00 00 00 00       	mov    $0x0,%eax
}
 465:	c9                   	leave  
 466:	c3                   	ret    

00000467 <gets>:

char*
gets(char *buf, int max)
{
 467:	55                   	push   %ebp
 468:	89 e5                	mov    %esp,%ebp
 46a:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 46d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 474:	eb 4c                	jmp    4c2 <gets+0x5b>
    cc = read(0, &c, 1);
 476:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47d:	00 
 47e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 481:	89 44 24 04          	mov    %eax,0x4(%esp)
 485:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 48c:	e8 44 01 00 00       	call   5d5 <read>
 491:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 494:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 498:	7f 02                	jg     49c <gets+0x35>
      break;
 49a:	eb 31                	jmp    4cd <gets+0x66>
    buf[i++] = c;
 49c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49f:	8d 50 01             	lea    0x1(%eax),%edx
 4a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a5:	89 c2                	mov    %eax,%edx
 4a7:	8b 45 08             	mov    0x8(%ebp),%eax
 4aa:	01 c2                	add    %eax,%edx
 4ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 4b2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b6:	3c 0a                	cmp    $0xa,%al
 4b8:	74 13                	je     4cd <gets+0x66>
 4ba:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4be:	3c 0d                	cmp    $0xd,%al
 4c0:	74 0b                	je     4cd <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c5:	83 c0 01             	add    $0x1,%eax
 4c8:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4cb:	7c a9                	jl     476 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
 4d3:	01 d0                	add    %edx,%eax
 4d5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4db:	c9                   	leave  
 4dc:	c3                   	ret    

000004dd <stat>:

int
stat(char *n, struct stat *st)
{
 4dd:	55                   	push   %ebp
 4de:	89 e5                	mov    %esp,%ebp
 4e0:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4ea:	00 
 4eb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ee:	89 04 24             	mov    %eax,(%esp)
 4f1:	e8 07 01 00 00       	call   5fd <open>
 4f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4fd:	79 07                	jns    506 <stat+0x29>
    return -1;
 4ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 504:	eb 23                	jmp    529 <stat+0x4c>
  r = fstat(fd, st);
 506:	8b 45 0c             	mov    0xc(%ebp),%eax
 509:	89 44 24 04          	mov    %eax,0x4(%esp)
 50d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 510:	89 04 24             	mov    %eax,(%esp)
 513:	e8 fd 00 00 00       	call   615 <fstat>
 518:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 51b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51e:	89 04 24             	mov    %eax,(%esp)
 521:	e8 bf 00 00 00       	call   5e5 <close>
  return r;
 526:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 529:	c9                   	leave  
 52a:	c3                   	ret    

0000052b <atoi>:

int
atoi(const char *s)
{
 52b:	55                   	push   %ebp
 52c:	89 e5                	mov    %esp,%ebp
 52e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 531:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 538:	eb 25                	jmp    55f <atoi+0x34>
    n = n*10 + *s++ - '0';
 53a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 53d:	89 d0                	mov    %edx,%eax
 53f:	c1 e0 02             	shl    $0x2,%eax
 542:	01 d0                	add    %edx,%eax
 544:	01 c0                	add    %eax,%eax
 546:	89 c1                	mov    %eax,%ecx
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	8d 50 01             	lea    0x1(%eax),%edx
 54e:	89 55 08             	mov    %edx,0x8(%ebp)
 551:	0f b6 00             	movzbl (%eax),%eax
 554:	0f be c0             	movsbl %al,%eax
 557:	01 c8                	add    %ecx,%eax
 559:	83 e8 30             	sub    $0x30,%eax
 55c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 55f:	8b 45 08             	mov    0x8(%ebp),%eax
 562:	0f b6 00             	movzbl (%eax),%eax
 565:	3c 2f                	cmp    $0x2f,%al
 567:	7e 0a                	jle    573 <atoi+0x48>
 569:	8b 45 08             	mov    0x8(%ebp),%eax
 56c:	0f b6 00             	movzbl (%eax),%eax
 56f:	3c 39                	cmp    $0x39,%al
 571:	7e c7                	jle    53a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 573:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 576:	c9                   	leave  
 577:	c3                   	ret    

00000578 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 578:	55                   	push   %ebp
 579:	89 e5                	mov    %esp,%ebp
 57b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 57e:	8b 45 08             	mov    0x8(%ebp),%eax
 581:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 584:	8b 45 0c             	mov    0xc(%ebp),%eax
 587:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 58a:	eb 17                	jmp    5a3 <memmove+0x2b>
    *dst++ = *src++;
 58c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 58f:	8d 50 01             	lea    0x1(%eax),%edx
 592:	89 55 fc             	mov    %edx,-0x4(%ebp)
 595:	8b 55 f8             	mov    -0x8(%ebp),%edx
 598:	8d 4a 01             	lea    0x1(%edx),%ecx
 59b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 59e:	0f b6 12             	movzbl (%edx),%edx
 5a1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5a3:	8b 45 10             	mov    0x10(%ebp),%eax
 5a6:	8d 50 ff             	lea    -0x1(%eax),%edx
 5a9:	89 55 10             	mov    %edx,0x10(%ebp)
 5ac:	85 c0                	test   %eax,%eax
 5ae:	7f dc                	jg     58c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5b3:	c9                   	leave  
 5b4:	c3                   	ret    

000005b5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5b5:	b8 01 00 00 00       	mov    $0x1,%eax
 5ba:	cd 40                	int    $0x40
 5bc:	c3                   	ret    

000005bd <exit>:
SYSCALL(exit)
 5bd:	b8 02 00 00 00       	mov    $0x2,%eax
 5c2:	cd 40                	int    $0x40
 5c4:	c3                   	ret    

000005c5 <wait>:
SYSCALL(wait)
 5c5:	b8 03 00 00 00       	mov    $0x3,%eax
 5ca:	cd 40                	int    $0x40
 5cc:	c3                   	ret    

000005cd <pipe>:
SYSCALL(pipe)
 5cd:	b8 04 00 00 00       	mov    $0x4,%eax
 5d2:	cd 40                	int    $0x40
 5d4:	c3                   	ret    

000005d5 <read>:
SYSCALL(read)
 5d5:	b8 05 00 00 00       	mov    $0x5,%eax
 5da:	cd 40                	int    $0x40
 5dc:	c3                   	ret    

000005dd <write>:
SYSCALL(write)
 5dd:	b8 10 00 00 00       	mov    $0x10,%eax
 5e2:	cd 40                	int    $0x40
 5e4:	c3                   	ret    

000005e5 <close>:
SYSCALL(close)
 5e5:	b8 15 00 00 00       	mov    $0x15,%eax
 5ea:	cd 40                	int    $0x40
 5ec:	c3                   	ret    

000005ed <kill>:
SYSCALL(kill)
 5ed:	b8 06 00 00 00       	mov    $0x6,%eax
 5f2:	cd 40                	int    $0x40
 5f4:	c3                   	ret    

000005f5 <exec>:
SYSCALL(exec)
 5f5:	b8 07 00 00 00       	mov    $0x7,%eax
 5fa:	cd 40                	int    $0x40
 5fc:	c3                   	ret    

000005fd <open>:
SYSCALL(open)
 5fd:	b8 0f 00 00 00       	mov    $0xf,%eax
 602:	cd 40                	int    $0x40
 604:	c3                   	ret    

00000605 <mknod>:
SYSCALL(mknod)
 605:	b8 11 00 00 00       	mov    $0x11,%eax
 60a:	cd 40                	int    $0x40
 60c:	c3                   	ret    

0000060d <unlink>:
SYSCALL(unlink)
 60d:	b8 12 00 00 00       	mov    $0x12,%eax
 612:	cd 40                	int    $0x40
 614:	c3                   	ret    

00000615 <fstat>:
SYSCALL(fstat)
 615:	b8 08 00 00 00       	mov    $0x8,%eax
 61a:	cd 40                	int    $0x40
 61c:	c3                   	ret    

0000061d <link>:
SYSCALL(link)
 61d:	b8 13 00 00 00       	mov    $0x13,%eax
 622:	cd 40                	int    $0x40
 624:	c3                   	ret    

00000625 <mkdir>:
SYSCALL(mkdir)
 625:	b8 14 00 00 00       	mov    $0x14,%eax
 62a:	cd 40                	int    $0x40
 62c:	c3                   	ret    

0000062d <chdir>:
SYSCALL(chdir)
 62d:	b8 09 00 00 00       	mov    $0x9,%eax
 632:	cd 40                	int    $0x40
 634:	c3                   	ret    

00000635 <dup>:
SYSCALL(dup)
 635:	b8 0a 00 00 00       	mov    $0xa,%eax
 63a:	cd 40                	int    $0x40
 63c:	c3                   	ret    

0000063d <getpid>:
SYSCALL(getpid)
 63d:	b8 0b 00 00 00       	mov    $0xb,%eax
 642:	cd 40                	int    $0x40
 644:	c3                   	ret    

00000645 <sbrk>:
SYSCALL(sbrk)
 645:	b8 0c 00 00 00       	mov    $0xc,%eax
 64a:	cd 40                	int    $0x40
 64c:	c3                   	ret    

0000064d <sleep>:
SYSCALL(sleep)
 64d:	b8 0d 00 00 00       	mov    $0xd,%eax
 652:	cd 40                	int    $0x40
 654:	c3                   	ret    

00000655 <uptime>:
SYSCALL(uptime)
 655:	b8 0e 00 00 00       	mov    $0xe,%eax
 65a:	cd 40                	int    $0x40
 65c:	c3                   	ret    

0000065d <kthread_create>:
SYSCALL(kthread_create)
 65d:	b8 17 00 00 00       	mov    $0x17,%eax
 662:	cd 40                	int    $0x40
 664:	c3                   	ret    

00000665 <kthread_join>:
SYSCALL(kthread_join)
 665:	b8 16 00 00 00       	mov    $0x16,%eax
 66a:	cd 40                	int    $0x40
 66c:	c3                   	ret    

0000066d <kthread_mutex_init>:
SYSCALL(kthread_mutex_init)
 66d:	b8 18 00 00 00       	mov    $0x18,%eax
 672:	cd 40                	int    $0x40
 674:	c3                   	ret    

00000675 <kthread_mutex_destroy>:
SYSCALL(kthread_mutex_destroy)
 675:	b8 19 00 00 00       	mov    $0x19,%eax
 67a:	cd 40                	int    $0x40
 67c:	c3                   	ret    

0000067d <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 67d:	b8 1a 00 00 00       	mov    $0x1a,%eax
 682:	cd 40                	int    $0x40
 684:	c3                   	ret    

00000685 <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 685:	b8 1b 00 00 00       	mov    $0x1b,%eax
 68a:	cd 40                	int    $0x40
 68c:	c3                   	ret    

0000068d <kthread_cond_init>:
SYSCALL(kthread_cond_init)
 68d:	b8 1c 00 00 00       	mov    $0x1c,%eax
 692:	cd 40                	int    $0x40
 694:	c3                   	ret    

00000695 <kthread_cond_destroy>:
SYSCALL(kthread_cond_destroy)
 695:	b8 1d 00 00 00       	mov    $0x1d,%eax
 69a:	cd 40                	int    $0x40
 69c:	c3                   	ret    

0000069d <kthread_cond_wait>:
SYSCALL(kthread_cond_wait)
 69d:	b8 1e 00 00 00       	mov    $0x1e,%eax
 6a2:	cd 40                	int    $0x40
 6a4:	c3                   	ret    

000006a5 <kthread_cond_signal>:
SYSCALL(kthread_cond_signal)
 6a5:	b8 1f 00 00 00       	mov    $0x1f,%eax
 6aa:	cd 40                	int    $0x40
 6ac:	c3                   	ret    

000006ad <kthread_cond_broadcast>:
 6ad:	b8 20 00 00 00       	mov    $0x20,%eax
 6b2:	cd 40                	int    $0x40
 6b4:	c3                   	ret    

000006b5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6b5:	55                   	push   %ebp
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	83 ec 18             	sub    $0x18,%esp
 6bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 6be:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 6c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c8:	00 
 6c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d0:	8b 45 08             	mov    0x8(%ebp),%eax
 6d3:	89 04 24             	mov    %eax,(%esp)
 6d6:	e8 02 ff ff ff       	call   5dd <write>
}
 6db:	c9                   	leave  
 6dc:	c3                   	ret    

000006dd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6dd:	55                   	push   %ebp
 6de:	89 e5                	mov    %esp,%ebp
 6e0:	56                   	push   %esi
 6e1:	53                   	push   %ebx
 6e2:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6ec:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6f0:	74 17                	je     709 <printint+0x2c>
 6f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6f6:	79 11                	jns    709 <printint+0x2c>
    neg = 1;
 6f8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 702:	f7 d8                	neg    %eax
 704:	89 45 ec             	mov    %eax,-0x14(%ebp)
 707:	eb 06                	jmp    70f <printint+0x32>
  } else {
    x = xx;
 709:	8b 45 0c             	mov    0xc(%ebp),%eax
 70c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 70f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 716:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 719:	8d 41 01             	lea    0x1(%ecx),%eax
 71c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 71f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 722:	8b 45 ec             	mov    -0x14(%ebp),%eax
 725:	ba 00 00 00 00       	mov    $0x0,%edx
 72a:	f7 f3                	div    %ebx
 72c:	89 d0                	mov    %edx,%eax
 72e:	0f b6 80 5c 11 00 00 	movzbl 0x115c(%eax),%eax
 735:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 739:	8b 75 10             	mov    0x10(%ebp),%esi
 73c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 73f:	ba 00 00 00 00       	mov    $0x0,%edx
 744:	f7 f6                	div    %esi
 746:	89 45 ec             	mov    %eax,-0x14(%ebp)
 749:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 74d:	75 c7                	jne    716 <printint+0x39>
  if(neg)
 74f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 753:	74 10                	je     765 <printint+0x88>
    buf[i++] = '-';
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8d 50 01             	lea    0x1(%eax),%edx
 75b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 75e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 763:	eb 1f                	jmp    784 <printint+0xa7>
 765:	eb 1d                	jmp    784 <printint+0xa7>
    putc(fd, buf[i]);
 767:	8d 55 dc             	lea    -0x24(%ebp),%edx
 76a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76d:	01 d0                	add    %edx,%eax
 76f:	0f b6 00             	movzbl (%eax),%eax
 772:	0f be c0             	movsbl %al,%eax
 775:	89 44 24 04          	mov    %eax,0x4(%esp)
 779:	8b 45 08             	mov    0x8(%ebp),%eax
 77c:	89 04 24             	mov    %eax,(%esp)
 77f:	e8 31 ff ff ff       	call   6b5 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 784:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 788:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 78c:	79 d9                	jns    767 <printint+0x8a>
    putc(fd, buf[i]);
}
 78e:	83 c4 30             	add    $0x30,%esp
 791:	5b                   	pop    %ebx
 792:	5e                   	pop    %esi
 793:	5d                   	pop    %ebp
 794:	c3                   	ret    

00000795 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 795:	55                   	push   %ebp
 796:	89 e5                	mov    %esp,%ebp
 798:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 79b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7a2:	8d 45 0c             	lea    0xc(%ebp),%eax
 7a5:	83 c0 04             	add    $0x4,%eax
 7a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 7ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7b2:	e9 7c 01 00 00       	jmp    933 <printf+0x19e>
    c = fmt[i] & 0xff;
 7b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 7ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bd:	01 d0                	add    %edx,%eax
 7bf:	0f b6 00             	movzbl (%eax),%eax
 7c2:	0f be c0             	movsbl %al,%eax
 7c5:	25 ff 00 00 00       	and    $0xff,%eax
 7ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7d1:	75 2c                	jne    7ff <printf+0x6a>
      if(c == '%'){
 7d3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7d7:	75 0c                	jne    7e5 <printf+0x50>
        state = '%';
 7d9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7e0:	e9 4a 01 00 00       	jmp    92f <printf+0x19a>
      } else {
        putc(fd, c);
 7e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e8:	0f be c0             	movsbl %al,%eax
 7eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ef:	8b 45 08             	mov    0x8(%ebp),%eax
 7f2:	89 04 24             	mov    %eax,(%esp)
 7f5:	e8 bb fe ff ff       	call   6b5 <putc>
 7fa:	e9 30 01 00 00       	jmp    92f <printf+0x19a>
      }
    } else if(state == '%'){
 7ff:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 803:	0f 85 26 01 00 00    	jne    92f <printf+0x19a>
      if(c == 'd'){
 809:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 80d:	75 2d                	jne    83c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 80f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 81b:	00 
 81c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 823:	00 
 824:	89 44 24 04          	mov    %eax,0x4(%esp)
 828:	8b 45 08             	mov    0x8(%ebp),%eax
 82b:	89 04 24             	mov    %eax,(%esp)
 82e:	e8 aa fe ff ff       	call   6dd <printint>
        ap++;
 833:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 837:	e9 ec 00 00 00       	jmp    928 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 83c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 840:	74 06                	je     848 <printf+0xb3>
 842:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 846:	75 2d                	jne    875 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 848:	8b 45 e8             	mov    -0x18(%ebp),%eax
 84b:	8b 00                	mov    (%eax),%eax
 84d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 854:	00 
 855:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 85c:	00 
 85d:	89 44 24 04          	mov    %eax,0x4(%esp)
 861:	8b 45 08             	mov    0x8(%ebp),%eax
 864:	89 04 24             	mov    %eax,(%esp)
 867:	e8 71 fe ff ff       	call   6dd <printint>
        ap++;
 86c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 870:	e9 b3 00 00 00       	jmp    928 <printf+0x193>
      } else if(c == 's'){
 875:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 879:	75 45                	jne    8c0 <printf+0x12b>
        s = (char*)*ap;
 87b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 87e:	8b 00                	mov    (%eax),%eax
 880:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 883:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 887:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88b:	75 09                	jne    896 <printf+0x101>
          s = "(null)";
 88d:	c7 45 f4 06 0d 00 00 	movl   $0xd06,-0xc(%ebp)
        while(*s != 0){
 894:	eb 1e                	jmp    8b4 <printf+0x11f>
 896:	eb 1c                	jmp    8b4 <printf+0x11f>
          putc(fd, *s);
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	0f b6 00             	movzbl (%eax),%eax
 89e:	0f be c0             	movsbl %al,%eax
 8a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a5:	8b 45 08             	mov    0x8(%ebp),%eax
 8a8:	89 04 24             	mov    %eax,(%esp)
 8ab:	e8 05 fe ff ff       	call   6b5 <putc>
          s++;
 8b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 8b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b7:	0f b6 00             	movzbl (%eax),%eax
 8ba:	84 c0                	test   %al,%al
 8bc:	75 da                	jne    898 <printf+0x103>
 8be:	eb 68                	jmp    928 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8c0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 8c4:	75 1d                	jne    8e3 <printf+0x14e>
        putc(fd, *ap);
 8c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8c9:	8b 00                	mov    (%eax),%eax
 8cb:	0f be c0             	movsbl %al,%eax
 8ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 8d2:	8b 45 08             	mov    0x8(%ebp),%eax
 8d5:	89 04 24             	mov    %eax,(%esp)
 8d8:	e8 d8 fd ff ff       	call   6b5 <putc>
        ap++;
 8dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8e1:	eb 45                	jmp    928 <printf+0x193>
      } else if(c == '%'){
 8e3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8e7:	75 17                	jne    900 <printf+0x16b>
        putc(fd, c);
 8e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8ec:	0f be c0             	movsbl %al,%eax
 8ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 8f3:	8b 45 08             	mov    0x8(%ebp),%eax
 8f6:	89 04 24             	mov    %eax,(%esp)
 8f9:	e8 b7 fd ff ff       	call   6b5 <putc>
 8fe:	eb 28                	jmp    928 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 900:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 907:	00 
 908:	8b 45 08             	mov    0x8(%ebp),%eax
 90b:	89 04 24             	mov    %eax,(%esp)
 90e:	e8 a2 fd ff ff       	call   6b5 <putc>
        putc(fd, c);
 913:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 916:	0f be c0             	movsbl %al,%eax
 919:	89 44 24 04          	mov    %eax,0x4(%esp)
 91d:	8b 45 08             	mov    0x8(%ebp),%eax
 920:	89 04 24             	mov    %eax,(%esp)
 923:	e8 8d fd ff ff       	call   6b5 <putc>
      }
      state = 0;
 928:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 92f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 933:	8b 55 0c             	mov    0xc(%ebp),%edx
 936:	8b 45 f0             	mov    -0x10(%ebp),%eax
 939:	01 d0                	add    %edx,%eax
 93b:	0f b6 00             	movzbl (%eax),%eax
 93e:	84 c0                	test   %al,%al
 940:	0f 85 71 fe ff ff    	jne    7b7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 946:	c9                   	leave  
 947:	c3                   	ret    

00000948 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 948:	55                   	push   %ebp
 949:	89 e5                	mov    %esp,%ebp
 94b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 94e:	8b 45 08             	mov    0x8(%ebp),%eax
 951:	83 e8 08             	sub    $0x8,%eax
 954:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 957:	a1 88 11 00 00       	mov    0x1188,%eax
 95c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 95f:	eb 24                	jmp    985 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 961:	8b 45 fc             	mov    -0x4(%ebp),%eax
 964:	8b 00                	mov    (%eax),%eax
 966:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 969:	77 12                	ja     97d <free+0x35>
 96b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 971:	77 24                	ja     997 <free+0x4f>
 973:	8b 45 fc             	mov    -0x4(%ebp),%eax
 976:	8b 00                	mov    (%eax),%eax
 978:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 97b:	77 1a                	ja     997 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 980:	8b 00                	mov    (%eax),%eax
 982:	89 45 fc             	mov    %eax,-0x4(%ebp)
 985:	8b 45 f8             	mov    -0x8(%ebp),%eax
 988:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 98b:	76 d4                	jbe    961 <free+0x19>
 98d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 990:	8b 00                	mov    (%eax),%eax
 992:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 995:	76 ca                	jbe    961 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 997:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99a:	8b 40 04             	mov    0x4(%eax),%eax
 99d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a7:	01 c2                	add    %eax,%edx
 9a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ac:	8b 00                	mov    (%eax),%eax
 9ae:	39 c2                	cmp    %eax,%edx
 9b0:	75 24                	jne    9d6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 9b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9b5:	8b 50 04             	mov    0x4(%eax),%edx
 9b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bb:	8b 00                	mov    (%eax),%eax
 9bd:	8b 40 04             	mov    0x4(%eax),%eax
 9c0:	01 c2                	add    %eax,%edx
 9c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9cb:	8b 00                	mov    (%eax),%eax
 9cd:	8b 10                	mov    (%eax),%edx
 9cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d2:	89 10                	mov    %edx,(%eax)
 9d4:	eb 0a                	jmp    9e0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d9:	8b 10                	mov    (%eax),%edx
 9db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9de:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e3:	8b 40 04             	mov    0x4(%eax),%eax
 9e6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f0:	01 d0                	add    %edx,%eax
 9f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9f5:	75 20                	jne    a17 <free+0xcf>
    p->s.size += bp->s.size;
 9f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9fa:	8b 50 04             	mov    0x4(%eax),%edx
 9fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a00:	8b 40 04             	mov    0x4(%eax),%eax
 a03:	01 c2                	add    %eax,%edx
 a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a08:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a0e:	8b 10                	mov    (%eax),%edx
 a10:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a13:	89 10                	mov    %edx,(%eax)
 a15:	eb 08                	jmp    a1f <free+0xd7>
  } else
    p->s.ptr = bp;
 a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a1a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a1d:	89 10                	mov    %edx,(%eax)
  freep = p;
 a1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a22:	a3 88 11 00 00       	mov    %eax,0x1188
}
 a27:	c9                   	leave  
 a28:	c3                   	ret    

00000a29 <morecore>:

static Header*
morecore(uint nu)
{
 a29:	55                   	push   %ebp
 a2a:	89 e5                	mov    %esp,%ebp
 a2c:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a2f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a36:	77 07                	ja     a3f <morecore+0x16>
    nu = 4096;
 a38:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a3f:	8b 45 08             	mov    0x8(%ebp),%eax
 a42:	c1 e0 03             	shl    $0x3,%eax
 a45:	89 04 24             	mov    %eax,(%esp)
 a48:	e8 f8 fb ff ff       	call   645 <sbrk>
 a4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a50:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a54:	75 07                	jne    a5d <morecore+0x34>
    return 0;
 a56:	b8 00 00 00 00       	mov    $0x0,%eax
 a5b:	eb 22                	jmp    a7f <morecore+0x56>
  hp = (Header*)p;
 a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a66:	8b 55 08             	mov    0x8(%ebp),%edx
 a69:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a6f:	83 c0 08             	add    $0x8,%eax
 a72:	89 04 24             	mov    %eax,(%esp)
 a75:	e8 ce fe ff ff       	call   948 <free>
  return freep;
 a7a:	a1 88 11 00 00       	mov    0x1188,%eax
}
 a7f:	c9                   	leave  
 a80:	c3                   	ret    

00000a81 <malloc>:

void*
malloc(uint nbytes)
{
 a81:	55                   	push   %ebp
 a82:	89 e5                	mov    %esp,%ebp
 a84:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a87:	8b 45 08             	mov    0x8(%ebp),%eax
 a8a:	83 c0 07             	add    $0x7,%eax
 a8d:	c1 e8 03             	shr    $0x3,%eax
 a90:	83 c0 01             	add    $0x1,%eax
 a93:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a96:	a1 88 11 00 00       	mov    0x1188,%eax
 a9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 aa2:	75 23                	jne    ac7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 aa4:	c7 45 f0 80 11 00 00 	movl   $0x1180,-0x10(%ebp)
 aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aae:	a3 88 11 00 00       	mov    %eax,0x1188
 ab3:	a1 88 11 00 00       	mov    0x1188,%eax
 ab8:	a3 80 11 00 00       	mov    %eax,0x1180
    base.s.size = 0;
 abd:	c7 05 84 11 00 00 00 	movl   $0x0,0x1184
 ac4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aca:	8b 00                	mov    (%eax),%eax
 acc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 acf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad2:	8b 40 04             	mov    0x4(%eax),%eax
 ad5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 ad8:	72 4d                	jb     b27 <malloc+0xa6>
      if(p->s.size == nunits)
 ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
 add:	8b 40 04             	mov    0x4(%eax),%eax
 ae0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 ae3:	75 0c                	jne    af1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae8:	8b 10                	mov    (%eax),%edx
 aea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aed:	89 10                	mov    %edx,(%eax)
 aef:	eb 26                	jmp    b17 <malloc+0x96>
      else {
        p->s.size -= nunits;
 af1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af4:	8b 40 04             	mov    0x4(%eax),%eax
 af7:	2b 45 ec             	sub    -0x14(%ebp),%eax
 afa:	89 c2                	mov    %eax,%edx
 afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aff:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b05:	8b 40 04             	mov    0x4(%eax),%eax
 b08:	c1 e0 03             	shl    $0x3,%eax
 b0b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b11:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b14:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b17:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b1a:	a3 88 11 00 00       	mov    %eax,0x1188
      return (void*)(p + 1);
 b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b22:	83 c0 08             	add    $0x8,%eax
 b25:	eb 38                	jmp    b5f <malloc+0xde>
    }
    if(p == freep)
 b27:	a1 88 11 00 00       	mov    0x1188,%eax
 b2c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b2f:	75 1b                	jne    b4c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 b31:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b34:	89 04 24             	mov    %eax,(%esp)
 b37:	e8 ed fe ff ff       	call   a29 <morecore>
 b3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b3f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b43:	75 07                	jne    b4c <malloc+0xcb>
        return 0;
 b45:	b8 00 00 00 00       	mov    $0x0,%eax
 b4a:	eb 13                	jmp    b5f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b55:	8b 00                	mov    (%eax),%eax
 b57:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b5a:	e9 70 ff ff ff       	jmp    acf <malloc+0x4e>
}
 b5f:	c9                   	leave  
 b60:	c3                   	ret    

00000b61 <wrapper>:
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {
 b61:	55                   	push   %ebp
 b62:	89 e5                	mov    %esp,%ebp
 b64:	83 ec 18             	sub    $0x18,%esp

    func(arg);
 b67:	8b 45 0c             	mov    0xc(%ebp),%eax
 b6a:	89 04 24             	mov    %eax,(%esp)
 b6d:	8b 45 08             	mov    0x8(%ebp),%eax
 b70:	ff d0                	call   *%eax
    exit();
 b72:	e8 46 fa ff ff       	call   5bd <exit>

00000b77 <qthread_create>:
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {
 b77:	55                   	push   %ebp
 b78:	89 e5                	mov    %esp,%ebp
 b7a:	57                   	push   %edi
 b7b:	56                   	push   %esi
 b7c:	53                   	push   %ebx
 b7d:	83 ec 2c             	sub    $0x2c,%esp

    *thread = (qthread_t)malloc(sizeof(struct qthread));
 b80:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 b87:	e8 f5 fe ff ff       	call   a81 <malloc>
 b8c:	8b 55 08             	mov    0x8(%ebp),%edx
 b8f:	89 02                	mov    %eax,(%edx)
    int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
 b91:	8b 45 10             	mov    0x10(%ebp),%eax
 b94:	8b 38                	mov    (%eax),%edi
 b96:	8b 75 0c             	mov    0xc(%ebp),%esi
 b99:	bb 61 0b 00 00       	mov    $0xb61,%ebx
 b9e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 ba5:	e8 d7 fe ff ff       	call   a81 <malloc>
 baa:	05 00 10 00 00       	add    $0x1000,%eax
 baf:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 bb3:	89 74 24 08          	mov    %esi,0x8(%esp)
 bb7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 bbb:	89 04 24             	mov    %eax,(%esp)
 bbe:	e8 9a fa ff ff       	call   65d <kthread_create>
 bc3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    (*thread)->tid = t_id;
 bc6:	8b 45 08             	mov    0x8(%ebp),%eax
 bc9:	8b 00                	mov    (%eax),%eax
 bcb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 bce:	89 10                	mov    %edx,(%eax)
    return t_id;
 bd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
 bd3:	83 c4 2c             	add    $0x2c,%esp
 bd6:	5b                   	pop    %ebx
 bd7:	5e                   	pop    %esi
 bd8:	5f                   	pop    %edi
 bd9:	5d                   	pop    %ebp
 bda:	c3                   	ret    

00000bdb <qthread_join>:

int qthread_join(qthread_t thread, void **retval){
 bdb:	55                   	push   %ebp
 bdc:	89 e5                	mov    %esp,%ebp
 bde:	83 ec 28             	sub    $0x28,%esp

    int val = kthread_join(thread->tid, (int)retval);
 be1:	8b 55 0c             	mov    0xc(%ebp),%edx
 be4:	8b 45 08             	mov    0x8(%ebp),%eax
 be7:	8b 00                	mov    (%eax),%eax
 be9:	89 54 24 04          	mov    %edx,0x4(%esp)
 bed:	89 04 24             	mov    %eax,(%esp)
 bf0:	e8 70 fa ff ff       	call   665 <kthread_join>
 bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return val;
 bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 bfb:	c9                   	leave  
 bfc:	c3                   	ret    

00000bfd <qthread_mutex_init>:

int qthread_mutex_init(qthread_mutex_t *mutex){
 bfd:	55                   	push   %ebp
 bfe:	89 e5                	mov    %esp,%ebp
 c00:	83 ec 08             	sub    $0x8,%esp
	*mutex = kthread_mutex_init();
 c03:	e8 65 fa ff ff       	call   66d <kthread_mutex_init>
 c08:	8b 55 08             	mov    0x8(%ebp),%edx
 c0b:	89 02                	mov    %eax,(%edx)
	if (*mutex > 0){
 c0d:	8b 45 08             	mov    0x8(%ebp),%eax
 c10:	8b 00                	mov    (%eax),%eax
 c12:	85 c0                	test   %eax,%eax
 c14:	7e 07                	jle    c1d <qthread_mutex_init+0x20>
		return 0;
 c16:	b8 00 00 00 00       	mov    $0x0,%eax
 c1b:	eb 05                	jmp    c22 <qthread_mutex_init+0x25>
	}
	return *mutex;
 c1d:	8b 45 08             	mov    0x8(%ebp),%eax
 c20:	8b 00                	mov    (%eax),%eax
}
 c22:	c9                   	leave  
 c23:	c3                   	ret    

00000c24 <qthread_mutex_destroy>:

int qthread_mutex_destroy(qthread_mutex_t *mutex){
 c24:	55                   	push   %ebp
 c25:	89 e5                	mov    %esp,%ebp
 c27:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_destroy((int)mutex);
 c2a:	8b 45 08             	mov    0x8(%ebp),%eax
 c2d:	89 04 24             	mov    %eax,(%esp)
 c30:	e8 40 fa ff ff       	call   675 <kthread_mutex_destroy>
 c35:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 c38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c3c:	79 07                	jns    c45 <qthread_mutex_destroy+0x21>
    	return -1;
 c3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c43:	eb 05                	jmp    c4a <qthread_mutex_destroy+0x26>
    }
    return 0;
 c45:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c4a:	c9                   	leave  
 c4b:	c3                   	ret    

00000c4c <qthread_mutex_lock>:

int qthread_mutex_lock(qthread_mutex_t *mutex){
 c4c:	55                   	push   %ebp
 c4d:	89 e5                	mov    %esp,%ebp
 c4f:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_lock((int)mutex);
 c52:	8b 45 08             	mov    0x8(%ebp),%eax
 c55:	89 04 24             	mov    %eax,(%esp)
 c58:	e8 20 fa ff ff       	call   67d <kthread_mutex_lock>
 c5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 c60:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c64:	79 07                	jns    c6d <qthread_mutex_lock+0x21>
    	return -1;
 c66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c6b:	eb 05                	jmp    c72 <qthread_mutex_lock+0x26>
    }
    return 0;
 c6d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c72:	c9                   	leave  
 c73:	c3                   	ret    

00000c74 <qthread_mutex_unlock>:

int qthread_mutex_unlock(qthread_mutex_t *mutex){
 c74:	55                   	push   %ebp
 c75:	89 e5                	mov    %esp,%ebp
 c77:	83 ec 28             	sub    $0x28,%esp
    int val = kthread_mutex_unlock((int)mutex);
 c7a:	8b 45 08             	mov    0x8(%ebp),%eax
 c7d:	89 04 24             	mov    %eax,(%esp)
 c80:	e8 00 fa ff ff       	call   685 <kthread_mutex_unlock>
 c85:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (val < 0){
 c88:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c8c:	79 07                	jns    c95 <qthread_mutex_unlock+0x21>
    	return -1;
 c8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c93:	eb 05                	jmp    c9a <qthread_mutex_unlock+0x26>
    }
    return 0;
 c95:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c9a:	c9                   	leave  
 c9b:	c3                   	ret    

00000c9c <qthread_cond_init>:

int qthread_cond_init(qthread_cond_t *cond){
 c9c:	55                   	push   %ebp
 c9d:	89 e5                	mov    %esp,%ebp

	return 0;
 c9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ca4:	5d                   	pop    %ebp
 ca5:	c3                   	ret    

00000ca6 <qthread_cond_destroy>:

int qthread_cond_destroy(qthread_cond_t *cond){
 ca6:	55                   	push   %ebp
 ca7:	89 e5                	mov    %esp,%ebp
    
    return 0;
 ca9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 cae:	5d                   	pop    %ebp
 caf:	c3                   	ret    

00000cb0 <qthread_cond_signal>:

int qthread_cond_signal(qthread_cond_t *cond){
 cb0:	55                   	push   %ebp
 cb1:	89 e5                	mov    %esp,%ebp
    
    return 0;
 cb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 cb8:	5d                   	pop    %ebp
 cb9:	c3                   	ret    

00000cba <qthread_cond_broadcast>:

int qthread_cond_broadcast(qthread_cond_t *cond){
 cba:	55                   	push   %ebp
 cbb:	89 e5                	mov    %esp,%ebp
	return 0;
 cbd:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 cc2:	5d                   	pop    %ebp
 cc3:	c3                   	ret    

00000cc4 <qthread_cond_wait>:

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
 cc4:	55                   	push   %ebp
 cc5:	89 e5                	mov    %esp,%ebp
	return 0;
 cc7:	b8 00 00 00 00       	mov    $0x0,%eax
    
}
 ccc:	5d                   	pop    %ebp
 ccd:	c3                   	ret    
