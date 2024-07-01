Return-Path: <netdev+bounces-108171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D632F91E153
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AB61C22EC7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CF15F326;
	Mon,  1 Jul 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXVSrgwX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2415EFB2;
	Mon,  1 Jul 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842007; cv=none; b=EXLtY2uIw0vCyPLmprPdYGK8AD+66vw3Ar64hhG8qb4ORKnMSwJTl2a47+RSBstsQcDeRbIyxUSguZrz8xfkc4EjeWZRsXn88GZUc3kHHeAQs3DXtbVRbevPjkFOFgJjfj8l4LnTn+IEkbWUwIykkPYf0JW8gh0a3GXR4Y76as4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842007; c=relaxed/simple;
	bh=r8TwQcnCucjLf3kM3DNF0A1LB9UEN+OlT5l5Gu1zqZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4J76cGh9g3mSRACs7M9qbM4pZoHjE+VqL72y/Vo/qiGoVV6VxlmZ+VccZkWpaEydk9nIm8E6dj1bSYjLSCaQY3wdq807mT9rlut6rC4ZYNDoTsjVmupC+rtuYJd4BEvow4RNMmX+sDEOAc7NvbrBHhEpw0c9e76c1TinSpZKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXVSrgwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DE0C116B1;
	Mon,  1 Jul 2024 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842006;
	bh=r8TwQcnCucjLf3kM3DNF0A1LB9UEN+OlT5l5Gu1zqZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXVSrgwX6xGnNVw8bHLm1pEJOdWLG9BWhabv/PL/EfTjTIvdzWelbL2/GpdRkr4CA
	 tCNVaajyzy1L6IHs0PPpeab4t1oeOhQVPCDUHo58+az4k2YoYGp64UvDaOufgzRGoX
	 5+HnfF6ZDnwQHw07UqOS1gZ2xyIYvtgGemJfk0dGHOiEorbD2vTYhlCrpEwJ5GbJID
	 kkLss+ukrXm22I/2RhVmZdCWShVt7xlMtm3KaQT3g7BSN6RirZ9O9i3PJ1viGFBn29
	 H2q+fUX4AN+DNiptlO+VYIib/Th4w1d+vrzyTVeGXxm5cZoGdvf0ftRGlyETZBn428
	 5lid3z318HhYg==
Date: Mon, 1 Jul 2024 14:53:19 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v4 2/2] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <20240701135319.GE17134@kernel.org>
References: <cover.1719672695.git.lorenzo@kernel.org>
 <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>

On Sat, Jun 29, 2024 at 05:01:38PM +0200, Lorenzo Bianconi wrote:
> Add airoha_eth driver in order to introduce ethernet support for
> Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
> en7581-evb networking architecture is composed by airoha_eth as mac
> controller (cpu port) and a mt7530 dsa based switch.
> EN7581 mac controller is mainly composed by Frame Engine (FE) and
> QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
> functionalities are supported now) while QDMA is used for DMA operation
> and QOS functionalities between mac layer and the dsa switch (hw QoS is
> not available yet and it will be added in the future).
> Currently only hw lan features are available, hw wan will be added with
> subsequent patches.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Some minor feedback from my side.

> +static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
> +				    u32 clear, u32 set)
> +{
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(index >= ARRAY_SIZE(eth->irqmask)))
> +		return;
> +
> +	spin_lock_irqsave(&eth->irq_lock, flags);
> +
> +	eth->irqmask[index] &= ~clear;
> +	eth->irqmask[index] |= set;
> +	airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
> +	/* Read irq_enable register in order to guarantee the update above
> +	 * completes in the spinlock critical section.
> +	 */
> +	airoha_rr(eth, REG_INT_ENABLE(index));

airoha_rr() expects an __iomem pointer as it's first argument,
but the type of eth is struct airoha_eth *eth.

Should this be using airoha_qdma_rr() instead?

Flagged by Sparse.

> +
> +	spin_unlock_irqrestore(&eth->irq_lock, flags);
> +}

...

> +static void airoha_ethtool_get_strings(struct net_device *dev, u32 sset,
> +				       u8 *data)
> +{
> +	int i;
> +
> +	if (sset != ETH_SS_STATS)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++) {
> +		memcpy(data + i * ETH_GSTRING_LEN,
> +		       airoha_ethtool_stats_name[i], ETH_GSTRING_LEN);
> +	}
> +
> +	data += ETH_GSTRING_LEN * ARRAY_SIZE(airoha_ethtool_stats_name);
> +	page_pool_ethtool_stats_get_strings(data);
> +}

W=1 allmodconfig builds on x86_64 with gcc-13 complain about the use
of memcpy above because the source is (often?) less than ETH_GSTRING_LEN
bytes long.

I think the preferred solution is to use ethtool_puts(),
something like this (compile tested only!):

@@ -2291,12 +2291,9 @@ static void airoha_ethtool_get_strings(struct net_device *dev, u32 sset,
 	if (sset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++) {
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       airoha_ethtool_stats_name[i], ETH_GSTRING_LEN);
-	}
+	for (i = 0; i < ARRAY_SIZE(airoha_ethtool_stats_name); i++)
+		ethtool_puts(&data, airoha_ethtool_stats_name[i]);
 
-	data += ETH_GSTRING_LEN * ARRAY_SIZE(airoha_ethtool_stats_name);
 	page_pool_ethtool_stats_get_strings(data);
 }
 

...

> +static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
> +{
> +	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
> +	struct net_device *dev;
> +	struct airoha_gdm_port *port;

nit: reverse xmas tree

> +	int err, index;
> +	u32 id;

...

-- 
pw-bot: changes-requested

