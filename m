Return-Path: <netdev+bounces-207854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5BB08CEA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A447B1853
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080C145348;
	Thu, 17 Jul 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z54c6Kuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE91DA21;
	Thu, 17 Jul 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755484; cv=none; b=erPxMAB+RUImqRLGbCL5/fbIzMqgZ32zsLoMuwhsayJ47rpxRTc/oQa9Ti5xtEGqNndgD4N9bvrP3uwTxk0jZ1QAmLsNW7vhJm/H/s+ZUNUYcWZ5jHL17j7Q6qgRclPFxuGgYt+rrvtOXgQxq+4zth17b/NmvJnovafSPy6nGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755484; c=relaxed/simple;
	bh=IM4QtbLTW+vhhANiYAEWUa7DJNSOUUbW6+deuw3Sevw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBKyZlLrqsBWMvRXp3/SkunohfKd4g3Ly6Hs/w/k20A+qqI5ZGnT0XAcDMyqPVKuXGqfBgj5BexE/a1I5+M8Cd9xRSaMQaQkP6GlyuAoN56TOsCa7npNTiBeh9dAvxdmIE9VT6vtJSBMLu9gks5AME5pej1vE/TRKLyiotBWWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z54c6Kuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D583DC4CEEB;
	Thu, 17 Jul 2025 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755483;
	bh=IM4QtbLTW+vhhANiYAEWUa7DJNSOUUbW6+deuw3Sevw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z54c6KuuYhIPD9PjuP5c6b6t+XOu6gaT1DhiSNtMZctlG9JG2+kelhVNtoyjeNmfw
	 TZT91qjZPESwvAdufujrUxlM1FqcCtGx7s0ZnZU479lJzhApGHKSzg3IFPxhKz7R0l
	 I8M+OlcbXO2WelpCv4gTM6l2O4JEABvHUn9hDnudxGQyPXPaa9/Et+Ns8wy1A3VEMn
	 cy3pkPCZMSAsnZsQiVBRRg6Qj4+CEAbh2+/Sa51gvsAsJ4qOojMbRkiojYUrTYL9ch
	 HgZja8ZIEuEXWwLPYViGRFhz4QQ1+CunJTpb1R+gw56Oz8Qe44fA7ojXCJ2K4FklOb
	 SYXwZlBoiAA6w==
Date: Thu, 17 Jul 2025 13:31:18 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 1/4] Octeontx2-af: Add programmed macaddr to RVU pfvf
Message-ID: <20250717123118.GB27043@horms.kernel.org>
References: <20250716164158.1537269-1-hkelam@marvell.com>
 <20250716164158.1537269-2-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716164158.1537269-2-hkelam@marvell.com>

On Wed, Jul 16, 2025 at 10:11:55PM +0530, Hariprasad Kelam wrote:
> Octeontx2/CN10k MAC block supports DMAC filters. DMAC filters
> can be installed on the interface through ethtool.
> 
> When a user installs a DMAC filter, the interface's MAC address
> is implicitly added to the filter list. To ensure consistency,
> this MAC address must be kept in sync with the pfvf->mac_addr field,
> which is used to install MAC-based NPC rules.
> 
> This patch updates the pfvf->mac_addr field with the programmed MAC
> address and also enables VF interfaces to install DMAC filters.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 23 ++++++++-----------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 890a1a5df2de..dd589f9b10da 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -682,16 +682,19 @@ int rvu_mbox_handler_cgx_mac_addr_set(struct rvu *rvu,
>  				      struct cgx_mac_addr_set_or_get *rsp)
>  {
>  	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
> +	struct rvu_pfvf *pfvf;
>  	u8 cgx_id, lmac_id;
>  
> -	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
> -		return -EPERM;
> +	if (!is_pf_cgxmapped(rvu, pf))
> +		return LMAC_AF_ERR_PF_NOT_MAPPED;
>  
>  	if (rvu_npc_exact_has_match_table(rvu))
>  		return rvu_npc_exact_mac_addr_set(rvu, req, rsp);
>  
>  	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
>  
> +	pfvf = &rvu->pf[pf];
> +	memcpy(pfvf->mac_addr, req->mac_addr, ETH_ALEN);

nit: I think ether_addr_copy() can be used here.

>  	cgx_lmac_addr_set(cgx_id, lmac_id, req->mac_addr);
>  
>  	return 0;
> @@ -769,20 +772,12 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu *rvu,
>  				      struct cgx_mac_addr_set_or_get *req,
>  				      struct cgx_mac_addr_set_or_get *rsp)
>  {
> -	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
> -	u8 cgx_id, lmac_id;
> -	int rc = 0;
> -	u64 cfg;
> +	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
>  
> -	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
> -		return -EPERM;
> -
> -	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> +	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, req->hdr.pcifunc)))
> +		return LMAC_AF_ERR_PF_NOT_MAPPED;
>  
> -	rsp->hdr.rc = rc;
> -	cfg = cgx_lmac_addr_get(cgx_id, lmac_id);
> -	/* copy 48 bit mac address to req->mac_addr */
> -	u64_to_ether_addr(cfg, rsp->mac_addr);
> +	memcpy(rsp->mac_addr, pfvf->mac_addr, ETH_ALEN);

Ditto.

>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
> 

