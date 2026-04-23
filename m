Return-Path: <netdev+bounces-280708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MsOFO346WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40149450E1E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFEA9301F248
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324E3E1D1E;
	Thu, 23 Apr 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e/dvXpyO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72113E1D18;
	Thu, 23 Apr 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941030; cv=none; b=L3q0kC1b0Sugn4x0rCAoJLRas30Ix2MaTKaRD8dv7O0TUAtHmgMLbTUKA3V6qrTXAF/rauPNkWBDaaBmdMDrYilGRS7VTywFiReKAsP8jiJaWwYRlETqXMPTmyuS9YvwSyLAg371CLS4FSByZ3sbq3ftlsm4Y4NYBrzmmoDiZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941030; c=relaxed/simple;
	bh=PY4NK7obJtBHw69Q80wxdB4VKYtUT3TqtquOEKdVROE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKJCLxBLVGQh5wnbSKK4uKg6YJ87iHKsczZgsykUwIgDgfCxiZkhKFpaPKWyxRMxquDKW49zydDa2/VDXd8m1Rf03SFrKoNklnX0xB2ZtajqflFw422TT2Ri+zg+gNUthufxLWSQ8wI6oxQBFPJLGF2H9vq2eOpeHDLvmrI5ZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e/dvXpyO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MNN4Gq3067901;
	Thu, 23 Apr 2026 03:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	cGu83TMXf8pQ3b1+JLufD0vmNHRHvvMjj2c3RibFn8=; b=e/dvXpyOmxOVQRX8J
	R3ZaQMGQMcooiH2njyj1xo3vdW/DRxJtMciFNHpMq8uQTpxzwY+2rfT+zhLFYDEC
	qbB0sNuROTQM2Aui+CiQm7OULNKgILOXGAKW/aOe9PfiUoE3vTguj41PVIzC8Mm8
	12/Iv+Y0QTk8tqiL6CJfj0Vy4ybRyEyo82u8NVhBgfbBedUjOcU2GWFNc8Qp3oqg
	i8DkaGn/qpmlmrYXUf/Mr+GUBVva6j8YpH5p6LPQy5gb0AoBTrfxMu5VIhmkooJY
	5/ljYFtKgur6QtUKwenAl62K6gZCWLjEeXx6atdVzbo3U2kmwxGfNau/8TtUpdml
	6OSFg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dpepgwd8s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 03:43:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Apr 2026 03:43:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Apr 2026 03:43:27 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E25043F7044;
	Thu, 23 Apr 2026 03:43:23 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Suman Ghosh <sumang@marvell.com>, "Dan
 Carpenter" <error27@gmail.com>
Subject: [PATCH v3 net 01/11] octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
Date: Thu, 23 Apr 2026 16:13:07 +0530
Message-ID: <20260423104317.2707923-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423104317.2707923-1-rkannoth@marvell.com>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hskMiAj1xg2SdJg5dzljwc7KShe4Kgj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfXzeqs5XiJlXJw
 Srb7ms5UkDCnzmMdR+Uwu72mzNRL9WE4TPYTa1NnX1jY0FvrLHXKye9dygbwRysKJiVkhSviNPw
 U1TjNzptOA2QvY8zv3DcJLnueOdQaGRAi/3r8FkNTk+8g9vHNm39rRmhMzdvUr1PthMsA2QOuO8
 F2mWTSbUd37202KvhXFa4btEwNAJjvdsNClEHOuxOWgP6xwb0Qg0yMzb5IzJmpWJnpcS9dNv2jc
 kZ8RRrbnUsoDgy6crQgH8QAX2gFXwP3rSxYCddI/vUisL+JWwOGaJRL5VtMVvoZWq5vkq+DI/6D
 5DIJ9cZgfQgW4MWvBbgp9yPTH3BxtyiuiAJsQ3RNusstGQKVBewr4c9HheuA2OfcOEYku8K8e3z
 sNKJAvJHAzqAwTOwqbR24ZK9ff2pTnDi9ESSMasZV3cI7l5HrRsjAOfdEfuxyyONHCUHhGLLumx
 Yu8tZLdNFqYiIAW/14A==
X-Proofpoint-GUID: hskMiAj1xg2SdJg5dzljwc7KShe4Kgj9
X-Authority-Analysis: v=2.4 cv=SJBykuvH c=1 sm=1 tr=0 ts=69e9f7d0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=j4DJZzs_5jzhZZj0efwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280708-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 40149450E1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 7291fdb89b03..49b5cd2838b5 100644
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
+				"%s: Error happened to while copying old_midx=%u new_midx=%u\n",
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


