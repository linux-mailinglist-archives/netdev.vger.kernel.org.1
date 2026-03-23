Return-Path: <netdev+bounces-270701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEhRKk+WwWkTUAQAu9opvQ
	(envelope-from <netdev+bounces-270701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:36:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C72FC5F9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D71D303588A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B333CEB8B;
	Mon, 23 Mar 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBvW+vHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B43CCFB4;
	Mon, 23 Mar 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294547; cv=none; b=Y1LhG4+uIdEqKlChJy0g1Eg5ZbhH54whZtGOL2z+YaTYctuxNxgacQeDvQOKkRiqQFRZzWGcFLZ5+RBuqHMUhTfoBGfUjXtjS15fjx692zVPiu6kvERuFuN2Qtzk+otx/ah8caPdRjjrjCPcBv7R3VkSLysmYyuo4e1LwVJPhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294547; c=relaxed/simple;
	bh=bOvcY+CJn/YkEPr120Z/mLaUY5shLsNKNM8vnqAvUIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhtluI/uzXUaWN9izd85nLR+ES0WzfSKbeT+ydJp6TKwBLIXmY4X7aTa1m6zEm/dIyZY6xWNA3NiWgIqaBrNhMdtJ5VoJ/JJJDG6ylLP44S+bCdZ9BDlbYcN4ouID1i0dmUHkvrAJ/YVRgKrgWlkOe1dJe5k6F/tI+q5b327eEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBvW+vHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB101C4CEF7;
	Mon, 23 Mar 2026 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294546;
	bh=bOvcY+CJn/YkEPr120Z/mLaUY5shLsNKNM8vnqAvUIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBvW+vHn2nfbL7wFiljbPTgIvioJVTlNnjxQGvxQ6iZCsyLCX/E+4Rz+MXH1iRRvt
	 4nwHdyqbPNsf/lTVQ+XZpUnqju9dvDCLtFPFMTrQzd0OcHO8CFgGZd7J4hTbyIenyo
	 D0mr0J7uv66LxroNb9NDBBjIZVk3rdzOdxYCSUuWTwlwTYWBeqTw9OlcjOUVN/hWw0
	 DrlefhNSltKwwwrZ/cjCyAJEsde+hkwZUKCLsYVp0ZFYlFozNy9Nluy5P0CwK1Ib5I
	 aauAKupycE8N0H5jqEeE4ayeZd5vqvsD3CFyiiJIE6/9GXgVTbzm/kPHbzt2DYI+gq
	 DrpgZtsdgEC0g==
Date: Mon, 23 Mar 2026 19:35:41 +0000
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
Message-ID: <20260323-numbness-murky-6ad25f9ac5d7@spud>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
 <20260318-suspense-arming-fe118c3f15c6@spud>
 <absXy5Qmd/iHWofD@bby-cbu-swbuild03.eng.microchip.com>
 <20260319-spearfish-styling-9918d2d2e537@spud>
 <acFCPnia+riDwvJJ@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpKQuGiqgczD1gfA"
Content-Disposition: inline
In-Reply-To: <acFCPnia+riDwvJJ@bby-cbu-swbuild03.eng.microchip.com>
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
	TAGGED_FROM(0.00)[bounces-270701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 699C72FC5F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jpKQuGiqgczD1gfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 06:38:06AM -0700, Charles Perry wrote:
> On Thu, Mar 19, 2026 at 01:35:52AM +0000, Conor Dooley wrote:
> > On Wed, Mar 18, 2026 at 02:23:23PM -0700, Charles Perry wrote:
> > > > > +
> > > > > +  clock-frequency: true
> > > >=20
> > > > Does this genuinely have no constraints?
> > >=20
> > > It's going to divide the input frequency by 2 to 512 (the prescaler i=
s 8
> > > bit long), so assuming an input clock of 156.25 MHz, the bounds are 3=
05KHz
> > > to 78MHz. The standard is 2.5MHz.
> > >=20
> > > I can add a maximum and minimum here since I do have some validation =
on
> > > this in the driver which will bail out if this is out of bound.
>=20
> Hello Conor,
>=20
> I have second doubt about this. The minimum and maximum depend on the inp=
ut
> clock frequency which might change if someone uses a different crystal or
> clock config. So for that reason, I thinks it's better to not specify the
> bounds, because there's no way to know for sure what they when building t=
he
> device tree.

Okay, sure.

--jpKQuGiqgczD1gfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacGWDQAKCRB4tDGHoIJi
0jrtAQCZMRvPThiu1SYnhUZTAjlqGS0mO0P0RjJuBQQThO+nqgD/XanqfuNWh/lj
EKy/WvnuNeJHY8g0dFjHZ7qOpIg6Dg8=
=ljJk
-----END PGP SIGNATURE-----

--jpKQuGiqgczD1gfA--

