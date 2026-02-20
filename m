Return-Path: <netdev+bounces-259783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GeiI5XZmGkSNgMAu9opvQ
	(envelope-from <netdev+bounces-259783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:00:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E716B172
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A5A302FAAD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769972F3C30;
	Fri, 20 Feb 2026 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svX6zwOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80B24DCE5;
	Fri, 20 Feb 2026 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624849; cv=none; b=F2a/YzdWTMqldfKSKID6AbVsb8Tjjl6WAIxfImgdlvNwgs+1KA5aLmUgkzK9Q3kteJw0K2jwNv95+9CqktmWdGeN1UK4EwDJA2uoLn1tsiI2/zWbIEQRFZTQUpR8tF6CF4WYtCxV2UtOS8rDWXt4FbVC7mmVLA0vyLVe3Sibii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624849; c=relaxed/simple;
	bh=j8ewDZamzs1TUqrD98btJHbb2prX1tgCIDCSHXyKP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSEvoAK0deYT9/2IFcnUAErFV55ewvXxNNeqwgN/0aVOw6CJYdfn6TDxf/CgS/b+rmMMiVLcm+EJvnwv4dCG1nGzA7iq+OKO1nwYqjzV1AgfdFlCRoIhkxSsgEiCxOntyk+ZSbcc1PMwG3oAP//9XguWYRGgRxQCVDjOvqUFMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svX6zwOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05829C116C6;
	Fri, 20 Feb 2026 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771624849;
	bh=j8ewDZamzs1TUqrD98btJHbb2prX1tgCIDCSHXyKP0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svX6zwOaYzJn1xmxcW4F3TCS53OmLgF9S4IfY5MLZ9Awz2faOYHVqXgrtO5KzI/aN
	 tMO1jyfo9oo2ArMO0nOZ9IWZsUBZrpEaeE/lx+nFVBrMlM0Dtdmca2wE9iT4Bs27Qr
	 FWM0tICDnXU7z8Tta2YyudsmnXCi1bg7HipnwVpRRqp7bUBkdbqXPCBmCH1y01RDLa
	 nFSUhGIfqgph98KbTIDHblrfmwAZFkMKoe/IPCGv+AoKTzW6NSZN9u0R0YhwqxUtNQ
	 pjcq0RPyQJuuv+jQj/AvZ9H6kg0gRM1fnS3Q7q2x/OMr142BnQH/suq6Mb5e2oxSyl
	 ZdRne+uuPFfqw==
Date: Fri, 20 Feb 2026 22:00:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Max Hsu <max.hsu@sifive.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 3/5] net: macb: Add support for SiFive FU740-C000
Message-ID: <20260220-backtrack-saturday-b85344cd5eb6@spud>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
 <20260220-fu740-v1-3-c8af54130c58@sifive.com>
 <45821cd4-214c-43c0-ab2d-bbf34d9ec911@lunn.ch>
 <CAHibDyzQAWgGP9sktLtnpND-Qr6FRrTA=HEiweyDD6rWm=8=5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="owSUAfZltS+zhmwj"
Content-Disposition: inline
In-Reply-To: <CAHibDyzQAWgGP9sktLtnpND-Qr6FRrTA=HEiweyDD6rWm=8=5g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259783-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E81E716B172
X-Rspamd-Action: no action


--owSUAfZltS+zhmwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 02:35:03AM +0800, Max Hsu wrote:
> Thanks for the review, Andrew!
>=20
> Based on Conor's feedback on patch 1, I'll be dropping this patch entirely
> in v2. Instead, I'll use a fallback compatible string pattern
> ("sifive,fu740-c000-gem", "sifive,fu540-c000-gem") in the device tree,
> which makes this driver change redundant.
>=20
> Since there will be no net subsystem changes in v2, the series will go
> through the devicetree and RISC-V trees instead.

Nope, you still have one patch for net - the dt-binding for the macb
goes via net. Nothing in this series goes via devicetree or RISC-V trees
either.
Generally, bindings go through driver trees and dts patches go through
the soc tree.

Cheers,
Conor.

--owSUAfZltS+zhmwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZjZigAKCRB4tDGHoIJi
0ppkAQDELcLSGsd9+CZKBIRTpROITc+zabzoqZ2zjM8e+CEGYAEAuTFkDeKn4vsG
nyHlHlHuc1eRatDuaFWmAN81FiAvBAg=
=gWwp
-----END PGP SIGNATURE-----

--owSUAfZltS+zhmwj--

