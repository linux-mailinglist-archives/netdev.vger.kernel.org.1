Return-Path: <netdev+bounces-42365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E67CE7C1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC36B20DB0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6C41A98;
	Wed, 18 Oct 2023 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="KHM3q59b";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="UUZZK7g5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40B339AF
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:30:54 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D29138;
	Wed, 18 Oct 2023 12:30:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 5165E6017F;
	Wed, 18 Oct 2023 21:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697657449; bh=gVLlUryR/gipZWvKZqxamud/RSVtVmRXx/zDZWcW8J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHM3q59b3fBMsxuL4XvOgaV0YYxaI/ByW4tlxu5RfkjeO02mmri2caKWCdLC83Q0r
	 XOeuKvbImB2wick8pojWOmqLKke6SKn7f5R6PN8prByaz9VTgGVdi4kkcWCSBGX5qE
	 R670ghfcEeXyjyauscMSf7hJxnMrz4gN5Ib3SuuOvno4rV+Q/KKQvF1wqqjpuwH1j/
	 TrPX935L/DVjsl2t7NfduejkINkFOOxp3k2fabBHA/mXWIz+64TuRdFxDNZE9aWoxi
	 47qNZ9OySdK552lf27DwE+cxDfRDYMGiemJElzwm8bdqOleEjease3Lo60VVoHk+dI
	 tKtGNlcE6/Gbg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSOPNPGDigns; Wed, 18 Oct 2023 21:30:46 +0200 (CEST)
Received: from defiant.home (78-2-200-105.adsl.net.t-com.hr [78.2.200.105])
	by domac.alu.hr (Postfix) with ESMTPSA id 8A31E6017E;
	Wed, 18 Oct 2023 21:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697657446; bh=gVLlUryR/gipZWvKZqxamud/RSVtVmRXx/zDZWcW8J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUZZK7g5hVaTqZp9aM00jXAF7lp92Hp/fZTMqkyOdJmZOnMZ0mdqVCvHyE3G45BTb
	 vhF6KkX7fJ+6I+8cQ2kCqj+Hq8+DWlziAH3uzSRDlzpnH1uJj65GaHgkgTh4R6NxVU
	 DXmrb7/VACThgSuVjcvUQvdWTzWn33Xaab3kOHWvfqXJH4YrPxvBgN7K/9mjhNxuMx
	 o5Ke80WCG/IvPBsoXpWC5pk9hSA4t1UAyAaWmkWchV2tGjk/0CwS0GcEsHD6+8nY3q
	 HcfsyfBa/Dm+ObexgcB8nbm+ly3ZLLrMUk6gCMWGHfFQNbJe7sPMNMYR6nXgurKezO
	 4htcAjy8F3kvg==
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Marco Elver <elver@google.com>
Subject: [PATCH v3 2/3] r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
Date: Wed, 18 Oct 2023 21:28:29 +0200
Message-Id: <20231018192828.343562-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018192828.343562-1-mirsad.todorovac@alu.unizg.hr>
References: <20231018192828.343562-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

KCSAN reported the following data-race:

==================================================================
BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169

race at unknown origin, with read to 0xffff888140d37570 of 4 bytes by interrupt on cpu 21:
rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
__napi_poll (net/core/dev.c:6527)
net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
__do_softirq (kernel/softirq.c:553)
__irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
irq_exit_rcu (kernel/softirq.c:647)
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
call_cpuidle (kernel/sched/idle.c:135)
do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)

value changed: 0xb0000042 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
==================================================================

The read side is in

drivers/net/ethernet/realtek/r8169_main.c
=========================================
   4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
   4356                    int budget)
   4357 {
   4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
   4359         struct sk_buff *skb;
   4360
   4361         dirty_tx = tp->dirty_tx;
   4362
   4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
   4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
   4365                 u32 status;
   4366
 → 4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
   4368                 if (status & DescOwn)
   4369                         break;
   4370
   4371                 skb = tp->tx_skb[entry].skb;
   4372                 rtl8169_unmap_tx_skb(tp, entry);
   4373
   4374                 if (skb) {
   4375                         pkts_compl++;
   4376                         bytes_compl += skb->len;
   4377                         napi_consume_skb(skb, budget);
   4378                 }
   4379                 dirty_tx++;
   4380         }
   4381
   4382         if (tp->dirty_tx != dirty_tx) {
   4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
   4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
   4385
   4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
   4387                                               rtl_tx_slots_avail(tp),
   4388                                               R8169_TX_START_THRS);
   4389                 /*
   4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
   4391                  * too close. Let's kick an extra TxPoll request when a burst
   4392                  * of start_xmit activity is detected (if it is not detected,
   4393                  * it is slow enough). -- FR
   4394                  * If skb is NULL then we come here again once a tx irq is
   4395                  * triggered after the last fragment is marked transmitted.
   4396                  */
   4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
   4398                         rtl8169_doorbell(tp);
   4399         }
   4400 }

tp->TxDescArray[entry].opts1 is reported to have a data-race and READ_ONCE() fixes
this KCSAN warning.

   4366
 → 4367                 status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
   4368                 if (status & DescOwn)
   4369                         break;
   4370

Fixes: ^1da177e4c3f4 ("initial git repository build")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Marco Elver <elver@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
v3:
 fixed the Fixes: tag for 3/3.

v2:
 fixed double Signed-off-by: tag

 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 81be6085a480..361b90007148 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4364,7 +4364,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		unsigned int entry = dirty_tx % NUM_TX_DESC;
 		u32 status;
 
-		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
+		status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
 		if (status & DescOwn)
 			break;
 
-- 
2.34.1


