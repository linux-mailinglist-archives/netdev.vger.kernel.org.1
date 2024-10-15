Return-Path: <netdev+bounces-135622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AF99E901
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6AF1C22C3C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC41F472C;
	Tue, 15 Oct 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaN+i4Qs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767691EF923;
	Tue, 15 Oct 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994251; cv=none; b=SQByuKy+CPuly+XAoVH+8FaKyjxNTEaZl2WWny1QHoZzZVdGht/7ho4TeBO9PjsCEntwwh5XMrmP9aaONeMibUke7E5kY4of7wrpK2KnT5isginYMEcuMuasxI2+o1/vTin2PmHawWUcsGJ1mMehiwF9OIeC1rrNnHLds1nESvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994251; c=relaxed/simple;
	bh=y+TgaiI7J/jSSYzxAw22Eb8Kte8Q1JyRu7C9LHRxYNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9XFPzeSNoatcjeL6lZ3JXMqDLLRtzwJhuQqkhZrkHpyWRuuxOyfOQNduFqcAwIbP+evvHkhtEy7ZfnP4RqLiWzDwKnPXi8r4QbkCphSDUuZTT+eGp22ZgtK+DEohmHj3HUINaaHCh56nSv9y6+npPXHdqLpK1dzsLODu9Zy7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaN+i4Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463DEC4CEC6;
	Tue, 15 Oct 2024 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728994251;
	bh=y+TgaiI7J/jSSYzxAw22Eb8Kte8Q1JyRu7C9LHRxYNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaN+i4Qsf+ngZdxNJefPuqntIcEuA6A2ATjaapyVQA0uknJ48fWgfnDpbaI2GwRgY
	 JLCSHppy/NGNEEvQwVG/KPco3oCyA+wRadCCHpUxug0BXsS260Q6ERi64dJDw47QhV
	 b3RKAVWX6xnxVzQkGFkGAF/Fy97xy3VyHBj4TTiSPffpYs0qomYBvL306UYltxIiIF
	 v1AgitFso53aumLsDp1o9OWeFMOYcpX2s6gavzYnTpevCys4cgFgl+d6PvfRFwjw15
	 1WVlvIiAgrVk9RYfBhsT5eBhUg07LkxjHpGL7GyQj9WXO0ntZ05qW7CB+9RyMYPOLA
	 yAhxyYnvloLGA==
Date: Tue, 15 Oct 2024 13:10:47 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] net: ethernet: freescale: Use %pa to format
 resource_size_t
Message-ID: <20241015121047.GE569285@kernel.org>
References: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
 <20241015072448.6ssv6vsyjpv4vnhi@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015072448.6ssv6vsyjpv4vnhi@DEN-DL-M70577>

On Tue, Oct 15, 2024 at 07:24:48AM +0000, Daniel Machon wrote:
> > Hi,
> > 
> > This short series addersses the formatting of variables of
> > type resource_size_t in freescale drivers.
> > 
> > The correct format string for resource_size_t is %pa which
> > acts on the address of the variable to be formatted [1].
> > 
> > [1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229
> > 
> > These problems were introduced by
> > commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")
> > 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/
> > 
> > ---
> > Simon Horman (2):
> >       net: fec_mpc52xx_phy: Use %pa to format resource_size_t
> >       net: ethernet: fs_enet: Use %pa to format resource_size_t
> > 
> >  drivers/net/ethernet/freescale/fec_mpc52xx_phy.c     | 2 +-
> >  drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > base-commit: 6aac56631831e1386b6edd3c583c8afb2abfd267
> > 
> 
> Hi Simon,
> 
> Is this for net-next? I dont see a target tree name :-)

Hi Daniel,

Yes, it is. Sorry for forgetting to include that in the subject.

> Looking at the docs, %pa seems correct to me.
> 
> For the series:
> 
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> 

