Return-Path: <netdev+bounces-258654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA4eD/Fej2mtQgEAu9opvQ
	(envelope-from <netdev+bounces-258654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:27:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4048138A25
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 780BD3035892
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA70C364EAB;
	Fri, 13 Feb 2026 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxqLTt51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50A3659E5
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003617; cv=pass; b=paZxpyMqHJuYC0oIE0ufn0qyLzTy1UVAp3vJV3MK9DyrnoHttnVjIj6P1GfB0lcg+ImDJeXOt+FdFEmmXByQLl214zsqdU24PE9duDyDdLO8Isye+afWz2ID6t7zPlvpanLfSCtENN9OsvItZlrPBFFgN1G8uojJQeQX2s4gqwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003617; c=relaxed/simple;
	bh=UJXwGb0K7dJ5HUgOnYnDjsJeNxUZbg/A6tc5uCB/D2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg0ogqwmolj2dCjkoseUmSgHi6F6JIBq7kAaLqcgdkfRd/lWbtPzmDTLSU/YGYnf5YHO72IJ0xcZ8I0p/aA03IesDKLkXUjXvx8ZbcIZLrEa3WX0v09PinbGX5igIi4LD0VRJ+VUCW6Z0cMv4RPpCFsQwgfrbbMvN9FBdzx5Hw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxqLTt51; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50698970941so13330801cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 09:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771003615; cv=none;
        d=google.com; s=arc-20240605;
        b=PyZkpsW773rbZJ6sFBSsaKMvxigyOoF18UpPMZQ9wrZ8suhrMuQlXwkChQ+CUIrbBd
         vHG0c96mqsIObNNPpHP/DenL+vEl6emrbF2/nVIaXGr3YqZUQbSkhdJiUyW07YiTyQyZ
         sJf59DyLZZRiLvImRJZLQiHmtgyIcpB/W1u1yWhwkymAbq9VYU7YXXwxWW383/5NB2x3
         Ltwk+nSWmDvsa75bH8mfPrT828t7PdZUjCQ/tM1vpVdz1FGvL0bSMgQpHoPBJ4EK4eEA
         lGajg8KAUZa81dThr9iW1goRIXwsp7hxTi1fFLM3k1Jm2emV3/n5r+Ok3XSPQW3j83q/
         B5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I8pcDoKzxJogKYS/OO7iHWHCToeCi1Wj1Fp9M61/fzg=;
        fh=myqj721IEMPFUbc+yD8m/7CepKoPmtGl2YYnCnUJzE4=;
        b=Tiojb8gA0a0A3CykDE7DSfA/XErwUsIb1bDRbjyZaFYM/nGzHElZjuaEZGrIlvbzfq
         j/PHKgZ+mnjPGoTMrDrtFjjRUgRMgaVEhmMG6a406tLfygiPA9cyjmjmlOgnGWlrfEzt
         D2BxPoKkvia2K+HLwUiAMVzJSCbTt3TyCLLtnONQKOdcBrgkx075dhUn1qq3dFh9+Xv2
         ve1N3PyZUVlfTX0p3qUUATLNx80H0MlHKR9uDucMT5D1WBISVIdFEc1OBnln110aRnmQ
         JVgz+GPyslpDqVwyePYPYlYGyKfrKNde+K3PDQ9uYJ4njUAzURvRm2K1UJVTbijI4J7Z
         1FGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771003615; x=1771608415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8pcDoKzxJogKYS/OO7iHWHCToeCi1Wj1Fp9M61/fzg=;
        b=DxqLTt51j/haBAtjlK5o872sqerQLa2YVfixiUgl3mw98lB8HmF/Yxq9CxGPqGQV94
         X2fxCnPb1sgNlhx1l56wuf199oKP+3SpTdWFneOH73SOXuwBVZK+AkdlYk7vu88PzHSW
         UDaIBvKhDF283gEHdhTUb5LYnAzcXWksEnzDsD7vqmKQMSqax2KHowTL/oNLp+apY9m5
         oIgYUKfN9AU0JWOk30hdsyQ5HI+ZP9Fv06eHLiO+EuX7IZO59BVzAmu1n+AySztsmwqm
         /99KvKokK8GfjjxWi2JAp55p6EPd+RB/2FuyUYv5r3Z0Kh3krwZRJNb7M+pPqeMBt+GV
         D4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771003615; x=1771608415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I8pcDoKzxJogKYS/OO7iHWHCToeCi1Wj1Fp9M61/fzg=;
        b=ho9oyag4cxxygu53cCYNToh9v1GIuTzAuACDNGtMDyMxnCl93rgUO0UGYbq2E572He
         +TR7rKaPj6JLTI0dyR7cvFi3exXnXRFK0sZzEtjgs52DuL7siNIi/v2krjqc6CPPNZsi
         q/yf5sj1SW8k4mHQu1VZDs2TfEvS6zgvPniL1R7GGIugvqha4/MYf3MVnLlbUiRT1SwX
         708elgKwTTyadYPvZXG+LeAcDY2l8jn9kwfL5Qoy1VqyVneun3EuMm6hmBFWb0cglG96
         O+g0Geg3l/eMgd3/er/elrWfcHqjSEBqXDSt/dsw2Re1mY2AKmivufSKd0mYIRJHa07l
         fOug==
X-Forwarded-Encrypted: i=1; AJvYcCUVlH+0O/1FW97QU2FQnS+Lvdp5WvXtIHLhKRjS2Y1ABem0hiCtc0adLQKfnmeP16BHl5t1dZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqfj50UZE7q/4BSJe7b0wVMBNsD7a0V++SrX+LAWmx85mylyg9
	Etj7MQm+ZlkBRKLEflTMio76wtucjKulEVu9e8qvZCKyCeocPllp5cBr8ernkw3Br0YHHt6GF9l
	Pm8rlSKQdpS3oIAnFgRUE3zFxPpAyr+1iCqrdpKK9
X-Gm-Gg: AZuq6aISjV7tLd073duXtiYGh5srJObRVQOAJU3/d9Hqv/7Yntj0YE3Tpy2xeFbF78H
	NYTNW8EU4gQaYdSQWHIAAZ+Rt21+ovzoCSyZJBN0ex4epqQXMdD8GW+OXqsRkdyRfM8/5tudbqq
	jVW3w1qeEHorR5uAHDpafg0fGNu3Q+oyzb7/zjSarzYgGcwsmwvuAJQXm0kPBX2v6sBWBBnk8lT
	q7Yfc8nPyVAlJkENru4PaLY1EnzyDS0KoBQJ8GNcjnK4SZem4sbYAeHZItJ3jbTHQfmpH5hPSwD
	WjRRc1o5F3OE1OWI8A==
X-Received: by 2002:a05:622a:15cd:b0:4ee:56c0:712f with SMTP id
 d75a77b69052e-506b403c9b6mr2328851cf.76.1771003614443; Fri, 13 Feb 2026
 09:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
In-Reply-To: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Feb 2026 18:26:43 +0100
X-Gm-Features: AZwV_QidXYrCWtymSxesmUdClpP8uLjasaNp_j6i9wipfraedaKKiPfL0ni5LQE
Message-ID: <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
To: syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>, 
	Gerd Rausch <gerd.rausch@oracle.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258654-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email,syzkaller.appspot.com:url];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A4048138A25
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 1:15=E2=80=AFPM syzbot
<syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    57be33f85e36 nfc: nxp-nci: remove interrupt trigger type
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12f2165a58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2c36acc86fd56=
a9d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5efae91f6093283=
9f0a5
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1584065a580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f2165a58000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/77aaa9b6c846/dis=
k-57be33f8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2617a56e7118/vmlinu=
x-57be33f8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4fd173f33f5f/b=
zImage-57be33f8.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> kworker/u8:6/2985 is trying to acquire lock:
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/=
net/sock.h:1709 [inline]
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15=
d/0x650 net/ipv6/af_inet6.c:533
>
> but task is already holding lock:
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/=
net/sock.h:1709 [inline]
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+=
0x2c/0x2e0 net/ipv4/tcp.c:3694
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(k-sk_lock-AF_INET6);
>   lock(k-sk_lock-AF_INET6);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 4 locks held by kworker/u8:6/2985:
>  #0: ffff888033131948 ((wq_completion)krds_cp_wq#1/0){+.+.}-{0:0}, at: pr=
ocess_one_work kernel/workqueue.c:3232 [inline]
>  #0: ffff888033131948 ((wq_completion)krds_cp_wq#1/0){+.+.}-{0:0}, at: pr=
ocess_scheduled_works+0x9d4/0x17a0 kernel/workqueue.c:3340
>  #1: ffffc9000b8a7bc0 ((work_completion)(&(&cp->cp_send_w)->work)){+.+.}-=
{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
>  #1: ffffc9000b8a7bc0 ((work_completion)(&(&cp->cp_send_w)->work)){+.+.}-=
{0:0}, at: process_scheduled_works+0xa0f/0x17a0 kernel/workqueue.c:3340
>  #2: ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock inc=
lude/net/sock.h:1709 [inline]
>  #2: ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_=
cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
>  #3: ffff88807a07abc8 (k-clock-AF_INET6){++.-}-{3:3}, at: rds_tcp_data_re=
ady+0x113/0x950 net/rds/tcp_recv.c:320
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 2985 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEM=
PT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/24/2026
> Workqueue: krds_cp_wq#1/0 rds_send_worker
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
>  check_deadlock kernel/locking/lockdep.c:3093 [inline]
>  validate_chain kernel/locking/lockdep.c:3895 [inline]
>  __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
>  lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
>  lock_sock_nested+0x48/0x100 net/core/sock.c:3780
>  lock_sock include/net/sock.h:1709 [inline]
>  inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>  rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>  rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>  rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>  rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>  rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>  __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>  rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>  rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>  tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>  tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>  sk_backlog_rcv include/net/sock.h:1185 [inline]
>  __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
>  release_sock+0x5f/0x1f0 net/core/sock.c:3795
>  rds_send_xmit+0x207e/0x28d0 net/rds/send.c:480
>  rds_send_worker+0x7d/0x2e0 net/rds/threads.c:200
>  process_one_work kernel/workqueue.c:3257 [inline]
>  process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
>  worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
>  kthread+0x726/0x8b0 kernel/kthread.c:463
>  ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>
> BUG: sleeping function called from invalid context at net/core/sock.c:378=
2
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2985, name: kworke=
r/u8:6
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 UID: 0 PID: 2985 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEM=
PT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/24/2026
> Workqueue: krds_cp_wq#1/0 rds_send_worker
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  __might_resched+0x378/0x4d0 kernel/sched/core.c:8829
>  lock_sock_nested+0x5d/0x100 net/core/sock.c:3782
>  lock_sock include/net/sock.h:1709 [inline]
>  inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>  rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>  rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>  rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>  rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>  rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>  __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>  rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>  rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>  tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>  tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>  sk_backlog_rcv include/net/sock.h:1185 [inline]
>  __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
>  release_sock+0x5f/0x1f0 net/core/sock.c:3795
>  rds_send_xmit+0x207e/0x28d0 net/rds/send.c:480
>  rds_send_worker+0x7d/0x2e0 net/rds/threads.c:200
>  process_one_work kernel/workqueue.c:3257 [inline]
>  process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
>  worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
>  kthread+0x726/0x8b0 kernel/kthread.c:463
>  ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>
> BUG: scheduling while atomic: kworker/u8:6/2985/0x00000202
> INFO: lockdep is turned off.
> Modules linked in:
> Preemption disabled at:
> [<0000000000000000>] 0x0
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Gerd, please take a look, thanks.

commit 9d27a0fb122f19b6d01d02f4b4f429ca28811ace
Author: Gerd Rausch <gerd.rausch@oracle.com>
Date:   Mon Feb 2 22:57:23 2026 -0700

    net/rds: Trigger rds_send_ping() more than once

