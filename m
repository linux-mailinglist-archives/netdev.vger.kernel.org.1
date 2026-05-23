Return-Path: <netdev+bounces-291080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAqqOVt5EWrymQYAu9opvQ
	(envelope-from <netdev+bounces-291080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:54:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288FF5BE639
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2771E30162BA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D83E38422D;
	Sat, 23 May 2026 09:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF0346AD6;
	Sat, 23 May 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529779; cv=none; b=rkUXehn4qmlfBbP+7dDSdu3IAhhxEmE3du3OKJqKdG3f4qnxwOwjk5y3IqMFed1tABMos7im8h38JvQnLYta7M5P9D+0YZp09McOhWXcFdWnTYmqQP1J76qC5oC1Zdl+Mzt8PfIEeL9Xex7InB3+h8CmV/6AM56jK+gdUHq/2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529779; c=relaxed/simple;
	bh=7mK/Tcgrq0a2/KKSItHnUHEV83LyzhWDHGjjqhhLRtw=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=fvtD9YA+fr+0mETSgKi5GsNeNTqyVrlVSAWNsPVo0RQ3Cu36AhuQztl1drVNI/QyySRcaeIA5R8kse/9XfXPeLvqMRTKxoQT8PLrkhPCfyzX9gu5OuRIv4M8c/U+pCoFf/UCGuR3F9ohIcUXeY94Xok4dnHuazgf4/kFxNkBLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gMy6F6XNFz51Srq;
	Sat, 23 May 2026 17:49:25 +0800 (CST)
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl1.zte.com.cn with SMTP id 64N9nLtX087700;
	Sat, 23 May 2026 17:49:21 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Sat, 23 May 2026 17:49:24 +0800 (CST)
X-Zmail-TransId: 2afe6a1178242e6-e9392
X-Mailer: Zmail v1.0
Message-ID: <20260523174924524-pD70cw6PRL8mMtwjhGyz@zte.com.cn>
Date: Sat, 23 May 2026 17:49:24 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY0IDIvMl0gbmV0L2V0aGVybmV0L3p0ZS9kaW5naGFpOiBhZGQgaGFyZHdhcmXCoHJlZ2lzdGVyIGFjY2VzcyBhbmQgUENJIGNhcGFiaWxpdHkgc2Nhbm5pbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64N9nLtX087700
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 23 May 2026 17:49:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A117825.001/4gMy6F6XNFz51Srq
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NO_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.813];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291080-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 288FF5BE639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Junyang Han <han.junyang@zte.com.cn>

Implement PCI configuration space access, BAR mapping, capability
scanning (common/notify/device), and hardware queue register
definitions for DingHai PF device.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 drivers/net/ethernet/zte/dinghai/dh_queue.h |  71 ++++
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 440 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    |  66 +++
 3 files changed, 577 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h

