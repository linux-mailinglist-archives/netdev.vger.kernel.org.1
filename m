Return-Path: <netdev+bounces-175791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00CA677A8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B0219C14F4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F820DD40;
	Tue, 18 Mar 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="JU7NiJY/"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-37.ptr.blmpb.com (lf-1-37.ptr.blmpb.com [103.149.242.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF72080D3
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311127; cv=none; b=AjdOrW+2Kf5xZ85WYZk30a/U/zlZxONWvRDEwd5eI74afT+RN5fNFuqgARycGPAEg9FsZJUa0zS8aWHot10zTCyIxIE3gtYI3eg0habMLwaJKZQ1Lv4t0JjzHgVs6wDxbPVZYUbRax7+ZH3UkvMvhTNcqkDO8hBcCV1Y8MZAHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311127; c=relaxed/simple;
	bh=0gtEiyJNJlaWikBvDhz/56vDmIiWwt12roTcrDbYQek=;
	h=Cc:Subject:To:Mime-Version:In-Reply-To:Date:Message-Id:
	 Content-Type:References:From; b=IpD4ekE/+thrSIwUahLURLinzwu+GxO/ecnukTEHv2g6eCZJrPXV1ypMUaGN6GlJkob4A/54kTmkdc8IwiT0iglGK1Vefte4+ZMBGZPCHdgsZLtzURi0Kh09SrhESTseZYKnUKW6iaZNsNoEsjCPzTmHZa/576hIpJJU3H6jESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=JU7NiJY/; arc=none smtp.client-ip=103.149.242.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742310914; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UHlUCSm2AO8NXr5A0QkP3RfIfgW02JMXvkyfgfJWRLY=;
 b=JU7NiJY/0XIzkqch6J0jgjB9BP835UeQ4g6v+Sc8hkiEj5rR5P/KqnWwdosxK8/hp8xZem
 YK8I7DAVGjgDeTnAdVZOng5Gy2YjY6aIHEc/RvBKfYvcf3vx3Q9sDyULZxzOsFcdxBrw/L
 Iig3Nj65obPW9IyR+9/AEXgZsYmfnPWaWEknlagTgiZ2KmgkttpI8xtKL1v76xZGwZuzEP
 xvQTgBi9D+qpxLlDYsGegqsm1XkDWQtIIMyyGASbhpsKHwS5W1/kPXPtR4x/wLgDddN46x
 E8AxBJok0PQGrAbi81wq0zXpfV5YoVD3lzri7YvKLAzUfcrmJ8bs6N2KWfVm5A==
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Subject: [PATCH net-next v9 09/14] xsc: Init net device
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250318151449.1376756-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 23:15:11 +0800
Date: Tue, 18 Mar 2025 23:15:11 +0800
Message-Id: <20250318151510.1376756-10-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267d98e00+bc9cfa+vger.kernel.org+tianx@yunsilicon.com>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>

Initialize network device:
1. Prepare xsc_eth_params, set up the network parameters such as MTU,
number of channels, and RSS configuration
2. Configure netdev, Set the MTU, features
3. Set mac addr to hardware, and attach netif

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
 .../yunsilicon/xsc/common/xsc_device.h        |  42 +++
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |  38 ++
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 341 +++++++++++++++++-
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  28 ++
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  31 ++
 .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h | 180 +++++++++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  49 +++
 8 files changed, 709 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index e6863cb08..f310ca810 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -8,6 +8,7 @@
 
 #include <linux/pci.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/if_vlan.h>
 
 #include "common/xsc_cmdq.h"
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
new file mode 100644
index 000000000..45ea8d2a0
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_DEVICE_H
+#define __XSC_DEVICE_H
+
+enum xsc_traffic_types {
+	XSC_TT_IPV4,
+	XSC_TT_IPV4_TCP,
+	XSC_TT_IPV4_UDP,
+	XSC_TT_IPV6,
+	XSC_TT_IPV6_TCP,
+	XSC_TT_IPV6_UDP,
+	XSC_TT_IPV4_IPSEC_AH,
+	XSC_TT_IPV6_IPSEC_AH,
+	XSC_TT_IPV4_IPSEC_ESP,
+	XSC_TT_IPV6_IPSEC_ESP,
+	XSC_TT_ANY,
+	XSC_NUM_TT,
+};
+
+#define XSC_NUM_INDIR_TIRS XSC_NUM_TT
+
+enum {
+	XSC_L3_PROT_TYPE_IPV4	= BIT(0),
+	XSC_L3_PROT_TYPE_IPV6	= BIT(1),
+};
+
+enum {
+	XSC_L4_PROT_TYPE_TCP	= BIT(0),
+	XSC_L4_PROT_TYPE_UDP	= BIT(1),
+};
+
+struct xsc_tirc_config {
+	u8 l3_prot_type;
+	u8 l4_prot_type;
+	u32 rx_hash_fields;
+};
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
new file mode 100644
index 000000000..582f99d8c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_PP_H
+#define __XSC_PP_H
+
+enum {
+	XSC_HASH_FIELD_SEL_SRC_IP	= BIT(0),
+	XSC_HASH_FIELD_SEL_PROTO	= BIT(1),
+	XSC_HASH_FIELD_SEL_DST_IP	= BIT(2),
+	XSC_HASH_FIELD_SEL_SPORT	= BIT(3),
+	XSC_HASH_FIELD_SEL_DPORT	= BIT(4),
+	XSC_HASH_FIELD_SEL_SRC_IPV6	= BIT(5),
+	XSC_HASH_FIELD_SEL_DST_IPV6	= BIT(6),
+	XSC_HASH_FIELD_SEL_SPORT_V6	= BIT(7),
+	XSC_HASH_FIELD_SEL_DPORT_V6	= BIT(8),
+};
+
+#define XSC_HASH_IP		(XSC_HASH_FIELD_SEL_SRC_IP	|\
+				XSC_HASH_FIELD_SEL_DST_IP	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+#define XSC_HASH_IP_PORTS	(XSC_HASH_FIELD_SEL_SRC_IP	|\
+				XSC_HASH_FIELD_SEL_DST_IP	|\
+				XSC_HASH_FIELD_SEL_SPORT	|\
+				XSC_HASH_FIELD_SEL_DPORT	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+#define XSC_HASH_IP6		(XSC_HASH_FIELD_SEL_SRC_IPV6	|\
+				XSC_HASH_FIELD_SEL_DST_IPV6	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+#define XSC_HASH_IP6_PORTS	(XSC_HASH_FIELD_SEL_SRC_IPV6	|\
+				XSC_HASH_FIELD_SEL_DST_IPV6	|\
+				XSC_HASH_FIELD_SEL_SPORT_V6	|\
+				XSC_HASH_FIELD_SEL_DPORT_V6	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+
+#endif /* __XSC_PP_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index f5e247864..cc40628f9 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -6,17 +6,339 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/ethtool.h>
 
 #include "common/xsc_core.h"
+#include "common/xsc_driver.h"
+#include "common/xsc_device.h"
+#include "common/xsc_pp.h"
 #include "xsc_eth_common.h"
 #include "xsc_eth.h"
 
+static const struct xsc_tirc_config tirc_default_config[XSC_NUM_INDIR_TIRS] = {
+	[XSC_TT_IPV4] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV4,
+				.l4_prot_type = 0,
+				.rx_hash_fields = XSC_HASH_IP,
+	},
+	[XSC_TT_IPV4_TCP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV4,
+				.l4_prot_type = XSC_L4_PROT_TYPE_TCP,
+				.rx_hash_fields = XSC_HASH_IP_PORTS,
+	},
+	[XSC_TT_IPV4_UDP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV4,
+				.l4_prot_type = XSC_L4_PROT_TYPE_UDP,
+				.rx_hash_fields = XSC_HASH_IP_PORTS,
+	},
+	[XSC_TT_IPV6] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV6,
+				.l4_prot_type = 0,
+				.rx_hash_fields = XSC_HASH_IP6,
+	},
+	[XSC_TT_IPV6_TCP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV6,
+				.l4_prot_type = XSC_L4_PROT_TYPE_TCP,
+				.rx_hash_fields = XSC_HASH_IP6_PORTS,
+	},
+	[XSC_TT_IPV6_UDP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV6,
+				.l4_prot_type = XSC_L4_PROT_TYPE_UDP,
+				.rx_hash_fields = XSC_HASH_IP6_PORTS,
+	},
+};
+
 static int xsc_get_max_num_channels(struct xsc_core_device *xdev)
 {
 	return min_t(int, xdev->dev_res->eq_table.num_comp_vectors,
 		     XSC_ETH_MAX_NUM_CHANNELS);
 }
 
