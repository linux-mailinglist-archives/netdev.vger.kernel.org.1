Return-Path: <netdev+bounces-263341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCyjGBkbp2m+dgAAu9opvQ
	(envelope-from <netdev+bounces-263341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:32:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF671F4A5E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4BDE3038149
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07063ED5A3;
	Tue,  3 Mar 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayMZEOCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A9370D61;
	Tue,  3 Mar 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559103; cv=none; b=kWw98nu29A5nF0tLF9iNoDuwTL1IgYvG/GsnkRruYqSZyde1qyc1qJcBtO8EpEYsc74obBK4TeiFKOVz5e1HZfcD83ugo6CYZmYi6rXK5fyyeuvLPHNEI2epxRdbooVujqW5TOuHGXQsRmYDyCRrK1XecCusOor9eVJvMF2E5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559103; c=relaxed/simple;
	bh=pY5n2w8jxdL8cFzyns9wivOokBIq3asBNiks807SDUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUiBft8SJExJxtbAHiB2PW23fGzsGZOarqXn6VbwK0KsxWaaL37vm0qoHG7GEpKXd3gHcjZ379+1hodMrpr5ULaCiyV7eXX/A27d0ZjSkfSFiVXSKc8IMLTvv3yu0Rw15tDOocP+TuRyJjUPyvx9pyurnUX3GcABgKOoD2LR+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayMZEOCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC311C116C6;
	Tue,  3 Mar 2026 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772559103;
	bh=pY5n2w8jxdL8cFzyns9wivOokBIq3asBNiks807SDUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayMZEOCxp4r1d+JFjs7Mm76K0BMM3upfkBAEHAFiVYnbgldtosNDL2ucp1UO/lJy8
	 rhP1E0u94SpIpXMTCc1PzxUoZpsOB4D1R+BfM0pIUMLb/v9WhCxl5vwNjUW93mwMWl
	 6EurA1MTmL394eqa44VQS/5y7DsepQNUvPhzAGANVZOSYASOEGI7gNI9ff52UTcJNC
	 ZFEBLIIyNyXayUpvY9DFZBiI/F0vZSkL2W0ruct4DyODpMA0t0T/HpiPaSjahEps0N
	 c0XxRn8hqohG2oKRIFStvn46KIok2/eDSyjJwFks2NLQy6UC7loA/fj/CMx0izdu31
	 NADfVK/XbCCsg==
Date: Tue, 3 Mar 2026 17:31:36 +0000
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
Message-ID: <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
 <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
 <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2KMOK4Ft/U2Z0A+"
Content-Disposition: inline
In-Reply-To: <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
X-Cookie: Use the Force, Luke.
X-Rspamd-Queue-Id: BAF671F4A5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263341-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--u2KMOK4Ft/U2Z0A+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 03:25:35PM +0000, Russell King (Oracle) wrote:
> On Tue, Mar 03, 2026 at 03:14:02PM +0000, Mark Brown wrote:

> > Sorry, what's the breakage here?  The log messages, or something else?

> ... which then caused someone to "fix" DT by disabling devices to shut
> up those log messages, including for platforms where those devices were
> being used, which ultimately caused a boot failure.

> ... and your argument that SATA PHYs need these supplies, which is false
> when the SATA PHY is integrated into the SoC and there's no details on
> what those supplies are or where they come from, or even if they are
> controllable.

The supplies don't need to be controllable or have any other information
to be specified, it sounds like this hardware has a fixed voltage
regulator that's supplying the PHY which is representable without any
changes, though I do agree it's annoying.

Though having said that with your description above I'm really not clear
that the regulator support is in the right place in the SATA framework
at all, it sounds like the supplies are being requested by the SATA
controller but the expectation is that the SATA controller is the thing
that is supplying power rather than consuming it.  I think that's where
things are going wrong here?  There are some SATA implementations that
don't include the power delivery part of SATA and only those require the
supplies?  The logs you posted looked like it was controllers requesting
the supplies which does look like the bindings and associated requests
aren't what I'd expect for something describing the hardware.

For SFP my understanding is that SFP has a physical specification which
includes power inputs and that these supplies are being requested by the
devices that consume them.  If some part of that is not the case then it
sounds like the bindings aren't describing the hardware (or at least are
a bit unclear about how they're doing so) and should be revised.  The
series doesn't seem to do anything at all with the supply side either,
I'm guessing there are some SFP controllers with integrated power
provisioning.

--u2KMOK4Ft/U2Z0A+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmnGvcACgkQJNaLcl1U
h9ClPQf+KoZchX4uxx9PwHMnQmvsfiSbR/ULKTz9o+AwC9GPuXRw8Un/rSp7FTQW
5GAgU0fSIq9CYaSf9x4JfovQPeSMQhLli1tuow+uJg5pMzyBmaX8c2uk7rMmQbHk
iRkaT07l6/zFEdhoGZ/ZsibclP9oJmxpG+xkdnjDElS5TU14XxtlYd7A6Hs3l6VU
mMsMmBCFIBxlWQWaS0pg713dbSo+knym6T5Uvb/UAHxZsLCrcouSwJeSIQTRodhV
GRpyjfa4YoOPM8krXd32+Q838CaX4wxbAQQMiIwVPs4yizdW3RTdE1IxjiWzhCrU
WU/YzmPwkGXDxlvMzOQqtJ+ItyNemQ==
=wqtY
-----END PGP SIGNATURE-----

--u2KMOK4Ft/U2Z0A+--

