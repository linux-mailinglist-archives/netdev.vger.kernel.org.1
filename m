Return-Path: <netdev+bounces-298333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jU0lAJUZK2qu2gMAu9opvQ
	(envelope-from <netdev+bounces-298333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7D6751D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:24:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298333-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298333-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A61E931DEA3E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35A3AA4F6;
	Thu, 11 Jun 2026 20:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB63A9629
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:24:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209487; cv=none; b=QNk84X5AyOEx7tb6JNvzBvIypQhNzvF2YgNtm3fUm/LJL2fiaEQQv2U0esw/jPYOU116aE3KU7Nn2xba23OCj8DVHPsBqyLpBVVp5FjflegKNvpfm/yrHTNh+Etl5jGxDznksabyy4KdklhGXELAwfWTuRAqMQYjL/R1M3Tb65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209487; c=relaxed/simple;
	bh=cwQp9RYZSVROTPNW2Mx1xJuRUo48ZQKS9/ilG+tlnMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mhiMdw8A6re5sRcY/sba7+pO/CAd2DjGWxYIjKYCVxfG+bwIz2zgaCAtpx8C9JKwn0nh5cuanJMtpgQ82nKsWGwWW++vnAmOVle3c60AV2k8Tv6eNZdPgvFfY50Q44Wm6GKJjdb9Cd7NDkksecZLlbAyQJP2cEU/NJPSFWm3ipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso609676a34.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209480; x=1781814280;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ0XVG+J6ePfnG2Ysl3vzXgB33Kh11LqKEd4gUXQNEg=;
        b=Hn457FVwYqxdG4a6jUPql9TCdMahx3tLo+RPks6CcPqpmvtPKm5Hk9iOlA1FV3AK8Z
         JuMo0HiaDWQD8Le7MCuES68V+K62kGRwmyutgIbrO54Ope5XVXkJsXGmVSsvCXXl9BYP
         /JXsXeAWPBF0el11Q6CLayolX89TFiLMd9lUMPk9vYh5tdKKHyBgUHEB2GYfkeYL+x74
         04UIaABnTYRgBf8a0DFxp91z2/evv4y2C8AR7fCdzdThp2Rgw1Aq8Ns/dgM48bX7tfof
         CihpR8oh2D8xR7DWCuKLQapUBWwwnSuZXLtIQHBfCnLPpAx4Jb6IQXy+feiI84WSxj9C
         3V1A==
X-Forwarded-Encrypted: i=1; AFNElJ+gbqpRzniqGccIZJFMbfITv+KoClE7QCFWBVJE2Mh9lNnRhYQQbUIrtWSgHatIkCjiBVugBKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfQ5JKG3dRVl5oqFNBFt8yBOKCwFuqAXXYT3pIqZO5KW4OEC3
	2TY6TOqeUf+alc83xidTeEZrb84aY2F4MexPfyA7aatPQwWsQJLbOWfR7N/CI+VTnt0OEuGj+DA
	/zTBsJZ1+l23LMGNmNhWGtM5wNaC8z41nlY88p0fCiRNDYV6k7iM+ARdVsRw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:608:b0:69e:390e:b98f with SMTP id
 006d021491bc7-69ecade914cmr3250855eaf.4.1781209479754; Thu, 11 Jun 2026
 13:24:39 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:24:39 -0700
In-Reply-To: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2b1987.99669fcc.12a77b.0000.GAE@google.com>
Subject: [syzbot ci] Re: mm: Unconditional per-VMA locks and cleanups
From: syzbot ci <syzbot+ci9dd46370954d5c77@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aliceryhl@google.com, arve@android.com, 
	christian@brauner.io, cmllamas@google.com, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dsahern@kernel.org, gregkh@linuxfoundation.org, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ljs@kernel.org, netdev@vger.kernel.org, shakeel.butt@linux.dev, 
	surenb@google.com, tkjos@android.com, vbabka@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:aliceryhl@google.com,m:arve@android.com,m:christian@brauner.io,m:cmllamas@google.com,m:dave.hansen@linux.intel.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:gregkh@linuxfoundation.org,m:liam.howlett@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,m:vbabka@kernel.org,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298333-lists,netdev=lfdr.de,ci9dd46370954d5c77];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspotmail.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlesource.com:url,googlegroups.com:email,appspotmail.com:email,syzbot.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AD7D6751D0

syzbot ci has tested the following series

