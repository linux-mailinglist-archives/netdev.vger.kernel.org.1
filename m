Return-Path: <netdev+bounces-104392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F790C612
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D941C217F8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7A13AD0A;
	Tue, 18 Jun 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgUAMR3M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8347A5D;
	Tue, 18 Jun 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696463; cv=none; b=XfQ3bMJfrx8LMh2OeAFKcWKcYT8Z2q6//1rhQv24cEFI00FB/cOS9m9SWiaoAEd6n7rr3r0moodNtgdIbe8bI4v6t08tZ76d6plXz2XhSpUbt3z3tpBr0bWvkkMSSvuBegdXBmENx2UBPJpxbPXdMsN19F/Mow2g+s2OSy4EelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696463; c=relaxed/simple;
	bh=kWoPBUQm3BlOjgFdJfsDu5HMF2BzOEKyQniwyMyajYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU+1BQZvxkV+FUBIq8MFeW+OD+T66ZgesG//R/Vnnl4CgD3jAZD9Sz/PeT76GIdHbRhLD+xnrE+g1csoVrU88a3T+c7Uwg/JMcDcuN4dShdco0djU7VU2VOpY6IT5hgLjOi3B8G2HF6HOKzFGRgjIW8eCdFrhiYtqeRha/FZFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgUAMR3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DE6C3277B;
	Tue, 18 Jun 2024 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718696462;
	bh=kWoPBUQm3BlOjgFdJfsDu5HMF2BzOEKyQniwyMyajYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgUAMR3MXK+t17MY08oKmJBeH72dkdheWyF+wvBu7C30JySBHO7RbmBe6aw3OWBv1
	 lLNgMyu6EeC82CFkS4KhrozEw/ThSchYZ2hYnqG1Q/9euJLAFCPnRKQALcWOSTZ18A
	 CiOZKWqb9hxOd3mCKkzT4dxn2K9SsECdrFuEr9jb7YqSlt+B+cqpRzKMTA3LWfSSp/
	 m5dX5AhgobO0M00PKPTyYyOM7iHtdMrfqaPweyj8ZqfsvCbt82HcxVAED9FZIUwuRk
	 /pmgJgkYQGlEbDdJpHV4/rOqfrMIvqREeAbNlzzS7SoX3Tgczc1SJqzQvwK0t3Wz9/
	 EPTGNNmQIFGZA==
Date: Tue, 18 Jun 2024 08:40:58 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v5 01/10] octeontx2-pf: Refactoring RVU driver
Message-ID: <20240618074058.GC8447@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-2-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:04PM +0530, Geetha sowjanya wrote:
> Refactoring and export list of shared functions such that
> they can be used by both RVU NIC and representor driver.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

...

> @@ -2949,6 +2952,7 @@ static int nix_tx_vtag_alloc(struct rvu *rvu, int blkaddr,
>  	mutex_unlock(&vlan->rsrc_lock);
>  
>  	regval = size ? vtag : vtag << 32;
> +	regval |= (vtag & ~GENMASK_ULL(47, 0)) << 48;

Hi Geetha,

I'm a little confused by the line above.

vtag is a 64 bit value.
It is masked, leaving the upper 16 bits intact,
and the lower 48 bits as zeros.
It is then left-shifted 48 bits.
By my reasoning the result is always 0.

e.g.
  0x123456789abcdef1 & ~GENMASK_ULL(47, 0) => 0x1234000000000000
  0x1234000000000000 << 48 => 0

Also, I suspect that FIELD_PREP could be used to good effect here.
(And, as an aside, elsewhere in this file/driver.)

>  	rvu_write64(rvu, blkaddr,
>  		    NIX_AF_TX_VTAG_DEFX_DATA(index), regval);
> @@ -4619,6 +4623,7 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
>  	rvu_get_lbk_link_max_frs(rvu, &lbk_max_frs);
>  	rvu_get_lmac_link_max_frs(rvu, &lmac_max_frs);
>  
> +	rvu_write64(rvu, blkaddr, NIX_AF_SDP_LINK_CREDIT, SDP_LINK_CREDIT);
>  	/* Set default min/max packet lengths allowed on NIX Rx links.
>  	 *
>  	 * With HW reset minlen value of 60byte, HW will treat ARP pkts
> @@ -4630,14 +4635,14 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
>  				((u64)lmac_max_frs << 16) | NIC_HW_MIN_FRS);
>  	}
>  
> -	for (link = hw->cgx_links; link < hw->lbk_links; link++) {
> +	for (link = hw->cgx_links; link < hw->cgx_links + hw->lbk_links; link++) {
>  		rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link),
>  			    ((u64)lbk_max_frs << 16) | NIC_HW_MIN_FRS);
>  	}
>  	if (hw->sdp_links) {
>  		link = hw->cgx_links + hw->lbk_links;
>  		rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link),
> -			    SDP_HW_MAX_FRS << 16 | NIC_HW_MIN_FRS);
> +			    SDP_HW_MAX_FRS << 16 | SDP_HW_MIN_FRS);
>  	}
>  
>  	/* Get MCS external bypass status for CN10K-B */

...

