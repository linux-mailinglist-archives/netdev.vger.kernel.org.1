Return-Path: <netdev+bounces-274896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG7VLF1az2kXvgYAu9opvQ
	(envelope-from <netdev+bounces-274896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9F391528
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F39B630138DA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DA37107B;
	Fri,  3 Apr 2026 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="exoi5c1r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8F314A83;
	Fri,  3 Apr 2026 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196666; cv=none; b=DqhUSoc4bF9guqGGVkbDPs/mbeseAmEJN+dsIt1j/4kJ733/ddesrHqDzeU+tHoNCTqe6nM3Z/pVdZmU+302NgMMiB9fi1YHIv4sKelk0STmAoEe47Q9emyiD/Vh6MYhVGsTPAHMU3qiVjHD+ZMxPODPYT77k9rCMeNSkfHcnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196666; c=relaxed/simple;
	bh=4cpalp1OciTA0qvxJ6K1sxD4n7uOrRXRwr5D8CWt9kA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPD2+5F0dSIvH3Hr9QnxU7ZqVwXEaXhrhfL0rowWQ+JsCHZyC1e2otTwxyP1/lRKgkDqwysu/4nXY7opaduSWaFwYLrn44w1ijP5vJIodZ/i8xpUZ2rc6MaS+Texy7jGOzmkssVrtvkyIUW2xJhIf8gdewIsJUWZPyvPbO5/SVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=exoi5c1r; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63330wBK1821189;
	Thu, 2 Apr 2026 23:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=cEdE+x4eUz0C9916LgvXuemii
	L6daokysjjkOnbUU8A=; b=exoi5c1rY7zSYmlbFmPVwAeVRniY51TTWPMwIqb+w
	DykdJ5kvf0g5PKWcH4C2YV5N0yxWCqMwAPxQ6kRjxNllFYz3m9Df+gYIUF6GrqG7
	ti+trNMRC2K1MPPdRDgdMvpzhSyvy/fteZJkx8ShnVka+S7681KE57/NFmAnqWd5
	CkOid5rmcPlUz2w2xIQYkPpipjj2CnjC5r5sNJ+BcAZnTKgVN0iYTIRPj1KGbdA+
	3KxUGIMk6kmHZE/FSMtAfVmiNpNEHiVipmIffKQ5N0NnkUJeKt3qXTmaKzkbJ7s5
	inIX1Vli4MfsWajsVELHaNLwPRCiYX+nYMzbJGztk3FoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d9d9guwpr-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 23:10:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 2 Apr 2026 23:10:44 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 2 Apr 2026 23:01:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 2 Apr 2026 23:01:32 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 3EF763F7073;
	Thu,  2 Apr 2026 23:01:28 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:31:28 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
        <gakula@marvell.com>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <bbhushan2@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,4/4] octeontx2-pf: cn20k: Use unified Halo context
Message-ID: <20260403060128.GA1485819@kernel-ep2>
References: <1774940919-1599-5-git-send-email-sbhatta@marvell.com>
 <20260402112011.216286-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260402112011.216286-1-pabeni@redhat.com>
X-Proofpoint-ORIG-GUID: eFXdii1nHRkkbeJT2N__EYyjAJGiIldc
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=69cf59e8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=20KFwNOVAAAA:8 a=iDgarg-P1KTe9FNtOO0A:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA1MyBTYWx0ZWRfX3//O0z85r5o2
 6iDxOFsunFON3kVSkzhpBgBTg6u6V7CAYllvip4wJ8W4OSiNBo0EUQq503DRSmGVtDJY0OS6T0V
 TJ4zr0YNJFWQxYL7M23T1A/JyHvED0RrpLUzDtL7WEIiu6pRhTNYEgUnBRcAd/lr3z1WP5gOAKA
 PX5bnKYRLWZF0iQuIfUO4NLvt7AQQVsopSvxTBJf0vrE0C9QTC6xRlwF4+g2IoDBBb9IUW/e5bX
 PZwK+WJ9mL9i6IG7+ZifAtFTQ1B7ivk8v3iEJyQARH+4tuuieTG0eyRAVgCINDUN55uZ47V35PZ
 TgtoHZ5RHnbtAO8iKLKARby7WxuRWriG9xzB08rIDixBoF42FG4s34F014aayblFx7UDdlsiXAx
 TBbmRdm81R53Nf4DmOq+6qMVpvkzmVz6pX7WRKrrgu5LnoyLeR2GleTGS7PD/pTjdpoomLFG8m3
 cWuZlQc4c5FeIEMKfpw==
