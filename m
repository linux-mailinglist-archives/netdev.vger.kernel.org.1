Return-Path: <netdev+bounces-297644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2leuOg5SKWqAUwMAu9opvQ
	(envelope-from <netdev+bounces-297644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:01:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28166907E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=kpnwfitE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297644-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297644-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A6313028C43
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CDF403B0F;
	Wed, 10 Jun 2026 11:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EE3E008A;
	Wed, 10 Jun 2026 11:55:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092534; cv=none; b=iJ3+tC62Y0hq6xMDQvn0ywkVuwVafxSoYI3xYAgIyTI2CazrpnpmwqO7r22uZq+5Wj0IoA0S/pb7siZJ6xhNMFsjlvhVpv6ISCM3taR5HZolM9vYNigCCoRg6rIUetB0b6RsNy2cmPmh4nS1Ta+plbShSVv4PjhEBP0WmEbblGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092534; c=relaxed/simple;
	bh=v925w/XsObFXjPESfQL4VWVL5hRweyEqdK7ESzLYcec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaRr3bk2tLllwGjCoJdwh6RvsV4qjXtRwD/5GyGmDlfEwH53CSIokEAo2ikFr29rkyyIRhHfgcucfU1G7ejuc+lml9LuJpe9CVvOi3rfzmdmyB/sMZeFnkaWat+ncpuX/JENUKjUnD8/J0gSlk+ByQ0myEuxI3srwV3XI1iOmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kpnwfitE; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kQOe2876384;
	Wed, 10 Jun 2026 04:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	MV+VfWzoan3X72PrQxH1Fk6Rz7ZOw1XJIZHuvi/TQw=; b=kpnwfitEn77e/94yj
	ettxODENQWO20aH+EngHBb3emH6PLe91mZrR3MAmcHKB2Pge/+dIjc9CrGXtDhS3
	hxxD3m4a1PTxsBuZz9ttj0Qr2jDMCvXmygx0uXwM+0CXE3OtPznHIDwy979XRfhg
	S7f1oZzWMFqsRR4ot/d5BwD4ckAu8GTqA9ENyw3g8q+r0U897Zw+b9mana4cqDBh
	jEpkLbl6BYqTJe7nKuVR0PYYactEYqzy7a7HVH53tOYDORK/dlHHBYLwvcZQksdI
	U0XU2rdedxbSUxS7gM8cL3ioUE/YrzdaJyR7O1oVKApmn7N0348cPEkoF9qeitbw
	l5bxg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eps392u4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 04:55:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 04:55:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 04:55:22 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.66.228])
	by maili.marvell.com (Postfix) with ESMTP id 5612F3F708D;
	Wed, 10 Jun 2026 04:55:18 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v5 5/12] net: atlantic: add AQC113 filter data structures, firmware query and register dump
Date: Wed, 10 Jun 2026 17:24:41 +0530
Message-ID: <20260610115448.272-6-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=KKlqylFo c=1 sm=1 tr=0 ts=6a2950ab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=7fZV__5iCZDCNs-PDKAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: FBN5ISAiQ1oYZhO192e0DYDrEoeVYXnV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX9hcjm9qeR86G
 Tz+Lv5DCcGI+mgbwIeO2k0wp+dc4fVE7aWoNMJV/bNKvDu1eZyrGhpdXxmkoyD46oKGY/SuBTww
 bokSuliUKHwy8/u6C8iF1TgCv5nUQF89HlmBbYld7pvIFrmomNpkxPtQ48vUJjge/ohRNsN+FiK
 EcUkj60b7RPwdrtwmDScml6ZZrv1+j7Zg3UG/Oi6yEeWi/OTsc/6ATn0H+hat5m2hZwN9oCWz4O
 FBBey3o/srcu9tWKu0AzKUUdsaDqZRLmiB3pSGThPKou3CYSHJmriL8iiCd9BL7zBdfz8iCRs+P
 pJWQJYk1Zm5LlZFLIy9sKxIF496NeMYudwyZu+Ygisjq4x2zV+S4SW96xKYr6Ha+Ozum+qDRMrX
 +LQqpMPSn7YUTb9irfjiB000RM0F4D45w6Bd+fdM45n7HfEckogwf6oFUJ6mHTclRm9/Wkd6XBB
 9+0JT4HixJXfuxYT9hQ==
X-Proofpoint-GUID: FBN5ISAiQ1oYZhO192e0DYDrEoeVYXnV
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297644-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C28166907E

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add filter infrastructure for AQC113 hardware:

- Define L3 (IPv4/IPv6), L4 (TCP/UDP/SCTP), and combined L3L4 filter
  structures with serialized usage counter for filter sharing.
