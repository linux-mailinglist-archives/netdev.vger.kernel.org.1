Return-Path: <netdev+bounces-256881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIrOBdPUg2kHuwMAu9opvQ
	(envelope-from <netdev+bounces-256881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:22:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45106ED39A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D55D3005335
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7539E199;
	Wed,  4 Feb 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CLyBU674";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uWHVmFiA"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4439B491;
	Wed,  4 Feb 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247366; cv=none; b=B49RQCXMjFAQTl5BRfBY+ncnDVVxeUux8Ar/UxEOtAeTHp0lDcA7jfw8AEouNl3u6ZLTRjb8QrUZ00+lIOXRZxEW16xsZOMpz7yum1Km6lRjbZl1+9wLz+Zt+csOzLTkan12ti+NwokZaAGTN6q04LA2mIhuPLw8AC6vKcqgmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247366; c=relaxed/simple;
	bh=fTOJdaUi5+ewQjL3NAbPqcKxujLEOrAdK4o4cCcUx4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOmIXHO9cdND0vEHS8+RksV1vHWaAO0d+oUphnVE+Jrgc2NXHtQt2f1+wsSG0/gtbxpidj+sO2JsFAqGtAzAKl+1QqY2RH06D7n/MH1e3fFZuk7LTmcEsgWQiqTdZy7zoeAAo3G9KxZA9s4yQoFiSHhnXG793IfSzoWMuTLUZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CLyBU674; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uWHVmFiA; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f5xGR3yHXz9t5H;
	Thu,  5 Feb 2026 00:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770247359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAiHySxMfaAtoILhLhenop1pdIVM9fDrQ2GwRqxyFRY=;
	b=CLyBU674jna2Yo3y2TBpTe+5KATrs4J3TaX5tM0WT+pZ+kaeO8PI8aM42aOvaF0QOoAVtd
	AlJiN3bSMZokN8l4NeTvKj3X1dg7npz7vtSajSEknDMtRaJa63ykGYc+QhBqikc8affp9t
	Ozsg2gWxmHpwmnF2oefrzXcLDfLiisGBB6T9tEmTQj68Mlg9Ob9GpKUEfqByWjVrBd7YSU
	9nekFEMfpk4o1W4OVYmwkrV+nMqa+ecyPXXeAiSLV3+NScMdULNwriCl/D3MXJKSsHAxWy
	cMnThp2/SGKOuxw3UIi0GPH/P9s/dz8J0OtH2BAkFtVcadHTgh8wUsR4CRhHmQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uWHVmFiA;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770247357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAiHySxMfaAtoILhLhenop1pdIVM9fDrQ2GwRqxyFRY=;
	b=uWHVmFiAVj9mjRR1nH+vbXX/Kndqa/KB7zt8uA1SpYImr4z4/ALaf7muJi18roV7s7i/MY
	AQPD5Am7dEy0XcCUVhcA4o3SdFtKVzJNHocc2BkUg1X1gpxcmZk5cok+an6SQADYxFPZNv
	j0Q/BUsUHkns0XqqyzWmvI8rJD3NfrSk5cZLlM11mBzzH2yZkX6eW5FZBpg2A5MpzIHAs7
	+Pm9Hqj0Qm2KG3xLKb2yIex45vm1PhEPvoXaC4BJkGbDtDmSsSLOlkSe5PexPhqu2d2IED
	cGd98T+S6nguBMSzVnlwUuJNkPaIQtiLYy+E9WVyla0QD8t5RTYajp6S0LaYGw==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v23 7/7] net: mtip: Extend the L2 switch driver for imx287 with bridge operations
Date: Thu,  5 Feb 2026 00:21:35 +0100
Message-Id: <20260204232135.1024665-8-lukasz.majewski@mailbox.org>
In-Reply-To: <20260204232135.1024665-1-lukasz.majewski@mailbox.org>
References: <20260204232135.1024665-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dc7wqe4y96qcnieyjczohb54d9skqjqg
X-MBO-RS-ID: 101e7750fe0bb44c897
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-256881-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailbox.org:email,mailbox.org:dkim,mailbox.org:mid,nabladev.com:email]
X-Rspamd-Queue-Id: 45106ED39A
X-Rspamd-Action: no action

After this change the MTIP L2 switch can be configured as offloading
device for packet switching when bridge on its interfaces is created.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---

Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14 - v15:
- None

Changes for v16:
- Enable MTIP ports to support bridge offloading

Changes for v17 - v20:
- None

Changes for v21:
- Avoid double call of notifier_from_errno() on -EOPNOTSUPP
- Rollback changes to driver state when switchdev_bridge_port_offload()
  fails

Changes for v22:
- Reorder setting of br_members and master_dev to successful call of
  switchdev_bridge_port_offload()

Changes for v23:
- Update copyright notice
- Clear the br_offload flag and enable switch port separation
---
 .../net/ethernet/freescale/mtipsw/Makefile    |   2 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  |   9 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |   2 +
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   | 138 ++++++++++++++++++
 4 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c

diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
index a99aaf6ddfb2..81e2b0e03e6c 100644
--- a/drivers/net/ethernet/freescale/mtipsw/Makefile
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_FEC_MTIP_L2SW) += nxp-mtipl2sw.o
-nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o
+nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o mtipl2sw_br.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 31e9ed1c2268..7c2023a33713 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -1947,11 +1947,15 @@ static int mtip_sw_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret, "Could not alloc IRQ\n");
 	}
 
