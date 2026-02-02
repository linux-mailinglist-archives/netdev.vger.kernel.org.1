Return-Path: <netdev+bounces-255752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LRvAe5MgGlQ6AIAu9opvQ
	(envelope-from <netdev+bounces-255752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:06:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BDC90CF
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B734C3002D38
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C730AD0A;
	Mon,  2 Feb 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X1AO8ZWb"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F39AD24
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015976; cv=none; b=gcrI0/f1S0KagpD5RzSYAC4TVTrnWX/ENGXHSiRX88IzNUReR9RzYNy2zAA0DwxMICcYsaQeK3KuZ5HvA+n4+SJzZRwHlhsfkiVKFHAQ9/KFemoz6RVuKQP/YoyKaluMNcswyaqA1zMzrkR048MF9jjziVRQD+3mWJRZUHXTFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015976; c=relaxed/simple;
	bh=jjxwPQEIVam1LDtDSNVqbI4Rh6Q32nV6y2b/Q/GIrFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvbB9jnyjruSLf7TfXtSaiM+Cff+AYbD+q7vJxxNfctMngcfsCSrE45WZuBtNswmwUIbFFv/VyO2pZ7lIjCWTZO7sSCs6nZuL5usIstcdBwTkXZpehlCDKWu43kv/urpnC11kEV2YbWFt/UaGBya7PmabSL6Ualyuhj2FYqy6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X1AO8ZWb; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770015968; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Amnll6Nutv6iO0zwGc3xgv5qWHjESVFIr0hWcyjk7Ew=;
	b=X1AO8ZWb3JsNqrXN82ieRH6SWRX7tIyejqexQ3xw9lUc3jZYmDsnQ0NArib6Ah2NO/ZXrwqyN5YMODDFAakzFuaLM5YhrbBklteQyaxtlOXeU7nARg+ozOCIi1iZqN0CFpaiu2jNZHX59oQbfwwq8clQYPJjOJ5z+/75003yDBE=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WyKN2CJ_1770015966 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 15:06:07 +0800
Date: Mon, 2 Feb 2026 15:06:06 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	dongchenchen2@huawei.com
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
Message-ID: <ajpt3yxq4s74mg4fylos742xq7adq74cdza7cfnhrkemj2ugtj@hy765y7xpyu4>
References: <20260131212934.2547995-1-edumazet@google.com>
 <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-255752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengwei_yin@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,linux-foundation.org:email,prot_hook.dev:url]
X-Rspamd-Queue-Id: 293BDC90CF
X-Rspamd-Action: no action

Hi Eric,

> On Mon, Feb 2, 2026 at 4:16 AM YinFengwei <fengwei_yin@linux.alibaba.com> wrote:
> >
> > + Chenchen as he hit the exact same issue.
> >
> > Hi Eric,
> >
> > > Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a patch.
> > >
> > > Real issue is that (struct packet_type)->dev needs RCU protection:
> > >
> > > ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> > > to get device name without any barrier.
> > >
> > > At the same time, concurrent writer can remove a packet_type structure
> > > (which is correctly freed after an RCU grace period) _and_ clear pt->dev
> > > without an RCU grace period.
> > >
> > > Fix this issue by using proper RCU on pt->dev pointer.
> > Still can hit this issue with same backtrace even with this fixing patch.
> >
> > Look at the __dev_remove_pack(), the pt->list is protected by ptype_lock
> > while prot_hook.dev is protected by bind_lock. Could it make sure the
> > procfs interface see either the list element with prot_hook.dev not NULL
> > or can't see the list element with NULL prot_hook.dev?
> >
> > Regards
> > Yin, Fengwei
> 
> Please share the new stack trace (with the symbols), or the repro, thanks !

About the reproducing environment:
1. We can reproduce it on bare mental arm64 server and kvm guest on arm64 server.
   So I use virtualization env to reproduce it now.
