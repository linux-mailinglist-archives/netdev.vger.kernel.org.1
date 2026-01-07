Return-Path: <netdev+bounces-247580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A79CFBE28
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F99A3119CED
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D9264638;
	Wed,  7 Jan 2026 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BZCnAPkj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C352571DA;
	Wed,  7 Jan 2026 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757181; cv=none; b=GK7Xcod8xUHXFXdydenBN4n6gKgNYXCgpwaIdM/ftTlBKhtBCSler/lHIjqysFlCaBazKWiWw3F5Jw3ZF7RnL2tt071tSbXf+68Xvd7IfN4kqmJ7ZEgdFKz2NH3xNJ8rV8XivALmlpkT3B3TWffMEo+tc7xDCLnUZsp+YT+euwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757181; c=relaxed/simple;
	bh=rpOSjUUXU4Ab+VRpVXzQAPpHvsTeNqVANenlG3JaDJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1ewHP4TdNCNrID0BuGpDPSyHRpty4btdaGc/miTuO0n7nP2wcWnT4q+zgPXzBEZeFyYKcL/Zev87svO5fl3CbxP0U4yv6Tfu4AmbiT1O5dj7GaiuMW1nsQaG+NzsBZ8wJFqDl+9FatnsrkV0qKSNl0Xz0D63QyEKzeOEr5SRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BZCnAPkj; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NqTxP3768635;
	Tue, 6 Jan 2026 19:39:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	gkVMboJgR4bt6epSsZv7yjjrzsc2s4aW3I2TBn/epU=; b=BZCnAPkjOuzkQL2k4
	zn8LvGqwL4mLJUapmUXmPIPyVJviRlbqwEzmIN7OgEFy80o/kWIDSrJY+Xlh2bVX
	YGL+GyebRtpcoUdKEkF8QYTbDlnVQDrYuJ6ml8WsEBVltdczDWg+U35PBbyvaPkO
	Rgo7xs3VqoDv7rOQKK5MT5qPhQUum+wYRDQ34fXjNv8zB62HhHxNoRnqj/FzsKO3
	syQRN71sA2FFtGUPQS7VRk0cunqJTnCB7AIUhB5K/1B2dj+HVRkS0r1H0/TYDtAI
	cJ4iQEjXTRWh2qZmshOg5e0uSZ4aoxKKOrQXrcbHudyupEj8F4M8JrjKDvpiDelr
	dLe7Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bhces8bqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 19:39:28 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 19:39:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 19:39:41 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E87B93F704F;
	Tue,  6 Jan 2026 19:39:24 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Wed, 7 Jan 2026 09:08:40 +0530
Message-ID: <20260107033844.437026-10-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107033844.437026-1-rkannoth@marvell.com>
References: <20260107033844.437026-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FokIPmrq c=1 sm=1 tr=0 ts=695dd570 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=Suy3FIYwjLXlUDo0TKgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: TqADK7yJkOpqzDQ_fZ6LbeCGiTRmJMrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNyBTYWx0ZWRfX1jYu4nao1tSc
 JdOU4BG40dj1OftzjZiRceEwDHyiLfNNGVRhpXx3w71XIjAEeBBBpGKs02oseRipi/s6CaDgfDa
 oZ3rvzOLRiK+MmUqIEzr7eHmQZDLMS9HMa4QJgpKwjTJZUXO/AX193GZ2SvlkK3EgWRXGUdh2vm
 hp1OmCgpN+BjJ0nt0fcVrNv9JhxAFTKtseY7MD5NmHbI7AQqtYMpetPxVbb5ToaAmeKOdk/GCx4
 kXh/BYT7llAoT/8wM1GT898wh9E4NkgX7StNAjFjapXnp7e+OCjE01oGRqInsyN1Oqg8mmswxb6
 daBrNaGAp3D6CmszW8aBa9PRnH4ZfdeS1KUcy90/9pakOlToC4ODalXoFhDdFhkQ6JFHYP85/we
 CVYOF1EzEse/FrtClu/pKJOxRMo2VQ8b8QSje0D/lPYx6N7Y/AXaqk6O3BJ0yKlF4eSsT2iSYFX
 G4H+W86mF0+eb5SmzzQ==
X-Proofpoint-ORIG-GUID: TqADK7yJkOpqzDQ_fZ6LbeCGiTRmJMrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01

This patch adds support for virtual MCAM index allocation and
improves CN20K MCAM defragmentation handling. A new field is
introduced in the non-ref, non-contiguous MCAM allocation mailbox
request to indicate that virtual indexes should be returned instead
of physical ones. Virtual indexes allow the hardware to move mapped
MCAM entries internally, enabling defragmentation and preventing
scattered allocations across subbanks. The patch also enhances
defragmentation by treating non-ref, non-contiguous allocations as
ideal candidates for packing sparsely used regions, which can free
up subbanks for potential x2 or x4 configuration. All such
allocations are tracked and always returned as virtual indexes so
they remain stable even when entries are moved during defrag.
During defragmentation, MCAM entries may shift between subbanks,
but their virtual indexes remain unchanged. Additionally, this
update fixes an issue where entry statistics were not being
restored correctly after defragmentation.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 770 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  16 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   5 +
 .../marvell/octeontx2/af/rvu_devlink.c        |  81 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  22 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |   2 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   6 +
 7 files changed, 883 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 478c415b9af0..27adcd7ee8f6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -208,6 +208,204 @@ struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void)
 	return &npc_mkex_extr_default;
 }
 
