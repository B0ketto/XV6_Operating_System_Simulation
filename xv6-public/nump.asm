
_nump:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
            free(a);
         } // Simulate some busy work
    }
}

int main(void) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
    int pid1 = fork();
  14:	e8 92 03 00 00       	call   3ab <fork>
    if (pid1 == 0)
  19:	85 c0                	test   %eax,%eax
  1b:	75 0f                	jne    2c <main+0x2c>
    {
        // Child process 1

        busy_loop1(SHORT_LOOP); 
  1d:	83 ec 0c             	sub    $0xc,%esp
  20:	6a 64                	push   $0x64
  22:	e8 79 00 00 00       	call   a0 <busy_loop1>
        exit();
  27:	e8 87 03 00 00       	call   3b3 <exit>
    }
    else if(fork()==0)
  2c:	e8 7a 03 00 00       	call   3ab <fork>
  31:	85 c0                	test   %eax,%eax
  33:	75 12                	jne    47 <main+0x47>
    {
        // Child process 2
        busy_loop2(LONG_LOOP); 
  35:	83 ec 0c             	sub    $0xc,%esp
  38:	68 e8 03 00 00       	push   $0x3e8
  3d:	e8 5e 00 00 00       	call   a0 <busy_loop1>
        exit();
  42:	e8 6c 03 00 00       	call   3b3 <exit>
    }

    // Parent process
    int n1 = numberofprocesses();
  47:	e8 0f 04 00 00       	call   45b <numberofprocesses>
  4c:	89 c7                	mov    %eax,%edi

    wait(); // Wait for child 1
  4e:	e8 68 03 00 00       	call   3bb <wait>
    int n2 = numberofprocesses();
  53:	e8 03 04 00 00       	call   45b <numberofprocesses>
  58:	89 c6                	mov    %eax,%esi

    wait(); // Wait for child 2
  5a:	e8 5c 03 00 00       	call   3bb <wait>
    int n3= numberofprocesses();
  5f:	e8 f7 03 00 00       	call   45b <numberofprocesses>
  64:	89 c3                	mov    %eax,%ebx

    printf(1, "ready processes: %d\n", n1);
  66:	50                   	push   %eax
  67:	57                   	push   %edi
  68:	68 88 08 00 00       	push   $0x888
  6d:	6a 01                	push   $0x1
  6f:	e8 ec 04 00 00       	call   560 <printf>
    printf(1, "ready processes: %d\n", n2);
  74:	83 c4 0c             	add    $0xc,%esp
  77:	56                   	push   %esi
  78:	68 88 08 00 00       	push   $0x888
  7d:	6a 01                	push   $0x1
  7f:	e8 dc 04 00 00       	call   560 <printf>
    printf(1, "ready processes: %d\n", n3);
  84:	83 c4 0c             	add    $0xc,%esp
  87:	53                   	push   %ebx
  88:	68 88 08 00 00       	push   $0x888
  8d:	6a 01                	push   $0x1
  8f:	e8 cc 04 00 00       	call   560 <printf>



    exit();
  94:	e8 1a 03 00 00       	call   3b3 <exit>
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <busy_loop1>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	31 f6                	xor    %esi,%esi
  a7:	53                   	push   %ebx
  a8:	83 ec 0c             	sub    $0xc,%esp
    for (i = 0; i < n; i++) {
  ab:	8b 45 08             	mov    0x8(%ebp),%eax
  ae:	85 c0                	test   %eax,%eax
  b0:	7e 3e                	jle    f0 <busy_loop1+0x50>
  b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  b8:	31 db                	xor    %ebx,%ebx
        for (int j = 0; j < n; j++)
  ba:	31 ff                	xor    %edi,%edi
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    	    int*a =malloc(sizeof(int));
  c0:	83 ec 0c             	sub    $0xc,%esp
  c3:	6a 04                	push   $0x4
  c5:	e8 c6 06 00 00       	call   790 <malloc>
            *a=i*j;
  ca:	89 18                	mov    %ebx,(%eax)
        for (int j = 0; j < n; j++)
  cc:	01 f3                	add    %esi,%ebx
            free(a);
  ce:	89 04 24             	mov    %eax,(%esp)
  d1:	e8 2a 06 00 00       	call   700 <free>
        for (int j = 0; j < n; j++)
  d6:	89 f8                	mov    %edi,%eax
  d8:	83 c4 10             	add    $0x10,%esp
  db:	83 c7 01             	add    $0x1,%edi
  de:	39 7d 08             	cmp    %edi,0x8(%ebp)
  e1:	75 dd                	jne    c0 <busy_loop1+0x20>
    for (i = 0; i < n; i++) {
  e3:	8d 56 01             	lea    0x1(%esi),%edx
  e6:	39 c6                	cmp    %eax,%esi
  e8:	74 06                	je     f0 <busy_loop1+0x50>
  ea:	89 d6                	mov    %edx,%esi
  ec:	eb ca                	jmp    b8 <busy_loop1+0x18>
  ee:	66 90                	xchg   %ax,%ax
}
  f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  f5:	5f                   	pop    %edi
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret    
  f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff:	90                   	nop

00000100 <busy_loop2>:
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	83 ec 0c             	sub    $0xc,%esp
 109:	8b 45 08             	mov    0x8(%ebp),%eax
 10c:	85 c0                	test   %eax,%eax
 10e:	7e 40                	jle    150 <busy_loop2+0x50>
 110:	31 f6                	xor    %esi,%esi
 112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 118:	31 db                	xor    %ebx,%ebx
 11a:	31 ff                	xor    %edi,%edi
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	6a 04                	push   $0x4
 125:	e8 66 06 00 00       	call   790 <malloc>
 12a:	89 18                	mov    %ebx,(%eax)
 12c:	01 f3                	add    %esi,%ebx
 12e:	89 04 24             	mov    %eax,(%esp)
 131:	e8 ca 05 00 00       	call   700 <free>
 136:	89 f8                	mov    %edi,%eax
 138:	83 c4 10             	add    $0x10,%esp
 13b:	83 c7 01             	add    $0x1,%edi
 13e:	39 7d 08             	cmp    %edi,0x8(%ebp)
 141:	75 dd                	jne    120 <busy_loop2+0x20>
 143:	8d 56 01             	lea    0x1(%esi),%edx
 146:	39 c6                	cmp    %eax,%esi
 148:	74 06                	je     150 <busy_loop2+0x50>
 14a:	89 d6                	mov    %edx,%esi
 14c:	eb ca                	jmp    118 <busy_loop2+0x18>
 14e:	66 90                	xchg   %ax,%ax
 150:	8d 65 f4             	lea    -0xc(%ebp),%esp
 153:	5b                   	pop    %ebx
 154:	5e                   	pop    %esi
 155:	5f                   	pop    %edi
 156:	5d                   	pop    %ebp
 157:	c3                   	ret    
 158:	66 90                	xchg   %ax,%ax
 15a:	66 90                	xchg   %ax,%ax
 15c:	66 90                	xchg   %ax,%ax
 15e:	66 90                	xchg   %ax,%ax

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 160:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 161:	31 c0                	xor    %eax,%eax
{
 163:	89 e5                	mov    %esp,%ebp
 165:	53                   	push   %ebx
 166:	8b 4d 08             	mov    0x8(%ebp),%ecx
 169:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 170:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 174:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 177:	83 c0 01             	add    $0x1,%eax
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 17e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 181:	89 c8                	mov    %ecx,%eax
 183:	c9                   	leave  
 184:	c3                   	ret    
 185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 55 08             	mov    0x8(%ebp),%edx
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 19a:	0f b6 02             	movzbl (%edx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 17                	jne    1b8 <strcmp+0x28>
 1a1:	eb 3a                	jmp    1dd <strcmp+0x4d>
 1a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a7:	90                   	nop
 1a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1ac:	83 c2 01             	add    $0x1,%edx
 1af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1b2:	84 c0                	test   %al,%al
 1b4:	74 1a                	je     1d0 <strcmp+0x40>
    p++, q++;
 1b6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 1b8:	0f b6 19             	movzbl (%ecx),%ebx
 1bb:	38 c3                	cmp    %al,%bl
 1bd:	74 e9                	je     1a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1bf:	29 d8                	sub    %ebx,%eax
}
 1c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c4:	c9                   	leave  
 1c5:	c3                   	ret    
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1d4:	31 c0                	xor    %eax,%eax
 1d6:	29 d8                	sub    %ebx,%eax
}
 1d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1db:	c9                   	leave  
 1dc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 1dd:	0f b6 19             	movzbl (%ecx),%ebx
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	eb db                	jmp    1bf <strcmp+0x2f>
 1e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop

000001f0 <strlen>:

uint
strlen(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1f6:	80 3a 00             	cmpb   $0x0,(%edx)
 1f9:	74 15                	je     210 <strlen+0x20>
 1fb:	31 c0                	xor    %eax,%eax
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 c0 01             	add    $0x1,%eax
 203:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 207:	89 c1                	mov    %eax,%ecx
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	89 c8                	mov    %ecx,%eax
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop
  for(n = 0; s[n]; n++)
 210:	31 c9                	xor    %ecx,%ecx
}
 212:	5d                   	pop    %ebp
 213:	89 c8                	mov    %ecx,%eax
 215:	c3                   	ret    
 216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 227:	8b 4d 10             	mov    0x10(%ebp),%ecx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld    
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	8b 7d fc             	mov    -0x4(%ebp),%edi
 235:	89 d0                	mov    %edx,%eax
 237:	c9                   	leave  
 238:	c3                   	ret    
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 24a:	0f b6 10             	movzbl (%eax),%edx
 24d:	84 d2                	test   %dl,%dl
 24f:	75 12                	jne    263 <strchr+0x23>
 251:	eb 1d                	jmp    270 <strchr+0x30>
 253:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 257:	90                   	nop
 258:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 25c:	83 c0 01             	add    $0x1,%eax
 25f:	84 d2                	test   %dl,%dl
 261:	74 0d                	je     270 <strchr+0x30>
    if(*s == c)
 263:	38 d1                	cmp    %dl,%cl
 265:	75 f1                	jne    258 <strchr+0x18>
      return (char*)s;
  return 0;
}
 267:	5d                   	pop    %ebp
 268:	c3                   	ret    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 270:	31 c0                	xor    %eax,%eax
}
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    
 274:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 27f:	90                   	nop

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 285:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 288:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 289:	31 db                	xor    %ebx,%ebx
{
 28b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 28e:	eb 27                	jmp    2b7 <gets+0x37>
    cc = read(0, &c, 1);
 290:	83 ec 04             	sub    $0x4,%esp
 293:	6a 01                	push   $0x1
 295:	57                   	push   %edi
 296:	6a 00                	push   $0x0
 298:	e8 2e 01 00 00       	call   3cb <read>
    if(cc < 1)
 29d:	83 c4 10             	add    $0x10,%esp
 2a0:	85 c0                	test   %eax,%eax
 2a2:	7e 1d                	jle    2c1 <gets+0x41>
      break;
    buf[i++] = c;
 2a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2af:	3c 0a                	cmp    $0xa,%al
 2b1:	74 1d                	je     2d0 <gets+0x50>
 2b3:	3c 0d                	cmp    $0xd,%al
 2b5:	74 19                	je     2d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 2b7:	89 de                	mov    %ebx,%esi
 2b9:	83 c3 01             	add    $0x1,%ebx
 2bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2bf:	7c cf                	jl     290 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2cb:	5b                   	pop    %ebx
 2cc:	5e                   	pop    %esi
 2cd:	5f                   	pop    %edi
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    
  buf[i] = '\0';
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	89 de                	mov    %ebx,%esi
 2d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dc:	5b                   	pop    %ebx
 2dd:	5e                   	pop    %esi
 2de:	5f                   	pop    %edi
 2df:	5d                   	pop    %ebp
 2e0:	c3                   	ret    
 2e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ef:	90                   	nop

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f5:	83 ec 08             	sub    $0x8,%esp
 2f8:	6a 00                	push   $0x0
 2fa:	ff 75 08             	push   0x8(%ebp)
 2fd:	e8 f1 00 00 00       	call   3f3 <open>
  if(fd < 0)
 302:	83 c4 10             	add    $0x10,%esp
 305:	85 c0                	test   %eax,%eax
 307:	78 27                	js     330 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 309:	83 ec 08             	sub    $0x8,%esp
 30c:	ff 75 0c             	push   0xc(%ebp)
 30f:	89 c3                	mov    %eax,%ebx
 311:	50                   	push   %eax
 312:	e8 f4 00 00 00       	call   40b <fstat>
  close(fd);
 317:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 31a:	89 c6                	mov    %eax,%esi
  close(fd);
 31c:	e8 ba 00 00 00       	call   3db <close>
  return r;
 321:	83 c4 10             	add    $0x10,%esp
}
 324:	8d 65 f8             	lea    -0x8(%ebp),%esp
 327:	89 f0                	mov    %esi,%eax
 329:	5b                   	pop    %ebx
 32a:	5e                   	pop    %esi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 330:	be ff ff ff ff       	mov    $0xffffffff,%esi
 335:	eb ed                	jmp    324 <stat+0x34>
 337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33e:	66 90                	xchg   %ax,%ax

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 02             	movsbl (%edx),%eax
 34a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 34d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 350:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 355:	77 1e                	ja     375 <atoi+0x35>
 357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 360:	83 c2 01             	add    $0x1,%edx
 363:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 366:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 36a:	0f be 02             	movsbl (%edx),%eax
 36d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x20>
  return n;
}
 375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 378:	89 c8                	mov    %ecx,%eax
 37a:	c9                   	leave  
 37b:	c3                   	ret    
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	8b 45 10             	mov    0x10(%ebp),%eax
 387:	8b 55 08             	mov    0x8(%ebp),%edx
 38a:	56                   	push   %esi
 38b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38e:	85 c0                	test   %eax,%eax
 390:	7e 13                	jle    3a5 <memmove+0x25>
 392:	01 d0                	add    %edx,%eax
  dst = vdst;
 394:	89 d7                	mov    %edx,%edi
 396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3a1:	39 f8                	cmp    %edi,%eax
 3a3:	75 fb                	jne    3a0 <memmove+0x20>
  return vdst;
}
 3a5:	5e                   	pop    %esi
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	5f                   	pop    %edi
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    

