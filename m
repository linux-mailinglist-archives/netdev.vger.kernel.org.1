Return-Path: <netdev+bounces-292624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDTUMw0LGGpzbAgAu9opvQ
	(envelope-from <netdev+bounces-292624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9665EF984
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAAC7302304D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702973ACF0B;
	Thu, 28 May 2026 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1a69PTM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D54384CFF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960283; cv=none; b=jWlduwpSr96nKW9ey77gt2aJ3nJ8kxHpAFTHze8ROEjrSKy8ewtuii+8jYYjT62I8UFMP/KJNphmr7qqCQaW+4g9ABFTinddfGwCHAny1Za6HbcWupH4lblxACLx4wGoQYSF16rlPSEMrkwjNcGJtvUGhzzkbXPN+jya7ua3CL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960283; c=relaxed/simple;
	bh=vhzUQ1m6c8j4UajbX01EgK8RDo85toB9lWbN0FKjo40=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=fHP/aJbNAQreIphA/E5NIAMvLjiwyP8Rz3MSNDUhYFlLrouUnMT+a1+z8Mmn0Lo5jF7hu6SB5xkwV4bk/Lr1dglzpSfkaKwvYUcMvu9dG+ZPFApbzwSAc0yU8OctBkIIg0KIU0reBd2iehSH9/ZpjTADVYfIUuau/3EFZPKcxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1a69PTM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5038F1F000E9;
	Thu, 28 May 2026 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960281;
	bh=+4OeeSFA61rnzlH+5nXGv+Ltllk86hfMy+9IPw4Mspo=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=g1a69PTMhA7UzFUhIw3rljyUVJWE8j9SNNC+UXSoZ9pt9DzIvaj8jUM3VT7Hh+LLL
	 0O2rU7K4s439CcmW3JrQbxdywrQbwmLMyVr+XVQZpAqH3C7M6ehd9/qLKDjRkaydCE
	 5X0HuiBXqKMgXn8U6de8b5Ofl3cDkfDC+CQvoD7+XlgTqKynGzS9jJWpDkGj0BQ0MO
	 O59tngxqREtQob8QHQpuxWf3l0uaziLvCMTc6cu8ZOfq8MBOlTacjM4nOzbgzO5HaD
	 NVwKg7VFxqjpT5gB2OHAA2EsFFmg04zTYrvJigmp8KxZPFjorncolSmjQi9Vyf6HAu
	 HFsjE2VX91ECg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ed838cd1a8776029ff3df7628116bc9ae8dee180d1ce6380de2a0d32bfe3;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 28 May 2026 11:24:37 +0200
Message-Id: <DIU79B74YFW6.1NBOTHFQQ65A5@kernel.org>
Subject: Re: phylink and an unusual PHY/SFP setup
Cc: "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.20.0
References: <DITB8QZ1OEQF.327XUI9E0SXQ3@kernel.org>
 <061815ee-e95e-4723-aa2a-d84bc3ad6233@lunn.ch>
In-Reply-To: <061815ee-e95e-4723-aa2a-d84bc3ad6233@lunn.ch>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292624-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E9665EF984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--ed838cd1a8776029ff3df7628116bc9ae8dee180d1ce6380de2a0d32bfe3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Andrew,

On Wed May 27, 2026 at 3:35 PM CEST, Andrew Lunn wrote:
> On Wed, May 27, 2026 at 10:19:18AM +0200, Michael Walle wrote:
>> Hi,
>>=20
>> I have a board with a rather unusual network link setup:
>>=20
>>  MAC/PCS (fman) <-SerDes-> PHY (M88E1112) <-SerDes-> SFP
>>=20
>> or even
>>=20
>>  MAC/PCS (fman) <-SerDes-> PHY (M88E1112) <-SerDes-> Copper SFP with PHY
>
> Such setups do exist already, but with a different PHY. The Marvel 10G
> PHY is sometimes placed in the middle like this. And there are other
> PHYs.
>
> Take a look at
>
> commit 35d1a5464b476aa98b7b76ce41bb4de748cebfc2
> Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Date:   Thu Jan 8 09:00:35 2026 +0100
>
>     net: phy: marvell10g: Support SFP through phy_port
>    =20
>     Convert the Marvell10G driver to use the generic SFP handling, throug=
h a
>     dedicated .attach_port() handler to populate the port's supported
>     interfaces.
>    =20
>     As the 88x3310 supports multiple MDI, the .attach_port() logic handle=
s
>     both SFP attach with 10GBaseR support, and support for the "regular"
>     port that usually is a BaseT port.
>
> Also, marvell-88x2222.c.
>
> 	Andrew

Thanks for the pointer. It looks like this can be used to support
both the Base-T port and the SerDes port of this PHY.

But I'm still trying to wrap my head around the SerDes links and
it's configuration. Basically, phylink tries to match both ends of
the link and will configure the PCS and the PHY accordingly. But in
my case, the link between the MAC/PCS and the PHY is always SGMII
(at least that's what the Marvell datasheet says). The line side of
the PHY is then either Base-T if using the copper port or 1000Base-X,
100Base-FX or SGMII on the fiber port.

If I add these modes to the possible_interfaces property, the PCS
might be configured wrong, that is, in 1000Base-X mode for example.
But it really should only be ever in SGMII mode.

-michael

--ed838cd1a8776029ff3df7628116bc9ae8dee180d1ce6380de2a0d32bfe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCahgJ1hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jYRwGAh7pM9r3v/3uu7IHm+UA28Yl4Tl39vall
QRu/csOWGlk+QbcVtmJpyJM8ANfjMm2nAYDvHYzWhf6Vs1YwMOr/ECytHvE4hTMW
WT4oGb4+nbZduMqUYMSLNdwxRrbxecHPdk4=
=Gjcm
-----END PGP SIGNATURE-----

--ed838cd1a8776029ff3df7628116bc9ae8dee180d1ce6380de2a0d32bfe3--

