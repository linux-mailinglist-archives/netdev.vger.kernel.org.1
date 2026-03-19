Return-Path: <netdev+bounces-269420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKFLGb3iu2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:49:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2C22CA99D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FB5D3039F4D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F443CD8BB;
	Thu, 19 Mar 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eIcQSIiA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CA3CCA18;
	Thu, 19 Mar 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920866; cv=none; b=fy1JLuf3Dtgbapk0Z+uKNf1mpSsZUhlkstudRI2flq1e8PUzOqzY/e0sOxJMrIyet0DT5bl36Z4HcEq5CBnfmdE2Gcfbo5f4Z0+VRc9zg4OGca8t5NmvO41s/gPAmttzWSUCGDZNNFv6o87toswAtZH9I580gB6Uq2IGukuJliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920866; c=relaxed/simple;
	bh=Wo08HBYtpWbJHsU8DNJFH4PFy1XGqADEO8nMgvfAznw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME433cUdJ4BRs/UOWs4ycXOf2FlTWkrI1NVGaYKADPtuQd3YfUJLS/41qk1A93sowiexzjh9gs24Z7Go/TvThdaBAYS8Y+wwD+PTHoB40xp9e4dFxN9pFEbGEuNJ4R5fewCC5Ty3mVX9TsZDpliUfllOOXVOQfXC11RaCwBwiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eIcQSIiA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4wfQK3901489;
	Thu, 19 Mar 2026 04:47:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wZKepoax+H+/OgyDKVi/1FeIV
	DuSq6R0MymFyeJE6Og=; b=eIcQSIiApJhP5/20wGdtCwlLAFcgtKIFpbGfmj5pz
	QcjZR25Ax3WMhQV8XiiKLVg34gjFTbT8ilwM3in7YT3S45gb1UD2jLJmIe8noMSj
	E70VEdODLsXgI42pFp+FjPIlHZIh/ndRoPPCkZZquvrXRPsrX43ZjSYFtUctdjlo
	1BDmncIMf9Wq+0r6R9YGJw7KBJiBV5KiG54RW1lOORZiJqt7whAvTOqI3nPsiO8q
	rbrlX7e/AVhTCQej2PMjxWBXAwoQBZ9vXS6Ngaq/7HFX41xyGser13cGnb8NCOeO
	f8bqat75O+yoqOcCjL85iKY5zFi8qnq4uQqVDAr71jezQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d07ws93rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 04:47:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Mar 2026 04:47:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 19 Mar 2026 04:47:32 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 425853F706D;
	Thu, 19 Mar 2026 04:47:29 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 3/4] octeontx2-af: npa: cn20k: Add debugfs for Halo
Date: Thu, 19 Mar 2026 17:17:05 +0530
Message-ID: <1773920826-16985-4-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1773920826-16985-1-git-send-email-sbhatta@marvell.com>
References: <1773920826-16985-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: WEVUPZNEuV7O1PuLK7L-V66g7ntsfoKV
X-Proofpoint-ORIG-GUID: WEVUPZNEuV7O1PuLK7L-V66g7ntsfoKV
X-Authority-Analysis: v=2.4 cv=Wrgm8Nfv c=1 sm=1 tr=0 ts=69bbe256 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=xE7MTFBHVDZtU5icdfMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NSBTYWx0ZWRfX43yUiJLwh0B0
 MYm3qjeWtqfiRkSuHcizhbOlE12DGyws8xNqOTbpxh1VdvqrHDmeqkuCSqaK80afqBwNg4yJn2p
 jdh4LUddjoW2tOCt6TDNbYe6tIzgJE8M26LJT/HGE3FvSJKgyb8wLUb6TBme5yFA8asE9wVrdfs
 Nxrgw+PsnWR8NDPNs+fVoLJLcG+yuj9LB8aTc6DD6l9LvzVhq5y59D3EX/6zM4OQBt7POeF244p
 QqVe/j7S6pu4NPJY6S5pK7fKeYm0xwoTB6fPaclNkNqIezC3H3TxxaM9DAkcghtdOHOAPnoGGE0
 SOweIlzwDEXGYBKVmIul6VHTMVbC9oraJisoCiykDrVxcQHr+7EaQecIp+/VI1CrZqEDbTe99nu
 KqHEMYaKxF8Ne/0QwJVH1kDrUY2/RtV/ZUnHk4n8geT2NLmvtTHj1yYEewePovGL7ygqLlNnRlt
 kgl16Oh8gES8R1ymtZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269420-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CB2C22CA99D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Linu Cherian <lcherian@marvell.com>