+static u16 npc_idx2vidx(u16 idx)
+{
+	unsigned long index;
+	void *map;
+	u16 vidx;
+	int val;
+
+	vidx = idx;
+	index = idx;
+
+	map = xa_load(&npc_priv.xa_idx2vidx_map, index);
+	if (!map)
+		goto done;
+
+	val = xa_to_value(map);
+	if (val == -1)
+		goto done;
+
+	vidx = val;
+
+done:
+	return vidx;
+}
+
+static bool npc_is_vidx(u16 vidx)
+{
+	return vidx >= npc_priv.bank_depth * 2;
+}
+
+static u16 npc_vidx2idx(u16 vidx)
+{
+	unsigned long index;
+	void *map;
+	int val;
+	u16 idx;
+
+	idx = vidx;
+	index = vidx;
+
+	map = xa_load(&npc_priv.xa_vidx2idx_map, index);
+	if (!map)
+		goto done;
+
+	val = xa_to_value(map);
+	if (val == -1)
+		goto done;
+
+	idx = val;
+
+done:
+	return idx;
+}
+
+u16 npc_cn20k_vidx2idx(u16 idx)
+{
+	if (!npc_priv.init_done)
+		return idx;
+
+	if (!npc_is_vidx(idx))
+		return idx;
+
+	return npc_vidx2idx(idx);
+}
+
+u16 npc_cn20k_idx2vidx(u16 idx)
+{
+	if (!npc_priv.init_done)
+		return idx;
+
+	if (npc_is_vidx(idx))
+		return idx;
+
+	return npc_idx2vidx(idx);
+}
+
+static int npc_vidx_maps_del_entry(struct rvu *rvu, u16 vidx, u16 *old_midx)
+{
+	u16 mcam_idx;
+	void *map;
+
+	if (!npc_is_vidx(vidx)) {
+		dev_err(rvu->dev,
+			"%s:%d vidx(%u) does not map to proper mcam idx\n",
+			__func__, __LINE__, vidx);
+		return -ESRCH;
+	}
+
+	mcam_idx = npc_vidx2idx(vidx);
+
+	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s:%d vidx(%u) does not map to proper mcam idx\n",
+			__func__, __LINE__, vidx);
+		return -ESRCH;
+	}
+
+	map = xa_erase(&npc_priv.xa_idx2vidx_map, mcam_idx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s:%d mcam idx(%u) is not valid\n",
+			__func__, __LINE__, vidx);
+		return -ESRCH;
+	}
+
+	if (old_midx)
+		*old_midx = mcam_idx;
+
+	return 0;
+}
+
+static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
+{
+	u16 old_midx;
+	void *map;
+	int rc;
+
+	if (!npc_is_vidx(vidx)) {
+		dev_err(rvu->dev,
+			"%s:%d vidx(%u) does not map to proper mcam idx\n",
+			__func__, __LINE__, vidx);
+		return -ESRCH;
+	}
+
+	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s:%d vidx(%u) could not be deleted from vidx2idx map\n",
+			__func__, __LINE__, vidx);
+		return -ESRCH;
+	}
+
+	old_midx = xa_to_value(map);
+
+	rc = xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
+		       xa_mk_value(new_midx), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s:%d vidx(%u) cannot be added to vidx2idx map\n",
+			__func__, __LINE__, vidx);
+		return rc;
+	}
+
+	map = xa_erase(&npc_priv.xa_idx2vidx_map, old_midx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s:%d old_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
+			__func__, __LINE__, old_midx, vidx);
+		return -ESRCH;
+	}
+
+	rc = xa_insert(&npc_priv.xa_idx2vidx_map, new_midx,
+		       xa_mk_value(vidx), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s:%d new_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
+			__func__, __LINE__, new_midx, vidx);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
+				   u16 *vidx)
+{
+	int rc, max, min;
+	u32 id;
+
+	/* Virtual index start from maximum mcam index + 1 */
+	max = npc_priv.bank_depth * 2 * 2 - 1;
+	min = npc_priv.bank_depth * 2;
+
+	rc = xa_alloc(&npc_priv.xa_vidx2idx_map, &id,
+		      xa_mk_value(mcam_idx),
+		      XA_LIMIT(min, max), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s:%d Failed to add to vidx2idx map (%u)\n",
+			__func__, __LINE__, mcam_idx);
+		return rc;
+	}
+
+	rc = xa_insert(&npc_priv.xa_idx2vidx_map, mcam_idx,
+		       xa_mk_value(id), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s:%d Failed to add to idx2vidx map (%u)\n",
+			__func__, __LINE__, mcam_idx);
+		return rc;
+	}
+
+	if (vidx)
+		*vidx = id;
+
+	return 0;
+}
+
 static void npc_config_kpmcam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpm, int entry)
