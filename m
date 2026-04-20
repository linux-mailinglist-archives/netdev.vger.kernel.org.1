Return-Path: <netdev+bounces-279622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMYpNJaN5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFB426309
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CCED3019534
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A1377EBA;
	Mon, 20 Apr 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Aew8x1qM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5137756A;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651657; cv=none; b=C+BIv1HaQ+h7Nf4f+wrBFCSf8I0BF+0hyKG2A5ZMKlvxptBXZwBO70cBLTgUdOl840NnFn3Qx3TEVmgd7YbGQSRtPxea9qIZOn1nBQEBJxPKc+VW7Rt9wAx+/yNEeGFgGGC8f5AjHW3fUP66Wn/3rLjlK/wMT56ouwuUEvfLdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651657; c=relaxed/simple;
	bh=ZCbuWCU9tV6IXABfR7T1+jJdUjBYDvr6VjklhOb8cR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpAA0B1+oS+hVNLujg+TURKuPuqIH/swo97QdH9lyjdy/k+bUlpvDF0vsTAO9BAEM6etDeVRWU2/F021mI/Pb2Se66MBuSprTv6FhMcA9sVjAKGMsWc+b5OjUg60v+V4HmJS5M3XLnhNi8HEhAx1nrEgBHyZK4SkBzcrult/G60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Aew8x1qM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KD560277428, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651614;
	bh=e+6zQgOXz/3PJlvNg67wi3PeQJQNEhCuhjSnQd8juio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Aew8x1qMDa2Nq6QaYBxd3VdlQaKOAFA4N7my6szS+L4smv34R1n3wj714qNan795P
	 aGe/h+IzbHdSycUTdN/anUh8Kw2ldQyIWeVLNMikqP7UII36uF7Ai4+FTQurm5/o7y
	 5e9AQfErwK7JSyWfeJ1Ku6qZOtzGZcod6+96fvO8CnjdY008wuWgxsgx++mKYKBY1m
	 SBMqPG3BgE6f262ZhvvNAvYva9ahDdOqFvG7DkWaOdoMvZrhqp8QBu6yl8uDvHeQbk
	 fBl43OAugS78fh46GsKMsbgteACpIyCWR/zdSRMFGH+1wMDysScdXgitDXOKGZ8jP6
	 4b2TZBYe+d8SQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KD560277428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:13 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 20 Apr 2026 10:20:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Date: Mon, 20 Apr 2026 10:19:49 +0800
Message-ID: <20260420021957.1756-2-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279622-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3ABFB426309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

To support rss, this patch adds some macro definitions and register
definitions.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..0fbec27e4a0d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -77,6 +77,23 @@
 #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
