Return-Path: <netdev+bounces-234603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CEC23DF8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C5B1A631B1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25FE2FB63D;
	Fri, 31 Oct 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGbQVSCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E82F261F
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900138; cv=none; b=k4zybubQh1jK6I84N2PPva7hmNV2fZKB215MhxLgTBJ84cvaLsZqlbmHeCieh51qMFWI9db4VsDWOFasJPrCBMBFrfZqdtrBaHn/n64/LrACfPVp2PVjs9Nf/dY1VCBDrsFNWAqVF4CP62m2ZJo8eHk1NdTsmV6K9nyemgbwSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900138; c=relaxed/simple;
	bh=iebUdKZzmfa2jg23LRJHVuu3kza1F82z99YH30rDyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYIp2rqYj4iOFe2BmECTeV3AzK/GiUqmb1rLWAcQKT0ZiHHG0DM3dO/5uQrFAcVa3hxN6U8fj7Y0NHAoQqaEilwg/50zEeTqGGHC43keK2G1r652EJlzrSzFtBe2hhJfsA/eOwfPFd6jhdKbjvSbXOk8drqfKjgOVscPepPxpYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGbQVSCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E006DC4CEE7;
	Fri, 31 Oct 2025 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761900138;
	bh=iebUdKZzmfa2jg23LRJHVuu3kza1F82z99YH30rDyb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGbQVSCmaZgm3pK/emkYuL6wOZwS2Ej0PMgWnCExnZ0K9MYE54merAH4WuUUE0ZQt
	 SwIDl8uvXsAERGNcizhrF5fJfAS7YKUYgvRiq1V0FPLxVDr4UnkN6M0YPYV8IUV84N
	 8gghXnFh2Id96xfTYBDy6BoxN7QuQrxv39X3nsOkxHdDMgusRbtBTR4G3joG3Ebf9p
	 3fD6y4dB8bUgqPvU97RgNbSxZ8yW2drZLvfR9HWC2dsw38ZpFgIObIXgWBMBMt6Pfi
	 oMptgDFxJxVxBnZ2J0JV17QiE/dpiSL3/2Fnc3XvNEWD7szMNXBRoOQvPpSVjtNK22
	 JSfPHcUehH18A==
Date: Fri, 31 Oct 2025 09:42:15 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <aQR2Z51Q45Zl99m_@lore-desk>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
 <CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
 <aEg1lvstEFgiZST1@lore-rh-laptop>
 <20250611173626.54f2cf58@kernel.org>
 <aEtAZq8Th7nOdakk@lore-rh-laptop>
 <20250612155721.4bb76ab1@kernel.org>
 <aFATYATliil63D5R@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="preRBihCmKgtL7Vn"
Content-Disposition: inline
In-Reply-To: <aFATYATliil63D5R@lore-desk>


--preRBihCmKgtL7Vn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On Thu, 12 Jun 2025 23:02:30 +0200 Lorenzo Bianconi wrote:
> > > > I'm not Eric but FWIW 256B is not going to help much. It's best to =
keep
> > > > the len / truesize ratio above 50%, so with 32k buffers we're talki=
ng
> > > > about copying multiple frames. =20
> > >=20
> > > what I mean here is reallocate the skb if the true size is small (e.g=
=2E below
> > > 256B) in order to avoid consuming the high order page from the page_p=
ool. Maybe
> > > we can avoid it if reducing the page order to 2 for LRO queues provide
> > > comparable results.
> >=20
> > Hm, truesize is the buffer size, right? If the driver allocated n bytes
> > of memory for packets it sent up the stack, the truesizes of the skbs
> > it generated must add up to approximately n bytes.
>=20
> With 'truesize' I am referring to the real data size contained in the x-o=
rder
> page returned by the hw. If this size is small, I was thinking to just al=
locate
> a skb for it, copy the data from the x-order page into it and re-insert t=
he
> x-order page into the page_pool running page_pool_put_full_page().
> Let me do some tests with order-2 page to see if the GRO can compensate t=
he
> reduced page size.

Sorry for the late reply about this item.
I carried out some comparison tests between GRO-only and GRO+LRO with order=
-2
pages [0]. The system is using a 2.5Gbps link. The device is receiving a si=
ngle TCP
stream. MTU is set to 1500B.

- GRO only:			~1.6Gbps
- GRO+LRO (order-2 pages):	~2.1Gbps

In both cases we can't reach the line-rate. Do you think the difference can=
 justify
the hw LRO support? Thanks in advance.

Regards,
Lorenzo

[0] the hw LRO requires contiguous memory pages to work. I reduced the size=
 to
order-2 from order-5 (original implementation).

>=20
> Regards,
> Lorenzo
>=20
> >=20
> > So if the HW places one aggregation session per buffer, and the buffer
> > is 32kB -- to avoid mem use ratio < 25% you'd need to copy all sessions
> > smaller than 8kB?
> >=20
> > If I'm not making sense - just ignore, I haven't looked at the rest of
> > the driver :)
> >=20



--preRBihCmKgtL7Vn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQR2ZwAKCRA6cBh0uS2t
rNydAQChGxrsUEw7j8qWnmWp3WjRruhrQe2yexdNUpd+gRWnVAD+JiRBjf4A5lOw
QGVPdyJFfYlLM98zy6KQEHHtDr90cQw=
=DjeM
-----END PGP SIGNATURE-----

--preRBihCmKgtL7Vn--

