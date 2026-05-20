Return-Path: <netdev+bounces-289971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLD4IOPGDWr93AUAu9opvQ
	(envelope-from <netdev+bounces-289971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:36:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF3658FB73
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD7C324758E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F93EC2E1;
	Wed, 20 May 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Skn1/Wfh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868ED3E6385;
	Wed, 20 May 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286431; cv=none; b=hcWe9jr8T3rrOEO/7l0unYb7yA1y2tW6gNdYHKw6HpycBKwpbbkEaeXID+VIMvmnN+YBScqdkLCOV1ScrBi7r8ipH3tX6rwdMRHJ7k4VAM8Wx0GxmdpMdx5bm5SOYwCn/AlLQ7Qe+SUdsigjKZ0eA1eM7Dd+oYSdsWMYzqcSJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286431; c=relaxed/simple;
	bh=p++pSmr5OvlmRxSDi7TvT3YCjxv0/Put9joEVjh7RfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5lsfBHjio2SkLVY4U+aHDaouZP0vJOhqvMIfLM8tG5M10Kk8jM09WBHM1uP+IpmMslHmDTc3ZM4HL+COSTiZJNVB5JNV7RFQuMUMozo7nfWU3a/faJZ1BXgra9T9rjlEkZgp4caJJKw9eTxRyGYsvYSsu+hoUw/239UD0U/424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Skn1/Wfh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7VoTr2111005;
	Wed, 20 May 2026 07:12:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
	pq2K873g4hu1MnkcFVRuoKNsT3XCoCvjLwGtCbsNH4=; b=Skn1/WfhGy+Jc2z11
	doxctBw8wAlMWqoM9T3i+Uyd0YXHSIfQXXQ5MpwrFYB+saSsdaEPJekgk4YeUtij
	fBckpZyeatZRDkvV9DDXDXpbo8qmU0paHEoWhcgxdG8FmqxPQY7jnsscWGAlGRZ1
	Ph5wz9PGBgqdI1eY4pyuKtd4yDKbf34lmFbiAWr2yhNOFIZgsv6KrrkR4w75ywa2
	xUyQ2eNUxTnM6kZ+AyJ1dGIn94cR8F0K+HzKzHVgOyt6Vtrd6V5NjUKbkGlyuZla
	iOV6zWf5DDRRDL/vtOqqSAqLtMINthnBZ+KBCWrWzduoi9HPORIDgD9UXRN8nN2M
	ovLHw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8cfmdvhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:12:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:12:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:12:49 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 40A855B6942;
	Wed, 20 May 2026 07:12:42 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 12/12] net: atlantic: add AQC113 PTP support in aq_ptp and driver core
Date: Wed, 20 May 2026 19:40:45 +0530
Message-ID: <20260520141046.2151-13-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=JYuMa0KV c=1 sm=1 tr=0 ts=6a0dc162 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=6XZc2mIfAAAA:8
 a=zqemhHUUE2z4KKSHsBkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=vbtKyj4BGzZNu1KS43SK:22
X-Proofpoint-ORIG-GUID: 4_xLscnJG3iY-U7ZAiDsH18rhSPTCERB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX3zS+yNTIKUZN
 h1SLyga2VTA08TD5IH+EwGdxsFpX6BfDlfWHs6kl4dVrlVb2K1FHQrGIPpEoHkx0q2dIGX+6vC+
 +gnnJoK8mvYIhda0wfMtcNofyKDdlzmptuoXECWjmIRHAteqIyStp1lHyHknqdoGq8xVohA1buC
 gwdo7pst4LqGGbpNinnNI7u52rU9l1kw7VpEDFUjznY/XINlupr2emZmeNKo6c19RIk3F/NMtno
 y0NbI6OA7/BT/bojcMByyDjjR9VzbTIhd8hFNRP/ieXRaUXH07dCuSjXHQWLntCuP7o/MotqyOI
 rMBN1QFyxwmx4jCM3dsY+/Q505HyV/w4l/loSndHJV//jDX9V6VPAK5W70gMNmLuHtp1Vtmu+H2
 p4OBlCav8yWPkr7u38h6vbCE2Pgbsg1C3bEF9jCf55l+VA0dlGWOTWWQAJs8nkcqFwfMHQcjliR
 /ZPrSqWhEtHe3x8PZjw==
