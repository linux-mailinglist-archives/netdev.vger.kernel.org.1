Return-Path: <netdev+bounces-196786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B8AD6584
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93731BC39AF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34296223DD6;
	Thu, 12 Jun 2025 02:21:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760542206BB;
	Thu, 12 Jun 2025 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694864; cv=none; b=aIDqw6iWxdE+yAfh24g5T4InmCnCVaE/6UaE7vQTMLC1e9q0LnAVl4pI/25HlSLGJByj89HZS0s+IohIu9prEhj4otlU4Cu7fTgbvWCo2123rjMMwEMxvPGwi7ef0KEr/I2eidHO4BnJkvO+uu5WUc1kP3gtmCLr64dnNBI6Wtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694864; c=relaxed/simple;
	bh=/1hcgqOT8iLgbTiavdVRn232oc00cA0HHTfP5GUc+XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUw/ZSy3b2kNm8OrPv7U+AzlzHU8MbOiSN3RUDK3/BLisiPWQsRGN2ETW/nLarfF1nAz+88LxvSqwd4EuzZL3D1OipAKvKudkxRmbtE4/jEwUBH7gM2Sty0mhrwCstO4wr5Y0gDvWAYVLVWPhx1mj4sK2CStORPwt+IPLwszrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bHmSP5v6Hz2TSNb;
	Thu, 12 Jun 2025 10:19:33 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B3C9140277;
	Thu, 12 Jun 2025 10:20:54 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 10:20:53 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 8/8] net: hns3: clear hns alarm: comparison of integer expressions of different signedness
Date: Thu, 12 Jun 2025 10:13:17 +0800
Message-ID: <20250612021317.1487943-9-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250612021317.1487943-1-shaojijie@huawei.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Peiyang Wang <wangpeiyang1@huawei.com>

A static alarm exists in the hns and needs to be cleared.

The alarm is comparison of integer expressions of different
signedness including 's64' and 'long unsigned int',
'int' and 'long unsigned int', 'u32' and 'int',
'int' and 'unsigned int'.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hns3/hns3_common/hclge_comm_cmd.c         |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 22 +++++++-------
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  4 +--
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 13 ++++----
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 30 +++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         |  7 +++--
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       |  2 +-
 11 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index 4ad4e8ab2f1f..37396ca4ecfc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -348,7 +348,7 @@ static int hclge_comm_cmd_csq_clean(struct hclge_comm_hw *hw)
 static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
 {
 	u32 head = hclge_comm_read_dev(hw, HCLGE_COMM_NIC_CSQ_HEAD_REG);
-	return head == hw->cmq.csq.next_to_use;
+	return head == (u32)hw->cmq.csq.next_to_use;
 }
 
 static u32 hclge_get_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a91bd2e50138..ef302243f0d5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1690,8 +1690,8 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, dma_addr_t dma,
 #define HNS3_LIKELY_BD_NUM	1
 
 	struct hns3_desc *desc = &ring->desc[ring->next_to_use];
