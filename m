Return-Path: <netdev+bounces-293511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PBILaL1HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0FE618FED
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BC3C3005998
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2A23815B;
	Mon,  1 Jun 2026 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LukZnaMp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B28823DE;
	Mon,  1 Jun 2026 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282780; cv=none; b=b2aK3ytA5AxQILJh75vbOFJCfyOmCZ+eRXr1WaxyUnToM+KrUIyfSl+OULNpAE6XyH6wKznrpk2UPZNMxib6Que/H7/VB69X6Pop5IcsPtnG/e8MHxS8/oX/PYECgoZCfNv/6VM4aAvzaje1/4RB0FtraAv/uv5m590GWo2yits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282780; c=relaxed/simple;
	bh=0Uc4HZZ/amh/L1HZx+8wzX1hV3BXfjY9hKApm14BU2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYVTl8tzkpCDwOBVFW08chp77TDaGYl9Ulo818n1QWTkR0YygAyWf8ziqmsWvl6K/6aszBGKPFWcjAb8TAEYn0y54H+BVTtB8daShvTTFKfs0dLzjU7GaZvrqPiL6TrCLVKHCOk93aBQae7/5w0Od1YmVYpmTicCt6w4LbaXU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LukZnaMp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VN0LYk3439390;
	Sun, 31 May 2026 19:59:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	qpD76Emr4W2fH2Jq6Djdx2fKfho0CqSwFqYbXsyli0=; b=LukZnaMpfH8s+HH/4
	2Ot0qdxaTsWUMwKn7c912SYZMKR/Kh6/hva0g0k4oKGsyAPXZ23ZQn8GZuwYA9dF
	ovHR/acCOznKE4IhAgiWLpZo1e6yKrJJtaL6cwETfQlXxEvT4OY7F3ElxOQIWZO4
	pliJ5rRBuAxCpoMnwS3mbG4guFRnWAwNUUMpWU48PDgcSVpUK9gwXWanXNojSWDw
	9a5bBUz3zcSHGsL8uSqguNlpdCxmSzDIOhU+uEvI/4mUfk33gVhCTBBt+UkvX6Yd
	bWk2TGjixG0TGIRZBi+JFp61A0SRgtXzHYM2NRflGFHMWp1/Re8RFudp62a42tow
	+8uKQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eggn8a4x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:59:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 31 May 2026 19:59:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 31 May 2026 19:59:30 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 67E513F7085;
	Sun, 31 May 2026 19:59:26 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v17 net-next 4/8] octeontx2-af: npc: cn20k: add subbank search order control
Date: Mon, 1 Jun 2026 08:28:39 +0530
Message-ID: <20260601025844.865865-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601025844.865865-1-rkannoth@marvell.com>
References: <20260601025844.865865-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eFNqfagdGa4UJQQc1nsCZ96KBQT0CTvA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAyOCBTYWx0ZWRfXwHwBs84W5LkE
 gwln+DlNu3ZHYoDIGx88/J0ifAK6lkf326rABdluedSXMHHskQ+X/0NpKeZUK64SUoHpjFDo77j
 80Zy4otowyEArrTgrNUQ86o4fDwcxvwII5BrAHJ2Mmevo1uuHkVTMVULUfSXKsx4KUhtqBsMqGQ
 DE5EBwPsM61KCrj8dsqk4ukpKe2abwF9faBj0fHsoM8GGujcSiKPkPtNORd6TCF/Zlbcy8s1s/7
 rL8qwPmc/Lv1Tzl5kLbX6Lm/G3JrweXQQM48majaSXvbgsjHn09cECzLOXOsa3j70zi8Q4Ls4rD
 5wcREllJfYDk/JFqPiB2D4Ny/o/Ou63pl4lFwwL3vpjyl0P+IqL/1ncCF9GDFRVdgUg6lrCh4Qq
 FzE16p5jownLjyB5hjH8Q8x7VmDvKupQQs88TqtEO6na4Nsci3PyGlCWgXpfRcQF3B95bZ4WX0x
 uabVmGS8sxacLUvpmAw==
X-Proofpoint-GUID: eFNqfagdGa4UJQQc1nsCZ96KBQT0CTvA
X-Authority-Analysis: v=2.4 cv=ON0XGyaB c=1 sm=1 tr=0 ts=6a1cf592 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=z2PpVAnn9QbhSI22PBIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293511-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4B0FE618FED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CN20K NPC MCAM is split into 32 subbanks that are searched in a
predefined order during allocation. Lower-numbered subbanks have
higher priority than higher-numbered ones.

Add a runtime "srch_order" to control the order in which
subbanks are searched during MCAM allocation.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 120 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   3 +
 .../marvell/octeontx2/af/rvu_devlink.c        |  92 ++++++++++++--
 3 files changed, 203 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 9fa9a589cf9c..0e1744609ccf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3376,7 +3376,7 @@ rvu_mbox_handler_npc_cn20k_get_kex_cfg(struct rvu *rvu,
 	return 0;
 }
 
