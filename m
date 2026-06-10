Return-Path: <netdev+bounces-297652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a9zYHo9SKWqpUwMAu9opvQ
	(envelope-from <netdev+bounces-297652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:03:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D66690C2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:03:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=SQLSEZNs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297652-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297652-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 974E0306A155
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA35406811;
	Wed, 10 Jun 2026 11:56:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC30407572;
	Wed, 10 Jun 2026 11:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092570; cv=none; b=hBrE/lvrPriBR1cyyCRIrppMkFfgFZcmAWos2KRvTDIL9PmU9orrrDA1bvhDdo9+PtjpXSGHuQ3pfnAqdyJ0LF6qns2ETbpPFKT2wS+iD1O5J5YwPQ28ifT3grS1SubmBIazuMbYak1LmL7TIhgWXZ7SUaG1UJ12jr6kSdCrV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092570; c=relaxed/simple;
	bh=onqPioNVct3HjK+E2TFppYAmkyk5uGIi5W+FfSexljs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyqzkwX4tmsQ6bTCxBZg4Fs1kVWStkQUtADF7Tjze3trnNjZJ3cgCTN23tiF/llUsZ4zWbsYHoqL1dJGji8VGjcqanEMbkKjE1jYP7pJeA5EGuDb81N26SODlGLhm62olaXvOge2EgXyfNh818UCXFWe2cFJT+j8r+zkd8IkW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SQLSEZNs; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kZ273045239;
	Wed, 10 Jun 2026 04:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	7m3qMzNvJdnQGMooy9VeMPngFRjKCQQXpyEboKW87w=; b=SQLSEZNsz9qkkA9t4
	cKzoy6Wt01BjkwLAp0cgXJywfgnSCKv/CLIydY5y7RovBbU7E3zsTlZP4NB/OGUO
	kmSS3sDf+NMGhdNRhl5wtN1f4Orz7zEHP7ujnBkugh5HoEbRnynzrNYJAO/NNw/F
	yEhnpGFSThxmLBcOzGHJAOleEgaseoor1r0bIsoj8dqQ/JlM8W5rvhmX0pv4ZXyp
	WFWVsz3An/TMId1hjdS9JBPEuL2E/sM7dPlYGBtEGQYIGhHS0Ag0Dm5utgW7VOa2
	D3G045LNooKVv48w7XqczE1ayEefnZQvR6uw5b4sPIVt+kctBhBOGTfnvUUgs165
	JBUzA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eq02msb0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:56 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 78F453F708D;
	Wed, 10 Jun 2026 04:55:52 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 12/12] net: atlantic: add AQC113 PTP support in aq_ptp and driver core
Date: Wed, 10 Jun 2026 17:24:48 +0530
Message-ID: <20260610115448.272-13-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260610115448.272-1-sukhdeeps@marvell.com>
References: <20260610115448.272-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a2950cd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=6XZc2mIfAAAA:8
 a=zqemhHUUE2z4KKSHsBkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=vbtKyj4BGzZNu1KS43SK:22
X-Proofpoint-GUID: TKx3F1MKwnyHqJcHTDEfjIdIWBVdSpLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX2tW77GRAzHkE
 afy3Pg9FODvS/62GDIc0inUJDKnDUroB8vH97Mcjl/ssU0NWoGeXyJaCckxHO58w3a/dYXL9QDl
 mzw8yp1ck/Fah+umjbvXsZjYlgLfFpjzfQB8OwOXJwb3CnfkSe8v0IbPmAr2ZStz4gKvVKyDvOQ
 mzsITJOe44ZkZNTs+8+lt/6JFDopF9IcPp9//w+yoFvcKT3jsZLGtuieLLeoy6fW7AKLDuCdDUD
 23BRht5aNbVudRKDyWfIwDMY6S7aCJtvWH5hh7DRssb+MmzjtU9CSqdLn87YZar5vmGkLJ2GD5R
 +JCJNpYLAsNpnkzmhYw8DEH9dYy9txa7ayuBRbey4J6uJ6WXmyE2hOLBCWJJkMbelcHBYk2DI4L
 K7FM3nBka2grvuhw76Cnnp5nnC3Qbw6SiNOs9wENKPCBHEX7i/850DRkmyvVaymz+VYP8cpnPqM
 PfyCl0EizoP4OqAIHFw==
X-Proofpoint-ORIG-GUID: TKx3F1MKwnyHqJcHTDEfjIdIWBVdSpLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297652-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F0D66690C2

From: Sukhdeep Singh <sukhdeeps@marvell.com>

aq_ptp.c / aq_ptp.h:
- Add aq_ptp_state enum (AQ_PTP_FIRST_INIT, AQ_PTP_LINK_UP,
  AQ_PTP_NO_LINK) to distinguish first init from link-change events;
  on AQC113 only reset the TSG clock on first init to avoid disrupting
  ongoing synchronization.
- Add aq_ptp_dpath_enable() for comprehensive L3/L4 PTP filter
  setup/teardown, replacing the previous single-filter approach with
  an array of 4 slots for IPv4 and IPv6 PTP multicast addresses
  (224.0.1.129, 224.0.0.107, ff0e::181, ff02::6b).
- Add aq_ptp_parse_rx_filters() to map hwtstamp_rx_filters to L2/L4
  enable flags and call aq_ptp_dpath_enable().
- Re-apply RX filters on link change (hardware state lost after reset).
- Extend PTP ring alloc/init/start/stop to handle AQC113 PTP ring ops.
- Add per-instance PTP offset table for AQC113 with empirically measured
  values at 100M/1G/2.5G/5G/10G link speeds.
- Export aq_ptp_dpath_enable() and updated ring helpers in aq_ptp.h.

aq_hw.h:
- Include hw_atl2/hw_atl2.h for AQC113 PTP type definitions.

aq_nic.c:
- Account for PTP IRQ vector (AQ_HW_PTP_IRQS) in vector count math.
- Call hw_atl2 PTP re-enable hook after hardware reset in
  aq_nic_update_link_status().

