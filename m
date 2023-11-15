Return-Path: <netdev+bounces-48028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123DF7EC55C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726D5B20C68
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356FD28E3E;
	Wed, 15 Nov 2023 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP4tn9Mu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAF2EAFC;
	Wed, 15 Nov 2023 14:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0114C433C8;
	Wed, 15 Nov 2023 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700058696;
	bh=X0zwMR33P3gQ46xEwVzb9xCqEqYvEjlN3eTg/GpDNGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nP4tn9Mu8JvKtU+ZDP3/W5VC2NFUaH/x4lOHm/kgG/GkHCPKz45TL26QPPtTwLm9D
	 qr4Sr6/oRQUr7TYpXvxjkx/92nMMV4wluYHckaXJKFyiM2iHT5MOJuAfHaNuNAcHAv
	 TxeZbdahEDGB6D/HBOpxathOcukgToVb1k969olr9dvEFRxTuUps2FKGt/TD50d+MV
	 gjnsgUSdmOY6FtKj6Xd7kduafmgG2dXU/pvmhOZQHm49qKHnOcZFoSY5eufHqD49Hs
	 C4mSzSLNAYWqHhH3kA5IaFhS5vDcsmKobwcpBCYLknhm98APAVrVZB5qKlUNpYAtaT
	 9c/iWw47iQvmQ==
Date: Wed, 15 Nov 2023 14:31:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/6] net: phy: introduce core support for phy-mode =
 "10g-qxgmii"
Message-ID: <20231115-tightness-naturist-459776cff199@squawk>
References: <20231115140630.10858-1-quic_luoj@quicinc.com>
 <20231115140630.10858-3-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z3tph6xppgMkCCjq"
Content-Disposition: inline
In-Reply-To: <20231115140630.10858-3-quic_luoj@quicinc.com>


--Z3tph6xppgMkCCjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:06:26PM +0800, Luo Jie wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> 10G-QXGMII is a MAC-to-PHY interface defined by the USXGMII multiport
> specification. It uses the same signaling as USXGMII, but it multiplexes
> 4 ports over the link, resulting in a maximum speed of 2.5G per port.
>=20
> Some in-tree SoCs like the NXP LS1028A use "usxgmii" when they mean
> either the single-port USXGMII or the quad-port 10G-QXGMII variant, and
> they could get away just fine with that thus far. But there is a need to
> distinguish between the 2 as far as SerDes drivers are concerned.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../devicetree/bindings/net/ethernet-controller.yaml |  1 +

I know it is one line, but bindings need to be in their own patches
please.

--Z3tph6xppgMkCCjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVTWQAAKCRB4tDGHoIJi
0hLcAQD09A4z6eyfiteENmtAECCBlON0RrlWKjJUA+IaFCdg6AEA4z6TN2X+C7f4
JZsjVtMpNWoKnI7Ao8uM7RN927kPUw0=
=mswn
-----END PGP SIGNATURE-----

--Z3tph6xppgMkCCjq--

