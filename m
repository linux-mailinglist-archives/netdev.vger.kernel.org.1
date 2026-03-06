Return-Path: <netdev+bounces-264877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5XYVDgQBq2msZQEAu9opvQ
	(envelope-from <netdev+bounces-264877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F9224E93
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444343055DE8
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF03AE1B7;
	Fri,  6 Mar 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo/QrYGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483C233723;
	Fri,  6 Mar 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814276; cv=none; b=oJxRCirl3hdzDagUjxR+Fm8fSKnvhIHtRYG3Ybustrhe7oV71SX5MaJ45NAOwZl9BSBKXcsZAT9dqhG+7IRKS3asZR4QMNeEzvH0wql08vviQT7jM1/wPcN/FaO6/AHOIrqeJycZukC9sVn0Falqi1ZRdPR4tiaQkI+/A0hvaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814276; c=relaxed/simple;
	bh=Ba8mQLOaFnpnr0NzmQQ3FPas3CvCs/fUBqA1uiRtQN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDotoLvLrGc3J45qiypaAiZbN3PoCsS7bzNXztWeD3BgbudlBXQme6E38wVZyG9NiCG5iaAXiQGj1TY56yR/lWznP5LRpjnrOeaR6f5PGJlCZFVuvdN8THqdd1G5BPS8WHPu00GZ2PGtpUPQDMGriffVo9dIhyaN0qfp36Uux9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo/QrYGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BD5C4CEF7;
	Fri,  6 Mar 2026 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814276;
	bh=Ba8mQLOaFnpnr0NzmQQ3FPas3CvCs/fUBqA1uiRtQN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bo/QrYGfW4wrreeK3uFebWWpTvTwtJqaPQPIfKqff0TT+zbEkH0chP2GMl4V0GuPC
	 tGGsZmrSsRdM4+JJlH7eIDmb76zJm0ErizR4axrQtKNQe9wH1xWFDnK8Tg3tOAqJv8
	 QtTZhvr0N8ioLqXDl7FHsaqamlxKLQd4fmN24l4yGP/HBR726s9ixtifJ40yiLCl7b
	 ciDT5WM+5BqGBwPkfKMJihIrBhOF9cNe7U8QQGsXoQLuAM1+JGz53WiWSNw8YFmWqp
	 oNe06SFmN88UMpT7dvclF+putj9KN15FuH7OhJIC6MX7ZDq3F3iqrbJX2/HddHrH6N
	 p/GdpXeVEfZQA==
Date: Fri, 6 Mar 2026 16:24:31 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <20260306-distaste-depress-55d020802bae@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-backlit-epilogue-62139ae694a6@spud>
 <aamLf63OfJ5RH69v@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-fantasy-useable-40ca04f0266e@spud>
 <aamS-LPZaOfamwQC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mDj1BB+t/c7mmT8n"
Content-Disposition: inline
In-Reply-To: <aamS-LPZaOfamwQC@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 7D5F9224E93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264877-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--mDj1BB+t/c7mmT8n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 02:28:08PM +0000, Russell King (Oracle) wrote:
> I suggest something like the following in vitesse.c for this PHY:
>=20
> #define VSC8662_EXT_CON1		0x17
> #define VSC8662_EXT_CON_MAC_AN		BIT(13)
>=20
> #define VSC8662_MAC_AN			0x1b
> #define VSC8662_MAC_AN_BYPASS		BIT(13)
>=20
> static unsigned int vsc8662_inband_caps(struct phy_device *phydev,
> 					phy_interface_t interface)
> {
> 	if (interface =3D=3D PHY_INTERFACE_MODE_SGMII)
> 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE |
> 		       LINK_INBAND_BYPASS;
>=20
> 	return 0;
> }
>=20
> static int vsc8662_config_inband(struct phy_device *phydev, unsigned int =
modes)
> {
> 	bool changed =3D false;
> 	u16 mask;
> 	int ret;
>=20
> 	mask =3D VSC8662_EXT_CON_MAC_AN;
> 	ret =3D phy_modify_changed(phydev, VSC8662_EXT_CON1, mask,
> 				 modes & (LINK_INBAND_ENABLE |
> 				 	  LINK_INBAND_BYPASS) ? mask : 0);
> 	if (ret > 0)
> 		changed =3D true;

FYI, clang warns that changed is set but not used.

> 	else if (ret < 0)
> 		return ret;
>=20
> 	mask =3D VSC8662_MAC_AN_BYPASS;
> 	ret =3D phy_modify(phydev, VSC8662_MAC_AN, mask,
> 			 modes & LINK_INBAND_BYPASS ? mask : 0);
> 	if (ret < 0)
> 		return ret;
>=20
> 	return genphy_soft_reset(phydev);
> }
>=20
> and the appropriate initialisers in the phy_driver struct.

I tested this, on top of the failing next that I found the problem on,
and it seems to make things work. Thanks for coming up with it.

Could you please make this a patch, I don't understand why this is the
correct way to fix the problem, or the impact on users of the 8662 other
than me, so I wouldn't be able to write a suitable commit message.

Cheers,
Conor.

--mDj1BB+t/c7mmT8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaar/vwAKCRB4tDGHoIJi
0uXBAPsFNIh3ZrTgJkV3Bf0AgYY/bP6tPP2WSb12J7/tBPl6YAD/cHTX+lDR7RMD
Qj6IPIViHAADJdgB/uRBnLfEB9658gs=
=UWpI
-----END PGP SIGNATURE-----

--mDj1BB+t/c7mmT8n--