-static int *subbank_srch_order;
+static u32 *subbank_srch_order;
 
 static void npc_populate_restricted_idxs(int num_subbanks)
 {
@@ -3388,7 +3388,7 @@ static int npc_create_srch_order(int cnt)
 {
 	int val = 0;
 
-	subbank_srch_order = kcalloc(cnt, sizeof(int),
+	subbank_srch_order = kcalloc(cnt, sizeof(u32),
 				     GFP_KERNEL);
 	if (!subbank_srch_order)
 		return -ENOMEM;
@@ -3906,6 +3906,122 @@ static void npc_unlock_all_subbank(void)
 		mutex_unlock(&npc_priv.sb[i].lock);
 }
 
+int npc_cn20k_search_order_set(struct rvu *rvu,
+			       u64 narr[MAX_NUM_SUB_BANKS], int cnt)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int rsrc[2][MAX_NUM_SUB_BANKS] = { };
+	u8 save[MAX_NUM_SUB_BANKS] = { };
+	struct npc_subbank *sb;
+	struct xarray *xa;
+	int prio, rc, err;
+	int sb_idx;
+	enum {
+		FREE = 0,
+		USED = 1,
+	};
+
+	if (cnt != npc_priv.num_subbanks) {
+		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
+			cnt, npc_priv.num_subbanks);
+		return -EINVAL;
+	}
+
+	mutex_lock(&mcam->lock);
+	npc_lock_all_subbank();
+
+	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
+		sb = &npc_priv.sb[sb_idx];
+		save[sb->idx] = sb->arr_idx;
+	}
+
+	for (prio = 0; prio < cnt; prio++) {
+		sb_idx = narr[prio];
+		sb = &npc_priv.sb[sb_idx];
+
+		if (sb->flags & NPC_SUBBANK_FLAG_USED)
+			xa = &npc_priv.xa_sb_used;
+		else
+			xa = &npc_priv.xa_sb_free;
+
+		rc = xa_err(xa_store(xa, prio,
+				     xa_mk_value(sb_idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"Setting arr_idx=%d for sb=%d failed\n",
+				sb->arr_idx, sb_idx);
+			goto fail;
+		}
+
+		if (sb->flags & NPC_SUBBANK_FLAG_USED) {
+			rsrc[USED][sb->arr_idx] -= 1;
+			rsrc[USED][prio] += 1;
+		} else {
+			rsrc[FREE][sb->arr_idx] -= 1;
+			rsrc[FREE][prio] += 1;
+		}
+
+		sb->arr_idx = prio;
+	}
+
+	for (prio = 0; prio < cnt; prio++) {
+		if (rsrc[FREE][prio] == -1)
+			xa_erase(&npc_priv.xa_sb_free, prio);
+
+		if (rsrc[USED][prio] == -1)
+			xa_erase(&npc_priv.xa_sb_used, prio);
+	}
+
+	for (int i = 0; i < cnt; i++)
+		subbank_srch_order[i] = (u32)narr[i];
+
+	restrict_valid = false;
+
+	npc_unlock_all_subbank();
+	mutex_unlock(&mcam->lock);
+
+	return 0;
+
+fail:
+	for (prio = 0; prio < cnt; prio++) {
+		if (rsrc[FREE][prio] == 1)
+			xa_erase(&npc_priv.xa_sb_free, prio);
+
+		if (rsrc[USED][prio] == 1)
+			xa_erase(&npc_priv.xa_sb_used, prio);
+	}
+
+	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
+		sb = &npc_priv.sb[sb_idx];
+		sb->arr_idx = save[sb_idx];
+
+		if (sb->flags & NPC_SUBBANK_FLAG_USED)
+			xa = &npc_priv.xa_sb_used;
+		else
+			xa = &npc_priv.xa_sb_free;
+
+		/* Since the entry already exists, xa_store() replaces
+		 * the value without a kmalloc(), making failure highly unlikely.
+		 */
+		err = xa_err(xa_store(xa, sb->arr_idx,
+				      xa_mk_value(sb->idx), GFP_KERNEL));
+		WARN(!!err, "Failed to rollback sb=%u idx=%u\n",
+		     sb->idx, sb->arr_idx);
+	}
+
+	npc_unlock_all_subbank();
+	mutex_unlock(&mcam->lock);
+
+	return rc;
+}
+
+const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
+{
+	*restricted_order = restrict_valid;
+	*sz = npc_priv.num_subbanks;
+	return subbank_srch_order;
+}
+
 /* Only non-ref non-contigous mcam indexes
  * are picked for defrag process
  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 3e851950be64..8bf857317e49 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -347,5 +347,8 @@ bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
 int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
 			       struct npc_subbank **sb,
 			       int *sb_off);
+const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz);
+int npc_cn20k_search_order_set(struct rvu *rvu, u64 narr[MAX_NUM_SUB_BANKS],
+			       int cnt);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index a42404e6db7c..aa3ecab5ebd8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1258,6 +1258,7 @@ enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_SRCH_ORDER,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
@@ -1619,12 +1620,83 @@ static int rvu_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	return 0;
 }
 
+static int rvu_af_dl_npc_srch_order_set(struct devlink *devlink, u32 id,
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+
+	return npc_cn20k_search_order_set(rvu,
+					  ctx->val.u64arr.val,
+					  ctx->val.u64arr.size);
+}
+
+static int rvu_af_dl_npc_srch_order_get(struct devlink *devlink, u32 id,
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
+{
+	bool restricted_order;
+	const u32 *order;
+	u32 sz;
+
+	order = npc_cn20k_search_order_get(&restricted_order, &sz);
+	ctx->val.u64arr.size = sz;
+	for (int i = 0; i < sz; i++)
+		ctx->val.u64arr.val[i] = order[i];
+
+	return 0;
+}
+
+static int rvu_af_dl_npc_srch_order_validate(struct devlink *devlink, u32 id,
+					     union devlink_param_value *val,
+					     struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	bool restricted_order;
+	unsigned long w = 0;
+	u64 *arr;
+	u32 sz;
+
+	npc_cn20k_search_order_get(&restricted_order, &sz);
+	if (sz != val->u64arr.size) {
+		dev_err(rvu->dev,
+			"Wrong size %llu, should be %u\n",
+			val->u64arr.size, sz);
+		return -EINVAL;
+	}
+
+	arr = val->u64arr.val;
+	for (int i = 0; i < sz; i++) {
+		if (arr[i] >= sz)
+			return -EINVAL;
+
+		w |= BIT_ULL(arr[i]);
+	}
+
+	if (bitmap_weight(&w, sz) != sz) {
+		dev_err(rvu->dev,
+			"Duplicate or out-of-range subbank index. %lu\n",
+			find_first_zero_bit(&w, sz));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct devlink_ops rvu_devlink_ops = {
 	.eswitch_mode_get = rvu_devlink_eswitch_mode_get,
 	.eswitch_mode_set = rvu_devlink_eswitch_mode_set,
 };
 
-static const struct devlink_param rvu_af_dl_param_defrag[] = {
+static const struct devlink_param rvu_af_dl_cn20k_params[] = {
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_SRCH_ORDER,
+			     "npc_srch_order", DEVLINK_PARAM_TYPE_U64_ARRAY,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_dl_npc_srch_order_get,
+			     rvu_af_dl_npc_srch_order_set,
+			     rvu_af_dl_npc_srch_order_validate),
 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
 			     "npc_defrag", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
@@ -1666,13 +1738,13 @@ int rvu_register_dl(struct rvu *rvu)
 	}
 
 	if (is_cn20k(rvu->pdev)) {
-		err = devlink_params_register(dl, rvu_af_dl_param_defrag,
-					      ARRAY_SIZE(rvu_af_dl_param_defrag));
+		err = devlink_params_register(dl, rvu_af_dl_cn20k_params,
+					      ARRAY_SIZE(rvu_af_dl_cn20k_params));
 		if (err) {
 			dev_err(rvu->dev,
-				"devlink defrag params register failed with error %d",
+				"devlink cn20k params register failed with error %d",
 				err);
-			goto err_dl_defrag;
+			goto err_dl_cn20k_params;
 		}
 	}
 
@@ -1695,10 +1767,10 @@ int rvu_register_dl(struct rvu *rvu)
 
 err_dl_exact_match:
 	if (is_cn20k(rvu->pdev))
-		devlink_params_unregister(dl, rvu_af_dl_param_defrag,
-					  ARRAY_SIZE(rvu_af_dl_param_defrag));
+		devlink_params_unregister(dl, rvu_af_dl_cn20k_params,
+					  ARRAY_SIZE(rvu_af_dl_cn20k_params));
 
-err_dl_defrag:
+err_dl_cn20k_params:
 	devlink_params_unregister(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
 
 err_dl_health:
@@ -1717,8 +1789,8 @@ void rvu_unregister_dl(struct rvu *rvu)
 	devlink_params_unregister(dl, rvu_af_dl_params, ARRAY_SIZE(rvu_af_dl_params));
 
 	if (is_cn20k(rvu->pdev))
-		devlink_params_unregister(dl, rvu_af_dl_param_defrag,
-					  ARRAY_SIZE(rvu_af_dl_param_defrag));
+		devlink_params_unregister(dl, rvu_af_dl_cn20k_params,
+					  ARRAY_SIZE(rvu_af_dl_cn20k_params));
 
 	/* Unregister exact match devlink only for CN10K-B */
 	if (rvu_npc_exact_has_match_table(rvu))
-- 
2.43.0


