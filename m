Return-Path: <netdev+bounces-264544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD9HCEzwqWlGIQEAu9opvQ
	(envelope-from <netdev+bounces-264544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:06:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F01218642
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9485A3115813
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8834BA5B;
	Thu,  5 Mar 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGKoGMdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BB34B43D;
	Thu,  5 Mar 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744666; cv=none; b=VlwPPrUz+9Gj4lQGPBfXxAmsYX3MRQg84joKpqk3BtHPz1c6U6JP+1mAvxvPGALFjQlX3z0Zeo2aHidFfST54i3o0X8ogwtE4UQTwIDwyDUIi+xCgQPdhJdvSeVQVNU9rFoUzKQJh9iO9b/AOAT92JSMrG4Ya7N4j0ODsvN70lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744666; c=relaxed/simple;
	bh=zazYrHvSYXwWZwTBCtNqw2NlYT9eCTVzZJ22WXvKDCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGecuUJOAkVVZzs46haKi3KCssBczp77A3eoK2f3OESbwhfFhAiP2bnPuZ08dALUNzz3gmRQGbklglPQQgOB2qBhj+1dsESxDQxE6CqUSJnHbQIdWvwv6UnNMVVE78YcCQLThU2sSTKW97+w31sv9LLgVpScKzrXCYnJbYb2MBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGKoGMdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD05C116C6;
	Thu,  5 Mar 2026 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772744665;
	bh=zazYrHvSYXwWZwTBCtNqw2NlYT9eCTVzZJ22WXvKDCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGKoGMdgvYrKL4azyYnKY5NxH9P4S6CjcZ/QDnmfafybQheYx2fgHJA5uqLHK9YLK
	 xDwoVDcBNO5n1mKPL8KdwtBHouaOg3Esaz9q6LaPuBuk+4MnBpAacbd8dmC1OEoWa6
	 NCpNzHdWqcC3SHEzEh8IgpfSoz7I9HW4+V2pwz4tcYc9XhRKoh64GpTFIMW2HP8ao2
	 qluUm7/Ppcaj23bW2B24+7eu1NzXxUTG0q+zAJuya7iNzflmo/Evqu/x54n2DiUzNf
	 5Ks/WzuSn9ulmMKWipomicKAXA9crK3HDDOe2ASq8486keMR9ceW3m915jaDfrEkj0
	 FtjWbkNhCoXMA==
Date: Thu, 5 Mar 2026 21:04:17 +0000
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
Message-ID: <20260305-chatting-immersion-1995ed2ddef5@spud>
References: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
 <20260228232600.4187398-1-kuba@kernel.org>
 <20260228-shopping-april-a8c4d2481cbe@spud>
 <a1e36563-0e74-48b2-ae02-813cb28fc931@microchip.com>
 <20260303-stardust-shaky-c8a757ec149d@spud>
 <1d35173d-b364-4c4a-a083-388d3bd27ce5@microchip.com>
 <20260303-speech-reversing-b3fdf4817798@spud>
 <cb782e55-29f9-46c5-8213-397202b326ec@microchip.com>
 <20260304-stardust-blade-c9ed766b041a@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ze45Z7enXNcfXoL5"
Content-Disposition: inline
In-Reply-To: <20260304-stardust-blade-c9ed766b041a@spud>
X-Rspamd-Queue-Id: 78F01218642
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264544-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--ze45Z7enXNcfXoL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:52:58PM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 09:13:39AM -0700, Ryan Wanner wrote:
> > > No, I don't think this is what I am suggesting. I am suggesting adding
> > > USRIO_HAS_CLKEN to the gem configs, and then modifying the usrio stru=
ct
> > > to have a member called something like "refclk_default_enable" and se=
tting
> > > it to true for emacs and false for gems. Then in init code somewhere,=
 we
> > > would do:
> > >=20
> > > 	if (property_present(refclk-source))
> > > 		if (property_read_string(refclk-source) =3D=3D "external"
> > > 			refclk_enable =3D true
> > > 		else
> > > 			refclk_enable =3D false
> > > 	else if (property_present(refclk-ext))
> > > 		refclk_enable =3D true
> > > 	else
> > > 		refclk_enable =3D usrio.refclk_default_enable
> > >=20
> > > Then later on in init, when configuring the caps, we would do:
> > >=20
> > > 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
> > >=20
> > > 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
> > > 			val |=3D refclk_enable;
> > >=20
> > > 		macb_or_gem_writel(bp, USRIO, val);
> > > 	}
> > >=20
> > > Or maybe we just roll all that up together inside the !USRIO_DISABLED
> > > code.=20
> > >=20
> > > The code currently in macb_configure_caps() about refclks would be
> > > deleted.
> > >=20
> > > This would produce one property that works for both emacs and gems, n=
ot
> > > change any defaults for existing devices and retain support for whate=
ver
> > > devicetrees made it into the wild with your property.
> > >=20
> > > Does that make sense?
> >=20
> > If we are set to have an external and internal clock dt property than I
> > think we should just keep those if statements inside the !USRIO_DISABLED
> > code block just to keep it more organized and clean and keeping the
> > current HAS_CLKEN if statement be the fallback default case to set the
> > register bit value. Some thing like this:
> >=20
> > if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
> > 		if (property_present(refclk-source)) {
> > 			if (property_read_string =3D=3D "external")
> > 				val |=3D true;
> > 			else
> > 				val |=3D false;
> > 		}
> > 		else if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
> > 			val |=3D bp->usrio->refclk;
> >=20
> > 		macb_or_gem_writel(bp, USRIO, val);
> > }
> >=20
> > Would this be a good middle ground?
>=20
> I explicitly would like to make HAS_CLKEN represent the USRIO having the
> bit, and not ascribe behaviour to it, so that it is actually a
> capability. This is why I want to make the default a member of the usrio
> struct in match data.
> Also, the bit position depends on the usrio struct, which we both
> omitted from our pseudo code, which means that even knowing how to
> modify val depends on having HAS_CLKEN/usrio.refclk being set, so your
> fallback doesn't sit right with me - I am trying to avoid things writing
> to USRIO without specifically being told what it is writing to is valid.

Ryan and I have discussed this a bit more, and it seems like the
USRIO_HAS_CLKEN capability flag is also being used to represent two
different "features" entirely (turning on a xceiver clock and choosing
the refclk source), depending on which device the driver has been bound
to. The next version of this series will also split this into two
different capability flags, so that each actually does what it says on
the tin.

--ze45Z7enXNcfXoL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaanv0QAKCRB4tDGHoIJi
0oz1APwMZmmb5uy3DhSTBfBlnKJpHeM0ls3Jfzyp65FAfq/XjQD+JmWDSVx6mbpG
EgKcXYMJlYa29W0FoQxDe2MkGzB5Qw0=
=hH75
-----END PGP SIGNATURE-----

--ze45Z7enXNcfXoL5--

