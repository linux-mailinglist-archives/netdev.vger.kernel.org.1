Return-Path: <netdev+bounces-209068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE46B0E267
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6763A6D6D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832227AC30;
	Tue, 22 Jul 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP7WaPDC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B116AA7
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204132; cv=none; b=s1DBoJgIvD2jORFwDoQHh2iwAe2DtpglwVWqxV2qyM4uxmPlNtiZgH1B4uI7BfVSZNzg9cPzsI8IbQD9o0MMTKzvrRtEisMA3BxEAHjWYYmA4zpBOZYOTcqW/1RXA1iK4sHBysqSXBZBJNRclJEyvrF5v0DjBH8FT8LtUARARUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204132; c=relaxed/simple;
	bh=SRjp+rZFJkGMAoTZJaBhJAi4ydF0MxcQwR4T+kXrxXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4FPljSbd62+r/7fipJ8Ebt6iMeq3SF7jXNCTmXb8bgbCtRikH7LI3Apa5TYxQi3INaxWpVFcH3pn3zNv/hhUdVxe+3/ZKstDboWvmtVFDGQZoAyf4h8jbM0KHBcnTBNuok10aFz/lN+8XRCs469UZ3UMdxnfTMJvEhfwWhEzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP7WaPDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECD1C4CEEB;
	Tue, 22 Jul 2025 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204132;
	bh=SRjp+rZFJkGMAoTZJaBhJAi4ydF0MxcQwR4T+kXrxXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP7WaPDC7e89Ay+qIxCMFDjxSaFe1/TZAeVne3Ybq3CZ6aF5HP0Zk87bJCWDQDxYc
	 J9UMkHxHUSeiA20CFpM1VINBNqVFsGBHqwEfw4STsGcR+IV8qKOR+uc7YMsFdXzT7Y
	 v3R81Ptzekfpvcn7ubFtgQD5L8/Hkg3lLxgAt0rXHMLLwWH9lRizpGzJr8Eq5SJJvS
	 4GzvmSRvUUBu2VRIoSLg/pZWawypehFNulfgnmzCwhc4CE9teHONb5S0QadElHKapM
	 ld9DybO0dbtkJUw3BBVb6kpjN2VZvSzQX6hdBh5IdY57UCt4MgFa11bpAfid0WEjlJ
	 gGOOjH9dg7+zQ==
Date: Tue, 22 Jul 2025 18:08:47 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 09/11] octeontx2-af: Accommodate more
 bandwidth profiles for cn20k
Message-ID: <20250722170847.GU2459@horms.kernel.org>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-10-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752772063-6160-10-git-send-email-sbhatta@marvell.com>

On Thu, Jul 17, 2025 at 10:37:41PM +0530, Subbaraya Sundeep wrote:
> CN20K has 16k of leaf profiles, 2k of middle profiles and
> 256 of top profiles. This patch modifies existing receive
> queue and bandwidth profile context structures to accommodate
> additional profiles of cn20k.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 13 ++++++++-----
>  .../net/ethernet/marvell/octeontx2/af/rvu_struct.h  |  6 ++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 162283302e31..f6ecdb4b5ff9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -5856,7 +5856,7 @@ static int nix_verify_bandprof(struct nix_cn10k_aq_enq_req *req,
>  		return -EINVAL;
>  
>  	ipolicer = &nix_hw->ipolicer[hi_layer];
> -	prof_idx = req->prof.band_prof_id;
> +	prof_idx =  req->prof.band_prof_id_h << 7 | req->prof.band_prof_id;
>  	if (prof_idx >= ipolicer->band_prof.max ||
>  	    ipolicer->pfvf_map[prof_idx] != pcifunc)
>  		return -EINVAL;
> @@ -6021,8 +6021,10 @@ static int nix_ipolicer_map_leaf_midprofs(struct rvu *rvu,
>  	aq_req->op = NIX_AQ_INSTOP_WRITE;
>  	aq_req->qidx = leaf_prof;
>  
> -	aq_req->prof.band_prof_id = mid_prof;
> +	aq_req->prof.band_prof_id = mid_prof & 0x7F;
>  	aq_req->prof_mask.band_prof_id = GENMASK(6, 0);
> +	aq_req->prof.band_prof_id_h = mid_prof >> 7;
> +	aq_req->prof_mask.band_prof_id_h = GENMASK(3, 0);
>  	aq_req->prof.hl_en = 1;
>  	aq_req->prof_mask.hl_en = 1;
>  

Perhaps it follows an existing pattern in this driver.
But the shifts in the above two hunks look
ripe for using FIELD_PREP/FIELD_GET along with #define GENMASK(...).

Likewise elsewhere in this patch.

...

