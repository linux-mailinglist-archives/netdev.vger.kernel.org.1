Return-Path: <netdev+bounces-248354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84127D073E0
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 06:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76911301D302
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAC2FD1B3;
	Fri,  9 Jan 2026 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D7n4WgGq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18F2F0C70;
	Fri,  9 Jan 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937760; cv=none; b=ofDLcFl9zUr3KMooGwLGWHR/UpthtKlqn5GGruzsj8WdEy8bQyJiyHR4mk8ynfLeMZUleD7APUWMcf2TTTNGwN0ZbH172IlFGYNODr131q5D4bYPbOE4UY4lsjZ3i2cYqt8uivV/cHv1np6Y0opC2icACSt7a/+yUOxYgGuJLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937760; c=relaxed/simple;
	bh=ZbrIlM1z1GFFMtJjUEoo9zUWZrIdoTHuEVE7zOlm/ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvshDXXpZd4jEirGT0Ar8PY2w4ZXuiiXjzNflt2wzcSVj7fRjiJegU2b8NQI0WNQrQRPmPhLalQhyEKs4iQTyMMv/E2jD8T0+2K/5uYXZKR6/U3vjpI9+TVMzRHk8Kc1gwsO/F3g6daEwG5tHfzUVd0dheIJjbAIx2ZPIF+/iB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D7n4WgGq; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6093EZEL2938365;
	Thu, 8 Jan 2026 21:49:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	7SQPCYX0pYss3sbQP2sUlOQRMwfi1kqb+jIIxJRrTU=; b=D7n4WgGq16uQiAh0Y
	H6WcmSpsML6zZcIFsy0mFvOuJxkaDJZGBG0v+HFYL+YiCz9AMwYPb+qy5Dbudhld
	VubHZpWCxYa03dXdSAIhcDRTnD48R07+qhW5YI6tqnzXmayXKriPz5/TNS6OGLdn
	/29wLRry//bIaRs30X8oSITmB6QeWCS9ydhk6e4jimNCKY3Yu50SBGEwkzvf65MO
	zOgMy51NrYwlHpQCgKS+fktVPyP4v7XjJ1NttKxNcameH5z4SEenuF6Fl3r+5VWa
	4W8HfjyDXRoqVgaLSL7REXACs0XhRRO7GldamLpRaO5FfMZkMRroCHRZYjmH+a2E
	pIGPg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2v0d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 21:49:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 21:49:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 21:49:04 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 02B133F7060;
	Thu,  8 Jan 2026 21:49:00 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v3 08/13] octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
Date: Fri, 9 Jan 2026 11:18:23 +0530
Message-ID: <20260109054828.1822307-9-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109054828.1822307-1-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2WfSmSx3qvF5A9uC-93idB3TvLASb_na
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX5fpBiIx1gIAe
 P+qGn74V7Fa5V/sSOSETc02OLpJetUUqZRvpUx3G+KvhPeg7sMVGAooOxZ/R5iVz6jsRQVUrAwE
 gqhfkXvRUcdgLlYRnAdXdDbJ9WYr/txsevqANpltE7/ySDHgPoYbDrJeQkSgjmblwI0iLVZrGqE
 WOH4I1pBrYnPDwXHcUMshhpX4qprLhsE/aEpDK16Mt9I6RVN+6xUENkZHXw750MBsFWXLiCKqtX
 OByskB7j2yMRim+CYbvjhQMgTuw/GytPlDWYaNvOpsSjtEdLF981ZKWL6q2CECdETDaKkwpU5ON
 WcHSTnx/VCCgqshyRHLRIDjoooyDp30TKgYTkop2oWTEl/BHbFXBgriruM+LC7ZMWCNvQU4jkog
 d6kPeKTrxH+uRxlwO/HXDsFVC7iWkwCUCSQEc6uELMC6JVihCkoATqGqS7MEx6F6vViqKqTUo6l
 LedjbO9j6zjB1IFuAsw==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=696096d2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=IrAhxYro04ajLXZv7mAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2WfSmSx3qvF5A9uC-93idB3TvLASb_na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Due to new requirements in CN20K, the existing `struct mcam_entry` needed
to be updated. Previously, it contained two arrays, `kw` and `kw_mask`,
each of size 7 (keyword size). To support CN20K requirements, the size of
these arrays has been increased from 7 to 8. However, this change breaks
backward compatibility because it alters the structure layout. Therefore,
we decided to use separate mailboxes that use the updated `struct
mcam_entry`.

This patch identifies such mailboxes and adds new ones specifically for
CN20K.

New mailboxes added:
1. `NPC_CN20K_MCAM_WRITE_ENTRY`
2. `NPC_CN20K_MCAM_ALLOC_AND_WRITE_ENTRY`
3. `NPC_CN20K_MCAM_READ_ENTRY`
4. `NPC_CN20K_MCAM_READ_BASE_RULE`

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/mbox_init.c    |  17 ++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 188 ++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   7 +-
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  57 ++++-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  61 +++++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  28 ++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  54 ++++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 197 +++++++++++++-----
 11 files changed, 530 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
index bd3aab7770dd..71401dec0d77 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -397,6 +397,12 @@ int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	if (is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))
 		return 0;
 
+	/* sanity check */
+	cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_NIXX_CFG(0) |
+			 (RVU_AFPF << 16));
+	if (!cfg)
+		return 0;
+
 	ctx_cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST3);
 	/* Alloc memory for CQINT's HW contexts */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
@@ -420,5 +426,16 @@ int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_BASE(nixlf),
 		    (u64)pfvf->nix_qints_ctx->iova);
 
