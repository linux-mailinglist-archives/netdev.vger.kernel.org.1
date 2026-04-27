Return-Path: <netdev+bounces-281223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMJKEagD72lz3QAAu9opvQ
	(envelope-from <netdev+bounces-281223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23246D997
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE4D3020A67
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0756371043;
	Mon, 27 Apr 2026 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dmw1/TRU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC013793BC;
	Mon, 27 Apr 2026 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271554; cv=none; b=Htnr/67ti3u39urReoP/h7IcEKCegCCZjOwkDPtRnQ99ihEDv4waMY0NSdV6PEbZ2MCQtpRwBH0Pd/jARRmbx3uQH2lCqr5iXaqxlljSG4xbdCiTKETOsO/1fid9bTMF64ZUOMkAJlq6qsV99ILBEMDJC9ytfXpqvOh6I0hJLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271554; c=relaxed/simple;
	bh=7/9UNUsSqnQSs6ZWXAUxzCuNH1IwgDwHC/7gGH7Ye2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPSzAxO7W1lRon2IFe/nW+wQnR6NOyuwYvllLpcXNUtYf26UB08aBlZBjeqsHF4HCuLNQ+1B5zK12zdvf69vq3CD9tVf2732VC6+dmuhD1kkORM+37LDTwWcPC0o0jw4kJQVyd5kKt1NqJ9RjvJWVi/BS41jxeNzZtb4so81rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dmw1/TRU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNlXbJ2712746;
	Sun, 26 Apr 2026 23:32:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	XE1DQv907gWYudwja/sxf9SoOgJ17iStMiEkfynJtY=; b=dmw1/TRU+M7FGUpCv
	vXi5KF8bolPlA60sbYoNdxHZDHAj3MNRhA1K3pAxr5B7xswk2EOuo/gPWXZ49js6
	Le3KN7VKsuCCrUYATpMIDNddThX6SbeB+HsGchvJnJk9QYOHX7KytSGM5G+LuF6E
	oOJCi/flLixaBlMSdlIGXHHd0qp97N6HQ0gUPhBw60kSdjkVMHKLAb/hDv1B+Gpu
	dvKYvuOrygpXN1gyKtPMAp2/C/i7RYJZuqS8e+oSWVjLtcXA09alcb6evGOBAdTW
	+Yi1hY5+nQsas1nAhj1u8ngwAG/9NL+k9+IdEezY/UMuYURoE5oYMv64szbt7uY7
	YPEqQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4drw4fjxqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:32:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 23:32:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 23:32:23 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 918973F70BB;
	Sun, 26 Apr 2026 23:32:19 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>, "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH v4 net 01/10] octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
Date: Mon, 27 Apr 2026 12:02:04 +0530
Message-ID: <20260427063213.3937451-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427063213.3937451-1-rkannoth@marvell.com>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Irv6-L9tXzqYS3qqV9VriAIFmEHAXkoM
X-Proofpoint-GUID: Irv6-L9tXzqYS3qqV9VriAIFmEHAXkoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NyBTYWx0ZWRfX48PI82QzHjJU
 7sCqDrfmkBQnURFqZGDlmGQkMgx8IaWMV/w3803tO6+SllQCJw8L4kh6Qs0vHlPJT038/6w+vjO
 Pu3e6YAEf43jEUTbBgN+eSFHcnPe6o1Z8FWh5rjoAIv9c0Fu6fANZcJ6/hmq+ix6Eu5fj/u6jFM
 Uv/mlQfyxXN6oYrNswv07p+ZdPyAWWfQj8uvy9d8Acql82xqN8fOwokdkW6JvqMKmt1tMS1Jxij
 zABDDdiiQXhUIuGuo32dchdefo3zH2dbJzn9hW7ZDZmlNjramFbbVOrv1I7+IR0yyjMPyLhwbOG
 dUFjOPIWGgm7H6DZodBEO5vF2nKbY4qZmrC2vLFdqKKHaBUXvQ+yBI6M9y3vomA+HAAc/MrX7hH
 XdiKjvcUh59kWM7iSWH++sAh7XXDaB3DejVbvCX1Ffwc0/Sm+kZB3S3tMYgKaNYD2UKA0gxL6lJ
 qhiVVY4P4YxV2k3gSZw==
X-Authority-Analysis: v=2.4 cv=X/Ni7mTe c=1 sm=1 tr=0 ts=69ef02f8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=j4DJZzs_5jzhZZj0efwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 9C23246D997
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281223-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

npc_mcam_idx_2_key_type() can fail; callers used to ignore it and still
used kw_type when enabling, configuring, copying, and reading MCAM
entries. That could program or decode hardware with an undefined key
type.

Return -EINVAL when key-type lookup fails. Return -EINVAL from
npc_cn20k_copy_mcam_entry() when src and dest key types differ instead
of failing silently.

Change npc_cn20k_{enable,config,copy,read}_mcam_entry() to return int on
success or error. Thread those errors through the cn20k MCAM write and
read mbox handlers, the cn20k baseline steer read path, NPC defrag
move (disable/copy/enable with dev_err and -EFAULT), and the DMAC
update path in rvu_npc_fs.c.

Make npc_copy_mcam_entry() return int so the cn20k branch can return
npc_cn20k_copy_mcam_entry() without a void/int mismatch, and fail
NPC_MCAM_SHIFT_ENTRY when copy fails.

Cc: Suman Ghosh <sumang@marvell.com>
Cc: Dan Carpenter <error27@gmail.com>
Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 109 ++++++++++++------
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  20 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  18 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  20 ++--
 4 files changed, 111 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7291fdb89b03..8d5cee833af7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -798,7 +798,7 @@ void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
 		iounmap(mkex_prfl_addr);
 }
 
