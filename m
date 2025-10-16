Return-Path: <netdev+bounces-229947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F4BE270D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 107D8501E6A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11D32A3C1;
	Thu, 16 Oct 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="GNB6Z2in";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AI79jTS8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72B324B25;
	Thu, 16 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607234; cv=none; b=I/9yjPTZ5+40sBcQIAMc4R/oPVUGDBTKhai3HO/uqntxWwmmgRqn+1m0zzriqySvBhuj/WS/LL37nXFK/vlbCe0srevw+YnW20YyvZVhB1l6Q6DMbkzyIZOUXdr9NzRZUQfZQVR/K5oxKqelrD2M7sEdItel0YUWabKYdUk9PQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607234; c=relaxed/simple;
	bh=uNbN9TRSDsOqkVANM3w7ZLCcBXSqXKUui5X70JcRE8I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mwSG9KgOAsNWXQo+kqJF0DxyEkvnAzR2qB2Mp/edU6YjjH6MTT5UkoQ/zuHdjjG88H0ILXA1M4lTjfIpsFu6/vyhWHCz9k4PyRwRDFoKKXzCxd5GwqoUKj8GUxYPYPpzgMyD1fOJEFVx9MN3gustgDRF43mKZosiYwbdbub8vMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=GNB6Z2in; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AI79jTS8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EDAB14000B4;
	Thu, 16 Oct 2025 05:33:49 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 05:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760607229; x=1760693629; bh=HKIIP7EMa3kiCvEdSloRcVMbxBGUsM0L
	jZHG22p7+5s=; b=GNB6Z2inBvCzWxDteewxYt06bg4h2IAodNA+MggooFmUvljl
	44mmI2SUWp6W8xBqy5v7wfx7X49yMxC0Vap2m7o3d+Ujm5HSwimRGqFSRFR9wW2S
	8/Z/PbxOw92cKkO/zyEK9oYGncpJFraPqo7P4+FkBcc9zcBmsS9vyHnZcnLrONWr
	wVoBkt62EfPkfjD5tWTB1VKINCZmoXkujheTYYJlDCSAVXP6unnwpA/ratNU62Qf
	2ZPVzhF+HqxNil0nhlI12+h+5Q42eP0VObueCrrAaOVm3+zUQK79qbPBnurzEVSs
	HAVkBhakhZw+D5Vh1PNQZb6edB2hj1JBtkTyTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760607229; x=
	1760693629; bh=HKIIP7EMa3kiCvEdSloRcVMbxBGUsM0LjZHG22p7+5s=; b=A
	I79jTS89kqLtqQbv9J6qEpY3McgAC7NkEVgzUW+eRV84lEUuR1ZM5i1HC3tEM61G
	tAfC+1rhlvCBK8b7892/ICXEN/u1UFBvceD47YJKUH84Bl3QbEOscT+MYRlMBilM
	Jg/4rb2768lC9JhrIZf2apjc13I6cp81nBnxnKctGn8aPNvyeo1QRjROnNgWB22c
	9IdmcJ5OKuXYqnWaH7ZcazzhkyJlic0pf15GbLkQUjSmMTVcmKyvjBwK7sfUqLXV
	aguWXsR+nbnyMS3WBkQ7wi/Sn3oGexsjYOYJK5L5GufE+Rtbko7tf2JUoDdIMdxS
	lSczRAAkFspL1FOHB29Lw==
