Return-Path: <netdev+bounces-110590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47492D4DE
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162091F22146
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09519194140;
	Wed, 10 Jul 2024 15:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFA18EFE0
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624886; cv=none; b=ZGBOJxF2ox1SVbPGKs3er+0lwWWF47vbhJXMlL1PZmZV0qkvcG73qlqg2LaTL/0WP4wdZ8JNV7ZqMUZj44VavpOkDTWLvSmlYNHCpnSxZhXiTFJ1GykWnTU3yJD8A2kRBQ+MgTKaIh78zdRQXvNmc8PFGwXIipSsXJXJsSUelJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624886; c=relaxed/simple;
	bh=tzP8zIxopcJsOmcjsM8AJL7Wlp4Sri4G1wOpI92nR7E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fc+OSI41o9nOS1OdW/nF5Ri2fDHczy2gQZ/u9hM1Z8CA4SPnYUJN0pzuRiIrP+q+lWjxir3Yyzf5mrE8NrW7Krtz7Opb1+N+9GvmJPqtrfAJZQXNbiFngRQ3F335xM0AwEljk4i4rOHryjFiEkDZYlwXrt5RkY1IzPc5VcFn9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-381f1b3050bso64448955ab.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624884; x=1721229684;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxxII31q7fuG7hZ/Q2eiQTNmx2gCG6jesezUdHaFxcw=;
        b=Plv1i1ryLE4xM2IC+MyUAZxDmYQqC4vxE5Aj7DijJmXrvF7ram1B0IEDutEVmLcNJc
         mSjq1FtsfL63t6ZktuUtT4R07vQuKfqbg3pKqYst88Uf/Y58Uxq1RaFN3hicVae//243
         RODIrJpHrsIsy+clij2AatzIb+6yF02Te7x+xqU6DgI028MLe97ixH7PCmdAujtxrVGb
         KdzYBR80AvI5Vh8LEI66h8QvzTjTWfuzxzCzn0XnjteY2eKCZgR+pzWnw/7BshYMFTCq
         cAdIdh/44INFjLmqWOiJSwYkxap2k92ckfITO8KDA5xS9rCodjUAHHNlogbVrCeSRQxQ
         3B0w==
X-Forwarded-Encrypted: i=1; AJvYcCVXVPIB/AB7gttryk1pSh2kk63PNr8JBUrLPveYzaH7eH17D8R1nYkQxXfq0NxvMCdj9FycRH6KWRseIB+h1GfG9gDLMNux
X-Gm-Message-State: AOJu0Yyo2DCF7d5J/UiklJgAMrVViImzpgpaeVbFrI/IqJkfNUWztY5W
	3HHTIYfxY5s1l7aOOU1PVJ06fYk7fEv2NOpFmE36Cos1FqtPB9u8Kg86BAPzLRwrAnjY0LyYlPv
	XocXTgJCiNT+Vj0SJDaZZdSO1WUSkf/mmPsTHzSVo571hHtbHxYS42tk=
X-Google-Smtp-Source: AGHT+IGhZ33aGEZmppDxzUhDwXzPJ/Kd0/t+OCu65s73HBSGGE2nxAfzeRETdCnK8Xg0ZOC3MhLNbs7/qHBMjWNwrZyle85iNh8t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d9c1:0:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-38a56c0a199mr598775ab.1.1720624884607; Wed, 10 Jul 2024
 08:21:24 -0700 (PDT)
Date: Wed, 10 Jul 2024 08:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009ff2e061ce633d7@google.com>
Subject: [syzbot] [net?] possible deadlock in ip_mroute_setsockopt
From: syzbot <syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40ab9e0dc865 netxen_nic: Use {low,upp}er_32_bits() helpers
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14ce4831980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=e227429f6fa77945d7e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82323446a05a/disk-40ab9e0d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ef73ffa3427/vmlinux-40ab9e0d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38572b425814/bzImage-40ab9e0d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-01403-g40ab9e0dc865 #0 Not tainted
------------------------------------------------------
syz.1.1201/8409 is trying to acquire lock:
ffffffff8f5e9108 (rtnl_mutex){+.+.}-{3:3}, at: ip_mroute_setsockopt+0x15b/0x1190 net/ipv4/ipmr.c:1369

but task is already holding lock:
ffff88805f784c50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3064

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
       __do_sys_sendto net/socket.c:2204 [inline]
       __se_sys_sendto net/socket.c:2200 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2200
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ipv6_setsockopt+0xbf3/0x3630 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0x5c/0x1a0 net/ipv6/ipv6_sockglue.c:993
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ip_mroute_setsockopt+0x15b/0x1190 net/ipv4/ipmr.c:1369
       do_ip_setsockopt+0x129f/0x3cd0 net/ipv4/ip_sockglue.c:948
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET6 --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz.1.1201/8409:
 #0: ffff88805f784c50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3064

stack backtrace:
CPU: 0 PID: 8409 Comm: syz.1.1201 Not tainted 6.10.0-rc6-syzkaller-01403-g40ab9e0dc865 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ip_mroute_setsockopt+0x15b/0x1190 net/ipv4/ipmr.c:1369
 do_ip_setsockopt+0x129f/0x3cd0 net/ipv4/ip_sockglue.c:948
 ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
 smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5dfd375bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5dfe06b048 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f5dfd503f60 RCX: 00007f5dfd375bd9
RDX: 00000000000000ca RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f5dfd3e4e60 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000020000100 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5dfd503f60 R15: 00007fff4a8a5b18
 </TASK>


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

