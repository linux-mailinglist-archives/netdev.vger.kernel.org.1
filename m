Return-Path: <netdev+bounces-221577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6CB5108B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26803188BFFF
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825FB3101D2;
	Wed, 10 Sep 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="h/1Yi5gi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2CHyEMs"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699043101BD
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491481; cv=none; b=HAAlskDNiaJTh8euAEiljWoiffN6kyrk+2L1aWv/iF7zYqu0WsvbUJ2MvVECmBkJC5A0v72tYHlyRI6b2P/sE3RHm+mMK2nORs3pmmKXn7Ux+2bIiq6htAM386np1wesYvLfW7w6kPcwSEwgw/W0nlMrorwGUoWjx5m1x36uA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491481; c=relaxed/simple;
	bh=SzS6s0TiVK8P0u+1VgtJ0YGJaCwrnr/RS29JY2Jxwb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnsbzqMP4F1sizd4AB8Q+j5yzSJ8C3fWS2SGaJirqlR1vwyO3pkSYRhMoICU34sOmRlrcn9YHxX0Y5SvaCSVJn7dSQ+dKhHvx3ZFq6qM78UqclcB3v+kTmzxyD0i7dSk0dbgcqTSJHm2UWdALBTGEbl00qickTkKYOkheZU8MJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=h/1Yi5gi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2CHyEMs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4400D7A015A;
	Wed, 10 Sep 2025 04:04:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 04:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757491477; x=
	1757577877; bh=KPqIKASzb3R90pIcczJi8m7zL8fcliR4BZNaV0KFaww=; b=h
	/1Yi5gilwyPV7urQwUv0PXFT0D1KAiT1u3J6mupdtkRyp5engeCOSP0i4Bk+nbtV
	CDHtw+hb0PN6TropMLL0Q31rU42p1jm/eK0rVRTkxxLWascG3tg8N70mt3hAA3wF
	Lc6FWyjx5Oc/0BE6zN+XLr77LBP7ghFt2kVTsSHsS8RpvgKqH5SLuR1RqWHYYgbm
	WPowJ8vlGmIHCfgjMWvhivhk9pAhBeT1ugPkpC78Uv15UDRlmejZTHFmmsA5fJKU
	N+EnAxuZF+0GoYLF5G5Ng1L7aV4xq5tr8oFoQZcOwZdXKskYbAOiBZAuUPu9G2iq
	P8apQnJL0XQ4ipk+PzIHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757491477; x=1757577877; bh=KPqIKASzb3R90pIcczJi8m7zL8fcliR4BZN
	aV0KFaww=; b=a2CHyEMs0decW8g29xwcPsodY52Yob119TCPFmehJOPDBOaYoNk
	WQFt31l38slg82n7xE5dWgMhGaA2H/Qqfx3QFT5vbT1RbBZy7iz4L8Avlt3QIH42
	xqi6kEB4huOOAeLRkO+WS4z5znIYM08JQLq+1WBx98wMFpZ9K9maWosi4YKkFBvD
	muzpM32TPfvHH3IkLC6oII7xSu8OAwnBktkjH1cW4q4EZyq3JMURto3dtOrXKPkC
	xhklAy6GCrHxLjrgkKLpcnoTag/iKpvh3zA/H5vPaHwz7S5aAWvC4uyuyN/gbbJ8
	0Y+eDOrWwZVVfPbcVY2Owl/z/raw7BbSn/Q==
X-ME-Sender: <xms:FDHBaHvDTSwvdDOJT82AC-IeJj8YVqLM5GQ5qcsOIflHFZSURIc2cw>
    <xme:FDHBaD9QMz3RnqVZw8VPpsDGqmGc4VTBDzAeb-4AESqMTHf05PzaxQd7W311IbaAx
    NZRV_CXHBOlQhqDW48>
X-ME-Received: <xmr:FDHBaBPvpkrgOZSY9UPOeBI5g2EF79tB9ZG1Kv4N35SmTkWPkyJ2wljTAVW->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeih
    rghnjhhunhdriihhuheslhhinhhugidruggvvhdprhgtphhtthhopehsthgvfhhfvghnrd
    hklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopeigmhhusehrvggu
    hhgrthdrtghomh
