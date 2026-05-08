Return-Path: <netdev+bounces-285782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB8UGFrR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F774F6135
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 263D0300EDB4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358DC3D5240;
	Fri,  8 May 2026 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DiMsmVh1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC03D0918;
	Fri,  8 May 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241880; cv=none; b=tUMyG9lGdgR2muu4pughxYb+P9PKlwgqkXNzSln9cVkdvBNYpJO0K2+OHu4t6mTlmkv3XrR+22oqAuJ0Hq5M77TWqoRkKz7Q9cX1IpRTTMWWqB8qLH5bNF4ONEisF7B+fqU/lu2d/OrPp/WcFdLzc322Tf/eATw8hb7UCUn4tCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241880; c=relaxed/simple;
	bh=7g055n00NvFTN9lIMo0CyvDamJMaLZEp9Dp/5sE5Jag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYpLU3Zdf2NW9IVZjzrsK0dCcZtQEW+zAhTQ6eLzmc3xC3Qw6qQDdvd1Ju92IPHbWJywB0UbeYOuB30+bz9z9ULZ5HO7IkTNHtsQXol1lyFD+dQT/bcrBssxa4niZhNnxv33W25IeBIe2UJ556sATrRlze6xqFYw0Dkd/lrJtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DiMsmVh1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648BPUpZ2841687;
	Fri, 8 May 2026 05:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
	4ARQlUwKuzZXpy7J4k5mvR0HhFKnmxbCyRhzYhcA5k=; b=DiMsmVh1oGThsfFNA
	Me/OUY8eBnsWJsNjVjs6UllmKyseEcwjhk6cuNl0I0NEPX/WauF94bKQROlLUNJL
	0T0rXXg9/3RFlXJgZpaRb2CqK9n5pLaEoTzZyXdRdNKxkizOvJnPOx/zJbZDtrKJ
	2z0McNtN9XL9svgWdoh/0IJO38ybc6RE3MxKRF1dPzUc/3cFBet0BUqBZgzjujRU
	2ThqafVRMoXUNDN9dGpvFcud+PGsqUTpO9UN5qunznpmleGA2MZy98pKjb2uTWV+
	9bPHvFp7h4+a1rIdFlzmJLgeH3K9QvuwLwQIozuzzs3g+lQWOyvVKxOm685sX6ZL
	2UVpQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e14g0hqwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:04:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:04:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:04:08 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 917A43F7087;
	Fri,  8 May 2026 05:04:03 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 9/9] net: atlantic: add PTP support for AQC113 (Antigua) (Antigua)
Date: Fri, 8 May 2026 17:31:56 +0530
Message-ID: <20260508120156.3060-10-sukhdeeps@marvell.com>
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
X-Proofpoint-ORIG-GUID: DJx4QQN5WXl51EduFJd1nlD4686bSI_Q
X-Authority-Analysis: v=2.4 cv=bMUm5v+Z c=1 sm=1 tr=0 ts=69fdd13a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=6XZc2mIfAAAA:8
 a=oAJpGNNeFsV_TL9veLAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=vbtKyj4BGzZNu1KS43SK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX7q3vCEvTmM6y
 EnsODYdim+fH9tLnYKEy+jCh3dFHGCsFRh+64kUyAcw3FKDGOLrFyk2NDp6BwHJhCMeLXpOfgMz
 u3b3jqw1PNvJk2wGq5iN1G1Gn6DBvORM1PYCquXQ06/P16LntJsg58QK1Qi/nJyxelQG2MBbVug
 cwItu8ayGG0Uw7BRMmQ1YQ5A/kWfdodv4go+PTqZoPaCdjP2ta1FLaHF3IhnvCJD9++G9e/w3wF
 Yxdm7Ib5McEfQZcpwOEaG1n+y6YJ/kosLIhMu7xPzc6Yd7wi4jnjtA58shb55F2jp4fsOuaZ5CF
 O7aJ4O5DdObrLLiUL+dr/3DCogIdBguh1c66102Q8yW1iyPH+Oh+bySTK3uug9Y+A9i2I3zppFG
 ygBcyBIUn2tkpY1+OZBccAwmhGYJTbNwLg1uAtB5ItqGKDhGlOYeTMquThpnUQD42deTX4NBVyg
 9B8WX+etV+bs0hSYFGA==
