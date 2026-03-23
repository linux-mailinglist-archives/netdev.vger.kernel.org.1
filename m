Return-Path: <netdev+bounces-270357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOkQKPi4wGmpKQQAu9opvQ
	(envelope-from <netdev+bounces-270357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:52:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AF2EC490
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 021463008C37
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8102C0294;
	Mon, 23 Mar 2026 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gH1b+adx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AF29E114;
	Mon, 23 Mar 2026 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237920; cv=none; b=bZACdcHZx9LevU4T4xR4nUADOfvyVc5PsD896DDYQZtPvEQbY0ha08ZjqZDPgsxL8xfZLyEtQUFTSlACW/xleYtVc6oOnTdl1lYCjoryoNbAPCW1qDaURlO/oiTOJJpNEdCvp+inlKW4bSukFg2xckS2n2MgDVs13dZGAvZfvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237920; c=relaxed/simple;
	bh=4j7LfjSzQA2eb11OiXlNMSNKssUjiOmEJwxssjnUooU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tt5509ov7oykQWM3u4m95uDY71TyEFABS1rTYKh9eD9zSq0MLQS9Iul7V4ihXMAtVE+dobTsJQ8+dYRzDjXzouOfumZHseFoXNT6zn2iPQpp45vlupN2OR4nRSdfCjmSNAYz32A5cOx2Wr+HekrCd/UnpfYNuaiVNqIB53cgZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gH1b+adx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNl2r7142011;
	Sun, 22 Mar 2026 20:51:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	BYlSpDz3SgW2vAdiJz0JWencSfw/qby2bqHdTAU2jo=; b=gH1b+adxwuMbltpf+
	XECsLqcZz4Th99t7zBG4KBEFn0i5R6u0PCv5hNDhuPO7AZ32CskBMNRxGhJ9Rm7q
	ZCxu2iklJFbalQ5LSLvZVIkUIoCmnKAjZ2/VpEWaSRZONgRfF9rgaFw26bGdYzuW
	Qnls74QE2MC6VlK6cxEtUkU04VwyViz7n6ArQcqb0H95v7bhtTdJ5GhzMB+/ncIe
	fYd3bVgrD8BYNcICExFjrf5KvVWpH+2EfYwfYGjOCJvQY+quo4jVPogyC3ucuMIX
	+13TaPLHkGoaJcWwQ2C6o4FoW8yFcGBGH2fvnrtE5V20XmLb+LXPvhS+CypVrZnG
	JscjQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d2c3617q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 20:51:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Mar 2026 20:51:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 22 Mar 2026 20:51:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5843D3F70A1;
	Sun, 22 Mar 2026 20:51:42 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, <dtatulea@nvidia.com>, <tariqt@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v7 net-next 5/5] octeontx2-af: npc: Support for custom KPU profile from filesystem
Date: Mon, 23 Mar 2026 09:21:10 +0530
Message-ID: <20260323035110.3908741-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323035110.3908741-1-rkannoth@marvell.com>
References: <20260323035110.3908741-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNiBTYWx0ZWRfX5dXG5wpuwf2D
 E3TPhfYZsDb+hwYOQbr8ZdcXj55VhD4ZRVTg95JIOol3MIT1CJ1lUlLzDBxp9NytGU33tH0gK/Y
 wJNMmzZRBEZMZAlFkOrbMUraCYJJs9h5cHozSFuLtIoMrPCi+ZpPPzYpZ04jGh20yjnARJRwlgW
 NkJnsv/QgZUpH0lJ93xUvA9HMsma20RQrsFWPRqpKBjyhl5MKlMS0WkL9AwJlzUuSEldGyaHJax
 A1+rZqbXGnB9/GXETJI6jhbN2iFf16VXFzZ3JxRgFHha9TK5Css133dHMD41SN3WGRggUfwEsbZ
 29hIimh7ZT2YUW4nnVPt4eaCn5mD9j3R1ew7e9j8PSu/vdv/zXMw9BKvxtwTuAvf4hMCmCy4OxZ
 67xNUG40+9hQdZ9RK9yfqdnbbsOcP172GlLGBekUVTDAYUdzLykvf64hEF1dR0BI4Bvk3rFbGFF
 R9XvNRvYhi6/x1ZXCZw==