X-ME-Proxy: <xmx:FDHBaBGaeNhB6A30PsH5EOgDVNS2sOacguYKqmVz6zCgQISk5j1n3Q>
    <xmx:FDHBaPQ4bU_9-HNAOP3vkgkWnc9eS3Yb57yW0TQWcAgv3Yq0eKXWNQ>
    <xmx:FDHBaOu_1WGJ8OktgmvP4GYpgVv7TnhyXJsGThO0nFdVv1XW3-BO4w>
    <xmx:FDHBaHIahWB5gbuPBzigDzVJETCR-NmgGR8la5PChx5I7noszAHTCw>
    <xmx:FTHBaP5rbo6-B2ER7OkRpOkfTgkRNxMjAfHJXkkfuRQk__AW5mG2j29U>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:04:36 -0400 (EDT)
Date: Wed, 10 Sep 2025 10:04:34 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
Message-ID: <aMExEjj3I4ahnMHc@krikkit>
References: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
 <20250909092315.GC341237@unreal>
 <aMByADrbXBAXzIJr@krikkit>
 <20250910054550.GI341237@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910054550.GI341237@unreal>

2025-09-10, 08:45:50 +0300, Leon Romanovsky wrote:
> On Tue, Sep 09, 2025 at 08:29:20PM +0200, Sabrina Dubroca wrote:
> > 2025-09-09, 12:23:15 +0300, Leon Romanovsky wrote:
> > > On Mon, Aug 25, 2025 at 02:50:23PM +0200, Sabrina Dubroca wrote:
> > > > Xiumei reported a regression in IPsec offload tests over xfrmi, where
> > > > IPv6 over IPv4 tunnels are no longer offloaded after commit
> > > > cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> > > > implementation").
> > > 
> > > What does it mean "tunnels not offloaded"?
> > 
> > Offload is no longer performed for those tunnels, or for packets going
> > through those tunnels if we want to be pedantic.
> > 
> > > xdo_dev_offload_ok()
> > > participates in data path and influences packet processing itself,
> > > but not if tunnel offloaded or not.
> > 
> > If for you "tunnel is offloaded" means "xdo_dev_state_add is called",
> > then yes.
> 
> Yes, "offloaded" means that we created HW objects.

For me "offloaded" can mean either the xfrm state or the packets
depending on context, and I don't think there's a strict definition,
but whatever.

Xiumei reported a regression in IPsec offload tests over xfrmi, where
the traffic for IPv6 over IPv4 tunnels is processed in SW instead of
going through crypto offload, after commit [...].

It's getting too verbose IMO, but does that work for you?


For the subject, are you ok with the current one? It's hard to fit
more details into such a short space.

> > > Also what type of "offload" are you talking? Crypto or packet?
> > 
> > Crypto offload, but I don't think packet offload would behave
> > differently here.
> 
> It will, at least in the latest code, we have an extra check before
> passing packet to HW.
> 
>   765         if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
>   766                 if (!xfrm_dev_offload_ok(skb, x)) {
>   767                         XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
>   768                         kfree_skb(skb);
>   769                         return -EHOSTUNREACH;
>   770                 }

So it looks like packet offload is also affected. We get to
xfrm_dev_offload_ok, it does the wrong check, and the packets will get
dropped instead of being sent through SW crypto. Am I misreading this?


> > > > Commit cc18f482e8b6 added a generic version of existing checks
> > > > attempting to prevent packets with IPv4 options or IPv6 extension
> > > > headers from being sent to HW that doesn't support offloading such
> > > > packets. The check mistakenly uses x->props.family (the outer family)
> > > > to determine the inner packet's family and verify if
> > > > options/extensions are present.
> > > 
> > > This is how ALL implementations did, so I'm not agree with claimed Fixes
> > > tag (it it not important).
> > 
> > Well, prior to your commit, offload seemed to work on mlx5 as I
> > describe just after this.
> 
> It worked by chance, not by design :)

Sure.

[...]
> > > The latter is more correct, so it raises question against which
> > > in-kernel driver were these xfrmi tests performed?
> > 
> > mlx5
> 
> It is artifact.

Sorry, I'm not sure what you mean here.

[...]
> > > Will it work for transport mode too? We are taking this path both for
> > > tunnel and transport modes.
> > 
> > Yes, if you look at __xfrm_init_state, inner_mode will always be set
> > to whatever family is "inside".
> 
> I believe that you need to rephrase commit message around meaning of "offloaded"
> but the change looks ok to me.
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks. I'll send a v2 when we agree on the wording, to avoid
resending multiple times.

-- 
Sabrina

