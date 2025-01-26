Return-Path: <netdev+bounces-160955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994CA1C70E
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 09:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37AA16701D
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E48635E;
	Sun, 26 Jan 2025 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghCz0DMH"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4955887;
	Sun, 26 Jan 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737880890; cv=none; b=D7GkJzKPnDCBBS5E3C1w38nqtLv/fQ/XyacCTGWp+TEd7Z1rSU+TOiXQ6gwYdLtfmHaECjnxsE1GBwzD2k+SyncgyZHmMk/DvgwOYZkrJtV3CgpWZFp13X3qgLypCbiv0+xEDB9zDjh7M8nFtoOeYIZAdpR6Akeivwfgs+gsrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737880890; c=relaxed/simple;
	bh=1uU+IlNal+3EPTF/c40sK/iz5IjYkn5z3LCvgEtMl1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHOHozoAMlMTWIGeVPHF+m6VKnRmYyqpeFkzTr0vkzAFcDZw4kTBBHDv7I8nVVGuolzWLK4hEINMWShQfcS1o9/69rTZGg/vzA6wBRZiya2QgltASlodV7d0jbpTa+XU9WmSuGuPtv0HEOYGqykHdHMfuHDxpJMutO6qR74H64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghCz0DMH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18FA92540103;
	Sun, 26 Jan 2025 03:41:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 26 Jan 2025 03:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737880886; x=1737967286; bh=HftiZnevtp2qsnswvVZXprhygnVO8ILoeqm
	v/RLP7DQ=; b=ghCz0DMHEyWWC3P4FQncx+iKypq2RfrGaudZw7qPikAVrYP5SwZ
	QqHH8AD13TlGQIK45fiecOhOQ+MR7XQx1mdMGSSsZ/ACh6Gm0HQMyOsLdBGYNnwO
	yz7n2jlZ6i/8nUAd3qbmSjcK5nmfA7v2mAfVldbxTYiK+qvm077iPn2+DUwXnDrY
	3R+FasvmpRUGlU+gY3ceEOVtNNpNzgyd+HyHsTA4SNBxXSqEXq4XxuioWKp+IeXi
	oXqkJqdT5Wh+WMhIQ4/9nNN+kx8tHgzM59DuF45tPWHw3NrqfLLyGyCeNIka2X+0
	unRuexvZamJouX19sI2prUzLN8qmyHCSgKQ==
X-ME-Sender: <xms:NvWVZ0GRQYxjN6EG78mYvtoUJtC_ZiT3Nz5Ielkg8WTBSZPiqzj0lg>
    <xme:NvWVZ9VaTS6rBkMbcs6FBEe_iRUj6vurXEom1CZvZhizN2lcgmneeBZp_cW03KxHJ
    icjy_K5ISVFAec>
X-ME-Received: <xmr:NvWVZ-JiR6BmOphchStlHlgASuJae87b5-qgMN4Clstgr8x6KXBPCRlwxtsV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgleektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopedtgiduvddtjeesghhmrghilhdrtghomhdprhgtphhtthhopegr
    nhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegsghhrihhffhhishesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnhhesnhhvihguihgrrdgtohhmpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghp
    lhihrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvghkshgrnhguvghrrd
    hlohgsrghkihhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:NvWVZ2GSd8rk6Q76dOpZQVJFjbCP83n5WvR-tm9AO6WUJTCBEp_oaA>
    <xmx:NvWVZ6U9HO7GkxTTz7l2XFE8pYwGF8Ea_Brtb9sX78E8xo2LsSofpw>
    <xmx:NvWVZ5MZayxKuK-jiCAay_c4NJHybliV6nwQ_NEUwGE6oOYXn34uaA>
    <xmx:NvWVZx2HtaJT4RUf0DUY4FfOYjvzUe6p6IH6tR2genF6FfOmYRQPnA>
    <xmx:NvWVZ4Yxox-UqScH-CKvvBbjRcJSxt4_PDvqf-1AqmL7Qg46l4QJ_VMC>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jan 2025 03:41:25 -0500 (EST)
