Return-Path: <netdev+bounces-16004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7B74AEAD
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1934528171C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D63BE5E;
	Fri,  7 Jul 2023 10:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCB63C9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:22:49 +0000 (UTC)
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDBB12A
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 03:22:48 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-262f7a3bc80so2620394a91.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 03:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688725368; x=1691317368;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ueiBuEN+wg/Nr0s18dKyTssSqkuw56srD8rsuBlk7o=;
        b=Q2+hJ4bmbwjj+nQ35cM7/WtO+AaedLWEvfJkv7pAd3Vy4XX5zOheZqausyhA6/drnL
         N8vcsniZ6lWjVc6h3URidREsJE8g76dj/w2kAc5Zu8TT8eJk//CO2IJEnCtz9/fjDnYn
         dlozC9rZPm2X6XOh2IqrZ/1Tbyd4WXVf3fuP0WssH33J0hoQg4SgmWBtZx67kiEz/nSu
         c9jyVWjiyXmK2p7AaKPdomCi1oAsxifxnmVLdaiMnFInjsPOzYBDqHNj4uGp428scjjn
         Y0XRHmpyqIepv59A6OEckCY1Xoe01NPGKvbl4A0/rg4njlKCxyToYM4moazrsqzyvdAZ
         iu3Q==
X-Gm-Message-State: ABy/qLZHku9IUQ3m5zvLJIVnj4/OA6cnFxdRzh60MdGHH1yZY39OOYxs
	32CiPXsg9erf8c50az1Xixf/2NjnuLEHPOGjSfYRQ9k9bSoC
X-Google-Smtp-Source: APBJJlHAjHS5Zwyl861BtEFX+Npa6vDdErTSRVEAvVNf97Q4n430gWj6tp24eGEJUBCbXBiM882ZjGa8ganuzbzKjIAjMXAraUCJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d793:b0:263:2f09:20c3 with SMTP id
 z19-20020a17090ad79300b002632f0920c3mr3945414pju.9.1688725367851; Fri, 07 Jul
 2023 03:22:47 -0700 (PDT)
Date: Fri, 07 Jul 2023 03:22:47 -0700
In-Reply-To: <0000000000006d817e05f85cd6a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac930905ffe30322@google.com>
Subject: Re: [syzbot] [nfc?] UBSAN: shift-out-of-bounds in nci_activate_target
From: syzbot <syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com>
To: anupnewsmail@gmail.com, davem@davemloft.net, edumazet@google.com, 
	krzysztof.kozlowski@linaro.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfc@lists.01.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has found a reproducer for the following issue on:

HEAD commit:    a452483508d7 Merge tag 's390-6.5-2' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161e174aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7df0cabaf5becfdc
dashboard link: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123fc664a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12003f4aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524f562d731e/disk-a4524835.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/253005f05b78/vmlinux-a4524835.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1864a30871e7/bzImage-a4524835.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in net/nfc/nci/core.c:912:45
shift exponent 268435489 is too large for 32-bit type 'int'
CPU: 0 PID: 5028 Comm: syz-executor696 Not tainted 6.4.0-syzkaller-12155-ga452483508d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x221/0x5a0 lib/ubsan.c:387
 nci_activate_target.cold+0x1a/0x1f net/nfc/nci/core.c:912
 nfc_activate_target+0x1f8/0x4c0 net/nfc/core.c:420
 nfc_genl_activate_target+0x1f3/0x290 net/nfc/netlink.c:900
 genl_family_rcv_msg_doit.isra.0+0x1e6/0x2d0 net/netlink/genetlink.c:970
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x4ff/0x7e0 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:748
 ____sys_sendmsg+0x739/0x920 net/socket.c:2494
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2548
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff498fc3ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff49876f2e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff4990542a0 RCX: 00007ff498fc3ab9
RDX: 0000000000000000 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 00007ff49901a510 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000001 R14: 0000000000000000 R15: 00007ff4990542a8
 </TASK>
================================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

