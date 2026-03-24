Return-Path: <netdev+bounces-271202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFvfCobOwmkBmQQAu9opvQ
	(envelope-from <netdev+bounces-271202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:48:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABA31A4A3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A6A43061BE2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0C40B6E0;
	Tue, 24 Mar 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPGsrbpO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011940759B;
	Tue, 24 Mar 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374221; cv=none; b=oKJCdt7xcYUnRI6cHXJjQpBRIM5KB0ZME0dVadIQM0lJOrjNzz87NrBA5c+bo/x/5pwi2oDOTj51c0spnuXiFMCsUgYbjoVZOJw87dg3u1wUzHnatofjplD4IsMJ11rSQ7zPP4uVeuPO6/tFOfRA98MZKLzwsg+DHYik+e2M2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374221; c=relaxed/simple;
	bh=x0A2EBPOCbbbBE+krLjw8biQKVDzGTXdjm43j+QGjoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tADWd/X0IHg17UtV1eMFUVH2sbd/VCjxJy7aAW3aPYiWQACH1CDhdl3AnqsOC5gJEdfYkQHONZhBMhNxVXUivN3BU4rko+QpyE6Qx5MgTZ/YBTYShDysqeUGJF0rPbKXXJvlXAvxjvDRLCJmjTn5NoMyLVkOobApFWFhT+IIEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPGsrbpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738FFC19424;
	Tue, 24 Mar 2026 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374220;
	bh=x0A2EBPOCbbbBE+krLjw8biQKVDzGTXdjm43j+QGjoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPGsrbpOBQ7mYpAAe2gj2rcJMV9g+o/YGciUJbP3EpOEQTRFiY0TcbegVgFi2Q/iN
	 oy5eZ671x4gFd5bJA/qQhMdBEZLM7tmnWLEgjpjVf4UrHMCxLNrEMWa7vIXXPF5VTe
	 egkzxRLOLpxnpdGLwwCzbAwbUjtozmE6VF9vwGEsn5rwlSay7OuqccAEuB8+vWlyX7
	 yCWOHFIOiHK6QI5L75fSL0PA/Oi1lMGxuzdKTWGnw4J8mBPR/CAli7h5DnosGADiYb
	 iuMaUDU1H2KndHwFxVMLlNbwy31jJbW3Gm5o/jb2vGR0yIR/kHhZzf+/y6OdHOnvjq
	 +6NLylCrjry6Q==
Date: Tue, 24 Mar 2026 17:43:35 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next 2/2] dt-bindings: remove unimplemented AXI
 snps,kbbe snps,mb and snps,rb
Message-ID: <20260324-lustiness-contest-8b576dbb24c3@spud>
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
 <E1w4ydt-0000000Dlph-3WvI@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQa+yvbosfZFTy1W"
Content-Disposition: inline
In-Reply-To: <E1w4ydt-0000000Dlph-3WvI@rmk-PC.armlinux.org.uk>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271202-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 8AABA31A4A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rQa+yvbosfZFTy1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:05:45AM +0000, Russell King (Oracle) wrote:
> Remove the AXI snps,kbbe snps,mb and snps,rb properties as they have
> not been used, and although the driver parses these, the code hasn't
> ever used the parsed result. This parsing has now been removed.
>=20
> These were introduced by commit afea03656add ("stmmac: rework DMA bus
> setting and introduce new platform AXI structure").
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--rQa+yvbosfZFTy1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacLNQQAKCRB4tDGHoIJi
0kc0AQD8Fdqu9e8zpFe52VG7zrmCtL+z47MkS5ZSvp1U2lhQmwEAgx0GK1qbgkQW
5E9TdD4nGRoAcgomDUF8g8DK8XIrnwk=
=486U
-----END PGP SIGNATURE-----

--rQa+yvbosfZFTy1W--

