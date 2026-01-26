Return-Path: <netdev+bounces-253320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id crIvFubtdmkHZAEAu9opvQ
	(envelope-from <netdev+bounces-253320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 05:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D33D83E40
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 05:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3520A30037D0
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA041C5D72;
	Mon, 26 Jan 2026 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzr01ZgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749713AA2F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401827; cv=pass; b=reOn1VUZb0dPzNKHcyen3/om+pux/iZgAuCvch5fRyUY241+M+fOAR1ZPjpe2mhDrfgY34OkzKtccOmXRvBOjZ6+j4xrzClAyEDBKnOInJ5tfhN4THX4lr6Oi6b9HshaluebLCCYGShOACqM/Fw+X+E+Eca+FIpFHqba3759ysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401827; c=relaxed/simple;
	bh=7G0NqmKiD9mcjqBvDeRa3sH/GmPk5wwxoXZ4lC8dIG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZAz5cML0/6HLKYBGOB70JnbF1zbpVKDgk5u3UboDk+TlfPfgX2nIlmFV0UWfOOzOozp83RXoEKBD2Kio2YWv55ig5rMO5/5cceblpVO4WY7OETDUHV/ygSu7rwI6/OtbYiLwR8Hy9PucY+vA6Q4MUaxYbemQOlPyb+IutMAMGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzr01ZgG; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-352c7b9a961so303315a91.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769401825; cv=none;
        d=google.com; s=arc-20240605;
        b=jVQidoJ/CvZ95CQ3eU7RsVuSXiObEdj2j4NP5rD9GCFov8y1U0b5M08UFAkruaHB91
         vYupj2DUryJElU1r2LJmMYgwsbr0sFZkDbwq4EYT/FfdbX7e7kTsDDAWBu20tqVMHwqv
         s7c1rPolnv5eHvzqOWfIjVA3k5c5Le8+46sqtVclzVoP/giMcoCDNS7bX3tylXjzinzd
         BEMYDl2wGXmtoV4IugyN+QAbdL4Mj8E/NGObN86KUJksU5pUfVy+t/bg8RcLnIC1qt6T
         pGXotvkGDCu6ponJ7fm3eImDefdBGBni74jshjqm/8ovi/WHIX4fHTQn8r4ubZsBx/GN
         KDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/OKlmFPE9H+5PUxxZez6vDE4p3ZR1kNWUH/zO7FYb8=;
        fh=r8DeCB6jl+bi3hQLSSNTRwg5b6QbigmxPpDH/fzYUjo=;
        b=A4tlW/7s3VZEv5LXsuu9BnzqCROHwzdpunWrQIoud8T0IUJXZk18nbVrhmLLh91EaI
         4tjy3GGcOGmKek0N15Au+45TArJpmmC+T32kv+1ReJB86EN94+FEdwQFXiJAB7d6LGRI
         gRiZkLIVO5LDqjpn3b0xrOwmtZ6cHuLipSovKCdaLG6tPbh9zDpVi+Gx9zeXmiobgPUw
         C9BI1qM9KfWqTFUXjyJ5h+MwLPNeyhzfj5bNvLvsd58aiDEbSDGO4jW+oEHpw3OIrevP
         gsCGRm4ngBYn1hlXpM9iz14yGf65cgU9CNI7zqJE7wSpilXsyI0YdAuEJSJRL//vmSOQ
         yTdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769401825; x=1770006625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/OKlmFPE9H+5PUxxZez6vDE4p3ZR1kNWUH/zO7FYb8=;
        b=Vzr01ZgG/M+FB9mGijOFL3UJOgxxMw9H04wPmo/qhaoyYwX8c3ofOglqBb8R/VV+3y
         a/T+ahlvkIzjvt42EwY6bNd4SXkrdfS1W03h+FdVFgPJ/swaiQ7Z/Yyp0Ndu2LxIOVbX
         c/OSfMuPu+TXMhtoazkxKQK+dgcBbG+THFzHph4p6GUXbCEl1xxp9fFEr1D9tNCUnE83
         UvU31XYtB/kxXbmawQZpg990fMsXyvPeZz/EKEACAxGT2XhIUVJzE1yhg6AvVXZYcLvD
         cRWVlTSFuetiXtChTy37qu0ScLPtimjHq5CWTI9Flj+NoHcYjBo3clmoYiv4VjLcd2Be
         sq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769401825; x=1770006625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/OKlmFPE9H+5PUxxZez6vDE4p3ZR1kNWUH/zO7FYb8=;
        b=Yv3PXreE8fmsUwM38SusNFdH14Pu7OSMA0HLfMI0aNyfkAnEe1TLEAbAjrCcn9/vA+
         zT16E5mzKwa9naCWiQIlIJMlWnX9cvf6FU1cP+uqnjku5OzL2YD0wcFDJsq87pTn4niQ
         rglaq5TE0unQ9YfoFqxt+Gf31JE+7/jPXbKk7wU1oRmEs91ixvvIPjHeULIT0eSRn3Oq
         sG+BYZl46LO2NfXarTD1JD1PWi7ih6LdKAq+ad/5RW/bofLOnBQDZulwcT5jDQplGnp5
         YtTEg60/PfHxEhGkciCVpi32m08homG/HNMB9ic5vU4YT30v7nThssFb4vXdG8y3meyA
         6L5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzbW6f3mfaTD1fcCa3DxfFMzSYBtrqSKbSmMn4/8g62HRF19u54yE7en6qFTdydcYZDdsXds4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYPnrGUK2kteuwcL7WoqGZTFiufe9lj8Gl/fALWZCnouvpL/2
	RWIdOba7lGMC8Ujv+h+ax+/VTvSkF6fkRRBZh2Qti5nLQB4HPYJn5RbFCd6x+Q/1gLoY6J54bua
	Cd9aZcizYVL/DTvl+V5xlkSr6YnIh864=
X-Gm-Gg: AZuq6aIZm4cynkoLORLfirHUZ5vmYmp0MwHCAdd0hUHjx4KnvyVGXuOy0ht4j5UA03C
	XAutR1h710yMRYCTKw5bcxO/Jv2/EWwlQIiutsvgqu1VgPKmi1kqzjWy4OSyjOGHyfjm8cU1lrG
	ctAYFFwqvlgvdUeb3fGHvzgn/4hsLH6oBon3LjaE/AYG+XS7aDI7nfwMqKi0ZlI15q2S8r385Hm
	QLBQKGVLw1iFR3dJFezgoDv/Km9UtopRbiR9Rj3lFakjXI8VKXCfcfLdvCCYao163hwwBzUgpvT
	3grfoFKWtL0HhAMlGbqL48+DsEw=
X-Received: by 2002:a17:90b:2f4e:b0:341:88ba:c632 with SMTP id
 98e67ed59e1d1-353c3fd8eb5mr2016295a91.0.1769401825158; Sun, 25 Jan 2026
 20:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
In-Reply-To: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
From: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Date: Mon, 26 Jan 2026 13:30:14 +0900
X-Gm-Features: AZwV_QgLRbvERYrnq2dMCc3BFJLVVQNaTNz3NV3SRlv9liDJktxNOPixtLfhYiw
Message-ID: <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, jiri@resnulli.us, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	horms@kernel.org
Cc: syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253320-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmkim1503@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D33D83E40
X-Rspamd-Action: no action

Apologies, I set the wrong title and KASAN report. The root cause is
out-of-bounds, not use-after-free. Please find the correct KASAN
report below.

KASAN report
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in u32_classify+0x1180/0x11b0
net/sched/cls_u32.c:221
Read of size 4 at addr ffff88812264f010 by task test/301

CPU: 0 UID: 0 PID: 301 Comm: test Not tainted 6.19.0-rc7 #11 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xd0/0x660 mm/kasan/report.c:482
 kasan_report+0xce/0x100 mm/kasan/report.c:595
 u32_classify+0x1180/0x11b0 net/sched/cls_u32.c:221
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x6dd/0x11d0 net/sched/cls_api.c:1860
 htb_classify net/sched/sch_htb.c:245 [inline]
 htb_enqueue+0x31e/0xf10 net/sched/sch_htb.c:625
 dev_qdisc_enqueue+0x45/0x160 net/core/dev.c:4147
 __dev_xmit_skb net/core/dev.c:4262 [inline]
 __dev_queue_xmit+0x1eea/0x3060 net/core/dev.c:4798
 dev_queue_xmit include/linux/netdevice.h:3381 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip_finish_output2+0xdd2/0x1710 net/ipv4/ip_output.c:237
 __ip_finish_output.part.0+0x182/0x2f0 net/ipv4/ip_output.c:315
 __ip_finish_output net/ipv4/ip_output.c:444 [inline]
 ip_finish_output net/ipv4/ip_output.c:325 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x288/0x510 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:464 [inline]
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 ip_send_skb net/ipv4/ip_output.c:1508 [inline]
 ip_push_pending_frames+0x1ad/0x210 net/ipv4/ip_output.c:1528
 icmp_push_reply+0x2c3/0x3e0 net/ipv4/icmp.c:395
 __icmp_send+0xe93/0x2040 net/ipv4/icmp.c:972
 icmp_send include/net/icmp.h:43 [inline]
 __udp4_lib_rcv+0xfbc/0x2660 net/ipv4/udp.c:2741
 ip_protocol_deliver_rcu+0x196/0x380 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x348/0x4d0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_local_deliver+0x1a0/0x2f0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:474 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:453 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_rcv+0x352/0x3d0 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:6152
 __netif_receive_skb+0x1f/0x110 net/core/dev.c:6265
 process_backlog+0x210/0x670 net/core/dev.c:6617
 __napi_poll+0xa4/0x590 net/core/dev.c:7681
 napi_poll net/core/dev.c:7744 [inline]
 net_rx_action+0xa0e/0xf60 net/core/dev.c:7896
 handle_softirqs+0x18c/0x530 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0x3b/0x60 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x61/0x70 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:936 [inline]
 __dev_queue_xmit+0x6c0/0x3060 net/core/dev.c:4859
 dev_queue_xmit include/linux/netdevice.h:3381 [inline]
 neigh_resolve_output net/core/neighbour.c:1594 [inline]
 neigh_resolve_output+0x42e/0x790 net/core/neighbour.c:1574
 neigh_output include/net/neighbour.h:556 [inline]
 ip_finish_output2+0x63a/0x1710 net/ipv4/ip_output.c:237
 __ip_finish_output.part.0+0x182/0x2f0 net/ipv4/ip_output.c:315
 __ip_finish_output net/ipv4/ip_output.c:444 [inline]
 ip_finish_output net/ipv4/ip_output.c:325 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x288/0x510 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:464 [inline]
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 ip_send_skb+0x160/0x1b0 net/ipv4/ip_output.c:1508
 udp_send_skb+0x6d6/0x1000 net/ipv4/udp.c:1195
 udp_sendmsg+0x1463/0x1eb0 net/ipv4/udp.c:1484
 inet_sendmsg+0xfa/0x140 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 sock_write_iter+0x493/0x5b0 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x657/0xd30 fs/read_write.c:686
 ksys_write+0x1b2/0x200 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa4/0x320 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53a5175513
Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 64 8b 04 25 18 00 00 08
RSP: 002b:00007ffc8dde8d08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f53a5175513
RDX: 0000000000000040 RSI: 00007ffc8dde8d40 RDI: 0000000000000003
RBP: 00007ffc8dde8da0 R08: 0000000000000004 R09: 0000000000000000
R10: fffffffffffffd8d R11: 0000000000000246 R12: 000055ca02b4d0f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the object at ffff88812264f000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 16 bytes inside of
 allocated 512-byte region [ffff88812264f000, ffff88812264f200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12264c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100041c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100041c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0200000000000002 ffffea0004899301 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88812264ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88812264ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88812264f000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff88812264f080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88812264f100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

2026=EB=85=84 1=EC=9B=94 26=EC=9D=BC (=EC=9B=94) PM 1:15, =EA=B9=80=EA=B0=
=95=EB=AF=BC <km.kim1503@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> Dear Linux kernel developers and maintainers,
> Using a modified version of syzkaller, I identified a new bug and
> refined the PoC, and the bug-related information is attached
> below.Please let me know if you need any further information.
>
> Summary
>
> When configuring u32 classifier, the type for hoff in sel allows
> negative values. This leads to an Out-of-Bounds read during subsequent
> processing of classify.
>
> P.S. If the memory at the Out-of-Bounds access point has already been
> freed, KASAN may detect this as a Use-After-Free.
>
> Keywords
> - net/sched
>
> Kernel Info
> Version: (Output of /proc/version)
> - Linux version Linux version 6.19.0-rc7
> Commit: (Git hash if applicable)
> - 63804fed149a6750ffd28610c5c1c98cce6bd377
>
>
> Description(Root Cause)
> ```
> TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
>    const struct tcf_proto *tp,
>    struct tcf_result *res)
> {
> struct {
> struct tc_u_knode *knode;
> unsigned int   off;
> } stack[TC_U32_MAXDEPTH];
>
> struct tc_u_hnode *ht =3D rcu_dereference_bh(tp->root);
> unsigned int off =3D skb_network_offset(skb);
> struct tc_u_knode *n;
> int sdepth =3D 0;
> int off2 =3D 0;
> int sel =3D 0;
> #ifdef CONFIG_CLS_U32_PERF
> int j;
> #endif
> int i, r;
>
> next_ht:
> n =3D rcu_dereference_bh(ht->ht[sel]);
>
> next_knode:
> if (n) {
> ...
> if (ht->divisor) {
> __be32 *data, hdata;
>
> data =3D skb_header_pointer(skb, off + n->sel.hoff, 4, // [1]
>   &hdata);
> if (!data)
> goto out;
> sel =3D ht->divisor & u32_hash_fold(*data, &n->sel, // [2]
>   n->fshift);
> }
> ...
> }
>
> ...
> return -1;
> }
> ```
> n->sel.hoff is a user-controllable value of type short. Since no
> additional validation exists before reaching [1], off + n->sel.hoff
> can become negative, causing data to point to an address before
> skb=E2=86=92head. In the PoC, off is 0xe and n->sel.hoff is 0xf000 (-4096=
 as a
> signed short), resulting in skb_header_pointer()'s second argument
> being -4082.
>
> ```
> static inline void * __must_check
> __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
>      const void *data, int hlen, void *buffer)
> {
> if (likely(hlen - offset >=3D len))
> return (void *)data + offset; // [3]
>
> if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
> return NULL;
>
> return buffer;
> }
> ```
> Since offset is set to -4082 at [3], data - 4082 is returned and
> stored in data, resulting in an Out-of-Bounds condition that exceeds
> the intended range.
> Subsequently, at [2], this data value is used, triggering an Out-of-Bound=
s read.
>
>
> Kasan Report
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in u32_classify+0x1180/0x11b0
> net/sched/cls_u32.c:221
> Read of size 4 at addr ffff888103af9d90 by task test/315
>
> CPU: 1 UID: 0 PID: 315 Comm: test Not tainted 6.19.0-rc7 #11 PREEMPT(full=
)
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xd0/0x660 mm/kasan/report.c:482
>  kasan_report+0xce/0x100 mm/kasan/report.c:595
>  u32_classify+0x1180/0x11b0 net/sched/cls_u32.c:221
>  tc_classify include/net/tc_wrapper.h:197 [inline]
>  __tcf_classify net/sched/cls_api.c:1764 [inline]
>  tcf_classify+0x6dd/0x11d0 net/sched/cls_api.c:1860
>  htb_classify net/sched/sch_htb.c:245 [inline]
>  htb_enqueue+0x31e/0xf10 net/sched/sch_htb.c:625
>  dev_qdisc_enqueue+0x45/0x160 net/core/dev.c:4147
>  __dev_xmit_skb net/core/dev.c:4262 [inline]
>  __dev_queue_xmit+0x1eea/0x3060 net/core/dev.c:4798
>  dev_queue_xmit include/linux/netdevice.h:3381 [inline]
>  neigh_hh_output include/net/neighbour.h:540 [inline]
>  neigh_output include/net/neighbour.h:554 [inline]
>  ip_finish_output2+0xdd2/0x1710 net/ipv4/ip_output.c:237
>  __ip_finish_output.part.0+0x182/0x2f0 net/ipv4/ip_output.c:315
>  __ip_finish_output net/ipv4/ip_output.c:444 [inline]
>  ip_finish_output net/ipv4/ip_output.c:325 [inline]
>  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
>  ip_output+0x288/0x510 net/ipv4/ip_output.c:438
>  dst_output include/net/dst.h:464 [inline]
>  ip_local_out net/ipv4/ip_output.c:131 [inline]
>  ip_send_skb net/ipv4/ip_output.c:1508 [inline]
>  ip_push_pending_frames+0x1ad/0x210 net/ipv4/ip_output.c:1528
>  icmp_push_reply+0x2c3/0x3e0 net/ipv4/icmp.c:395
>  __icmp_send+0xe93/0x2040 net/ipv4/icmp.c:972
>  icmp_send include/net/icmp.h:43 [inline]
>  __udp4_lib_rcv+0xfbc/0x2660 net/ipv4/udp.c:2741
>  ip_protocol_deliver_rcu+0x196/0x380 net/ipv4/ip_input.c:207
>  ip_local_deliver_finish+0x348/0x4d0 net/ipv4/ip_input.c:241
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  NF_HOOK include/linux/netfilter.h:312 [inline]
>  ip_local_deliver+0x1a0/0x2f0 net/ipv4/ip_input.c:262
>  dst_input include/net/dst.h:474 [inline]
>  ip_rcv_finish net/ipv4/ip_input.c:453 [inline]
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  NF_HOOK include/linux/netfilter.h:312 [inline]
>  ip_rcv+0x352/0x3d0 net/ipv4/ip_input.c:573
>  __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:6152
>  __netif_receive_skb+0x1f/0x110 net/core/dev.c:6265
>  process_backlog+0x210/0x670 net/core/dev.c:6617
>  __napi_poll+0xa4/0x590 net/core/dev.c:7681
>  napi_poll net/core/dev.c:7744 [inline]
>  net_rx_action+0xa0e/0xf60 net/core/dev.c:7896
>  handle_softirqs+0x18c/0x530 kernel/softirq.c:622
>  do_softirq kernel/softirq.c:523 [inline]
>  do_softirq+0x3b/0x60 kernel/softirq.c:510
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x61/0x70 kernel/softirq.c:450
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  rcu_read_unlock_bh include/linux/rcupdate.h:936 [inline]
>  __dev_queue_xmit+0x6c0/0x3060 net/core/dev.c:4859
>  dev_queue_xmit include/linux/netdevice.h:3381 [inline]
>  neigh_hh_output include/net/neighbour.h:540 [inline]
>  neigh_output include/net/neighbour.h:554 [inline]
>  ip_finish_output2+0xdd2/0x1710 net/ipv4/ip_output.c:237
>  __ip_finish_output.part.0+0x182/0x2f0 net/ipv4/ip_output.c:315
>  __ip_finish_output net/ipv4/ip_output.c:444 [inline]
>  ip_finish_output net/ipv4/ip_output.c:325 [inline]
>  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
>  ip_output+0x288/0x510 net/ipv4/ip_output.c:438
>  dst_output include/net/dst.h:464 [inline]
>  ip_local_out net/ipv4/ip_output.c:131 [inline]
>  ip_send_skb+0x160/0x1b0 net/ipv4/ip_output.c:1508
>  udp_send_skb+0x6d6/0x1000 net/ipv4/udp.c:1195
>  udp_sendmsg+0x1463/0x1eb0 net/ipv4/udp.c:1484
>  inet_sendmsg+0xfa/0x140 net/ipv4/af_inet.c:859
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  sock_write_iter+0x493/0x5b0 net/socket.c:1195
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x657/0xd30 fs/read_write.c:686
>  ksys_write+0x1b2/0x200 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xa4/0x320 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2e77de9513
> Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> 1f 00 64 8b 04 25 18 00 00 00
> RSP: 002b:00007ffef12b6668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2e77de9513
> RDX: 0000000000000040 RSI: 00007ffef12b66a0 RDI: 0000000000000003
> RBP: 00007ffef12b6700 R08: 0000000000000004 R09: 0000000000000000
> R10: fffffffffffffd8d R11: 0000000000000246 R12: 000055fef9c660f0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
> Allocated by task 1:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:78
>  unpoison_slab_object mm/kasan/common.c:340 [inline]
>  __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:366
>  kasan_slab_alloc include/linux/kasan.h:253 [inline]
>  slab_post_alloc_hook mm/slub.c:4953 [inline]
>  slab_alloc_node mm/slub.c:5263 [inline]
>  kmem_cache_alloc_node_noprof+0x13b/0x4d0 mm/slub.c:5315
>  kmalloc_reserve+0x15d/0x270 net/core/skbuff.c:586
>  __alloc_skb+0x13b/0x390 net/core/skbuff.c:690
>  alloc_skb include/linux/skbuff.h:1383 [inline]
>  nlmsg_new include/net/netlink.h:1055 [inline]
>  mpls_netconf_notify_devconf+0x41/0xf0 net/mpls/af_mpls.c:1205
>  mpls_dev_sysctl_register+0x1c4/0x2a0 net/mpls/af_mpls.c:1441
>  mpls_add_dev net/mpls/af_mpls.c:1490 [inline]
>  mpls_dev_notify+0x342/0x670 net/mpls/af_mpls.c:1635
>  call_netdevice_notifier net/core/dev.c:1884 [inline]
>  call_netdevice_register_notifiers net/core/dev.c:1892 [inline]
>  call_netdevice_register_net_notifiers+0x15d/0x4c0 net/core/dev.c:1923
>  register_netdevice_notifier+0xd7/0x230 net/core/dev.c:1979
>  mpls_init+0x3a/0x110 net/mpls/af_mpls.c:2827
>  do_one_initcall+0xb2/0x3a0 init/main.c:1378
>  do_initcall_level init/main.c:1440 [inline]
>  do_initcalls init/main.c:1456 [inline]
>  do_basic_setup init/main.c:1475 [inline]
>  kernel_init_freeable+0x461/0x780 init/main.c:1688
>  kernel_init+0x1f/0x250 init/main.c:1578
>  ret_from_fork+0x378/0x490 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> Freed by task 1:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:78
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x43/0x70 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2540 [inline]
>  slab_free mm/slub.c:6674 [inline]
>  kmem_cache_free+0xcc/0x4c0 mm/slub.c:6785
>  skb_kfree_head net/core/skbuff.c:1066 [inline]
>  skb_kfree_head net/core/skbuff.c:1063 [inline]
>  skb_free_head+0x19d/0x230 net/core/skbuff.c:1080
>  skb_release_data+0x4ac/0x670 net/core/skbuff.c:1107
>  skb_release_all net/core/skbuff.c:1182 [inline]
>  __kfree_skb net/core/skbuff.c:1196 [inline]
>  consume_skb net/core/skbuff.c:1429 [inline]
>  consume_skb+0xc7/0x220 net/core/skbuff.c:1423
>  netlink_broadcast_filtered+0x379/0xd50 net/netlink/af_netlink.c:1535
>  nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
>  nlmsg_multicast include/net/netlink.h:1184 [inline]
>  nlmsg_notify+0x8d/0x1c0 net/netlink/af_netlink.c:2593
>  mpls_netconf_notify_devconf+0x8f/0xf0 net/mpls/af_mpls.c:1217
>  mpls_dev_sysctl_register+0x1c4/0x2a0 net/mpls/af_mpls.c:1441
>  mpls_add_dev net/mpls/af_mpls.c:1490 [inline]
>  mpls_dev_notify+0x342/0x670 net/mpls/af_mpls.c:1635
>  call_netdevice_notifier net/core/dev.c:1884 [inline]
>  call_netdevice_register_notifiers net/core/dev.c:1892 [inline]
>  call_netdevice_register_net_notifiers+0x15d/0x4c0 net/core/dev.c:1923
>  register_netdevice_notifier+0xd7/0x230 net/core/dev.c:1979
>  mpls_init+0x3a/0x110 net/mpls/af_mpls.c:2827
>  do_one_initcall+0xb2/0x3a0 init/main.c:1378
>  do_initcall_level init/main.c:1440 [inline]
>  do_initcalls init/main.c:1456 [inline]
>  do_basic_setup init/main.c:1475 [inline]
>  kernel_init_freeable+0x461/0x780 init/main.c:1688
>  kernel_init+0x1f/0x250 init/main.c:1578
>  ret_from_fork+0x378/0x490 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> The buggy address belongs to the object at ffff888103af9d40
>  which belongs to the cache skbuff_small_head of size 704
> The buggy address is located 80 bytes inside of
>  freed 704-byte region [ffff888103af9d40, ffff888103afa000)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x103a=
f8
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x200000000000040(head|node=3D0|zone=3D2)
> page_type: f5(slab)
> raw: 0200000000000040 ffff888100919280 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000080130013 00000000f5000000 0000000000000000
> head: 0200000000000040 ffff888100919280 dead000000000100 dead000000000122
> head: 0000000000000000 0000000080130013 00000000f5000000 0000000000000000
> head: 0200000000000002 ffffea00040ebe01 00000000ffffffff 00000000ffffffff
> head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff888103af9c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff888103af9d00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> >ffff888103af9d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff888103af9e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888103af9e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

