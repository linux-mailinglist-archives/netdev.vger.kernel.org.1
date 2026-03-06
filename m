Return-Path: <netdev+bounces-264848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOV5HsjwqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:20:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC5223AB7
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3B3930A0C50
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD293A5E92;
	Fri,  6 Mar 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiZltdZ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8C3242D8
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810001; cv=none; b=kRrtreBp7mZ/c2ASAdnTkV3lrleHa3/KL+tdPNT2tJoJ9v6D4CmNk6knVWPAUcNVdMOvQ1dl4zynALTK4TMa8aFEf/L7ZISqNltvO5qH91mH4OtsV4XB9Putyjwlsef2g1c1nlcjxgCpee3+/ixwy5hab7hN6t6XJaWNRs1AZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810001; c=relaxed/simple;
	bh=m3yX/TuFuLRmQIgjvocQq3GX0w3ISo7+U2TC5CEV9uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJIJqIj3VQL2GKgZYrEgHajJmZV++XNxCAjBRxjhr3mdWT+8S1hwi4I62s7eYG+DpLGx530rTOUUzE0N1BmRvi9E9+E67aLvZxG74G8LrU6eOhRXWZZRF7YZhc0LeNklf73GwXrhadUnA6C3kb+4kBaIb1yPZ6y60WwTPbMawJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiZltdZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC2AC4CEF7;
	Fri,  6 Mar 2026 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810000;
	bh=m3yX/TuFuLRmQIgjvocQq3GX0w3ISo7+U2TC5CEV9uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiZltdZ2gL1FgHjce7eq7UkgNdE3B4LBXJl8Qxe8+hOJHZUbs+T/gCtq822uK3SXp
	 xTDxNlZKmvRv+qxSeUHDc/A9eyWLuenTL/NO0qMG+kcC9WNWRn6FPehz7PW1C1PX62
	 psecRgeyD+CRzBQS0qvbuhAFLQ7u1/guxPnWe0QoV/5rHghKcPBk+lpSfZ3A9Y6Eqp
	 o5HlFzYcgk4FIRzFpMx1H61mJumZtuX0wmQ8iT6LcOqRhntlHBrpDPWejjuz16xD2n
	 ZcAiOJR35oELwpol4XNVFP880WiVW/ZxVYQF1Zvyb0IDwXXEUy21kxzA2BSl6Ojqm9
	 F0dC5Vcig7fVA==
Date: Fri, 6 Mar 2026 16:13:18 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix GDM2 loopback configuration
 for USB serdes
Message-ID: <aarvDt9TAn0MkUk8@lore-desk>
References: <20260228-airoha-fix-loopback-for-usb-serdes-v1-1-a94be0f897da@kernel.org>
 <20260303141624.GD71509@kernel.org>
 <aaftUXaSD0u5ZhO7@lore-desk>
 <20260306134226.GD461701@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UOcuNL+C/U/0CMjH"
Content-Disposition: inline
In-Reply-To: <20260306134226.GD461701@kernel.org>
X-Rspamd-Queue-Id: D6DC5223AB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--UOcuNL+C/U/0CMjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Mar 04, 2026 at 09:29:05AM +0100, Lorenzo Bianconi wrote:
> > > On Sat, Feb 28, 2026 at 01:20:33PM +0100, Lorenzo Bianconi wrote:
> > > > Flow Control source port mapping for USB serdes needs to be configu=
red
> > > > according to the GDM port nbd parameter. This is a preliminary patch
> > > > since nbd parameter is specific for the given port serdes and needs=
 to
> > > > be read from the DTS (in the current codebase is assigned staticall=
y).
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >=20
> > > Hi Lorenzo,
> > >=20
> > > Is this a fix? If so, should it have a fixes tag? And be targeted at =
net?
> > > Otherwise, perhaps drop the "Fix" from the subject.
> >=20
> > Hi Simon,
> >=20
> > This is a preliminary patch in order to completely fix the loopback
> > configuration for USB serdes but the point is we are not supporting
> > USB serdes upstream yet (there is only OpenWrt support available at
> > the moment). Do you think we should target net-next or net in this
> > case?
>=20
> If there is no bug in net - given the way net can be used with in-tree co=
de
> - then I would not tag this as a fix.

ack, fine.

Regards,
Lorenzo

>=20
> >=20
> > >=20
> > > Also, I think it would be worth explaining the situation
> > > before and after this patch.
>=20
> ...
>=20

--UOcuNL+C/U/0CMjH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaarvDgAKCRA6cBh0uS2t
rHS4AP93AGB12XIMmq1lglTzHPArpDsRGddVBWHb/RHvuaZHdAEA1mo58+20I1V4
7y5FGuGUMVWZVwOEUq8W6grMJD84VAc=
=ifxM
-----END PGP SIGNATURE-----

--UOcuNL+C/U/0CMjH--