Date: Sun, 26 Jan 2025 10:41:23 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Brad Griffis <bgriffis@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <Z5X1M0Fs-K6FkSAl@shredder>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com>
 <Z5S69kb7Qz_QZqOh@shredder>
 <20250125224342.00006ced@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125224342.00006ced@gmail.com>

Hi,

On Sat, Jan 25, 2025 at 10:43:42PM +0800, Furong Xu wrote:
> Hi Ido
> 
> On Sat, 25 Jan 2025 12:20:38 +0200, Ido Schimmel wrote:
> 
> > On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
> > > On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch>
> > > wrote: 
> > > > > Just to clarify, the patch that you had us try was not intended
> > > > > as an actual fix, correct? It was only for diagnostic purposes,
> > > > > i.e. to see if there is some kind of cache coherence issue,
> > > > > which seems to be the case?  So perhaps the only fix needed is
> > > > > to add dma-coherent to our device tree?    
> > > > 
> > > > That sounds quite error prone. How many other DT blobs are
> > > > missing the property? If the memory should be coherent, i would
> > > > expect the driver to allocate coherent memory. Or the driver
> > > > needs to handle non-coherent memory and add the necessary
> > > > flush/invalidates etc.  
> > > 
> > > stmmac driver does the necessary cache flush/invalidates to
> > > maintain cache lines explicitly.  
> > 
> > Given the problem happens when the kernel performs syncing, is it
> > possible that there is a problem with how the syncing is performed?
> > 
> > I am not familiar with this driver, but it seems to allocate multiple
> > buffers per packet when split header is enabled and these buffers are
> > allocated from the same page pool (see stmmac_init_rx_buffers()).
> > Despite that, the driver is creating the page pool with a non-zero
> > offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
> > headroom, which is only present in the head buffer.
> > 
> > I asked Thierry to test the following patch [1] and initial testing
> > seems OK. He also confirmed that "SPH feature enabled" shows up in the
> > kernel log.
> > BTW, the commit that added split header support (67afd6d1cfdf0) says
> > that it "reduces CPU usage because without the feature all the entire
> > packet is memcpy'ed, while that with the feature only the header is".
> > This is no longer correct after your patch, so is there still value in
> > the split header feature? With two large buffers being allocated from
> 
> Thanks for these great insights!
> 
> Yes, when "SPH feature enabled", it is not correct after my patch,
> pp_params.offset should be updated to match the offset of split payload.
> 
> But I would like to let pp_params.max_len remains to
> dma_conf->dma_buf_sz since the sizes of both header and payload are
> limited to dma_conf->dma_buf_sz by DMA engine, no more than
> dma_conf->dma_buf_sz bytes will be written into a page buffer.
> So my patch would be like [2]:
> 
> BTW, the split header feature will be very useful on some certain
> cases, stmmac driver should support this feature always.
> 
> [2]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index edbf8994455d..def0d893efbb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2091,7 +2091,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>         pp_params.nid = dev_to_node(priv->device);
>         pp_params.dev = priv->device;
>         pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
> -       pp_params.offset = stmmac_rx_offset(priv);
> +       pp_params.offset = priv->sph ? 0 : stmmac_rx_offset(priv);

SPH is the only scenario in which the driver uses multiple buffers per
packet?

>         pp_params.max_len = dma_conf->dma_buf_sz;

Are you sure this is correct? Page pool documentation says that "For
pages recycled on the XDP xmit and skb paths the page pool will use the
max_len member of struct page_pool_params to decide how much of the page
needs to be synced (starting at offset)" [1].

While "no more than dma_conf->dma_buf_sz bytes will be written into a
page buffer", for the head buffer they will be written starting at a
non-zero offset unlike buffers used for the data, no?

[1] https://docs.kernel.org/networking/page_pool.html#dma-sync