@@ -977,6 +1175,8 @@ int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
 	int blkaddr, rc;
 	u8 nix_intf;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -1018,6 +1218,8 @@ int rvu_mbox_handler_npc_cn20k_mcam_read_entry(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, rc;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -1058,6 +1260,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	entry_req.ref_prio = req->ref_prio;
 	entry_req.ref_entry = req->ref_entry;
 	entry_req.count = 1;
+	entry_req.virt = req->virt;
 
 	rc = rvu_mbox_handler_npc_mcam_alloc_entry(rvu,
 						   &entry_req, &entry_rsp);
@@ -1067,7 +1270,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	if (!entry_rsp.count)
 		return NPC_MCAM_ALLOC_FAILED;
 
-	entry = entry_rsp.entry;
+	entry = npc_cn20k_vidx2idx(entry_rsp.entry);
 	mutex_lock(&mcam->lock);
 
 	if (is_npc_intf_tx(req->intf))
@@ -1081,7 +1284,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 
 	mutex_unlock(&mcam->lock);
 
-	rsp->entry = entry;
+	rsp->entry = entry_rsp.entry;
 	return 0;
 }
 
@@ -2143,24 +2346,56 @@ static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
 			bool maps_del)
 {
 	struct npc_subbank *sb;
-	int idx, i;
+	u16 vidx, midx;
+	int sb_off, i;
 	bool ret;
 	int rc;
 
 	for (i = 0; i < count; i++) {
-		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
-						 &sb, &idx);
-		if (rc)
+		if (npc_is_vidx(mcam_idx[i])) {
+			vidx = mcam_idx[i];
+			midx = npc_vidx2idx(vidx);
+		} else {
+			midx = mcam_idx[i];
+			vidx = npc_idx2vidx(midx);
+		}
+
+		if (midx >= npc_priv.bank_depth * npc_priv.num_banks) {
+			dev_err(rvu->dev,
+				"%s:%d Invalid mcam_idx=%u cannot be deleted\n",
+				__func__, __LINE__, mcam_idx[i]);
+			return -EINVAL;
+		}
+
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, midx,
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d Failed to find subbank info for vidx=%u\n",
+				__func__, __LINE__, vidx);
 			return rc;
+		}
 
-		ret = npc_subbank_free(rvu, sb, idx);
-		if (ret)
+		ret = npc_subbank_free(rvu, sb, sb_off);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s:%d Failed to find subbank info for vidx=%u\n",
+				__func__, __LINE__, vidx);
 			return -EINVAL;
+		}
 
 		if (!maps_del)
 			continue;
 
-		rc = npc_del_from_pf_maps(rvu, mcam_idx[i]);
+		rc = npc_del_from_pf_maps(rvu, midx);
+		if (rc)
+			return rc;
+
+		/* If there is no vidx mapping; continue */
+		if (vidx == midx)
+			continue;
+
+		rc = npc_vidx_maps_del_entry(rvu, vidx, NULL);
 		if (rc)
 			return rc;
 	}
@@ -2675,10 +2910,12 @@ int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count)
 
 int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 			    int prio, u16 *mcam_idx, int ref, int limit,
-			    bool contig, int count)
+			    bool contig, int count, bool virt)
 {
+	bool defrag_candidate = false;
 	int i, eidx, rc, bd;
 	bool ref_valid;
+	u16 vidx;
 
 	bd = npc_priv.bank_depth;
 
@@ -2696,6 +2933,7 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 	}
 
 	ref_valid = !!(limit || ref);
+	defrag_candidate = !ref_valid && !contig && virt;
 	if (!ref_valid) {
 		if (contig && count > npc_priv.subbank_depth)
 			goto try_noref_multi_subbank;
@@ -2764,6 +3002,16 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 		rc = npc_add_to_pf_maps(rvu, mcam_idx[i], pcifunc);
 		if (rc)
 			return rc;
+
+		if (!defrag_candidate)
+			continue;
+
+		rc = npc_vidx_maps_add_entry(rvu, mcam_idx[i], pcifunc, &vidx);
+		if (rc)
+			return rc;
+
+		/* Return vidx to caller */
+		mcam_idx[i] = vidx;
 	}
 
 	return 0;
@@ -3034,6 +3282,501 @@ static int npc_pcifunc_map_create(struct rvu *rvu)
 	return cnt;
 }
 
