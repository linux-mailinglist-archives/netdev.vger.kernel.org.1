Return-Path: <netdev+bounces-290649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFogMqLAD2q8PQYAu9opvQ
	(envelope-from <netdev+bounces-290649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA55AE085
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7287C3019E74
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BA30677B;
	Fri, 22 May 2026 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M424TaC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C73126BF
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417144; cv=none; b=XltuJLD4RVQS0uGpjlkr6o9x/es8nW5iUMgQB6rBNVPBa9SdI73FtGT0ay2gSv0C0HjtioLwbJXxCp+VJ8AYwUlKt08xEL6okiXMRkyykZ4CBLMmsFxwM+bPf/qsHGX6uXBmk+zArUZGjzbL5kxlVrckWQ8c/M4EDcEBhjPtQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417144; c=relaxed/simple;
	bh=uPyp542CMmbmJzl7dBBseBffhtDfHFoffyqIsi+pXk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COA6bN8pgUWac1k4cp9sCpFh81NjKa5uyOSJtygeVQgFC50i174BiLZ99Ow+6nAZ8NNY9PVJJDSk4SJQFea0H4tLyExr4QmyPVhwkaitVIAvdD0vNQehZHcb7EkBdgUQ5WagPfOkRG4xz9Nyx6ZnlQaMJ87NyfvHf8yMBFDImRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M424TaC/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5752b279662so2473177e0c.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779417141; x=1780021941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1fx5LPErRw5JFetAdcBD95+0AHvLdag2WmnQ/0mqnY=;
        b=M424TaC/Ou1efFsfxhvMppOfJIv5tMoG/cgWRCgX/nI48sxWIhRoZ7dSyRCw3zYech
         jdXd+W+WuzIiom7RQFCFwoJk9MXSnMinf1RUsZcJwjgfAsFZpAWi8RoILMZVo0R6a/Wy
         5IWJt/z9AEx8U5zCSqZs/fp3EOCtdrQlgNgTllIWGJshkUSqzJ6pLoruuodyY3XWlRRs
         Vw4K0IvYhtO75ryxM1PVmKZ5oAJaYv5VfgLLkXU8jhX5UZwmGMwBGuR1uVpchdM12PkS
         x2bJ7VA1otJLOG4u7UiKuNb56t9sGyCVU3kcgxqdpPfgdAqF9PGU51NdbirYdtVCyOwg
         PSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779417141; x=1780021941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K1fx5LPErRw5JFetAdcBD95+0AHvLdag2WmnQ/0mqnY=;
        b=rIgSIvRrIzHBBo9YLwGXJa0kx1E5aIzJ5gzAHx8tfVo/HbniJ+/o8AOw1d9pbQFJw0
         Y4M/ZlN1b/mrXjO8N6JEXGsDzkOKfYiVERLw5xG9n2+7Ha+fThSkPfTjPH1ZP+/ojtKU
         +ofRzSqtGEDo0OGSg6VkB+KCARAhxuViaA4WU3FjJJzL3YCStxJ8Fm9qiS8MbprEILUP
         K86emU0MKYHHH+6XlsokwH3s7PpXyHjaU0djDhliJJQZ0yb64Rqaqyc+dB7BUEgQX/S0
         Kb7e/8ShuL+aJYj5Bcadp29HB3ZqWMLOYiO5FQESkZoeLUmEmm8/BXg7I82lks38L8mZ
         CEsw==
X-Gm-Message-State: AOJu0YxNfYPwMzYlz0hBT/I/EiYCVR/UzWgk2gaJhI0C2BFBWK6ipuFm
	rQ25lzCY8p61RMlkm6oG626SYBB4AvwENnMXYs90Z6zxt19/mSTKe6ro
X-Gm-Gg: Acq92OE/vVQesAKKhrUBfbtoDNSpRgp5Z3eVcg8kk2mbJY5oG0E245spYf4xyvGfBSC
	+JJPzFm+/a/ZGwoZE2a4BDJbNuEFZlVAd7CNH20PCvq2k/u8M089e66nfvG+VTHx6Sj28CYsWzj
	H1qa5FA1+DtqJVLLelS6Oyb3+9oVPj8uBMjRPDRq8wJC4R0nictSUaVHM0OVwSlOW3EJvgznMOb
	pE4PKno27b14LRH1iog+A7sgiU7H8UjSDgI+UTzgp4gIUIJfsLZZPqK9XOGbe85m/zDlt56oF3F
	SH29dX/a7fGXuCZlu8lD7mT+B+ipyb60h83L58Kz6GtKfvjUNLsoRrG+PH4CumgKUqNbJ3HVLaD
	qWSGrHGXIk8bj7l8bXUOITa0TgA8MtmRsL74rVXbS9FF8JFKiAeNP6HnteuqmhGydepWHTuEZVU
	zhSxMTEKMSEWzAHyNlIziCb6Qca2X1g99rr6jCPaWv05KBLEcpLw==
X-Received: by 2002:a05:6122:2a0e:b0:577:4f42:ec0a with SMTP id 71dfb90a1353d-5865e1bf08bmr957304e0c.1.1779417140672;
        Thu, 21 May 2026 19:32:20 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm640709e0c.5.2026.05.21.19.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:32:19 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 May 2026 23:31:16 -0300
Subject: [net-next PATCH v6 7/8] net: dsa: realtek: rtl8365mb: add FDB
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-realtek_forward-v6-7-d391bbad38c3@gmail.com>
References: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
In-Reply-To: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: 61FA55AE085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Implement support for FDB and MDB management for the RTL8365MB series
switches.

The hardware supports IVL by keying the unicast forwarding database with
the {MAC, VID, EFID} tuple.  The Extended Filtering ID (EFID) is 3 bits
wide, providing 8 unique filtering domains. This driver reserves EFID 0
for standalone ports, effectively limiting the hardware offload to a
maximum of 7 bridges. The multicast database uses a {MAC, VID} key, with
ports from different bridges sharing the same multicast group.

Introduce a mutex lock (l2_lock) to protect concurrent L2 table updates.

Add support for forwarding database operations, including unicast and
multicast entry handling as well as fast aging support.

Set DSA switch flags assisted_learning_on_cpu_port and fdb_isolation.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/realtek.h        |  29 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c   | 547 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h   |  32 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  25 +-
 drivers/net/dsa/realtek/rtl83xx.c        | 294 +++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |  16 +
 7 files changed, 943 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index b7fc4e852fd8..6c329e046d0b 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
 rtl8365mb-objs := rtl8365mb_main.o \
 		  rtl8365mb_table.o \
 		  rtl8365mb_vlan.o \
+		  rtl8365mb_l2.o \
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e0079752f296..afbffcd448f6 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -45,6 +45,12 @@ struct rtl8366_vlan_4k {
 	u8	fid;
 };
 
+struct realtek_fdb_entry {
+	u8 mac_addr[ETH_ALEN];
+	u16 vid;
+	bool is_static;
+};
+
 struct realtek_priv {
 	struct device		*dev;
 	struct reset_control    *reset_ctl;
@@ -59,6 +65,15 @@ struct realtek_priv {
 	 * deleting port VLAN memberships and PVID configurations.
 	 */
 	struct mutex		vlan_lock;
+	/* l2_lock is used to prevent concurrent modifications of L2 table
+	 * entries while another function is reading it. l2_(add,del)_mc
+	 * is an example that first read current table entry and then
+	 * create/update it. l2_(add|del)_uc uses a single table op and,
+	 * internally, it might not need this lock. However, altering FDB
+	 * may still collide, as well as l2_flush, with fdb_dump iterating
+	 * over FDB.
+	 */
+	struct mutex		l2_lock;
 	struct mii_bus		*user_mii_bus;
 	struct mii_bus		*bus;
 	int			mdio_addr;
@@ -117,6 +132,19 @@ struct realtek_ops {
 	int	(*port_remove_isolation)(struct realtek_priv *priv, int port,
 					 u32 mask);
 	int	(*port_set_efid)(struct realtek_priv *priv, int port, u32 efid);
+	int	(*l2_add_uc)(struct realtek_priv *priv, int port,
+			     const unsigned char addr[ETH_ALEN],
+			     u16 efid, u16 vid);
+	int	(*l2_del_uc)(struct realtek_priv *priv, int port,
+			     const unsigned char addr[ETH_ALEN],
+			     u16 efid, u16 vid);
+	int	(*l2_get_next_uc)(struct realtek_priv *priv, u16 *addr,
+				  int port, struct realtek_fdb_entry *entry);
+	int	(*l2_add_mc)(struct realtek_priv *priv, int port,
+			     const unsigned char addr[ETH_ALEN], u16 vid);
+	int	(*l2_del_mc)(struct realtek_priv *priv, int port,
+			     const unsigned char addr[ETH_ALEN], u16 vid);
+	int	(*l2_flush)(struct realtek_priv *priv, int port, u16 vid);
 	int	(*phy_read)(struct realtek_priv *priv, int phy, int regnum);
 	int	(*phy_write)(struct realtek_priv *priv, int phy, int regnum,
 			     u16 val);
@@ -129,6 +157,7 @@ struct realtek_variant {
 	unsigned int clk_delay;
 	u8 cmd_read;
 	u8 cmd_write;
+	u16 l2_table_size;
 	size_t chip_data_sz;
 };
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
new file mode 100644
index 000000000000..dc32d919e4fc
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -0,0 +1,547 @@
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
+#define RTL8365MB_L2_UC_D0_MAC5_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_UC_D0_MAC4_MSK		GENMASK(15, 8)
+#define RTL8365MB_L2_UC_D1_MAC3_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_UC_D1_MAC2_MSK		GENMASK(15, 8)
+#define RTL8365MB_L2_UC_D2_MAC1_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_UC_D2_MAC0_MSK		GENMASK(15, 8)
+#define RTL8365MB_L2_UC_D3_VID_MSK		GENMASK(11, 0)
+#define RTL8365MB_L2_UC_D3_IVL_MSK		GENMASK(13, 13)
+#define RTL8365MB_L2_UC_D3_PORT_EXT_MSK	GENMASK(15, 15)
+#define   RTL8365MB_L2_UC_PORT_HI_MSK		GENMASK(3, 3)
+#define RTL8365MB_L2_UC_D4_EFID_MSK		GENMASK(2, 0)
+#define RTL8365MB_L2_UC_D4_FID_MSK		GENMASK(6, 3)
+#define RTL8365MB_L2_UC_D4_SA_PRI_MSK		GENMASK(7, 7)
+#define RTL8365MB_L2_UC_D4_PORT_MSK		GENMASK(10, 8)
+#define   RTL8365MB_L2_UC_PORT_LO_MSK		GENMASK(2, 0)
+#define RTL8365MB_L2_UC_D4_AGE_MSK		GENMASK(13, 11)
+#define RTL8365MB_L2_UC_D4_AUTH_MSK		GENMASK(14, 14)
+#define RTL8365MB_L2_UC_D4_SA_BLOCK_MSK	GENMASK(15, 15)
+
+#define RTL8365MB_L2_UC_D5_DA_BLOCK_MSK	GENMASK(0, 0)
+#define RTL8365MB_L2_UC_D5_PRIORITY_MSK	GENMASK(3, 1)
+#define RTL8365MB_L2_UC_D5_FWD_PRI_MSK		GENMASK(4, 4)
+#define RTL8365MB_L2_UC_D5_STATIC_MSK		GENMASK(5, 5)
+
+#define RTL8365MB_L2_MC_D0_MAC5_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_MC_D0_MAC4_MSK		GENMASK(15, 8)
+#define RTL8365MB_L2_MC_D1_MAC3_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_MC_D1_MAC2_MSK		GENMASK(15, 8)
+#define RTL8365MB_L2_MC_D2_MAC1_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_MC_D2_MAC0_MSK		GENMASK(15, 8)
+#define RTL8365MB_L2_MC_D3_VID_MSK		GENMASK(11, 0)
+#define RTL8365MB_L2_MC_D3_IVL_MSK		GENMASK(13, 13)
+#define RTL8365MB_L2_MC_D3_MBR_HI1_MSK		GENMASK(15, 14)
+#define   RTL8365MB_L2_MC_MBR_HI1_MSK		GENMASK(9, 8)
+
+#define RTL8365MB_L2_MC_D4_MBR_MSK		GENMASK(7, 0)
+#define   RTL8365MB_L2_MC_MBR_LO_MSK		GENMASK(7, 0)
+#define RTL8365MB_L2_MC_D4_IGMPIDX_MSK		GENMASK(15, 8)
+
+#define RTL8365MB_L2_MC_D5_IGMP_ASIC_MSK	GENMASK(0, 0)
+#define RTL8365MB_L2_MC_D5_PRIORITY_MSK	GENMASK(3, 1)
+#define RTL8365MB_L2_MC_D5_FWD_PRI_MSK		GENMASK(4, 4)
+#define RTL8365MB_L2_MC_D5_STATIC_MSK		GENMASK(5, 5)
+#define RTL8365MB_L2_MC_D5_MBR_HI2_MSK		GENMASK(7, 7)
+#define   RTL8365MB_L2_MC_MBR_HI2_MSK		GENMASK(10, 10)
+
+/* Port flush command registers - writing a 1 to the port's MASK bit will
+ * initiate the flush procedure. Completion is signalled when the corresponding
+ * BUSY bit is 0.
+ */
+#define RTL8365MB_L2_FLUSH_PORT_REG		0x0A36
+#define   RTL8365MB_L2_FLUSH_PORT_MSK_MSK	GENMASK(7, 0)
+#define   RTL8365MB_L2_FLUSH_PORT_BUSY_MSK	GENMASK(15, 8)
+
+#define RTL8365MB_L2_FLUSH_PORT_EXT_REG		0x0A35
+#define   RTL8365MB_L2_FLUSH_PORT_EXT_MSK_MSK	GENMASK(2, 0)
+#define   RTL8365MB_L2_FLUSH_PORT_EXT_BUSY_MSK	GENMASK(5, 3)
+
+#define RTL8365MB_L2_FLUSH_CTRL1_REG		0x0A37
+#define   RTL8365MB_L2_FLUSH_CTRL1_VID_MSK	GENMASK(11, 0)
+#define   RTL8365MB_L2_FLUSH_CTRL1_FID_MSK	GENMASK(15, 12)
+
+#define RTL8365MB_L2_FLUSH_CTRL2_REG		0x0A38
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_MSK	GENMASK(1, 0)
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT	0
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_VID 1
+#define   RTL8365MB_L2_FLUSH_CTRL2_MODE_PORT_FID 2
+#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_MSK	GENMASK(2, 2)
+#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_DYNAMIC	0
+#define   RTL8365MB_L2_FLUSH_CTRL2_TYPE_BOTH	1
+
+/* This flushes the entire LUT, reading it back it will turn 0 when the
+ * operation is complete
+ */
+#define RTL8365MB_L2_FLUSH_CTRL3_REG		0x0A39
+#define   RTL8365MB_L2_FLUSH_CTRL3_MSK		GENMASK(0, 0)
+
+struct rtl8365mb_l2_uc_key {
+	u8 mac_addr[ETH_ALEN];
+	u16 vid;
+	u16 fid;
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
+	u32 val;
+
+	uc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC5_MSK, data[0]);
+	uc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC4_MSK, data[0]);
+	uc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC3_MSK, data[1]);
+	uc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC2_MSK, data[1]);
+	uc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC1_MSK, data[2]);
+	uc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC0_MSK, data[2]);
+	uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MSK, data[4]);
+	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MSK, data[3]);
+	uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MSK, data[3]);
+	uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MSK, data[4]);
+	uc->age = FIELD_GET(RTL8365MB_L2_UC_D4_AGE_MSK, data[4]);
+	uc->auth = FIELD_GET(RTL8365MB_L2_UC_D4_AUTH_MSK, data[4]);
+
+	val = FIELD_GET(RTL8365MB_L2_UC_D4_PORT_MSK, data[4]);
+	uc->port = FIELD_PREP(RTL8365MB_L2_UC_PORT_LO_MSK, val);
+	val = FIELD_GET(RTL8365MB_L2_UC_D3_PORT_EXT_MSK, data[3]);
+	uc->port |= FIELD_PREP(RTL8365MB_L2_UC_PORT_HI_MSK, val);
+
+	uc->sa_pri = FIELD_GET(RTL8365MB_L2_UC_D4_SA_PRI_MSK, data[4]);
+	uc->fwd_pri = FIELD_GET(RTL8365MB_L2_UC_D5_FWD_PRI_MSK, data[5]);
+	uc->sa_block = FIELD_GET(RTL8365MB_L2_UC_D4_SA_BLOCK_MSK, data[4]);
+	uc->da_block = FIELD_GET(RTL8365MB_L2_UC_D5_DA_BLOCK_MSK, data[5]);
+	uc->priority = FIELD_GET(RTL8365MB_L2_UC_D5_PRIORITY_MSK, data[5]);
+	uc->is_static = FIELD_GET(RTL8365MB_L2_UC_D5_STATIC_MSK, data[5]);
+}
+
+static void rtl8365mb_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data)
+{
+	u32 val;
+
+	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
+	data[0] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D0_MAC5_MSK, uc->key.mac_addr[5]);
+	data[0] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D0_MAC4_MSK, uc->key.mac_addr[4]);
+	data[1] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D1_MAC3_MSK, uc->key.mac_addr[3]);
+	data[1] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D1_MAC2_MSK, uc->key.mac_addr[2]);
+	data[2] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D2_MAC1_MSK, uc->key.mac_addr[1]);
+	data[2] |=
+		FIELD_PREP(RTL8365MB_L2_UC_D2_MAC0_MSK, uc->key.mac_addr[0]);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_VID_MSK, uc->key.vid);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_IVL_MSK, uc->key.ivl);
+
+	val = FIELD_GET(RTL8365MB_L2_UC_PORT_HI_MSK, uc->port);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_PORT_EXT_MSK, val);
+
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_FID_MSK, uc->key.fid);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_EFID_MSK, uc->key.efid);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_AGE_MSK, uc->age);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_AUTH_MSK, uc->auth);
+
+	val = FIELD_GET(RTL8365MB_L2_UC_PORT_LO_MSK, uc->port);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_PORT_MSK, val);
+
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_SA_PRI_MSK, uc->sa_pri);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_UC_D4_SA_BLOCK_MSK, uc->sa_block);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_FWD_PRI_MSK, uc->fwd_pri);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_DA_BLOCK_MSK, uc->da_block);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_PRIORITY_MSK, uc->priority);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_STATIC_MSK, uc->is_static);
+}
+
+static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
+{
+	u32 val;
+
+	mc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_MC_D0_MAC5_MSK, data[0]);
+	mc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_MC_D0_MAC4_MSK, data[0]);
+	mc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_MC_D1_MAC3_MSK, data[1]);
+	mc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_MC_D1_MAC2_MSK, data[1]);
+	mc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_MC_D2_MAC1_MSK, data[2]);
+	mc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_MC_D2_MAC0_MSK, data[2]);
+	/* key.vid,key.fid shares the same memory space */
+	mc->key.vid = FIELD_GET(RTL8365MB_L2_MC_D3_VID_MSK, data[3]);
+	mc->key.ivl = FIELD_GET(RTL8365MB_L2_MC_D3_IVL_MSK, data[3]);
+	mc->priority = FIELD_GET(RTL8365MB_L2_MC_D5_PRIORITY_MSK, data[5]);
+	mc->fwd_pri = FIELD_GET(RTL8365MB_L2_MC_D5_FWD_PRI_MSK, data[5]);
+	mc->is_static = FIELD_GET(RTL8365MB_L2_MC_D5_STATIC_MSK, data[5]);
+
+	val = FIELD_GET(RTL8365MB_L2_MC_D4_MBR_MSK, data[4]);
+	mc->member = FIELD_PREP(RTL8365MB_L2_MC_MBR_LO_MSK, val);
+	val = FIELD_GET(RTL8365MB_L2_MC_D3_MBR_HI1_MSK, data[3]);
+	mc->member |= FIELD_PREP(RTL8365MB_L2_MC_MBR_HI1_MSK, val);
+	val = FIELD_GET(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, data[5]);
+	mc->member |= FIELD_PREP(RTL8365MB_L2_MC_MBR_HI2_MSK, val);
+
+	mc->igmpidx = FIELD_GET(RTL8365MB_L2_MC_D4_IGMPIDX_MSK, data[4]);
+	mc->igmp_asic = FIELD_GET(RTL8365MB_L2_MC_D5_IGMP_ASIC_MSK, data[5]);
+}
+
+static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
+{
+	u32 val;
+
+	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
+	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_D0_MAC5_MSK, mc->key.mac_addr[5]);
+	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_D0_MAC4_MSK, mc->key.mac_addr[4]);
+	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_D1_MAC3_MSK, mc->key.mac_addr[3]);
+	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_D1_MAC2_MSK, mc->key.mac_addr[2]);
+	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_D2_MAC1_MSK, mc->key.mac_addr[1]);
+	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_D2_MAC0_MSK, mc->key.mac_addr[0]);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_VID_MSK, mc->key.vid);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_IVL_MSK, mc->key.ivl);
+
+	val = FIELD_GET(RTL8365MB_L2_MC_MBR_HI1_MSK, mc->member);
+	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_MBR_HI1_MSK, val);
+
+	val = FIELD_GET(RTL8365MB_L2_MC_MBR_LO_MSK, mc->member);
+	data[4] |= FIELD_PREP(RTL8365MB_L2_MC_D4_MBR_MSK, val);
+
+	data[4] |= FIELD_PREP(RTL8365MB_L2_MC_D4_IGMPIDX_MSK, mc->igmpidx);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_IGMP_ASIC_MSK, mc->igmp_asic);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_PRIORITY_MSK, mc->priority);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_FWD_PRI_MSK, mc->fwd_pri);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_STATIC_MSK, mc->is_static);
+
+	val = FIELD_GET(RTL8365MB_L2_MC_MBR_HI2_MSK, mc->member);
+	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, val);
+}
+
+/**
+ * rtl8365mb_l2_get_next_uc() - get the next Unicast L2 entry
+ * @priv: realtek_priv pointer
+ * @addr: as input, the table index to start the walk
+ *        as output, the found table index
+ * @port: restrict the walk on entries related to port
+ * @entry: returned L2 Unicast table entry
+ *
+ * This function get the next unicast L2 table entry starting from @addr
+ * and checking exclusively entries related to @port. If no more entries
+ * were found, the output @addr will be lower than the input @addr and @entry
+ * will not be overwritten.
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ **/
+int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
+			     struct realtek_fdb_entry *entry)
+{
+	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	struct rtl8365mb_l2_uc uc;
+	int ret;
+
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
+				    RTL8365MB_TABLE_OP_READ, addr,
+				    RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT,
+				    port, data, RTL8365MB_L2_ENTRY_SIZE);
+	if (ret)
+		return ret;
+
+	rtl8365mb_l2_data_to_uc(data, &uc);
+
+	ether_addr_copy(entry->mac_addr, uc.key.mac_addr);
+	entry->vid = uc.key.vid;
+	entry->is_static = uc.is_static;
+
+	return 0;
+}
+
+int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
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
+	uc.key.fid = 0;
+	uc.key.ivl = true;
+	uc.key.vid = vid;
+
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
+	return ret;
+}
+
+int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
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
+	uc.key.fid = 0;
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
+			   FIELD_PREP(RTL8365MB_L2_FLUSH_CTRL2_MODE_MSK,
+				      mode) |
+			   FIELD_PREP(RTL8365MB_L2_FLUSH_CTRL2_TYPE_MSK,
+				      RTL8365MB_L2_FLUSH_CTRL2_TYPE_DYNAMIC));
+	if (ret)
+		goto out;
+
+	ret = regmap_write(priv->map_nolock, RTL8365MB_L2_FLUSH_CTRL1_REG,
+			   FIELD_PREP(RTL8365MB_L2_FLUSH_CTRL1_VID_MSK, vid));
+
+	if (ret)
+		goto out;
+	/* Now issue the flush command and wait for its completion. There are
+	 * two registers for this purpose, and which one to use depends on the
+	 * port number. The _EXT register is for ports 8 or higher.
+	 */
+	if (port < 8) {
+		val = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_MSK_MSK,
+				 BIT(port) & 0xFF);
+		ret = regmap_write(priv->map_nolock,
+				   RTL8365MB_L2_FLUSH_PORT_REG, val);
+		if (ret)
+			goto out;
+
+		mask = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_BUSY_MSK,
+				  BIT(port) & 0xFF);
+		ret = regmap_read_poll_timeout(priv->map_nolock,
+					       RTL8365MB_L2_FLUSH_PORT_REG,
+					       val, !(val & mask), 10, 10000);
+		if (ret)
+			goto out;
+	} else {
+		val = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_EXT_MSK_MSK,
+				 BIT(port) >> 8);
+		ret = regmap_write(priv->map_nolock,
+				   RTL8365MB_L2_FLUSH_PORT_EXT_REG, val);
+		if (ret)
+			goto out;
+
+		mask = FIELD_PREP(RTL8365MB_L2_FLUSH_PORT_EXT_BUSY_MSK,
+				  BIT(port) >> 8);
+		ret = regmap_read_poll_timeout(priv->map_nolock,
+					       RTL8365MB_L2_FLUSH_PORT_EXT_REG,
+					       val, !(val & mask), 10, 10000);
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
+int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
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
+		dev_dbg(priv->dev,
+			"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
+			__func__, mac_addr, addr, mc.member, mc.igmpidx,
+			mc.is_static ? "static" : "dynamic");
+		/* the port must be added as a member */
+		mc.member |= BIT(port);
+
+		if (!mc.is_static) {
+			dev_dbg(priv->dev,
+				"%s: promoting addr=%d group to static\n",
+				__func__, addr);
+			mc.is_static = 1;
+		}
+
+		rtl8365mb_l2_mc_to_data(&mc, data);
+	} else if (ret == -ENOENT) {
+		/* New entry, no need to update data again as it already
+		 * includes the member.
+		 *
+		 * Multicast hardware entries do not support EFID (bridge
+		 * isolation). However, traffic isolation is still maintained
+		 * because the hardware applies the port isolation masks
+		 * (pmasks) configured in bridge_join after the L2 lookup.
+		 * Entries from different bridges will collide on the same
+		 * MAC+VID slot with an OR'ed member mask, but packets will
+		 * only exit through ports allowed by the source port's pmask.
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
+	return ret;
+}
+
+int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
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
+	if (ret == -ENOENT) {
+		dev_dbg(priv->dev, "l2_del_mc: vid=%d missing\n", vid);
+		/* Silently return success */
+		return 0;
+	}
+
+	if (ret)
+		/* Return on any other error */
+		return ret;
+
+	rtl8365mb_l2_data_to_mc(data, &mc);
+	dev_dbg(priv->dev,
+		"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
+		__func__, mac_addr, addr, mc.member, mc.igmpidx,
+		mc.is_static ? "static" : "dynamic");
+	/* the port must be removed as a member */
+	mc.member &= ~BIT(port);
+	if (!mc.member) {
+		/* Multicast entries do not have an age field. Clearing both
+		 * the member portmask and is_static flags is the hardware
+		 * signal to invalidate and reclaim the L2 table slot.
+		 */
+		mc.is_static = 0;
+		mc.igmpidx = 0;
+		mc.priority = 0;
+		mc.fwd_pri = 0;
+		mc.igmp_asic = 0;
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
index 000000000000..9470cf059ce5
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.h
@@ -0,0 +1,32 @@
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
+int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
+			     struct realtek_fdb_entry *entry);
+int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
+			const unsigned char addr[static ETH_ALEN],
+			u16 efid, u16 vid);
+int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
+			const unsigned char addr[static ETH_ALEN],
+			u16 efid, u16 vid);
+int rtl8365mb_l2_flush(struct realtek_priv *priv, int port, u16 vid);
+
+int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 vid);
+int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
+			const unsigned char mac_addr[static ETH_ALEN],
+			u16 vid);
+
+#endif /* _REALTEK_RTL8365MB_L2_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 91282cd39487..bcf917d0a58c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -104,6 +104,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
+#include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
 
 /* Family-specific data and limits */
