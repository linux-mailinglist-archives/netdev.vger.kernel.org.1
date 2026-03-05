Return-Path: <netdev+bounces-264504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LO3N5DDqWm2EQEAu9opvQ
	(envelope-from <netdev+bounces-264504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9E2169C2
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00592307648B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6913C918;
	Thu,  5 Mar 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TGKM86/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020B3E7148
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732789; cv=pass; b=dPP03CSHLJgsfK0L0koxW8AU20Wf8jJyZv55MmQ5/taAoLTfwUqNQM6SGzdg48FqzySsD6vhevkaKcPpJgWNiQtzt5/8/1EDchltRGnEdGw2u1P3g4cLDXefVuxvSuzVOgy5cIYAIES6WQvV/eXU0zAxpCM9mXSFNVgiUEWbCl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732789; c=relaxed/simple;
	bh=HvBq9jnzNjLB6kAJI0vQRn038Ai1+KvWLLxIRD3xlI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKxkBQQ8tc5gcnZ8Bk/isKcnjry7it0wjPbvUn8aaqSmIqsIlfjs9CuCXNXx2UzzISya51vol6tsaAJ1AVTh+4tI2IiWox4ObAyPWN4D9Ybu7mSuJDe9lUHt8BZHiPfK18QUOA9MRhmClKKeQhw5rktKXULPgjjU1O/5i673VTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TGKM86/; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1273349c56bso10301793c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 09:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772732787; cv=none;
        d=google.com; s=arc-20240605;
        b=Tdnr3NS/oelM+Y6/nmd/Wu5dqPtyhV4+zZDunLyuyNN94ASsOn0JeEMZlslY8p3ZAK
         /gNxwlPk07DjsbBzU+1FNeXHz4gISRS17HzaX0C1wSwcZ67kkRQsynaP2cJg0cv8Cd4O
         UYNOZmVO5jyRze18opEgTXrDcJAbh+XnK+J0qNCV/u7sr4beHWddybOrTnsohNjXW+O4
         JpOJxvSB3xDyeYE/pgbcltwcDxDf82SuiNrr0SOX/BvDoMbN6SYuhHbmwQTij+5a3MRj
         dmO26uJAUSwt+zbg7v4+ZS3Hd/5opdD1dq1MgdM6NMquUAXUITil/jdLXolYLtxPLC2J
         HHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lrjPlnIyQYvqnZ4vQmlaK92orXWEwh6zWLfH4folOco=;
        fh=TwgNZecd2kwRFKZ0dgyWumr+xroCRRme4gzlv/456xg=;
        b=PRYjXHmw+JDAHlff9nvdvu5rtFtvEetkeQE6swJV42DZX7AOObEq77nTDNYD0wMhTN
         U7A3CY1Y3ydM/p4jYn1PYLOellac7370l66gCCzyib6hliTab7dvxM1o47uDMec3WAVN
         g73FWL2avJUTh8FKJQdBfBC+yZY4G6M60ypRk+zjVNELoeWCze06JJemrXVRy5066YC9
         5cC/JNC6Y2qLn2SJ4JnyeHrtZ6tPj8HnloEePN6C/+dTPQKKfzip/DbykcoAGMSpWv3A
         6N5hJ3HnQqkcR5IP8NxPLBfWs3knXLGzwKpti/u5tXYGQlxNVRRZAaUDIfNjWuU/ciMv
         XJrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772732787; x=1773337587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrjPlnIyQYvqnZ4vQmlaK92orXWEwh6zWLfH4folOco=;
        b=0TGKM86/36CNxezpRBy8sAvdiplcD8Yj6+IMTf8uawQEEa8KCRD/d+1S1z8paXt7fn
         L6ceR0nzUgvY/Y+dDZXiOr1VunyXmDlNMVq2U0aKxAJ7GvzT4EESdzVke2tu9ww3g+yl
         62BOuwr/CP+57uB6mwxQE+cFvC40ifrJKWKBqyNO6fXfL1UAUGzh5jZxOSMtSyhQhnED
         YRmFL9hTiaYZbcqwSk0HjF9McxBUn4P1u4X8J6U2tMkysGUtH+rUPlFfvWYh6s3/Ia4R
         SbIZlNqdLVxHeINm1n4aHgMoj0gejlB40ha/SM9ycccn/wUUAeI6M9yE+Ao3kjbRZbW3
         r5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732787; x=1773337587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrjPlnIyQYvqnZ4vQmlaK92orXWEwh6zWLfH4folOco=;
        b=vFSjhpZlovs/pa4gxutoWwcG87Kmdnda5Ir5/FV8DGMAnezdI1jnszBV22aH7i9jHB
         veBK//5R6cR9r+a2TRhjShmObFSytrjRazIHxIHY4VRoBHa2qOkWitPBdSnttaxJX6kv
         wzYwsD1RvWAlfpx3fxJM0t55IFkP13oC6US848g9OUT09NmOeAV43TnA+E2vT/HdeAsb
         eU8TIQFUdFlxY4BuVvMXGrqG1/yg5p8DBZjKcXZt/3dLs3gjKw5VvTaBDv4N7ORanO04
         T0JD52sxjEeL74Rmb9YgzqGlOan24TcKISwCFJfYlR1Q/F2Y0Gogmq/E6w/W3hoH4YYr
         1dYw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ9/3P0+nxjjrrO3Rkws0Ci5Mr/YdMrpKGr62Pdv7AYV27RS76NxH2ac4qBgByXH1cAMgvJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9Wdkzj7BYMIjfKdU4R10qB/2yyiTrgKhNrxHduHb6XNr6r7v
	jtOX50ThZVb3iKrwWi4LCsTT6SdhrzkT+Su5Ykukb/7xqo/Mf6In9rX4LkKHTdO2q+RAruvNyZn
	gMiRpxP8r48KtFCChF9OoDdXbudV1ZxAHKxc3Ou+I
X-Gm-Gg: ATEYQzyCN2tre0wNmK2yXGtilpM30Nk7vb0kobGHG/NIjLmfIVnbho+HVeRlpqpUpGO
	sROvORFnSIW32Tz4O18JPTmdo8ul5Lvh782LerayroQk9ny+2qJqWSKzzFT1atKsItJGWao1wk/
	7MSsAp6pAgvL0nPRgKX4cuNv/c3rov2rILqfDoFWWX5Ye4N0WEsO7MAmyVmv7WGVFeZcZL4+//k
	DoBStbaDh46MJvLssLNAWve0lZsle/llItd5I1twLZIvSLcOqSQvbc5ck7MBe4CObzNufzFb4B0
	CqsDbPZcMsgxFsZYcrTo06ktrYfJ0zTR2rF9V9Uy6UfQuuZtC6P2epmRDJ9Wb/C+2xzFJYP/EBN
	0Ynkrs6w=
X-Received: by 2002:a05:7022:6712:b0:11b:9386:8267 with SMTP id
 a92af1059eb24-128b71000a2mr2583041c88.44.1772732786476; Thu, 05 Mar 2026
 09:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-4-kuniyu@google.com>
 <875x7ao68n.fsf@cloudflare.com>
In-Reply-To: <875x7ao68n.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 09:46:15 -0800
X-Gm-Features: AaiRm53wxv7nCgD4uUICwlgiaQ2wAnvB-kLVhj5KdGABF4FxCYmRC1bTg5e95do
Message-ID: <CAAVpQUDwq5DPQhQxziRYZf2FnF_CPBV-siLi3kRH2Kw2G_qwUg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in udp_bpf_recvmsg().
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7ED9E2169C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-264504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,9307c991a6d07ce6e6d8];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 3:39=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> > syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0=
]
> >
> > sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> > but its processing is lockless.
> >
> > Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> > multiple threads could touch the same sk_msg.
> >
> > For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock=
.
> >
> > Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> > commit accidentally removed it.
>
> FWIW, it doesn't sound like commit 9f2470fbc4cb ("skmsg: Improve
> udp_bpf_recvmsg() accuracy") removed it by accident. The commit message
> calls it out explicitly:
>
>     Also, UDP does not lock the sock during BH Rx path, it makes
>     no sense for its ->recvmsg() to lock the sock. It is always
>     possible for ->recvmsg() to be called before packets actually
>     arrive in the receive queue, we just use best effort to make
>     it accurate here.
>
> Looks like we just didn't understand the consequences at that time.

