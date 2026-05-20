Return-Path: <netdev+bounces-289966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MATsAg3FDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:28:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A758F9F2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 791D83098A4B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5633E929C;
	Wed, 20 May 2026 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NyzoqI0n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4D3E7BDE;
	Wed, 20 May 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286377; cv=none; b=hN/ADGQY7P5BYDQXJyO0jmBpQu7C9oLoFl4ns9Qos7DVGNOD2i/1U7IT1y31Ps6yerHVcjCYC/NeYxuSG2C0RQidxUBbv1z6GXjcySA3iS4He76KT4iRhQRPENC6oFoU92TYOR+aeYMp2qHTXqH/hqH187EbZ0i9VD9mXMypY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286377; c=relaxed/simple;
	bh=WgIJfF4VzgzMuhe5np7VaeTq2JXhbWYRdnpTgTNXlfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTKOUoZ2ACo+O6VibBxrWDjGsmMtCT1qRTTWIcpiGSjOR8tfG2wF3WW15Sz1xQjQLZlU0m/LMr3BaUQZoqOsqy6FvQi/msgHPQAvmBownKVnGBTSYpZHnbMZVXYsdqkzHp5p12hKST9drQyz8YKJryI5AgU2FiXcspHfROa9jGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NyzoqI0n; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDpTUx2255606;
	Wed, 20 May 2026 07:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	U3B9inqHJp1PXKQDC3a3ZwqG7Mcvwr9n6RN79Oh68c=; b=NyzoqI0nxJSOQ9puN
	/vN5KV9UuUHVYzVrYJV6Dagnd+fQPHrqZ2ss+8hr9j4qD3LBPjTjPlmWoy/UIv0Q
	d5Kq+oDO15gd4PrOqy2ldB/gF27ZtHcijgUaIqRU4uUu/Z5ou/EoD8hfpEKiMOqc
	6EGYini0KPBh7HqIjFZSUiAXsqqTpXFmP4rtWEAV7Z0tRub8yRrdTcyoYISdc+I5
	xEP0XyiWTP10MYsnU6ai/f2sy/e0bbamhzP5CF9v+FMiN41L26JubjBG7N1O23wn
	dWU5cnGAAc4zuU3PKBziH/gqtAp9wskP10isbZe0GpVx7GfxaLWPNHdBZHcor3wS
	rKp1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94euhmkk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:12:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:12:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:12:24 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 64A2D5B693E;
	Wed, 20 May 2026 07:12:17 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 9/12] net: atlantic: extend hw_ops and TX descriptor  for AQC113 PTP
Date: Wed, 20 May 2026 19:40:42 +0530
Message-ID: <20260520141046.2151-10-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260520141046.2151-1-sukhdeeps@marvell.com>
References: <20260520141046.2151-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX0fGsDapWaqvg
 +ppDDrJuFATXAB2NGMzEBBcbolHDKGvQ34VBHHD1EPwJEC3gniYAw3hG9a4P1tU87IP0gwwdPbg
 avsJQkiC9kX/avGJXOcnClbJdp5VxcjT+N78pqHYK2YYhQ7iE99ETZyLYDCfP4qXX+8a5LMEWS2
 fQnOOsp7DyeKdl/hoINFh+h/0S4P4VX5hTSIvKB4YVB+jRywQZaLIbkzIhRgJDT/RHwJXAkdPPp
 o02qv2/i1CxoE3iMQAq2PbW9ymGeUtejGF+w9sOSyiJ7WeOd0wv38OKxr1r+YQ+Gt4CsDoemCB5
 cHZALLcpGAcIq48xM24fKsC/TSE1sPDjT9nUL1UUrrZD+T4UAadOk4j8dZMaKOkWi1jsrDjRZZI
 FqN0Pm6KsyTWnxVO2tNmD3hlAxwClNSVG0lITNtaTcwIl2dR+IZaEGJln+9B/l4yK19RhABSj9K
 a6a+XApeub4Z5dHxYqQ==
X-Proofpoint-ORIG-GUID: PZylsOnUz1puaoFz_e8Bul7Zu6k44gCQ
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0dc14a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=hiUK1oAcT578BJWSq0gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PZylsOnUz1puaoFz_e8Bul7Zu6k44gCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289966-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 533A758F9F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Extend the aq_hw_ops interface with new function pointers required for
PTP support on AQC113:
- enable_ptp: enable/disable PTP counter with clock selection
- hw_ring_tx_ptp_get_ts: read TX timestamp from descriptor writeback
- hw_tx_ptp_ring_init/hw_rx_ptp_ring_init: per-ring PTP initialization
- hw_get_clk_sel: query active TSG clock selection

