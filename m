Return-Path: <netdev+bounces-273781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELBoGFhSzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A23728F0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 644C23038E30
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB3466B5B;
	Tue, 31 Mar 2026 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n87niXXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407146AEC7
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998060; cv=none; b=YE4i2CEEeBtCQzKZQdv34Yd3dA0IPZibzt9eQtjACFXGJ0m7invN1Trihu/5+w8NVeHUO1dHUP7s2uj6DP5aqKpabLL/6uq+r6eqHTeeLR2onYB95aSh2KtG5Hegd+cr4GpltT8csE/1+qLADaMfVHOYb8cKAImNTz8zwXGjZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998060; c=relaxed/simple;
	bh=opbPqYr59ykM4mi1Qec+Y7KtTsf3ls1hHO7GW0cHaZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpS4u3UfNTJisqNbdaolPlfewJlbXUV1tpTd1XOe4kCjSqTJUqx9wzfvOEQolqsN4cEh6CVbGtBlkR12YXWw+l+GDQ2h1DS12g1m1S6Yb4dKo5AdjP7yfa/jk9hJsqs0BGBIEUNqLga3c7Dr5eqsVw69IEz3D4YvhbW8I1fcDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n87niXXn; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5674d8be45eso1740079e0c.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998056; x=1775602856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVSxqrmft82CW5zhffxaBSlaB2KPtvzEqUsxhFVjkdI=;
        b=n87niXXnP9RAlz0GjkGJ4UD1MZ5sMybOjAjL6Tflyxp+0RAswhu1OWv91Pc3PIwfFm
         tW0Qte63JEBqIVGrkvqn8AuDAzgI0UKHKTTpSOxt8Cq7POJ/DcD9uruOvfCRaY6KP3J1
         8E8LKgwLRN/60RKId3dzR4IeMtUTtMS1x3iGLbXgCNXndQuAiV6rmIQ7SB9pFQG0i4fa
         bAzGUjO/UE+0gkHz6R7uzKCZRGqOhrBtUXP/pJ1Lv6UU+tcppRJANPY78BCAZEDmTd/b
         euN7/zXBSW5qY2mmpVby691zOhDpH2s3o5kbt9IyZqSWKSGZps5kAPxBAmZ7hwQg4Yhi
         SmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998056; x=1775602856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LVSxqrmft82CW5zhffxaBSlaB2KPtvzEqUsxhFVjkdI=;
        b=UtDYhIR0fwBeSKBBH4dy1MvrXtCoz7e/FQUTih2rQhGkNZuxqoM37LyyRVB+J5HpVt
         KeYanlAMiiw1wCSttYPNgsITvXpBYr8MQW120EWqKX2PuZUs3MessblK4jSE4MTn41JM
         Ga9jNpWXywNsfoXgrfbJaR1yjJG74lx2WtLa5tmAB/0Oyu55qQ46cIxqt461AYwoofI5
         wAcX/GJnHDq7BO8yRBeVzgCCHnst1ahLGCNXhNQEvpWoM1yxHxeH09HXAHbubSL63MUW
         3BF6OHudo773LUwsQhXU7OkK4yQovgL3E7Ie9nxe2dY4BaRGDNiyM+CQvfAdGlkirKD0
         bFbw==
X-Gm-Message-State: AOJu0Yx16Wuj/bDSpEDrGFNLQuscgTfSNvC+ailHa4mBQovL471Zq1d3
	vLUDQH8L1bSrQluo7iPUnnpsL/ZudiupWXdGDGrBh5Hbjot913y34AqC
X-Gm-Gg: ATEYQzwT1GsIXsL9dGTNXNZjBH8FQZ1AzmTSVNzzS/nn90T7YsXUASU4MCyMR+afrAq
	kLo6BSvEk4PRtm0MBW2E1ZFBbDx19qe1qjCFiAetLNnVkd9sXphQpOEVmlnLrNi/QKhxAQSmMHt
	0KsQExbOwQBZLiB+90yIWk4qi02UC5l1/631t7H4eCdfrEe91eXhraEnz1qzroEleDSBYhweVp0
	tvjpSoTNAi9dGBuoFIW133puFskG2Cmy6VWjQc3JwcFXsEnj5psR5tMPyc5Ncr/Arxodw6qeSIl
	B2SYUeY1bLtnEkR7a0Ma8CvkxE4qrsQ3HBnVMI2b9/K+8B/AXnsvPz/YxHqHI4TBSdETCi5PeD1
	8MrvADV+VqPze/nTKRllF1RUs81/YV182cSVWYRDuU3S0btsGgfztz+cmq9MO5pUptXx2NQZeSV
	hc87gergpyFlAp1NDceahiEwqPYA+gOd/ZKvB5cA==
