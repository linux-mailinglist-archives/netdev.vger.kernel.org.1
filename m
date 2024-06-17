Return-Path: <netdev+bounces-104168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4446B90B649
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30B21F223BC
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0014D71F;
	Mon, 17 Jun 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G80aV3pI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29514A602;
	Mon, 17 Jun 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641507; cv=none; b=pyUkDADM2u2kNiiRRXb1xba9FD5Mq+128gGXDL7ZA1vwM58i2Ct4nMpnv+0ktaQbCzQ7Fo2luUTFgc5HAEsqh8jb4px5EbIYdWJWvWkqrnnDrA/YZms2liQWNMK/9Fxfc7Ybk3GMvHrR+UC7k54k986TtfiVV/emoViC5fzL2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641507; c=relaxed/simple;
	bh=68avS0eUJDWQtrEQ997VxoS1VpdCGwWUQWfUSqA7RZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz5f1+07C66XCiX/vISMm7hkSsc5cAzu/b+1UuJhffaMyVG/DIaOPzhTohyLHlzZfdAhb+4LwQcakFo7ajAznfbWSJ4HNZhLBu3MipErZ0OhCH7kKYAHJy9xYydw6QDijU5emyHjV9g8MQ4+EDcqJu8kzab4JqzTCLZgTxhX1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G80aV3pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A9C2BD10;
	Mon, 17 Jun 2024 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718641507;
	bh=68avS0eUJDWQtrEQ997VxoS1VpdCGwWUQWfUSqA7RZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G80aV3pIJpocMaVZJehpDvj+csDfQezq9mrHt6oPp7/nTwhw1OrfGXj9S7veUgOce
	 1Gs87CPP1Ehmr5nA/f+tlFi6Ale3lxObAcVkyJ2irdvRdnKWLA2c7+g/RCGiKF0dv9
	 7Nd2jZDfuUcnIaXkBfD64bUtMiQzEIv/wWiPM1ISr+NTg6PckG4Fc4wepjOYS/uUyX
	 ZCMbTnk11CQQDCXcL19k9Zg/i9kx2YorGgBCXo8sxtfEoZRizpjpTNoONPyAZyaMlv
	 uzq3ixUTB/Tbe+nQiEmg2JElkDQNg+Xpxryuv0eTgBRajDwXYhkoqGJgQJgaLQ3bgj
	 eOt+JoY1WaQgw==
Date: Mon, 17 Jun 2024 17:25:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240617-sinner-scorpion-c140d223975e@spud>
References: <20240617113841.3694934-1-kamilh@axis.com>
 <20240617113841.3694934-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bmjGa3lhaG1D2Hr0"
Content-Disposition: inline
In-Reply-To: <20240617113841.3694934-4-kamilh@axis.com>


--bmjGa3lhaG1D2Hr0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 01:38:40PM +0200, Kamil Hor=E1k - 2N wrote:
> There is a group of PHY chips supporting BroadR-Reach link modes in
> a manner allowing for more or less identical register usage as standard
> Clause 22 PHY.
> These chips support standard Ethernet link modes as well, however, the
> circuitry is mutually exclusive and cannot be auto-detected.
> The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
> based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
> (1BR-10 in Broadcom documents).
>=20
> Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.
>=20
> Signed-off-by: Kamil Hor=E1k - 2N <kamilh@axis.com>

I suspect that "- 2N" is not part of your name, and should be removed
=66rom the signoff and commit author fields.
The patch seems fine, to a phy-agnostic such as myself, so with that
fixed up
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Do=
cumentation/devicetree/bindings/net/ethernet-phy.yaml
> index 8fb2a6ee7e5b..0353ef98f2e1 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -93,6 +93,13 @@ properties:
>        the turn around line low at end of the control phase of the
>        MDIO transaction.
> =20
> +  brr-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Request the PHY to operate in BroadR-Reach mode. This means the
> +      PHY will use the BroadR-Reach protocol to communicate with the oth=
er
> +      end of the link, including LDS auto-negotiation if applicable.
> +
>    clocks:
>      maxItems: 1
>      description:
> --=20
> 2.39.2
>=20

--bmjGa3lhaG1D2Hr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBjXAAKCRB4tDGHoIJi
0k0VAPiewtXS8KzbLRLXZfcbybTdFpNg516B70j7vJjYmIjxAP94WhSqdQZg4U7z
sz/FhwHQ30tQQmFA5Y4Mzoh/zRH6AA==
=+Kc7
-----END PGP SIGNATURE-----

--bmjGa3lhaG1D2Hr0--

