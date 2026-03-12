Return-Path: <netdev+bounces-266865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oADUJtMlsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:32:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9526C407
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BF8B30CCD44
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0393750DD;
	Thu, 12 Mar 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hJfXlTrT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AF375AA5;
	Thu, 12 Mar 2026 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282517; cv=none; b=esZxlS6XPQ8LrUvfjLjqunOx15QYefRBUs+IrVl6k95kcWDBcA9UF/BP3/sAMa4B9aWBrE8NRHKwo962q3TKOUwrW3iRUG/HTSZ96qnrUWf/grpuEibsY/V7XPYvSdr4l4wyVQJ/dGLuWKBBwThjxno4p/yWMoLpBU/lIioZv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282517; c=relaxed/simple;
	bh=cnT4FeVrQOKHtH3NF/Jj3Lk2KGkZJIAI9qJ9ngxwrOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7AfV4Y4nYDEoBXU7Drn51eCqTZpKKipniL3mEgXdZw5xGHoV88ISgE9u6eRHfzudAmeaTw89MSdty4EuKroHIuHqUhgFypokwM8FaYYbqpWpGUeFKnFLVuvpAsSTe4KANeVYwWcg9kPEpLKDhylL+4qQ0yDEAaWsznpZxCxHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hJfXlTrT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMUJt63349918;
	Wed, 11 Mar 2026 19:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	H4/l1iUbKlyWFcYg7vMo8j6h80/6gwyM7NFtsEERjo=; b=hJfXlTrT1efZHOn3t
	XsO93bQyvlu/Te98IHN6oObDvocrs3KLpoePieVbTQwsmvtyJhF+aCNMW3uhqgIv
	YTtgMASi62wcXVTXgKv2BaUUdf2hSNUHcoyzblCagwM8G3L7hOx6VS6h06Z8HeDo
	HAxeCvS3wYR9TAGkddOvDJyhqW+19h/tpTOqNtnhlnxX69ZVn3lfeTBd5rp3reC6
	Jb+z3CMVS6CJJBRoibZCXrLOw72DndKO0BZcLXRUaWaeLoUM4qn9SirwYO91s+L/
	bRwM4eBTbMMTgvBDn/2UbsNFQvEhf0CCB1qMVt8vL/MuQyOsYn0Ww/xzOR0zyFLL
	SXhkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cuh7q0f1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 19:28:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Mar 2026 19:28:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 11 Mar 2026 19:28:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3607F3F705B;
	Wed, 11 Mar 2026 19:28:16 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 3/5] octeontx2-af: npc: cn20k: add subbank search order control
Date: Thu, 12 Mar 2026 07:57:52 +0530
Message-ID: <20260312022754.2029595-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312022754.2029595-1-rkannoth@marvell.com>
References: <20260312022754.2029595-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QZtrf8bv c=1 sm=1 tr=0 ts=69b224c6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=Kwk0B_gUNWffwnM1zl4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Bi6JWkusSCIunRajMds4RlbEl0Nue50d
X-Proofpoint-ORIG-GUID: Bi6JWkusSCIunRajMds4RlbEl0Nue50d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAxNyBTYWx0ZWRfX+cNBan7ywxvF
 YS6yGORPOhhZWhUAEqN+VzXMHS8OxxGEhUZXpFQP/rr4XN9XlyD6ol0PHSnlwgYMfG2kQAUVx0D
 csT6SjU0KVFAIOwasr4BW2lE3QcS5rpW6rdfHt2KqPkPurTij9DqzWS1zOP74P/+p3dpnU2/aDB
 nb2RTrReKEDCuFuxsEaQmfBLzVjBwAznZr8i9/Q/TRCcvbKmgZgJpv/v3lDf6/riZa4Uok+OE9s
 m3QMHB8exs5XPPjhsvMxhdZE8cY7HxuCop/rbMlJghV40QrTBWZfzWMwxZNWDIUtwstDJvuyO4b
 OBilhxkF8pZLMfjFaOf3a3+JMLJDTILTjV8/z5IY1d82WJhz/wK1HeSZgIdaztDoK/iuwHvYwxh
 yr+sxyEVvY4fR3HB+S9OoeeEK5m1VMoxDiiS3UkhUvGaNYySjY832n96md+QbHTHchVFqhMz6XY
 v/qy+4hyt+LrTH/C4wQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
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
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266865-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 04F9526C407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CN20K NPC MCAM is split into 32 subbanks that are searched in a
predefined order during allocation. Lower-numbered subbanks have
higher priority than higher-numbered ones.

