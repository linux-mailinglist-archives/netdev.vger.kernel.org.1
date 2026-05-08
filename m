Return-Path: <netdev+bounces-285779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrLLjjR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3334F60E6
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17F75300E02B
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027EC3890F9;
	Fri,  8 May 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hhqeFOUT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C2395254;
	Fri,  8 May 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241845; cv=none; b=R4asQ1if339wnEZAx3fa6CeBVsnwrcJKisrelkqm4xtwLduQIjnrdXydSIMroIT0mQa4144UagqSrMbaAPwR/SStGqjzWX1nDecL1wn4N3oYpQ/WqS7jKd3OZVoPsurv2kiO4JL6qzm5DYLDOR74RwAJy48JoDSh4NeXq/1F0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241845; c=relaxed/simple;
	bh=pS/NHo26KR2yadceDNjzTfzVGimQ19p7OFFeFhgzV3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spcB231rBsDx8zPz2RlrbiZtVAARoRs0iDYGZ4DYB2+XHoKpjsLFnraOD1fY/e4VlkoeHCbi0Lcg6hxYEgeu2/JNHOOp1UD2CuSMjc/hmjCw2BagKvDMRGTpsCwTfdwjYCswwm8pomQGG8pYq6r3EhZG7KdEBHO32U63DoSbFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hhqeFOUT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6481co7o1753610;
	Fri, 8 May 2026 05:03:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	3Jd3g4sORASzHea+bl+InX+uYPD+wDaCnDHFG6mwDI=; b=hhqeFOUTG6W0F0bpQ
	+ctbozYTL4v+zIMJjZ9e0cDDC4iOD6aIjGgHpI0Y5QfonX/TT5UQOJSzZGGrATHA
	WH0qdYiSJ6CDRT0YoH9FqD+3h5sonn1JyGezwIDTmHqidE+SLXN2FEFKGrqPRPTk
	82FeIK7mKf/1rf2ydWw3Xs7W6sg2IbK5v7zU/0cWTa9HvYbI2cw6ScJORs245E4J
	kJKnbEB6RG5rC6OKYVMqp1Avgkmm5631TegMweauvK6C5XnGqdVxoCedAEyZpage
	cDl0pG1jYCec0N1UXpq935pCmScPS0fsGcMVVeL9Oe0IiXcbdDmMqZ2bcFtv8BD0
	s5tow==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e0uytkcrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:03:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:03:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:03:40 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 2C4783F708C;
	Fri,  8 May 2026 05:03:35 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 5/9] net: atlantic: add AQC113 filter data structures and firmware query and firmware query firmware query
Date: Fri, 8 May 2026 17:31:52 +0530
Message-ID: <20260508120156.3060-6-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=I6RVgtgg c=1 sm=1 tr=0 ts=69fdd11e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=3QfP4igTxnc4TM591i8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfXwkOoEAtj69X+
 XHb1G3O7GYXxd6NxdaDkC0+MmMbNoIoJnyRFzlPdJJ1v+QPfQX0oXyxHyqQ8c2xs6P7Khny299V
 THYwe/cVYnoLTpLnz4QR8N1cOzSz455crAFRweAS7ACpFEM3SUUTH+YDpzwz6OU2p2IgTg+pXpc
 wlnYqFNqbTWdMj1yQCzI8uTjJLaiDgNTu98RFE5ckC2mi3AGq1k8pPJn0IrIMibWP4eI8IKJ+0s
 QgA+pvyZIxDtXwrUzEh0EOx+JIRi0t21lYl1D4okg3BT5zcn4+1jdefY2U3eu5LkGiJNhyxwA8S
 V2Lr3U+heF/f1t9wqjDTd9LbxKl02umjF6CfTz5pGNPKYt4QBD5CHPx+UZ8wU3D3EM0/o/yAzsU
 UPWEEfZovV5vRzxo6PyUz04JmaZQBjKzZiJIAmIyRYyg8LOOS8K0fQcZ/sopneXCaYBKNVAZArP
 YGDeyHdYiSZQUFDzioQ==