Similar to other hardware contexts add debugfs support for
unified Halo context.

Sample output on cn20k::
/sys/kernel/debug/cn20k/npa # cat halo_ctx
======halo : 2=======
W0: Stack base          ffffff790000
W1: ena                 1
W1: nat_align           0
W1: stack_caching       1
W1: aura drop ena       0
W1: aura drop           0
W1: buf_offset          0
W1: buf_size            32
W1: ref_cnt_prof                0
W2: stack_max_pages     13
W2: stack_pages         11
W3: bp_0                0
W3: bp_1                0
W3: bp_2                0

snip ..

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 60 +++++++++++++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |  2 +
 .../marvell/octeontx2/af/rvu_debugfs.c        | 74 +++++++++++++++++--
 3 files changed, 128 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 3debf2fae1a4..c0cfd3a39c23 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -489,3 +489,63 @@ void print_npa_cn20k_pool_ctx(struct seq_file *m,
 		   pool->thresh_qint_idx, pool->err_qint_idx);
 	seq_printf(m, "W8: fc_msh_dst\t\t%d\n", pool->fc_msh_dst);
 }
+
+void print_npa_cn20k_halo_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
+{
+	struct npa_cn20k_aq_enq_rsp *cn20k_rsp;
+	struct npa_cn20k_halo_s *halo;
+
+	cn20k_rsp = (struct npa_cn20k_aq_enq_rsp *)rsp;
+	halo = &cn20k_rsp->halo;
+
+	seq_printf(m, "W0: Stack base\t\t%llx\n", halo->stack_base);
+
+	seq_printf(m, "W1: ena \t\t%d\nW1: nat_align \t\t%d\n",
+		   halo->ena, halo->nat_align);
+	seq_printf(m, "W1: stack_caching\t%d\n",
+		   halo->stack_caching);
+	seq_printf(m, "W1: aura drop ena\t%d\n", halo->aura_drop_ena);
+	seq_printf(m, "W1: aura drop\t\t%d\n", halo->aura_drop);
+	seq_printf(m, "W1: buf_offset\t\t%d\nW1: buf_size\t\t%d\n",
+		   halo->buf_offset, halo->buf_size);
+	seq_printf(m, "W1: ref_cnt_prof\t\t%d\n", halo->ref_cnt_prof);
+	seq_printf(m, "W2: stack_max_pages \t%d\nW2: stack_pages\t\t%d\n",
+		   halo->stack_max_pages, halo->stack_pages);
+	seq_printf(m, "W3: bp_0\t\t%d\nW3: bp_1\t\t%d\nW3: bp_2\t\t%d\n",
+		   halo->bp_0, halo->bp_1, halo->bp_2);
+	seq_printf(m, "W3: bp_3\t\t%d\nW3: bp_4\t\t%d\nW3: bp_5\t\t%d\n",
+		   halo->bp_3, halo->bp_4, halo->bp_5);
+	seq_printf(m, "W3: bp_6\t\t%d\nW3: bp_7\t\t%d\nW3: bp_ena_0\t\t%d\n",
+		   halo->bp_6, halo->bp_7, halo->bp_ena_0);
+	seq_printf(m, "W3: bp_ena_1\t\t%d\nW3: bp_ena_2\t\t%d\n",
+		   halo->bp_ena_1, halo->bp_ena_2);
+	seq_printf(m, "W3: bp_ena_3\t\t%d\nW3: bp_ena_4\t\t%d\n",
+		   halo->bp_ena_3, halo->bp_ena_4);
+	seq_printf(m, "W3: bp_ena_5\t\t%d\nW3: bp_ena_6\t\t%d\n",
+		   halo->bp_ena_5, halo->bp_ena_6);
+	seq_printf(m, "W3: bp_ena_7\t\t%d\n", halo->bp_ena_7);
+	seq_printf(m, "W4: stack_offset\t%d\nW4: shift\t\t%d\nW4: avg_level\t\t%d\n",
+		   halo->stack_offset, halo->shift, halo->avg_level);
+	seq_printf(m, "W4: avg_con \t\t%d\nW4: fc_ena\t\t%d\nW4: fc_stype\t\t%d\n",
+		   halo->avg_con, halo->fc_ena, halo->fc_stype);
+	seq_printf(m, "W4: fc_hyst_bits\t%d\nW4: fc_up_crossing\t%d\n",
+		   halo->fc_hyst_bits, halo->fc_up_crossing);
+	seq_printf(m, "W4: update_time\t\t%d\n", halo->update_time);
+	seq_printf(m, "W5: fc_addr\t\t%llx\n", halo->fc_addr);
+	seq_printf(m, "W6: ptr_start\t\t%llx\n", halo->ptr_start);
+	seq_printf(m, "W7: ptr_end\t\t%llx\n", halo->ptr_end);
+	seq_printf(m, "W8: bpid_0\t\t%d\n", halo->bpid_0);
+	seq_printf(m, "W8: err_int \t\t%d\nW8: err_int_ena\t\t%d\n",
+		   halo->err_int, halo->err_int_ena);
+	seq_printf(m, "W8: thresh_int\t\t%d\nW8: thresh_int_ena \t%d\n",
+		   halo->thresh_int, halo->thresh_int_ena);
+	seq_printf(m, "W8: thresh_up\t\t%d\nW8: thresh_qint_idx\t%d\n",
+		   halo->thresh_up, halo->thresh_qint_idx);
+	seq_printf(m, "W8: err_qint_idx \t%d\n", halo->err_qint_idx);
+	seq_printf(m, "W9: thresh\t\t%llu\n", (u64)halo->thresh);
+	seq_printf(m, "W9: fc_msh_dst\t\t%d\n", halo->fc_msh_dst);
+	seq_printf(m, "W9: op_dpc_ena\t\t%d\nW9: op_dpc_set\t\t%d\n",
+		   halo->op_dpc_ena, halo->op_dpc_set);
+	seq_printf(m, "W9: stream_ctx\t\t%d\nW9: unified_ctx\t\t%d\n",
+		   halo->stream_ctx, halo->unified_ctx);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
index 0c5f05883666..7e00c7499e35 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
@@ -27,5 +27,7 @@ void print_npa_cn20k_aura_ctx(struct seq_file *m,
 			      struct npa_cn20k_aq_enq_rsp *rsp);
 void print_npa_cn20k_pool_ctx(struct seq_file *m,
 			      struct npa_cn20k_aq_enq_rsp *rsp);
+void print_npa_cn20k_halo_ctx(struct seq_file *m,
+			      struct npa_aq_enq_rsp *rsp);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 413f9fa40b33..3d73bf7f0b1f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -975,6 +975,12 @@ static void print_npa_qsize(struct seq_file *m, struct rvu_pfvf *pfvf)
 					pfvf->aura_ctx->qsize);
 		seq_printf(m, "Aura count : %d\n", pfvf->aura_ctx->qsize);
 		seq_printf(m, "Aura context ena/dis bitmap : %s\n", buf);
