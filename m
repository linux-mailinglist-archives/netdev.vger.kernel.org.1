Return-Path: <netdev+bounces-265365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMW0HLM1rmkuAgIAu9opvQ
	(envelope-from <netdev+bounces-265365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:51:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB88233633
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E7E5305F3D4
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA6280336;
	Mon,  9 Mar 2026 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jonrO4fN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8145279903;
	Mon,  9 Mar 2026 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024428; cv=none; b=H8gHrwrBrlOOdAegxZWcJZu/d6zwTwvAsLH0VlTzkfQcTQ9ksBsrVM87XZr9BlDNbyz873/VwBU4wOWHOj5WELAaktKZqHcwoYs7ySBdDMc0ZkwVC2O9YMPuoLX2cZIDlR5v80qV0SWMfJvLBX2ptKOBwCJlcJf14DcMqF5rNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024428; c=relaxed/simple;
	bh=00o2hAyhJxUc5Smp0yKOtW1lunKu+6CR+lu0EvimHVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5XoYdxFei8kerQ1hKAskT/b/tQ+fy0sQ5AWLCx/ly0g+snbE/MifqiBF0IyyNSu+RZgHpAw7io+exkiX7VizYM7aHOIiux9wMpzBY3B7UgU6gwclELjAoLlzZPA6P7jdGA/CAxPTVLtN2cxrWQJac3Ub2tz6OY5zOwzNPctfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jonrO4fN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628Ng7v13507751;
	Sun, 8 Mar 2026 19:46:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	6Ey/ZmBzedhUx+dGm4/mezYe+oopquIu4Dd9mGe3rw=; b=jonrO4fNOeW+xNqCt
	TvJXxSth0pAz+6sQjrZ7S8FN2f4NsyW2OqbjYev80JiWcZ+FgK2UkL+sk0mFa+r0
	pP9aa1YGjJrHKA9qweTJ8mFz8rdiXPZnPqHeFODRe5s9X4wNBebiDgbPnZeRVujd
	QuZdR6BimveCV0nPKmQfWnM0KLyr8CoNdXj/2q1e5cYZQBAbbiQ9fVn4aoTwKTw1
	GjYxaex8YmQUxetIJX0GpOrgTmx0mbdHHT4mAmGt8ju5L7hBGVXPY36cRk7DneDF
	VMch3fbroVdD1SANRDfytRYeVjAHtGxZixWfTcW+NvNghZWDj7c9RR1Q8JnU5+2t
	yGAaQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8qtf83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 19:46:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 8 Mar 2026 19:46:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 8 Mar 2026 19:46:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DAFF23F707D;
	Sun,  8 Mar 2026 19:46:52 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 5/5] octeontx2-af: Add support for loading custom KPU profile from filesystem
Date: Mon, 9 Mar 2026 08:16:19 +0530
Message-ID: <20260309024619.898211-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309024619.898211-1-rkannoth@marvell.com>
References: <20260309024619.898211-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAyNCBTYWx0ZWRfXxNfaDTHSmyeL
 f8N00ywIp1SfPZ2R7uEnUcXlQEg7lX6aLEjSTeys7tWha7gFAqQvgVhD6HfdzGwc/l/xGP1V/Y0
 O2PpOrHUiWlImG9aidKrY0xZvyfwC3dePSCgNZKlq6PWpVk3lWSWwYgGZNfa3kwLxmfWUIkfHC2
 E8x6h9kQAnwLGIRrqsrxw27bxDyiTn+Io7hnhUb7UnwWGbKV8AXdMtIfXihoEZCFRJ/+qDMEydP
 hSAKUjM3LlY8889AVr/ZCH7HISWFDsSfKctfiW1P/jBoaJKAXLdnXwgt8qAeQ0eJFxqWEJOhVwb
 wRUEFlt79wBMix29+GfqcxnnnVHomj9tBsuX6w65sOJwv/zpEcXsRmE6bLvPosBuEOq9pmW7li1
 V6JZFljutzYtFv6Z6xU9JciMX8+wP1VFhW/hr+0GWAkzjOQR0J9N8kN7Xw5bF9hxsWirDhZLbGf
 XLZ9v+UxAoEfxIT/oTg==
X-Proofpoint-GUID: lJq_dLBQy5mO-UbHKh252YpoMeQt88FN
X-Proofpoint-ORIG-GUID: lJq_dLBQy5mO-UbHKh252YpoMeQt88FN
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69ae34a1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=wlbaZ-2X3v7ZcC-DwWoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_01,2026-03-06_02,2025-10-01_01
X-Rspamd-Queue-Id: BCB88233633
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-265365-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Flashing updated firmware on deployed devices is cumbersome. Provide a
mechanism to load a custom KPU (Key Parse Unit) profile directly from
the filesystem at module load time.

