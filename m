Return-Path: <netdev+bounces-285780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ+DIEHR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB324F60F4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1EA5300BB8D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46DD3D0918;
	Fri,  8 May 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IP+CRGv1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5A396579;
	Fri,  8 May 2026 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241854; cv=none; b=dM9yJRdULpIsu0l2eYQcrz5OC1xbTYFhheZejrPX6W/1s3MrIssknGXxHyVed4lmHcYPEQgTEaiOv9bwMxATvVWCk9N3AMeWPWZ27L8Tc3b9Od1ZpIcmRTDHbcbQjSdcon1DODi4f44tQaaUTTEpTYW6o82399pVmKJgApJ/Gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241854; c=relaxed/simple;
	bh=5Rj3PnAz0uBEx3C9AT31iUuHVS6X4ygvcnuR5FL0kz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGLDZ0v3WEm+UdzgIGENFkyh40U7HbKKhoSzi03VXC5UQKWYL/gFe4XKaJ/wPg/5jhH1SPYDN8wpGK5h00QH0lSupqY/ssHowMemsNo4VVzAy/ZX4QsBE+DcoH9YSsUO5NWs4Q0JZW/+fh086p06i99DHJBE6LyRkTk+FV8iXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IP+CRGv1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648BPU5u2841684;
	Fri, 8 May 2026 05:03:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	5+rFPRIyuxq7S27C0/a57f8Nd+3qn0oDbgIIXIbIqQ=; b=IP+CRGv1toRPQUy9w
	HJUBgvRhhgoOBPba28Eypnp7jZ2hDDnqGWM/ecg/yuepQBbeeeME4r4B3tKsJy6v
	wU71wt8lHjQ9T+wpy+384sT0kAOYfI3npEs4MqpWMKn6YBv9ge12FOqOerR+dhtG
	uhMDJ38CSA34CYHY8CaMhNWedA5EIbO2LJ82wr6l0x78DmWA9fFE0f4a56+N2bCC
	7B1yyu6d4yjHpViguXTpBz0jEjZq266rVxTAl26PSQilj+zQH+54rsXQ+JSEAVrh
	YcqGUJZMKiZEp8qZLat0GDl2S0h9eDfFDrP46ugVXs8uqDqrnYiglW9nyBMdkRLq
	Vw6Ww==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e14g0hqw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:03:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:03:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:03:48 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id AD7D75B693F;
	Fri,  8 May 2026 05:03:43 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 6/9] net: atlantic: implement AQC113 L2/L3/L4 RX filter management filter management management
Date: Fri, 8 May 2026 17:31:53 +0530
Message-ID: <20260508120156.3060-7-sukhdeeps@marvell.com>
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
X-Proofpoint-ORIG-GUID: OgZw0sPRkgYLpWyurbA6O1dWCewynjNd
X-Authority-Analysis: v=2.4 cv=bMUm5v+Z c=1 sm=1 tr=0 ts=69fdd125 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=J2FfQZe5whmnkCmaWzMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfXy7nBg07jFS7h
 BSsix7aU5jy2bOtdC8qOmEuIgNM3ut0PKvGM9ww9SFyuBNl8sVpxb7Bs9h9P2geLMc73nyfX55N
 IJwcdevuU17Ni4KACiYe1Ap6N7ijQu5UiGn2ZTD3RK2gt0JBRBgqp6KcnaK2LMxTdmUI2e38Z98
 N/XiPz4hF0I/7hcNwacFJH0KZtZywF9Ed032oTL9hfcLz1z2E/TXJ8mVA5yxzsf7tjb91mKs4rh
 KSOxKpgHHd2w+4QuMvg87BfxgkQoQABnvxYfbjPkXdHm0CSCblBeJyxl8npc+dvfkfOqAYzj3rX
 Jm0QX0ODME49kBCB5rJsloy772CMpTSMK+8gxzapcHAlFW7LsLi1dD+zSTyiMISNIYVQAMPAoEG
 7HYq/lwSfxjrn60utOJOUuhu7BCSawBq0VIkPz9txbUpO+4cbViV3uWhclqfJbQeKugwgTcYfvc
 +YS6wc2O3RD4CiQgyJg==
X-Proofpoint-GUID: OgZw0sPRkgYLpWyurbA6O1dWCewynjNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 1BB324F60F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285780-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,l4.sport:url];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Implement complete RX filter management for AQC113 hardware:

- Add tag-based filter policy with reference-counted sharing, allowing
  multiple filter rules to share the same L3 or L4 hardware filter
  when their match criteria are identical.
- Implement L3 (IPv4/IPv6 source/destination address and protocol)
  filter find, get (program HW and increment refcount), and put
  (decrement refcount and clear HW when last user releases).
- Implement L4 (TCP/UDP/SCTP source/destination port) filter
  management with the same find/get/put pattern.
- Add combined L3L4 filter configuration that translates legacy
  aq_rx_filter_l3l4 commands into AQC113 separate L3+L4 filter
  programming with Action Resolver Table (ART) entries.
- Add L2 ethertype filter set/clear with tag-based ART integration.
- Add MAC address setup using firmware-provided L2 filter base index.

Update hardware initialization:
- Use firmware-reported ART section base and count instead of
  hardcoded 0xFFFF section enable.
