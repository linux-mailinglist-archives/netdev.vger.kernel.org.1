Return-Path: <netdev+bounces-31006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF478A807
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4391C20431
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08FF46B4;
	Mon, 28 Aug 2023 08:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0E10FE
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:47:37 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DEDEC
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:47:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fbfcb8d90so44379067b3.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693212453; x=1693817253;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZLUD06eJQo5YxL3R/I5qpo6rcedYN5OtbIsbSO0ygfo=;
        b=f2V9TMthzRMgAVpdk9RuwMuUwrHnH9gTXiynXc04UyWnHZMqcu4cWFtafZPCkOY0ff
         K8GOfxjp6vnaYOXsjHPgezWoXxsD7TEay/gWwO81++4/NgHBIeCn6nqmgyqFVLOczwtN
         n+G/16ISC8p3Z4InWmHjl4kTKhQxl3EmM9EP1nnoSw4etPn+W8DH24I25rabJZwlm6Ey
         tLuEJF/8CNP1sAxPj+id3TudgOFRhhC2PajmYXLkDT9pyKDB1tvBhW1nEFGnqUUbZ9gl
         hz80LXP1+YYb0YtcAO73bN0zJoycMyYwWPLYQdRm52jLkcXJMVaT9mDaECKcej1TxUap
         Ubow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693212453; x=1693817253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLUD06eJQo5YxL3R/I5qpo6rcedYN5OtbIsbSO0ygfo=;
        b=iz/nhPlm+21AIAtLu6YEdjGA6AXIK7eQ1I902r5ybNChdB+Aeq+Hcfvg/pmar45RJD
         EO2BjgnTZ97XtCNN/Iu6yNg3Hc6NsPECxUOck6kHPxwC3ZxvlnE2hU/Y67X0J2/1cKQj
         YGNMyJGVM1brk+oItxtfBgsCboMD9Wv88rvLb/OXWSsZJs8PNHJ095FtIivNUd9VS6X2
         BMbpicpmS9csq0e7c+VCnJcGH7WDsLhyO3puajOQToqcgtXllhH+Qbt9OvpPCWUQSqUI
         GKDyM+AtzmkveqRTKusDZDWQjcfsDckdlywA556+bKo2htRudJsfNekt6B79SN+0UG/p
         2D0Q==
X-Gm-Message-State: AOJu0YzYikLmOzxTmzmdiz2oBsemx8h4k6OopgZUZ1A0pgJKL+dg0ebu
	0z/044aPJLSImqyp/a3xJU8x5+ZuvipF8Q==
X-Google-Smtp-Source: AGHT+IHilwGafP6lR47I+suxahU+UhUmuARRlnyMy5wGsCaNDvNSJ5NEvY77k8Pwx87wXXX2HCI7WFFVhqvHcw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4506:0:b0:56d:647:664b with SMTP id
 s6-20020a814506000000b0056d0647664bmr877466ywa.5.1693212453467; Mon, 28 Aug
 2023 01:47:33 -0700 (PDT)
Date: Mon, 28 Aug 2023 08:47:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828084732.2366402-1-edumazet@google.com>
Subject: [PATCH net-next] inet: fix IP_TRANSPARENT error handling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

My recent patch forgot to change error handling for IP_TRANSPARENT
socket option.

WARNING: bad unlock balance detected!
6.5.0-rc7-syzkaller-01717-g59da9885767a #0 Not tainted
-------------------------------------
syz-executor151/5028 is trying to release lock (sk_lock-AF_INET) at:
[<ffffffff88213983>] sockopt_release_sock+0x53/0x70 net/core/sock.c:1073
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor151/5028:

stack backtrace:
CPU: 0 PID: 5028 Comm: syz-executor151 Not tainted 6.5.0-rc7-syzkaller-01717-g59da9885767a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
__lock_release kernel/locking/lockdep.c:5438 [inline]
lock_release+0x4b5/0x680 kernel/locking/lockdep.c:5781
sock_release_ownership include/net/sock.h:1824 [inline]
release_sock+0x175/0x1b0 net/core/sock.c:3527
sockopt_release_sock+0x53/0x70 net/core/sock.c:1073
do_ip_setsockopt+0x12c1/0x3640 net/ipv4/ip_sockglue.c:1364
ip_setsockopt+0x59/0xe0 net/ipv4/ip_sockglue.c:1419
raw_setsockopt+0x218/0x290 net/ipv4/raw.c:833
__sys_setsockopt+0x2cd/0x5b0 net/socket.c:2305
__do_sys_setsockopt net/socket.c:2316 [inline]
__se_sys_setsockopt net/socket.c:2313 [inline]

Fixes: 4bd0623f04ee ("inet: move inet->transparent to inet->inet_flags")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/ipv4/ip_sockglue.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 54ad0f0d5c2dd2273f290de5693060a2cb185534..d1c73660b844949b57960630e0467112da4f0abd 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1007,12 +1007,10 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 	case IP_TRANSPARENT:
 		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
-			err = -EPERM;
-			break;
-		}
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
 		if (optlen < 1)
-			goto e_inval;
+			return -EINVAL;
 		inet_assign_bit(TRANSPARENT, sk, val);
 		return 0;
 	case IP_NODEFRAG:
-- 
2.42.0.rc1.204.g551eb34607-goog


