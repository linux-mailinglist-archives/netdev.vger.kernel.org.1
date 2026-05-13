Return-Path: <netdev+bounces-287562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPMZHWBnBGpVIAIAu9opvQ
	(envelope-from <netdev+bounces-287562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:58:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C56532A37
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07C3730DD8EA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7443FFADB;
	Wed, 13 May 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="SRjyvKD+"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA840DFCE;
	Wed, 13 May 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673380; cv=none; b=lDaInBHbEXy2gjGg0HvnzNK77m6dwp+ycyh/nCkKdpFPMP/ltBQSL+6YosRQnM5Y2wwXeQS1j6xEEB/9K9zS8A7X3meulCLGUsIm9imQWvWeDzZq1qQcjqij/HKopUUWI44WfYaPPqSZdVu7dJZnCjW7JvbWOH3nkeHj8KTC/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673380; c=relaxed/simple;
	bh=eJnCLW27yb8xuivYxrs31zKi7MCuzeQIBxAas0KOOSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo7LWdn/gqJHWr9K6m46nllULXJuG4Hu+R6cS0wpSt6VGduGetptWfRf0aOnCOhc1Wfw0KlSWZ/+WpWwzwDpggSBj1/avDMNmxmfV+3reEi0Hahr23EfQozI0kCqeNuB1foeiHRWX/QVZ2KFjAyC+U3cm6w51MDjm9KjRAJVVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=SRjyvKD+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64DBtkAN3894741, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778673347;
	bh=wrV+85mkvCAkUP2E3h4xM9BaqqETmvUQhoWWZjMmgJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SRjyvKD+3CgR9yQEVPmk1gHWC9X49v5ugi99Bc8YWXtR3Hl8YfK+wnYsGbzw+Ooym
	 Wk53XTXQ3BKPdQZ2X7yD0osadHrgH8vpC62bueYreTJ+p1FjO2Pvqog7QaGRVo4uyC
	 5/4vb/IutQBGkjrX7xit6gUh786jQ2CiZSGCAaHjSYtryX+UNbShxBXHnxJnzBaduA
	 3Go+RmU0+7tq7qlmfudIggLmwfVIkiEnmEAdTJOUQDGu9TdL3Dn8H7czkig206zuQv
	 O26sL2INJo/W2YJ3XH4c1HgGGMJNhMwkJ2m1Zus8xWhdD9FEPjpnJh9ngcht0U7Hzf
	 +3cWIOeU24kJg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64DBtkAN3894741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 May 2026 19:55:47 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 May 2026 19:55:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 13 May 2026 19:55:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v3 5/7] r8169: add support and enable rss
Date: Wed, 13 May 2026 19:55:41 +0800
Message-ID: <20260513115543.1730-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260513115543.1730-1-javen_xu@realsil.com.cn>
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: E8C56532A37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287562-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support and enable rss for RTL8127.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - some changes moved from Patch 2/7
Changes in v3:
 - add struct rtl8169_rss_data. Allocate it dynamically when needed.
 - define rss_key as an u32 array
 - replace some magic bit numbers in rtl8169_set_rss_hash_opt() and
   rtl8125_set_rx_q_num()
 - use union to combine different rx descriptor, refactor struct RxDesc
 - remove dead code from rtl8169_double_check_rss_support()
---
 drivers/net/ethernet/realtek/r8169_main.c | 405 ++++++++++++++++++++--
 1 file changed, 371 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b9c505e4bc0a..b90375cef724 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -82,6 +82,19 @@
 #define R8169_MAX_MSIX_VEC	32
 #define R8127_MAX_RX_QUEUES	8
 #define R8169_DEFAULT_RX_QUEUES	1