+	ret = mtip_register_notifiers(fep);
+	if (ret)
+		goto of_free_references;
+
 	ret = mtip_switch_dma_init(fep);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: ethernet switch init fail (%d)!\n",
 			__func__, ret);
-		goto of_free_references;
+		goto unregister_notifiers;
 	}
 
 	ret = mtip_mii_init(fep, pdev);
@@ -1983,6 +1987,8 @@ static int mtip_sw_probe(struct platform_device *pdev)
 			  fep->bd_dma);
 	fep->rx_bd_base = NULL;
 	fep->tx_bd_base = NULL;
+ unregister_notifiers:
+	mtip_unregister_notifiers(fep);
  of_free_references:
 	mtip_parse_of_cleanup(fep);
 
@@ -1995,6 +2001,7 @@ static void mtip_sw_remove(struct platform_device *pdev)
 
 	timer_delete_sync(&fep->timer_mgnt);
 
+	mtip_unregister_notifiers(fep);
 	mtip_ndev_cleanup(fep);
 
 	mtip_parse_of_cleanup(fep);
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
index 72784df6c127..49d8454f7cd1 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -640,6 +640,8 @@ int mtip_port_learning_config(struct switch_enet_private *fep, int port,
 int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
 			      bool enable);
 bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+int mtip_register_notifiers(struct switch_enet_private *fep);
+void mtip_unregister_notifiers(struct switch_enet_private *fep);
 int mtip_port_enable_config(struct switch_enet_private *fep, int port,
 			    bool tx_en, bool rx_en);
 void mtip_clear_atable(struct switch_enet_private *fep);
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
new file mode 100644
index 000000000000..c9d9151b0e81
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - bridge network interface
+ *
+ *  Copyright (C) 2026 NABLADEV Software Engineering GmbH
+ *  Lukasz Majewski <lukma@nabladev.com>
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <net/switchdev.h>
+
+#include "mtipl2sw.h"
+
+static int mtip_ndev_port_link(struct net_device *ndev,
+			       struct net_device *br_ndev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
+	struct switch_enet_private *fep = priv->fep;
+	struct net_device *other_ndev;
+	int err;
+
+	/* Check if one port of MTIP switch is already bridged */
+	if (fep->br_members && !fep->br_offload) {
+		/* Get the second bridge ndev */
+		other_ndev = fep->ndev[fep->br_members - 1];
+		other_priv = netdev_priv(other_ndev);
+		if (other_priv->master_dev != br_ndev) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "L2 offloading only possible for the same bridge!");
+			return -EOPNOTSUPP;
+		}
+
+		fep->br_offload = 1;
+		mtip_switch_dis_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+
+	err = switchdev_bridge_port_offload(ndev, ndev, NULL, NULL, NULL,
+					    false, extack);
+	if (err) {
+		dev_err(&ndev->dev, "can't offload bridge port %s [err: %d]\n",
+			ndev->name, err);
+
+		if (fep->br_members && fep->br_offload) {
+			fep->br_offload = 0;
+			mtip_switch_en_port_separation(fep);
+		}
+
+		return err;
+	}
+
+	if (!priv->master_dev)
+		priv->master_dev = br_ndev;
+
+	fep->br_members |= BIT(priv->portnum - 1);
+
+	dev_dbg(&ndev->dev,
+		"%s: ndev: %s br: %s fep: %p members: 0x%x offload: %d\n",
+		__func__, ndev->name,  br_ndev->name, fep, fep->br_members,
+		fep->br_offload);
+
+	return NOTIFY_DONE;
+}
+
+static void mtip_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev);
+	struct switch_enet_private *fep = priv->fep;
+
+	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n", __func__,
+		ndev->name, fep->br_members);
+
+	switchdev_bridge_port_unoffload(ndev, NULL, NULL, NULL);
+
+	fep->br_members &= ~BIT(priv->portnum - 1);
+	priv->master_dev = NULL;
+
+	if (fep->br_members && fep->br_offload) {
+		fep->br_offload = 0;
+		mtip_switch_en_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+}
+
+/* netdev notifier */
+static int mtip_netdevice_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct netlink_ext_ack *extack;
+	int ret = NOTIFY_DONE;
+
+	if (!mtip_is_switch_netdev_port(ndev))
+		return NOTIFY_DONE;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		if (!netif_is_bridge_master(info->upper_dev))
+			break;
+
+		if (info->linking)
+			ret = mtip_ndev_port_link(ndev, info->upper_dev,
+						  extack);
+		else
+			mtip_netdevice_port_unlink(ndev);
+
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block mtip_netdevice_nb __read_mostly = {
+	.notifier_call = mtip_netdevice_event,
+};
+
+int mtip_register_notifiers(struct switch_enet_private *fep)
+{
+	int ret = register_netdevice_notifier(&mtip_netdevice_nb);
+
+	if (ret)
+		dev_err(&fep->pdev->dev, "can't register netdevice notifier\n");
+
+	return ret;
+}
+
+void mtip_unregister_notifiers(struct switch_enet_private *fep)
+{
+	unregister_netdevice_notifier(&mtip_netdevice_nb);
+}
-- 
2.39.5