-	unsigned int frag_buf_num;
-	int k, sizeoflast;
+	unsigned int frag_buf_num, k;
+	int sizeoflast;
 
 	if (likely(size <= HNS3_MAX_BD_SIZE)) {
 		desc->addr = cpu_to_le64(dma);
@@ -1863,7 +1863,7 @@ static bool hns3_skb_need_linearized(struct sk_buff *skb, unsigned int *bd_size,
 				     unsigned int bd_num, u8 max_non_tso_bd_num)
 {
 	unsigned int tot_len = 0;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < max_non_tso_bd_num - 1U; i++)
 		tot_len += bd_size[i];
@@ -1891,7 +1891,7 @@ static bool hns3_skb_need_linearized(struct sk_buff *skb, unsigned int *bd_size,
 
 void hns3_shinfo_pack(struct skb_shared_info *shinfo, __u32 *size)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < MAX_SKB_FRAGS; i++)
 		size[i] = skb_frag_size(&shinfo->frags[i]);
@@ -2207,9 +2207,9 @@ static int hns3_handle_tx_sgl(struct hns3_enet_ring *ring,
 	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
 	u32 nfrag = skb_shinfo(skb)->nr_frags + 1;
 	struct sg_table *sgt;
-	int i, bd_num = 0;
+	int bd_num = 0;
 	dma_addr_t dma;
-	u32 cb_len;
+	u32 cb_len, i;
 	int nents;
 
 	if (skb_has_frag_list(skb))
@@ -2544,7 +2544,7 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 	struct hnae3_handle *handle = priv->ae_handle;
 	struct rtnl_link_stats64 ring_total_stats;
 	struct hns3_enet_ring *ring;
-	unsigned int idx;
+	int idx;
 
 	if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
 		return;
@@ -2770,7 +2770,7 @@ static int hns3_nic_change_mtu(struct net_device *netdev, int new_mtu)
 
 static int hns3_get_timeout_queue(struct net_device *ndev)
 {
-	int i;
+	unsigned int i;
 
 	/* Find the stopped queue the same way the stack does */
 	for (i = 0; i < ndev->num_tx_queues; i++) {
@@ -2851,7 +2851,7 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 	struct hns3_enet_ring *tx_ring;
-	int timeout_queue;
+	u32 timeout_queue;
 
 	timeout_queue = hns3_get_timeout_queue(ndev);
 	if (timeout_queue >= ndev->num_tx_queues) {
@@ -3821,7 +3821,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 {
 	__be16 type = skb->protocol;
 	struct tcphdr *th;
-	int depth = 0;
+	u32 depth = 0;
 
 	while (eth_type_vlan(type)) {
 		struct vlan_hdr *vh;
@@ -5934,7 +5934,7 @@ static const struct hns3_hw_error_info hns3_hw_err[] = {
 static void hns3_process_hw_error(struct hnae3_handle *handle,
 				  enum hnae3_hw_error_type type)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(hns3_hw_err); i++) {
 		if (hns3_hw_err[i].type == type) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index dd61ddd8f904..d3bad5d1b888 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -621,7 +621,7 @@ struct hns3_reset_type_map {
 	enum hnae3_reset_type rst_type;
 };
 
-static inline int ring_space(struct hns3_enet_ring *ring)
+static inline u32 ring_space(struct hns3_enet_ring *ring)
 {
 	/* This smp_load_acquire() pairs with smp_store_release() in
 	 * hns3_nic_reclaim_one_desc called by hns3_clean_tx_ring.
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 0d6db46db5ed..549b0382921d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -542,7 +542,7 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops = hns3_get_ops(h);
-	int i;
+	u32 i;
 
 	if (!ops->get_strings)
 		return;
@@ -570,7 +570,7 @@ static u64 *hns3_get_stats_tqps(struct hnae3_handle *handle, u64 *data)
 	struct hns3_nic_priv *nic_priv = handle->priv;
 	struct hns3_enet_ring *ring;
 	u8 *stat;
-	int i, j;
+	u32 i, j;
 
 	/* get stats for Tx */
 	for (i = 0; i < kinfo->num_tqps; i++) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 21deec217668..f130020a1227 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -830,10 +830,10 @@ hclge_dbg_dump_reg_tqp(struct hclge_dev *hdev,
 {
 	const struct hclge_dbg_dfx_message *dfx_message = reg_info->dfx_msg;
 	const struct hclge_dbg_reg_common_msg *reg_msg = &reg_info->reg_msg;
+	u32 index, entry, i, cnt, min_num;
 	struct hclge_desc *desc_src;
-	u32 index, entry, i, cnt;
-	int bd_num, min_num, ret;
 	struct hclge_desc *desc;
+	int bd_num, ret;
 
 	ret = hclge_dbg_get_dfx_bd_num(hdev, reg_msg->offset, &bd_num);
 	if (ret)
@@ -885,9 +885,9 @@ hclge_dbg_dump_reg_common(struct hclge_dev *hdev,
 	const struct hclge_dbg_reg_common_msg *reg_msg = &reg_info->reg_msg;
 	const struct hclge_dbg_dfx_message *dfx_message = reg_info->dfx_msg;
 	struct hclge_desc *desc_src;
-	int bd_num, min_num, ret;
+	int bd_num, min_num, ret, i;
 	struct hclge_desc *desc;
-	u32 entry, i;
+	u32 entry;
 
 	ret = hclge_dbg_get_dfx_bd_num(hdev, reg_msg->offset, &bd_num);
 	if (ret)
@@ -1279,7 +1279,7 @@ static int hclge_dbg_dump_reg_cmd(struct hclge_dev *hdev,
 {
 	const struct hclge_dbg_reg_type_info *reg_info;
 	int pos = 0, ret = 0;
-	int i;
+	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(hclge_dbg_reg_info); i++) {
 		reg_info = &hclge_dbg_reg_info[i];
@@ -2648,9 +2648,8 @@ static void hclge_dbg_dump_mac_list(struct hclge_dev *hdev, char *buf, int len,
 	struct hclge_mac_node *mac_node, *tmp;
 	struct hclge_vport *vport;
 	struct list_head *list;
-	u32 func_id;
+	u32 func_id, i;
 	int pos = 0;
-	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mac_list_items); i++)
 		result[i] = &data_str[i][0];
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ddd11a575c2a..ef8ec00b2caa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -582,7 +582,7 @@ static u64 *hclge_comm_get_stats(struct hclge_dev *hdev,
 				 int size, u64 *data)
 {
 	u64 *buf = data;
-	u32 i;
+	int i;
 
 	for (i = 0; i < size; i++) {
 		if (strs[i].stats_num > hdev->ae_dev->dev_specs.mac_stats_num)
@@ -599,7 +599,7 @@ static void hclge_comm_get_strings(struct hclge_dev *hdev, u32 stringset,
 				   const struct hclge_comm_stats_str strs[],
 				   int size, u8 **data)
 {
-	u32 i;
+	int i;
 
 	if (stringset != ETH_SS_STATS)
 		return;
@@ -2624,7 +2624,7 @@ int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex, u8 lan
 	int ret;
 
 	duplex = hclge_check_speed_dup(duplex, speed);
-	if (!mac->support_autoneg && mac->speed == speed &&
+	if (!mac->support_autoneg && mac->speed == (u32)speed &&
 	    mac->duplex == duplex && (mac->lane_num == lane_num || lane_num == 0))
 		return 0;
 
@@ -2652,7 +2652,7 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 	if (ret)
 		return ret;
 
-	hdev->hw.mac.req_speed = speed;
+	hdev->hw.mac.req_speed = (u32)speed;
 	hdev->hw.mac.req_duplex = duplex;
 
 	return 0;
@@ -3446,7 +3446,7 @@ static int hclge_tp_port_init(struct hclge_dev *hdev)
 static int hclge_update_port_info(struct hclge_dev *hdev)
 {
 	struct hclge_mac *mac = &hdev->hw.mac;
-	int speed;
+	u32 speed;
 	int ret;
 
 	/* get the port info from SFP cmd if not copper port */
@@ -6991,7 +6991,7 @@ static int hclge_get_all_rules(struct hnae3_handle *handle,
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_fd_rule *rule;
 	struct hlist_node *node2;
-	int cnt = 0;
+	u32 cnt = 0;
 
 	if (!hnae3_ae_dev_fd_supported(hdev->ae_dev))
 		return -EOPNOTSUPP;
@@ -8225,14 +8225,14 @@ static int hclge_update_desc_vfid(struct hclge_desc *desc, int vfid, bool clr)
 		word_num = vfid / 32;
 		bit_num  = vfid % 32;
 		if (clr)
-			desc[1].data[word_num] &= cpu_to_le32(~(1 << bit_num));
+			desc[1].data[word_num] &= cpu_to_le32(~(1U << bit_num));
 		else
 			desc[1].data[word_num] |= cpu_to_le32(1 << bit_num);
 	} else {
 		word_num = (vfid - HCLGE_VF_NUM_IN_FIRST_DESC) / 32;
 		bit_num  = vfid % 32;
 		if (clr)
-			desc[2].data[word_num] &= cpu_to_le32(~(1 << bit_num));
+			desc[2].data[word_num] &= cpu_to_le32(~(1U << bit_num));
 		else
 			desc[2].data[word_num] |= cpu_to_le32(1 << bit_num);
 	}
@@ -9296,7 +9296,7 @@ static int hclge_add_mgr_tbl(struct hclge_dev *hdev,
 static int init_mgr_tbl(struct hclge_dev *hdev)
 {
 	int ret;
-	int i;
+	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(hclge_mgr_table); i++) {
 		ret = hclge_add_mgr_tbl(hdev, &hclge_mgr_table[i]);
@@ -10717,7 +10717,7 @@ int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu)
 	max_frm_size = max(max_frm_size, HCLGE_MAC_DEFAULT_FRAME);
 	mutex_lock(&hdev->vport_lock);
 	/* VF's mps must fit within hdev->mps */
-	if (vport->vport_id && max_frm_size > hdev->mps) {
+	if (vport->vport_id && (u32)max_frm_size > hdev->mps) {
 		mutex_unlock(&hdev->vport_lock);
 		return -EINVAL;
 	} else if (vport->vport_id) {
@@ -10728,7 +10728,7 @@ int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu)
 
 	/* PF's mps must be greater then VF's mps */
 	for (i = 1; i < hdev->num_alloc_vport; i++)
-		if (max_frm_size < hdev->vport[i].mps) {
+		if ((u32)max_frm_size < hdev->vport[i].mps) {
 			dev_err(&hdev->pdev->dev,
 				"failed to set pf mtu for less than vport %d, mps = %u.\n",
 				i, hdev->vport[i].mps);
@@ -11218,7 +11218,7 @@ static int hclge_init_nic_client_instance(struct hnae3_ae_dev *ae_dev,
 {
 	struct hnae3_client *client = vport->nic.client;
 	struct hclge_dev *hdev = ae_dev->priv;
-	int rst_cnt = hdev->rst_stats.reset_cnt;
+	u32 rst_cnt = hdev->rst_stats.reset_cnt;
 	int ret;
 
 	ret = client->ops->init_instance(&vport->nic);
@@ -11262,7 +11262,7 @@ static int hclge_init_roce_client_instance(struct hnae3_ae_dev *ae_dev,
 {
 	struct hclge_dev *hdev = ae_dev->priv;
 	struct hnae3_client *client;
-	int rst_cnt;
+	u32 rst_cnt;
 	int ret;
 
 	if (!hnae3_dev_roce_supported(hdev) || !hdev->roce_client ||
@@ -12092,7 +12092,7 @@ static int hclge_vf_rate_param_check(struct hclge_dev *hdev,
 				     int min_tx_rate, int max_tx_rate)
 {
 	if (min_tx_rate != 0 ||
-	    max_tx_rate < 0 || max_tx_rate > hdev->hw.mac.max_speed) {
+	    max_tx_rate < 0 || (u32)max_tx_rate > hdev->hw.mac.max_speed) {
 		dev_err(&hdev->pdev->dev,
 			"min_tx_rate:%d [0], max_tx_rate:%d [0, %u]\n",
 			min_tx_rate, max_tx_rate, hdev->hw.mac.max_speed);
@@ -12117,7 +12117,7 @@ static int hclge_set_vf_rate(struct hnae3_handle *handle, int vf,
 	if (!vport)
 		return -EINVAL;
 
-	if (!force && max_tx_rate == vport->vf_info.max_tx_rate)
+	if (!force && (u32)max_tx_rate == vport->vf_info.max_tx_rate)
 		return 0;
 
 	ret = hclge_tm_qs_shaper_cfg(vport, max_tx_rate);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 59c863306657..c7ff12a6c076 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -749,16 +749,17 @@ static int hclge_get_rss_key(struct hclge_vport *vport,
 #define HCLGE_RSS_MBX_RESP_LEN	8
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_comm_rss_cfg *rss_cfg;
+	int rss_hash_key_size;
 	u8 index;
 
 	index = mbx_req->msg.data[0];
 	rss_cfg = &hdev->rss_cfg;
+	rss_hash_key_size = sizeof(rss_cfg->rss_hash_key);
 
 	/* Check the query index of rss_hash_key from VF, make sure no
 	 * more than the size of rss_hash_key.
 	 */
-	if (((index + 1) * HCLGE_RSS_MBX_RESP_LEN) >
-	      sizeof(rss_cfg->rss_hash_key)) {
+	if (((index + 1) * HCLGE_RSS_MBX_RESP_LEN) > rss_hash_key_size) {
 		dev_warn(&hdev->pdev->dev,
 			 "failed to get the rss hash key, the index(%u) invalid !\n",
 			 index);
@@ -800,7 +801,7 @@ static void hclge_handle_link_change_event(struct hclge_dev *hdev,
 
 static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
 {
-	u32 tail = hclge_read_dev(hw, HCLGE_COMM_NIC_CRQ_TAIL_REG);
+	int tail = hclge_read_dev(hw, HCLGE_COMM_NIC_CRQ_TAIL_REG);
 
 	return tail == hw->hw.cmq.crq.next_to_use;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 9a456ebf9b7c..96553109f44c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -151,7 +151,7 @@ int hclge_mac_mdio_config(struct hclge_dev *hdev)
 
 	mdio_bus->parent = &hdev->pdev->dev;
 	mdio_bus->priv = hdev;
-	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
+	mdio_bus->phy_mask = ~(1U << mac->phy_addr);
 	ret = mdiobus_register(mdio_bus);
 	if (ret) {
 		dev_err(mdio_bus->parent,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h
index 63483636c074..61faddcc3dd0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h
@@ -25,7 +25,7 @@ struct ifreq;
 #define HCLGE_PTP_TIME_SEC_H_MASK	GENMASK(15, 0)
 #define HCLGE_PTP_TIME_SEC_L_REG	0x54
 #define HCLGE_PTP_TIME_NSEC_REG		0x58
-#define HCLGE_PTP_TIME_NSEC_MASK	GENMASK(29, 0)
+#define HCLGE_PTP_TIME_NSEC_MASK	0x3fffffffLL
 #define HCLGE_PTP_TIME_NSEC_NEG		BIT(31)
 #define HCLGE_PTP_TIME_SYNC_REG		0x5C
 #define HCLGE_PTP_TIME_SYNC_EN		BIT(0)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index d1883ec7f8cf..052cb9e2d01d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2469,7 +2469,7 @@ static int hclgevf_init_nic_client_instance(struct hnae3_ae_dev *ae_dev,
 					    struct hnae3_client *client)
 {
 	struct hclgevf_dev *hdev = ae_dev->priv;
-	int rst_cnt = hdev->rst_stats.rst_cnt;
+	u32 rst_cnt = hdev->rst_stats.rst_cnt;
 	int ret;
 
 	ret = client->ops->init_instance(&hdev->nic);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 85c2a634c8f9..f5c99ca54369 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -159,7 +159,7 @@ static bool hclgevf_cmd_crq_empty(struct hclgevf_hw *hw)
 {
 	u32 tail = hclgevf_read_dev(hw, HCLGE_COMM_NIC_CRQ_TAIL_REG);
 
-	return tail == hw->hw.cmq.crq.next_to_use;
+	return tail == (u32)hw->hw.cmq.crq.next_to_use;
 }
 
 static void hclgevf_handle_mbx_response(struct hclgevf_dev *hdev,
-- 
2.33.0


