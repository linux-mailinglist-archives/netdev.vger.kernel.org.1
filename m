Return-Path: <netdev+bounces-294242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9H76JozjHmpcYgAAu9opvQ
	(envelope-from <netdev+bounces-294242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FF62F25B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=QVi8pmFc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294242-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D569D30EAB5E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7883EDE67;
	Tue,  2 Jun 2026 13:55:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81633EDADF;
	Tue,  2 Jun 2026 13:55:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408550; cv=none; b=C7IB7PnroYLoU+cGsAo1IX8BoDngY9JNJTrdI3RVt8Gf9HxaBIIzz1gR+OV6Zp1+tZkDl9eadg9SClEuXwd2VyfnVrosKXbZ7KPAGC4rkJwKZbCP6Pwt82jAcN40Z3qDAgP93nFA1VXpUflyysr5bebFv5sQbji1Sdyjgnv7FB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408550; c=relaxed/simple;
	bh=QjnhZL4J5FpXu/8QaIMBIfv7YJ3qQmy4J0msnXBxCn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZcEcswjYqonyrfJKr4IJAqr4ntSJHxtn7403qY9tWE/KFerR78FrN6Ew2mBGWnHGctTWAF/4y6/g24tk7+yfp4Fnc/cbVA6zeQT3+4MBPR1xwcsGE7wn3ICdOaOrBE34QPnR1sAyHpiXMPAQc622Blu4oLYBeGv4UyMxI5SsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QVi8pmFc; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65272q4n1261723;
	Tue, 2 Jun 2026 06:55:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
	ec1EfGCETtLB4cmQs/IEz12HcXnq7aM6AVi5Gv8uWM=; b=QVi8pmFcNlBpl6ruw
	qS4YuP7+l5PBMrbviefx8fCr97DUA2+f9TRe2JnjX1CDAhQKsj8bNNp2dOtJhrmb
	ONjfgA0WJlkwJa5WeYgX979VuvyD4GXAittSVSMI9O3cy1j+yNySXB8isZlNyW8o
	LkCWSW9HmkcYcHgOdblREGLwQCMBXyzpi7TmvqTPoaoQWVKGRI2RtzejdVe6Mk20
	dZUNnRmWl/iHhot4Aa8lvW5opm97Ke3Eu+KfEPqKm7RtmYWSzrgnUV55O0Y9pK4f
	HwMwPAW/0W4PqZb94Q3noonzlBDX2SsQwmg4qzm26d8GT3Ed8gGSPgEnxIPwU92E
	UCipw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b8qb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:55:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 06:55:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 06:55:32 -0700
Received: from BG-LT92649.marvell.com (unknown [10.193.71.86])
	by maili.marvell.com (Postfix) with ESMTP id 1EA4F3F7062;
	Tue,  2 Jun 2026 06:55:27 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v4 6/12] net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address
Date: Tue, 2 Jun 2026 19:24:46 +0530
Message-ID: <20260602135452.516-7-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260602135452.516-1-sukhdeeps@marvell.com>
References: <20260602135452.516-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMyBTYWx0ZWRfX2GJ0/LuS/UNn
 gmxu+7QsF868kAeBnESgqu/1Zkhox1bZbNPBM3kiJ+8UfsOPXSJmLqXz9jOFHz+YLNw8pFDMKxh
 gTW2MeTZBWpflSUZZXv0kO45GeB112ao2xdUCtEZXxx8diU8SRPhUV3ZS9dfjwFFbrqc7F60Axj
 8WAamOAzARG0K9wAofYgyD5echAg/sNLSmso1b1+hmHm+wrrvyfoiRnCx5xBEMByiB5oNvOdsfl
 IxISKVOdPp2cLTWCt9ZqRPCIaAusiBI+3NnIMNJXv2PNdGlGHPKXe1lNxCjc0dCO32lWb3jO2s2
 oZyb/yYLA+FVq+HbREEW6ar0q84a4mR14bxl/+5pZFYMIoqrgX3/+TAXP8AxCKm7XJW2nRnjpOG
 0vgwEtUsXypgvudPxo/qBJ9FxHJmFTkLrMjbqRJyqas1e2nA+TdFpaRIaJWlvKwZVVMuAclDkLC
 KSPwzJ5SpviwgA3jxBQ==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1ee0d5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=7NEf1ERlbMdKfpasHkQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 1Ek8OJJyCiTNm6euP59hNgJAH4xKTzQY
X-Proofpoint-GUID: 1Ek8OJJyCiTNm6euP59hNgJAH4xKTzQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294242-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:sukhdeeps@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 081FF62F25B

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
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 69 +++++++++++++++++--
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       |  2 +
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 0ce9caae8799..27a62fffbc29 100644
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
@@ -556,7 +612,7 @@ static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 	hw_atl2_hw_init_tx_path(self);
 	hw_atl2_hw_init_rx_path(self);
 
-	hw_atl_b0_hw_mac_addr_set(self, mac_addr);
+	hw_atl2_hw_mac_addr_set(self, mac_addr);
 
 	self->aq_fw_ops->set_link_speed(self, aq_nic_cfg->link_speed_msk);
 	self->aq_fw_ops->set_state(self, MPI_INIT);
@@ -825,7 +881,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
 const struct aq_hw_ops hw_atl2_ops = {
 	.hw_soft_reset        = hw_atl2_utils_soft_reset,
 	.hw_prepare           = hw_atl2_utils_initfw,
-	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
+	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,
 	.hw_init              = hw_atl2_hw_init,
 	.hw_reset             = hw_atl2_hw_reset,
 	.hw_start             = hw_atl_b0_hw_start,
@@ -855,6 +911,7 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_rss_set                  = hw_atl2_hw_rss_set,
 	.hw_rss_hash_set             = hw_atl_b0_hw_rss_hash_set,
 	.hw_tc_rate_limit_set        = hw_atl2_hw_init_tx_tc_rate_limit,
+	.hw_get_regs                 = hw_atl2_utils_hw_get_regs,
 	.hw_get_hw_stats             = hw_atl2_utils_get_hw_stats,
 	.hw_get_fw_version           = hw_atl2_utils_get_fw_version,
 	.hw_set_offload              = hw_atl_b0_hw_offload_set,
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 3011c7cd5259..0f603a37218c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -627,6 +627,8 @@ int hw_atl2_utils_get_filter_caps(struct aq_hw_s *self)
 	if (priv->art_count == 0)
 		priv->art_count = 128;
 	priv->l2_filters_base_index = filter_caps.l2_filters_base_index;
+	if (priv->l2_filters_base_index >= HW_ATL2_MAC_MAX)
+		priv->l2_filters_base_index = HW_ATL2_MAC_UC;
 	priv->l2_filter_count = filter_caps.l2_filter_count;
 	priv->etype_filter_base_index = filter_caps.ethertype_filter_base_index;
 	priv->etype_filter_count = filter_caps.ethertype_filter_count;
-- 
2.43.0