X-Proofpoint-GUID: DJx4QQN5WXl51EduFJd1nlD4686bSI_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 25F774F6135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285782-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add IEEE 1588 PTP support for the AQC113 (Antigua) network controller
alongside the existing AQC107 (Atlantic) PTP implementation.

AQC113 PTP uses a different hardware architecture from AQC107:
- Dual TSG clocks (sel 0 for PTP, sel 1 for PTM) instead of PHY-based
  timestamping
- TX timestamp via descriptor writeback instead of firmware mailbox
- Per-instance PTP timestamp offsets instead of global static table
- Hardware L3/L4 filters for PTP multicast steering with IPv4 and
  IPv6 support (4 filter slots for multicast addresses)
- Direct hardware clock control instead of firmware-mediated access

Key implementation details:

PTP clock management:
- Add aq_ptp_state enum to distinguish first init, link up, and no
  link states for proper clock initialization
- On AQC113, only reset the clock on first init (not on every link
  change) to avoid disrupting ongoing PTP synchronization
- Re-apply RX filters on link change since hardware state is lost

TX timestamp path:
- Add per-packet TX timestamp request via request_ts/clk_sel in the
  ring buffer descriptor
- Poll for TX timestamp completion in aq_ring_tx_clean() with a
  timeout mechanism (aq_ptp_tx_ts_timedout/clear)
- Set AQ_HW_TXD_CTL_TS_EN in TX descriptors for timestamp-requested
  packets

RX filter management:
- Replace single UDP filter with array of 4 for IPv4/IPv6 multicast
  PTP addresses (224.0.1.129, 224.0.0.107, ff0e::181, ff02::6b)
- Add aq_ptp_dpath_enable() for comprehensive filter setup/teardown
- Add aq_ptp_parse_rx_filters() to map hwtstamp_rx_filters to L2/L4
  enable flags

PTP TX path in aq_main.c:
- Add IPv6 PTP packet detection using ipv6_hdr()->nexthdr
- Use PTP_EV_PORT/PTP_GEN_PORT defines instead of magic numbers
- Move skb_tx_timestamp() to non-PTP path to avoid double timestamps

IRQ and initialization:
- Account for PTP IRQ vector (AQ_HW_PTP_IRQS) in vector math
- Move filter/VLAN rule application to aq_nic_start() for proper
  ordering after PTP ring setup
- Add AQ_HW_FLAG_STARTED flag management in open/close

HW layer (hw_atl2.c):
- Implement PTP clock enable/disable, read, adjust, increment
- Add GPIO pulse generation for PPS output
- Add TX/RX PTP ring initialization
- Add TX timestamp descriptor readback
- Add RX timestamp extraction from packet trailer
- Re-enable PTP after hardware reset
- Wire all PTP ops into hw_atl2_ops table

Per-instance PTP offsets with empirically measured values for AQC113
at each link speed (100M/1G/2.5G/5G/10G).

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |   1 +
 .../net/ethernet/aquantia/atlantic/aq_main.c  |  34 +-
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  48 +-
 .../ethernet/aquantia/atlantic/aq_pci_func.c  |   4 +-
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 535 ++++++++++++++----
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |  15 +-
 .../net/ethernet/aquantia/atlantic/aq_ring.c  |  42 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 179 +++++-
 .../aquantia/atlantic/hw_atl2/hw_atl2.h       |  12 +
 .../atlantic/hw_atl2/hw_atl2_internal.h       |   3 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  10 +
 11 files changed, 710 insertions(+), 173 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index e3bacad08b93..4141210578fd 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -15,6 +15,7 @@
 #include "aq_common.h"
 #include "aq_rss.h"
 #include "hw_atl/hw_atl_utils.h"
+#include "hw_atl2/hw_atl2.h"
 
 #define AQ_HW_MAC_COUNTER_HZ   312500000ll
 #define AQ_HW_PHY_COUNTER_HZ   160000000ll
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 4ef4fe64b8ac..aadf3f7f40d0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -19,8 +19,10 @@
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <net/pkt_cls.h>
+#include <linux/ptp_classify.h>
 #include <net/pkt_sched.h>
 #include <linux/filter.h>
 
@@ -68,20 +70,14 @@ int aq_ndev_open(struct net_device *ndev)
 	if (err < 0)
 		goto err_exit;
 
-	err = aq_reapply_rxnfc_all_rules(aq_nic);
-	if (err < 0)
-		goto err_exit;
-
-	err = aq_filters_vlans_update(aq_nic);
-	if (err < 0)
-		goto err_exit;
-
 	err = aq_nic_start(aq_nic);
 	if (err < 0) {
 		aq_nic_stop(aq_nic);
 		goto err_exit;
 	}
 
