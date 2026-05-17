Return-Path: <netdev+bounces-288744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LnfNw3VCWpRrwQAu9opvQ
	(envelope-from <netdev+bounces-288744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81196561BC4
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B96423003340
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E24255F28;
	Sun, 17 May 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SkoVtGwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90F2AEE1;
	Sun, 17 May 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029259; cv=none; b=JTjgthrVxtjnXzuuxRdCFuwixiTa7gE+OI7mVoI/O9wFpAm4HxPRaPN9/AoieugqhJgyopKmKsPvKfhnj3PqkRTHy2M1AzlnGcJv7i0cPTpX6QnjdT75TJXeVFznyr/xmr5GWEs3icu8UTq69cD2NHaD1shEdHzJkHsgzlI0OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029259; c=relaxed/simple;
	bh=BEHpKpEd77lX+9kQfr2vCFUzYxbfYYT1hRmevbFKGBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/aL6BBEGZIZluhb6UEwxl2lc7uQx/PvQ6F7JYEJwin/pAYIQ+/ReQuTRT8bVzMcQ5Eolb3+osJpXYCWMXjzHbBz1EQDkSQLR4Ru7t/udHOtu6DtSS/bMHP1OvjrYR9UV0u0CW5FIEN/rdwvMvzNlLfVfgsfJOO+PXsdnIsr/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SkoVtGwZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HCUYVj3942766;
	Sun, 17 May 2026 07:47:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=9Sqe34V2S2Yc63YS3YZ9XqZNc
	rQWj2QL1bYPuKbJRqk=; b=SkoVtGwZKBkpJyMssUSTJxIz/9UZ+7PqkuP6YGI0f
	kthDjfe5Q9cmVLwSJTIMDK9w49WEa4s4J3D0rq1fYPtOo8vmZrsjC22dcBezclKQ
	JTC6NrNinh1DeI2caTidpUK1jn15cMdfbOAGybUCxjrmBpPFuIl8WxbH0Bx6V5Ci
	MxoZ7Vc/ebCzf+tfneumh1UVy88YeSglndhi+Z8P1h5h4iqoWbOKitEPf8Fez8BL
	yUe8Uzqy2FSnOg51z4Cur0vuvjTJwIxz4xra28QFREtjltLtudhBLxegSUe5R18y
	NVrx9H3ylJjT4z1fdYADHgrlku89Jj7/mqBvXYwLRtFjg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e6nxkj92h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 07:47:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 17 May 2026 07:47:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 17 May 2026 07:47:14 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 8FF945E6868;
	Sun, 17 May 2026 07:47:10 -0700 (PDT)
Date: Sun, 17 May 2026 20:17:09 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: Re: [net-next PATCH v5 2/4] octeontx2-af: npa: cn20k: Add DPC support
Message-ID: <20260517144709.GB1632721@kernel-ep2>
References: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
 <1777879921-15542-3-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1777879921-15542-3-git-send-email-sbhatta@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE1OSBTYWx0ZWRfX8bJvH1bMwJBd
 S566uvQzFDCupNtUL57VdTMBe4PXqAsAnZKGADl0kgo0v+1wvIZQhXwKDM1bW3ZPkafOwhYM3+t
 nTlBGbgzUPwPkhzlNbxUo2mHiLPT1BxpwSwpX5+cO44p04KEoysfO6+gsopy1Qa7Ne7wVmKT2j3
 g7VzxMle7nHXY0erNG0ySWVVZcJ+nLs8TfKL0iMpWdyPN0PxmLG4FkibnPAB6laN+L4WqIVdg0R
 JKIoV6NZ+xBaMSs4+ZKKnSZpzlLUVY9ZobfEiyuz8ukpZ67ClLvSVI5BCzmKHyhU8j3Skoem1mx
 LTFoPzrZWWu+dpp8s+F0PJzr/xmNJwviryN2723DLAF6qzg+Xn8MpVJ+mQ+CnrEbZB7ncWE3w1Z
 MHetvQih8m350cJFLODRy3uk/7Rnw2iImwUIEL02UHHFeEuDpQ7UcLENtSHPR7LDSMg41Pdw6CB
 6dtD5lLg0gMVw+gxZ7g==
X-Proofpoint-GUID: fCP6L-WO5n4ieAT9MbnWySShlv_qSEDR
X-Proofpoint-ORIG-GUID: fCP6L-WO5n4ieAT9MbnWySShlv_qSEDR
X-Authority-Analysis: v=2.4 cv=NbPWEWD4 c=1 sm=1 tr=0 ts=6a09d4f2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=sWBrz1kr2qppWN3KPtEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_03,2026-05-15_01,2025-10-01_01
X-Rspamd-Queue-Id: 81196561BC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288744-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-04 at 13:01:59, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> From: Linu Cherian <lcherian@marvell.com>
> 
> CN20k introduces 32 diagnostic and performance
> counters that are shared across all NPA LFs.
> 
> Counters being shared, each PF driver need to request
> for a counter with the required configuration to the AF,
> so that a counter can be allocated and mapped to the
> respective LF with the requested configuration.
> 
> Add new mbox messages, npa_dpc_alloc/free to handle this.
> 
> Also ensure all the LF to DPC counter mappings are cleared
> at the time of LF free/teardown.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
>  .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 129 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  19 +++
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +
>  .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  14 +-
>  6 files changed, 177 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> index 4285b5d6a6a2..b13e7628f767 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
> @@ -29,4 +29,10 @@ int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
>  		     void *reg_base, int direction, int ndevs);
>  void cn20k_rvu_enable_afvf_intr(struct rvu *rvu, int vfs);
>  void cn20k_rvu_disable_afvf_intr(struct rvu *rvu, int vfs);
> +
> +int npa_cn20k_dpc_alloc(struct rvu *rvu, struct npa_cn20k_dpc_alloc_req *req,
> +			struct npa_cn20k_dpc_alloc_rsp *rsp);
> +int npa_cn20k_dpc_free(struct rvu *rvu, struct npa_cn20k_dpc_free_req *req);
> +void npa_cn20k_dpc_free_all(struct rvu *rvu, u16 pcifunc);
> +
>  #endif /* CN20K_API_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> index c963f43dc7b0..24a710f4f5fc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
> @@ -8,6 +8,8 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  
> +#include "cn20k/api.h"
> +#include "cn20k/reg.h"
>  #include "struct.h"
>  #include "../rvu.h"
>  
> @@ -46,3 +48,130 @@ int rvu_npa_halo_hwctx_disable(struct npa_aq_enq_req *req)
>  
>  	return 0;
>  }
> +
> +int npa_cn20k_dpc_alloc(struct rvu *rvu, struct npa_cn20k_dpc_alloc_req *req,
> +			struct npa_cn20k_dpc_alloc_rsp *rsp)
> +{
> +	struct rvu_hwinfo *hw = rvu->hw;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	int cntr, lf, blkaddr, ridx;
> +	struct rvu_block *block;
> +	struct rvu_pfvf *pfvf;
> +	u64 val, lfmask;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
> +	if (!pfvf->npalf || blkaddr < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	block = &hw->block[blkaddr];
> +	lf = rvu_get_lf(rvu, block, pcifunc, 0);
> +	if (lf < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	mutex_lock(&rvu->rsrc_lock);
> +
> +	/* allocate a new counter */
> +	cntr = rvu_alloc_rsrc(&rvu->npa_dpc);
Is there a mechanism to prevent a single VF from exhausting all 32 shared
counters? Without quotas, a misconfigured or malicious VF could repeatedly
request counters until the pool is empty, starving the PF and other VFs.

[Sundeep] No. There is no support of Quotas in AF driver. It is up
to PFs/VFs to allocate the resources as per their need.
 
> +	if (cntr < 0) {
> +		mutex_unlock(&rvu->rsrc_lock);
> +		return cntr;
> +	}
> +
> +	rsp->cntr_id = cntr;
> +
> +	/* DPC counter config */
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPCX_CFG(cntr), req->dpc_conf);
> +
> +	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
> +	ridx = lf >> 6;
> +	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
What happens here and in npa_cn20k_dpc_free() if lf is 128 or greater? If
lf >= 128, ridx becomes >= 2, and the shift amount (lf - 64) will be 64 or
more. This would result in undefined behavior when using BIT_ULL() since the
shift exceeds 63.

[Sundeep] Max LFs supported are 128 only so lf is 0 to 127.
> +
> +	ridx = 2 * cntr + ridx;
> +	/* Give permission for LF access */
> +	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
> +	val |= lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
Does the hardware guarantee that the other PERMITX register for this counter
is clear? Since this only sets bits in one of the PERMITX registers without
clearing the other, stale state from a prior kexec could remain. This might
grant unauthorized LFs access to the counter or cause issues when freeing.

[Sundeep] Only one NPA LF per PF/VF and one LF bit in PERMITX
registers and we do not assign same counter for two LFs.

> +
> +	mutex_unlock(&rvu->rsrc_lock);
> +
> +	return 0;
> +}
> +
> +int rvu_mbox_handler_npa_cn20k_dpc_alloc(struct rvu *rvu,
> +					 struct npa_cn20k_dpc_alloc_req *req,
> +					 struct npa_cn20k_dpc_alloc_rsp *rsp)
> +{
> +	return npa_cn20k_dpc_alloc(rvu, req, rsp);
> +}
Is it possible for VFs on older platforms to trigger this handler? Without an
is_cn20k() check, it appears VFs on older chips could send this message and
cause the driver to read or write CN20K-specific registers, potentially
accessing undefined MMIO space.

[Sundeep] No not possible.

Thanks,
Sundeep

> +
> +int npa_cn20k_dpc_free(struct rvu *rvu, struct npa_cn20k_dpc_free_req *req)
> +{
> +	struct rvu_hwinfo *hw = rvu->hw;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	int cntr, lf, blkaddr, ridx;
> +	struct rvu_block *block;
> +	struct rvu_pfvf *pfvf;
> +	u64 val, lfmask;
> +
> +	pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
> +	if (!pfvf->npalf || blkaddr < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	block = &hw->block[blkaddr];
> +	lf = rvu_get_lf(rvu, block, pcifunc, 0);
> +	if (lf < 0)
> +		return NPA_AF_ERR_AF_LF_INVALID;
> +
> +	if (req->cntr_id >= NPA_DPC_MAX)
> +		return NPA_AF_ERR_PARAM;
> +
> +	mutex_lock(&rvu->rsrc_lock);
> +
> +	/* 0 to 63 lfs -> idx 0, 64 - 127 lfs -> idx 1 */
> +	ridx = lf >> 6;
> +	lfmask = BIT_ULL(ridx ? lf - NPA_DPC_LFS_PER_REG : lf);
> +	cntr = req->cntr_id;
> +
> +	ridx = 2 * cntr + ridx;
> +
> +	val = rvu_read64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx));
> +	/* Check if the counter is allotted to this LF */
> +	if (!(val & lfmask)) {
> +		mutex_unlock(&rvu->rsrc_lock);
> +		return 0;
> +	}
> +
> +	/* Revert permission */
> +	val &= ~lfmask;
> +	rvu_write64(rvu, blkaddr, NPA_AF_DPC_PERMITX(ridx), val);
> +
> +	/* Free this counter */
> +	rvu_free_rsrc(&rvu->npa_dpc, req->cntr_id);
> +
> +	mutex_unlock(&rvu->rsrc_lock);
> +
> +	return 0;
> +}
> +
> +void npa_cn20k_dpc_free_all(struct rvu *rvu, u16 pcifunc)
> +{
> +	struct npa_cn20k_dpc_free_req req;
> +	int i;
> +
> +	req.hdr.pcifunc = pcifunc;
> +	for (i = 0; i < NPA_DPC_MAX; i++) {
> +		req.cntr_id = i;
> +		npa_cn20k_dpc_free(rvu, &req);
> +	}
> +}
> +
> +int rvu_mbox_handler_npa_cn20k_dpc_free(struct rvu *rvu,
> +					struct npa_cn20k_dpc_free_req *req,
> +					struct msg_rsp *rsp)
> +{
> +	return npa_cn20k_dpc_free(rvu, req);
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> index 8bfaa507ee50..9b49e376878e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
> @@ -143,4 +143,11 @@
>  	offset = (0xb000000ull | (a) << 4 | (b) << 20);		\
>  	offset; })
>  
> +/* NPA Registers */
> +#define NPA_AF_DPCX_CFG(a)		(0x800 | (a) << 6)
> +#define NPA_AF_DPC_PERMITX(a)		(0x1000 | (a) << 3)
> +
> +#define NPA_DPC_MAX			32
> +#define NPA_DPC_LFS_PER_REG		64
> +
>  #endif /* RVU_MBOX_REG_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 4a97bd93d882..b29ec26b66b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -213,6 +213,10 @@ M(NPA_AQ_ENQ,		0x402, npa_aq_enq, npa_aq_enq_req, npa_aq_enq_rsp)   \
>  M(NPA_HWCTX_DISABLE,	0x403, npa_hwctx_disable, hwctx_disable_req, msg_rsp)\
>  M(NPA_CN20K_AQ_ENQ,	0x404, npa_cn20k_aq_enq, npa_cn20k_aq_enq_req,	\
>  				npa_cn20k_aq_enq_rsp)			\
> +M(NPA_CN20K_DPC_ALLOC,	0x405, npa_cn20k_dpc_alloc, npa_cn20k_dpc_alloc_req, \
> +				npa_cn20k_dpc_alloc_rsp)		\
> +M(NPA_CN20K_DPC_FREE,	0x406, npa_cn20k_dpc_free, npa_cn20k_dpc_free_req, \
> +				msg_rsp)				\
>  /* SSO/SSOW mbox IDs (range 0x600 - 0x7FF) */				\
>  /* TIM mbox IDs (range 0x800 - 0x9FF) */				\
>  /* CPT mbox IDs (range 0xA00 - 0xBFF) */				\
> @@ -910,6 +914,21 @@ struct npa_cn20k_aq_enq_rsp {
>  	};
>  };
>  
> +struct npa_cn20k_dpc_alloc_req {
> +	struct mbox_msghdr hdr;
> +	u16 dpc_conf;
> +};
> +
> +struct npa_cn20k_dpc_alloc_rsp {
> +	struct mbox_msghdr hdr;
> +	u8 cntr_id;
> +};
> +
> +struct npa_cn20k_dpc_free_req {
> +	struct mbox_msghdr hdr;
> +	u8 cntr_id;
> +};
> +
>  /* Disable all contexts of type 'ctype' */
>  struct hwctx_disable_req {
>  	struct mbox_msghdr hdr;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 36a71d32b894..0299fa1bd3bc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -663,6 +663,9 @@ struct rvu {
>  	/* CPT interrupt lock */
>  	spinlock_t		cpt_intr_lock;
>  
> +	/* NPA */
> +	struct rsrc_bmap	npa_dpc;
> +
>  	struct mutex		mbox_lock; /* Serialize mbox up and down msgs */
>  	u16			rep_pcifunc;
>  	bool			altaf_ready;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> index 809386c6bcba..f7916ac79c69 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> @@ -8,6 +8,8 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  
> +#include "cn20k/api.h"
> +#include "cn20k/reg.h"
>  #include "rvu_struct.h"
>  #include "rvu_reg.h"
>  #include "rvu.h"
> @@ -504,6 +506,8 @@ int rvu_mbox_handler_npa_lf_free(struct rvu *rvu, struct msg_req *req,
>  		return NPA_AF_ERR_LF_RESET;
>  	}
>  
> +	if (is_cn20k(rvu->pdev))
> +		npa_cn20k_dpc_free_all(rvu, pcifunc);
>  	npa_ctx_free(rvu, pfvf);
>  
>  	return 0;
> @@ -569,12 +573,17 @@ static int npa_aq_init(struct rvu *rvu, struct rvu_block *block)
>  int rvu_npa_init(struct rvu *rvu)
>  {
>  	struct rvu_hwinfo *hw = rvu->hw;
> -	int blkaddr;
> +	int err, blkaddr;
>  
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, 0);
>  	if (blkaddr < 0)
>  		return 0;
>  
> +	rvu->npa_dpc.max = NPA_DPC_MAX;
> +	err = rvu_alloc_bitmap(&rvu->npa_dpc);
> +	if (err)
> +		return err;
> +
>  	/* Initialize admin queue */
>  	return npa_aq_init(rvu, &hw->block[blkaddr]);
>  }
> @@ -591,6 +600,7 @@ void rvu_npa_freemem(struct rvu *rvu)
>  
>  	block = &hw->block[blkaddr];
>  	rvu_aq_free(rvu, block->aq);
> +	kfree(rvu->npa_dpc.bmap);
>  }
>  
>  void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
> @@ -611,6 +621,8 @@ void rvu_npa_lf_teardown(struct rvu *rvu, u16 pcifunc, int npalf)
>  	ctx_req.ctype = NPA_AQ_CTYPE_HALO;
>  	npa_lf_hwctx_disable(rvu, &ctx_req);
>  
> +	if (is_cn20k(rvu->pdev))
> +		npa_cn20k_dpc_free_all(rvu, pcifunc);
>  	npa_ctx_free(rvu, pfvf);
>  }
>  
> -- 
> 2.48.1
> 

