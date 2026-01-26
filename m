Return-Path: <netdev+bounces-253469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O0ODBBgd2n8eQEAu9opvQ
	(envelope-from <netdev+bounces-253469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:37:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5CE885B3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59AE303AF26
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B44335067;
	Mon, 26 Jan 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WRgEMEkp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0615530C;
	Mon, 26 Jan 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430811; cv=none; b=OyrbTItXonc3KyVaNrOQFCQb3lNBj7Kw0F5nhhYNFpWnqdF85GRMM2uvKTX4+ehbjV9ZRPsvO6feRN1DOU4loetoO/lcOBUrgzgZNbqQPWQwkgP1cKiofAhpbvi6Q4i9XKVmQ/6yqfXrwEEO655GDrxZ8y+o7kQf929tEVLqiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430811; c=relaxed/simple;
	bh=IY1E+CRE6MXClP2B0jnW6o3kKUC9EDwXF09xVssdt1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkAGUxubaDH9pXRihmGJg99SmYQYz43w8Aqr2DvKB8Qi7Yg91gPBgT8gupubgMh6n0tDGoEI61Dh61wDV8yQmxbJxzNqW2UP+zfs9wnTnc3N7MD/xOuSHuKziJRB6O6dJIec0T1HQnkGA5u9CvVsDpHHtsNvztx4kteZEPCQYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WRgEMEkp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q5NE0Q2632813;
	Mon, 26 Jan 2026 04:33:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
	UNs0TenQki3e72WqtP0Unc+QEoaIGL/i5NDu0YXPZ0=; b=WRgEMEkpU0IGaW6dl
	5itzS+TN9rzHbpu3X3HsaCSYU9dyiTmEFLXm1hUn0xGGH88exFD2+pxB2zMQzHe/
	lu3T6wZC/Un/43UIrbQuf7+nNzOapQ7a9DOpyyqNrQX5tvPAmWNk0fOxm3R9hTyf
	OLF6hmVXS19cSpCQXZRHlHVJ0M5+bQPEABE7FnP2hBlLVSUXkQPbiqGeE8PEiSMT
	Sp2YTNXRBrSvSiy9XYGuvU9EcpmTg71SP71laURFx734rS3QhbnIxvwHTaUerGHe
	auUtOjo10B4vdQlyC2ZvSSUr8Wkc84jz1+PMoe3iDuGJqCMc2a0nv7gq1D81y90I
	7AM7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bwfqc9sja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 04:33:20 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Jan 2026 04:33:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Jan 2026 04:33:19 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 99A103F70B4;
	Mon, 26 Jan 2026 04:33:16 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v5 02/13] octeontx2-af: npc: cn20k: KPM profile changes
Date: Mon, 26 Jan 2026 18:02:42 +0530
Message-ID: <20260126123254.1000480-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126123254.1000480-1-rkannoth@marvell.com>
References: <20260126123254.1000480-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DuNbOW/+ c=1 sm=1 tr=0 ts=69775f10 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=6-Y-9hFfzBH4qAAUAIcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: liNr7K8JJXiNXa1X-f9Rzl9pWS7IIR_U
X-Proofpoint-ORIG-GUID: liNr7K8JJXiNXa1X-f9Rzl9pWS7IIR_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNiBTYWx0ZWRfX5E+8M3At504o
 zVbJzOJqI3mh6xCFoPpdbkT0ln5bad/U5ZhsuiIS3Pq6OUeOk/NUxp+9UkdTnbSkp435nI3wwde
 d/jv7oHaliaPDomSHw9+HLdEulxSKW2/+C+yBNVzavs1z5iOEQD8NXrYEyqZuw+aBowF9LIvKDB
 pHkO2elX+Fjqn/BHOkspLb3DP9iajrtXy9351/eop2nW+g1O72EfTXIjiKdHw0phxJNo+FWtYpb
 Jb9rewMWnUodLamJ6QFYNsLVxMpstop13+qvD6k4sBrBOOn8cRTZSAHATC12eekBtGKlL/WMwce
 ot5DW1XqXCYv4+jE3LOaVbULUVerWMkiG5NN+DF7mEWkB8p+q9JpNFOMvAsnURWXdp8rsJObnYb
 GzSNQWNl9gVCTi0khHyBugvEfofyvIU41TVE3fFQFKkNu/b7v5n7zxoAdUASCSqaIfhoQDCNBse
 VIcBVq8sfcyn+YJ0Vlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253469-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8D5CE885B3