+#define R8169_MAX_RX_QUEUES	8
+#define R8169_MAX_TX_QUEUES	1
+#define R8169_MAX_MSIX_VEC	32
+#define R8127_MAX_TX_QUEUES	1
+#define R8127_MAX_RX_QUEUES	8
+#define R8127_MAX_IRQ		32
+#define R8127_MIN_IRQ		30
+#define RTL8127_RSS_KEY_SIZE	40
+#define RSS_CPU_NUM_OFFSET	16
+#define RSS_MASK_BITS_OFFSET	8
+#define RTL8127_MAX_INDIRECTION_TABLE_ENTRIES 128
+#define RXS_8125B_RSS_UDP_V4 BIT(27)
+#define RXS_8125_RSS_IPV4_V4 BIT(28)
+#define RXS_8125_RSS_IPV6_V4 BIT(29)
+#define RXS_8125_RSS_TCP_V4 BIT(30)
+#define RTL8127_RXS_RSS_L3_TYPE_MASK_V4 (RXS_8125_RSS_IPV4_V4 | RXS_8125_RSS_IPV6_V4)
+#define RTL8127_RXS_RSS_L4_TYPE_MASK_V4 (RXS_8125_RSS_TCP_V4 | RXS_8125B_RSS_UDP_V4)
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -435,6 +452,8 @@ enum rtl8125_registers {
 #define INT_CFG0_CLKREQEN		BIT(3)
 	IntrMask_8125		= 0x38,
 	IntrStatus_8125		= 0x3c,
+	IntrMask1_8125		= 0x800,
+	IntrStatus1_8125	= 0x802,
 	INT_CFG1_8125		= 0x7a,
 	LEDSEL2			= 0x84,
 	LEDSEL1			= 0x86,
@@ -444,6 +463,36 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	TNPDS_Q1_LOW		= 0x2100,
+	RDSAR_Q1_LOW		= 0x4000,
+	IMR_V2_SET_REG_8125	= 0x0d0c,
+	IMR_V2_CLEAR_REG_8125	= 0x0d00,
+	IMR_V4_L2_CLEAR_REG_8125 = 0x0d10,
+	ISR_V2_8125		= 0x0d04,
+	ISR_V4_L2_8125		= 0x0d14,
+};
+
+enum rtl8127_msix_id {
+	MSIX_ID_V4_LINKCHG	= 29,
+};
+
+enum rtl8127_rss_register_content {
+	RSS_CTRL_TCP_IPV4_SUPP		= (1 << 0),
+	RSS_CTRL_IPV4_SUPP		= (1 << 1),
+	RSS_CTRL_TCP_IPV6_SUPP		= (1 << 2),
+	RSS_CTRL_IPV6_SUPP		= (1 << 3),
+	RSS_CTRL_IPV6_EXT_SUPP		= (1 << 4),
+	RSS_CTRL_TCP_IPV6_EXT_SUPP	= (1 << 5),
+	RSS_CTRL_UDP_IPV4_SUPP		= (1 << 11),
+	RSS_CTRL_UDP_IPV6_SUPP		= (1 << 12),
+	RSS_CTRL_UDP_IPV6_EXT_SUPP	= (1 << 13),
+	RSS_INDIRECTION_TBL_8125_V2	= 0x4700,
+	RSS_KEY_8125			= 0x4600,
+};
+
+enum rtl8127_rss_flag {
+	RTL_8125_RSS_FLAG_HASH_UDP_IPV4  = (1 << 0),
+	RTL_8125_RSS_FLAG_HASH_UDP_IPV6  = (1 << 1),
 };
 
 #define LEDSEL_MASK_8125	0x23f
@@ -474,6 +523,10 @@ enum rtl_register_content {
 	RxRUNT	= (1 << 20),
 	RxCRC	= (1 << 19),
 
+	RxRES_RSS	= (1 << 22),
+	RxRUNT_RSS	= (1 << 21),
+	RxCRC_RSS	= (1 << 20),
+
 	/* ChipCmdBits */
 	StopReq		= 0x80,
 	CmdReset	= 0x10,
@@ -576,6 +629,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+	ISRIMR_V6_LINKCHG	= (1 << 29),
+	ISRIMR_V6_TOK_Q0	= (1 << 8),
+	ISRIMR_V6_ROK_Q0	= (1 << 0),
 };
 
 enum rtl_desc_bit {
@@ -633,6 +689,11 @@ enum rtl_rx_desc_bit {
 #define RxProtoIP	(PID1 | PID0)
 #define RxProtoMask	RxProtoIP
 
+	RxUDPT_v4	= (1 << 19),
+	RxTCPT_v4	= (1 << 18),
+	RxUDPF_v4	= (1 << 16), /* UDP/IP checksum failed */
+	RxTCPF_v4	= (1 << 15), /* TCP/IP checksum failed */
+
 	IPFail		= (1 << 16), /* IP checksum failed */
 	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
 	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
@@ -659,6 +720,11 @@ struct RxDesc {
 	__le64 addr;
 };
 
+enum features {
+	RTL_FEATURE_MSI		= (1 << 1),
+	RTL_FEATURE_MSIX	= (1 << 2),
+};
+
 struct ring_info {
 	struct sk_buff	*skb;
 	u32		len;
@@ -728,6 +794,13 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rx_desc_ring_type {
+	RX_DESC_RING_TYPE_UNKNOWN = 0,
+	RX_DESC_RING_TYPE_DEAFULT,
+	RX_DESC_RING_TYPE_RSS,
+	RX_DESC_RING_TYPE_MAX
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -763,6 +836,8 @@ struct rtl8169_private {
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
 	bool sfp_mode:1;
+	bool rss_support:1;
+	bool rss_enable:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
-- 
2.43.0


