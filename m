Return-Path: <netdev+bounces-283717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGTdLtNL+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E34B9630
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A54E4301B162
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A32ED870;
	Mon,  4 May 2026 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bVQ6FevV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE332EB5CD;
	Mon,  4 May 2026 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879961; cv=none; b=R/xPPCAIlh+79qZUi5TAZ/bhpIJpKsFuLFXDE1qUnuHnHcN2hqMOxzzwl7uIRleGbIvbdJxuhsRRqcYQ0PLk6IGNbEw+oeA+XYvAjL4T/aprAzHmNC3BO/Ksw8w+W+0X0QhnaTKO4AEOFLBNrH7pcZSGjbbrdla9XKm1NsZUr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879961; c=relaxed/simple;
	bh=baPKF36Z/hTe4IaIvwlAGx/027mEQrYoM1bDHwUNtEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgARGIx3sbMUQU/zmgpqcg1e8h/EclFCYNoJFAaxixYrKATUxc/r1lH8li/i4ZaXwAS2SHtKK/wLHIhU2hJm8xyeDR1p5DiZaDHjgVIF5uZ25TAF4daq4i0KC5VStP3Fyr3/n+Z/Ss/bgWAB8OnP3I3TwaX7mbLJNXR1b079xjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bVQ6FevV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644105rW1093480;
	Mon, 4 May 2026 00:32:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=u+AHhWedxpwVEFuC1T/1LzxBe
	5JQr4s+GKYdtqQjqmc=; b=bVQ6FevVB/FIH7xLAQ8h58bGmSPWrWCuzEsOeP9UP
	D1mgShPcdSc55nAuMOcll5zlsyLMHCt/8wSyoIXrz5MDOkXj8pOf6Gw8fnij55s1
	XRJ/vGW4/37bMHqcNoFtPEXTVkRcme/t+EAb5ebMlCpHpBj9t0DKBwy7o5k+8XXs
	XWwhd0fe6LljvcWfIHZHfYUsT0/HpIb0HDtJ+kblE8I64FmTlCZ+hDmTwFFNyOX0
	AAJIT5i0u+XcK1Cyrf/lIlJLlnuVH+En5B6ffKz2XbCjthjvXZrlZOMJ8WLciIks
	denhQ92YP0SO9OYiOgEforyMT4lp/lQNDLb8aeN7bNttg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dwemn3dfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 00:32:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 00:32:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 00:32:15 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id D15083F7054;
	Mon,  4 May 2026 00:32:11 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v5 2/4] octeontx2-af: npa: cn20k: Add DPC support
Date: Mon, 4 May 2026 13:01:59 +0530
Message-ID: <1777879921-15542-3-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
References: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: TvpZKEWmXiouapvWW2nJm74cAqk95aLY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4MCBTYWx0ZWRfX0ZqtW1s3Wq1p
 AAed1C06/PUiKAB1dJRIcnUz5Khs/+YVfpYRCsdDpfXFSiv5TJgxUsMcEGtBVdXNim5lp0OyKjc
 xzSUiM5ajXwpRBktHXj/l/FdCC76qYm7d6Kc7ad4KgfTri01FtpehNPFUz2m/8v6rd7+H7LOAgc
 feZ64MgG45IK21vS13+poPpk+3LgHUo1sOn3ieBMUqYw9ROpQhh7HY+hXDJZCmnY4EbN7fLIyhB
 +JIH7lNhdSQVt2sGz817Oha7iXikKc042prk6Ruaf52QPr//EXDO06ddGcSLRK8+EEVHdz/Vi3K
 WcMkioQwc6KBRlRcwNSLjwJUBPVoa0VNXrC9MusW5St6xLory11Qg/X/2qJX3VCPcDihbUCYI9z
 t3l+nu3wj46rVFBzB2MsEnOQUwbnKWcb0Vb4QUHxbNxp7dUuC0v16mxRL+51CNs8NWYmx35zm68
 gs01VWJURN6+PmHod8g==
