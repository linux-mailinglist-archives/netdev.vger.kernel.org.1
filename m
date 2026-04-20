Return-Path: <netdev+bounces-279629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK1xAAyO5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476D426381
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DB03048572
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C6379980;
	Mon, 20 Apr 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="D26y+2gg"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC05377574;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651659; cv=none; b=slzlm7TZ+YglIN+/pZ5NlVWxoaSAUmJrdHCSESKYrhrDGJTo5t+gAP61HjpIfgDzCk4PoSIU9TBkaCIDQrxzI4VMSt8P0+GY6UqPyNWnfwoq5bYspQ2pmYtJB5Mu7c6cJbQN+N4hzxx7NqQYHq4l/hrn1RE0Mk2GebER7jn7/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651659; c=relaxed/simple;
	bh=9uTKNSP7e2S1OSDwRNMMw7aisjqpienkyGsNONMrOIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgE3Zr7LXH+opV9pCgR/ySwaEi4/gdk/xE2lN/Jpu85XYEqS3QIKYePqCn5avXOvHCWWDvoR7/D8+6x6ixcdqC8nugvuUSp6XSc1HBnLaBL0Knz19mG34kabEsUZyEMAozPFU7Zjd+eJKxtXzsqv6MJtcJmqZQEmKHpijGhvxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=D26y+2gg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KFBm8277433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651615;
	bh=oiLdHzuUFpkCR2n4q9jI1qPtuuW7sT+noFPY++D9neM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=D26y+2gg4BdlI77D5yEu1bv2exystq95MyttVxBxLb5Wa7V2figqxw6pEIBpeb4RK
	 W08Yl59ABpdCjWWjYS03tOjR2Fig7OjV29KDcxS6gopEddPNOVQ5J1hvPmBE2pMzoS
	 xWUb7PUb0+WDBuMIBpdv1Dm9kKFK2YIcUGYy5svLM5v3z0RSRiHtiLjZEqo4IZbNiy
	 N4+6ecviIRhEvp/A7wcQnYO9fxEAia1x4c5Zhuta+zM3uEMDFtNYwDa5c2lgQymEOS
	 nxNBnd5MufNzCVFyNzk2JzIovsOTUSWojpqeoxgQ2411riJcu8kBoQlXqpxCCZlKLQ
	 lPCHOMl/vlooA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KFBm8277433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:15 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 10:20:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:14 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 7/9] r8169: add support and enable rss
Date: Mon, 20 Apr 2026 10:19:55 +0800
Message-ID: <20260420021957.1756-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279629-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Queue-Id: 9476D426381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support and enable rss for RTL8127. We remove the
setting nvecs 1 to support multi queue and rss.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 340 ++++++++++++++++++++--
 1 file changed, 321 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 622ee8905a05..b3f15e6fd5e9 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -718,6 +718,21 @@ struct RxDesc {
 	__le64 addr;
 };
 
+struct RxDescRss {
+	union {
+		__le64 addr;
+		struct {
+			__le32 RSSInfo;
+			__le32 RSSResult;
+		} RxDescRSSDWord;
+	};
+
+	struct {
+		__le32 opts2;
+		__le32 opts1;
+	} RxDescOpts;
+};
+
 enum features {
 	RTL_FEATURE_MSI		= (1 << 1),
 	RTL_FEATURE_MSIX	= (1 << 2),
@@ -853,9 +868,13 @@ struct rtl8169_private {
 	u16 imr_reg[R8169_MAX_MSIX_VEC];
 	unsigned int num_tx_rings;
 	unsigned int num_rx_rings;
+	u32 rss_flags;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u8 rss_key[RTL8127_RSS_KEY_SIZE];
+	u8 rss_indir_tbl[RTL8127_MAX_INDIRECTION_TABLE_ENTRIES];
+	u8 HwSuppIndirTblEntries;
 	u16 HwSuppNumTxQueues;
 	u16 HwSuppNumRxQueues;
 	u8 min_irq_nvecs;
@@ -1698,6 +1717,13 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	}
 }
 