+struct npc_defrag_node {
+	u8 idx;
+	u8 key_type;
+	bool valid;
+	bool refs;
+	u16 free_cnt;
+	u16 vidx_cnt;
+	u16 *vidx;
+	struct list_head list;
+};
+
+static bool npc_defrag_skip_restricted_sb(int sb_id)
+{
+	int i;
+
+	if (!restrict_valid)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(npc_subbank_restricted_idxs); i++)
+		if (sb_id == npc_subbank_restricted_idxs[i])
+			return true;
+	return false;
+}
+
+/* Find subbank with minimum number of virtual indexes */
+static struct npc_defrag_node *npc_subbank_min_vidx(struct list_head *lh)
+{
+	struct npc_defrag_node *node, *tnode = NULL;
+	int min = INT_MAX;
+
+	list_for_each_entry(node, lh, list) {
+		if (!node->valid)
+			continue;
+
+		/* if subbank has ref allocated mcam indexes, that subbank
+		 * is not a good candidate to move out indexes.
+		 */
+		if (node->refs)
+			continue;
+
+		if (min > node->vidx_cnt) {
+			min = node->vidx_cnt;
+			tnode = node;
+		}
+	}
+
+	return tnode;
+}
+
+/* Find subbank with maximum number of free spaces */
+static struct npc_defrag_node *npc_subbank_max_free(struct list_head *lh)
+{
+	struct npc_defrag_node *node, *tnode = NULL;
+	int max = INT_MIN;
+
+	list_for_each_entry(node, lh, list) {
+		if (!node->valid)
+			continue;
+
+		if (max < node->free_cnt) {
+			max = node->free_cnt;
+			tnode = node;
+		}
+	}
+
+	return tnode;
+}
+
+static int npc_defrag_alloc_free_slots(struct rvu *rvu,
+				       struct npc_defrag_node *f,
+				       int cnt, u16 *save)
+{
+	int alloc_cnt1, alloc_cnt2;
+	struct npc_subbank *sb;
+	int rc, sb_off, i;
+	bool deleted;
+
+	sb = &npc_priv.sb[f->idx];
+
+	alloc_cnt1 = 0;
+	alloc_cnt2 = 0;
+
+	rc = __npc_subbank_alloc(rvu, sb,
+				 NPC_MCAM_KEY_X2, sb->b0b,
+				 sb->b0t,
+				 NPC_MCAM_LOWER_PRIO,
+				 false, cnt, save, cnt, true,
+				 &alloc_cnt1);
+	if (alloc_cnt1 < cnt) {
+		rc = __npc_subbank_alloc(rvu, sb,
+					 NPC_MCAM_KEY_X2, sb->b1b,
+					 sb->b1t,
+					 NPC_MCAM_LOWER_PRIO,
+					 false, cnt - alloc_cnt1,
+					 save + alloc_cnt1,
+					 cnt - alloc_cnt1,
+					 true, &alloc_cnt2);
+	}
+
+	if (alloc_cnt1 + alloc_cnt2 != cnt) {
+		dev_err(rvu->dev,
+			"%s:%d Failed to alloc cnt=%u alloc_cnt1=%u alloc_cnt2=%u\n",
+			__func__, __LINE__, cnt, alloc_cnt1, alloc_cnt2);
+		goto fail_free_alloc;
+	}
+	return 0;
+
+fail_free_alloc:
+	for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d Error to find subbank for mcam idx=%u\n",
+				__func__, __LINE__, save[i]);
+			break;
+		}
+
+		deleted = __npc_subbank_free(rvu, sb, sb_off);
+		if (!deleted) {
+			dev_err(rvu->dev,
+				"%s:%d Error to free mcam idx=%u\n",
+				__func__, __LINE__, save[i]);
+			break;
+		}
+	}
+
+	return rc;
+}
+
+static int npc_defrag_add_2_show_list(struct rvu *rvu, u16 old_midx,
+				      u16 new_midx, u16 vidx)
+{
+	struct npc_defrag_show_node *node;
+
+	node = kcalloc(1, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->old_midx = old_midx;
+	node->new_midx = new_midx;
+	node->vidx = vidx;
+	INIT_LIST_HEAD(&node->list);
+
+	mutex_lock(&npc_priv.lock);
+	list_add_tail(&node->list, &npc_priv.defrag_lh);
+	mutex_unlock(&npc_priv.lock);
+
+	return 0;
+}
+
+static
+int npc_defrag_move_vdx_to_free(struct rvu *rvu,
+				struct npc_defrag_node *f,
+				struct npc_defrag_node *v,
+				int cnt, u16 *save)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int i, vidx_cnt, rc, sb_off;
+	u16 new_midx, old_midx, vidx;
+	struct npc_subbank *sb;
+	bool deleted;
+	u16 pcifunc;
+	int blkaddr;
+	void *map;
+	u8 bank;
+	u16 midx;
+	u64 stats;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+
+	vidx_cnt = v->vidx_cnt;
+	for (i = 0; i < cnt; i++) {
+		vidx = v->vidx[vidx_cnt - i - 1];
+		old_midx = npc_vidx2idx(vidx);
+		new_midx = save[cnt - i - 1];
+
+		dev_dbg(rvu->dev,
+			"%s:%d Moving %u ---> %u  (vidx=%u)\n",
+			__func__, __LINE__,
+			old_midx, new_midx, vidx);
+
+		rc = npc_defrag_add_2_show_list(rvu, old_midx, new_midx, vidx);
+		if (rc)
+			dev_err(rvu->dev,
+				"%s:%d Error happened to add to show list vidx=%u\n",
+				__func__, __LINE__, vidx);
+
+		/* Modify vidx to point to new mcam idx */
+		rc = npc_vidx_maps_modify(rvu, vidx, new_midx);
+		if (rc)
+			return rc;
+
+		midx = old_midx % mcam->banksize;
+		bank = old_midx / mcam->banksize;
+		stats = rvu_read64(rvu, blkaddr,
+				   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx, bank));
+
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false);
+		npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx);
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true);
+
+		midx = new_midx % mcam->banksize;
+		bank = new_midx / mcam->banksize;
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx, bank),
+			    stats);
+
+		/* Free the old mcam idx */
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, old_midx,
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d Unable to calculate subbank off for mcamidx=%u\n",
+				__func__, __LINE__, old_midx);
+			return rc;
+		}
+
+		deleted = __npc_subbank_free(rvu, sb, sb_off);
+		if (!deleted) {
+			dev_err(rvu->dev,
+				"%s:%d  Failed to free mcamidx=%u sb=%u sb_off=%u\n",
+				__func__, __LINE__, old_midx, sb->idx, sb_off);
+			return -EFAULT;
+		}
+
+		/* save pcifunc */
+		map = xa_load(&npc_priv.xa_idx2pf_map, old_midx);
+		pcifunc = xa_to_value(map);
+
+		/* delete from pf maps */
+		rc =  npc_del_from_pf_maps(rvu, old_midx);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d  Failed to delete pf maps for mcamidx=%u\n",
+				__func__, __LINE__, old_midx);
+			return rc;
+		}
+
+		/* add new mcam_idx to pf map */
+		rc = npc_add_to_pf_maps(rvu, new_midx, pcifunc);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d  Failed to add pf maps for mcamidx=%u\n",
+				__func__, __LINE__, new_midx);
+			return rc;
+		}
+
+		/* Remove from mcam maps */
+		mcam->entry2pfvf_map[old_midx] = NPC_MCAM_INVALID_MAP;
+		mcam->entry2cntr_map[old_midx] = NPC_MCAM_INVALID_MAP;
+		npc_mcam_clear_bit(mcam, old_midx);
+
+		mcam->entry2pfvf_map[new_midx] = pcifunc;
+		mcam->entry2cntr_map[new_midx] = pcifunc;
+		npc_mcam_set_bit(mcam, new_midx);
+
+		/* Mark as invalid */
+		v->vidx[vidx_cnt - i - 1] = -1;
+		save[cnt - i - 1] = -1;
+
+		f->free_cnt--;
+		v->vidx_cnt--;
+	}
+
+	return 0;
+}
+
+static int npc_defrag_process(struct rvu *rvu, struct list_head *lh)
+{
+	struct npc_defrag_node *v = NULL;
+	struct npc_defrag_node *f = NULL;
+	int rc = 0, cnt;
+	u16 *save;
+
+	while (1) {
+		/* Find subbank with minimum vidx */
+		if (!v) {
+			v = npc_subbank_min_vidx(lh);
+			if (!v)
+				break;
+		}
+
+		/* Find subbank with maximum free slots */
+		if (!f) {
+			f = npc_subbank_max_free(lh);
+			if (!f)
+				break;
+		}
+
+		if (!v->vidx_cnt) {
+			list_del_init(&v->list);
+			v = NULL;
+			continue;
+		}
+
+		if (!f->free_cnt) {
+			list_del_init(&f->list);
+			f = NULL;
+			continue;
+		}
+
+		/* If both subbanks are same, choose vidx and
+		 * search for free list again
+		 */
+		if (f == v) {
+			list_del_init(&f->list);
+			f = NULL;
+			continue;
+		}
+
+		/* Calculate minimum free slots needs to be allocated */
+		cnt = f->free_cnt > v->vidx_cnt ? v->vidx_cnt :
+			f->free_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s:%d cnt=%u free_cnt=%u(sb=%u) vidx_cnt=%u(sb=%u)\n",
+			__func__, __LINE__, cnt, f->free_cnt, f->idx,
+			v->vidx_cnt, v->idx);
+
+		/* Allocate an array to store newly allocated
+		 * free slots (mcam indexes)
+		 */
+		save = kcalloc(cnt, sizeof(*save), GFP_KERNEL);
+		if (!save) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		/* Alloc free slots for existing vidx */
+		rc = npc_defrag_alloc_free_slots(rvu, f, cnt, save);
+		if (rc) {
+			kfree(save);
+			goto err;
+		}
+
+		/* Move vidx to free slots; update pf_map and vidx maps,
+		 * and free existing vidx mcam slots
+		 */
+		rc = npc_defrag_move_vdx_to_free(rvu, f, v, cnt, save);
+		if (rc) {
+			kfree(save);
+			goto err;
+		}
+
+		kfree(save);
+
+		if (!f->free_cnt) {
+			list_del_init(&f->list);
+			f = NULL;
+		}
+
+		if (!v->vidx_cnt) {
+			list_del_init(&v->list);
+			v = NULL;
+		}
+	}
+
+err:
+	/* TODO: how to go back to old state ? */
+	return rc;
+}
+
+static void npc_defrag_list_clear(void)
+{
+	struct npc_defrag_show_node *node, *next;
+
+	mutex_lock(&npc_priv.lock);
+	list_for_each_entry_safe(node, next, &npc_priv.defrag_lh, list) {
+		list_del_init(&node->list);
+		kfree(node);
+	}
+
+	mutex_unlock(&npc_priv.lock);
+}
+
+/* Only non-ref non-contigous mcam indexes
+ * are picked for defrag process
+ */
+int npc_cn20k_defrag(struct rvu *rvu)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct npc_defrag_node *node, *tnode;
+	struct list_head x4lh, x2lh, *lh;
+	int rc = 0, i, sb_off, tot;
+	struct npc_subbank *sb;
+	unsigned long index;
+	void *map;
+	u16 midx;
+
+	/* Free previous show list */
+	npc_defrag_list_clear();
+
+	INIT_LIST_HEAD(&x4lh);
+	INIT_LIST_HEAD(&x2lh);
+
+	node = kcalloc(npc_priv.num_subbanks, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	/* Lock mcam */
+	mutex_lock(&mcam->lock);
+	npc_lock_all_subbank();
+
+	/* Fill in node with subbank properties */
+	for (i = 0; i < npc_priv.num_subbanks; i++) {
+		sb = &npc_priv.sb[i];
+
+		node[i].idx = i;
+		node[i].key_type = sb->key_type;
+		node[i].free_cnt = sb->free_cnt;
+		node[i].vidx = kcalloc(npc_priv.subbank_depth * 2,
+				       sizeof(*node[i].vidx),
+				       GFP_KERNEL);
+		if (!node[i].vidx) {
+			rc = -ENOMEM;
+			goto free_vidx;
+		}
+
+		/* If subbank is empty, dont include it in defrag
+		 * process
+		 */
+		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
+			node[i].valid = false;
+			continue;
+		}
+
+		if (npc_defrag_skip_restricted_sb(i)) {
+			node[i].valid = false;
+			continue;
+		}
+
+		node[i].valid = true;
+		INIT_LIST_HEAD(&node[i].list);
+
+		/* Add node to x2 or x4 list */
+		lh = sb->key_type == NPC_MCAM_KEY_X2 ? &x2lh : &x4lh;
+		list_add_tail(&node[i].list, lh);
+	}
+
+	/* Filling vidx[] array with all vidx in that subbank */
+	xa_for_each_start(&npc_priv.xa_vidx2idx_map, index, map,
+			  npc_priv.bank_depth * 2) {
+		midx = xa_to_value(map);
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, midx,
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:%d Error to get mcam_idx for vidx=%lu\n",
+				__func__, __LINE__, index);
+			goto free_vidx;
+		}
+
+		tnode = &node[sb->idx];
+		tnode->vidx[tnode->vidx_cnt] = index;
+		tnode->vidx_cnt++;
+	}
+
+	/* Mark all subbank which has ref allocation */
+	for (i = 0; i < npc_priv.num_subbanks; i++) {
+		tnode = &node[i];
+
+		if (!tnode->valid)
+			continue;
+
+		tot = (tnode->key_type == NPC_MCAM_KEY_X2) ?
+			npc_priv.subbank_depth * 2 : npc_priv.subbank_depth;
+
+		if (node[i].vidx_cnt != tot - tnode->free_cnt)
+			tnode->refs = true;
+	}
+
+	rc =  npc_defrag_process(rvu, &x2lh);
+	if (rc)
+		goto free_vidx;
+
+	rc =  npc_defrag_process(rvu, &x4lh);
+	if (rc)
+		goto free_vidx;
+
+free_vidx:
+	npc_unlock_all_subbank();
+	mutex_unlock(&mcam->lock);
+	for (i = 0; i < npc_priv.num_subbanks; i++)
+		kfree(node[i].vidx);
+	kfree(node);
+	return rc;
+}
+
+int rvu_mbox_handler_npc_defrag(struct rvu *rvu, struct msg_req *req,
+				struct msg_rsp *rsp)
+{
+	return npc_cn20k_defrag(rvu);
+}
+
 int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast)
 {
@@ -3419,6 +4162,8 @@ static int npc_priv_init(struct rvu *rvu)
 	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_idx2vidx_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_vidx2idx_map, XA_FLAGS_ALLOC);
 
 	if (npc_create_srch_order(num_subbanks)) {
 		kfree(npc_priv.sb);
@@ -3444,6 +4189,9 @@ static int npc_priv_init(struct rvu *rvu)
 	for (i = 0; i < npc_priv.pf_cnt; i++)
 		xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC);
 