+		if (pfvf->halo_bmap) {
+			bitmap_print_to_pagebuf(false, buf, pfvf->halo_bmap,
+						pfvf->aura_ctx->qsize);
+			seq_printf(m, "Halo context ena/dis bitmap : %s\n",
+				   buf);
+		}
 	}
 
 	if (!pfvf->pool_ctx) {
@@ -1204,6 +1210,20 @@ static void print_npa_pool_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
 		seq_printf(m, "W8: fc_msh_dst\t\t%d\n", pool->fc_msh_dst);
 }
 
+static const char *npa_ctype_str(int ctype)
+{
+	switch (ctype) {
+	case NPA_AQ_CTYPE_AURA:
+		return "aura";
+	case NPA_AQ_CTYPE_HALO:
+		return "halo";
+	case NPA_AQ_CTYPE_POOL:
+		return "pool";
+	default:
+		return "unknown";
+	}
+}
+
 /* Reads aura/pool's ctx from admin queue */
 static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 {
@@ -1220,6 +1240,7 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 
 	switch (ctype) {
 	case NPA_AQ_CTYPE_AURA:
+	case NPA_AQ_CTYPE_HALO:
 		npalf = rvu->rvu_dbg.npa_aura_ctx.lf;
 		id = rvu->rvu_dbg.npa_aura_ctx.id;
 		all = rvu->rvu_dbg.npa_aura_ctx.all;
@@ -1244,6 +1265,9 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 	} else if (ctype == NPA_AQ_CTYPE_POOL && !pfvf->pool_ctx) {
 		seq_puts(m, "Pool context is not initialized\n");
 		return -EINVAL;
+	} else if (ctype == NPA_AQ_CTYPE_HALO && !pfvf->aura_ctx) {
+		seq_puts(m, "Halo context is not initialized\n");
+		return -EINVAL;
 	}
 
 	memset(&aq_req, 0, sizeof(struct npa_aq_enq_req));
@@ -1253,6 +1277,9 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 	if (ctype == NPA_AQ_CTYPE_AURA) {
 		max_id = pfvf->aura_ctx->qsize;
 		print_npa_ctx = print_npa_aura_ctx;
+	} else if (ctype == NPA_AQ_CTYPE_HALO) {
+		max_id = pfvf->aura_ctx->qsize;
+		print_npa_ctx = print_npa_cn20k_halo_ctx;
 	} else {
 		max_id = pfvf->pool_ctx->qsize;
 		print_npa_ctx = print_npa_pool_ctx;
@@ -1260,8 +1287,7 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 
 	if (id < 0 || id >= max_id) {
 		seq_printf(m, "Invalid %s, valid range is 0-%d\n",
-			   (ctype == NPA_AQ_CTYPE_AURA) ? "aura" : "pool",
-			max_id - 1);
+			   npa_ctype_str(ctype), max_id - 1);
 		return -EINVAL;
 	}
 
@@ -1274,12 +1300,19 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 		aq_req.aura_id = aura;
 
 		/* Skip if queue is uninitialized */
+		if (ctype == NPA_AQ_CTYPE_AURA &&
+		    !test_bit(aura, pfvf->aura_bmap))
+			continue;
+
+		if (ctype == NPA_AQ_CTYPE_HALO &&
+		    !test_bit(aura, pfvf->halo_bmap))
+			continue;
+
 		if (ctype == NPA_AQ_CTYPE_POOL && !test_bit(aura, pfvf->pool_bmap))
 			continue;
 
-		seq_printf(m, "======%s : %d=======\n",
-			   (ctype == NPA_AQ_CTYPE_AURA) ? "AURA" : "POOL",
-			aq_req.aura_id);
+		seq_printf(m, "======%s : %d=======\n", npa_ctype_str(ctype),
+			   aq_req.aura_id);
 		rc = rvu_npa_aq_enq_inst(rvu, &aq_req, &rsp);
 		if (rc) {
 			seq_puts(m, "Failed to read context\n");
@@ -1308,6 +1341,12 @@ static int write_npa_ctx(struct rvu *rvu, bool all,
 			return -EINVAL;
 		}
 		max_id = pfvf->aura_ctx->qsize;
+	} else if (ctype == NPA_AQ_CTYPE_HALO) {
+		if (!pfvf->aura_ctx) {
+			dev_warn(rvu->dev, "Halo context is not initialized\n");
+			return -EINVAL;
+		}
+		max_id = pfvf->aura_ctx->qsize;
 	} else if (ctype == NPA_AQ_CTYPE_POOL) {
 		if (!pfvf->pool_ctx) {
 			dev_warn(rvu->dev, "Pool context is not initialized\n");
@@ -1318,13 +1357,14 @@ static int write_npa_ctx(struct rvu *rvu, bool all,
 
 	if (id < 0 || id >= max_id) {
 		dev_warn(rvu->dev, "Invalid %s, valid range is 0-%d\n",
-			 (ctype == NPA_AQ_CTYPE_AURA) ? "aura" : "pool",
+			 npa_ctype_str(ctype),
 			max_id - 1);
 		return -EINVAL;
 	}
 
 	switch (ctype) {
 	case NPA_AQ_CTYPE_AURA:
+	case NPA_AQ_CTYPE_HALO:
 		rvu->rvu_dbg.npa_aura_ctx.lf = npalf;
 		rvu->rvu_dbg.npa_aura_ctx.id = id;
 		rvu->rvu_dbg.npa_aura_ctx.all = all;
@@ -1383,12 +1423,12 @@ static ssize_t rvu_dbg_npa_ctx_write(struct file *filp,
 				     const char __user *buffer,
 				     size_t count, loff_t *ppos, int ctype)
 {
-	char *cmd_buf, *ctype_string = (ctype == NPA_AQ_CTYPE_AURA) ?
-					"aura" : "pool";
+	const char *ctype_string = npa_ctype_str(ctype);
 	struct seq_file *seqfp = filp->private_data;
 	struct rvu *rvu = seqfp->private;
 	int npalf, id = 0, ret;
 	bool all = false;
+	char *cmd_buf;
 
 	if ((*ppos != 0) || !count)
 		return -EINVAL;
@@ -1426,6 +1466,21 @@ static int rvu_dbg_npa_aura_ctx_display(struct seq_file *filp, void *unused)
 
 RVU_DEBUG_SEQ_FOPS(npa_aura_ctx, npa_aura_ctx_display, npa_aura_ctx_write);
 
+static ssize_t rvu_dbg_npa_halo_ctx_write(struct file *filp,
+					  const char __user *buffer,
+					  size_t count, loff_t *ppos)
+{
+	return rvu_dbg_npa_ctx_write(filp, buffer, count, ppos,
+				     NPA_AQ_CTYPE_HALO);
+}
+
+static int rvu_dbg_npa_halo_ctx_display(struct seq_file *filp, void *unused)
+{
+	return rvu_dbg_npa_ctx_display(filp, unused, NPA_AQ_CTYPE_HALO);
+}
+
+RVU_DEBUG_SEQ_FOPS(npa_halo_ctx, npa_halo_ctx_display, npa_halo_ctx_write);
+
 static ssize_t rvu_dbg_npa_pool_ctx_write(struct file *filp,
 					  const char __user *buffer,
 					  size_t count, loff_t *ppos)
@@ -2816,6 +2871,9 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
 			    &rvu_dbg_npa_qsize_fops);
 	debugfs_create_file("aura_ctx", 0600, rvu->rvu_dbg.npa, rvu,
 			    &rvu_dbg_npa_aura_ctx_fops);
+	if (is_cn20k(rvu->pdev))
+		debugfs_create_file("halo_ctx", 0600, rvu->rvu_dbg.npa, rvu,
+				    &rvu_dbg_npa_halo_ctx_fops);
 	debugfs_create_file("pool_ctx", 0600, rvu->rvu_dbg.npa, rvu,
 			    &rvu_dbg_npa_pool_ctx_fops);
 
-- 
2.48.1


