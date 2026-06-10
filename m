Return-Path: <netdev+bounces-297647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /BJsH/RQKWotUwMAu9opvQ
	(envelope-from <netdev+bounces-297647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:56:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7B66900F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:56:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=d4BfHJo+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297647-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297647-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97560307A0C9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91292406271;
	Wed, 10 Jun 2026 11:55:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC054404BF3;
	Wed, 10 Jun 2026 11:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092544; cv=none; b=c8PgCM41CK+wu9s2R0rDHEQZjRmVh102J7JCR+B/Q+9WIVQvBI67HngXzIKg7ypNOorcDBHcqhkUK5n/aGnPnMY77uXkLmLZZz8FA7DYsMPRpfzuuqbhN2nOiKkgSITHTFk4nKUUMlikUb2l0TElIEUzxOoMx4TYjANBK7jVe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092544; c=relaxed/simple;
	bh=hDd1jvWQjZLpE8A8OXo7/syLhfMEi3UTeQA1srV/FpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuQywU0NJkOHONQSCV9DfFoGmR8RHJYPpeILbqZ1/zralRayDocRoon3YhGATU7cb0ExtBDDnytNUKQW7HryxBa9mS2t1B54tEQ9Uh+9B5xAgobtwKALP/SsyXlu/DbtSdFQe19ADnk5JQcY/Fk871vU/VJF0O3O13eoaWmLo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d4BfHJo+; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kZJP2877604;
	Wed, 10 Jun 2026 04:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	NbiyrH+jhFwP+haYteAmwT+eIbP8+bycsJ65wNFOME=; b=d4BfHJo+39VibUEjF
	cIdbA9hzMJCECievxDwKb0mdkIEjvbOunw86Xj6FU7xaSzNjBk8hAmd6xJjJiv3o
	gROAQSWkdHYVrwoWsATmmJwFQRc3NVel94Kvia/5POWZNPi2+lI6n5YOWd9Mfkmu
	OUxc38v8XZJyEkZD/iSMorv7NH0TMd/3XNQvZ6tleoOoBzNMaDpDZ98Qlg3SOAQY
	7iwAGBVQ622aICjwJJe1Jry3MzhJL/OnTFlCj9u9ydehVAp4AzJ8hkBLlayT6rq+
	OBGMp37hZE+KIkGXFRq/MjEqKaF95YIJWQMgrp0oqMgwS2vaB1A/uT5YbnayykQ9
	5K20A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps392u53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:27 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 359AE3F708D;
	Wed, 10 Jun 2026 04:55:22 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 6/12] net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address
Date: Wed, 10 Jun 2026 17:24:42 +0530
Message-ID: <20260610115448.272-7-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a2950b0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=qZ44PZnu26tmsjHz8DIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: x3JXaSEIxwH6o6BVTRfZJa9oYzcUVLKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfXzZm4+SlQkl2L
 sWRAG6qTTE+X7rVOEx4CpYQPsV3yqBUl812Z1XM8h1UaHXh/Lb2U2RZskhIw1cT5Pzmv/i0tPO1
 VnmFOXSTXKzS0J4m4n2QUK6KAFKJJNw1zsQc4vYh5Hj0oKJ3WoCCZSOuU+I9n2pR+spZqBklHRk
 p6zn/5e/gM9L0NPjuGVxAJjhelTTpSL0POvm+sz4LzoFM12qf8h0/kIgV4mdG99BeEFnDgf4Q5b
 yisFVeP2TRz60YGYysA6MxYQsPGib395YWgOH0rj+uzahAwiJSEpM75mOMaVUsVhBFiGTA2OxEE
 ffPcHPnmsmmfGpz3BxgUuvWCcVn40K9d92nYWsuvmWmv6Nh0bRKHvbYJpsC7R4IlSy1+dYLdeti
 MoIB/hsMUTEV26fp8vRqGvVPL+3zcJYBC/XCWSXyjfX8DFjv9qxAP5V7VlziyBh1F8PySoEBKEj
 mbgKLxCNKtthfIv7gOA==
X-Proofpoint-GUID: x3JXaSEIxwH6o6BVTRfZJa9oYzcUVLKg
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297647-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29F7B66900F

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Fix initialization issues in hw_atl2 to correctly support AQC113:

- hw_atl2_hw_reset: replace unconditional priv memset with selective
  field clears so that l3l4_filters[].l3_index and l4_index can be
  initialized to -1 (not allocated) rather than 0; 0 is a valid filter
  index and would incorrectly appear as an occupied slot after a reset.

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
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 81 ++++++++++++++++---
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       |  2 +
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index ba9555fb8f11..ec5b2a03fd6f 100644
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
@@ -394,9 +407,20 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 	 * REC entry is used for further processing. If multiple entries match,
 	 * the lowest REC entry, Action field will be selected.
 	 */