000003ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ab:	b8 01 00 00 00       	mov    $0x1,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <exit>:
SYSCALL(exit)
 3b3:	b8 02 00 00 00       	mov    $0x2,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait>:
SYSCALL(wait)
 3bb:	b8 03 00 00 00       	mov    $0x3,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <pipe>:
SYSCALL(pipe)
 3c3:	b8 04 00 00 00       	mov    $0x4,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <read>:
SYSCALL(read)
 3cb:	b8 05 00 00 00       	mov    $0x5,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <write>:
SYSCALL(write)
 3d3:	b8 10 00 00 00       	mov    $0x10,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <close>:
SYSCALL(close)
 3db:	b8 15 00 00 00       	mov    $0x15,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <kill>:
SYSCALL(kill)
 3e3:	b8 06 00 00 00       	mov    $0x6,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exec>:
SYSCALL(exec)
 3eb:	b8 07 00 00 00       	mov    $0x7,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <open>:
SYSCALL(open)
 3f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mknod>:
SYSCALL(mknod)
 3fb:	b8 11 00 00 00       	mov    $0x11,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <unlink>:
SYSCALL(unlink)
 403:	b8 12 00 00 00       	mov    $0x12,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <fstat>:
SYSCALL(fstat)
 40b:	b8 08 00 00 00       	mov    $0x8,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <link>:
