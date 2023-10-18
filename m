Return-Path: <netdev+bounces-42366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5637CE7CA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D2A1C209A6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC32450C9;
	Wed, 18 Oct 2023 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ugaIAH3z";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="EhmDyHZk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90C339AF
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:34:23 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C3811F;
	Wed, 18 Oct 2023 12:34:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 40C4C6017F;
	Wed, 18 Oct 2023 21:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697657659; bh=/W3mk8TahFX3fe6Zwq2eTM/o+YuIuTXh3wIDyuxcYGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugaIAH3z/KUiC9ZBmjFP9shpP559G4snGyQ94CtEH1nndvxEaTajwQdUxBsXHouZd
	 phZllqTU1Bcd7ItNdoPsQf6IDqsUGypTCjuU/lyL5f29UqhkxRvVZFPWxkyxTPfNC/
	 fzNunZchniaIKUjcAJDZnP9pF5dKhdiqj2Ximiu1hf6YUKZ8LkbAAhLHgUeJxTjr3U
	 BLfKDRorxGIjYLRYxjb1lhJdUuYK5e1lxboLu72w9Xeb8CQknHAYo8QV0kRzXOL2mr
	 L8RxV5H7WzxtuQrfxRfymhgr9lhijLqFxtDT3fRz1vqKq0V8jK/JFbuLLO/F9IjxHg
	 eExZ2I2q0RsPw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pH1VaXI5Ez19; Wed, 18 Oct 2023 21:34:16 +0200 (CEST)
Received: from defiant.home (78-2-200-105.adsl.net.t-com.hr [78.2.200.105])
	by domac.alu.hr (Postfix) with ESMTPSA id 7C0996017E;
	Wed, 18 Oct 2023 21:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1697657656; bh=/W3mk8TahFX3fe6Zwq2eTM/o+YuIuTXh3wIDyuxcYGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhmDyHZk/+90zh97GTcCb56QBpvh+97Fd+5aS5Kg+D/kBjRmxWLvl2vftvvf7GrLX
	 IAE46Mv/szXpw6g5O44A6e17WHGNlQGIqbtv6bPjx7mLHJWZgGZk/JlJftYW9Hmgr5
	 1wGj3Esp6XERxxA1nbCjxlMWXklsn5cksYCkUXHv5Hvzirr8XfVmiz6REMC2inFGCs
	 DJR9wtC/fj++oXZAvyqDP3vSxAkSo382T7FR4yjEhNgJZhU4NurtuITG3gAV6NI13Y
	 21FOkUh8R9ShD7v/KLzR8oOd7gL3navjYn35NTtjOn0oT2izy/FmNxHIx+4W0I73En
	 lGif90N9463/A==
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
Subject: [PATCH v3 3/3] r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1
Date: Wed, 18 Oct 2023 21:28:31 +0200
Message-Id: <20231018192828.343562-3-mirsad.todorovac@alu.unizg.hr>
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

KCSAN reported the following data-race bug:

==================================================================
BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169

race at unknown origin, with read to 0xffff888117e43510 of 4 bytes by interrupt on cpu 21:
rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
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

value changed: 0x80003fff -> 0x3402805f

Reported by Kernel Concurrency Sanitizer on:
CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
==================================================================

drivers/net/ethernet/realtek/r8169_main.c:
==========================================
   4429
 → 4430                 status = le32_to_cpu(desc->opts1);
   4431                 if (status & DescOwn)
   4432                         break;
   4433
   4434                 /* This barrier is needed to keep us from reading
   4435                  * any other fields out of the Rx descriptor until
   4436                  * we know the status of DescOwn
   4437                  */
   4438                 dma_rmb();
   4439
   4440                 if (unlikely(status & RxRES)) {
   4441                         if (net_ratelimit())
   4442                                 netdev_warn(dev, "Rx ERROR. status = %08x\n",

Marco Elver explained that dma_rmb() doesn't prevent the compiler to tear up the access to
desc->opts1 which can be written to concurrently. READ_ONCE() should prevent that from
happening:

   4429
 → 4430                 status = le32_to_cpu(READ_ONCE(desc->opts1));
   4431                 if (status & DescOwn)
   4432                         break;
   4433

As the consequence of this fix, this KCSAN warning was eliminated.

Fixes: 6202806e7c03a ("r8169: drop member opts1_mask from struct rtl8169_private")
Suggested-by: Marco Elver <elver@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Acked-by: Marco Elver <elver@google.com>
---
v3:
 fixed the Fixes: tag for 3/3.

v2:
 fixed double Signed-off-by: tag

 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 281aaa851847..81be6085a480 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(desc->opts1);
+		status = le32_to_cpu(READ_ONCE(desc->opts1));
 		if (status & DescOwn)
 			break;
 
-- 
2.34.1


