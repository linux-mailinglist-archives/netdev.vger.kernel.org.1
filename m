Return-Path: <netdev+bounces-248339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF3D07135
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D158C3017112
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17F3164C7;
	Fri,  9 Jan 2026 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SG/vxWow"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666002FE048;
	Fri,  9 Jan 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931829; cv=none; b=JTdZWC25P9H1aiRVAsx8sJ0Cm6E0PStfMrNO3Yov+1atDPfgA2pRZqIUqSdw8SiZCELFAPhWp/2J77yNFFkhgWgfaHdKQmaJWRIqs0+C5tx+juJ2eEgsYKjIAXUCnH2L2XsmDijWciXCi3XtIcWx6rePd5FXrIawCsW3yv9hwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931829; c=relaxed/simple;
	bh=abKWTshI3Sk4EJvY2sgQ0YvahqoNhRfN8DRiP8g73Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZyamAEQquL77a0BbudU75mwpitbCEo4PvP+mX/tgwLRIVZkCpk28Xb+820OB3HkMqbwczxOZObxx5rFQw5mvQKdbjqZtMstOw4dhfGT1Q1fwxsLHumk11FPQs3CRgwharAIImMTaUZzd4+xjompWE48psosxY2tKyrt6ydVdpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SG/vxWow; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LeiJJQCA648xtNmhTYCtHNzKwHpQF1tlV4W/ViQloRE=;
	b=SG/vxWow1LIyw3ei1jr3VgzEjT8zCEq78Kn5T++pcqR1jEAgGVo7wrnxhfgJD+QBL4dD+f42T
	XdaPIO2cJrom3vMHEuphHlirsPdkLrN2kBEh9Jf8mNAdcRrnBHxytZP52g8JqGmAND55JnyORvV
	7Jl8DjWRejKF8g10/eYS5QY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dnSs60MKqz1prQb;
	Fri,  9 Jan 2026 12:07:06 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 7671740567;
	Fri,  9 Jan 2026 12:10:24 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 12:10:23 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v10 6/9] hinic3: Add .ndo_vlan_rx_add/kill_vid and .ndo_validate_addr
Date: Fri, 9 Jan 2026 10:35:56 +0800
Message-ID: <5f8d02212f1249bff167c3756f886a854bf8f114.1767861236.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767861236.git.zhuyikai1@h-partners.com>
References: <cover.1767861236.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Implement following callback function:
.ndo_vlan_rx_add_vid
.ndo_vlan_rx_kill_vid
.ndo_validate_addr

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  7 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 10 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 62 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 41 ++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  2 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  6 ++
 6 files changed, 128 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 6071d2023a5d..1f6bf7be9c1e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -137,11 +137,17 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
 
 	nic_dev->rx_buf_len = HINIC3_RX_BUF_LEN;
 	nic_dev->lro_replenish_thld = HINIC3_LRO_REPLENISH_THLD;
+	nic_dev->vlan_bitmap = kzalloc(HINIC3_VLAN_BITMAP_SIZE(nic_dev),
+				       GFP_KERNEL);
+	if (!nic_dev->vlan_bitmap)
+		return -ENOMEM;
+
 	nic_dev->nic_svc_cap = hwdev->cfg_mgmt->cap.nic_svc_cap;
 
 	nic_dev->workq = create_singlethread_workqueue(HINIC3_NIC_DEV_WQ_NAME);
 	if (!nic_dev->workq) {
 		dev_err(hwdev->dev, "Failed to initialize nic workqueue\n");
+		kfree(nic_dev->vlan_bitmap);
 		return -ENOMEM;
 	}
 
