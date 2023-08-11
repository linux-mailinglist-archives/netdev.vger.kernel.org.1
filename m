Return-Path: <netdev+bounces-26810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3377911B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F67E2822AB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04229DF5;
	Fri, 11 Aug 2023 13:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188763B3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:57:09 +0000 (UTC)
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CFB2D7F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:57:07 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-68732996d32so3163981b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762226; x=1692367026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMlVZlWE/dk55GwzPGz9vyZlRIwuGqC03/tu4YFsQjI=;
        b=RDPqNPkelfjw7zi+jVUgjBsbEo8lJYdhiQYkm3UVUM6/nt5ZqDNXH4/EbfTuHx+1gC
         dwdiE/XRMFRfJkPzuHOPSkOylP8bXAR8gfQO4CsTtAXv1DEmPnvcOxWndmaSwrWm0Qk3
         7NnpF/2IHC6ClQ0Gh0Bjmno95zDyZFjMfpKeskxS+nrR27Er4R6czsGxA/NKDrRirwFp
         eFzejweebYOzjJXZqiPFdAkUKu8k8cyzObRFzAn7z7Vrolw+aJosOecYg+llcbxu4fMZ
         b5FhfUiMrWuxurNVFrlyiHIC6ZsfuDdRXTKTS/nqT3iEYhLmbWut4VgrUOLFj4/ZQFPd
         aZ4A==
X-Gm-Message-State: AOJu0YzQlIN1QxdohcasI+z6Xeclvi+qJdO+UqDfGtV1t3+1K/QrCKF8
	r6excQHxSYEQeOXMKKewgjsNPN0JaZwu2MnuyS34ti7QXxlF
X-Google-Smtp-Source: AGHT+IG6qvjXDrmLcc0m+c3CgWdtNEHOO0UM8F4u6NBo7zESTPobXBABkVZttBKPsFMCMSP5QGh300ETRxFcWAjPEu3qIci3Umhn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a27:b0:687:94c2:106 with SMTP id
 fj39-20020a056a003a2700b0068794c20106mr833132pfb.5.1691762226631; Fri, 11 Aug
 2023 06:57:06 -0700 (PDT)
Date: Fri, 11 Aug 2023 06:57:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090196d0602a6167d@google.com>
Subject: [syzbot] [net?] WARNING in unregister_vlan_dev
From: syzbot <syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122a53aba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=662f783a5cdf3add2719
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1604a23da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15261ffda80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf6b84b5998f/disk-048c796b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4000dee89ebe/vmlinux-048c796b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b700ee9bd306/bzImage-048c796b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5027 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 0 PID: 5027 Comm: syz-executor906 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
RSP: 0018:ffffc900039bfae0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000027f95e01 RCX: 0000000000000000
RDX: ffff88802d241dc0 RSI: ffffffff8829a7b8 RDI: 0000000000000001
RBP: ffff88807c680000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8a40008b R12: ffff888029882e80
R13: 0000000000000000 R14: 0000000000000002 R15: ffff888029882e80
FS:  0000555555f8f380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002800 CR3: 000000007f16b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2e5/0x3c0 net/core/dev.c:10786
 unregister_vlan_dev+0x2a9/0x580 net/8021q/vlan.c:118
 vlan_ioctl_handler+0x387/0xa80 net/8021q/vlan.c:627
 sock_ioctl+0x4b0/0x6e0 net/socket.c:1271
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f29480b4419
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb9d37898 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2948101390 RCX: 00007f29480b4419
RDX: 0000000020002800 RSI: 0000000000008982 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007ffdb9d378e0
R13: 00007ffdb9d378b0 R14: 0000000000000001 R15: 00007ffdb9d378e0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

