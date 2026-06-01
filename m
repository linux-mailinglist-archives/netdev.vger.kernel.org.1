Return-Path: <netdev+bounces-293697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMNAMXRuHWrlagkAu9opvQ
	(envelope-from <netdev+bounces-293697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:35:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E361E626
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9FF4308EBA7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CEB3A4F4A;
	Mon,  1 Jun 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KXRAdaun";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g7W92kl2"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607C3A4F33;
	Mon,  1 Jun 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313178; cv=none; b=qqh/zkhQQYZrQ+d/O+A51Obn73tcCO6N6ew23oGka8eJV12ssPqCsJRhe5Iu3bIQA7Wj7k6Z8MVuCRS+S6/W5QVolg84r5oJw5zJKKBRaaZ8VEG91ixizjh8AJoOpBy2Kb/lBQI5KaAh7+HM/t/fiHAEAv3kGpVKz47w3zuj/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313178; c=relaxed/simple;
	bh=bxqH9AdTyCEszCiklsP2bhpZh7r72M/llZQj4Ce70T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scOalDKnmy9H+9P1b2s8r6ukvrQol8kKv7yRs57tGmPRdwNpFznziY7X8HA6vRexr3K7GmVqoqSnVGcgYNFuf/HhNr1F5J+IgQjAFBAtA/sEtTgmrMHxKc8i2cgtXpWydICKs+M/xzCDBIYc3M4js7L9H+8meFkcnVpNRYQzE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KXRAdaun; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=g7W92kl2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gTWqp5shtz9thq;
	Mon,  1 Jun 2026 13:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKA5ewge2HaR8c9oruQp+nhwZO3iGLvBV4mDI9WArDU=;
	b=KXRAdaunY3JCFY7kVpPLmy9Za9A3ccEHC0g3d9dX0hRPBVpkO+ON7j/xLna+KxNQLkY5yH
	XGpXVhw1PuT9PhfM64CmoYIe6x+DpoSrHyE5O7d+DR8cb17vq4z28eMEZDbBlk+3KQ+GuE
	CTfWjIRwQ9J5DlIdukDFkvVBEwUT0fwJzhLyEbM527Ao/NGYtbPKWXaCFoGyYS92DaYkj6
	FwQ4ynikJ7iy5oQGLrwUhKG7HdxCI+gbo/Btk45A+/hPkGOHVf9zBM9E6K37Ds3JAPFfUT
	H949xQU/2lTe3f15rNtTnu/UGK2yqWTADU05AfxXnyVC+sM0qcJL36ivLFsjWg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=g7W92kl2;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKA5ewge2HaR8c9oruQp+nhwZO3iGLvBV4mDI9WArDU=;
	b=g7W92kl2plFhMQuq2+Z3RmpAJXc/gzKubkYd3+GPfAhWfUqWNzBwOKGWEo3fugxopLCtPt
	pmt8KD/aBpHooWSAGenOaKk+D9yNq4Rtd6z0ynpOrzctEBjXI/9E9lvBy37eSPZQwRqpkf
	AWd2cU17JRGRNtP2d/iFIKjE4dohV0pYWF0VqZaKK/ChMob+lLqXj3lTavhgs3FlcTvR/t
	jYX1l0HZVKQdNRa8ycbl37bI5+k7gw2QeYkLQJLpsu8kSySIZ/6egPtNUeYlYfDfJCfzYP
	WvfSy1amiyujNR5fvAQqSkECE+pVU7VSgJGGDofoGhlm/7CLdN8pmUurZdNf0g==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v24 6/7] net: mtip: Extend the L2 switch driver with management operations
Date: Mon,  1 Jun 2026 13:24:35 +0200
Message-ID: <20260601112437.2216043-7-lukasz.majewski@mailbox.org>
In-Reply-To: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b61c134b11940e4bbff
X-MBO-RS-META: i9jjczj485gcn4jihd8g8gs7gmozntwq
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-293697-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,nabladev.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,freescale.com:email]
X-Rspamd-Queue-Id: 2C1E361E626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch provides function necessary for managing the L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>

---
Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14 - v21:
- None

