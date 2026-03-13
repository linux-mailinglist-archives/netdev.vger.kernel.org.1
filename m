Return-Path: <netdev+bounces-267585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA2kDNBwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738D289A6A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8635313484C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB534398910;
	Fri, 13 Mar 2026 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QybOzs4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C42E719C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432940; cv=pass; b=ORkWSmNep3fm33ikSeoc9pvQ1ZrIzZtcLoVZdZoc2zvkJNFCekrnALEWgMS0oPNLrRXKmuY/UhemDT6V7tD9SRTQGhsxJqEXl+eKEzddemshp3odOynk+UTxwr3OoAHqIzywYkqe6TenLk4+H89Xd6/Uz4HRjBA1MPwLEAMD7Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432940; c=relaxed/simple;
	bh=QAQayLu2rOY4rKsaUlZu3H3bUqc/sgniGozjMD0Q3S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMncWSccFyThCNJ1/r9ks3i2rTi/0N72NPu2ygkFKPJsdyZaLGkhi4aVvQYCUnWLhKksBVNQoFKG0OwlCsJ4e4WRQTle/oiGUuTPrWP1bdEQerJe0pelqNGrJyJ6UeWyaXDuG5xnEYdWbQqRAmdh2Y2jqbkqv9jv/gYqnAiMCiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QybOzs4C; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a6ac6f389so34113246d6.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773432937; cv=none;
        d=google.com; s=arc-20240605;
        b=O2eP9hgpUA3ndoQZDkC3aD3s5IDfDWlyBd6n6kGAY775vp24xru+2m53v8CpOpgRzo
         YWHBumssp9hYR8Zu82tE8MpavAB95Ko6QJoii0csndEOmdWF/IJu12kAiWn0WqbrSYmd
         77N5YDBPO3j052NSALwdDAUTBuaeq7cmZoIepBkvkS2Wmq8GMn2rNkWViFd0qz1fMRhV
         bTUrUdR4uzFjsuacCIFtqh2GiW/5lR7ADQpayxLQsVXwdCJ5Hqh5p2wMxO6V6c/x5YeD
         nWFsG3iTyKnp85BZJeoqH4B2RTqazsk3bTbe30hr4UorWNvdQfiovwfgsn69cM55SMXi
         bwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/Pued1QLV+qx2YCdyFB8QhfPMtsBrZdMNkNdhRMLjM=;
        fh=2JEyZEEx8yb0tPCMnxSw8bAAtuFJg54CsFKAXDOD8og=;
        b=bdrJaxnwxIhLikWuj/eBB6TrRm6aCDTzdHnUqK/5EX/pmqzQFHcUkWpYutK7BaEoT8
         YzPSgzTeDjC9mWn+4OVfEO/hIEQr30KktCQFoqq2FLqPLXy7IvAeG+Fur/jrVtqRIWxw
         /BYuySZ25d+28XIBUAVUeWFOfLLNLC5m3LTVOwOX/7cpQQY4lmXMnYanbvxo1kpyl7mB
         VvRyTmqG+0xsgbMUSI9z9HuQA+SP62mp6Dmu68XJksYljOwF4JoSYLqkeWAkwVzjlyy7
         gaKrujkV3ZQSRGOedJ9cbXlJew5ohdf23XYZd+DkFmqOjCluyxKp/t/se4ldExuoAIRC
         /qtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773432937; x=1774037737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Pued1QLV+qx2YCdyFB8QhfPMtsBrZdMNkNdhRMLjM=;
        b=QybOzs4C8eTcr1UbAKHuCCrmBhzjlzWNRULe9u+zAHhUi2OLOiDuBqlPJ/2lcLs7xb
         lsUC92rNtJdeMOfryeSYHyybI/+Sou8+KkOI9kCaYE2ghD2s3wGMQ0UhICraZx4JqOGG
         jZ72uRl7jFctrxdxbf+o9R8T3trt1sFbDO2gPY65our1UGlGdcwdkJXI1/ZUpiVRvUV6
         oD93so9jTciOLrLHqNhP76pk+AY+d3lFnWniX/5qoERZkXLSpXT3v/mFwgJZsnboKcbZ
         vILf/zjtNt8M5AAc/NBLaXPVHkr5j8Tw3QBOSv+a1G+8kboaZ5+zk7poRKX4VT+dCGTl
         vrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432937; x=1774037737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/Pued1QLV+qx2YCdyFB8QhfPMtsBrZdMNkNdhRMLjM=;
        b=GyUXTQH76Epmdx0dF9XHYENbD2b9rEHvTY6vpSMExCzlkJbJUwSo863Zwg5F9SHjlL
         1g8CmGAPUVSrdfK68366iAQxZD3k4akslGHJRGn30wY7YsvQstF/j8IADrbE+JYymO6V
         iUHxRJ5rX17ygzcojzGy+6ON+WKKoOQ5Mb7he21M1oncpN6s2uDs1AcH6zJLofpinY1U
         jG9XMMau8lGcna+W5VhcSJi6Wewakx7f47B43Yhnv0tOsPvaTK8UVW0iNQlc2AAiHxRl
         R3ZMRAZXKDcPfsueVxcBtpnPg4CXkBYQiIJhUGDEiSkVZ/nTqLWd3TpGNZU640d29GXv
         fYDw==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ3Q/Skg9Ttyb1Am5/mSUWgfwq2FRk5Vfq8n1anBiXy2ptQXiff/oezPUkiAT1lnHrAPCuoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1OqEcgbOXj6ONC+9g22QMPxIkcCO0WBuScQ4etb7xG2e4IC5i
	PL6ux3ZGEPXawyH9yrFljKXK7eqYZAPTLtQDqq4PvIvIrEATJhrlju6zHSKnRmgQzoAmvyTapPl
	jAM3VnPFJnRGTf4F4bg+18BuLtBGi9ZIN48Z+mDA5
