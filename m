Return-Path: <netdev+bounces-262271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMGcEhSDo2m9FgUAu9opvQ
	(envelope-from <netdev+bounces-262271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 01:06:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FD1C9C80
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 01:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE1830158BF
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7A1A294;
	Sun,  1 Mar 2026 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecUmek2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE36846F;
	Sun,  1 Mar 2026 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772323598; cv=none; b=Xcm8xWOuZCiwpsEh4RhWm0//L6CPg8aTIQoLIytd2Fc2AMQdqiP8jwHjt4WD90xsBRWT4VnCTrMhthY2lF7e8eZUZ0d/3QV/6hivczw0uIcxzK2tOKJEcATlR1YqRWT5NnwpmWtPYJB8Tn64G6+CEWGHxacPY4Y5LLC2TTGuOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772323598; c=relaxed/simple;
	bh=KVZEqxhqfMk2K5SJptsD55r8uz/Z6dnQu8CTdmkZpyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RekI/5T3+YJ17KgZ5+v0CFki/V/UAGx2QxauD+p2ZlSSU0s9aYi2JBUGDiV+qZt/NXaeRExh+Knw9y2fUYYN2wL8R+f1O+R9h8UMqkoAQz/2EX6egmF1+rgIsdvK+wOvv/SFmq1vZwDAx5qpkeR/12Dvm1FnpN9h3vDzOpeSjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecUmek2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00133C19421;
	Sun,  1 Mar 2026 00:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772323598;
	bh=KVZEqxhqfMk2K5SJptsD55r8uz/Z6dnQu8CTdmkZpyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecUmek2wGXSZYFlYs9O3cHJy0vUDKiOsT5g8g0309rpdp0wQUFDqxuor7AsHBl0xx
	 RgiWeCQ9ZBnTjaM1MFDtTM6ti1LD3AawiA7RtWdhA+031B33wG4NDQlU4xLqsh0Hg4
	 YXNhoKpk3keT4kpkXt6aIuaInvFGEIGQ/iZ8LcFCwyTFcZJLDlt2Jxtkl/f+UjeIS3
	 BNEQEAgEsON0gA9lI3MzekYyCkt/h1ISaHvfsfqdAMV8T3xHbmjKuX2qma3CM3N0DI
	 ZMW5ZtFKItTwBUj9fsErDy14sZ2Zb8TdcUr3/0/urZf07t60rR8D4lX6fClkG3j54K
	 4AzhOcdQfRcXA==
Date: Sun, 1 Mar 2026 00:06:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, richardcochran@gmail.com, abin.joseph@amd.com,
	robh@kernel.org, edumazet@google.com, netdev@vger.kernel.org,
	theo.lebrun@bootlin.com, pjw@kernel.org,
	Valentina.FernandezAlanis@microchip.com, krzk+dt@kernel.org,
	sean.anderson@linux.dev, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org, alex@ghiti.fr,
	devicetree@vger.kernel.org, palmer@dabbelt.com,
	nicolas.ferre@microchip.com, vineeth.karumanchi@amd.com,
	claudiu.beznea@tuxon.dev, samuel.holland@sifive.com,
	daire.mcnamara@microchip.com, conor+dt@kernel.org,
	dave.stevenson@raspberrypi.com, linux-riscv@lists.infradead.org,
	davem@davemloft.net, conor.dooley@microchip.com,
	narmstrong@baylibre.com, pabeni@redhat.com,
	Ryan.Wanner@microchip.com
Subject: Re: [net-next,v2,2/8] net: macb: rename macb_default_usrio to
 at91_default_usrio as not all platforms have mii mode control in usrio
Message-ID: <20260228-shopping-april-a8c4d2481cbe@spud>
References: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
 <20260228232600.4187398-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZXbF+PkoVTFGVgRa"
Content-Disposition: inline
In-Reply-To: <20260228232600.4187398-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-262271-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,amd.com,kernel.org,google.com,vger.kernel.org,bootlin.com,microchip.com,linux.dev,eecs.berkeley.edu,ghiti.fr,dabbelt.com,tuxon.dev,sifive.com,raspberrypi.com,lists.infradead.org,davemloft.net,baylibre.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC3FD1C9C80
X-Rspamd-Action: no action


--ZXbF+PkoVTFGVgRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Sat, Feb 28, 2026 at 03:26:00PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: macb: rename macb_default_usrio to at91_default_usrio as not all
> platforms have mii mode control in usrio
>=20
> This patch renames macb_default_usrio to at91_default_usrio to better
> reflect that the usrio configuration is platform-specific, and
> introduces a new capability flag (MACB_CAPS_USRIO_HAS_MII) to gate MII
> mode configuration code for platforms that actually support it.
>=20
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
> > @@ -779,6 +779,7 @@ #define MACB_CAPS_DMA_64B			BIT(21)
> >  #define MACB_CAPS_DMA_PTP			BIT(22)
> >  #define MACB_CAPS_RSC				BIT(23)
> >  #define MACB_CAPS_NO_LSO			BIT(24)
> > +#define MACB_CAPS_USRIO_HAS_MII			BIT(25)
> >
> >  /* LSO settings */
> >  #define MACB_LSO_UFO_ENABLE			0x01
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -4614,13 +4614,15 @@
> >
> >  	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
> >  		val =3D 0;
> > -		if (phy_interface_mode_is_rgmii(bp->phy_interface))
> > -			val =3D bp->usrio->rgmii;
> > -		else if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII &&
> > -			 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> > -			val =3D bp->usrio->rmii;
> > -		else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> > -			val =3D bp->usrio->mii;
> > +		if (bp->caps & MACB_CAPS_USRIO_HAS_MII) {
> > +			if (phy_interface_mode_is_rgmii(bp->phy_interface))
> > +				val =3D bp->usrio->rgmii;
> > +			else if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII &&
> > +				 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> > +				val =3D bp->usrio->rmii;
> > +			else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> > +				val =3D bp->usrio->mii;
> > +		}
> >
> >  		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
> >  			val |=3D bp->usrio->refclk;
>=20
> Can bp->usrio be NULL here? The new MACB_CAPS_USRIO_HAS_MII capability
> gates the MII-related dereferences of bp->usrio, but bp->usrio is also
> dereferenced when MACB_CAPS_USRIO_HAS_CLKEN is set.
>=20
> With the change to default_gem_config later in this patch:
>=20
> static const struct macb_config default_gem_config =3D {
> 	...
> 	.usrio =3D NULL,
> 	...
> };
>=20
> A device that matches the generic 'cdns,macb' compatible string (without
> specific .data) will get bp->usrio =3D NULL during probe. If the device
> tree then has 'cdns,refclk-ext', macb_configure_caps() adds
> MACB_CAPS_USRIO_HAS_CLKEN without checking if bp->usrio is valid:
>=20
> macb_configure_caps() {
> 	...
> 	if (of_property_read_bool(np, "cdns,refclk-ext"))
> 		bp->caps |=3D MACB_CAPS_USRIO_HAS_CLKEN;
> 	...
> }
>=20
> Then in macb_init(), the code would dereference bp->usrio->refclk with
> bp->usrio being NULL, causing a crash.
>=20
> The MACB_CAPS_USRIO_HAS_MII gate only protects the MII-related
> dereferences above, not the CLKEN dereference.

AI makes a good point here, but in one way this isn't even a problem
with the patchset, it's actually another example of the sort of thing
that I am trying to get rid of from the driver. As far as I can tell,
this was added very recently, for the emac on sama7g5. The sama7g5-emac
sets this cap in its match data, as do several other devices, so this
code that sets the cap based on the dt property isn't needed.

I would like to get rid of setting the cap based on the dt property,
because it is inherently tied to how at91 have their USRIO set up.
Other platforms that want to use this external refclk might use a
different mechanism for the selection, or only support an external
source. What USRIO does is very platform specific, so it should be
something that is opted in to explicitly. I didn't ask for the property
to be bound to only the at91 devices that use it when I reviewed the
binding, because I figured other platforms might be able to reuse the
property and that's also why I didn't ask for a microchip prefix on the
property. For the driver to reflect that general use, it shouldn't then
do at91-specific things when the property is present.

Ryan, how does this property actually work now, given your removal
of the cap from match data was reverted? I feel like it just doesn't do
what you want it to do anymore? Before the revert, having the property
meant that the value in sama7g5_usrio.refclk would be written to the
hardware and not having the property meant that the bit would remain
unset. You then had to revert to avoid breaking old devices, because
your property changed the default behaviour for the emac, so now having
the property means that the value in sama7g5_usrio.refclk is written to
the hardware, but that also happens without the property because the cap
is set in the match data.

Unless I am missing something, should we not actually revert
dce32ece3bb8f ("net: cadence: macb: Expose REFCLK as a device tree
property") and 1b7531c094c88 ("dt-bindings: net: cdns,macb: Add external
REFCLK property"), and instead add a property like
"microchip,refclk-internal", because that would actually let you
override the default behaviour of the driver?

Cheers,
Conor.

>=20
> > @@ -4638,13 +4640,6 @@
> >  	return 0;
> >  }
> >
> > -static const struct macb_usrio_config macb_default_usrio =3D {
> > -	.mii =3D MACB_BIT(MII),
> > -	.rmii =3D MACB_BIT(RMII),
> > -	.rgmii =3D GEM_BIT(RGMII),
> > -	.refclk =3D MACB_BIT(CLKEN),
> > -};
> > -
>=20
> [ ... ]
>=20
> > @@ -5219,6 +5214,13 @@ static int eyeq5_init(struct platform_device *pd=
ev)
> >  	return ret;
> >  }
> >
> > +static const struct macb_usrio_config at91_default_usrio =3D {
> > +	.mii =3D MACB_BIT(MII),
> > +	.rmii =3D MACB_BIT(RMII),
> > +	.rgmii =3D GEM_BIT(RGMII),
> > +	.refclk =3D MACB_BIT(CLKEN),
> > +};
> > +
>=20
> [ ... ]
>=20
> > @@ -5432,7 +5448,7 @@ MODULE_DEVICE_TABLE(of, macb_dt_ids);
> >  	.dma_burst_length =3D 16,
> >  	.clk_init =3D macb_clk_init,
> >  	.init =3D macb_init,
> > -	.usrio =3D &macb_default_usrio,
> > +	.usrio =3D NULL,
> >  	.jumbo_max_len =3D 10240,
> >  };
> >
> --=20
> pw-bot: cr

--ZXbF+PkoVTFGVgRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaODBgAKCRB4tDGHoIJi
0gs/APwMsvBtZc3nBNGbarB8g1f0V6tvmTnFVzuAqsfj8G7v+gD9FLULicP6knc0
4MRq+EqCQo1OMd2KHGif/BwNCkzv9QU=
=GwKV
-----END PGP SIGNATURE-----

--ZXbF+PkoVTFGVgRa--