X-Proofpoint-ORIG-GUID: TgrSCCYZKX5zeW93J507DbC3QjVaugg1
X-Proofpoint-GUID: TgrSCCYZKX5zeW93J507DbC3QjVaugg1
X-Authority-Analysis: v=2.4 cv=SItPlevH c=1 sm=1 tr=0 ts=69c0b8d4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=M6FVU7mOVnAuWYZvVqIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270357-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4A1AF2EC490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  40 ++-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  17 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 276 +++++++++++++++---
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 ++
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 6 files changed, 305 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 69439ff76e10..a3015b12a20b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -521,13 +521,17 @@ npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
 			       int kpm, int start_entry,
 			       const struct npc_kpu_profile *profile)
 {
+	int num_cam_entries, num_action_entries;
 	int entry, num_entries, max_entries;
 	u64 idx;
 
-	if (profile->cam_entries != profile->action_entries) {
+	num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile);
+	num_action_entries = npc_get_num_kpu_action_entries(rvu, profile);
+
+	if (num_cam_entries != num_action_entries) {
 		dev_err(rvu->dev,
 			"kpm%d: CAM and action entries [%d != %d] not equal\n",
-			kpm, profile->cam_entries, profile->action_entries);
+			kpm, num_cam_entries, num_action_entries);
 
 		WARN(1, "Fatal error\n");
 		return;
@@ -536,16 +540,18 @@ npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
 	max_entries = rvu->hw->npc_kpu_entries / 2;
 	entry = start_entry;
 	/* Program CAM match entries for previous kpm extracted data */
-	num_entries = min_t(int, profile->cam_entries, max_entries);
+	num_entries = min_t(int, num_cam_entries, max_entries);
 	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
-		npc_config_kpmcam(rvu, blkaddr, &profile->cam[idx],
+		npc_config_kpmcam(rvu, blkaddr,
+				  npc_get_kpu_cam_nth_entry(rvu, profile, idx),
 				  kpm, entry);
 
 	entry = start_entry;
 	/* Program this kpm's actions */
-	num_entries = min_t(int, profile->action_entries, max_entries);
+	num_entries = min_t(int, num_action_entries, max_entries);
 	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
-		npc_config_kpmaction(rvu, blkaddr, &profile->action[idx],
+		npc_config_kpmaction(rvu, blkaddr,
+				     npc_get_kpu_action_nth_entry(rvu, profile, idx),
 				     kpm, entry, false);
 }
 
@@ -611,20 +617,23 @@ npc_enable_kpm_entry(struct rvu *rvu, int blkaddr, int kpm, int num_entries)
 static void npc_program_kpm_profile(struct rvu *rvu, int blkaddr, int num_kpms)
 {
 	const struct npc_kpu_profile *profile1, *profile2;
+	int pfl1_num_cam_entries, pfl2_num_cam_entries;
 	int idx, total_cam_entries;
 
 	for (idx = 0; idx < num_kpms; idx++) {
 		profile1 = &rvu->kpu.kpu[idx];
+		pfl1_num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile1);
 		npc_program_single_kpm_profile(rvu, blkaddr, idx, 0, profile1);
 		profile2 = &rvu->kpu.kpu[idx + KPU_OFFSET];
+		pfl2_num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile2);
+
 		npc_program_single_kpm_profile(rvu, blkaddr, idx,
-					       profile1->cam_entries,
+					       pfl1_num_cam_entries,
 					       profile2);
-		total_cam_entries = profile1->cam_entries +
-			profile2->cam_entries;
+		total_cam_entries = pfl1_num_cam_entries + pfl2_num_cam_entries;
 		npc_enable_kpm_entry(rvu, blkaddr, idx, total_cam_entries);
 		rvu_write64(rvu, blkaddr, NPC_AF_KPMX_PASS2_OFFSET(idx),
-			    profile1->cam_entries);
+			    pfl1_num_cam_entries);
 		/* Enable the KPUs associated with this KPM */
 		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x01);
 		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx + KPU_OFFSET),
