Return-Path: <netdev+bounces-150052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFC9E8BEA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB68E280DC1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56037214A6B;
	Mon,  9 Dec 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="O8sduOiw"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-19.ptr.blmpb.com (lf-2-19.ptr.blmpb.com [101.36.218.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0E1547E3
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728369; cv=none; b=j4RvxqrbW8fMeaXzY5Zt/gYXfb9oELAQVhUNx3Z1hkbDDBuJFmnYwbCVTHsMzAXR7xAc3Andafl0K8N9eGcEGah++FhgUQuWobiUT50+BUBrfe7WXNmeFBGjJb3x+rLg/nZ7smuLRujCx2II+4e0OTs7cDRFYbJwtYYN71eGLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728369; c=relaxed/simple;
	bh=qCqXIoMbGa1yoJ1r6zbj2Cct2Qt/sLlv+kCo/N5LDW8=;
	h=Mime-Version:Content-Type:From:Date:To:Message-Id:Cc:Subject; b=QLeTK8vls2fmNKBNO3I8jUgfRRWIgtHLxFPC8Q0as7rtneVZlWUVsG8rGxYAaAaHM05d7QoIlFcRFAQqQI0jEvhlAAsmn2hL/Qtzg4mVPfp7Cw4k5okCCS3zS1tq4q/eJGqHLN3QbCR68JS48n/kBGhfEyhT6/uC+HuKxMVrXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=O8sduOiw; arc=none smtp.client-ip=101.36.218.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728291; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xhSXleEo2hQGYCuw4TJATFhU6pBxqBBwL67gBYnxJag=;
 b=O8sduOiwidAmpcd3/kjLTED4lpB4VIrSQv+vjaFUaQ4o/E/bvIKFCuhm4BRlun+71V04Bg
 LsRxKsijkgPXJqfDdOZW6n/3Sria/a50qEf3+v4lryYfrb83dT+OkEzqu9ox/43J6b2E9v
 S2M9kIuhhKh/IFLNfqGa78VG1u7M2bSSr5KJBk+d0tVLNL7ecNX0iGeidJTKXHoVuyq8QO
 kAzyjhIDZTo4WkViL46DQT2h2IQs40DXt4125Oiso6DVYFDs34gmzAtgJfUG9EIVwV+aGA
 gcy1Rudr2qqfa78vk+yIG4OIgGIlUBg5bR70ab2tfJwKm7iUse+mBUz7JOq5qg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Tian Xin" <tianx@yunsilicon.com>
Date: Mon,  9 Dec 2024 15:11:00 +0800
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Message-Id: <20241209071101.3392590-16-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:28 +0800
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267569821+f28ec9+vger.kernel.org+tianx@yunsilicon.com>
Subject: [PATCH 15/16] net-next/yunsilicon: Add ndo_set_mac_address

From: Xin Tian <tianx@yunsilicon.com>

Add ndo_set_mac_address

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   4 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    |  48 ++++-----
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   | 102 ++++++++++++++++++
 4 files changed, 130 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 979e3b150..8da471f02 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -613,6 +613,10 @@ void xsc_core_frag_buf_free(struct xsc_core_device *xdev, struct xsc_frag_buf *b
 int xsc_register_interface(struct xsc_interface *intf);
 void xsc_unregister_interface(struct xsc_interface *intf);
 
+u8 xsc_core_query_vport_state(struct xsc_core_device *dev, u16 vport);
+int xsc_core_modify_nic_vport_mac_address(struct xsc_core_device *dev,
+					  u16 vport, u8 *addr, bool perm_mac);
+
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
 	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index a3b557cc5..1861b10a8 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -1349,37 +1349,13 @@ static void xsc_eth_sw_deinit(struct xsc_adapter *adapter)
 	return xsc_eth_close_channels(adapter);
 }
 
-static int _xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod,
-				  u16 vport, void *out, int outlen)
-{
-	struct xsc_query_vport_state_in in;
-
-	memset(&in, 0, sizeof(in));
-	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_VPORT_STATE);
-	in.vport_number = cpu_to_be16(vport);
-	if (vport)
-		in.other_vport = 1;
-
-	return xsc_cmd_exec(dev, &in, sizeof(in), out, outlen);
-}
-
-static u8 xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod, u16 vport)
-{
-	struct xsc_query_vport_state_out out;
-
-	memset(&out, 0, sizeof(out));
-	_xsc_query_vport_state(dev, opmod, vport, &out, sizeof(out));
-
-	return out.state;
-}
-
 static bool xsc_eth_get_link_status(struct xsc_adapter *adapter)
 {
 	bool link_up;
 	struct xsc_core_device *xdev = adapter->xdev;
 	u16 vport = 0;
 
-	link_up = xsc_query_vport_state(xdev, XSC_CMD_OP_QUERY_VPORT_STATE, vport);
+	link_up = xsc_core_query_vport_state(xdev, vport);
 
 	xsc_core_dbg(adapter->xdev, "link_status=%d\n", link_up);
 
@@ -1668,11 +1644,33 @@ static void xsc_eth_get_stats(struct net_device *netdev, struct rtnl_link_stats6
 	xsc_eth_fold_sw_stats64(adapter, stats);
 }
 
+static int xsc_eth_set_mac(struct net_device *netdev, void *addr)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+	struct sockaddr *saddr = addr;
+	struct xsc_core_device *xdev = adapter->xdev;
+	int ret;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	ret = xsc_core_modify_nic_vport_mac_address(xdev, 0, saddr->sa_data, false);
+	if (ret)
+		xsc_core_err(adapter->xdev, "%s: xsc set mac addr failed\n", __func__);
+
+	netif_addr_lock_bh(netdev);
+	eth_hw_addr_set(netdev, saddr->sa_data);
+	netif_addr_unlock_bh(netdev);
+
+	return 0;
+}
+
 static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
 	.ndo_get_stats64	= xsc_eth_get_stats,
