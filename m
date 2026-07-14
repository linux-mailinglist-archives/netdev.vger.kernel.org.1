Return-Path: <netdev+bounces-307317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Id+KGbqXVWpQqgAAu9opvQ
	(envelope-from <netdev+bounces-307317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CD750391
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:58:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=OquQMdGK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307317-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA54C3064E00
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48D372680;
	Tue, 14 Jul 2026 01:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF38370D7C;
	Tue, 14 Jul 2026 01:56:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994181; cv=none; b=WQeKT96jCX0IW2n8rff7UkNncOn8d/6PyFxnSLQZY2cYFL5JKnrC+OiO0Tn7vSdoOOSEIVyd4ak+mUtPNfF2e7Y88LbZ0RIn4E0bHbi7uh68+vmyQNyUuH8AxUzA5PK0LEv4DsmjHTZ673tOlfd+gb/r/JmtqltFfz0JXXLzleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994181; c=relaxed/simple;
	bh=Mv+dDvABi94MNH45UXFXQykoZNkpev9EpkcKln9Zmqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBwOwOczmvjbuZiT6KTm7n/xfsjtXEDsBCHcJOmWzVv+Gd25SPj0TcX5bSuvqxOCBHQ8T14gadsp5SgzwUR0x0S2aa2kJQw4Ek6mnFvR4SH7xoTxBweMSDLUH2cbwLmYfnW5Ebegxw8/QysO3di3jW+P090M6tcUGUnFXHXFlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OquQMdGK; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnZOf2948457;
	Mon, 13 Jul 2026 18:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	MsiOJYKphB86SdSIwVQpvOPHxAMVQQmyyo1656mblg=; b=OquQMdGK8zOQwmVsC
	4qlwEJe4OyaicyU3eM3Vg0Pzu7D57KQeA1Hv9gOGH1rFA8dhyKOfwFYV1Mz8fj93
	kkHdcbHcCPVXoTNlzvKol9P0xOPTa9yhn+XxnWKPkUd3Cc4meUd8ZsPqM4draASU
	HgWAAloHSrG21aJr6UPstI2Jm+W1j7ShjxTNRqmrAgfyTm9Zuz07JbfbAAQYpI2d
	5SsCjfHWtxikbel2CbWYvbL42MfPWD80kMUwq0H447OEfJMlEdZT9zkR1RuEYHt1
	5kVkRVJ2ytbKm6tP3WfTvZwi72YlRQOlABwp8D9CbIsnnM0ybEOemn8XCj6Dqvkr
	x5+6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fbnbex559-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:53:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 18:53:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 18:53:56 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CF28A5E6866;
	Mon, 13 Jul 2026 18:53:53 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 4/9] octeontx2-af: switch: Representor for switch port
Date: Tue, 14 Jul 2026 07:23:26 +0530
Message-ID: <20260714015331.1801922-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714015331.1801922-1-rkannoth@marvell.com>
References: <20260714015331.1801922-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: w9payAAMT-svuNdXyNjrmO3ZAMtX9IQh
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a5596b5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=vKW80V-kDxkLz87EuU0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: w9payAAMT-svuNdXyNjrmO3ZAMtX9IQh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX1o296gcaEHpC
 Xgx98eBv42L4BRoNKTZ/ex7QgWc2EeI82Xpft0mvry0yfOX4N1EHY2kcm0v5PtMLUC9GY0lRdsg
 5VZHcft+5syEyZOm3JusZWnFYavBh2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX6sruFipUHRlX
 b4otwe08bsRabOC+RddktBtdDxXMV/4t5uc1c0wGVtP3yWVCUFl100sVB2a/ZgSj0ALh0EV4by/
 +z4fx1umcG8eLzPnVkqZwZZm5RSzn1RFygHwKVy2sJv8F1RvOacBBAwFisrHKX4la8dDpWvfbfD
 w8AhqGu0Y4O91HNGZj0qNzyW7HN9vexXPQalmxDWNh8NXQJdNGfuj2g0w+p4pc+LikAOjw7TOIe
 FvJ2bKzaZQPGDHJQ8NO8X1JhL/cpMBGFdk7IsDiZnp/w0E1UKiEK+M1jxuX3szl/wFqK21lOnIk
 eJNouz9qhYELBGPRKpjImVkh/AtdlE7QhuuGjxj0RIUxD+dRzmVJs3yR+AR7tQkIwOPPgdWt/nf
 QY3EQE+4RJi5avlUi4yoR4iH5rTLUSeqGrXS0EXzZIZmlDDtBD01zGBwP8vnSRjYDdUUCmIG8Po
 O68B8ZiJMBurXPT9sgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307317-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC0CD750391

Extends esw_cfg with a devlink-derived switch id, copies it into
rvu->rswitch on the AF, adds rvu_sw_port_id(), exports
rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  5 +++++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  3 ++-
 .../marvell/octeontx2/af/switch/rvu_sw.c      | 19 +++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  4 ++++
 6 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 23bc66ed854e..cdfb5a8bafb9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1834,6 +1834,7 @@ struct get_rep_cnt_rsp {
 struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	u64 rsvd;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 73d2329b5c26..8cf1ad9ec749 100644
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
index fe143ad3f944..403d57870efe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -5,7 +5,26 @@
  *
  */
 
+#include <linux/bitfield.h>
+
 #include "rvu.h"
+#include "rvu_sw.h"
+
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u16 rep_id;
+
+	if (!rvu->rep2pfvf_map || !rvu->rep_cnt)
+		return RVU_SW_INVALID_PORT_ID;
+
+	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
+	if (rep_id >= rvu->rep_cnt ||
+	    rvu->rep2pfvf_map[rep_id] != pcifunc)
+		return RVU_SW_INVALID_PORT_ID;
+
+	return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+}
 
 int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
index f28dba556d80..e9ad32c84576 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -8,4 +8,9 @@
 #ifndef RVU_SWITCH_H
 #define RVU_SWITCH_H
 
+/* RVU Switch */
+#define RVU_SW_INVALID_PORT_ID	((u32)~0U)
+
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


