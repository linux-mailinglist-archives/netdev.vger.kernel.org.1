Return-Path: <netdev+bounces-289968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IASsFibFDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:28:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FB58FA07
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1325C306ECA6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C93EEAF1;
	Wed, 20 May 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bmivRlH1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493B3EAC9B;
	Wed, 20 May 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286388; cv=none; b=jaUmTnzjmrTQa/vz0rdZ0o75F1CSKRYldJhqQc5iSGFQjsBkYgf/DWuhqesUEnYDdz+1OTkibLeoidwormvHBLiVwgOLCAClqRvVEIenVKQBMBbtzLyUBxuhbx6KN/FMuTqfmNWr0jwC0DUQE5WiWExMhJyHsT/A65v2m2sBYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286388; c=relaxed/simple;
	bh=FLEmRYUDJdnLgKaP4umSv7Pnoaq+IOpB1DSxP50R/oM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSHwELTi+9XIHoH5CNvVu1IbANfldV1r8NHlJS6v3WrL2K3mHgDqJxDzpn3ggUhuYWtw3nE01XOsL+clj6nSmwoLrbdNdPfIvuy2vcpagh8UVSJhGHgjIE9NujseS8PNYvKSJzZzOFrWf6wRxcMZbWvD9jiQ4L5euc4xLdDXbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bmivRlH1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDhpEs2256088;
	Wed, 20 May 2026 07:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	+rf03qYk3ZLMqu84O3k/bZNXydTCzp7nRU0tlFhBMI=; b=bmivRlH1W9Ce2Rwq/
	oHehs9U5jFsNq6r+FWEsWP/NwWb/ROF0IbdnoPDWm5G2dKc2lFAq09pJ9tn36Ikr
	bqih4xKmXvmhAMrfpnSifiVPx/jqfZ5ILusQbpc9HgwGAMRMcYnOf8ZABPNNTXIe
	DhF9ODjJd7SKtrZcHBd1t2eqnDsZeQYe4U8wRkpS2TGF6Tofb5s7TUru4WXbRVn/
	qaLk3+CSCXdp4+3H3zQTWGURJvu/RCu+mYErfm7jX07fenf+aFd4XtnfAMUGO883
	2TYv7ksUxmumk5gEHO8zGihvEw6k6JVVtMIPwZEz0EmU2+P32Q6RwcCNXRNQQyCU
	U0z8Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94euhmjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:12:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 07:12:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 07:12:07 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.74.182])
	by maili.marvell.com (Postfix) with ESMTP id 4F1635B6942;
	Wed, 20 May 2026 07:12:01 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v3 7/12] net: atlantic: implement AQC113 L2/L3/L4 RX filter ops
Date: Wed, 20 May 2026 19:40:40 +0530
Message-ID: <20260520141046.2151-8-sukhdeeps@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX/484WDAGjCLu
 sHvAiYI4w5yagGzpfpYMZpoH6AszzH391tJAdhr1AUJArd2qxj0kMWZFqrIl4+54UYwXBjMC59K
 IW1a1qCnBGI9G5fBDGNSnfSh2AVqyehwj6TJpJtiEAdML4hS5kVdzLwqelRoIC9F888G15GKH7f
 oC1iViuT316RHPmEgq6OfdomLtN0j7BofInAUgyxs5BJwebDOMKGWCQbkY59ySk7woltGaahtj2
 Ry/vN9I2c2RABzUNHVszs/Sl/l+JD5dHo87CMlotvqfgTtyf9jLI3LAW6PTb43jPCXcaHBcouJ8
 qlnPYnG5vnqiyiR9dE27O/w/0pB9OS7v+oBMGPpewmv3AdVXU6GvTu8HbJElv2z96XrDkvxfiB8
 KfSF+rcZWOCRr7ON3cyqZq4eCfya7ib6G8EsuE6E0hUlwPLN4HS4541qkZPqZkcFQcb6X0f/u3d
 wA007vwB2iFGgYYpKHw==
