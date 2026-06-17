Return-Path: <netdev+bounces-300128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00EuOlmAMmrm0wUAu9opvQ
	(envelope-from <netdev+bounces-300128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EFE698D59
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:09:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=JpjJwjtn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300128-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300128-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB9E431CD711
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38C3DD538;
	Wed, 17 Jun 2026 10:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AB3D300F;
	Wed, 17 Jun 2026 10:45:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693154; cv=none; b=SkuHVsZx10qqar9qLewfi+LIYJPBYJ1PQdhySg5mCKTdOAri5WAVDakuD3xSiOO5a4zKZtSAwh5+BPw0oE+vhvrVil632pEbkwjAiQIh9VW96fRAFArZD15FODn+4vuP4H+BeooOJizd2YJUWt5H4j8lLLTRg8AbfvI5fBWgxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693154; c=relaxed/simple;
	bh=fpCMJMfU8wCh9S5pVZpQhY4EtacnSTJn86rKnPyCsIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iX50rm0KKsIa5BXSsuta+QXvJyuWVLMzHpJTTn8zvnubOxjI7+hJ45Rcjy8R6+bKHRT0b6Pz0XKKSydM7DVoQKezJI0XQK5gined6SSeIoPQrXUTVspcmDmAQ0cuMpmwi2/R9PvLSEqnLMJHJ38qNXQVksaxUI8YZ/Qbu40TPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JpjJwjtn; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8XnFk1525406;
	Wed, 17 Jun 2026 03:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=dgUc1U9bzeG3nrMDE26EL79
	6nxMAkwRFFQYzLKu4kLM=; b=JpjJwjtn6Vdy2/N5ivVhfY4CQA4Th9h56tEuvr3
	+mRHVIk487E5ccpL8zS//RAKFPWSXsbAS94cttJb8bLxy3KEA2vB5PlAIiRW0qG0
	jk25YEQIwqefg/49YhyFjKMsobfX8HwKVc7gFGYDBtG80FeA+JNcFEWKFODr9vk1
	IxRvIQMcMPslUJRWsklh666laAwslbLo6DwWQmS9a/bYFjkGItXPTO6yRaypA0tF
	t8fc76Dq5lW6trTlPOf3UtI6fGRihvSXnR0swsOOYGlFMA6vamno2ZVKPaK4DVof
	IBfqCax6zAeMuuItVWJ85pLOb+FFG37KbEaSTDNqHwsTqpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eueg5a4ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 03:45:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Jun 2026 03:45:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Jun 2026 03:45:32 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6BB873F7083;
	Wed, 17 Jun 2026 03:45:28 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>, <lcherian@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH net] octeontx2-af: fix CGX debugfs RVU AF PCI reference leaks
Date: Wed, 17 Jun 2026 16:15:25 +0530
Message-ID: <20260617104525.1321395-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Vbpte_-QjHKcLXNw1awkVAca6NLIbz5p
X-Proofpoint-ORIG-GUID: Vbpte_-QjHKcLXNw1awkVAca6NLIbz5p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfXx6Ex00+gm1Xn
 UwmzCy+mTxfrYYNJJl2YV1DY1VCZntLEaZhAWb4VNeoXOsaPxpmM8VbPQxTDKi5rlsNBIMcHVNt
 vwZcxoLSGdtv9FvbRUZbtkCZLvlPkaU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMSBTYWx0ZWRfX2DVN+VVqitV+
 3Usvjs5WMHfQZ/fFBmhqeHF687+XWEPvA8LLh3c55gooLZL/amRQlgWG9xBGjSoGSAOebzP0HSY
 2AFPQIHiE4Tofn/vrasGkyEhcEql98zr/Udh2LM1DNVy37nSy4VZOJs6t5pi4Aalhf8VBanFOBm
 /iqSgDBpNX+NGqE4FhSCNTbvLZxPRYQAmnMbc7EWYmgiCJ3Ycem4LuU/H5VGGP5F090eUqndugG
 CsA3+4VF4Dpn2KyU0A7ob2QowY6l37+jCE7BJ1EGrWKhYNDmQxzJDjyytakpBzDlXQmceoa7XCf
 4rl8IjC4o6coHaMogUO23WC7lBTTUIMVfCe9tRBUczxVrlGZiB5+/pkWLxzdaoJNPwVSKEkMkBv
 asc5YZ8+tvHhyTqKtsvKc1x5QQnelr+1gP/9Q0rUGiG5vSBqcDfonZb4ROXryeJfAGmfRtCUfbK
 9llpWOHlRAcTEumY8mQ==
X-Authority-Analysis: v=2.4 cv=UqNT8ewB c=1 sm=1 tr=0 ts=6a327acc cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=a4YZzIsXFeaM3Y4ekB4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300128-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,marvell.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:hkelam@marvell.com,m:lcherian@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:rkannoth@marvell.com,m:dbgh9129@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6EFE698D59

