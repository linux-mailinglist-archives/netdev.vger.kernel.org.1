Return-Path: <netdev+bounces-195688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF7AD1E2F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FE316B7CD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADCB2571BF;
	Mon,  9 Jun 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="DPpGuOqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JtfotKuq"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5960DCF;
	Mon,  9 Jun 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473705; cv=none; b=oAdHQvfQryjYzhiyPrpjMBLrjmYab07X9YJI9iW7PX12JB5z2iN7b/o3gdY7zbcE8qJVw3deoqxoZC7mH/b3NoXsvxS2PB3zOFN0ynFSm+DIRxPaHY8tWW1Ar4eQoX8PpR9fkICWZjvtaEqzGnwJ/pm++Vh5xqWAGosFu2BXf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473705; c=relaxed/simple;
	bh=bPYp6XMwLg16+zGYigllyk/wrSQ6mKM5RJaOYTMv97o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWqeAC66Scmn2lJBPPGM5xV26FN+tZA3aSAlVTijSu91GLEhMu0JO2K1iOCES1GY5LKVzrtuoQgF48WHisUXCBAV6bEDxTQVySFhsMPKSIw/GnShhbEpO68V6QGErAdjf6qgMDBRHWyj9NLnowXMYiH22hl4NDlVqxFrdbVjstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; spf=pass smtp.mailfrom=stwcx.xyz; dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b=DPpGuOqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JtfotKuq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DE29E13804E7;
	Mon,  9 Jun 2025 08:55:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 09 Jun 2025 08:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749473701; x=1749560101; bh=S729HnA4jb
	8m0hmjvYJPSqMiZdCif/ewwBRO+2NkvbY=; b=DPpGuOqMlauZQBLd+MjT/JPZ/B
	Yr3eDoGN8XbBIuaz2SHdvFtx9gLpKcVXMx8o9QlbE/wdoGYzQ61lDlypChtjquuc
	+k+LV9z/XFZ7sW72H3ZGG9BtyKVoeGeXZVfdycr5EIWdliPqX8gTvybtJnB9A3Za
	lu3otp8RlA6bgcPntieOjBEe+InAIbhFkkMcCsqOpYZzLdH3iILeVVTMIJgBXRF3
	+u9owm12AMEi7Pli6NYv8Tg0YDvXpoxxWqbCSXvCJaCVyAhJr+sc0yAKV1oHka4A
	I5b8Mnkt7dwk0jxa06+GOVRZCQ9DAfQJoCn2rljNq3qf2RQnR5ICgTWWLOxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749473701; x=1749560101; bh=S729HnA4jb8m0hmjvYJPSqMiZdCif/ewwBR
	O+2NkvbY=; b=JtfotKuqk99TQrFRR2ysmZRs70V2RYgzRvfPFYWPYffuN9zfiqj
	XXsRvuokpFRIyLiqv/L19551Y15bvgNWDX1eA82BDvvG99T+g8FBFZWcVzlXmt3O
	g4i9zvT9U+08x+TSVgKAume61u9stIjAU4UgK2+yX6e89Hd7KHLrCnwCiB0kNwCt
	32IxnvO8ARe4JfiB1SMZYO0uSFOm5BynyBIQdHdv2PyK4VWQFDX84+x6FfuqqNmu
	MTFT3GV+3reKgxkcau8l0Dhbqb0+1xZ4WAv2IA8v5cfeA7z5b0gFqDWZiE5nOGFo
	2F6fyDIodpnPB/nbYwYpb18eRM8IeRuMm9g==
X-ME-Sender: <xms:pNlGaGn1e142nL6resnxnUPHgykxj9UgbItyTljzDlQjarP3MZbGrw>
    <xme:pNlGaN3vBSxrnNkfyAYXwk_w0b-HyxwKSJMPeavaLIn3MW4ezZvAWddPjMC16OLC-
    tyGRBluK8Kg5d1fMq0>
X-ME-Received: <xmr:pNlGaEoHJNECDj5khn57rk2VcDhikVcF8bVzmtiDSrS25F5Ld_n-G93pf1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmsh
    cuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeej
    heeftdejiedvfeekffehledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehs
    thiftgigrdighiiipdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhhksegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphht
    thhopehmrghtthestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhho
    rhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopehpvghtvghrhihinhdrohhpvghnsghmtgesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:pNlGaKkC_5O5FGh9HhDqi7d-5JqQtnSxp0m9tglXPz7whDEsJyUnlA>
    <xmx:pNlGaE28B17l_1VAJVePMJyrg3yTM2GilmPv9IVBcy7gUgv3gdP31w>
    <xmx:pNlGaBv3WtowVLYuyq3NRRvTJ1F2-MQXUWyTavAX7-uzh13WgrvoSg>
    <xmx:pNlGaAUKP1xjLqEl0sPcE7Ma7ChyZeR7jd2NpXLWmBdARshcXDUM_w>
    <xmx:pdlGaE-SZbrM-oeNAhjaaywkPSoJy0bUWZGegLqGuef-SU3NA5pK5yv_>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 08:55:00 -0400 (EDT)