+	INIT_LIST_HEAD(&npc_priv.defrag_lh);
+	mutex_init(&npc_priv.lock);
+
 	return 0;
 }
 
@@ -3456,6 +4204,8 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	xa_destroy(&npc_priv.xa_idx2pf_map);
 	xa_destroy(&npc_priv.xa_pf_map);
 	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
+	xa_destroy(&npc_priv.xa_idx2vidx_map);
+	xa_destroy(&npc_priv.xa_vidx2idx_map);
 
 	for (i = 0; i < npc_priv.pf_cnt; i++)
 		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 09d701c0d046..e3955fa59734 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -105,6 +105,13 @@ struct npc_subbank {
 	u8 key_type;	/*NPC_MCAM_KEY_X4 or NPC_MCAM_KEY_X2 */
 };
 
+struct npc_defrag_show_node {
+	u16 old_midx;
+	u16 new_midx;
+	u16 vidx;
+	struct list_head list;
+};
+
 struct npc_priv_t {
 	int bank_depth;
 	const int num_banks;
@@ -118,6 +125,10 @@ struct npc_priv_t {
 	struct xarray xa_idx2pf_map;	/* Mcam idxes to pf map. */
 	struct xarray xa_pf_map;	/* pcifunc to index map. */
 	struct xarray xa_pf2dfl_rmap;	/* pcifunc to default rule index */
+	struct xarray xa_idx2vidx_map;	/* mcam idx to virtual index map. */
+	struct xarray xa_vidx2idx_map;	/* mcam vidx to index map. */
+	struct list_head defrag_lh;	/* defrag list head for debugfs */
+	struct mutex lock;		/* lock */
 	int pf_cnt;
 	bool init_done;
 };
@@ -212,7 +223,7 @@ void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
 
 int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 			    int prio, u16 *mcam_idx, int ref, int limit,
-			    bool contig, int count);
+			    bool contig, int count, bool virt);
 int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
 int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
 const int *npc_cn20k_search_order_get(bool *restricted_order);