Changes for v22:
- Update 'mode' check in mtip_vlan_input_process(). The comment was
  misleading, so it has been removed. ESW_VIMSEL accepts "Mode" 1 to 4,
  but it has allowed values from 0 to 3 (the IM fields' values)

Changes for v23:
- Update copyright notice

Changes for v24:
- None
---
 .../net/ethernet/freescale/mtipsw/Makefile    |   2 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  |  31 ++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  23 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c | 442 ++++++++++++++++++
 4 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
index bd8ffb30939a..a99aaf6ddfb2 100644
--- a/drivers/net/ethernet/freescale/mtipsw/Makefile
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_FEC_MTIP_L2SW) += nxp-mtipl2sw.o
-nxp-mtipl2sw-objs := mtipl2sw.o
+nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 212207861e13..76e503e128dd 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -505,8 +505,35 @@ static void mtip_config_switch(struct switch_enet_private *fep)
 
 	writel(0, fep->hwp + ESW_BKLR);
 
+	/* Do NOT disable learning */
+	mtip_port_learning_config(fep, 0, 0, 0);
+	mtip_port_learning_config(fep, 1, 0, 0);
+	mtip_port_learning_config(fep, 2, 0, 0);
+
+	/* Disable blocking */
+	mtip_port_blocking_config(fep, 0, 0);
+	mtip_port_blocking_config(fep, 1, 0);
+	mtip_port_blocking_config(fep, 2, 0);
+
 	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
 	       fep->hwp + ESW_IMR);
+
+	mtip_port_enable_config(fep, 0, 1, 1);
+	mtip_port_enable_config(fep, 1, 1, 1);
+	mtip_port_enable_config(fep, 2, 1, 1);
+
+	mtip_port_broadcast_config(fep, 0, 1);
+	mtip_port_broadcast_config(fep, 1, 1);
+	mtip_port_broadcast_config(fep, 2, 1);
+
+	/* Disable multicast receive on port 0 (MGNT) */
+	mtip_port_multicast_config(fep, 0, 0);
+	mtip_port_multicast_config(fep, 1, 1);
+	mtip_port_multicast_config(fep, 2, 1);
+
+	/* Setup VLANs to provide port separation */
+	if (!fep->br_offload)
+		mtip_switch_en_port_separation(fep);
 }
 
 static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
@@ -592,6 +619,10 @@ static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
 
 	skb_tx_timestamp(skb);
 
