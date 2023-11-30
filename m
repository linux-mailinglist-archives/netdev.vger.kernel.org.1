Return-Path: <netdev+bounces-52389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90877FE8F8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 07:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60219282179
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 06:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2C1D534;
	Thu, 30 Nov 2023 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dcip5YaD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC024D66;
	Wed, 29 Nov 2023 22:07:24 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU3K0rs024869;
	Wed, 29 Nov 2023 22:07:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=z4t1WdlmW+hR+yq0a+c9zTIk+DFWEXOFIevPFNpA530=;
 b=Dcip5YaDInD8BM7JevsxZbmrGY/0s+G0oH5r/e48CY/Yxa2lsAv1l46muQRW4YptzEKU
 XowbIS/GBLWGhY/z+FLA+YpC0m5njXp3ScrECMaFOTuBIN0qdhAtgcxCE+0qzq/xVpbN
 7h0TN+zbCx5SumiiW26I8tTL/3GURVZmKyse5oXKfxZ4LaX1eaCbiVW8DB3wHbQev5mc
 Ahfs3nn2a7jaA4UBKnsWJKSX+FkwJ/noGP/4z8sZ38xOnLl9ydjclbkUgwQ2s/lnBAtf
 glQcQ4Jh8va/FC0am0U1VlTJ8gpYiOLJ2Jx5LXXk7c6fUmGS/ccyYrqlbRyMkXB9Aec5 iQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3updt69krk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 22:07:10 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 22:07:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 29 Nov 2023 22:07:08 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 880E33F7071;
	Wed, 29 Nov 2023 22:07:04 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <pbhagavatula@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-af: debugfs: update CQ context fields
Date: Thu, 30 Nov 2023 11:37:03 +0530
Message-ID: <20231130060703.16769-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: a3BB-cXgoS9cXrpvAjNKSNaKFO3snIl4
X-Proofpoint-ORIG-GUID: a3BB-cXgoS9cXrpvAjNKSNaKFO3snIl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_03,2023-11-29_01,2023-05-22_02

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

This patch update the CQ structure fields to support the feature
added in new silicons and also dump these fields in debugfs.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c | 17 +++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_struct.h  | 17 +++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 468b6561ed3f..e6d7914ce61c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1825,6 +1825,8 @@ static void print_nix_rq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 static void print_nix_cq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 {
 	struct nix_cq_ctx_s *cq_ctx = &rsp->cq;
+	struct nix_hw *nix_hw = m->private;
+	struct rvu *rvu = nix_hw->rvu;
 
 	seq_printf(m, "W0: base \t\t\t%llx\n\n", cq_ctx->base);
 
@@ -1836,6 +1838,16 @@ static void print_nix_cq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 	seq_printf(m, "W1: bpid \t\t\t%d\nW1: bp_ena \t\t\t%d\n\n",
 		   cq_ctx->bpid, cq_ctx->bp_ena);
 
+	if (!is_rvu_otx2(rvu)) {
+		seq_printf(m, "W1: lbpid_high \t\t\t0x%03x\n", cq_ctx->lbpid_high);
+		seq_printf(m, "W1: lbpid_med \t\t\t0x%03x\n", cq_ctx->lbpid_med);
+		seq_printf(m, "W1: lbpid_low \t\t\t0x%03x\n", cq_ctx->lbpid_low);
+		seq_printf(m, "(W1: lbpid) \t\t\t0x%03x\n",
+			   cq_ctx->lbpid_high << 6 | cq_ctx->lbpid_med << 3 |
+			   cq_ctx->lbpid_low);
+		seq_printf(m, "W1: lbp_ena \t\t\t\t%d\n\n", cq_ctx->lbp_ena);
+	}
+
 	seq_printf(m, "W2: update_time \t\t%d\nW2:avg_level \t\t\t%d\n",
 		   cq_ctx->update_time, cq_ctx->avg_level);
 	seq_printf(m, "W2: head \t\t\t%d\nW2:tail \t\t\t%d\n\n",
@@ -1847,6 +1859,11 @@ static void print_nix_cq_ctx(struct seq_file *m, struct nix_aq_enq_rsp *rsp)
 		   cq_ctx->qsize, cq_ctx->caching);
 	seq_printf(m, "W3: substream \t\t\t0x%03x\nW3: ena \t\t\t%d\n",
 		   cq_ctx->substream, cq_ctx->ena);
+	if (!is_rvu_otx2(rvu)) {
+		seq_printf(m, "W3: lbp_frac \t\t\t%d\n", cq_ctx->lbp_frac);
+		seq_printf(m, "W3: cpt_drop_err_en \t\t\t%d\n",
+			   cq_ctx->cpt_drop_err_en);
+	}
 	seq_printf(m, "W3: drop_ena \t\t\t%d\nW3: drop \t\t\t%d\n",
 		   cq_ctx->drop_ena, cq_ctx->drop);
 	seq_printf(m, "W3: bp \t\t\t\t%d\n\n", cq_ctx->bp);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index edc9367b1b95..5ef406c7e8a4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -340,11 +340,12 @@ struct nix_aq_res_s {
 /* NIX Completion queue context structure */
 struct nix_cq_ctx_s {
 	u64 base;
-	u64 rsvd_64_67		: 4;
+	u64 lbp_ena             : 1;
+	u64 lbpid_low           : 3;
 	u64 bp_ena		: 1;
-	u64 rsvd_69_71		: 3;
+	u64 lbpid_med           : 3;
 	u64 bpid		: 9;
-	u64 rsvd_81_83		: 3;
+	u64 lbpid_high          : 3;
 	u64 qint_idx		: 7;
 	u64 cq_err		: 1;
 	u64 cint_idx		: 7;
@@ -358,10 +359,14 @@ struct nix_cq_ctx_s {
 	u64 drop		: 8;
 	u64 drop_ena		: 1;
 	u64 ena			: 1;
-	u64 rsvd_210_211	: 2;
-	u64 substream		: 20;
+	u64 cpt_drop_err_en     : 1;
+	u64 rsvd_211	        : 1;
+	u64 substream           : 12;
+	u64 stash_thresh        : 4;
+	u64 lbp_frac            : 4;
 	u64 caching		: 1;
-	u64 rsvd_233_235	: 3;
+	u64 stashing            : 1;
+	u64 rsvd_234_235	: 2;
 	u64 qsize		: 4;
 	u64 cq_err_int		: 8;
 	u64 cq_err_int_ena	: 8;
-- 
2.25.1