@@ -335,6 +341,7 @@ static void hinic3_nic_event(struct auxiliary_device *adev,
 static void hinic3_free_nic_dev(struct hinic3_nic_dev *nic_dev)
 {
 	destroy_workqueue(nic_dev->workq);
+	kfree(nic_dev->vlan_bitmap);
 }
 
 static int hinic3_nic_probe(struct auxiliary_device *adev,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 69405715e734..60f47152c01d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -56,6 +56,15 @@ struct l2nic_cmd_update_mac {
 	u8                   new_mac[ETH_ALEN];
 };
 
+struct l2nic_cmd_vlan_config {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u16                  vlan_id;
+	u16                  rsvd2;
+};
+
 struct l2nic_cmd_vlan_offload {
 	struct mgmt_msg_head msg_head;
 	u16                  func_id;
@@ -205,6 +214,7 @@ enum l2nic_cmd {
 	L2NIC_CMD_SET_MAC             = 21,
 	L2NIC_CMD_DEL_MAC             = 22,
 	L2NIC_CMD_UPDATE_MAC          = 23,
+	L2NIC_CMD_CFG_FUNC_VLAN       = 25,
 	L2NIC_CMD_SET_VLAN_FILTER_EN  = 26,
 	L2NIC_CMD_SET_RX_VLAN_OFFLOAD = 27,
 	L2NIC_CMD_CFG_RSS             = 60,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 87ada13b8f96..74b2ce9e3a0a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -17,6 +17,12 @@
 #define HINIC3_LRO_DEFAULT_COAL_PKT_SIZE  32
 #define HINIC3_LRO_DEFAULT_TIME_LIMIT     16
 
+#define VLAN_BITMAP_BITS_SIZE(nic_dev)    (sizeof(*(nic_dev)->vlan_bitmap) * 8)
+#define VID_LINE(nic_dev, vid)  \
+	((vid) / VLAN_BITMAP_BITS_SIZE(nic_dev))
+#define VID_COL(nic_dev, vid)  \
+	((vid) & (VLAN_BITMAP_BITS_SIZE(nic_dev) - 1))
+
 /* try to modify the number of irq to the target number,
  * and return the actual number of irq.
  */
@@ -688,6 +694,59 @@ static int hinic3_set_mac_addr(struct net_device *netdev, void *addr)
 	return 0;
 }
 
+static int hinic3_vlan_rx_add_vid(struct net_device *netdev,
+				  __be16 proto, u16 vid)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned long *vlan_bitmap = nic_dev->vlan_bitmap;
+	u32 column, row;
+	u16 func_id;
+	int err;
+
+	column = VID_COL(nic_dev, vid);
+	row = VID_LINE(nic_dev, vid);
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	err = hinic3_add_vlan(nic_dev->hwdev, vid, func_id);
+	if (err) {
+		netdev_err(netdev, "Failed to add vlan %u\n", vid);
+		goto out;
+	}
+
+	set_bit(column, &vlan_bitmap[row]);
+	netdev_dbg(netdev, "Add vlan %u\n", vid);
+
+out:
+	return err;
+}
+
+static int hinic3_vlan_rx_kill_vid(struct net_device *netdev,
+				   __be16 proto, u16 vid)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned long *vlan_bitmap = nic_dev->vlan_bitmap;
+	u32 column, row;
+	u16 func_id;
+	int err;
+
+	column  = VID_COL(nic_dev, vid);
+	row = VID_LINE(nic_dev, vid);
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_del_vlan(nic_dev->hwdev, vid, func_id);
+	if (err) {
+		netdev_err(netdev, "Failed to delete vlan %u\n", vid);
+		goto out;
+	}
+
+	clear_bit(column, &vlan_bitmap[row]);
+	netdev_dbg(netdev, "Remove vlan %u\n", vid);
+
+out:
+	return err;
+}
+
 static void hinic3_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -771,6 +830,9 @@ static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_features_check   = hinic3_features_check,
 	.ndo_change_mtu       = hinic3_change_mtu,
 	.ndo_set_mac_address  = hinic3_set_mac_addr,
+	.ndo_validate_addr    = eth_validate_addr,
+	.ndo_vlan_rx_add_vid  = hinic3_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = hinic3_vlan_rx_kill_vid,
 	.ndo_tx_timeout       = hinic3_tx_timeout,
 	.ndo_get_stats64      = hinic3_get_stats64,
 	.ndo_start_xmit       = hinic3_xmit_frame,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 79494ac8f395..918882deea87 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -10,6 +10,9 @@
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_io.h"
 
+#define MGMT_MSG_CMD_OP_ADD  1
+#define MGMT_MSG_CMD_OP_DEL  0
+
 static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
 			       u64 *s_feature, u16 size)
 {
@@ -496,6 +499,44 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 	return pkt_drop.msg_head.status;
 }
 
+static int hinic3_config_vlan(struct hinic3_hwdev *hwdev,
+			      u8 opcode, u16 vlan_id, u16 func_id)
+{
+	struct l2nic_cmd_vlan_config vlan_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	vlan_info.opcode = opcode;
+	vlan_info.func_id = func_id;
+	vlan_info.vlan_id = vlan_id;
+
+	mgmt_msg_params_init_default(&msg_params, &vlan_info,
+				     sizeof(vlan_info));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_FUNC_VLAN, &msg_params);
+
+	if (err || vlan_info.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to %s vlan, err: %d, status: 0x%x\n",
+			opcode == MGMT_MSG_CMD_OP_ADD ? "add" : "delete",
+			err, vlan_info.msg_head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id)
+{
+	return hinic3_config_vlan(hwdev, MGMT_MSG_CMD_OP_ADD, vlan_id, func_id);
+}
+
+int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id)
+{
+	return hinic3_config_vlan(hwdev, MGMT_MSG_CMD_OP_DEL, vlan_id, func_id);
+}
+
 int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable)
 {
 	struct mag_cmd_set_port_enable en_state = {};
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index a17cd56bce71..84831c87507b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -83,5 +83,7 @@ int hinic3_set_port_enable(struct hinic3_hwdev *hwdev, bool enable);
 int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
 int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id,
 			    bool enable);
+int hinic3_add_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
+int hinic3_del_vlan(struct hinic3_hwdev *hwdev, u16 vlan_id, u16 func_id);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index a8e92e070d9e..6e48c29566e1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -4,12 +4,17 @@
 #ifndef _HINIC3_NIC_DEV_H_
 #define _HINIC3_NIC_DEV_H_
 
+#include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 
 #include "hinic3_hw_cfg.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_mgmt_interface.h"
 
+#define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
+#define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
+	(VLAN_N_VID / HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev))
+
 enum hinic3_flags {
 	HINIC3_RSS_ENABLE,
 };
@@ -71,6 +76,7 @@ struct hinic3_nic_dev {
 	u16                             max_qps;
 	u16                             rx_buf_len;
 	u32                             lro_replenish_thld;
+	unsigned long                   *vlan_bitmap;
 	unsigned long                   flags;
 	struct hinic3_nic_service_cap   nic_svc_cap;
 
-- 
2.43.0


