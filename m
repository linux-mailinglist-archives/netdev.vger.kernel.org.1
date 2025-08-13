Return-Path: <netdev+bounces-213454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CBBB250D1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAC7565FCB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2670F28D839;
	Wed, 13 Aug 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwRNjTRA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008728CF5D;
	Wed, 13 Aug 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104385; cv=none; b=jK/olUiNQ4C09uH340zkLBySHe4lLImX8zonZiTjfc2e5Ag6tsP+BBkWf5Jxc3U5GDBYfcLg36BoBoGwfqNDFkr03Rl1Nq6JbDUD0BooZ/CirL4uux4lHLe6IxeF0eWbu2olsrAN0iihZKQSgy6XF14YvhI4E740QDpEKDvdjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104385; c=relaxed/simple;
	bh=jCV6REqPKpCo7kCdS3vMJ1eOqgUd9wCq3DKI4TZSfFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8ZyTN63ldVkG/HKRPyRQ3buqh6BEkMeK4J5BK5YIPCOCZZVQ0KxDHkv0t+d3RTQeKR5RknfZR057wmaPg340ora63e210Zsj4JyBAQkM7ah/5Ba8PBwZ5siK5bnkfz+rYyhNOFAeh7CZLNIZrPULVIsF/Mx1s8in0ZANBZWANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwRNjTRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F275EC4CEEB;
	Wed, 13 Aug 2025 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104384;
	bh=jCV6REqPKpCo7kCdS3vMJ1eOqgUd9wCq3DKI4TZSfFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwRNjTRAgoMaGqEU38sSRiotRItIi67zGe4Z9/IGyMoMubwan8ZtC/NxC0AeaccES
	 H/g0hxJLP9W5C9iTTFAusF3nxtGAoNnQ4Iu4q5jfi3C/Wm9H88VDEM+0Dls5HMxfri
	 zMUlYx5saKpaOVLqMh71MgldK7Z1YsYpGf2ieDPteIJYvH9hkadJxChKizoRXSO2Sp
	 Nni8kVaVUKOHxj7nhK8gQuUrfs+kVIrkPIaty0uTb/W6DNUnt1mhv4B+NHtPmd0sV+
	 wBVh188xxlyqTO0iMdr0aKLxZiVBFytjCAp4EYBs6xTr8JLfl0Uiq17TAQObCzbpWD
	 MlRNNZW4h8oog==
Date: Wed, 13 Aug 2025 17:59:38 +0100
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next] dt-bindings: net: realtek,rtl82xx: document
 wakeup-source property
Message-ID: <20250813-clumsily-jogging-5b271d626084@spud>
References: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
 <E1um9Xj-008kBx-72@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kXphbP+2Kj0gDEJX"
Content-Disposition: inline
In-Reply-To: <E1um9Xj-008kBx-72@rmk-PC.armlinux.org.uk>


--kXphbP+2Kj0gDEJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:21:19PM +0100, Russell King (Oracle) wrote:
> The RTL8211F PHY has two modes for a single INTB/PMEB pin:
>=20
> 1. INTB mode, where it signals interrupts to the CPU, which can
>    include wake-on-LAN events.
> 2. PMEB mode, where it only signals a wake-on-LAN event, which
>    may either be a latched logic low until software manually
>    clears the WoL state, or pulsed mode.
>=20
> In the case of (1), there is no way to know whether the interrupt to
> which the PHY is connected is capable of waking the system. In the
> case of (2), there would be no interrupt property in the PHY's DT
> description, and thus there is nothing to describe whether the pin is
> even wired to anything such as a power management controller.
>=20
> There is a "wakeup-source" property which can be applied to any device
> - see Documentation/devicetree/bindings/power/wakeup-source.txt
>=20
> Case 1 above matches example 2 in this document, and case 2 above
> matches example 3. Therefore, it seems reasonable to make use of this
> existing specification, albiet it hasn't been converted to YAML.
>=20
> Document the wakeup-source property in the device description, which
> will indicate that the PHY has been wired up in such a way that it
> can wake the system from a low power state.
>=20
> We will use this in a rewrite of the existing broken Wake-on-Lan code
> that was merged during the 6.16 merge window to support case 1. Case 2
> can be added to the driver later without needing to further alter the
> DT description. To be clear, the existing Wake-on-Lan code that was
> recently merged has multiple functional issues.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Apologies, this should've been sent with the patch to the driver which
> can be found at:
>=20
> https://lore.kernel.org/r/E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk

Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
>  Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b=
/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index d248a08a2136..2b5697bd7c5d 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -45,12 +45,16 @@ title: Realtek RTL82xx PHY
>      description:
>        Disable CLKOUT clock, CLKOUT clock default is enabled after hardwa=
re reset.
> =20
> -
>    realtek,aldps-enable:
>      type: boolean
>      description:
>        Enable ALDPS mode, ALDPS mode default is disabled after hardware r=
eset.
> =20
> +  wakeup-source:
> +    type: boolean
> +    description:
> +      Enable Wake-on-LAN support for the RTL8211F PHY.
> +
>  unevaluatedProperties: false
> =20
>  allOf:
> --=20
> 2.30.2
>=20

--kXphbP+2Kj0gDEJX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJzEegAKCRB4tDGHoIJi
0qhYAQDcb4YsLfc0FatMF1QPO+izo/7JXWF9SG22gFqMgiyrpQD+OnRiK4OBgRHv
b9VeSq3xg5/9mj1ZXFl/DvOKilprlQc=
=QwM2
-----END PGP SIGNATURE-----

--kXphbP+2Kj0gDEJX--