X-Received: by 2002:a05:6122:ca1:b0:56a:ef89:34fc with SMTP id 71dfb90a1353d-56d8a81bd48mr662957e0c.6.1774998056172;
        Tue, 31 Mar 2026 16:00:56 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:55 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:08 -0300
Subject: [net-next PATCH 08/10] net: dsa: realtek: rtl8365mb: add FDB
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-8-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273781-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 054A23728F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Add support for forwarding database operations, including unicast and
multicast entry handling as well as fast aging support.

The driver implements Independent VLAN Learning (IVL) by keying the
forwarding database with the {VID, MAC, EFID} tuple. The Extended
Filtering ID (EFID) is 3 bits wide, providing 8 unique filtering
domains. Since EFID 0 is reserved for standalone ports where learning is
disabled, the hardware is limited to offloading a maximum of 7 bridges.

The driver implements only the subset of L2 table accessors needed to
support these DSA operations. Other hardware capabilities are left
untouched and can be added incrementally if needed.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c   | 465 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h   |  59 ++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 197 ++++++++++++-
 4 files changed, 721 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index b7fc4e852fd8..6c329e046d0b 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
 rtl8365mb-objs := rtl8365mb_main.o \
 		  rtl8365mb_table.o \
 		  rtl8365mb_vlan.o \