@@ -111,8 +112,15 @@
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_MAX_NUM_PORTS		11
-#define RTL8365MB_MAX_NUM_EXTINTS	3
+/* Valid for the whole family except RTL8370B, which has 4160 entries.
+ * RTL8370B is mentioned in vendor code but it might not even belong
+ * to the same RTL8367C family.
+ */
 #define RTL8365MB_LEARN_LIMIT_MAX	2112
+#define RTL8365MB_MAX_NUM_EXTINTS	3
+
+/* The LUT table size matches the maximum learning limit */
+#define RTL8365MB_L2_TABLE_SIZE		RTL8365MB_LEARN_LIMIT_MAX
 
 /* Chip identification registers */
 #define RTL8365MB_CHIP_ID_REG		0x1300
@@ -2432,6 +2440,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	ds->assisted_learning_on_cpu_port = true;
+	ds->fdb_isolation = true;
 	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
 	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
 	ds->configure_vlan_while_not_filtering = true;
@@ -2553,6 +2563,12 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
+	.port_fast_age = rtl83xx_port_fast_age,
+	.port_fdb_add = rtl83xx_port_fdb_add,
+	.port_fdb_del = rtl83xx_port_fdb_del,
+	.port_fdb_dump = rtl83xx_port_fdb_dump,
+	.port_mdb_add = rtl83xx_port_mdb_add,
+	.port_mdb_del = rtl83xx_port_mdb_del,
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
 	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,