X-Authority-Analysis: v=2.4 cv=APzNkgjn c=1 sm=1 tr=0 ts=69f84b80 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=MAZRZ2gKoPIzyDCOxB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: TvpZKEWmXiouapvWW2nJm74cAqk95aLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 710E34B9630
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-283717-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

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
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 129 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  19 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  14 +-
 6 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
index 4285b5d6a6a2..b13e7628f767 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -29,4 +29,10 @@ int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
 		     void *reg_base, int direction, int ndevs);
 void cn20k_rvu_enable_afvf_intr(struct rvu *rvu, int vfs);
 void cn20k_rvu_disable_afvf_intr(struct rvu *rvu, int vfs);
+
+int npa_cn20k_dpc_alloc(struct rvu *rvu, struct npa_cn20k_dpc_alloc_req *req,
+			struct npa_cn20k_dpc_alloc_rsp *rsp);
+int npa_cn20k_dpc_free(struct rvu *rvu, struct npa_cn20k_dpc_free_req *req);
+void npa_cn20k_dpc_free_all(struct rvu *rvu, u16 pcifunc);
+
 #endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
index c963f43dc7b0..24a710f4f5fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
@@ -8,6 +8,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "cn20k/api.h"
+#include "cn20k/reg.h"
 #include "struct.h"
 #include "../rvu.h"
 
@@ -46,3 +48,130 @@ int rvu_npa_halo_hwctx_disable(struct npa_aq_enq_req *req)
 
 	return 0;
 }
+
+int npa_cn20k_dpc_alloc(struct rvu *rvu, struct npa_cn20k_dpc_alloc_req *req,
+			struct npa_cn20k_dpc_alloc_rsp *rsp)
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
+	mutex_lock(&rvu->rsrc_lock);
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
+	/* DPC counter config */
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
+	return npa_cn20k_dpc_alloc(rvu, req, rsp);
+}
+
+int npa_cn20k_dpc_free(struct rvu *rvu, struct npa_cn20k_dpc_free_req *req)
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
index 36a71d32b894..0299fa1bd3bc 100644
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
index 809386c6bcba..f7916ac79c69 100644
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
@@ -504,6 +506,8 @@ int rvu_mbox_handler_npa_lf_free(struct rvu *rvu, struct msg_req *req,
 		return NPA_AF_ERR_LF_RESET;
 	}
 
+	if (is_cn20k(rvu->pdev))
+		npa_cn20k_dpc_free_all(rvu, pcifunc);
 	npa_ctx_free(rvu, pfvf);
 
 	return 0;
@@ -569,12 +573,17 @@ static int npa_aq_init(struct rvu *rvu, struct rvu_block *block)
 int rvu_npa_init(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
-	int blkaddr;
+	int err, blkaddr;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
 	if (blkaddr < 0)
 		return 0;
 
+	rvu->npa_dpc.max = NPA_DPC_MAX;
+	err = rvu_alloc_bitmap(&rvu->npa_dpc);
+	if (err)
+		return err;
+
 	/* Initialize admin queue */
 	return npa_aq_init(rvu, &hw->block[blkaddr]);
 }
@@ -591,6 +600,7 @@ void rvu_npa_freemem(struct rvu *rvu)
 
 	block = &hw->block[blkaddr];
 	rvu_aq_free(rvu, block->aq);
+	kfree(rvu->npa_dpc.bmap);
 }
 
 void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
@@ -611,6 +621,8 @@ void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
 	ctx_req.ctype = NPA_AQ_CTYPE_HALO;
 	npa_lf_hwctx_disable(rvu, &ctx_req);
 
+	if (is_cn20k(rvu->pdev))
+		npa_cn20k_dpc_free_all(rvu, pcifunc);
 	npa_ctx_free(rvu, pfvf);
 }
 
-- 
2.48.1