X-Rspamd-Action: no action

From: Suman Ghosh <sumang@marvell.com>

KPU (Kangaroo Processing Unit) profiles are primarily used to set the
required packet pointers that will be used in later stages for key
generation. In the new CN20K silicon variant, a new KPM profile is
introduced alongside the existing KPU profiles.

In CN20K, a total of 16 KPUs are grouped into 8 KPM profiles. As per
the current hardware design, each KPM configuration contains a
combination of 2 KPUs:
    KPM0 = KPU0 + KPU8
    KPM1 = KPU1 + KPU9
    ...
    KPM7 = KPU7 + KPU15

This configuration enables more efficient use of KPU resources. This
patch adds support for the new KPM profile configuration.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 221 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  37 +++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  48 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |  17 ++
 6 files changed, 327 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 30cc05c64487..dfd94a30d81c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -9,6 +9,7 @@
 
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
+#include "rvu_npc.h"
 
 static struct npc_priv_t npc_priv = {
 	.num_banks = MAX_NUM_BANKS,
@@ -20,6 +21,226 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_X4] = "X4",
 };
 
+static void npc_config_kpmcam(struct rvu *rvu, int blkaddr,
+			      const struct npc_kpu_profile_cam *kpucam,
+			      int kpm, int entry)
+{
+	struct npc_kpu_cam cam0 = {0};
+	struct npc_kpu_cam cam1 = {0};
+
+	cam1.state = kpucam->state & kpucam->state_mask;
+	cam1.dp0_data = kpucam->dp0 & kpucam->dp0_mask;
+	cam1.dp1_data = kpucam->dp1 & kpucam->dp1_mask;
+	cam1.dp2_data = kpucam->dp2 & kpucam->dp2_mask;
+
+	cam0.state = ~kpucam->state & kpucam->state_mask;
+	cam0.dp0_data = ~kpucam->dp0 & kpucam->dp0_mask;
+	cam0.dp1_data = ~kpucam->dp1 & kpucam->dp1_mask;
+	cam0.dp2_data = ~kpucam->dp2 & kpucam->dp2_mask;
+
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRYX_CAMX(kpm, entry, 0), *(u64 *)&cam0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRYX_CAMX(kpm, entry, 1), *(u64 *)&cam1);
+}
+
+static void
+npc_config_kpmaction(struct rvu *rvu, int blkaddr,
+		     const struct npc_kpu_profile_action *kpuaction,
+		     int kpm, int entry, bool pkind)
+{
+	struct npc_kpm_action0 action0 = {0};
+	struct npc_kpu_action1 action1 = {0};
+	u64 reg;
+
+	action1.errlev = kpuaction->errlev;
+	action1.errcode = kpuaction->errcode;
+	action1.dp0_offset = kpuaction->dp0_offset;
+	action1.dp1_offset = kpuaction->dp1_offset;
+	action1.dp2_offset = kpuaction->dp2_offset;
+
+	if (pkind)
+		reg = NPC_AF_PKINDX_ACTION1(entry);
+	else
+		reg = NPC_AF_KPMX_ENTRYX_ACTION1(kpm, entry);
+
+	rvu_write64(rvu, blkaddr, reg, *(u64 *)&action1);
+
+	action0.byp_count = kpuaction->bypass_count;
+	action0.capture_ena = kpuaction->cap_ena;
+	action0.parse_done = kpuaction->parse_done;
+	action0.next_state = kpuaction->next_state;
+	action0.capture_lid = kpuaction->lid;
+	action0.capture_ltype = kpuaction->ltype;
+	action0.capture_flags = kpuaction->flags;
+	action0.ptr_advance = kpuaction->ptr_advance;
+	action0.var_len_offset = kpuaction->offset;
+	action0.var_len_mask = kpuaction->mask;
+	action0.var_len_right = kpuaction->right;
+	action0.var_len_shift = kpuaction->shift;
+
+	if (pkind)
+		reg = NPC_AF_PKINDX_ACTION0(entry);
+	else
+		reg = NPC_AF_KPMX_ENTRYX_ACTION0(kpm, entry);
+
+	rvu_write64(rvu, blkaddr, reg, *(u64 *)&action0);
+}
+
+static void
+npc_program_single_kpm_profile(struct rvu *rvu, int blkaddr,
+			       int kpm, int start_entry,
+			       const struct npc_kpu_profile *profile)
+{
+	int entry, num_entries, max_entries;
+	u64 idx;
+
+	if (profile->cam_entries != profile->action_entries) {
+		dev_err(rvu->dev,
+			"kpm%d: CAM and action entries [%d != %d] not equal\n",
+			kpm, profile->cam_entries, profile->action_entries);
+	}
+
+	max_entries = rvu->hw->npc_kpu_entries / 2;
+	entry = start_entry;
+	/* Program CAM match entries for previous kpm extracted data */
+	num_entries = min_t(int, profile->cam_entries, max_entries);
+	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
+		npc_config_kpmcam(rvu, blkaddr, &profile->cam[idx],
+				  kpm, entry);
+
+	entry = start_entry;
+	/* Program this kpm's actions */
+	num_entries = min_t(int, profile->action_entries, max_entries);
+	for (idx = 0; entry < num_entries + start_entry; entry++, idx++)
+		npc_config_kpmaction(rvu, blkaddr, &profile->action[idx],
+				     kpm, entry, false);
+}
+
+static void
+npc_enable_kpm_entry(struct rvu *rvu, int blkaddr, int kpm, int num_entries)
+{
+	u64 entry_mask;
+
+	entry_mask = npc_enable_mask(num_entries);
+	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
+	if (!rvu->kpu.custom)
+		entry_mask |= GENMASK_ULL(KPU_MAX_CST_ENT - 1, 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 0), entry_mask);
+	if (num_entries <= 64) {
+		/* Disable all the entries in W1, W2 and W3 */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 1),
+			    npc_enable_mask(0));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 2),
+			    npc_enable_mask(0));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 3),
+			    npc_enable_mask(0));
+		return;
+	}
+
+	num_entries = num_entries - 64;
+	entry_mask = npc_enable_mask(num_entries);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 1), entry_mask);
+	if (num_entries <= 64) {
+		/* Disable all the entries in W2 and W3 */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 2),
+			    npc_enable_mask(0));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 3),
+			    npc_enable_mask(0));
+		return;
+	}
+
+	num_entries = num_entries - 64;
+	entry_mask = npc_enable_mask(num_entries);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 2), entry_mask);
+	if (num_entries <= 64) {
+		/* Disable all the entries in W3 */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(kpm, 3),
+			    npc_enable_mask(0));
+		return;
+	}
+
+	num_entries = num_entries - 64;
+	entry_mask = npc_enable_mask(num_entries);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_KPMX_ENTRY_DISX(kpm, 3), entry_mask);
+}
+
+#define KPU_OFFSET	8
+static void npc_program_kpm_profile(struct rvu *rvu, int blkaddr, int num_kpms)
+{
+	const struct npc_kpu_profile *profile1, *profile2;
+	int idx, total_cam_entries;
+
+	for (idx = 0; idx < num_kpms; idx++) {
+		profile1 = &rvu->kpu.kpu[idx];
+		npc_program_single_kpm_profile(rvu, blkaddr, idx, 0, profile1);
+		profile2 = &rvu->kpu.kpu[idx + KPU_OFFSET];
+		npc_program_single_kpm_profile(rvu, blkaddr, idx,
+					       profile1->cam_entries,
+					       profile2);
+		total_cam_entries = profile1->cam_entries +
+			profile2->cam_entries;
+		npc_enable_kpm_entry(rvu, blkaddr, idx, total_cam_entries);
+		rvu_write64(rvu, blkaddr, NPC_AF_KPMX_PASS2_OFFSET(idx),
+			    profile1->cam_entries);
+		/* Enable the KPUs associated with this KPM */
+		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x01);
+		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx + KPU_OFFSET),
+			    0x01);
+	}
+}
+
+void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	int num_pkinds, idx;
+
+	/* Disable all KPMs and their entries */
+	for (idx = 0; idx < hw->npc_kpms; idx++) {
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 0), ~0ULL);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 1), ~0ULL);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 2), ~0ULL);
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_KPMX_ENTRY_DISX(idx, 3), ~0ULL);
+	}
+
+	for (idx = 0; idx < hw->npc_kpus; idx++)
+		rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(idx), 0x00);
+
+	/* Load and customize KPU profile. */
+	npc_load_kpu_profile(rvu);
+
+	/* Configure KPU and KPM mapping for second pass */
+	rvu_write64(rvu, blkaddr, NPC_AF_KPM_PASS2_CFG, 0x76543210);
+
+	/* First program IKPU profile i.e PKIND configs.
+	 * Check HW max count to avoid configuring junk or
+	 * writing to unsupported CSR addresses.
+	 */
+	num_pkinds = rvu->kpu.pkinds;
+	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
+
+	for (idx = 0; idx < num_pkinds; idx++)
+		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
+				     0, idx, true);
+
+	/* Program KPM CAM and Action profiles */
+	npc_program_kpm_profile(rvu, blkaddr, hw->npc_kpms);
+}
+
 struct npc_priv_t *npc_priv_get(void)
 {
 	return &npc_priv;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 26da0a2c717a..55882a0f37fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -94,6 +94,42 @@ struct npc_priv_t {
 	bool init_done;
 };
 
+struct npc_kpm_action0 {
+#if defined(__BIG_ENDIAN_BITFIELD)
+	u64 rsvd_63_57     : 7;
+	u64 byp_count      : 3;
+	u64 capture_ena    : 1;
+	u64 parse_done     : 1;
+	u64 next_state     : 8;
+	u64 rsvd_43        : 1;
+	u64 capture_lid    : 3;
+	u64 capture_ltype  : 4;
+	u64 rsvd_32_35     : 4;
+	u64 capture_flags  : 4;
+	u64 ptr_advance    : 8;
+	u64 var_len_offset : 8;
+	u64 var_len_mask   : 8;
+	u64 var_len_right  : 1;
+	u64 var_len_shift  : 3;
+#else
+	u64 var_len_shift  : 3;
+	u64 var_len_right  : 1;
+	u64 var_len_mask   : 8;
+	u64 var_len_offset : 8;
+	u64 ptr_advance    : 8;
+	u64 capture_flags  : 4;
+	u64 rsvd_32_35     : 4;
+	u64 capture_ltype  : 4;
+	u64 capture_lid    : 3;
+	u64 rsvd_43        : 1;
+	u64 next_state     : 8;
+	u64 parse_done     : 1;
+	u64 capture_ena    : 1;
+	u64 byp_count      : 3;
+	u64 rsvd_63_57     : 7;
+#endif
+};
+
 struct rvu;
 
 struct npc_priv_t *npc_priv_get(void);
@@ -107,4 +143,5 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 			    int prio, u16 *mcam_idx, int ref, int limit,
 			    bool contig, int count);
 int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