@@ -2574,6 +2590,12 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.port_add_isolation = rtl8365mb_port_add_isolation,
 	.port_remove_isolation = rtl8365mb_port_remove_isolation,
 	.port_set_efid = rtl8365mb_port_set_efid,
+	.l2_add_uc = rtl8365mb_l2_add_uc,
+	.l2_del_uc = rtl8365mb_l2_del_uc,
+	.l2_get_next_uc = rtl8365mb_l2_get_next_uc,
+	.l2_add_mc = rtl8365mb_l2_add_mc,
+	.l2_del_mc = rtl8365mb_l2_del_mc,
+	.l2_flush = rtl8365mb_l2_flush,
 	.phy_read = rtl8365mb_phy_read,
 	.phy_write = rtl8365mb_phy_write,
 };
@@ -2585,6 +2607,7 @@ const struct realtek_variant rtl8365mb_variant = {
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
 	.cmd_write = 0xb8,
+	.l2_table_size = RTL8365MB_L2_TABLE_SIZE,
 	.chip_data_sz = sizeof(struct rtl8365mb),
 };
 
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 126a5405272b..c2e39868c4c0 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -156,6 +156,7 @@ rtl83xx_probe(struct device *dev,
 
 	mutex_init(&priv->map_lock);
 	mutex_init(&priv->vlan_lock);
+	mutex_init(&priv->l2_lock);
 
 	rc.lock_arg = priv;
 	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
@@ -467,6 +468,299 @@ void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_leave, "REALTEK_DSA");
 
