Return-Path: <netdev+bounces-104970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FAE90F536
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0941C2159F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED41411D7;
	Wed, 19 Jun 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8kmch8B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D41848;
	Wed, 19 Jun 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818582; cv=none; b=Aase4nq1jpgJfxYasHp5QSWcl37KEkbw69NfDT0o7zDjc9xu4Blwz/5Aurf9vNOgw/edgHmMBfLAgwoLGU8ifinfgjO27PXqd0b2H+7eaxnYAzM5TcwswK8ZFnr0MAkm1NxlMqblbsVNoOfikxEwyradggXxrNe4xZaAZx13sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818582; c=relaxed/simple;
	bh=DrmJn4DQDg8tS/79j2zVF7iokicQzqB2ahSSIe6NO1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrjcFrRAPqqxF+nNT9P4MlaPn2OkkbDWLJowDwP3dLOsbjCfd0RiBIZXflUrat/65KKjLktPRkdDNSulKbks20ctbgZOjCwMZlS0cq9lWwlKe/CTGSMYR4+BBzDlz8RZ3qcWy10EqYbrq0r1RIqwDJmdvU6ScaoTRJsMo7qS8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8kmch8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572FAC2BBFC;
	Wed, 19 Jun 2024 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818581;
	bh=DrmJn4DQDg8tS/79j2zVF7iokicQzqB2ahSSIe6NO1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8kmch8BTnHgHALIfxSL47FmS0jyLMCvAZBQ7IxJly7ya4XiTwxj5cV6q+iAsvhZF
	 aIZTkgJU3bwobPbCSeXvYNll8cXvnf7+M5ZNUWPToS7cvXHj0T6YF1NdE05G93edBU
	 WWewKuNMx5cH9ThC/7+vk04+wwr7zm66P6dSb7lzt/KaISu1fpD6nLzulNV3Iy39aG
	 AopUWom6uyVXKkAEX1ITgFgrBAzZ8fQX9HpUN7pfLTss79hgyYNE55wcwW5pMoxI2f
	 fYLx8wEcr0LLcSPthTUmmAEevu7HTA1iqJUXx2PHm6NDoE3iqh1WkV0XEAvM9R1YKc
	 FldH9tXO7tbGQ==
Date: Wed, 19 Jun 2024 18:36:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240619-plow-audacity-8ee9d98a005e@spud>
References: <20240619150359.311459-1-kamilh@axis.com>
 <20240619150359.311459-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c7q0oAxjwmmc8+yb"
Content-Disposition: inline
In-Reply-To: <20240619150359.311459-4-kamilh@axis.com>


--c7q0oAxjwmmc8+yb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 05:03:58PM +0200, Kamil Hor=E1k - 2N wrote:
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

Please fix your SoB and from addresses via your gitconfig as I told you
to in response to the off-list mail you sent me. You also dropped my Ack
without an explanation, why?

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
>

--c7q0oAxjwmmc8+yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMXEAAKCRB4tDGHoIJi
0lkSAQDW+9gNfAKDGi1U2F+s8+yBsEsb0NQ5+TLYGiHPwWj5OgD/StCQn3Ce4XCU
fD0X4999cQOtS22vCCda+6giB/kDbwM=
=JF9C
-----END PGP SIGNATURE-----

--c7q0oAxjwmmc8+yb--