+#define R8127_MAX_IRQ		32
+#define R8127_MIN_IRQ		30
+#define R8169_IRQ_DEFAULT	1
+#define RTL_RSS_KEY_SIZE	40
+#define RSS_CPU_NUM_MASK	GENMASK(18, 16)
+#define RSS_HASH_MASK		GENMASK(10, 8)
+#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
+#define RXS_RSS_UDP		BIT(27)
+#define RXS_RSS_IPV4		BIT(28)
+#define RXS_RSS_IPV6		BIT(29)
+#define RXS_RSS_TCP		BIT(30)
+#define RXS_RSS_L3_TYPE_MASK	(RXS_RSS_IPV4 | RXS_RSS_IPV6)
+#define RXS_RSS_L4_TYPE_MASK	(RXS_RSS_TCP | RXS_RSS_UDP)
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -592,6 +605,25 @@ enum rtl_register_content {
 #define	ISRIMR_LINKCHG	BIT(29)
 #define	ISRIMR_TOK_Q0	BIT(8)
 #define	ISRIMR_ROK_Q0	BIT(0)
+#define RTL_DESC_TYPE_CTRL		0xd8
+#define RSS_KEY_REG			0x4600
+#define RSS_INDIRECTION_TBL_REG		0x4700
+#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
+#define RTL_DESC_TYPE_RSS		BIT(1)
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
+#define RTL_RX_Q_NUM_MASK		GENMASK(4, 2)
 };
 
 enum rtl_isr_version {
@@ -654,6 +686,11 @@ enum rtl_rx_desc_bit {
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
@@ -675,9 +712,27 @@ struct TxDesc {
 };
 
 struct RxDesc {
-	__le32 opts1;
-	__le32 opts2;
-	__le64 addr;
+	union {
+		/* RX_DESC_RING_TYPE_DEFAULT */
+		struct {
+			__le32 opts1;
+			__le32 opts2;
+			__le64 addr;
+		};
+
+		/* RX_DESC_RING_TYPE_RSS */
+		struct {
+			union {
+				__le64 rss_addr;
+				struct {
+					__le32 rss_info;
+					__le32 rss_result;
+				} rss_dword;
+			};
+			__le32 rss_opts2;
+			__le32 rss_opts1;
+		};
+	};
 };
 
 struct ring_info {
@@ -764,6 +819,13 @@ struct rtl8169_rx_ring {
 	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
 };
 
+struct rtl8169_rss_data {
+	u32 rss_flags;
+	u32 rss_key[RTL_RSS_KEY_SIZE / sizeof(u32)];
+	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
+	u8 hw_supp_indir_tbl_entries;
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -783,9 +845,11 @@ struct rtl8169_private {
 	u16 tx_lpi_timer;
 	u32 irq_mask;
 	u16 hw_supp_num_rx_queues;
+	struct rtl8169_rss_data *rss_data;
 	enum rtl_isr_version hw_supp_isr_ver;
 	enum rtl_isr_version hw_curr_isr_ver;
 	u8 irq_nvecs;
+	u8 init_rx_desc_type;
 	bool recheck_desc_ownbit;
 	unsigned int features;
 	int irq;
@@ -1620,6 +1684,13 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
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
@@ -1919,9 +1990,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
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
+		opts2 = le32_to_cpu(desc->rss_opts2);
+		break;
+	default:
+		opts2 = le32_to_cpu(desc->opts2);
+		break;
+	}
 
 	if (opts2 & RxVlanTag)
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
@@ -2750,6 +2832,14 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl8169_init_rss(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
+		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+
+	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
+}
+
 static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 {
 	tp->num_rx_rings = 1;
@@ -2757,6 +2847,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_80:
 		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
+		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
 		tp->hw_supp_isr_ver = RTL_ISR_VER_8127;
 		break;
 	default:
@@ -2764,6 +2855,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 		tp->hw_supp_isr_ver = RTL_ISR_VER_DEFAULT;
 		break;
 	}
+	tp->init_rx_desc_type = RX_DESC_RING_TYPE_DEFAULT;
 	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
 }
 
@@ -2889,6 +2981,72 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
 }
 
+static void rtl8169_store_rss_key(struct rtl8169_private *tp)
+{
+	u32 *rss_key = tp->rss_data->rss_key;
+	const u16 rss_key_reg = RSS_KEY_REG;
+	u32 num_entries = RTL_RSS_KEY_SIZE / sizeof(u32);
+
+	/* Write redirection table to HW */
+	for (int i = 0; i < num_entries; i++)
+		RTL_W32(tp, rss_key_reg + (i * 4), rss_key[i]);
+}
+
+static void rtl8169_store_reta(struct rtl8169_private *tp)
+{
+	u16 indir_tbl_reg = RSS_INDIRECTION_TBL_REG;
+	u32 i, reta_entries = tp->rss_data->hw_supp_indir_tbl_entries;
+	u32 reta = 0;
+	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
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
+	u32 rss_flags = tp->rss_data->rss_flags;
+	u32 rss_ctrl;
+
+	rss_ctrl = FIELD_PREP(RSS_CPU_NUM_MASK, ilog2(tp->num_rx_rings));
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
+	rss_ctrl |= FIELD_PREP(RSS_HASH_MASK,
+			       ilog2(tp->rss_data->hw_supp_indir_tbl_entries));
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
 	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
@@ -3955,6 +4113,18 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
+{
+	u16 q_ctrl;
+	u16 rx_q_num;
+
+	rx_q_num = (u16)ilog2(tp->num_rx_rings);
+	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
+	q_ctrl &= ~RTL_RX_Q_NUM_MASK;
+	q_ctrl |= FIELD_PREP(RTL_RX_Q_NUM_MASK, rx_q_num);
+	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
+}
+
 static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
 {
 	u8 tmp;
@@ -3994,6 +4164,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
+	/* enable rx descriptor type v4 and set queue num for rss*/
+	if (tp->rss_enable) {
+		rtl8125_set_rx_q_num(tp);
+		RTL_W8(tp, RTL_DESC_TYPE_CTRL,
+		       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
+	}
+
 	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
@@ -4230,6 +4407,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
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
@@ -4257,14 +4440,26 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void rtl8169_mark_to_asic(struct RxDesc *desc)
+static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
+	u32 eor;
 
-	desc->opts2 = 0;
-	/* Force memory writes to complete before releasing descriptor */
-	dma_wmb();
-	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		eor = le32_to_cpu(desc->rss_opts1) & RingEnd;
+		desc->rss_opts2 = 0;
+		/* Force memory writes to complete before releasing descriptor */
+		dma_wmb();
+		WRITE_ONCE(desc->rss_opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+		break;
+	default:
+		eor = le32_to_cpu(desc->opts1) & RingEnd;
+		desc->opts2 = 0;
+		/* Force memory writes to complete before releasing descriptor */
+		dma_wmb();
+		WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+		break;
+	}
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
@@ -4287,9 +4482,12 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 		return NULL;
 	}
 
-	desc->addr = cpu_to_le64(mapping);
 	ring->rx_desc_phy_addr[index] = mapping;
-	rtl8169_mark_to_asic(desc);
+	if (tp->init_rx_desc_type == RX_DESC_RING_TYPE_RSS)
+		desc->rss_addr = cpu_to_le64(mapping);
+	else
+		desc->addr = cpu_to_le64(mapping);
+	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
 }
@@ -4310,6 +4508,18 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring
 	}
 }
 
+static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		desc->rss_opts1 |= cpu_to_le32(RingEnd);
+		break;
+	default:
+		desc->opts1 |= cpu_to_le32(RingEnd);
+		break;
+	}
+}
+
 static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
