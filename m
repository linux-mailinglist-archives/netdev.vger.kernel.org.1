Return-Path: <netdev+bounces-263450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LLbDUxkp2mghAAAu9opvQ
	(envelope-from <netdev+bounces-263450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:44:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0401F81EF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02CE7301DD91
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9803822AD;
	Tue,  3 Mar 2026 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exmjtMvC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382F384237;
	Tue,  3 Mar 2026 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577859; cv=none; b=KPS/L58SYDA7jus26Oam7PhbtJ/JhLCZA9/5oH5YsHsfoDqaydRRyvvWAJDbHEazKhzxPDoAvcvK3AWrmVsTNX6gGrn3F9fabo3Vh14OB5BgkZo3I4Cvbpx4C+h+WZAhWUey8jUm2yB4WSlz6UtCF6czPUSgQ3fuQ/x8lQ3Njqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577859; c=relaxed/simple;
	bh=rTbcFi1faJtQlXJP5dG6Smix1FhVj3sxoc7vDc8J9fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiHCPmqfQaWBkeWusP1k6wzoVO89E8bOTCKhZ29ODmNLlKHPNivsHqpPrWxugAKXVgUzwNcZU4EikbyxWKxceF/hFMBp1B+GZeAk/GmOoQ0up/ZDeu8JsRmgAtMkDrA8cmf5KQRtapg0RbRmKuMAIfxWUhC1Yh3FS7fsVcXb1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exmjtMvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C1C116C6;
	Tue,  3 Mar 2026 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772577858;
	bh=rTbcFi1faJtQlXJP5dG6Smix1FhVj3sxoc7vDc8J9fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exmjtMvCr70PGpA/1IO8EQ7Q75MvSyHJDhxVGuZQkodl4+uijFtkYlHYIdXEj/p2V
	 IT/TwxLbNI/lHomK8EKi8+kdduhit9PMyC8PaBWT3ARCl7oH8B/euxtNYU3mEfgswf
	 0JOlWNvZHGrXNwHqp5MyiFMkz1zUznBfWD3gOK8EGTCMOeFYTbuPdcMszMHVKoL8nZ
	 OrCdyQ2u2JKaLzgABIBgUIdlAlg201gvq/lnOHrb+cDjLhzwYImRtRcDaO/a9T2qFe
	 qTOXLeMjZfxvYN2igf3WtmF8rkwzcutwHkn6QPcCbAFEs6tDuZJ7Uv8qZsqi++Y1d3
	 qYrD46g+EMXfg==
Date: Tue, 3 Mar 2026 22:44:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Ryan Wanner <ryan.wanner@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	richardcochran@gmail.com, abin.joseph@amd.com, robh@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org,
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
	narmstrong@baylibre.com, pabeni@redhat.com
Subject: Re: [net-next,v2,2/8] net: macb: rename macb_default_usrio to
 at91_default_usrio as not all platforms have mii mode control in usrio
Message-ID: <20260303-speech-reversing-b3fdf4817798@spud>
References: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
 <20260228232600.4187398-1-kuba@kernel.org>
 <20260228-shopping-april-a8c4d2481cbe@spud>
 <a1e36563-0e74-48b2-ae02-813cb28fc931@microchip.com>
 <20260303-stardust-shaky-c8a757ec149d@spud>
 <1d35173d-b364-4c4a-a083-388d3bd27ce5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isqVLd/Yo4U/6wrG"
Content-Disposition: inline
In-Reply-To: <1d35173d-b364-4c4a-a083-388d3bd27ce5@microchip.com>
X-Rspamd-Queue-Id: EB0401F81EF
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
	TAGGED_FROM(0.00)[bounces-263450-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,amd.com,google.com,vger.kernel.org,bootlin.com,microchip.com,linux.dev,eecs.berkeley.edu,ghiti.fr,dabbelt.com,tuxon.dev,sifive.com,raspberrypi.com,lists.infradead.org,davemloft.net,baylibre.com,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--isqVLd/Yo4U/6wrG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 03:04:19PM -0700, Ryan Wanner wrote:
> On 3/3/26 11:01, Conor Dooley wrote:
> > On Tue, Mar 03, 2026 at 10:35:05AM -0700, Ryan Wanner wrote:
> >> On 2/28/26 17:06, Conor Dooley wrote:
> >>> Yo,
> >>>
> >>> On Sat, Feb 28, 2026 at 03:26:00PM -0800, Jakub Kicinski wrote:
> >>>> This is an AI-generated review of your patch. The human sending this
> >>>> email has considered the AI review valid, or at least plausible.
> >>>>
> >>>> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai=
-local.html
> >>>> ---
> >>>> net: macb: rename macb_default_usrio to at91_default_usrio as not all
> >>>> platforms have mii mode control in usrio
> >>>>
> >>>> This patch renames macb_default_usrio to at91_default_usrio to better
> >>>> reflect that the usrio configuration is platform-specific, and
> >>>> introduces a new capability flag (MACB_CAPS_USRIO_HAS_MII) to gate M=
II
> >>>> mode configuration code for platforms that actually support it.
> >>>>
> >>>>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethe=
rnet/cadence/macb.h
> >>>>> --- a/drivers/net/ethernet/cadence/macb.h
> >>>>> +++ b/drivers/net/ethernet/cadence/macb.h
> >>>>> @@ -779,6 +779,7 @@ #define MACB_CAPS_DMA_64B			BIT(21)
> >>>>>  #define MACB_CAPS_DMA_PTP			BIT(22)
> >>>>>  #define MACB_CAPS_RSC				BIT(23)
> >>>>>  #define MACB_CAPS_NO_LSO			BIT(24)
> >>>>> +#define MACB_CAPS_USRIO_HAS_MII			BIT(25)
> >>>>>
> >>>>>  /* LSO settings */
> >>>>>  #define MACB_LSO_UFO_ENABLE			0x01
> >>>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net=
/ethernet/cadence/macb_main.c
> >>>>> --- a/drivers/net/ethernet/cadence/macb_main.c
> >>>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
> >>>>> @@ -4614,13 +4614,15 @@
> >>>>>
> >>>>>  	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
> >>>>>  		val =3D 0;
> >>>>> -		if (phy_interface_mode_is_rgmii(bp->phy_interface))
> >>>>> -			val =3D bp->usrio->rgmii;
> >>>>> -		else if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII &&
> >>>>> -			 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> >>>>> -			val =3D bp->usrio->rmii;
> >>>>> -		else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> >>>>> -			val =3D bp->usrio->mii;
> >>>>> +		if (bp->caps & MACB_CAPS_USRIO_HAS_MII) {
> >>>>> +			if (phy_interface_mode_is_rgmii(bp->phy_interface))
> >>>>> +				val =3D bp->usrio->rgmii;
> >>>>> +			else if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII &&
> >>>>> +				 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> >>>>> +				val =3D bp->usrio->rmii;
> >>>>> +			else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
> >>>>> +				val =3D bp->usrio->mii;
> >>>>> +		}
> >>>>>
> >>>>>  		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
> >>>>>  			val |=3D bp->usrio->refclk;
> >>>>
> >>>> Can bp->usrio be NULL here? The new MACB_CAPS_USRIO_HAS_MII capabili=
ty
> >>>> gates the MII-related dereferences of bp->usrio, but bp->usrio is al=
so
> >>>> dereferenced when MACB_CAPS_USRIO_HAS_CLKEN is set.
> >>>>
> >>>> With the change to default_gem_config later in this patch:
> >>>>
> >>>> static const struct macb_config default_gem_config =3D {
> >>>> 	...
> >>>> 	.usrio =3D NULL,
> >>>> 	...
> >>>> };
> >>>>
> >>>> A device that matches the generic 'cdns,macb' compatible string (wit=
hout
> >>>> specific .data) will get bp->usrio =3D NULL during probe. If the dev=
ice
> >>>> tree then has 'cdns,refclk-ext', macb_configure_caps() adds
> >>>> MACB_CAPS_USRIO_HAS_CLKEN without checking if bp->usrio is valid:
> >>>>
> >>>> macb_configure_caps() {
> >>>> 	...
> >>>> 	if (of_property_read_bool(np, "cdns,refclk-ext"))
> >>>> 		bp->caps |=3D MACB_CAPS_USRIO_HAS_CLKEN;
> >>>> 	...
> >>>> }
> >>>>
> >>>> Then in macb_init(), the code would dereference bp->usrio->refclk wi=
th
> >>>> bp->usrio being NULL, causing a crash.
> >>>>
> >>>> The MACB_CAPS_USRIO_HAS_MII gate only protects the MII-related
> >>>> dereferences above, not the CLKEN dereference.
> >>>
> >>> AI makes a good point here, but in one way this isn't even a problem
> >>> with the patchset, it's actually another example of the sort of thing
> >>> that I am trying to get rid of from the driver. As far as I can tell,
> >>> this was added very recently, for the emac on sama7g5. The sama7g5-em=
ac
> >>> sets this cap in its match data, as do several other devices, so this
> >>> code that sets the cap based on the dt property isn't needed.
> >>>
> >>> I would like to get rid of setting the cap based on the dt property,
> >>> because it is inherently tied to how at91 have their USRIO set up.
> >>> Other platforms that want to use this external refclk might use a
> >>> different mechanism for the selection, or only support an external
> >>> source. What USRIO does is very platform specific, so it should be
> >>> something that is opted in to explicitly. I didn't ask for the proper=
ty
> >>> to be bound to only the at91 devices that use it when I reviewed the
> >>> binding, because I figured other platforms might be able to reuse the
> >>> property and that's also why I didn't ask for a microchip prefix on t=
he
> >>> property. For the driver to reflect that general use, it shouldn't th=
en
> >>> do at91-specific things when the property is present.
> >>>
> >>> Ryan, how does this property actually work now, given your removal
> >>> of the cap from match data was reverted? I feel like it just doesn't =
do
> >>> what you want it to do anymore? Before the revert, having the property
> >>> meant that the value in sama7g5_usrio.refclk would be written to the
> >>> hardware and not having the property meant that the bit would remain
> >>> unset. You then had to revert to avoid breaking old devices, because
> >>> your property changed the default behaviour for the emac, so now havi=
ng
> >>> the property means that the value in sama7g5_usrio.refclk is written =
to
> >>> the hardware, but that also happens without the property because the =
cap
> >>> is set in the match data.
> >>
> >> So even with the revert the patch still does what it is intended to do,
> >> mainly for the sama7g5_gem and the newer SAM devices, sam9x75 and sama=
7d65.
> >=20
> > Oh, the gems actually have this, but with the default the other way to
> > the emacs? I had figured that only the emacs actually had it, given they
> > were all added prior to your change. Obviously the property then cannot
> > be removed if the gems need it.
>=20
> Yes that is correct, I am not sure why this was left out in the initial
> implementation of the gems maybe others can give some insight. The gems
> can, similar to the emacs, take an external or internal ref clock that
> is decided by the usrio registers. The difference with the gems and the
> emacs is the gems can have 125MHz refclk for RGMII (50Mhz for RMII)
> either internal or external where as the emacs can only switch refclk
> for RMII.
>=20
> >=20
> >> Currently with the removal of the change to the emac there is no
> >> functional difference. With the newer SAM devices that need this usrio
> >> flexibility this patch still works.
> >>
> >> How this works now is for sama7g5_gmac configs, the default is to use
> >> the internal clock for refclk then adding that dt property will set th=
at
> >> bit to 1 and refclk will be from an external source. For the
> >> sama7g5_emac configs this has no effect due to ABI.
> >>>
> >>> Unless I am missing something, should we not actually revert
> >>> dce32ece3bb8f ("net: cadence: macb: Expose REFCLK as a device tree
> >>> property") and 1b7531c094c88 ("dt-bindings: net: cdns,macb: Add exter=
nal
> >>> REFCLK property"), and instead add a property like
> >>> "microchip,refclk-internal", because that would actually let you
> >>> override the default behaviour of the driver?
> >>
> >> I think this could be the better way to go as this keeps the existing
> >> behavior for the legacy devices while still allowing the initial goal =
of
> >> the patch series. Seems it would be more strait forward in the ABI sen=
se
> >> to have a "microchip,refclk-internal" property than an "refclk-ext"
> >> property and having the risk of breaking older devices.
> >=20
> > By the sounds of things, you actually need both to be functional. The
> > gems default to internal, so need refclk-external and the emacs default
> > to external so need refclk-internal. Maybe it'd be better to have
> > "microchip/cdns,refclk-source" that can be set to a string to deal with
> > both cases?
>=20
> Since a dt string would need to be placed either way could the default
> be setting be 1 like how the emacs is set then make a
> "microchip,refclk-internal" flag, this seems to have the minimal amount
> of conflicts with legacy implementation.

Unless I misunderstand what you're saying, you're suggesting changing
the default for the non-emacs? I don't think this can be done, for the
same reason that your emac patch got reverted - it breaks existing
devices. With my suggestion, the driver support for refclk-ext would
remain, so as not to break any existing setups, but it would be removed
=66rom the binding or marked deprecated.

> > I'd also like to decouple setting the USRIO_HAS_CLKEN cap from what
> > direction it is set in. That way, all devices with the bit in their
> > USRIO would set the cap, but the value would come from either a default
> > in match data or from the dt property if set. I think that's more
> > natural behaviour for the capability, since the bit is in the usrio
> > register regardless of which refclk source is used.
> >=20
> > Does that seem reasonable?
>=20
> So to leave the "USRIO_HAS_CLKEN" caps flag in the existing configs for
> emacs, then have this be a toggle for the gem configs, and the
> "microchip/cdns,refclk-source" would be parsed to either set this bit to
> 1 or 0? The USRIO refclk bit will be set in the macb_init() based on if
> the dt property is there rather than how it is currently implemented now
> if I understand correctly?

No, I don't think this is what I am suggesting. I am suggesting adding
USRIO_HAS_CLKEN to the gem configs, and then modifying the usrio struct
to have a member called something like "refclk_default_enable" and setting
it to true for emacs and false for gems. Then in init code somewhere, we
would do:

	if (property_present(refclk-source))
		if (property_read_string(refclk-source) =3D=3D "external"
			refclk_enable =3D true
		else
			refclk_enable =3D false
	else if (property_present(refclk-ext))
		refclk_enable =3D true
	else
		refclk_enable =3D usrio.refclk_default_enable

Then later on in init, when configuring the caps, we would do:

	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {

		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
			val |=3D refclk_enable;

		macb_or_gem_writel(bp, USRIO, val);
	}

Or maybe we just roll all that up together inside the !USRIO_DISABLED
code.=20

The code currently in macb_configure_caps() about refclks would be
deleted.

This would produce one property that works for both emacs and gems, not
change any defaults for existing devices and retain support for whatever
devicetrees made it into the wild with your property.

Does that make sense?

--isqVLd/Yo4U/6wrG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaadkOwAKCRB4tDGHoIJi
0p/4AQDyRP2K4sNJup9+pnk2RqMzv3fJxVNlq4mtr5QOPPA26QD9EGgGA+4JnOfv
4jtyQUPl1VpJDTx9b8BY3+xiL/WI9QA=
=2hXL
-----END PGP SIGNATURE-----

--isqVLd/Yo4U/6wrG--

