Return-Path: <netdev+bounces-285781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIrREG3S/WnCjgAAu9opvQ
	(envelope-from <netdev+bounces-285781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:09:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C64F621B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D8530A72CC
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C743DA7F4;
	Fri,  8 May 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IkEAmprE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECB3D0918;
	Fri,  8 May 2026 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241861; cv=none; b=iwVVux0ocItfhfOa8D4SJ1Ka1QgA0PPNnsPFWLO2fP3OScnuMR3iRNraleJPyOWF8FpSbTmZd/K5af7AOf2PgKMp+TnAjqtClyS7M++c6KEZ9gjc4HGvzGKnCstgWHaxBstxGNEVueKBtf7AnIZBLi5pBoQ9Y30Jdf67ouZFOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241861; c=relaxed/simple;
	bh=2t1Dp/jQeQrGn3UOZxzDNu9IBUyQMz9Ij0A5b6VW3ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIb2OXHrEcjg6GCXq/INxfgjh2PJwx+xqcRymvaUbOuqhEqjwuu2ADCIeewLbiRin4HBVl/ZA9cDdFIBk6AB8ljXQo90wBzotLkFfQZidvY9IJg+X7NvoZJ5qwG3RajepYExxAxDZSjDrCJb9drQTH1/15VMttdzbdicQTCiHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IkEAmprE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6484TrqH2850767;
	Fri, 8 May 2026 05:04:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	q6rEEkokTKkjLg1shSBnLYJwRvWt2wyCC+UHV7/nDw=; b=IkEAmprElVqWmzAeU
	kNbZgMq/nIxXla6f1a3ZxkOiA7FBu4S3ouBisWrekHcbPtUHponIVgS2oCF67I8d
	fVgJMfRB4wN4/FkEPLD74RMH3X01+9LgcNBg2/0rfnB1Vd1WOBBX6hdVJ87s0rKm
	JuEd4p4nDPPpOT4In04wh8v7Pi8XwSWVGtf1UudvOelJLbbWP/8v8YitcrjJ5aTe
	95pmwdSiyDKdKUpCXbt91DnmQjuXoWrLfUlGg4Eqbcw9S1x0U+m8K4aCjRbXcS0o
	ik2wHxiDANiqYIzvd44A0byIew0OCyFObn3IYRtb18S3UppBpbzuBWWy3RI3Ui5K
	7mZIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e0wy2awk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:04:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:04:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:04:01 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 00B1F3F7087;
	Fri,  8 May 2026 05:03:56 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 8/9] net: atlantic: extend hw_ops and TX descriptor for AQC113 PTP for AQC113 PTP
Date: Fri, 8 May 2026 17:31:55 +0530
Message-ID: <20260508120156.3060-9-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260508120156.3060-1-sukhdeeps@marvell.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nAVgU8DRQYsed0-PRtSSfhMNwRMuGGVe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX/LFPTueoRh0I
 A09XC6oYwdLNeo6bofGwFqbmUfRjYOzGBqSG9lUxUm3/eeQbBIMLKdYbXuxOw9kYSvLm6kk76JN
 nCFh5RNyan0vhD1SH+aEdQVp7GrsQOpvBmSBTWkz2qz61QC2PrFxTpyeNazFDgP1sAo4+JHzdFK
 nF48OdC5xfGEDe8QR62eoajm+NVlbTP3zsA7TpvfO/dfY62VlM0P/Dr2+X1CFpP2PaHMdwOxP3O
 ve7rAgtZN23Md3Qw2NAvrThJoOsW4sO7j4VOhk6Nm6b+Tz28DU6c2Y22+fuj4af49F1SDFjc8mx
 6R7myGe0uQbwj21XY9LHSo8FlfwAdjOlJYCez+McK+4lcjJNdpVbwxnlKa0hATw32MLj4WXSvIG
 U2v0hxgfTEYnXcOB8eSOfMMrL8l0CL/0TimCQ+z6E4GEhnGsuGmgM9ph7w+9eJLgjwZFilm2R5z
 stFtMvKT3VoaOGUTC5A==
X-Proofpoint-GUID: nAVgU8DRQYsed0-PRtSSfhMNwRMuGGVe
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=69fdd132 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=hiUK1oAcT578BJWSq0gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 971C64F621B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285781-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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
index 04fb87d4e56d..e3bacad08b93 100644
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
@@ -325,11 +341,15 @@ struct aq_hw_ops {
 
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
 
@@ -339,6 +359,14 @@ struct aq_hw_ops {
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