- Define tag policy structure for ethertype filter management.
- Add RPF L3/L4 command bit definitions for filter programming.
- Add filter count constants for L3L4, L3V4, L4, VLAN, and ethertype.
- Extend hw_atl2_priv with filter arrays, base indices, and counts
  discovered from firmware.

Query filter capabilities from firmware shared memory at init time
to discover available L2/L3/L4/VLAN/ethertype filter resources and
ART (Action Resolver Table) configuration.

Add hardware register dump utility for AQC113 debug support.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       |  9 ---
 .../atlantic/hw_atl2/hw_atl2_internal.h       | 65 +++++++++++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.c | 34 +++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  7 +-
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       | 69 +++++++++++++++++--
 5 files changed, 169 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 0ce9caae8799..ba9555fb8f11 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -540,17 +540,8 @@ static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 	};
 
 	struct aq_nic_cfg_s *aq_nic_cfg = self->aq_nic_cfg;
-	struct hw_atl2_priv *priv = self->priv;
-	u8 base_index, count;
 	int err;
 
-	err = hw_atl2_utils_get_action_resolve_table_caps(self, &base_index,
-							  &count);
-	if (err)
-		return err;
-
-	priv->art_base_index = 8 * base_index;
-
 	hw_atl2_init_launchtime(self);
 
 	hw_atl2_hw_init_tx_path(self);
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
index 5a89bb8722f9..6b608918ec33 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
@@ -84,6 +84,19 @@ enum HW_ATL2_RPF_ART_INDEX {
 					  HW_ATL_VLAN_MAX_FILTERS,
 };
 