+	rvu_write64(rvu, BLKADDR_NIX0, RVU_AF_BAR2_SEL, RVU_AF_BAR2_PFID);
+	rvu_write64(rvu, BLKADDR_NIX0,
+		    AF_BAR2_ALIASX(0, NIX_GINT_INT_W1S), ALTAF_RDY);
+	/* wait for ack */
+	err = rvu_poll_reg(rvu, BLKADDR_NIX0,
+			   AF_BAR2_ALIASX(0, NIX_GINT_INT), ALTAF_RDY, true);
+	if (err)
+		rvu->altaf_ready = false;
+	else
+		rvu->altaf_ready = true;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 252e86d85f69..528e17f6bf85 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -611,9 +611,13 @@ npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1), 0);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0), 0);
+
+	/* Clear corresponding stats register */
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank), 0);
 }
 
-static void npc_cn20k_get_keyword(struct mcam_entry *entry, int idx,
+static void npc_cn20k_get_keyword(struct cn20k_mcam_entry *entry, int idx,
 				  u64 *cam0, u64 *cam1)
 {
 	u64 kw_mask;
@@ -638,7 +642,7 @@ static void npc_cn20k_get_keyword(struct mcam_entry *entry, int idx,
 
 static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
-				   struct mcam_entry *entry,
+				   struct cn20k_mcam_entry *entry,
 				   int bank, u8 kw_type, int kw)
 {
 	u64 intf_ext = 0, intf_ext_mask = 0;
@@ -725,7 +729,8 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 
 static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
-				   struct mcam_entry *entry, u8 kw_type)
+				   struct cn20k_mcam_entry *entry,
+				   u8 kw_type)
 {
 	int kw = 0, bank;
 
@@ -763,9 +768,9 @@ npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
 	}
 }
 
-void
-npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index, u8 intf,
-			    struct mcam_entry *entry, bool enable, u8 hw_prio)
+void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
+				 u8 intf, struct cn20k_mcam_entry *entry,
+				 bool enable, u8 hw_prio)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
@@ -873,7 +878,7 @@ void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
 	}
 }
 
-static void npc_cn20k_fill_entryword(struct mcam_entry *entry, int idx,
+static void npc_cn20k_fill_entryword(struct cn20k_mcam_entry *entry, int idx,
 				     u64 cam0, u64 cam1)
 {
 	entry->kw[idx] = cam1;
@@ -881,8 +886,8 @@ static void npc_cn20k_fill_entryword(struct mcam_entry *entry, int idx,
 }
 
 void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
-			       struct mcam_entry *entry, u8 *intf, u8 *ena,
-			       u8 *hw_prio)
+			       struct cn20k_mcam_entry *entry,
+			       u8 *intf, u8 *ena, u8 *hw_prio)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int kw = 0, bank;
@@ -962,6 +967,171 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 					NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 1));
 }
 
+int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
+						struct npc_cn20k_mcam_write_entry_req *req,
+						struct msg_rsp *rsp)
+{
+	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 pcifunc = req->hdr.pcifunc;
+	int blkaddr, rc;
+	u8 nix_intf;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	mutex_lock(&mcam->lock);
+	rc = npc_mcam_verify_entry(mcam, pcifunc, req->entry);
+	if (rc)
+		goto exit;
+
+	if (!is_npc_interface_valid(rvu, req->intf)) {
+		rc = NPC_MCAM_INVALID_REQ;
+		goto exit;
+	}
+
+	if (is_npc_intf_tx(req->intf))
+		nix_intf = pfvf->nix_tx_intf;
+	else
+		nix_intf = pfvf->nix_rx_intf;
+
+	/* For AF installed rules, the nix_intf should be set to target NIX */
+	if (is_pffunc_af(req->hdr.pcifunc))
+		nix_intf = req->intf;
+
+	npc_cn20k_config_mcam_entry(rvu, blkaddr, req->entry, nix_intf,
+				    &req->entry_data, req->enable_entry,
+				    req->hw_prio);
+
+	rc = 0;
+exit:
+	mutex_unlock(&mcam->lock);
+	return rc;
+}
+
+int rvu_mbox_handler_npc_cn20k_mcam_read_entry(struct rvu *rvu,
+					       struct npc_mcam_read_entry_req *req,
+					       struct npc_cn20k_mcam_read_entry_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 pcifunc = req->hdr.pcifunc;
+	int blkaddr, rc;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	mutex_lock(&mcam->lock);
+	rc = npc_mcam_verify_entry(mcam, pcifunc, req->entry);
+	if (!rc)
+		npc_cn20k_read_mcam_entry(rvu, blkaddr, req->entry,
+					  &rsp->entry_data, &rsp->intf,
+					  &rsp->enable, &rsp->hw_prio);
+
+	mutex_unlock(&mcam->lock);
+	return rc;
+}
+
+int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
+							  struct npc_cn20k_mcam_alloc_and_write_entry_req *req,
+							  struct npc_mcam_alloc_and_write_entry_rsp *rsp)
+{
+	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
+	struct npc_mcam_alloc_entry_req entry_req;
+	struct npc_mcam_alloc_entry_rsp entry_rsp;
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 entry = NPC_MCAM_ENTRY_INVALID;
+	int blkaddr, rc;
+	u8 nix_intf;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	if (!is_npc_interface_valid(rvu, req->intf))
+		return NPC_MCAM_INVALID_REQ;
+
+	/* Try to allocate a MCAM entry */
+	entry_req.hdr.pcifunc = req->hdr.pcifunc;
+	entry_req.contig = true;
+	entry_req.ref_prio = req->ref_prio;
+	entry_req.ref_entry = req->ref_entry;
+	entry_req.count = 1;
+
+	rc = rvu_mbox_handler_npc_mcam_alloc_entry(rvu,
+						   &entry_req, &entry_rsp);
+	if (rc)
+		return rc;
+
+	if (!entry_rsp.count)
+		return NPC_MCAM_ALLOC_FAILED;
+
+	entry = entry_rsp.entry;
+	mutex_lock(&mcam->lock);
+
+	if (is_npc_intf_tx(req->intf))
+		nix_intf = pfvf->nix_tx_intf;
+	else
+		nix_intf = pfvf->nix_rx_intf;
+
+	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
+				    &req->entry_data, req->enable_entry,
+				    req->hw_prio);
+
+	mutex_unlock(&mcam->lock);
+
+	rsp->entry = entry;
+	return 0;
+}
+
+int rvu_mbox_handler_npc_cn20k_read_base_steer_rule(struct rvu *rvu,
+						    struct msg_req *req,
+						    struct npc_cn20k_mcam_read_base_rule_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int index, blkaddr, nixlf, rc = 0;
+	u16 pcifunc = req->hdr.pcifunc;
+	u8 intf, enable, hw_prio;
+	struct rvu_pfvf *pfvf;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	/* Return the channel number in case of PF */
+	if (!(pcifunc & RVU_PFVF_FUNC_MASK)) {
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
+		rsp->entry.kw[0] = pfvf->rx_chan_base;
+		rsp->entry.kw_mask[0] = 0xFFFULL;
+		goto out;
+	}
+
+	/* Find the pkt steering rule installed by PF to this VF */
+	mutex_lock(&mcam->lock);
+	for (index = 0; index < mcam->bmap_entries; index++) {
+		if (mcam->entry2target_pffunc[index] == pcifunc)
+			goto read_entry;
+	}
+
+	rc = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
+	if (rc < 0) {
+		mutex_unlock(&mcam->lock);
+		goto out;
+	}
+	/* Read the default ucast entry if there is no pkt steering rule */
+	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
+					 NIXLF_UCAST_ENTRY);
+read_entry:
+	/* Read the mcam entry */
+	npc_cn20k_read_mcam_entry(rvu, blkaddr, index,
+				  &rsp->entry, &intf,
+				  &enable, &hw_prio);
+	mutex_unlock(&mcam->lock);
+out:
+	return rc;
+}
+
 static u8 npc_map2cn20k_flag(u8 flag)
 {
 	switch (flag) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 061827df04ea..8f9df2d98a9b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -292,15 +292,16 @@ int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast);
 
 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
