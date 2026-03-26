Return-Path: <netdev+bounces-271916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEjzJi7oxGkz5AQAu9opvQ
	(envelope-from <netdev+bounces-271916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:02:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1635330CED
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15C55302C13B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F43346774;
	Thu, 26 Mar 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WtD/jlsO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74223504B;
	Thu, 26 Mar 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512094; cv=none; b=mV9kjIQ7YfFDLv4sAxJnJ8vlXa6pTMADsgDyPhSBzqRyHdaozMhEJMEfY5PNZE40R4S6k4ANYT6hVpfuR7/LPqv0mD7TT4MJcsX60A01gVFl1TujFaTkmRcek6am7u1oYiRl10bmb/5MwUkxjUjKfsLiJdeJe4I9OpQ2rjCgWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512094; c=relaxed/simple;
	bh=y5oW7zxnjDdRFa0HXOEXh0mKNhkE6lygUG0JeG9Ond4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FreepvSr0dPLPFh5n+RHIBu/7EifyFNH6jQbFdlE82Wk6TITpAdXzjObxf9Dhg1Qe/H2oXxyCMz9ufPLjjq2x8yF5p8rLr93D2tfgpkvB187YZghZs+we16RMQk6oyPnJd6ZEPchDwPUbAcb1R14X0WZm97HtANXQ8GYeQiqlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WtD/jlsO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7F1w92125476;
	Thu, 26 Mar 2026 01:01:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Bc8xIn9n/6+Fm0RK+RDcgYI+e
	II5tdDJ+925QTFX2V4=; b=WtD/jlsOzuBc+5DNaF5zy/6dRICa9tRcoIYQ+3Ls+
	uWA9h9apFysufdku+C5G5mQWm8ckf60lo9Yrcjq6ckornQZBJKxQqUVqZlDKCoW6
	oVMWY8ltErkxftyrLz8slHUXBjp2KN8n30OLTjn2EnohAkIUDl+SyDZkJXbKlAkv
	+rDlwzlCKAf3jifkRuAdUns0PSYfRPC6RSVCf51+V0OrvK6en9Q1Ma8nxxYgnHur
	5fo/gvhbnq0bxZieQ/0LBzQmwFQKF+mdztwuODqS+PgZyzyjxhjDCxVc8rJqv6jR
	3aC2zyqb7VLgQnYN2eScohApF3IwQjOYRaiwWnCtsokmA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d47nabvr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:01:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 01:01:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 01:01:13 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 1DF443F7070;
	Thu, 26 Mar 2026 01:01:08 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 3/4] octeontx2-af: npa: cn20k: Add debugfs for Halo
Date: Thu, 26 Mar 2026 13:30:47 +0530
Message-ID: <1774512048-10740-4-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774512048-10740-1-git-send-email-sbhatta@marvell.com>
References: <1774512048-10740-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA1NyBTYWx0ZWRfXw76IffPBZ1m2
 PxqLUEz5LhuFKKK22NSgSG6dny/ysuJW67+JRruWNQE3o5pQBpwwwsYFvieBRrego/hzawvRjhV
 kK/Es3mIlV3ZdbupSNp4Ilu4CxSZaR/rrbRkU6dW7nYu2ApzlLXXmpeFn8GNkCbVQCsXgcD51xw
 G9raSReqjHqaG43J6q+ZzqtgAC+/DtWS4Nw1duiGyBssTvhp+l4CpB1i+RiJQshdd0fHV9qdZRB
 YjilbcIRTil64rza4HLTwgj408hqGWoqIYFqTHh/v5k0arPE0lpsuCq3Hyw8f8zB9z7A8YBBwtQ
 XS3wcFkqRGDmqQI5Cc60g4hzWnqUwqBGnM/FTtO8PDMtqN04OA0o1Ot4YajbF7Wd3XtGPWbGOPZ
 UHBXuTAw4y+ITsMF/T297MrAwGrpfKilW5DMHoTvwbV7ouM+5vo/waOmut5Si400rmrrhmzagYJ
 SKI5oWrK+RbEwP8aANg==