+	aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_FLAG_STARTED);
+
 err_exit:
 	if (err < 0)
 		aq_nic_deinit(aq_nic, true);
@@ -97,6 +93,7 @@ int aq_ndev_close(struct net_device *ndev)
 	err = aq_nic_stop(aq_nic);
 	aq_nic_deinit(aq_nic, true);
 
+	aq_utils_obj_clear(&aq_nic->aq_hw->flags, AQ_HW_FLAG_STARTED);
 	return err;
 }
 
@@ -113,16 +110,25 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
 		 * and hardware PTP design of the chip. Otherwise ptp stream
 		 * will fail to sync
 		 */
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) ||
-		    unlikely((ip_hdr(skb)->version == 4) &&
-			     (ip_hdr(skb)->protocol == IPPROTO_UDP) &&
-			     ((udp_hdr(skb)->dest == htons(319)) ||
-			      (udp_hdr(skb)->dest == htons(320)))) ||
-		    unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
+		if (unlikely(skb->protocol == htons(ETH_P_IP) &&
+			     ip_hdr(skb)->protocol == IPPROTO_UDP &&
+			     (udp_hdr(skb)->dest == htons(PTP_EV_PORT) ||
+			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
+			return aq_ptp_xmit(aq_nic, skb);
+
+		/* PTP over IPv6 does not use extension headers */
+		if (unlikely(skb->protocol == htons(ETH_P_IPV6) &&
+			     ipv6_hdr(skb)->nexthdr == IPPROTO_UDP &&
+			     (udp_hdr(skb)->dest == htons(PTP_EV_PORT) ||
+			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
+			return aq_ptp_xmit(aq_nic, skb);
+
+		if (unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
 			return aq_ptp_xmit(aq_nic, skb);
 	}
 #endif
 
+	skb_tx_timestamp(skb);
 	return aq_nic_xmit(aq_nic, skb);
 }
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 3cec853e9fad..63a4987a60de 100644
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
@@ -279,6 +291,9 @@ static int aq_nic_hw_prepare(struct aq_nic_s *self)
 	int err = 0;
 
 	err = self->aq_hw_ops->hw_soft_reset(self->aq_hw);
+
+	self->aq_hw->clk_select = -1;
+
 	if (err)
 		goto exit;
 
@@ -450,7 +465,14 @@ int aq_nic_init(struct aq_nic_s *self)
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
 
@@ -496,6 +518,14 @@ int aq_nic_start(struct aq_nic_s *self)
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
@@ -793,6 +823,12 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
 
 	first->eop_index = dx;
 	dx_buff->is_eop = 1U;
+	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+	    self->aq_hw_ops->enable_ptp &&
+	    self->aq_hw_ops->hw_get_clk_sel) {
+		dx_buff->request_ts = 1U;
+		dx_buff->clk_sel = self->aq_hw_ops->hw_get_clk_sel(self->aq_hw);
+	}
 	dx_buff->skb = skb;
 	dx_buff->xdpf = NULL;
 	goto exit;
@@ -895,8 +931,6 @@ int aq_nic_xmit(struct aq_nic_s *self, struct sk_buff *skb)
 
 	frags = aq_nic_map_skb(self, skb, ring);
 
-	skb_tx_timestamp(skb);
-
 	if (likely(frags)) {
 		err = self->aq_hw_ops->hw_ring_tx_xmit(self->aq_hw,
 						       ring, frags);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index e9e38af680c3..9e72a9c23b40 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -293,8 +293,8 @@ static int aq_pci_probe(struct pci_dev *pdev,
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
index 7486a28d7ff8..781d865e1127 100644
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
@@ -49,6 +61,12 @@ struct ptp_tx_timeout {
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
@@ -64,7 +82,7 @@ struct aq_ptp_s {
 
 	struct ptp_tx_timeout ptp_tx_timeout;
 
-	unsigned int idx_vector;
+	unsigned int idx_ptp_vector;
 	struct napi_struct napi;
 
 	struct aq_ring_s ptp_tx;
@@ -73,7 +91,7 @@ struct aq_ptp_s {
 
 	struct ptp_skb_ring skb_ring;
 
-	struct aq_rx_filter_l3l4 udp_filter;
+	struct aq_rx_filter_l3l4 udp_filter[PTP_UDP_FILTERS_CNT];
 	struct aq_rx_filter_l2 eth_type_filter;
 
 	struct delayed_work poll_sync;
@@ -81,18 +99,15 @@ struct aq_ptp_s {
 
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
@@ -104,10 +119,10 @@ void aq_ptp_tm_offset_set(struct aq_nic_s *aq_nic, unsigned int mbps)
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
@@ -366,6 +381,8 @@ static void aq_ptp_convert_to_hwtstamp(struct aq_ptp_s *aq_ptp,
 static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 			      u64 period)
 {
+	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
+
 	if (period)
 		netdev_dbg(aq_nic->ndev,
 			   "Enable GPIO %d pulsing, start time %llu, period %u\n",
@@ -380,7 +397,8 @@ static int aq_ptp_hw_pin_conf(struct aq_nic_s *aq_nic, u32 pin_index, u64 start,
 	 */
 	mutex_lock(&aq_nic->fwreq_mutex);
 	aq_nic->aq_hw_ops->hw_gpio_pulse(aq_nic->aq_hw, pin_index,
-					 0, start, (u32)period, 0);
+					 aq_ptp->ptp_clock_sel, start,
+					 (u32)period, PTP_GPIO_HIGHTIME);
 	mutex_unlock(&aq_nic->fwreq_mutex);
 
 	return 0;
@@ -454,7 +472,8 @@ static void aq_ptp_extts_pin_ctrl(struct aq_ptp_s *aq_ptp)
 
 	if (aq_nic->aq_hw_ops->hw_extts_gpio_enable)
 		aq_nic->aq_hw_ops->hw_extts_gpio_enable(aq_nic->aq_hw, 0,
-							0, enable);
+							aq_ptp->ptp_clock_sel,
+							enable);
 }
 
 static int aq_ptp_extts_pin_configure(struct ptp_clock_info *ptp,
@@ -543,14 +562,193 @@ void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp)
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
+	int err = 0, i = 0;
+	int flt_idx = 0;
+	const struct aq_hw_ops *hw_ops = aq_nic->aq_hw_ops;
+	struct ethtool_rx_flow_spec *fsp =
+		(struct ethtool_rx_flow_spec *)&cmd.fs;
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
+		if (!err && hw_ops->hw_filter_l2_set) {
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
@@ -572,53 +770,53 @@ void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
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
+	if (aq_ptp->hwtstamp_config.rx_filter != config->rx_filter)
+		err = aq_ptp_dpath_enable(aq_ptp,
+					  ptp_en_flags,
+					  aq_ptp->ptp_rx.idx);
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
@@ -673,21 +871,23 @@ static int aq_ptp_poll(struct napi_struct *napi, int budget)
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
@@ -818,7 +1018,7 @@ int aq_ptp_irq_alloc(struct aq_nic_s *aq_nic)
 		return 0;
 
 	if (pdev->msix_enabled || pdev->msi_enabled) {
-		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_vector),
+		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector),
 				  aq_ptp_isr, 0, aq_nic->ndev->name, aq_ptp);
 	} else {
 		err = -EINVAL;
@@ -837,7 +1037,7 @@ void aq_ptp_irq_free(struct aq_nic_s *aq_nic)
 	if (!aq_ptp)
 		return;
 
-	free_irq(pci_irq_vector(pdev, aq_ptp->idx_vector), aq_ptp);
+	free_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector), aq_ptp);
 }
 
 int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
@@ -875,6 +1075,9 @@ int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
 	if (err < 0)
 		goto err_rx_free;
 
+	if (aq_ptp->a2_ptp)
+		return 0;
+
 	err = aq_ring_init(&aq_ptp->hwts_rx, ATL_RING_RX);
 	if (err < 0)
 		goto err_rx_free;
@@ -912,10 +1115,12 @@ int aq_ptp_ring_start(struct aq_nic_s *aq_nic)
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
 
@@ -933,7 +1138,9 @@ void aq_ptp_ring_stop(struct aq_nic_s *aq_nic)
 	aq_nic->aq_hw_ops->hw_ring_tx_stop(aq_nic->aq_hw, &aq_ptp->ptp_tx);
 	aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw, &aq_ptp->ptp_rx);
 
-	aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw, &aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_nic->aq_hw_ops->hw_ring_rx_stop(aq_nic->aq_hw,
+						   &aq_ptp->hwts_rx);
 
 	napi_disable(&aq_ptp->napi);
 }
@@ -972,11 +1179,13 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
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
@@ -984,7 +1193,7 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 		goto err_exit_hwts_rx;
 	}
 
-	aq_ptp->ptp_ring_param.vec_idx = aq_ptp->idx_vector;
+	aq_ptp->ptp_ring_param.vec_idx = aq_ptp->idx_ptp_vector;
 	aq_ptp->ptp_ring_param.cpu = aq_ptp->ptp_ring_param.vec_idx +
 			aq_nic_get_cfg(aq_nic)->aq_rss.base_cpu_number;
 	cpumask_set_cpu(aq_ptp->ptp_ring_param.cpu,
@@ -993,7 +1202,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	return 0;
 
 err_exit_hwts_rx:
-	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_ring_free(&aq_ptp->hwts_rx);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1011,7 +1221,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 
 	aq_ring_free(&aq_ptp->ptp_tx);
 	aq_ring_free(&aq_ptp->ptp_rx);
-	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+	if (aq_ptp->a1_ptp)
+		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 
 	aq_ptp_skb_ring_release(&aq_ptp->skb_ring);
 }
@@ -1035,46 +1246,49 @@ static struct ptp_clock_info aq_ptp_clock = {
 	.pin_config	= NULL,
 };
 
-#define ptp_offset_init(__idx, __mbps, __egress, __ingress)   do { \
-		ptp_offset[__idx].mbps = (__mbps); \
-		ptp_offset[__idx].egress = (__egress); \
-		ptp_offset[__idx].ingress = (__ingress); } \
-		while (0)
+static inline void ptp_offset_init(struct aq_ptp_s *aq_ptp, int idx,
+				   unsigned int mbps, int egress, int ingress)
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
@@ -1082,11 +1296,12 @@ static void aq_ptp_offset_init_from_fw(const struct hw_atl_ptp_offset *offsets)
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
@@ -1139,26 +1354,43 @@ static void aq_ptp_gpio_init(struct ptp_clock_info *info,
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
+						AQ_HW_PTP_DISABLE);
+
+		aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
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
@@ -1168,19 +1400,43 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
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
@@ -1190,10 +1446,12 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 
 	aq_ptp->aq_nic = aq_nic;
 	aq_ptp->a1_ptp = a1_ptp;
+	aq_ptp->a2_ptp = a2_ptp;
 
 	spin_lock_init(&aq_ptp->ptp_lock);
 	spin_lock_init(&aq_ptp->ptp_ring_lock);
 
+	aq_ptp_offset_init(aq_ptp, &mbox.info.ptp_offset);
 	aq_ptp->ptp_info = aq_ptp_clock;
 	aq_ptp_gpio_init(&aq_ptp->ptp_info, &mbox.info);
 	clock = ptp_clock_register(&aq_ptp->ptp_info, &aq_nic->ndev->dev);
@@ -1210,22 +1468,34 @@ int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec)
 
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
 
@@ -1244,30 +1514,45 @@ void aq_ptp_unregister(struct aq_nic_s *aq_nic)
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
 
+	/* disable ptp */
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
+	cancel_delayed_work_sync(&aq_ptp->poll_sync);
+
 	aq_nic_release_filter(aq_nic, aq_rx_filter_ethertype,
 			      aq_ptp->eth_type_filter.location);
-	aq_nic_release_filter(aq_nic, aq_rx_filter_l3l4,
-			      aq_ptp->udp_filter.location);
-	cancel_delayed_work_sync(&aq_ptp->poll_sync);
-	/* disable ptp */
-	mutex_lock(&aq_nic->fwreq_mutex);
-	aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 0);
-	mutex_unlock(&aq_nic->fwreq_mutex);
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
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e270327e47fd..a52d6d3fe464 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -308,24 +308,30 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 			}
 		}
 