+static bool rtl_check_rss_support(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		return true;
+	return false;
+}
+
 static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
@@ -2001,9 +2027,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
 		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
 }
 
-static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
+static void rtl8169_rx_vlan_tag(struct rtl8169_private *tp,
+				struct RxDesc *desc,
+				struct sk_buff *skb)
 {
-	u32 opts2 = le32_to_cpu(desc->opts2);
+	u32 opts2;
+
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		opts2 = le32_to_cpu(((struct RxDescRss *)desc)->RxDescOpts.opts2);
+		break;
+	default:
+		opts2 = le32_to_cpu(desc->opts2);
+		break;
+	}
 
 	if (opts2 & RxVlanTag)
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
@@ -2884,6 +2921,14 @@ static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
 		tp->imr_reg[i] = (u16)(IntrMask1_8125 + (i - 1) * 4);
 }
 
+static void rtl8169_init_rss(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->HwSuppIndirTblEntries; i++)
+		tp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+
+	netdev_rss_key_fill(tp->rss_key, RTL8127_RSS_KEY_SIZE);
+}
+
 static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 {
 	tp->num_rx_rings = 1;
@@ -2895,6 +2940,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 		tp->max_irq_nvecs = R8127_MAX_IRQ;
 		tp->HwSuppNumTxQueues = R8127_MAX_TX_QUEUES;
 		tp->HwSuppNumRxQueues = R8127_MAX_RX_QUEUES;
+		tp->HwSuppIndirTblEntries = RTL8127_MAX_INDIRECTION_TABLE_ENTRIES;
 		tp->HwSuppIsrVer = 6;
 		break;
 	default:
@@ -2908,10 +2954,6 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 	tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
 	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
 
-	/* This just force nvecs, and will be remove in the following patch*/
-	tp->min_irq_nvecs = 1;
-	tp->max_irq_nvecs = 1;
-
 	rtl_setup_mqs_reg(tp);
 	rtl_set_ring_size(tp, NUM_RX_DESC, NUM_TX_DESC);
 }
@@ -3038,6 +3080,76 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
 }
 