X-Authority-Analysis: v=2.4 cv=LsifC3dc c=1 sm=1 tr=0 ts=69c4e7cb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=xE7MTFBHVDZtU5icdfMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0WaBlGrcJDoMN0c61UsUyjYqi3Q7KhNL
X-Proofpoint-GUID: 0WaBlGrcJDoMN0c61UsUyjYqi3Q7KhNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271916-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D1635330CED
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
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 60 ++++++++++++++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |  2 +
 .../marvell/octeontx2/af/rvu_debugfs.c        | 71 ++++++++++++++++---
 3 files changed, 125 insertions(+), 8 deletions(-)

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
index fa461489acdd..0ac59103b4a4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -968,6 +968,9 @@ static void print_npa_qsize(struct seq_file *m, struct rvu_pfvf *pfvf)
 		seq_printf(m, "Aura count : %d\n", pfvf->aura_ctx->qsize);
 		seq_printf(m, "Aura context ena/dis bitmap : %*pb\n",
 			   pfvf->aura_ctx->qsize, pfvf->aura_bmap);
+		if (pfvf->halo_bmap)
+			seq_printf(m, "Halo context ena/dis bitmap : %*pb\n",
+				   pfvf->aura_ctx->qsize, pfvf->halo_bmap);
 	}
 
 	if (!pfvf->pool_ctx) {
@@ -1195,6 +1198,20 @@ static void print_npa_pool_ctx(struct seq_file *m, struct npa_aq_enq_rsp *rsp)
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
@@ -1211,6 +1228,7 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 
 	switch (ctype) {
 	case NPA_AQ_CTYPE_AURA:
+	case NPA_AQ_CTYPE_HALO:
 		npalf = rvu->rvu_dbg.npa_aura_ctx.lf;
 		id = rvu->rvu_dbg.npa_aura_ctx.id;
 		all = rvu->rvu_dbg.npa_aura_ctx.all;
@@ -1235,6 +1253,9 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 	} else if (ctype == NPA_AQ_CTYPE_POOL && !pfvf->pool_ctx) {
 		seq_puts(m, "Pool context is not initialized\n");
 		return -EINVAL;
+	} else if (ctype == NPA_AQ_CTYPE_HALO && !pfvf->aura_ctx) {
+		seq_puts(m, "Halo context is not initialized\n");
+		return -EINVAL;
 	}
 
 	memset(&aq_req, 0, sizeof(struct npa_aq_enq_req));
@@ -1244,6 +1265,9 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 	if (ctype == NPA_AQ_CTYPE_AURA) {
 		max_id = pfvf->aura_ctx->qsize;
 		print_npa_ctx = print_npa_aura_ctx;
+	} else if (ctype == NPA_AQ_CTYPE_HALO) {
+		max_id = pfvf->aura_ctx->qsize;
+		print_npa_ctx = print_npa_cn20k_halo_ctx;
 	} else {
 		max_id = pfvf->pool_ctx->qsize;
 		print_npa_ctx = print_npa_pool_ctx;
@@ -1251,8 +1275,7 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
 
 	if (id < 0 || id >= max_id) {
 		seq_printf(m, "Invalid %s, valid range is 0-%d\n",
-			   (ctype == NPA_AQ_CTYPE_AURA) ? "aura" : "pool",
-			max_id - 1);
+			   npa_ctype_str(ctype), max_id - 1);
 		return -EINVAL;
 	}
 
@@ -1265,12 +1288,19 @@ static int rvu_dbg_npa_ctx_display(struct seq_file *m, void *unused, int ctype)
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
@@ -1299,6 +1329,12 @@ static int write_npa_ctx(struct rvu *rvu, bool all,
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
@@ -1309,13 +1345,14 @@ static int write_npa_ctx(struct rvu *rvu, bool all,
 
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
@@ -1374,12 +1411,12 @@ static ssize_t rvu_dbg_npa_ctx_write(struct file *filp,
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
@@ -1417,6 +1454,21 @@ static int rvu_dbg_npa_aura_ctx_display(struct seq_file *filp, void *unused)
 
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
@@ -2798,6 +2850,9 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
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