+		  rtl8365mb_l2.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
new file mode 100644
index 000000000000..be5825f8fe7b
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Forwarding and multicast database interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ */
+
+#include <linux/etherdevice.h>
+
+#include "rtl8365mb_l2.h"
+#include "rtl8365mb_table.h"
+#include <linux/regmap.h>
+
+#define RTL8365MB_L2_ENTRY_SIZE			6
+
+#define RTL8365MB_L2_UC_D0_MAC5_MASK		GENMASK(7, 0)
+#define RTL8365MB_L2_UC_D0_MAC4_MASK		GENMASK(15, 8)
+#define RTL8365MB_L2_UC_D1_MAC3_MASK		GENMASK(7, 0)
+#define RTL8365MB_L2_UC_D1_MAC2_MASK		GENMASK(15, 8)
+#define RTL8365MB_L2_UC_D2_MAC1_MASK		GENMASK(7, 0)
+#define RTL8365MB_L2_UC_D2_MAC0_MASK		GENMASK(15, 8)
+#define RTL8365MB_L2_UC_D3_VID_MASK		GENMASK(11, 0)
+#define RTL8365MB_L2_UC_D3_IVL_MASK		GENMASK(13, 13)
+#define RTL8365MB_L2_UC_D3_PORT_EXT_MASK	GENMASK(15, 15)
+#define RTL8365MB_L2_UC_D4_EFID_MASK		GENMASK(2, 0)
+#define RTL8365MB_L2_UC_D4_FID_MASK		GENMASK(6, 3)
+#define RTL8365MB_L2_UC_D4_SA_PRI_MASK		GENMASK(7, 7)
+#define RTL8365MB_L2_UC_D4_PORT_MASK		GENMASK(10, 8)
+#define RTL8365MB_L2_UC_D4_AGE_MASK		GENMASK(13, 11)
+#define RTL8365MB_L2_UC_D4_AUTH_MASK		GENMASK(14, 14)
+#define RTL8365MB_L2_UC_D4_SA_BLOCK_MASK	GENMASK(15, 15)
+#define RTL8365MB_L2_UC_D5_DA_BLOCK_MASK	GENMASK(0, 0)
+#define RTL8365MB_L2_UC_D5_PRIORITY_MASK	GENMASK(3, 1)
+#define RTL8365MB_L2_UC_D5_FWD_PRI_MASK		GENMASK(4, 4)
+#define RTL8365MB_L2_UC_D5_STATIC_MASK		GENMASK(5, 5)
+
+#define RTL8365MB_L2_MC_MAC5_MASK		GENMASK(7, 0)   /* D0 */
+#define RTL8365MB_L2_MC_MAC4_MASK		GENMASK(15, 8)  /* D0 */
+#define RTL8365MB_L2_MC_MAC3_MASK		GENMASK(7, 0)   /* D1 */
+#define RTL8365MB_L2_MC_MAC2_MASK		GENMASK(15, 8)  /* D1 */
+#define RTL8365MB_L2_MC_MAC1_MASK		GENMASK(7, 0)   /* D2 */
+#define RTL8365MB_L2_MC_MAC0_MASK		GENMASK(15, 8)  /* D2 */
+#define RTL8365MB_L2_MC_VID_MASK		GENMASK(11, 0)  /* D3 */
+#define RTL8365MB_L2_MC_IVL_MASK		GENMASK(13, 13) /* D3 */
+#define RTL8365MB_L2_MC_MBR_EXT1_MASK		GENMASK(15, 14) /* D3 */
+
+#define RTL8365MB_L2_MC_MBR_MASK		GENMASK(7, 0)   /* D4 */
+#define RTL8365MB_L2_MC_IGMPIDX_MASK		GENMASK(15, 8)  /* D4 */
+
+#define RTL8365MB_L2_MC_IGMP_ASIC_MASK		GENMASK(0, 0)   /* D5 */
+#define RTL8365MB_L2_MC_PRIORITY_MASK		GENMASK(3, 1)   /* D5 */
+#define RTL8365MB_L2_MC_FWD_PRI_MASK		GENMASK(4, 4)   /* D5 */
+#define RTL8365MB_L2_MC_STATIC_MASK		GENMASK(5, 5)   /* D5 */
+#define RTL8365MB_L2_MC_MBR_EXT2_MASK		GENMASK(7, 7)   /* D5 */
+
+/* Port flush command registers - writing a 1 to the port's MASK bit will
+ * initiate the flush procedure. Completion is signalled when the corresponding
+ * BUSY bit is 0.
+ */
+#define RTL8365MB_L2_FLUSH_PORT_REG		0x0A36
+#define   RTL8365MB_L2_FLUSH_PORT_MASK_MASK	GENMASK(7, 0)
+#define   RTL8365MB_L2_FLUSH_PORT_BUSY_MASK	GENMASK(15, 8)
+
+#define RTL8365MB_L2_FLUSH_PORT_EXT_REG		0x0A35
+#define   RTL8365MB_L2_FLUSH_PORT_EXT_MASK_MASK	GENMASK(2, 0)
+#define   RTL8365MB_L2_FLUSH_PORT_EXT_BUSY_MASK	GENMASK(5, 3)
+
+#define RTL8365MB_L2_FLUSH_CTRL1_REG		0x0A37
+#define   RTL8365MB_L2_FLUSH_CTRL1_VID_MASK	GENMASK(11, 0)
+#define   RTL8365MB_L2_FLUSH_CTRL1_FID_MASK	GENMASK(15, 12)
+
+#define RTL8365MB_L2_FLUSH_CTRL2_REG		0x0A38
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_MASK	GENMASK(1, 0)
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT	0
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_VID 1
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_FID 2
+#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_MASK	GENMASK(2, 2)
+#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_DYNAMIC	0
+#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_BOTH	0
+
+/* This flushes the entire LUT, reading it back it will turn 0 when the
+ * operation is complete
+ */
+#define RTL8365MB_L2_FLUSH_CTRL3_REG		0x0A39
+#define   RTL8365MB_L2_FLUSH_CTRL3_MASK		GENMASK(0, 0)
+
+struct rtl8365mb_l2_mc_key {
+	u8 mac_addr[ETH_ALEN];
+	union {
+		u16 vid; /* IVL */
+		u16 fid; /* SVL */
+	};
+	bool ivl;
+};
+
+struct rtl8365mb_l2_mc {
+	struct rtl8365mb_l2_mc_key key;
+	u16 member;
+	u8 priority;
+	u8 igmpidx;
+
+	bool is_static;
+	bool fwd_pri;
+	bool igmp_asic;
+};
+
+static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
+{
+	uc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC5_MASK, data[0]);
+	uc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC4_MASK, data[0]);
+	uc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC3_MASK, data[1]);
+	uc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC2_MASK, data[1]);
+	uc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC1_MASK, data[2]);
+	uc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC0_MASK, data[2]);
+	uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MASK, data[4]);
+	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MASK, data[3]);
+	uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MASK, data[3]);
+	uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MASK, data[4]);
+	uc->age = FIELD_GET(RTL8365MB_L2_UC_D4_AGE_MASK, data[4]);
+	uc->auth = FIELD_GET(RTL8365MB_L2_UC_D4_AUTH_MASK, data[4]);
+	uc->port = FIELD_GET(RTL8365MB_L2_UC_D4_PORT_MASK, data[4]) |
+		   (FIELD_GET(RTL8365MB_L2_UC_D3_PORT_EXT_MASK, data[3]) << 3);
+	uc->sa_pri = FIELD_GET(RTL8365MB_L2_UC_D4_SA_PRI_MASK, data[4]);
+	uc->fwd_pri = FIELD_GET(RTL8365MB_L2_UC_D5_FWD_PRI_MASK, data[5]);
+	uc->sa_block = FIELD_GET(RTL8365MB_L2_UC_D4_SA_BLOCK_MASK, data[4]);
+	uc->da_block = FIELD_GET(RTL8365MB_L2_UC_D5_DA_BLOCK_MASK, data[5]);
+	uc->priority = FIELD_GET(RTL8365MB_L2_UC_D5_PRIORITY_MASK, data[5]);
+	uc->is_static = FIELD_GET(RTL8365MB_L2_UC_D5_STATIC_MASK, data[5]);
+}
+
+static void rtl8365mb_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data)
+{
+	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
+	data[0] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D0_MAC5_MASK, uc->key.mac_addr[5]);
+	data[0] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D0_MAC4_MASK, uc->key.mac_addr[4]);
+	data[1] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D1_MAC3_MASK, uc->key.mac_addr[3]);
+	data[1] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D1_MAC2_MASK, uc->key.mac_addr[2]);
+	data[2] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D2_MAC1_MASK, uc->key.mac_addr[1]);
+	data[2] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D2_MAC0_MASK, uc->key.mac_addr[0]);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_VID_MASK, uc->key.vid);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_IVL_MASK, uc->key.ivl);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_PORT_EXT_MASK, uc->port >> 3);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_FID_MASK, uc->key.fid);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_EFID_MASK, uc->key.efid);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_AGE_MASK, uc->age);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_AUTH_MASK, uc->auth);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_PORT_MASK, uc->port);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_SA_PRI_MASK, uc->sa_pri);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_SA_BLOCK_MASK, uc->sa_block);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_FWD_PRI_MASK, uc->fwd_pri);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_DA_BLOCK_MASK, uc->da_block);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_PRIORITY_MASK, uc->priority);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_STATIC_MASK, uc->is_static);
+}
+
+static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
+{
+	mc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_MC_MAC5_MASK, data[0]);
+	mc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_MC_MAC4_MASK, data[0]);
+	mc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_MC_MAC3_MASK, data[1]);
+	mc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_MC_MAC2_MASK, data[1]);
+	mc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_MC_MAC1_MASK, data[2]);
+	mc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_MC_MAC0_MASK, data[2]);
+	mc->key.vid = FIELD_GET(RTL8365MB_L2_MC_VID_MASK, data[3]);
+	mc->key.ivl = FIELD_GET(RTL8365MB_L2_MC_IVL_MASK, data[3]);
+	mc->priority = FIELD_GET(RTL8365MB_L2_MC_PRIORITY_MASK, data[5]);
+	mc->fwd_pri = FIELD_GET(RTL8365MB_L2_MC_FWD_PRI_MASK, data[5]);
+	mc->is_static = FIELD_GET(RTL8365MB_L2_MC_STATIC_MASK, data[5]);
+	mc->member = FIELD_GET(RTL8365MB_L2_MC_MBR_MASK, data[4]) |
+		     (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT1_MASK, data[3]) << 8) |
+		     (FIELD_GET(RTL8365MB_L2_MC_MBR_EXT2_MASK, data[5]) << 8);
+	mc->igmpidx = FIELD_GET(RTL8365MB_L2_MC_IGMPIDX_MASK, data[4]);
+	mc->igmp_asic = FIELD_GET(RTL8365MB_L2_MC_IGMP_ASIC_MASK, data[5]);
+}
+
+static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
+{
+	memset(data, 0, 12);
+	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_MAC5_MASK, mc->key.mac_addr[5]);
+	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_MAC4_MASK, mc->key.mac_addr[4]);
+	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_MAC3_MASK, mc->key.mac_addr[3]);
+	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_MAC2_MASK, mc->key.mac_addr[2]);
+	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_MAC1_MASK, mc->key.mac_addr[1]);
+	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_MAC0_MASK, mc->key.mac_addr[0]);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_VID_MASK, mc->key.vid);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_IVL_MASK, mc->key.ivl);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_EXT1_MASK, mc->member >> 8);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_MASK, mc->member);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_MC_IGMPIDX_MASK, mc->igmpidx);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_IGMP_ASIC_MASK, mc->igmp_asic);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_PRIORITY_MASK, mc->priority);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_FWD_PRI_MASK, mc->fwd_pri);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_STATIC_MASK, mc->is_static);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_MBR_EXT2_MASK, mc->member >> 10);
+}
+
+/**
+ * rtl8365mb_l2_get_next_uc() - get the next Unicast L2 entry
+ *
+ * @priv: realtek_priv pointer
+ * @addr: as input, the table index to start the walk
+ *        as output, the found table index
+ * @port: restrict the walk on entries related to port
+ * @uc: returned L2 Unicast table entry
+ *
+ * This function get the next unicast L2 table entry starting from @addr
+ * and checking exclusively entries related to @port. If no more entries
+ * were found, the output @addr will be lower than the input @addr and @uc
+ * will not be overwritten.
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ **/
+int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, u16 port,
+			     struct rtl8365mb_l2_uc *uc)
+{
+	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	int ret;
+
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_READ, addr,
+				    RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT,
+				    port, data, RTL8365MB_L2_ENTRY_SIZE);
+	if (ret)
+		return ret;
+
+	rtl8365mb_l2_data_to_uc(data, uc);
+
+	return 0;
+}
+
+int rtl8365mb_l2_add_uc(struct realtek_priv *priv, u16 port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 efid, u16 vid)
+{
+	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	struct rtl8365mb_l2_uc uc = { 0 };
+	u16 addr;
+	int ret;
+
+	memcpy(uc.key.mac_addr, mac_addr, ETH_ALEN);
+	uc.key.efid = efid;
+	uc.key.ivl = true;
+	uc.key.vid = vid;
+	uc.port = port;
+	/* do not let HW decrease age */
+	uc.is_static = true;
+	/* age greater than 0 adds/updates entries */
+	uc.age = 1;
+	rtl8365mb_l2_uc_to_data(&uc, data);
+
+	/* add the new entry or update an existing one */
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_WRITE, &addr,
+				    0, 0,
+				    data, RTL8365MB_L2_ENTRY_SIZE);
+	/* addr will hold the table index, but it is not used here */
+	if (ret == -ENOENT) {
+		/* -ENOENT means the just added entry was not found (and @addr
+		 * does not hold the table index. Although any error will be
+		 * treated equally by the caller, assume that the missing entry
+		 * means the table is full (tested in real HW).
+		 */
+		return -ENOSPC;
+	}
+	return ret;
+}
+
+int rtl8365mb_l2_del_uc(struct realtek_priv *priv, u16 port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 efid, u16 vid)
+{
+	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	struct rtl8365mb_l2_uc uc = { 0 };
+	u16 addr;
+	int ret;
+
+	memcpy(uc.key.mac_addr, mac_addr, ETH_ALEN);
+	uc.key.efid = efid;
+	uc.key.ivl = true;
+	uc.key.vid = vid;
+	/* age 0 deletes the entry */
+	uc.age = 0;
+	rtl8365mb_l2_uc_to_data(&uc, data);
+
+	/* it looks like the switch will always add/update the entry,
+	 * even when age is 0 or uc.key did not match an existing entry,
+	 * just to immediately drop it because age is zero. You can still
+	 * get the added/updated address from @addr
+	 */
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_WRITE, &addr,
+				    0, 0,
+				    data, RTL8365MB_L2_ENTRY_SIZE);
+	/* addr will hold the table index, but it is not used here */
+	return ret;
+}
+
+int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid)
+{
+	int mode = vid ? RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_VID :
+			 RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT;
+	u32 val, mask;
+	int ret;
+
+	mutex_lock(&priv->map_lock);
+
+	/* Configure flushing mode; only flush dynamic entries */
+	ret = regmap_write(priv->map_nolock, RTL8365MB_L2_FLUSH_CTRL2_REG,
+			   FIELD_PREP(RTL8365MB_L2_FLUSH_CTRL2_MODE_MASK,
+				      mode) |
+			   FIELD_PREP(RTL8365MB_L2_FLUSH_CTRL2_TYPE_MASK,
+				      RTL8365MB_L2_FLUSH_CTRL2_TYPE_DYNAMIC));
+	if (ret)
+		goto out;
+
+	ret = regmap_write(priv->map_nolock, RTL8365MB_L2_FLUSH_CTRL1_REG,
+			   FIELD_PREP(RTL8365MB_L2_FLUSH_CTRL1_VID_MASK, vid));
+
+	if (ret)
+		goto out;
+	/* Now issue the flush command and wait for its completion. There are
+	 * two registers for this purpose, and which one to use depends on the
+	 * port number. The _EXT register is for ports 8 or higher.
+	 */
+	if (port < 8) {
+		val = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_MASK_MASK,
+				 BIT(port) & 0xFF);
+		ret = regmap_write(priv->map_nolock,
+				   RTL8365MB_L2_FLUSH_PORT_REG, val);
+		if (ret)
+			goto out;
+
+		mask = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_BUSY_MASK,
+				  BIT(port) & 0xFF);
+		ret = regmap_read_poll_timeout(priv->map_nolock,
+					       RTL8365MB_L2_FLUSH_PORT_REG,
+					       val, !(val & mask), 10, 100);
+		if (ret)
+			goto out;
+	} else {
+		val = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_EXT_MASK_MASK,
+				 BIT(port) >> 8);
+		ret = regmap_write(priv->map_nolock,
+				   RTL8365MB_L2_FLUSH_PORT_EXT_REG, val);
+		if (ret)
+			goto out;
+
+		mask = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_EXT_BUSY_MASK,
+				  BIT(port) >> 8);
+		ret = regmap_read_poll_timeout(priv->map_nolock,
+					       RTL8365MB_L2_FLUSH_PORT_EXT_REG,
+					       val, !(val & mask), 10, 100);
+		if (ret)
+			goto out;
+	}
+
+out:
+	mutex_unlock(&priv->map_lock);
+
+	return ret;
+}
+
+int rtl8365mb_l2_add_mc(struct realtek_priv *priv, u16 port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 vid)
+{
+	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	struct rtl8365mb_l2_mc mc = { 0 };
+	u16 addr;
+	int ret;
+
+	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
+	mc.key.vid = vid;
+	mc.key.ivl = true;
+	/* Already set the port and is_static, although not used in OP_READ,
+	 * data will be ready for OP_WRITE if it is a new entry.
+	 */
+	mc.member |= BIT(port);
+	mc.is_static = 1;
+	rtl8365mb_l2_mc_to_data(&mc, data);
+
+	/* First look for an existing entry (to get existing port members) */
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_READ, &addr,
+				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
+				    data, RTL8365MB_L2_ENTRY_SIZE);
+	if (!ret) {
+		/* There is already an entry... */
+		rtl8365mb_l2_data_to_mc(data, &mc);
+		/* the port must be added as a member */
+		mc.member |= BIT(port);
+		rtl8365mb_l2_mc_to_data(&mc, data);
+	} else if (ret == -ENOENT) {
+		/* New entry, no need to update data again as it already
+		 * includes the member
+		 */
+	} else {
+		return ret;
+	}
+
+	/* add the new entry or update an existing one */
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_WRITE, &addr,
+				    0, 0,
+				    data, RTL8365MB_L2_ENTRY_SIZE);
+	/* addr will hold the table index, but it is not used here */
+	if (ret == -ENOENT) {
+		/* -ENOENT means the just added entry was not found (and @addr
+		 * does not hold the table index. Although any error will be
+		 * treated equally by the caller, assume that the missing entry
+		 * means the table is full (tested in real HW).
+		 */
+		return -ENOSPC;
+	}
+
+	return ret;
+}
+
+int rtl8365mb_l2_del_mc(struct realtek_priv *priv, u16 port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 vid)
+{
+	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	struct rtl8365mb_l2_mc mc = { 0 };
+	u16 addr;
+	int ret;
+
+	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
+	mc.key.vid = vid;
+	mc.key.ivl = true;
+	rtl8365mb_l2_mc_to_data(&mc, data);
+
+	/* First look for an existing entry (to get existing port members) */
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_READ, &addr,
+				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
+				    data, RTL8365MB_L2_ENTRY_SIZE);
+	if (ret)
+		/* Any error, including -ENOENT is unexpected */
+		return ret;
+
+	rtl8365mb_l2_data_to_mc(data, &mc);
+	/* the port must be removed as a member */
+	mc.member &= ~BIT(port);
+	if (!mc.member) {
+		/* With no members, zero all non-key fields to delete the
+		 * entry. However is_static is everything else we wrote.
+		 * (and probably all that is needed by the HW)
+		 */
+		mc.is_static = 0;
+	}
+	rtl8365mb_l2_mc_to_data(&mc, data);
+
+	/* update the existing entry. */
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_WRITE, &addr,
+				    0, 0,
+				    data, RTL8365MB_L2_ENTRY_SIZE);
+	return ret;
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.h b/drivers/net/dsa/realtek/rtl8365mb_l2.h
new file mode 100644
index 000000000000..b60d8617969d
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Forwarding and multicast database interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ */
+
+#ifndef _REALTEK_RTL8365MB_L2_H
+#define _REALTEK_RTL8365MB_L2_H
+
+#include <linux/if_ether.h>
+#include <linux/types.h>
+
+#include "realtek.h"
+
+/* It's valid for all family but RTL8370B, which has 4160 */
+#define RTL8365MB_LEARN_LIMIT_MAX	2112
+
+struct rtl8365mb_l2_uc_key {
+	u8 mac_addr[ETH_ALEN];
+	union {
+		u16 vid; /* IVL */
+		u16 fid; /* SVL */
+	};
+	bool ivl;
+	u16 efid;
+};
+
+struct rtl8365mb_l2_uc {
+	struct rtl8365mb_l2_uc_key key;
+	u8 port;
+	u8 age;
+	u8 priority;
+
+	bool sa_block;
+	bool da_block;
+	bool auth;
+	bool is_static;
+	bool sa_pri;
+	bool fwd_pri;
+};
+
+int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, u16 port,
+			     struct rtl8365mb_l2_uc *uc);
+int rtl8365mb_l2_add_uc(struct realtek_priv *priv, u16 port,
+			const unsigned char addr[static ETH_ALEN],
+			u16 efid, u16 vid);
+int rtl8365mb_l2_del_uc(struct realtek_priv *priv, u16 port,
+			const unsigned char addr[static ETH_ALEN],
+			u16 efid, u16 vid);
+int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid);
+
+int rtl8365mb_l2_add_mc(struct realtek_priv *priv, u16 port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 vid);
+int rtl8365mb_l2_del_mc(struct realtek_priv *priv, u16 port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 vid);
+
+#endif /* _REALTEK_RTL8365MB_L2_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index c955864f17b3..0767b2704ad7 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -104,6 +104,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
+#include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
 
 /* Family-specific data and limits */