+/**
+ * rtl83xx_port_fast_age() - flush dynamic FDB entries learned on a port
+ * @ds: DSA switch instance
+ * @port: port index
+ *
+ * This function requests the switch to age out dynamic FDB entries learned on
+ * @port.
+ *
+ * Context: Can sleep.
+ * Return: Nothing.
+ */
+void rtl83xx_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct realtek_priv *priv = ds->priv;
+	int ret;
+
+	if (!priv->ops->l2_flush) {
+		dev_warn_once(priv->dev, "l2_flush op not defined\n");
+		return;
+	}
+
+	dev_dbg(priv->dev, "fast_age port %d\n", port);
+
+	mutex_lock(&priv->l2_lock);
+	ret = priv->ops->l2_flush(priv, port, 0);
+	mutex_unlock(&priv->l2_lock);
+	if (ret)
+		dev_err(priv->dev, "failed to fast age on port %d: %d\n", port,
+			ret);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_fast_age, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_fdb_add() - add a static FDB entry to a port database
+ * @ds: DSA switch instance
+ * @port: port index
+ * @addr: MAC address to add
+ * @vid: VLAN ID associated with @addr
+ * @db: database where the entry should be added
+ *
+ * This function adds a static unicast FDB entry to the standalone port
+ * database or to a bridge database.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_fdb_add(struct dsa_switch *ds, int port,
+			 const unsigned char *addr, u16 vid,
+			 struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	int efid;
+	int ret;
+
+	if (!priv->ops->l2_add_uc)
+		return -EOPNOTSUPP;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	/*
+	 * DSA_DB_BRIDGE ports use bridge number [1..N] as EFID, while
+	 * DSA_DB_PORT use the default EFID (0), not used by any bridge.
+	 * Standalone user ports share EFID (0) but have hardware learning
+	 * disabled. The CPU port also uses EFID (0), caused by
+	 * ds->assisted_learning_on_cpu_port = true
+	 */
+	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
+
+	dev_dbg(priv->dev, "%s: port:%d addr:%pM efid:%d vid:%d dbtype:%d\n",
+		__func__, port, addr, efid, vid, db.type);
+
+	mutex_lock(&priv->l2_lock);
+	ret = priv->ops->l2_add_uc(priv, port, addr, efid, vid);
+	mutex_unlock(&priv->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "fdb_add ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_fdb_add, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_fdb_del() - delete a static FDB entry from a port database
+ * @ds: DSA switch instance
+ * @port: port index
+ * @addr: MAC address to delete
+ * @vid: VLAN ID associated with @addr
+ * @db: database where the entry should be removed
+ *
+ * This function deletes a static unicast FDB entry from the standalone port
+ * database or from a bridge database.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_fdb_del(struct dsa_switch *ds, int port,
+			 const unsigned char *addr, u16 vid,
+			 struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	int efid;
+	int ret;
+
+	if (!priv->ops->l2_del_uc)
+		return -EOPNOTSUPP;
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
+	dev_dbg(priv->dev, "%s: port:%d addr:%pM efid:%d vid:%d dbtype:%d\n",
+		__func__, port, addr, efid, vid, db.type);
+
+	mutex_lock(&priv->l2_lock);
+	ret = priv->ops->l2_del_uc(priv, port, addr, efid, vid);
+	mutex_unlock(&priv->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "fdb_del ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_fdb_del, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_fdb_dump() - iterate over FDB entries associated with a port
+ * @ds: DSA switch instance
+ * @port: port index
+ * @cb: callback invoked for each entry
+ * @data: opaque pointer passed to @cb
+ *
+ * This function walks the unicast FDB entries associated with @port and calls
+ * @cb for each matching entry.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, or negative value for failure.
+ */
+int rtl83xx_port_fdb_dump(struct dsa_switch *ds, int port,
+			  dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct realtek_fdb_entry entry = { 0 };
+	struct realtek_priv *priv = ds->priv;
+	u16 l2_table_size = priv->variant->l2_table_size;
+	u16 start_addr, addr = 0;
+	int ret = 0;
+
+	if (!priv->ops->l2_get_next_uc)
+		return -EOPNOTSUPP;
+	if (!l2_table_size) {
+		dev_warn_once(priv->dev, "l2_table_size not defined\n");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&priv->l2_lock);
+	while (true) {
+		start_addr = addr;
+
+		dev_dbg(priv->dev, "l2_get_next_uc, addr:%d, port:%d\n",
+			addr, port);
+		ret = priv->ops->l2_get_next_uc(priv, &addr, port, &entry);
+		dev_dbg(priv->dev,
+			"%s addr:%d mac:%pM vid:%d static:%d ret:%pe\n",
+			__func__, addr, entry.mac_addr, entry.vid,
+			entry.is_static, ERR_PTR(ret));
+
+		if (ret == -ENOENT) {
+			/* If the table is empty, returns without errors. Note
+			 * that the l2_get_next_uc overflow to the first match
+			 * when it reaches the end of the table.
+			 */
+			ret = 0;
+			break;
+		}
+
+		if (ret)
+			break;
+
+		/* When the addr returned is before the requested one, it
+		 * indicates that we reached the end.
+		 */
+		if (addr < start_addr)
+			break;
+
+		ret = cb(entry.mac_addr, entry.vid, entry.is_static, data);
+		if (ret)
+			break;
+
+		addr++;
+
+		/* Avoid querying beyond the valid L2 table range. */
+		if (addr >= l2_table_size)
+			break;
+	}
+	mutex_unlock(&priv->l2_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_fdb_dump, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_mdb_add() - add a multicast database entry to a port database
+ * @ds: DSA switch instance
+ * @port: port index
+ * @mdb: multicast database entry to add
+ * @db: database where the entry should be added
+ *
+ * This function adds a multicast database entry to the standalone port
+ * database or to a bridge database.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_mdb_add(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_port_mdb *mdb,
+			 struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	const unsigned char *addr = mdb->addr;
+	u16 vid = mdb->vid;
+	int efid;
+	int ret;
+
+	if (!priv->ops->l2_add_mc)
+		return -EOPNOTSUPP;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
+
+	dev_dbg(priv->dev, "%s: port:%d addr:%pM efid:%d vid:%d dbtype:%d\n",
+		__func__, port, addr, efid, vid, db.type);
+
+	mutex_lock(&priv->l2_lock);
+	ret = priv->ops->l2_add_mc(priv, port, addr, vid);
+	mutex_unlock(&priv->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "mdb_add ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_mdb_add, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_mdb_del() - delete a multicast database entry from a port
+ * database
+ * @ds: DSA switch instance
+ * @port: port index
+ * @mdb: multicast database entry to delete
+ * @db: database where the entry should be removed
+ *
+ * This function deletes a multicast database entry from the standalone port
+ * database or from a bridge database.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_port_mdb *mdb,
+			 struct dsa_db db)
+{
+	struct realtek_priv *priv = ds->priv;
+	const unsigned char *addr = mdb->addr;
+	u16 vid = mdb->vid;
+	int efid;
+	int ret;
+
+	if (!priv->ops->l2_del_mc)
+		return -EOPNOTSUPP;
+
+	if (db.type != DSA_DB_PORT && db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
+
+	dev_dbg(priv->dev, "%s: port:%d addr:%pM efid:%d vid:%d dbtype:%d\n",
+		__func__, port, addr, efid, vid, db.type);
+
+	mutex_lock(&priv->l2_lock);
+	ret = priv->ops->l2_del_mc(priv, port, addr, vid);
+	mutex_unlock(&priv->l2_lock);
+
+	if (ret)
+		dev_err(priv->dev, "mdb_del ERROR %pe\n", ERR_PTR(ret));
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_mdb_del, "REALTEK_DSA");
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index 2481a1aaa226..dcb819fe567f 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -28,4 +28,20 @@ int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
 void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
 			       struct dsa_bridge bridge);
 
+void rtl83xx_port_fast_age(struct dsa_switch *ds, int port);
+int rtl83xx_port_fdb_add(struct dsa_switch *ds, int port,
+			 const unsigned char *addr, u16 vid,
+			 struct dsa_db db);
+int rtl83xx_port_fdb_del(struct dsa_switch *ds, int port,
+			 const unsigned char *addr, u16 vid,
+			 struct dsa_db db);
+int rtl83xx_port_fdb_dump(struct dsa_switch *ds, int port,
+			  dsa_fdb_dump_cb_t *cb, void *data);
+int rtl83xx_port_mdb_add(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_port_mdb *mdb,
+			 struct dsa_db db);
+int rtl83xx_port_mdb_del(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_port_mdb *mdb,
+			 struct dsa_db db);
+
 #endif /* _RTL83XX_H */

-- 
2.54.0


