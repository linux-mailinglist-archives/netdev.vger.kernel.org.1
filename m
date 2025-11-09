Return-Path: <netdev+bounces-237063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52584C44322
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 18:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B020A188C2AF
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8A2FFDC9;
	Sun,  9 Nov 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Qhd1vocq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvM1UJ89"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195413002DB
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707894; cv=none; b=PWZASl3x6I8fKQ29RCFmSof7eQbhan0AacmZkBtbB2A6Ax5rlhOOY6lt66I7j1LxBPLgP6SpzGpsq8ZLatfAH9d1LpXUVbBzIGDkE/VdV+j18lF8o1uhrzGRXtB9OkKm9tk4yy1R6mdY6tpD+WTS62kyCzbWYl85H5E8WKcFdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707894; c=relaxed/simple;
	bh=KisPtllEHK/H0ws6st20YaQiPYBOY0W+JoW+T6KxhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQBVJYyDxGWVMhJ+gmNUBvyk2lyt53KrhRri4+RFmNIF9thJbvQIDp+fZibS6846v6kshP1RDnxmjZUe5ATICRlW7rjbMQwFXGcFMEYGlkU6VJ/v1fJ77abomRUoOI58GrsbwqAAnme8auGktozspm1S5w+dHBfC/gdQovhava0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=Qhd1vocq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvM1UJ89; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FE451400186;
	Sun,  9 Nov 2025 12:04:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 09 Nov 2025 12:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762707890; x=1762794290; bh=9CRgYtIjiH
	H9mDR9Nco6TCvjT7WwV9QHDL5PFYPtnfQ=; b=Qhd1vocqYrjwNWmLc3WdbcsC07
	oeN9AUk4ltypSDRnZdbo5sOWGN7jkTzGw2IPYfCodG9S9nEbAM1sdyewnQ4VFAWH
	vAYjJe1SglT0J/4oHPClvgbplJm50Wodok0OexIDaNHbZewsnsDZmdOLKbp5u6C6
	yJ/xlB0KgtU1vcbmrSEnSAx0WasVqSjnDoYPKf7KLBtZGNhz/BJ4GuSl1/fBn1D7
	ZSp269bOZzxy99BHDmbZnPPFlAK+gDMpm9o53H7lsQnPQMAavJkBM//2RlRkRcxc
	LBcKwh8zpHQ+LRr0LmpKwkynsWGWNr9+R2D2jY9H9HJThIieqTONO6hUqwWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762707890; x=1762794290; bh=9CRgYtIjiHH9mDR9Nco6TCvjT7WwV9QHDL5
	PFYPtnfQ=; b=fvM1UJ89sMUKPSCVQb8cOYg5fWDUUdv1Sxdu3lKwxCY4RYXGWdL
	mNXrNKDo1t/xmlT+JSGRzFdf9ufUoFf3GtLChME28rF0vX0oYPwglQegtEAoNo46
	y4xObXMkgoGOp4s087KIpyaKvfq2BYhm/dylz4gouLRslU4FmE5PUlJMOAxWw7uK
	x4wM4KBu6EGBaDOSaTR4vPgBHM1C0erBSszBjPWge4GRFUJEIXZSj2QSgXS24wTz
	q0Qk7ist9/kjC3RX9+U+K6O0DXNFJCgzFoc8+FxBhB7pmySjx4rhGB63rHZrgpTW
	mWVTfEeqlCm79pZX13jkULGgKn6B0RgIgtA==
X-ME-Sender: <xms:sckQaUg5NbslTe-7FnTz_ODDi448kHepN9R1pzIUewSmo9gjR-yhRA>
    <xme:sckQadeGKvlKL40rtbPgonZc5aBZX9Ju04vpjSjQzdEqsXZjTj34Or9pOy7sznih3
    ig6l_3nC0X_s8fl_3kqYefZdH1e4vcNQIji173C4hnmo2DwREI2>
X-ME-Received: <xmr:sckQab0DWG0rJCN2evcIAW37ZpwRpS2AYSxqRUpRxR2NMUpq9faR3_4uXqG4539pb4IncU5nOTpLtCy_Hl_wmqv6SHZBdbOY54d_TW33>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnheptdejue
    etkeehfeeuleeugfevieffkefhteefiedvfeehuefhjeegvdeiffeihfeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
    drihhspdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhvghnghhqiheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeiguhgr
    nhiihhhuoheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvihhrth
    hurghlihiirghtihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegr
    nhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepvghpvghrvgiimh
    grsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:sckQaRo1o1D4P7Ca-hd0nYBRiByCi6NpkvfaIGAuBSBaidX0b833Dg>
    <xmx:sckQabgC1pGTXbbb3LcqV9HjLjzjdpXg3sxVwDOZdJJODaTLUOTZ1Q>
    <xmx:sckQadnX4yPPaCJjyoPmggE-BbzyJ1PxsCrvi9FMTF5GXzOo_MM6kA>
    <xmx:sckQaUplTTph2KbU5ByROPJFEggwRG41BF4xShSABf7xGkAQlLmnMQ>
    <xmx:sskQaeWtqFQeR38FLysPx8rHNRSf-GWOLW17CGFMIuppydc6zNFUiJ5O>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 12:04:48 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 82A92691A321; Sun, 09 Nov 2025 18:04:47 +0100 (CET)
Date: Sun, 9 Nov 2025 18:04:47 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 1/4] virtio-net: fix incorrect flags recording in
 big mode
Message-ID: <aoiyv6uhkup4fjjrbdplwulmhxivpdxfw5cisgxhdideiomjrd@7cu6uhkfqoxx>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4x6p5yr7pt2zzcg4"
Content-Disposition: inline
In-Reply-To: <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>


--4x6p5yr7pt2zzcg4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net v4 1/4] virtio-net: fix incorrect flags recording in
 big mode
MIME-Version: 1.0

On Wed, Oct 29, 2025 at 11:09:10AM +0800, Xuan Zhuo wrote:
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
>
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
>
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Fixes my networking with CSUM offload enabled in Cloud Hypervisor, thanks!

Tested-by: Alyssa Ross <hi@alyssa.is>

--4x6p5yr7pt2zzcg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaRDJrgAKCRBbRZGEIw/w
oqsaAQD50NHyep7KNpIOM8rPTkXTBAkvuIdnILhstAXwxyKGFwD8CFVC8o0MxRca
3TX4LsnC+ef6TXIhAznKqgvgYUoXaAY=
=BMsX
-----END PGP SIGNATURE-----

--4x6p5yr7pt2zzcg4--