-				 u8 intf, struct mcam_entry *entry,
+				 u8 intf,
+				 struct cn20k_mcam_entry *entry,
 				 bool enable, u8 hw_prio);
 void npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
 				 int index, bool enable);
 void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
 			       u16 src, u16 dest);
 void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
-			       struct mcam_entry *entry, u8 *intf, u8 *ena,
-			       u8 *hw_prio);
+			       struct cn20k_mcam_entry *entry, u8 *intf,
+			       u8 *ena, u8 *hw_prio);
 void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
 				int bank, int index);
 int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index bf50d999528b..8bfaa507ee50 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -78,6 +78,13 @@
 #define RVU_MBOX_VF_INT_ENA_W1C			(0x38)
 
 #define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
+
+#define NIX_GINT_INT                           (0x200)
+#define NIX_GINT_INT_W1S                       (0x208)
+
+#define ALTAF_FLR                              BIT_ULL(0)
+#define ALTAF_RDY                              BIT_ULL(1)
+
 /* NPC registers */
 #define NPC_AF_INTFX_EXTRACTORX_CFG(a, b) \
 	(0x20c000ull | (a) << 16 | (b) << 8)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 7c58552435d2..34c960b84a65 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -287,6 +287,16 @@ M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6015, npc_cn20k_get_free_count,      \
 				 msg_req, npc_cn20k_get_free_count_rsp)	\
 M(NPC_CN20K_GET_KEX_CFG, 0x6016, npc_cn20k_get_kex_cfg,			\
 				   msg_req, npc_cn20k_get_kex_cfg_rsp)	\
+M(NPC_CN20K_MCAM_WRITE_ENTRY,	0x6017, npc_cn20k_mcam_write_entry,			\
+				 npc_cn20k_mcam_write_entry_req, msg_rsp)	\
+M(NPC_CN20K_MCAM_ALLOC_AND_WRITE_ENTRY, 0x6018, npc_cn20k_mcam_alloc_and_write_entry,	\
+				npc_cn20k_mcam_alloc_and_write_entry_req,  \
+				npc_mcam_alloc_and_write_entry_rsp)  \
+M(NPC_CN20K_MCAM_READ_ENTRY,	0x6019, npc_cn20k_mcam_read_entry,	\
+				  npc_mcam_read_entry_req,		\
+				  npc_cn20k_mcam_read_entry_rsp)	\
+M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601a, npc_cn20k_read_base_steer_rule,            \
+				   msg_req, npc_cn20k_mcam_read_base_rule_rsp)  \
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1570,13 +1580,32 @@ struct mcam_entry_mdata {
 };
 
 struct mcam_entry {
-#define NPC_MAX_KWS_IN_KEY	8 /* Number of keywords in max keywidth */
+#define NPC_MAX_KWS_IN_KEY	7 /* Number of keywords in max keywidth */
 	u64	kw[NPC_MAX_KWS_IN_KEY];
 	u64	kw_mask[NPC_MAX_KWS_IN_KEY];
 	u64	action;
 	u64	vtag_action;
 };
 
