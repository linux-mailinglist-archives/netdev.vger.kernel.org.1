Return-Path: <netdev+bounces-292778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLA4EkF5GGqxkQgAu9opvQ
	(envelope-from <netdev+bounces-292778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECD5F58B6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 712AA300BD4B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129B3F88A2;
	Thu, 28 May 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAG0EfBP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BA28727D;
	Thu, 28 May 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988725; cv=none; b=gIyMSjyYk4arvFykMwpvKC0Q3qLfDSwwgcj6icWZ5jPplVFihquf8OQ2NAh6+f5JUWEnost0zGNKdBO5WpE4qiNtO7dYh7obTPMv0ZaKyyL9L3sMSC84wZxkGkNbC820qWLREox8GrZMHory2Qutwi0K6BKM8bqtvgiP09aQfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988725; c=relaxed/simple;
	bh=/HbR0QGskg8/wk9msa78HaN680ohxDzq+HSK6sdp0GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxuuG6AnCL/4nZB8P2081As6LzVa8cDtEi8ydFK4LbQBo+luCTvXMHPru85B4KwQoZFA80rmWaEZKDicUA0pa4nFx0bf5oHZ4aJivFPzrT/6kf6rxlmzyn8wUC64hlgXjOMWFbDRFcD4tTf6v+lTaf7vOGdOKbYjPg6ziclUfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAG0EfBP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E94C1F000E9;
	Thu, 28 May 2026 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779988724;
	bh=6EVMSybi3rbZqC5wP14LRh21sOUpXfetPVkMcTMGv7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fAG0EfBPCLf4hO3rJkAHVfoRY4N8C/0euUqvv9Fe6G9LNgZkhdvLOpazzhOnrAOwz
	 66kUwsAG+0piGbBxr39oi5gcqSXZi4+RhbB8QN7nh0u+CSGnpZVxwF1UTrUNk63ccX
	 XHPEv049HnHRj9V6iCp5ogUSirl9/NzlsjaUpDdEP4PP3DHVHq+az7S62V9wAA9Y3o
	 UFyHRgbSt3rb9d9IU5HXfXwVIVeuhcMnDJENqweJar4WnI1C9mIl4YQFDcX0AwM0Zn
	 9vdDTpTMSsRbLuGwysf3Uh3t++CkGYteQobr5fPD/lFo+RCFdZQlaNPnJ/OujvrBJJ
	 gwat0Srkr8K/Q==
Date: Thu, 28 May 2026 18:18:38 +0100
From: Conor Dooley <conor@kernel.org>
To: "Regus, Ciprian" <Ciprian.Regus@analog.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 01/10] dt-bindings: net: Add ADIN1140
Message-ID: <20260528-slick-deprive-cc1b83031336@spud>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-1-37e5c8d4e0a0@analog.com>
 <20260527-nearness-antacid-9f94a3f43abc@spud>
 <925d1903a01a44d8ac61b1302a820e6a@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="thpfhmrY2Klzm+AB"
Content-Disposition: inline
In-Reply-To: <925d1903a01a44d8ac61b1302a820e6a@analog.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292778-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4FECD5F58B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--thpfhmrY2Klzm+AB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 04:46:54PM +0000, Regus, Ciprian wrote:
> > > +title: ADI ADIN1140 10BASE-T1S MAC-PHY
> > > +
> > > +maintainers:
> > > +  - Ciprian Regus <ciprian.regus@analog.com>
> > > +
> > > +description: |
> > > +  The ADIN1140 (also called AD3306) is a low power single port
> >=20
> > Can you explain what is going on here please?
> > Is "adin1140" (which I can find no information easily online for) the
> > exact same device as the ad3306 (which has an entry on your site)?
>=20
> The adin1140 is an upcoming version of ad3306 that lacks some
> (stress test) qualifications, but otherwise they are the exact same die.
>=20
> >=20
> > > +  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
> > > +  and all the associated analog circuitry.
> > > +  The device tries to implement the Open Alliance TC6 10BASE-T1x MAC-
> > PHY
> > > +  Serial Interface specification and is compliant with the
> > > +  IEEE 802.3cg-2019 Ethernet standard for 10 Mbps single pair
> > > +  Ethernet (SPE). The device has a 4-wire SPI interface for
> > > +  communication between the MAC and host processor.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/net/ethernet-controller.yaml#
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad3306
> > > +      - adi,adin1140
> >=20
> > Because if they are really two names for the same part, this compatible
> > setup makes no sense, as it means they have a different programming
> > models.
>=20
> Since they have the same programming model, should I just keep the adi,ad=
in1140
> entry?

If the ad3306 was the existing device, probably it should be the
compatible you keep, if you remove any.
Otherwise, just permit ad3306 as a fallback for adin1140:

compatible:
  oneOf:
    - items:
        - const: adi,adin1140
        - const: adi,ad3306
    - const: adi,ad3306

>=20
> >=20
> > Thanks,
> > Conor.
> >=20
>=20

--thpfhmrY2Klzm+AB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahh47gAKCRB4tDGHoIJi
0syoAQCSZ6Ql3ZQUOEPqUPZoCTiDFk9wmUSGrB2Lt8R8pPZhPQD+Ow3lHtoQ+oq/
SHRRCHhtQIF7VOhO4ayQKfT/UtYgjAE=
=0USY
-----END PGP SIGNATURE-----

--thpfhmrY2Klzm+AB--

