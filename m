Return-Path: <netdev+bounces-284747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CMGMST5+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591924D7C2F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC5E730595AD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB803E317E;
	Wed,  6 May 2026 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="IQZP4jSR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32F3E315C;
	Wed,  6 May 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055250; cv=none; b=auutfAxc6tkFuKPbB0bI8kmr4DRkDphhmYMczBTp1GolCzZpD72xDsuWHE5G2fqN38uXz6SN5c9RHHTxC7aqttduTxLHN+MD732Xe5wyMQu/hyPMxjLmD+McrCUYbwygoZfg6EwVlsoVxy8zh3l/3goOFEYDZ/RHr3cuhO/blhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055250; c=relaxed/simple;
	bh=7PSCrLcd/2bRHlthTjzhBwMoKgjJu6Schh+5MNaOVOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBqPEUHI196LN+iP6TWTEpiSoUHK8zTdUKlNG2neWLbZXzJYJn8h2mMK5IGS0R9E1gP+hexj9OK19JUSu36OPXSTC7zDbWMPO/V5ehmfb9v3/u/LCvZuRjwh0rXXfmAgjTfLSm7XtpXgnryiSyaJ4QDIIgXMU9ktZerRPN73sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=IQZP4jSR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468DUnsC1854043, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778055210;
	bh=N7Qk6Nf0QnwCJOYn5dWFLoGJt/TOUe3HQCgtkt6POiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IQZP4jSRCDQIh1hFUFCoF5mKm2pZjuS/F7eLAbnAMxPsTf06EzLLNDAZ4nX5QCJfO
	 5YWYdPoBtktZvn0ZCI9WdhY9MhMA8rIKRgou3ArrJ3f//1bxocwxhRp6chiOpOLWgF
	 jww+q/AUf37WbHkYmd2MH/dOscpJdk/Brc/b8TnY2t1IVL/4wIgZBIWBictxTUnlHv
	 bqpvKier+JIiHn9tF+/XHpaBLCTWXqEVu+L02DI++v4ZPbZIG1N/bmYrcftQi6SkXv
	 5kOZNeROGzAO4zycOxsMPuZIIuDzEG/33q9EQYoL2afApMpAD6sg13tcUIYe+3Q0It
	 AjUx8JTSfTI5g==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468DUnsC1854043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 May 2026 16:13:30 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:13:29 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 16:13:29 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v1 5/7] r8169: add support and enable rss
Date: Wed, 6 May 2026 16:13:23 +0800
Message-ID: <20260506081326.767-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260506081326.767-1-javen_xu@realsil.com.cn>
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 591924D7C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284747-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support and enable rss for RTL8127.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 361 ++++++++++++++++++++--
 1 file changed, 343 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 69601e077646..9b42cee24b8a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -80,6 +80,18 @@
 #define R8127_MAX_TX_QUEUES	8
 #define R8169_MAX_MSIX_VEC	32
 #define R8127_MAX_RX_QUEUES	8
+#define R8127_MAX_IRQ		32
+#define R8127_MIN_IRQ		30
+#define RTL_RSS_KEY_SIZE	40
+#define RSS_CPU_NUM_OFFSET	16
+#define RSS_MASK_BITS_OFFSET	8
+#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
+#define RXS_RSS_UDP		BIT(27)
+#define RXS_RSS_IPV4		BIT(28)
+#define RXS_RSS_IPV6		BIT(29)
+#define RXS_RSS_TCP		BIT(30)
+#define RXS_RSS_L3_TYPE_MASK	(RXS_RSS_IPV4 | RXS_RSS_IPV6)
+#define RXS_RSS_L4_TYPE_MASK	(RXS_RSS_TCP | RXS_RSS_UDP)
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -449,6 +461,7 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	TNPDS_Q1_LOW		= 0x2100,
 	RDSAR_Q1_LOW		= 0x4000,
 	IMR_SET_VEC_MAP_REG	= 0x0d0c,
 	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
@@ -456,7 +469,23 @@ enum rtl8125_registers {
 };
 
 #define MSIX_ID_VEC_MAP_LINKCHG		29