-void
+int
 npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 			    int index, bool enable)
 {
@@ -808,7 +808,9 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 	u64 cfg, hw_prio;
 	u8 kw_type;
 
-	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
+		return -EINVAL;
+
 	if (kw_type == NPC_MCAM_KEY_X2) {
 		cfg = rvu_read64(rvu, blkaddr,
 				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx,
@@ -819,7 +821,7 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
 			    cfg);
-		return;
+		return 0;
 	}
 
 	/* For NPC_CN20K_MCAM_KEY_X4 keys, both the banks
@@ -836,6 +838,8 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
 			    cfg);
 	}
+
+	return 0;
 }
 
 void
@@ -1042,9 +1046,9 @@ npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
 	}
 }
 
-void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
-				 u8 intf, struct cn20k_mcam_entry *entry,
-				 bool enable, u8 hw_prio, u8 req_kw_type)
+int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
+				u8 intf, struct cn20k_mcam_entry *entry,
+				bool enable, u8 hw_prio, u8 req_kw_type)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
@@ -1052,10 +1056,13 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	int kw = 0;
 	u8 kw_type;
 
+	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
+		return -EINVAL;
+
 	/* Disable before mcam entry update */
-	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
+	if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false))
+		return -EINVAL;
 
-	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
 	/* CAM1 takes the comparison value and
 	 * CAM0 specifies match for a bit in key being '0' or '1' or 'dontcare'.
 	 * CAM1<n> = 0 & CAM0<n> = 1 => match if key<n> = 0
@@ -1120,9 +1127,11 @@ void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 	/* PF installing VF rule */
 	npc_cn20k_set_mcam_bank_cfg(rvu, blkaddr, mcam_idx, bank,
 				    kw_type, enable, hw_prio);
+
+	return 0;
 }
 
-void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
+int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u64 cfg, sreg, dreg, soff, doff;
@@ -1132,10 +1141,15 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 
 	dbank = npc_get_bank(mcam, dest);
 	sbank = npc_get_bank(mcam, src);
-	npc_mcam_idx_2_key_type(rvu, src, &src_kwtype);
-	npc_mcam_idx_2_key_type(rvu, dest, &dest_kwtype);
+
+	if (npc_mcam_idx_2_key_type(rvu, src, &src_kwtype))
+		return -EINVAL;
+
+	if (npc_mcam_idx_2_key_type(rvu, dest, &dest_kwtype))
+		return -EINVAL;
+
 	if (src_kwtype != dest_kwtype)
-		return;
+		return -EINVAL;
 
 	src &= (mcam->banksize - 1);
 	dest &= (mcam->banksize - 1);
@@ -1170,6 +1184,8 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 		if (src_kwtype == NPC_MCAM_KEY_X2)
 			break;
 	}