+struct cn20k_mcam_entry {
+#define NPC_CN20K_MAX_KWS_IN_KEY	8 /* Number of keywords in max keywidth */
+	u64	kw[NPC_CN20K_MAX_KWS_IN_KEY];
+	u64	kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
+	u64	action;
+	u64	vtag_action;
+};
+
+struct npc_cn20k_mcam_write_entry_req {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry_data;
+	u16 entry;	 /* MCAM entry to write this match key */
+	u16 cntr;	 /* Counter for this MCAM entry */
+	u8  intf;	 /* Rx or Tx interface */
+	u8  enable_entry;/* Enable this MCAM entry ? */
+	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u64 reserved;	 /* reserved for future use */
+};
+
 struct npc_mcam_write_entry_req {
 	struct mbox_msghdr hdr;
 	struct mcam_entry entry_data;
@@ -1649,8 +1678,30 @@ struct npc_mcam_alloc_and_write_entry_req {
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  alloc_cntr;  /* Allocate counter and map ? */
-	/* hardware priority, supported for cn20k */
-	u8 hw_prio;
+};
+
+struct npc_cn20k_mcam_alloc_and_write_entry_req {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry_data;
+	u16 ref_entry;
+	u8  ref_prio;    /* Lower or higher w.r.t ref_entry */
+	u8  intf;	 /* Rx or Tx interface */
+	u8  enable_entry;/* Enable this MCAM entry ? */
+	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u16 reserved[4]; /* reserved for future use */
+};
+
+struct npc_cn20k_mcam_read_entry_rsp {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry_data;
+	u8 intf;
+	u8 enable;
+	u8 hw_prio; /* valid for cn20k */
+};
+
+struct npc_cn20k_mcam_read_base_rule_rsp {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry;
 };
 
 struct npc_mcam_alloc_and_write_entry_rsp {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index cb05ec69e0b3..cefc5d70f3e4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -644,6 +644,7 @@ struct rvu_npc_mcam_rule {
 	u16 chan;
 	u16 chan_mask;
 	u8 lxmb;
+	u8 hw_prio;
 };
 
 #endif /* NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index df02caedc020..17ed22e9b6e7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -600,6 +600,7 @@ static void rvu_check_min_msix_vec(struct rvu *rvu, int nvecs, int pf, int vf)
 
 static int rvu_setup_msix_resources(struct rvu *rvu)
 {
+	struct altaf_intr_notify *altaf_intr_data;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf, vf, numvfs, hwvf, err;
 	int nvecs, offset, max_msix;
@@ -706,6 +707,20 @@ static int rvu_setup_msix_resources(struct rvu *rvu)
 	rvu->msix_base_iova = iova;
 	rvu->msixtr_base_phy = phy_addr;
 
+	if (is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))
+		return 0;
+
+	altaf_intr_data = &rvu->fwdata->altaf_intr_info;
+	if (altaf_intr_data->gint_paddr) {
+		iova = dma_map_resource(rvu->dev, altaf_intr_data->gint_paddr,
+					PCI_MSIX_ENTRY_SIZE, DMA_BIDIRECTIONAL, 0);
+
+		if (dma_mapping_error(rvu->dev, iova))
+			return -ENOMEM;
+
+		altaf_intr_data->gint_iova_addr = iova;
+	}
+
 	return 0;
 }
 
@@ -2156,6 +2171,26 @@ int rvu_mbox_handler_ndc_sync_op(struct rvu *rvu,
 	return 0;
 }
 
+static void rvu_notify_altaf(struct rvu *rvu, u16 pcifunc, u64 op)
+{
+	int pf, vf;
+
+	if (!rvu->fwdata)
+		return;
+
+	if (op == ALTAF_FLR) {
+		pf = rvu_get_pf(rvu->pdev, pcifunc);
+		set_bit(pf, rvu->fwdata->altaf_intr_info.flr_pf_bmap);
+		if (pcifunc & RVU_PFVF_FUNC_MASK) {
+			vf = pcifunc & RVU_PFVF_FUNC_MASK;
+			set_bit(vf, rvu->fwdata->altaf_intr_info.flr_vf_bmap);
+		}
+	}
+
+	rvu_write64(rvu, BLKADDR_NIX0, AF_BAR2_ALIASX(0, NIX_GINT_INT_W1S), op);
+	usleep_range(5000, 6000);
+}
+
 static int rvu_process_mbox_msg(struct otx2_mbox *mbox, int devid,
 				struct mbox_msghdr *req)
 {
@@ -2239,7 +2274,8 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 
 	offset = mbox->rx_start + ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
 
-	if (req_hdr->sig && !(is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))) {
+	if (req_hdr->sig && rvu->altaf_ready &&
+	    !(is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))) {
 		req_hdr->opt_msg = mw->mbox_wrk[devid].num_msgs;
 		rvu_write64(rvu, BLKADDR_NIX0, RVU_AF_BAR2_SEL,
 			    RVU_AF_BAR2_PFID);
@@ -2748,6 +2784,16 @@ static void rvu_blklf_teardown(struct rvu *rvu, u16 pcifunc, u8 blkaddr)
 	block = &rvu->hw->block[blkaddr];
 	num_lfs = rvu_get_rsrc_mapcount(rvu_get_pfvf(rvu, pcifunc),
 					block->addr);
+
+	if (block->addr == BLKADDR_TIM && rvu->altaf_ready) {
+		rvu_notify_altaf(rvu, pcifunc, ALTAF_FLR);
+		return;
+	}
+
+	if ((block->addr == BLKADDR_SSO || block->addr == BLKADDR_SSOW) &&
+	    rvu->altaf_ready)
+		return;
+
 	if (!num_lfs)
 		return;
 	for (slot = 0; slot < num_lfs; slot++) {
@@ -3031,7 +3077,7 @@ static int rvu_afvf_msix_vectors_num_ok(struct rvu *rvu)
 
 static int rvu_register_interrupts(struct rvu *rvu)
 {
-	int ret, offset, pf_vec_start;
+	int i, ret, offset, pf_vec_start;
 
 	rvu->num_vec = pci_msix_vec_count(rvu->pdev);
 
@@ -3222,6 +3268,13 @@ static int rvu_register_interrupts(struct rvu *rvu)
 	if (ret)
 		goto fail;
 
+	for (i = 0; i < rvu->num_vec; i++) {
+		if (strstr(&rvu->irq_name[i * NAME_SIZE], "Mbox") ||
+		    strstr(&rvu->irq_name[i * NAME_SIZE], "FLR"))
+			irq_set_affinity(pci_irq_vector(rvu->pdev, i),
+					 cpumask_of(0));
+	}
+
 	return 0;
 
 fail:
@@ -3250,8 +3303,8 @@ static int rvu_flr_init(struct rvu *rvu)
 			    cfg | BIT_ULL(22));
 	}
 
-	rvu->flr_wq = alloc_ordered_workqueue("rvu_afpf_flr",
-					      WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	rvu->flr_wq = alloc_workqueue("rvu_afpf_flr",
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
 	if (!rvu->flr_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a53bb5c924ef..f811d6b5c545 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -197,7 +197,7 @@ struct npc_key_field {
 	/* Masks where all set bits indicate position
 	 * of a field in the key
 	 */
-	u64 kw_mask[NPC_MAX_KWS_IN_KEY];
+	u64 kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
 	/* Number of words in the key a field spans. If a field is
 	 * of 16 bytes and key offset is 4 then the field will use
 	 * 4 bytes in KW0, 8 bytes in KW1 and 4 bytes in KW2 and
@@ -1191,4 +1191,5 @@ int rvu_rep_pf_init(struct rvu *rvu);
 int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
+int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 425d3a43c0b8..407f360feaf5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -21,6 +21,7 @@
 #include "rvu_npc_hash.h"
 #include "mcs.h"
 
+#include "cn20k/reg.h"
 #include "cn20k/debugfs.h"
 
 #define DEBUGFS_DIR_NAME "octeontx2"
@@ -3506,10 +3507,10 @@ static int rvu_dbg_npc_mcam_show_rules(struct seq_file *s, void *unused)
 	struct rvu_npc_mcam_rule *iter;
 	struct rvu *rvu = s->private;
 	struct npc_mcam *mcam;
-	int pf, vf = -1;
+	int pf, vf = -1, bank;
+	u16 target, index;
 	bool enabled;
 	int blkaddr;
-	u16 target;
 	u64 hits;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
@@ -3554,6 +3555,15 @@ static int rvu_dbg_npc_mcam_show_rules(struct seq_file *s, void *unused)
 
 		enabled = is_mcam_entry_enabled(rvu, mcam, blkaddr, iter->entry);
 		seq_printf(s, "\tenabled: %s\n", enabled ? "yes" : "no");
+		if (is_cn20k(rvu->pdev)) {
+			seq_printf(s, "\tpriority: %u\n", iter->hw_prio);
+			index = iter->entry & (mcam->banksize - 1);
+			bank = npc_get_bank(mcam, iter->entry);
+			hits = rvu_read64(rvu, blkaddr,
+					  NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank));
+			seq_printf(s, "\thits: %lld\n", hits);
+			continue;
+		}
 
 		if (!iter->has_cntr)
 			continue;
@@ -3721,11 +3731,17 @@ static int rvu_dbg_npc_exact_drop_cnt(struct seq_file *s, void *unused)
 		chan = field->kw_mask[0] & cam1;
 
 		str = (cfg & 1) ? "enabled" : "disabled";
+		if (is_cn20k(rvu->pdev))
+			seq_printf(s, "0x%x\t%d\t\t%llu\t0x%x\t%s\n", pcifunc, i,
+				   rvu_read64(rvu, blkaddr,
+					      NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(i, 0)),
+				   chan, str);
+		else
+			seq_printf(s, "0x%x\t%d\t\t%llu\t0x%x\t%s\n", pcifunc, i,
+				   rvu_read64(rvu, blkaddr,
+					      NPC_AF_MATCH_STATX(table->counter_idx[i])),
+				   chan, str);
 
-		seq_printf(s, "0x%x\t%d\t\t%llu\t0x%x\t%s\n", pcifunc, i,
-			   rvu_read64(rvu, blkaddr,
-				      NPC_AF_MATCH_STATX(table->counter_idx[i])),
-			   chan, str);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index ea0368b32b01..fdc6792df7bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2382,8 +2382,8 @@ void rvu_npc_get_mcam_counter_alloc_info(struct rvu *rvu, u16 pcifunc,
 	}
 }
 
-static int npc_mcam_verify_entry(struct npc_mcam *mcam,
-				 u16 pcifunc, int entry)
+int npc_mcam_verify_entry(struct npc_mcam *mcam,
+			  u16 pcifunc, int entry)
 {
 	/* verify AF installed entries */
 	if (is_pffunc_af(pcifunc))
@@ -2926,6 +2926,10 @@ int npc_config_cntr_default_entries(struct rvu *rvu, bool enable)
 	struct rvu_npc_mcam_rule *rule;
 	int blkaddr;
 
+	/* Counter is set for each rule by default */
+	if (is_cn20k(rvu->pdev))
+		return -EINVAL;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return -EINVAL;
@@ -3106,7 +3110,7 @@ int rvu_mbox_handler_npc_mcam_write_entry(struct rvu *rvu,
 	if (rc)
 		goto exit;
 
-	if (req->set_cntr &&
+	if (!is_cn20k(rvu->pdev) && req->set_cntr &&
 	    npc_mcam_verify_counter(mcam, pcifunc, req->cntr)) {
 		rc = NPC_MCAM_INVALID_REQ;
 		goto exit;
@@ -3321,6 +3325,10 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int err;
 
+	/* Counter is not supported for CN20K */
+	if (is_cn20k(rvu->pdev))
+		return NPC_MCAM_INVALID_REQ;
+
 	mutex_lock(&mcam->lock);
 
 	err = __npc_mcam_alloc_counter(rvu, req, rsp);
@@ -3375,6 +3383,10 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int err;
 
+	/* Counter is not supported for CN20K */
+	if (is_cn20k(rvu->pdev))
+		return NPC_MCAM_INVALID_REQ;
+
 	mutex_lock(&mcam->lock);
 
 	err = __npc_mcam_free_counter(rvu, req, rsp);
@@ -3433,6 +3445,10 @@ int rvu_mbox_handler_npc_mcam_unmap_counter(struct rvu *rvu,
 	u16 index, entry = 0;
 	int blkaddr, rc;
 
+	/* Counter is not supported for CN20K */
+	if (is_cn20k(rvu->pdev))
+		return NPC_MCAM_INVALID_REQ;
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3477,12 +3493,20 @@ int rvu_mbox_handler_npc_mcam_clear_counter(struct rvu *rvu,
 		struct npc_mcam_oper_counter_req *req, struct msg_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	int blkaddr, err;
+	int blkaddr, err, index, bank;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
+	if (is_cn20k(rvu->pdev)) {
+		index = req->cntr & (mcam->banksize - 1);
+		bank = npc_get_bank(mcam, req->cntr);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank), 0);
+		return 0;
+	}
+
 	mutex_lock(&mcam->lock);
 	err = npc_mcam_verify_counter(mcam, req->hdr.pcifunc, req->cntr);
 	mutex_unlock(&mcam->lock);
@@ -3499,12 +3523,20 @@ int rvu_mbox_handler_npc_mcam_counter_stats(struct rvu *rvu,
 			struct npc_mcam_oper_counter_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	int blkaddr, err;
+	int blkaddr, err, index, bank;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
+	if (is_cn20k(rvu->pdev)) {
+		index = req->cntr & (mcam->banksize - 1);
+		bank = npc_get_bank(mcam, req->cntr);
+		rsp->stat = rvu_read64(rvu, blkaddr,
+				       NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank));
+		return 0;
+	}
+
 	mutex_lock(&mcam->lock);
 	err = npc_mcam_verify_counter(mcam, req->hdr.pcifunc, req->cntr);
 	mutex_unlock(&mcam->lock);
@@ -3799,11 +3831,19 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
-	mutex_lock(&mcam->lock);
-
 	index = req->entry & (mcam->banksize - 1);
 	bank = npc_get_bank(mcam, req->entry);
 
+	mutex_lock(&mcam->lock);
+
+	if (is_cn20k(rvu->pdev)) {
+		rsp->stat_ena = 1;
+		rsp->stat = rvu_read64(rvu, blkaddr,
+				       NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index, bank));
+		mutex_unlock(&mcam->lock);
+		return 0;
+	}
+
 	/* read MCAM entry STAT_ACT register */
 	regval = rvu_read64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_STAT_ACT(index, bank));
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 64b13e63b7a5..9e4859b66e1b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -254,7 +254,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 				 * other field bits.
 				 */
 				if (npc_check_overlap_fields(dummy, input,
-							     NPC_MAX_KWS_IN_KEY - 1))
+							     NPC_MAX_KWS_IN_KEY))
 					return true;
 			}
 		}
@@ -285,7 +285,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 					 start_kwi, offset, intf);
 			/* check any input field bits falls in any other field bits */
 			if (npc_check_overlap_fields(dummy, input,
-						     NPC_MAX_KWS_IN_KEY))
+						     NPC_CN20K_MAX_KWS_IN_KEY))
 				return true;
 		}
 	}
