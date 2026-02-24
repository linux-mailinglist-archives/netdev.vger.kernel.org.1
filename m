Return-Path: <netdev+bounces-260389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJv0ImhcnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43431836CF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3A0318F928
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E334B683;
	Tue, 24 Feb 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lv7c4k1j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DB2853F8;
	Tue, 24 Feb 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920102; cv=none; b=Gv/0Y57pszT3XUB/3hton3wVWUkjh8ZeAYswyCIYNxIISpNgL+eclHPSgNWxHxL/FhdW0SrN0SjuRFrKXr6C7hqmI/HIxq4W+FZj/l7EtkjKDAvyYWXLAjmZOjRS0usgG/HbVG/pq80tV2ZfsLeAmeqRld+0Jc9EkMO7CMH2Mr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920102; c=relaxed/simple;
	bh=ecnXec5Xj9HRRGZMnW5hy0fTOdPyFcRlq0YEndgoESs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlvLaHrWFP7Yp+V7HjAFJSlRCZz07VEiXvBI6j3jp8OMxDS275okgVdszsC0At/L0MgUclmJ1b6h7ULRBqlw2gr3vfXERfpAfrv8F/Dc5xfS4HbKIZHqZ3tGHX7j5qiw8ShOuaDS0beQ7nQ1yh1CzyCNC05O1wIqeteVwNrZgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lv7c4k1j; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHMfgn2182532;
	Tue, 24 Feb 2026 00:01:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	jcr9FSA0NAQpvKDfnMxt3g+BgVvvKGlt05xNRKjOtc=; b=Lv7c4k1j/Jmxbz0N8
	bvO6UzOaaSXNkaejzNHqpNJBaRLFwbX4lQrbfMKyiMh4ehGHqmi6VkpIVb14zFw3
	hr1Orp5b32ACMo+ODVE52cg76LcXtTbeo3UjN2JFoiBL6k/ciJZhJdP9+ix87zFr
	uqBouw52O6fVE12NnpiW6Yf9UW5iShJguG7BnL7IhZAuUNRdjNUmhl5Zg8Kl8btJ
	0N2pJzbQHd62NoMzTch2idjSPc+r5HwXtNWisFTCY481c3CZl6P1GWFelItF2s4f
	2vie3sDPoMr13yHOseRUDwTrM69iJ+CsUcITGHVt7WbFraUKkJQqY0iwJiPAkzRC
	o2Uug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cfd3gwata-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:01:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 00:01:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 00:01:29 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8559F3F7075;
	Tue, 24 Feb 2026 00:01:25 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v9 10/13] octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
Date: Tue, 24 Feb 2026 13:30:06 +0530
Message-ID: <20260224080009.4147301-11-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FJL-eZI-jwHk_V6YPBihKBe-YoTn5niP
X-Proofpoint-GUID: FJL-eZI-jwHk_V6YPBihKBe-YoTn5niP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfXzphSZY32kc5D
 B2JVqSeJFs7fbmQJpue3RPNrhu62vAlBK6wZoM40ajGwbtwXBCLy8sai1KmDRiY0jgKDADdhxDM
 jTXeB5Ij3XY7ei9tjGw6dbS722B6rwrzybvKPq8goXPV8D8owjwi2GryY+v+IShKCfTuRoPyvgL
 k5NVLo1eS9GGNmXMECc3Dw59qC2h/XFzbZQ2aKgAzZw6j2J7q4i0n60LVfX6jbRqFrA0YN7Sfbe
 YC4zwbzvt5SF/mBYkrXoK0Aw/2Xmmq5CneKQu3s9fBmC4QaUS9xWANpG6RIX3xZ9VXyOzTzFt1W
 9vseyL+Lm3g3m7/ZncxzN/Z+UTV7putKd8vpt1/+yBL7ip5ejkQOEG0b5Y0GjUKjtYVqfSgMZ1D
 MMyWcZnt7PWfjdTgAEC+lVnjPVtAe82CzgHdc2c7yMkA97+dH2qMiX2+GxHALW43tFugUjjmjWP
 HnfXNh9eraXQD80NFUA==
X-Authority-Analysis: v=2.4 cv=H5XWAuYi c=1 sm=1 tr=0 ts=699d5adb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=R86mbzlVWIuRp1_vrRQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260389-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E43431836CF
X-Rspamd-Action: no action

In CN20K, the PF/VF driver is unaware of the NPC MCAM entry type (x2/x4)
required for a particular TC rule when the user installs rules through the
TC command. This forces the PF/VF driver to first query the AF driver for
the rule size, then allocate an entry, and finally install the flow. This
sequence requires three mailbox request/response exchanges from the PF. To
speed up the installation, the `install_flow` mailbox request message is
extended with additional fields that allow the AF driver to determine the
required NPC MCAM entry type, allocate the MCAM entry, and complete the
flow installation in a single step.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 189 +++++++++++--
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   5 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  48 ++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |   4 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 137 ++++++++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |  12 +
 .../marvell/octeontx2/nic/otx2_flows.c        | 265 +++++++++++++++++-
 7 files changed, 603 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index acd065f44efa..63a287ee8f70 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -14,6 +14,7 @@
 #include "rvu_npc.h"
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
+#include "rvu_npc_fs.h"
 
 static struct npc_priv_t npc_priv = {
 	.num_banks = MAX_NUM_BANKS,
@@ -812,7 +813,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		cfg = rvu_read64(rvu, blkaddr,
 				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx,
 								   bank));
