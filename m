Return-Path: <netdev+bounces-291657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7kRqDnh7FWpEVwcAu9opvQ
	(envelope-from <netdev+bounces-291657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C4F5D4676
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29706305A8B2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D63DD856;
	Tue, 26 May 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kTo6wBbq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29853DC850;
	Tue, 26 May 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792486; cv=none; b=g83wNQBqNNuQwkfrFVmUX/sfOZuJ9CUqHzLNZcD+DCqjaFdpzZdAHbHAoLPXjUT0EzpxWkU/NxTVPSnCDg8F+7Cj55I97PX8XX5wCYlryelQGMSc4SgZm9ErwmofnNCcVlyMwKJ/3FLhEfTQ+0z/a8IGGuWbqC14QZPm1v5Hy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792486; c=relaxed/simple;
	bh=UO9ArN0/GP4BIu7TXgBtfuDSksIKYKASNV5DMJNjRA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkGZTE6upnRw/2jraMQgdoO5FRkE2ZkIrz43bmGLBp766Ya2HDJeYS+4H12hATZwX6ODMDTk4gXE9VQYL6Z6UKNDSWo2q8raknzXy79wRchDrnmoAnj5tzN9crtR+7xRtMdJmP6+UIxiCsw/qQPc4XHgcNHlEKjCSJwsqeCiVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kTo6wBbq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q6kRdI2935095;
	Tue, 26 May 2026 03:47:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=KZjoSY1iftfjhRK6YVsK2pJH9
	DIm781meXoamOYUg10=; b=kTo6wBbqA0D7E/nBxeikrVkzJjyD2AJCXjhDUs918
	BMMrnpcTBGvUS+5rR3aWfurzJZgBlrJSRx22AnR7UX5iPmt4rqxRkjgwsBDRk3rf
	SOXPKGmrwD1/pVH9pe5ZwzgetlQp1oCMFpnHgdHvg0+erYa3JAyrFb1SE5advq10
	QVaEHOZBrGIEN6vZyEN8OLZM9ZGLmoy8EMThQmdWRKln7VPeGfcK4ob1zKqq4R1m
	tRBD00kRhM1+8cwZskx60k7MBlCpaXYFQ42LJyw6gG5jjv7/SUFDRIEaUcNGfsqR
	0PMMYUKiCo0qW5DCQ+tJjy5t7TeI4MjGasp+dHiqfuv6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ebbrf7unp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 03:47:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 03:47:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 03:47:45 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 39C163F7052;
	Tue, 26 May 2026 03:47:41 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v6 3/5] octeontx2-af: npa: cn20k: Add DPC support
Date: Tue, 26 May 2026 16:17:25 +0530
Message-ID: <1779792447-5593-4-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
References: <1779792447-5593-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=epTvCIpX c=1 sm=1 tr=0 ts=6a157a53 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=MAZRZ2gKoPIzyDCOxB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: mIYPf1Vr6sjB4SbcCrEmEixXZvr4hie9
X-Proofpoint-GUID: mIYPf1Vr6sjB4SbcCrEmEixXZvr4hie9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MyBTYWx0ZWRfX6nMaD0yIz79L
 FQvoUHG6IGsFETmTfEWO53VRnMZtHwjePXpiSw0WXk414smtgdpCVPaJ+4NL8JmFf5skLyaowe0
 UAw9fezWcwVp/0JRh4Ppck2nts4WlbMOO2AHSDWMpitax+Ac5kcaAdEMT0pyGOogzpyUBRA3Lfi
 JD+go1kySQCdS5YXzmWFx2ZEzjVhLn5WYm23tFuW1uBqJgukZvPLet0SHskRlsq2qi7c+aCgot/
 7qzYCYTabey85X40JokCEjGXG511xTQuZJqvCkR/vlTCHrG8JhvyJI/vw5Og+dbOPPxCjdlVtOh
 ENHhf2xCU/T+Kxf5dix0Q3U6RX6OdAQN1x8EU8k5hSq1bFHzf4qhkDJCghrwe/NEXwac9VUo9lf
 SL1EeCqq05JHhHX1PQ71P4r24akXfI8sQ6mTM10fqUxEGlsuv6wYDbQ/ljmfeUAkFgpXJ5AHh/A
 Ef1glktDl0FoCgDtlQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291657-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 26C4F5D4676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Linu Cherian <lcherian@marvell.com>

CN20k introduces 32 diagnostic and performance
counters that are shared across all NPA LFs.

Counters being shared, each PF driver need to request
for a counter with the required configuration to the AF,
so that a counter can be allocated and mapped to the
respective LF with the requested configuration.

Add new mbox messages, npa_dpc_alloc/free to handle this.

Also ensure all the LF to DPC counter mappings are cleared
at the time of LF free/teardown.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   3 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 139 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  19 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  17 ++-
 6 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
index 4285b5d6a6a2..53050f63eb81 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -29,4 +29,7 @@ int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
 		     void *reg_base, int direction, int ndevs);
 void cn20k_rvu_enable_afvf_intr(struct rvu *rvu, int vfs);
 void cn20k_rvu_disable_afvf_intr(struct rvu *rvu, int vfs);