Date: Mon, 9 Jun 2025 08:54:59 -0400
From: Patrick Williams <patrick@stwcx.xyz>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mctp: fix infinite data from mctp_dump_addrinfo
Message-ID: <aEbZoxqFBnd0Pr32@heinlein>
References: <20250606111117.3892625-1-patrick@stwcx.xyz>
 <0ee86d6d80c08f6dce6422503b247a253fa75874.camel@codeconstruct.com.au>
 <575fa12e699f6f65b47f5b776ec91ef9c350644a.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5DQEcKQFOqy03Isn"
Content-Disposition: inline
In-Reply-To: <575fa12e699f6f65b47f5b776ec91ef9c350644a.camel@codeconstruct.com.au>


--5DQEcKQFOqy03Isn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 03:47:09PM +0800, Jeremy Kerr wrote:
> Hi Patrick,
>=20
> [+CC Andrew, for openbmc kernel reasons]
>=20
> > So, it seems like there's something more subtle happening here - or I
> > have misunderstood something about the fix (I'm unsure of the
> > reference to xa_for_each_start; for_each_netdev_dump only calls xa_star=
t?).
>=20
> Ah! Are you on the openbmc 6.6 backport perhaps?
>=20
> It look the xa_for_each_start()-implementation of netdev_for_each_dump()
> would not be compatible with a direct backport of 2d20773aec14 ("mctp: no
> longer rely on net->dev_index_head[]").
>=20
> This was the update for the for_each_netdev_dump() macro:
>=20
> commit f22b4b55edb507a2b30981e133b66b642be4d13f
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Thu Jun 13 14:33:16 2024 -0700
>=20
>     net: make for_each_netdev_dump() a little more bug-proof
>    =20
>     I find the behavior of xa_for_each_start() slightly counter-intuitive.
>     It doesn't end the iteration by making the index point after the last
>     element. IOW calling xa_for_each_start() again after it "finished"
>     will run the body of the loop for the last valid element, instead
>     of doing nothing.
>=20
> ... which sounds like what's happening here.

Ah, yep.  That's exactly what is going on here.  I guess this change
isn't needed for master and it looks like you've already requested a
revert for 6.6?

--=20
Patrick Williams

--5DQEcKQFOqy03Isn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmhG2aIACgkQqwNHzC0A
wRmUTA/9FdHgKfnG+gFQo6DCG9mHLf0yPDJrTBdo/7jBgeLqBgGieTVqP9XW77Gm
tZJqLaj14dZgQoGIXpVgcNp/0vb5V+WxwM1iKoguhr1IgJRgBnGUh84sB3g4y058
3NjAUF1mUt54nMnqS7dcy3bV9fb/Jz3d8oouOx50jSNynj79ufykNbB3RTinScTU
BuFtsD1W9S1OOEJ6VvuO5NgUee83m2zpx13qHiou+JBkn8VStXbRPDs5gWVXKXbL
QVzjOM0TTJ3WayWxPeS/G6bvV+3aDwBgllHOP0BY8v7D6YY6g2di/kyH4mknv4WR
tScONFlI/PbViokMq0uriVPl28aQcA3dUEuXke9SPeNEcaTn9CWHs0LKMiN/VbFV
rl2cWfUdND+PO8oe8nFat6+RfNTwHuJK9QIEY8gRtfK6A/38XimbfIuaYJwXaJBS
ytw89/ojbQsK9xklkxIBeIBpI/uQ/fSfZwNomNCoDxGqcc8LpU/fN+c9CLAP6ZBC
Qs52Cd4Q2yXObbvSb5JrtWZ+kdCyQ0Ancw/rKYYIsWMd8iP013TCrLs0gT3ANIc/
Vq0SclVZ66iBOL9cCswVBNgOpTo+TbbPUIuPE7Z3FPy3kqXIhVnMz0JjGREuglo+
KNNIBwXA4wuO5Kzy2i3XP5FxsaZh+eyRsuE270td1RjFjjrRI4o=
=Qp9/
-----END PGP SIGNATURE-----

--5DQEcKQFOqy03Isn--

