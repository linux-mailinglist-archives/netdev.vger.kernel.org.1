Return-Path: <netdev+bounces-306454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mj+NBeujUGoG2wIAu9opvQ
	(envelope-from <netdev+bounces-306454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:48:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D89738280
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:48:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306454-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306454-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D18A83012B00
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F843DE45C;
	Fri, 10 Jul 2026 07:48:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EA3D88FA
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 07:48:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669733; cv=none; b=KLqJ0tPBI3yNiQ3u4vXJe7luDgU6gp7zOBroMAFTwgf/cfaJFkLb6T14b6yJIoCira7RyVy/mh5eEOX/lQqyMrOu4U6u0XLEqR1CjQt3OqQXpr+C+uOnG59F2TswNv6I2TOHLqUVFWCaOol5VSwjkNh+7P8rLumEkl3I7HL5STE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669733; c=relaxed/simple;
	bh=M3Z6y4YsWmVKCH5ALvDjolmKNa3zXoIsX8XIF7VJupU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XR53rEr7pye0lLk/leHUgxMSP2QMJAHtacQYBSK3z+8qpL9mZX9tagaY/8aUyI9Zc+l5lzq1gnGA+Hhaqylx0NWvd+EP46TpFELzMAzs5Xh0WHtrIpMSjTHCLXFkLyD6OkzYjBdrr9TdgxVYTEDOtXEyDOz9fCobfpiLJvnQvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a41e3d6fe9so104117b6e.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669726; x=1784274526;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S7iWmIGSqDaBYznUPH1jSqXgLOb7lcIMTX9KV8of18s=;
        b=kh5ux8ZbVcP8dpfZoFoH2Q01dv6GswOek4jYgEuwKKQW2ot62bmJ9ccBaodwuhG9sr
         WvSxQa9wx4DJULbEjC5AQ0pvN32MWOQkyAvjdcKmhFBAS0ErjCF6GG7EFZrfFYXenVDF
         Xr0VglQ+wX2Dby8GNomtQxB+pFOlYWqXspZmsANHTHc3i//ymzP157XznkmHtz5lAfGM
         XARsUAMGeR3snin3jEjsQPgtWwqPgnsHyEhgJscTQ+o3ld7OyVR/t+0ECwDW6J8mMDVc
         riy0eyMzHG8LLGbsjMtP6WFvjwj6dRnPzoBIZkQZJlZ6zigVYoxQLymEmlPXrzbGgM/n
         lyWw==
X-Forwarded-Encrypted: i=1; AFNElJ/ImDkVYyZL9bngn6oF5CjPHampmw2YmirwQ9D/eZVMx+64fJDRJyI+fgsNhtd7YhkizRbBbL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYcXH/iVpZAdX4yZo01X39AxCKxhs3YPnJQpe/wzSkn19QiLj
	xVJnrE6WWhElMrIspWhrV0vbcdUB7jSVQmD3RKiiz4krIkts+Cc1EobZZVhMFnsUAdTxeBpvU0P
	1YSK/q+Y4qpD86r1rojB3nXwknXDNMdqMf+1iqZ/KA3gvup9zYih1ahfny1k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a9:b0:486:8a11:6e8b with SMTP id
 5614622812f47-4a2018ccdcemr8598435b6e.2.1783669726573; Fri, 10 Jul 2026
 00:48:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:48:46 -0700
In-Reply-To: <20260709091138.170348-1-t.martitz@fritz.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a50a3de.c76b52dc.2a15e.000c.GAE@google.com>
Subject: [syzbot ci] Re: macvlan: allow source mode devices along with passthru
From: syzbot ci <syzbot+cibb313f90ba9abb55@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, t.martitz@fritz.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306454-lists,netdev=lfdr.de,cibb313f90ba9abb55];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzbot.org:url,googlegroups.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90D89738280

syzbot ci has tested the following series

[v2] macvlan: allow source mode devices along with passthru
https://lore.kernel.org/all/20260709091138.170348-1-t.martitz@fritz.com
* [PATCH v2 1/1] macvlan: allow source mode devices along with passthru

and found the following issue:
general protection fault in macvlan_port_release_mac

Full report is available here:
https://ci.syzbot.org/series/72476997-558e-41ae-b146-c05346cdd7f6

***

general protection fault in macvlan_port_release_mac

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      fe3e786ef4eb6e47d2901f568a27bd920477bbe9
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/0c5e2f82-62bd-40bf-a873-66f277607c07/config
syz repro: https://ci.syzbot.org/findings/d5d14725-5a48-484c-876d-026175d0b21a/syz_repro

batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000118: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000008c0-0x00000000000008c7]
CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:macvlan_passthru drivers/net/macvlan.c:78 [inline]
RIP: 0010:macvlan_port_release_mac+0x138/0x490 drivers/net/macvlan.c:807
Code: 01 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 b9 30 ae fb 48 8b 1b 4c 8d b3 c0 08 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 44 02 00 00 45 8b 36 44 89 f6 83 e6 01
RSP: 0018:ffffc90000127500 EFLAGS: 00010206
RAX: 0000000000000118 RBX: 0000000000000000 RCX: ffff888102ec5940
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000127630 R08: ffffffff9032faf7 R09: 1ffffffff2065f5e
R10: dffffc0000000000 R11: fffffbfff2065f5f R12: dffffc0000000000
R13: 1ffff92000024ea4 R14: 00000000000008c0 R15: ffff888109b28818
FS:  0000000000000000(0000) GS:ffff8882a9223000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffefe7250d8 CR3: 000000000e746000 CR4: 00000000000006f0
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
RSP: 0018:ffffc90000127500 EFLAGS: 00010206
RAX: 0000000000000118 RBX: 0000000000000000 RCX: ffff888102ec5940
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000127630 R08: ffffffff9032faf7 R09: 1ffffffff2065f5e
R10: dffffc0000000000 R11: fffffbfff2065f5f R12: dffffc0000000000
R13: 1ffff92000024ea4 R14: 00000000000008c0 R15: ffff888109b28818
FS:  0000000000000000(0000) GS:ffff8882a9223000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffefe7250d8 CR3: 000000000e746000 CR4: 00000000000006f0
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

