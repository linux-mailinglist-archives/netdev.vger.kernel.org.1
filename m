Return-Path: <netdev+bounces-297408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bXaqKf3KKGqNJgMAu9opvQ
	(envelope-from <netdev+bounces-297408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:25:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE7665701
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="Vzu/RyrJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297408-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F70730534EE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65C27FB0E;
	Wed, 10 Jun 2026 02:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267BBA3D;
	Wed, 10 Jun 2026 02:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058253; cv=none; b=nqeF9Xm4sLxLeeymYOAPlxlWlzeriJrd0wxshDR63bFwDVyjhq1o24UyeSAmSEivJlxuCP+1zhlhotUF0R5r/Yke40qsVxx97zMxTehdqKhTr6iqUW1MRP3Nke+gL+4z7HYTwaDJzOpxJpyMBX4TlziU2rx+ix9wgJcXOZpSEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058253; c=relaxed/simple;
	bh=a3fWP8f+L8R0fxxsfHNMpTlFJiErWAwPbfYoGBkW+dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oa19/pozUhaAp6xJB72pMk8y+B39hE3uJL/UDHRNIIA7N5cTXzpMAoWVR9ONSvT2QfS5TGrhqZLh4QD5CqVIfAuj29gfwZwu33dO6lh7S5Ba/F2Ov/PnEzmMTGZS++T52W+3hJuUZEHn5nwdxCV1v+n6z+um/Sq+Eiw0OmgKjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vzu/RyrJ; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1w7Wb2379619;
	Tue, 9 Jun 2026 19:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=f5wygD3OrQoB3y8EPWdHY1o
	Qhqa9eIRqLFQF3BLplyc=; b=Vzu/RyrJ+SbAFynLlrqXIilC1mF3n+qVqVtr+Eo
	djBGUa4OorUlQbW4du/XuJ3TV4DM/ECupmjyUJWo3LVhEup/UB9xaiWDbT64BklC
	f9HAtI4dLtHhCQddVC4Fh24gEXURI8mSxuN40Y9xZgREQtoAmyeWnU8g/6miV1e3
	Z9QF+OO5hzwbqgG7XlCRg4TtndTvbMCs8HqNwlfROit92OmBqRxe6bhvQx62MBvl
	ztPDfkG5zLdWfeWT9NSgI/M3mFhmQH1Ng4VpfoEft5bcT9S5E4/89BP4NGfn8zNr
	2KJ3l8SXSS3fTsQgH636myEZCo4qbLla3g5oEiUrY/CiM+w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2ex7vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 19:24:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 19:24:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 19:24:01 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 92B533F704B;
	Tue,  9 Jun 2026 19:23:58 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sbhatta@marvell.com>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-af: npc: Fix size of entry2cntr_map
Date: Wed, 10 Jun 2026 07:53:44 +0530
Message-ID: <20260610022344.969774-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAyMCBTYWx0ZWRfX2rHVP9JoryXH
 aNDEZMHkJ8Txz882m9SCIhRJVN/DWvLGneM9YioVmpR6Int/CUkvH4YHWCeyunSVD/x1qub930N
 7IW585KOtdYoMQyCTZaV8+zindCOGMVenu52TCP5NPu1Ugh9gCsNpksxOhjqZH8cfURhE+wFmds
 HQZuNJlXaFxsPRbbenQuxpY0yXCtl42cC1KlllZ67ZpTvuHF4y2o8dcjHi7/hOvjZYfX+fNiP31
 MrbcM5/luwUIgmK8Q2WXisGo8pK++bl4Ae8rOv4Dk0kJY4pM769cS+eVgPlSVjnmCP3NlF47Qpp
 x6TUrVIqC5gsaVH4HREhDe9TmLfoIJ8u9MsM3vmQuJQ6z9r2Dmdscfsj0c+jD7vMkY8t0JtrI21
 upzdkO6EpTqZhXlPSYs45Vax1DWGRCoT6IqiWKODJ7vPXE8Lg1u6WyV5vwR259i02EOIu4RhBOD
 l02BmoA+GgjwOIsjdYA==
X-Proofpoint-GUID: ASSXzKBR10qAoIQ2xRbcdsRaDiUlLku_
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a28cac2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=yrZL8xZCd92uUAc6fdYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ASSXzKBR10qAoIQ2xRbcdsRaDiUlLku_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297408-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:naveenm@marvell.com,m:netdev@vger.kernel.org,m:sbhatta@marvell.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BCE7665701

KASAN prints below splat. This is caused by allocating counter for
reserved mcam entry for cpt 2nd pass entry. But mcam->entry2cntr_map
is not allocated for reserved entries.

BUG: KASAN: slab-out-of-bounds in npc_map_mcam_entry_and_cntr+0xb0/0x1a0
Write of size 2 at addr ffff0001033e7ffe by task kworker/0:1/14

CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 6.1.67 #1
Hardware name: Marvell CN106XX board (DT)
Workqueue: events work_for_cpu_fn
Call trace:
 dump_backtrace.part.0+0xe4/0xf0
 show_stack+0x18/0x30
 dump_stack_lvl+0x88/0xb4
 print_report+0x154/0x458
 kasan_report+0xb8/0x194
 __asan_store2+0x7c/0xa0
 npc_map_mcam_entry_and_cntr+0xb0/0x1a0
 rvu_mbox_handler_npc_mcam_write_entry+0x268/0x280
 npc_install_flow+0x840/0xfe0
 rvu_npc_install_cpt_pass2_entry+0x138/0x190
 rvu_nix_init+0x148c/0x2880
 rvu_probe+0x1800/0x30b0
 local_pci_probe+0x78/0xe0
 work_for_cpu_fn+0x30/0x50
 process_one_work+0x4cc/0x97c
 worker_thread+0x360/0x630
 kthread+0x1a0/0x1b0
 ret_from_fork+0x10/0x20

Fixes: 55307fcb9258 ("octeontx2-af: Add mbox messages to install and delete MCAM rules")
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 40 +++++++------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index d301a3f0f87a..4994385a822b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2181,7 +2181,7 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	/* Alloc memory for MCAM entry to counter mapping and for tracking
 	 * counter's reference count.
 	 */
-	mcam->entry2cntr_map = kcalloc(mcam->bmap_entries, sizeof(u16),
+	mcam->entry2cntr_map = kcalloc(mcam->total_entries, sizeof(u16),
 				       GFP_KERNEL);
 	if (!mcam->entry2cntr_map)
 		goto free_cntr_map;
@@ -2197,10 +2197,11 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	if (!mcam->entry2target_pffunc)
 		goto free_cntr_refcnt;

-	for (index = 0; index < mcam->bmap_entries; index++) {
+	for (index = 0; index < mcam->bmap_entries; index++)
 		mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
+
+	for (index = 0; index < mcam->total_entries; index++)
 		mcam->entry2cntr_map[index] = NPC_MCAM_INVALID_MAP;
-	}

 	for (cntr = 0; cntr < mcam->counters.max; cntr++)
 		mcam->cntr2pfvf_map[cntr] = NPC_MCAM_INVALID_MAP;
@@ -3531,7 +3532,7 @@ static int __npc_mcam_free_counter(struct rvu *rvu,
 				   struct msg_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	u16 index, entry = 0;
+	u16 index;
 	int blkaddr, err;

 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
@@ -3547,20 +3548,16 @@ static int __npc_mcam_free_counter(struct rvu *rvu,
 	mcam->cntr2pfvf_map[req->cntr] = NPC_MCAM_INVALID_MAP;
 	rvu_free_rsrc(&mcam->counters, req->cntr);

-	/* Disable all MCAM entry's stats which are using this counter */
-	while (entry < mcam->bmap_entries) {
+	/* Disable all MCAM entry's stats which are using this counter.
+	 * Scan the full MCAM index range: AF-reserved rules (e.g. CPT pass-2)
+	 */
+	for (index = 0; index < mcam->total_entries; index++) {
 		if (!mcam->cntr_refcnt[req->cntr])
 			break;
-
-		index = find_next_bit(mcam->bmap, mcam->bmap_entries, entry);
-		if (index >= mcam->bmap_entries)
-			break;
-		entry = index + 1;
 		if (mcam->entry2cntr_map[index] != req->cntr)
 			continue;
-
-		npc_unmap_mcam_entry_and_cntr(rvu, mcam, blkaddr,
-					      index, req->cntr);
+		npc_unmap_mcam_entry_and_cntr(rvu, mcam, blkaddr, index,
+					      req->cntr);
 	}

 	return 0;
@@ -3631,7 +3628,7 @@ int rvu_mbox_handler_npc_mcam_unmap_counter(struct rvu *rvu,
 		struct npc_mcam_unmap_counter_req *req, struct msg_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	u16 index, entry = 0;
+	u16 index;
 	int blkaddr, rc;

 	/* Counter is not supported for CN20K */
@@ -3658,20 +3655,13 @@ int rvu_mbox_handler_npc_mcam_unmap_counter(struct rvu *rvu,
 	}

 	/* Disable all MCAM entry's stats which are using this counter */
-	while (entry < mcam->bmap_entries) {
+	for (index = 0; index < mcam->total_entries; index++) {
 		if (!mcam->cntr_refcnt[req->cntr])
 			break;
-
-		index = find_next_bit(mcam->bmap, mcam->bmap_entries, entry);
-		if (index >= mcam->bmap_entries)
-			break;
-		entry = index + 1;
-
 		if (mcam->entry2cntr_map[index] != req->cntr)
 			continue;
-
-		npc_unmap_mcam_entry_and_cntr(rvu, mcam, blkaddr,
-					      index, req->cntr);
+		npc_unmap_mcam_entry_and_cntr(rvu, mcam, blkaddr, index,
+					      req->cntr);
 	}
 exit:
 	mutex_unlock(&mcam->lock);
--
2.43.0

--
v1 -> v2: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260605055839.3549559-1-rkannoth@marvell.com/