-		hw_prio = cfg & GENMASK_ULL(14, 8);
+		hw_prio = cfg & GENMASK_ULL(30, 24);
 		cfg = enable ? 1 : 0;
 		cfg |= hw_prio;
 		rvu_write64(rvu, blkaddr,
@@ -828,7 +829,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		cfg = rvu_read64(rvu, blkaddr,
 				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx,
 								   bank));
-		hw_prio = cfg & GENMASK_ULL(14, 8);
+		hw_prio = cfg & GENMASK_ULL(30, 24);
 		cfg = enable ? 1 : 0;
 		cfg |= hw_prio;
 		rvu_write64(rvu, blkaddr,
@@ -895,25 +896,33 @@ static void npc_cn20k_get_keyword(struct cn20k_mcam_entry *entry, int idx,
 	*cam0 = ~*cam1 & kw_mask;
 }
 
-/*-----------------------------------------------------------------------------|
- *Kex type  |  mcam entry   |  cam1	   |	cam 0	|| <----- output ----> |
- *profile   |  len	    | (key type)   | (key type)	|| len	  |   type     |
- *-----------------------------------------------------------------------------|
- *X2	    |  256 (X2)	    |  001b	   |	110b	|| X2	  |    X2      |
- *-----------------------------------------------------------------------------|
- *X4	    |  256 (X2)	    |  000b	   |	000b	|| X2	  |  DYNAMIC   |
- *-----------------------------------------------------------------------------|
- *X4	    |  512 (X4)	    |  010b	   |	101b	|| X4	  |    X4      |
- *-----------------------------------------------------------------------------|
- *DYN	    |  256 (X2)	    |  000b	   |	000b	|| X2	  |  DYNAMIC   |
- *-----------------------------------------------------------------------------|
- *DYN	    |  512 (X4)	    |  010b	   |	101b	|| X4	  |    X4      |
- *-----------------------------------------------------------------------------|
+/*-------------------------------------------------------------------------
+ *Kex type|  mcam	|  cam1	|cam0   | req_kwtype||<----- output >	  |
+ * in     |		|	|	|	    ||		|	  |
+ * profile|  len	|	|	|	    ||len	| type    |
+ *-------------------------------------------------------------------------
+ *X2	|  256 (X2)	|  001b	|110b	| 0	    ||X2	| X2      |
+ *------------------------------------------------------------------------|
+ *X4	|  256 (X2)	|  000b	|000b	| 0	    ||X2	| DYN     |
+ *------------------------------------------------------------------------|
+ *X4	|  512 (X4)	|  010b	|101b	| 0	    ||X4	| X4      |
+ *------------------------------------------------------------------------|
+ *DYN	|  256 (X2)	|  000b	|000b	| 0	    ||X2	| DYN     |
+ *------------------------------------------------------------------------|
+ *DYN	|  512 (X4)	|  010b	|101b	| 0	    ||X4	| X4      |
+ *------------------------------------------------------------------------|
+ *X4	|  256 (X2)	|  000b	|000b	| X2	    ||DYN	| DYN     |
+ *------------------------------------------------------------------------|
+ *DYNC	|  256 (X2)	|  000b	|000b	| X2	    ||DYN	| DYN     |
+ *------------------------------------------------------------------------|
+ * X2	|  512 (X4)	|  xxxb	|xxxb	| X4	    ||INVAL	| INVAL   |
+ *------------------------------------------------------------------------|
  */
 static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
 				   struct cn20k_mcam_entry *entry,
-				   int bank, u8 kw_type, int kw)
+				   int bank, u8 kw_type, int kw,
+				   u8 req_kw_type)
 {
 	u64 intf_ext = 0, intf_ext_mask = 0;
 	u8 tx_intf_mask = ~intf & 0x3;
@@ -938,6 +947,15 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 		kw_type_mask = 0;
 	}
 
+	/* Say, we need to write x2 keyword in an x4 subbank.
+	 * req_kw_type will be x2, and kw_type will be x4.
+	 * So in the case ignore kw bits in mcam.
+	 */
+	if (kw_type == NPC_MCAM_KEY_X4 && req_kw_type == NPC_MCAM_KEY_X2) {
+		kw_type = 0;
+		kw_type_mask = 0;
+	}
+
 	intf_ext = ((u64)kw_type << 16) | tx_intf;
 	intf_ext_mask = (((u64)kw_type_mask  << 16) & GENMASK_ULL(18, 16)) |
 		tx_intf_mask;
@@ -985,14 +1003,15 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
 				   struct cn20k_mcam_entry *entry,
