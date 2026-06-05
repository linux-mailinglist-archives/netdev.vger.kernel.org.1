Return-Path: <netdev+bounces-295658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gI7pGpR0ImqGXgEAu9opvQ
	(envelope-from <netdev+bounces-295658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:02:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA81645BC8
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:02:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Fhh6orLo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295658-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AEE03037BED
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCC43DA43;
	Fri,  5 Jun 2026 07:00:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886443E4B4;
	Fri,  5 Jun 2026 07:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642843; cv=none; b=o+yGRzjp+mKhnmTVqMfR97rmBJLstLzzphqcKv/BE/+UJlSQie336nzrZSCZ1bk2FWsxdurtd98lmmjlK4F63e760cuUGLtPBAZWE4yIHiZJO6W8Fi21alKTXIGBYaf8BTBDPXJlxAkWXOWyKoSci02ULewW9dAkDTHYkuoQy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642843; c=relaxed/simple;
	bh=NABlmMVEQU+zULkHS7DYTl05mNhWBxJ2FUTVvu8Wp0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGKkfEFtxLQgo+yRfC8P0oxKdaAdphJyJCVxNP3CHFM7SFPY07LeuHZOoaZ1ijKGkcUXmdYaNTOYi6cjZuEpnxBQsPE9JWz81eptIc6FvvO5LW0euJFp6Om1Bb5vVIX8/sSEZzc7EDSzR87Sid9MWK4cXNQu87N2TROIGLEbY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Fhh6orLo; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NRpZg1932966;
	Fri, 5 Jun 2026 00:00:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	RJpo/sEPFpn8lmG25ihcflqZeqSgefqTUNjp78tjt8=; b=Fhh6orLo7Ix0Zunoh
	LYNTdrofNas3ATK3PY+negvrHIdaL8HQYWv99B8U+dvW6/8tS5uvIE1zUas3tvcc
	aqqh/BehBCSMBLtbH5HA3LSqWQGIUq9UDiiipXy4sv7vExp8rD7v+F9yUWC/6rsP
	DUXAFXX9jVPjbjmB45RvAKWcJZEiwd9+194GQLJS2UwovKNbDsnk+NYXwjka6xAm
	7M1AkGgURahEwWPpuce/4V5DRmZpZKS95BAwjSoc3yWW9zTLd8ohpAojWngPb8eM
	RYkS4mJY9Fh5fC86eDG56pobFSmdAkCWJNtUuWia18/O7uKeFqQUN6wtZ6VLqfMs
	s3ovw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ekk2911mw-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 00:00:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:59:50 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 23:33:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 23:33:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 88AC43F7074;
	Thu,  4 Jun 2026 23:33:17 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v19 net-next 5/9] octeontx2-af: npc: cn20k: add subbank search order control
Date: Fri, 5 Jun 2026 12:02:41 +0530
Message-ID: <20260605063245.3553861-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605063245.3553861-1-rkannoth@marvell.com>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MOlQXsZl c=1 sm=1 tr=0 ts=6a227410 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=z2PpVAnn9QbhSI22PBIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: zIhZr49SWeyzMPiD4L36fb98IiLyqN6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2NCBTYWx0ZWRfX9NOKPywuUlu3
 otKlzD24O596UrdnKVJH22indCfgnI2RYmufOkeiVeVT02zzRgSv3qJhJaQLv1oEmj63wxbLzM2
 5+ABPBdvGvwOWCtiM69W7q+zCkd8UMVzFAtYlRCRFteyJ/FcGXTO/5hzNZK6rhi51CpsJsr16gu
 Xz2pC0bBwUNf08sqN4d8FrSiaG6X0B1IDc6/hWCRr0ERdW/czxwL3xiCHI1F8JoBWlAdvflL2oX
 1PfGYXqZmTBvBnGqSHoS596exb+jpKr3tq7nKbiVuLczmUZ6dL+JM7wJwwgcDydyKorFk1Z7TdY
 z79M1c8Iwh1/mShpI6MxYrC6k/MxPURAP4xOyi4V13Mi6Q8gRxQfG/isQOe7q6MYOdhJLrxJZYA
 Z6ngdWdosyvZJgs5bRhxxvnP6ez4TwCut3c2fRh9dc6jrC7z2G04hhjbdtz4SFqAaGRGHQ8Vefr
 PgfZhR9BjM5Mc/7y3xQ==
X-Proofpoint-GUID: zIhZr49SWeyzMPiD4L36fb98IiLyqN6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295658-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFA81645BC8

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
index 31eaaceb8766..2705753c1878 100644
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