aq_pci_func.c:
- Pass PTP IRQ index to aq_ptp_irq_alloc() in probe path.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |   1 +
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  45 +-
 .../ethernet/aquantia/atlantic/aq_pci_func.c  |   4 +-
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 547 ++++++++++++++----
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |  15 +-
 5 files changed, 473 insertions(+), 139 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 0ba29b8f95ab..338c956ad1f7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -15,6 +15,7 @@
 #include "aq_common.h"
 #include "aq_rss.h"
 #include "hw_atl/hw_atl_utils.h"
+#include "hw_atl2/hw_atl2.h"
 
 #define AQ_HW_MAC_COUNTER_HZ   312500000ll
 #define AQ_HW_PHY_COUNTER_HZ   160000000ll
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 09c90c969fb1..01792f7abf96 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -72,8 +72,15 @@ static void aq_nic_cfg_update_num_vecs(struct aq_nic_s *self)
 
 	cfg->vecs = min(cfg->aq_hw_caps->vecs, AQ_CFG_VECS_DEF);
 	cfg->vecs = min(cfg->vecs, num_online_cpus());
-	if (self->irqvecs > AQ_HW_SERVICE_IRQS)
-		cfg->vecs = min(cfg->vecs, self->irqvecs - AQ_HW_SERVICE_IRQS);
+	if (self->irqvecs > AQ_HW_SERVICE_IRQS + AQ_HW_PTP_IRQS)
+		cfg->vecs = min(cfg->vecs,
+				self->irqvecs - AQ_HW_SERVICE_IRQS - AQ_HW_PTP_IRQS);
+	else if (self->irqvecs > AQ_HW_PTP_IRQS)
+		cfg->vecs = min(cfg->vecs,
+				self->irqvecs - AQ_HW_PTP_IRQS);
+	else
+		cfg->vecs = 1U;
+
 	/* cfg->vecs should be power of 2 for RSS */
 	cfg->vecs = rounddown_pow_of_two(cfg->vecs);
 
@@ -138,7 +145,8 @@ void aq_nic_cfg_start(struct aq_nic_s *self)
 	 * link status IRQ. If no - we'll know link state from
 	 * slower service task.
 	 */
-	if (AQ_HW_SERVICE_IRQS > 0 && cfg->vecs + 1 <= self->irqvecs)
+	if (AQ_HW_SERVICE_IRQS > 0 &&
+	    self->irqvecs > AQ_HW_PTP_IRQS + AQ_HW_SERVICE_IRQS)
 		cfg->link_irq_vec = cfg->vecs;
 	else
 		cfg->link_irq_vec = 0;
