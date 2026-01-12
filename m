Return-Path: <netdev+bounces-249058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C9D13452
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0BF9302C3B5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2EA25B1D2;
	Mon, 12 Jan 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/yy/SHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18722DFA4;
	Mon, 12 Jan 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228841; cv=none; b=dPBqz+1tsYTbc+rE1mHWBbi2gIm6TFym8n0IPLax04cBT8ev01Q3Spug6atyI8x8qWcX3iPZHgt/MSVD5pJM2BWaP75AvRdhFKhv/w09JS/IR1ze224YOWBZ8OT8X9QEje9y4vRB1Ni9cpPZIt8MXGe0IZy5uav+fy7mqbE50yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228841; c=relaxed/simple;
	bh=SDAL0N+qnwLvzZJAzcXSoQROGQiuK08faEFfpMLHSZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooAGfX38eUyTZUr5IFMKui7YRGrNmtgvdfhY5AP0eVdXAX/ksaWJ82PsXOnuuUdAR5iWwaQcvl4GbmwCH7efUCas0dZnH9cePOHQIUR70bebeilfGV0d41xZd0oHkH3t5E3RU6uC62KSzHWBGdIsyzMPrBfuWQHoAGnK+tLKkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/yy/SHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCBFC19421;
	Mon, 12 Jan 2026 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228840;
	bh=SDAL0N+qnwLvzZJAzcXSoQROGQiuK08faEFfpMLHSZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/yy/SHnqAKrjtGGfSswYMzKavZlqQqzOfGZKk7cxHJ9SwyNHu76QGX8eMuT8MKED
	 CIVV6guZOvV3zdpAHHY3JtpNpRR+VRwmiEOvRTzKPruYxyRQN8o7Z9hiOPTF6V61fx
	 5RSIwlNr0VpwquOMXhbMllbrMGjpmvd14l8kSOSPLt45xbZYUAjXPTGKNl/V3i+0MC
	 C29rSyOSZW4aX+B8al2ILOz1UwUmL+ef5ZKVQg0fUXL6raFjU7QgEZ6alXHRdpBqsc
	 sdsdg1TPTBm5wS5u7uPOqwOM/pSkCPS500YgbhGKRnCf4XBJQr2RvKn49X9ZVslzyc
	 jKMwtYbmpRP3A==
Date: Mon, 12 Jan 2026 15:40:38 +0100
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
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <aWUH5nHR3xz-vk-a@lore-desk>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
 <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>
 <f57867a0-a57d-4572-b0ed-b2adb41d9689@lunn.ch>
 <aWT4vcBzG6UnaqOF@lore-desk>
 <81f98b9a-3905-4bd9-80ee-348facefeab9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35dfMFi+mqodQRNK"
Content-Disposition: inline
In-Reply-To: <81f98b9a-3905-4bd9-80ee-348facefeab9@lunn.ch>


--35dfMFi+mqodQRNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > Why cannot this scheme be extended with another compatible?
> >=20
> > yes, that is another possibility I was thinking of but then I found
> > "firwmare-name" property was quite a common approach.
> > Something like:
>=20
> Having two different ways of doing the same thing in one driver just
> add unneeded complexity. Please just key of the compatible like all
> other devices this driver supports.
>=20
>     Andrew

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> ---
> pw-bot: cr

--35dfMFi+mqodQRNK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWUH5gAKCRA6cBh0uS2t
rD+QAQD2KKc4Cab4DOiJr5tUgFk9XtQJh21lPwcIXXyOJIv41AEAivnvtVJJ4Nyo
VQCZ8SeSJRq/fIn4RXDBDubNyNDJhAg=
=G7LN
-----END PGP SIGNATURE-----

--35dfMFi+mqodQRNK--