+
+void npa_cn20k_dpc_free_all(struct rvu *rvu, u16 pcifunc);
+
 #endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
index fe8f926c8b75..7c9cd28de3ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
@@ -8,6 +8,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "cn20k/api.h"
+#include "cn20k/reg.h"
 #include "struct.h"
 #include "../rvu.h"
 
@@ -19,3 +21,140 @@ int rvu_mbox_handler_npa_cn20k_aq_enq(struct rvu *rvu,
 				   (struct npa_aq_enq_rsp *)rsp);
 }
 EXPORT_SYMBOL(rvu_mbox_handler_npa_cn20k_aq_enq);
+
+static int npa_cn20k_dpc_alloc(struct rvu *rvu,
+			       struct npa_cn20k_dpc_alloc_req *req,
+			       struct npa_cn20k_dpc_alloc_rsp *rsp)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	u16 pcifunc = req->hdr.pcifunc;
+	int cntr, lf, blkaddr, ridx;
+	struct rvu_block *block;
+	struct rvu_pfvf *pfvf;
+	u64 val, lfmask;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (!pfvf->npalf || blkaddr < 0)
+		return NPA_AF_ERR_AF_LF_INVALID;
+
+	mutex_lock(&rvu->rsrc_lock);
+
+	block = &hw->block[blkaddr];
+	lf = rvu_get_lf(rvu, block, pcifunc, 0);
+	if (lf < 0) {
+		mutex_unlock(&rvu->rsrc_lock);
+		return NPA_AF_ERR_AF_LF_INVALID;
+	}
+
+	/* allocate a new counter */
+	cntr = rvu_alloc_rsrc(&rvu->npa_dpc);
+	if (cntr < 0) {
+		mutex_unlock(&rvu->rsrc_lock);
+		return cntr;
+	}
+
+	rsp->cntr_id = cntr;
+
+	/* Consumers can configure to count ALLOC/FREE requests only */
+	rvu_write64(rvu, blkaddr, NPA_AF_DPCX_CFG(cntr), req->dpc_conf);
+
+	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
+	ridx = lf >> 6;
+	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
+
+	ridx = 2 * cntr + ridx;
+	/* Give permission for LF access */
+	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
+	val |= lfmask;
+	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
+
+	mutex_unlock(&rvu->rsrc_lock);
+
+	return 0;
+}
+
+int rvu_mbox_handler_npa_cn20k_dpc_alloc(struct rvu *rvu,
+					 struct npa_cn20k_dpc_alloc_req *req,
+					 struct npa_cn20k_dpc_alloc_rsp *rsp)
+{
+	if (!is_cn20k(rvu->pdev))
+		return -EOPNOTSUPP;
+
+	return npa_cn20k_dpc_alloc(rvu, req, rsp);
+}
+
+static int npa_cn20k_dpc_free(struct rvu *rvu,
+			      struct npa_cn20k_dpc_free_req *req)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	u16 pcifunc = req->hdr.pcifunc;
+	int cntr, lf, blkaddr, ridx;
+	struct rvu_block *block;
+	struct rvu_pfvf *pfvf;
+	u64 val, lfmask;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
+	if (!pfvf->npalf || blkaddr < 0)
+		return NPA_AF_ERR_AF_LF_INVALID;
+
+	block = &hw->block[blkaddr];
+	lf = rvu_get_lf(rvu, block, pcifunc, 0);
+	if (lf < 0)
+		return NPA_AF_ERR_AF_LF_INVALID;
+
+	if (req->cntr_id >= NPA_DPC_MAX)
+		return NPA_AF_ERR_PARAM;
+
+	mutex_lock(&rvu->rsrc_lock);
+
+	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
+	ridx = lf >> 6;
+	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
+	cntr = req->cntr_id;
+
+	ridx = 2 * cntr + ridx;
+
+	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
+	/* Check if the counter is allotted to this LF */
+	if (!(val & lfmask)) {
+		mutex_unlock(&rvu->rsrc_lock);
+		return 0;
+	}
+
+	/* Revert permission */
+	val &= ~lfmask;
+	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
+
+	/* Free this counter */
+	rvu_free_rsrc(&rvu->npa_dpc, req->cntr_id);
+
+	mutex_unlock(&rvu->rsrc_lock);
+
+	return 0;
+}
+
+void npa_cn20k_dpc_free_all(struct rvu *rvu, u16 pcifunc)
+{
+	struct npa_cn20k_dpc_free_req req;
+	int i;
+
+	req.hdr.pcifunc = pcifunc;
+	for (i = 0; i < NPA_DPC_MAX; i++) {
+		req.cntr_id = i;
+		npa_cn20k_dpc_free(rvu, &req);
+	}
+}
+
+int rvu_mbox_handler_npa_cn20k_dpc_free(struct rvu *rvu,
+					struct npa_cn20k_dpc_free_req *req,
+					struct msg_rsp *rsp)
+{
+	if (!is_cn20k(rvu->pdev))
+		return -EOPNOTSUPP;
+
+	return npa_cn20k_dpc_free(rvu, req);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index 8bfaa507ee50..9b49e376878e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -143,4 +143,11 @@
 	offset = (0xb000000ull | (a) << 4 | (b) << 20);		\
 	offset; })
 
