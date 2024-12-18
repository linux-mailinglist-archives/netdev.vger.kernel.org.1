Return-Path: <netdev+bounces-152890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9609F63D5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4131895AED
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354C19CC22;
	Wed, 18 Dec 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="HiwyA9vh"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AA19E99F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519073; cv=none; b=UJ+eMgxASFCU9A03NXnRWZsvLWh+E+t7MQbCHxEYpC9P3PVYzm7jU+0XS2yKzMMuzEpzsJrcqt1pQj1PQW66lO0jV3gZGxweVXOhxxsrjwMZDK4SLqeGsZVjyVQkfJuuJihKsiFq0GZFApUjXLkGPmUAzNbHeLB/JVq2Isfbdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519073; c=relaxed/simple;
	bh=1P+aWE3sZkrqj1Bpr/dl+6TDLut65sc3i6SMb9hVuOo=;
	h=Message-Id:Mime-Version:In-Reply-To:Content-Type:Subject:Cc:From:
	 References:To:Date; b=jy7ZT/ZUKhY4Y7Yuw4WoC/2ciPcR8Xkh4+bR7imAfcHygi2y26yYUiRMXf8y4Jqbh0pw6XcOh3/ldVdvzPfs05pSclomB2LQJrMFAAetJqNULKss877q58dpBhsQsrXjX/bAltl9udYnBcE25qu9bGZpPlMWHU445JWpJdnFedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=HiwyA9vh; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519059; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QUXZFiXX06Wzo2GpXQAsyufggdcZcheTnLAYEQCT2Ms=;
 b=HiwyA9vhVUEQ3rGmmbkkCyNVXgh+mIJ566dX9Kp1w1amFhlGTgCoohhe4YiWVyQwL5K+B2
 0yxnnkVwyocnNtY0Vj3Zb1SucrQsFTcqXoTnYSe1cDo3KM9Hhpq04Z/Q9dERWpx12DQKcV
 tj0yvMtFdL9AYebrwvc2VNXo7B1bPjpSOQe2ri+pkniEH7phITcwBi+j37pKiUjIUZOJ/Y
 z/iiPUVkqPA1/rik5dTOKPB6C1m9W5yuRJEKGKalFxhc3ZWzaFJXKB3LTBMuHGNx0nCI5k
 3xry4c/m0gIZYrrqtTjSMQRwhlm6LwLk97EGiaF/X2jdm2mOZgZm5DcdiO8wsg==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 18:50:56 +0800
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Message-Id: <20241218105055.2237645-16-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20241218105023.2237645-1-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v1 15/16] net-next/yunsilicon: Add ndo_set_mac_address
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
X-Lms-Return-Path: <lba+26762a911+95623e+vger.kernel.org+tianx@yunsilicon.com>
Date: Wed, 18 Dec 2024 18:50:56 +0800

Add ndo_set_mac_address

 
Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  2 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 22 ++++++
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   | 72 +++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index d69be5352..5c60b3126 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -612,6 +612,8 @@ int xsc_register_interface(struct xsc_interface *intf);
 void xsc_unregister_interface(struct xsc_interface *intf);
 
 u8 xsc_core_query_vport_state(struct xsc_core_device *xdev, u16 vport);
+int xsc_core_modify_nic_vport_mac_address(struct xsc_core_device *xdev,
+					  u16 vport, u8 *addr, bool perm_mac);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 0c6e949b5..6df7ed3bb 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -1647,6 +1647,27 @@ static void xsc_eth_get_stats(struct net_device *netdev, struct rtnl_link_stats6
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
 static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev, u16 mtu, u16 rx_buf_sz)
 {
 	struct xsc_set_mtu_mbox_in in;
@@ -1677,6 +1698,7 @@ static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
 	.ndo_get_stats64	= xsc_eth_get_stats,
+	.ndo_set_mac_address	= xsc_eth_set_mac,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c b/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
index 8200f6c91..f044ac009 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
@@ -6,6 +6,8 @@
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
 
+#define LAG_ID_INVALID		U16_MAX
+
 u8 xsc_core_query_vport_state(struct xsc_core_device *xdev, u16 vport)
 {
 	struct xsc_query_vport_state_in in;
@@ -28,3 +30,73 @@ u8 xsc_core_query_vport_state(struct xsc_core_device *xdev, u16 vport)
 	return out.state;
 }
 EXPORT_SYMBOL(xsc_core_query_vport_state);
+
+static int xsc_modify_nic_vport_context(struct xsc_core_device *xdev, void *in,
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
+	err = xsc_cmd_exec(xdev, in, inlen, &out, sizeof(out));
+	if (err || out.hdr.status) {
+		xsc_core_err(xdev, "fail to modify nic vport err=%d status=%d\n",
+			     err, out.hdr.status);
+	}
+	return err;
+}
+
+static int __xsc_modify_nic_vport_mac_address(struct xsc_core_device *xdev,
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
+	err = xsc_modify_nic_vport_context(xdev, in, in_sz);
+	if (err)
+		xsc_core_err(xdev, "modify nic vport context failed\n");
+
+	kfree(in);
+	return err;
+}
+
+int xsc_core_modify_nic_vport_mac_address(struct xsc_core_device *xdev,
+					  u16 vport, u8 *addr, bool perm_mac)
+{
+	return __xsc_modify_nic_vport_mac_address(xdev, vport, addr, 0, perm_mac);
+}
+EXPORT_SYMBOL(xsc_core_modify_nic_vport_mac_address);
-- 
2.43.0

