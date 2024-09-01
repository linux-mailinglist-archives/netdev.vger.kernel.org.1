Return-Path: <netdev+bounces-124055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7A967BBE
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993DE281B42
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE84225D7;
	Sun,  1 Sep 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byA2c9Y/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91BD2C9D;
	Sun,  1 Sep 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215451; cv=none; b=j1XpuROvfqWpuHJ7oSqiNWTsRmTc9VoI6iBybRqoSjcnlff4RXOAJt4jtTK/GYqRLqAWYJO9TfCijjvM3aAKwMpKh7dw1HopkZ7TTv8KyzvpgOMO5sB2lacRXX8SYrEJjPcTKiCYPFdBog4cn23h6Odp4K8sgnFjd7GCVacXryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215451; c=relaxed/simple;
	bh=rLam6OuvElKfa+4klzcuq+HotmqGXLuMC9ftlVRktjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYPulipvixrL8kEAd8KpW484C5Qx5amwaqG38sRh4eOVBiGnE3zbOQ71Yql0+p/PfY0lhpybXSEPIjKbXyoMoLw+0HqpVKXboeAJIvR0iKG65g0oWFcJqwd3N/3a9MllgW+t88jOERUiJ39pIUuc83dafSkF1tWmAMxEVPelwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byA2c9Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF33C4CEC3;
	Sun,  1 Sep 2024 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725215450;
	bh=rLam6OuvElKfa+4klzcuq+HotmqGXLuMC9ftlVRktjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byA2c9Y/uGsgC6Hyrupz6Yox1bOBtSOh0Ta+4KK1WgK6lxFU1FRU6BnXxn8Xuy7+R
	 iwKVlTdKfFw2q/jshRnrNCmn0cw9DvXU1oPxRyv+Odhb+A+zGnzkdKuHFiAgoYi+BB
	 PxFc6am1VK9IHbGPWoRuPJIN5wBAZeblBNiamM+D3W2UZlUjL2V++6PlVqFJWW5g6h
	 EvJPr/xkXxQHwCN+9vfMwxquJ4GS/m5AmXSBA2UI0vDf1PI9reja7Fl7Ff7KR3cz2p
	 DdoRQbZIP0yvgr/zoX3iJHZLsLf+gfiCQacOcvQFYqdV4niS0vFfE5DmpNO45dYBLy
	 wxGbgTaJm24pA==
Date: Sun, 1 Sep 2024 19:30:46 +0100
From: Simon Horman <horms@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Yan Zhen' <yanzhen@vivo.com>,
	"marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH net-next v3] net: mvneta: Use min macro
Message-ID: <20240901183046.GB23170@kernel.org>
References: <20240830010423.3454810-1-yanzhen@vivo.com>
 <d23dfbf563714d7090d163a075ca9a51@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23dfbf563714d7090d163a075ca9a51@AcuMS.aculab.com>

On Sun, Sep 01, 2024 at 10:52:38AM +0000, David Laight wrote:
> From: Yan Zhen
> > Sent: 30 August 2024 02:04
> > To: marcin.s.wojtas@gmail.com; davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > 
> > Using the real macro is usually more intuitive and readable,
> > When the original file is guaranteed to contain the minmax.h header file
> > and compile correctly.
> > 
> > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > ---
> > 
> > Changes in v3:
> > - Rewrite the subject.
> > 
> >  drivers/net/ethernet/marvell/mvneta.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index d72b2d5f96db..08d277165f40 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
> > 
> >  	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
> >  		return -EINVAL;
> > -	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
> > -		ring->rx_pending : MVNETA_MAX_RXD;
> > +	pp->rx_ring_size = umin(ring->rx_pending, MVNETA_MAX_RXD);
> 
> Why did you use umin() instead of min() ?

Possibly because I mistakenly advised it is appropriate, sorry about that.
Given your explanation elsewhere [1], I now agree min() is appropriate.

[1] https://lore.kernel.org/netdev/20240901171150.GA23170@kernel.org/T/#mebc52fc11de13eff8a610e3a63c5d1026d527492

> >  	pp->tx_ring_size = clamp_t(u16, ring->tx_pending,
> >  				   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
> 
> Hmmm how about a patch to fix the bug in that line?
> A typical example of the complete misuse of the '_t' variants.
> The fact that the LHS is u16 doesn't mean that it is anyway
> correct to cast the RHS value to u16.
> In this case if someone tries to set the ring size to 64k they'll