@@ -112,7 +113,6 @@
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_MAX_NUM_PORTS		11
 #define RTL8365MB_MAX_NUM_EXTINTS	3
-#define RTL8365MB_LEARN_LIMIT_MAX	2112
 
 /* Chip identification registers */
 #define RTL8365MB_CHIP_ID_REG		0x1300
@@ -705,6 +705,7 @@ struct rtl8365mb_port {
  * @chip_info: chip-specific info about the attached switch
  * @cpu: CPU tagging and CPU port configuration for this chip
  * @mib_lock: prevent concurrent reads of MIB counters
+ * @l2_lock: prevent concurrent access to L2 look-up table
  * @ports: per-port data
  *
  * Private data for this driver.
@@ -715,6 +716,15 @@ struct rtl8365mb {
 	const struct rtl8365mb_chip_info *chip_info;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
+	/* l2_lock is used to prevent concurrent modifications of L2 table
+	 * entries while another function is reading it. l2_(add,del)_mc
+	 * is an example that first read current table entry and then
+	 * create/update it. l2_(add|del)_uc uses a single table op and,
+	 * internally, it might not need this lock. However, altering FDB
+	 * may still collide, as well as l2_flush, with fdb_dump iterating
+	 * over FDB.
+	 */
+	struct mutex l2_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
 };
 
@@ -1267,6 +1277,22 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
 			   val << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET(port));
 }
 