X-ME-Sender: <xms:_LvwaHuX0Gi0fWP0GPJ3CH3JkaegiJ_aIYW89ld5NAQZQ_rotuBiIA>
    <xme:_LvwaDTV2zPLT7VaYiDHioSDWJq4WULFECQu1XuJ8T75GvDk9NaqwiMrj9j3J8tcb
    iJ0RdtlFpiC1T7VWi-tCWkkXk--Nd0hDREp-tY3eE3Vt8bN_0J_60I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrthhh
    vgifucfotgeurhhiuggvfdcuoehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruheqne
    cuggftrfgrthhtvghrnhepvdeitdeufeffheeltddutddtuddugfdtveffffekvdffvdfh
    gfejuedtgeeluddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghupdhnsggprhgtphhtthho
    peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehiohgrnhgrrdgtihhorhhn
    vghisehngihprdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_LvwaLNf_YQT1Tb90jrjQgOqF0S_W0diemqevOrpv9gVUCf6cH05Pw>
    <xmx:_LvwaB-PmJekHfN-yFVaRAFlLkFcRn_qa2a7DAKf6Uo1-ignwpK6Gg>
    <xmx:_LvwaMca4vFcQTmztkQ_ptLGadunuZUGhkhTg4Ot7bE98G0sshKB2w>
    <xmx:_LvwaAwRfJUqULkd5WfWHplduMxWh-7yGNNjAynsl2OXTYa6kxE5UA>
    <xmx:_bvwaCr-aG5YcPj6hb-UMmf69lLIBr3Bfwpc_fGDgbkvawhcdotvR_aX>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B08C415C0053; Thu, 16 Oct 2025 05:33:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_WGycAshL9F
Date: Thu, 16 Oct 2025 20:33:27 +1100
From: "Mathew McBride" <matt@traverse.com.au>
To: "Ioana Ciornei" <ioana.ciornei@nxp.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <9beeb68d-2973-4d40-b48b-ee9cc984b9db@app.fastmail.com>
In-Reply-To: 
 <xl3227oc7kfa6swgaxoew7g2jzgy2ksgnpqo4qvz2nzbuludnh@ti6h25vfp4ft>
References: <20251015-fix-dpaa2-vhost-net-v1-1-26ea2d33e5c3@traverse.com.au>
 <xl3227oc7kfa6swgaxoew7g2jzgy2ksgnpqo4qvz2nzbuludnh@ti6h25vfp4ft>
Subject: Re: [PATCH] dpaa2-eth: treat skb with exact headroom as scatter/gather frames
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 15, 2025, at 9:18 PM, Ioana Ciornei wrote:
> On Wed, Oct 15, 2025 at 03:01:24PM +1100, Mathew McBride wrote:
[snip]
> Hi Mathew,
> 
> First of all, sorry for missing your initial message.
> 
No problem. I had a revert patch in my tree and mostly forgot about the problem until a customer of ours reminded me recently. The S/G "solution" looked easy enough to try.

> While I was trying to understand how the 'aligned_start >= skb->head'
> check ends up failing while you have the necessary 128bytes of headroom,
> I think I discovered that this is not some kind of off-by-one issue.
> 
> The below snippet is from your original message.
> fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd alignment issue, aligned_start=ffff008002e09140 skb->head=ffff008002e09180
> fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd data=ffff008002e09200
> fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd is cloned=0
> dpaa2_eth_build_single_fdskb len=150 headroom=128 headlen=150 tailroom=42
> 
> If my understanding is correct skb->data=ffff008002e09200.
> Following the dpaa2_eth_build_single_fd() logic, this means that
> buffer_start = 0xffff008002e09200 - 0x80
> buffer_start = 0xFFFF008002E09180
> 
> Now buffer_start is already pointing to the start of the skb's memory
> and I don't think the extra 'buffer_start - DPAA2_ETH_TX_BUF_ALIGN'
> adjustment is correct.
> 
> What I think happened is that I did not take into consideration that by
> adding the DPAA2_ETH_TX_BUF_ALIGN inside the dpaa2_eth_needed_headroom()
> function I also need to remove it from the manual adjustment.
> 
> Could you please try with the following diff and let me know how it does
> in your setup?
> 

It looks good to me! I've tested across two different kernel series (6.6 and 6.18) with two different host userlands (Debian and OpenWrt). Both VM (vhost-net) and normal system traffic are OK.

Many thanks,
Matt

> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> @@ -1077,7 +1077,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
>         dma_addr_t addr;
> 
>         buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
> -       aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
> +       aligned_start = PTR_ALIGN(buffer_start,
>                                   DPAA2_ETH_TX_BUF_ALIGN);
>         if (aligned_start >= skb->head)
>                 buffer_start = aligned_start;
> 
> Ioana
> 

