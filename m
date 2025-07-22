Return-Path: <netdev+bounces-209064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD9B0E258
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757681AA7CB2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E627C17E;
	Tue, 22 Jul 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py79Qm8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58DBA36
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203829; cv=none; b=Uv6w7Q/UNkUMw8aNMyo0mtaULLvF4/uZ3sh6xztjpltY4WLstPAb6SVHGyJr91PCohh9kbkwZf3FVYuOF2GVg0ACI7KrVldbEMzq48n/nt9jPJPwjjjo7Ipc2En0upZm/JlLSKS9feazx9IDtR0P5BtJP48U/reM5+bR32ncssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203829; c=relaxed/simple;
	bh=C4ygKWRUmwX4LLvc4OXae9hOgNNQ1OiBqucIuvTscpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrj3go4hshI9tBPsU/uRdzHB3Z15HjELcMIcvyfbbykKeer0cwaTA3eY52mE0fY+VNg4KY4Brs478EaA0Pt/21xFYKvc/fnr1ZYK6CKHYyqWxyi2v7CwJ4PrX0H0yon+/xhsdzLZfWRxWkxYA/XReD9a5JT0UxaDyxtACCkbzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py79Qm8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530C3C4CEEB;
	Tue, 22 Jul 2025 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753203828;
	bh=C4ygKWRUmwX4LLvc4OXae9hOgNNQ1OiBqucIuvTscpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Py79Qm8zD1pBwiLPMBvhZiGIgB5bRgEyUsI8BFy6N7KcPrxfgfIy4NwbhEOn8wS0s
	 yoquk38AGSWaAcOu+wIyFtLD7y91VO46xXGWSpqJsbS6ai87HwPQYQXPwHP7Br2E9R
	 Ee+AB8es5gVy+9fSKWdMySa64d9piiD7hLC8YW2X0PICP+YS0b84KcMg4hfcmugOGO
	 ScyHEj6dMYfCCJ8HUrPphrduPPPtoIQKcXmJSfUHGJK1RgTx18LGGoSFaK4Vqht4yx
	 Q7RAjQt/9FTd9/Ydj4PKm5/UTL8/2nAD4egs2XLXDY/DdpcyBs1nBuexz5+JqSP2Jp
	 YW0xklBE/Zshw==
Date: Tue, 22 Jul 2025 18:03:44 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 07/11] octeontx2-pf: Initialize cn20k
 specific aura and pool contexts
Message-ID: <20250722170344.GS2459@horms.kernel.org>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-8-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752772063-6160-8-git-send-email-sbhatta@marvell.com>

On Thu, Jul 17, 2025 at 10:37:39PM +0530, Subbaraya Sundeep wrote:
> From: Linu Cherian <lcherian@marvell.com>
> 
> With new CN20K NPA pool and aura contexts supported in AF
> driver this patch modifies PF driver to use new NPA contexts.
> Implement new hw_ops for intializing aura and pool contexts
> for all the silicons.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

...

> @@ -250,3 +239,170 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
>  
>  	return 0;
>  }
> +
> +#define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
> +
> +static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
> +			      int pool_id, int numptrs)
> +{
> +	struct npa_cn20k_aq_enq_req *aq;
> +	struct otx2_pool *pool;
> +	int err;
> +
> +	pool = &pfvf->qset.pool[pool_id];
> +
> +	/* Allocate memory for HW to update Aura count.
> +	 * Alloc one cache line, so that it fits all FC_STYPE modes.
> +	 */
> +	if (!pool->fc_addr) {
> +		err = qmem_alloc(pfvf->dev, &pool->fc_addr, 1, OTX2_ALIGN);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Initialize this aura's context via AF */
> +	aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> +	if (!aq) {
> +		/* Shared mbox memory buffer is full, flush it and retry */
> +		err = otx2_sync_mbox_msg(&pfvf->mbox);
> +		if (err)
> +			return err;
> +		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
> +		if (!aq)
> +			return -ENOMEM;
> +	}
> +
> +	aq->aura_id = aura_id;
> +
> +	/* Will be filled by AF with correct pool context address */
> +	aq->aura.pool_addr = pool_id;
> +	aq->aura.pool_caching = 1;
> +	aq->aura.shift = ilog2(numptrs) - 8;
> +	aq->aura.count = numptrs;
> +	aq->aura.limit = numptrs;
> +	aq->aura.avg_level = 255;
> +	aq->aura.ena = 1;
> +	aq->aura.fc_ena = 1;
> +	aq->aura.fc_addr = pool->fc_addr->iova;
> +	aq->aura.fc_hyst_bits = 0; /* Store count on all updates */
> +
> +	/* Enable backpressure for RQ aura */
> +	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
> +		aq->aura.bp_ena = 0;
> +		/* If NIX1 LF is attached then specify NIX1_RX.
> +		 *
> +		 * Below NPA_AURA_S[BP_ENA] is set according to the
> +		 * NPA_BPINTF_E enumeration given as:
> +		 * 0x0 + a*0x1 where 'a' is 0 for NIX0_RX and 1 for NIX1_RX so
> +		 * NIX0_RX is 0x0 + 0*0x1 = 0
> +		 * NIX1_RX is 0x0 + 1*0x1 = 1
> +		 * But in HRM it is given that
> +		 * "NPA_AURA_S[BP_ENA](w1[33:32]) - Enable aura backpressure to
> +		 * NIX-RX based on [BP] level. One bit per NIX-RX; index
> +		 * enumerated by NPA_BPINTF_E."
> +		 */
> +		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
> +			aq->aura.bp_ena = 1;
> +#ifdef CONFIG_DCB
> +		aq->aura.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
> +#else
> +		aq->aura.bpid = pfvf->bpid[0];
> +#endif

From a build coverage point of view it is a shame that we can't use
something like this here (because queue_to_pfc_map doesn't exist
if CONFIG_DCB isn't enabled).

		bpid_idx = IS_ENABLED(CONFIG_DCB) ? ...;

But I do wonder if somehow it's nicer to constrain the #ifdef to an
as-small-as-possible helper. Something like this (compile tested only):

@@ -242,6 +242,15 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 
 #define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
 
+static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
+{
+#ifdef CONFIG_DCB
+	return pfvf->queue_to_pfc_map[aura_id];
+#else
+	return 0;
+#endif
+}
+
 static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 			      int pool_id, int numptrs)
 {
@@ -289,6 +298,7 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 	/* Enable backpressure for RQ aura */
 	if (aura_id < pfvf->hw.rqpool_cnt && !is_otx2_lbkvf(pfvf->pdev)) {
 		aq->aura.bp_ena = 0;
+		u8 bpid_idx;
 		/* If NIX1 LF is attached then specify NIX1_RX.
 		 *
 		 * Below NPA_AURA_S[BP_ENA] is set according to the
@@ -303,11 +313,9 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 		 */
 		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
 			aq->aura.bp_ena = 1;
-#ifdef CONFIG_DCB
-		aq->aura.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
-#else
-		aq->aura.bpid = pfvf->bpid[0];
-#endif
+
+		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
+		aq->aura.bpid = pfvf->bpid[bpid_idx];
 
 		/* Set backpressure level for RQ's Aura */
 		aq->aura.bp = RQ_BP_LVL_AURA;

> +
> +		/* Set backpressure level for RQ's Aura */
> +		aq->aura.bp = RQ_BP_LVL_AURA;
> +	}
> +
> +	/* Fill AQ info */
> +	aq->ctype = NPA_AQ_CTYPE_AURA;
> +	aq->op = NPA_AQ_INSTOP_INIT;
> +
> +	return 0;
> +}

...

