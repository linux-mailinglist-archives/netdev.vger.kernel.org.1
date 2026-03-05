Return-Path: <netdev+bounces-264513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHCKGATMqWl+FQEAu9opvQ
	(envelope-from <netdev+bounces-264513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:31:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0121216FB4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BAFC3050213
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E112BDC1B;
	Thu,  5 Mar 2026 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjh2FJ7q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE21F3FED;
	Thu,  5 Mar 2026 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735488; cv=none; b=rKwD5fyhE+dZpDmtmDus2Abi2hHtdl/5jEhtvY8DseJOEyUgcs7m2QWPG1Ov3CKeUJPHbKfq8p/s/P1iOeOpmhNZX2QhEvFTw5UoTYRyNlmTYvaIkHHTYWoCOYdZfXTFrT9CFsQain3XUJTCq/lyw0Oxz6/Oxf9I9r/wNUlPbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735488; c=relaxed/simple;
	bh=AQVfJhoX1BRMgRzZzFWFIZQ56LXVONFDmF13tEmWmSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVVy8AqvtRuGNZsx3FdXlX8QBWtDm/a1hPQyR9wUQYj2L1FVTTk+jKbHzQkEwml1fWlPEZdLPfn+Qpvm81w9oyUA708XSiWy7pkO3pzU5nfr+cVdeQ+/A+X1iRbxuuGEduzdpq8TfZHBjVjzFmcc9ccUk8EJ4HKrJw/OBsPSoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjh2FJ7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE657C116C6;
	Thu,  5 Mar 2026 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772735488;
	bh=AQVfJhoX1BRMgRzZzFWFIZQ56LXVONFDmF13tEmWmSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjh2FJ7qh1/63/jpE7NBwK7OIRaYt5jVAG/eg24hM9oYj6yXxFAlfWXkwwWrCJMWm
	 UygLmkaECtHLcntqlTzMXnKBOtdK1axNJJHx4sy0SHEEJuRx1kK9FBFOserhnWE6QV
	 lOF4KDK3onan0UlJC7q6tzgPzuzRvfk7i06l7IHSQTEU2Kpkgew/9qr5eeIBOpCh4B
	 v62451+SUL4jfaWoKczRbWs4eFuFI2Ay88TOMEKbAOXo9kHeyuCxbmzmWk+mfCD5ea
	 Z1qI8MU5NtwNbXxAVVhbejHQrMs6Ydv0KW1xWABGqcD+O3zxHZDZi9gki9zZBxzG7A
	 ihn6IGwC/02SA==
Date: Thu, 5 Mar 2026 18:31:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <20260305-reliant-parchment-0ff685a9c78e@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
 <20260303-mosaic-debate-90cf8c8bbb33@spud>
 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U36N4Du8wU9KvAZH"
Content-Disposition: inline
In-Reply-To: <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
X-Rspamd-Queue-Id: C0121216FB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-264513-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--U36N4Du8wU9KvAZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Ostergaard wrote:
> On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > > +        properties:
> > > > +          microchip,led-drive-mode:
> > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > > +            description: |
> > > > +              Set the LED drive mode for the copper PHY associated=
 with
> > > > +              this port.
> > > > +
> > > > +                0 - LED1 and LED2 in open-drain mode
> > > > +                1 - LED1 in active drive mode (can be used for sin=
gle-LED
> > > > +                    configurations requiring active drive)
> > > > +                2 - Reserved
> > > > +                3 - LED1 and LED2 in active drive mode
> > > > +            minimum: 0
> > > > +            maximum: 3
> > >=20
> > > I doubt the DT Maintainers will accept that. This looks a lot like a
> > > value you write into a register. How are active drive and open-drain
> > > described in other DT bindings? Is there something you can reuse?
> >=20
> > I had a quick look and I didn't see anything really that stood out to me
> > that would be a drop-in replacement.
> > I also tried looking in the datasheet for more information on these
> > modes, but I couldn't see anything obvious. For example, there were zero
> > hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
> >=20
> > That said, yea you're right about DT maintainer feelings about it.
> > There's a couple things I could suggest, but I'd like to know about what
> > mode 1 means for LED2 first. If there's actually nothing similar, what
> > about representing each led with a child node and having open-drain be
> > the default with a property in the child for active-drive?
> >=20
> > >=20
> > > For 1, what happens to LED2? Not used at all?
>=20
> In mode 1 LED2 will be open-drain. This mode only makes sense if you have
> just 1 LED. With two LEDs mode 0 or mode 3 should be used.

Could we then have child nodes for each led, and have a property in each
that sets the mode to either open-drain or active-drive? Or am I just
inserting complexity by asking for that?

--U36N4Du8wU9KvAZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaanL+gAKCRB4tDGHoIJi
0tfIAP9B7qfOus/9VKdwPQXPg9Zhl8gG3TahJc3f6gjl3NDgWgEAmKVBQLZILMPo
fgRdfpOBD5HexrCxMTk5nAOkDBg0qAA=
=eDyb
-----END PGP SIGNATURE-----

--U36N4Du8wU9KvAZH--