-		if (likely(!buff->is_eop))
-			goto out;
-
-		if (buff->skb) {
-			u64_stats_update_begin(&self->stats.tx.syncp);
-			++self->stats.tx.packets;
-			self->stats.tx.bytes += buff->skb->len;
-			u64_stats_update_end(&self->stats.tx.syncp);
-			dev_kfree_skb_any(buff->skb);
-		} else if (buff->xdpf) {
-			u64_stats_update_begin(&self->stats.tx.syncp);
-			++self->stats.tx.packets;
-			self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
-			u64_stats_update_end(&self->stats.tx.syncp);
-			xdp_return_frame_rx_napi(buff->xdpf);
-		}
+		if (unlikely(buff->is_eop)) {
+			if (unlikely(buff->request_ts) &&
+			    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
+				u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
+
+				if (!ts)
+					break;
 
-out:
+				aq_ptp_tx_hwtstamp(self->aq_nic, ts);
+			}
+			if (buff->skb) {
+				u64_stats_update_begin(&self->stats.tx.syncp);
+				++self->stats.tx.packets;
+				self->stats.tx.bytes += buff->skb->len;
+				u64_stats_update_end(&self->stats.tx.syncp);
+				dev_kfree_skb_any(buff->skb);
+			} else if (buff->xdpf) {
+				u64_stats_update_begin(&self->stats.tx.syncp);
+				++self->stats.tx.packets;
+				self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
+				u64_stats_update_end(&self->stats.tx.syncp);
+				xdp_return_frame_rx_napi(buff->xdpf);
+			}
+		}
 		buff->skb = NULL;
 		buff->xdpf = NULL;
 		buff->pa = 0U;