[v2] mm: Unconditional per-VMA locks and cleanups
https://lore.kernel.org/all/20260610230409.A44D29FA@davehans-spike.ostc.intel.com
* [PATCH v2 1/5] mm: Make per-VMA locks available universally
* [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
* [PATCH v2 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
* [PATCH v2 4/5] binder: Remove mmap_lock fallback
* [PATCH v2 5/5] tcp: Remove mmap_lock fallback path

and found the following issue:
general protection fault in tcp_zerocopy_receive

Full report is available here:
https://ci.syzbot.org/series/3e6d125a-b2ae-49a4-b833-babfb8bc9150

***

general protection fault in tcp_zerocopy_receive

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      c8459ee2fef502d6ef6c063751c33d9ac7943eab
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/e7d66981-7900-4c3d-b992-664ccd13a57e/config
syz repro: https://ci.syzbot.org/findings/59d09544-f280-48fe-8ca9-a2fd8225e9df/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 5876 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:vma_start_read_locked_nested include/linux/mmap_lock.h:240 [inline]
RIP: 0010:vma_start_read_locked+0xa0/0x300 include/linux/mmap_lock.h:257
Code: 28 84 c0 0f 85 2b 02 00 00 44 8b 35 ba 0d 1b 0e 31 ff 44 89 f6 e8 c0 e2 af ff 45 85 f6 74 48 4c 8d 73 10 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 b1 37 1b 00 bf 38 03 00 00 49 03
RSP: 0018:ffffc9000399f4a0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88816d558000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000399f538 R08: ffff8881076c64df R09: 1ffff11020ed8c9b
R10: dffffc0000000000 R11: ffffed1020ed8c9c R12: 1ffff92000733e94
R13: dffffc0000000000 R14: 0000000000000010 R15: 0000000000011000
FS:  00007f4866b966c0(0000) GS:ffff88818dc86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000011000 CR3: 0000000117c8a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 vma_start_read_unlocked+0x3f/0x70 mm/mmap_lock.c:362
 find_tcp_vma net/ipv4/tcp.c:2173 [inline]
 tcp_zerocopy_receive+0x762/0x2200 net/ipv4/tcp.c:2227
 do_tcp_getsockopt+0x2079/0x2940 net/ipv4/tcp.c:4758
 tcp_getsockopt+0x83/0x130 net/ipv4/tcp.c:4856
 do_sock_getsockopt+0x51d/0x7e0 net/socket.c:2487
 __sys_getsockopt net/socket.c:2518 [inline]
 __do_sys_getsockopt net/socket.c:2525 [inline]
 __se_sys_getsockopt net/socket.c:2522 [inline]
 __x64_sys_getsockopt+0x1a4/0x240 net/socket.c:2522
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4865d9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4866b96028 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007f4866015fa0 RCX: 00007f4865d9ce59
RDX: 0000000000000023 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007f4865e32d6f R08: 0000200000000380 R09: 0000000000000000
R10: 0000200000000340 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4866016038 R14: 00007f4866015fa0 R15: 00007ffc748de268
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_start_read_locked_nested include/linux/mmap_lock.h:240 [inline]
RIP: 0010:vma_start_read_locked+0xa0/0x300 include/linux/mmap_lock.h:257
Code: 28 84 c0 0f 85 2b 02 00 00 44 8b 35 ba 0d 1b 0e 31 ff 44 89 f6 e8 c0 e2 af ff 45 85 f6 74 48 4c 8d 73 10 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 b1 37 1b 00 bf 38 03 00 00 49 03
RSP: 0018:ffffc9000399f4a0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88816d558000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000399f538 R08: ffff8881076c64df R09: 1ffff11020ed8c9b
R10: dffffc0000000000 R11: ffffed1020ed8c9c R12: 1ffff92000733e94
R13: dffffc0000000000 R14: 0000000000000010 R15: 0000000000011000
FS:  00007f4866b966c0(0000) GS:ffff88818dc86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4865dea540 CR3: 0000000117c8a000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	28 84 c0 0f 85 2b 02 	sub    %al,0x22b850f(%rax,%rax,8)
   7:	00 00                	add    %al,(%rax)
   9:	44 8b 35 ba 0d 1b 0e 	mov    0xe1b0dba(%rip),%r14d        # 0xe1b0dca
  10:	31 ff                	xor    %edi,%edi
  12:	44 89 f6             	mov    %r14d,%esi
  15:	e8 c0 e2 af ff       	call   0xffafe2da
  1a:	45 85 f6             	test   %r14d,%r14d
  1d:	74 48                	je     0x67
  1f:	4c 8d 73 10          	lea    0x10(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 b1 37 1b 00       	call   0x1b37ea
  39:	bf 38 03 00 00       	mov    $0x338,%edi
  3e:	49                   	rex.WB
  3f:	03                   	.byte 0x3


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

