Return-Path: <netdev+bounces-269255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKzfDxdTu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:36:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3CE2C4880
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E22B301F5E3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CC333426;
	Thu, 19 Mar 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwUaiouL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86633263B;
	Thu, 19 Mar 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884158; cv=none; b=LqxtIPrKWi51h+owyD/D6PC0GGIzRZQexHfO/erp1p5/sv9FJx9OypamgVXopA+AUgr3FFlWmK5Ni0xxBljFwO+MeC9lN5skeQj312/zlRUFjo17E0eknLD3XRwoFlCnpaQA7Of5BdYD2jfVyr1TcOTuw/Y9Cix8+MjkDURKDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884158; c=relaxed/simple;
	bh=4w28ebdGYqA8tTr4BHfNuPsWGEG6U/lm63Wl2wf0TBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVTH6aAOQVzVOdf64LzDntZtlsjRuTMV6Vm3Bwib0vUQAMP3z5A0P393jcKmV2wrzkV5ezWV9iz579yQysyKoAawoQWzhQvnZ2tHCTA1yor7Yaio2RRzeIEWF/0TXYenVGMEQ3QAy6W4Y5YQCFfxhOn6okWrfwoo2XGq0pOLccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwUaiouL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3316EC2BC9E;
	Thu, 19 Mar 2026 01:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773884157;
	bh=4w28ebdGYqA8tTr4BHfNuPsWGEG6U/lm63Wl2wf0TBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwUaiouLeCVh83DZNEfaWAqt57nbm27xrV8R81wqL+pE/3ivZvZFzoISi2L3Hq8zg
	 483CimfC2jMjhN7hbk/54ipCETlqhSX33z7TxUvNEyWHdJ85O5BjK9QBKVx1qrT0XY
	 4j0YQPQgNhDeqV1CkMQdB+jv+lvK23SF2QNH10LPzkig4NhJ6Y9nD31eteqhkkxAXU
	 vXZXErlT2YAY8q0C3JhlhEtT7HcoBbQS/UgOp6WvBJKDeuvdUtVyCeoI60dKi11Ozp
	 ZBG0HMpHCYdIRFrZeChc46p7DE55v7npzyzWF30PaRfdgeUyQvKfVt4OYSGGEWXmaG
	 u5uJ0UG0qH42Q==
Date: Thu, 19 Mar 2026 01:35:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <20260319-spearfish-styling-9918d2d2e537@spud>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
 <20260318-suspense-arming-fe118c3f15c6@spud>
 <absXy5Qmd/iHWofD@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TRfkxA2u8xk+P4Fr"
Content-Disposition: inline
In-Reply-To: <absXy5Qmd/iHWofD@bby-cbu-swbuild03.eng.microchip.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269255-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E3CE2C4880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--TRfkxA2u8xk+P4Fr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 02:23:23PM -0700, Charles Perry wrote:
> > > +
> > > +  clock-frequency: true
> >=20
> > Does this genuinely have no constraints?
>=20
> It's going to divide the input frequency by 2 to 512 (the prescaler is 8
> bit long), so assuming an input clock of 156.25 MHz, the bounds are 305KHz
> to 78MHz. The standard is 2.5MHz.
>=20
> I can add a maximum and minimum here since I do have some validation on
> this in the driver which will bail out if this is out of bound.


That sounds like a good idea, thanks.

pw-bot: changes-requested

Cheers,
Conor.

--TRfkxA2u8xk+P4Fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabtS+AAKCRB4tDGHoIJi
0iNNAP0fc5r0AJMWLrL1gpNT0MsvtIM8VnoN4U/3nEFwXGk4UgEAnchwFcZj0O8e
/nYvTkQPoEHppZ0bMSqdtbTgR0R49gs=
=+b5O
-----END PGP SIGNATURE-----

--TRfkxA2u8xk+P4Fr--

