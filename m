Return-Path: <netdev+bounces-24114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133476ED49
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D01C2153F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE31F184;
	Thu,  3 Aug 2023 14:56:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69111ED48
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:56:09 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A883EA
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:56:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583f048985bso12119277b3.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691074561; x=1691679361;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ulqpaPBOW/lrx7s+AySXLD2+ILyfF7UdkCdLLNQGUCU=;
        b=W44gfd+WI9+Jp0vDRJyuJvIAnKe0Yccu/bxV1RnT20G5szj0GZ6XI369KvVXZEB8c+
         ApkSXHWhZvyEaNGe4WgNTzrqgn+mHda7RQeFXpn8Vbb8X5Cfk4gJ3cXOW0NIhJCrQGWo
         IfEpS7zVOh8g2A30cdUsyjhET7xjej3K7tpVqak6AWIDlrISgaWra5l70W+gOcrJSIHf
         YhMyP/sVEfjnv3Eh8ANh4BiBpwzZDzX+K/FhHDhZ8dvFEsHxPiEd1EAzueuYt/OOxUrh
         y80VvD1RijFi2w3yi3btbtHYa7bin8GHrmKasqE5Av3pxCvmq8JnfQSGrreekZoslba/
         Pbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691074561; x=1691679361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulqpaPBOW/lrx7s+AySXLD2+ILyfF7UdkCdLLNQGUCU=;
        b=ZCagFF6GRF6G3SpwmASICIjdsEbHJ/M7IE3O2IYAeKEL6IID+qimvBsTqbeeWv7wOv
         LBItMBR5Os7OFyW7TWNu7a0Q2pH8cHqB3Hni7AZR53fUckDV9NmPInDEHf8alaEX9M1B
         THODPf+DHKIZRAW5vdLA/JLLtyVab+2Rlb/zTBOJtBy4HdRmmiVdK8JKtmuk3T2OVOEx
         eGkf9cGsgncwg/yIhbcuIdCb8mbfoRrbCH9UbH1wdBmDL0wTvstxTc/eRdA1zf3Jw1ZF
         yLenb5IUYj1J0AA/sbitpwoO6rEFLzjEUInjpNlovPu5vhOiGO8NLzAVSAAAAjt33/vh
         ubfg==
X-Gm-Message-State: ABy/qLYtrCHUEHkpSczzqFJqO4CuZU2qKaJuPiXYMMYZHNRap1b2fbdd
	gwSNAkPZP5bJI3hpUfn+a/l0hNglt44gvQ==
X-Google-Smtp-Source: APBJJlGmjM7g+eO79ZTuYmIC1YUCdlOJANiwErRto2fVF4jrNndrrDhjQ13Z17mDLIzUqNwK4CQ9BoV6aoURqQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b703:0:b0:584:41a6:6cd8 with SMTP id
 v3-20020a81b703000000b0058441a66cd8mr166324ywh.8.1691074561722; Thu, 03 Aug
 2023 07:56:01 -0700 (PDT)
Date: Thu,  3 Aug 2023 14:56:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230803145600.2937518-1-edumazet@google.com>
Subject: [PATCH net] net/packet: annotate data-races around tp->status
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Another syzbot report [1] is about tp->status lockless reads
from __packet_get_status()

[1]
BUG: KCSAN: data-race in __packet_rcv_has_room / __packet_set_status

