Return-Path: <netdev+bounces-55682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868CF80BF74
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFACEB20851
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C815AC7;
	Mon, 11 Dec 2023 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="KDltS9Sc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2/JLh+Kl"
X-Original-To: netdev@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629EF1FE8;
	Sun, 10 Dec 2023 18:51:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 0DB723200A9D;
	Sun, 10 Dec 2023 21:50:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Dec 2023 21:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1702263058; x=1702349458; bh=4J
	cWAGFDAKqU0mXy71u7gfYt92DBUCLVc/XBkrUumIY=; b=KDltS9ScE28iWnXFTe
	ybWLpPM5SNGL1hKC3iFLgi4DGgPmzez4toJ7OzOxoetvY1O5TJJLXLQ626mJZDNP
	+2PVp9UbADk8jzX41Z/y5AxH+G5lj4qaUecXJxbo2Gh3UXN1OiylX0AVDIkA3S/N
	wydlgo73UbFcnvvFfTQqr1UWZklZdyj+6Cqck3MFI/TJJ0u0OiFXGc9ke9v9PONq
	7vjp7SgpiCrCuW/7UUYRP2rWACoG/YNV/Gw8g+D4M4NrNCXmXk+FScsw4seroNof
	1SRJa2OLDSTV0cdEJbuuRF/qnYwAMWIKDGVXL0hBUan/Ftuak9MzTaSGf1W945dI
	5AyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702263058; x=1702349458; bh=4JcWAGFDAKqU0
	mXy71u7gfYt92DBUCLVc/XBkrUumIY=; b=2/JLh+Kl9NVINPXq99u/g7xozl+y6
	ns4zJpIPDx7EPWdOL24RYzBJxS5RgiPFgxNPYSgMB1sgL2ooPV1/ByP8MbuslhN1
	xC90YXnTcUz88isHTmm6nznXLzaI5OTL00ZR+fQjqHFfZ3s622vdVyWrCFUTCOwe
	T70A2SfDjwKC4ARgEdhI4qcFp20n1SiWWmNOmi9JKlSjFU+ihtf08odUcNRCKr91
	ALVADD0TAle9BYTcrlLp9rwM3Og64DLiWSnhh7YFvqSVpEZ/iwstw9+UKVzhQ+wY
	zgxjij66HG/K5+peBjiShENXypMjSAnMfH2r40kBQqIiSo0Ciw0cgizLg==
X-ME-Sender: <xms:Enl2ZZ-guBsx3FebNJixt9YSkFIbwssNqnVCm0IUZzYC0PGeL6UGwQ>
    <xme:Enl2ZdtZdeq0-3H-VrPb4eQ2qDGIkJWNgBC4LcR-9CnFxYl8FiovBWCkAfNtBe9E4
    MV1PTJccHFFwc7ONag>
X-ME-Received: <xmr:Enl2ZXBc9vn8rXvaDZmt1Y_Zna_6X2UOkfc7OIwacvpwGJlW86utDiVZ8vw4PGqhOasWnsUYoxaxh7r0pSdOv371Z5BQdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeehfeejheeftdejiedvfeekffehledukeduleelffekgfdtleduledvtdegtdehkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrh
    hitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:Enl2ZddnFWEtlkdUchpd_LhaZLfvFstGsYtlS__Zfi0jdoNC9mpJ3Q>
    <xmx:Enl2ZeMk4PmFi5xsqngbgl8_-ol2ZtavQcMDAiG5jn-iVs2ga-0CpQ>
    <xmx:Enl2ZflCviGy2JFRWnVjz0_x0-_3NdtvF8xhv8Go6kw-2UW7RXsZww>
    <xmx:Enl2ZdcQJTz8R22Q8VWEOFNrywA377FsFj1U05_cESBtm1Vm4mQ7xQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 21:50:57 -0500 (EST)
Date: Sun, 10 Dec 2023 20:50:56 -0600
From: Patrick Williams <patrick@stwcx.xyz>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, peter@pjd.dev, sam@mendozajonas.com
Subject: Re: [PATCH net-next v2 3/3] net/ncsi: Add NC-SI 1.2 Get MC MAC
 Address command
Message-ID: <ZXZ5EOSJAekCiT44@heinlein.vulture-banana.ts.net>
References: <20231114160737.3209218-4-patrick@stwcx.xyz>
 <20231210215356.4154-1-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+15r0ml6tBo+jei6"
Content-Disposition: inline
In-Reply-To: <20231210215356.4154-1-fr0st61te@gmail.com>


--+15r0ml6tBo+jei6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:53:56AM +0300, Ivan Mikhaylov wrote:
>=20
> seems very similar to ncsi_rsp_handler_oem_gma except address_count, why =
it
> shouldn't be part of this call with additional param? What's inside it ju=
st
> code duplicity of ncsi_rsp_handler_oem_gma.
>=20
> And as we talked in openbmc mailing list, ndo_set_mac_address do not noti=
fy
> network layer about mac change and this fixed part already in
> ncsi_rsp_handler_oem_gma with 790071347a0a1a89e618eedcd51c687ea783aeb3 .
>=20
> David, any actions should be needed about fixing it in net-next? Need it =
to
> put patch above with fix or do the revert from net-next and make it right?

I agree that both of your recommendations might make the code better,
but I don't see why we would need to revert it.  The code does the
intended function for many use cases, even if you've identified a few
where calling `dev_set_mac_address` would be better.

Either you or I can send a "Fixes: " on this commit to improve the
handling as you're proposing.  While the change is likely trivial, I
have not had any chance to test it yet, so I've not sent it up myself.
If you want to refactor the code to reduce duplication, I think that should
be an entirely separate proposal.

--=20
Patrick Williams

--+15r0ml6tBo+jei6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmV2eQ8ACgkQqwNHzC0A
wRmp3A/+NnxL8+c3M1OsmMuJUdi5Fe2npPOc/1Xl5ZNPQQ7JrAb4bOjLNcWpUD9b
Z3R2rEzRHNoWQvI4f2T34Sx/z2/Pelmvii9P85YkubOfl6tq+YXY5sDDomjtZmnI
CTQmO8QU8AB7tVS+4t3ElcRE/hKmKzpZNcTFk7mOFXOphO6jpNiVphqHsJoLv9pL
VaPuRdyKoEfRjjAF05wkjnFW95SyyNnwd4GpxCX1gaem44mLXtISPy8TxI9W8XFU
EVVW+MItPTNtpm8daHgBN7dojAZjlD8To9hcrLCYq0jOHuPD2XZT2yIiPYba4rpx
Ee/hR3u32P0NYqbku8L7eut7JXD0ThjPvvZaUUd72vI2HjkTG0Wep08kUxbokD7+
iU2E7SOhT7PxpceUcTpuGVYDFPfcr0JtET7b4fxl41XVQiXHP33RqYipIVNX3w/1
ZS5aSoflE5a8YRMSXUtq69cMbJgcHvjzlxHKZt1boL7l3rWBgeEWX+dXWrO3rVmX
IUh7cxQJQIey30+8Ld1E28mhomykNGwb+zajV5fZhEO2MANi5mOn+QXGgzAi+bTX
Fl4Awrg2B6uO+F5SDGGhv11rtKPUMZBVABEsitvI0cCTGbfEkNdaRqOxG3w0WR9f
65KwbXs0uMKSsIz2THSXnQ/kww2jOfJtNfCAVwl+OP5PZWBMks0=
=Fw1V
-----END PGP SIGNATURE-----

--+15r0ml6tBo+jei6--

