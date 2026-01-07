Return-Path: <netdev+bounces-247745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9FCFDF49
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B454C30010EA
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456E337BAD;
	Wed,  7 Jan 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NkaFJcQU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354E337BB0;
	Wed,  7 Jan 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792282; cv=none; b=m1ERSLP+VuCuANCSS3bYD723AXRV9G95bJX4hGs6+glU2MKb4cKMXilVLp76r9FeFlreOJUvRPIZwHeqWIDrltRZCLICYhB0AleT5WRxpzDyXUUQYQIYgq+vaIeWVxwj7sWDlQ/RZf8rsaunzZKlC4PMWWCocoTqd8qehWv60EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792282; c=relaxed/simple;
	bh=08kjM0UEVJ3OBOcUn7eJgPUyGRiSVCOjkmpoVugQw/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHDi4SzHZS5WGnzUr02DHeiQICTYPEQgjvhf1IALTSzz6jz5q44iPTOQeQ+G30UJC38PZgZ1oUNxoK3r6boSOfwBTdKOM4Ah7YTpGKKi+hix+j6ZIAAI44n/tEI2bKUuW3Ghd77EdwODx6Z8zQyTVZIDVea7jz/DsQP6GoBRP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NkaFJcQU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NqRlL3768578;
	Wed, 7 Jan 2026 05:24:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	5yJx0JbT68f7zq+eCmKiyumjAoJaoNuNekDS+tHtr4=; b=NkaFJcQUASXvqu3li
	6lsp34RNSpWoQ/qHMEZKnIhaECHfmQWeip55Tz5iEF/6mnPkJoui86jsrbauwemL
	2yyX3hKN4BcexeuJwTjESmhFGK735HJj6hI35S6Kt7lJfjfohmEDyoImVTQ2ZG6k
	L/HR9YSBZzrTViewJIIi8+ANWYfVyV3mm7bNBqpO3mSo/L3WpkWdov90Fd42rpJw
	5bpYgaGHl0fXZC2Wlbn2TXumNJ7yhvsN3J/Xhc3P1+S0cAwwvDQo8eR6Wn0CZNY3
	S7fXRbT6dARjJzGq5s2LhCUU8PbzSAm7KBEdQuXENdpvt6MXXlUvqQ48hztJ4S+o
	M9ndw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bhces9chs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:30 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:44 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 658C23F704A;
	Wed,  7 Jan 2026 05:24:26 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 04/10] octeontx2-af: switch: Representor for switch port
Date: Wed, 7 Jan 2026 18:54:02 +0530
Message-ID: <20260107132408.3904352-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107132408.3904352-1-rkannoth@marvell.com>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FokIPmrq c=1 sm=1 tr=0 ts=695e5e8e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=xXrhxGPyklmKcrYTpSYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: DBDy9bAu-jqaeyo8_8hiVBT0XWbbW-FA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX/fcR6jNyKDsP
 83IORqjdNMYSL1whTYIPxc2/TXA/tDQshWGF4DgsBMOQsRYvLBqPIMtWqhFcqgeeH1kWPsnYMFm
 qShTrcZsC0/jyw2qUGUsHonjdM3hW4vcCwySizapEVfMCOVGfiDUHkCGZSz58ROwQ5WWGeYKiDU
 Xxo3eyBD6MI/gC8+pIw3VmiQhKmOquElvTRIpn/u3J39rUuPYfswh61mCl+tLoLboAVyVlMjUWA
 1gIcnObkR+JtVkKJJWD04sePskgtE3LJYFfrJATjImt96UO0xMCmXu9rBMZGY9N1nR+afMq8rVS
 ByorjPsCdQrDDapqK+Tzn8naY2CJEO8pWZBcphoHhWVethkJaT7jgRNjRMfiLNzWXtJ4t59WZ+C
 4kKJrDkZFu8aX6ME4NqQTWqFZPmwMu7/3/t4+CWAingfYUxuWL/EBIUMWH4QVD3xsttNkok88Ij
 qzyKIEUha9cK5PHigzg==
X-Proofpoint-ORIG-GUID: DBDy9bAu-jqaeyo8_8hiVBT0XWbbW-FA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

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