+void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr);
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index 098b0247848b..073d4b815681 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -77,8 +77,21 @@
 #define RVU_MBOX_VF_INT_ENA_W1S			(0x30)
 #define RVU_MBOX_VF_INT_ENA_W1C			(0x38)
 
+#define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 /* NPC registers */
-#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a) (0xf000000ull | (a) << 3)
+#define NPC_AF_INTFX_EXTRACTORX_CFG(a, b) \
+	(0x908000ull | (a) << 10 | (b) << 3)
+#define NPC_AF_INTFX_EXTRACTORX_LTX_CFG(a, b, c) \
+	(0x900000ull | (a) << 13 | (b) << 8  | (c) << 3)
+#define NPC_AF_KPMX_ENTRYX_CAMX(a, b, c) \
+	(0x100000ull | (a) << 14 | (b) << 6 | (c) << 3)
+#define NPC_AF_KPMX_ENTRYX_ACTION0(a, b) \
+	(0x100020ull | (a) << 14 | (b) << 6)
+#define NPC_AF_KPMX_ENTRYX_ACTION1(a, b) \
+	(0x100028ull | (a) << 14 | (b) << 6)
+#define NPC_AF_KPMX_ENTRY_DISX(a, b)	(0x180000ull | (a) << 6 | (b) << 3)
+#define NPC_AF_KPM_PASS2_CFG	0x580
+#define NPC_AF_KPMX_PASS2_OFFSET(a)	(0x190000ull | (a) << 3)
+#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a)	(0xC000000ull | (a) << 3)
 