@@ -456,9 +456,9 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	u8 start_lid;
 
 	if (is_cn20k(rvu->pdev))
-		max_kw = NPC_MAX_KWS_IN_KEY;
+		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
 	else
-		max_kw = NPC_MAX_KWS_IN_KEY - 1;
+		max_kw = NPC_MAX_KWS_IN_KEY;
 
 	key_fields = mcam->rx_key_fields;
 	features = &mcam->rx_features;
@@ -902,6 +902,7 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf)
 {
+	struct cn20k_mcam_entry cn20k_dummy = { {0} };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct mcam_entry dummy = { {0} };
 	u64 *kw, *kw_mask, *val, *mask;
@@ -917,9 +918,15 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	if (!field->nr_kws)
 		return;
 
-	max_kw = NPC_MAX_KWS_IN_KEY;
-	kw = dummy.kw;
-	kw_mask = dummy.kw_mask;
+	if (is_cn20k(rvu->pdev)) {
+		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		kw = cn20k_dummy.kw;
+		kw_mask = cn20k_dummy.kw_mask;
+	} else {
+		max_kw = NPC_MAX_KWS_IN_KEY;
+		kw = dummy.kw;
+		kw_mask = dummy.kw_mask;
+	}
 
 	for (i = 0; i < max_kw; i++) {
 		if (!field->kw_mask[i])
@@ -1241,6 +1248,10 @@ static void rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 
+	/* There is no counter alloted for cn20k */
+	if (is_cn20k(rvu->pdev))
+		return;
+
 	mutex_lock(&mcam->lock);
 
 	__rvu_mcam_remove_counter_from_rule(rvu, pcifunc, rule);
@@ -1290,8 +1301,17 @@ static int npc_mcast_update_action_index(struct rvu *rvu, struct npc_install_flo
 static void
 npc_populate_mcam_mdata(struct rvu *rvu,
 			struct mcam_entry_mdata *mdata,
+			struct cn20k_mcam_entry *cn20k_entry,
 			struct mcam_entry *entry)
 {
+	if (is_cn20k(rvu->pdev)) {
+		mdata->kw = cn20k_entry->kw;
+		mdata->kw_mask = cn20k_entry->kw_mask;
+		mdata->action = &cn20k_entry->action;
+		mdata->vtag_action = &cn20k_entry->vtag_action;
+		mdata->max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		return;
+	}
 	mdata->kw = entry->kw;
 	mdata->kw_mask = entry->kw_mask;
 	mdata->action = &entry->action;
@@ -1411,9 +1431,11 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 			    bool pf_set_vfs_mac)
 {
 	struct rvu_npc_mcam_rule *def_ucast_rule = pfvf->def_ucast_rule;
+	struct npc_cn20k_mcam_write_entry_req cn20k_write_req = { 0 };
 	u64 features, installed_features, missing_features = 0;
 	struct npc_mcam_write_entry_req write_req = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct cn20k_mcam_entry *cn20k_entry;
 	struct mcam_entry_mdata mdata = { };
 	struct rvu_npc_mcam_rule dummy = { 0 };
 	struct rvu_npc_mcam_rule *rule;
@@ -1426,11 +1448,12 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 
 	installed_features = req->features;
 	features = req->features;
-	entry = &write_req.entry_data;
 	entry_index = req->entry;
 
-	npc_populate_mcam_mdata(rvu, &mdata,
-				&write_req.entry_data);
+	cn20k_entry = &cn20k_write_req.entry_data;
+	entry = &write_req.entry_data;
+
+	npc_populate_mcam_mdata(rvu, &mdata, cn20k_entry, entry);
 
 	npc_update_flow(rvu, &mdata, features, &req->packet, &req->mask, &dummy,
 			req->intf, blkaddr);
@@ -1477,49 +1500,80 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 		new = true;
 	}
 
-	/* allocate new counter if rule has no counter */
-	if (!req->default_rule && req->set_cntr && !rule->has_cntr)
-		rvu_mcam_add_counter_to_rule(rvu, owner, rule, rsp);
-
-	/* if user wants to delete an existing counter for a rule then
-	 * free the counter
-	 */
-	if (!req->set_cntr && rule->has_cntr)
-		rvu_mcam_remove_counter_from_rule(rvu, owner, rule);
+	if (!is_cn20k(rvu->pdev)) {
+		write_req.hdr.pcifunc = owner;
+
+		/* allocate new counter if rule has no counter */
+		if (!req->default_rule && req->set_cntr && !rule->has_cntr)
+			rvu_mcam_add_counter_to_rule(rvu, owner, rule, rsp);
+
+		/* if user wants to delete an existing counter for a rule then
+		 * free the counter
+		 */
+		if (!req->set_cntr && rule->has_cntr)
+			rvu_mcam_remove_counter_from_rule(rvu, owner, rule);
+
+		/* AF owns the default rules so change the owner just to relax
+		 * the checks in rvu_mbox_handler_npc_mcam_write_entry
+		 */
+		if (req->default_rule)
+			write_req.hdr.pcifunc = 0;
+
+		write_req.entry = entry_index;
+		write_req.intf = req->intf;
+		write_req.enable_entry = (u8)enable;
+		/* if counter is available then clear and use it */
+		if (req->set_cntr && rule->has_cntr) {
+			rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr), req->cntr_val);
+			write_req.set_cntr = 1;
+			write_req.cntr = rule->cntr;
+		}
+		goto update_rule;
+	}
 
-	write_req.hdr.pcifunc = owner;
+	cn20k_write_req.hdr.pcifunc = owner;
 
-	/* AF owns the default rules so change the owner just to relax
-	 * the checks in rvu_mbox_handler_npc_mcam_write_entry
-	 */
 	if (req->default_rule)
-		write_req.hdr.pcifunc = 0;
+		cn20k_write_req.hdr.pcifunc = 0;
 
-	write_req.entry = entry_index;
-	write_req.intf = req->intf;
-	write_req.enable_entry = (u8)enable;
-	/* if counter is available then clear and use it */
-	if (req->set_cntr && rule->has_cntr) {
-		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr), req->cntr_val);
-		write_req.set_cntr = 1;
-		write_req.cntr = rule->cntr;
-	}
+	cn20k_write_req.entry = entry_index;
+	cn20k_write_req.intf = req->intf;
+	cn20k_write_req.enable_entry = (u8)enable;
+	cn20k_write_req.hw_prio = req->hw_prio;
+
+update_rule:
 
 	/* update rule */
 	memcpy(&rule->packet, &dummy.packet, sizeof(rule->packet));
 	memcpy(&rule->mask, &dummy.mask, sizeof(rule->mask));
 	rule->entry = entry_index;
