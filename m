Return-Path: <netdev+bounces-282254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIacLpmu8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB254903C5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09471300B637
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43103A3E64;
	Wed, 29 Apr 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="S9UZUpKM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571738F255;
	Wed, 29 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446504; cv=none; b=RGadQ/jDO6Dn9GT3OIeAeRGd0olokuAMIQu5km0xoDsT88qGYqo/2/TFqc4eiaaa01qDJnnT2/LWWhrLLLfqqqMxNU1L9WjE9uL3dfP83iqiMn8IXmcrBI9G5uK58GIsZXCOfwIe9OsQpHsUhOYp18F7T9XgfDQpUEPPNg+gZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446504; c=relaxed/simple;
	bh=qOU6YjWrEbr2B646nOSHDnGFj8tZQynDGBIFsEBhjTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GflDbZxlYaRVod94nr4na5Q3Y6g1R5z1w+IFr5351lXkqu0o+hU1VQFefMa6YkyWf+jvAEo0DKWB1IIwlnbAFfR0oNnH9WsIwHB480rw3PjQ8PeW+N4Nq9fipsk9ROZL4PIgHzWBLQjh+LeVUNlgXZR2bEoOXOO5lT71xepB1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=S9UZUpKM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77rvaE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446473;
	bh=5lCXOqpGi1iIKdudot62B1Kcq8h5XbayfXu+ex/jKH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=S9UZUpKMrZvIXLB9OLLIbnTT4dW70Qiay8EY1nbh8Sjs7FsQij7vnfZq0zo9Lvs1S
	 qB4arxOZn0rsBlmWl5mCDUGHDHlkC10RywDAM+rZU06WsWq+WboSzOnNROvxkSarCg
	 tMf8hjVpPQvNMKRlZGBgoz969azgy7s/vUlp7l4rMjE/PtMZFf+4aNFOtVWgAGXH3H
	 pyuZC0dcFCrQYmYw1MNKNCI0kHahBUH+ujdwcHUrMeRkCfuEeVFEjk5iGY+34Y3cDL
	 pZJUrfCTgDA1lJkiH8/hE5Y5Lqd2ommX3kflDpW/WaJvBxof4NHUY5ypDWvtOeKScD
	 C/kOzKUNLzz5g==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77rvaE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:53 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:53 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:53 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2 1/8] r8169: add some register definitions
Date: Wed, 29 Apr 2026 15:07:43 +0800
Message-ID: <20260429070750.1477-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260429070750.1477-1-javen_xu@realsil.com.cn>
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 9BB254903C5
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
	TAGGED_FROM(0.00)[bounces-282254-lists,netdev=lfdr.de];
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

From: Javen Xu <javen_xu@realsil.com.cn>

To support rss, this patch adds some macro definitions and register
definitions.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
changes in v2:
 - modify the name, avoid using camel names
 - change the name more reasonable, global
---
 drivers/net/ethernet/realtek/r8169_main.c | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..4f56f8b420fe 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -77,6 +77,21 @@
 #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
+#define R8169_MAX_RX_QUEUES	8
+#define R8169_MAX_MSIX_VEC	32
+#define R8127_MAX_RX_QUEUES	8
+#define R8127_MAX_IRQ		32
+#define R8127_MIN_IRQ		30
+#define RTL_RSS_KEY_SIZE	40
+#define RSS_CPU_NUM_OFFSET	16
+#define RSS_MASK_BITS_OFFSET	8
+#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
+#define RXS_RSS_UDP BIT(27)
+#define RXS_RSS_IPV4 BIT(28)
+#define RXS_RSS_IPV6 BIT(29)
+#define RXS_RSS_TCP BIT(30)
+#define RXS_RSS_L3_TYPE_MASK (RXS_RSS_IPV4 | RXS_RSS_IPV6)
+#define RXS_RSS_L4_TYPE_MASK (RXS_RSS_TCP | RXS_RSS_UDP)
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -435,6 +450,8 @@ enum rtl8125_registers {
 #define INT_CFG0_CLKREQEN		BIT(3)
 	IntrMask_8125		= 0x38,
 	IntrStatus_8125		= 0x3c,
+	INTR_VEC_MAP_MASK	= 0x800,
+	INTR_VEC_MAP_STATUS	= 0x802,
 	INT_CFG1_8125		= 0x7a,
 	LEDSEL2			= 0x84,
 	LEDSEL1			= 0x86,
@@ -444,8 +461,32 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	TNPDS_Q1_LOW		= 0x2100,
+	RDSAR_Q1_LOW		= 0x4000,
+	IMR_SET_VEC_MAP_REG	= 0x0d0c,
+	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
+	ISR_VEC_MAP_REG		= 0x0d04,
 };
 
+#define MSIX_ID_VEC_MAP_LINKCHG		29
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
+#define RTL_VEC_MAP_ENABLE		BIT(0)
+#define RSS_INDIRECTION_TBL_REG		0x4700
+#define RSS_KEY_REG			0x4600
+
 #define LEDSEL_MASK_8125	0x23f
 
 #define RX_VLAN_INNER_8125	BIT(22)
@@ -576,6 +617,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+#define	ISRIMR_LINKCHG	BIT(29)
+#define	ISRIMR_TOK_Q0	BIT(8)
+#define	ISRIMR_ROK_Q0	BIT(0)
 };
 
 enum rtl_desc_bit {
@@ -633,6 +677,11 @@ enum rtl_rx_desc_bit {
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
@@ -728,6 +777,13 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rx_desc_ring_type {
+	RX_DESC_RING_TYPE_UNKNOWN = 0,
+	RX_DESC_RING_TYPE_DEFAULT,
+	RX_DESC_RING_TYPE_RSS,
+	RX_DESC_RING_TYPE_MAX
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -763,6 +819,8 @@ struct rtl8169_private {
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


