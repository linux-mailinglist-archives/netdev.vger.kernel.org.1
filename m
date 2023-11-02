Return-Path: <netdev+bounces-45788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5AC7DF9A3
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC73A281CED
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A02111D;
	Thu,  2 Nov 2023 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3F21104
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 18:12:01 +0000 (UTC)
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929371700
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:11:36 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6cd91356d52so1521218a34.2
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 11:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948696; x=1699553496;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RbtI8xpa03CyJhsKvMnr93wyie1HRbEaEXonJG5DH8=;
        b=ZaYSONNkLW+1JE1Eu47k3HA7p5t/BBcfodTTAfz9jMcfKdacBZxDaTyFP8VFxIuS/L
         zZEIar567GuVa0QRR3tT995948QkuDtaNmSSNxWYF9MbEu/90GKmrrmmRJITzEWoEOhA
         A9a59mMRMDyurSRDjDfqULvQZ2C2JLYtjVqgYP2wKpvRext0IfM/RfnoSwklBfTN+Twx
         Ilwk8aIUs36ZygWSdMTSntrnXE8n9PGVqadwEd6DRmdRt5ZLTfq84OP7QhP9u7sG8o/e
         rPika68I0D6eYlKaZ7XbSMYvX3P4fIHzmeXinwvIvwQLXBLWCa5EtUy6vCEZkS1d25D9
         jwBg==
X-Gm-Message-State: AOJu0YzCoO4VkHyky8F3SfswK72iyukWxs0WvekREo1o1aYzSdo5eYhx
	b1Hm4erd2m5JKzjiHyT486rEieDaOJBJl1hvZkd7AIvOLNFG
X-Google-Smtp-Source: AGHT+IGNMO1VffYnQF9u0dfpNAJh16AvZmj0/iWFfFMNS6Y2wK7AAt4WaTDoeYEL91q6bsBkQsuWE1+rDzH1BduMr/yzbWDLWKQ9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:6b1a:0:b0:6bc:fb26:499e with SMTP id
 g26-20020a9d6b1a000000b006bcfb26499emr5585697otp.2.1698948695863; Thu, 02 Nov
 2023 11:11:35 -0700 (PDT)
Date: Thu, 02 Nov 2023 11:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082378906092f51aa@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find (2)
From: syzbot <syzbot+23bbb17a7878e2b3d1d4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3669558bdf35 Merge tag 'for-6.6-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16656930680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=754d6383bae8bc99
dashboard link: https://syzkaller.appspot.com/bug?extid=23bbb17a7878e2b3d1d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2e55d5455c8/disk-3669558b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a0b7323ae76/vmlinux-3669558b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3430d935a839/bzImage-3669558b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23bbb17a7878e2b3d1d4@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in xfrm_state_find+0x17bc/0x8ce0 net/xfrm/xfrm_state.c:1160
 xfrm_state_find+0x17bc/0x8ce0 net/xfrm/xfrm_state.c:1160
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2469 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2514 [inline]
 xfrm_resolve_and_create_bundle+0x80c/0x4e30 net/xfrm/xfrm_policy.c:2807
 xfrm_lookup_with_ifid+0x3f7/0x3590 net/xfrm/xfrm_policy.c:3141
 xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
 xfrm_lookup_route+0x63/0x2b0 net/xfrm/xfrm_policy.c:3281
 ip6_dst_lookup_flow net/ipv6/ip6_output.c:1246 [inline]
 ip6_sk_dst_lookup_flow+0x1044/0x1260 net/ipv6/ip6_output.c:1278
 udpv6_sendmsg+0x3448/0x4000 net/ipv6/udp.c:1552
 inet6_sendmsg+0x105/0x190 net/ipv6/af_inet6.c:655
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmmsg+0x3c4/0x950 net/socket.c:2681
 __do_sys_sendmmsg net/socket.c:2710 [inline]
 __se_sys_sendmmsg net/socket.c:2707 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2707
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable tmp.i.i created at:
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2447 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2514 [inline]
 xfrm_resolve_and_create_bundle+0x370/0x4e30 net/xfrm/xfrm_policy.c:2807
 xfrm_lookup_with_ifid+0x3f7/0x3590 net/xfrm/xfrm_policy.c:3141

CPU: 0 PID: 26289 Comm: syz-executor.3 Not tainted 6.6.0-rc1-syzkaller-00033-g3669558bdf35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
=====================================================


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