@@ -570,7 +576,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 							    self->hw_head);
 
 				if (unlikely(!is_rsc_completed) ||
-						frag_cnt > MAX_SKB_FRAGS) {
+				    frag_cnt > MAX_SKB_FRAGS) {
 					err = 0;
 					goto err_exit;
 				}
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index c71e8d1adfc9..3047bda619c0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -7,6 +7,7 @@
 #include "aq_hw_utils.h"
 #include "aq_ring.h"
 #include "aq_nic.h"
+#include "aq_ptp.h"
 #include "hw_atl/hw_atl_b0.h"
 #include "hw_atl/hw_atl_utils.h"
 #include "hw_atl/hw_atl_llh.h"
@@ -20,6 +21,15 @@
 static int hw_atl2_act_rslvr_table_set(struct aq_hw_s *self, u8 location,
 				       u32 tag, u32 mask, u32 action);
 
+static void hw_atl2_enable_ptp(struct aq_hw_s *self,
+			       unsigned int param, int enable);
+static int hw_atl2_hw_tx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring);
+static int hw_atl2_hw_rx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring);
+static void aq_get_ptp_ts(struct aq_hw_s *self, u64 *stamp);
+static int hw_atl2_adj_clock_freq(struct aq_hw_s *self, s32 ppb);
+
 #define DEFAULT_BOARD_BASIC_CAPABILITIES \
 	.is_64_dma = true,		  \
 	.op64bit = true,		  \