X-Proofpoint-ORIG-GUID: ZvIJ3oYU8V-8uTPduDOaFVf4ItKVqkoa
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0dc138 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=DqYEYfIcCQT9R2GCmsUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ZvIJ3oYU8V-8uTPduDOaFVf4ItKVqkoa
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289968-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4E7FB58FA07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Implement complete RX filter management for AQC113 hardware:

- Add tag-based filter policy with reference-counted sharing
  (hw_atl2_filter_tag_get/put), allowing multiple filter rules to share
  the same L3 or L4 hardware filter when their match criteria are
  identical.

- Implement L3 (IPv4/IPv6 source/destination address and protocol)
  filter find, get (program HW and increment refcount), and put
  (decrement refcount and clear HW when last user releases).

- Implement L4 (TCP/UDP/SCTP source/destination port) filter management
  with the same find/get/put pattern.

- Add combined L3L4 filter configuration (hw_atl2_new_fl3l4_configure)
  that translates legacy aq_rx_filter_l3l4 commands into AQC113 separate
  L3+L4 filter programming with Action Resolver Table (ART) entries.

- Add L2 ethertype filter set/clear (hw_atl2_hw_fl2_set/clear) with
  tag-based ART integration.

- Wire .hw_filter_l2_set, .hw_filter_l2_clear, .hw_filter_l3l4_set
  into hw_atl2_ops.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 518 ++++++++++++++++++
 1 file changed, 518 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index db0035fb04c7..a8ab27367dc1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -87,6 +87,38 @@ const struct aq_hw_caps_s hw_atl2_caps_aqc116c = {
 			  AQ_NIC_RATE_10M,
 };
 
+/* Find tag with the same action or new free tag
+ *  top - top inclusive tag value
+ *  action - action for ActionResolverTable
+ */
+static int hw_atl2_filter_tag_get(struct hw_atl2_tag_policy *tags,
+				  int top, u16 action)
+{
+	int i;
+
+	for (i = 1; i <= top; i++)
+		if (tags[i].usage > 0 && tags[i].action == action) {
+			tags[i].usage++;
+			return i;
+		}
+
+	for (i = 1; i <= top; i++)
+		if (tags[i].usage == 0) {
+			tags[i].usage = 1;
+			tags[i].action = action;
+			return i;
+		}
+
+	return -1;
+}
+
+static void hw_atl2_filter_tag_put(struct hw_atl2_tag_policy *tags,
+				   int tag)
+{
+	if (tags[tag].usage > 0)
+		tags[tag].usage--;
+}
+
 static u32 hw_atl2_sem_act_rslvr_get(struct aq_hw_s *self)
 {
 	return hw_atl_reg_glb_cpu_sem_get(self, HW_ATL2_FW_SM_ACT_RSLVR);
@@ -819,6 +851,489 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
 	return &self->curr_stats;
 }
 
