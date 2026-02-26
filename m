Return-Path: <netdev+bounces-261283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBoXN5QkoGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:46:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF3F1A47F9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF999300E1A9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8D3126DF;
	Thu, 26 Feb 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqApQBF+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6A30FC34;
	Thu, 26 Feb 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102791; cv=none; b=KZ2dZskIwtYt9hI1337VeNVcl4U8hdzSY3+ID83M7pIFGtajk0LdhrnKWGRn1itRVoGSjwSsjnN2l2sQVFUnfilpYS5qOczSE03qbRfY7R2U/9BEr2ImL4LRkPv2RtV0dmNlyzZTihJjcgEm37h+5mtEcfRmz0kxdw1UV1rYWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102791; c=relaxed/simple;
	bh=uDsB0i6QXrY22o/BHBYBi7a/Koo8ot6LI6Ju593/6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBIQBPqCt1IxlVSHltR4g6WGbXmI5V4dRFh55NQkZdj3PE5mAS7pJ/8qYa9mZslURFcm9rfJA7wcTBlXzhaI3kYHz+INUeNEjEnn1AwYZDZpZqIxAkPLr8uUKCZMRXAnPgmJX+6wCgv8pMo4pSjBDdlhsl4A4CqoYgIfyg3YGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqApQBF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D3DC19422;
	Thu, 26 Feb 2026 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772102790;
	bh=uDsB0i6QXrY22o/BHBYBi7a/Koo8ot6LI6Ju593/6xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqApQBF+a2+ASv11fBkuASvxv1L0IH4ibb8JP4ZH741RqaqHOnojnW7ZD73cWyILw
	 4ccTSta1YxM3CTOtwBKqpP88pwM2bJq5ZDEo2SE8qUZEeEEfIzKGk+r54IcZcq6niu
	 F/uQAHbMjIIbcvf8RJ3M7/kbtKnMCbRbYlPCsxePO2kcyvP7I5dLUI7XkF5LHfvuEj
	 zRr4ILjiH+d7im/as1dCHxhKkGqma3V982rxtxvQAxkVGpJHn/heQbzHOb+pwvwq0+
	 IDeqGkI7Ov0GaGVVO/gjejuSIKGV6K+eL8PX6ok8+G3hOVEUI4YUvXQkyMQ9NUEVsI
	 s5iCS8uLt3e+g==
Date: Thu, 26 Feb 2026 10:46:24 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <20260226-folic-excitable-82eff83a125a@spud>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Im2QyThLb1POUKOO"
Content-Disposition: inline
In-Reply-To: <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261283-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.3:email,0.0.0.8:email,0.0.0.7:email]
X-Rspamd-Queue-Id: 0DF3F1A47F9
X-Rspamd-Action: no action


--Im2QyThLb1POUKOO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 06:22:55PM +0200, Th=E9o Lebrun wrote:
> Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> that must grab a generic PHY and initialise it.
>=20
> We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> the first users of bp->phy that use it in non-SGMII cases.
>=20
> The phy_set_mode_ext() call is made unconditionally. It cannot cause
> issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
> those cases, the call is a no-op (returning zero). From reading
> upstream DTS, we can figure out that no platform has a bp->phy and a
> PHY driver that has a .set_mode() implementation:
>  - cdns,zynqmp-gem: no DTS upstream.
>  - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attached.
>  - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
>  - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
>    drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().

Ran into this patch while looking at other stuff. Theo could you explain
this analysis to someone not really au fait with phys? Looking at
soc.dtsi files won't show you phys, since that's a board level decision,
but you have found one for the zynqmp-gem so I guess that's just the way
you presented the data?
mpfs definitely has phys attached, so is you not finding one for it but
finding for zynqmp, an indication that you were only looking for rgmii
phys? Also, is the analysis of the connected phy driver accurate for
zynmqmp?
zynqmp-zc1751-xm018-dc4.dts seems to have 4 ethernet phys:
		ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
			reg =3D <0>;
		};
		ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
			reg =3D <7>;
		};
		ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
			reg =3D <3>;
		};
		ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
			reg =3D <8>;
		};

I'm not sure that this matters because they probably don't actually
implement mode changes as they're dedicated ethernet phys. The zynmp phy
seems to only be used for !ethernet devices. The phys I'm aware of being
used with mpfs are all also dedicated ethernet ones. Calling
phy_set_mode_ext() seems to be to be the right decision, but the rationale
confused me a little.

Cheers,
Conor.

--Im2QyThLb1POUKOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaAkgAAKCRB4tDGHoIJi
0iTVAP9HHR8z82MzQweWvBR0kQrJMikIfQ3m8ksMbGhiqsLiKAD8Cxa8C7Ggx/NI
dVXtXKShc3DBXOu7l49uCeq8DFBqgQg=
=x46e
-----END PGP SIGNATURE-----

--Im2QyThLb1POUKOO--