2. With debian cloud disk image, it took very long to hit it (like days).
3. With a buildroot based disk image from our QA team, it took less than 1 hours
   to hit it. Unfortunately, I can't share the buildroot based disk image.
4. I didn't reproduce it on x86 env.


The base commit I applied your fix (So you dup the code matches the stacktrace
decode output):
commit 18f7fcd5e69a04df57b563360b88be72471d6b62 (HEAD -> master, tag:
v6.19-rc8, origin/master)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 1 14:01:13 2026 -0800

    Linux 6.19-rc8

Let me know if you need furhter information. Thanks.

Regards
Yin, Fengwei

---------------------------------------------------------------------------------
The stack trace is like:
[ 1248.009152] watchdog: BUG: soft lockup - CPU#0 stuck for 149s!
[b2ac940_rcu_sta:12914]
[ 1248.009167] Modules linked in:
[ 1248.009171] CPU: 0 UID: 0 PID: 12914 Comm: b2ac940_rcu_sta Tainted: G	L      6.19.0-rc8-00001-gbcedc33b3f13 #8 VOLUNTARY
[ 1248.009241] Tainted: [L]=SOFTLOCKUP
[ 1248.009248] Hardware name: linux,dummy-virt (DT)
[ 1248.009250] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[ 1248.009251] pc : ptype_seq_next+0x1c/0x180
[ 1248.009257] lr : traverse.part.0+0x88/0x198
[ 1248.009260] sp : ffff800087a13b20
[ 1248.009260] x29: ffff800087a13b20 x28: ffff000004d35900 x27:0000000000000000
[ 1248.009262] x26: 0000000000000000 x25: ffff0000040ddad0 x24:ffff0000040ddac0
[ 1248.009264] x23: 00000000000080db x22: 0000000000000033 x21:0000000000000000
[ 1248.009266] x20: ffff000003bbc158 x19: ffff0000040dda98 x18:0000000000000000
[ 1248.009268] x17: 0000000000000000 x16: 0000000000000000 x15:0000000000000000
[ 1248.009270] x14: 0000000000000000 x13: 0a6e6f6974636e75 x12:4620202020202065
[ 1248.009272] x11: 0000000000000000 x10: 0000000000000001 x9 :ffff8000804d5ac8
[ 1248.009274] x8 : 000000000000000a x7 : ffff8000818cb9e2 x6 :000000000000000a
[ 1248.009289] x5 : 0000000000000000 x4 : ffff8000827d2e40 x3 :0000000772a30439
[ 1248.009290] x2 : ffff0000040ddac0 x1 : ffff000003bbc158 x0 :ffff0000040dda98
[ 1248.009292] Call trace:
[ 1248.009293]  ptype_seq_next+0x1c/0x180 (P)
[ 1248.009296]  seq_read_iter+0x300/0x500
[ 1248.009297]  seq_read+0xe8/0x128
[ 1248.009298]  proc_reg_read+0xb8/0x108
[ 1248.009300]  do_loop_readv_writev.part.0+0xc0/0x128
[ 1248.009302]  vfs_readv+0x178/0x1e0
[ 1248.009303]  do_preadv+0x98/0x100
[ 1248.009305]  __arm64_sys_preadv+0x28/0x40
[ 1248.009306]  invoke_syscall+0x50/0x120
[ 1248.009307]  el0_svc_common.constprop.0+0x48/0xf0
[ 1248.009309]  do_el0_svc+0x24/0x38
[ 1248.009310]  el0_svc+0x38/0x168
[ 1248.009312]  el0t_64_sync_handler+0xa0/0xe8
[ 1248.009314]  el0t_64_sync+0x1ac/0x1b0