+static bool hw_atl2_rxf_l3_is_equal(struct hw_atl2_l3_filter *f1,
+				    struct hw_atl2_l3_filter *f2)
+{
+	if (f1->cmd != f2->cmd)
+		return false;
+
+	if (f1->cmd & HW_ATL2_RPF_L3_CMD_SA_EN)
+		if (f1->srcip[0] != f2->srcip[0])
+			return false;
+
+	if (f1->cmd & HW_ATL2_RPF_L3_CMD_DA_EN)
+		if (f1->dstip[0] != f2->dstip[0])
+			return false;
+
+	if (f1->cmd & (HW_ATL2_RPF_L3_CMD_PROTO_EN |
+		       HW_ATL2_RPF_L3_V6_CMD_PROTO_EN))
+		if (f1->proto != f2->proto)
+			return false;
+
+	if (f1->cmd & HW_ATL2_RPF_L3_V6_CMD_SA_EN)
+		if (memcmp(f1->srcip, f2->srcip, 16))
+			return false;
+
+	if (f1->cmd & HW_ATL2_RPF_L3_V6_CMD_DA_EN)
+		if (memcmp(f1->dstip, f2->dstip, 16))
+			return false;
+
+	return true;
+}
+
+static int hw_atl2_new_fl3l4_find_l3(struct aq_hw_s *self,
+				     struct hw_atl2_l3_filter *l3)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	struct hw_atl2_l3_filter *l3_filters;
+	int i, first, last;
+
+	if (l3->cmd & HW_ATL2_RPF_L3_V6_CMD_EN) {
+		l3_filters = priv->l3_v6_filters;
+		first = priv->l3_v6_filter_base_index;
+		last = priv->l3_v6_filter_base_index +
+		       priv->l3_v6_filter_count;
+	} else {
+		l3_filters = priv->l3_v4_filters;
+		first = priv->l3_v4_filter_base_index;
+		last = priv->l3_v4_filter_base_index +
+		       priv->l3_v4_filter_count;
+	}
+	for (i = first; i < last; i++) {
+		if (hw_atl2_rxf_l3_is_equal(&l3_filters[i], l3))
+			return i;
+	}
+
+	for (i = first; i < last; i++) {
+		u32 l3_enable_mask = HW_ATL2_RPF_L3_CMD_EN |
+				     HW_ATL2_RPF_L3_V6_CMD_EN;
+
+		if (!(l3_filters[i].cmd & l3_enable_mask))
+			return i;
+	}
+
+	return -ENOSPC;
+}
+
+static void hw_atl2_rxf_l3_get(struct aq_hw_s *self,
+			       struct hw_atl2_l3_filter *l3, int idx,
+			       const struct hw_atl2_l3_filter *_l3)
+{
+	int i;
+
+	l3->usage++;
+	if (l3->usage == 1) {
+		l3->cmd = _l3->cmd;
+		for (i = 0; i < 4; i++) {
+			l3->srcip[i] = _l3->srcip[i];
+			l3->dstip[i] = _l3->dstip[i];
+		}
+		l3->proto = _l3->proto;
+
+		if (l3->cmd & HW_ATL2_RPF_L3_CMD_EN) {
+			hw_atl2_rpf_l3_v4_cmd_set(self, l3->cmd, idx);
+			hw_atl2_rpf_l3_v4_tag_set(self, idx + 1, idx);
+			hw_atl2_rpf_l3_v4_dest_addr_set(self,
+							idx,
+							l3->dstip[0]);
+			hw_atl2_rpf_l3_v4_src_addr_set(self,
+						       idx,
+						       l3->srcip[0]);
+		} else {
+			hw_atl2_rpf_l3_v6_cmd_set(self, l3->cmd, idx);
+			hw_atl2_rpf_l3_v6_tag_set(self, idx + 1, idx);
+			hw_atl2_rpf_l3_v6_dest_addr_set(self,
+							idx,
+							l3->dstip);
+			hw_atl2_rpf_l3_v6_src_addr_set(self,
+						       idx,
+						       l3->srcip);
+		}
+	}
+}
+
+static void hw_atl2_rxf_l3_put(struct aq_hw_s *self,
+			       struct hw_atl2_l3_filter *l3, int idx)
+{
+	if (l3->usage)
+		l3->usage--;
+
+	if (!l3->usage) {
+		if (l3->cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
+			hw_atl2_rpf_l3_v6_cmd_set(self, 0, idx);
+		else
+			hw_atl2_rpf_l3_v4_cmd_set(self, 0, idx);
+		l3->cmd = 0;
+	}
+}
+
+static bool hw_atl2_rxf_l4_is_equal(struct hw_atl2_l4_filter *f1,
+				    struct hw_atl2_l4_filter *f2)
+{
+	if (f1->cmd != f2->cmd)
+		return false;
+
+	if (f1->cmd & HW_ATL2_RPF_L4_CMD_SP_EN)
+		if (f1->sport != f2->sport)
+			return false;
+
+	if (f1->cmd & HW_ATL2_RPF_L4_CMD_DP_EN)
+		if (f1->dport != f2->dport)
+			return false;
+
+	return true;
+}
+
+static int hw_atl2_new_fl3l4_find_l4(struct aq_hw_s *self,
+				     struct hw_atl2_l4_filter *l4)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	int i, first, last;
+
+	first = priv->l4_filter_base_index;
+	last = priv->l4_filter_base_index + priv->l4_filter_count;
+
+	for (i = first; i < last; i++)
+		if (hw_atl2_rxf_l4_is_equal(&priv->l4_filters[i], l4))
+			return i;
+
+	for (i = first; i < last; i++)
+		if ((priv->l4_filters[i].cmd & HW_ATL2_RPF_L4_CMD_EN) == 0)
+			return i;
+
+	return -ENOSPC;
+}
+
+static void hw_atl2_rxf_l4_put(struct aq_hw_s *self,
+			       struct hw_atl2_l4_filter *l4, int idx)
+{
+	if (l4->usage)
+		l4->usage--;
+
+	if (!l4->usage) {
+		l4->cmd = 0;
+		hw_atl2_rpf_l4_cmd_set(self, l4->cmd, idx);
+	}
+}
+
+static void hw_atl2_rxf_l4_get(struct aq_hw_s *self,
+			       struct hw_atl2_l4_filter *l4, int idx,
+			       const struct hw_atl2_l4_filter *_l4)
+{
+	l4->usage++;
+	if (l4->usage == 1) {
+		l4->cmd = _l4->cmd;
+		l4->sport = _l4->sport;
+		l4->dport = _l4->dport;
+
+		hw_atl2_rpf_l4_cmd_set(self, l4->cmd, idx);
+		hw_atl2_rpf_l4_tag_set(self, idx + 1, idx);
+		hw_atl_rpf_l4_spd_set(self, l4->sport, idx);
+		hw_atl_rpf_l4_dpd_set(self, l4->dport, idx);
+	}
+}
+
+static int hw_atl2_new_fl3l4_configure(struct aq_hw_s *self,
+				       struct aq_rx_filter_l3l4 *data)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	s8 old_l3_index = priv->l3l4_filters[data->location].l3_index;
+	s8 old_l4_index = priv->l3l4_filters[data->location].l4_index;
+	u8 old_ipv6 = priv->l3l4_filters[data->location].ipv6;
+	struct hw_atl2_l3_filter *l3_filters;
+	struct hw_atl2_l3_filter l3;
+	struct hw_atl2_l4_filter l4;
+	s8 l3_idx = -1;
+	s8 l4_idx = -1;
+
+	if (!(data->cmd & HW_ATL_RX_ENABLE_FLTR_L3L4))
+		return 0;
+
+	memset(&l3, 0, sizeof(l3));
+	memset(&l4, 0, sizeof(l4));
+
+	/* convert legacy filter to new */
+	if (data->cmd & HW_ATL_RX_ENABLE_CMP_PROT_L4) {
+		l3.cmd |= data->is_ipv6 ? HW_ATL2_RPF_L3_V6_CMD_PROTO_EN :
+					  HW_ATL2_RPF_L3_CMD_PROTO_EN;
+		l3.cmd |= data->is_ipv6 ? HW_ATL2_RPF_L3_V6_CMD_EN :
+					  HW_ATL2_RPF_L3_CMD_EN;
+		switch (data->cmd & 0x7) {
+		case HW_ATL_RX_TCP:
+			l3.cmd |= IPPROTO_TCP << (data->is_ipv6 ? 0x18 : 8);
+			break;
+		case HW_ATL_RX_UDP:
+			l3.cmd |= IPPROTO_UDP << (data->is_ipv6 ? 0x18 : 8);
+			break;
+		case HW_ATL_RX_SCTP:
+			l3.cmd |= IPPROTO_SCTP << (data->is_ipv6 ? 0x18 : 8);
+			break;
+		case HW_ATL_RX_ICMP:
+			l3.cmd |= IPPROTO_ICMP << (data->is_ipv6 ? 0x18 : 8);
+			break;
+		}
+	}
+
+	if (data->cmd & HW_ATL_RX_ENABLE_CMP_SRC_ADDR_L3) {
+		if (data->is_ipv6) {
+			l3.cmd |= HW_ATL2_RPF_L3_V6_CMD_SA_EN |
+				  HW_ATL2_RPF_L3_V6_CMD_EN;
+			memcpy(l3.srcip, data->ip_src, sizeof(l3.srcip));
+		} else {
+			l3.cmd |= HW_ATL2_RPF_L3_CMD_SA_EN |
+				  HW_ATL2_RPF_L3_CMD_EN;
+			l3.srcip[0] = data->ip_src[0];
+		}
+	}
+	if (data->cmd & HW_ATL_RX_ENABLE_CMP_DEST_ADDR_L3) {
+		if (data->is_ipv6) {
+			l3.cmd |= HW_ATL2_RPF_L3_V6_CMD_DA_EN |
+				  HW_ATL2_RPF_L3_V6_CMD_EN;
+			memcpy(l3.dstip, data->ip_dst, sizeof(l3.dstip));
+		} else {
+			l3.cmd |= HW_ATL2_RPF_L3_CMD_DA_EN |
+				  HW_ATL2_RPF_L3_CMD_EN;
+			l3.dstip[0] = data->ip_dst[0];
+		}
+	}
+
+	if (data->cmd & HW_ATL_RX_ENABLE_CMP_DEST_PORT_L4) {
+		l4.cmd |= HW_ATL2_RPF_L4_CMD_DP_EN | HW_ATL2_RPF_L4_CMD_EN;
+		l4.dport = data->p_dst;
+	}
+	if (data->cmd & HW_ATL_RX_ENABLE_CMP_SRC_PORT_L4) {
+		l4.cmd |= HW_ATL2_RPF_L4_CMD_SP_EN | HW_ATL2_RPF_L4_CMD_EN;
+		l4.sport = data->p_src;
+	}
+
+	/* find L3 and L4 filters */
+	if (l3.cmd & (HW_ATL2_RPF_L3_CMD_EN | HW_ATL2_RPF_L3_V6_CMD_EN)) {
+		l3_idx = hw_atl2_new_fl3l4_find_l3(self, &l3);
+		if (l3_idx < 0)
+			return l3_idx;
+
+		if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
+			l3_filters = priv->l3_v6_filters;
+		else
+			l3_filters = priv->l3_v4_filters;
+
+		if (priv->l3l4_filters[data->location].l3_index != l3_idx ||
+		    old_ipv6 != !!(l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN))
+			hw_atl2_rxf_l3_get(self, &l3_filters[l3_idx],
+					   l3_idx, &l3);
+	}
+
+	if (old_l3_index != -1) {
+		if (old_ipv6)
+			l3_filters = priv->l3_v6_filters;
+		else
+			l3_filters = priv->l3_v4_filters;
+
+		if (!(hw_atl2_rxf_l3_is_equal(&l3,
+					      &l3_filters[old_l3_index]))) {
+			hw_atl2_rxf_l3_put(self,
+					   &l3_filters[old_l3_index],
+					   old_l3_index);
+		}
+	}
+	if (l3.cmd & HW_ATL2_RPF_L3_V6_CMD_EN)
+		priv->l3l4_filters[data->location].ipv6 = 1;
+	else
+		priv->l3l4_filters[data->location].ipv6 = 0;
+	priv->l3l4_filters[data->location].l3_index = l3_idx;
+
+	if (l4.cmd & HW_ATL2_RPF_L4_CMD_EN) {
+		l4_idx = hw_atl2_new_fl3l4_find_l4(self, &l4);
+		if (l4_idx < 0)
+			return -EINVAL;
+
+		if (priv->l3l4_filters[data->location].l4_index != l4_idx)
+			hw_atl2_rxf_l4_get(self, &priv->l4_filters[l4_idx],
+					   l4_idx, &l4);
+	}
+
+	if (old_l4_index != -1) {
+		if (!(hw_atl2_rxf_l4_is_equal(&priv->l4_filters[old_l4_index],
+					      &l4))) {
+			hw_atl2_rxf_l4_put(self,
+					   &priv->l4_filters[old_l4_index],
+					   old_l4_index);
+		}
+	}
+	priv->l3l4_filters[data->location].l4_index = l4_idx;
+
+	return 0;
+}
+
+static int hw_atl2_hw_fl3l4_set(struct aq_hw_s *self,
+				struct aq_rx_filter_l3l4 *data)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	struct hw_atl2_l3_filter *l3_filters;
+	struct hw_atl2_l3_filter *l3 = NULL;
+	struct hw_atl2_l4_filter *l4 = NULL;
+	u8 location = data->location;
+	u32 req_tag = 0;
+	u16 action = 0;
+	int l3_index;
+	int l4_index;
+	u32 mask = 0;
+	u8 index;
+	u8 ipv6;
+	int res;
+
+	res = hw_atl2_new_fl3l4_configure(self, data);
+	if (res)
+		return res;
+
+	l3_index = priv->l3l4_filters[location].l3_index;
+	l4_index = priv->l3l4_filters[location].l4_index;
+	ipv6 = priv->l3l4_filters[location].ipv6;
+	if (ipv6)
+		l3_filters = priv->l3_v6_filters;
+	else
+		l3_filters = priv->l3_v4_filters;
+
+	if (!(data->cmd & HW_ATL_RX_ENABLE_FLTR_L3L4)) {
+		if (l3_index > -1)
+			hw_atl2_rxf_l3_put(self, &l3_filters[l3_index],
+					   l3_index);
+
+		if (l4_index > -1)
+			hw_atl2_rxf_l4_put(self, &priv->l4_filters[l4_index],
+					   l4_index);
+
+		priv->l3l4_filters[location].l3_index = -1;
+		priv->l3l4_filters[location].l4_index = -1;
+		index = priv->art_base_index + HW_ATL2_RPF_L3L4_USER_INDEX +
+			location;
+		hw_atl2_act_rslvr_table_set(self, index, 0, 0,
+					    HW_ATL2_ACTION_DISABLE);
+
+		return 0;
+	}
+
+	if (l3_index != -1)
+		l3 = &l3_filters[l3_index];
+	if (l4_index != -1)
+		l4 = &priv->l4_filters[l4_index];
+
+	if (l4 && (l4->cmd & HW_ATL2_RPF_L4_CMD_EN)) {
+		req_tag |= (l4_index + 1) << HW_ATL2_RPF_TAG_L4_OFFSET;
+		mask |= HW_ATL2_RPF_TAG_L4_MASK;
+	}
+
+	if (l3) {
+		if (l3->cmd & HW_ATL2_RPF_L3_V6_CMD_EN) {
+			req_tag |= (l3_index + 1) <<
+				   HW_ATL2_RPF_TAG_L3_V6_OFFSET;
+			mask |= HW_ATL2_RPF_TAG_L3_V6_MASK;
+		} else {
+			req_tag |= (l3_index + 1) <<
+				   HW_ATL2_RPF_TAG_L3_V4_OFFSET;
+			mask |= HW_ATL2_RPF_TAG_L3_V4_MASK;
+		}
+	}
+
+	if (data->cmd & (HW_ATL_RX_HOST << HW_ATL2_RPF_L3_L4_ACTF_SHIFT))
+		action = HW_ATL2_ACTION_ASSIGN_QUEUE((data->cmd  &
+						      HW_ATL2_RPF_L3_L4_RXQF_MSK) >>
+						     HW_ATL2_RPF_L3_L4_RXQF_SHIFT);
+	else
+		action = HW_ATL2_ACTION_DROP;
+
+	index = priv->art_base_index + HW_ATL2_RPF_L3L4_USER_INDEX + location;
+	hw_atl2_act_rslvr_table_set(self, index, req_tag, mask, action);
+	return 0;
+}
+
+static int hw_atl2_hw_fl2_set(struct aq_hw_s *self,
+			      struct aq_rx_filter_l2 *data)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	u32 mask = HW_ATL2_RPF_TAG_ET_MASK;
+	u32 req_tag = 0;
+	u16 action = 0;
+	u32 location;
+	u8 index;
+	int tag;
+
+	location = priv->etype_filter_base_index + data->location;
+
+	hw_atl_rpf_etht_flr_set(self, data->ethertype, location);
+	hw_atl_rpf_etht_user_priority_en_set(self,
+					     !!data->user_priority_en,
+					     location);
+	if (data->user_priority_en) {
+		hw_atl_rpf_etht_user_priority_set(self,
+						  data->user_priority,
+						  location);
+		req_tag |= data->user_priority << HW_ATL2_RPF_TAG_PCP_OFFSET;
+		mask |= HW_ATL2_RPF_TAG_PCP_MASK;
+	}
+
+	if (data->queue < 0) {
+		hw_atl_rpf_etht_flr_act_set(self, 0U, location);
+		hw_atl_rpf_etht_rx_queue_en_set(self, 0U, location);
+		action = HW_ATL2_ACTION_DROP;
+	} else {
+		hw_atl_rpf_etht_flr_act_set(self, 1U, location);
+		hw_atl_rpf_etht_rx_queue_en_set(self, 1U, location);
+		hw_atl_rpf_etht_rx_queue_set(self, data->queue, location);
+		action = HW_ATL2_ACTION_ASSIGN_QUEUE(data->queue);
+	}
+
+	tag = hw_atl2_filter_tag_get(priv->etype_policy,
+				     priv->etype_filter_tag_top,
+				     action);
+
+	if (tag < 0)
+		return -ENOSPC;
+
+	req_tag |= tag << HW_ATL2_RPF_TAG_ET_OFFSET;
+	hw_atl2_rpf_etht_flr_tag_set(self, tag, location);
+	index = priv->art_base_index + HW_ATL2_RPF_ET_PCP_USER_INDEX +
+		data->location;
+	hw_atl2_act_rslvr_table_set(self, index, req_tag, mask, action);
+
+	hw_atl_rpf_etht_flr_en_set(self, 1U, location);
+
+	return aq_hw_err_from_flags(self);
+}
+
+static int hw_atl2_hw_fl2_clear(struct aq_hw_s *self,
+				struct aq_rx_filter_l2 *data)
+{
+	struct hw_atl2_priv *priv = self->priv;
+	u32 location;
+	u8 index;
+	u32 tag;
+
+	location = priv->etype_filter_base_index + data->location;
+	hw_atl_rpf_etht_flr_en_set(self, 0U, location);
+	hw_atl_rpf_etht_flr_set(self, 0U, location);
+	hw_atl_rpf_etht_user_priority_en_set(self, 0U, location);
+
+	index = priv->art_base_index + HW_ATL2_RPF_ET_PCP_USER_INDEX +
+		data->location;
+	hw_atl2_act_rslvr_table_set(self, index, 0, 0,
+				    HW_ATL2_ACTION_DISABLE);
+	tag = hw_atl2_rpf_etht_flr_tag_get(self, location);
+	hw_atl2_filter_tag_put(priv->etype_policy, tag);
+
+	return aq_hw_err_from_flags(self);
+}
+
+/*
+ * Set VLAN filter table
+ * Configure VLAN filter table to accept (and assign the queue) traffic
+ * for the particular vlan ids.
+ * Note: use this function under vlan promisc mode not to lost the traffic
+ *
+ * param - aq_hw_s
+ * param - aq_rx_filter_vlan VLAN filter configuration
+ * return 0 - OK, <0 - error
+ */
 static int hw_atl2_hw_vlan_set(struct aq_hw_s *self,
 			       struct aq_rx_filter_vlan *aq_vlans)
 {
@@ -900,6 +1415,9 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_ring_rx_init             = hw_atl2_hw_ring_rx_init,
 	.hw_ring_tx_init             = hw_atl2_hw_ring_tx_init,
 	.hw_packet_filter_set        = hw_atl2_hw_packet_filter_set,
+	.hw_filter_l2_set            = hw_atl2_hw_fl2_set,
+	.hw_filter_l2_clear          = hw_atl2_hw_fl2_clear,
+	.hw_filter_l3l4_set          = hw_atl2_hw_fl3l4_set,
 	.hw_filter_vlan_set          = hw_atl2_hw_vlan_set,
 	.hw_filter_vlan_ctrl         = hw_atl2_hw_vlan_ctrl,
 	.hw_multicast_list_set       = hw_atl2_hw_multicast_list_set,
-- 
2.43.0