@@ -144,6 +154,12 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
 		priv->l3l4_filters[i].l4_index = -1;
 	}
 
+	if (self->clk_select != -1)
+		hw_atl2_enable_ptp(self,
+				   self->clk_select,
+				   aq_utils_obj_test(&self->flags, AQ_HW_PTP_AVAILABLE) ?
+				   1 : 0);
+
 	self->aq_fw_ops->set_state(self, MPI_RESET);
 
 	err = aq_hw_err_from_flags(self);
@@ -719,14 +735,24 @@ static int hw_atl2_hw_ring_rx_init(struct aq_hw_s *self,
 				   struct aq_ring_s *aq_ring,
 				   struct aq_ring_param_s *aq_ring_param)
 {
-	return hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
+	int res = hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
+
+	if (aq_ptp_ring(aq_ring->aq_nic, aq_ring))
+		hw_atl2_hw_rx_ptp_ring_init(self, aq_ring);
+
+	return res;
 }
 
 static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
 				   struct aq_ring_s *aq_ring,
 				   struct aq_ring_param_s *aq_ring_param)
 {
-	return hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
+	int res = hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
+
+	if (aq_ptp_ring(aq_ring->aq_nic, aq_ring))
+		hw_atl2_hw_tx_ptp_ring_init(self, aq_ring);
+
+	return res;
 }
 
 #define IS_FILTER_ENABLED(_F_) ((packet_filter & (_F_)) ? 1U : 0U)
@@ -886,6 +912,138 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
 	return &self->curr_stats;
 }
 
