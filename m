Return-Path: <netdev+bounces-266554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJW3Nng9sWmAswIAu9opvQ
	(envelope-from <netdev+bounces-266554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:01:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A057261A0A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB096342D97E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206853C942D;
	Wed, 11 Mar 2026 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/2CnPIi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF43B6341
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220940; cv=none; b=IH4nzUzjGjO6TXwATC2oWFmdj7jHg+5N4ABeAr8KYm+7lb+9AFmVOEhAlaAWMcE0+PILTyP4Dy0HbVMIyjdzVBFxRIsuz/BLREv1O1Q2nNsdvTo5WOSMP2vrFxqih+REX1xmTt2EP8sA4/q3DURWcJJdupN0aoBLI1pSH3lO04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220940; c=relaxed/simple;
	bh=nwnCtT5rZ3SSPWoE89WolsuErn7PYGAmzNRkH08jgUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qev3VL2CF8rDbW9e8VabWTjc+7h/JWXRouVjiexFHcTJNPpHiAvPGNdAM5wIMFjavk9hx6peB/jitDa180mjtOlkqakLhsyYrzKaJtJCdvxd/uruITtwxrSDcmeirq8XZN5mzYYTCBgf6CG28HPJf0vTNl0qgelPECtzHhGZClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/2CnPIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33FFC2BC86;
	Wed, 11 Mar 2026 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773220940;
	bh=nwnCtT5rZ3SSPWoE89WolsuErn7PYGAmzNRkH08jgUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/2CnPIiAqT7y1RVDWt9iUjtEKLmnwEx03+zlxumpTXCkKaWvDHLCtvAJUOw6rZZ4
	 PNkpSXtx1wPqFWe2IhUQkIg/4sTjSfv3Oq/7TF4W2GxvnGo0yHx5wnNa36OPtmvE6s
	 z0E3ghdYAwIqH78N4JAro3a8kMiCStUDrgIJccndQlduSX45531xA/mgOvNcJmYFwG
	 UULd0ns9woVYhi3tbaT/SrSKZpIV8vDWqMz11gHUz/Sz3HA3ExrwjxjGA68hZxsxI/
	 wQudvm/QLH3CT0uW4PCJZXga38+var0eJtERceRvSoKDpzP0QKSdqyk9hgP1cVaEV6
	 9ms/efSWQdT9A==
Date: Wed, 11 Mar 2026 09:22:16 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <20260311-hazard-laptop-c8a44ccf92f3@spud>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LgTnV1t/dKEOw+OA"
Content-Disposition: inline
In-Reply-To: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
X-Rspamd-Queue-Id: 0A057261A0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:email]
X-Rspamd-Action: no action


--LgTnV1t/dKEOw+OA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 01:07:00AM +0000, Russell King (Oracle) wrote:
> Add support for VSC8662 reporting its inband capabilities, and also
> hook to configure the PHY's inband mode.
>=20
> This fixes a regression in the macb driver caused by commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
>=20
> Reported-by: Conor Dooley <conor@kernel.org>
> Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@=
spud
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks Russell.

--LgTnV1t/dKEOw+OA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabE0SAAKCRB4tDGHoIJi
0lqiAQCzQKnZnuukKMujZN4g811hHZWJV8QtGdNcM/PXdu0ZMQD/WgNUv8RI/L59
oIeMywOYLx4luXd84ok22ZKr1ryDBQY=
=uA4P
-----END PGP SIGNATURE-----

--LgTnV1t/dKEOw+OA--