+static void xsc_build_default_indir_rqt(u32 *indirection_rqt, int len,
+					int num_channels)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		indirection_rqt[i] = i % num_channels;
+}
+
+static void xsc_build_rss_param(struct xsc_rss_params *rss_param,
+				u16 num_channels)
+{
+	enum xsc_traffic_types tt;
+
+	rss_param->hfunc = ETH_RSS_HASH_TOP;
+	netdev_rss_key_fill(rss_param->toeplitz_hash_key,
+			    sizeof(rss_param->toeplitz_hash_key));
+
+	xsc_build_default_indir_rqt(rss_param->indirection_rqt,
+				    XSC_INDIR_RQT_SIZE, num_channels);
+
+	for (tt = 0; tt < XSC_NUM_INDIR_TIRS; tt++) {
+		rss_param->rx_hash_fields[tt] =
+			tirc_default_config[tt].rx_hash_fields;
+	}
+	rss_param->rss_hash_tmpl = XSC_HASH_IP_PORTS | XSC_HASH_IP6_PORTS;
+}
+
+static void xsc_eth_build_nic_params(struct xsc_adapter *adapter,
+				     u32 ch_num, u32 tc_num)
+{
+	struct xsc_eth_params *params = &adapter->nic_param;
+	struct xsc_core_device *xdev = adapter->xdev;
+
+	params->mtu = SW_DEFAULT_MTU;
+	params->num_tc = tc_num;
+
+	params->comp_vectors = xdev->dev_res->eq_table.num_comp_vectors;
+	params->max_num_ch = ch_num;
+	params->num_channels = ch_num;
+
+	params->rq_max_size = BIT(xdev->caps.log_max_qp_depth);
+	params->sq_max_size = BIT(xdev->caps.log_max_qp_depth);
+	xsc_build_rss_param(&adapter->rss_param,
+			    adapter->nic_param.num_channels);
+}
+
+static int xsc_eth_netdev_init(struct xsc_adapter *adapter)
+{
+	unsigned int node, tc, nch;
+
+	tc = adapter->nic_param.num_tc;
+	nch = adapter->nic_param.max_num_ch;
+	node = dev_to_node(adapter->dev);
+	adapter->txq2sq = kcalloc_node(nch * tc,
+				       sizeof(*adapter->txq2sq),
+				       GFP_KERNEL, node);
+	if (!adapter->txq2sq)
+		goto err_out;
+
+	adapter->workq = create_singlethread_workqueue("xsc_eth");
+	if (!adapter->workq)
+		goto err_free_priv;
+
+	netif_carrier_off(adapter->netdev);
+
+	return 0;
+
+err_free_priv:
+	kfree(adapter->txq2sq);
+err_out:
+	return -ENOMEM;
+}
+
+static int xsc_eth_close(struct net_device *netdev)
+{
+	return 0;
+}
+
+static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
+			      u16 mtu, u16 rx_buf_sz)
+{
+	struct xsc_set_mtu_mbox_out out;
+	struct xsc_set_mtu_mbox_in in;
+	int ret;
+
+	memset(&in, 0, sizeof(struct xsc_set_mtu_mbox_in));
+	memset(&out, 0, sizeof(struct xsc_set_mtu_mbox_out));
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_SET_MTU);
+	in.mtu = cpu_to_be16(mtu);
+	in.rx_buf_sz_min = cpu_to_be16(rx_buf_sz);
+	in.mac_port = xdev->mac_port;
+
+	ret = xsc_cmd_exec(xdev, &in, sizeof(struct xsc_set_mtu_mbox_in), &out,
+			   sizeof(struct xsc_set_mtu_mbox_out));
+	if (ret || out.hdr.status) {
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "failed to set hw_mtu=%u rx_buf_sz=%u, err=%d, status=%d\n",
+			   mtu, rx_buf_sz, ret, out.hdr.status);
+		ret = -ENOEXEC;
+	}
+
+	return ret;
+}
+
+static const struct net_device_ops xsc_netdev_ops = {
+	/* TBD */
+};
+
+static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	/* Set up network device as normal. */
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+	netdev->netdev_ops = &xsc_netdev_ops;
+
+	netdev->min_mtu = SW_MIN_MTU;
+	netdev->max_mtu = SW_MAX_MTU;
+	/*mtu - macheaderlen - ipheaderlen should be aligned in 8B*/
+	netdev->mtu = SW_DEFAULT_MTU;
+
+	netdev->vlan_features |= NETIF_F_SG;
+	netdev->vlan_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	netdev->vlan_features |= NETIF_F_GRO;
+	netdev->vlan_features |= NETIF_F_TSO;
+	netdev->vlan_features |= NETIF_F_TSO6;
+
+	netdev->vlan_features |= NETIF_F_RXCSUM;
+	netdev->vlan_features |= NETIF_F_RXHASH;
+
+	netdev->hw_features = netdev->vlan_features;
+
+	netdev->hw_enc_features |= NETIF_F_IP_CSUM;
+	netdev->hw_enc_features |= NETIF_F_IPV6_CSUM;
+	netdev->hw_enc_features |= NETIF_F_TSO;
+	netdev->hw_enc_features |= NETIF_F_TSO6;
+	netdev->hw_enc_features |= NETIF_F_GSO_PARTIAL;
+
+	netdev->hw_features		|= NETIF_F_GSO_PARTIAL;
+	netdev->hw_features		|= NETIF_F_GSO_UDP_L4;
+	netdev->features		|= netdev->hw_features;
+	netdev->gso_partial_features	|= NETIF_F_GSO_UDP_L4;
+
+	netdev->features		|= NETIF_F_HIGHDMA;
+}
+
+static int xsc_eth_nic_init(struct xsc_adapter *adapter,
+			    void *rep_priv, u32 ch_num, u32 tc_num)
+{
+	int err;
+
+	xsc_eth_build_nic_params(adapter, ch_num, tc_num);
+
+	err = xsc_eth_netdev_init(adapter);
+	if (err)
+		return err;
+
+	xsc_eth_build_nic_netdev(adapter);
+
+	return 0;
+}
+
+static void xsc_eth_nic_cleanup(struct xsc_adapter *adapter)
+{
+	destroy_workqueue(adapter->workq);
+	kfree(adapter->txq2sq);
+}
+
+static int xsc_eth_get_mac(struct xsc_core_device *xdev, char *mac)
+{
+	struct xsc_query_eth_mac_mbox_out *out;
+	struct xsc_query_eth_mac_mbox_in in;
+	int err = 0;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_ETH_MAC);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out));
+	if (err || out->hdr.status) {
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "get mac failed! err=%d, out.status=%u\n",
+			   err, out->hdr.status);
+		err = -ENOEXEC;
+		goto err_free;
+	}
+
+	memcpy(mac, out->mac, 6);
+
+err_free:
+	kfree(out);
+	return err;
+}
+
+static void xsc_eth_l2_addr_init(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	char mac[6] = {0};
+	int ret = 0;
+
+	ret = xsc_eth_get_mac(adapter->xdev, mac);
+	if (ret) {
+		netdev_err(netdev, "get mac failed %d, generate random mac...",
+			   ret);
+		eth_random_addr(mac);
+	}
+	dev_addr_mod(netdev, 0, mac, 6);
+
+	if (!is_valid_ether_addr(netdev->perm_addr))
+		memcpy(netdev->perm_addr, netdev->dev_addr, netdev->addr_len);
+}
+
+static int xsc_eth_nic_enable(struct xsc_adapter *adapter)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+
+	xsc_eth_l2_addr_init(adapter);
+
+	xsc_eth_set_hw_mtu(xdev, XSC_SW2HW_MTU(adapter->nic_param.mtu),
+			   XSC_SW2HW_RX_PKT_LEN(adapter->nic_param.mtu));
+
+	rtnl_lock();
+	netif_device_attach(adapter->netdev);
+	rtnl_unlock();
+
+	return 0;
+}
+
+static void xsc_eth_nic_disable(struct xsc_adapter *adapter)
+{
+	rtnl_lock();
+	if (netif_running(adapter->netdev))
+		xsc_eth_close(adapter->netdev);
+	netif_device_detach(adapter->netdev);
+	rtnl_unlock();
+}
+
+static int xsc_attach_netdev(struct xsc_adapter *adapter)
+{
+	int err = -1;
+
+	err = xsc_eth_nic_enable(adapter);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void xsc_detach_netdev(struct xsc_adapter *adapter)
+{
+	xsc_eth_nic_disable(adapter);
+
+	flush_workqueue(adapter->workq);
+	adapter->status = XSCALE_ETH_DRIVER_DETACH;
+}
+
+static int xsc_eth_attach(struct xsc_core_device *xdev,
+			  struct xsc_adapter *adapter)
+{
+	int err = -1;
+
+	if (netif_device_present(adapter->netdev))
+		return 0;
+
+	err = xsc_attach_netdev(adapter);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void xsc_eth_detach(struct xsc_core_device *xdev,
+			   struct xsc_adapter *adapter)
+{
+	if (!netif_device_present(adapter->netdev))
+		return;
+
+	xsc_detach_netdev(adapter);
+}
+
 static int xsc_eth_probe(struct auxiliary_device *adev,
 			 const struct auxiliary_device_id *adev_id)
 {
@@ -24,6 +346,7 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
 	struct xsc_core_device *xdev = xsc_adev->xdev;
 	struct xsc_adapter *adapter;
 	struct net_device *netdev;
+	void *rep_priv = NULL;
 	int num_chl, num_tc;
 	int err;
 
@@ -46,14 +369,30 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
 	adapter->xdev = xdev;
 	xdev->eth_priv = adapter;
 
+	err = xsc_eth_nic_init(adapter, rep_priv, num_chl, num_tc);
+	if (err) {
+		netdev_err(netdev, "xsc_eth_nic_init failed, err=%d\n", err);
+		goto err_free_netdev;
+	}
+
+	err = xsc_eth_attach(xdev, adapter);
+	if (err) {
+		netdev_err(netdev, "xsc_eth_attach failed, err=%d\n", err);
+		goto err_nic_cleanup;
+	}
+
 	err = register_netdev(netdev);
 	if (err) {
 		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
-		goto err_free_netdev;
+		goto err_detach;
 	}
 
 	return 0;
 
+err_detach:
+	xsc_eth_detach(xdev, adapter);
+err_nic_cleanup:
+	xsc_eth_nic_cleanup(adapter);
 err_free_netdev:
 	free_netdev(netdev);
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 0c70c0d59..f5c1e3ead 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -6,11 +6,39 @@
 #ifndef __XSC_ETH_H
 #define __XSC_ETH_H
 
+#include "common/xsc_device.h"
+#include "xsc_eth_common.h"
+
+enum {
+	XSCALE_ETH_DRIVER_INIT,
+	XSCALE_ETH_DRIVER_OK,
+	XSCALE_ETH_DRIVER_CLOSE,
+	XSCALE_ETH_DRIVER_DETACH,
+};
+
+struct xsc_rss_params {
+	u32	indirection_rqt[XSC_INDIR_RQT_SIZE];
+	u32	rx_hash_fields[XSC_NUM_INDIR_TIRS];
+	u8	toeplitz_hash_key[52];
+	u8	hfunc;
+	u32	rss_hash_tmpl;
+};
+
 struct xsc_adapter {
 	struct net_device	*netdev;
 	struct pci_dev		*pdev;
 	struct device		*dev;
 	struct xsc_core_device	*xdev;
+
+	struct xsc_eth_params	nic_param;
+	struct xsc_rss_params	rss_param;
+
+	struct workqueue_struct	*workq;
+
+	struct xsc_sq		**txq2sq;
+
+	u32			status;
+	struct mutex		status_lock; /*protect status */
 };
 
 #endif /* __XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index b5640f05d..da17c16ad 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -6,10 +6,41 @@
 #ifndef __XSC_ETH_COMMON_H
 #define __XSC_ETH_COMMON_H
 
+#include "xsc_pph.h"
+
+#define SW_MIN_MTU		ETH_MIN_MTU
+#define SW_DEFAULT_MTU		ETH_DATA_LEN
+#define SW_MAX_MTU		9600
+
+#define XSC_ETH_HW_MTU_SEND	9800
+#define XSC_ETH_HW_MTU_RECV	9800
+#define XSC_ETH_HARD_MTU	(ETH_HLEN + VLAN_HLEN * 2 + ETH_FCS_LEN)
+#define XSC_SW2HW_MTU(mtu)	((mtu) + XSC_ETH_HARD_MTU)
+#define XSC_SW2HW_FRAG_SIZE(mtu)	((mtu) + XSC_ETH_HARD_MTU)
+#define XSC_ETH_RX_MAX_HEAD_ROOM	256
+#define XSC_SW2HW_RX_PKT_LEN(mtu)	\
+	((mtu) + ETH_HLEN + XSC_ETH_RX_MAX_HEAD_ROOM)
+
 #define XSC_LOG_INDIR_RQT_SIZE		0x8
 
 #define XSC_INDIR_RQT_SIZE		BIT(XSC_LOG_INDIR_RQT_SIZE)
 #define XSC_ETH_MIN_NUM_CHANNELS	2
 #define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
 
+struct xsc_eth_params {
+	u16	num_channels;
+	u16	max_num_ch;
+	u8	num_tc;
+	u32	mtu;
+	u32	hard_mtu;
+	u32	comp_vectors;
+	u32	sq_size;
+	u32	sq_max_size;
+	u8	rq_wq_type;
+	u32	rq_size;
+	u32	rq_max_size;
+	u32	rq_frags_size;
+	u32	pflags;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h
new file mode 100644
index 000000000..34f1200e8
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_PPH_H
+#define __XSC_PPH_H
+
+#define XSC_PPH_HEAD_LEN	64
+
+enum {
+	L4_PROTO_NONE	= 0,
+	L4_PROTO_TCP	= 1,
+	L4_PROTO_UDP	= 2,
+	L4_PROTO_ICMP	= 3,
+	L4_PROTO_GRE	= 4,
+};
+
+enum {
+	L3_PROTO_NONE	= 0,
+	L3_PROTO_IP	= 2,
+	L3_PROTO_IP6	= 3,
+};
+
+struct epp_pph {
+	u16 outer_eth_type;
+	u16 inner_eth_type;
+
+	u16 rsv1:1;
+	u16 outer_vlan_flag:2;
+	u16 outer_ip_type:2;
+	u16 outer_ip_ofst:5;
+	u16 outer_ip_len:6;
+
+	u16 rsv2:1;
+	u16 outer_tp_type:3;
+	u16 outer_tp_csum_flag:1;
+	u16 outer_tp_ofst:7;
+	u16 ext_tunnel_type:4;
+
+	u8 tunnel_ofst;
+	u8 inner_mac_ofst;
+
+	u32 rsv3:2;
+	u32 inner_mac_flag:1;
+	u32 inner_vlan_flag:2;
+	u32 inner_ip_type:2;
+	u32 inner_ip_ofst:8;
+	u32 inner_ip_len:6;
+	u32 inner_tp_type:2;
+	u32 inner_tp_csum_flag:1;
+	u32 inner_tp_ofst:8;
+
+	u16 rsv4:1;
+	u16 payload_type:4;
+	u16 payload_ofst:8;
+	u16 pkt_type:3;
+
+	u16 rsv5:2;
+	u16 pri:3;
+	u16 logical_in_port:11;
+	u16 vlan_info;
+	u8 error_bitmap:8;
+
+	u8 rsv6:7;
+	u8 recirc_id_vld:1;
+	u16 recirc_id;
+
+	u8 rsv7:7;
+	u8 recirc_data_vld:1;
+	u32 recirc_data;
+
+	u8 rsv8:6;
+	u8 mark_tag_vld:2;
+	u16 mark_tag;
+
+	u8 rsv9:4;
+	u8 upa_to_soc:1;
+	u8 upa_from_soc:1;
+	u8 upa_re_up_call:1;
+	u8 upa_pkt_drop:1;
+
+	u8 ucdv;
+	u16 rsv10:2;
+	u16 pkt_len:14;
+
+	u16 rsv11:2;
+	u16 pkt_hdr_ptr:14;
+
+	u64	 rsv12:5;
+	u64	 csum_ofst:8;
+	u64	 csum_val:29;
+	u64	 csum_plen:14;
+	u64	 rsv11_0:8;
+
+	u64	 rsv11_1;
+	u64	 rsv11_2;
+	u16 rsv11_3;
+};
+
+#define OUTER_L3_BIT	BIT(3)
+#define OUTER_L4_BIT	BIT(2)
+#define INNER_L3_BIT	BIT(1)
+#define INNER_L4_BIT	BIT(0)
+#define OUTER_BIT		(OUTER_L3_BIT | OUTER_L4_BIT)
+#define INNER_BIT		(INNER_L3_BIT | INNER_L4_BIT)
+#define OUTER_AND_INNER	(OUTER_BIT | INNER_BIT)
+
+#define PACKET_UNKNOWN	BIT(4)
+
+#define EPP2SOC_PPH_EXT_TUNNEL_TYPE_OFFSET (6UL)
+#define EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_MASK (0XF00)
+#define EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_OFFSET (8)
+
+#define EPP2SOC_PPH_EXT_ERROR_BITMAP_OFFSET (20UL)
+#define EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_MASK (0XFF)
+#define EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_OFFSET (0)
+
+#define XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(PPH_BASE_ADDR)	\
+	((*(u16 *)((u8 *)(PPH_BASE_ADDR) +	\
+	EPP2SOC_PPH_EXT_TUNNEL_TYPE_OFFSET) &	\
+	EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_MASK) >>	\
+	EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_OFFSET)
+
+#define XSC_GET_EPP2SOC_PPH_ERROR_BITMAP(PPH_BASE_ADDR)	\
+	((*(u8 *)((u8 *)(PPH_BASE_ADDR) +	\
+	EPP2SOC_PPH_EXT_ERROR_BITMAP_OFFSET) &	\
+	EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_MASK) >>	\
+	EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_OFFSET)
+
+#define PPH_OUTER_IP_TYPE_OFF		(4UL)
+#define PPH_OUTER_IP_TYPE_MASK		(0x3)
+#define PPH_OUTER_IP_TYPE_SHIFT		(11)
+#define PPH_OUTER_IP_TYPE(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_IP_TYPE_OFF)) >>	\
+	PPH_OUTER_IP_TYPE_SHIFT) & PPH_OUTER_IP_TYPE_MASK)
+
+#define PPH_OUTER_IP_OFST_OFF		(4UL)
+#define PPH_OUTER_IP_OFST_MASK		(0x1f)
+#define PPH_OUTER_IP_OFST_SHIFT		(6)
+#define PPH_OUTER_IP_OFST(base)			\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_IP_OFST_OFF)) >>	\
+	PPH_OUTER_IP_OFST_SHIFT) & PPH_OUTER_IP_OFST_MASK)
+
+#define PPH_OUTER_IP_LEN_OFF		(4UL)
+#define PPH_OUTER_IP_LEN_MASK		(0x3f)
+#define PPH_OUTER_IP_LEN_SHIFT		(0)
+#define PPH_OUTER_IP_LEN(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_IP_LEN_OFF)) >>	\
+	PPH_OUTER_IP_LEN_SHIFT) & PPH_OUTER_IP_LEN_MASK)
+
+#define PPH_OUTER_TP_TYPE_OFF		(6UL)
+#define PPH_OUTER_TP_TYPE_MASK		(0x7)
+#define PPH_OUTER_TP_TYPE_SHIFT		(12)
+#define PPH_OUTER_TP_TYPE(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_TP_TYPE_OFF)) >>	\
+	PPH_OUTER_TP_TYPE_SHIFT) & PPH_OUTER_TP_TYPE_MASK)
+
+#define PPH_PAYLOAD_OFST_OFF		(14UL)
+#define PPH_PAYLOAD_OFST_MASK		(0xff)
+#define PPH_PAYLOAD_OFST_SHIFT		(3)
+#define PPH_PAYLOAD_OFST(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_PAYLOAD_OFST_OFF)) >>	\
+	PPH_PAYLOAD_OFST_SHIFT) & PPH_PAYLOAD_OFST_MASK)
+
+#define PPH_CSUM_OFST_OFF		(38UL)
+#define PPH_CSUM_OFST_MASK		(0xff)
+#define PPH_CSUM_OFST_SHIFT		(51)
+#define PPH_CSUM_OFST(base)		\
+	((be64_to_cpu(*(u64 *)((u8 *)(base) + PPH_CSUM_OFST_OFF)) >>	\
+	PPH_CSUM_OFST_SHIFT) & PPH_CSUM_OFST_MASK)
+
+#define PPH_CSUM_VAL_OFF		(38UL)
+#define PPH_CSUM_VAL_MASK		(0xeffffff)
+#define PPH_CSUM_VAL_SHIFT		(22)
+#define PPH_CSUM_VAL(base)		\
+	((be64_to_cpu(*(u64 *)((u8 *)(base) + PPH_CSUM_VAL_OFF)) >>	\
+	PPH_CSUM_VAL_SHIFT) & PPH_CSUM_VAL_MASK)
+#endif /* __XSC_TBM_H */
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
new file mode 100644
index 000000000..223d4873d
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef __XSC_QUEUE_H
+#define __XSC_QUEUE_H
+
+#include "common/xsc_core.h"
+
+struct xsc_sq {
+	struct xsc_core_qp		cqp;
+	/* dirtied @completion */
+	u16                        cc;
+	u32                        dma_fifo_cc;
+
+	/* dirtied @xmit */
+	u16                        pc ____cacheline_aligned_in_smp;
+	u32                        dma_fifo_pc;
+
+	struct xsc_cq            cq;
+
+	/* read only */
+	struct xsc_wq_cyc         wq;
+	u32                        dma_fifo_mask;
+	struct {
+		struct xsc_sq_dma         *dma_fifo;
+		struct xsc_tx_wqe_info    *wqe_info;
+	} db;
+	void __iomem              *uar_map;
+	struct netdev_queue       *txq;
+	u32                        sqn;
+	u16                        stop_room;
+
+	__be32                     mkey_be;
+	unsigned long              state;
+	unsigned int               hw_mtu;
+
+	/* control path */
+	struct xsc_wq_ctrl        wq_ctrl;
+	struct xsc_channel         *channel;
+	int                        ch_ix;
+	int                        txq_ix;
+	struct work_struct         recover_work;
+} ____cacheline_aligned_in_smp;
+
+#endif /* __XSC_QUEUE_H */
-- 
2.43.0