diff --git a/drivers/net/ethernet/zte/dinghai/dh_queue.h b/drivers/net/ethernet/zte/dinghai/dh_queue.h
new file mode 100644
index 000000000000..5067c73fed33
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/dh_queue.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - PCI capability definitions
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __DH_QUEUE_H__
+#define __DH_QUEUE_H__
+
+/* Vector value used to disable MSI for queue */
+#define ZXDH_MSI_NO_VECTOR      0xff
+
+/* Status byte for guest to report progress, and synchronize features */
+/* We have seen device and processed generic fields */
+#define ZXDH_CONFIG_S_ACKNOWLEDGE 1
+/* We have found a driver for the device. */
+#define ZXDH_CONFIG_S_DRIVER      2
+/* Driver has used its parts of the config, and is happy */
+#define ZXDH_CONFIG_S_DRIVER_OK   4
+/* Driver has finished configuring features */
+#define ZXDH_CONFIG_S_FEATURES_OK 8
+/* Device entered invalid state, driver must reset it */
+#define ZXDH_CONFIG_S_NEEDS_RESET 0x40
+/* We've given up on this device */
+#define ZXDH_CONFIG_S_FAILED      0x80
+
+/* This is the PCI capability header: */
+struct zxdh_pf_pci_cap {
+	__u8 cap_vndr;		/* Generic PCI field: PCI_CAP_ID_VNDR */
+	__u8 cap_next;		/* Generic PCI field: next ptr. */
+	__u8 cap_len;		/* Generic PCI field: capability length */
+	__u8 cfg_type;		/* Identifies the structure. */
+	__u8 bar;		/* Where to find it. */
+	__u8 id;		/* Multiple capabilities of the same type */
+	__u8 padding[2];		/* Pad to full dword. */
+	__le32 offset;		/* Offset within bar. */
+	__le32 length;		/* Length of the structure, in bytes. */
+};
+
+/* Fields in ZXDH_PF_PCI_CAP_COMMON_CFG: */
+struct zxdh_pf_pci_common_cfg {
+	/* About the whole device. */
+	__le32 device_feature_select; /* read-write */
+	__le32 device_feature;	/* read-only */
+	__le32 guest_feature_select; /* read-write */
+	__le32 guest_feature;		/* read-write */
+	__le16 msix_config;		/* read-write */
+	__le16 num_queues;		/* read-only */
+	__u8 device_status;		/* read-write */
+	__u8 config_generation;	/* read-only */
+
+	/* About a specific virtqueue. */
+	__le16 queue_select;		/* read-write */
+	__le16 queue_size;		/* read-write, power of 2. */
+	__le16 queue_msix_vector;	/* read-write */
+	__le16 queue_enable;		/* read-write */
+	__le16 queue_notify_off;	/* read-only */
+	__le32 queue_desc_lo;		/* read-write */
+	__le32 queue_desc_hi;		/* read-write */
+	__le32 queue_avail_lo;		/* read-write */
+	__le32 queue_avail_hi;		/* read-write */
+	__le32 queue_used_lo;		/* read-write */
+	__le32 queue_used_hi;		/* read-write */
+};
+
+struct zxdh_pf_pci_notify_cap {
+	struct zxdh_pf_pci_cap cap;
+	__le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
+};
+
+#endif /* __DH_QUEUE_H__ */
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
index e64be25b007e..5332cab63acf 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.c
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -9,6 +9,7 @@
 #include <net/devlink.h>
 #include <linux/dma-mapping.h>
 #include "en_pf.h"
+#include "dh_queue.h"

 MODULE_AUTHOR("Junyang Han <han.junyang@zte.com.cn>");
 MODULE_DESCRIPTION("ZTE DingHai series Ethernet driver");
@@ -92,6 +93,445 @@ void dh_pf_pci_close(struct dh_core_dev *dev)
 	pci_disable_device(dev->pdev);
 }