+	/* For port separation - force sending via specified port */
+	if (!fep->br_offload && port != 0)
+		mtip_forced_forward(fep, port, 1);
+
 	dev->stats.tx_bytes += skb->len;
 	/* If this was the last BD in the ring,
 	 * start at the beginning again.
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
index 7fbad157ff83..72784df6c127 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -618,6 +618,29 @@ static inline int mtip_get_time(void)
 
 #define MTIP_PORT_FORWARDING_INIT 0xFF
 
+/* Switch Management functions */
+int mtip_vlan_input_process(struct switch_enet_private *fep,
+			    int port, int mode, unsigned short port_vlanid,
+			    int vlan_verify_en, int vlan_domain_num,
+			    int vlan_domain_port);
+int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
+			       int vlan_domain_verify_en,
+			       int vlan_discard_unknown_en);
+int mtip_port_multicast_config(struct switch_enet_private *fep, int port,
+			       bool enable);
+int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
+			     int mode);
+void mtip_switch_en_port_separation(struct switch_enet_private *fep);
+void mtip_switch_dis_port_separation(struct switch_enet_private *fep);
+int mtip_port_broadcast_config(struct switch_enet_private *fep,
+			       int port, bool enable);
+int mtip_forced_forward(struct switch_enet_private *fep, int port, bool enable);
+int mtip_port_learning_config(struct switch_enet_private *fep, int port,
+			      bool disable, bool irq_adj);
+int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
+			      bool enable);
 bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+int mtip_port_enable_config(struct switch_enet_private *fep, int port,
+			    bool tx_en, bool rx_en);
 void mtip_clear_atable(struct switch_enet_private *fep);
 #endif /* __MTIP_L2SWITCH_H_ */
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
new file mode 100644
index 000000000000..4c07861a6a3e
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - switch MGNT
+ *
+ *  Copyright (C) 2026 NABLADEV Software Engineering GmbH
+ *  Lukasz Majewski <lukma@nabladev.com>
+ *
+ *  Based on a previous work by:
+ *
+ *  Copyright 2010-2012 Freescale Semiconductor, Inc.
+ *  Alison Wang (b18965@freescale.com)
+ *  Jason Jin (Jason.jin@freescale.com)
+ *
+ *  Copyright (C) 2010-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Shrek Wu (B16972@freescale.com)
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+
+#include "mtipl2sw.h"
+
+int mtip_vlan_input_process(struct switch_enet_private *fep,
+			    int port, int mode, unsigned short port_vlanid,
+			    int vlan_verify_en, int vlan_domain_num,
+			    int vlan_domain_port)
+{
+	if (mode < 0 || mode > 3) {
+		dev_err(&fep->pdev->dev,
+			"%s: VLAN input processing mode (%d) not supported\n",
+			__func__, mode);
+		return -EINVAL;
+	}
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (vlan_verify_en == 1 &&
+	    (vlan_domain_num < 0 || vlan_domain_num > 32)) {
+		dev_err(&fep->pdev->dev, "%s: Domain out of range\n", __func__);
+		return -EINVAL;
+	}
+
+	writel(FIELD_PREP(MCF_ESW_PID_VLANID_MASK, port_vlanid),
+	       fep->hwp + ESW_PID(port));
+	if (port == 0) {
+		if (vlan_verify_en == 1)
+			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
+					  port_vlanid) | MCF_ESW_VRES_P0,
+			       fep->hwp + ESW_VRES(vlan_domain_num));
+
+		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN0,
+		       fep->hwp + ESW_VIMEN);
+		writel(readl(fep->hwp + ESW_VIMSEL) |
+		       FIELD_PREP(MCF_ESW_VIMSEL_IM0_MASK, mode),
+		       fep->hwp + ESW_VIMSEL);
+	} else if (port == 1) {
+		if (vlan_verify_en == 1)
+			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
+					  port_vlanid) | MCF_ESW_VRES_P1,
+			       fep->hwp + ESW_VRES(vlan_domain_num));
+
+		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN1,
+		       fep->hwp + ESW_VIMEN);
+		writel(readl(fep->hwp + ESW_VIMSEL) |
+		       FIELD_PREP(MCF_ESW_VIMSEL_IM1_MASK, mode),
+		       fep->hwp + ESW_VIMSEL);
+	} else if (port == 2) {
+		if (vlan_verify_en == 1)
+			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
+					  port_vlanid) | MCF_ESW_VRES_P2,
+			       fep->hwp + ESW_VRES(vlan_domain_num));
+
+		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN2,
+		       fep->hwp + ESW_VIMEN);
+		writel(readl(fep->hwp + ESW_VIMSEL) |
+		       FIELD_PREP(MCF_ESW_VIMSEL_IM2_MASK, mode),
+		       fep->hwp + ESW_VIMSEL);
+	}
+
+	return 0;
+}
+
+int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
+			     int mode)
+{
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (port == 0) {
+		writel(readl(fep->hwp + ESW_VOMSEL) |
+		       FIELD_PREP(MCF_ESW_VOMSEL_OM0_MASK, mode),
+		       fep->hwp + ESW_VOMSEL);
+	} else if (port == 1) {
+		writel(readl(fep->hwp + ESW_VOMSEL) |
+		       FIELD_PREP(MCF_ESW_VOMSEL_OM1_MASK, mode),
+		       fep->hwp + ESW_VOMSEL);
+	} else if (port == 2) {
+		writel(readl(fep->hwp + ESW_VOMSEL) |
+		       FIELD_PREP(MCF_ESW_VOMSEL_OM2_MASK, mode),
+		       fep->hwp + ESW_VOMSEL);
+	}
+
+	return 0;
+}
+
+int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
+			       int vlan_domain_verify_en,
+			       int vlan_discard_unknown_en)
+{
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (vlan_domain_verify_en == 1) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV2,
+			       fep->hwp + ESW_VLANV);
+	} else if (vlan_domain_verify_en == 0) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_VV0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_VV1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_VV2,
+			       fep->hwp + ESW_VLANV);
+	}
+
+	if (vlan_discard_unknown_en == 1) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_DU0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_DU1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_DU2,
+			       fep->hwp + ESW_VLANV);
+	} else if (vlan_discard_unknown_en == 0) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_DU0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_DU1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_DU2,
+			       fep->hwp + ESW_VLANV);
+	}
+
+	dev_dbg(&fep->pdev->dev, "%s: ESW_VLANV %#x\n", __func__,
+		readl(fep->hwp + ESW_VLANV));
+
+	return 0;
+}
+
+int mtip_port_multicast_config(struct switch_enet_private *fep,
+			       int port, bool enable)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_DMCR);
+	if (enable) {
+		if (port == 0)
+			reg |= MCF_ESW_DMCR_P0;
+		else if (port == 1)
+			reg |= MCF_ESW_DMCR_P1;
+		else if (port == 2)
+			reg |= MCF_ESW_DMCR_P2;
+	} else {
+		if (port == 0)
+			reg &= ~MCF_ESW_DMCR_P0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_DMCR_P1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_DMCR_P2;
+	}
+
+	writel(reg, fep->hwp + ESW_DMCR);
+	return 0;
+}
+
+/* enable or disable port n tx or rx
+ * tx_en 0 disable port n tx
+ * tx_en 1 enable  port n tx
+ * rx_en 0 disable port n rx
+ * rx_en 1 enable  port n rx
+ */
+int mtip_port_enable_config(struct switch_enet_private *fep, int port,
+			    bool tx_en, bool rx_en)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_PER);
+	if (tx_en) {
+		if (port == 0)
+			reg |= MCF_ESW_PER_TE0;
+		else if (port == 1)
+			reg |= MCF_ESW_PER_TE1;
+		else if (port == 2)
+			reg |= MCF_ESW_PER_TE2;
+	} else {
+		if (port == 0)
+			reg &= (~MCF_ESW_PER_TE0);
+		else if (port == 1)
+			reg &= (~MCF_ESW_PER_TE1);
+		else if (port == 2)
+			reg &= (~MCF_ESW_PER_TE2);
+	}
+
+	if (rx_en) {
+		if (port == 0)
+			reg |= MCF_ESW_PER_RE0;
+		else if (port == 1)
+			reg |= MCF_ESW_PER_RE1;
+		else if (port == 2)
+			reg |= MCF_ESW_PER_RE2;
+	} else {
+		if (port == 0)
+			reg &= (~MCF_ESW_PER_RE0);
+		else if (port == 1)
+			reg &= (~MCF_ESW_PER_RE1);
+		else if (port == 2)
+			reg &= (~MCF_ESW_PER_RE2);
+	}
+
+	writel(reg, fep->hwp + ESW_PER);
+	return 0;
+}
+
+void mtip_switch_en_port_separation(struct switch_enet_private *fep)
+{
+	u32 reg;
+
+	mtip_vlan_input_process(fep, 0, 3, 0x10, 1, 0, 0);
+	mtip_vlan_input_process(fep, 1, 3, 0x11, 1, 1, 0);
+	mtip_vlan_input_process(fep, 2, 3, 0x12, 1, 2, 0);
+
+	reg = readl(fep->hwp + ESW_VRES(0));
+	writel(reg | MCF_ESW_VRES_P1 | MCF_ESW_VRES_P2,
+	       fep->hwp + ESW_VRES(0));
+
+	reg = readl(fep->hwp + ESW_VRES(1));
+	writel(reg | MCF_ESW_VRES_P0, fep->hwp + ESW_VRES(1));
+
+	reg = readl(fep->hwp + ESW_VRES(2));
+	writel(reg | MCF_ESW_VRES_P0, fep->hwp + ESW_VRES(2));
+
+	dev_dbg(&fep->pdev->dev, "%s: VRES0: 0x%x\n",
+		__func__, readl(fep->hwp + ESW_VRES(0)));
+	dev_dbg(&fep->pdev->dev, "%s: VRES1: 0x%x\n", __func__,
+		readl(fep->hwp + ESW_VRES(1)));
+	dev_dbg(&fep->pdev->dev, "%s: VRES2: 0x%x\n", __func__,
+		readl(fep->hwp + ESW_VRES(2)));
+
+	mtip_set_vlan_verification(fep, 0, 1, 0);
+	mtip_set_vlan_verification(fep, 1, 1, 0);
+	mtip_set_vlan_verification(fep, 2, 1, 0);
+
+	mtip_vlan_output_process(fep, 0, 2);
+	mtip_vlan_output_process(fep, 1, 2);
+	mtip_vlan_output_process(fep, 2, 2);
+}
+
+void mtip_switch_dis_port_separation(struct switch_enet_private *fep)
+{
+	writel(0, fep->hwp + ESW_PID(0));
+	writel(0, fep->hwp + ESW_PID(1));
+	writel(0, fep->hwp + ESW_PID(2));
+
+	writel(0, fep->hwp + ESW_VRES(0));
+	writel(0, fep->hwp + ESW_VRES(1));
+	writel(0, fep->hwp + ESW_VRES(2));
+
+	writel(0, fep->hwp + ESW_VIMEN);
+	writel(0, fep->hwp + ESW_VIMSEL);
+	writel(0, fep->hwp + ESW_VLANV);
+	writel(0, fep->hwp + ESW_VOMSEL);
+}
+
+int mtip_port_broadcast_config(struct switch_enet_private *fep,
+			       int port, bool enable)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_DBCR);
+	if (enable) {
+		if (port == 0)
+			reg |= MCF_ESW_DBCR_P0;
+		else if (port == 1)
+			reg |= MCF_ESW_DBCR_P1;
+		else if (port == 2)
+			reg |= MCF_ESW_DBCR_P2;
+	} else {
+		if (port == 0)
+			reg &= ~MCF_ESW_DBCR_P0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_DBCR_P1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_DBCR_P2;
+	}
+
+	writel(reg, fep->hwp + ESW_DBCR);
+	return 0;
+}
+
+/* The frame is forwarded to the forced destination ports.
+ * It only replace the MAC lookup function,
+ * all other filtering(eg.VLAN verification) act as normal
+ */
+int mtip_forced_forward(struct switch_enet_private *fep, int port, bool enable)
+{
+	u32 reg = 0;
+
+	if (port & ~GENMASK(1, 0)) {
+		dev_err(&fep->pdev->dev,
+			"%s: Forced forward for port(s): 0x%x not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	/* Enable Forced forwarding for port(s) */
+	reg |= FIELD_PREP(MCF_ESW_P0FFEN_FD_MASK, port & GENMASK(1, 0));
+
+	if (enable)
+		reg |= MCF_ESW_P0FFEN_FEN;
+	else
+		reg &= ~MCF_ESW_P0FFEN_FEN;
+
+	writel(reg, fep->hwp + ESW_P0FFEN);
+	return 0;
+}
+
+int mtip_port_learning_config(struct switch_enet_private *fep, int port,
+			      bool disable, bool irq_adj)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_BKLR);
+	if (disable) {
+		if (irq_adj)
+			writel(readl(fep->hwp + ESW_IMR) & ~MCF_ESW_IMR_LRN,
+			       fep->hwp + ESW_IMR);
+
+		if (port == 0)
+			reg |= MCF_ESW_BKLR_LD0;
+		else if (port == 1)
+			reg |= MCF_ESW_BKLR_LD1;
+		else if (port == 2)
+			reg |= MCF_ESW_BKLR_LD2;
+	} else {
+		if (irq_adj)
+			writel(readl(fep->hwp + ESW_IMR) | MCF_ESW_IMR_LRN,
+			       fep->hwp + ESW_IMR);
+
+		if (port == 0)
+			reg &= ~MCF_ESW_BKLR_LD0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_BKLR_LD1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_BKLR_LD2;
+	}
+
+	writel(reg, fep->hwp + ESW_BKLR);
+	dev_dbg(&fep->pdev->dev, "%s ESW_BKLR %#x, ESW_IMR %#x\n", __func__,
+		readl(fep->hwp + ESW_BKLR), readl(fep->hwp + ESW_IMR));
+
+	return 0;
+}
+
+int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
+			      bool enable)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_BKLR);
+	if (enable) {
+		if (port == 0)
+			reg |= MCF_ESW_BKLR_BE0;
+		else if (port == 1)
+			reg |= MCF_ESW_BKLR_BE1;
+		else if (port == 2)
+			reg |= MCF_ESW_BKLR_BE2;
+	} else {
+		if (port == 0)
+			reg &= ~MCF_ESW_BKLR_BE0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_BKLR_BE1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_BKLR_BE2;
+	}
+
+	writel(reg, fep->hwp + ESW_BKLR);
+	return 0;
+}
-- 
2.39.5