Update existing hw_ops signatures to support AQC113 dual-clock
architecture:
- hw_gpio_pulse: add clk_sel and hightime parameters
- hw_extts_gpio_enable: add channel parameter

Add PTP-related hardware defines:
- AQ_HW_TXD_CTL_TS_EN/TS_TSG0 for TX descriptor timestamp control
- AQ2_HW_PTP_COUNTER_HZ for AQC113 TSG clock frequency
- AQ_HW_PTP_IRQS for PTP interrupt vector accounting
- PTP enable flags (L2/L4) and TSG clock selection constants

Add request_ts and clk_sel bitfields to aq_ring_buff_s for per-packet
TX timestamp request tracking.

Update hw_atl_b0.c (AQC107) implementations:
- Adapt gpio_pulse and extts_gpio_enable to new signatures
- Add TX descriptor timestamp bits for AQC113 when ANTIGUA chip
  feature is detected

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_hw.h    | 34 +++++++++++++++++--
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  4 +--
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  4 ++-
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      | 15 ++++++--
 4 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 57ea59026a2c..0ba29b8f95ab 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -19,6 +19,9 @@
 #define AQ_HW_MAC_COUNTER_HZ   312500000ll
 #define AQ_HW_PHY_COUNTER_HZ   160000000ll
 
