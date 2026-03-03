Return-Path: <netdev+bounces-263377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHDKAK8wp2kjfwAAu9opvQ
	(envelope-from <netdev+bounces-263377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:04:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31781F59D6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB891300D4F5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74913845AE;
	Tue,  3 Mar 2026 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIQSYG+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA4377EA1;
	Tue,  3 Mar 2026 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564649; cv=none; b=Gb9/UvkMk6wF80NmHyi+ILvUk587Bf8/Jm8qhIfdVIRTdPwTGxCOJ+HOJIGCCQ5u99b8I7PeEuAEN8V8VLI0zbMtuv5bOKJU5WF1nvy04QIh7pL/NfbnI+79ewpBR/72b+AqjCvzvaq7ImwLo2fWvWng2xTJ019Gdsc0LUTejR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564649; c=relaxed/simple;
	bh=Ls5d0F6utRyv7s9aWgBon26Vc6hhPSXQBepnMUYJc28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNljJph+6qppgFS9ztWK0/N7X1YsiGH4jfTGjeOLbVOgBWSL3r6w07Qa1retO5p4QHukIXXy0mh0UEZkzE7yTeRjjaoOwaQeyN06TR8l5G3c7OB4H8fLr7WFr5RSruD/Z14BX/0k+T/rvA6QCbJNbGf618RxRSkVIW4v0KBUnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIQSYG+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64B2C116C6;
	Tue,  3 Mar 2026 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772564649;
	bh=Ls5d0F6utRyv7s9aWgBon26Vc6hhPSXQBepnMUYJc28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIQSYG+rFjYV7pnNtO/c6aFPT2Pnk5SSDc4JN83WBDNm/g1VUtfDR2tt097i+kJSQ
	 kzJp6tJI1sXZoGkVZ34ue6qqtUqzgVxS6bX84EW2fwHPPaOB8ByhqWjOjaWj+avr6p
	 cGyx4cDOwsqeWjT3vJuS7nsGacsulHiS/swKh9Zd2DHdLwmxFVRpImIStoY9gnX59/
	 AmX9fESwe1twnsyznXH5YedP325ZQoNUVJgTfN9X/7mzfj2FdLHp0n6VWydgBHbUtN
	 4j0AfU4DlC33N37s26ZbVSQHrGyS5MCQytDq1mmlAlK19cKX1Oz34MckK5lPKUY3MK
	 DHRUxpzks7ANA==
Date: Tue, 3 Mar 2026 19:04:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
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
Message-ID: <20260303-mosaic-debate-90cf8c8bbb33@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mDeycmnSpjEBNjAk"
Content-Disposition: inline
In-Reply-To: <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
X-Rspamd-Queue-Id: F31781F59D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263377-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--mDeycmnSpjEBNjAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > +        properties:
> > +          microchip,led-drive-mode:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            description: |
> > +              Set the LED drive mode for the copper PHY associated with
> > +              this port.
> > +
> > +                0 - LED1 and LED2 in open-drain mode
> > +                1 - LED1 in active drive mode (can be used for single-=
LED
> > +                    configurations requiring active drive)
> > +                2 - Reserved
> > +                3 - LED1 and LED2 in active drive mode
> > +            minimum: 0
> > +            maximum: 3
>=20
> I doubt the DT Maintainers will accept that. This looks a lot like a
> value you write into a register. How are active drive and open-drain
> described in other DT bindings? Is there something you can reuse?

I had a quick look and I didn't see anything really that stood out to me
that would be a drop-in replacement.
I also tried looking in the datasheet for more information on these
modes, but I couldn't see anything obvious. For example, there were zero
hits for "drain" in either LAN9645xS or LAN9645xF datasheets.

That said, yea you're right about DT maintainer feelings about it.
There's a couple things I could suggest, but I'd like to know about what
mode 1 means for LED2 first. If there's actually nothing similar, what
about representing each led with a child node and having open-drain be
the default with a property in the child for active-drive?

>=20
> For 1, what happens to LED2? Not used at all?
>=20
>     Andrew

--mDeycmnSpjEBNjAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacwowAKCRB4tDGHoIJi
0gb4AQCWkWkmTIM8GJfJTP4My3dFk7rkxfSKzGAagdkb2xu+ywEA2x8Xwh4vxcOV
1olqF8zATG33o0OYhTOjUbJtGGAfbgM=
=iHFd
-----END PGP SIGNATURE-----

--mDeycmnSpjEBNjAk--

