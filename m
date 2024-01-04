Return-Path: <netdev+bounces-61551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6806C8243F1
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB642B23080
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0C23747;
	Thu,  4 Jan 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIKiVkeS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690C23743
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96FFC433C7;
	Thu,  4 Jan 2024 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704379061;
	bh=4RDIDIhNrd8HmTe3ASSfj9FrHQAx1BtEwWISUoUjekw=;
	h=From:To:Cc:Subject:Date:From;
	b=MIKiVkeSD3/knKPPLMvrwXfBJ+9qy0h0hh8JV5xdIGdQ65TJvZsb67x2f/XtIKy1n
	 iUxJiEwW9BFdJhRgGEgHiuEhzDxA1nori8L5WTdo6Nbm0EWLWlrqDZG4I8U27VgJHv
	 FajUopc5OlT/T3IykMWjYrxCHZFDtQwOmP48MIGpH3SILpRj5XKEhySfv42l3nwQg7
	 hgXzF6AsXuMV+U6N78b6O39zYW4vzrosHcYUCqSq96Xvsq/InzO2sGy18IjyePeOq1
	 Pg8lhN/iJjhlsxRv3xXj3CLUeInleQNoZEAoyy7yP8OvwpgO8fwqZ0bI3ZnJPHLlRt
	 UVNFakmvmgiOA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	3chas3@gmail.com
Subject: [PATCH net-next] net: fill in MODULE_DESCRIPTION()s for ATM
Date: Thu,  4 Jan 2024 06:37:37 -0800
Message-ID: <20240104143737.1317945-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to all the ATM modules and drivers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: 3chas3@gmail.com
---
 drivers/atm/atmtcp.c   | 1 +
 drivers/atm/eni.c      | 1 +
 drivers/atm/idt77105.c | 1 +
 drivers/atm/iphase.c   | 1 +
 drivers/atm/nicstar.c  | 1 +
 drivers/atm/suni.c     | 1 +
 net/atm/common.c       | 1 +
 net/atm/lec.c          | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index 96bea1ab1ecc..d4aa0f353b6c 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -494,6 +494,7 @@ static void __exit atmtcp_exit(void)
 	deregister_atm_ioctl(&atmtcp_ioctl_ops);
 }
 
+MODULE_DESCRIPTION("ATM over TCP");
 MODULE_LICENSE("GPL");
 module_init(atmtcp_init);
 module_exit(atmtcp_exit);
diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index a31ffe16e626..3011cf1a84a9 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -2318,4 +2318,5 @@ static int __init eni_init(void)
 module_init(eni_init);
 /* @@@ since exit routine not defined, this module can not be unloaded */
 
+MODULE_DESCRIPTION("Efficient Networks ENI155P ATM NIC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/atm/idt77105.c b/drivers/atm/idt77105.c
index bfca7b8a6f31..fcd70e094a2e 100644
--- a/drivers/atm/idt77105.c
+++ b/drivers/atm/idt77105.c
@@ -372,4 +372,5 @@ static void __exit idt77105_exit(void)
 
 module_exit(idt77105_exit);
 
+MODULE_DESCRIPTION("IDT77105 PHY driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 9bba8f280a4d..d213adcefe33 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -90,6 +90,7 @@ module_param(IA_RX_BUF, int, 0);
 module_param(IA_RX_BUF_SZ, int, 0);
 module_param(IADebugFlag, uint, 0644);
 
+MODULE_DESCRIPTION("Driver for Interphase ATM PCI NICs");
 MODULE_LICENSE("GPL");
 
 /**************************** IA_LIB **********************************/
diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 1a50de39f5b5..27153d6bc781 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -171,6 +171,7 @@ static const struct atmdev_ops atm_ops = {
 static struct timer_list ns_timer;
 static char *mac[NS_MAX_CARDS];
 module_param_array(mac, charp, NULL, 0);
+MODULE_DESCRIPTION("ATM NIC driver for IDT 77201/77211 \"NICStAR\" and Fore ForeRunnerLE.");
 MODULE_LICENSE("GPL");
 
 /* Functions */
diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
index 21e5acc766b8..32802ea9521c 100644
--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -387,4 +387,5 @@ int suni_init(struct atm_dev *dev)
 
 EXPORT_SYMBOL(suni_init);
 
+MODULE_DESCRIPTION("S/UNI PHY driver");
 MODULE_LICENSE("GPL");
diff --git a/net/atm/common.c b/net/atm/common.c
index f7019df41c3e..2a1ec014e901 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -890,6 +890,7 @@ subsys_initcall(atm_init);
 
 module_exit(atm_exit);
 
+MODULE_DESCRIPTION("Asynchronous Transfer Mode (ATM) networking core");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_ATMPVC);
 MODULE_ALIAS_NETPROTO(PF_ATMSVC);
diff --git a/net/atm/lec.c b/net/atm/lec.c
index 6257bf12e5a0..ffef658862db 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -2234,4 +2234,5 @@ lec_arp_check_empties(struct lec_priv *priv,
 	spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
 }
 
+MODULE_DESCRIPTION("ATM LAN Emulation (LANE) support");
 MODULE_LICENSE("GPL");
-- 
2.43.0