@@ -634,6 +643,7 @@ static void npc_program_kpm_profile(struct rvu *rvu, int blkaddr, int num_kpms)
 
 void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
 {
+	struct npc_kpu_profile_action *act;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int num_pkinds, idx;
 
@@ -665,9 +675,15 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
 	num_pkinds = rvu->kpu.pkinds;
 	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
 
-	for (idx = 0; idx < num_pkinds; idx++)
-		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
+	/* Cn20k does not support Custom profile from filesystem */
+	for (idx = 0; idx < num_pkinds; idx++) {
+		act = npc_get_ikpu_nth_entry(rvu, idx);
+		if (!act)
+			continue;
+
+		npc_config_kpmaction(rvu, blkaddr, act,
 				     0, idx, true);
+	}
 
 	/* Program KPM CAM and Action profiles */
 	npc_program_kpm_profile(rvu, blkaddr, hw->npc_kpms);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index cefc5d70f3e4..c8c0cb68535c 100644
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
@@ -290,6 +303,10 @@ struct npc_kpu_profile {
 	int action_entries;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_profile_action *action;
+	int cam_entries2;
+	int action_entries2;
+	struct npc_kpu_profile_action *action2;
+	struct npc_kpu_profile_cam2 *cam2;
 };
 
 /* NPC KPU register formats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf908..eb2e4ccf070d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -553,8 +553,9 @@ struct npc_kpu_profile_adapter {
 	const char			*name;
 	u64				version;
 	const struct npc_lt_def_cfg	*lt_def;
-	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
-	const struct npc_kpu_profile	*kpu; /* array[kpus] */
+	struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
+	struct npc_kpu_profile_action	*ikpu2; /* array[pkinds] */
+	struct npc_kpu_profile	*kpu; /* array[kpus] */
 	union npc_mcam_key_prfl {
 		struct npc_mcam_kex		*mkex;
 					/* used for cn9k and cn10k */
@@ -564,6 +565,7 @@ struct npc_kpu_profile_adapter {
 	bool				custom;
 	size_t				pkinds;
 	size_t				kpus;
+	bool				from_fs;
 };
 
 #define RVU_SWITCH_LBK_CHAN	63
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 8d260bcfbf38..ff0acf2c174a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1582,8 +1582,12 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
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
@@ -1595,6 +1599,14 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
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
@@ -1606,34 +1618,104 @@ u64 npc_enable_mask(int count)
 	return (((count) < 64) ? ~(BIT_ULL(count) - 1) : (0x00ULL));
 }
 
+struct npc_kpu_profile_action *
+npc_get_ikpu_nth_entry(struct rvu *rvu, int n)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return &profile->ikpu2[n];
+
+	return &profile->ikpu[n];
+}
+
+int
+npc_get_num_kpu_cam_entries(struct rvu *rvu,
+			    const struct npc_kpu_profile *kpu_pfl)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return kpu_pfl->cam_entries2;
+
+	return kpu_pfl->cam_entries;
+}
+
+struct npc_kpu_profile_cam *
+npc_get_kpu_cam_nth_entry(struct rvu *rvu,
+			  const struct npc_kpu_profile *kpu_pfl, int n)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return (void *)&kpu_pfl->cam2[n];
+
+	return (void *)&kpu_pfl->cam[n];
+}
+
+int
+npc_get_num_kpu_action_entries(struct rvu *rvu,
+			       const struct npc_kpu_profile *kpu_pfl)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return kpu_pfl->action_entries2;
+
+	return kpu_pfl->action_entries;
+}
+
+struct npc_kpu_profile_action *
+npc_get_kpu_action_nth_entry(struct rvu *rvu,
+			     const struct npc_kpu_profile *kpu_pfl,
+			     int n)
+{
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
+
+	if (profile->from_fs)
+		return (void *)&kpu_pfl->action2[n];
+
+	return (void *)&kpu_pfl->action[n];
+}
+
 static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 				    const struct npc_kpu_profile *profile)
 {
+	int num_cam_entries, num_action_entries;
 	int entry, num_entries, max_entries;
 	u64 entry_mask;
 
-	if (profile->cam_entries != profile->action_entries) {
+	num_cam_entries = npc_get_num_kpu_cam_entries(rvu, profile);
+	num_action_entries = npc_get_num_kpu_action_entries(rvu, profile);
+
+	if (num_cam_entries != num_action_entries) {
 		dev_err(rvu->dev,
 			"KPU%d: CAM and action entries [%d != %d] not equal\n",
-			kpu, profile->cam_entries, profile->action_entries);
+			kpu, num_cam_entries, num_action_entries);
 	}
 
 	max_entries = rvu->hw->npc_kpu_entries;
 
+	WARN(num_cam_entries > max_entries,
+	     "KPU%u: err: hw max entries=%u, input entries=%u\n",
+	     kpu,  rvu->hw->npc_kpu_entries, num_cam_entries);
+
 	/* Program CAM match entries for previous KPU extracted data */
-	num_entries = min_t(int, profile->cam_entries, max_entries);
+	num_entries = min_t(int, num_cam_entries, max_entries);
 	for (entry = 0; entry < num_entries; entry++)
 		npc_config_kpucam(rvu, blkaddr,
-				  &profile->cam[entry], kpu, entry);
+				  (void *)npc_get_kpu_cam_nth_entry(rvu, profile, entry),
+				  kpu, entry);
 
 	/* Program this KPU's actions */
