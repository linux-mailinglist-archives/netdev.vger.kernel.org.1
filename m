Return-Path: <netdev+bounces-277330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GT/B2bU2GmuiwgAu9opvQ
	(envelope-from <netdev+bounces-277330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B393B3D5CA2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D33300C93B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E33890FF;
	Fri, 10 Apr 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt7HkuUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CB386541;
	Fri, 10 Apr 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817584; cv=none; b=hp40h1SvoK4sMRkpBKonnUy7rvZ2sC9hfLIXeqCgjgEMCJnluA0nL9XWodbAq0++SUxVHfQd5k+lrkxk5EFqA4VH0+gRKnDOqi72OhvMzUCd7ShXNJfGqEWc7CJ/sXQn1Ee59eisaFwUjsCpz4OMBhwg7A/G3bi87gLkMQH1zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817584; c=relaxed/simple;
	bh=efZPYGaK0Qk1kuXGiCrPaA7LV0wmuHFUZ8/kjzOSrmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQaHYh3VsuqqYHtQLkTdOQUreuuVZ3oNdUwSyEScQ//gdNssFLSjqZqhSm78WdHosDLuzwD0p1BpD63CN5TV58HovTbjq2c5BsiloEz19dOpr9V6C3doR6kSDHhv+M7c3ZMXcTlim8E/1D41GAYq71WUeg1pmuppBQail16ff+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt7HkuUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0AEC19421;
	Fri, 10 Apr 2026 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775817584;
	bh=efZPYGaK0Qk1kuXGiCrPaA7LV0wmuHFUZ8/kjzOSrmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mt7HkuUxnn8sc44z2lZodnzAhebUi6C72VQRdpnHBhONc9PTvfyjZOxObbJ7Hu0as
	 EM/YrtAW3H5E/nUHtzkd1vapxnIuNqU0kQ21dReehFXy5LpIvLB6YnZtMzAHMYNFw6
	 e25JBfyMlnBy45FD+5YxMUrUkktGv5p1LUIWqliNL0V6/56uXj3/ciEzr8+JCDNcQw
	 fXyjyf0KyEdFKw3BWpAlbLYHW21ArOjBoeIFHe1349c+0giLHL+qCK0nsf8rVGwoUP
	 Pz5PLb/2+UMKV7BIkDroLGT/CZv1SVNwf6ZBKzgOjBSy1zvFFkRIuNDyr6RKw+7vjd
	 2sDUK9rkBToyg==
Date: Fri, 10 Apr 2026 12:39:42 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v3 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Message-ID: <adjTbn415fwqUfsD@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
 <20260409195645.16c68979@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9OsCBHIk5k9xxPwx"
Content-Disposition: inline
In-Reply-To: <20260409195645.16c68979@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B393B3D5CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--9OsCBHIk5k9xxPwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 09, Jakub Kicinski wrote:
> On Mon, 06 Apr 2026 12:34:05 +0200 Lorenzo Bianconi wrote:
> > EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> > Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> > manages the traffic in a TDM manner. As a result multiple net_devices c=
an
> > connect to the same GDM{3,4} port and there is a theoretical "1:n"
> > relation between GDM ports and net_devices.
>=20
> Still waiting for the device tree review. I'm going to blindly send out
> the Sashiko review, please comment if any of it makes sense?

ack, I will do.

Regards,
Lorenzo

--9OsCBHIk5k9xxPwx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadjTbgAKCRA6cBh0uS2t
rLAHAP9fr+xJrviNMbREuUyGBcQn8ZW1o1zADHVS56b5PvPSqQEAqbJlkikpGNEo
lCdL4qOdlPlnY1xlLOhPWxXH/kMt1AI=
=HygG
-----END PGP SIGNATURE-----

--9OsCBHIk5k9xxPwx--