-				   u8 kw_type)
+				   u8 kw_type, u8 req_kw_type)
 {
 	int kw = 0, bank;
 
 	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4)
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       index, intf,
-				       entry, bank, kw_type, kw);
+				       entry, bank, kw_type,
+				       kw, req_kw_type);
 }
 
 static void
@@ -1002,7 +1021,7 @@ npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u64 bank_cfg;
 
-	bank_cfg = (u64)hw_prio << 8;
+	bank_cfg = (u64)hw_prio << 24;
 	if (enable)
 		bank_cfg |= 0x1;
 
@@ -1025,7 +1044,7 @@ npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
 
 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 				 u8 intf, struct cn20k_mcam_entry *entry,
-				 bool enable, u8 hw_prio)
+				 bool enable, u8 hw_prio, u8 req_kw_type)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
@@ -1048,27 +1067,34 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 		npc_cn20k_clear_mcam_entry(rvu, blkaddr, bank, mcam_idx);
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       mcam_idx, intf, entry,
-				       bank, kw_type, kw);
+				       bank, kw_type, kw, req_kw_type);
 		/* Set 'action' */
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 0),
 			    entry->action);
 
+		/* Set 'action2' for inline receive */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+								  bank, 2),
+			    entry->action2);
+
 		/* Set TAG 'action' */
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 1),
 			    entry->vtag_action);
-
 		goto set_cfg;
 	}
+
 	/* Clear mcam entry to avoid writes being suppressed by NPC */
 	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 0, mcam_idx);
 	npc_cn20k_clear_mcam_entry(rvu, blkaddr, 1, mcam_idx);
 
 	npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
-			       mcam_idx, intf, entry, kw_type);
+			       mcam_idx, intf, entry,
+			       kw_type, req_kw_type);
 	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
 		/* Set 'action' */
 		rvu_write64(rvu, blkaddr,
@@ -1081,6 +1107,12 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
 								  bank, 1),
 			    entry->vtag_action);
+
+		/* Set 'action2' for inline receive */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
+								  bank, 2),
+			    entry->action2);
 	}
 
 set_cfg:
@@ -1169,7 +1201,7 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	bank_cfg = rvu_read64(rvu, blkaddr,
 			      NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(index, bank));
 	*ena = bank_cfg & 0x1;
-	*hw_prio = (bank_cfg & GENMASK_ULL(14, 8)) >> 8;
+	*hw_prio = (bank_cfg & GENMASK_ULL(30, 24)) >> 24;
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		cam1 = rvu_read64(rvu, blkaddr,
 				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index,
@@ -1305,7 +1337,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
 
 	npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
 				    &req->entry_data, req->enable_entry,
-				    req->hw_prio);
+				    req->hw_prio, req->req_kw_type);
 
 	rc = 0;
 exit:
@@ -1385,7 +1417,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 
 	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
 				    &req->entry_data, req->enable_entry,
-				    req->hw_prio);
+				    req->hw_prio, req->req_kw_type);
 
 	mutex_unlock(&mcam->lock);
 
@@ -1393,6 +1425,14 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	return 0;
 }
 
+static int rvu_npc_get_base_steer_rule_type(struct rvu *rvu, u16 pcifunc)
+{
+	if (is_lbk_vf(rvu, pcifunc))
+		return NIXLF_PROMISC_ENTRY;
+
+	return NIXLF_UCAST_ENTRY;
+}
+
 int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 						    struct msg_req *req,
 						    struct npc_cn20k_mcam_read_base_rule_rsp *rsp)
@@ -1402,6 +1442,7 @@ int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	u8 intf, enable, hw_prio;
 	struct rvu_pfvf *pfvf;
+	int rl_type;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
@@ -1427,9 +1468,16 @@ int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 		mutex_unlock(&mcam->lock);
 		goto out;
 	}
+
+	rl_type = rvu_npc_get_base_steer_rule_type(rvu, pcifunc);
+
 	/* Read the default ucast entry if there is no pkt steering rule */
-	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
-					 NIXLF_UCAST_ENTRY);
+	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf, rl_type);
+	if (index < 0) {
+		mutex_unlock(&mcam->lock);
+		goto out;
+	}
+
 read_entry:
 	/* Read the mcam entry */
 	npc_cn20k_read_mcam_entry(rvu, blkaddr, index,
@@ -3953,6 +4001,89 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 	return  set ? 0 : -ESRCH;
 }
 
