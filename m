Return-Path: <netdev+bounces-289963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCMYHDzEDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:25:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF7A58F8CC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61D49308508E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00E3E9C10;
	Wed, 20 May 2026 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="X2CfpcJl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0C3EC2CE;
	Wed, 20 May 2026 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286347; cv=none; b=SFVJhArFT3XasVbxwPhwWvC/8NFzwx9DW9riO5V7eKPaWYOzjV5Pgp9n4cYKHKvy+Q+WgBeYQ15bJsekgOrb9HDBYSowGbeRBu88nCpnShEBQLn1OqzmsQrjq5fg9L9r4qNpOuSa/Bwr37MZtpiwQnx+yOYPKQ6ASuorHtkP3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286347; c=relaxed/simple;
	bh=4wLmnSWxa1Je7a/khbfo4f66k7XVGP7PsLT9y1FAWgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0WoV85An/nT3vt1emD429tUqCKGKPlzNZwwIcN6jnubCre/mT6pYhjA8FxHEw5r67jcj4Zjf/rkuIvrzSJAFCEOWe0bIUNdsTxxsdyPkKW1dgaG0/2EXsI/S+wIKn5CWjLRaJl66fHSnlGOzREc9vV516tDvZYf1Ypm1wHwf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X2CfpcJl; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7fNc72111008;
	Wed, 20 May 2026 07:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	MeVEAD6qE7QFTfRahB6yVpLCe350LzXZzArrn5bVmA=; b=X2CfpcJlReCx7fmO2
	NMvRm5q+Pn4lSgWP8ZuJjg9CjK6vb+B8+6E/rOBOkiLzVXT2ZsOCJeEETjEkf4bW
	YID/hYXmOY3cXkto7sqCWofxQiMz3AgQ79j8byCPKAHcsI13A2B8Hrnpkd3qUhtK
	mh7eIIjUHNuqZnIPjiiqeGzGvvISAqbrcdFhVhX24gC9npkZTIRB/1doYlp5zaPx
	DiYIeox60bKGxrzFLTxPLsefG4suEMMJwhVT3xfRk1QOLEvPHCOArNUy1A3tUOP4
	rJlB5fifPCpX7WkImNebaznm0XZZQWRoedWBowaIpQNYrQBx2rANwfVuioCKbjTp
	SDvnQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8cfmdvfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:12:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:12:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:12:00 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id D9DC85B693E;
	Wed, 20 May 2026 07:11:54 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 6/12] net: atlantic: fix AQC113 HW init: ART sections, L2 filter slot, MAC address
Date: Wed, 20 May 2026 19:40:39 +0530
Message-ID: <20260520141046.2151-7-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=JYuMa0KV c=1 sm=1 tr=0 ts=6a0dc131 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ow_Oa9Ti8BdOYnj_f70A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: khN-TK53vBl0VqMYNJAmIyPIXb8sIewn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfXwxT0ywhYOhV1
 3i9xv8JV6CtzUEgK/6x62jNrp3y5txwfimxAEmcpOqT0ZJ644swojfUi5eAGRi+WpFPwt686Qf4
 QlErhB+PFszMzAlDUchvxLsnUH4CXYp7BKZxI36ZPvB++dt5HWZbGtXqLa9zmosVWeA6MSaynDm
 4duMUCjNl4vhcjROWD6ubI0k4DvZZOCEM/s9hP6y9ZlDy+9pzlQV7uba5xl9Q6+e+cDU/4gYv+M
 i+uxDLSC+qZ5heZ4OdO3DdXWYHJv/rHjkpBSmN9tGhCIy68xV68Osm4DOXQUJzpLYy85fcFEkCj
 7lvIFGvaxcJyvY8V09vTMxIMZJZ2sNA8BnnfXtdXmHkYAGgS8LwhJsydDyO7ew0IwSqpzvusvJA
 RPfSX2vf+sFe5v8+eY/svZZ8w1jsIIStMWQIK8CZUQ9d4TcXyQOvgjLG2pvPDLYw70o/zLGD7PG
 HY2vYBFe+lZONAgfmWg==