X-Proofpoint-GUID: AHj3wMgKXYrG5tVjGrrBd5GS_9F7tGxj
X-Proofpoint-ORIG-GUID: AHj3wMgKXYrG5tVjGrrBd5GS_9F7tGxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 5A3334F60E6
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
	TAGGED_FROM(0.00)[bounces-285779-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Add filter infrastructure for AQC113 hardware:

- Define L3 (IPv4/IPv6), L4 (TCP/UDP/SCTP), and combined L3L4 filter
  structures with reference-counted sharing support.
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
 .../atlantic/hw_atl2/hw_atl2_internal.h       | 63 +++++++++++++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.c | 33 ++++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  5 ++
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       | 52 +++++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
index 5a89bb8722f9..fc086d84fb91 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
@@ -84,6 +84,18 @@ enum HW_ATL2_RPF_ART_INDEX {
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
+
 #define HW_ATL2_ACTION(ACTION, RSS, INDEX, VALID) \
 	((((ACTION) & 0x3U) << 8) | \
 	(((RSS) & 0x1U) << 7) | \
@@ -94,6 +106,12 @@ enum HW_ATL2_RPF_ART_INDEX {
 #define HW_ATL2_ACTION_DISABLE HW_ATL2_ACTION(0, 0, 0, 0)
 #define HW_ATL2_ACTION_ASSIGN_QUEUE(QUEUE) HW_ATL2_ACTION(1, 0, (QUEUE), 1)
 #define HW_ATL2_ACTION_ASSIGN_TC(TC) HW_ATL2_ACTION(1, 1, (TC), 1)
+#define HW_ATL2_RPF_L3L4_FILTERS 8
+#define HW_ATL2_RPF_L3V4_FILTERS 8
+#define HW_ATL2_RPF_L4_FILTERS 8
+#define HW_ATL2_RPF_VLAN_FILTERS 16
+#define HW_ATL2_RPF_ETYPE_FILTERS 16
+#define HW_ATL2_RPF_ETYPE_TAGS 7
 
 enum HW_ATL2_RPF_RSS_HASH_TYPE {
 	HW_ATL2_RPF_RSS_HASH_TYPE_NONE = 0,
@@ -119,9 +137,54 @@ enum HW_ATL2_RPF_RSS_HASH_TYPE {
 
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
index 0fe6257d9c08..ffd723dcfb63 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c
@@ -128,3 +128,36 @@ int hw_atl2_utils_soft_reset(struct aq_hw_s *self)
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
+	for (i = 0; i < aq_hw_caps->mac_regs_count; i++)
+		regs_buff[i] = aq_hw_read_reg(self,
+					      hw_atl2_utils_hw_mac_regs[i]);
+	return 0;
+}
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
index 6bad64c77b87..c84955bc14ae 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h
@@ -626,10 +626,15 @@ int hw_atl2_utils_initfw(struct aq_hw_s *self, const struct aq_fw_ops **fw_ops);
 
 int hw_atl2_utils_soft_reset(struct aq_hw_s *self);
 
+int hw_atl2_utils_hw_get_regs(struct aq_hw_s *self,
+			      const struct aq_hw_caps_s *aq_hw_caps,
+			      u32 *regs_buff);
+
 u32 hw_atl2_utils_get_fw_version(struct aq_hw_s *self);
 
 int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
 						u8 *base_index, u8 *count);
+int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self);
 
 extern const struct aq_fw_ops aq_a2_fw_ops;
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 7370e3f76b62..546b48f897d3 100644
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
@@ -606,6 +610,54 @@ u32 hw_atl2_utils_get_fw_version(struct aq_hw_s *self)
 	       version.bundle.build;
 }
 
+int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	struct filter_caps_s filter_caps;
+	u32 tag_top;
+	int err;
+
+	err = hw_atl2_shared_buffer_read_safe(self, filter_caps, &filter_caps);
+	if (err)
+		return err;
+
+	priv->art_base_index = filter_caps.rslv_tbl_base_index * 8;
+	priv->art_count = filter_caps.rslv_tbl_count * 8;
+	if (priv->art_count == 0)
+		priv->art_count = 128;
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
+	if (filter_caps.vlan_filter_count > 2)
+		priv->vlan_filter_count = min_t(u32,
+						filter_caps.vlan_filter_count - 2,
+						tag_top);
+	else
+		priv->vlan_filter_count = 0;
+
+	priv->l3_v4_filter_base_index = filter_caps.l3_ip4_filter_base_index;
+	priv->l3_v4_filter_count = min_t(u32, filter_caps.l3_ip4_filter_count,
+					 HW_ATL2_RPF_L3V4_FILTERS - 1);
+	priv->l3_v6_filter_base_index = filter_caps.l3_ip6_filter_base_index;
+	priv->l3_v6_filter_count = filter_caps.l3_ip6_filter_count;
+	priv->l4_filter_base_index = filter_caps.l4_filter_base_index;
+	priv->l4_filter_count = min_t(u32, filter_caps.l4_filter_count,
+				      HW_ATL2_RPF_L4_FILTERS - 1);
+
+	return 0;
+}
+
 int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
 						u8 *base_index, u8 *count)
 {
-- 
2.43.0


