Return-Path: <netdev+bounces-304750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87imDhj5SWqZ9AAAu9opvQ
	(envelope-from <netdev+bounces-304750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 08:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90314709257
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 08:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304750-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304750-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13CDE30054E8
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B32F7478;
	Sun,  5 Jul 2026 06:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBC27F19F
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 06:26:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783232789; cv=none; b=uhvMuMbWAL9Y5gu8pL2oQMf7TOa9JW3D3D6r6Ol/s9qs/E4+9rBohzGC1tfig761UowWWCh1zdsodC9F7OhMzjhK3PW0u61wCBqtdZiBXISwwdz/ugQDMRoxHdOc2N7L6H34Ob/Tgj0MxJoq7nPAyFy0I2h4JeB59l/4G0BS+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783232789; c=relaxed/simple;
	bh=ZRLxZgqyN3T0N9JKVPeoWIHBqUGsTyu6ztiO6yyBCS0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XcPfUfo1+N7j2NsXWgDvlxoGVXY+/7LLD4Jr9AaBDHfNVsZV8tq1KAegcD+HyZ+2tJZLqLbRM6niMJUEe1Jvv51UNK7G27RrecWSrHb4MdS+dP6yT0900erUdgq0dzaGXIHtsEpalrGn7nT/4fqnVqeBwEzgPo5TmhQK63cAO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6a18e349abfso2678426eaf.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 23:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783232787; x=1783837587;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYjiezpgYlbe1rCtBCbicnJESVBKCFTSbnvtIUSvla0=;
        b=guaiYEF3+9nZowJRUoEJ5YYiLI1GK15x5LUlvRTmLvisWgmmjvLYkjlqvhtWfM7OVn
         J/qi3aj57jNm1LcVNR0L81VU0BZeSZR9kqU+JxFe5o1c/er9xjggeMoVYte9Cjijz/Uj
         E2HQJoDGLgxotuIxRv1QC1r6gcUgcYldbjopbYINQiSgX6PNE3vPt8A8i7aByOrlw61e
         Ivv1ij4qt+LGKgOnzdqcJHX01wP1y6mztukn8Ty1jAtdr2bdiwKDbLhXoZMIM0vBaUmM
         RrbFxHIqg4vSDBEBlvyAS04x5FimuvaxIXMIVZrXOJnwyPVp1B1EEAa727p8nT5L3Ll3
         /nxw==
X-Forwarded-Encrypted: i=1; AFNElJ9/nizs4dBzD46uye+N1Qa2dNRzKzGPSRxAsA/HnymeX3Yx9H7Y5tFBA5DYMH1+gxhdjb+hebY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUb9cnKdhDgK+8G8pUJXYT2i05cBL2HeCZ95ZUTo09t36Gh4Y
	a1G9f9n4iCPZ12a+KfYDk6ev8r+a2k6CdOypxoy61cRpCndncnZH7Sd+DJJ9SXNNHA6FjgSyeL+
	BxSJL9CxIeiIuyZvAckgk+AzDbm2QVwctJuVGD1yavJsmjYJ8VCKuWM/fDjg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81c1:b0:6a1:1ccd:d09d with SMTP id
 006d021491bc7-6a31d636ccbmr5266884eaf.42.1783232787391; Sat, 04 Jul 2026
 23:26:27 -0700 (PDT)
Date: Sat, 04 Jul 2026 23:26:27 -0700
In-Reply-To: <694ebdbd.050a0220.35954c.0077.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a49f913.52c20a74.1f8b39.0011.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in rcu_note_context_switch (5)
From: syzbot <syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304750-lists,netdev=lfdr.de,84d4a405ed798b40c96d];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90314709257

syzbot has found a reproducer for the following issue on:

HEAD commit:    b73bc9ca3686 Merge tag 'nf-next-26-07-02' of https://git.k..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1043ef19580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=84d4a405ed798b40c96d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d07719580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1443ef19580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7f8c662a498/disk-b73bc9ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3ffbd688a32/vmlinux-b73bc9ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/235149e2b678/bzImage-b73bc9ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com

------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note_context_switch+0xc58/0xef0 kernel/rcu/tree_plugin.h:332, CPU#1: syz.0.17/5817
Modules linked in:
CPU: 1 UID: 0 PID: 5817 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:rcu_note_context_switch+0xc58/0xef0 kernel/rcu/tree_plugin.h:332
Code: 00 41 c6 45 00 00 48 8b 3d 35 15 ab 0e 48 81 c4 a8 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 af 60 ff ff 48 8d 3d c8 d6 ae 0e <67> 48 0f b9 3a e9 6f f4 ff ff 90 0f 0b 90 45 84 e4 0f 84 3e f4 ff
RSP: 0018:ffffc90002eced20 EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff888030d80000 RCX: 0000000080000002
RDX: 0000000000000000 RSI: ffffffff8c4bd260 RDI: ffffffff905ad640
RBP: dffffc0000000000 R08: ffffffff905767f7 R09: 1ffffffff20aecfe
R10: dffffc0000000000 R11: fffffbfff20aecff R12: 0000000000000000
R13: dffffc0000000000 R14: ffff8880b873c180 R15: ffff888030d804c4
FS:  000055557f679500(0000) GS:ffff888125060000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff0e1073780 CR3: 0000000022684000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __schedule+0x2e9/0x56c0 kernel/sched/core.c:7088
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 netlink_broadcast_filtered+0xe53/0xea0 net/netlink/af_netlink.c:1553
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xe3/0x1a0 net/netlink/af_netlink.c:2599
 __ip6_del_rt_siblings+0x5ed/0x7d0 net/ipv6/route.c:4080
 ip6_route_del+0x104f/0x1100 net/ipv6/route.c:4220
 inet6_rtm_delroute+0x5d7/0x6d0 net/ipv6/route.c:5657
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7076
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff0e119de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd842e7d98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff0e1425fa0 RCX: 00007ff0e119de59
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007ff0e1233e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff0e1425fac R14: 00007ff0e1425fa0 R15: 00007ff0e1425fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 41 c6             	add    %al,-0x3a(%rcx)
   3:	45 00 00             	add    %r8b,(%r8)
   6:	48 8b 3d 35 15 ab 0e 	mov    0xeab1535(%rip),%rdi        # 0xeab1542
   d:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
  14:	5b                   	pop    %rbx
  15:	41 5c                	pop    %r12
  17:	41 5d                	pop    %r13
  19:	41 5e                	pop    %r14
  1b:	41 5f                	pop    %r15
  1d:	5d                   	pop    %rbp
  1e:	e9 af 60 ff ff       	jmp    0xffff60d2
  23:	48 8d 3d c8 d6 ae 0e 	lea    0xeaed6c8(%rip),%rdi        # 0xeaed6f2
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 6f f4 ff ff       	jmp    0xfffff4a3
  34:	90                   	nop
  35:	0f 0b                	ud2
  37:	90                   	nop
  38:	45 84 e4             	test   %r12b,%r12b
  3b:	0f                   	.byte 0xf
  3c:	84 3e                	test   %bh,(%rsi)
  3e:	f4                   	hlt
  3f:	ff                   	.byte 0xff


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

