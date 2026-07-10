Return-Path: <netdev+bounces-306495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UUCaINrBUGpx4gIAu9opvQ
	(envelope-from <netdev+bounces-306495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0049739504
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:56:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306495-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306495-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3539D3013A50
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634B43FBB6F;
	Fri, 10 Jul 2026 09:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74713FADFA
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:56:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677388; cv=none; b=PN8B1LzfpzGdbb6pgibeKLmBcuuiwwwnuP4BLA0CzSgx/CzWxj2VfMncub9qk+xVhyBsb5Z5HfZ7tC6hq/O1CXm4WfThhfk8W2OeEFHF1FVozBhfAcTCGD6LHP4p+lA/Bj6QG4qEoSBrdeD+7ZYYKMTQIw3lERl3lEQK+qyHnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677388; c=relaxed/simple;
	bh=xjZzlw/40cZc5WwM5Wrd1CH1kKYAZ966j02JUM20z+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QT4nDmAVbPuBVL3FIT0SOH8wqf8cuWecjGR15yFljuqFs+Ke2gIMaDpVgLpqr6pHoPAmb+b9IN2snXmCCgctUw3EhgBGGo6GuQXvHCXgrePnnBVdmZflLHDjys4QQQXUBN9S9AaplwBnM1KXKepF+dgMDZKjDvfNX84BP0OyQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-497e582f42fso866787b6e.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 02:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677386; x=1784282186;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Ev0u6kHtBC5am4b+df+KrL1PiaixVZqkDtRTVVytN4=;
        b=C3HPa3eRD1JTL2OkXIbElnJ3aCF4YhWYcH1FRlRUUCj+xTHduGcQP5lRwC97IBpF15
         Yj4NkkeVjLhenQi1j+xcSgiaY69JktvuNB2wI3m1IKuYv18Xz/wGzQMXM6uOKWxPoHMY
         kOlvM0+bDDxEyajtdWGW2mHQM+VJICIoHy8JO3c0OmWIHl+IjumxYoDgkCToYh4b5OQl
         EFqPaNkVGX7n4Xx3pwT+DH1vpF5fS28yQAiGuki/5Rrxl5RwMVc+Ew4BEmDk0+AYVBoh
         aXN5oXFYk7TKR38i3REpQSFElHCUyBhoz5PJVMiJCjOSdqddntoXkJ26ORqg9ss0bOAz
         Gkaw==
X-Forwarded-Encrypted: i=1; AFNElJ++TPxLg+Kxh5Ua1xZLdq5Xy/a51Gp/EwDedmzJWZ1nMYMyIwfDh26BUzFO/ePOyWm7kSU4mGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmibH7lZ0sKkQQdU7hVrHGlgTw92Exg9TfHdJLiw/gKMVuBhw
	I0ftzz4D6PCmmpadAt4B02ElsLtRakelYJNvn6Dj/Rg17hp7uLhHOo26fNr87Nk8SO1mST0jPGl
	wTCi0gpyC/SCfeZDbmzWii4D0vQA85RcVqNP31LxRK3e315MQepy0cEfhiDc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13cb:b0:49b:9a35:f72d with SMTP id
 5614622812f47-4a204e078demr8796221b6e.29.1783677385855; Fri, 10 Jul 2026
 02:56:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 02:56:25 -0700
In-Reply-To: <20260709100512.1383421-1-t.martitz@fritz.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a50c1c9.c76b52dc.2a15e.000e.GAE@google.com>
Subject: [syzbot ci] Re: macvlan: allow source mode devices along with passthru
From: syzbot ci <syzbot+cid92d08b94bac992e@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, t.martitz@fritz.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306495-lists,netdev=lfdr.de,cid92d08b94bac992e];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:t.martitz@fritz.com,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,syzkaller.appspotmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0049739504

syzbot ci has tested the following series

[v2] macvlan: allow source mode devices along with passthru
https://lore.kernel.org/all/20260709100512.1383421-1-t.martitz@fritz.com
* [PATCH v2 1/1] macvlan: allow source mode devices along with passthru

and found the following issue:
general protection fault in macvlan_port_release_mac

Full report is available here:
https://ci.syzbot.org/series/2632619d-fb66-47ac-85a1-a781bbb0d57d

***

general protection fault in macvlan_port_release_mac

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      fe3e786ef4eb6e47d2901f568a27bd920477bbe9
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/90f86060-ab12-43d6-a718-5d0f5eb5df09/config
syz repro: https://ci.syzbot.org/findings/d1f12788-51d7-4251-8fc9-6bfda6a1e20a/syz_repro

batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000118: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000008c0-0x00000000000008c7]
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:macvlan_passthru drivers/net/macvlan.c:78 [inline]
RIP: 0010:macvlan_port_release_mac+0x138/0x490 drivers/net/macvlan.c:807
Code: 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 b9 30 ae fb 48 8b 1b 4c 8d b3 c0 08 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 44 02 00 00 45 8b 36 44 89 f6 83 e6 01
RSP: 0018:ffffc90000117500 EFLAGS: 00010206
RAX: 0000000000000118 RBX: 0000000000000000 RCX: ffff888102e98000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000117630 R08: ffffffff9032faf7 R09: 1ffffffff2065f5e
R10: dffffc0000000000 R11: fffffbfff2065f5f R12: dffffc0000000000
R13: 1ffff92000022ea4 R14: 00000000000008c0 R15: ffff88816b068818
FS:  0000000000000000(0000) GS:ffff88818dc23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb0fefe8158 CR3: 0000000113c9a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 macvlan_port_destroy+0x2eb/0x310 drivers/net/macvlan.c:1343
 unregister_netdevice_many_notify+0x1ad2/0x2150 net/core/dev.c:12464
 unregister_netdevice_many net/core/dev.c:12506 [inline]
 default_device_exit_batch+0x961/0x9e0 net/core/dev.c:13098
 ops_exit_list net/core/net_namespace.c:205 [inline]
 ops_undo_list+0x4b4/0x8d0 net/core/net_namespace.c:252
 cleanup_net+0x572/0x810 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:macvlan_passthru drivers/net/macvlan.c:78 [inline]
RIP: 0010:macvlan_port_release_mac+0x138/0x490 drivers/net/macvlan.c:807
Code: 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 b9 30 ae fb 48 8b 1b 4c 8d b3 c0 08 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 44 02 00 00 45 8b 36 44 89 f6 83 e6 01
RSP: 0018:ffffc90000117500 EFLAGS: 00010206
RAX: 0000000000000118 RBX: 0000000000000000 RCX: ffff888102e98000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000117630 R08: ffffffff9032faf7 R09: 1ffffffff2065f5e
R10: dffffc0000000000 R11: fffffbfff2065f5f R12: dffffc0000000000
R13: 1ffff92000022ea4 R14: 00000000000008c0 R15: ffff88816b068818
FS:  0000000000000000(0000) GS:ffff88818dc23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33163fff CR3: 0000000175a06000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	01 00                	add    %eax,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	d8 48 c1             	fmuls  -0x3f(%rax)
   8:	e8 03 42 80 3c       	call   0x3c804210
   d:	20 00                	and    %al,(%rax)
   f:	74 08                	je     0x19
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 b9 30 ae fb       	call   0xfbae30d2
  19:	48 8b 1b             	mov    (%rbx),%rbx
  1c:	4c 8d b3 c0 08 00 00 	lea    0x8c0(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 44 02 00 00    	jne    0x27b
  37:	45 8b 36             	mov    (%r14),%r14d
  3a:	44 89 f6             	mov    %r14d,%esi
  3d:	83 e6 01             	and    $0x1,%esi


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