+
+	return 0;
 }
 
 static void npc_cn20k_fill_entryword(struct cn20k_mcam_entry *entry, int idx,
@@ -1179,16 +1195,17 @@ static void npc_cn20k_fill_entryword(struct cn20k_mcam_entry *entry, int idx,
 	entry->kw_mask[idx] = cam1 ^ cam0;
 }
 
-void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
-			       struct cn20k_mcam_entry *entry,
-			       u8 *intf, u8 *ena, u8 *hw_prio)
+int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
+			      struct cn20k_mcam_entry *entry,
+			      u8 *intf, u8 *ena, u8 *hw_prio)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u64 cam0, cam1, bank_cfg, cfg;
 	int kw = 0, bank;
 	u8 kw_type;
 
-	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
+		return -EINVAL;
 
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
@@ -1298,6 +1315,8 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 	cfg = rvu_read64(rvu, blkaddr,
 			 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 1));
 	entry->vtag_action = cfg;
+
+	return 0;
 }
 
 int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
@@ -1335,11 +1354,10 @@ int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
 	if (is_pffunc_af(req->hdr.pcifunc))
 		nix_intf = req->intf;
 
-	npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
-				    &req->entry_data, req->enable_entry,
-				    req->hw_prio, req->req_kw_type);
+	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
+					 &req->entry_data, req->enable_entry,
+					 req->hw_prio, req->req_kw_type);
 
-	rc = 0;
 exit:
 	mutex_unlock(&mcam->lock);
 	return rc;
@@ -1361,11 +1379,13 @@ int rvu_mbox_handler_npc_cn20k_mcam_read_entry(struct rvu *rvu,
 
 	mutex_lock(&mcam->lock);
 	rc = npc_mcam_verify_entry(mcam, pcifunc, req->entry);
-	if (!rc)
-		npc_cn20k_read_mcam_entry(rvu, blkaddr, req->entry,
-					  &rsp->entry_data, &rsp->intf,
-					  &rsp->enable, &rsp->hw_prio);
+	if (rc)
+		goto fail;
 
+	rc = npc_cn20k_read_mcam_entry(rvu, blkaddr, req->entry,
+				       &rsp->entry_data, &rsp->intf,
+				       &rsp->enable, &rsp->hw_prio);
+fail:
 	mutex_unlock(&mcam->lock);
 	return rc;
 }
@@ -1415,14 +1435,14 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	else
 		nix_intf = pfvf->nix_rx_intf;
 
-	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
-				    &req->entry_data, req->enable_entry,
-				    req->hw_prio, req->req_kw_type);
+	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
+					 &req->entry_data, req->enable_entry,
+					 req->hw_prio, req->req_kw_type);
 
 	mutex_unlock(&mcam->lock);
 
 	rsp->entry = entry_rsp.entry;
-	return 0;
+	return rc;
 }
 
 static int rvu_npc_get_base_steer_rule_type(struct rvu *rvu, u16 pcifunc)
@@ -1480,9 +1500,9 @@ int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
 
 read_entry:
 	/* Read the mcam entry */
-	npc_cn20k_read_mcam_entry(rvu, blkaddr, index,
-				  &rsp->entry, &intf,
-				  &enable, &hw_prio);
+	rc = npc_cn20k_read_mcam_entry(rvu, blkaddr, index,
+				       &rsp->entry, &intf,
+				       &enable, &hw_prio);
 	mutex_unlock(&mcam->lock);
 out:
 	return rc;
@@ -3607,9 +3627,30 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
 				   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx,
 								      bank));
 
-		npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false);
-		npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx);
-		npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true);
+		/* If bug happened during copy/enable mcam, then there is a bug in allocation
+		 * algorithm itself. There is no point in rewinding and returning, as it
+		 * will face further issue. Return error after printing error
+		 */
+		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false)) {
+			dev_err(rvu->dev,
+				"%s: Error happened while disabling old_mid=%u\n",
+				__func__, old_midx);
+			return -EFAULT;
+		}
+
+		if (npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx)) {
+			dev_err(rvu->dev,
+				"%s: Error happened while copying old_midx=%u new_midx=%u\n",
+				__func__, old_midx, new_midx);
+			return -EFAULT;
+		}
+
+		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true)) {
+			dev_err(rvu->dev,
+				"%s: Error happened while enabling new_mid=%u\n",
+				__func__, new_midx);
+			return -EFAULT;
+		}
 
 		midx = new_midx % mcam->banksize;
 		bank = new_midx / mcam->banksize;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 815d0b257a7e..8f3eea9cfb1d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -320,16 +320,16 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc);
 int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast);
 
