Return-Path: <netdev+bounces-122447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81A96161F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095F41C235E0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38D1D175E;
	Tue, 27 Aug 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwDVhmOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1E126F1E;
	Tue, 27 Aug 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781469; cv=none; b=CM1ZMaY27Su36Nec7ppnK/9cDZS7Xqj9rQJ/6c1SsauMIwbAYowosg0D/IUWeZk+5Rkc7/zawKVWkfo6Tzy+MMJIvkQW+Or8MJnIUhE1IPg/A6nqqiXQvsyl7Qn6DFFTV15uWzXkPA4trHVwJfjm05YtrqcQFhH0zn0e+C1cndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781469; c=relaxed/simple;
	bh=fjt18GqG3Pb96VIN06GKpQcRAbi6Q5jRjvjEhh6JYl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK2vvN4oKbt+47bFGE1YI98oTWYwJ6rMfyUAAXVEoPKOBJ2fuaxKLXTfSJYsjq0XRCSUHC9PsO8p9JSErXUdLj9Qwk5o7Or5U3wbTkehO+W5oiP1iN5u7eDMrmu4BRbDasq6LEzYQaA/Xzkw/vqcWmxmJ8pEvMisCICMQXaLkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwDVhmOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15722C4AF18;
	Tue, 27 Aug 2024 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781468;
	bh=fjt18GqG3Pb96VIN06GKpQcRAbi6Q5jRjvjEhh6JYl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwDVhmOyWG8rjS3kFOJEb1hN4EaGsXCZ1J5otduWg0RXECgcU0O9S2qf4sCZAJT0J
	 0zRqSQD6MPFdMPHGNbwl3k+7tepCN/B8nJCKjJ+yExRQpWrTfnN/KwsT0NqGXjR5o+
	 mawDmX5NC8zkQSWJhAy3pueLpIPH/KGWMmCmCMBnUvpSQBRMG8a0aZp9tpDnLgkMm+
	 3pIYcnvHUFWJNMFh25z0TrVBxNemm+cu1NXh5rMUAiFDjuxM1oA0dI4uNXry5mT2vh
	 1FEcABG+o49GhGsEBhn7qDckpcPLAyRxkVHts3Mckd/+6Z2uEFHqj7hMuHhGqUWz6t
	 SOty/TaGxlnRA==
Date: Tue, 27 Aug 2024 18:57:45 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] ethernet: marvell: Use min macro
Message-ID: <20240827175745.GS1368797@kernel.org>
References: <20240827115848.3908369-1-yanzhen@vivo.com>
 <20240827175408.GR1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827175408.GR1368797@kernel.org>

On Tue, Aug 27, 2024 at 06:54:08PM +0100, Simon Horman wrote:
> On Tue, Aug 27, 2024 at 07:58:48PM +0800, Yan Zhen wrote:
> > Using the real macro is usually more intuitive and readable,
> > When the original file is guaranteed to contain the minmax.h header file 
> > and compile correctly.
> > 
> > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index d72b2d5f96db..415d2b9e63f9 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
> >  
> >  	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
> >  		return -EINVAL;
> > -	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
> > -		ring->rx_pending : MVNETA_MAX_RXD;
> > +	pp->rx_ring_size = min(ring->rx_pending, MVNETA_MAX_RXD);
> 
> Given that the type of ring->rx_pending is __32, and MVNETA_MAX_RXD is
> a positive value.

Sorry, I hit send to soon. What I wanted to say is:

I think that it is appropriate to use umin() here.
Because:
1) As I understand things, the type of MVNETA_MAX_RXD is signed,
   but it always holds a positive value
2) ring->rx_pending is unsigned

> See: 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
>      https://git.kernel.org/torvalds/c/80fcac55385c