-	num_entries = min_t(int, profile->action_entries, max_entries);
+	num_entries = min_t(int, num_action_entries, max_entries);
 	for (entry = 0; entry < num_entries; entry++)
-		npc_config_kpuaction(rvu, blkaddr, &profile->action[entry],
+		npc_config_kpuaction(rvu, blkaddr,
+				     (void *)npc_get_kpu_action_nth_entry(rvu, profile, entry),
 				     kpu, entry, false);
 
 	/* Enable all programmed entries */
-	num_entries = min_t(int, profile->action_entries, profile->cam_entries);
+	num_entries = min_t(int, num_action_entries, num_cam_entries);
 	entry_mask = npc_enable_mask(num_entries);
 	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
 	if (!rvu->kpu.custom)
@@ -1677,26 +1759,49 @@ static void npc_prepare_default_kpu(struct rvu *rvu,
 	npc_cn20k_update_action_entries_n_flags(rvu, profile);
 }
 
+static int npc_alloc_kpu_cam2_n_action2(struct rvu *rvu, int kpu_num,
+					int num_entries)
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
+	kpu->action2 = devm_kcalloc(rvu->dev, num_entries,
+				    sizeof(*kpu->action2), GFP_KERNEL);
+	if (!kpu->action2)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int npc_apply_custom_kpu(struct rvu *rvu,
-				struct npc_kpu_profile_adapter *profile)
+				struct npc_kpu_profile_adapter *profile,
+				bool from_fs, int *fw_kpus)
 {
 	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
 	struct npc_kpu_profile_action *action;
+	struct npc_kpu_profile_fwdata *sfw;
 	struct npc_kpu_profile_fwdata *fw;
+	struct npc_kpu_profile_cam2 *cam2;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_fwdata *fw_kpu;
-	int entries;
-	u16 kpu, entry;
+	int entries, ret, entry, kpu;
 
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
@@ -1730,32 +1835,90 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
 		return -EINVAL;
 	}
 
+	*fw_kpus = fw->kpus;
+
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
+		profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
+					      sizeof(ikpu_action_entries),
+					      GFP_KERNEL);
+		if (!profile->ikpu2)
+			return -ENOMEM;
+
+		action = (struct npc_kpu_profile_action *)(fw->data + offset);
+
+		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
+			return -ENOMEM;
+
+		memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
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
+
+		entries = min(fw_kpu->entries, rvu->hw->npc_kpu_entries);
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
+		profile->kpu[kpu].cam_entries2 = entries;
+		profile->kpu[kpu].action_entries2 = entries;
+		ret = npc_alloc_kpu_cam2_n_action2(rvu, kpu, entries);
+		if (ret) {
+			dev_warn(rvu->dev,
+				 "profile entry allocation failed for kpu=%d for %d entries\n",
+				 kpu, entries);
+			return -EINVAL;
+		}
+
 		for (entry = 0; entry < entries; entry++) {
-			profile->kpu[kpu].cam[entry] = cam[entry];
-			profile->kpu[kpu].action[entry] = action[entry];
+			profile->kpu[kpu].cam2[entry] = cam2[entry];
+			profile->kpu[kpu].action2[entry] = action[entry];
 		}
 	}
 
@@ -1852,7 +2015,10 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	const char *kpu_profile = rvu->kpu_pfl_name;
 	const struct firmware *fw = NULL;
