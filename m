Return-Path: <netdev+bounces-108408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6D923B61
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E641F221F2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92977158855;
	Tue,  2 Jul 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cssSimQO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58B1586FB;
	Tue,  2 Jul 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916128; cv=none; b=fF5ktNxEbQF1Zu55/9fRrBO/5SxnZzPiN0nonUZ+XFzfAiskOexiPUcleHUoAACXGSYf0J5jZQ8oThgrERqt6AHwurtUSYILWAsifsrgN2Rn6G+NeYs5ko+FoV05RfUTBW1J2L8EOGnkaYRnF7b5G+V4qKzwFcU80429epefShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916128; c=relaxed/simple;
	bh=5Da4XpjNVfQ7N6+Y3f4xsDAcVO2Gntj9bbnFtQpmSNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQeYZDFJlHPFU3aNGlwL5BDRB2uE9Jn3jE5xkb0ZFE57EAMcrKaNGr1y51/l/8Fe5iVT/mhH06dMqU19t/i83rXUfPwsPy0Mv5lbPRWMvM0jz2XUsynd/FH/0WK9UDcSUmQ5YQBsMBqQHNcBvlvQds7iXDvp1LiT1r9Jv+YgAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cssSimQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C68C116B1;
	Tue,  2 Jul 2024 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719916127;
	bh=5Da4XpjNVfQ7N6+Y3f4xsDAcVO2Gntj9bbnFtQpmSNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cssSimQODutroiBttk5MhlwJcf2Wc3SrO7fTIiGX9f2mJli4BdtnuBhod5XRnnb6o
	 TlHxwaYGSSJTcHBSPj1PDk4pUsBRwk0h1N9pX3Fw+aehJznmIx3QdmXTCMU3OJoo7J
	 pPpa+xlC+nTVUHznLtajH/CyEzJMV+jIdJ+ugtIlcbqkDpy1PlW70ThftCYY0LYDpg
	 S6nWwa8BInzlkJHDoEXekVeVKsuKoxkB2cGeJZTl8fqwmKjXDyC4FxcMr0fMdivKmS
	 EBrS6Ya5ndJVdcWhtP6kxKwVLn8sPxhQU1Wn9z2Qyh2QxyOWyN9vYCihFl/atR6i1e
	 VkG29g+AHn8hw==
Date: Tue, 2 Jul 2024 11:28:43 +0100
From: Simon Horman <horms@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [PATCH net,2/6] octeontx2-af: reduce cpt flt interrupt vectors
 for cn10kb
Message-ID: <20240702102843.GE598357@kernel.org>
References: <20240701090746.2171565-1-schalla@marvell.com>
 <20240701090746.2171565-3-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701090746.2171565-3-schalla@marvell.com>

On Mon, Jul 01, 2024 at 02:37:42PM +0530, Srujana Challa wrote:
> On new silicon(cn10kb), the number of FLT interrupt vectors has
> been reduced. Hence, this patch modifies the code to make
> it work for both cn10ka and cn10kb.
> 

I am tempted to think this is more about enabling new hardware
than fixing a bug. But I do also see how one might argue otherwise.

In any case, if this is a fix then a fixes tag should go here.
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
>  .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 73 ++++++++++++++++---
>  .../marvell/octeontx2/af/rvu_struct.h         |  5 +-
>  3 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 4a77f6fe2622..41b46724cb3d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1848,8 +1848,9 @@ struct cpt_flt_eng_info_req {
>  
>  struct cpt_flt_eng_info_rsp {
>  	struct mbox_msghdr hdr;
> -	u64 flt_eng_map[CPT_10K_AF_INT_VEC_RVU];
> -	u64 rcvrd_eng_map[CPT_10K_AF_INT_VEC_RVU];
> +#define CPT_AF_MAX_FLT_INT_VECS 3
> +	u64 flt_eng_map[CPT_AF_MAX_FLT_INT_VECS];
> +	u64 rcvrd_eng_map[CPT_AF_MAX_FLT_INT_VECS];
>  	u64 rsvd;
>  };
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> index 98440a0241a2..38363ea56c6c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> @@ -37,6 +37,38 @@
>  	(_rsp)->free_sts_##etype = free_sts;                        \
>  })
>  
> +#define MAX_AE  GENMASK_ULL(47, 32)
> +#define MAX_IE  GENMASK_ULL(31, 16)
> +#define MAX_SE  GENMASK_ULL(15, 0)
> +static u32 cpt_max_engines_get(struct rvu *rvu)
> +{
> +	u16 max_ses, max_ies, max_aes;
> +	u64 reg;
> +
> +	reg = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_CONSTANTS1);
> +	max_ses = FIELD_GET(MAX_SE, reg);
> +	max_ies = FIELD_GET(MAX_IE, reg);
> +	max_aes = FIELD_GET(MAX_AE, reg);
> +
> +	return max_ses + max_ies + max_aes;
> +}
> +
> +/* Number of flt interrupt vectors are depends on number of engines that
> + * the chip has. Each flt vector represents 64 engines.
> + */
> +static int cpt_10k_flt_nvecs_get(struct rvu *rvu)
> +{
> +	u32 max_engs;
> +	int flt_vecs;
> +
> +	max_engs = cpt_max_engines_get(rvu);
> +
> +	flt_vecs = (max_engs / 64);
> +	flt_vecs += (max_engs % 64) ? 1 : 0;
> +
> +	return flt_vecs;
> +}
> +

I think the callers of this function assume it will never return a value
greater than 3. Perhaps it would be worth enforcing that, or WARNing if it
not so.  I'm thinking of a case a fw/hw revision comes along and this
assumption no longer holds.

>  static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
>  {
>  	struct rvu_block *block = ptr;

...

