Return-Path: <netdev+bounces-303973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z+n0G3nuRWpOGwsAu9opvQ
	(envelope-from <netdev+bounces-303973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF726F376B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:52:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=CpDO0u5x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303973-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303973-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AFA8301CF50
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB13369D4A;
	Thu,  2 Jul 2026 04:50:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5E368D6B;
	Thu,  2 Jul 2026 04:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967852; cv=none; b=MiPakpOQHur8/sdNR6FYEQhgVHkcNRjuJEhoxc2Kpkx7FRHY/1h5gMgEtqMocMCXeCNvAfAhDdHc/LJznK7WxqxBXdu+g/x890NQX+uYr0Fxv4yEzvl196c/NqncH+8cIkh+QXt0DBIs4QevtK5KD14n8Prm/aHRrHXEB3cAM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967852; c=relaxed/simple;
	bh=gvLNtn6c5zm9YxxAJBl+bTZOBbiVOzn3n88E7MGmr9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAfmciRvU47Cyitj3auVKPA4H0tVIf60zqiGh2hT30+rDEhk9aNwsZx6hERP83tcM3dXugFQxzMxGDq+TCX6U1XMxoQRReAP7yUsqROsDcMpvq9BD6qiwXvSb0KddwbFaqZfa6IM3ntvWeF9wqtcN3+NKdlxN0bm1xgVms1GSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CpDO0u5x; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MDbT213810;
	Wed, 1 Jul 2026 21:50:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	Va1dwkw4YjPqAKZjsfNehjvT5uNDsUYDhFQi5Y7fjA=; b=CpDO0u5x5WezDSDKu
	jyPuhSe1OCFHhfZcPM2AhapSNuJbEPL/00sAyQRLl7gDkKu5BY/uhmXPyUUOt0WF
	RpOD+vtUfKsVuUomjJQNoiPuaHUTxTijgixhyrzp4ZSAUEcjCMGGrps6pCY7ODo2
	eU/fAGzj5yuLTo0GycxnxtQADO5JyQWQblVqHHz2WLvclTCdkTVC+6UL0k/zcwId
	5vZcoBr8TJoETHF3uxqpDZE1qa2n865bVFn2lAsideAe4DVtcTVdwVpBJy/HqVkM
	0RO0voM3viavI2vM8mJuSjMqsmZSWLZvmWn3syinBz5GVl/4Ho8NIyFpqYb6N0kl
	YPPRw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f52krbdst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:50:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:50:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:50:42 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 558053F708F;
	Wed,  1 Jul 2026 21:50:40 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 4/9] octeontx2-af: switch: Representor for switch port
Date: Thu, 2 Jul 2026 10:20:21 +0530
Message-ID: <20260702045026.2914748-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702045026.2914748-1-rkannoth@marvell.com>
References: <20260702045026.2914748-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfXzSYZIsjY8I8Z
 mHN4qeaptHHlnLhlIiqVig5w4K23vGylQqg1jUh21B9ytiOYEXlgJDf8nNDBBSL6tmRT+LolM3y
 yqSvG/cGe4eTxg0ZE8n6rD2x+qn9MXo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfXyPT1kcjkt/Ts
 tj0YJLVQaJ0gkZcosUtI7McCEWoGLCnWAumLuNmSGqWzMALKBuTUdNfW2oFBRlCaq3rVhYa2KNr
 PyWdbSMIRZwDsCCLA8hl+pd8VkTTwF8dk7LHq4NWip4RmZ+ajdGTuLnSWOVXzDaJSlIJiyuz2OB
 9Gfi5GMtzxL82pVfD7jm03Yomwiyu7tDlL7jPfkq4NOwlEMcgUi9ycwGRpCPrl70e1jxZGLLDHg
 9etoqsQpkL5o4pRmWvGX2Ar4h5cV0ntzDqTxw7qL5/cnZOHUPClea/wP7M3k5Bbz8a2FowcMu8z
 MJaH6KDmi1DILPhczut0UXslpStgvFVmsmL5b2OqAysKwXiaMw1+vtRRnI4kpMLZK5jNAlV0jCa
 NBjmvQg7I94UJVMCP+86+AAGNfpZxElMprOrqc+3bMZRDgQQ6nYBmyEAYJ6v5WXlPdhOW9UizMe
 sWcITulNV7eDTbAtAQw==
X-Proofpoint-GUID: VkqIxtmW92kNv0XnWlxMgF-eg3Ik2eiZ
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a45ee23 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=DoYLhwvCB9hUwP6ZXpoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: VkqIxtmW92kNv0XnWlxMgF-eg3Ik2eiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303973-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DF726F376B

Extends esw_cfg with a devlink-derived switch id, copies it into
rvu->rswitch on the AF, adds rvu_sw_port_id(), exports
rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h   |  5 +++++
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c   |  3 ++-
 .../ethernet/marvell/octeontx2/af/switch/rvu_sw.c | 15 +++++++++++++++
 .../ethernet/marvell/octeontx2/af/switch/rvu_sw.h |  3 +++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c  |  4 ++++
 6 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 43ff97441273..7ac26629d9af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1833,6 +1833,7 @@ struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
 	u64 rsvd;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 };
 
 struct rep_evt_data {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 21803e257cae..3e34d56a5bd3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -576,6 +576,10 @@ struct rvu_switch {
 	u16 *entry2pcifunc;
 	u16 mode;
 	u16 start_entry;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
+	u64 flags;
+	u16 pcifunc;
 };
 
 struct rep_evtq_ent {
@@ -1197,4 +1201,5 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..6bb6064b2391 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -189,7 +189,7 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
 	return 0;
 }
 
-static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
 	int id;
 
@@ -436,6 +436,7 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	memcpy(rvu->rswitch.switch_id, req->switch_id, MAX_PHYS_ITEM_ID_LEN);
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index fe143ad3f944..28f8281e9219 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -5,7 +5,22 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u32 port_id;
+	u16 rep_id;
+
+	rep_id  = rvu_rep_get_vlan_id(rvu, pcifunc);
+
+	port_id = FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+		  FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+
+	return port_id;
+}
 
 int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
index f28dba556d80..847a8da60d0a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -8,4 +8,7 @@
 #ifndef RVU_SWITCH_H
 #define RVU_SWITCH_H
 
+/* RVU Switch */
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..257a2ae6a53e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -399,8 +399,11 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
+
 	mutex_lock(&priv->mbox.lock);
 	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
 	if (!req) {
@@ -408,6 +411,7 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 		return -ENOMEM;
 	}
 	req->ena = ena;
+	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
 	return 0;
-- 
2.43.0