+static void rtl8365mb_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+	int ret;
+
+	dev_dbg(priv->dev, "fast_age port %d\n", port);
+
+	mutex_lock(&mb->l2_lock);
+	ret = rtl8365mb_l2_flush(priv, port, 0);
+	mutex_unlock(&mb->l2_lock);
+	if (ret)
+		dev_err(priv->dev, "failed to fast age on port %d: %d\n", port,
+			ret);
+}
+
 static int rtl8365mb_port_set_transparent(struct realtek_priv *priv,
 					  int igr_port, int egr_port,
 					  bool enable)
@@ -1444,6 +1470,165 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
 	return ret;
 }
 
+static int rtl8365mb_port_fdb_add(struct dsa_switch *ds, int port,
+				  const unsigned char *addr, u16 vid,
+				  struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb;
+	int efid;
+	int ret;
+
+	mb = priv->chip_data;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	/*
+	 * DSA_DB_BRIDGE ports use bridge number [1..N] as EFID, while
+	 * DSA_DB_PORT use the default EFID (0), not used by any bridge.
+	 */
+	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
+
+	dev_dbg(priv->dev, "fdb_add port %d addr %pM efid %d vid %d\n",
+		port, addr, efid, vid);
+
+	mutex_lock(&mb->l2_lock);
+	ret = rtl8365mb_l2_add_uc(priv, port, addr, efid, vid);
+	mutex_unlock(&mb->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "fdb_add ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+
+static int rtl8365mb_port_fdb_del(struct dsa_switch *ds, int port,
+				  const unsigned char *addr, u16 vid,
+				  struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb;
+	int efid;
+	int ret;
+
+	mb = priv->chip_data;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	/*
+	 * DSA_DB_BRIDGE ports use bridge number [1..N] as EFID, while
+	 * DSA_DB_PORT use the default EFID (0), not used by any bridge.
+	 */
+	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
+
+	dev_dbg(priv->dev, "fdb_del port %d addr %pM efid %d vid %d\n",
+		port, addr, efid, vid);
+
+	mutex_lock(&mb->l2_lock);
+	ret = rtl8365mb_l2_del_uc(priv, port, addr, efid, vid);
+	mutex_unlock(&mb->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "fdb_del ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+
+static int rtl8365mb_port_fdb_dump(struct dsa_switch *ds, int port,
+				   dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_l2_uc uc = {0};
+	u16 start_addr, addr = 0;
+	struct rtl8365mb *mb;
+	int ret = 0;
+
+	mb = priv->chip_data;
+
+	mutex_lock(&mb->l2_lock);
+	while (true) {
+		start_addr = addr;
+
+		dev_dbg(priv->dev, "l2_get_next_uc, addr:%d, port:%d\n",
+			addr, port);
+		ret = rtl8365mb_l2_get_next_uc(priv, &addr, port, &uc);
+		dev_dbg(priv->dev,
+			"l2_get_next_uc addr:%d mac:%pM vid:%d static:%d ret:%pe\n",
+			addr, uc.key.mac_addr, uc.key.vid, uc.is_static,
+			ERR_PTR(ret));
+
+		/* table is empty for that port */
+		if (ret == -ENOENT)
+			break;
+		if (ret)
+			break;
+
+		/* overflow: reached the end */
+		if (addr < start_addr)
+			break;
+
+		cb(uc.key.mac_addr, uc.key.vid, uc.is_static, data);
+
+		addr++;
+
+		/* Avoid -ETIMEDOUT in rtl8365mb_l2_get_next_uc() */
+		if (addr > RTL8365MB_LEARN_LIMIT_MAX)
+			break;
+	}
+	mutex_unlock(&mb->l2_lock);
+
+	return ret;
+}
+
+static int rtl8365mb_port_mdb_add(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_mdb *mdb,
+				  struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb;
+	int ret;
+
+	mb = priv->chip_data;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	dev_dbg(priv->dev, "mdb_add port %d addr %pM vid %d\n",
+		port, mdb->addr, mdb->vid);
+
+	mutex_lock(&mb->l2_lock);
+	ret = rtl8365mb_l2_add_mc(priv, port, mdb->addr, mdb->vid);
+	mutex_unlock(&mb->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "mdb_add ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+
+static int rtl8365mb_port_mdb_del(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_mdb *mdb,
+				  struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb;
+	int ret;
+
+	mb = priv->chip_data;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	dev_dbg(priv->dev, "mdb_del port %d addr %pM vid %d\n",
+		port, mdb->addr, mdb->vid);
+
+	mutex_lock(&mb->l2_lock);
+	ret = rtl8365mb_l2_del_mc(priv, port, mdb->addr, mdb->vid);
+	mutex_unlock(&mb->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "mdb_del ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
 static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 				       bool enable)
 {
@@ -2305,6 +2490,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	mb = priv->chip_data;
 	cpu = &mb->cpu;
 
+	mutex_init(&mb->l2_lock);
+
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
 		dev_err(priv->dev, "failed to reset chip: %d\n", ret);
@@ -2369,6 +2556,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	ds->assisted_learning_on_cpu_port = true;
+	ds->fdb_isolation = true;
 	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
 	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
 
@@ -2498,6 +2687,12 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_bridge_join = rtl8365mb_port_bridge_join,
 	.port_bridge_leave = rtl8365mb_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
+	.port_fast_age = rtl8365mb_port_fast_age,
+	.port_fdb_add = rtl8365mb_port_fdb_add,
+	.port_fdb_del = rtl8365mb_port_fdb_del,
+	.port_fdb_dump = rtl8365mb_port_fdb_dump,
+	.port_mdb_add = rtl8365mb_port_mdb_add,
+	.port_mdb_del = rtl8365mb_port_mdb_del,
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
 	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,

-- 
2.53.0