-	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
+	art_last_sec = min_t(u32,
+			     priv->art_base_index / 8 + priv->art_count / 8,
+			     16U);
+	art_first_sec = min_t(u32, priv->art_base_index / 8, 16U);
+	art_mask = (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
+	if (!art_mask) {
+		/* ART base index is out of range, enabling all sections */
+		art_mask = 0xFFFF;
+	}
+	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
+	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
+	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
 	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
-				     HW_ATL2_MAC_UC);
+				     priv->l2_filters_base_index);
 	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);
 
 	/* FW reserves the beginning of ART, thus all driver entries must
@@ -484,6 +508,7 @@ static int hw_atl2_act_rslvr_table_set(struct aq_hw_s *self, u8 location,
 static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
 {
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
+	struct hw_atl2_priv *priv = self->priv;
 	int i;
 
 	/* Rx TC/RSS number config */
@@ -499,7 +524,9 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
 
 	/* Multicast filters */
 	for (i = HW_ATL2_MAC_MAX; i--;) {
-		hw_atl_rpfl2_uc_flr_en_set(self, (i == 0U) ? 1U : 0U, i);
+		hw_atl_rpfl2_uc_flr_en_set(self,
+					   (i == priv->l2_filters_base_index) ?
+					   1U : 0U, i);
 		hw_atl_rpfl2unicast_flr_act_set(self, 1U, i);
 	}
 
@@ -530,6 +557,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
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
@@ -547,7 +603,7 @@ static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 	hw_atl2_hw_init_tx_path(self);
 	hw_atl2_hw_init_rx_path(self);
 
-	hw_atl_b0_hw_mac_addr_set(self, mac_addr);
+	hw_atl2_hw_mac_addr_set(self, mac_addr);
 
 	self->aq_fw_ops->set_link_speed(self, aq_nic_cfg->link_speed_msk);
 	self->aq_fw_ops->set_state(self, MPI_INIT);
@@ -619,6 +675,8 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
 					 [ETH_ALEN],
 					 u32 count)
 {
+	struct hw_atl2_priv *priv = self->priv;
+	u32 base_location = priv->l2_filters_base_index + 1;
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	int err = 0;
 
@@ -634,18 +692,18 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
 		u32 l = (ar_mac[i][2] << 24) | (ar_mac[i][3] << 16) |
 					(ar_mac[i][4] << 8) | ar_mac[i][5];
 
-		hw_atl_rpfl2_uc_flr_en_set(self, 0U, HW_ATL2_MAC_MIN + i);
+		hw_atl_rpfl2_uc_flr_en_set(self, 0U, base_location + i);
 
 		hw_atl_rpfl2unicast_dest_addresslsw_set(self, l,
-							HW_ATL2_MAC_MIN + i);
+							base_location + i);
 
 		hw_atl_rpfl2unicast_dest_addressmsw_set(self, h,
-							HW_ATL2_MAC_MIN + i);
+							base_location + i);
 
-		hw_atl2_rpfl2_uc_flr_tag_set(self, 1, HW_ATL2_MAC_MIN + i);
+		hw_atl2_rpfl2_uc_flr_tag_set(self, 1, base_location + i);
 
 		hw_atl_rpfl2_uc_flr_en_set(self, (cfg->is_mc_list_enabled),
-					   HW_ATL2_MAC_MIN + i);
+					   base_location + i);
 	}
 
 	err = aq_hw_err_from_flags(self);
@@ -816,7 +874,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
 const struct aq_hw_ops hw_atl2_ops = {
 	.hw_soft_reset        = hw_atl2_utils_soft_reset,
 	.hw_prepare           = hw_atl2_utils_initfw,
-	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
+	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,
 	.hw_init              = hw_atl2_hw_init,
 	.hw_reset             = hw_atl2_hw_reset,
 	.hw_start             = hw_atl_b0_hw_start,
@@ -846,6 +904,7 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_rss_set                  = hw_atl2_hw_rss_set,
 	.hw_rss_hash_set             = hw_atl_b0_hw_rss_hash_set,
 	.hw_tc_rate_limit_set        = hw_atl2_hw_init_tx_tc_rate_limit,
+	.hw_get_regs                 = hw_atl2_utils_hw_get_regs,
 	.hw_get_hw_stats             = hw_atl2_utils_get_hw_stats,
 	.hw_get_fw_version           = hw_atl2_utils_get_fw_version,
 	.hw_set_offload              = hw_atl_b0_hw_offload_set,
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 12c3f42ab611..dc9b2ef4640b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -626,6 +626,8 @@ int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
 	if (priv->art_count == 0)
 		priv->art_count = HW_ATL2_ART_TOTAL_ENTRIES;
 	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
+	if (priv->l2_filters_base_index >= HW_ATL2_MAC_MAX)
+		priv->l2_filters_base_index = HW_ATL2_MAC_UC;
 	priv->l2_filter_count = filter_caps.l2_filter_count;
 	priv->etype_filter_base_index = filter_caps.ethertype_filter_base_index;
 	priv->etype_filter_count = filter_caps.ethertype_filter_count;
-- 
2.43.0