-	memcpy(&rule->rx_action, &entry->action, sizeof(struct nix_rx_action));
-	if (is_npc_intf_tx(req->intf))
-		memcpy(&rule->tx_action, &entry->action,
-		       sizeof(struct nix_tx_action));
-	rule->vtag_action = entry->vtag_action;
+	if (is_cn20k(rvu->pdev)) {
+		memcpy(&rule->rx_action, &cn20k_entry->action, sizeof(struct nix_rx_action));
+		if (is_npc_intf_tx(req->intf))
+			memcpy(&rule->tx_action, &cn20k_entry->action,
+			       sizeof(struct nix_tx_action));
+		rule->vtag_action = cn20k_entry->vtag_action;
+	} else {
+		memcpy(&rule->rx_action, &entry->action, sizeof(struct nix_rx_action));
+		if (is_npc_intf_tx(req->intf))
+			memcpy(&rule->tx_action, &entry->action,
+			       sizeof(struct nix_tx_action));
+		rule->vtag_action = entry->vtag_action;
+	}
+
 	rule->features = installed_features;
 	rule->default_rule = req->default_rule;
 	rule->owner = owner;
 	rule->enable = enable;
-	rule->chan_mask = write_req.entry_data.kw_mask[0] & NPC_KEX_CHAN_MASK;
-	rule->chan = write_req.entry_data.kw[0] & NPC_KEX_CHAN_MASK;
+
+	if (is_cn20k(rvu->pdev)) {
+		rule->chan_mask = cn20k_write_req.entry_data.kw_mask[0] & NPC_KEX_CHAN_MASK;
+		rule->chan = cn20k_write_req.entry_data.kw[0] & NPC_KEX_CHAN_MASK;
+	} else {
+		rule->chan_mask = write_req.entry_data.kw_mask[0] & NPC_KEX_CHAN_MASK;
+		rule->chan = write_req.entry_data.kw[0] & NPC_KEX_CHAN_MASK;
+	}
+
 	rule->chan &= rule->chan_mask;
 	rule->lxmb = dummy.lxmb;
 	if (is_npc_intf_tx(req->intf))