@@ -245,5 +256,8 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
 				int bank, int index);
 int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
+u16 npc_cn20k_vidx2idx(u16 index);
+u16 npc_cn20k_idx2vidx(u16 idx);
+int npc_cn20k_defrag(struct rvu *rvu);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 34c960b84a65..05de319f5e51 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -297,6 +297,9 @@ M(NPC_CN20K_MCAM_READ_ENTRY,	0x6019, npc_cn20k_mcam_read_entry,	\
 				  npc_cn20k_mcam_read_entry_rsp)	\
 M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601a, npc_cn20k_read_base_steer_rule,            \
 				   msg_req, npc_cn20k_mcam_read_base_rule_rsp)  \
+M(NPC_MCAM_DEFRAG,	     0x601b,	npc_defrag,			\
+					msg_req,			\
+					msg_rsp)			\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1553,6 +1556,7 @@ struct npc_mcam_alloc_entry_req {
 	u16 ref_entry;
 	u16 count;    /* Number of entries requested */
 	u8 kw_type; /* entry key type, valid for cn20k */
+	u8 virt;    /* Request virtual index */
 };
 
 struct npc_mcam_alloc_entry_rsp {
@@ -1688,6 +1692,7 @@ struct npc_cn20k_mcam_alloc_and_write_entry_req {
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u8  virt;	 /* Allocate virtual index */
 	u16 reserved[4]; /* reserved for future use */
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 0f9953eaf1b0..cc83d4fc5724 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -11,6 +11,7 @@
 #include "rvu_reg.h"
 #include "rvu_struct.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/npc.h"
 
 #define DRV_NAME "octeontx2-af"
 
@@ -1256,9 +1257,66 @@ enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
+static int rvu_af_npc_defrag_feature_get(struct devlink *devlink, u32 id,
+					 struct devlink_param_gset_ctx *ctx,
+					 struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	bool enabled;
+
+	enabled = is_cn20k(rvu->pdev);
+
+	snprintf(ctx->val.vstr, sizeof(ctx->val.vstr), "%s",
+		 enabled ? "enabled" : "disabled");
+
+	return 0;
+}
+
+static int rvu_af_npc_defrag(struct devlink *devlink, u32 id,
+			     struct devlink_param_gset_ctx *ctx,
+			     struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+
+	npc_cn20k_defrag(rvu);
+
+	return 0;
+}
+
+static int rvu_af_npc_defrag_feature_validate(struct devlink *devlink, u32 id,
+					      union devlink_param_value val,
+					      struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	u64 enable;
+
+	if (kstrtoull(val.vstr, 10, &enable)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only 1 value is supported");
+		return -EINVAL;
+	}
+
+	if (enable != 1) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only initiating defrag is supported");
+		return -EINVAL;
+	}
+
+	if (is_cn20k(rvu->pdev))
+		return 0;
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "Can defrag NPC only in cn20k silicon");
+	return -EFAULT;
+}
+
 static int rvu_af_npc_exact_feature_get(struct devlink *devlink, u32 id,
 					struct devlink_param_gset_ctx *ctx,
 					struct netlink_ext_ack *extack)