-#define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 #endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e85dac2c806d..14ca28ab493a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -447,9 +447,11 @@ struct rvu_hwinfo {
 	u8	sdp_links;
 	u8	cpt_links;	/* Number of CPT links */
 	u8	npc_kpus;          /* No of parser units */
+	u8	npc_kpms;	/* Number of enhanced parser units */
+	u8	npc_kex_extr;	/* Number of LDATA extractors per KEX */
 	u8	npc_pkinds;        /* No of port kinds */
 	u8	npc_intfs;         /* No of interfaces */
-	u8	npc_kpu_entries;   /* No of KPU entries */
+	u16	npc_kpu_entries;   /* No of KPU entries */
 	u16	npc_counters;	   /* No of match stats counters */
 	u32	lbk_bufsize;	   /* FIFO size supported by LBK */
 	bool	npc_ext_set;	   /* Extended register set */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 6c5fe838717e..133ae6421de7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -17,6 +17,7 @@
 #include "npc_profile.h"
 #include "rvu_npc_hash.h"
 #include "cn20k/npc.h"
+#include "rvu_npc.h"
 
 #define RSVD_MCAM_ENTRIES_PER_PF	3 /* Broadcast, Promisc and AllMulticast */
 #define RSVD_MCAM_ENTRIES_PER_NIXLF	1 /* Ucast for LFs */