SYSCALL(link)
 413:	b8 13 00 00 00       	mov    $0x13,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mkdir>:
SYSCALL(mkdir)
 41b:	b8 14 00 00 00       	mov    $0x14,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <chdir>:
SYSCALL(chdir)
 423:	b8 09 00 00 00       	mov    $0x9,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <dup>:
SYSCALL(dup)
 42b:	b8 0a 00 00 00       	mov    $0xa,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getpid>:
SYSCALL(getpid)
 433:	b8 0b 00 00 00       	mov    $0xb,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <sbrk>:
SYSCALL(sbrk)
 43b:	b8 0c 00 00 00       	mov    $0xc,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sleep>:
SYSCALL(sleep)
 443:	b8 0d 00 00 00       	mov    $0xd,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <uptime>:
SYSCALL(uptime)
 44b:	b8 0e 00 00 00       	mov    $0xe,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <worldpeace>:
SYSCALL(worldpeace)
 453:	b8 17 00 00 00       	mov    $0x17,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <numberofprocesses>:
SYSCALL(numberofprocesses)
 45b:	b8 18 00 00 00       	mov    $0x18,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <spawn>:
SYSCALL(spawn)
 463:	b8 1a 00 00 00       	mov    $0x1a,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <getvasize>:
SYSCALL(getvasize)
 46b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <va_to_pa>:
