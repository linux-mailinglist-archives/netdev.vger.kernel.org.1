Return-Path: <netdev+bounces-251318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24518D3B93C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28A0630268D8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C5C2F7ADE;
	Mon, 19 Jan 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDdIJn00"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18142E4247;
	Mon, 19 Jan 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857545; cv=none; b=Y70kq6jDrCp7aSa1gIfcJp4uDBCEb9gw/aMgoOoKoZJuUlaztnndkuBT0BXlsWpl5XgfxbBLYxNw8em3F2q2MgYb+0L4zWhxGSEOpSvpKlB/Zbsqaw4PgnkQdxrnfJ2q98MM62md1ZTFf+Q7CuKQ/d38Pdsdh30BC73s2CSJTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857545; c=relaxed/simple;
	bh=RiZix3ZWSDDX0kVsKNY2/NK7ibKFt0yaP7yosjnxrbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbsmIhZo9AMPlYPMQg2+SxQ+cVqmYVQMMIIT7LswBinoUpGY7gFUBRW5S8cDdoD+/V7YqGttICBV0CGtiWomKYlXiuJgtVmBhWdto0Yqyld+bCOA1o2qZlCuUSTAvzCaYlt8U5ddEFDBSzuYpGBHAZMSD3CdY24cDUuSnzgmvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDdIJn00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2778C116C6;
	Mon, 19 Jan 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768857545;
	bh=RiZix3ZWSDDX0kVsKNY2/NK7ibKFt0yaP7yosjnxrbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDdIJn00Jog/P1TGthnFCcvdmd9MZ4Kv5OupR2BYOgkjTDGlXiGgFQDD+KwHnqN76
	 +7brQbDWyD5rhRm6Hi3d5kLeGWnGNloNIfs5CR0CIcATh2i2Q9dH0PU/sTwUv8JMmo
	 Yk3tpQMglfC+aKfLLXzcM12JCW6qEi/vW6ELxs3Fdx7I+lu3ahOcwelFZXsDqbG9EG
	 Kl/u1DOdo8KwFZXHToF5NJQqH7QwiHd9qAnqRJ/Vmi9XLJUVy1Dlw403Sj6fiqEmfG
	 BCPWcjx79UYwISheRm9PM9wm1f0TwPf7JRvI55voidsN1qJZ3Q7tYIAmW1Bq9LzNIe
	 Opgg9R0/fAzYg==
Date: Mon, 19 Jan 2026 22:19:02 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <aW6fxogvp0sQFFsp@lore-desk>
References: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
 <20260119-airoha-npu-firmware-name-v3-2-cba88eed96cc@kernel.org>
 <2b716edf-23c6-427d-beb5-16127b8bf429@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cLZYzOR0huwzNIPg"
Content-Disposition: inline
In-Reply-To: <2b716edf-23c6-427d-beb5-16127b8bf429@lunn.ch>


--cLZYzOR0huwzNIPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 19, Andrew Lunn wrote:
> On Mon, Jan 19, 2026 at 04:32:41PM +0100, Lorenzo Bianconi wrote:
> > Introduce the capability to read the firmware binary names from device-=
tree
> > using the firmware-name property if available.
> > This patch is needed because NPU firmware binaries are board specific s=
ince
> > they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
> > MT7992) and the WiFi chip version info is not available in the NPU driv=
er.
> > This is a preliminary patch to enable MT76 NPU offloading if the Airoha=
 SoC
> > is equipped with MT7996 (Eagle) WiFi chipset.
>=20
> I _think_ you need to add the firmware file names to the end of the
> file using MODULE_FIRMWARE(). That gives dracul, or whatever is
> building in initramfs, the information it needs to include them.

ack, right. I will fix it in v4.

Regards,
Lorenzo

>=20
> 	 Andrew

--cLZYzOR0huwzNIPg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaW6fxgAKCRA6cBh0uS2t
rGkoAP9P+eNo3FzutaIAdBTw8UVL8in96lthLkhY5MyMzdgYTAD/RUF4ix1+Jwej
w9JdQnMTU5CLmNOkfaPDRBTR36lVYg4=
=a56P
-----END PGP SIGNATURE-----

--cLZYzOR0huwzNIPg--