@@ -1410,9 +1411,9 @@ static void npc_load_mkex_profile(struct rvu *rvu, int blkaddr,
 		iounmap(mkex_prfl_addr);
 }
 
-static void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
-				 const struct npc_kpu_profile_action *kpuaction,
-				 int kpu, int entry, bool pkind)
+void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
+			  const struct npc_kpu_profile_action *kpuaction,
+			  int kpu, int entry, bool pkind)
 {
 	struct npc_kpu_action0 action0 = {0};
 	struct npc_kpu_action1 action1 = {0};
@@ -1475,7 +1476,7 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 		    NPC_AF_KPUX_ENTRYX_CAMX(kpu, entry, 1), *(u64 *)&cam1);
 }
 
-static inline u64 enable_mask(int count)
+u64 npc_enable_mask(int count)
 {
 	return (((count) < 64) ? ~(BIT_ULL(count) - 1) : (0x00ULL));
 }
@@ -1508,7 +1509,7 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 
 	/* Enable all programmed entries */
 	num_entries = min_t(int, profile->action_entries, profile->cam_entries);
-	entry_mask = enable_mask(num_entries);
+	entry_mask = npc_enable_mask(num_entries);
 	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
 	if (!rvu->kpu.custom)
 		entry_mask |= GENMASK_ULL(KPU_MAX_CST_ENT - 1, 0);
