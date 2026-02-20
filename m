Return-Path: <netdev+bounces-259690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CAbIZoqmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:34:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F41664A1
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54BF3305DA55
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6432142B;
	Fri, 20 Feb 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+xa95bO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE131ED8A;
	Fri, 20 Feb 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579775; cv=none; b=pWWK3p3Xe0YIWdNerkxtCG9OBgUauTXwVZvS5Ul3pHZOTBvLK+gT5m0va4iM9eUHQiEgMgM1uOJJ5Gb5t/tTvG+EiMM1z0EMZNe/EvwR3X6rPOeBv+YBhkZzkeYNDU3jEFLCw9jEh4Uq/O/5Ddf8XphzffWOGkKI2KOwwouucJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579775; c=relaxed/simple;
	bh=1I7Qtp/lo2yxzhdgjzwU99gB6b79DwIjAoM2q/13oPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQCcvjJMkniwUg3Fa/2nawf3mCKj3sxVnvxILng4dNrh5oP8AKiWn6N5vsWCutIEGMFn57BX7yAPCdTi2ViBY11e5rSwBLBBhDu42EXZyg4i1TpQzcp999sT6fWsyEDEAKionYZ7z3T4B8twft2cIwoinBwLMsb/2rQT02C6Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+xa95bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BABC116C6;
	Fri, 20 Feb 2026 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579775;
	bh=1I7Qtp/lo2yxzhdgjzwU99gB6b79DwIjAoM2q/13oPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+xa95bOKq4vStUjKCEvRwSYMjU4F2npiVuz0zgivxI2r31Qnp+4m+c6bRTPl5B4t
	 pUetHqghAyPri7Pudi9Yfd/jEnJ9TlZUM5P7PD7Utoj2YbXpDpHSPn21LGs04MFNRz
	 LgeqUansSyoXgnYxO+iNuIjkQIRvi57h0flp7GL5uSXdk3hPPVU6bVOiVAIJKdKdDn
	 BssoAX+eR+kJcZGkMj9LJEZKX07nuZgYs4gnidiV/y/QhfjGq+eMnmSo0a/si9PbMC
	 SIOwfMDpCubSpy36VN4XjwfPdy+qHcFbxpGtEuL3cbE4fuCvh02QjMihTfhqGiaraz
	 F5gxbtIn/QfPw==
Date: Fri, 20 Feb 2026 09:29:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Max Hsu <max.hsu@sifive.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/5] dt-bindings: net: macb: Add SiFive FU740-C000 support
Message-ID: <20260220-repeal-glitter-acb73cc75564@spud>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
 <20260220-fu740-v1-1-c8af54130c58@sifive.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5HKymcCcP91liaN3"
Content-Disposition: inline
In-Reply-To: <20260220-fu740-v1-1-c8af54130c58@sifive.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259690-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D82F41664A1
X-Rspamd-Action: no action


--5HKymcCcP91liaN3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 04:27:05PM +0800, Max Hsu wrote:
> Add the SiFive FU740-C000 ethernet controller compatible string to the
> Cadence MACB binding documentation.
>=20
> The FU740 ethernet controller uses the same GEMGXL management block as
> the FU540, which is tightly coupled with the Cadence MACB IP. This
> follows the SiFive IP versioning scheme which requires SoC-specific
> compatible strings for proper hardware identification.

Your rationale for this change is misguided, as this is not a SiFive IP,
so that document does not apply. On the other hand, the general rules
for devicetrees require this so this just means a change in the
rationale provided.

>=20
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index cb14c35ba996..b46dde1da170 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -63,6 +63,7 @@ properties:
>            - mobileye,eyeq5-gem        # Mobileye EyeQ5 SoCs
>            - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit etherne=
t interface
>            - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
> +          - sifive,fu740-c000-gem     # SiFive FU740-C000 SoC

I don't think this is right, since it is identical to the one on the
fu540 (as evidenced by how it has worked until now and the contents of
your driver change). I think you should add the fu740 with a fallback to
the fu540, like the devices from Microchip that fall back to the
microchip,sama7g5-gem. The rest of the changes to the driver and binding
can then be dropped as they'll be redundant.

Thanks,
Conor.

pw-bot: changes-requested

> =20
>        - items:
>            - enum:
> @@ -74,7 +75,7 @@ properties:
>      minItems: 1
>      items:
>        - description: Basic register set
> -      - description: GEMGXL Management block registers on SiFive FU540-C=
000 SoC
> +      - description: GEMGXL Management block registers on SiFive FU540/F=
U740 SoCs
> =20
>    interrupts:
>      minItems: 1
> @@ -181,7 +182,9 @@ allOf:
>          properties:
>            compatible:
>              contains:
> -              const: sifive,fu540-c000-gem
> +              enum:
> +                - sifive,fu540-c000-gem
> +                - sifive,fu740-c000-gem
>      then:
>        properties:
>          reg:
>=20
> --=20
> 2.43.0
>=20

--5HKymcCcP91liaN3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZgpeAAKCRB4tDGHoIJi
0irpAP0SUJFhZrfZ7GbhicinRgZw5rR0S2wuNO2cdDCESgQOogEAr+OAoDbIw4nq
Etix2x3W8zaNk0pHyVg5KDRHTDlkfAU=
=jna2
-----END PGP SIGNATURE-----

--5HKymcCcP91liaN3--