I meant that's the accident :)

> by mistake
https://dictionary.cambridge.org/us/dictionary/english/accidentally


>
> >
> > Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
> >
> > Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> > an option due to copy_page_to_iter() in sk_msg_recvmsg().
> >
> > [0]:
> > BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/=
skmsg.c:428
> > Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
> >
> > CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/13/2026
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xba/0x230 mm/kasan/report.c:482
> >  kasan_report+0x117/0x150 mm/kasan/report.c:595
> >  sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
> >  udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
> >  inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
> >  sock_recvmsg_nosec net/socket.c:1078 [inline]
> >  sock_recvmsg+0x1a8/0x270 net/socket.c:1100
> >  ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
> >  ___sys_recvmsg+0x215/0x590 net/socket.c:2854
> >  do_recvmmsg+0x334/0x800 net/socket.c:2949
> >  __sys_recvmmsg net/socket.c:3023 [inline]
> >  __do_sys_recvmmsg net/socket.c:3046 [inline]
> >  __se_sys_recvmmsg net/socket.c:3039 [inline]
> >  __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fb319f9aeb9
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fb31ad97028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> > RAX: ffffffffffffffda RBX: 00007fb31a216090 RCX: 00007fb319f9aeb9
> > RDX: 0000000000000001 RSI: 0000200000000400 RDI: 0000000000000004
> > RBP: 00007fb31a008c1f R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000040000021 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fb31a216128 R14: 00007fb31a216090 R15: 00007ffe21dd0a98
> >  </TASK>
> >
> > Allocated by task 6019:
> >  kasan_save_stack mm/kasan/common.c:57 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> >  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> >  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
> >  kasan_kmalloc include/linux/kasan.h:263 [inline]
> >  __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
> >  kmalloc_noprof include/linux/slab.h:957 [inline]
> >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> >  alloc_sk_msg net/core/skmsg.c:510 [inline]
> >  sk_psock_skb_ingress_self+0x60/0x350 net/core/skmsg.c:612
> >  sk_psock_verdict_apply net/core/skmsg.c:1038 [inline]
> >  sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1236
> >  udp_read_skb+0x73e/0x7e0 net/ipv4/udp.c:2045
> >  sk_psock_verdict_data_ready+0x12d/0x550 net/core/skmsg.c:1257
> >  __udp_enqueue_schedule_skb+0xc54/0x10b0 net/ipv4/udp.c:1789
> >  __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
> >  udp_queue_rcv_one_skb+0xac5/0x19c0 net/ipv4/udp.c:2475
> >  __udp4_lib_mcast_deliver+0xc06/0xcf0 net/ipv4/udp.c:2585
> >  __udp4_lib_rcv+0x10f6/0x2620 net/ipv4/udp.c:2724
> >  ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
> >  ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
> >  NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
> >  dst_input include/net/dst.h:474 [inline]
> >  ip_sublist_rcv_finish+0x221/0x2a0 net/ipv4/ip_input.c:584
> >  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
> >  ip_sublist_rcv+0x5c6/0xa70 net/ipv4/ip_input.c:644
> >  ip_list_rcv+0x3f1/0x450 net/ipv4/ip_input.c:678
> >  __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
> >  __netif_receive_skb_list_core+0x7e5/0x810 net/core/dev.c:6242
> >  __netif_receive_skb_list net/core/dev.c:6294 [inline]
> >  netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6385
> >  netif_receive_skb_list+0x54/0x410 net/core/dev.c:6437
> >  xdp_recv_frames net/bpf/test_run.c:269 [inline]
> >  xdp_test_run_batch net/bpf/test_run.c:350 [inline]
> >  bpf_test_run_xdp_live+0x1946/0x1cf0 net/bpf/test_run.c:379
> >  bpf_prog_test_run_xdp+0x81c/0x1160 net/bpf/test_run.c:1396
> >  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
> >  __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
> >  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 6021:
> >  kasan_save_stack mm/kasan/common.c:57 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> >  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
> >  poison_slab_object mm/kasan/common.c:253 [inline]
> >  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
> >  kasan_slab_free include/linux/kasan.h:235 [inline]
> >  slab_free_hook mm/slub.c:2540 [inline]
> >  slab_free mm/slub.c:6674 [inline]
> >  kfree+0x1be/0x650 mm/slub.c:6882
> >  kfree_sk_msg include/linux/skmsg.h:385 [inline]
> >  sk_msg_recvmsg+0xaa8/0xc30 net/core/skmsg.c:483
> >  udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
> >  inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
> >  sock_recvmsg_nosec net/socket.c:1078 [inline]
> >  sock_recvmsg+0x1a8/0x270 net/socket.c:1100
> >  ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
> >  ___sys_recvmsg+0x215/0x590 net/socket.c:2854
> >  do_recvmmsg+0x334/0x800 net/socket.c:2949
> >  __sys_recvmmsg net/socket.c:3023 [inline]
> >  __do_sys_recvmmsg net/socket.c:3046 [inline]
> >  __se_sys_recvmmsg net/socket.c:3039 [inline]
> >  __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> > Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Thanks