X-Proofpoint-GUID: khN-TK53vBl0VqMYNJAmIyPIXb8sIewn
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
	TAGGED_FROM(0.00)[bounces-289963-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 9AF7A58F8CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Fix initialization issues in hw_atl2 to correctly support AQC113:

- hw_atl2_hw_reset: replace unconditional priv memset with selective
  field clears to preserve firmware-reported layout (art_base_index,
  l2_filters_base_index, etc.) across resets; initialize l3l4_filters
  l3_index/l4_index to -1 to indicate 'not allocated'.

- hw_atl2_hw_init_new_rx_filters: use firmware-reported ART section
  base and count (clamped to 16) instead of hardcoded 0xFFFF mask;
  enable simultaneous IPv4/IPv6 L3 filter mode (rpf_l3_v6_v4_select);
  tag the UC MAC slot using firmware-supplied l2_filters_base_index
  instead of hardcoded HW_ATL2_MAC_UC.

- hw_atl2_hw_init_rx_path: enable only the firmware-assigned MAC slot
  (priv->l2_filters_base_index) instead of always slot 0.

- Add hw_atl2_hw_mac_addr_set() that programs the MAC address into
  the firmware-assigned L2 filter slot.  Wire into hw_atl2_ops
  replacing the A1 hw_atl_b0_hw_mac_addr_set; call it from hw_init.

- Wire .hw_get_regs into hw_atl2_ops.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 65 +++++++++++++++++--
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 0ce9caae8799..db0035fb04c7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -11,6 +11,7 @@
 #include "hw_atl/hw_atl_utils.h"
 #include "hw_atl/hw_atl_llh.h"
 #include "hw_atl/hw_atl_llh_internal.h"
+#include "hw_atl2.h"
 #include "hw_atl2_utils.h"
 #include "hw_atl2_llh.h"
 #include "hw_atl2_internal.h"
@@ -95,12 +96,21 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
 {
 	struct hw_atl2_priv *priv = self->priv;
 	int err;
+	int i;
 
 	err = hw_atl2_utils_soft_reset(self);
 	if (err)
 		return err;
 
-	memset(priv, 0, sizeof(*priv));
+	memset(&priv->last_stats, 0, sizeof(priv->last_stats));
+	memset(priv->l3_v4_filters, 0, sizeof(priv->l3_v4_filters));
+	memset(priv->l3_v6_filters, 0, sizeof(priv->l3_v6_filters));
+	memset(priv->l4_filters, 0, sizeof(priv->l4_filters));
+	memset(priv->etype_policy, 0, sizeof(priv->etype_policy));
+	for (i = 0; i < HW_ATL2_RPF_L3L4_FILTERS; i++) {
+		priv->l3l4_filters[i].l3_index = -1;
+		priv->l3l4_filters[i].l4_index = -1;
+	}
 
 	self->aq_fw_ops->set_state(self, MPI_RESET);
 
@@ -380,6 +390,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 {
 	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
 	struct hw_atl2_priv *priv = self->priv;
+	u32 art_first_sec, art_last_sec;
+	u32 art_sections;
+	u32 art_mask;
 	u16 action;
 	u8 index;
 	int i;
@@ -394,9 +407,16 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 	 * REC entry is used for further processing. If multiple entries match,
 	 * the lowest REC entry, Action field will be selected.
 	 */
-	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
+	art_last_sec = min_t(u32,
+			     priv->art_base_index / 8 + priv->art_count / 8,
+			     16U);
+	art_first_sec = min_t(u32, priv->art_base_index / 8, 16U);
+	art_mask = (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
+	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
+	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
+	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
 	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
-				     HW_ATL2_MAC_UC);
+				     priv->l2_filters_base_index);
 	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);
 
 	/* FW reserves the beginning of ART, thus all driver entries must
@@ -484,6 +504,7 @@ static int hw_atl2_act_rslvr_table_set(struct aq_hw_s *self, u8 location,
 static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
 {
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
+	struct hw_atl2_priv *priv = self->priv;
 	int i;
 
 	/* Rx TC/RSS number config */
@@ -499,7 +520,9 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
 
 	/* Multicast filters */
 	for (i = HW_ATL2_MAC_MAX; i--;) {
-		hw_atl_rpfl2_uc_flr_en_set(self, (i == 0U) ? 1U : 0U, i);
+		hw_atl_rpfl2_uc_flr_en_set(self,
+					   (i == priv->l2_filters_base_index) ?
+					   1U : 0U, i);
 		hw_atl_rpfl2unicast_flr_act_set(self, 1U, i);
 	}
 
@@ -530,6 +553,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
 	return aq_hw_err_from_flags(self);
 }
 
+static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	u32 location = priv->l2_filters_base_index;
+	unsigned int h;
+	unsigned int l;
+	int err;
+
+	if (!mac_addr) {
+		err = -EINVAL;
+		goto err_exit;
+	}
+	h = (mac_addr[0] << 8) | (mac_addr[1]);
+	l = (mac_addr[2] << 24) | (mac_addr[3] << 16) |
+		(mac_addr[4] << 8) | mac_addr[5];
+
+	hw_atl_rpfl2_uc_flr_en_set(self, 0U, location);
+	hw_atl_rpfl2unicast_dest_addresslsw_set(self, l, location);
+	hw_atl_rpfl2unicast_dest_addressmsw_set(self, h, location);
+	hw_atl_rpfl2unicast_flr_act_set(self, 1U, location);
+	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC, location);
+	hw_atl_rpfl2_uc_flr_en_set(self, 1U, location);
+
+	err = aq_hw_err_from_flags(self);
+
+err_exit:
+	return err;
+}
+
 static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl2_igcr_table_[4][2] = {
@@ -556,7 +608,7 @@ static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 	hw_atl2_hw_init_tx_path(self);
 	hw_atl2_hw_init_rx_path(self);
 
-	hw_atl_b0_hw_mac_addr_set(self, mac_addr);
+	hw_atl2_hw_mac_addr_set(self, mac_addr);
 
 	self->aq_fw_ops->set_link_speed(self, aq_nic_cfg->link_speed_msk);
 	self->aq_fw_ops->set_state(self, MPI_INIT);
@@ -825,7 +877,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
 const struct aq_hw_ops hw_atl2_ops = {
 	.hw_soft_reset        = hw_atl2_utils_soft_reset,
 	.hw_prepare           = hw_atl2_utils_initfw,
-	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
+	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,
 	.hw_init              = hw_atl2_hw_init,
 	.hw_reset             = hw_atl2_hw_reset,
 	.hw_start             = hw_atl_b0_hw_start,
@@ -855,6 +907,7 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_rss_set                  = hw_atl2_hw_rss_set,
 	.hw_rss_hash_set             = hw_atl_b0_hw_rss_hash_set,
 	.hw_tc_rate_limit_set        = hw_atl2_hw_init_tx_tc_rate_limit,
+	.hw_get_regs                 = hw_atl2_utils_hw_get_regs,
 	.hw_get_hw_stats             = hw_atl2_utils_get_hw_stats,
 	.hw_get_fw_version           = hw_atl2_utils_get_fw_version,
 	.hw_set_offload              = hw_atl_b0_hw_offload_set,
-- 
2.43.0