+int zxdh_pf_pci_find_capability(struct pci_dev *pdev, u8 cfg_type,
+				u32 ioresource_types, int *bars)
+{
+	int pos;
+	u8 type;
+	u8 bar;
+
+	for (pos = pci_find_capability(pdev, PCI_CAP_ID_VNDR); pos > 0;
+	     pos = pci_find_next_capability(pdev, pos, PCI_CAP_ID_VNDR)) {
+		pci_read_config_byte(pdev,
+				     pos + offsetof(struct zxdh_pf_pci_cap,
+							cfg_type), &type);
+		pci_read_config_byte(pdev,
+				     pos + offsetof(struct zxdh_pf_pci_cap, bar), &bar);
+
+		/* ignore structures with reserved BAR values */
+		if (bar > ZXDH_PF_MAX_BAR_VAL)
+			continue;
+
+		if (type == cfg_type) {
+			if (pci_resource_len(pdev, bar) &&
+			    pci_resource_flags(pdev, bar) & ioresource_types) {
+				*bars |= (1 << bar);
+				return pos;
+			}
+		}
+	}
+
+	return 0;
+}
+
+void __iomem *zxdh_pf_map_capability(struct dh_core_dev *dh_dev, int off,
+				     size_t minlen, u32 align,
+				     u32 start, u32 size,
+				     size_t *len, resource_size_t *pa,
+				     u32 *bar_off)
+{
+	struct pci_dev *pdev = dh_dev->pdev;
+	void __iomem *p;
+	u32 offset;
+	u32 length;
+	u8 bar;
+
+	pci_read_config_byte(pdev,
+			     off + offsetof(struct zxdh_pf_pci_cap, bar), &bar);
+	pci_read_config_dword(pdev,
+			      off + offsetof(struct zxdh_pf_pci_cap,
+						offset), &offset);
+	pci_read_config_dword(pdev,
+			      off + offsetof(struct zxdh_pf_pci_cap,
+						length), &length);
+
+	if (bar_off)
+		*bar_off = offset;
+
+	if (length <= start) {
+		dev_err(dh_dev->device, "bad capability len %u (>%u expected)\n",
+			length, start);
+		return NULL;
+	}
+
+	if (length - start < minlen) {
+		dev_err(dh_dev->device, "bad capability len %u (>=%zu expected)\n",
+			length, minlen);
+		return NULL;
+	}
+
+	length -= start;
+	if (start + offset < offset) {
+		dev_err(dh_dev->device, "map wrap-around %u+%u\n", start, offset);
+		return NULL;
+	}
+
+	offset += start;
+	if (offset & (align - 1)) {
+		dev_err(dh_dev->device, "offset %u not aligned to %u\n", offset, align);
+		return NULL;
+	}
+
+	if (length > size)
+		length = size;
+
+	if (len)
+		*len = length;
+
+	if (minlen + offset < minlen ||
+	    minlen + offset > pci_resource_len(pdev, bar)) {
+		dev_err(dh_dev->device,
+			"map custom queue %zu@%u out of range on bar %i length %lu\n",
+			minlen, offset, bar,
+			(unsigned long)pci_resource_len(pdev, bar));
+		return NULL;
+	}
+
+	p = pci_iomap_range(pdev, bar, offset, length);
+	if (!p) {
+		dev_err(dh_dev->device, "unable to map custom queue %u@%u on bar %i\n",
+			length, offset, bar);
+	} else if (pa) {
+		*pa = pci_resource_start(pdev, bar) + offset;
+	}
+
+	return p;
+}
+
+int zxdh_pf_common_cfg_init(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	struct pci_dev *pdev = dh_dev->pdev;
+	int common;
+
+	/* check for a common config: if not, use legacy mode (bar 0). */
+	common = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_COMMON_CFG,
+					     IORESOURCE_IO | IORESOURCE_MEM,
+					     &pf_dev->modern_bars);
+	if (common == 0) {
+		dev_err(dh_dev->device,
+			"missing capabilities %i, leaving for legacy driver\n",
+			common);
+		return -ENODEV;
+	}
+
+	pf_dev->common = zxdh_pf_map_capability(dh_dev, common,
+						sizeof(struct zxdh_pf_pci_common_cfg),
+						ZXDH_PF_ALIGN4, 0,
+						sizeof(struct zxdh_pf_pci_common_cfg),
+						NULL, NULL, NULL);
+	if (!pf_dev->common) {
+		dev_err(dh_dev->device, "pf_dev->common is null\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int zxdh_pf_notify_cfg_init(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	struct pci_dev *pdev = dh_dev->pdev;
+	u32 notify_length;
+	u32 notify_offset;
+	int notify;
+
+	/* If common is there, these should be too... */
+	notify = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_NOTIFY_CFG,
+					     IORESOURCE_IO | IORESOURCE_MEM,
+					     &pf_dev->modern_bars);
+	if (notify == 0) {
+		dev_err(dh_dev->device, "missing capabilities %i\n", notify);
+		return -EINVAL;
+	}
+
+	pci_read_config_dword(pdev,
+			      notify + offsetof(struct zxdh_pf_pci_notify_cap,
+				notify_off_multiplier),
+		&pf_dev->notify_offset_multiplier);
+	pci_read_config_dword(pdev,
+			      notify + offsetof(struct zxdh_pf_pci_notify_cap,
+				cap.length), &notify_length);
+	pci_read_config_dword(pdev,
+			      notify + offsetof(struct zxdh_pf_pci_notify_cap,
+				cap.offset), &notify_offset);
+
+	/* We don't know how many VQs we'll map, ahead of the time.
+	 * If notify length is small, map it all now. Otherwise,
+	 * map each VQ individually later.
+	 */
+	if (notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
+		pf_dev->notify_base = zxdh_pf_map_capability(dh_dev, notify,
+							     ZXDH_PF_MAP_MINLEN2,
+							    ZXDH_PF_ALIGN2, 0,
+							    notify_length,
+							    &pf_dev->notify_len,
+							    &pf_dev->notify_pa, NULL);
+		if (!pf_dev->notify_base) {
+			dev_err(dh_dev->device, "pf_dev->notify_base is null\n");
+			return -EINVAL;
+		}
+	} else {
+		pf_dev->notify_map_cap = notify;
+	}
+
+	return 0;
+}
+
+int zxdh_pf_device_cfg_init(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	struct pci_dev *pdev = dh_dev->pdev;
+	int device;
+
+	/* Device capability is only mandatory for
+	 * devices that have device-specific configuration.
+	 */
+	device = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_DEVICE_CFG,
+					     IORESOURCE_IO | IORESOURCE_MEM,
+					     &pf_dev->modern_bars);
+
+	/* we don't know how much we should map,
+	 * but PAGE_SIZE is more than enough for all existing devices.
+	 */
+	if (device) {
+		pf_dev->device = zxdh_pf_map_capability(dh_dev, device, 0,
+							ZXDH_PF_ALIGN4, 0, PAGE_SIZE,
+						       &pf_dev->device_len, NULL,
+						       &pf_dev->dev_cfg_bar_off);
+		if (!pf_dev->device) {
+			dev_err(dh_dev->device, "pf_dev->device is null\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+void zxdh_pf_modern_cfg_uninit(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	struct pci_dev *pdev = dh_dev->pdev;
+
+	if (pf_dev->device)
+		pci_iounmap(pdev, pf_dev->device);
+	if (pf_dev->notify_base)
+		pci_iounmap(pdev, pf_dev->notify_base);
+	pci_iounmap(pdev, pf_dev->common);
+}
+
+int zxdh_pf_modern_cfg_init(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	struct pci_dev *pdev = dh_dev->pdev;
+	int ret;
+
+	ret = zxdh_pf_common_cfg_init(dh_dev);
+	if (ret) {
+		dev_err(dh_dev->device, "zxdh_pf_common_cfg_init failed: %d\n", ret);
+		return -EINVAL;
+	}
+
+	ret = zxdh_pf_notify_cfg_init(dh_dev);
+	if (ret) {
+		dev_err(dh_dev->device, "zxdh_pf_notify_cfg_init failed: %d\n", ret);
+		goto err_map_notify;
+	}
+
+	ret = zxdh_pf_device_cfg_init(dh_dev);
+	if (ret) {
+		dev_err(dh_dev->device, "zxdh_pf_device_cfg_init failed: %d\n", ret);
+		goto err_map_device;
+	}
+
+	return 0;
+
+err_map_device:
+	if (pf_dev->notify_base)
+		pci_iounmap(pdev, pf_dev->notify_base);
+err_map_notify:
+	pci_iounmap(pdev, pf_dev->common);
+	return -EINVAL;
+}
+
+u16 zxdh_pf_get_queue_notify_off(struct dh_core_dev *dh_dev,
+				 u16 phy_index, u16 index)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	if (pf_dev->packed_status)
+		iowrite16(phy_index, &pf_dev->common->queue_select);
+	else
+		iowrite16(index, &pf_dev->common->queue_select);
+
+	return ioread16(&pf_dev->common->queue_notify_off);
+}
+
+void __iomem *zxdh_pf_map_vq_notify(struct dh_core_dev *dh_dev,
+				    u16 phy_index, u16 index,
+				     resource_size_t *pa)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	u16 off;
+
+	off = zxdh_pf_get_queue_notify_off(dh_dev, phy_index, index);
+
+	if (pf_dev->notify_base) {
+		/* offset should not wrap */
+		if ((u64)off *
+			pf_dev->notify_offset_multiplier + 2 > pf_dev->notify_len) {
+			dev_err(dh_dev->device,
+				"bad notification offset %u (x %u) for queue %u > %zd",
+				off, pf_dev->notify_offset_multiplier, phy_index,
+				pf_dev->notify_len);
+			return NULL;
+		}
+
+		if (pa)
+			*pa = pf_dev->notify_pa + off * pf_dev->notify_offset_multiplier;
+
+		return pf_dev->notify_base + off * pf_dev->notify_offset_multiplier;
+	} else {
+		return zxdh_pf_map_capability(dh_dev, pf_dev->notify_map_cap, 2, 2,
+					      off * pf_dev->notify_offset_multiplier,
+					      2, NULL, pa, NULL);
+	}
+}
+
+void zxdh_pf_unmap_vq_notify(struct dh_core_dev *dh_dev, void *priv)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	if (!pf_dev->notify_base)
+		pci_iounmap(dh_dev->pdev, priv);
+}
+
+void zxdh_pf_set_status(struct dh_core_dev *dh_dev, u8 status)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	iowrite8(status, &pf_dev->common->device_status);
+}
+
+u8 zxdh_pf_get_status(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	return ioread8(&pf_dev->common->device_status);
+}
+
+u8 zxdh_pf_get_cfg_gen(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	u8 config_generation;
+
+	config_generation = ioread8(&pf_dev->common->config_generation);
+	dev_info(dh_dev->device, "config_generation is %d\n", config_generation);
+
+	return config_generation;
+}
+
+void zxdh_pf_get_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	u32 DEV_MAC_L;
+	u16 DEV_MAC_H;
+
+	if (pf_dev->pf_sriov_cap_base) {
+		DEV_MAC_L = ioread32(pf_dev->pf_sriov_cap_base +
+				     (pf_dev->sriov_bar_size) * vf_id +
+				     pf_dev->dev_cfg_bar_off);
+		mac[0] = DEV_MAC_L & 0xff;
+		mac[1] = (DEV_MAC_L >> 8) & 0xff;
+		mac[2] = (DEV_MAC_L >> 16) & 0xff;
+		mac[3] = (DEV_MAC_L >> 24) & 0xff;
+		DEV_MAC_H = ioread16(pf_dev->pf_sriov_cap_base +
+				      (pf_dev->sriov_bar_size) * vf_id +
+				      pf_dev->dev_cfg_bar_off +
+				      ZXDH_DEV_MAC_HIGH_OFFSET);
+		mac[4] = DEV_MAC_H & 0xff;
+		mac[5] = (DEV_MAC_H >> 8) & 0xff;
+	}
+}
+
+void zxdh_pf_set_vf_mac_reg(struct zxdh_pf_device *pf_dev,
+			    u8 *mac, int vf_id)
+{
+	u32 DEV_MAC_L;
+	u16 DEV_MAC_H;
+
+	if (pf_dev->pf_sriov_cap_base) {
+		DEV_MAC_L = mac[0] | (mac[1] << 8) |
+					(mac[2] << 16) | (mac[3] << 24);
+		DEV_MAC_H = mac[4] | (mac[5] << 8);
+		iowrite32(DEV_MAC_L, (pf_dev->pf_sriov_cap_base +
+			  (pf_dev->sriov_bar_size) * vf_id +
+			  pf_dev->dev_cfg_bar_off));
+		iowrite16(DEV_MAC_H, (pf_dev->pf_sriov_cap_base +
+			  (pf_dev->sriov_bar_size) * vf_id +
+			  pf_dev->dev_cfg_bar_off +
+			  ZXDH_DEV_MAC_HIGH_OFFSET));
+	}
+}
+
+void zxdh_pf_set_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	zxdh_pf_set_vf_mac_reg(pf_dev, mac, vf_id);
+}
+
+void zxdh_set_mac(struct dh_core_dev *dh_dev, u8 *mac)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	u32 DEV_MAC_L;
+	u16 DEV_MAC_H;
+
+	DEV_MAC_L = mac[0] | (mac[1] << 8) | (mac[2] << 16) | (mac[3] << 24);
+	DEV_MAC_H = mac[4] | (mac[5] << 8);
+	iowrite32(DEV_MAC_L, pf_dev->device);
+	iowrite16(DEV_MAC_H, pf_dev->device + ZXDH_DEV_MAC_HIGH_OFFSET);
+}
+
+void zxdh_get_mac(struct dh_core_dev *dh_dev, u8 *mac)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	u32 DEV_MAC_L;
+	u16 DEV_MAC_H;
+
+	DEV_MAC_L = ioread32(pf_dev->device);
+	mac[0] = DEV_MAC_L & 0xff;
+	mac[1] = (DEV_MAC_L >> 8) & 0xff;
+	mac[2] = (DEV_MAC_L >> 16) & 0xff;
+	mac[3] = (DEV_MAC_L >> 24) & 0xff;
+	DEV_MAC_H = ioread16(pf_dev->device + ZXDH_DEV_MAC_HIGH_OFFSET);
+	mac[4] = DEV_MAC_H & 0xff;
+	mac[5] = (DEV_MAC_H >> 8) & 0xff;
+}
+
+u64 zxdh_pf_get_features(struct dh_core_dev *dh_dev)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+	u64 device_feature;
+
+	iowrite32(0, &pf_dev->common->device_feature_select);
+	device_feature = ioread32(&pf_dev->common->device_feature);
+	iowrite32(1, &pf_dev->common->device_feature_select);
+	device_feature |= ((u64)ioread32(&pf_dev->common->device_feature)
+						<< 32);
+
+	return device_feature;
+}
+
+void zxdh_pf_set_features(struct dh_core_dev *dh_dev, u64 features)
+{
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	iowrite32(0, &pf_dev->common->guest_feature_select);
+	iowrite32((u32)features, &pf_dev->common->guest_feature);
+	iowrite32(1, &pf_dev->common->guest_feature_select);
+	iowrite32(features >> 32, &pf_dev->common->guest_feature);
+}
+
 static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct zxdh_pf_device *pf_dev;
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
index de46e8b275ca..50d904444a64 100644
--- a/drivers/net/ethernet/zte/dinghai/en_pf.h
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -17,6 +17,24 @@
 #define ZXDH_PF_DEVICE_ID	0x8040
 #define ZXDH_VF_DEVICE_ID	0x8041