SYSCALL(va_to_pa)
 473:	b8 1d 00 00 00       	mov    $0x1d,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 47b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 483:	b8 1f 00 00 00       	mov    $0x1f,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 48b:	b8 20 00 00 00       	mov    $0x20,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <getpasize>:
SYSCALL(getpasize)
 493:	b8 22 00 00 00       	mov    $0x22,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <mmap>:
 49b:	b8 23 00 00 00       	mov    $0x23,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    
 4a3:	66 90                	xchg   %ax,%ax
 4a5:	66 90                	xchg   %ax,%ax
 4a7:	66 90                	xchg   %ax,%ax
 4a9:	66 90                	xchg   %ax,%ax
 4ab:	66 90                	xchg   %ax,%ax
 4ad:	66 90                	xchg   %ax,%ax
 4af:	90                   	nop

000004b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 3c             	sub    $0x3c,%esp
 4b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4bc:	89 d1                	mov    %edx,%ecx
{
 4be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4c1:	85 d2                	test   %edx,%edx
 4c3:	0f 89 7f 00 00 00    	jns    548 <printint+0x98>
 4c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4cd:	74 79                	je     548 <printint+0x98>
    neg = 1;
 4cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4d8:	31 db                	xor    %ebx,%ebx
 4da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	89 cf                	mov    %ecx,%edi
 4e6:	f7 75 c4             	divl   -0x3c(%ebp)
 4e9:	0f b6 92 fc 08 00 00 	movzbl 0x8fc(%edx),%edx
 4f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4f3:	89 d8                	mov    %ebx,%eax
 4f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 501:	76 dd                	jbe    4e0 <printint+0x30>
  if(neg)
 503:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 506:	85 c9                	test   %ecx,%ecx
 508:	74 0c                	je     516 <printint+0x66>
    buf[i++] = '-';
 50a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 50f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 511:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 516:	8b 7d b8             	mov    -0x48(%ebp),%edi
 519:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 51d:	eb 07                	jmp    526 <printint+0x76>
 51f:	90                   	nop
    putc(fd, buf[i]);
 520:	0f b6 13             	movzbl (%ebx),%edx
 523:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 526:	83 ec 04             	sub    $0x4,%esp
 529:	88 55 d7             	mov    %dl,-0x29(%ebp)
 52c:	6a 01                	push   $0x1
 52e:	56                   	push   %esi
 52f:	57                   	push   %edi
 530:	e8 9e fe ff ff       	call   3d3 <write>
  while(--i >= 0)
 535:	83 c4 10             	add    $0x10,%esp
 538:	39 de                	cmp    %ebx,%esi
 53a:	75 e4                	jne    520 <printint+0x70>
}
 53c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 548:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 54f:	eb 87                	jmp    4d8 <printint+0x28>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 56c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 56f:	0f b6 13             	movzbl (%ebx),%edx
 572:	84 d2                	test   %dl,%dl
 574:	74 6a                	je     5e0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 576:	8d 45 10             	lea    0x10(%ebp),%eax
 579:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 57c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 57f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 581:	89 45 d0             	mov    %eax,-0x30(%ebp)
 584:	eb 36                	jmp    5bc <printf+0x5c>
 586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58d:	8d 76 00             	lea    0x0(%esi),%esi
 590:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 593:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 598:	83 f8 25             	cmp    $0x25,%eax
 59b:	74 15                	je     5b2 <printf+0x52>
  write(fd, &c, 1);
 59d:	83 ec 04             	sub    $0x4,%esp
 5a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5a3:	6a 01                	push   $0x1
 5a5:	57                   	push   %edi
 5a6:	56                   	push   %esi
 5a7:	e8 27 fe ff ff       	call   3d3 <write>
 5ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 5af:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5b2:	0f b6 13             	movzbl (%ebx),%edx
 5b5:	83 c3 01             	add    $0x1,%ebx
 5b8:	84 d2                	test   %dl,%dl
 5ba:	74 24                	je     5e0 <printf+0x80>
    c = fmt[i] & 0xff;
 5bc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 5bf:	85 c9                	test   %ecx,%ecx
 5c1:	74 cd                	je     590 <printf+0x30>
      }
    } else if(state == '%'){
 5c3:	83 f9 25             	cmp    $0x25,%ecx
 5c6:	75 ea                	jne    5b2 <printf+0x52>
      if(c == 'd'){
 5c8:	83 f8 25             	cmp    $0x25,%eax
 5cb:	0f 84 07 01 00 00    	je     6d8 <printf+0x178>
 5d1:	83 e8 63             	sub    $0x63,%eax
 5d4:	83 f8 15             	cmp    $0x15,%eax
 5d7:	77 17                	ja     5f0 <printf+0x90>
 5d9:	ff 24 85 a4 08 00 00 	jmp    *0x8a4(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e3:	5b                   	pop    %ebx
 5e4:	5e                   	pop    %esi
 5e5:	5f                   	pop    %edi
 5e6:	5d                   	pop    %ebp
 5e7:	c3                   	ret    
 5e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 5f6:	6a 01                	push   $0x1
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5fe:	e8 d0 fd ff ff       	call   3d3 <write>
        putc(fd, c);
 603:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 607:	83 c4 0c             	add    $0xc,%esp
 60a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 60d:	6a 01                	push   $0x1
 60f:	57                   	push   %edi
 610:	56                   	push   %esi
 611:	e8 bd fd ff ff       	call   3d3 <write>
        putc(fd, c);
 616:	83 c4 10             	add    $0x10,%esp
      state = 0;
 619:	31 c9                	xor    %ecx,%ecx
 61b:	eb 95                	jmp    5b2 <printf+0x52>
 61d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	b9 10 00 00 00       	mov    $0x10,%ecx
 628:	6a 00                	push   $0x0
 62a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 62d:	8b 10                	mov    (%eax),%edx
 62f:	89 f0                	mov    %esi,%eax
 631:	e8 7a fe ff ff       	call   4b0 <printint>
        ap++;
 636:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 63a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 63d:	31 c9                	xor    %ecx,%ecx
 63f:	e9 6e ff ff ff       	jmp    5b2 <printf+0x52>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 648:	8b 45 d0             	mov    -0x30(%ebp),%eax
 64b:	8b 10                	mov    (%eax),%edx
        ap++;
 64d:	83 c0 04             	add    $0x4,%eax
 650:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 653:	85 d2                	test   %edx,%edx
 655:	0f 84 8d 00 00 00    	je     6e8 <printf+0x188>
        while(*s != 0){
 65b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 65e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 660:	84 c0                	test   %al,%al
 662:	0f 84 4a ff ff ff    	je     5b2 <printf+0x52>
 668:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 66b:	89 d3                	mov    %edx,%ebx
 66d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
          s++;
 673:	83 c3 01             	add    $0x1,%ebx
 676:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 679:	6a 01                	push   $0x1
 67b:	57                   	push   %edi
 67c:	56                   	push   %esi
 67d:	e8 51 fd ff ff       	call   3d3 <write>
        while(*s != 0){
 682:	0f b6 03             	movzbl (%ebx),%eax
 685:	83 c4 10             	add    $0x10,%esp
 688:	84 c0                	test   %al,%al
 68a:	75 e4                	jne    670 <printf+0x110>
      state = 0;
 68c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 68f:	31 c9                	xor    %ecx,%ecx
 691:	e9 1c ff ff ff       	jmp    5b2 <printf+0x52>
 696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6a0:	83 ec 0c             	sub    $0xc,%esp
 6a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6a8:	6a 01                	push   $0x1
 6aa:	e9 7b ff ff ff       	jmp    62a <printf+0xca>
 6af:	90                   	nop
        putc(fd, *ap);
 6b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 6b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6b6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6b8:	6a 01                	push   $0x1
 6ba:	57                   	push   %edi
 6bb:	56                   	push   %esi
        putc(fd, *ap);
 6bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6bf:	e8 0f fd ff ff       	call   3d3 <write>
        ap++;
 6c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6cb:	31 c9                	xor    %ecx,%ecx
 6cd:	e9 e0 fe ff ff       	jmp    5b2 <printf+0x52>
 6d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 6d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6db:	83 ec 04             	sub    $0x4,%esp
 6de:	e9 2a ff ff ff       	jmp    60d <printf+0xad>
 6e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6e7:	90                   	nop
          s = "(null)";
 6e8:	ba 9d 08 00 00       	mov    $0x89d,%edx
        while(*s != 0){
 6ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 6f0:	b8 28 00 00 00       	mov    $0x28,%eax
 6f5:	89 d3                	mov    %edx,%ebx
 6f7:	e9 74 ff ff ff       	jmp    670 <printf+0x110>
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 0c 0c 00 00       	mov    0xc0c,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	89 c2                	mov    %eax,%edx
 71a:	8b 00                	mov    (%eax),%eax
 71c:	39 ca                	cmp    %ecx,%edx
 71e:	73 30                	jae    750 <free+0x50>
 720:	39 c1                	cmp    %eax,%ecx
 722:	72 04                	jb     728 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	39 c2                	cmp    %eax,%edx
 726:	72 f0                	jb     718 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 728:	8b 73 fc             	mov    -0x4(%ebx),%esi
 72b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72e:	39 f8                	cmp    %edi,%eax
 730:	74 30                	je     762 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 732:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 735:	8b 42 04             	mov    0x4(%edx),%eax
 738:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 73b:	39 f1                	cmp    %esi,%ecx
 73d:	74 3a                	je     779 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 73f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 741:	5b                   	pop    %ebx
  freep = p;
 742:	89 15 0c 0c 00 00    	mov    %edx,0xc0c
}
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret    
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 750:	39 c2                	cmp    %eax,%edx
 752:	72 c4                	jb     718 <free+0x18>
 754:	39 c1                	cmp    %eax,%ecx
 756:	73 c0                	jae    718 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 f8                	cmp    %edi,%eax
 760:	75 d0                	jne    732 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 762:	03 70 04             	add    0x4(%eax),%esi
 765:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 768:	8b 02                	mov    (%edx),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 76f:	8b 42 04             	mov    0x4(%edx),%eax
 772:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 775:	39 f1                	cmp    %esi,%ecx
 777:	75 c6                	jne    73f <free+0x3f>
    p->s.size += bp->s.size;
 779:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 77c:	89 15 0c 0c 00 00    	mov    %edx,0xc0c
    p->s.size += bp->s.size;
 782:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 785:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 788:	89 0a                	mov    %ecx,(%edx)
}
 78a:	5b                   	pop    %ebx
 78b:	5e                   	pop    %esi
 78c:	5f                   	pop    %edi
 78d:	5d                   	pop    %ebp
 78e:	c3                   	ret    
 78f:	90                   	nop

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 3d 0c 0c 00 00    	mov    0xc0c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 70 07             	lea    0x7(%eax),%esi
 7a5:	c1 ee 03             	shr    $0x3,%esi
 7a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7ab:	85 ff                	test   %edi,%edi
 7ad:	0f 84 9d 00 00 00    	je     850 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 7b5:	8b 4a 04             	mov    0x4(%edx),%ecx
 7b8:	39 f1                	cmp    %esi,%ecx
 7ba:	73 6a                	jae    826 <malloc+0x96>
 7bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7c1:	39 de                	cmp    %ebx,%esi
 7c3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7c6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7d0:	eb 17                	jmp    7e9 <malloc+0x59>
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7da:	8b 48 04             	mov    0x4(%eax),%ecx
 7dd:	39 f1                	cmp    %esi,%ecx
 7df:	73 4f                	jae    830 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e1:	8b 3d 0c 0c 00 00    	mov    0xc0c,%edi
 7e7:	89 c2                	mov    %eax,%edx
 7e9:	39 d7                	cmp    %edx,%edi
 7eb:	75 eb                	jne    7d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7ed:	83 ec 0c             	sub    $0xc,%esp
 7f0:	ff 75 e4             	push   -0x1c(%ebp)
 7f3:	e8 43 fc ff ff       	call   43b <sbrk>
  if(p == (char*)-1)
 7f8:	83 c4 10             	add    $0x10,%esp
 7fb:	83 f8 ff             	cmp    $0xffffffff,%eax
 7fe:	74 1c                	je     81c <malloc+0x8c>
  hp->s.size = nu;
 800:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 803:	83 ec 0c             	sub    $0xc,%esp
 806:	83 c0 08             	add    $0x8,%eax
 809:	50                   	push   %eax
 80a:	e8 f1 fe ff ff       	call   700 <free>
  return freep;
 80f:	8b 15 0c 0c 00 00    	mov    0xc0c,%edx
      if((p = morecore(nunits)) == 0)
 815:	83 c4 10             	add    $0x10,%esp
 818:	85 d2                	test   %edx,%edx
 81a:	75 bc                	jne    7d8 <malloc+0x48>
        return 0;
  }
}
 81c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 81f:	31 c0                	xor    %eax,%eax
}
 821:	5b                   	pop    %ebx
 822:	5e                   	pop    %esi
 823:	5f                   	pop    %edi
 824:	5d                   	pop    %ebp
 825:	c3                   	ret    
    if(p->s.size >= nunits){
 826:	89 d0                	mov    %edx,%eax
 828:	89 fa                	mov    %edi,%edx
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 830:	39 ce                	cmp    %ecx,%esi
 832:	74 4c                	je     880 <malloc+0xf0>
        p->s.size -= nunits;
 834:	29 f1                	sub    %esi,%ecx
 836:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 839:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 83c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 83f:	89 15 0c 0c 00 00    	mov    %edx,0xc0c
}
 845:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 848:	83 c0 08             	add    $0x8,%eax
}
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 850:	c7 05 0c 0c 00 00 10 	movl   $0xc10,0xc0c
 857:	0c 00 00 
    base.s.size = 0;
 85a:	bf 10 0c 00 00       	mov    $0xc10,%edi
    base.s.ptr = freep = prevp = &base;
 85f:	c7 05 10 0c 00 00 10 	movl   $0xc10,0xc10
 866:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 869:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 86b:	c7 05 14 0c 00 00 00 	movl   $0x0,0xc14
 872:	00 00 00 
    if(p->s.size >= nunits){
 875:	e9 42 ff ff ff       	jmp    7bc <malloc+0x2c>
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 880:	8b 08                	mov    (%eax),%ecx
 882:	89 0a                	mov    %ecx,(%edx)
 884:	eb b9                	jmp    83f <malloc+0xaf>