+static void rtl8169_store_rss_key(struct rtl8169_private *tp)
+{
+	const u16 rss_key_reg = RSS_KEY_8125;
+	u32 i, rss_key_size = sizeof(tp->rss_key);
+	u32 *rss_key = (u32 *)tp->rss_key;
+
+	/* Write redirection table to HW */
+	for (i = 0; i < rss_key_size; i += 4)
+		RTL_W32(tp, rss_key_reg + i, *rss_key++);
+}
+
+static void rtl8169_store_reta(struct rtl8169_private *tp)
+{
+	u16 indir_tbl_reg = RSS_INDIRECTION_TBL_8125_V2;
+	u32 i, reta_entries = tp->HwSuppIndirTblEntries;
+	u32 reta = 0;
+	u8 *indir_tbl = tp->rss_indir_tbl;
+
+	/* Write redirection table to HW */
+	for (i = 0; i < reta_entries; i++) {
+		reta |= indir_tbl[i] << (i & 0x3) * 8;
+		if ((i & 3) == 3) {
+			RTL_W32(tp, indir_tbl_reg, reta);
+			indir_tbl_reg += 4;
+			reta = 0;
+		}
+	}
+}
+
+static int rtl8169_set_rss_hash_opt(struct rtl8169_private *tp)
+{
+	u32 rss_flags = tp->rss_flags;
+	u32 hash_mask_len;
+	u32 rss_ctrl;
+
+	rss_ctrl = ilog2(tp->num_rx_rings);
+	rss_ctrl &= (BIT(0) | BIT(1) | BIT(2));
+	rss_ctrl <<= RSS_CPU_NUM_OFFSET;
+
+	/* Perform hash on these packet types */
+	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP
+		 | RSS_CTRL_IPV4_SUPP
+		 | RSS_CTRL_IPV6_SUPP
+		 | RSS_CTRL_IPV6_EXT_SUPP
+		 | RSS_CTRL_TCP_IPV6_SUPP
+		 | RSS_CTRL_TCP_IPV6_EXT_SUPP;
+
+	if (rss_flags & RTL_8125_RSS_FLAG_HASH_UDP_IPV4)
+		rss_ctrl |= RSS_CTRL_UDP_IPV4_SUPP;
+
+	if (rss_flags & RTL_8125_RSS_FLAG_HASH_UDP_IPV6)
+		rss_ctrl |= RSS_CTRL_UDP_IPV6_SUPP |
+			    RSS_CTRL_UDP_IPV6_EXT_SUPP;
+
+	hash_mask_len = ilog2(tp->HwSuppIndirTblEntries);
+	hash_mask_len &= (BIT(0) | BIT(1) | BIT(2));
+	rss_ctrl |= hash_mask_len << RSS_MASK_BITS_OFFSET;
+
+	RTL_W32(tp, RSS_CTRL_8125, rss_ctrl);
+
+	return 0;
+}
+
+static void rtl_set_rss_config(struct rtl8169_private *tp)
+{
+	rtl8169_set_rss_hash_opt(tp);
+	rtl8169_store_reta(tp);
+	rtl8169_store_rss_key(tp);
+}
+
 static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 {
 	/*
@@ -4102,6 +4214,29 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8125_set_tx_q_num(struct rtl8169_private *tp)
+{
+	u16 mac_ocp_data;
+
+	mac_ocp_data = r8168_mac_ocp_read(tp, 0xe63e);
+	mac_ocp_data &= ~(BIT(11) | BIT(10));
+	mac_ocp_data |= ((ilog2(tp->num_tx_rings) & 0x03) << 10);
+	r8168_mac_ocp_write(tp, 0xe63e, mac_ocp_data);
+}
+
+static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
+{
+	u16 q_ctrl;
+	u16 rx_q_num;
+
+	rx_q_num = (u16)ilog2(tp->num_rx_rings);
+	rx_q_num &= (BIT(0) | BIT(1) | BIT(2));
+	rx_q_num <<= 2;
+	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
+	q_ctrl &= ~(BIT(2) | BIT(3) | BIT(4));
+	q_ctrl |= rx_q_num;
+	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
+}
 
 static void rtl8125_hw_set_interrupt_type(struct rtl8169_private *tp)
 {
@@ -4142,6 +4277,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
+	/* enable rx descriptor type v4 and set queue num for rss*/
+	if (tp->rss_enable) {
+		rtl8125_set_rx_q_num(tp);
+		rtl8125_set_tx_q_num(tp);
+		RTL_W8(tp, 0xd8, RTL_R8(tp, 0xd8) | 0x02);
+	}
+
 	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
@@ -4378,6 +4520,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
 	rtl_hw_aspm_clkreq_enable(tp, true);
 	rtl_set_rx_max_size(tp);
 	rtl_set_rx_tx_desc_registers(tp);
+	if (rtl_is_8125(tp)) {
+		if (tp->rss_enable)
+			rtl_set_rss_config(tp);
+		else
+			RTL_W32(tp, RSS_CTRL_8125, 0x00);
+	}
 	rtl_lock_config_regs(tp);
 
 	rtl_jumbo_config(tp);
@@ -4405,6 +4553,16 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+static void rtl8169_mark_to_asic_rss(struct RxDescRss *descrss)
+{
+	u32 eor = le32_to_cpu(descrss->RxDescOpts.opts1) & RingEnd;
+
+	descrss->RxDescOpts.opts2 = 0;
+	/* Force memory writes to complete before releasing descriptor */
+	dma_wmb();
+	WRITE_ONCE(descrss->RxDescOpts.opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+}
+
 static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 {
 	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
@@ -4417,7 +4575,14 @@ static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 
 static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	rtl8169_mark_to_asic_default(desc);
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		rtl8169_mark_to_asic_rss((struct RxDescRss *)desc);
+		break;
+	default:
+		rtl8169_mark_to_asic_default(desc);
+		break;
+	}
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
@@ -4441,7 +4606,13 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	ring->RxDescPhyAddr[index] = mapping;
-	desc->addr = cpu_to_le64(mapping);
+	if (tp->InitRxDescType == RX_DESC_RING_TYPE_RSS) {
+		struct RxDescRss *descrss = (struct RxDescRss *)(ring->RxDescArray) + index;
+
+		descrss->addr = cpu_to_le64(mapping);
+	} else {
+		desc->addr = cpu_to_le64(mapping);
+	}
 	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
@@ -4468,9 +4639,21 @@ static void rtl8169_mark_as_last_descriptor_default(struct RxDesc *desc)
 	desc->opts1 |= cpu_to_le32(RingEnd);
 }
 
+static void rtl8169_mark_as_last_descriptor_rss(struct RxDescRss *descrss)
+{
+	descrss->RxDescOpts.opts1 |= cpu_to_le32(RingEnd);
+}
+
 static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	rtl8169_mark_as_last_descriptor_default(desc);
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		rtl8169_mark_as_last_descriptor_rss((struct RxDescRss *)desc);
+		break;
+	default:
+		rtl8169_mark_as_last_descriptor_default(desc);
+		break;
+	}
 }
 
 static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