@@ -172,7 +180,14 @@ static int aq_nic_update_link_status(struct aq_nic_s *self)
 		aq_nic_update_interrupt_moderation_settings(self);
 
 		if (self->aq_ptp) {
-			aq_ptp_clock_init(self);
+			/* AQC113 TSG requires >= 100 Mbps full-duplex: below 100 Mbps
+			 * timestamp resolution is insufficient for IEEE 1588, and
+			 * half-duplex collision domains make TX/RX correlation unreliable.
+			 */
+			bool ptp_link_good = (self->aq_hw->aq_link_status.mbps >= 100 &&
+					      self->aq_hw->aq_link_status.full_duplex);
+
+			aq_ptp_clock_init(self, ptp_link_good ? AQ_PTP_LINK_UP : AQ_PTP_NO_LINK);
 			aq_ptp_tm_offset_set(self,
 					     self->aq_hw->aq_link_status.mbps);
 			aq_ptp_link_change(self);
@@ -279,6 +294,7 @@ static int aq_nic_hw_prepare(struct aq_nic_s *self)
 	int err = 0;
 
 	err = self->aq_hw_ops->hw_soft_reset(self->aq_hw);
+
 	if (err)
 		goto exit;
 
@@ -450,7 +466,14 @@ int aq_nic_init(struct aq_nic_s *self)
 	}
 
 	if (aq_nic_get_cfg(self)->is_ptp) {
-		err = aq_ptp_init(self, self->irqvecs - 1);
+		u32 ptp_isr_vec;
+
+		if (self->irqvecs > AQ_HW_PTP_IRQS)
+			ptp_isr_vec = self->irqvecs - AQ_HW_PTP_IRQS;
+		else
+			ptp_isr_vec = 0;
+
+		err = aq_ptp_init(self, ptp_isr_vec);
 		if (err < 0)
 			goto err_exit;
 
@@ -691,6 +714,7 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
 	unsigned int ret = 0U;
 	unsigned int dx;
 	u8 l4proto = 0;
+	s32 clk_sel;
 
 	if (ipver == 4)
 		l4proto = ip_hdr(skb)->protocol;
@@ -803,6 +827,17 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
 	dx_buff->is_eop = 1U;
 	dx_buff->skb = skb;
 	dx_buff->xdpf = NULL;
+	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+	    self->aq_hw_ops->enable_ptp &&
+	    self->aq_hw_ops->hw_get_clk_sel &&
+	    aq_ptp_ring(self, ring)) {
+		clk_sel = (s32)self->aq_hw_ops->hw_get_clk_sel(self->aq_hw);
+		if (clk_sel < 0)
+			goto exit;
+		dx_buff->request_ts = 1U;
+		dx_buff->clk_sel = (u32)clk_sel;
+		ring->ptp_ts_deadline = jiffies + HZ;
+	}
 	goto exit;
 
 mapping_error:
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 5d510471b0d0..2e8378e595bd 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -294,8 +294,8 @@ static int aq_pci_probe(struct pci_dev *pdev,
 	numvecs = min((u8)AQ_CFG_VECS_DEF,
 		      aq_nic_get_cfg(self)->aq_hw_caps->msix_irqs);
 	numvecs = min(numvecs, num_online_cpus());
-	/* Request IRQ vector for PTP */
-	numvecs += 1;
+	/* Request IRQ lines for PTP */
+	numvecs += AQ_HW_PTP_IRQS;
 
 	numvecs += AQ_HW_SERVICE_IRQS;
 	/*enable interrupts */
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 6bb2329f1a68..558ac9237f75 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -26,6 +26,18 @@
 
 #define POLL_SYNC_TIMER_MS 15
 
+#define PTP_UDP_FILTERS_CNT 4
+
+#define PTP_IPV4_MC_ADDR1 0xE0000181
+#define PTP_IPV4_MC_ADDR2 0xE000006B
+
+#define PTP_IPV6_MC_ADDR10 0xFF0E
+#define PTP_IPV6_MC_ADDR14 0x0181
+#define PTP_IPV6_MC_ADDR20 0xFF02
+#define PTP_IPV6_MC_ADDR24 0x006B
+
+#define PTP_GPIO_HIGHTIME 100000
+
 enum ptp_speed_offsets {
 	ptp_offset_idx_10 = 0,
 	ptp_offset_idx_100,
@@ -49,11 +61,18 @@ struct ptp_tx_timeout {
 	unsigned long tx_start;
 };
 
+struct ptp_tm_offset {
+	unsigned int mbps;
+	int egress;
+	int ingress;
+};
+
 struct aq_ptp_s {
 	struct aq_nic_s *aq_nic;
 	struct kernel_hwtstamp_config hwtstamp_config;
 	spinlock_t ptp_lock;
 	spinlock_t ptp_ring_lock;
+	struct mutex ptp_filter_lock; /* serializes aq_ptp_dpath_enable() */
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_info;
 
@@ -64,7 +83,7 @@ struct aq_ptp_s {
 
 	struct ptp_tx_timeout ptp_tx_timeout;
 
-	unsigned int idx_vector;
+	unsigned int idx_ptp_vector;
 	struct napi_struct napi;
 
 	struct aq_ring_s ptp_tx;
@@ -73,7 +92,7 @@ struct aq_ptp_s {
 
 	struct ptp_skb_ring skb_ring;
 
-	struct aq_rx_filter_l3l4 udp_filter;
+	struct aq_rx_filter_l3l4 udp_filter[PTP_UDP_FILTERS_CNT];
 	struct aq_rx_filter_l2 eth_type_filter;
 
 	struct delayed_work poll_sync;
@@ -81,18 +100,15 @@ struct aq_ptp_s {
 
 	bool extts_pin_enabled;
 	u64 last_sync1588_ts;
+	/* TSG clock selection: 0 - PTP, 1 - PTM */
+	u32 ptp_clock_sel;
 
 	bool a1_ptp;
-};
+	bool a2_ptp;
 
-struct ptp_tm_offset {
-	unsigned int mbps;
-	int egress;
-	int ingress;
+	struct ptp_tm_offset ptp_offset[6];
 };
 
-static struct ptp_tm_offset ptp_offset[6];
-
 void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic, unsigned int mbps)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
@@ -104,10 +120,10 @@ void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic, unsigned int mbps)
 	egress = 0;
 	ingress = 0;
 
-	for (i = 0; i < ARRAY_SIZE(ptp_offset); i++) {
-		if (mbps == ptp_offset[i].mbps) {
-			egress = ptp_offset[i].egress;
-			ingress = ptp_offset[i].ingress;
+	for (i = 0; i < ARRAY_SIZE(aq_ptp->ptp_offset); i++) {
+		if (mbps == aq_ptp->ptp_offset[i].mbps) {
+			egress = aq_ptp->ptp_offset[i].egress;
+			ingress = aq_ptp->ptp_offset[i].ingress;
 			break;
 		}
 	}
@@ -378,6 +394,8 @@ static void aq_ptp_convert_to_hwtstamp(struct aq_ptp_s *aq_ptp,
 static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 			      u64 period)
 {
+	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
+
 	if (period)
 		netdev_dbg(aq_nic->ndev,
 			   "Enable GPIO %d pulsing, start time %llu, period %u\n",
@@ -392,7 +410,8 @@ static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 	 */
 	mutex_lock(&aq_nic->fwreq_mutex);
 	aq_nic->aq_hw_ops->hw_gpio_pulse(aq_nic->aq_hw, pin_index,
-					 0, start, (u32)period, 0);
+					 aq_ptp->ptp_clock_sel, start,
+					 (u32)period, PTP_GPIO_HIGHTIME);
 	mutex_unlock(&aq_nic->fwreq_mutex);
 
 	return 0;
@@ -466,7 +485,8 @@ static void aq_ptp_extts_pin_ctrl(struct aq_ptp_s *aq_ptp)
 
 	if (aq_nic->aq_hw_ops->hw_extts_gpio_enable)
 		aq_nic->aq_hw_ops->hw_extts_gpio_enable(aq_nic->aq_hw, 0,
-							0, enable);
+							aq_ptp->ptp_clock_sel,
+							enable);
 }
 
 static int aq_ptp_extts_pin_configure(struct ptp_clock_info *ptp,
@@ -555,14 +575,191 @@ void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp)
 		return;
 	}
 
-	timestamp += atomic_read(&aq_ptp->offset_egress);
-	aq_ptp_convert_to_hwtstamp(aq_ptp, &hwtstamp, timestamp);
-	skb_tstamp_tx(skb, &hwtstamp);
+	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
+		timestamp += atomic_read(&aq_ptp->offset_egress);
+		aq_ptp_convert_to_hwtstamp(aq_ptp, &hwtstamp, timestamp);
+		skb_tstamp_tx(skb, &hwtstamp);
+	}
+
 	dev_kfree_skb_any(skb);
 
 	aq_ptp_tx_timeout_update(aq_ptp);
 }
 
+static void aq_ptp_fill_udpv4_mc(struct ethtool_rx_flow_spec *fsp,
+				 u16 rx_queue, __be32 mc_addr)
+{
+	memset(fsp, 0, sizeof(*fsp));
+	fsp->ring_cookie = rx_queue;
+	fsp->flow_type = UDP_V4_FLOW;
+	fsp->h_u.udp_ip4_spec.pdst = cpu_to_be16(PTP_EV_PORT);
+	fsp->m_u.udp_ip4_spec.pdst = cpu_to_be16(0xffff);
+	fsp->h_u.udp_ip4_spec.ip4dst = mc_addr;
+	fsp->m_u.udp_ip4_spec.ip4dst = cpu_to_be32(0xffffffff);
+}
+
+static void aq_ptp_fill_udpv6_mc(struct ethtool_rx_flow_spec *fsp,
+				 u16 rx_queue,
+				 __be32 ip6dst_hi, __be32 ip6dst_hi_mask,
+				 __be32 ip6dst_lo, __be32 ip6dst_lo_mask)
+{
+	memset(fsp, 0, sizeof(*fsp));
+	fsp->ring_cookie = rx_queue;
+	fsp->flow_type = UDP_V6_FLOW;
+	fsp->h_u.udp_ip6_spec.pdst = cpu_to_be16(PTP_EV_PORT);
+	fsp->m_u.udp_ip6_spec.pdst = cpu_to_be16(0xffff);
+	fsp->h_u.udp_ip6_spec.ip6dst[0] = ip6dst_hi;
+	fsp->m_u.udp_ip6_spec.ip6dst[0] = ip6dst_hi_mask;
+	fsp->h_u.udp_ip6_spec.ip6dst[3] = ip6dst_lo;
+	fsp->m_u.udp_ip6_spec.ip6dst[3] = ip6dst_lo_mask;
+}
+
+static void aq_ptp_add_a2_filter(struct aq_ptp_s *aq_ptp,
+				 struct ethtool_rx_flow_spec *fsp,
+				 int *flt_idx)
+{
+	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
+
+	aq_set_data_fl3l4(fsp,
+			  &aq_ptp->udp_filter[*flt_idx],
+			  aq_ptp->udp_filter[*flt_idx].location,
+			  true);
+
+	netdev_dbg(aq_nic->ndev,
+		   "PTP MC filter prepared. Loc: %x\n",
+		   aq_ptp->udp_filter[*flt_idx].location);
+	(*flt_idx)++;
+}
+
+static int aq_ptp_dpath_enable(struct aq_ptp_s *aq_ptp,
+			       int enable_flags, u16 rx_queue)
+{
+	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
+	struct ethtool_rxnfc cmd = { 0 };
+	const struct aq_hw_ops *hw_ops = aq_nic->aq_hw_ops;
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd.fs;
+	int err = 0, i = 0;
+	int flt_idx = 0;
+
+	netdev_dbg(aq_nic->ndev,
+		   "%sable ptp filters: %x.\n",
+		   enable_flags ? "En" : "Dis", enable_flags);
+
+	if (enable_flags) {
+		/* Clear all existing L4 filters before applying new config */
+		for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
+			aq_ptp->udp_filter[i].cmd &=
+				~HW_ATL_RX_ENABLE_FLTR_L3L4;
+			if (hw_ops->hw_filter_l3l4_set) {
+				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
+						&aq_ptp->udp_filter[i]);
+				if (err)
+					netdev_dbg(aq_nic->ndev,
+						   "Set UDP filter failed\n");
+			}
+		}
+		if (enable_flags & (AQ_HW_PTP_L4_ENABLE)) {
+			if (aq_ptp->a1_ptp) {
+				fsp->ring_cookie = rx_queue;
+				fsp->flow_type = UDP_V4_FLOW;
+				fsp->h_u.udp_ip4_spec.pdst =
+					cpu_to_be16(PTP_EV_PORT);
+				fsp->m_u.udp_ip4_spec.pdst =
+					cpu_to_be16(0xffff);
+				err = aq_set_data_fl3l4(fsp,
+							&aq_ptp->udp_filter[flt_idx],
+							aq_ptp->udp_filter[flt_idx].location,
+							true);
+				if (!err) {
+					netdev_dbg(aq_nic->ndev,
+						   "Set UDPv4, location: %x\n",
+						   aq_ptp->udp_filter[flt_idx]
+						   .location);
+					flt_idx++;
+				}
+			} else {
+				aq_ptp_fill_udpv4_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV4_MC_ADDR1));
+				aq_ptp_add_a2_filter(aq_ptp, fsp,
+						     &flt_idx);
+
+				aq_ptp_fill_udpv6_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV6_MC_ADDR20 << 16),
+						     cpu_to_be32(0xffff0000),
+						     cpu_to_be32(PTP_IPV6_MC_ADDR24),
+						     cpu_to_be32(0x0000ffff));
+				aq_ptp_add_a2_filter(aq_ptp, fsp,
+						     &flt_idx);
+
+				aq_ptp_fill_udpv6_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV6_MC_ADDR10 << 16),
+						     cpu_to_be32(0xffff0000),
+						     cpu_to_be32(PTP_IPV6_MC_ADDR14),
+						     cpu_to_be32(0x0000ffff));
+				aq_ptp_add_a2_filter(aq_ptp, fsp,
+						     &flt_idx);
+
+				aq_ptp_fill_udpv4_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV4_MC_ADDR2));
+				aq_ptp_add_a2_filter(aq_ptp, fsp,
+						     &flt_idx);
+			}
+		}
+
+		if (enable_flags & AQ_HW_PTP_L2_ENABLE) {
+			aq_ptp->eth_type_filter.ethertype = ETH_P_1588;
+			aq_ptp->eth_type_filter.queue = rx_queue;
+		}
+
+		if (hw_ops->hw_filter_l3l4_set) {
+			for (i = 0; i < flt_idx; i++) {
+				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
+						&aq_ptp->udp_filter[i]);
+
+				if (!err) {
+					netdev_dbg(aq_nic->ndev,
+						   "Set UDP filter complete. Location: %x\n",
+						   aq_ptp->udp_filter[i].location);
+				} else {
+					netdev_dbg(aq_nic->ndev, "Set UDP filter failed\n");
+					break;
+				}
+			}
+		}
+
+		if (!err && (enable_flags & AQ_HW_PTP_L2_ENABLE) &&
+		    hw_ops->hw_filter_l2_set) {
+			err = hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
+					&aq_ptp->eth_type_filter);
+
+			if (!err)
+				netdev_dbg(aq_nic->ndev,
+					   "Set L2 filter complete. Location: %d\n",
+					   aq_ptp->eth_type_filter.location);
+		}
+	} else {
+		/* PTP disabled, clear all UDP/L2 filters */
+		for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
+			aq_ptp->udp_filter[i].cmd &=
+				~HW_ATL_RX_ENABLE_FLTR_L3L4;
+			if (hw_ops->hw_filter_l3l4_set) {
+				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
+						&aq_ptp->udp_filter[i]);
+				if (err)
+					netdev_dbg(aq_nic->ndev,
+						   "Set UDP filter failed\n");
+			}
+		}
+
+		if (!err && hw_ops->hw_filter_l2_clear)
+			err = hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
+						&aq_ptp->eth_type_filter);
+	}
+
+	return err;
+}
+
 /* aq_ptp_rx_hwtstamp - utility function which checks for RX time stamp
  * @adapter: pointer to adapter struct
  * @shhwtstamps: particular skb_shared_hwtstamps to save timestamp
@@ -584,59 +781,61 @@ void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
 	*config = aq_ptp->hwtstamp_config;
 }
 
-static void aq_ptp_prepare_filters(struct aq_ptp_s *aq_ptp)
+static unsigned int aq_ptp_parse_rx_filters(enum hwtstamp_rx_filters rx_filter)
 {
-	aq_ptp->udp_filter.cmd = HW_ATL_RX_ENABLE_FLTR_L3L4 |
-			       HW_ATL_RX_ENABLE_CMP_PROT_L4 |
-			       HW_ATL_RX_UDP |
-			       HW_ATL_RX_ENABLE_CMP_DEST_PORT_L4 |
-			       HW_ATL_RX_HOST << HW_ATL_RX_ACTION_FL3F4_SHIFT |
-			       HW_ATL_RX_ENABLE_QUEUE_L3L4 |
-			       aq_ptp->ptp_rx.idx << HW_ATL_RX_QUEUE_FL3L4_SHIFT;
-	aq_ptp->udp_filter.p_dst = PTP_EV_PORT;
-
-	aq_ptp->eth_type_filter.ethertype = ETH_P_1588;
-	aq_ptp->eth_type_filter.queue = aq_ptp->ptp_rx.idx;
+	unsigned int ptp_en_flags = AQ_HW_PTP_DISABLE;
+
+	switch (rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		ptp_en_flags = AQ_HW_PTP_L2_ENABLE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		ptp_en_flags = AQ_HW_PTP_L4_ENABLE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_ALL:
+	default:
+		ptp_en_flags = AQ_HW_PTP_L4_ENABLE | AQ_HW_PTP_L2_ENABLE;
+		break;
+	}
+	return ptp_en_flags;
 }
 
 int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
 			       struct kernel_hwtstamp_config *config)
 {
+	unsigned int ptp_en_flags = aq_ptp_parse_rx_filters(config->rx_filter);
 	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
-	const struct aq_hw_ops *hw_ops;
 	int err = 0;
 
-	hw_ops = aq_nic->aq_hw_ops;
-	if (config->tx_type == HWTSTAMP_TX_ON ||
-	    config->rx_filter == HWTSTAMP_FILTER_PTP_V2_EVENT) {
-		aq_ptp_prepare_filters(aq_ptp);
-		if (hw_ops->hw_filter_l3l4_set) {
-			err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
-							 &aq_ptp->udp_filter);
-		}
-		if (!err && hw_ops->hw_filter_l2_set) {
-			err = hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
-						       &aq_ptp->eth_type_filter);
-		}
-		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
-	} else {
-		aq_ptp->udp_filter.cmd &= ~HW_ATL_RX_ENABLE_FLTR_L3L4;
-		if (hw_ops->hw_filter_l3l4_set) {
-			err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
-							 &aq_ptp->udp_filter);
-		}
-		if (!err && hw_ops->hw_filter_l2_clear) {
-			err = hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
-							&aq_ptp->eth_type_filter);
-		}
-		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
+	mutex_lock(&aq_ptp->ptp_filter_lock);
+	if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter) {
+		err = aq_ptp_dpath_enable(aq_ptp,
+					  ptp_en_flags,
+					  aq_ptp->ptp_rx.idx);
 	}
+	mutex_unlock(&aq_ptp->ptp_filter_lock);
 
 	if (err)
 		return -EREMOTEIO;
 
-	aq_ptp->hwtstamp_config = *config;
+	if (ptp_en_flags != AQ_HW_PTP_DISABLE)
+		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
+	else
+		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
 
+	aq_ptp->hwtstamp_config = *config;
 	return 0;
 }
 
@@ -685,21 +884,23 @@ static int aq_ptp_poll(struct napi_struct *napi, int budget)
 		was_cleaned = true;
 	}
 
-	/* Processing HW_TIMESTAMP RX traffic */
-	err = aq_nic->aq_hw_ops->hw_ring_hwts_rx_receive(aq_nic->aq_hw,
-							 &aq_ptp->hwts_rx);
-	if (err < 0)
-		goto err_exit;
-
-	if (aq_ptp->hwts_rx.sw_head != aq_ptp->hwts_rx.hw_head) {
-		aq_ring_hwts_rx_clean(&aq_ptp->hwts_rx, aq_nic);
-
-		err = aq_nic->aq_hw_ops->hw_ring_hwts_rx_fill(aq_nic->aq_hw,
-							      &aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp) {
+		/* Processing HW_TIMESTAMP RX traffic */
+		err = aq_nic->aq_hw_ops->hw_ring_hwts_rx_receive(aq_nic->aq_hw,
+			&aq_ptp->hwts_rx);
 		if (err < 0)
 			goto err_exit;
 
-		was_cleaned = true;
+		if (aq_ptp->hwts_rx.sw_head != aq_ptp->hwts_rx.hw_head) {
+			aq_ring_hwts_rx_clean(&aq_ptp->hwts_rx, aq_nic);
+
+			err = aq_nic->aq_hw_ops->hw_ring_hwts_rx_fill(aq_nic->aq_hw,
+				&aq_ptp->hwts_rx);
+			if (err < 0)
+				goto err_exit;
+
+			was_cleaned = true;
+		}
 	}
 
 	/* Processing PTP RX traffic */
@@ -830,7 +1031,7 @@ int aq_ptp_irq_alloc(struct aq_nic_s *aq_nic)
 		return 0;
 
 	if (pdev->msix_enabled || pdev->msi_enabled) {
-		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_vector),
+		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector),
 				  aq_ptp_isr, 0, aq_nic->ndev->name, aq_ptp);
 	} else {
 		err = -EINVAL;
@@ -849,7 +1050,7 @@ void aq_ptp_irq_free(struct aq_nic_s *aq_nic)
 	if (!aq_ptp)
 		return;
 
-	free_irq(pci_irq_vector(pdev, aq_ptp->idx_vector), aq_ptp);
+	free_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector), aq_ptp);
 }
 
 int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