stack trace decode:
[ 1248.009152] watchdog: BUG: soft lockup - CPU#0 stuck for 149s!	[b2ac940_rcu_sta:12914]
[ 1248.009167] Modules linked in:
[ 1248.009241] Tainted: [L]=SOFTLOCKUP
[ 1248.009248] Hardware name: linux,dummy-virt (DT)
[ 1248.009250] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[ 1248.009251] pc : ptype_seq_next (/mnt/ssd/fyin/linux/net/core/net-procfs.c:228)
[ 1248.009257] lr : traverse.part.0 (/mnt/ssd/fyin/linux/fs/seq_file.c:120)
[ 1248.009260] sp : ffff800087a13b20
[ 1248.009260] x29: ffff800087a13b20 x28: ffff000004d35900 x27:0000000000000000
[ 1248.009262] x26: 0000000000000000 x25: ffff0000040ddad0 x24:ffff0000040ddac0
[ 1248.009264] x23: 00000000000080db x22: 0000000000000033 x21:0000000000000000
[ 1248.009266] x20: ffff000003bbc158 x19: ffff0000040dda98 x18:0000000000000000
[ 1248.009268] x17: 0000000000000000 x16: 0000000000000000 x15:0000000000000000
[ 1248.009270] x14: 0000000000000000 x13: 0a6e6f6974636e75 x12:4620202020202065
[ 1248.009272] x11: 0000000000000000 x10: 0000000000000001 x9 :ffff8000804d5ac8
[ 1248.009274] x8 : 000000000000000a x7 : ffff8000818cb9e2 x6 :000000000000000a
[ 1248.009289] x5 : 0000000000000000 x4 : ffff8000827d2e40 x3 :0000000772a30439
[ 1248.009290] x2 : ffff0000040ddac0 x1 : ffff000003bbc158 x0 :ffff0000040dda98
[ 1248.009292] Call trace:
[ 1248.009293]  ptype_seq_next (/mnt/ssd/fyin/linux/net/core/net-procfs.c:228) (P)
[ 1248.009296]  seq_read_iter (/mnt/ssd/fyin/linux/fs/seq_file.c:101 /mnt/ssd/fyin/linux/fs/seq_file.c:195)
[ 1248.009297]  seq_read (/mnt/ssd/fyin/linux/fs/seq_file.c:163)
[ 1248.009298]  proc_reg_read (/mnt/ssd/fyin/linux/fs/proc/inode.c:308 /mnt/ssd/fyin/linux/fs/proc/inode.c:320)
[ 1248.009300]  do_loop_readv_writev.part.0 (/mnt/ssd/fyin/linux/fs/read_write.c:850)
[ 1248.009302]  vfs_readv (/mnt/ssd/fyin/linux/fs/read_write.c:840 /mnt/ssd/fyin/linux/fs/read_write.c:1020)
[ 1248.009303]  do_preadv (/mnt/ssd/fyin/linux/fs/read_write.c:1132)
[ 1248.009305]  __arm64_sys_preadv (/mnt/ssd/fyin/linux/fs/read_write.c:1174)
[ 1248.009306]  invoke_syscall (/mnt/ssd/fyin/linux/./arch/arm64/include/asm/current.h:19 /mnt/ssd/fyin/linux/arch/arm64/kernel/syscall.c:54)                               
[ 1248.009307]  el0_svc_common.constprop.0 (/mnt/ssd/fyin/linux/./include/linux/thread_info.h:140 /mnt/ssd/fyin/linux/arch/arm64/kernel/syscall.c:140)
[ 1248.009309]  do_el0_svc (/mnt/ssd/fyin/linux/arch/arm64/kernel/syscall.c:152)
[ 1248.009310]  el0_svc (/mnt/ssd/fyin/linux/./arch/arm64/include/asm/alternative-macros.h:254 /mnt/ssd/fyin/linux/./arch/arm64/include/asm/cpufeature.h:809 /mnt/ssd/fyin/linux/./arch/arm64/include/asm/irqflags.h:73 /mnt/ssd/fyin/linux/arch/arm64/kernel/entry-common.c:80 /mnt/ssd/fyin/linux/arch/arm64/kernel/entry-common.c:725)
[ 1248.009312]  el0t_64_sync_handler (/mnt/ssd/fyin/linux/arch/arm64/kernel/entry-common.c:744)                                                                             
[ 1248.009314]  el0t_64_sync (/mnt/ssd/fyin/linux/arch/arm64/kernel/entry.S:596)


