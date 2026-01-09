Return-Path: <netdev+bounces-248448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1ED0892F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48E4530158ED
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93430339705;
	Fri,  9 Jan 2026 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LicuDmtH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC645338F5B;
	Fri,  9 Jan 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954702; cv=none; b=oQzwicTtDzx9IjEZs9JwAKdu6gOZeSNl3FRgs5qDItu+l9qENy941Y9xBTHmWtedV2C0LsA9+PS8M/QMVs6wNVYfOwTrlj20Q4ixgPpKMzNhXMXIXrhFSl3WoQxwhfaFF5It/8mJpVm7/bXwXmvvNMBXS1ue5/x4fVHdAwc82ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954702; c=relaxed/simple;
	bh=08kjM0UEVJ3OBOcUn7eJgPUyGRiSVCOjkmpoVugQw/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcBNeP0Nc9XnYwpe1FoXB/4qWloEns2JO+d2DQh0eUh+aMoWNDlxjnq6ZydM0Pz/gNgmSF6TGkvE1SoRiPB+O+Big7l/TX+3zYBc15T0kCsv8EUh9mtwr1cu7VnIqZxHMNNQjeZtf1ZHi/B+rpZKKFA9LJ5IyBAQKQaESPJj2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LicuDmtH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6092L2BJ2938085;
	Fri, 9 Jan 2026 02:31:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	5yJx0JbT68f7zq+eCmKiyumjAoJaoNuNekDS+tHtr4=; b=LicuDmtHUNgYJPDTA
	JZEv3emEhrcpbVawNhHGJEaV/NUffWRXBOwg2O3vyYzIEByAX+QbMBQzjUq04zlB
	ZgDrnetsREljadVK2PAZSDNsWumqF+I6W3dQFxmj+VIi6d25tagIzPtSqdP6JJbT
	fg91trE5TgqhHZMBZLybpFTLsJ2g/iS32TPw0DbFdnG0dfESjM50+gPltkE3u0x+
	eF0IAWL8lG+7QBjr3BNh4FIKJoFfHFBKPWhZucdBgAlcsqLpeyzecmLlXlUF4Gtp
	4GFlIK31Ugsu3bO3URgc3xTuBVtpXA5ViOc/U4NZtb9qUcsmLW+Z/rIKhf4C0jxi
	VtqiA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2vmvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 02:31:32 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Jan 2026 02:31:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Jan 2026 02:31:47 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 51CC23F70F7;
	Fri,  9 Jan 2026 02:31:29 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 04/10] octeontx2-af: switch: Representor for switch port
Date: Fri, 9 Jan 2026 16:00:29 +0530
Message-ID: <20260109103035.2972893-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109103035.2972893-1-rkannoth@marvell.com>
References: <20260109103035.2972893-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fMZxgO6PbfkezUBwpc-sihqSrnzm_oDi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3NiBTYWx0ZWRfXwtKznojo/eOl
 AtTUaeSPKMQcq1L5jMC7SYtUMuvLtfXmLlo+Y6uuVUXbdKr2FBbo0sdFv64cJN0ttlREigGGLFY
 CdegUyai++p7zDmUGNizveZ+rwD2qK1nUQ9fC0n08SYLLYwrO+pzDPXKBhmgQekGxS4TuBdqyBT
 C+ggsBU0MTyJDm2sxKn4e3Jxo8gzijqX3SyFHH6fJGxLexvyA53+4nWRulTDtwjvlpoBeSCA3Eu
 jmWDYvj2kkXTwuQH++qDG/4Ngkw2rl07Ss7fMjYalMcjR75Msq3NcAP454PPWIvJI+JQqrVnfXf
 f7c+zOJhD8N9QrVwCR0WaMvBlkjTPsciMoCaykwbyFbLOZmrQjmXQCCbhLF+jfqbs9xaw24S65B
 Gyb6IYszbQV8iCBBHCqW1ympTzS5/guwqiEImIJI1eePdhwlkcw55kcv7vv2EWK77NYAlNQjDxc
 DVUI6IEP8zPI4Wm2jYg==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=6960d904 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=xXrhxGPyklmKcrYTpSYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: fMZxgO6PbfkezUBwpc-sihqSrnzm_oDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01

Representor support is already available in AF driver. When
Representors are enabled through devlink, switch id and various
information are collected from AF driver and sent to switchdev
thru mbox message. This message enables switchdev HW.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  5 +++++
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |  3 ++-
 .../ethernet/marvell/octeontx2/af/switch/rvu_sw.c  | 14 ++++++++++++++
 .../ethernet/marvell/octeontx2/af/switch/rvu_sw.h  |  3 +++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  4 ++++
 6 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index d82d7c1b0926..24703c27a352 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1721,6 +1721,7 @@ struct get_rep_cnt_rsp {
 struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	u64 rsvd;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 4e11cdf5df63..0f3d1b38a7dd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -567,6 +567,10 @@ struct rvu_switch {
 	u16 *entry2pcifunc;
 	u16 mode;
 	u16 start_entry;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
+	u64 flags;
+	u16 pcifunc;
 };
 
 struct rep_evtq_ent {
@@ -1185,4 +1189,5 @@ int rvu_rep_pf_init(struct rvu *rvu);
 int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 4415d0ce9aef..078ba5bd2369 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -181,7 +181,7 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
 	return 0;
 }
 
-static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
 	int id;
 
@@ -428,6 +428,7 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	memcpy(rvu->rswitch.switch_id, req->switch_id, MAX_PHYS_ITEM_ID_LEN);
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index fe143ad3f944..533ee8725e38 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -6,6 +6,20 @@
  */
 
 #include "rvu.h"
+#include "rvu_sw.h"
+
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u16 port_id;
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
index b476733a0234..9200198be71f 100644
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