+int rvu_mbox_handler_npc_get_pfl_info(struct rvu *rvu, struct msg_req *req,
+				      struct npc_get_pfl_info_rsp *rsp)
+{
+	if (!is_cn20k(rvu->pdev)) {
+		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
+		return -EOPNOTSUPP;
+	}
+
+	rsp->kw_type = npc_priv.kw;
+	rsp->x4_slots = npc_priv.bank_depth;
+	return 0;
+}
+
+int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
+				     struct npc_get_num_kws_req *req,
+				     struct npc_get_num_kws_rsp *rsp)
+{
+	struct rvu_npc_mcam_rule dummy = { 0 };
+	struct cn20k_mcam_entry cn20k_entry = { 0 };
+	struct mcam_entry_mdata mdata = { };
+	struct mcam_entry entry = { 0 };
+	struct npc_install_flow_req *fl;
+	int i, cnt = 0, blkaddr;
+
+	if (!is_cn20k(rvu->pdev)) {
+		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
+		return -EOPNOTSUPP;
+	}
+
+	fl = &req->fl;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0) {
+		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
+		return NPC_MCAM_INVALID_REQ;
+	}
+
+	npc_populate_mcam_mdata(rvu, &mdata, &cn20k_entry, &entry);
+
+	npc_update_flow(rvu, &mdata, fl->features, &fl->packet,
+			&fl->mask, &dummy, fl->intf, blkaddr);
+
+	/* Find the most significant word valid. Traverse from
+	 * MSB to LSB, check if cam0 or cam1 is set
+	 */
+	for (i = NPC_CN20K_MAX_KWS_IN_KEY - 1; i >= 0; i--) {
+		if (cn20k_entry.kw[i] || cn20k_entry.kw_mask[i]) {
+			cnt = i + 1;
+			break;
+		}
+	}
+
+	rsp->kws = cnt;
+
+	return 0;
+}
+
+int rvu_mbox_handler_npc_get_dft_rl_idxs(struct rvu *rvu, struct msg_req *req,
+					 struct npc_get_dft_rl_idxs_rsp *rsp)
+{
+	u16 bcast, mcast, promisc, ucast;
+	u16 pcifunc;
+	int rc;
+
+	if (!is_cn20k(rvu->pdev)) {
+		dev_err(rvu->dev, "Mbox support is only for cn20k\n");
+		return -EOPNOTSUPP;
+	}
+
+	pcifunc = req->hdr.pcifunc;
+
+	rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &bcast, &mcast,
+					 &promisc, &ucast);
+	if (rc)
+		return rc;
+
+	rsp->bcast = bcast;
+	rsp->mcast = mcast;
+	rsp->promisc = promisc;
+	rsp->ucast = ucast;
+	return 0;
+}
+
 static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
 {
 	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index f3c01b46c58c..815d0b257a7e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -321,9 +321,8 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast);
 
 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
-				 u8 intf,
-				 struct cn20k_mcam_entry *entry,
-				 bool enable, u8 hw_prio);
+				 u8 intf, struct cn20k_mcam_entry *entry,
+				 bool enable, u8 hw_prio, u8 req_kw_type);
 void npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 				 int index, bool enable);
 void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 1638bf4e15fd..79cb1c752c2b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -301,6 +301,15 @@ M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601a, npc_cn20k_read_base_steer_rule,       \
 M(NPC_MCAM_DEFRAG,	     0x601b,	npc_defrag,			\
 					msg_req,			\
 					msg_rsp)			\
