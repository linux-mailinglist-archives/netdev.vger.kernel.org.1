Return-Path: <netdev+bounces-14897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4EC744626
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 05:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B81C20846
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EE17F3;
	Sat,  1 Jul 2023 03:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483A17F2
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 03:05:17 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABB49E0
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 20:00:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b10f171e0so2485965a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 20:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688180416; x=1690772416;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2wiAgAbJ3Wjk7juSdNsz+B6N/zmZMeaxN1RCHIrworw=;
        b=Zu9q3EXTKXEG6r8TMScaZIq4UhvnRICptpEs6Q3cCKr/0GfDU95bUN6mpUdAeiN5xD
         FtZBEM3LHWTFr5Q3eIXUXS9CWDYPBcWgPvA57BMM5TeSlXK5bBcT5n1HwlpyvoOvzmSL
         ZrM2ooByxznbp1HNVlKKtn1S0XNT2l5S+WMzFhgZEBBE8jxjILZoNzKJtw9CXXN+GOrD
         f6dsTUb2QwA3iD79arre3N1n50MCfOiCTaEcRlNDBUEyA3DgjBJhvw6S2Hrlv2HVPuIO
         71DW5rbtw4U2zl9rJ/Uz3eKcYuXswzwqCzLFDKPw1YNYhkZXa14VOgpU3i4IkLJPmR5U
         YryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688180416; x=1690772416;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wiAgAbJ3Wjk7juSdNsz+B6N/zmZMeaxN1RCHIrworw=;
        b=DdwmUhxpjaOQX72tvZDbDOjLbF2AmoljceLz0d4G9/I7Kqrr3R7JTzDdVjDA8URnYq
         VyVK2xRu38cin9JxxRtGMvx/PPpAOsUw8V5UCPYw6F1Vuqvg3XMYbdVlJlMmpIozofGN
         Ol5r367Qd4vbtRgUkB+h3Cotjvg3Gh5+D1/QZIeo+Kdy6ouRaWgBito+5r8gaDvaz1qF
         SZJGR8X+1yZie3ZM5+1P+L7qyZKEkA+NJQF1Pi5p/O//O3iGYImNEv/RVOjZXyTiSGOw
         l66eMD/md8snuXCmLhRhteL5ytnoQ55vzHT0hl/qu2T+gqTlv3sv/WNg2xdiMqh16cx5
         rh9Q==
X-Gm-Message-State: ABy/qLaapgGuvg4uVqFEM/Fpb0OqtamCinnOPaaDcmLhmkYm3Ll+5i31
	uOtsxfWM8mmj+p5xgAG2CsI2PJA+yzNpJw==
X-Google-Smtp-Source: APBJJlGbwjoRXF7vacvhH66Iu43FGmpxCA2Jtx/7qBuDnjy/Xv/cMzkDA580jYYvHSn/vDiXVoLiZwVAGHDBNw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:346:0:b0:bac:adb8:a605 with SMTP id
 67-20020a250346000000b00bacadb8a605mr30376ybd.2.1688179706427; Fri, 30 Jun
 2023 19:48:26 -0700 (PDT)
Date: Sat,  1 Jul 2023 02:48:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230701024825.2689655-1-edumazet@google.com>
Subject: [PATCH net] net: fix net_dev_start_xmit trace event vs skb_transport_offset()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

After blamed commit, we must be more careful about using
skb_transport_offset(), as reminded us by syzbot:

WARNING: CPU: 0 PID: 10 at include/linux/skbuff.h:2868 skb_transport_offset include/linux/skbuff.h:2977 [inline]
WARNING: CPU: 0 PID: 10 at include/linux/skbuff.h:2868 perf_trace_net_dev_start_xmit+0x89a/0xce0 include/trace/events/net.h:14
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/u4:1 Not tainted 6.1.30-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
RIP: 0010:skb_transport_header include/linux/skbuff.h:2868 [inline]
RIP: 0010:skb_transport_offset include/linux/skbuff.h:2977 [inline]
RIP: 0010:perf_trace_net_dev_start_xmit+0x89a/0xce0 include/trace/events/net.h:14
Code: 8b 04 25 28 00 00 00 48 3b 84 24 c0 00 00 00 0f 85 4e 04 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc e8 56 22 01 fd <0f> 0b e9 f6 fc ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 86 f9 ff
RSP: 0018:ffffc900002bf700 EFLAGS: 00010293
RAX: ffffffff8485d8ca RBX: 000000000000ffff RCX: ffff888100914280
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: ffffc900002bf818 R08: ffffffff8485d5b6 R09: fffffbfff0f8fb5e
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff110217d8f67
R13: ffff88810bec7b3a R14: dffffc0000000000 R15: dffffc0000000000
FS: 0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f96cf6d52f0 CR3: 000000012224c000 CR4: 0000000000350ef0
Call Trace:
<TASK>
[<ffffffff84715e35>] trace_net_dev_start_xmit include/trace/events/net.h:14 [inline]
[<ffffffff84715e35>] xmit_one net/core/dev.c:3643 [inline]
[<ffffffff84715e35>] dev_hard_start_xmit+0x705/0x980 net/core/dev.c:3660
[<ffffffff8471a232>] __dev_queue_xmit+0x16b2/0x3370 net/core/dev.c:4324
[<ffffffff85416493>] dev_queue_xmit include/linux/netdevice.h:3030 [inline]
[<ffffffff85416493>] batadv_send_skb_packet+0x3f3/0x680 net/batman-adv/send.c:108
[<ffffffff85416744>] batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
[<ffffffff853bc52a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:393 [inline]
[<ffffffff853bc52a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:421 [inline]
[<ffffffff853bc52a>] batadv_iv_send_outstanding_bat_ogm_packet+0x69a/0x840 net/batman-adv/bat_iv_ogm.c:1701
[<ffffffff8151023c>] process_one_work+0x8ac/0x1170 kernel/workqueue.c:2289
[<ffffffff81511938>] worker_thread+0xaa8/0x12d0 kernel/workqueue.c:2436

Fixes: 66e4c8d95008 ("net: warn if transport header was not set")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 include/trace/events/net.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index da611a7aaf970f541949cdd87ac9203c4c7e81b1..f667c76a3b022971b28e8418ad681d8aa0a26442 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -51,7 +51,8 @@ TRACE_EVENT(net_dev_start_xmit,
 		__entry->network_offset = skb_network_offset(skb);
 		__entry->transport_offset_valid =
 			skb_transport_header_was_set(skb);
-		__entry->transport_offset = skb_transport_offset(skb);
+		__entry->transport_offset = skb_transport_header_was_set(skb) ?
+			skb_transport_offset(skb) : 0;
 		__entry->tx_flags = skb_shinfo(skb)->tx_flags;
 		__entry->gso_size = skb_shinfo(skb)->gso_size;
 		__entry->gso_segs = skb_shinfo(skb)->gso_segs;
-- 
2.41.0.255.g8b1d071c50-goog


