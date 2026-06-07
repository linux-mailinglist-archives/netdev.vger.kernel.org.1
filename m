Return-Path: <netdev+bounces-296288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uU8UNQK0JWrOKgIAu9opvQ
	(envelope-from <netdev+bounces-296288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:10:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C74651345
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:10:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I4Yl6IzY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296288-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296288-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4935D300F5F5
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C18282F02;
	Sun,  7 Jun 2026 18:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534AC23395E
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 18:07:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855661; cv=none; b=fsxVGmNjKft05T1UCX3+L8caAGDj1W2eD3nuiihCiQGfGOSMSsZJhRpHlnlCximbJEQWP99AtOq3BX+hwS13o/4lZ5pMAsUpZtu42GizVOlxf9yJmD2TD1MxZeysNiFAHjWIX2YN6zU90C1qeEQE9XL8FseyHJ9dNuhbISAneTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855661; c=relaxed/simple;
	bh=PQM4GYYc63X3V6cnm9lbwspw+o8AmiO+ug+JwhEds3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC9vKtsIJsaslkgffBDweKAyMWY94Hm8StgdNnHJS4UR+rWp0s7DO1Ul27hCENr4yol21tjUtWskQXODj0GPFuyETU9o5J1O8uc4c+T3NU4IqEnWrJYCcXb5OugjaUnzEpMvBQRkFyrVCU/Xyn6kG2hhV/QvgmKXKrYNLbRrLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4Yl6IzY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7438F1F00893;
	Sun,  7 Jun 2026 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780855660;
	bh=qi2ck4KPgoc5FG6O8jbWnIUyAELMxFVIS/GHtqRzVs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I4Yl6IzYIbSWSpv3sD5o/fo+Uc87bLpZUzq1wVqWHOIo36fhbZ0br5jXODPptLCi+
	 kD+34FnAivaxqA77xZzX0Rr0E5XVqP2VU4FHNWVSkJ82oyVat1x58btX3ramkcKvTv
	 2YoMfCNb9ql3jZwh3xN958p4y6O+DXufoeAFsE4UquJ5h/wXYlJdfCVTD1Za78sMUT
	 +To3CBtsBnNh63tTeP1ogeT14u6t36JUO9ziVqk7WXcIfoxXlhW5dLR4GvrNz4H0rs
	 dfhqGioicQC+oXa2RAb9cpA4MOfEsxWNpoXkmwh251djGic5+AcVAc3QoJ4pXaZjUX
	 WZ0oR7wKC96sQ==
Date: Sun, 7 Jun 2026 20:07:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v2] net: airoha: add ethtool priv_flags support
 for LAN/WAN and GDM2 loopback
Message-ID: <aiWzaV1f1Fpc2rhJ@lore-desk>
References: <20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org>
 <33c3a87d-ad97-4f6a-8f76-ebab80c496ac@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FDYc2oFp0P5PYaqK"
Content-Disposition: inline
In-Reply-To: <33c3a87d-ad97-4f6a-8f76-ebab80c496ac@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296288-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29C74651345


--FDYc2oFp0P5PYaqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > When a GDM3/GDM4 port is set to WAN mode, enable GDM2 loopback to
> > support hardware QoS. Conversely, when switching back to LAN mode,
> > disable the GDM2 loopback and restore the default forwarding
> > configuration.
>=20
> Why not just use the presence of an off loadable qdisc as the
> indicator to change mode?

Hi Andrew,

Interesting, can you please provide more details about you mean?

Regards,
Lorenzo

>=20
> 	  Andrew

--FDYc2oFp0P5PYaqK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiWzaQAKCRA6cBh0uS2t
rBgqAQCqcFqDzywecN1kArDNW6bODjr34Zqph7c6FCUcVU4HRQD/aSPSKpVPnX+5
N3ol6cuoilM77IyMeZX43ObBeGoPrAs=
=QEdK
-----END PGP SIGNATURE-----

--FDYc2oFp0P5PYaqK--

