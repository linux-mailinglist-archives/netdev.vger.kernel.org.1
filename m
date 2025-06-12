Return-Path: <netdev+bounces-197214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B7AD7CDE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E47A3A2F92
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589A2D6624;
	Thu, 12 Jun 2025 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyG4M7IK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F21EDA2F
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762155; cv=none; b=Wa77OeNC8xPIsD9wPMkdDCp/X3m+wNdsNXfRpcFuMimzmXrbsse2hJ6g7E9ykYGhuViGQRMrYQcnWtgfLW7hzMjBZ26Ytt1aGoxkDIMxqhcC/0cwvGgjruujBBqEUFZRmiQ0OOMr+rlhiefOQ7W9s6dz5QbhFvGYY42MeEv4a2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762155; c=relaxed/simple;
	bh=iM6BZQQJgZKEbKntENWh02GdDa6BeA3Rk/HIeclWu4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2yeBGb0Keq0DnH6aRuEreNIPepWuH4INvxUvw9ga7YnKX2GCpTmSlrDVC1PdEDFNszBZeszScK6NnEH5CDtccqON5GVegQ7g6bzzMl6BsCfnR0uk5/lriWOuA9r1S2v8tM//8O+7JudnYXZu/ZHjfGUxo9OAB1OKX3A0gGoqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyG4M7IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCFAC4CEED;
	Thu, 12 Jun 2025 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749762154;
	bh=iM6BZQQJgZKEbKntENWh02GdDa6BeA3Rk/HIeclWu4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyG4M7IKfyuY1vGOCTJ35Eh/uzrXm5jbPS4/MNGAKwJKUhdHIriMznC/dl3cEQPG0
	 +Q3BSi+TNZzYl96Iug6RnmWrUm0DwrFv0KjbyOQ3zVwnSo+NAe2WVrLFgBb3ThYoF4
	 euNbam8IN/YVcuzn6rG/n2HCCLVc5bFMYYdy9A9oSbHgxheidJDqa5jZyefvTqwjsS
	 oJL9VJsStkDLqvAljjIJu1AyZoi5/764x44DYq+lyAALoRG5A5pXBRLU4/cAmqfNVT
	 Qhk9hhJG/HaTy/NWKCh8wzmMMOWxBV6yy2NL+qXnzWQg2Dqxwr50gxeW0MmkF/DQr5
	 XLAZdqQunH3lQ==
Date: Thu, 12 Jun 2025 23:02:30 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <aEtAZq8Th7nOdakk@lore-rh-laptop>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
 <CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
 <aEg1lvstEFgiZST1@lore-rh-laptop>
 <20250611173626.54f2cf58@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GWlYu+qUx6A6DKw3"
Content-Disposition: inline
In-Reply-To: <20250611173626.54f2cf58@kernel.org>


--GWlYu+qUx6A6DKw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 10 Jun 2025 15:39:34 +0200 Lorenzo Bianconi wrote:
> > > Tell us more... It seems small LRO packets will consume a lot of
> > > space, incurring a small skb->len/skb->truesize ratio, and bad TCP WAN
> > > performance. =20
> >=20
> > I think the main idea is forward to hw LRO queues (queues 24-31 in this
> > case) just specific protocols with mostly big packets but I completely
> > agree we have an issue for small packets. One possible approach would be
> > to define a threshold (e.g. 256B) and allocate a buffer or page from the
> > page allocator for small packets (something similar to what mt7601u dri=
ver
> > is doing[0]).  What do you think?
>=20
> I'm not Eric but FWIW 256B is not going to help much. It's best to keep
> the len / truesize ratio above 50%, so with 32k buffers we're talking
> about copying multiple frames.

Hi Jakub,

what I mean here is reallocate the skb if the true size is small (e.g. below
256B) in order to avoid consuming the high order page from the page_pool. M=
aybe
we can avoid it if reducing the page order to 2 for LRO queues provide
comparable results.

>=20
> > > And order-5 pages are unlikely to be available in the long run anyway=
=2E =20
> >=20
> > I agree. I guess we can reduce the order to ~ 2 (something similar to
> > mtk_eth_soc hw LRO implementation [1]).
>=20
> Would be good to test. SW GRO can "re-GRO" the partially coalesced
> packets, so it's going to be diminishing returns.

ack, I will do.

>=20
> > > LRO support would only make sense if the NIC is able to use multiple
> > > order-0 pages to store the payload. =20
> >=20
> > The hw supports splitting big packets over multiple order-0 pages if we
> > increase the MTU over one page size, but according to my understanding
> > hw LRO requires contiguous memory to work.
>=20
> Hm, you're already passing buffers smaller than normal TSO so
> presumably having a smaller buffers will break the sessions more=20
> often but still work?

I will test it.

>=20
> You mean want to steal some of the code from:
> https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/

ack, I will take a look.

> and make the buffer size user-configurable. But not a requirement.
> Let's at least get some understanding of the perf benefit of=20
> 32k vs 16k or 8k

ack, I will do.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--GWlYu+qUx6A6DKw3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaEtAYwAKCRA6cBh0uS2t
rMGGAQD8IPe8MoY4V366zinNUIPPKyB070wrYzfX9tsT+tHyoQD/T1CmJhx+pqlk
cSGShFOwx4/ZNLd0ZWvClZvmVC7ptwA=
=Ir7x
-----END PGP SIGNATURE-----

--GWlYu+qUx6A6DKw3--