@@ -5171,6 +5354,28 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
+static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
+				   struct RxDescRss *desc,
+				   struct sk_buff *skb)
+{
+	u32 rss_header_info;
+	u32 hash_val;
+
+	if (!(tp->dev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_header_info = le32_to_cpu(desc->RxDescRSSDWord.RSSInfo);
+
+	if (!(rss_header_info & RTL8127_RXS_RSS_L3_TYPE_MASK_V4))
+		return;
+
+	hash_val = le32_to_cpu(desc->RxDescRSSDWord.RSSResult);
+
+	skb_set_hash(skb, hash_val,
+		     (RTL8127_RXS_RSS_L4_TYPE_MASK_V4 & rss_header_info) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
+}
+
 static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
 					   struct sk_buff *skb,
 					   struct RxDesc *desc)
@@ -5183,16 +5388,41 @@ static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
 		skb_checksum_none_assert(skb);
 }
 
+static inline void rtl8169_rx_csum_rss(struct rtl8169_private *tp,
+				       struct sk_buff *skb,
+				       struct RxDescRss *descrss)
+{
+	u32 opts1 = le32_to_cpu(descrss->RxDescOpts.opts1);
+
+	if (((opts1 & RxTCPT_v4) && !(opts1 & RxTCPF_v4)) ||
+	    ((opts1 & RxUDPT_v4) && !(opts1 & RxUDPF_v4)))
+	    skb->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		skb_checksum_none_assert(skb);
+}
+
 static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
 				   struct sk_buff *skb,
 				   struct RxDesc *desc)
 {
-	rtl8169_rx_csum_default(tp, skb, desc);
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		rtl8169_rx_csum_rss(tp, skb, (struct RxDescRss *)desc);
+		break;
+	default:
+		rtl8169_rx_csum_default(tp, skb, desc);
+		break;
+	}
 }
 
 static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	return READ_ONCE(desc->opts1);
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		return READ_ONCE(((struct RxDescRss *)desc)->RxDescOpts.opts1);
+	default:
+		return READ_ONCE(desc->opts1);
+	}
 }
 
 static int rtl8169_check_rx_desc_error(struct net_device *dev,
@@ -5201,12 +5431,25 @@ static int rtl8169_check_rx_desc_error(struct net_device *dev,
 {
 	int ret = 0;
 
-	if (unlikely(status & RxRES)) {
-		if (status & (RxRWT | RxRUNT))
-			dev->stats.rx_length_errors++;
-		if (status & RxCRC)
-			dev->stats.rx_crc_errors++;
-		ret = -1;
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		if (unlikely(status & RxRES_RSS)) {
+			if (status & RxRUNT_RSS)
+				dev->stats.rx_length_errors++;
+			if (status & RxCRC_RSS)
+				dev->stats.rx_crc_errors++;
+			ret = -1;
+		}
+		break;
+	default:
+		if (unlikely(status & RxRES)) {
+			if (status & (RxRWT | RxRUNT))
+				dev->stats.rx_length_errors++;
+			if (status & RxCRC)
+				dev->stats.rx_crc_errors++;
+			ret = -1;
+		}
+		break;
 	}
 	return ret;
 }
@@ -5215,7 +5458,14 @@ static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
 					     struct RxDesc *desc,
 					     dma_addr_t mapping)
 {
-	desc->addr = cpu_to_le64(mapping);
+	switch (tp->InitRxDescType) {
+	case RX_DESC_RING_TYPE_RSS:
+		((struct RxDescRss *)desc)->addr = cpu_to_le64(mapping);
+		break;
+	default:
+		desc->addr = cpu_to_le64(mapping);
+		break;
+	}
 }
 
 static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
@@ -5291,10 +5541,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
+		if (tp->rss_enable)
+			rtl8169_rx_hash(tp, (struct RxDescRss *)desc, skb);
+
 		rtl8169_rx_csum(tp, skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
-		rtl8169_rx_vlan_tag(desc, skb);
+		rtl8169_rx_vlan_tag(tp, desc, skb);
 
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
@@ -5873,6 +6126,45 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_double_check_rss_support(struct rtl8169_private *tp)
+{
+	if (tp->HwCurrIsrVer > 1) {
+		if (!(tp->features & RTL_FEATURE_MSIX) || tp->irq_nvecs < tp->min_irq_nvecs)
+			tp->HwCurrIsrVer = 1;
+	}
+
+	if (tp->rss_support && tp->HwCurrIsrVer > 1) {
+		u8 rss_queue_num = netif_get_num_default_rss_queues();
+
+		tp->num_rx_rings = min(rss_queue_num, tp->HwSuppNumRxQueues);
+		if (!(tp->num_rx_rings >= 2 && tp->irq_nvecs >= tp->min_irq_nvecs))
+			tp->num_rx_rings = 1;
+	}
+
+	if (tp->num_rx_rings >= 2) {
+		tp->rss_enable = 1;
+		tp->InitRxDescType = RX_DESC_RING_TYPE_RSS;
+	} else {
+		tp->rss_enable = 0;
+		if (tp->irq_nvecs > 1) {
+			pci_free_irq_vectors(tp->pci_dev);
+
+			tp->irq_nvecs = pci_alloc_irq_vectors(tp->pci_dev, 1, 1, PCI_IRQ_ALL_TYPES);
+
+			if (tp->irq_nvecs > 0) {
+				tp->irq = pci_irq_vector(tp->pci_dev, 0);
+			} else {
+				tp->irq = tp->pci_dev->irq;
+				tp->irq_nvecs = 1;
+			}
+
+			tp->features &= ~RTL_FEATURE_MSIX;
+			if (pci_dev_msi_enabled(tp->pci_dev))
+				tp->features |= RTL_FEATURE_MSI;
+		}
+	}
+}
+
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -6346,6 +6638,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
+	tp->rss_support = rtl_check_rss_support(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -6367,6 +6660,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
+	rtl8169_double_check_rss_support(tp);
+
+	if (tp->rss_support)
+		rtl8169_init_rss(tp);
 
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
@@ -6388,6 +6685,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
+	if (tp->rss_support) {
+		dev->hw_features |= NETIF_F_RXHASH;
+		dev->features |= NETIF_F_RXHASH;
+	}
+
 	/*
 	 * Pretend we are using VLANs; This bypasses a nasty bug where
 	 * Interrupts stop flowing on high load on 8110SCd controllers.
-- 
2.43.0


