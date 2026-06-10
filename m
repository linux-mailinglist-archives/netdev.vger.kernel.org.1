Return-Path: <netdev+bounces-297616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tq2SI35BKWp7TAMAu9opvQ
	(envelope-from <netdev+bounces-297616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:50:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F142A66872E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:50:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Msfzxnst;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93B1930D9573
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA23FAE1D;
	Wed, 10 Jun 2026 10:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BD3F7884;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088101; cv=none; b=hEn9asPwV6ey2n1Ug1sN/qHUF36Fexk+vYjOUE+8+mUZjPLbFmH0mOlVT8q/5tKPnoZdHTfWf2AJdFnXyzXAQ7VKlU+MzzLYGk3NOqP6tCqulbFV9YEfaLg2b6eGg3ePDdoXhLW0nroLRHqLcWeeIMZ9r+tNKdDx+3ZhPM/M/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088101; c=relaxed/simple;
	bh=VT6qgK4mn/du9ZXrGgtdvRyh3fKqhB/ygg9sLwK3SHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QG+vB2tZCbFBvldP8tXfa1ZkVZowRhDqyxqW289UbvHertNa7alLL7MG9UYhO3SSPNEPPlxFPhHZNHRXEauS88dklOc7G2LyLPYva/rzCnbe4dXwoDIt13Sqm46kPCZB+Udz1p8KCK85i/Bd/hsqjAsmbA9Preqq4CfrX/6bSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msfzxnst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B2E1C4AF0E;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781088101;
	bh=VT6qgK4mn/du9ZXrGgtdvRyh3fKqhB/ygg9sLwK3SHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MsfzxnstLb5fMqYF6nN/cOS2WzF4LKVMgz1iNYMrr1p79ezNNyjKxka9/ZZnF86Ib
	 RGFHVP0toc3Ov8i+yjb9zcMQ8XpqP8z5hYQGJsOBmAfzMockSDwTZ0WxGB0Nvh4JXj
	 0LQmKBsKY+Xhvu/Hf8IUaA1S392YTF30Nu1GAfKfHhC6E9BwwnWqR5QayenMA953G0
	 z/6kHIzw+Owb3OmqFRPQ4x+OA2qeTMrYsOcQFsjY7q8c7rXZeJAL50AHT6dMjAscj7
	 75mWSSJLsbVyQe1aw/PTQrIHFWIjVJs/dFtnFZBAIv5FHVEYkDs0c0sxtTg55QD06q
	 iBY4RN2Ksr4og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27326CD8CB9;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Wed, 10 Jun 2026 18:41:05 +0800
Subject: [PATCH v2 2/7] net: wwan: t9xx: Add control plane transaction
 layer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-t9xx_driver_v1-v2-2-c65addf23b3f@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
In-Reply-To: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781088082; l=9013;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=/8JlCnQOCD1zznDNQhn1Ckv3gur6ScI6WuxfW1gOeII=;
 b=+nPy0oU37leFylf41M7G6lD16JO7lubCLp46x56h1DVlw/xs5bVTqHTNxPtcKbO19G5PriJXB
 WBT2BjaW97MDc0HnvHO+JiR3kJOJQkM+9rjuLOeNxn0wDaZrevCm2iO
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297616-lists,netdev=lfdr.de,jackbb_wu.compal.com];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jackbb_wu@compal.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,compal.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[jackbb_wu@compal.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,compal.com:replyto,compal.com:email,compal.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F142A66872E

From: Jack Wu <jackbb_wu@compal.com>

The control plane implements TX services that reside in the
transaction layer. The services receive the packets from the
port layer and call the corresponding DMA components to
transmit data to the device. Meanwhile, TX services receive
and manage the port control commands from the port layer.

The control plane implements RX services that reside in the
transaction layer. The services receive the downlink packets
from the modem and transfer the packets to the corresponding
port layer interfaces.

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 drivers/net/wwan/Kconfig                    |  5 +++
 drivers/net/wwan/t9xx/Makefile              |  5 +--
 drivers/net/wwan/t9xx/mtk_ctrl_plane.c      | 48 +++++++++++++++++++++++++++++
 drivers/net/wwan/t9xx/mtk_ctrl_plane.h      | 22 +++++++++++++
 drivers/net/wwan/t9xx/mtk_dev.c             | 44 ++++++++++++++++++++++++++
 drivers/net/wwan/t9xx/mtk_dev.h             |  5 +++
 drivers/net/wwan/t9xx/pcie/Makefile         | 10 ++++++
 drivers/net/wwan/t9xx/pcie/mtk_pci.c        | 10 +++---
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h | 21 +++++++++++++
 9 files changed, 163 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 4cee537c739f..7019b44494f8 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -124,6 +124,7 @@ config MTK_T7XX
 config MTK_T9XX
 	tristate "MediaTek PCIe 5G WWAN modem T9xx device"
 	depends on PCI
+	select MTK_T9XX_PCI
 	select NET_DEVLINK
 	help
 	  Enables MediaTek PCIe based 5G WWAN modem (T9xx series) device.
@@ -133,6 +134,10 @@ config MTK_T9XX
 
 	  If unsure, say N.
 
+config MTK_T9XX_PCI
+	tristate
+	depends on PCI
+
 endif # WWAN
 
 endmenu
diff --git a/drivers/net/wwan/t9xx/Makefile b/drivers/net/wwan/t9xx/Makefile
index 6f2dd3f91454..ae9d6f2344ab 100644
--- a/drivers/net/wwan/t9xx/Makefile
+++ b/drivers/net/wwan/t9xx/Makefile
@@ -4,7 +4,8 @@ ccflags-y += -I$(src)/pcie
 ccflags-y += -I$(src)
 
 obj-$(CONFIG_MTK_T9XX) += mtk_t9xx.o
+obj-$(CONFIG_MTK_T9XX_PCI) += pcie/
 
 mtk_t9xx-y := \
-	pcie/mtk_pci.o \
-	pcie/mtk_pci_drv_m9xx.o
+	mtk_dev.o \
+	mtk_ctrl_plane.o
diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
new file mode 100644
index 000000000000..07938f3e6fe2
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, MediaTek Inc.
+ * Copyright (c) 2022-2023, Intel Corporation.
+ */
+
+#include <linux/device.h>
+
+#include "mtk_ctrl_plane.h"
+
+/**
+ * mtk_ctrl_init() - Initialize the control plane block.
+ * @mdev: Pointer to the MTK modem device.
+ *
+ * Allocates and initializes the control plane block
+ * associated with @mdev.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int mtk_ctrl_init(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_blk *ctrl_blk;
+
+	ctrl_blk = devm_kzalloc(mdev->dev, sizeof(*ctrl_blk), GFP_KERNEL);
+	if (!ctrl_blk)
+		return -ENOMEM;
+
+	ctrl_blk->mdev = mdev;
+	mdev->ctrl_blk = ctrl_blk;
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_ctrl_init);
+
+/**
+ * mtk_ctrl_exit() - Clean up the control plane block.
+ * @mdev: Pointer to the MTK modem device.
+ *
+ * Frees the control plane block associated with @mdev.
+ */
+void mtk_ctrl_exit(struct mtk_md_dev *mdev)
+{
+	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
+
+	devm_kfree(mdev->dev, ctrl_blk);
+	mdev->ctrl_blk = NULL;
+}
+EXPORT_SYMBOL(mtk_ctrl_exit);
diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.h b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
new file mode 100644
index 000000000000..c141876ef95d
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#ifndef __MTK_CTRL_PLANE_H__
+#define __MTK_CTRL_PLANE_H__
+
+#include <linux/kref.h>
+#include <linux/skbuff.h>
+
+#include "mtk_dev.h"
+
+struct mtk_ctrl_blk {
+	struct mtk_md_dev *mdev;
+	struct mtk_ctrl_trans *trans;
+};
+
+int mtk_ctrl_init(struct mtk_md_dev *mdev);
+void mtk_ctrl_exit(struct mtk_md_dev *mdev);
+
+#endif /* __MTK_CTRL_PLANE_H__ */
diff --git a/drivers/net/wwan/t9xx/mtk_dev.c b/drivers/net/wwan/t9xx/mtk_dev.c
new file mode 100644
index 000000000000..f254ca7ed877
--- /dev/null
+++ b/drivers/net/wwan/t9xx/mtk_dev.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#include <linux/module.h>
+
+#include "mtk_dev.h"
+
+struct mtk_md_dev *mtk_dev_alloc(struct device *pdev, const struct mtk_dev_ops *dev_ops)
+{
+	struct mtk_md_dev *mdev;
+
+	mdev = devm_kzalloc(pdev, sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return NULL;
+
+	mdev->dev_ops = dev_ops;
+	mdev->dev = pdev;
+	return mdev;
+}
+EXPORT_SYMBOL(mtk_dev_alloc);
+
+void mtk_dev_free(struct mtk_md_dev *mdev)
+{
+	struct device *dev = mdev->dev;
+
+	devm_kfree(dev, mdev);
+}
+EXPORT_SYMBOL(mtk_dev_free);
+
+static int __init mtk_common_drv_init(void)
+{
+	return 0;
+}
+module_init(mtk_common_drv_init);
+
+static void __exit mtk_common_drv_exit(void)
+{
+}
+module_exit(mtk_common_drv_exit);
+
+MODULE_DESCRIPTION("MediaTek T9xx PCIe WWAN driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/wwan/t9xx/mtk_dev.h b/drivers/net/wwan/t9xx/mtk_dev.h
index 8278a0e2875e..bb3ea68890ea 100644
--- a/drivers/net/wwan/t9xx/mtk_dev.h
+++ b/drivers/net/wwan/t9xx/mtk_dev.h
@@ -36,6 +36,7 @@ enum mtk_dev_evt_d2h {
 };
 
 struct mtk_md_dev;
+struct mtk_ctrl_blk;
 
 struct mtk_dev_ops {
 	u32 (*get_dev_state)(struct mtk_md_dev *mdev);
@@ -57,6 +58,7 @@ struct mtk_md_dev {
 	void *hw_priv;
 	u32 hw_ver;
 	char dev_str[MTK_DEV_STR_LEN];
+	struct mtk_ctrl_blk *ctrl_blk;
 };
 
 static inline u32 mtk_dev_get_dev_state(struct mtk_md_dev *mdev)
@@ -105,4 +107,7 @@ static inline int mtk_dev_send_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt)
 	return mdev->dev_ops->send_dev_evt(mdev, dev_evt);
 }
 
+struct mtk_md_dev *mtk_dev_alloc(struct device *pdev, const struct mtk_dev_ops *dev_ops);
+void mtk_dev_free(struct mtk_md_dev *mdev);
+
 #endif /* __MTK_DEV_H__ */
diff --git a/drivers/net/wwan/t9xx/pcie/Makefile b/drivers/net/wwan/t9xx/pcie/Makefile
new file mode 100644
index 000000000000..7410d1796d27
--- /dev/null
+++ b/drivers/net/wwan/t9xx/pcie/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+ccflags-y += -I$(src)
+ccflags-y += -I$(src)/..
+
+obj-$(CONFIG_MTK_T9XX_PCI) += mtk_t9xx_pcie.o
+
+mtk_t9xx_pcie-y := \
+	mtk_pci_drv_m9xx.o \
+	mtk_pci.o
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
index 616bf5f31b6c..9f71685ea96c 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_pci.c
+++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 
 #include "mtk_dev.h"
+#include "mtk_trans_ctrl.h"
 #include "mtk_pci.h"
 #include "mtk_pci_reg.h"
 
@@ -469,6 +470,7 @@ static u32 mtk_pci_ext_h2d_evt_hw_bits(u32 chs)
 
 	SET_HW_BITS(hw_bits, chs, MHCCIF_RC2EP_EVT_DEVICE_RESET,
 		    DEV_EVT_H2D_DEVICE_RESET);
+
 	return LE32_TO_U32(cpu_to_le32(hw_bits));
 }
 
@@ -915,13 +917,11 @@ static int mtk_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct mtk_md_dev *mdev;
 	int ret;
 
-	mdev = devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
+	mdev = mtk_dev_alloc(dev, &pci_hw_ops);
 	if (!mdev) {
 		ret = -ENOMEM;
 		goto log_err;
 	}
-	mdev->dev_ops = &pci_hw_ops;
-	mdev->dev = dev;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -1002,7 +1002,7 @@ static int mtk_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 free_priv_data:
 	devm_kfree(dev, priv);
 free_cntx_data:
-	devm_kfree(dev, mdev);
+	mtk_dev_free(mdev);
 log_err:
 	dev_err(dev, "Failed to probe device, ret=%d\n", ret);
 
@@ -1030,7 +1030,7 @@ static void mtk_pci_remove(struct pci_dev *pdev)
 	pci_load_and_free_saved_state(pdev, &priv->saved_state);
 
 	devm_kfree(dev, priv);
-	devm_kfree(dev, mdev);
+	mtk_dev_free(mdev);
 }
 
 static pci_ers_result_t mtk_pci_error_detected(struct pci_dev *pdev,
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
new file mode 100644
index 000000000000..d6de4c43b529
--- /dev/null
+++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2022, MediaTek Inc.
+ */
+
+#ifndef __MTK_TRANS_CTRL_H__
+#define __MTK_TRANS_CTRL_H__
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "mtk_dev.h"
+
+struct mtk_ctrl_trans {
+	struct mtk_ctrl_blk *ctrl_blk;
+	struct mtk_md_dev *mdev;
+};
+
+#endif

-- 
2.34.1