X-Proofpoint-GUID: eFXdii1nHRkkbeJT2N__EYyjAJGiIldc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_02,2026-04-02_05,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274896-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BCA9F391528
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

On 2026-04-02 at 16:50:11, Paolo Abeni (pabeni@redhat.com) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-pf: cn20k: Use unified Halo context
> 
> This commit replaces the separate aura and pool contexts with the unified
> Halo context available in CN20K hardware for managing network device pools
> and buffer allocation.
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> 
> [ ... ]
> 
> > @@ -516,85 +507,8 @@ int cn20k_tc_alloc_entry(struct otx2_nic *nic,
> >
> >  	return 0;
> >  }
> > -
> > -static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
> > -			      int pool_id, int numptrs)
> > -{
> > -	struct npa_cn20k_aq_enq_req *aq;
> > -	struct otx2_pool *pool;
> > -	u8 bpid_idx;
> > -	int err;
> > -
> > -	pool = &pfvf->qset.pool[pool_id];
> > -
> > -	/* Allocate memory for HW to update Aura count.
> > -	 * Alloc one cache line, so that it fits all FC_STYPE modes.
> > -	 */
> > -	if (!pool->fc_addr) {
> > -		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
> > -		if (err)
> > -			return err;
> > -	}
> > -
> > -	/* Initialize this aura's context via AF */
> > -	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> > -	if (!aq) {
> > -		/* Shared mbox memory buffer is full, flush it and retry */
> > -		err = otx2_sync_mbox_msg(&pfvf->mbox);
> > -		if (err)
> > -			return err;
> > -		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> > -		if (!aq)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	aq->aura_id = aura_id;
> > -
> > -	/* Will be filled by AF with correct pool context address */
> > -	aq->aura.pool_addr = pool_id;
> > -	aq->aura.pool_caching = 1;
> > -	aq->aura.shift = ilog2(numptrs) - 8;
> > -	aq->aura.count = numptrs;
> > -	aq->aura.limit = numptrs;
> > -	aq->aura.avg_level = 255;
> > -	aq->aura.ena = 1;
> > -	aq->aura.fc_ena = 1;
> > -	aq->aura.fc_addr = pool->fc_addr->iova;
> > -	aq->aura.fc_hyst_bits = 0; /* Store count on all updates */
> >
> > -	/* Enable backpressure for RQ aura */
> > -	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
> > -		aq->aura.bp_ena = 0;
> > -		/* If NIX1 LF is attached then specify NIX1_RX.
> > -		 *
> > -		 * Below NPA_AURA_S[BP_ENA] is set according to the
> > -		 * NPA_BPINTF_E enumeration given as:
> > -		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
> > -		 * NIX0_RX is 0x0 + 0*0x1 = 0
> > -		 * NIX1_RX is 0x0 + 1*0x1 = 1
> > -		 * But in HRM it is given that
> > -		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
> > -		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
> > -		 * enumerated by NPA_BPINTF_E."
> > -		 */
> > -		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
> > -			aq->aura.bp_ena = 1;
> > -
> > -		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
> > -		aq->aura.bpid = pfvf->bpid[bpid_idx];
> > -
> > -		/* Set backpressure level for RQ's Aura */
> > -		aq->aura.bp = RQ_BP_LVL_AURA;
> > -	}
> > -
> > -	/* Fill AQ info */
> > -	aq->ctype = NPA_AQ_CTYPE_AURA;
> > -	aq->op = NPA_AQ_INSTOP_INIT;
> > -
> > -	return 0;
> > -}
> > -
> > -static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
> > +static int cn20k_halo_aq_init(struct otx2_nic *pfvf, u16 pool_id,
> >  			      int stack_pages, int numptrs, int buf_size,
> >  			      int type)
> >  {
> > @@ -610,36 +524,57 @@ struct page_pool_params pp_params = { 0 };
> >  	if (err)
> >  		return err;
> >
> > +	/* Allocate memory for HW to update Aura count.
> > +	 * Alloc one cache line, so that it fits all FC_STYPE modes.
> > +	 */
> > +	if (!pool->fc_addr) {
> > +		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
> > +		if (err) {
> > +			qmem_free(pfvf->dev, pool->stack);
> > +			return err;
> > +		}
> > +	}
> > +
> >  	pool->rbsize = buf_size;
> >
> > -	/* Initialize this pool's context via AF */
> > +	/* Initialize this aura's context via AF */
> >  	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> >  	if (!aq) {
> >  		/* Shared mbox memory buffer is full, flush it and retry */
> >  		err = otx2_sync_mbox_msg(&pfvf->mbox);
> > -		if (err) {
> > -			qmem_free(pfvf->dev, pool->stack);
> > -			return err;
> > -		}
> > +		if (err)
> > +			goto free_mem;
> >  		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> >  		if (!aq) {
> > -			qmem_free(pfvf->dev, pool->stack);
> > -			return -ENOMEM;
> > +			err = -ENOMEM;
> > +			goto free_mem;
> >  		}
> >  	}
> >
> >  	aq->aura_id = pool_id;
> > -	aq->pool.stack_base = pool->stack->iova;
> > -	aq->pool.stack_caching = 1;
> > -	aq->pool.ena = 1;
> > -	aq->pool.buf_size = buf_size / 128;
> > -	aq->pool.stack_max_pages = stack_pages;
> > -	aq->pool.shift = ilog2(numptrs) - 8;
> > -	aq->pool.ptr_start = 0;
> > -	aq->pool.ptr_end = ~0ULL;
> >
> > +	aq->halo.stack_base = pool->stack->iova;
> > +	aq->halo.stack_caching = 1;
> > +	aq->halo.ena = 1;
> > +	aq->halo.buf_size = buf_size / 128;
> > +	aq->halo.stack_max_pages = stack_pages;
> > +	aq->halo.shift = ilog2(numptrs) - 8;
> > +	aq->halo.ptr_start = 0;
> > +	aq->halo.ptr_end = ~0ULL;
> > +
> > +	aq->halo.avg_level = 255;
> > +	aq->halo.fc_ena = 1;
> > +	aq->halo.fc_addr = pool->fc_addr->iova;
> > +	aq->halo.fc_hyst_bits = 0; /* Store count on all updates */
> > +
> > +	if (pfvf->npa_dpc_valid) {
> > +		aq->halo.op_dpc_ena = 1;
> > +		aq->halo.op_dpc_set = pfvf->npa_dpc;
> > +	}
> > +	aq->halo.unified_ctx = 1;
>                     ^^^^
> 
> Does this code properly configure backpressure for receive queues? The old
> cn20k_aura_aq_init configured NPA-level backpressure by setting bp_ena,
> bpid, and bp fields in the aura context. This caused the hardware to signal
> backpressure to NIX-RX when receive buffers filled to 85% (RQ_BP_LVL_AURA):

For now we want backpressure to be disabled since we do not have setup
to test it at the moment. I will write a comment saying disable backpressure
in Halo context and revisit later?
> 
>     /* Enable backpressure for RQ aura */
>     if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
>         aq->aura.bp_ena = 0;
>         if (pfvf->nix_blkaddr == BLKADDR_NIX1)
>             aq->aura.bp_ena = 1;
> 
>         bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
>         aq->aura.bpid = pfvf->bpid[bpid_idx];
> 
>         /* Set backpressure level for RQ's Aura */
>         aq->aura.bp = RQ_BP_LVL_AURA;
>     }
> 
> The new cn20k_halo_aq_init does not set the equivalent Halo context fields
> (bp_ena_0, bpid_0, bp_0). Looking at struct npa_cn20k_halo_s in the AF
> headers, these fields exist in the Halo context.
> 
> The AF side rvu_npa_aq_enq_inst() does not auto-configure backpressure
> during INIT operations. The AF teardown code rvu_npa_halo_hwctx_disable()
> explicitly clears bp_ena_0 through bp_ena_7, confirming these fields are
> expected to be set during initialization.
> 
> Without NPA-level backpressure configuration, wouldn't CN20K devices fail
> to trigger backpressure when aura buffers fill up, leading to packet drops
> under heavy traffic load?
> 
> >
> >  	/* Fill AQ info */
> > -	aq->ctype = NPA_AQ_CTYPE_POOL;
> > +	aq->ctype = NPA_AQ_CTYPE_HALO;
> >  	aq->op = NPA_AQ_INSTOP_INIT;
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -1651,6 +1651,9 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
> >  	if (!is_otx2_lbkvf(pf->pdev))
> >  		otx2_nix_config_bp(pf, true);
> >
> > +	if (is_cn20k(pf->pdev))
> > +		cn20k_npa_alloc_dpc(pf);
> > +
> >  	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
> >  	err = otx2_rq_aura_pool_init(pf);
> >  	if (err) {
> > @@ -1726,6 +1729,8 @@
> >  	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_AURA, true);
> >  	otx2_aura_pool_free(pf);
> >  err_free_nix_lf:
> > +	if (pf->npa_dpc_valid)
> > +		cn20k_npa_free_dpc(pf);
> 
> Is there a potential double-free of the NPA DPC counter via the
> rvu_rep_rsrc_init error path?
> 
> cn20k_npa_free_dpc() does not clear nic->npa_dpc_valid after successfully
> freeing the DPC counter. If otx2_init_hw_resources() fails after
> cn20k_npa_alloc_dpc() succeeds (e.g., otx2_rq_aura_pool_init() returns an
> error), the error cleanup at err_free_nix_lf calls cn20k_npa_free_dpc(pf)
> which frees the counter but leaves npa_dpc_valid=true.
> 
> The caller rvu_rep_rsrc_init() then calls otx2_free_hw_resources(priv) at
> its err_free_rsrc label:
> 
> rvu_rep_rsrc_init()
>     otx2_init_hw_resources(priv)
>         cn20k_npa_alloc_dpc(pf) [succeeds]
>         otx2_rq_aura_pool_init(pf) [fails]
>         goto err_free_nix_lf
>         cn20k_npa_free_dpc(pf) [frees counter, npa_dpc_valid still true]
>     goto err_free_rsrc
>     otx2_free_hw_resources(priv)
>         cn20k_npa_free_dpc(pf) [frees same counter again]
> 
> Looking at cn20k_npa_free_dpc() in cn20k.c:
> 
> int cn20k_npa_free_dpc(struct otx2_nic *nic)
> {
>     struct npa_cn20k_dpc_free_req *req;
>     int err;
> 
>     if (!nic->npa_dpc_valid)
>         return 0;
> 
>     mutex_lock(&nic->mbox.lock);
> 
>     req = otx2_mbox_alloc_msg_npa_cn20k_dpc_free(&nic->mbox);
>     if (!req) {
>         mutex_unlock(&nic->mbox.lock);
>         return -ENOMEM;
>     }
> 
>     req->cntr_id = nic->npa_dpc;
> 
>     err = otx2_sync_mbox_msg(&nic->mbox);
> 
>     mutex_unlock(&nic->mbox.lock);
> 
>     return err;
> }
> 
> Since npa_dpc_valid is still true, the second call passes the guard check
> and sends another mbox message to free the same counter ID. Shouldn't
> cn20k_npa_free_dpc() clear nic->npa_dpc_valid after the successful
> otx2_sync_mbox_msg() call to prevent this double-free?
>
Nice catch. Will fix this.

Thanks,
Sundeep
 
> >  	mutex_lock(&mbox->lock);
> >  	free_req = otx2_mbox_alloc_msg_nix_lf_free(mbox);
> >  	if (free_req) {
> 
> [ ... ]
> 

