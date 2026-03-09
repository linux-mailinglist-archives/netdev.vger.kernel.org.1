Return-Path: <netdev+bounces-265670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAq9AJUIr2loMAIAu9opvQ
	(envelope-from <netdev+bounces-265670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D123DF55
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE1B302AF1B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1152D7DD9;
	Mon,  9 Mar 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eblkBrMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738E2D46C0;
	Mon,  9 Mar 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078561; cv=none; b=e5RYKERxPPr0ZWyKAF6ic0a5hf2UPB/43IwfwBHNPCTJ15EGPr93YVYeVd99kU8RHyh4ds7PZ7fvIFQh1OzVzRM5S36g9OjJrsQWvpLmOLOXDSBiCpby2iSWKqrH9iaf+NLcn45xHueQ0etTQ1dQkPNzB1DlQenx+hYSiI4Iwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078561; c=relaxed/simple;
	bh=LZA81gCtXJLvRABXGlwzIk8enJa6pJ6aIrdKFYAczNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO/gwbiX9R3mqWEootPWr8ofJe0YYvKCILAwBmxFtG9OeWX4/JVGZ5LImhweLwnnouLmbR8ui7HDGmIA9VmN4yUaa0rVKyqQQ7N2Ky3f+xJwP4DXkiT026HLLKPwrDda7iTXxGxvKKhKK71lFSRGqJRA/mO41x5gWKrvsPLMhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eblkBrMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DEC4CEF7;
	Mon,  9 Mar 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078561;
	bh=LZA81gCtXJLvRABXGlwzIk8enJa6pJ6aIrdKFYAczNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eblkBrMF52v5USfdkrli1BGKhTb04U6FAf4N+20uvjXeC4urNjbWADQDJ0a9RFiri
	 v/l1vXsujU92DAdSJhp0uRMVCTjO9OaETycFnJ42xEVtkT1sOQemIww0+oMjJmOXqP
	 W+EpIsZ+d+Fr+5FvWLj3m71WDuruWZe4bMydGub9mwQUhA6hmXPNrFiFzD8qxgffaV
	 7NVQsGxCpXx3xllxenkVZy9e/499c59gLVMAkwv8N3luKBf2zar4FklcCfOTypaWAJ
	 MxkOoWOimpFDZrUHCdSuvQRfbYvI7G5+wablkGslWNiYN/JfYHGW7W+yBKNLfBUUzf
	 GMS7/J6Tsqxew==
Date: Mon, 9 Mar 2026 17:49:16 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mark unimplemented AXI snps,kbbe snps,mb
 and snps,rb
Message-ID: <20260309-spill-gradient-b6f9440f3a26@spud>
References: <E1vxq3L-0000000BsQm-4C8v@rmk-PC.armlinux.org.uk>
 <aatrvmyW-SaHuVN7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DdDmlkajYD81SMUJ"
Content-Disposition: inline
In-Reply-To: <aatrvmyW-SaHuVN7@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 6E3D123DF55
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-265670-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--DdDmlkajYD81SMUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2026 at 12:05:18AM +0000, Russell King (Oracle) wrote:
> Any chance of a review from the DT maintainers please?

Sure.

> On Wed, Mar 04, 2026 at 05:30:32PM +0000, Russell King (Oracle) wrote:
> > Mark the AXI snps,kbbe snps,mb and snps,rb properties as not
> > implemented. These were introduced by commit afea03656add ("stmmac:
> > rework DMA bus setting and introduce new platform AXI structure").
> > While stmmac has code to parse these properties and save their values,
> > these are written to write-only struct members - no code in stmmac
> > has ever read their value. Hence, these properties have been non-
> > functional from day one.

If they're not implemented and have never been used, could we delete
entirely? Note that they also appear down around line 600 in the file,
in the stmmac-axi-config section.

Cheers,
Conor.

> >=20
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Do=
cumentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 38bc34dc4f09..45dba6533458 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -202,11 +202,11 @@ title: Synopsys DesignWare MAC
> >          * snps,xit_frm, unlock on WoL
> >          * snps,wr_osr_lmt, max write outstanding req. limit
> >          * snps,rd_osr_lmt, max read outstanding req. limit
> > -        * snps,kbbe, do not cross 1KiB boundary.
> > +        * snps,kbbe, do not cross 1KiB boundary (not implemented)
> >          * snps,blen, this is a vector of supported burst length.
> >          * snps,fb, fixed-burst
> > -        * snps,mb, mixed-burst
> > -        * snps,rb, rebuild INCRx Burst
> > +        * snps,mb, mixed-burst (not implemented)
> > +        * snps,rb, rebuild INCRx Burst (not implemented)
> > =20
> >    snps,mtl-rx-config:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> > --=20
> > 2.47.3
> >=20
> >=20
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--DdDmlkajYD81SMUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaa8IGwAKCRB4tDGHoIJi
0mcPAP99zuyEYWyO5zE1ZmEoCPJbTcbTFBrK+jazuziv8HfoNAEAm1nNBAKGOKWv
PtuZYnjd307gHbK/4IBrZpCslIzFsgg=
=G9OF
-----END PGP SIGNATURE-----

--DdDmlkajYD81SMUJ--