+	.ndo_set_mac_address	= xsc_eth_set_mac,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 7c185e164..5c3d5624e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,5 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o intf.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o intf.o vport.o
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c b/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
new file mode 100644
index 000000000..82db21eb8
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+#include "common/xsc_driver.h"
+
+#define LAG_ID_INVALID		U16_MAX
+
+u8 xsc_core_query_vport_state(struct xsc_core_device *xdev, u16 vport)
+{
+	struct xsc_query_vport_state_in in;
+	struct xsc_query_vport_state_out out;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_VPORT_STATE);
+	in.vport_number = cpu_to_be16(vport);
+	if (vport)
+		in.other_vport = 1;
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status)
+		xsc_core_err(xdev, "failed to query vport state, err=%d, status=%d\n",
+			     err, out.hdr.status);
+
+	return out.state;
+}
+EXPORT_SYMBOL(xsc_core_query_vport_state);
+
+static int xsc_modify_nic_vport_context(struct xsc_core_device *dev, void *in,
+					int inlen)
+{
+	struct xsc_modify_nic_vport_context_out out;
+	struct xsc_modify_nic_vport_context_in *tmp;
+	int err;
+
+	memset(&out, 0, sizeof(out));
+	tmp = (struct xsc_modify_nic_vport_context_in *)in;
+	tmp->hdr.opcode = cpu_to_be16(XSC_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
+
+	err = xsc_cmd_exec(dev, in, inlen, &out, sizeof(out));
+	if (err || out.hdr.status) {
+		xsc_core_err(dev, "fail to modify nic vport err=%d status=%d\n",
+			     err, out.hdr.status);
+	}
+	return err;
+}
+
+static int __xsc_modify_nic_vport_mac_address(struct xsc_core_device *dev,
+					      u16 vport, u8 *addr, int force_other, bool perm_mac)
+{
+	struct xsc_modify_nic_vport_context_in *in;
+	int err;
+	int in_sz;
+	u8 *mac_addr;
+	u16 caps = 0;
+	u16 caps_mask = 0;
+	u16 lag_id = LAG_ID_INVALID;
+
+	in_sz = sizeof(struct xsc_modify_nic_vport_context_in) + 2;
+
+	in = kzalloc(in_sz, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	in->lag_id = cpu_to_be16(lag_id);
+
+	if (perm_mac) {
+		in->field_select.permanent_address = 1;
+		mac_addr = in->nic_vport_ctx.permanent_address;
+	} else {
+		in->field_select.current_address = 1;
+		mac_addr = in->nic_vport_ctx.current_address;
+	}
+
+	caps_mask |= BIT(XSC_TBM_CAP_PP_BYPASS);
+	in->caps = cpu_to_be16(caps);
+	in->caps_mask = cpu_to_be16(caps_mask);
+
+	ether_addr_copy(mac_addr, addr);
+
+	in->field_select.addresses_list = 1;
+	in->nic_vport_ctx.vlan_allowed = 0;
+
+	err = xsc_modify_nic_vport_context(dev, in, in_sz);
+	if (err)
+		xsc_core_err(dev, "modify nic vport context failed\n");
+
+	kfree(in);
+	return err;
+}
+
+int xsc_core_modify_nic_vport_mac_address(struct xsc_core_device *dev,
+					  u16 vport, u8 *addr, bool perm_mac)
+{
+	return __xsc_modify_nic_vport_mac_address(dev, vport, addr, 0, perm_mac);
+}
+EXPORT_SYMBOL(xsc_core_modify_nic_vport_mac_address);
-- 
2.43.0

