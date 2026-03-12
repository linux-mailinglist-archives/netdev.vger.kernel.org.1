Return-Path: <netdev+bounces-267112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fo7IWPVsmlDQAAAu9opvQ
	(envelope-from <netdev+bounces-267112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:01:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A44273DB4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20EFC300C373
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40337A4A1;
	Thu, 12 Mar 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4Nqlfve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42138DD3;
	Thu, 12 Mar 2026 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327704; cv=none; b=k3wgQlPno1BLHKdI582THMOzVLdsJ1FkDUi8nW+h+aXNfHmLT3CiOSa52hKsKCjAh9dH5azdFPzk4kz6ID0JOPhf2EqOgx/pJqW0SNpVvxz4zxc4tJfIGnRhQ2ZFgtF65tSyOMB9qdH1AI9cQ0vosONbtiKfE2HXiq/40frcUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327704; c=relaxed/simple;
	bh=L7hVTnTecMgXlvaOcu2bUHhGZHaiyI+PiQ97uCKP1Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkGxr5VUwtnyiUEmo3U7otJs07SboqEyTlTXcH8tvKkAjvRSQcKtvUdGqEe6/0blDAtq219C4s2cxumKTAChbfcuQBNr58uZDc33is4Vqd2/zyfxpBfbUOkrJIX6QNGRpALYULnz4FGrgDV9WpsQF0Xq+SkHScEHK2wW5vy+sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4Nqlfve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72685C4CEF7;
	Thu, 12 Mar 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327703;
	bh=L7hVTnTecMgXlvaOcu2bUHhGZHaiyI+PiQ97uCKP1Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4NqlfveNQD1BALX5Z/zHe+6mh7HV84jraBhR31cuflxkZWh115nSb/pOP4mqybgO
	 S5wlhv0izwEbM0dp65WoRoSmSKr4sU8RqcWMoi+f2kSwHEm9ksgX/cJhXriyYsJzl1
	 o0v37JOykeLh3XdI2vkkkzTa7nhJsnQ+/i1f9SSufCDq9bpLpSCX7MX6oYrg3FgTpg
	 gY0/cXG7EyN98S6CcavJBtL20U2PzLq4nyXENMSmcxvoBPjVaNUwya0nMedAqVY8R0
	 B4Q2tzlJKpyMXJb98MGhuZ3QjAzcRQgvPMIq3Hn6nImcVrW+BZ5LON5LE7Ob4iG8Wi
	 zWa20BFoV+Jeg==
Date: Thu, 12 Mar 2026 15:01:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: set default_an_inband to true for
 SGMII
Message-ID: <20260312-poise-parade-97e9382718da@spud>
References: <20260312133856.2911581-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JMF67jaW6InLzhzS"
Content-Disposition: inline
In-Reply-To: <20260312133856.2911581-1-charles.perry@microchip.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D9A44273DB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--JMF67jaW6InLzhzS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 06:38:55AM -0700, Charles Perry wrote:
> Most platforms using GEM in SGMII mode use in-band autonegotiation
> because it is on by default in GEM's 1G PCS and is always on since
> commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
> fixed-link mode"). Leave it on if possible using the "default_an_inband"
> flag of "struct phylink_config" so that platforms that lack in-band
> autonegotiation configurability at the PHY do not break with commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
> will turn off in-band autoneg for non hot pluggable PHYs.
>=20
> Once the majority of the PHY drivers that support SGMII have the
> ->config_inband() callback, this commit could be reverted so that non
> hot pluggable PHY use outband negotiation with macb, like its the case
> for other MACs.
>=20
> Fixes: 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> Closes: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba=
1@spud

Reported-by: Conor Dooley <conor.dooley@microchip.com>

> Tested-by: Conor Dooley <conor@kernel.org>

Just as an FYI, you shouldn't insert tags that "certify" the quality of
your patch that you weren't explicitly given. Reported-by/Suggested-by
you can conjure up yourself where appropriate, but Tested-by/Acked-by/Revie=
wed-by
need more care.

But of course, I did test it, and it restored functionality on both
boards that I have here, so:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 963a5d4e1a88..d1fc6a9b9fe5 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -838,6 +838,12 @@ static int macb_mii_probe(struct net_device *dev)
>  	if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
>  		bp->phylink_config.poll_fixed_state =3D true;
>  		bp->phylink_config.get_fixed_state =3D macb_get_pcs_fixed_state;
> +		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
> +		 * default_an_inband to true tells phylink to turn it off only
> +		 * if necessary (e.g. a fixed link or a PHY that doesn't support
> +		 * inband).
> +		 */
> +		bp->phylink_config.default_an_inband =3D true;
>  	}
> =20
>  	bp->phylink_config.mac_capabilities =3D MAC_ASYM_PAUSE |
> --=20
> 2.47.3
>=20

--JMF67jaW6InLzhzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabLVTwAKCRB4tDGHoIJi
0i8rAP9bly8XUKmsXto2NWvDMW7VvROVRtSbqS5lTSk7PsdNDAEAvaEVJwoAmWws
NLE9MbBFv8Y1ekRyuOUKid8k8plqRwE=
=+ptb
-----END PGP SIGNATURE-----

--JMF67jaW6InLzhzS--