@@ -1561,6 +1619,15 @@ static const struct devlink_ops rvu_devlink_ops = {
 	.eswitch_mode_set = rvu_devlink_eswitch_mode_set,
 };
 
+static const struct devlink_param rvu_af_dl_param_defrag[] = {
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
+			     "npc_defrag", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_npc_defrag_feature_get,
+			     rvu_af_npc_defrag,
+			     rvu_af_npc_defrag_feature_validate),
+};
+
 int rvu_register_dl(struct rvu *rvu)
 {
 	struct rvu_devlink *rvu_dl;
@@ -1593,6 +1660,17 @@ int rvu_register_dl(struct rvu *rvu)
 		goto err_dl_health;
 	}
 
+	if (is_cn20k(rvu->pdev)) {
+		err = devlink_params_register(dl, rvu_af_dl_param_defrag,
+					      ARRAY_SIZE(rvu_af_dl_param_defrag));
+		if (err) {
+			dev_err(rvu->dev,
+				"devlink defrag params register failed with error %d",
+				err);
+			goto err_dl_exact_match;
+		}
+	}
+
 	/* Register exact match devlink only for CN10K-B */
 	if (!rvu_npc_exact_has_match_table(rvu))
 		goto done;
@@ -1601,7 +1679,8 @@ int rvu_register_dl(struct rvu *rvu)
 				      ARRAY_SIZE(rvu_af_dl_param_exact_match));
 	if (err) {
 		dev_err(rvu->dev,
-			"devlink exact match params register failed with error %d", err);
+			"devlink exact match params register failed with error %d",
+			err);
 		goto err_dl_exact_match;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index fdc6792df7bb..d36291abcbc0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2454,7 +2454,7 @@ static void npc_unmap_mcam_entry_and_cntr(struct rvu *rvu,
  * reverse bitmap too. Should be called with
  * 'mcam->lock' held.
  */
-static void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index)
+void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index)
 {
 	u16 entry, rentry;
 
@@ -2470,7 +2470,7 @@ static void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index)
  * reverse bitmap too. Should be called with
  * 'mcam->lock' held.
  */
