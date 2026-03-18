Return-Path: <netdev+bounces-269147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHp+KoHlummdcwIAu9opvQ
	(envelope-from <netdev+bounces-269147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:48:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A342C09A8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6254D302B834
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06ED3563D7;
	Wed, 18 Mar 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujlpz/bS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD03354ADB;
	Wed, 18 Mar 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856093; cv=none; b=Ze+0QejGW8Fzzt7Hc2PITNkFYym9qSQ4NlZSUu4II7121C3irX6Hfqj+qXf37nFRnBYva72lwJvm8NSDQxy2wovMNlW9hLqwcWhSqefiABAjtOG5irK08k4Zt8OKJb6RyKHfY6/8eEa9W/7hWNr2vlX2lmlJsasc4yQxzku1U+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856093; c=relaxed/simple;
	bh=pQAFIbZIhmMTLc/mYEA5XgMpFNoRH/fDy2E8vDEfznc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGRNZgbYXJ34tQsVClRzcA4Yp5jxVFdTt6GD62/rRLp1XW6R3wAtGYfQVmNs0XZxFlujpysVk5QVcEscrvV8VhiL4kb2QkqhxCRWdlzb+BcKbQUmoE46Cco4A1bV/QGi81bMYsKSJU6SU3gYZ20A0fRSbCZ+icf2MIm0zvzy3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujlpz/bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B2C2BC87;
	Wed, 18 Mar 2026 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773856093;
	bh=pQAFIbZIhmMTLc/mYEA5XgMpFNoRH/fDy2E8vDEfznc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujlpz/bSwy+wfDQI5dQccWTn2L8KOYRsJbmmybLyDl+peieYdfDde8nj/IpVYcEYI
	 7ackhbtq8Yxc5Xg9TBBQH7zCyFewJSwOLR45mbnv0+OPXpUh4OHwxkaa7XoCoaxNPG
	 JsAP82j4T9J1XuAmlzbDc4af3CvFHAY9vy2904MYg+ea+Ut4HknYizButIAZEMzqYd
	 kw3YJ/FDX0s9DKkKTWfV+lqsWWWxm6MaWQzJ4A1veKmGU+GtOZnG7QjGCtAyCWyLSF
	 Vldoxrq7dJmwZgVLgR9GqQMTu7nzDNKjRCjHFh3Jefdi4WplhDavc7Je0mbbClX8Ss
	 r1rMTkjuCUsmw==
Date: Wed, 18 Mar 2026 17:48:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <20260318-suspense-arming-fe118c3f15c6@spud>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IW4jHSdMH+tE+sFx"
Content-Disposition: inline
In-Reply-To: <20260317184610.315852-2-charles.perry@microchip.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.901];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email,devicetree.org:url,microchip.com:email]
X-Rspamd-Queue-Id: 20A342C09A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--IW4jHSdMH+tE+sFx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 11:46:09AM -0700, Charles Perry wrote:
> This MDIO hardware is based on a Microsemi design supported in Linux by
> mdio-mscc-miim.c. However, The register interface is completely different
> with pic64hpsc, hence the need for separate documentation.
>=20
> The hardware supports C22 and C45.
>=20
> The documentation recommends an input clock of 156.25MHz and a prescaler
> of 39, which yields an MDIO clock of 1.95MHz.
>=20
> The hardware supports an interrupt pin to signal transaction completion
> which is not strictly needed as the software can also poll a "TRIGGER"
> bit for this.
>=20
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  .../net/microchip,pic64hpsc-mdio.yaml         | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64=
hpsc-mdio.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-md=
io.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.ya=
ml
> new file mode 100644
> index 000000000000..21c76199c11b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,pic64hpsc-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PIC64-HPSC/HX MDIO controller
> +
> +maintainers:
> +  - Charles Perry <charles.perry@microchip.com>
> +
> +description: |
> +  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO b=
us
> +  controller supports C22 and C45 register access. It is named "MDIO Ini=
tiator"
> +  in the documentation.
> +
> +allOf:
> +  - $ref: mdio.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,pic64hpsc-mdio
> +      - items:
> +          - const: microchip,pic64hx-mdio
> +          - const: microchip,pic64hpsc-mdio
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency: true

Does this genuinely have no constraints?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        mdio@4000C21E000 {
> +            compatible =3D "microchip,pic64hpsc-mdio";
> +            reg =3D <0x400 0x0C21E000 0x0 0x1000>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            phy0: ethernet-phy@0 {
> +                reg =3D <0>;
> +            };
> +        };
> +    };
> --=20
> 2.47.3
>=20

--IW4jHSdMH+tE+sFx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabrlWAAKCRB4tDGHoIJi
0lGMAQCFZMsheMTY8r7+nrjrKxb4dPNODqhfXUgAgD0LntsgdgD9EWcX+5BL8OPD
NRnL08pK+yY0gvYbjGj2Z9MIy72oOgM=
=nn8N
-----END PGP SIGNATURE-----

--IW4jHSdMH+tE+sFx--