+#define HW_ATL2_RPF_L3_CMD_EN       BIT(0)
+#define HW_ATL2_RPF_L3_CMD_SA_EN    BIT(1)
+#define HW_ATL2_RPF_L3_CMD_DA_EN    BIT(2)
+#define HW_ATL2_RPF_L3_CMD_PROTO_EN BIT(3)
+#define HW_ATL2_RPF_L3_V6_CMD_EN       BIT(0x10)
+#define HW_ATL2_RPF_L3_V6_CMD_SA_EN    BIT(0x11)
+#define HW_ATL2_RPF_L3_V6_CMD_DA_EN    BIT(0x12)
+#define HW_ATL2_RPF_L3_V6_CMD_PROTO_EN BIT(0x13)
+#define HW_ATL2_RPF_L4_CMD_EN       BIT(0)
+#define HW_ATL2_RPF_L4_CMD_DP_EN    BIT(1)
+#define HW_ATL2_RPF_L4_CMD_SP_EN    BIT(2)
+#define HW_ATL2_ART_TOTAL_ENTRIES   128
+
 #define HW_ATL2_ACTION(ACTION, RSS, INDEX, VALID) \
 	((((ACTION) & 0x3U) << 8) | \
 	(((RSS) & 0x1U) << 7) | \
@@ -94,6 +107,13 @@ enum HW_ATL2_RPF_ART_INDEX {
 #define HW_ATL2_ACTION_DISABLE HW_ATL2_ACTION(0, 0, 0, 0)
 #define HW_ATL2_ACTION_ASSIGN_QUEUE(QUEUE) HW_ATL2_ACTION(1, 0, (QUEUE), 1)
 #define HW_ATL2_ACTION_ASSIGN_TC(TC) HW_ATL2_ACTION(1, 1, (TC), 1)
+#define HW_ATL2_RPF_L3L4_FILTERS 8
+#define HW_ATL2_RPF_L3V4_FILTERS 8
+#define HW_ATL2_RPF_L3V6_FILTERS 6
+#define HW_ATL2_RPF_L4_FILTERS 8
+#define HW_ATL2_RPF_VLAN_FILTERS 16
+#define HW_ATL2_RPF_ETYPE_FILTERS 16
+#define HW_ATL2_RPF_ETYPE_TAGS 7
 
 enum HW_ATL2_RPF_RSS_HASH_TYPE {
 	HW_ATL2_RPF_RSS_HASH_TYPE_NONE = 0,
@@ -119,9 +139,54 @@ enum HW_ATL2_RPF_RSS_HASH_TYPE {
 
 #define HW_ATL_MCAST_FLT_ANY_TO_HOST 0x00010FFFU
 
+struct hw_atl2_l3_filter {
+	u8 proto;
+	u8 usage;
+	u32 cmd;
+	u32 srcip[4];
+	u32 dstip[4];
+};
+
+struct hw_atl2_l4_filter {
+	u8 usage;
+	u32 cmd;
+	u16 sport;
+	u16 dport;
+};
+
+struct hw_atl2_l3l4_filter {
+	s8 l3_index;
+	s8 l4_index;
+	u8 ipv6;
+};
+
+struct hw_atl2_tag_policy {
+	u16 action;
+	u16 usage;
+};
+
 struct hw_atl2_priv {
+	struct hw_atl2_l3_filter l3_v4_filters[HW_ATL2_RPF_L3L4_FILTERS];
+	struct hw_atl2_l3_filter l3_v6_filters[HW_ATL2_RPF_L3L4_FILTERS];
+	struct hw_atl2_l4_filter l4_filters[HW_ATL2_RPF_L3L4_FILTERS];
+	struct hw_atl2_l3l4_filter l3l4_filters[HW_ATL2_RPF_L3L4_FILTERS];
+	struct hw_atl2_tag_policy etype_policy[HW_ATL2_RPF_ETYPE_FILTERS];
 	struct statistics_s last_stats;
 	unsigned int art_base_index;
+	unsigned int art_count;
+	unsigned int l2_filters_base_index;
+	unsigned int l2_filter_count;
+	unsigned int etype_filter_base_index;
+	unsigned int etype_filter_count;
+	unsigned int etype_filter_tag_top;
+	unsigned int vlan_filter_base_index;
+	unsigned int vlan_filter_count;
+	unsigned int l3_v4_filter_base_index;
+	unsigned int l3_v4_filter_count;
+	unsigned int l3_v6_filter_base_index;
+	unsigned int l3_v6_filter_count;
+	unsigned int l4_filter_base_index;
+	unsigned int l4_filter_count;
 };
 
 #endif /* HW_ATL2_INTERNAL_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
index 0fe6257d9c08..ef549e172dd9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
@@ -128,3 +128,37 @@ int hw_atl2_utils_soft_reset(struct aq_hw_s *self)
 err_exit:
 	return err;
 }
+
+static const u32 hw_atl2_utils_hw_mac_regs[] = {
+	0x00005580U, 0x00005590U, 0x000055B0U, 0x000055B4U,
+	0x000055C0U, 0x00005B00U, 0x00005B04U, 0x00005B08U,
+	0x00005B0CU, 0x00005B10U, 0x00005B14U, 0x00005B18U,
+	0x00005B1CU, 0x00005B20U, 0x00005B24U, 0x00005B28U,
+	0x00005B2CU, 0x00005B30U, 0x00005B34U, 0x00005B38U,
+	0x00005B3CU, 0x00005B40U, 0x00005B44U, 0x00005B48U,
+	0x00005B4CU, 0x00005B50U, 0x00005B54U, 0x00005B58U,
+	0x00005B5CU, 0x00005B60U, 0x00005B64U, 0x00005B68U,
+	0x00005B6CU, 0x00005B70U, 0x00005B74U, 0x00005B78U,
+	0x00005B7CU, 0x00007C00U, 0x00007C04U, 0x00007C08U,
+	0x00007C0CU, 0x00007C10U, 0x00007C14U, 0x00007C18U,
+	0x00007C1CU, 0x00007C20U, 0x00007C40U, 0x00007C44U,
+	0x00007C48U, 0x00007C4CU, 0x00007C50U, 0x00007C54U,
+	0x00007C58U, 0x00007C5CU, 0x00007C60U, 0x00007C80U,
+	0x00007C84U, 0x00007C88U, 0x00007C8CU, 0x00007C90U,
+	0x00007C94U, 0x00007C98U, 0x00007C9CU, 0x00007CA0U,
+	0x00007CC0U, 0x00007CC4U, 0x00007CC8U, 0x00007CCCU,
+	0x00007CD0U, 0x00007CD4U, 0x00007CD8U, 0x00007CDCU,
+};
+
+int hw_atl2_utils_hw_get_regs(struct aq_hw_s *self,
+			      const struct aq_hw_caps_s *aq_hw_caps,
+			      u32 *regs_buff)
+{
+	unsigned int i;
+
+	for (i = 0; i < min_t(u32, aq_hw_caps->mac_regs_count,
+			      ARRAY_SIZE(hw_atl2_utils_hw_mac_regs)); i++)
+		regs_buff[i] = aq_hw_read_reg(self,
+					      hw_atl2_utils_hw_mac_regs[i]);
+	return 0;
+}
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
index 6bad64c77b87..bae18c32365b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
@@ -626,10 +626,13 @@ int hw_atl2_utils_initfw(struct aq_hw_s *self, const struct aq_fw_ops **fw_ops);
 
 int hw_atl2_utils_soft_reset(struct aq_hw_s *self);
 
+int hw_atl2_utils_hw_get_regs(struct aq_hw_s *self,
+			      const struct aq_hw_caps_s *aq_hw_caps,
+			      u32 *regs_buff);
+
 u32 hw_atl2_utils_get_fw_version(struct aq_hw_s *self);
 
-int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
-						u8 *base_index, u8 *count);
+int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self);
 
 extern const struct aq_fw_ops aq_a2_fw_ops;
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 7370e3f76b62..12c3f42ab611 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -121,6 +121,10 @@ static int aq_a2_fw_init(struct aq_hw_s *self)
 	u32 val;
 	int err;
 
+	err = hw_atl2_utils_get_filter_caps(self);
+	if (err)
+		return err;
+
 	hw_atl2_shared_buffer_get(self, link_control, link_control);
 	link_control.mode = AQ_HOST_MODE_ACTIVE;
 	hw_atl2_shared_buffer_write(self, link_control, link_control);
@@ -606,18 +610,75 @@ u32 hw_atl2_utils_get_fw_version(struct aq_hw_s *self)
 	       version.bundle.build;
 }
 
