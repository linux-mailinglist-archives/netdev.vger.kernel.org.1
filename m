Return-Path: <netdev+bounces-198048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C9ADB09F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A857A7E7B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DEF292B4B;
	Mon, 16 Jun 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjAUlyTt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E24292B4F
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078307; cv=none; b=G/i3BqqYkGLx258UEl7KARyLrOdZuKVXK6jpiRPmu39HZcHLyBioyk2gxdgp5k96/holaWshy3APajIR0kLMbbrYCkJXoMMd0D14+aYoWVkCqd24SWv/LYPSeAUnlyHqA3t8OY5pYgMyDMUWB0nJNHlN2rPcmkAr/ekFOoE9Lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078307; c=relaxed/simple;
	bh=np1h4zJ5vXfQTar5Dx3KmNyhdbcnNiAHewzhEqh18oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhAesFz+YAKKkOnwz022zakFecIHICRlHtvmt26CIpu23IPKJypd52PjyMiGOGZCXBt43rx1A3MnBkgOqRADTkxNZbhzWkhv5B4srZhKVh7eK7/e98mhm3dljFpwIlCMjRWZunP4VQR3QsKdIeEBE+mPK4oHjKx2tEvmQXW28Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjAUlyTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52777C4CEEA;
	Mon, 16 Jun 2025 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750078306;
	bh=np1h4zJ5vXfQTar5Dx3KmNyhdbcnNiAHewzhEqh18oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjAUlyTtBOGRAMwHP5h3X24rmszmA6db1aspcZNSHbYZ6qZEqmJjdwJPjYsssyLxS
	 Bch3rD0SseU04z/ZD9PcI1s26szSeFoKpA4sHN/s+Ph0djr1nSIaC2OlzDx6ifwEla
	 Xku1wY3S+3z9hL6h4lUvVCvT/CdqNgMPxp1JwmUPPKQ5AYRygcIFtNcDt6YCFLG1+U
	 39/LvzPFDQH8o9stOpc6qdFXumTW+iQB51r9zW0Dx1SD8TyYIz1pntGeN9/+3h5snO
	 IYz2OzNZEUMmUr4QHPwgiaFlJ0g3OOyrUjUpD4dIfRrd1AfHrUvIOT2IvynENs3Q0N
	 gSzh+4t+4hXDA==
Date: Mon, 16 Jun 2025 14:51:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <aFATYATliil63D5R@lore-desk>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
 <CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
 <aEg1lvstEFgiZST1@lore-rh-laptop>
 <20250611173626.54f2cf58@kernel.org>
 <aEtAZq8Th7nOdakk@lore-rh-laptop>
 <20250612155721.4bb76ab1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+ocVnvdJxRF6oLW"
Content-Disposition: inline
In-Reply-To: <20250612155721.4bb76ab1@kernel.org>


--W+ocVnvdJxRF6oLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 12 Jun 2025 23:02:30 +0200 Lorenzo Bianconi wrote:
> > > I'm not Eric but FWIW 256B is not going to help much. It's best to ke=
ep
> > > the len / truesize ratio above 50%, so with 32k buffers we're talking
> > > about copying multiple frames. =20
> >=20
> > what I mean here is reallocate the skb if the true size is small (e.g. =
below
> > 256B) in order to avoid consuming the high order page from the page_poo=
l. Maybe
> > we can avoid it if reducing the page order to 2 for LRO queues provide
> > comparable results.
>=20
> Hm, truesize is the buffer size, right? If the driver allocated n bytes
> of memory for packets it sent up the stack, the truesizes of the skbs
> it generated must add up to approximately n bytes.

With 'truesize' I am referring to the real data size contained in the x-ord=
er
page returned by the hw. If this size is small, I was thinking to just allo=
cate
a skb for it, copy the data from the x-order page into it and re-insert the
x-order page into the page_pool running page_pool_put_full_page().
Let me do some tests with order-2 page to see if the GRO can compensate the
reduced page size.

Regards,
Lorenzo

>=20
> So if the HW places one aggregation session per buffer, and the buffer
> is 32kB -- to avoid mem use ratio < 25% you'd need to copy all sessions
> smaller than 8kB?
>=20
> If I'm not making sense - just ignore, I haven't looked at the rest of
> the driver :)
>=20

--W+ocVnvdJxRF6oLW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFATYAAKCRA6cBh0uS2t
rBWaAQDOyU+4+eHsLnA3e8ZOON1SFtM4mDYagCpnTCvcmbG07QEAkgJ0dm5XXjOS
2MFXXDc12/UzCLmREkx436FYDzH0Mwk=
=oAr6
-----END PGP SIGNATURE-----

--W+ocVnvdJxRF6oLW--

