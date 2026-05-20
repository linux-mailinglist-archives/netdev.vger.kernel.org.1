Return-Path: <netdev+bounces-289964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NL4BajDDWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D77B58F7EE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2A6317685C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFE3ECBC8;
	Wed, 20 May 2026 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WN+OJp9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F83E9584;
	Wed, 20 May 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286348; cv=none; b=tSlUDUakgGy6dLCaQl0EOsymPbbYjJ+xC9/pZyfEos6XLlDcfLmvl5BFeAsIp7SdQYLcyc3dDllDt1r/Xd0XGUWuF5UkeXZKNXb+ADZ7Ws047qY5AC3L/7klAJtrvHlyLtfnrwGAzpcupoqr0aApMMdacUlpM7VmM82BrRynAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286348; c=relaxed/simple;
	bh=JAvLm3Ua1fx84JuGuU4dV9DDwtM0cK88KSfyl61VQZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgSHueg7Jl134jhti1PBcaHN0IyZfBJP37mpG5bXUk5FPBZqk7ofW8BkIsIp80+39FurcajDEuQ2XrpNuy7jlO6lkfU0GsivwKYUdAXqvGgKAM0VydQiEYXttVftPhP1075+CqXeFnea17oUJROM3oyUFdwqzZI2OO5ZFbJ81o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WN+OJp9Q; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K4G2j1243583;
	Wed, 20 May 2026 07:11:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
	PCdBa1/AdhSJawQoOnFraO/PPFO88Oru72EtIVeNg8=; b=WN+OJp9Q9UxcJwAOa
	+hFW0cDaRvqY2EO0qI8rrhlvitl2hIRYcf1l/Du7WA/R8AlDKGqv7sVBeknzqGpJ
	8N50lZ8B+ALewHjdGAtaQbQKqiLfz4Hqp/QwI91kwOg9PhHWdWfScHFwYeKiOmub
	yLKqv7MyosqcwxSqdFiX8XRjiBq0fAJO03VEDAcr/BlLQ6hA16WUb3Q7qN6Az9Ep
	xCji304I2WbSOQg5crugNZE3Cjv4ddO14DcWl2jy7FQPnBreCdzhfIxBVSNeuwUw
	qIM5Q9XE9wOF7iCo6J9WE/wnR53FGROGgnYlhuygUPn4W3oVX7F0/Qsps3LRUFk5
	QAT7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8k5rmx44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:11:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:11:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:11:52 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 3DA735B693E;
	Wed, 20 May 2026 07:11:46 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 5/12] net: atlantic: add AQC113 filter data structures and firmware query
Date: Wed, 20 May 2026 19:40:38 +0530
Message-ID: <20260520141046.2151-6-sukhdeeps@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=Ka7idwYD c=1 sm=1 tr=0 ts=6a0dc129 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=C_pYv5bCH7riZfDLuocA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX33GUt88y3cmq
 af3MtlozPy3Z0ljMsKwyjDzD4kcyTo8+OvFsWHtUPfgCOQOFOuU/xkrTnwz9rEkwNMylHVdnroD
 E+mu7O6TQmYby2zybIWPlnRe4aRYEF3Wm6Wsj6/aBDWTNLIsq4sHxts6kszaGdIQR66+aCLx5rY
 JIomnDbKngeWWvBWsyiUkCJv4Ga9aKO0630x9CXR/fbWZk2ZHDnQWbHsaE1KZ5qeH/rDmTap+tS
 GkXbLYRvi2WzK7xBYTjPtOqMq9F/WSd+mOK+lCm/9yGwuhx7y6bH0EEa2O0Axc1DpJTBuAhV9tU
 mPXZG+w0+LeB+2tNYGNaaA9wfNwbmy//pwS72fxImTcAR4TUz3dQCndxyKnS1Xb5m43qq2aL40E
 K7kRYlkwJ/RpoV2lqslS55Jxe30wIu7ISUnmrtyXdx5Vctyhi6OKSlblN1u/XsdrEd1C4yiPhkL
 wpvBE5/GvhkP2sTttQg==
X-Proofpoint-GUID: D8_fsuhpuR2_WeCQDuGLtuVI2E8qkC4N
X-Proofpoint-ORIG-GUID: D8_fsuhpuR2_WeCQDuGLtuVI2E8qkC4N
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289964-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5D77B58F7EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../atlantic/hw_atl2/hw_atl2_internal.h       | 63 +++++++++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.c | 34 ++++++++
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  5 ++
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       | 77 +++++++++++++++++++
 4 files changed, 179 insertions(+)

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
index 7370e3f76b62..41b4745cf04f 100644
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
@@ -606,6 +610,79 @@ u32 hw_atl2_utils_get_fw_version(struct aq_hw_s *self)
 	       version.bundle.build;
 }
 
+int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	struct filter_caps_s filter_caps;
+	u32 tag_top;
+	int err;
+	u32 min_val;
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
+	if (priv->l3_v4_filter_base_index >= HW_ATL2_RPF_L3L4_FILTERS) {
+		priv->l3_v4_filter_base_index = 0;
+		priv->l3_v4_filter_count = 0;
+	} else {
+		min_val = HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l3_v4_filter_base_index;
+		priv->l3_v4_filter_count = min_t(u32,
+						 filter_caps.l3_ip4_filter_count,
+						 min_val);
+	}
+
+	priv->l3_v6_filter_base_index = filter_caps.l3_ip6_filter_base_index;
+	if (priv->l3_v6_filter_base_index >= HW_ATL2_RPF_L3L4_FILTERS) {
+		priv->l3_v6_filter_base_index = 0;
+		priv->l3_v6_filter_count = 0;
+	} else {
+		min_val = HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l3_v6_filter_base_index;
+		priv->l3_v6_filter_count = min_t(u32,
+						 filter_caps.l3_ip6_filter_count,
+						 min_val);
+	}
+
+	priv->l4_filter_base_index = filter_caps.l4_filter_base_index;
+	if (priv->l4_filter_base_index >= HW_ATL2_RPF_L3L4_FILTERS) {
+		priv->l4_filter_base_index = 0;
+		priv->l4_filter_count = 0;
+	} else {
+		min_val = HW_ATL2_RPF_L3L4_FILTERS - 1 - priv->l4_filter_base_index;
+		priv->l4_filter_count = min_t(u32,
+					      filter_caps.l4_filter_count,
+					      min_val);
+	}
+
+	return 0;
+}
+
 int hw_atl2_utils_get_action_resolve_table_caps(struct aq_hw_s *self,
 						u8 *base_index, u8 *count)
 {
-- 
2.43.0