-int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
-						u8 *base_index, u8 *count)
+int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
 {
+	struct hw_atl2_priv *priv = self->priv;
 	struct filter_caps_s filter_caps;
+	u32 tag_top;
 	int err;
 
 	err = hw_atl2_shared_buffer_read_safe(self, filter_caps, &filter_caps);
 	if (err)
 		return err;
 
-	*base_index = filter_caps.rslv_tbl_base_index;
-	*count = filter_caps.rslv_tbl_count;
+	priv->art_base_index = filter_caps.rslv_tbl_base_index * 8;
+	priv->art_count = filter_caps.rslv_tbl_count * 8;
+	if (priv->art_count == 0)
+		priv->art_count = HW_ATL2_ART_TOTAL_ENTRIES;
+	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
+	priv->l2_filter_count = filter_caps.l2_filter_count;
+	priv->etype_filter_base_index = filter_caps.ethertype_filter_base_index;
+	priv->etype_filter_count = filter_caps.ethertype_filter_count;
+	priv->etype_filter_tag_top =
+		(priv->etype_filter_count >= HW_ATL2_RPF_ETYPE_TAGS) ?
+		 (HW_ATL2_RPF_ETYPE_TAGS) : (HW_ATL2_RPF_ETYPE_TAGS >> 1);
+	priv->vlan_filter_base_index = filter_caps.vlan_filter_base_index;
+	/* 0 - no tag, 1 - reserved for vlan-filter-offload filters */
+	tag_top =
+		  (filter_caps.vlan_filter_count == HW_ATL2_RPF_VLAN_FILTERS) ?
+		  (HW_ATL2_RPF_VLAN_FILTERS - 2) :
+		  (HW_ATL2_RPF_VLAN_FILTERS / 2 - 2);
+
+	if (filter_caps.vlan_filter_count > 2) {
+		priv->vlan_filter_count = min_t(u32,
+						filter_caps.vlan_filter_count - 2,
+						tag_top);
+	} else {
+		pr_debug("atlantic: FW vlan_filter_count=%u <= 2, no usable VLAN filters\n",
+			 filter_caps.vlan_filter_count);
+		priv->vlan_filter_count = 0;
+	}
+
+	priv->l3_v4_filter_base_index = filter_caps.l3_ip4_filter_base_index;
+	if (priv->l3_v4_filter_base_index >= HW_ATL2_RPF_L3V4_FILTERS) {
+		priv->l3_v4_filter_base_index = 0;
+		priv->l3_v4_filter_count = 0;
+	} else {
+		priv->l3_v4_filter_count = min_t(u32,
+						 filter_caps.l3_ip4_filter_count,
+						 HW_ATL2_RPF_L3V4_FILTERS - 1);
+	}
+
+	priv->l3_v6_filter_base_index = filter_caps.l3_ip6_filter_base_index;
+	if (priv->l3_v6_filter_base_index >= HW_ATL2_RPF_L3V6_FILTERS) {
+		priv->l3_v6_filter_base_index = 0;
+		priv->l3_v6_filter_count = 0;
+	} else {
+		priv->l3_v6_filter_count = min_t(u32,
+						 filter_caps.l3_ip6_filter_count,
+						 HW_ATL2_RPF_L3V6_FILTERS - 1);
+	}
+
+	priv->l4_filter_base_index = filter_caps.l4_filter_base_index;
+	if (priv->l4_filter_base_index >= HW_ATL2_RPF_L4_FILTERS) {
+		priv->l4_filter_base_index = 0;
+		priv->l4_filter_count = 0;
+	} else {
+		priv->l4_filter_count = min_t(u32,
+					      filter_caps.l4_filter_count,
+					      HW_ATL2_RPF_L4_FILTERS - 1);
+	}
+
 	return 0;
 }
 
-- 
2.43.0