write to 0xffff888117d7c080 of 8 bytes by interrupt on cpu 0:
__packet_set_status+0x78/0xa0 net/packet/af_packet.c:407
tpacket_rcv+0x18bb/0x1a60 net/packet/af_packet.c:2483
deliver_skb net/core/dev.c:2173 [inline]
__netif_receive_skb_core+0x408/0x1e80 net/core/dev.c:5337
__netif_receive_skb_one_core net/core/dev.c:5491 [inline]
__netif_receive_skb+0x57/0x1b0 net/core/dev.c:5607
process_backlog+0x21f/0x380 net/core/dev.c:5935
__napi_poll+0x60/0x3b0 net/core/dev.c:6498
napi_poll net/core/dev.c:6565 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6698
__do_softirq+0xc1/0x265 kernel/softirq.c:571
invoke_softirq kernel/softirq.c:445 [inline]
__irq_exit_rcu+0x57/0xa0 kernel/softirq.c:650
sysvec_apic_timer_interrupt+0x6d/0x80 arch/x86/kernel/apic/apic.c:1106
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
smpboot_thread_fn+0x33c/0x4a0 kernel/smpboot.c:112
kthread+0x1d7/0x210 kernel/kthread.c:379
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

read to 0xffff888117d7c080 of 8 bytes by interrupt on cpu 1:
__packet_get_status net/packet/af_packet.c:436 [inline]
packet_lookup_frame net/packet/af_packet.c:524 [inline]
__tpacket_has_room net/packet/af_packet.c:1255 [inline]
__packet_rcv_has_room+0x3f9/0x450 net/packet/af_packet.c:1298
tpacket_rcv+0x275/0x1a60 net/packet/af_packet.c:2285
deliver_skb net/core/dev.c:2173 [inline]
dev_queue_xmit_nit+0x38a/0x5e0 net/core/dev.c:2243
xmit_one net/core/dev.c:3574 [inline]
dev_hard_start_xmit+0xcf/0x3f0 net/core/dev.c:3594
__dev_queue_xmit+0xefb/0x1d10 net/core/dev.c:4244
dev_queue_xmit include/linux/netdevice.h:3088 [inline]
can_send+0x4eb/0x5d0 net/can/af_can.c:276
bcm_can_tx+0x314/0x410 net/can/bcm.c:302
bcm_tx_timeout_handler+0xdb/0x260
__run_hrtimer kernel/time/hrtimer.c:1685 [inline]
__hrtimer_run_queues+0x217/0x700 kernel/time/hrtimer.c:1749
hrtimer_run_softirq+0xd6/0x120 kernel/time/hrtimer.c:1766
__do_softirq+0xc1/0x265 kernel/softirq.c:571
run_ksoftirqd+0x17/0x20 kernel/softirq.c:939
smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
kthread+0x1d7/0x210 kernel/kthread.c:379
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

value changed: 0x0000000000000000 -> 0x0000000020000081

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 6.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/packet/af_packet.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a4631cb457a91f04b9acffcecbddc1624f423257..a2935bd18ed98356e73d058e7d416fca832b6b6b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -401,18 +401,20 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
 {
 	union tpacket_uhdr h;
 
+	/* WRITE_ONCE() are paired with READ_ONCE() in __packet_get_status */
+
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
-		h.h1->tp_status = status;
+		WRITE_ONCE(h.h1->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
 		break;
 	case TPACKET_V2:
-		h.h2->tp_status = status;
+		WRITE_ONCE(h.h2->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
 		break;
 	case TPACKET_V3:
-		h.h3->tp_status = status;
+		WRITE_ONCE(h.h3->tp_status, status);
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
 		break;
 	default:
@@ -429,17 +431,19 @@ static int __packet_get_status(const struct packet_sock *po, void *frame)
 
 	smp_rmb();
 
+	/* READ_ONCE() are paired with WRITE_ONCE() in __packet_set_status */
+
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
-		return h.h1->tp_status;
+		return READ_ONCE(h.h1->tp_status);
 	case TPACKET_V2:
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
-		return h.h2->tp_status;
+		return READ_ONCE(h.h2->tp_status);
 	case TPACKET_V3:
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
-		return h.h3->tp_status;
+		return READ_ONCE(h.h3->tp_status);
 	default:
 		WARN(1, "TPACKET version not supported.\n");
 		BUG();
-- 
2.41.0.640.ga95def55d0-goog