@@ -4326,7 +4536,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
 	}
 
 	/* mark as last descriptor in the ring */
-	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
+	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
 
 	return 0;
 }
@@ -4476,7 +4686,7 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
 		for (int j = 0; j < NUM_RX_DESC; j++)
-			rtl8169_mark_to_asic(ring->rx_desc_array + j);
+			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
 	}
 }
 
@@ -4937,35 +5147,104 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
-static inline void rtl8169_rx_csum(struct sk_buff *skb,
+static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
+				   struct RxDesc *desc,
+				   struct sk_buff *skb)
+{
+	u32 rss_header_info;
+	u32 hash_val;
+
+	if (!(tp->dev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_header_info = le32_to_cpu(desc->rss_dword.rss_info);
+
+	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
+		return;
+
+	hash_val = le32_to_cpu(desc->rss_dword.rss_result);
+
+	skb_set_hash(skb, hash_val,
+		     (RXS_RSS_L4_TYPE_MASK & rss_header_info) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
+}
+
+static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
+				   struct sk_buff *skb,
 				   struct RxDesc *desc)
 {
-	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
+	bool csum_ok = false;
+	u32 opts1;
 
-	if (status == RxProtoTCP || status == RxProtoUDP)
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		opts1 = le32_to_cpu(desc->rss_opts1);
+		if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
+		    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
+			csum_ok = true;
+		break;
+	default:
+		opts1 = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
+		if (opts1 == RxProtoTCP || opts1 == RxProtoUDP)
+			csum_ok = true;
+		break;
+	}
+
+	if (csum_ok)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
 		skb_checksum_none_assert(skb);
 }
 
+static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		return READ_ONCE(desc->rss_opts1);
+	default:
+		return READ_ONCE(desc->opts1);
+	}
+}
+
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
 