The C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

#ifndef __NR_bind
#define __NR_bind 200
#endif
#ifndef __NR_close
#define __NR_close 57
#endif
#ifndef __NR_ioctl
#define __NR_ioctl 29
#endif
#ifndef __NR_mmap
#define __NR_mmap 222
#endif
#ifndef __NR_openat
#define __NR_openat 56
#endif
#ifndef __NR_preadv
#define __NR_preadv 69
#endif
#ifndef __NR_socket
#define __NR_socket 198
#endif

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev)
{
  ev->state = 0;
}

static void event_reset(event_t* ev)
{
  ev->state = 0;
}

static void event_set(event_t* ev)
{
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

static bool write_file(const char* file, const char* what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static long syz_open_procfs(volatile long a0, volatile long a1)
{
  char buf[128];
  memset(buf, 0, sizeof(buf));
  if (a0 == 0) {
    snprintf(buf, sizeof(buf), "/proc/self/%s", (char*)a1);
  } else if (a0 == -1) {
    snprintf(buf, sizeof(buf), "/proc/thread-self/%s", (char*)a1);
  } else {
    snprintf(buf, sizeof(buf), "/proc/self/task/%d/%s", (int)a0, (char*)a1);
  }
  int fd = open(buf, O_RDWR);
  if (fd == -1)
    fd = open(buf, O_RDONLY);
  return fd;
}

static void kill_and_wait(int pid, int* status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void)
{
  if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
  }
  int i, call, thread;
  for (call = 0; call < 9; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      if (call == 6)
        break;
      event_timedwait(&th->done, 50);
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      sleep_ms(10);
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[4] = {0xffffffffffffffff, 0xffffffffffffffff, 0x0,
                 0xffffffffffffffff};

void execute_call(int call)
{
  intptr_t res = 0;
  switch (call) {
  case 0:
    //  close arguments: [
    //    fd: fd (resource)
    //  ]
    syscall(__NR_close, /*fd=*/3);
    break;
  case 1:
    //  socket$packet arguments: [
    //    domain: const = 0x11 (8 bytes)
    //    type: packet_socket_type = 0x3 (8 bytes)
    //    proto: const = 0x300 (4 bytes)
    //  ]
    //  returns sock_packet
    res = syscall(__NR_socket, /*domain=*/0x11ul, /*type=SOCK_RAW*/ 3ul,
                  /*proto=*/0x300);
    if (res != -1)
      r[0] = res;
    break;
  case 2:
    //  socket$nl_audit arguments: [
    //    domain: const = 0x10 (8 bytes)
    //    type: const = 0x3 (8 bytes)
    //    proto: const = 0x9 (4 bytes)
    //  ]
    //  returns sock_nl_audit
    res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/9);
    if (res != -1)
      r[1] = res;
    break;
  case 3:
    //  ioctl$sock_SIOCGIFINDEX arguments: [
    //    fd: sock (resource)
    //    cmd: const = 0x8933 (4 bytes)
    //    arg: ptr[out, ifreq_dev_t[devnames, ifindex]] {
    //      ifreq_dev_t[devnames, ifindex] {
    //        ifr_ifrn: buffer: {6c 6f 00 00 00 00 00 00 00 00 00 00 00 00 00
    //        00} (length 0x10) elem: ifindex (resource) pad = 0x0 (20 bytes)
    //      }
    //    }
    //  ]
    memcpy((void*)0x20000100,
           "lo\000\000\000\000\000\000\000\000\000\000\000\000\000\000", 16);
    res =
        syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0x8933, /*arg=*/0x20000100ul);
    if (res != -1)
      r[2] = *(uint32_t*)0x20000110;
    break;
  case 4:
    //  bind$packet arguments: [
    //    fd: sock_packet (resource)
    //    addr: ptr[in, sockaddr_ll] {
    //      sockaddr_ll {
    //        sll_family: const = 0x11 (2 bytes)
    //        sll_protocol: packet_protocols = 0x3 (2 bytes)
    //        sll_ifindex: ifindex (resource)
    //        sll_hatype: const = 0x1 (2 bytes)
    //        sll_pkttype: int8 = 0xc1 (1 bytes)
    //        sll_halen: const = 0x6 (1 bytes)
    //        sll_addr: union mac_addr {
    //          local: mac_addr_t[const[0xaa, int8]] {
    //            a0: buffer: {aa aa aa aa aa} (length 0x5)
    //            a1: const = 0xaa (1 bytes)
    //          }
    //        }
    //        pad: buffer: {00 00} (length 0x2)
    //      }
    //    }
    //    addrlen: len = 0x14 (8 bytes)
    //  ]
    *(uint16_t*)0x20001340 = 0x11;
    *(uint16_t*)0x20001342 = htobe16(3);
    *(uint32_t*)0x20001344 = r[2];
    *(uint16_t*)0x20001348 = 1;
    *(uint8_t*)0x2000134a = 0xc1;
    *(uint8_t*)0x2000134b = 6;
    memset((void*)0x2000134c, 170, 5);
    *(uint8_t*)0x20001351 = 0xaa;
    memset((void*)0x20001352, 0, 2);
    syscall(__NR_bind, /*fd=*/r[0], /*addr=*/0x20001340ul, /*addrlen=*/0x14ul);
    break;
  case 5:
    //  syz_open_procfs arguments: [
    //    pid: pid (resource)
    //    file: ptr[in, buffer] {
    //      buffer: {6e 65 74 2f 70 74 79 70 65 00} (length 0xa)
    //    }
    //  ]
    //  returns fd
    memcpy((void*)0x20000180, "net/ptype\000", 10);
    res = -1;
    res = syz_open_procfs(/*pid=*/0, /*file=*/0x20000180);
    if (res != -1)
      r[3] = res;
    break;
  case 6:
    //  preadv arguments: [
    //    fd: fd (resource)
    //    vec: ptr[in, array[iovec[out, array[int8]]]] {
    //      array[iovec[out, array[int8]]] {
    //        iovec[out, array[int8]] {
    //          addr: ptr[out, buffer] {
    //            buffer: (DirOut)
    //          }
    //          len: len = 0xe8 (8 bytes)
    //        }
    //      }
    //    }
    //    vlen: len = 0x1 (8 bytes)
    //    off_low: int32 = 0x80db (4 bytes)
    //    off_high: int32 = 0x2 (4 bytes)
    //  ]
    *(uint64_t*)0x20001840 = 0x20000280;
    *(uint64_t*)0x20001848 = 0xe8;
    syscall(__NR_preadv, /*fd=*/r[3], /*vec=*/0x20001840ul, /*vlen=*/1ul,
            /*off_low=*/0x80db, /*off_high=*/2);
    break;
  case 7:
    //  close arguments: [
    //    fd: fd (resource)
    //  ]
    syscall(__NR_close, /*fd=*/3);
    break;
  case 8:
    //  openat arguments: [
    //    fd: fd_dir (resource)
    //    file: nil
    //    flags: open_flags = 0x42 (4 bytes)
    //    mode: open_mode = 0x17f (2 bytes)
    //  ]
    //  returns fd
    syscall(
        __NR_openat, /*fd=*/0xffffff9c, /*file=*/0ul,
        /*flags=O_CREAT|O_RDWR*/ 0x42,
        /*mode=S_IXOTH|S_IWOTH|S_IROTH|S_IXGRP|S_IWGRP|S_IRGRP|S_IXUSR|0x100*/
        0x17f);
    break;
  }
}
int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
          /*fd=*/(intptr_t)-1, /*offset=*/0ul);
  const char* reason;
  (void)reason;
  loop();
  return 0;
}