X-Proofpoint-GUID: 4_xLscnJG3iY-U7ZAiDsH18rhSPTCERB
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289971-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DDF3658FB73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
- Move filter/VLAN rule application into aq_nic_start() after PTP ring
  setup for correct ordering.
- Call hw_atl2 PTP re-enable hook after hardware reset in
  aq_nic_update_link_status().

aq_pci_func.c:
- Pass PTP IRQ index to aq_ptp_irq_alloc() in probe path.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |   1 +
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  50 +-
 .../ethernet/aquantia/atlantic/aq_pci_func.c  |   5 +-
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 542 ++++++++++++++----
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |  15 +-
 5 files changed, 477 insertions(+), 136 deletions(-)

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
index 3cec853e9fad..9d37e0afed63 100644
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
@@ -172,7 +180,11 @@ static int aq_nic_update_link_status(struct aq_nic_s *self)
 		aq_nic_update_interrupt_moderation_settings(self);
 
 		if (self->aq_ptp) {
-			aq_ptp_clock_init(self);
+			/* PTP does not work in some modes even if physical link is up */
+			bool ptp_link_good = (self->aq_hw->aq_link_status.mbps >= 100 &&
+					      self->aq_hw->aq_link_status.full_duplex);
+
+			aq_ptp_clock_init(self, ptp_link_good ? AQ_PTP_LINK_UP : AQ_PTP_NO_LINK);
 			aq_ptp_tm_offset_set(self,
 					     self->aq_hw->aq_link_status.mbps);
 			aq_ptp_link_change(self);
@@ -279,6 +291,7 @@ static int aq_nic_hw_prepare(struct aq_nic_s *self)
 	int err = 0;
 
 	err = self->aq_hw_ops->hw_soft_reset(self->aq_hw);
+
 	if (err)
 		goto exit;
 
@@ -450,7 +463,14 @@ int aq_nic_init(struct aq_nic_s *self)
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
 
@@ -496,6 +516,14 @@ int aq_nic_start(struct aq_nic_s *self)
 			goto err_exit;
 	}
 
+	err = aq_reapply_rxnfc_all_rules(self);
+	if (err < 0)
+		goto err_exit;
+
+	err = aq_filters_vlans_update(self);
+	if (err < 0)
+		goto err_exit;
+
 	err = aq_ptp_ring_start(self);
 	if (err < 0)
 		goto err_exit;
@@ -683,6 +711,7 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
 	unsigned int ret = 0U;
 	unsigned int dx;
 	u8 l4proto = 0;
+	s32 clk_sel;
 
 	if (ipver == 4)
 		l4proto = ip_hdr(skb)->protocol;
@@ -793,6 +822,17 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
 
 	first->eop_index = dx;
 	dx_buff->is_eop = 1U;
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
 	dx_buff->skb = skb;
 	dx_buff->xdpf = NULL;
 	goto exit;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index e9e38af680c3..2e8378e595bd 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -250,6 +250,7 @@ static int aq_pci_probe(struct pci_dev *pdev,
 		goto err_ioremap;
 	}
 	self->aq_hw->aq_nic_cfg = aq_nic_get_cfg(self);
