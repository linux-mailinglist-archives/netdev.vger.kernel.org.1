Return-Path: <netdev+bounces-187267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7FAA5FF6
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378981788FC
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666831F1512;
	Thu,  1 May 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUwXcTvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAF19CC1C;
	Thu,  1 May 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109704; cv=none; b=SYTdo7Kvno+cBieCyYCWaWqztyzLELzP4AOUbvd27eCXZwh4fdLHrgOu5NQSEBM++THM4Y8qZHGJo0vHre5Y5qc04Pk//vbWknv3BRUbYlR3Uif6aR5UlFYFkG+TMQK/u2dMA7oJBNEYxyQ/lyze2IckdTaDPebhRJ1AQCvk85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109704; c=relaxed/simple;
	bh=dG/vmRyKkftV3UXTBolH+6yd6BgJNwN/cvqHh6HRxRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjDeTU4OS+sjZ+1RpQhMkn5/uxxWlJ6oICa7Zw2YRDbAuUg//42CtRTv0DdBRnolvUYA/GxoRd1ytLByMy3WaD5X/t4Xq0a24E6MVqs5CDsjPh/ih5popuEmPgYaehm0/tNY1fjbme5YF6bOX/C/24HKIkl8mirAYaSLFsfeNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUwXcTvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB17C4CEE3;
	Thu,  1 May 2025 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746109703;
	bh=dG/vmRyKkftV3UXTBolH+6yd6BgJNwN/cvqHh6HRxRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUwXcTvkkneJCvpsXOtBl99R3OlqklWXCU0ADMe603mh9WyN626b6zE18VejnTqyn
	 3AFdV0WJ/gyMGYjtJrvfXX3oRa7QfhUjUamPOqzbINRo1EDuxX3Qj0T709Xp2cVv78
	 DrVNx6bekqF4AUvubwfgc/r6x7SKb1/rtA77OzhJQzXCPRZLyzDkS0dC+F+G0mfowM
	 cox+Vl4WGQlCyZ+6IA/htz5dq1hMKJPugim/3AZLyQ8eiGFHdEItPgDPSRK/+r7ZWu
	 Yi54GnwJ5POgKb2iZqoQiAkUvNQzCI0VfpnH9WeGXSLSMsR1EOI4DfiRc+MKD02QBx
	 GLAKIFsjzh1lw==
Date: Thu, 1 May 2025 15:28:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <20250501-extrude-jot-aa8512a299ec@spud>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I870tTDMsq2gvFPl"
Content-Disposition: inline
In-Reply-To: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>


--I870tTDMsq2gvFPl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:21:35AM -0500, Andrew Lunn wrote:
> Device Tree and Ethernet MAC driver writers often misunderstand RGMII
> delays. Rewrite the Normative section in terms of the PCB, is the PCB
> adding the 2ns delay. This meaning was previous implied by the
> definition, but often wrongly interpreted due to the ambiguous wording
> and looking at the definition from the wrong perspective. The new
> definition concentrates clearly on the hardware, and should be less
> ambiguous.
>=20
> Add an Informative section to the end of the binding describing in
> detail what the four RGMII delays mean. This expands on just the PCB
> meaning, adding in the implications for the MAC and PHY.
>=20
> Additionally, when the MAC or PHY needs to add a delay, which is
> software configuration, describe how Linux does this, in the hope of
> reducing errors. Make it clear other users of device tree binding may
> implement the software configuration in other ways while still
> conforming to the binding.
>=20
> Fixes: 9d3de3c58347 ("dt-bindings: net: Add YAML schemas for the generic =
Ethernet options")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes in v2:
> Reword Normative section
> manor->manner
> add when using phylib/phylink
> request details in the commit message and .dts comments
> clarify PHY -internal-delay-ps values being depending on rgmii-X mode.
> Link to v1: https://lore.kernel.org/r/20250429-v6-15-rc3-net-rgmii-delays=
-v1-1-f52664945741@lunn.ch
> ---
>  .../bindings/net/ethernet-controller.yaml          | 97 ++++++++++++++++=
++++--
>  1 file changed, 90 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 45819b2358002bc75e876eddb4b2ca18017c04bd..a2d4c626f659a57fc7dcd3930=
1f322c28afed69d 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -74,19 +74,17 @@ properties:
>        - rev-rmii
>        - moca
> =20
> -      # RX and TX delays are added by the MAC when required
> +      # RX and TX delays are provided by the PCB. See below

I'm not sure that "provided" is the correct word to describe what's
meant here (implemented might be better), but it's perfectly
understandable as-is and I don't think worth respinning or splitting
hairs over...

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--I870tTDMsq2gvFPl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBOFAgAKCRB4tDGHoIJi
0jplAP9zRFU8cq0CrAIupeDxoyotkJxhG0NaXz1GE2mesULpvgD7BF2kqIywMMqL
jF2DMurlLRkxpRkBUqu61t3g8/rkCwY=
=FiiL
-----END PGP SIGNATURE-----

--I870tTDMsq2gvFPl--