@@ -887,6 +1088,9 @@ int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
 	if (err < 0)
 		goto err_rx_free;
 
+	if (aq_ptp->a2_ptp)
+		return 0;
+
 	err = aq_ring_init(&aq_ptp->hwts_rx, ATL_RING_RX);
 	if (err < 0)
 		goto err_rx_free;
@@ -924,10 +1128,12 @@ int aq_ptp_ring_start(struct aq_nic_s *aq_nic)
 	if (err < 0)
 		goto err_exit;
 
-	err = aq_nic->aq_hw_ops->hw_ring_rx_start(aq_nic->aq_hw,
-						  &aq_ptp->hwts_rx);
-	if (err < 0)
-		goto err_exit;
+	if (aq_ptp->a1_ptp) {
+		err = aq_nic->aq_hw_ops->hw_ring_rx_start(aq_nic->aq_hw,
+							  &aq_ptp->hwts_rx);
+		if (err < 0)
+			goto err_exit;
+	}
 
 	napi_enable(&aq_ptp->napi);
 
@@ -945,7 +1151,9 @@ void aq_ptp_ring_stop(struct aq_nic_s *aq_nic)
 	aq_nic->aq_hw_ops->hw_ring_tx_stop(aq_nic->aq_hw, &aq_ptp->ptp_tx);
 	aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw, &aq_ptp->ptp_rx);
 