+#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
+#define RSS_CTRL_IPV4_SUPP		BIT(1)
+#define RSS_CTRL_TCP_IPV6_SUPP		BIT(2)
+#define RSS_CTRL_IPV6_SUPP		BIT(3)
+#define RSS_CTRL_IPV6_EXT_SUPP		BIT(4)
+#define RSS_CTRL_TCP_IPV6_EXT_SUPP	BIT(5)
+#define RSS_CTRL_UDP_IPV4_SUPP		BIT(6)
+#define RSS_CTRL_UDP_IPV6_SUPP		BIT(7)
+#define RSS_CTRL_UDP_IPV6_EXT_SUPP	BIT(8)
+#define RTL_RSS_FLAG_HASH_UDP_IPV4	BIT(0)
+#define RTL_RSS_FLAG_HASH_UDP_IPV6	BIT(1)
+#define	RX_RES_RSS			BIT(22)
+#define	RX_RUNT_RSS			BIT(21)
+#define	RX_CRC_RSS			BIT(20)
 #define RTL_VEC_MAP_ENABLE		BIT(0)
+#define RSS_INDIRECTION_TBL_REG		0x4700
+#define RSS_KEY_REG			0x4600
 
 #define LEDSEL_MASK_8125	0x23f
 
@@ -648,6 +677,11 @@ enum rtl_rx_desc_bit {
 #define RxProtoIP	(PID1 | PID0)
 #define RxProtoMask	RxProtoIP
 
+#define	RX_UDPT_DESC_RSS	BIT(19)
+#define	RX_TCPT_DESC_RSS	BIT(18)
+#define	RX_UDPF_DESC_RSS	BIT(16) /* UDP/IP checksum failed */
+#define	RX_TCPF_DESC_RSS	BIT(15) /* TCP/IP checksum failed */
+
 	IPFail		= (1 << 16), /* IP checksum failed */
 	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
 	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
@@ -674,6 +708,21 @@ struct RxDesc {
 	__le64 addr;
 };
 
+struct rx_desc_rss {
+	union {
+		__le64 addr;
+		struct {
+			__le32 rss_info;
+			__le32 rss_result;
+		} rx_desc_rss_dword;
+	};
+
+	struct {
+		__le32 opts2;
+		__le32 opts1;
+	} rx_desc_opts;
+};
+
 struct ring_info {
 	struct sk_buff	*skb;
 	u32		len;
@@ -795,9 +844,13 @@ struct rtl8169_private {
 	u16 isr_reg[R8169_MAX_MSIX_VEC];
 	u16 imr_reg[R8169_MAX_MSIX_VEC];
 	unsigned int num_rx_rings;
+	u32 rss_flags;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u8 rss_key[RTL_RSS_KEY_SIZE];
+	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
+	u8 hw_supp_indir_tbl_entries;
 	u16 hw_supp_num_rx_queues;
 	u8 min_irq_nvecs;
 	u8 max_irq_nvecs;
@@ -1639,6 +1692,13 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
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
@@ -1938,9 +1998,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
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
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		opts2 = le32_to_cpu(((struct rx_desc_rss *)desc)->rx_desc_opts.opts2);
+		break;
+	default:
+		opts2 = le32_to_cpu(desc->opts2);
+		break;
+	}
 
 	if (opts2 & RxVlanTag)
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
@@ -2796,15 +2867,24 @@ static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
 		tp->imr_reg[i] = (u16)(INTR_VEC_MAP_MASK + (i - 1) * 4);
 }
 
+static void rtl8169_init_rss(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->hw_supp_indir_tbl_entries; i++)
+		tp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+
+	netdev_rss_key_fill(tp->rss_key, RTL_RSS_KEY_SIZE);
+}
+
 static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 {
 	tp->num_rx_rings = 1;
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_80:
-		tp->min_irq_nvecs = 1;
-		tp->max_irq_nvecs = 1;
+		tp->min_irq_nvecs = R8127_MIN_IRQ;
+		tp->max_irq_nvecs = R8127_MAX_IRQ;
 		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
+		tp->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
 		tp->hw_supp_isr_ver = 6;
 		break;
 	default:
@@ -2943,6 +3023,76 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
 }
 