-void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
-				 u8 intf, struct cn20k_mcam_entry *entry,
-				 bool enable, u8 hw_prio, u8 req_kw_type);
-void npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
-				 int index, bool enable);
-void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
-			       u16 src, u16 dest);
-void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
-			       struct cn20k_mcam_entry *entry, u8 *intf,
-			       u8 *ena, u8 *hw_prio);
+int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
+				u8 intf, struct cn20k_mcam_entry *entry,
+				bool enable, u8 hw_prio, u8 req_kw_type);
+int npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
+				int index, bool enable);
+int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
+			      u16 src, u16 dest);
+int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
+			      struct cn20k_mcam_entry *entry, u8 *intf,
+			      u8 *ena, u8 *hw_prio);
 void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
 				int bank, int index);
 int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c2ca5ed1d028..ecaf0946b852 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -241,7 +241,10 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 		if (index < 0 || index >= mcam->banksize * mcam->banks)
 			return;
 
-		return npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable);
+		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
+			dev_err(rvu->dev, "Error to %s mcam %u entry\n",
+				enable ? "enable" : "disable", index);
+		return;
 	}
 
 	index &= (mcam->banksize - 1);
@@ -589,8 +592,8 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			  NPC_AF_MCAMEX_BANKX_CFG(src, sbank)) & 1;
 }
 
-static void npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
-				int blkaddr, u16 src, u16 dest)
+static int npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
+			       int blkaddr, u16 src, u16 dest)
 {
 	int dbank = npc_get_bank(mcam, dest);
 	int sbank = npc_get_bank(mcam, src);
@@ -630,6 +633,7 @@ static void npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 NPC_AF_MCAMEX_BANKX_CFG(src, sbank));
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_MCAMEX_BANKX_CFG(dest, dbank), cfg);
+	return 0;
 }
 
 u64 npc_get_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
@@ -3266,7 +3270,10 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 		npc_enable_mcam_entry(rvu, mcam, blkaddr, new_entry, false);
 
 		/* Copy rule from old entry to new entry */
-		npc_copy_mcam_entry(rvu, mcam, blkaddr, old_entry, new_entry);
+		if (npc_copy_mcam_entry(rvu, mcam, blkaddr, old_entry, new_entry)) {
+			rc = NPC_MCAM_INVALID_REQ;
+			break;
+		}
 
 		/* Copy counter mapping, if any */
 		cntr = mcam->entry2cntr_map[old_entry];
@@ -3284,7 +3291,8 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 
 	/* If shift has failed then report the failed index */
 	if (index != req->shift_count) {
-		rc = NPC_MCAM_PERM_DENIED;
+		if (!rc)
+			rc = NPC_MCAM_PERM_DENIED;
 		rsp->failed_entry_idx = index;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index b45798d9fdab..fe10554b1f0e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1980,13 +1980,15 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 
 	ether_addr_copy(rule->packet.dmac, pfvf->mac_addr);
 
-	if (is_cn20k(rvu->pdev))
-		npc_cn20k_read_mcam_entry(rvu, npcblkaddr, rule->entry,
-					  cn20k_entry, &intf,
-					  &enable, &hw_prio);
-	else
+	if (is_cn20k(rvu->pdev)) {
+		if (npc_cn20k_read_mcam_entry(rvu, npcblkaddr, rule->entry,
+					      cn20k_entry, &intf,
+					      &enable, &hw_prio))
+			return -EINVAL;
+	} else {
 		npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
 				    entry, &intf, &enable);
+	}
 
 	npc_update_entry(rvu, NPC_DMAC, &mdata,
 			 ether_addr_to_u64(pfvf->mac_addr), 0,
@@ -2038,8 +2040,12 @@ void npc_mcam_enable_flows(struct rvu *rvu, u16 target)
 				continue;
 			}
 
-			if (rule->vfvlan_cfg)
-				npc_update_dmac_value(rvu, blkaddr, rule, pfvf);
+			if (rule->vfvlan_cfg) {
+				if (npc_update_dmac_value(rvu, blkaddr, rule, pfvf))
+					dev_err(rvu->dev,
+						"Update dmac failed for %u, target=%#x\n",
+						rule->entry, target);
+			}
 
 			if (rule->rx_action.op == NIX_RX_ACTION_DEFAULT) {
 				if (!def_ucast_rule)
-- 
2.43.0


