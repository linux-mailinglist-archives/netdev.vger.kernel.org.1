Return-Path: <netdev+bounces-160920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95BA1C2BC
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844B6168F94
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A5209F4B;
	Sat, 25 Jan 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Liy6QBKK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC322080D7;
	Sat, 25 Jan 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800448; cv=none; b=aMH2o8pQVqR2NwY+NOE7nrdZATMJI8MjNjlksn1RrGdZLwcX2AJt5ir4C8n4jJvCsjVVV1xaxsvtqgs5IPc8xh7++otMUmTP1X8iKy2z8x16684m+rtp9lzHZvtKv9cNCB66JD2MbbOpQASsA9go/pRnP882lQH2wr4P9Q+kT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800448; c=relaxed/simple;
	bh=lat7sgT9EGr0uNfpDjLRCQgYrj8L13sbh8ahww7+gZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCWwFQHEGoW9IJ+InxmXwq6kTT+TPwOlYKTsoCYABzfMJ4MLIf5VcDufbBqpXQ1s80V4Bi1HtBPL09/i+mcNKWaLDaWBlVtUXDVSOd7skpo6pBbq0iwWheV0NKNOKX+N6+pYcpB+RM88UpG+4qRofZg7aiXTbjBOug09ouDw+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Liy6QBKK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B7DEF138016A;
	Sat, 25 Jan 2025 05:20:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 25 Jan 2025 05:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737800443; x=1737886843; bh=wfvSpCX+V5zYmBnjZfj8HnP796xfwBWgA/B
	GlazT0N8=; b=Liy6QBKKq1vNslG0frNNQ8ZOZF4YVO28jfSlWo/+BChqGJ9nMuY
	PIhEdzwsITQ/MTcZerYpypwH3iSKKukVDIIU9ZHpNMVj49a8PZpPL2G6wLcv8CI/
	ctsQoxXEAwTbL/zFKgj4PE1pWTWtkV21mcYjMnTyoZGA0u+O4edtNhXPBAg5E4V0
	vBJ0tZZYNpQZ2/4SQhjjR6Mrl78uoUfyZEeApow7TRE7UUVMepOe0c8q3CCh+ax/
	nwXiBjePKol90O9nv4jBsxZPY+nlf+3xM4bXoj5PSxerJkzx6h+5AUBr37C+TAyP
	QLcdJSHO2OH5GcSFHS1C7fq5sThA2EE7ngQ==
X-ME-Sender: <xms:-rqUZ2YMP4eMQkA9PwoRDquitQv8LWBv4bIbsMKroykPh4tsCPFsxA>
    <xme:-rqUZ5YH-mRh6rN3RejNVMY2WFRU059L7CQj7w7BwzCU2yOlh4kXC4b8cXeYw3OGa
    8DzNRs9NDg1WO0>
X-ME-Received: <xmr:-rqUZw9X7qoxovCS-1F2_Xel_tMnaev6tiHbmmxDmsukOHy2X_BRaUqnfQq21QNW-gvdnMBA0nDQSn1r4hAvl3xAuy_ynw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgjedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptdiguddvtdejsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthht
    ohepsghgrhhifhhfihhssehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhnrghthh
    grnhhhsehnvhhiughirgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqd
    hmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopehlihhnuhig
    qdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrlhgvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:-rqUZ4r3aXKJCGS03zlXoSDGv-ALNpPNWBnJHO0xsV8nQHDYy4CIEw>
    <xmx:-rqUZxomAAfsoCiaBh8luWaktb77QMLNqWymjbIWlgZOiDtQZnRTHg>
    <xmx:-rqUZ2QxKkrfCRmjI2btgCo-I5egxZ0KJbMZAgE6oImhMvsAfLBlIw>
    <xmx:-rqUZxpxJC_77A3I1JfEIDCMeXO5pza8XHbENEUeokqmimNPCe2K0Q>
    <xmx:-7qUZw-X2p7RTI4nSrbACn3sVCY2G7iwO7hQ0e3D7H5fq0AnGAzFxI4Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 05:20:41 -0500 (EST)
Date: Sat, 25 Jan 2025 12:20:38 +0200
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
Message-ID: <Z5S69kb7Qz_QZqOh@shredder>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124104256.00007d23@gmail.com>

On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
> On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > Just to clarify, the patch that you had us try was not intended as an actual
> > > fix, correct? It was only for diagnostic purposes, i.e. to see if there is
> > > some kind of cache coherence issue, which seems to be the case?  So perhaps
> > > the only fix needed is to add dma-coherent to our device tree?  
> > 
> > That sounds quite error prone. How many other DT blobs are missing the
> > property? If the memory should be coherent, i would expect the driver
> > to allocate coherent memory. Or the driver needs to handle
> > non-coherent memory and add the necessary flush/invalidates etc.
> 
> stmmac driver does the necessary cache flush/invalidates to maintain cache lines
> explicitly.

Given the problem happens when the kernel performs syncing, is it
possible that there is a problem with how the syncing is performed?

I am not familiar with this driver, but it seems to allocate multiple
buffers per packet when split header is enabled and these buffers are
allocated from the same page pool (see stmmac_init_rx_buffers()).
Despite that, the driver is creating the page pool with a non-zero
offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
headroom, which is only present in the head buffer.

I asked Thierry to test the following patch [1] and initial testing
seems OK. He also confirmed that "SPH feature enabled" shows up in the
kernel log.

BTW, the commit that added split header support (67afd6d1cfdf0) says
that it "reduces CPU usage because without the feature all the entire
packet is memcpy'ed, while that with the feature only the header is".
This is no longer correct after your patch, so is there still value in
the split header feature? With two large buffers being allocated from
the same page pool for each packet (headers + data), the end result is
an inflated skb->truesize, no?

[1]
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index edbf8994455d..42170ce2927e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2091,8 +2091,8 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	pp_params.nid = dev_to_node(priv->device);
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
-	pp_params.offset = stmmac_rx_offset(priv);
-	pp_params.max_len = dma_conf->dma_buf_sz;
+	pp_params.offset = 0;
+	pp_params.max_len = num_pages * PAGE_SIZE;
 
 	rx_q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rx_q->page_pool)) {

