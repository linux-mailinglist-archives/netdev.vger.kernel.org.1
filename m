Return-Path: <netdev+bounces-299783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nVG8OJwTMWoKbQUAu9opvQ
	(envelope-from <netdev+bounces-299783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E468D6A9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:12:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XxWGbp6g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299783-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F30853006022
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306841B37D;
	Tue, 16 Jun 2026 09:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B33B5835
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:12:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601174; cv=none; b=UoNlyMZfZVyRmoZLMW4xeCZpbd8JLIVsdhlVfjAFNib75YGRHctm9aqabUwamaORiLQhAuRdvtEPKWYbCjyK0FHBh26TRdHW57FFSxe+Zqc3jCmtEYWzO9U2IbX3wNbSpC2BQd8M0Nh2UsIHOeu6vUuy4RsArGD1t67mQG7b5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601174; c=relaxed/simple;
	bh=DerSPE8IIwXDA40j0MY0KfN5j2dMWtXXT6W6NOD0unc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqQp2tlV9xlZBSHw3jFVLUzQ98d7AFQldcErd/+0ZTqd5Ssuu6XXC1JsJHkiZyLUmM0muUkW8DKO66tbfVMQhdSi3hUjzivZncyUN/kCLHlH5B0LEQ+1oXJgbnq5+RRjKcKWULkdAyFopucXd/Xl4aLFTXDGJVobrJCrtKHF2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxWGbp6g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB3E1F000E9;
	Tue, 16 Jun 2026 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781601173;
	bh=FW1d3+ywfL/u89Y0GaANXP2o6Did6zok4uhLhWb9zSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XxWGbp6geRDNQzfxDhSwRIUZBmg3xTl0P94mNm/l6/oZFK0Hu0sZjXjX2wtaIekTW
	 knC5/NwA80iuU0sE8HEUoabMVZi8wONVDqoa/E6K9ithuGPv/XIDfwJgM4c3A2zmRS
	 7lyHeYFjMGiFz7HvwgN0fWiWh/ClKVOCccvfBMOmsqTZh1GIlqGn2IByfMw09oA5R7
	 Mh2KW5sN2aN8Jjkqz5gGN/HZQzIROUm7jbY8R+W3so4kEqrHf7lQ9n5MGa35GPMscf
	 bEtrOHAWWdG7tRP5kZMzj/0cz4YnH6X20DeSAuMXqxZTptHnzrdNYieR2E/ZVC7vtH
	 ESYqMRO6pCkLA==
Date: Tue, 16 Jun 2026 11:12:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <ajETkkD9DlBtYHLu@lore-desk>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
 <20260615163713.665271a2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="veXpHt1QEexMKAbu"
Content-Disposition: inline
In-Reply-To: <20260615163713.665271a2@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299783-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:aleksander.lobakin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D64E468D6A9


--veXpHt1QEexMKAbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 11 Jun 2026 23:55:50 +0200 Lorenzo Bianconi wrote:
> >       net: airoha: use int instead of atomic_t for qdma users counter
> >       net: airoha: refactor QDMA start/stop into reusable helpers
> >       net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS of=
fload
>=20
> only the first patch applies cleanly right now

ack, I will repost missing ones as soon as net-next is open again.

Regards,
Lorenzo

--veXpHt1QEexMKAbu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajETkgAKCRA6cBh0uS2t
rOReAPsEmnYAMhDF28XS2vXZY1/UTQg2145bDKxI02AfrrbHKAD/RlrEtKZzVD+t
rV+CYqb0oXC+8tSoTWXY/uU+fRE88wk=
=SZVh
-----END PGP SIGNATURE-----

--veXpHt1QEexMKAbu--