X-Gm-Gg: ATEYQzys0oZSf5U3MsfRNkJT3w3suwlNu8Ur8WEn034w5QvQBBr6S+sQ/FqnXWD2Z/c
	AuSJ3bJ6/LQ3EzA8rRy/dOxOcajaE0P74+P6o+tUmoKj1loMk7XrqbFP/gGQwjhn9+2A0GJNVlD
	TItHIYmfP/oUpHsQWd6VDF7jPuk35HnvRvRLP17E2hySWZalXWNfXGfkQGFVD8tA3TBucQe9c+s
	n2a58S7XedxdXD1Qt/gCp8MRf17uE+Luk+85U73qF6iSk6dXG4Vd2tRPW5zOY8960BCr6nHLR4l
	EHTa9w==
X-Received: by 2002:a05:6214:1302:b0:880:54ac:79f8 with SMTP id
 6a1803df08f44-89a81f6056emr77613176d6.48.1773432936891; Fri, 13 Mar 2026
 13:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69b46af7.050a0220.36eb34.000e.GAE@google.com>
In-Reply-To: <69b46af7.050a0220.36eb34.000e.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Mar 2026 21:15:25 +0100
X-Gm-Features: AaiRm51kTJTHgcXwFm4NlSmml7NqEGDVhxFuEm6rSxT4aO4GrgUbRHUn524bPhc
Message-ID: <CANn89iJdHdQbtqP-kC_A7rsCdtw244uFuT=at6TSFV-sDcgQPQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in bond_header_create
To: syzbot <syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com>, 
	Jiayuan Chen <jiayuan.chen@shopee.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, jv@jvosburgh.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ccef46afa67b2b19];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267585-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,goo.gl:url,syzkaller.appspot.com:url,appspotmail.com:email,shopee.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 8738D289A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 8:52=E2=80=AFPM syzbot
<syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8004279c41ad Merge tag 'nfs-for-7.0-2' of git://git.linux=
-..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1593c41658000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dccef46afa67b2=
b19
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3d8bc31c45e1145=
0f24c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D172d1416580=
000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-8004279c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f56a78af5be3/vmlinu=
x-8004279c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/89a6ba48229d/b=
zImage-8004279c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xe000=
080fee63d21a: 0000 [#1] SMP KASAN NOPTI
> KASAN: probably user-memory-access in range [0x0000607f731e90d0-0x0000607=
f731e90d7]
> CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(=
full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> Workqueue: mld mld_ifc_work
> RIP: 0010:bond_header_create+0x150/0x300 drivers/net/bonding/bond_main.c:=
1524
> Code: e8 25 bd 59 fb 45 85 f6 0f 84 a5 00 00 00 e8 d7 b8 59 fb eb 05 e8 d=
0 b8 59 fb 48 85 ed 0f 84 89 00 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 38 00=
 74 08 48 89 ef e8 71 81 c5 fb 48 8b 6d 00 4c 8d 75
> RSP: 0018:ffffc90000b0f600 EFLAGS: 00010202
> RAX: 00000c0fee63d21a RBX: ffffffff866bf37b RCX: ffff888000c524c0
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000607f731e90d0 R08: ffffffff866bf37b R09: ffffffff8e75e420
> R10: dffffc0000000000 R11: ffffffff866bf340 R12: 00000000000086dd
> R13: ffff8880127763c0 R14: 0000000000000001 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88808ca55000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2fbfe3ff8c CR3: 0000000012645000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  dev_hard_header include/linux/netdevice.h:3439 [inline]
>  neigh_connected_output+0x286/0x460 net/core/neighbour.c:1644
>  __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
>  ip6_finish_output+0x2e5/0x740 net/ipv6/ip6_output.c:219
>  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
>  ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
>  dst_output include/net/dst.h:470 [inline]
>  NF_HOOK+0x177/0x4f0 include/linux/netfilter.h:318
>  mld_sendpack+0x8b4/0xe40 net/ipv6/mcast.c:1855
>  mld_send_cr net/ipv6/mcast.c:2154 [inline]
>  mld_ifc_work+0x835/0xe70 net/ipv6/mcast.c:2693
>  process_one_work kernel/workqueue.c:3275 [inline]
>  process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
>  worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bond_header_create+0x150/0x300 drivers/net/bonding/bond_main.c:=
1524
> Code: e8 25 bd 59 fb 45 85 f6 0f 84 a5 00 00 00 e8 d7 b8 59 fb eb 05 e8 d=
0 b8 59 fb 48 85 ed 0f 84 89 00 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 38 00=
 74 08 48 89 ef e8 71 81 c5 fb 48 8b 6d 00 4c 8d 75
> RSP: 0018:ffffc90000b0f600 EFLAGS: 00010202
> RAX: 00000c0fee63d21a RBX: ffffffff866bf37b RCX: ffff888000c524c0
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000607f731e90d0 R08: ffffffff866bf37b R09: ffffffff8e75e420
> R10: dffffc0000000000 R11: ffffffff866bf340 R12: 00000000000086dd
> R13: ffff8880127763c0 R14: 0000000000000001 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88808ca55000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e232d92000 CR3: 000000000e54c000 CR4: 0000000000352ef0
> ----------------
> Code disassembly (best guess):
>    0:   e8 25 bd 59 fb          call   0xfb59bd2a
>    5:   45 85 f6                test   %r14d,%r14d
>    8:   0f 84 a5 00 00 00       je     0xb3
>    e:   e8 d7 b8 59 fb          call   0xfb59b8ea
>   13:   eb 05                   jmp    0x1a
>   15:   e8 d0 b8 59 fb          call   0xfb59b8ea
>   1a:   48 85 ed                test   %rbp,%rbp
>   1d:   0f 84 89 00 00 00       je     0xac
>   23:   48 89 e8                mov    %rbp,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1) <-- trapping in=
struction
>   2f:   74 08                   je     0x39
>   31:   48 89 ef                mov    %rbp,%rdi
>   34:   e8 71 81 c5 fb          call   0xfbc581aa
>   39:   48 8b 6d 00             mov    0x0(%rbp),%rbp
>   3d:   4c                      rex.WR
>   3e:   8d                      .byte 0x8d
>   3f:   75                      .byte 0x75
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

I am suspecting.

Can you take a look ?

Thanks.

commit 950803f7254721c1c15858fbbfae3deaaeeecb11
Author: Jiayuan Chen <jiayuan.chen@shopee.com>
Date:   Fri Mar 6 10:15:07 2026 +0800

    bonding: fix type confusion in bond_setup_by_slave()

