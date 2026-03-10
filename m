Return-Path: <netdev+bounces-266018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMAzFHv9r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:16:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203E24A441
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C153087E85
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5D386454;
	Tue, 10 Mar 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShbMTL1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370683859E7;
	Tue, 10 Mar 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140973; cv=none; b=M7lr4xCTAy5HQdyykgF5W3tA10h/WypXarNueDl8UNXRcgAhTsot8i+2/XiCWcJNQp6SpGFzwqAmTtPQCXl/lhoY+EUANJVLGmu8IKnrguiNT2Jl8IcDHxYKN9uIjPvGWSWOiTC6osj4hDLsYu0+pIbajkuhdgD8OEld809XUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140973; c=relaxed/simple;
	bh=VNyUyS3lGjMPC8CdjvSh7uOSSVyYiTt8P2SG+uApMYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUq+mK2mDwa0JzIaEoyFds1PWpO8GSwkTYFy5ucN2rFMYWlL85saMBTA3I21gu8h53B9sZKwCYwAJ7/PWEARam6KlJM0OCI5jpxQqu4pfU/h6CUM1Ia8YF1zQEDUF7p/WhCXdqHvrM72iUP/iEDGDur4AnhbHE4gyfbwycVIRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShbMTL1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96717C19423;
	Tue, 10 Mar 2026 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140972;
	bh=VNyUyS3lGjMPC8CdjvSh7uOSSVyYiTt8P2SG+uApMYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShbMTL1wgx+KOaGEleckz5GEqbR9RVJRUkIjqiGrBa6t/E4r85d/Nd/EKG1xZRTHE
	 qnUnLtV4m0sz8bPSNkj4qxQ64Zfo+WtCAuq1OQwNYf/63QEeqlM/6/q0t/kFXR6VVN
	 IJY46oakEKw8bOQiPFM8/AlJVm8vtVSYH6v/N6IxysNU2xrFU+7580A0jGVP18yKdt
	 Wn0hVC/chZHRg51f+cVyxEC8QmFFLvi4Qg/7Y/Gfde7B8jy9+1u+6266UbZXe0GTWQ
	 x55gs2JGm0oGHFF3EfsULOVDVD3+YxT6M6kIHRR+k42JKrLSsAt86CiseZCdDJSA74
	 YSCEL8pDy0YsQ==
Date: Tue, 10 Mar 2026 11:09:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <20260310-serotonin-skimpily-797f9982f767@spud>
References: <E1vxq3L-0000000BsQm-4C8v@rmk-PC.armlinux.org.uk>
 <aatrvmyW-SaHuVN7@shell.armlinux.org.uk>
 <20260309-spill-gradient-b6f9440f3a26@spud>
 <5add0a0b-e6da-40ae-b7cc-e64910739355@kernel.org>
 <47657a77-2880-4556-84fc-96dc4174e705@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iu9PgrLjG9+kWljv"
Content-Disposition: inline
In-Reply-To: <47657a77-2880-4556-84fc-96dc4174e705@kernel.org>
X-Rspamd-Queue-Id: 1203E24A441
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
	TAGGED_FROM(0.00)[bounces-266018-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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


--Iu9PgrLjG9+kWljv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 09:48:25AM +0100, Krzysztof Kozlowski wrote:
> On 10/03/2026 09:43, Krzysztof Kozlowski wrote:
> > On 09/03/2026 18:49, Conor Dooley wrote:
> >> On Sat, Mar 07, 2026 at 12:05:18AM +0000, Russell King (Oracle) wrote:
> >>> Any chance of a review from the DT maintainers please?
> >>
> >> Sure.
> >>
> >>> On Wed, Mar 04, 2026 at 05:30:32PM +0000, Russell King (Oracle) wrote:
> >>>> Mark the AXI snps,kbbe snps,mb and snps,rb properties as not
> >>>> implemented. These were introduced by commit afea03656add ("stmmac:
> >>>> rework DMA bus setting and introduce new platform AXI structure").
> >>>> While stmmac has code to parse these properties and save their value=
s,
> >>>> these are written to write-only struct members - no code in stmmac
> >>>> has ever read their value. Hence, these properties have been non-
> >>>> functional from day one.
> >>
> >> If they're not implemented and have never been used, could we delete
>=20
> Maybe I misunderstood, did you mean delete from the drivers as well?

Correct. That's what I meant by "delete entirely".

> This would work as well, but we cannot only remove the dt-bindings.
>=20
>=20
> >> entirely? Note that they also appear down around line 600 in the file,
> >> in the stmmac-axi-config section.
> >>
> >=20
> > We should not document what is and what is not implemented, thus this
> > patch is not correct either. Either you deprecate properties, based on
> > some argument, or you leave them untouched regardless whether they are
> > implemented or not. If someone re-implements them next week, are you
> > going to change the binding? Usually no, unless these are not really
> > hardware properties.
>=20
>=20
>=20
> Best regards,
> Krzysztof

--Iu9PgrLjG9+kWljv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaa/75wAKCRB4tDGHoIJi
0iexAQCOa6PEkWnJQNJNx7hcSMkLCwgY24SY7Su39mLFSgob5wEAvaRrR33lzHjm
DpULJE9AsGgkBf5OCQ/zOrrcuNrmowU=
=5l75
-----END PGP SIGNATURE-----

--Iu9PgrLjG9+kWljv--

