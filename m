Return-Path: <netdev+bounces-208242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AACB0AAF3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE848A47D7B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1221DED70;
	Fri, 18 Jul 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9sovkPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8DBD517;
	Fri, 18 Jul 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869167; cv=none; b=M63oaJxmDmm38IG8BLhsMximjJwDIaFDZUvguU4vtT+tCHO//CRq97TLH6akv/EZ9jlutw/F5shNlXH/fP9ro/5UMfZYIZEVZXrGReEomnbGPQuF5l75Tl1q8iivJprwLI2tKaCvIiZW3W6WrhWXmU+8Ihp8ayasVvAQuq0v6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869167; c=relaxed/simple;
	bh=iM/cBfn6qf7kJPZApTF05wjQcPVP4ARh8oIYFBvOnbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLhTAetYpHUz7WNX7PMiox39tNGeWcHFPWgqmCStllmv1jypGATXt5Z8zwEEdGMoFpW4IoYaBkRO8QUcEOoV7kzRwlgRFjNh1RqPJEwiK20T2GlBGxM3rauY2HWNcpQim9XMC1rO7/r/JjZxlT5/mCxP6/fQR9pK3ATc28mHxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9sovkPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2DFC4CEEB;
	Fri, 18 Jul 2025 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752869167;
	bh=iM/cBfn6qf7kJPZApTF05wjQcPVP4ARh8oIYFBvOnbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9sovkPL7D4ADsST94stWH0zK+qSnkGSP7rTG4uGBOET4Estd53I+YmUj05eVidQY
	 Z+vhivYCZzdG4JK+0+6+msMFyJNHK0jd9mJWkgZjsA0rWpbTLQod7CrLL/6t4CGjlg
	 WrBVfNMJ/dnR3gXbbikXOA620EjvAhW2I3S8j55lPP9Ac0ModgGoAYg7tSOm+89kbx
	 8KW1iUdiwkv/vYGZ5+SIlNRxNvKXtkEX/dfo3XC8eIJM7pp91a1JUHBYV38eZXUUdO
	 wRgL1XMesXepYg8WKV12cra7adqTbHIwuMPNInU5hpbA2zD1TOoriaAY73a9RXqiGl
	 MGp/HZUCpQj3w==
Date: Fri, 18 Jul 2025 21:06:02 +0100
From: Simon Horman <horms@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Set CIC bit only for TX queues
 with COE
Message-ID: <20250718200602.GM2459@horms.kernel.org>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-3-c34092a88a72@altera.com>
 <20250714134012.GN721198@horms.kernel.org>
 <9f4acd69-12ff-4b2f-bb3a-e8d401b23238@altera.com>
 <20250716082209.GH721198@horms.kernel.org>
 <38d05790-eb4a-482a-89ec-8c17cf2e9680@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38d05790-eb4a-482a-89ec-8c17cf2e9680@altera.com>

On Thu, Jul 17, 2025 at 11:50:06AM +0530, G Thomas, Rohan wrote:
> Hi Simon,
> 
> On 7/16/2025 1:52 PM, Simon Horman wrote:
> > On Tue, Jul 15, 2025 at 07:14:21PM +0530, G Thomas, Rohan wrote:
> > > Hi Simon,
> > > 
> > > Thanks for reviewing the patch.
> > > 
> > > On 7/14/2025 7:10 PM, Simon Horman wrote:
> > > > On Mon, Jul 14, 2025 at 03:59:19PM +0800, Rohan G Thomas via B4 Relay wrote:
> > > > > From: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > > > 
> > > > > Currently, in the AF_XDP transmit paths, the CIC bit of
> > > > > TX Desc3 is set for all packets. Setting this bit for
> > > > > packets transmitting through queues that don't support
> > > > > checksum offloading causes the TX DMA to get stuck after
> > > > > transmitting some packets. This patch ensures the CIC bit
> > > > > of TX Desc3 is set only if the TX queue supports checksum
> > > > > offloading.
> > > > > 
> > > > > Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > > > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > > > 
> > > > Hi Rohan,
> > > > 
> > > > I notice that stmmac_xmit() handles a few other cases where
> > > > checksum offload should not be requested via stmmac_prepare_tx_desc:
> > > > 
> > > >           csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
> > > >           /* DWMAC IPs can be synthesized to support tx coe only for a few tx
> > > >            * queues. In that case, checksum offloading for those queues that don't
> > > >            * support tx coe needs to fallback to software checksum calculation.
> > > >            *
> > > >            * Packets that won't trigger the COE e.g. most DSA-tagged packets will
> > > >            * also have to be checksummed in software.
> > > >            */
> > > >           if (csum_insertion &&
> > > >               (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
> > > >                !stmmac_has_ip_ethertype(skb))) {
> > > >                   if (unlikely(skb_checksum_help(skb)))
> > > >                           goto dma_map_err;
> > > >                   csum_insertion = !csum_insertion;
> > > >           }
> > > > 
> > > > Do we need to care about them in stmmac_xdp_xmit_zc()
> > > > and stmmac_xdp_xmit_xdpf() too?
> > > 
> > > This patch only addresses avoiding the TX DMA hang by ensuring the CIC
> > > bit is only set when the queue supports checksum offload. For DSA tagged
> > > packets checksum offloading is not supported by the DWMAC IPs but no TX
> > > DMA hang. AFAIK, currently AF_XDP paths don't have equivalent handling
> > > like skb_checksum_help(), since they operate on xdp buffers. So this
> > > patch doesn't attempt to implement a sw fallback but just avoids DMA
> > > stall.
> > 
> > Ok, fair enough.
> > 
> > As per Andrew's advice elsewhere in this thread.
> > This patch also looks like it should be a fix for net,
> > and should have a Fixes tag.
> 
> Thanks for your comments.
> 
> You're right—this patch is a fix for the TX DMA hang issue caused by
> setting the CIC bit on queues that don't support checksum offload. But
> I couldn’t pinpoint a specific commit that introduced this behavior in
> the AF_XDP path. Initially, there was no support for DWMAC IPs with COE
> enabled only on specific queues, even though there can be IPs with such
> configuration. Commit 8452a05b2c63 ("net: stmmac: Tx coe sw fallback")
> added software fallback support for the AF_PACKET path. But the AF_XDP
> path has always enabled COE unconditionally even before that. So, do you
> think referencing the commit 8452a05b2c63 in the Fixes tag is
> appropriate and sufficient?

Hi Rohan,

Perhaps I'm missing the point, but my thinking is as follows:

As this patch only addresses the AF_XDP path I think we can take the
approach of asking "in which patch would a user of AF_XDP with this stmmac
observe this bug". (Or some variant thereof.) And I think the answer to
that question is the patch that added AF_XDP support to stmmac driver.

So I think we can use:

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")