+static void rtl8169_store_rss_key(struct rtl8169_private *tp)
+{
+	const u16 rss_key_reg = RSS_KEY_REG;
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
+	u16 indir_tbl_reg = RSS_INDIRECTION_TBL_REG;
+	u32 i, reta_entries = tp->hw_supp_indir_tbl_entries;
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
+	if (rss_flags & RTL_RSS_FLAG_HASH_UDP_IPV4)
+		rss_ctrl |= RSS_CTRL_UDP_IPV4_SUPP;
+
+	if (rss_flags & RTL_RSS_FLAG_HASH_UDP_IPV6)
+		rss_ctrl |= RSS_CTRL_UDP_IPV6_SUPP |
+			    RSS_CTRL_UDP_IPV6_EXT_SUPP;
+
+	hash_mask_len = ilog2(tp->hw_supp_indir_tbl_entries);
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
@@ -4004,6 +4154,20 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
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
+
 static void rtl8125_hw_set_interrupt_type(struct rtl8169_private *tp)
 {
 	u8 tmp;
@@ -4043,6 +4207,12 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
+	/* enable rx descriptor type v4 and set queue num for rss*/
+	if (tp->rss_enable) {
+		rtl8125_set_rx_q_num(tp);
+		RTL_W8(tp, 0xd8, RTL_R8(tp, 0xd8) | 0x02);
+	}
+
 	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
@@ -4279,6 +4449,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
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
@@ -4306,6 +4482,16 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+static void rtl8169_mark_to_asic_rss(struct rx_desc_rss *descrss)
+{
+	u32 eor = le32_to_cpu(descrss->rx_desc_opts.opts1) & RingEnd;
+
+	descrss->rx_desc_opts.opts2 = 0;
+	/* Force memory writes to complete before releasing descriptor */
+	dma_wmb();
+	WRITE_ONCE(descrss->rx_desc_opts.opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+}
+
 static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 {
 	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
@@ -4318,7 +4504,14 @@ static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 
 static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	rtl8169_mark_to_asic_default(desc);
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		rtl8169_mark_to_asic_rss((struct rx_desc_rss *)desc);
+		break;
+	default:
+		rtl8169_mark_to_asic_default(desc);
+		break;
+	}
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
@@ -4341,8 +4534,14 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 		return NULL;
 	}
 
-	desc->addr = cpu_to_le64(mapping);
 	ring->rx_desc_phy_addr[index] = mapping;
+	if (tp->init_rx_desc_type == RX_DESC_RING_TYPE_RSS) {
+		struct rx_desc_rss *descrss = (struct rx_desc_rss *)(ring->rx_desc_array) + index;
+
+		descrss->addr = cpu_to_le64(mapping);
+	} else {
+		desc->addr = cpu_to_le64(mapping);
+	}
 	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
@@ -4369,9 +4568,21 @@ static void rtl8169_mark_as_last_descriptor_default(struct RxDesc *desc)
 	desc->opts1 |= cpu_to_le32(RingEnd);
 }
 
+static void rtl8169_mark_as_last_descriptor_rss(struct rx_desc_rss *descrss)
+{
+	descrss->rx_desc_opts.opts1 |= cpu_to_le32(RingEnd);
+}
+
 static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	rtl8169_mark_as_last_descriptor_default(desc);
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		rtl8169_mark_as_last_descriptor_rss((struct rx_desc_rss *)desc);
+		break;
+	default:
+		rtl8169_mark_as_last_descriptor_default(desc);
+		break;
+	}
 }
 
 static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
@@ -5003,6 +5214,28 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
+static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
+				   struct rx_desc_rss *desc,
+				   struct sk_buff *skb)
+{
+	u32 rss_header_info;
+	u32 hash_val;
+
+	if (!(tp->dev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_header_info = le32_to_cpu(desc->rx_desc_rss_dword.rss_info);
+
+	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
+		return;
+
+	hash_val = le32_to_cpu(desc->rx_desc_rss_dword.rss_result);
+
+	skb_set_hash(skb, hash_val,
+		     (RXS_RSS_L4_TYPE_MASK & rss_header_info) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
+}
+
 static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
 					   struct sk_buff *skb,
 					   struct RxDesc *desc)
@@ -5015,28 +5248,66 @@ static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
 		skb_checksum_none_assert(skb);
 }
 
+static inline void rtl8169_rx_csum_rss(struct rtl8169_private *tp,
+				       struct sk_buff *skb,
+				       struct rx_desc_rss *descrss)
+{
+	u32 opts1 = le32_to_cpu(descrss->rx_desc_opts.opts1);
+
+	if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
+	    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		skb_checksum_none_assert(skb);
+}
+
 static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
 				   struct sk_buff *skb,
 				   struct RxDesc *desc)
 {
-	rtl8169_rx_csum_default(tp, skb, desc);
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		rtl8169_rx_csum_rss(tp, skb, (struct rx_desc_rss *)desc);
+		break;
+	default:
+		rtl8169_rx_csum_default(tp, skb, desc);
+		break;
+	}
 }
 
 static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	return READ_ONCE(desc->opts1);
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		return READ_ONCE(((struct rx_desc_rss *)desc)->rx_desc_opts.opts1);
+	default:
+		return READ_ONCE(desc->opts1);
+	}
 }
 
 static bool rtl8169_check_rx_desc_error(struct net_device *dev,
 					struct rtl8169_private *tp,
 					u32 status)
 {
-	if (unlikely(status & RxRES)) {
-		if (status & (RxRWT | RxRUNT))
-			dev->stats.rx_length_errors++;
-		if (status & RxCRC)
-			dev->stats.rx_crc_errors++;
-		return true;
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		if (unlikely(status & RX_RES_RSS)) {
+			if (status & RX_RUNT_RSS)
+				dev->stats.rx_length_errors++;
+			if (status & RX_CRC_RSS)
+				dev->stats.rx_crc_errors++;
+			return true;
+		}
+		break;
+	default:
+		if (unlikely(status & RxRES)) {
+			if (status & (RxRWT | RxRUNT))
+				dev->stats.rx_length_errors++;
+			if (status & RxCRC)
+				dev->stats.rx_crc_errors++;
+			return true;
+		}
+		break;
 	}
 	return false;
 }
