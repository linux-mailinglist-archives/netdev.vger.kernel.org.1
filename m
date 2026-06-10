Return-Path: <netdev+bounces-297462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O2mzHUwAKWqoOgMAu9opvQ
	(envelope-from <netdev+bounces-297462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F16661A9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:12:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297462-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297462-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77EF930319F9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D4371D08;
	Wed, 10 Jun 2026 06:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BA2E92B3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:11:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071891; cv=none; b=SToT4dHMApQPJMDmakx71GUtV+JE32UNWV3k3mSxPi66u82Q84gvPlObVpkU974kshFivg+fv/C5MgJkXzMM7DLf+mHM4FgydUCAphKzKb13PlJaWN6eufyo25hI4fBQd1R6lazcC1JSX5o/d1cKZmMCK6gyXDijNFSchwkUCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071891; c=relaxed/simple;
	bh=SJfpH95K3KVqOA6PwQXNrKEDVjcGxQcdnpDNckbiD44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YXQRI6tsUadJJqsyW5YMJCDAdRW/h0m0zrpFeZAqvKiSkPt6gCZ78vJiAiF0r4TmZnOJN4bWOvmaQyNHSRYC+HwZnh6mIHPvhZQVJ1H57OCzhgb8PvkZ8NqvOFoFvddm2miNp1wm8AW/2wldz1BsJKTSh/qPqpJkpGx3ugKtmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e6fd5f007eso13472007a34.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071889; x=1781676689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNWluBeT0hw+OaMJX5X8l/3bAeW8JB8X5Q39LAJfYoE=;
        b=i1m9pesAYs8TzW1JQYANUYr+VUcWdJpobqXBWpgiXf50GrMwuIqCrM7JCHC8D+6yzI
         j6hckRVuOBymZKWkte8XjpDRIdHcIykQ8ZjCddUnM+Ipumr2bCt8ZMs6TIwGmu0GPcFe
         mAPjsljbXyIRfgt+uirKwHChVrqWL+RwBYxALKPfo+5gfRDcP3hNLQYvBzXPANqotm7y
         qcbaxwPF12DS4UCP9M+n+Xlf+QcjAs6YrF4FqBteQJL19CtFQ9u3z+dTtKusEaAoZfHb
         yuRec5Oe4Jc6r1Lxk2sLGYQ60ohjgIgHOnt8Z8SX9JSAVPn3HAnEtPbTBioWrLJ5Dp2a
         rDmw==
X-Forwarded-Encrypted: i=1; AFNElJ9yOSWtlqcnmBbGW7CxHaXdrYSYJDC9g2oUDW+U8FnIqYD02GT+58xE9q7zRbEJFHiqagHEWBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVpMHjAfEnpbEaptvPLJAC16ALk1m+AyxGA8/OLQ11/xA24Oe
	qJ1IgJhuBUmudl8mI6E3fBHj9Jhc41tZmIo5HsbvtmEpSEpe4ps6r+9+emoOxpJ1T4zWNUas3oQ
	FWMsjjYSbc5gvSo4yQBT62cSntmw5F2d0DgTpZxfou1FSjOg5OGE8PRqhK+c=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c86:b0:69d:8cf6:2e5a with SMTP id
 006d021491bc7-69e6d487e50mr9983736eaf.23.1781071889482; Tue, 09 Jun 2026
 23:11:29 -0700 (PDT)
Date: Tue, 09 Jun 2026 23:11:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a290011.39669fcc.33b062.00b1.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in nsim_fib_event_nb (3)
From: syzbot <syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bd38685893011045];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297462-lists,netdev=lfdr.de,cb2aa2390ac024e25f5c];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 684F16661A9

Hello,

syzbot found the following issue on:

HEAD commit:    6f3ed7fec72f Merge tag 'for-7.1/dm-fixes-3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1144db7e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd38685893011045
dashboard link: https://syzkaller.appspot.com/bug?extid=cb2aa2390ac024e25f5c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/625fc484e456/disk-6f3ed7fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd23de5678d1/vmlinux-6f3ed7fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5395fddce64e/bzImage-6f3ed7fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#1: kworker/u8:8/1044
Modules linked in:
CPU: 1 UID: 0 PID: 1044 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 4b 36 23 fd 48 8d 3d 14 85 f1 0a 67 48 0f b9 3a eb 4a e8 38 36 23 fd 48 8d 3d 11 85 f1 0a <67> 48 0f b9 3a eb 37 e8 25 36 23 fd 48 8d 3d 0e 85 f1 0a 67 48 0f
RSP: 0018:ffffc90005e4f270 EFLAGS: 00010293
RAX: ffffffff84a135d8 RBX: 0000000000000002 RCX: ffff888027863d80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8f92baf0
RBP: 0000000000000000 R08: ffff888027863d80 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880117bd000
R13: dffffc0000000000 R14: ffff88803392903c R15: ffff8880117bd000
FS:  0000000000000000(0000) GS:ffff888126283000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557b57a3d220 CR3: 00000000352b4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 fib_info_hold include/net/ip_fib.h:629 [inline]
 nsim_fib4_prepare_event drivers/net/netdevsim/fib.c:930 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1000 [inline]
 nsim_fib_event_nb+0x1055/0x1240 drivers/net/netdevsim/fib.c:1043
 call_fib_notifier+0x45/0x80 net/core/fib_notifier.c:25
 call_fib_entry_notifier net/ipv4/fib_trie.c:90 [inline]
 fib_leaf_notify net/ipv4/fib_trie.c:2176 [inline]
 fib_table_notify net/ipv4/fib_trie.c:2194 [inline]
 fib_notify+0x36b/0x5e0 net/ipv4/fib_trie.c:2217
 fib_net_dump net/core/fib_notifier.c:70 [inline]
 register_fib_notifier+0x184/0x360 net/core/fib_notifier.c:108
 nsim_fib_create+0x85d/0x9f0 drivers/net/netdevsim/fib.c:1596
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1604 [inline]
 nsim_dev_reload_up+0x374/0x7c0 drivers/net/netdevsim/dev.c:1058
 devlink_reload+0x501/0x8d0 net/devlink/dev.c:475
 devlink_pernet_pre_exit+0x1ff/0x420 net/devlink/core.c:558
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
 cleanup_net+0x56e/0x800 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	eb 66                	jmp    0x68
   2:	85 db                	test   %ebx,%ebx
   4:	74 3e                	je     0x44
   6:	83 fb 01             	cmp    $0x1,%ebx
   9:	75 4c                	jne    0x57
   b:	e8 4b 36 23 fd       	call   0xfd23365b
  10:	48 8d 3d 14 85 f1 0a 	lea    0xaf18514(%rip),%rdi        # 0xaf1852b
  17:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  1c:	eb 4a                	jmp    0x68
  1e:	e8 38 36 23 fd       	call   0xfd23365b
  23:	48 8d 3d 11 85 f1 0a 	lea    0xaf18511(%rip),%rdi        # 0xaf1853b
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 37                	jmp    0x68
  31:	e8 25 36 23 fd       	call   0xfd23365b
  36:	48 8d 3d 0e 85 f1 0a 	lea    0xaf1850e(%rip),%rdi        # 0xaf1854b
  3d:	67                   	addr32
  3e:	48                   	rex.W
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