@@ -1517,7 +1518,7 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 	if (num_entries > 64) {
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_KPUX_ENTRY_DISX(kpu, 1),
-			    enable_mask(num_entries - 64));
+			    npc_enable_mask(num_entries - 64));
 	}
 
 	/* Enable this KPU */
@@ -1705,7 +1706,7 @@ static int npc_load_kpu_profile_fwdb(struct rvu *rvu, const char *kpu_profile)
 	return ret;
 }
 
-static void npc_load_kpu_profile(struct rvu *rvu)
+void npc_load_kpu_profile(struct rvu *rvu)
 {
 	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
 	const char *kpu_profile = rvu->kpu_pfl_name;
@@ -1847,12 +1848,19 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	mcam->keysize = cfg;
 
 	/* Number of banks combined per MCAM entry */
-	if (cfg == NPC_MCAM_KEY_X4)
-		mcam->banks_per_entry = 4;
-	else if (cfg == NPC_MCAM_KEY_X2)
-		mcam->banks_per_entry = 2;
-	else
-		mcam->banks_per_entry = 1;
+	if (is_cn20k(rvu->pdev)) {
+		if (cfg == NPC_MCAM_KEY_X2)
+			mcam->banks_per_entry = 1;
+		else
+			mcam->banks_per_entry = 2;
+	} else {
+		if (cfg == NPC_MCAM_KEY_X4)
+			mcam->banks_per_entry = 4;
+		else if (cfg == NPC_MCAM_KEY_X2)
+			mcam->banks_per_entry = 2;
+		else
+			mcam->banks_per_entry = 1;
+	}
 
 	/* Reserve one MCAM entry for each of the NIX LF to
 	 * guarantee space to install default matching DMAC rule.
@@ -1982,6 +1990,15 @@ static void rvu_npc_hw_init(struct rvu *rvu, int blkaddr)
 	hw->npc_pkinds = (npc_const1 >> 12) & 0xFFULL;
 	hw->npc_kpu_entries = npc_const1 & 0xFFFULL;
 	hw->npc_kpus = (npc_const >> 8) & 0x1FULL;
+	/* For Cn20k silicon, check if enhanced parser
+	 * is present, then set the NUM_KPMS = NUM_KPUS / 2 and
+	 * number of LDATA extractors per KEX.
+	 */
+	if (is_cn20k(rvu->pdev) && (npc_const1 & BIT_ULL(62))) {
+		hw->npc_kpms = hw->npc_kpus / 2;
+		hw->npc_kex_extr = (npc_const1 >> 36) & 0x3FULL;
+	}
+
 	hw->npc_intfs = npc_const & 0xFULL;
 	hw->npc_counters = (npc_const >> 48) & 0xFFFFULL;
 
@@ -2116,7 +2133,10 @@ int rvu_npc_init(struct rvu *rvu)
 		return -ENOMEM;
 
 	/* Configure KPU profile */
-	npc_parser_profile_init(rvu, blkaddr);
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_parser_profile_init(rvu, blkaddr);
+	else
+		npc_parser_profile_init(rvu, blkaddr);
 
 	/* Config Outer L2, IPv4's NPC layer info */
 	rvu_write64(rvu, blkaddr, NPC_AF_PCK_DEF_OL2,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
new file mode 100644
index 000000000000..80c63618ec47
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_NPC_H
+#define RVU_NPC_H
+
+u64 npc_enable_mask(int count);
+void npc_load_kpu_profile(struct rvu *rvu);
+void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
+			  const struct npc_kpu_profile_action *kpuaction,
+			  int kpu, int entry, bool pkind);
+
+#endif /* RVU_NPC_H */
-- 
2.43.0


