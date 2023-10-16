Return-Path: <netdev+bounces-41502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746C7CB21A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AC81C20910
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464C328CD;
	Mon, 16 Oct 2023 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQ+1PPOD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754C328A7
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:08:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69349B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:08:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a507eb61a6so70727517b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697479733; x=1698084533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/sXjyVokvW3s+tuEtHFC3wkNl22yyKxrTWWPfcViJg=;
        b=cQ+1PPOD7Mm6BkgB0V2mHffXN4/RtdA7+EKnV7oDQict5hQaUM34vo/9dPw+hpchSP
         wsZTx7bwCyRBuhmHKNIh/ijdluC/uzLFoUN5kK1/EzW5JV4dnk8cIavzJeLgf6aOJZRM
         UUlWjmPR5Q1M3bbV5p/ixEGDLNxIzQ5z/akfTe0CueUjzIvdqFikSVaQ29Gk3xeNS64h
         dLI07Qhme9KhUEp+fXz56lXh0ixqSuypvczbkqT2Tk6NJQEjGTzUFO/VZakQdW9Vwp6d
         Nq37nKI52bNiTAo4fKAl8tNCzn7m1mYsQKWVUsP+1ewnluQ5AfVPT86DMeLtWf8fl2vL
         7f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697479733; x=1698084533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/sXjyVokvW3s+tuEtHFC3wkNl22yyKxrTWWPfcViJg=;
        b=tVMkld4BBVNnSbpFddrALUX8RsANlWaqc6/3OXkiB1kOFMtCUcfgseDcLJs6aYJd1I
         Ss0BE1puTj9Y1DUT1sYe/pm8qJR99jR3Wes+XagMqN0Vr74DdzXYHvJUc1NYwpC2jqa0
         GdUgdDt7fH2Rrm3Ah6kpp7+vzepFxPXSP+6ZN3bmEmm15cnA95FasKVlKJY2mZtawAq8
         ASHv/ixjlyXt/aF9HxiY3CPoXAiAKHdCjG5DBs3E+YKuigm2uKtOdg8jFZ0YKjY0eiVj
         IDLgCRB3CpO96nljiG3baHvbyivlidZxDYQcSDXbQVzre61tQupi0ClxFPZMJTjOZPGs
         g6ng==
X-Gm-Message-State: AOJu0Yyi/MiyF0CsPhhfs0uHm/JrY4qnnAm3HI5xPe47Wv/NqMxCHzuV
	gH5MVxEk/iUBYm21TybZv4AuRO+IoezzgQ==
X-Google-Smtp-Source: AGHT+IGRB1wLHCm0n2khOWMMmxdju25G2GkYb+83R5SurwIToZC7AeHYmzYlN5tuKNQA6+gc8MtSgHNMT4hDBw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:2996:b0:5a7:af69:a279 with SMTP
 id eh22-20020a05690c299600b005a7af69a279mr436122ywb.9.1697479733056; Mon, 16
 Oct 2023 11:08:53 -0700 (PDT)
Date: Mon, 16 Oct 2023 18:08:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231016180851.3560092-1-edumazet@google.com>
Subject: [PATCH net] tun: prevent negative ifindex
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After commit 956db0a13b47 ("net: warn about attempts to register
negative ifindex") syzbot is able to trigger the following splat.

Negative ifindex are not supported.

WARNING: CPU: 1 PID: 6003 at net/core/dev.c:9596 dev_index_reserve+0x104/0x210
Modules linked in:
CPU: 1 PID: 6003 Comm: syz-executor926 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dev_index_reserve+0x104/0x210
lr : dev_index_reserve+0x100/0x210
sp : ffff800096a878e0
x29: ffff800096a87930 x28: ffff0000d04380d0 x27: ffff0000d04380f8
x26: ffff0000d04380f0 x25: 1ffff00012d50f20 x24: 1ffff00012d50f1c
x23: dfff800000000000 x22: ffff8000929c21c0 x21: 00000000ffffffea
x20: ffff0000d04380e0 x19: ffff800096a87900 x18: ffff800096a874c0
x17: ffff800084df5008 x16: ffff80008051f9c4 x15: 0000000000000001
x14: 1fffe0001a087198 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d41c9bc0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800091763d88 x4 : 0000000000000000 x3 : ffff800084e04748
x2 : 0000000000000001 x1 : 00000000fead71c7 x0 : 0000000000000000
Call trace:
dev_index_reserve+0x104/0x210
register_netdevice+0x598/0x1074 net/core/dev.c:10084
tun_set_iff+0x630/0xb0c drivers/net/tun.c:2850
__tun_chr_ioctl+0x788/0x2af8 drivers/net/tun.c:3118
tun_chr_ioctl+0x38/0x4c drivers/net/tun.c:3403
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:871 [inline]
__se_sys_ioctl fs/ioctl.c:857 [inline]
__arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
__invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 11348
hardirqs last enabled at (11347): [<ffff80008a716574>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last enabled at (11347): [<ffff80008a716574>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (11348): [<ffff80008a627820>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last enabled at (11138): [<ffff8000887ca53c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last enabled at (11138): [<ffff8000887ca53c>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
softirqs last disabled at (11136): [<ffff8000887ca41c>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (11136): [<ffff8000887ca41c>] release_sock+0x3c/0x1b0 net/core/sock.c:3518

Fixes: fb7589a16216 ("tun: Add ability to create tun device with given index")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/tun.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 89ab9efe522c30bd167d690f60c6b18fc29680a5..afa5497f7c35c3ab5682e66440afc8a888d14414 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3073,10 +3073,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct net *net = sock_net(&tfile->sk);
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	unsigned int ifindex, carrier;
+	unsigned int carrier;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
+	int ifindex;
 	int sndbuf;
 	int vnet_hdr_sz;
 	int le;
@@ -3132,7 +3133,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EFAULT;
 		if (copy_from_user(&ifindex, argp, sizeof(ifindex)))
 			goto unlock;
-
+		ret = -EINVAL;
+		if (ifindex < 0)
+			goto unlock;
 		ret = 0;
 		tfile->ifindex = ifindex;
 		goto unlock;
-- 
2.42.0.655.g421f12c284-goog


