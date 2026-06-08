Return-Path: <netdev+bounces-296434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dKFFDG2MJmpSYgIAu9opvQ
	(envelope-from <netdev+bounces-296434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:33:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B3654A18
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wx0nR9mo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296434-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296434-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1B9E300608F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE31330B30;
	Mon,  8 Jun 2026 09:32:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAE2E7F0A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:32:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911146; cv=none; b=n6Axp49UyZJ+ryNQBjf8HZWCvfLxlyTnKuudKCuDjTA8ttRLXsMfOtVz++kLUIvA34GCWCLwXgfAMLYkurfq/0MI3qxBYNU/3qb0xd3kXZ1zzBdV4ML9ismVfO0cvyTydwIM+iYEI6SyRotplmwqlOXj+sYva/yYAx7ysz5opeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911146; c=relaxed/simple;
	bh=rrtvF0lNcj+pHRtfwXDY3phiLJ219l2m72vOnALNy8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/gFRUJw0OUjaEtKpN9GL8BYTydoXFHcLoltqkqx9EJxy1cGf2BURyV1rzWHoMDXHs5Se/cPIkctj9s5aHfbFZ1Z1dlr/uw8MEAFH6XSZBl0AKsNH0uaNelSzxwqgxehi6exejpA1vCWnL7e4gyiY5APyqdcbURzfCmr2ec5H1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx0nR9mo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C351F00893;
	Mon,  8 Jun 2026 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780911145;
	bh=ber3utn/8EUmJVjFuWAwn9vEtzDxpWGplyIMDowu99g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wx0nR9mok/6CM2+NSHU3FRGlv4mFmxhM9+nz/9D9zYxNnja3GH/7MC2DD90ujMk2i
	 gSBpBUixI1ubPXnguTHRsGKMQ6gP5MJFR14oM77wXK6EKUsiJIwOlvWxHvhWvGXtdX
	 6ttNKVy7kDYbCO4MKiyKGM2NTYDvXKB8d/KXMaNNZpZXAEFFTsA3gDcyhtc9uvhFDG
	 F7imx4OXYr+skEUgOfBGkSLZGC/nZKciFw28FDIjFgGk4fgo0pyVqUPDSzIa33FBrW
	 mLt8vQKwtKSNoFF8tcLbL4CqwWE8vPP2QZV6DYG61HzUFftORZiWuwhIjqriCPlCOh
	 aJ9JWlkShUhhg==
Date: Mon, 8 Jun 2026 11:32:23 +0200
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
Message-ID: <aiaMJ6i4o3olQtu9@lore-desk>
References: <20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org>
 <33c3a87d-ad97-4f6a-8f76-ebab80c496ac@lunn.ch>
 <aiWzaV1f1Fpc2rhJ@lore-desk>
 <e8f3d24a-985b-4bde-9f51-2d5ae3d25b01@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adOSsypNp6f03yZM"
Content-Disposition: inline
In-Reply-To: <e8f3d24a-985b-4bde-9f51-2d5ae3d25b01@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296434-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 420B3654A18


--adOSsypNp6f03yZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 07, 2026 at 08:07:37PM +0200, Lorenzo Bianconi wrote:
> > > > When a GDM3/GDM4 port is set to WAN mode, enable GDM2 loopback to
> > > > support hardware QoS. Conversely, when switching back to LAN mode,
> > > > disable the GDM2 loopback and restore the default forwarding
> > > > configuration.
> > >=20
> > > Why not just use the presence of an off loadable qdisc as the
> > > indicator to change mode?
> >=20
> > Hi Andrew,
> >=20
> > Interesting, can you please provide more details about you mean?
>=20
> You say you need it to be in loopback mode in order to support
> hardware QoS. You configure QoS by using a qdisc, and something like
> mqprio, tcf etc. So when the user configures QoS, you can see if the
> hardware supports the request QoS. If so, swap to loopback mode and
> offload the QoS function to the hardware. If the hardware does not
> support the requested QoS, leave it in software and keep with LAN
> mode.

ack thx, nice idea. I will rework this patch in order to rely on tc to
configure GDM3/GDM4 ports in LAN/WAN mode.

Regards,
Lorenzo

>=20
> 	Andrew

--adOSsypNp6f03yZM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiaMJwAKCRA6cBh0uS2t
rK2bAPwIvDBSx3qJGo2xGvPkpy2z4KzEamk7juLxscsrz/+wtQEAl3TTMKLxFV09
y3YJwHEv243V0HLZH15bEMGGSDKoWws=
=rM/X
-----END PGP SIGNATURE-----

--adOSsypNp6f03yZM--