CGX per-lmac debugfs seq readers obtained struct rvu via
pci_get_drvdata(pci_get_device(..., PCI_DEVID_OCTEONTX2_RVU_AF, ...)),
which leaks a PCI device reference on every read. Store rvu and the CGX
handle in debugfs inode private data when creating stats, mac_filter,
and fwdata files (one context per CGX), and use debugfs aux numbers for
fwdata so lmac_id matches the other CGX debugfs entries.

Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
Cc: Linu Cherian <lcherian@marvell.com>
Reported-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 77 ++++++++++---------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fa461489acdd..77ff734438cd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2809,6 +2809,14 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
 			    &rvu_dbg_npa_ndc_hits_miss_fops);
 }
 
+/* Per-lmac CGX debugfs files need both RVU and CGX handle; inode->i_private
+ * points here so seq_file ops avoid pci_get_device(PCI_DEVID_OCTEONTX2_RVU_AF).
+ */
+struct rvu_cgx_lmac_dbgfs_ctx {
+	struct rvu	*rvu;
+	void		*cgxd;
+};
+
 #define PRINT_CGX_CUML_NIXRX_STATUS(idx, name)				\
 	({								\
 		u64 cnt;						\
@@ -2831,18 +2839,14 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
 
 static int cgx_print_stats(struct seq_file *s, int lmac_id)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
 	struct cgx_link_user_info linfo;
 	struct mac_ops *mac_ops;
-	void *cgxd = s->private;
+	void *cgxd = dctx->cgxd;
+	struct rvu *rvu = dctx->rvu;
 	u64 ucast, mcast, bcast;
 	int stat = 0, err = 0;
 	u64 tx_stat, rx_stat;
-	struct rvu *rvu;
-
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
-	if (!rvu)
-		return -ENODEV;
 
 	mac_ops = get_mac_ops(cgxd);
 	/* There can be no CGX devices at all */
@@ -2949,20 +2953,16 @@ RVU_DEBUG_SEQ_FOPS(cgx_stat, cgx_stat_display, NULL);
 
 static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
 	struct pci_dev *pdev = NULL;
-	void *cgxd = s->private;
+	void *cgxd = dctx->cgxd;
+	struct rvu *rvu = dctx->rvu;
 	char *bcast, *mcast;
 	u16 index, domain;
 	u8 dmac[ETH_ALEN];
-	struct rvu *rvu;
 	u64 cfg, mac;
 	int pf;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
-	if (!rvu)
-		return -ENODEV;
-
 	pf = cgxlmac_to_pf(rvu, cgx_get_cgxid(cgxd), lmac_id);
 	domain = 2;
 
@@ -3009,17 +3009,13 @@ RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, NULL);
 
 static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
 	struct cgx_lmac_fwdata_s *fwdata;
-	void *cgxd = s->private;
+	void *cgxd = dctx->cgxd;
+	struct rvu *rvu = dctx->rvu;
 	struct phy_s *phy;
-	struct rvu *rvu;
 	int cgx_id, i;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
-	if (!rvu)
-		return -ENODEV;
-
 	if (!rvu->fwdata)
 		return -EAGAIN;
 
@@ -3126,20 +3122,31 @@ static void rvu_dbg_cgx_init(struct rvu *rvu)
 		rvu->rvu_dbg.cgx = debugfs_create_dir(dname,
 						      rvu->rvu_dbg.cgx_root);
 
-		for_each_set_bit(lmac_id, &lmac_bmap, rvu->hw->lmac_per_cgx) {
-			/* lmac debugfs dir */
-			sprintf(dname, "lmac%d", lmac_id);
-			rvu->rvu_dbg.lmac =
-				debugfs_create_dir(dname, rvu->rvu_dbg.cgx);
-
-			debugfs_create_file_aux_num("stats", 0600, rvu->rvu_dbg.lmac,
-					    cgx, lmac_id, &rvu_dbg_cgx_stat_fops);
-			debugfs_create_file_aux_num("mac_filter", 0600,
-					    rvu->rvu_dbg.lmac, cgx, lmac_id,
-					    &rvu_dbg_cgx_dmac_flt_fops);
-			debugfs_create_file("fwdata", 0600,
-					    rvu->rvu_dbg.lmac, cgx,
-					    &rvu_dbg_cgx_fwdata_fops);
+		{
+			struct rvu_cgx_lmac_dbgfs_ctx *ctx;
+
+			ctx = devm_kzalloc(rvu->dev, sizeof(*ctx), GFP_KERNEL);
+			if (!ctx)
+				continue;
+
+			ctx->rvu = rvu;
+			ctx->cgxd = cgx;
+
+			for_each_set_bit(lmac_id, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+				/* lmac debugfs dir */
+				sprintf(dname, "lmac%d", lmac_id);
+				rvu->rvu_dbg.lmac =
+					debugfs_create_dir(dname, rvu->rvu_dbg.cgx);
+
+				debugfs_create_file_aux_num("stats", 0600, rvu->rvu_dbg.lmac,
+							    ctx, lmac_id, &rvu_dbg_cgx_stat_fops);
+				debugfs_create_file_aux_num("mac_filter", 0600,
+							    rvu->rvu_dbg.lmac, ctx, lmac_id,
+							    &rvu_dbg_cgx_dmac_flt_fops);
+				debugfs_create_file_aux_num("fwdata", 0600,
+							    rvu->rvu_dbg.lmac, ctx,
+							    lmac_id, &rvu_dbg_cgx_fwdata_fops);
+			}
 		}
 	}
 }
-- 
2.43.0