-	aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw, &aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw,
+						   &aq_ptp->hwts_rx);
 
 	napi_disable(&aq_ptp->napi);
 }
@@ -984,11 +1192,13 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	if (err)
 		goto err_exit_ptp_tx;
 
-	err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
-				    aq_nic->aq_nic_cfg.rxds,
-				    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
-	if (err)
-		goto err_exit_ptp_rx;
+	if (aq_ptp->a1_ptp) {
+		err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
+					    aq_nic->aq_nic_cfg.rxds,
+					    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
+		if (err)
+			goto err_exit_ptp_rx;
+	}
 
 	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
 	if (err != 0) {
@@ -996,7 +1206,7 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 		goto err_exit_hwts_rx;
 	}
 
-	aq_ptp->ptp_ring_param.vec_idx = aq_ptp->idx_vector;
+	aq_ptp->ptp_ring_param.vec_idx = aq_ptp->idx_ptp_vector;
 	aq_ptp->ptp_ring_param.cpu = aq_ptp->ptp_ring_param.vec_idx +
 			aq_nic_get_cfg(aq_nic)->aq_rss.base_cpu_number;
 	cpumask_set_cpu(aq_ptp->ptp_ring_param.cpu,
@@ -1005,7 +1215,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	return 0;
 
 err_exit_hwts_rx:
-	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1023,7 +1234,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 
 	aq_ring_free(&aq_ptp->ptp_tx);
 	aq_ring_free(&aq_ptp->ptp_rx);
-	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 
 	aq_ptp_skb_ring_release(&aq_ptp->skb_ring);
 }
