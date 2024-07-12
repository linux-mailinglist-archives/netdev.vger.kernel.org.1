Return-Path: <netdev+bounces-111078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778492FC87
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0301F2276F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA0171E49;
	Fri, 12 Jul 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvbsgxIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829AC17166F;
	Fri, 12 Jul 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794503; cv=none; b=c27PIGTw4GoCxereoKiTuslf2MT45B9CaW39+t6gzg4GTsMKGGyi/c8R7IJuaxn5cxqx2J9UtAm52/t6o6JWtVw41MvZ4ZcZRXTpdalX0mdx0DARmndI/hGKjmr9hmETZVNBXkqHypDZy413RCJeHU1KTSlihL3Uptv6BY/+ObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794503; c=relaxed/simple;
	bh=w0b/CpSHDgyoVkfW2CFFXNzHWLey9JfJxqCRZtdUKTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTbee3FVx89fcEJC6i7GLM9JBH2dTOSMNmmdALg0BCVGq1WqVO9TDsTw9D83aqy+2QXQbtX5dKK4TFX/I0u7BaK9lnmCJSiEqVEn0HAeWkzUXWyHw82v8HYMfeP1/Rs4BLZi8OLG6OF9ADEIeRgp+rCr+ZTZod2WD6faIjnTjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvbsgxIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659DCC32782;
	Fri, 12 Jul 2024 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794503;
	bh=w0b/CpSHDgyoVkfW2CFFXNzHWLey9JfJxqCRZtdUKTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvbsgxIZg6tdt7RVmn3l241x/7wEwSuy5/yNFKeRkZFaPaktQEjMs/Wz2zBu3rkj9
	 fPbojB3zf74+VuE/oA3Crb4P9y2I8o2tJVqxjthKSdbTDwOy4kmikwqaNnF7TgjOC1
	 x006jg9SIWszo02x/vJf3mtIVakj4v9WlarF67NqTgAxYq5omqDV2irI/hHm3+9VZu
	 UqixC1Bv6DjKacETDgLFEE5dJZEl/jy6QNb2VZu2XRGMeA6ARf7TBHEgkdGwIvzn+Z
	 FmXuudFpeyVys6FdQMNZ/nr9Bams8gVczFPH2SaVyoO5mexGkuVVdNFTBE4io4sYjt
	 ALxRFzEiCkj1A==
Date: Fri, 12 Jul 2024 07:28:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 conor@kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 upstream@airoha.com, angelogioacchino.delregno@collabora.com,
 benjamin.larsson@genexis.eu, rkannoth@marvell.com, sgoutham@marvell.com,
 andrew@lunn.ch, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v7 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <20240712072819.4f43062c@kernel.org>
In-Reply-To: <ZpEz-o1Dkg1gF_ud@lore-desk>
References: <cover.1720600905.git.lorenzo@kernel.org>
	<8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
	<20240711181003.4089a633@kernel.org>
	<ZpEz-o1Dkg1gF_ud@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 15:47:38 +0200 Lorenzo Bianconi wrote:
> > On Wed, 10 Jul 2024 10:47:41 +0200 Lorenzo Bianconi wrote:  
> > > Add airoha_eth driver in order to introduce ethernet support for
> > > Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> > > en7581-evb networking architecture is composed by airoha_eth as mac
> > > controller (cpu port) and a mt7530 dsa based switch.
> > > EN7581 mac controller is mainly composed by Frame Engine (FE) and
> > > QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> > > functionalities are supported now) while QDMA is used for DMA operation
> > > and QOS functionalities between mac layer and the dsa switch (hw QoS is
> > > not available yet and it will be added in the future).
> > > Currently only hw lan features are available, hw wan will be added with
> > > subsequent patches.  
> > 
> > It seems a bit unusual for DSA to have multiple ports, isn't it?
> > Can you explain how this driver differs from normal DSA a little 
> > more in the commit message?  
> 
> The Airoha eth SoC architecture is similar to mtk_eth_soc one (e.g MT7988a).
> The FrameEngine (FE) module has multiple GDM ports that are connected to
> different blocks. Current airoha_eth driver supports just GDM1 that is connected
> to a MT7530 DSA switch (I have not posted a tiny patch for mt7530 driver yet).
> In the future we will support even GDM{2,3,4} that will connect to differ
> phy modues (e.g. 2.5Gbps phy).

What I'm confused by is the mentioned of DSA. You put the port in the
descriptor, and there can only be one switch on the other side, right?

> > > +	q = &eth->q_tx[qid];
> > > +	if (WARN_ON_ONCE(!q->ndesc))
> > > +		goto error;
> > > +
> > > +	spin_lock_bh(&q->lock);
> > > +
> > > +	nr_frags = 1 + sinfo->nr_frags;
> > > +	if (q->queued + nr_frags > q->ndesc) {
> > > +		/* not enough space in the queue */
> > > +		spin_unlock_bh(&q->lock);
> > > +		return NETDEV_TX_BUSY;  
> > 
> > no need to stop the queue?  
> 
> reviewing this chunk, I guess we can get rid of it since we already block the
> txq at the end of airoha_dev_xmit() if we do not have enough space for the next
> packet:
> 
> 	if (q->ndesc - q->queued < q->free_thr)
> 		netif_tx_stop_queue(txq);

But @q is shared in your case isn't it? Unless we walk and stop all
ports this won't save us. Coincidentally not sure how useful BQL can
be in a setup like this :( It will have no way to figure out the real
egress rate given that each netdev only sees a (non-)random sample
of traffic sharing the queue :(