+M(NPC_MCAM_GET_NUM_KWS, 0x601c, npc_get_num_kws,		\
+				npc_get_num_kws_req,		\
+				npc_get_num_kws_rsp)		\
+M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601d, npc_get_dft_rl_idxs,	\
+					msg_req,		\
+					npc_get_dft_rl_idxs_rsp)\
+M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601e, npc_get_pfl_info,		\
+					msg_req,		\
+					npc_get_pfl_info_rsp)	\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1598,6 +1607,7 @@ struct cn20k_mcam_entry {
 	u64	kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
 	u64	action;
 	u64	vtag_action;
+	u64	action2;
 };
 
 struct npc_cn20k_mcam_write_entry_req {
@@ -1608,6 +1618,7 @@ struct npc_cn20k_mcam_write_entry_req {
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u8  req_kw_type; /* Type of kw which should be written */
 	u64 reserved;	 /* reserved for future use */
 };
 
@@ -1694,6 +1705,7 @@ struct npc_cn20k_mcam_alloc_and_write_entry_req {
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  hw_prio;	 /* hardware priority, valid for cn20k */
 	u8  virt;	 /* Allocate virtual index */
+	u8  req_kw_type; /* Key type to be written */
 	u16 reserved[4]; /* reserved for future use */
 };
 
@@ -1861,11 +1873,47 @@ struct npc_install_flow_req {
 	/* old counter value */
 	u16 cntr_val;
 	u8 hw_prio;
+	u8  req_kw_type; /* Key type to be written */
+	u8 alloc_entry;	/* only for cn20k */
+	u16 ref_prio;
+	u16 ref_entry;
 };
 
 struct npc_install_flow_rsp {
 	struct mbox_msghdr hdr;
 	int counter; /* negative if no counter else counter number */
+	u16 entry;
+	u8 kw_type;
+};
+
+struct npc_get_num_kws_req {
+	struct mbox_msghdr hdr;
+	struct npc_install_flow_req fl;
+	u32 rsvd[4];
+};
+
+struct npc_get_num_kws_rsp {
+	struct mbox_msghdr hdr;
+	int kws;
+	u32 rsvd[4];
+};
+
+struct npc_get_dft_rl_idxs_rsp {
+	struct mbox_msghdr hdr;
+	u16 bcast;
+	u16 mcast;
+	u16 promisc;
+	u16 ucast;
+	u16 vf_ucast;
+	u16 rsvd[7];
+};
+
+struct npc_get_pfl_info_rsp {
+	struct mbox_msghdr hdr;
+	u16 x4_slots;
+	u8 kw_type;
+	u8 rsvd1[3];
+	u32 rsvd2[4];
 };
 
 struct npc_delete_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 38a84c122465..c2ca5ed1d028 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2690,6 +2690,10 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	if (!is_cn20k(rvu->pdev))
 		goto not_cn20k;
 
+	/* Only x2 or x4 key types are accepted */
+	if (req->kw_type != NPC_MCAM_KEY_X2 && req->kw_type != NPC_MCAM_KEY_X4)
+		return NPC_MCAM_INVALID_REQ;
+
 	/* The below table is being followed during allocation,
 	 *
 	 * 1. ref_entry == 0 && prio == HIGH && count == 1 : user wants to
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index bff190ba95e2..5cee425f86b1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1071,11 +1071,11 @@ static void npc_update_vlan_features(struct rvu *rvu,
 				 ~0ULL, 0, intf);
 }
 
-static void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
-			    u64 features, struct flow_msg *pkt,
-			    struct flow_msg *mask,
-			    struct rvu_npc_mcam_rule *output, u8 intf,
-			    int blkaddr)
+void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
+		     u64 features, struct flow_msg *pkt,
+		     struct flow_msg *mask,
+		     struct rvu_npc_mcam_rule *output, u8 intf,
+		     int blkaddr)
 {
 	u64 dmac_mask = ether_addr_to_u64(mask->dmac);
 	u64 smac_mask = ether_addr_to_u64(mask->smac);
@@ -1304,7 +1304,7 @@ static int npc_mcast_update_action_index(struct rvu *rvu, struct npc_install_flo
 	return 0;
 }
 
-static void
+void
 npc_populate_mcam_mdata(struct rvu *rvu,
 			struct mcam_entry_mdata *mdata,
 			struct cn20k_mcam_entry *cn20k_entry,
@@ -1549,6 +1549,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	cn20k_wreq.intf = req->intf;
 	cn20k_wreq.enable_entry = (u8)enable;
 	cn20k_wreq.hw_prio = req->hw_prio;
+	cn20k_wreq.req_kw_type = req->req_kw_type;
 
 update_rule:
 
@@ -1642,6 +1643,79 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	return 0;
 }
 
+static int
+rvu_npc_free_entry_for_flow_install(struct rvu *rvu, u16 pcifunc,
+				    bool free_entry, int mcam_idx)
+{
+	struct npc_mcam_free_entry_req free_req = { 0 };
+	struct msg_rsp rsp;
+	int rc;
+
+	if (!free_entry)
+		return 0;
+
+	free_req.hdr.pcifunc = pcifunc;
+	free_req.entry = mcam_idx;
+	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
+	return rc;
+}
+
+static int
+rvu_npc_alloc_entry_for_flow_install(struct rvu *rvu,
+				     struct npc_install_flow_req *fl_req,
+				     u16 *mcam_idx, u8 *kw_type,
+				     bool *allocated)
+{
+	struct npc_mcam_alloc_entry_req entry_req;
+	struct npc_mcam_alloc_entry_rsp entry_rsp;
+	struct npc_get_num_kws_req kws_req;
+	struct npc_get_num_kws_rsp kws_rsp;
+	int off, kw_bits, rc;
+	u8 *src, *dst;
+
+	if (!is_cn20k(rvu->pdev)) {
+		*kw_type = -1;
+		return 0;
+	}
+
+	if (!fl_req->alloc_entry) {
+		*kw_type = -1;
+		return 0;
+	}
+
+	off = offsetof(struct npc_install_flow_req, packet);
+	dst = (u8 *)&kws_req.fl + off;
+	src = (u8 *)fl_req + off;
+	memcpy(dst, src, sizeof(struct npc_install_flow_req) - off);
+	rc = rvu_mbox_handler_npc_get_num_kws(rvu, &kws_req, &kws_rsp);
+	if (rc)
+		return rc;
+
+	kw_bits = kws_rsp.kws * 64;
+
+	*kw_type = NPC_MCAM_KEY_X2;
+	if (kw_bits > 256)
+		*kw_type = NPC_MCAM_KEY_X4;
+
+	memset(&entry_req, 0, sizeof(entry_req));
+	memset(&entry_rsp, 0, sizeof(entry_rsp));
+
+	entry_req.hdr.pcifunc = fl_req->hdr.pcifunc;
+	entry_req.ref_prio = fl_req->ref_prio;
+	entry_req.ref_entry = fl_req->ref_entry;
+	entry_req.kw_type = *kw_type;
+	entry_req.count = 1;
+	rc = rvu_mbox_handler_npc_mcam_alloc_entry(rvu,
+						   &entry_req,
+						   &entry_rsp);
+	if (rc)
+		return rc;
+
+	*mcam_idx = entry_rsp.entry_list[0];
+	*allocated = true;
+	return 0;
+}
+
 int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 				      struct npc_install_flow_req *req,
 				      struct npc_install_flow_rsp *rsp)
@@ -1652,11 +1726,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	int blkaddr, nixlf, err;
 	struct rvu_pfvf *pfvf;
 	bool pf_set_vfs_mac = false;
+	bool allocated = false;
 	bool enable = true;
+	u8 kw_type;
 	u16 target;
 
-	req->entry = npc_cn20k_vidx2idx(req->entry);
-
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
 		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
@@ -1666,6 +1740,17 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	if (!is_npc_interface_valid(rvu, req->intf))
 		return NPC_FLOW_INTF_INVALID;
 
+	err = rvu_npc_alloc_entry_for_flow_install(rvu, req, &req->entry,
+						   &kw_type, &allocated);
+	if (err) {
+		dev_err(rvu->dev,
+			"%s: Error to alloc mcam entry for pcifunc=%#x\n",
+			__func__, req->hdr.pcifunc);
+		return err;
+	}
+
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	/* If DMAC is not extracted in MKEX, rules installed by AF
 	 * can rely on L2MB bit set by hardware protocol checker for
 	 * broadcast and multicast addresses.
@@ -1679,6 +1764,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 			dev_warn(rvu->dev,
 				 "%s: mkex profile does not support ucast flow\n",
 				 __func__);
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
 			return NPC_FLOW_NOT_SUPPORTED;
 		}
 
@@ -1686,6 +1775,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 			dev_warn(rvu->dev,
 				 "%s: mkex profile does not support bcast/mcast flow",
 				 __func__);
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
 			return NPC_FLOW_NOT_SUPPORTED;
 		}
 
@@ -1695,8 +1788,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	}
 
 process_flow:
-	if (from_vf && req->default_rule)
+	if (from_vf && req->default_rule) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_VF_PERM_DENIED;
+	}
 
 	/* Each PF/VF info is maintained in struct rvu_pfvf.
 	 * rvu_pfvf for the target PF/VF needs to be retrieved
@@ -1724,8 +1820,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		req->chan_mask = 0xFFF;
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
-	if (err)
+	if (err) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_NOT_SUPPORTED;
+	}
 
 	pfvf = rvu_get_pfvf(rvu, target);
 
@@ -1744,8 +1843,11 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	/* Proceed if NIXLF is attached or not for TX rules */
 	err = nix_get_nixlf(rvu, target, &nixlf, NULL);
-	if (err && is_npc_intf_rx(req->intf) && !pf_set_vfs_mac)
+	if (err && is_npc_intf_rx(req->intf) && !pf_set_vfs_mac) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_NO_NIXLF;
+	}
 
 	/* don't enable rule when nixlf not attached or initialized */
 	if (!(is_nixlf_attached(rvu, target) &&
@@ -1760,20 +1862,31 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		enable = true;
 
 	/* Do not allow requests from uninitialized VFs */
-	if (from_vf && !enable)
+	if (from_vf && !enable) {
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return NPC_FLOW_VF_NOT_INIT;
+	}
 
 	/* PF sets VF mac & VF NIXLF is not attached, update the mac addr */
 	if (pf_set_vfs_mac && !enable) {
 		ether_addr_copy(pfvf->default_mac, req->packet.dmac);
 		ether_addr_copy(pfvf->mac_addr, req->packet.dmac);
 		set_bit(PF_SET_VF_MAC, &pfvf->flags);
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
 		return 0;
 	}
 
 	mutex_lock(&rswitch->switch_lock);
 	err = npc_install_flow(rvu, blkaddr, target, nixlf, pfvf,
 			       req, rsp, enable, pf_set_vfs_mac);
+	if (err)
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
+
+	rsp->kw_type = kw_type;
+	rsp->entry = req->entry;
 	mutex_unlock(&rswitch->switch_lock);
 
 	return err;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
index 442287ee7baa..d3ba86c23959 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h
@@ -18,4 +18,16 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf);
 
+void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
+		     u64 features, struct flow_msg *pkt,
+		     struct flow_msg *mask,
+		     struct rvu_npc_mcam_rule *output, u8 intf,
+		     int blkaddr);
+
+void
+npc_populate_mcam_mdata(struct rvu *rvu,
+			struct mcam_entry_mdata *mdata,
+			struct cn20k_mcam_entry *cn20k_entry,
+			struct mcam_entry *entry);
+
 #endif /* RVU_NPC_FS_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 052d989f2d9a..66c1a97a185d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -37,6 +37,98 @@ static void otx2_clear_ntuple_flow_info(struct otx2_nic *pfvf, struct otx2_flow_
 	flow_cfg->max_flows = 0;
 }
 