-static void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
+void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
 {
 	u16 entry, rentry;
 
@@ -2689,7 +2689,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	ret = npc_cn20k_ref_idx_alloc(rvu, pcifunc, req->kw_type,
 				      req->ref_prio, rsp->entry_list,
 				      req->ref_entry, limit,
-				      req->contig, req->count);
+				      req->contig, req->count, !!req->virt);
 
 	if (ret) {
 		rsp->count = 0;
@@ -2709,7 +2709,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	mutex_lock(&mcam->lock);
 	/* Mark the allocated entries as used and set nixlf mapping */
 	for (entry = 0; entry < rsp->count; entry++) {
-		index = rsp->entry_list[entry];
+		index = npc_cn20k_vidx2idx(rsp->entry_list[entry]);
 		npc_mcam_set_bit(mcam, index);
 		mcam->entry2pfvf_map[index] = pcifunc;
 		mcam->entry2cntr_map[index] = NPC_MCAM_INVALID_MAP;
@@ -3021,6 +3021,8 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
 	int blkaddr, rc = 0;
 	u16 cntr;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3151,6 +3153,8 @@ int rvu_mbox_handler_npc_mcam_ena_entry(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, rc;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3174,6 +3178,8 @@ int rvu_mbox_handler_npc_mcam_dis_entry(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, rc;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3208,8 +3214,8 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 
 	mutex_lock(&mcam->lock);
 	for (index = 0; index < req->shift_count; index++) {
-		old_entry = req->curr_entry[index];
-		new_entry = req->new_entry[index];
+		old_entry = npc_cn20k_vidx2idx(req->curr_entry[index]);
+		new_entry = npc_cn20k_vidx2idx(req->new_entry[index]);
 
 		/* Check if both old and new entries are valid and
 		 * does belong to this PFFUNC or not.
@@ -3251,7 +3257,7 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 	/* If shift has failed then report the failed index */
 	if (index != req->shift_count) {
 		rc = NPC_MCAM_PERM_DENIED;
-		rsp->failed_entry_idx = index;
+		rsp->failed_entry_idx = npc_cn20k_idx2vidx(index);
 	}
 
 	mutex_unlock(&mcam->lock);
@@ -3831,6 +3837,8 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	index = req->entry & (mcam->banksize - 1);
 	bank = npc_get_bank(mcam, req->entry);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
index 346e6ada158e..83c5e32e2afc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -16,4 +16,6 @@ void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
 int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
 			  u64 *size);
 
+void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index);
+void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index);
 #endif /* RVU_NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index bf7b21de436b..21adfd87785b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1638,6 +1638,8 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	bool enable = true;
 	u16 target;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
 		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
@@ -1791,6 +1793,10 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 	struct list_head del_list;
 	int blkaddr;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+	req->start = npc_cn20k_vidx2idx(req->start);
+	req->end = npc_cn20k_vidx2idx(req->end);
+
 	INIT_LIST_HEAD(&del_list);
 
 	mutex_lock(&mcam->lock);
-- 
2.43.0