When the rvu_af module is loaded with the kpu_profile parameter, the
specified profile is read from /lib/firmware/kpu and programmed into
the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
used by filesystem-loaded profiles and support ptype/ptype_mask in
npc_config_kpucam when profile->from_fs is set.

Usage:
  1. Copy the KPU profile file to /lib/firmware/kpu.
  2. Build OCTEONTX2_AF as a module.
  3. Load: insmod rvu_af.ko kpu_profile=<profile_name>

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  14 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   5 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 180 +++++++++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 4 files changed, 169 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index cefc5d70f3e4..5928c4d3cc8b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -265,6 +265,19 @@ struct npc_kpu_profile_cam {
 	u16 dp2_mask;
 } __packed;
 
+struct npc_kpu_profile_cam2 {
+	u8 state;
+	u8 state_mask;
+	u16 dp0;
+	u16 dp0_mask;
+	u16 dp1;
+	u16 dp1_mask;
+	u16 dp2;
+	u16 dp2_mask;
+	u8 ptype;
+	u8 ptype_mask;
+} __packed;
+
 struct npc_kpu_profile_action {
 	u8 errlev;
 	u8 errcode;
@@ -290,6 +303,7 @@ struct npc_kpu_profile {
 	int action_entries;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_profile_action *action;
+	struct npc_kpu_profile_cam2 *cam2;
 };
 
 /* NPC KPU register formats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf908..1efc53b63b67 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -553,8 +553,8 @@ struct npc_kpu_profile_adapter {
 	const char			*name;
 	u64				version;
 	const struct npc_lt_def_cfg	*lt_def;
-	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
-	const struct npc_kpu_profile	*kpu; /* array[kpus] */
+	struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
+	struct npc_kpu_profile	*kpu; /* array[kpus] */
 	union npc_mcam_key_prfl {
 		struct npc_mcam_kex		*mkex;
 					/* used for cn9k and cn10k */
@@ -564,6 +564,7 @@ struct npc_kpu_profile_adapter {
 	bool				custom;
 	size_t				pkinds;
 	size_t				kpus;
+	bool				from_fs;
 };
 
 #define RVU_SWITCH_LBK_CHAN	63
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 352dc5f1d5b9..05aabe26f030 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1583,8 +1583,12 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpu, int entry)
 {
+	const struct npc_kpu_profile_cam2 *kpucam2 = (void *)kpucam;
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	struct npc_kpu_cam cam0 = {0};
 	struct npc_kpu_cam cam1 = {0};
+	u64 *val = (u64 *)&cam1;
+	u64 *mask = (u64 *)&cam0;
 
 	cam1.state = kpucam->state & kpucam->state_mask;
 	cam1.dp0_data = kpucam->dp0 & kpucam->dp0_mask;
@@ -1596,6 +1600,14 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 	cam0.dp1_data = ~kpucam->dp1 & kpucam->dp1_mask;
 	cam0.dp2_data = ~kpucam->dp2 & kpucam->dp2_mask;
 
+	if (profile->from_fs) {
+		u8 ptype = kpucam2->ptype;
+		u8 pmask = kpucam2->ptype_mask;
+
+		*val |= FIELD_PREP(GENMASK_ULL(57, 56), ptype & pmask);
+		*mask |= FIELD_PREP(GENMASK_ULL(57, 56), ~ptype & pmask);
+	}
+
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_KPUX_ENTRYX_CAMX(kpu, entry, 0), *(u64 *)&cam0);
 	rvu_write64(rvu, blkaddr,
@@ -1610,6 +1622,7 @@ u64 npc_enable_mask(int count)
 static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 				    const struct npc_kpu_profile *profile)
 {
+	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
 	int entry, num_entries, max_entries;
 	u64 entry_mask;
 
@@ -1621,10 +1634,15 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 
 	max_entries = rvu->hw->npc_kpu_entries;
 
+	WARN(profile->cam_entries > max_entries,
+	     "KPU%u: err: hw max entries=%u, input entries=%u\n",
+	     kpu,  rvu->hw->npc_kpu_entries, profile->cam_entries);
+
 	/* Program CAM match entries for previous KPU extracted data */
 	num_entries = min_t(int, profile->cam_entries, max_entries);
 	for (entry = 0; entry < num_entries; entry++)
 		npc_config_kpucam(rvu, blkaddr,
+				  adapter->from_fs ? (void *)&profile->cam2[entry] :
 				  &profile->cam[entry], kpu, entry);
 
 	/* Program this KPU's actions */
@@ -1678,26 +1696,50 @@ static void npc_prepare_default_kpu(struct rvu *rvu,
 	npc_cn20k_update_action_entries_n_flags(rvu, profile);
 }
 
+static int npc_alloc_kpu_cam2_n_action(struct rvu *rvu, int kpu_num,
+				       int num_entries)
+{
+	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
+	struct npc_kpu_profile *kpu;
+
+	kpu = &adapter->kpu[kpu_num];
+
+	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
+				 sizeof(*kpu->cam2), GFP_KERNEL);
+	if (!kpu->cam2)
+		return -ENOMEM;
+
+	kpu->action = devm_kcalloc(rvu->dev, num_entries,
+				   sizeof(*kpu->action), GFP_KERNEL);
+	if (!kpu->action)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int npc_apply_custom_kpu(struct rvu *rvu,
-				struct npc_kpu_profile_adapter *profile)
+				struct npc_kpu_profile_adapter *profile,
+				bool from_fs)
 {
 	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
 	struct npc_kpu_profile_action *action;
+	struct npc_kpu_profile_fwdata *sfw;
 	struct npc_kpu_profile_fwdata *fw;
+	struct npc_kpu_profile_cam2 *cam2;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_fwdata *fw_kpu;
-	int entries;
+	int entries, ret;
 	u16 kpu, entry;
 
 	if (is_cn20k(rvu->pdev))
 		return npc_cn20k_apply_custom_kpu(rvu, profile);
 
-	fw = rvu->kpu_fwdata;
-
 	if (rvu->kpu_fwdata_sz < hdr_sz) {
 		dev_warn(rvu->dev, "Invalid KPU profile size\n");
 		return -EINVAL;
 	}
+
+	fw = rvu->kpu_fwdata;
 	if (le64_to_cpu(fw->signature) != KPU_SIGN) {
 		dev_warn(rvu->dev, "Invalid KPU profile signature %llx\n",
 			 fw->signature);
@@ -1731,31 +1773,80 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
 		return -EINVAL;
 	}
 
+	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
+	if (!sfw)
+		return -ENOMEM;
+
+	memcpy(sfw, fw, sizeof(*sfw));
+
 	profile->custom = 1;
-	profile->name = fw->name;
+	profile->name = sfw->name;
 	profile->version = le64_to_cpu(fw->version);
-	profile->mcam_kex_prfl.mkex = &fw->mkex;
-	profile->lt_def = &fw->lt_def;
+	profile->mcam_kex_prfl.mkex = &sfw->mkex;
+	profile->lt_def = &sfw->lt_def;
+
+	/* Binary blob contains ikpu actions entries at start of data[0] */
+	if (from_fs) {
+		action = (struct npc_kpu_profile_action *)(fw->data + offset);
+
+		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
+			return -ENOMEM;
+
+		memcpy((void *)profile->ikpu, action, sizeof(ikpu_action_entries));
+		offset += sizeof(ikpu_action_entries);
+	}
 
 	for (kpu = 0; kpu < fw->kpus; kpu++) {
 		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
-		if (fw_kpu->entries > KPU_MAX_CST_ENT)
-			dev_warn(rvu->dev,
-				 "Too many custom entries on KPU%d: %d > %d\n",
-				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
-		entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
-		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
-		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
+		if (!from_fs) {
+			if (fw_kpu->entries > KPU_MAX_CST_ENT)
+				dev_warn(rvu->dev,
+					 "Too many custom entries on KPU%d: %d > %d\n",
+					 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
+			entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
+			cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
+			offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
+			action = (struct npc_kpu_profile_action *)(fw->data + offset);
+			offset += fw_kpu->entries * sizeof(*action);
+			if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
+				dev_warn(rvu->dev,
+					 "Profile size mismatch on KPU%i parsing.\n",
+					 kpu + 1);
+				return -EINVAL;
+			}
+			for (entry = 0; entry < entries; entry++) {
+				profile->kpu[kpu].cam[entry] = cam[entry];
+				profile->kpu[kpu].action[entry] = action[entry];
+			}
+			continue;
+		}
+		entries = fw_kpu->entries;
+		dev_info(rvu->dev,
+			 "Loading %u entries on KPU%d\n", entries, kpu);
+
+		cam2 = (struct npc_kpu_profile_cam2 *)fw_kpu->data;
+		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam2);
 		action = (struct npc_kpu_profile_action *)(fw->data + offset);
 		offset += fw_kpu->entries * sizeof(*action);
 		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
 			dev_warn(rvu->dev,
-				 "Profile size mismatch on KPU%i parsing.\n",
+				 "profile size mismatch on kpu%i parsing.\n",
 				 kpu + 1);
 			return -EINVAL;
 		}
+
+		profile->kpu[kpu].cam_entries = entries;
+		profile->kpu[kpu].action_entries = entries;
+		ret = npc_alloc_kpu_cam2_n_action(rvu, kpu, entries);
+		if (ret) {
+			dev_warn(rvu->dev,
+				 "profile entry allocation failed for kpu=%d for %d entries\n",
+				 kpu, entries);
+			return -EINVAL;
+		}
+
 		for (entry = 0; entry < entries; entry++) {
-			profile->kpu[kpu].cam[entry] = cam[entry];
+			profile->kpu[kpu].cam2[entry] = cam2[entry];
 			profile->kpu[kpu].action[entry] = action[entry];
 		}
 	}
@@ -1853,7 +1944,10 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	const char *kpu_profile = rvu->kpu_pfl_name;
 	const struct firmware *fw = NULL;
-	bool retry_fwdb = false;
+	int len, ret;
+	char *path;
+
+	profile->from_fs = false;
 
 	/* If user not specified profile customization */
 	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
@@ -1866,27 +1960,53 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	 * Firmware database method.
 	 * Default KPU profile.
 	 */
-	if (!request_firmware_direct(&fw, kpu_profile, rvu->dev)) {
-		dev_info(rvu->dev, "Loading KPU profile from firmware: %s\n",
-			 kpu_profile);
+
+#define PDIR "kpu/"
+	len = strlen(kpu_profile) + sizeof(PDIR);
+	path = kmalloc(len, GFP_KERNEL);
+	if (!path)
+		return;
+
+	strscpy(path, PDIR, len);
+	strcat(path, kpu_profile);
+	if (!request_firmware_direct(&fw, path, rvu->dev)) {
+		dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
+			 path);
 		rvu->kpu_fwdata = kzalloc(fw->size, GFP_KERNEL);
 		if (rvu->kpu_fwdata) {
 			memcpy(rvu->kpu_fwdata, fw->data, fw->size);
 			rvu->kpu_fwdata_sz = fw->size;
 		}
 		release_firmware(fw);
-		retry_fwdb = true;
-		goto program_kpu;
+		kfree(path);
+
+		ret = npc_apply_custom_kpu(rvu, profile, true);
+		kfree(rvu->kpu_fwdata);
+		rvu->kpu_fwdata = NULL;
+
+		/* If an error occurs during firmware loading from filesystem, there is no way
+		 * to revert as we modified default profile memory. In this case, User should delete
+		 * the corrupted firmware image, reboot the device and copy corrected firmware.
+		 * This decision not to rollback is to save memory.
+		 */
+		if (ret) {
+			rvu->kpu_fwdata_sz = 0;
+			dev_err(rvu->dev,
+				"Loading KPU profile from filesystem failed\n");
+			return;
+		}
+
+		profile->from_fs = true;
+		return;
 	}
+	kfree(path);
 
-load_image_fwdb:
 	/* Loading the KPU profile using firmware database */
 	if (npc_load_kpu_profile_fwdb(rvu, kpu_profile))
 		goto revert_to_default;
 
-program_kpu:
 	/* Apply profile customization if firmware was loaded. */
-	if (!rvu->kpu_fwdata_sz || npc_apply_custom_kpu(rvu, profile)) {
+	if (!rvu->kpu_fwdata_sz || npc_apply_custom_kpu(rvu, profile, false)) {
 		/* If image from firmware filesystem fails to load or invalid
 		 * retry with firmware database method.
 		 */
@@ -1900,10 +2020,6 @@ void npc_load_kpu_profile(struct rvu *rvu)
 			}
 			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
-			if (retry_fwdb) {
-				retry_fwdb = false;
-				goto load_image_fwdb;
-			}
 		}
 
 		dev_warn(rvu->dev,
@@ -1927,6 +2043,7 @@ void npc_load_kpu_profile(struct rvu *rvu)
 
 static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 {
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int num_pkinds, num_kpus, idx;
 
@@ -1958,6 +2075,11 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 
 	for (idx = 0; idx < num_kpus; idx++)
 		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
+
+	if (profile->from_fs) {
+		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(54), 0x03);
+		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(58), 0x03);
+	}
 }
 
 void npc_mcam_rsrcs_deinit(struct rvu *rvu)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 62cdc714ba57..ab89b8c6e490 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -596,6 +596,7 @@
 #define NPC_AF_INTFX_KEX_CFG(a)		(0x01010 | (a) << 8)
 #define NPC_AF_PKINDX_ACTION0(a)	(0x80000ull | (a) << 6)
 #define NPC_AF_PKINDX_ACTION1(a)	(0x80008ull | (a) << 6)
+#define NPC_AF_PKINDX_TYPE(a)		(0x80010ull | (a) << 6)
 #define NPC_AF_PKINDX_CPI_DEFX(a, b)	(0x80020ull | (a) << 6 | (b) << 3)
 #define NPC_AF_KPUX_ENTRYX_CAMX(a, b, c) \
 		(0x100000 | (a) << 14 | (b) << 6 | (c) << 3)
-- 
2.43.0