+/* NPA Registers */
+#define NPA_AF_DPCX_CFG(a)		(0x800 | (a) << 6)
+#define NPA_AF_DPC_PERMITX(a)		(0x1000 | (a) << 3)
+
+#define NPA_DPC_MAX			32
+#define NPA_DPC_LFS_PER_REG		64
+
 #endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a97bd93d882..b29ec26b66b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -213,6 +213,10 @@ M(NPA_AQ_ENQ,		0x402, npa_aq_enq, npa_aq_enq_req, npa_aq_enq_rsp)   \
 M(NPA_HWCTX_DISABLE,	0x403, npa_hwctx_disable, hwctx_disable_req, msg_rsp)\
 M(NPA_CN20K_AQ_ENQ,	0x404, npa_cn20k_aq_enq, npa_cn20k_aq_enq_req,	\
 				npa_cn20k_aq_enq_rsp)			\
+M(NPA_CN20K_DPC_ALLOC,	0x405, npa_cn20k_dpc_alloc, npa_cn20k_dpc_alloc_req, \
+				npa_cn20k_dpc_alloc_rsp)		\
+M(NPA_CN20K_DPC_FREE,	0x406, npa_cn20k_dpc_free, npa_cn20k_dpc_free_req, \
+				msg_rsp)				\
 /* SSO/SSOW mbox IDs (range 0x600 - 0x7FF) */				\
 /* TIM mbox IDs (range 0x800 - 0x9FF) */				\
 /* CPT mbox IDs (range 0xA00 - 0xBFF) */				\
@@ -910,6 +914,21 @@ struct npa_cn20k_aq_enq_rsp {
 	};
 };
 
+struct npa_cn20k_dpc_alloc_req {
+	struct mbox_msghdr hdr;
+	u16 dpc_conf;
+};
+
+struct npa_cn20k_dpc_alloc_rsp {
+	struct mbox_msghdr hdr;
+	u8 cntr_id;
+};
+
+struct npa_cn20k_dpc_free_req {
+	struct mbox_msghdr hdr;
+	u8 cntr_id;
+};
+
 /* Disable all contexts of type 'ctype' */
 struct hwctx_disable_req {
 	struct mbox_msghdr hdr;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 0c4dae6d0967..90ad2c138898 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -663,6 +663,9 @@ struct rvu {
 	/* CPT interrupt lock */
 	spinlock_t		cpt_intr_lock;
 
+	/* NPA */
+	struct rsrc_bmap	npa_dpc;
+
 	struct mutex		mbox_lock; /* Serialize mbox up and down msgs */
 	u16			rep_pcifunc;
 	bool			altaf_ready;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index d15e6969ee56..30c067399660 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -8,6 +8,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "cn20k/api.h"
+#include "cn20k/reg.h"
 #include "rvu_struct.h"
 #include "rvu_reg.h"
 #include "rvu.h"
@@ -494,6 +496,8 @@ int rvu_mbox_handler_npa_lf_free(struct rvu *rvu, struct msg_req *req,
 		return NPA_AF_ERR_LF_RESET;
 	}
 
+	if (is_cn20k(rvu->pdev))
+		npa_cn20k_dpc_free_all(rvu, pcifunc);
 	npa_ctx_free(rvu, pfvf);
 
 	return 0;
@@ -559,12 +563,19 @@ static int npa_aq_init(struct rvu *rvu, struct rvu_block *block)
 int rvu_npa_init(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
-	int blkaddr;
+	int err, blkaddr;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
 	if (blkaddr < 0)
 		return 0;
 
+	if (is_cn20k(rvu->pdev)) {
+		rvu->npa_dpc.max = NPA_DPC_MAX;
+		err = rvu_alloc_bitmap(&rvu->npa_dpc);
+		if (err)
+			return err;
+	}
+
 	/* Initialize admin queue */
 	return npa_aq_init(rvu, &hw->block[blkaddr]);
 }
@@ -581,6 +592,9 @@ void rvu_npa_freemem(struct rvu *rvu)
 
 	block = &hw->block[blkaddr];
 	rvu_aq_free(rvu, block->aq);
+
+	if (is_cn20k(rvu->pdev))
+		kfree(rvu->npa_dpc.bmap);
 }
 
 void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
@@ -601,6 +615,7 @@ void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
 	if (is_cn20k(rvu->pdev)) {
 		ctx_req.ctype = NPA_AQ_CTYPE_HALO;
 		npa_lf_hwctx_disable(rvu, &ctx_req);
+		npa_cn20k_dpc_free_all(rvu, pcifunc);
 	}
 
 	npa_ctx_free(rvu, pfvf);
-- 
2.48.1