-static void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
+static void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
+				      struct RxDesc *desc,
 				      dma_addr_t mapping)
 {
-	desc->addr = cpu_to_le64(mapping);
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_RING_TYPE_RSS:
+		desc->rss_addr = cpu_to_le64(mapping);
+		break;
+	default:
+		desc->addr = cpu_to_le64(mapping);
+		break;
+	}
 }
 
 static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
@@ -4982,7 +5261,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(READ_ONCE(desc->opts1));
+		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
 
 		if (status & DescOwn) {
 			if (!tp->recheck_desc_ownbit)
@@ -4996,7 +5275,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 			 */
 			tp->recheck_desc_ownbit = false;
 			rtl8169_desc_quirk(tp);
-			status = le32_to_cpu(READ_ONCE(desc->opts1));
+			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
 			if (status & DescOwn)
 				break;
 		}
@@ -5045,11 +5324,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		skb->tail += pkt_size;
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
-
-		rtl8169_rx_csum(skb, desc);
+		if (tp->rss_enable)
+			rtl8169_rx_hash(tp, desc, skb);
+		rtl8169_rx_csum(tp, skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
-		rtl8169_rx_vlan_tag(desc, skb);
+		rtl8169_rx_vlan_tag(tp, desc, skb);
 
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
@@ -5058,8 +5338,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		rtl8169_set_desc_dma_addr(desc, ring->rx_desc_phy_addr[entry]);
-		rtl8169_mark_to_asic(desc);
+		rtl8169_set_desc_dma_addr(tp, desc, ring->rx_desc_phy_addr[entry]);
+		rtl8169_mark_to_asic(tp, desc);
 	}
 
 	return count;
@@ -5607,6 +5887,43 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 	}
 }
 
+static int get_max_irq_nvecs(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		return R8127_MAX_IRQ;
+	return R8169_IRQ_DEFAULT;
+}
+
+static int get_min_irq_nvecs(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		return R8127_MIN_IRQ;
+	return R8169_IRQ_DEFAULT;
+}
+
+static void rtl8169_double_check_rss_support(struct rtl8169_private *tp)
+{
+	if (tp->hw_curr_isr_ver > RTL_ISR_VER_DEFAULT) {
+		if (!(tp->features & RTL_VEC_MAP_ENABLE) || tp->irq_nvecs < get_min_irq_nvecs(tp))
+			tp->hw_curr_isr_ver = RTL_ISR_VER_8127;
+	}
+
+	if (tp->rss_support && tp->hw_curr_isr_ver > RTL_ISR_VER_DEFAULT) {
+		u8 rss_queue_num = netif_get_num_default_rss_queues();
+
+		tp->num_rx_rings = min(rss_queue_num, tp->hw_supp_num_rx_queues);
+		if (!(tp->num_rx_rings >= 2 && tp->irq_nvecs >= get_min_irq_nvecs(tp)))
+			tp->num_rx_rings = 1;
+	}
+
+	tp->rss_enable = 0;
+
+	if (tp->num_rx_rings >= 2) {
+		tp->rss_enable = 1;
+		tp->init_rx_desc_type = RX_DESC_RING_TYPE_RSS;
+	}
+}
+
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -5627,7 +5944,10 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
+	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp), get_max_irq_nvecs(tp), flags);
+
+	if (nvecs < 0)
+		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
 
 	if (nvecs < 0)
 		return nvecs;
@@ -6069,6 +6389,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
+	tp->rss_support = rtl_check_rss_support(tp);
+
+	if (tp->rss_support) {
+		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data), GFP_KERNEL);
+		if (!tp->rss_data)
+			return -ENOMEM;
+	}
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -6095,6 +6422,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!tp->rtl8169_napi)
 		return -ENOMEM;
 
+	rtl8169_double_check_rss_support(tp);
+
+	if (tp->rss_support)
+		rtl8169_init_rss(tp);
+
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
 
@@ -6112,6 +6444,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