+	self->aq_hw->clk_select = -1;
 	if (self->aq_hw->aq_nic_cfg->aq_hw_caps->priv_data_len) {
 		int len = self->aq_hw->aq_nic_cfg->aq_hw_caps->priv_data_len;
 
@@ -293,8 +294,8 @@ static int aq_pci_probe(struct pci_dev *pdev,
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
index 7486a28d7ff8..31373c20782c 100644
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
@@ -366,6 +382,8 @@ static void aq_ptp_convert_to_hwtstamp(struct aq_ptp_s *aq_ptp,
 static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 			      u64 period)
 {
+	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
+
 	if (period)
 		netdev_dbg(aq_nic->ndev,
 			   "Enable GPIO %d pulsing, start time %llu, period %u\n",
@@ -380,7 +398,8 @@ static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 	 */
 	mutex_lock(&aq_nic->fwreq_mutex);
 	aq_nic->aq_hw_ops->hw_gpio_pulse(aq_nic->aq_hw, pin_index,
-					 0, start, (u32)period, 0);
+					 aq_ptp->ptp_clock_sel, start,
+					 (u32)period, PTP_GPIO_HIGHTIME);
 	mutex_unlock(&aq_nic->fwreq_mutex);
 
 	return 0;
@@ -454,7 +473,8 @@ static void aq_ptp_extts_pin_ctrl(struct aq_ptp_s *aq_ptp)
 
 	if (aq_nic->aq_hw_ops->hw_extts_gpio_enable)
 		aq_nic->aq_hw_ops->hw_extts_gpio_enable(aq_nic->aq_hw, 0,
-							0, enable);
+							aq_ptp->ptp_clock_sel,
+							enable);
 }
 
 static int aq_ptp_extts_pin_configure(struct ptp_clock_info *ptp,
@@ -543,14 +563,194 @@ void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp)
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
+static int aq_ptp_add_a2_filter(struct aq_ptp_s *aq_ptp,
+				struct ethtool_rx_flow_spec *fsp,
+				int *flt_idx)
+{
+	struct aq_nic_s *aq_nic = aq_ptp->aq_nic;
+	int err;
+
+	err = aq_set_data_fl3l4(fsp,
+				&aq_ptp->udp_filter[*flt_idx],
+				aq_ptp->udp_filter[*flt_idx].location,
+				true);
+	if (!err) {
+		netdev_dbg(aq_nic->ndev,
+			   "PTP MC filter prepared. Loc: %x\n",
+			   aq_ptp->udp_filter[*flt_idx].location);
+		(*flt_idx)++;
+	}
+	return err;
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
+				err = aq_ptp_add_a2_filter(aq_ptp, fsp,
+							   &flt_idx);
+				if (err)
+					netdev_dbg(aq_nic->ndev,
+						   "UDPv4 filter prepare failed\n");
+
+				aq_ptp_fill_udpv6_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV6_MC_ADDR20 << 16),
+						     cpu_to_be32(0xffff0000),
+						     cpu_to_be32(PTP_IPV6_MC_ADDR24),
+						     cpu_to_be32(0x0000ffff));
+				err = aq_ptp_add_a2_filter(aq_ptp, fsp,
+							   &flt_idx);
+				if (err)
+					netdev_dbg(aq_nic->ndev,
+						   "UDPv6 filter prepare failed\n");
+
+				aq_ptp_fill_udpv6_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV6_MC_ADDR10 << 16),
+						     cpu_to_be32(0xffff0000),
+						     cpu_to_be32(PTP_IPV6_MC_ADDR14),
+						     cpu_to_be32(0x0000ffff));
+				err = aq_ptp_add_a2_filter(aq_ptp, fsp,
+							   &flt_idx);
+				if (err)
+					netdev_dbg(aq_nic->ndev,
+						   "UDPv6 filter prepare failed\n");
+
+				aq_ptp_fill_udpv4_mc(fsp, rx_queue,
+						     cpu_to_be32(PTP_IPV4_MC_ADDR2));
+				err = aq_ptp_add_a2_filter(aq_ptp, fsp,
+							   &flt_idx);
+				if (err)
+					netdev_dbg(aq_nic->ndev,
+						   "UDPv4 filter prepare failed\n");
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
@@ -572,53 +772,56 @@ void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
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
+	if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter) {
+		mutex_lock(&aq_ptp->ptp_filter_lock);
+		err = aq_ptp_dpath_enable(aq_ptp,
+					  ptp_en_flags,
+					  aq_ptp->ptp_rx.idx);
+		mutex_unlock(&aq_ptp->ptp_filter_lock);
+	}
+
+	if (ptp_en_flags != AQ_HW_PTP_DISABLE)
 		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
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
+	else
 		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
-	}
 
 	if (err)
 		return -EREMOTEIO;
@@ -673,21 +876,23 @@ static int aq_ptp_poll(struct napi_struct *napi, int budget)
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
@@ -818,7 +1023,7 @@ int aq_ptp_irq_alloc(struct aq_nic_s *aq_nic)
 		return 0;
 
 	if (pdev->msix_enabled || pdev->msi_enabled) {
-		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_vector),
+		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector),
 				  aq_ptp_isr, 0, aq_nic->ndev->name, aq_ptp);
 	} else {
 		err = -EINVAL;
@@ -837,7 +1042,7 @@ void aq_ptp_irq_free(struct aq_nic_s *aq_nic)
 	if (!aq_ptp)
 		return;
 
-	free_irq(pci_irq_vector(pdev, aq_ptp->idx_vector), aq_ptp);
+	free_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector), aq_ptp);
 }
 
 int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