@@ -5045,7 +5316,14 @@ static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
 					     struct RxDesc *desc,
 					     dma_addr_t mapping)
 {
-	desc->addr = cpu_to_le64(mapping);
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		((struct rx_desc_rss *)desc)->addr = cpu_to_le64(mapping);
+		break;
+	default:
+		desc->addr = cpu_to_le64(mapping);
+		break;
+	}
 }
 
 static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
@@ -5127,10 +5405,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
+		if (tp->rss_enable)
+			rtl8169_rx_hash(tp, (struct rx_desc_rss *)desc, skb);
+
 		rtl8169_rx_csum(tp, skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
-		rtl8169_rx_vlan_tag(desc, skb);
+		rtl8169_rx_vlan_tag(tp, desc, skb);
 
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
@@ -5242,7 +5523,6 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 		napi = &tp->r8169napi[i];
 		snprintf(irq->name, len, "%s-%d", dev->name, i);
-		irq->handler = rtl8169_interrupt;
 		rc = pci_request_irq(tp->pci_dev, i, irq->handler, NULL, napi, irq->name);
 		if (rc)
 			break;
@@ -5709,6 +5989,41 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_double_check_rss_support(struct rtl8169_private *tp)
+{
+	if (tp->hw_curr_isr_ver > 1) {
+		if (!(tp->features & RTL_VEC_MAP_ENABLE) || tp->irq_nvecs < tp->min_irq_nvecs)
+			tp->hw_curr_isr_ver = 1;
+	}
+
+	if (tp->rss_support && tp->hw_curr_isr_ver > 1) {
+		u8 rss_queue_num = netif_get_num_default_rss_queues();
+
+		tp->num_rx_rings = min(rss_queue_num, tp->hw_supp_num_rx_queues);
+		if (!(tp->num_rx_rings >= 2 && tp->irq_nvecs >= tp->min_irq_nvecs))
+			tp->num_rx_rings = 1;
+	}
+
+	tp->rss_enable = 0;
+
+	if (tp->num_rx_rings >= 2) {
+		tp->rss_enable = 1;
+		tp->init_rx_desc_type = RX_DESC_RING_TYPE_RSS;
+	} else if (tp->irq_nvecs > 1 && !tp->rss_support) {
+		pci_free_irq_vectors(tp->pci_dev);
+		tp->irq_nvecs = pci_alloc_irq_vectors(tp->pci_dev, 1, 1, PCI_IRQ_ALL_TYPES);
+
+		if (tp->irq_nvecs > 0) {
+			tp->irq = pci_irq_vector(tp->pci_dev, 0);
+		} else {
+			tp->irq = tp->pci_dev->irq;
+			tp->irq_nvecs = 1;
+		}
+
+		tp->features &= ~RTL_VEC_MAP_ENABLE;
+	}
+}
+
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -6177,6 +6492,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
+	tp->rss_support = rtl_check_rss_support(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -6198,6 +6514,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
+	rtl8169_double_check_rss_support(tp);
+
+	if (tp->rss_support)
+		rtl8169_init_rss(tp);
 
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
@@ -6219,6 +6539,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