@@ -1047,46 +1259,49 @@ static struct ptp_clock_info aq_ptp_clock = {
 	.pin_config	= NULL,
 };
 
-#define ptp_offset_init(__idx, __mbps, __egress, __ingress)   do { \
-		ptp_offset[__idx].mbps = (__mbps); \
-		ptp_offset[__idx].egress = (__egress); \
-		ptp_offset[__idx].ingress = (__ingress); } \
-		while (0)
+static void ptp_offset_init(struct aq_ptp_s *aq_ptp, int idx,
+			    unsigned int mbps, int egress, int ingress)
+{
+	aq_ptp->ptp_offset[idx].mbps = mbps;
+	aq_ptp->ptp_offset[idx].egress = egress;
+	aq_ptp->ptp_offset[idx].ingress = ingress;
+}
 
-static void aq_ptp_offset_init_from_fw(const struct hw_atl_ptp_offset *offsets)
+static void aq_ptp_offset_init_from_fw(struct aq_ptp_s *aq_ptp,
+				       const struct hw_atl_ptp_offset *offsets)
 {
 	int i;
 
 	/* Load offsets for PTP */
-	for (i = 0; i < ARRAY_SIZE(ptp_offset); i++) {
+	for (i = 0; i < ARRAY_SIZE(aq_ptp->ptp_offset); i++) {
 		switch (i) {
 		/* 100M */
 		case ptp_offset_idx_100:
-			ptp_offset_init(i, 100,
+			ptp_offset_init(aq_ptp, i, 100,
 					offsets->egress_100,
 					offsets->ingress_100);
 			break;
 		/* 1G */
 		case ptp_offset_idx_1000:
-			ptp_offset_init(i, 1000,
+			ptp_offset_init(aq_ptp, i, 1000,
 					offsets->egress_1000,
 					offsets->ingress_1000);
 			break;
 		/* 2.5G */
 		case ptp_offset_idx_2500:
-			ptp_offset_init(i, 2500,
+			ptp_offset_init(aq_ptp, i, 2500,
 					offsets->egress_2500,
 					offsets->ingress_2500);
 			break;
 		/* 5G */
 		case ptp_offset_idx_5000:
-			ptp_offset_init(i, 5000,
+			ptp_offset_init(aq_ptp, i, 5000,
 					offsets->egress_5000,
 					offsets->ingress_5000);
 			break;
 		/* 10G */
 		case ptp_offset_idx_10000:
-			ptp_offset_init(i, 10000,
+			ptp_offset_init(aq_ptp, i, 10000,
 					offsets->egress_10000,
 					offsets->ingress_10000);
 			break;
@@ -1094,11 +1309,12 @@ static void aq_ptp_offset_init_from_fw(const struct hw_atl_ptp_offset *offsets)
 	}
 }
 
-static void aq_ptp_offset_init(const struct hw_atl_ptp_offset *offsets)
+static void aq_ptp_offset_init(struct aq_ptp_s *aq_ptp,
+			       const struct hw_atl_ptp_offset *offsets)
 {
-	memset(ptp_offset, 0, sizeof(ptp_offset));
+	memset(aq_ptp->ptp_offset, 0, sizeof(aq_ptp->ptp_offset));
 
-	aq_ptp_offset_init_from_fw(offsets);
+	aq_ptp_offset_init_from_fw(aq_ptp, offsets);
 }
 
 static void aq_ptp_gpio_init(struct ptp_clock_info *info,
@@ -1151,26 +1367,46 @@ static void aq_ptp_gpio_init(struct ptp_clock_info *info,
 	       sizeof(struct ptp_pin_desc) * info->n_pins);
 }
 
-void aq_ptp_clock_init(struct aq_nic_s *aq_nic)
+void aq_ptp_clock_init(struct aq_nic_s *aq_nic, enum aq_ptp_state state)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
-	struct timespec64 ts;
 
-	ktime_get_real_ts64(&ts);
-	aq_ptp_settime(&aq_ptp->ptp_info, &ts);
+	if (!aq_ptp)
+		return;
+
+	if (aq_ptp->a1_ptp || state == AQ_PTP_FIRST_INIT) {
+		struct timespec64 ts;
+
+		ktime_get_real_ts64(&ts);
+		aq_ptp_settime(&aq_ptp->ptp_info, &ts);
+	}
+
+	if (!aq_ptp->a1_ptp && state != AQ_PTP_FIRST_INIT) {
+		mutex_lock(&aq_ptp->ptp_filter_lock);
+		unsigned int ptp_en_flags =
+			aq_ptp_parse_rx_filters(state == AQ_PTP_LINK_UP ?
+						aq_ptp->hwtstamp_config.rx_filter :
+						HWTSTAMP_FILTER_NONE);
+		if (aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx))
+			netdev_warn(aq_nic->ndev,
+				    "PTP RX filter restore failed in link change\n");
+		mutex_unlock(&aq_ptp->ptp_filter_lock);
+	}
 }
 
 static void aq_ptp_poll_sync_work_cb(struct work_struct *w);
 
-int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
+int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec)
 {
 	bool a1_ptp = ATL_HW_IS_CHIP_FEATURE(aq_nic->aq_hw, ATLANTIC);
+	bool a2_ptp = ATL_HW_IS_CHIP_FEATURE(aq_nic->aq_hw, ANTIGUA);
 	struct hw_atl_utils_mbox mbox;
 	struct ptp_clock *clock;
-	struct aq_ptp_s *aq_ptp;
+	struct aq_ptp_s *aq_ptp = NULL;
 	int err = 0;
+	int i;
 
-	if (!a1_ptp) {
+	if (!a1_ptp && !a2_ptp) {
 		aq_nic->aq_ptp = NULL;
 		return 0;
 	}
@@ -1180,19 +1416,43 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 		return 0;
 	}
 
-	if (!aq_nic->aq_fw_ops->enable_ptp) {
-		aq_nic->aq_ptp = NULL;
-		return 0;
+	if (a1_ptp) {
+		if (!aq_nic->aq_fw_ops->enable_ptp) {
+			aq_nic->aq_ptp = NULL;
+			return 0;
+		}
 	}
 
-	hw_atl_utils_mpi_read_stats(aq_nic->aq_hw, &mbox);
-
-	if (!(mbox.info.caps_ex & BIT(CAPS_EX_PHY_PTP_EN))) {
+	/* PTP requires at least 1 free irq vector for itself */
+	if (aq_nic->irqvecs <= AQ_HW_PTP_IRQS) {
+		netdev_warn(aq_nic->ndev,
+			    "Disabling PTP due to insufficient number of available IRQ vectors.\n");
 		aq_nic->aq_ptp = NULL;
 		return 0;
 	}
 
-	aq_ptp_offset_init(&mbox.info.ptp_offset);
+	if (a1_ptp) {
+		hw_atl_utils_mpi_read_stats(aq_nic->aq_hw, &mbox);
+		if (!(mbox.info.caps_ex & BIT(CAPS_EX_PHY_PTP_EN))) {
+			aq_nic->aq_ptp = NULL;
+			return 0;
+		}
+	} else {
+		memset(&mbox, 0, sizeof(mbox));
+
+		if (a2_ptp) {
+			mbox.info.ptp_offset.ingress_100 = HW_ATL2_PTP_OFFSET_INGRESS_100;
+			mbox.info.ptp_offset.egress_100 = HW_ATL2_PTP_OFFSET_EGRESS_100;
+			mbox.info.ptp_offset.ingress_1000 = HW_ATL2_PTP_OFFSET_INGRESS_1000;
+			mbox.info.ptp_offset.egress_1000 = HW_ATL2_PTP_OFFSET_EGRESS_1000;
+			mbox.info.ptp_offset.ingress_2500 = HW_ATL2_PTP_OFFSET_INGRESS_2500;
+			mbox.info.ptp_offset.egress_2500 = HW_ATL2_PTP_OFFSET_EGRESS_2500;
+			mbox.info.ptp_offset.ingress_5000 = HW_ATL2_PTP_OFFSET_INGRESS_5000;
+			mbox.info.ptp_offset.egress_5000 = HW_ATL2_PTP_OFFSET_EGRESS_5000;
+			mbox.info.ptp_offset.ingress_10000 = HW_ATL2_PTP_OFFSET_INGRESS_10000;
+			mbox.info.ptp_offset.egress_10000 = HW_ATL2_PTP_OFFSET_EGRESS_10000;
+		}
+	}
 
 	aq_ptp = kzalloc_obj(*aq_ptp);
 	if (!aq_ptp) {
@@ -1202,10 +1462,13 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 
 	aq_ptp->aq_nic = aq_nic;
 	aq_ptp->a1_ptp = a1_ptp;
+	aq_ptp->a2_ptp = a2_ptp;
 
 	spin_lock_init(&aq_ptp->ptp_lock);
 	spin_lock_init(&aq_ptp->ptp_ring_lock);
+	mutex_init(&aq_ptp->ptp_filter_lock);
 
+	aq_ptp_offset_init(aq_ptp, &mbox.info.ptp_offset);
 	aq_ptp->ptp_info = aq_ptp_clock;
 	aq_ptp_gpio_init(&aq_ptp->ptp_info, &mbox.info);
 	clock = ptp_clock_register(&aq_ptp->ptp_info, &aq_nic->ndev->dev);
@@ -1222,22 +1485,34 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 
 	netif_napi_add(aq_nic_get_ndev(aq_nic), &aq_ptp->napi, aq_ptp_poll);
 
-	aq_ptp->idx_vector = idx_vec;
+	aq_ptp->idx_ptp_vector = idx_ptp_vec;
 
 	aq_nic->aq_ptp = aq_ptp;
 
 	/* enable ptp counter */
+	aq_ptp->ptp_clock_sel = ATL_TSG_CLOCK_SEL_0;
 	aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
-	mutex_lock(&aq_nic->fwreq_mutex);
-	aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
-	aq_ptp_clock_init(aq_nic);
-	mutex_unlock(&aq_nic->fwreq_mutex);
+	if (a1_ptp) {
+		mutex_lock(&aq_nic->fwreq_mutex);
+		aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
+		mutex_unlock(&aq_nic->fwreq_mutex);
+	}
+	if (a2_ptp)
+		aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw, aq_ptp->ptp_clock_sel, 1);
 
 	INIT_DELAYED_WORK(&aq_ptp->poll_sync, &aq_ptp_poll_sync_work_cb);
 	aq_ptp->eth_type_filter.location =
-			aq_nic_reserve_filter(aq_nic, aq_rx_filter_ethertype);
-	aq_ptp->udp_filter.location =
+		aq_nic_reserve_filter(aq_nic, aq_rx_filter_ethertype);
+
+	for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
+		aq_ptp->udp_filter[i].location =
 			aq_nic_reserve_filter(aq_nic, aq_rx_filter_l3l4);
+	}
+
+	aq_ptp_clock_init(aq_nic, AQ_PTP_FIRST_INIT);
+	netdev_info(aq_nic->ndev,
+		    "Enable PTP Support. %d GPIO(s)\n",
+		    aq_ptp->ptp_info.n_pins);
 
 	return 0;
 
@@ -1256,31 +1531,47 @@ void aq_ptp_unregister(struct aq_nic_s *aq_nic)
 	if (!aq_ptp)
 		return;
 
-	ptp_clock_unregister(aq_ptp->ptp_clock);
+	if (aq_ptp->ptp_clock) {
+		ptp_clock_unregister(aq_ptp->ptp_clock);
+		aq_ptp->ptp_clock = NULL;
+	}
 }
 
 void aq_ptp_free(struct aq_nic_s *aq_nic)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
+	int i;
 
 	if (!aq_ptp)
 		return;
 
-	aq_nic_release_filter(aq_nic, aq_rx_filter_ethertype,
-			      aq_ptp->eth_type_filter.location);
-	aq_nic_release_filter(aq_nic, aq_rx_filter_l3l4,
-			      aq_ptp->udp_filter.location);
 	cancel_delayed_work_sync(&aq_ptp->poll_sync);
+
 	/* disable ptp */
-	mutex_lock(&aq_nic->fwreq_mutex);
-	aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 0);
-	mutex_unlock(&aq_nic->fwreq_mutex);
+	if (aq_ptp->a1_ptp) {
+		mutex_lock(&aq_nic->fwreq_mutex);
+		aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 0);
+		mutex_unlock(&aq_nic->fwreq_mutex);
+	}
+
+	if (aq_ptp->a2_ptp)
+		aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw,
+					      aq_ptp->ptp_clock_sel, 0);
+
+	aq_nic_release_filter(aq_nic, aq_rx_filter_ethertype,
+			      aq_ptp->eth_type_filter.location);
+	for (i = 0; i < PTP_UDP_FILTERS_CNT; i++)
+		aq_nic_release_filter(aq_nic, aq_rx_filter_l3l4,
+				      aq_ptp->udp_filter[i].location);
 
+	mutex_destroy(&aq_ptp->ptp_filter_lock);
 	kfree(aq_ptp->ptp_info.pin_config);
+	aq_ptp->ptp_info.pin_config = NULL;
 
 	netif_napi_del(&aq_ptp->napi);
-	kfree(aq_ptp);
+	aq_utils_obj_clear(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
 	aq_nic->aq_ptp = NULL;
+	kfree(aq_ptp);
 }
 
 struct ptp_clock *aq_ptp_get_ptp_clock(struct aq_ptp_s *aq_ptp)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 1658ef788de8..96cbfa59ac75 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
@@ -14,6 +14,12 @@
 
 #include "aq_ring.h"
 
+enum aq_ptp_state {
+	AQ_PTP_NO_LINK = 0,
+	AQ_PTP_FIRST_INIT = 1,
+	AQ_PTP_LINK_UP = 2,
+};
+
 #define PTP_8TC_RING_IDX             8
 #define PTP_4TC_RING_IDX            16
 #define PTP_HWST_RING_IDX           31
@@ -32,7 +38,7 @@ static inline unsigned int aq_ptp_ring_idx(const enum aq_tc_mode tc_mode)
 #if IS_REACHABLE(CONFIG_PTP_1588_CLOCK)
 
 /* Common functions */
-int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec);
+int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec);
 
 void aq_ptp_unregister(struct aq_nic_s *aq_nic);
 void aq_ptp_free(struct aq_nic_s *aq_nic);