-	bool retry_fwdb = false;
+	int len, ret, fw_kpus = 0;
+	char *path;
+
+	profile->from_fs = false;
 
 	/* If user not specified profile customization */
 	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
@@ -1865,27 +2031,57 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	 * Firmware database method.
 	 * Default KPU profile.
 	 */
-	if (!request_firmware_direct(&fw, kpu_profile, rvu->dev)) {
-		dev_info(rvu->dev, "Loading KPU profile from firmware: %s\n",
-			 kpu_profile);
+
+	/* No support for filesystem KPU loading */
+	if (is_cn20k(rvu->pdev))
+		goto load_image_fwdb;
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
+		ret = npc_apply_custom_kpu(rvu, profile, true, &fw_kpus);
+		kfree(rvu->kpu_fwdata);
+		rvu->kpu_fwdata = NULL;
+
+		if (ret) {
+			rvu->kpu_fwdata_sz = 0;
+			npc_prepare_default_kpu(rvu, profile);
+			dev_err(rvu->dev,
+				"Loading KPU profile from filesystem failed\n");
+			goto load_image_fwdb;
+		}
+
+		/* Cn20k does not support filesystem loading */
+		rvu->kpu.kpus = fw_kpus;
+		profile->from_fs = true;
+		return;
 	}
+	kfree(path);
 
 load_image_fwdb:
 	/* Loading the KPU profile using firmware database */
 	if (npc_load_kpu_profile_fwdb(rvu, kpu_profile))
 		goto revert_to_default;
 
-program_kpu:
 	/* Apply profile customization if firmware was loaded. */
-	if (!rvu->kpu_fwdata_sz || npc_apply_custom_kpu(rvu, profile)) {
+	if (!rvu->kpu_fwdata_sz ||
+	    npc_apply_custom_kpu(rvu, profile, false, &fw_kpus)) {
 		/* If image from firmware filesystem fails to load or invalid
 		 * retry with firmware database method.
 		 */
@@ -1899,10 +2095,6 @@ void npc_load_kpu_profile(struct rvu *rvu)
 			}
 			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
-			if (retry_fwdb) {
-				retry_fwdb = false;
-				goto load_image_fwdb;
-			}
 		}
 
 		dev_warn(rvu->dev,
@@ -1926,6 +2118,7 @@ void npc_load_kpu_profile(struct rvu *rvu)
 
 static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 {
+	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int num_pkinds, num_kpus, idx;
 
@@ -1949,7 +2142,9 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
 
 	for (idx = 0; idx < num_pkinds; idx++)
-		npc_config_kpuaction(rvu, blkaddr, &rvu->kpu.ikpu[idx], 0, idx, true);
+		npc_config_kpuaction(rvu, blkaddr,
+				     npc_get_ikpu_nth_entry(rvu, idx),
+				     0, idx, true);
 
 	/* Program KPU CAM and Action profiles */
 	num_kpus = rvu->kpu.kpus;
@@ -1957,6 +2152,11 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 
 	for (idx = 0; idx < num_kpus; idx++)
 		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
+
+	if (profile->from_fs) {
+		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(54), 0x03);
+		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(58), 0x03);
+	}
 }
 
 void npc_mcam_rsrcs_deinit(struct rvu *rvu)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
index 83c5e32e2afc..662f6693cfe9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -18,4 +18,21 @@ int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
 
 void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index);
 void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index);
+
+struct npc_kpu_profile_action *
+npc_get_ikpu_nth_entry(struct rvu *rvu, int n);
+
+int
+npc_get_num_kpu_cam_entries(struct rvu *rvu,
+			    const struct npc_kpu_profile *kpu_pfl);
+struct npc_kpu_profile_cam *
+npc_get_kpu_cam_nth_entry(struct rvu *rvu,
+			  const struct npc_kpu_profile *kpu_pfl, int n);
+
+int
+npc_get_num_kpu_action_entries(struct rvu *rvu,
+			       const struct npc_kpu_profile *kpu_pfl);
+struct npc_kpu_profile_action *
+npc_get_kpu_action_nth_entry(struct rvu *rvu,
+			     const struct npc_kpu_profile *kpu_pfl, int n);
 #endif /* RVU_NPC_H */
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