+#define AQ_HW_TXD_CTL_TS_EN       0x40000000U
+#define AQ_HW_TXD_CTL_TS_TSG0     0x80000000U
+
 enum aq_tc_mode {
 	AQ_TC_MODE_INVALID = -1,
 	AQ_TC_MODE_8TCS,
@@ -38,6 +41,8 @@ enum aq_tc_mode {
 
 #define AQ_FRAC_PER_NS 0x100000000LL
 
+#define AQ2_HW_PTP_COUNTER_HZ   156250000ll
+
 /* Used for rate to Mbps conversion */
 #define AQ_MBPS_DIVISOR         125000 /* 1000000 / 8 */
 
@@ -109,6 +114,7 @@ struct aq_stats_s {
 #define AQ_HW_IRQ_MSIX    3U
 
 #define AQ_HW_SERVICE_IRQS   1U
+#define AQ_HW_PTP_IRQS       1U
 
 #define AQ_HW_POWER_STATE_D0   0U
 #define AQ_HW_POWER_STATE_D3   3U
@@ -157,6 +163,15 @@ enum aq_priv_flags {
 	AQ_HW_LOOPBACK_PHYEXT_SYS,
 };
 
+enum {
+	AQ_HW_PTP_DISABLE = 0,
+	AQ_HW_PTP_L2_ENABLE = BIT(1),
+	AQ_HW_PTP_L4_ENABLE = BIT(2),
+};
+
+#define ATL_TSG_CLOCK_SEL_0 0
+#define ATL_TSG_CLOCK_SEL_1 1
+
 #define AQ_HW_LOOPBACK_MASK	(BIT(AQ_HW_LOOPBACK_DMA_SYS) |\
 				 BIT(AQ_HW_LOOPBACK_PKT_SYS) |\
 				 BIT(AQ_HW_LOOPBACK_DMA_NET) |\
@@ -198,6 +213,7 @@ struct aq_hw_s {
 	u32 rpc_tid;
 	struct hw_atl_utils_fw_rpc rpc;
 	s64 ptp_clk_offset;
+	s8 clk_select;
 	u16 phy_id;
 	void *priv;
 };
@@ -323,11 +339,15 @@ struct aq_hw_ops {
 
 	int (*hw_ts_to_sys_clock)(struct aq_hw_s *self, u64 ts, u64 *time);
 
-	int (*hw_gpio_pulse)(struct aq_hw_s *self, u32 index, u64 start,
-			     u32 period);
+	int (*hw_gpio_pulse)(struct aq_hw_s *self, u32 index,
+			     u32 clk_sel, u64 start,
+			     u32 period, u32 hightime);
 
 	int (*hw_extts_gpio_enable)(struct aq_hw_s *self, u32 index,
-				    u32 enable);
+				    u32 channel, int enable);
+
+	void (*enable_ptp)(struct aq_hw_s *self, unsigned int param,
+			   int enable);
 
 	int (*hw_get_sync_ts)(struct aq_hw_s *self, u64 *ts);
 
@@ -337,6 +357,14 @@ struct aq_hw_ops {
 	int (*extract_hwts)(struct aq_hw_s *self, u8 *p, unsigned int len,
 			    u64 *timestamp);
 
+	u64 (*hw_ring_tx_ptp_get_ts)(struct aq_ring_s *ring);
+
+	int (*hw_tx_ptp_ring_init)(struct aq_hw_s *self,
+				   struct aq_ring_s *aq_ring);
+	int (*hw_rx_ptp_ring_init)(struct aq_hw_s *self,
+				   struct aq_ring_s *aq_ring);
+	u32 (*hw_get_clk_sel)(struct aq_hw_s *self);
+
 	int (*hw_set_fc)(struct aq_hw_s *self, u32 fc, u32 tc);
 
 	int (*hw_set_loopback)(struct aq_hw_s *self, u32 mode, bool enable);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 9df8918216f6..7486a28d7ff8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -380,7 +380,7 @@ static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 	 */
 	mutex_lock(&aq_nic->fwreq_mutex);
 	aq_nic->aq_hw_ops->hw_gpio_pulse(aq_nic->aq_hw, pin_index,
-					 start, (u32)period);
+					 0, start, (u32)period, 0);
 	mutex_unlock(&aq_nic->fwreq_mutex);
 
 	return 0;
@@ -454,7 +454,7 @@ static void aq_ptp_extts_pin_ctrl(struct aq_ptp_s *aq_ptp)
 
 	if (aq_nic->aq_hw_ops->hw_extts_gpio_enable)
 		aq_nic->aq_hw_ops->hw_extts_gpio_enable(aq_nic->aq_hw, 0,
-							enable);
+							0, enable);
 }
 
 static int aq_ptp_extts_pin_configure(struct ptp_clock_info *ptp,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index d627ace850ff..e578fe04d22c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -85,7 +85,9 @@ struct __packed aq_ring_buff_s {
 			u32 is_error:1;
 			u32 is_vlan:1;
 			u32 is_lro:1;
-			u32 rsvd3:3;
+			u32 request_ts:1;
+			u32 clk_sel:1;
+			u32 rsvd3:1;
 			u16 eop_index;
 			u16 rsvd4;
 		};
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index c7895bfb2ecf..6c25ad264b19 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -736,6 +736,15 @@ int hw_atl_b0_hw_ring_tx_xmit(struct aq_hw_s *self, struct aq_ring_s *ring,
 				txd->ctl |= HW_ATL_B0_TXD_CTL_CMD_WB;
 				is_gso = false;
 				is_vlan = false;
+
+				if (ATL_HW_IS_CHIP_FEATURE(self, ANTIGUA) &&
+				    unlikely(buff->request_ts)) {
+					txd->ctl |= AQ_HW_TXD_CTL_TS_EN;
+					if (buff->clk_sel != ATL_TSG_CLOCK_SEL_1)
+						txd->ctl |= AQ_HW_TXD_CTL_TS_TSG0;
+					/* The only DD+TS is required */
+					txd->ctl &= ~HW_ATL_B0_TXD_CTL_CMD_WB;
+				}
 			}
 		}
 		ring->sw_tail = aq_ring_next_dx(ring, ring->sw_tail);
@@ -1323,8 +1332,8 @@ static int hw_atl_b0_adj_clock_freq(struct aq_hw_s *self, s32 ppb)
 	return self->aq_fw_ops->send_fw_request(self, &fwreq, size);
 }
 
-static int hw_atl_b0_gpio_pulse(struct aq_hw_s *self, u32 index,
-				u64 start, u32 period)
+static int hw_atl_b0_gpio_pulse(struct aq_hw_s *self, u32 index, u32 clk_sel,
+				u64 start, u32 period, u32 hightime)
 {
 	struct hw_fw_request_iface fwreq;
 	size_t size;
@@ -1342,7 +1351,7 @@ static int hw_atl_b0_gpio_pulse(struct aq_hw_s *self, u32 index,
 }
 
 static int hw_atl_b0_extts_gpio_enable(struct aq_hw_s *self, u32 index,
-				       u32 enable)
+				       u32 channel, int enable)
 {
 	/* Enable/disable Sync1588 GPIO Timestamping */
 	aq_phy_write_reg(self, MDIO_MMD_PCS, 0xc611, enable ? 0x71 : 0);
-- 
2.43.0