+/* Common configuration */
+#define ZXDH_PCI_CAP_COMMON_CFG	1
+/* Notifications */
+#define ZXDH_PCI_CAP_NOTIFY_CFG	2
+/* ISR access */
+#define ZXDH_PCI_CAP_ISR_CFG		3
+/* Device specific configuration */
+#define ZXDH_PCI_CAP_DEVICE_CFG	4
+/* PCI configuration access */
+#define ZXDH_PCI_CAP_PCI_CFG		5
+
+#define ZXDH_PF_MAX_BAR_VAL		0x5
+#define ZXDH_PF_ALIGN4			4
+#define ZXDH_PF_ALIGN2			2
+#define ZXDH_PF_MAP_MINLEN2		2
+
+#define ZXDH_DEV_MAC_HIGH_OFFSET	4
+
 enum dh_coredev_type {
 	DH_COREDEV_PF,
 	DH_COREDEV_VF,
@@ -36,7 +54,26 @@ struct dh_core_dev {
 };

 struct zxdh_pf_device {
+	struct zxdh_pf_pci_common_cfg __iomem *common;
+	/* Device-specific data (non-legacy mode)  */
+	/* Base of vq notifications (non-legacy mode). */
+	void __iomem *device;
+	void __iomem *notify_base;
+	void __iomem *pf_sriov_cap_base;
+	/* Physical base of vq notifications */
+	resource_size_t notify_pa;
+	/* So we can sanity-check accesses. */
+	size_t notify_len;
+	size_t device_len;
+	/* Capability for when we need to map notifications per-vq. */
+	s32 notify_map_cap;
+	u32 notify_offset_multiplier;
+	/* Multiply queue_notify_off by this value. (non-legacy mode). */
+	s32 modern_bars;
 	void __iomem *pci_ioremap_addr[6];
+	u64 sriov_bar_size;
+	u32 dev_cfg_bar_off;
+	bool packed_status;
 	bool bar_chan_valid;
 	bool vepa;
 	struct mutex irq_lock; /* Protects IRQ operations */
@@ -62,5 +99,34 @@ static inline void dh_core_free_priv(struct dh_core_dev *dh_dev)
 	((pdev)->device == ZXDH_VF_DEVICE_ID ? DH_COREDEV_VF : DH_COREDEV_PF)

 void dh_pf_pci_close(struct dh_core_dev *dev);
+int zxdh_pf_pci_find_capability(struct pci_dev *pdev, u8 cfg_type,
+				u32 ioresource_types, int *bars);
+void __iomem *zxdh_pf_map_capability(struct dh_core_dev *dh_dev, int off,
+				     size_t minlen, u32 align,
+				     u32 start, u32 size,
+				     size_t *len, resource_size_t *pa,
+				     u32 *bar_off);
+int zxdh_pf_common_cfg_init(struct dh_core_dev *dh_dev);
+int zxdh_pf_notify_cfg_init(struct dh_core_dev *dh_dev);
+int zxdh_pf_device_cfg_init(struct dh_core_dev *dh_dev);
+void zxdh_pf_modern_cfg_uninit(struct dh_core_dev *dh_dev);
+int zxdh_pf_modern_cfg_init(struct dh_core_dev *dh_dev);
+u16 zxdh_pf_get_queue_notify_off(struct dh_core_dev *dh_dev,
+				 u16 phy_index, u16 index);
+void __iomem *zxdh_pf_map_vq_notify(struct dh_core_dev *dh_dev,
+				    u16 phy_index, u16 index,
+				     resource_size_t *pa);
+void zxdh_pf_unmap_vq_notify(struct dh_core_dev *dh_dev, void *priv);
+void zxdh_pf_set_status(struct dh_core_dev *dh_dev, u8 status);
+u8 zxdh_pf_get_status(struct dh_core_dev *dh_dev);
+u8 zxdh_pf_get_cfg_gen(struct dh_core_dev *dh_dev);
+void zxdh_pf_get_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id);
+void zxdh_pf_set_vf_mac_reg(struct zxdh_pf_device *pf_dev,
+			    u8 *mac, int vf_id);
+void zxdh_pf_set_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id);
+void zxdh_set_mac(struct dh_core_dev *dh_dev, u8 *mac);
+void zxdh_get_mac(struct dh_core_dev *dh_dev, u8 *mac);
+u64 zxdh_pf_get_features(struct dh_core_dev *dh_dev);
+void zxdh_pf_set_features(struct dh_core_dev *dh_dev, u64 features);

 #endif /* __ZXDH_EN_PF_H__ */
-- 
2.27.0