Add a runtime devlink parameter "srch_order" (
DEVLINK_PARAM_TYPE_U32_ARRAY) to control the order in which
subbanks are searched during MCAM allocation.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 87 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  2 +
 .../marvell/octeontx2/af/rvu_devlink.c        | 92 +++++++++++++++++--
 3 files changed, 171 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index e854b85ced9e..348a72c4ee43 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3809,6 +3809,93 @@ static void npc_unlock_all_subbank(void)
 		mutex_unlock(&npc_priv.sb[i].lock);
 }
 
+int npc_cn20k_search_order_set(struct rvu *rvu,
+			       u32 arr[MAX_NUM_SUB_BANKS], int cnt)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u32 fslots[MAX_NUM_SUB_BANKS][2];
+	u32 uslots[MAX_NUM_SUB_BANKS][2];
+	int fcnt = 0, ucnt = 0;
+	struct npc_subbank *sb;
+	int idx, val, rc = 0;
+
+	unsigned long index;
+	void *v;
+
+	if (cnt != npc_priv.num_subbanks) {
+		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
+			cnt, npc_priv.num_subbanks);
+		return -EINVAL;
+	}
+
+	mutex_lock(&mcam->lock);
+	npc_lock_all_subbank();
+	restrict_valid = false;
+
+	for (int i = 0; i < cnt; i++)
+		subbank_srch_order[i] = arr[i];
+
+	xa_for_each(&npc_priv.xa_sb_used, index, v) {
+		val = xa_to_value(v);
+		uslots[ucnt][0] = index;
+		uslots[ucnt][1] = val;
+		xa_erase(&npc_priv.xa_sb_used, index);
+		ucnt++;
+	}
+
+	xa_for_each(&npc_priv.xa_sb_free, index, v) {
+		val = xa_to_value(v);
+		fslots[fcnt][0] = index;
+		fslots[fcnt][1] = val;
+		xa_erase(&npc_priv.xa_sb_free, index);
+		fcnt++;
+	}
+
+	/* xa_store() is done under lock. If xa_store fails
+	 * ,no rollback is planned as it might also fail.
+	 */
+	for (int i = 0; i < ucnt; i++) {
+		idx  = uslots[i][1];
+		sb = &npc_priv.sb[idx];
+		sb->arr_idx = subbank_srch_order[sb->idx];
+		rc = xa_err(xa_store(&npc_priv.xa_sb_used, sb->arr_idx,
+				     xa_mk_value(sb->idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"Error to insert index to used list %u\n",
+				sb->idx);
+			goto fail_used;
+		}
+	}
+
+	for (int i = 0; i < fcnt; i++) {
+		idx  = fslots[i][1];
+		sb = &npc_priv.sb[idx];
+		sb->arr_idx = subbank_srch_order[sb->idx];
+		rc = xa_err(xa_store(&npc_priv.xa_sb_free, sb->arr_idx,
+				     xa_mk_value(sb->idx), GFP_KERNEL));
+		if (rc) {
+			dev_err(rvu->dev,
+				"Error to insert index to free list %u\n",
+				sb->idx);
+			goto fail_used;
+		}
+	}
+
+fail_used:
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
index 004a556c7b90..b168ecfbc5c8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -343,5 +343,7 @@ int npc_cn20k_defrag(struct rvu *rvu);
 int npc_mcam_idx_2_subbank_idx(struct rvu *rvu, u16 mcam_idx,
 			       struct npc_subbank **sb,
 			       int *sb_off);
+const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz);
+int npc_cn20k_search_order_set(struct rvu *rvu, u32 arr[32], int cnt);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 287ff0eda152..420cda6d5d5f 100644
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
+					  ctx->val.u32arr.val,
+					  ctx->val.u32arr.size);
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
+	ctx->val.u32arr.size = sz;
+	for (int i = 0; i < sz; i++)
+		ctx->val.u32arr.val[i] = order[i];
+
+	return 0;
+}
+
+static int rvu_af_dl_npc_srch_order_validate(struct devlink *devlink, u32 id,
+					     union devlink_param_value val,
+					     struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	bool restricted_order;
+	unsigned long w = 0;
+	u32 *arr;
+	u32 sz;
+
+	npc_cn20k_search_order_get(&restricted_order, &sz);
+	if (sz != val.u32arr.size) {
+		dev_err(rvu->dev,
+			"Wrong size %u, should be %u\n",
+			val.u32arr.size, sz);
+		return -EINVAL;
+	}
+
+	arr = val.u32arr.val;
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
+			     "npc_srch_order", DEVLINK_PARAM_TYPE_U32_ARRAY,
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