@@ -52,7 +58,7 @@ void aq_ptp_service_task(struct aq_nic_s *aq_nic);
 
 void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic, unsigned int mbps);
 
-void aq_ptp_clock_init(struct aq_nic_s *aq_nic);
+void aq_ptp_clock_init(struct aq_nic_s *aq_nic, enum aq_ptp_state state);
 void aq_ptp_tx_skb_drop_head(struct aq_nic_s *aq_nic);
 
 /* Traffic processing functions */
@@ -81,7 +87,7 @@ u64 *aq_ptp_get_stats(struct aq_nic_s *aq_nic, u64 *data);
 
 #else
 
-static inline int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
+static inline int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec)
 {
 	return 0;
 }
@@ -123,7 +129,8 @@ static inline void aq_ptp_ring_deinit(struct aq_nic_s *aq_nic) {}
 static inline void aq_ptp_service_task(struct aq_nic_s *aq_nic) {}
 static inline void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic,
 					unsigned int mbps) {}
-static inline void aq_ptp_clock_init(struct aq_nic_s *aq_nic) {}
+static inline void aq_ptp_clock_init(struct aq_nic_s *aq_nic,
+				     enum aq_ptp_state state) {}
 static inline void aq_ptp_tx_skb_drop_head(struct aq_nic_s *aq_nic) {}
 static inline int aq_ptp_xmit(struct aq_nic_s *aq_nic, struct sk_buff *skb)
 {
-- 
2.43.0