- Enable L3 v6/v4 select mode for simultaneous IPv4/IPv6 filtering.
- Initialize L3L4 filter indices to -1 on reset.

Wire up hw_filter_l2_set, hw_filter_l2_clear, hw_filter_l3l4_set,
hw_set_mac_address, hw_get_version, and hw_get_regs in hw_atl2_ops.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../net/ethernet/aquantia/atlantic/aq_hw.h    |   2 +
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 582 +++++++++++++++++-
 2 files changed, 580 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 57ea59026a2c..04fb87d4e56d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -236,6 +236,8 @@ struct aq_hw_ops {
 
 	int (*hw_stop)(struct aq_hw_s *self);
 
+	u32 (*hw_get_version)(struct aq_hw_s *self);
+
 	int (*hw_ring_tx_init)(struct aq_hw_s *self, struct aq_ring_s *aq_ring,
 			       struct aq_ring_param_s *aq_ring_param);
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 0ce9caae8799..7abf7fe6e32c 100644
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
@@ -86,6 +87,38 @@ const struct aq_hw_caps_s hw_atl2_caps_aqc116c = {
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
@@ -95,12 +128,21 @@ static int hw_atl2_hw_reset(struct aq_hw_s *self)
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
 
@@ -380,6 +422,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 {
 	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
 	struct hw_atl2_priv *priv = self->priv;
+	u32 art_first_sec, art_last_sec;
+	u32 art_sections;
+	u32 art_mask;
 	u16 action;
 	u8 index;
 	int i;
@@ -394,9 +439,14 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
 	 * REC entry is used for further processing. If multiple entries match,
 	 * the lowest REC entry, Action field will be selected.
 	 */
-	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
+	art_last_sec = priv->art_base_index / 8 + priv->art_count / 8;
+	art_first_sec = priv->art_base_index / 8;
+	art_mask = (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);
+	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
+	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
+	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
 	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
-				     HW_ATL2_MAC_UC);
+				     priv->l2_filters_base_index);
 	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);
 
 	/* FW reserves the beginning of ART, thus all driver entries must
@@ -530,6 +580,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
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
@@ -767,6 +846,496 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
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
+		if (priv->l3l4_filters[data->location].l3_index != l3_idx)
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
+		if (l4_idx < 0) {
+			/* Undo L3 acquisition */
+			if (l3_idx >= 0) {
+				hw_atl2_rxf_l3_put(self, &l3_filters[l3_idx], l3_idx);
+				priv->l3l4_filters[data->location].l3_index = old_l3_index;
+				priv->l3l4_filters[data->location].ipv6 = old_ipv6;
+			}
+			return -EINVAL;
+		}
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
+	else if (data->cmd)
+		action = HW_ATL2_ACTION_DROP;
+	else
+		action = HW_ATL2_ACTION_DISABLE;
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
@@ -825,7 +1394,7 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
 const struct aq_hw_ops hw_atl2_ops = {
 	.hw_soft_reset        = hw_atl2_utils_soft_reset,
 	.hw_prepare           = hw_atl2_utils_initfw,
-	.hw_set_mac_address   = hw_atl_b0_hw_mac_addr_set,
+	.hw_set_mac_address   = hw_atl2_hw_mac_addr_set,
 	.hw_init              = hw_atl2_hw_init,
 	.hw_reset             = hw_atl2_hw_reset,
 	.hw_start             = hw_atl_b0_hw_start,
@@ -834,6 +1403,7 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_ring_rx_start     = hw_atl_b0_hw_ring_rx_start,
 	.hw_ring_rx_stop      = hw_atl_b0_hw_ring_rx_stop,
 	.hw_stop              = hw_atl2_hw_stop,
+	.hw_get_version       = hw_atl2_get_hw_version,
 
 	.hw_ring_tx_xmit         = hw_atl_b0_hw_ring_tx_xmit,
 	.hw_ring_tx_head_update  = hw_atl_b0_hw_ring_tx_head_update,
@@ -848,6 +1418,9 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_ring_rx_init             = hw_atl2_hw_ring_rx_init,
 	.hw_ring_tx_init             = hw_atl2_hw_ring_tx_init,
 	.hw_packet_filter_set        = hw_atl2_hw_packet_filter_set,
+	.hw_filter_l2_set            = hw_atl2_hw_fl2_set,
+	.hw_filter_l2_clear          = hw_atl2_hw_fl2_clear,
+	.hw_filter_l3l4_set          = hw_atl2_hw_fl3l4_set,
 	.hw_filter_vlan_set          = hw_atl2_hw_vlan_set,
 	.hw_filter_vlan_ctrl         = hw_atl2_hw_vlan_ctrl,
 	.hw_multicast_list_set       = hw_atl2_hw_multicast_list_set,
@@ -855,6 +1428,7 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_rss_set                  = hw_atl2_hw_rss_set,
 	.hw_rss_hash_set             = hw_atl_b0_hw_rss_hash_set,
 	.hw_tc_rate_limit_set        = hw_atl2_hw_init_tx_tc_rate_limit,
+	.hw_get_regs                 = hw_atl2_utils_hw_get_regs,
 	.hw_get_hw_stats             = hw_atl2_utils_get_hw_stats,
 	.hw_get_fw_version           = hw_atl2_utils_get_fw_version,
 	.hw_set_offload              = hw_atl_b0_hw_offload_set,
-- 
2.43.0


