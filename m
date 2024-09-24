Return-Path: <netdev+bounces-129461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C25984071
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CFD1C219B3
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F214D44D;
	Tue, 24 Sep 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4y4i2KM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9B14B084;
	Tue, 24 Sep 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166376; cv=none; b=JtjksbS7fQ+4fHP4xeWDqli/wtWpWp0oEL4Qyv3J394hlclNd+pRk9g17bRA5XZsaIeCXcRdG7inwrtoXRuNvSpUurMJ4xn/+jgPZpgU0s+xPqbmQFG+oAatgx4BCzsOSoXfz3bTFYncjmFfdLhMoQi2wApHDUZilZD6kvWwYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166376; c=relaxed/simple;
	bh=+mAzpN0apCcTeuZYQ1025YePKlqEkE9/u+Kn+PTRRF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0Q6DFg0+mfl9blLy6Tx61BiAWaT64JIlcFguoqzJ0h81njKmTDfUDU1vAZ/tsaGN9hRDzpx8VdDuifZ4wfPPXJg03nWiSpZErpGGu8yg6EIwKMWR8y0v8HafHdXTLKDYK3Lgsq9y//0T7dN8PGdsWFWMwjds7Spw6pW6p2GdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4y4i2KM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDECC4CEC4;
	Tue, 24 Sep 2024 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727166376;
	bh=+mAzpN0apCcTeuZYQ1025YePKlqEkE9/u+Kn+PTRRF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4y4i2KMrrcE2CrOy8mlm405vrWu9/Qy2h2YYxEAmqqjx/uh/BfhOCWnnP29P4gMO
	 wb8PrrIn1uexTgcLVJ4MKIPB7BsWKw4mcmCifhFUp1ufO5yMVA1Acqxmeofcgvp77p
	 SHgGlP5hLGKGE+v9NVojnSpdoSlVWKllPLkv9ecMUdpcFIqWCfY3DfZljMnONdzeyp
	 KWWPMUM+AvsvU1G47zk0m5GjVKNI4rA1eOG4e/opNbNzET60kZed4e5K2xKFCI46ZC
	 7CfG5FWhyjYdrlKWdjn4gv2yuXTBPwKNbq8SRO5+T28wFSPihfz8U1AvFqoMAz8epL
	 OeM4ySulkmY2w==
Date: Tue, 24 Sep 2024 09:26:12 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <20240924082612.GF4029621@kernel.org>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
 <20240924071839.GD4029621@kernel.org>
 <20240924101529.0093994d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924101529.0093994d@kmaincent-XPS-13-7390>

On Tue, Sep 24, 2024 at 10:15:29AM +0200, Kory Maincent wrote:
> On Tue, 24 Sep 2024 08:18:39 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Mon, Sep 23, 2024 at 05:34:26PM +0200, Kory Maincent wrote:
> >  [...]  
> > 
> > Thanks Kory,
> > 
> > I agree that these changes are correct.
> > But are they fixes; can this manifest in a bug?
> 
> I didn't face it but I think yes.
> In case of a 4 pairs PoE ports without the fix:
> 
>         chan = priv->port[id].chan[0];                                          
>         if (chan < 4) {                                                         
>                 enabled = ret & BIT(chan);                                  
>                 delivering = ret & BIT(chan + 4);                           
> 	...                          
>         }                                                                       
>                                                                                 
>         if (priv->port[id].is_4p) {                                             
>                 chan = priv->port[id].chan[1];                                  
>                 if (chan < 4) {
>                         enabled &= !!(ret & BIT(chan));                         
>                         delivering &= !!(ret & BIT(chan + 4));
> 
> If enabled = 0x2 here, enabled would be assigned to 0 instead of 1.
> ...
> 
> 		} 
> 	}  
> 
> I have an issue using 4pairs PoE port with my board so I can't test it.
> 
> 
> > (If so, I suspect the Kernel is riddled with such bugs.)
> 
> Don't know about it but if I can remove it from my driver it would be nice. :)

Right, no question from my side that this change is a good one.
I'm just wondering if it is best for net or net-next.