@@ -875,6 +1080,9 @@ int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
 	if (err < 0)
 		goto err_rx_free;
 
+	if (aq_ptp->a2_ptp)
+		return 0;
+
 	err = aq_ring_init(&aq_ptp->hwts_rx, ATL_RING_RX);
 	if (err < 0)
 		goto err_rx_free;
@@ -912,10 +1120,12 @@ int aq_ptp_ring_start(struct aq_nic_s *aq_nic)
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
 
@@ -933,7 +1143,9 @@ void aq_ptp_ring_stop(struct aq_nic_s *aq_nic)
 	aq_nic->aq_hw_ops->hw_ring_tx_stop(aq_nic->aq_hw, &aq_ptp->ptp_tx);
 	aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw, &aq_ptp->ptp_rx);
 
-	aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw, &aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw,
+						   &aq_ptp->hwts_rx);
 
 	napi_disable(&aq_ptp->napi);
 }
@@ -972,11 +1184,13 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
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
@@ -984,7 +1198,7 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 		goto err_exit_hwts_rx;
 	}
 
-	aq_ptp->ptp_ring_param.vec_idx = aq_ptp->idx_vector;
+	aq_ptp->ptp_ring_param.vec_idx = aq_ptp->idx_ptp_vector;
 	aq_ptp->ptp_ring_param.cpu = aq_ptp->ptp_ring_param.vec_idx +
 			aq_nic_get_cfg(aq_nic)->aq_rss.base_cpu_number;
 	cpumask_set_cpu(aq_ptp->ptp_ring_param.cpu,
@@ -993,7 +1207,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	return 0;
 
 err_exit_hwts_rx:
-	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1011,7 +1226,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 
 	aq_ring_free(&aq_ptp->ptp_tx);
 	aq_ring_free(&aq_ptp->ptp_rx);
-	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 
 	aq_ptp_skb_ring_release(&aq_ptp->skb_ring);
 }
@@ -1035,46 +1251,49 @@ static struct ptp_clock_info aq_ptp_clock = {
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
@@ -1082,11 +1301,12 @@ static void aq_ptp_offset_init_from_fw(const struct hw_atl_ptp_offset *offsets)
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
@@ -1139,26 +1359,44 @@ static void aq_ptp_gpio_init(struct ptp_clock_info *info,
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
+		unsigned int ptp_en_flags =
+			aq_ptp_parse_rx_filters(state == AQ_PTP_LINK_UP ?
+						aq_ptp->hwtstamp_config.rx_filter :
+						HWTSTAMP_FILTER_NONE);
+		mutex_lock(&aq_ptp->ptp_filter_lock);
+		aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
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
@@ -1168,19 +1406,43 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
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
@@ -1190,10 +1452,13 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 
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
@@ -1210,22 +1475,34 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 
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
 
@@ -1244,30 +1521,45 @@ void aq_ptp_unregister(struct aq_nic_s *aq_nic)
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
 
 	kfree(aq_ptp->ptp_info.pin_config);
+	aq_ptp->ptp_info.pin_config = NULL;
 
 	netif_napi_del(&aq_ptp->napi);
 	kfree(aq_ptp);
+	aq_utils_obj_clear(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
 	aq_nic->aq_ptp = NULL;
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 5e643ec7cc06..df93857deac9 100644
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
 
 /* Traffic processing functions */
 int aq_ptp_xmit(struct aq_nic_s *aq_nic, struct sk_buff *skb);
@@ -80,7 +86,7 @@ u64 *aq_ptp_get_stats(struct aq_nic_s *aq_nic, u64 *data);
 
 #else
 
-static inline int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
+static inline int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec)
 {
 	return 0;
 }
@@ -122,7 +128,8 @@ static inline void aq_ptp_ring_deinit(struct aq_nic_s *aq_nic) {}
 static inline void aq_ptp_service_task(struct aq_nic_s *aq_nic) {}
 static inline void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic,
 					unsigned int mbps) {}
-static inline void aq_ptp_clock_init(struct aq_nic_s *aq_nic) {}
+static inline void aq_ptp_clock_init(struct aq_nic_s *aq_nic,
+				     enum aq_ptp_state state) {}
 static inline int aq_ptp_xmit(struct aq_nic_s *aq_nic, struct sk_buff *skb)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


