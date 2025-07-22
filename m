Return-Path: <netdev+bounces-209053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160AB0E1E6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D8D6C65E7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236C27AC50;
	Tue, 22 Jul 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx1dWPE4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCE4B5AE
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201795; cv=none; b=ELClfqb6iIG/J1EXurIasI0LXHk19LtIFeI0zy/cq0+h5f3KBkSZ4wjcc2DHy3zOO8jFZLdnVo+jrt5Y6gzmR0kITyzcfM/m2i5f33DKk6rkvsYJsZpbUPKca8ca83hgE2LTwWIJPuxQXKDHH7qRTzwI4eJtw6BwWob/FvjGfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201795; c=relaxed/simple;
	bh=+OKy2PVIKyPgDVpZf0tb96Y2My075YKSAtpp7mHqu+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLhKh1+gtzXNkCeB0P3pVyFzTFgE/E+pJq5F3qOgInSvlSMlXi4ZkbSLcCsb10HXqFaB0K8aIlNZEa7rW2M7rNctRjV+h2CntiBrodnypIPx6+W6ZL5SGFMFMR5yxTFExY3R2c8XzAxYnoe+qHEmMhfkuI7D6Z9COKnO9m8vEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx1dWPE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47B6C4CEEB;
	Tue, 22 Jul 2025 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201795;
	bh=+OKy2PVIKyPgDVpZf0tb96Y2My075YKSAtpp7mHqu+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gx1dWPE43j7AmS4yL674oA9xkB4JfiUA1bHvQ2HluraNVeCVKldwq/CqUlkh/aA1u
	 VVum26L6Dh6wkzutNOGMRWkLGBPTB6hQt+JmhMp4pAr5nU1d/jygE1HmWsH8/o5wwn
	 ZKFbnZ8mYntNEjqf/7LfHdSUpTHP+jkLJL+Ibx5ZvP4Wo7WsKLlOkooRxstSpnFPpc
	 CBH4YWok85YRewraf9Nwb0KA4YBrYkQay/T+9r1B0NYKzz08G1v/YaRwdYIMQWGJBA
	 cAduS4JO+Axt742vYYPhf8r8W6KdcQgVUmazQsXFinTVEimclmjj00zBow7PVKJGN1
	 5Qc+5lcNtmumg==
Date: Tue, 22 Jul 2025 17:29:50 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <20250722162950.GO2459@horms.kernel.org>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-2-git-send-email-sbhatta@marvell.com>
 <20250722162743.GN2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722162743.GN2459@horms.kernel.org>

On Tue, Jul 22, 2025 at 05:27:43PM +0100, Simon Horman wrote:
> On Thu, Jul 17, 2025 at 10:37:33PM +0530, Subbaraya Sundeep wrote:
> > Simplify NIX context reading and writing by using hardware
> > maximum context size instead of using individual sizes of
> > each context type.
> > 
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > index 0596a3ac4c12..1097c86fdc46 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> > @@ -13,6 +13,8 @@
> >  
> >  #define RVU_MULTI_BLK_VER		0x7ULL
> >  
> > +#define NIX_MAX_CTX_SIZE		128
> > +
> >  /* RVU Block Address Enumeration */
> >  enum rvu_block_addr_e {
> >  	BLKADDR_RVUM		= 0x0ULL,
> > @@ -370,8 +372,12 @@ struct nix_cq_ctx_s {
> >  	u64 qsize		: 4;
> >  	u64 cq_err_int		: 8;
> >  	u64 cq_err_int_ena	: 8;
> > +	/* Ensure all context sizes are minimum 128 bytes */
> 
> Would this be better phrased as follows?
> 
> 	/* Ensure all context sizes are 128 bytes */
> 
> > +	u64 padding[12];
> >  };
> >  
> > +static_assert(sizeof(struct nix_cq_ctx_s) == NIX_MAX_CTX_SIZE);
> 
> I would suggest adding +static_assert() for all the
> drivers that you expect to be NIX_MAX_CTX_SIZE.
> 
> So also:
> - struct nix_rq_ctx_s
> - struct nix_sq_ctx_s
> - struct nix_bandprof_s

Likewise for new structures added by subsequent patches.

...

