Return-Path: <netdev+bounces-263275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGq7EAz9pmkKcAAAu9opvQ
	(envelope-from <netdev+bounces-263275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:23:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0A1F27B0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C0C53029AE7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B548B396;
	Tue,  3 Mar 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAoBictr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031F481AB8;
	Tue,  3 Mar 2026 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550850; cv=none; b=DeNpbvMo3OXlw3p2p2G9uhhinMbY09n4W1RcCthAtV7pvX9hAwVy8qWZZhs3ww2ny5VcjioI5h1+a7ciaYlQn9W6FJNdqjhRidzYhhUOojVG3mBN4o4ucGw+hsPOdKVZ7eltIt8PYFn86tC+z4Dsh8GkNODe2uvCC3W2npCi7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550850; c=relaxed/simple;
	bh=q8Yhoxi7+IE1A7PHj8vz4yw9E24/lnWHEoBeTrLCQ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0h7sBHf4BMwdgce0XpYDoOjZCOirCIdWptq1Dy2I3dJi484JLWsfGOeu2oVzqxWN5sz5RvMaDg0oXbLUo3Pykbo4u9BM2oLgTFCMYgHAezwkwDX0/Wbq+Ms5kLHfkys9wy0YJaEIhyKpsEihZKPGprMew6TsgL39z2MdDe7fNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAoBictr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB185C2BCB4;
	Tue,  3 Mar 2026 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772550849;
	bh=q8Yhoxi7+IE1A7PHj8vz4yw9E24/lnWHEoBeTrLCQ7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAoBictrO4XMnhEynZfcJBR718wkTXWRhtZtVgC3NGGwDfeKBiEN8CZC37mWyOpNM
	 zz/dqtIXyRa7x9Qs1Bhq7NZuW6CvyjSrLRmIFnp6eGlIAlOpx/U3QUGMqZgs0CT69Z
	 K6ZFFk81YQStjvj2VkSICcPWMGsrRCenCLT0fOSKIRljF3FYjv2uJw43Re5XEpcL4Q
	 dXty1dXe7esewqHf1rudeXBLIKtuDrSPiZARpey/Zwy16w8WEOyzIpLlFF06xleWTQ
	 QaN6sH+0XnRtC0S9GDPS/p0h7YXDaCh1g3lxHtlbpZJvzGv3ZD104tP3DbDv4Pdy2J
	 dvHyk4J0OBVcQ==
Date: Tue, 3 Mar 2026 15:14:02 +0000
From: Mark Brown <broonie@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZFJd5vM8CVsa9xva"
Content-Disposition: inline
In-Reply-To: <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
X-Cookie: Use the Force, Luke.
X-Rspamd-Queue-Id: DDE0A1F27B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263275-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--ZFJd5vM8CVsa9xva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 03:12:14PM +0000, Russell King (Oracle) wrote:
> On Tue, Mar 03, 2026 at 02:22:40PM +0000, Mark Brown wrote:
> > On Tue, Mar 03, 2026 at 02:54:27PM +0100, Romain Gantois wrote:

> > > If phandles to receiver and/or transmitter regulators for an SFP device are
> > > found, enable them at probe time.

> > The driver should unconditionally request whatever power the device
> > needs.

> ... and then we break everyone, just like you broke SATA, and I've
> never forgiven you for taking a principled line on this rather than a
> pragmatic approach. You're making the same mistake here.

Sorry, what's the breakage here?  The log messages, or something else?

--ZFJd5vM8CVsa9xva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmm+rkACgkQJNaLcl1U
h9CRSQf+IrzhYUxFlRBk3BpGyWg0HcCkNww1FUyWm1I/8IDylKE2uyh52Mz78K0R
J1d7qVdmo356qfGcUkXAw2XxxZXZjxMsiewbw2Vefcu/q1N4TEKK5e0lOXlyrAQc
Rdn+4Y2fr6lmjP0k+VIBZhMUuPIhNSaOKEFsedu600Mc8YpYRGhTKDkylTfzfWTU
/dIrKxIn8/YXpHyJzHELlmjOGR923T51qOTE3zABoxMOxVPksrqas621z5U9G10D
+kSWTZ7PvoodL7dGa5IjdaAVctholrY2e37p5A9DBGwxHmxrvwcpw1vqrzLgNXIF
3YYxb/EogdLxbMUpmczC47OJJV934w==
=Km+u
-----END PGP SIGNATURE-----

--ZFJd5vM8CVsa9xva--