+static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
+				  u16 *x4_slots)
+{
+	struct npc_get_pfl_info_rsp *rsp;
+	struct msg_req *req;
+	static struct {
+		bool is_set;
+		bool is_x2;
+		u16 x4_slots;
+	} pfl_info;
+
+	/* Avoid sending mboxes for constant information
+	 * like x4_slots
+	 */
+	mutex_lock(&pfvf->mbox.lock);
+	if (pfl_info.is_set) {
+		*is_x2 = pfl_info.is_x2;
+		*x4_slots = pfl_info.x4_slots;
+		mutex_unlock(&pfvf->mbox.lock);
+		return 0;
+	}
+
+	req = otx2_mbox_alloc_msg_npc_get_pfl_info(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	/* Send message to AF */
+	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	rsp = (struct npc_get_pfl_info_rsp *)otx2_mbox_get_rsp
+		(&pfvf->mbox.mbox, 0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	*is_x2 = (rsp->kw_type == NPC_MCAM_KEY_X2);
+	if (*is_x2)
+		*x4_slots = 0;
+	else
+		*x4_slots = rsp->x4_slots;
+
+	pfl_info.is_x2 = *is_x2;
+	pfl_info.x4_slots = *x4_slots;
+	pfl_info.is_set = true;
+
+	mutex_unlock(&pfvf->mbox.lock);
+	return 0;
+}
+
+static int otx2_get_dft_rl_idx(struct otx2_nic *pfvf, u16 *mcam_idx)
+{
+	struct npc_get_dft_rl_idxs_rsp *rsp;
+	struct msg_req *req;
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_get_dft_rl_idxs(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	/* Send message to AF */
+	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EINVAL;
+	}
+
+	rsp = (struct npc_get_dft_rl_idxs_rsp *)otx2_mbox_get_rsp
+		(&pfvf->mbox.mbox, 0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	if (is_otx2_lbkvf(pfvf->pdev))
+		*mcam_idx = rsp->promisc;
+	else
+		*mcam_idx = rsp->ucast;
+
+	mutex_unlock(&pfvf->mbox.lock);
+	return 0;
+}
+
 static int otx2_free_ntuple_mcam_entries(struct otx2_nic *pfvf)
 {
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
@@ -69,7 +161,10 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
 	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
-	int ent, allocated = 0;
+	u16 dft_idx = 0, x4_slots = 0;
+	int ent, allocated = 0, ref;
+	bool is_x2 = false;
+	int rc;
 
 	/* Free current ones and allocate new ones with requested count */
 	otx2_free_ntuple_mcam_entries(pfvf);
@@ -86,6 +181,22 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		return -ENOMEM;
 	}
 
+	if (is_cn20k(pfvf->pdev)) {
+		rc = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		if (rc) {
+			netdev_err(pfvf->netdev, "Error to retrieve profile info\n");
+			return rc;
+		}
+
+		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
+		if (rc) {
+			netdev_err(pfvf->netdev,
+				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
+				   pfvf->pcifunc);
+			return rc;
+		}
+	}
+
 	mutex_lock(&pfvf->mbox.lock);
 
 	/* In a single request a max of NPC_MAX_NONCONTIG_ENTRIES MCAM entries
@@ -96,18 +207,31 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		if (!req)
 			goto exit;
 
+		req->kw_type = is_x2 ? NPC_MCAM_KEY_X2 : NPC_MCAM_KEY_X4;
 		req->contig = false;
 		req->count = (count - allocated) > NPC_MAX_NONCONTIG_ENTRIES ?
 				NPC_MAX_NONCONTIG_ENTRIES : count - allocated;
 
+		ref = 0;
+
+		if (is_cn20k(pfvf->pdev)) {
+			req->ref_prio = NPC_MCAM_HIGHER_PRIO;
+			ref = dft_idx;
+		}
+
 		/* Allocate higher priority entries for PFs, so that VF's entries
 		 * will be on top of PF.
 		 */
 		if (!is_otx2_vf(pfvf->pcifunc)) {
 			req->ref_prio = NPC_MCAM_HIGHER_PRIO;
-			req->ref_entry = flow_cfg->def_ent[0];
+			ref = flow_cfg->def_ent[0];
 		}
 
+		if (is_cn20k(pfvf->pdev))
+			ref = is_x2 ? ref : ref & (x4_slots - 1);
+
+		req->ref_entry = ref;
+
 		/* Send message to AF */
 		if (otx2_sync_mbox_msg(&pfvf->mbox))
 			goto exit;
@@ -163,8 +287,24 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	struct npc_get_field_status_rsp *frsp;
 	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
-	int vf_vlan_max_flows;
-	int ent, count;
+	int vf_vlan_max_flows, count;
+	int rc, ref, prio, ent;
+	u16 dft_idx;
+
+	ref = 0;
+	prio = 0;
+	if (is_cn20k(pfvf->pdev)) {
+		rc = otx2_get_dft_rl_idx(pfvf, &dft_idx);
+		if (rc) {
+			netdev_err(pfvf->netdev,
+				   "Error to retrieve ucast mcam idx for pcifunc %#x\n",
+				   pfvf->pcifunc);
+			return rc;
+		}
+
+		ref = dft_idx;
+		prio = NPC_MCAM_HIGHER_PRIO;
+	}
 
 	vf_vlan_max_flows = pfvf->total_vfs * OTX2_PER_VF_VLAN_FLOWS;
 	count = flow_cfg->ucast_flt_cnt +
@@ -183,8 +323,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 		return -ENOMEM;
 	}
 
+	req->kw_type = NPC_MCAM_KEY_X2;
 	req->contig = false;
 	req->count = count;
+	req->ref_prio = prio;
+	req->ref_entry = ref;
 
 	/* Send message to AF */
 	if (otx2_sync_mbox_msg(&pfvf->mbox)) {
@@ -819,7 +962,7 @@ static int otx2_prepare_ipv6_flow(struct ethtool_rx_flow_spec *fsp,
 }
 
 static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
-			      struct npc_install_flow_req *req)
+				     struct npc_install_flow_req *req)
 {
 	struct ethhdr *eth_mask = &fsp->m_u.ether_spec;
 	struct ethhdr *eth_hdr = &fsp->h_u.ether_spec;
@@ -945,6 +1088,58 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 	return 0;
 }
 
+static int otx2_get_kw_type(struct otx2_nic *pfvf,
+			    struct npc_install_flow_req *fl_req,
+			    u8 *kw_type)
+{
+	struct npc_get_num_kws_req *req;
+	struct npc_get_num_kws_rsp *rsp;
+	u8 *src, *dst;
+	int off, err;
+	int kw_bits;
+
+	off = offsetof(struct npc_install_flow_req, packet);
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_get_num_kws(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	dst = (u8 *)&req->fl + off;
+	src = (u8 *)fl_req + off;
+
+	memcpy(dst, src, sizeof(struct npc_install_flow_req) - off);
+
+	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	if (err)  {
+		mutex_unlock(&pfvf->mbox.lock);
+		netdev_err(pfvf->netdev,
+			   "Error to get default number of keywords\n");
+		return err;
+	}
+
+	rsp = (struct npc_get_num_kws_rsp *)otx2_mbox_get_rsp
+		(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -EFAULT;
+	}
+
+	kw_bits = rsp->kws * 64;
+
+	if (kw_bits <= 256)
+		*kw_type = NPC_MCAM_KEY_X2;
+	else
+		*kw_type = NPC_MCAM_KEY_X4;
+
+	mutex_unlock(&pfvf->mbox.lock);
+
+	return 0;
+}
+
 static int otx2_is_flow_rule_dmacfilter(struct otx2_nic *pfvf,
 					struct ethtool_rx_flow_spec *fsp)
 {
@@ -973,12 +1168,41 @@ static int otx2_is_flow_rule_dmacfilter(struct otx2_nic *pfvf,
 
 static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 {
+	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
+	struct npc_install_flow_req *req, treq = { 0 };
 	u64 ring_cookie = flow->flow_spec.ring_cookie;
 #ifdef CONFIG_DCB
 	int vlan_prio, qidx, pfc_rule = 0;
 #endif
-	struct npc_install_flow_req *req;
-	int err, vf = 0;
+	int err, vf = 0, off, sz;
+	bool modify = false;
+	u8 kw_type = 0;
+	u8 *src, *dst;
+	u16 x4_slots;
+	bool is_x2;
+
+	if (is_cn20k(pfvf->pdev)) {
+		err = otx2_mcam_pfl_info_get(pfvf, &is_x2, &x4_slots);
+		if (err) {
+			netdev_err(pfvf->netdev,
+				   "Error to retrieve NPC profile info, pcifunc=%#x\n",
+				   pfvf->pcifunc);
+			return -EFAULT;
+		}
+
+		if (!is_x2) {
+			err = otx2_prepare_flow_request(&flow->flow_spec,
+							&treq);
+			if (err)
+				return err;
+
+			err = otx2_get_kw_type(pfvf, &treq, &kw_type);
+			if (err)
+				return err;
+
+			modify = true;
+		}
+	}
 
 	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_npc_install_flow(&pfvf->mbox);
@@ -987,14 +1211,29 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 		return -ENOMEM;
 	}
 
-	err = otx2_prepare_flow_request(&flow->flow_spec, req);
-	if (err) {
-		/* free the allocated msg above */
-		otx2_mbox_reset(&pfvf->mbox.mbox, 0);
-		mutex_unlock(&pfvf->mbox.lock);
-		return err;
+	if (modify) {
+		off = offsetof(struct npc_install_flow_req, packet);
+		sz = sizeof(struct npc_install_flow_req) - off;
+		dst = (u8 *)req + off;
+		src = (u8 *)&treq + off;
+
+		memcpy(dst, src, sz);
+		req->req_kw_type = kw_type;
+	} else {
+		err = otx2_prepare_flow_request(&flow->flow_spec, req);
+		if (err) {
+			/* free the allocated msg above */
+			otx2_mbox_reset(&pfvf->mbox.mbox, 0);
+			mutex_unlock(&pfvf->mbox.lock);
+			return err;
+		}
 	}
 
+	netdev_dbg(pfvf->netdev,
+		   "flow entry (%u) installed at loc:%u kw_type=%u\n",
+		   flow_cfg->flow_ent[flow->location],
+		   flow->location, kw_type);
+
 	req->entry = flow->entry;
 	req->intf = NIX_INTF_RX;
 	req->set_cntr = 1;
-- 
2.43.0


