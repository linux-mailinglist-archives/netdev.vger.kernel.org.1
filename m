Return-Path: <netdev+bounces-294804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HuXJK6hNIGrS0gAAu9opvQ
	(envelope-from <netdev+bounces-294804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:52:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649D6396F2
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:52:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eESiPhnA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294804-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294804-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B133066247
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5339A04D;
	Wed,  3 Jun 2026 15:08:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BF2C375A;
	Wed,  3 Jun 2026 15:08:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499316; cv=none; b=RRSNi4HirG55BiNYsr3oGAKA+UWSNTEUGgz07r56XlpinmvIq8wCuVWqfeEAJNGWtvIY2DizI4D+mp3X4Ax+2Spy+JSMdnvSFg1HE1YZ6J3zsGF7kaZ4jlset/h4hNkTXb7ZPYY06tBeh0OgpEBaXGturEaBPkxTj8Ix4w/c0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499316; c=relaxed/simple;
	bh=GbI2mBOm5shIRrexnf8ZmAFYSHX5Nk61O5tcS2VfEAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj6oRhENerHX6IZgDDlvjrHvWPxKgEmvTeIMW/3I8sq/Py/i3xjUs9ZLhmYa3cliOIkz7VZUky0wy6z45jzZjUL0BCA8gyD9ruNYlEjmivYyy/bdzdA+MOQOUASncZfTTELI3Z0Q/BzVoyJIYOuHpD/eQao6aHLG1Al5GBvq9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eESiPhnA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DE51F00893;
	Wed,  3 Jun 2026 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499315;
	bh=d3UCKgH8UNTNQlXVq1R2gxKykMTul6zeCVnMu7mz+r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eESiPhnAdLepmVOoBrcd110nPUCF0irf9+GDOD5LzkQKBfqnqgvhRvjq4h5dtpbNT
	 J4aN7Ah4Cq0cvYdp1sg+azuQLV0MA5edWIH6iLvY7HlThiBF/RE/vQTUNnfNAaY8vI
	 PXID/3+lQonXL68D2U7e2h5xz8yQPZnb/Eb0yE4AQ+mNypAKx335kiI55M7DL/KOE9
	 gbGVq2t0aTEAOLY1wAbkRwDHpkaudll/i0YDH3q5jMrfntWETiKFDRUVlsKA/5dWOx
	 7eDzgCs7i6wte0Cewmk0uH+DOO4N09nYTCaWoJmCCXgAzCMwWWyFG3h2nZYL+LaGzh
	 mH1VTKK9C1X7A==
Date: Wed, 3 Jun 2026 16:08:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260603-gamma-disk-1caf00eed023@spud>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y6QvGZvgHslsllYV"
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294804-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spud:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,onsemi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2649D6396F2


--y6QvGZvgHslsllYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 05:36:16PM +0000, Selvamani Rajagopal wrote:
>=20
>=20
> > -----Original Message-----
> > Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt typ=
e to be active low,
> > level triggered
> >=20
> > > According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> > > specification, interrupt type is active low, level triggered interrup=
t.
> >=20
> > Have you checked the documentation for this device etc to make sure that
> > the device actually follows the spec?
> > Maybe Parthiban can confirm this for us?
>=20
> Though I coordinated with Parthiban well ahead about this change, He is t=
he one who could confirm.=20

Please.

Dependant on an ack from Parthiban,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> To answer your question, I looked at the datasheet. In one occasion, it m=
entions "once RESET_N is deasserted, device asserts IRQ_N.
> When software clears RESETC bit of OA_STATUS0, device deasserts IRQ_N. Th=
is gives me an indication that the interrupt is level triggered.
>=20
> From our side, I checked with our engineer, who is part of the team that =
put together the specification, Pier, copied in this email, confirmed that =
it is level triggered.
>=20
> >=20
> > Cheers,
> > Conor.
> >=20
> > >
> > > Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BAS=
E-T1S
> > MACPHY")
> > > Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.=
yaml
> > b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> > > index 61e11d4a07c4..766ff58147ae 100644
> > > --- a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> > > +++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> > > @@ -67,7 +67,7 @@ examples:
> > >          pinctrl-names =3D "default";
> > >          pinctrl-0 =3D <&eth0_pins>;
> > >          interrupt-parent =3D <&gpio>;
> > > -        interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
> > > +        interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
> > >          local-mac-address =3D [04 05 06 01 02 03];
> > >          spi-max-frequency =3D <15000000>;
> > >        };
> > >
> > > --
> > > 2.43.0
> > >
> > >
>=20

--y6QvGZvgHslsllYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiBDbgAKCRB4tDGHoIJi
0tB1AQCU3pEsNdfLGaRUgrtRloq+p+30lujwJrd/sAD6tGpJ0gEAgraP/wjiRfQ+
tvkr4sicbE/GdtNv6DfU1yBnq3BFwAI=
=BCmA
-----END PGP SIGNATURE-----

--y6QvGZvgHslsllYV--