+static u32 hw_atl2_tsg_int_clk_freq(struct aq_hw_s *self)
+{
+	return AQ2_HW_PTP_COUNTER_HZ;
+}
+
+static void hw_atl2_enable_ptp(struct aq_hw_s *self,
+			       unsigned int param, int enable)
+{
+	self->clk_select = param;
+
+	/* enable tsg counter */
+	hw_atl2_tsg_clock_reset(self, self->clk_select);
+	hw_atl2_tsg_clock_en(self, !self->clk_select, enable);
+	hw_atl2_tsg_clock_en(self, self->clk_select, enable);
+
+	if (enable)
+		hw_atl2_adj_clock_freq(self, 0);
+
+	hw_atl2_tpb_tps_highest_priority_tc_enable_set(self, enable);
+}
+
+static void aq_get_ptp_ts(struct aq_hw_s *self, u64 *stamp)
+{
+	if (stamp)
+		*stamp = hw_atl2_tsg_clock_read(self, self->clk_select);
+}
+
+static u64 hw_atl2_hw_ring_tx_ptp_get_ts(struct aq_ring_s *ring)
+{
+	struct hw_atl2_txts_s *txts;
+
+	txts = (struct hw_atl2_txts_s *)&ring->dx_ring[ring->sw_head *
+						HW_ATL2_TXD_SIZE];
+	/* DD + TS_VALID */
+	if ((txts->ctrl & HW_ATL2_TXTS_DD) && (txts->ctrl & HW_ATL2_TXTS_TS_VALID))
+		return txts->ts;
+
+	return 0;
+}
+
+static u16 hw_atl2_hw_rx_extract_ts(struct aq_hw_s *self, u8 *p,
+				    unsigned int len, u64 *timestamp)
+{
+	unsigned int offset = HW_ATL2_RX_TS_SIZE;
+	u8 *ptr;
+
+	if (len <= offset || !timestamp)
+		return 0;
+
+	ptr = p + (len - offset);
+	memcpy(timestamp, ptr, sizeof(*timestamp));
+
+	return HW_ATL2_RX_TS_SIZE;
+}
+
+static int hw_atl2_adj_sys_clock(struct aq_hw_s *self, s64 delta)
+{
+	if (delta >= 0)
+		hw_atl2_tsg_clock_add(self, self->clk_select, (u64)delta);
+	else
+		hw_atl2_tsg_clock_sub(self, self->clk_select, (u64)(-delta));
+
+	return 0;
+}
+
+static int hw_atl2_adj_clock_freq(struct aq_hw_s *self, s32 ppb)
+{
+	u32 freq = hw_atl2_tsg_int_clk_freq(self);
+	u64 divisor = 0, base_ns;
+	u32 nsi_frac = 0, nsi;
+	u32 nsi_rem;
+
+	base_ns = div_u64((u64)((s64)ppb + NSEC_PER_SEC) * NSEC_PER_SEC, freq);
+	nsi = (u32)div_u64_rem(base_ns, NSEC_PER_SEC, &nsi_rem);
+	if (nsi_rem != 0) {
+		divisor = div_u64(mul_u32_u32(NSEC_PER_SEC, NSEC_PER_SEC),
+				  nsi_rem);
+		nsi_frac = (u32)div64_u64(AQ_FRAC_PER_NS * NSEC_PER_SEC,
+					  divisor);
+	}
+
+	hw_atl2_tsg_clock_increment_set(self, self->clk_select, nsi, nsi_frac);
+
+	return 0;
+}
+
+static int hw_atl2_hw_tx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring)
+{
+	hw_atl2_tdm_tx_desc_timestamp_writeback_en_set(self, true,
+						       aq_ring->idx);
+	hw_atl2_tdm_tx_desc_timestamp_en_set(self, true, aq_ring->idx);
+	hw_atl2_tdm_tx_desc_avb_en_set(self, true, aq_ring->idx);
+
+	return aq_hw_err_from_flags(self);
+}
+
+static int hw_atl2_hw_rx_ptp_ring_init(struct aq_hw_s *self,
+				       struct aq_ring_s *aq_ring)
+{
+	hw_atl2_rpf_rx_desc_timestamp_req_set(self,
+					      self->clk_select == ATL_TSG_CLOCK_SEL_1 ? 2 : 1,
+					      aq_ring->idx);
+	return aq_hw_err_from_flags(self);
+}
+
+static u32 hw_atl2_hw_get_clk_sel(struct aq_hw_s *self)
+{
+	return self->clk_select;
+}
+
+static int hw_atl2_gpio_pulse(struct aq_hw_s *self, u32 index, u32 clk_sel,
+			      u64 start, u32 period, u32 hightime)
+{
+	u32 mode;
+
+	if (start == 0)
+		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_GPIO;
+	else if (clk_sel == ATL_TSG_CLOCK_SEL_0)
+		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_TSG0_EVENT_OUTPUT;
+	else
+		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_TSG1_EVENT_OUTPUT;
+
+	if (index == 1 || index == 3) { /* Hardware limitation */
+		hw_atl2_gpio_special_mode_set(self, mode, index);
+	}
+
+	hw_atl2_tsg_ptp_gpio_gen_pulse(self, clk_sel, start, period, hightime);
+
+	return 0;
+}
+
 static bool hw_atl2_rxf_l3_is_equal(struct hw_atl2_l3_filter *f1,
 				    struct hw_atl2_l3_filter *f2)
 {
@@ -1474,4 +1632,21 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_set_offload              = hw_atl_b0_hw_offload_set,
 	.hw_set_loopback             = hw_atl_b0_set_loopback,
 	.hw_set_fc                   = hw_atl_b0_set_fc,
+
+	.hw_ring_hwts_rx_fill        = NULL,
+	.hw_ring_hwts_rx_receive     = NULL,
+
+	.hw_get_ptp_ts           = aq_get_ptp_ts,
+	.hw_adj_clock_freq       = hw_atl2_adj_clock_freq,
+	.hw_adj_sys_clock        = hw_atl2_adj_sys_clock,
+	.hw_gpio_pulse           = hw_atl2_gpio_pulse,
+
+	.enable_ptp              = hw_atl2_enable_ptp,
+	.hw_ring_tx_ptp_get_ts   = hw_atl2_hw_ring_tx_ptp_get_ts,
+	.rx_extract_ts           = hw_atl2_hw_rx_extract_ts,
+	.hw_tx_ptp_ring_init     = hw_atl2_hw_tx_ptp_ring_init,
+	.hw_rx_ptp_ring_init     = hw_atl2_hw_rx_ptp_ring_init,
+	.hw_get_clk_sel          = hw_atl2_hw_get_clk_sel,
+	.extract_hwts            = NULL,
+	.hw_extts_gpio_enable    = NULL,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h
index 346f0dc9912e..4b905231ae73 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h
@@ -7,6 +7,18 @@
 #define HW_ATL2_H
 
 #include "aq_common.h"
+#define HW_ATL2_RX_TS_SIZE 8
+
+#define HW_ATL2_PTP_OFFSET_INGRESS_100          768
+#define HW_ATL2_PTP_OFFSET_EGRESS_100           336
+#define HW_ATL2_PTP_OFFSET_INGRESS_1000         510
+#define HW_ATL2_PTP_OFFSET_EGRESS_1000          105
+#define HW_ATL2_PTP_OFFSET_INGRESS_2500         2447
+#define HW_ATL2_PTP_OFFSET_EGRESS_2500          634
+#define HW_ATL2_PTP_OFFSET_INGRESS_5000         1426
+#define HW_ATL2_PTP_OFFSET_EGRESS_5000          361
+#define HW_ATL2_PTP_OFFSET_INGRESS_10000        997
+#define HW_ATL2_PTP_OFFSET_EGRESS_10000         203
 
 extern const struct aq_hw_caps_s hw_atl2_caps_aqc113;
 extern const struct aq_hw_caps_s hw_atl2_caps_aqc115c;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
index 31d7cae6641a..e0687fb4350a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
@@ -29,7 +29,8 @@
 #define HW_ATL2_TXBUF_MAX              128U
 #define HW_ATL2_PTP_TXBUF_SIZE           8U
 
-#define HW_ATL2_RXBUF_MAX              192U
+/* Reduced from 192 to reserve space for PTP RX timestamp trailer */
+#define HW_ATL2_RXBUF_MAX              172U
 #define HW_ATL2_PTP_RXBUF_SIZE          16U
 #define HW_ATL2_RSS_REDIRECTION_MAX 64U
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
index c84955bc14ae..6a90e6389ebd 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
@@ -8,6 +8,16 @@
 
 #include "aq_hw.h"
 
+/* Hardware tx launch time descriptor */
+struct hw_atl2_txts_s {
+	u64 ts;
+	u32 ctrl;
+	u32 reserved;
+};
+
+#define HW_ATL2_TXTS_DD	BIT(3)
+#define HW_ATL2_TXTS_TS_VALID   BIT(20)
+
 /* F W    A P I */
 
 struct link_options_s {
-- 
2.43.0