@@ -1533,8 +1587,13 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 		pfvf->def_ucast_rule = rule;
 
 	/* write to mcam entry registers */
-	err = rvu_mbox_handler_npc_mcam_write_entry(rvu, &write_req,
-						    &write_rsp);
+	if (is_cn20k(rvu->pdev))
+		err = rvu_mbox_handler_npc_cn20k_mcam_write_entry(rvu, &cn20k_write_req,
+								  &write_rsp);
+	else
+		err = rvu_mbox_handler_npc_mcam_write_entry(rvu, &write_req,
+							    &write_rsp);
+
 	if (err) {
 		rvu_mcam_remove_counter_from_rule(rvu, owner, rule);
 		if (new) {
@@ -1775,23 +1834,25 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 				 struct rvu_npc_mcam_rule *rule,
 				 struct rvu_pfvf *pfvf)
 {
+	struct npc_cn20k_mcam_write_entry_req cn20k_write_req = { 0 };
 	struct npc_mcam_write_entry_req write_req = { 0 };
-	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct mcam_entry_mdata mdata = { };
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct cn20k_mcam_entry *cn20k_entry;
 	struct mcam_entry *entry;
 	u8 intf, enable, hw_prio;
 	struct msg_rsp rsp;
 	int err;
 
+	cn20k_entry = &cn20k_write_req.entry_data;
 	entry = &write_req.entry_data;
-
-	npc_populate_mcam_mdata(rvu, &mdata, entry);
+	npc_populate_mcam_mdata(rvu, &mdata, cn20k_entry, entry);
 
 	ether_addr_copy(rule->packet.dmac, pfvf->mac_addr);
 
 	if (is_cn20k(rvu->pdev))
 		npc_cn20k_read_mcam_entry(rvu, npcblkaddr, rule->entry,
-					  entry, &intf,
+					  cn20k_entry, &intf,
 					  &enable, &hw_prio);
 	else
 		npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
@@ -1806,7 +1867,10 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 	write_req.intf = pfvf->nix_rx_intf;
 
 	mutex_unlock(&mcam->lock);
-	err = rvu_mbox_handler_npc_mcam_write_entry(rvu, &write_req, &rsp);
+	if (is_cn20k(rvu->pdev))
+		err = rvu_mbox_handler_npc_cn20k_mcam_write_entry(rvu, &cn20k_write_req, &rsp);
+	else
+		err = rvu_mbox_handler_npc_mcam_write_entry(rvu, &write_req, &rsp);
 	mutex_lock(&mcam->lock);
 
 	return err;
@@ -1894,6 +1958,7 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 			       u64 chan_val, u64 chan_mask, u64 exact_val, u64 exact_mask,
 			       u64 bcast_mcast_val, u64 bcast_mcast_mask)
 {
+	struct npc_cn20k_mcam_write_entry_req cn20k_req = { 0 };
 	struct npc_mcam_alloc_counter_req cntr_req = { 0 };
 	struct npc_mcam_alloc_counter_rsp cntr_rsp = { 0 };
 	struct npc_mcam_write_entry_req req = { 0 };
@@ -1942,19 +2007,22 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 	/* Reserve slot 0 */
 	npc_mcam_rsrcs_reserve(rvu, blkaddr, mcam_idx);
 
-	/* Allocate counter for this single drop on non hit rule */
-	cntr_req.hdr.pcifunc = 0; /* AF request */
-	cntr_req.contig = true;
-	cntr_req.count = 1;
-	err = rvu_mbox_handler_npc_mcam_alloc_counter(rvu, &cntr_req, &cntr_rsp);
-	if (err) {
-		dev_err(rvu->dev, "%s: Err to allocate cntr for drop rule (err=%d)\n",
-			__func__, err);
-		return	-EFAULT;
+	if (!is_cn20k(rvu->pdev)) {
+		/* Allocate counter for this single drop on non hit rule */
+		cntr_req.hdr.pcifunc = 0; /* AF request */
+		cntr_req.contig = true;
+		cntr_req.count = 1;
+		err = rvu_mbox_handler_npc_mcam_alloc_counter(rvu, &cntr_req, &cntr_rsp);
+		if (err) {
+			dev_err(rvu->dev, "%s: Err to allocate cntr for drop rule (err=%d)\n",
+				__func__, err);
+			return	-EFAULT;
+		}
+		*counter_idx = cntr_rsp.cntr;
 	}
-	*counter_idx = cntr_rsp.cntr;
 
 	npc_populate_mcam_mdata(rvu, &mdata,
+				&cn20k_req.entry_data,
 				&req.entry_data);
 
 	/* Fill in fields for this mcam entry */
@@ -1965,6 +2033,20 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 	npc_update_entry(rvu, NPC_LXMB, &mdata, bcast_mcast_val, 0,
 			 bcast_mcast_mask, 0, NIX_INTF_RX);
 
+	if (is_cn20k(rvu->pdev)) {
+		cn20k_req.intf = NIX_INTF_RX;
+		cn20k_req.entry = mcam_idx;
+
+		err = rvu_mbox_handler_npc_cn20k_mcam_write_entry(rvu, &cn20k_req, &rsp);
+		if (err) {
+			dev_err(rvu->dev, "%s: Installation of single drop on non hit rule at %d failed\n",
+				__func__, mcam_idx);
+			return err;
+		}
+
+		goto enable_entry;
+	}
+
 	req.intf = NIX_INTF_RX;
 	req.set_cntr = true;
 	req.cntr = cntr_rsp.cntr;
@@ -1980,6 +2062,7 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 	dev_err(rvu->dev, "%s: Installed single drop on non hit rule at %d, cntr=%d\n",
 		__func__, mcam_idx, req.cntr);
 
+enable_entry:
 	/* disable entry at Bank 0, index 0 */
 	npc_enable_mcam_entry(rvu, mcam, blkaddr, mcam_idx, false);
 
-- 
2.43.0


