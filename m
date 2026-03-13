Return-Path: <netdev+bounces-267364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Di4G8fes2macQAAu9opvQ
	(envelope-from <netdev+bounces-267364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:54:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE9280E75
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71D3D30A6A17
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D7387370;
	Fri, 13 Mar 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbA/NZ7Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9F381AF2
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395414; cv=none; b=MTRzAjGo5oL1lbYOKcJchvcPJFaLrIa36J3ufrgDSKDgC0Arjw09iOEBjXVWVpSQ9kW/kiex/AKpOJTG/Xr8kexPpzJZ4odu3IYEvWLqJM/CgAdUPsacsztYTfJ2aCSumaxNRb+QNBCqRtx9rRvSqP+BZnkG1ayjMGAxVEcAPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395414; c=relaxed/simple;
	bh=nE43dtnYWlCGyu8787MseJzJUYs9YVHHV8gMUM6/mwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAeS9cElrZyO5nMBIXozVPS1lVjExMkWM//vL2DeTJesnToP39cTMdlsdv7RaBJjldCrHSRtKgvgQGFQJA4MfnZKlhv9YbHDSuAo//4sb9G4ABMRuBtrmEQfeSS2GkiF2zzkfNvnmL4cMc1atEEXr8lTOHavi+1+iT1S6HC3gw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbA/NZ7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF0FC19421;
	Fri, 13 Mar 2026 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773395413;
	bh=nE43dtnYWlCGyu8787MseJzJUYs9YVHHV8gMUM6/mwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbA/NZ7YwPHavzc0mAJthFEffrYNboVFe1KGGozKovrozKrovmb7dBKM3ah8WUzgR
	 eMfDyBrV0y4i0m3cEkiEONT9hnyOHP52ebG2lpNhw9LS6Zqi+1UoIP/IaurW0c1DKz
	 +KNN5CpeA4Vd88nrTw64cfKzwrQrDIxWJq7Kc1PZEj6zI+a7ma9Smy54jSGFkg9soW
	 +1Ew3j3NTHZQLFKbn4o2kVi5k03KsZGjG4ucGZ5W1XhHKuDu+DcEHKLIuMUixSNikp
	 e/zPm1+FKz6UE4QtpVq9FzK3UfSXHz2D6F2DKuUWjuY+P60T1l0M2AKStOhYHZWlYf
	 TsAlNlBCZN8Zg==
Date: Fri, 13 Mar 2026 09:50:09 +0000
From: Conor Dooley <conor@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <20260313-unloving-ambiguous-a6f492db06a9@spud>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <177336361104.619871.8288889004999699479.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+uPr45B8fwICoXaU"
Content-Disposition: inline
In-Reply-To: <177336361104.619871.8288889004999699479.git-patchwork-notify@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267364-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9EE9280E75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--+uPr45B8fwICoXaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 01:00:11AM +0000, patchwork-bot+netdevbpf@kernel.or=
g wrote:
> Hello:
>=20
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>=20
> On Wed, 11 Mar 2026 01:07:00 +0000 you wrote:
> > Add support for VSC8662 reporting its inband capabilities, and also
> > hook to configure the PHY's inband mode.
> >=20
> > This fixes a regression in the macb driver caused by commit
> > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> >=20
> > Reported-by: Conor Dooley <conor@kernel.org>
> > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba=
1@spud
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - [net-next] net: phy: vitesse: add inband caps and configuration
>     https://git.kernel.org/netdev/net-next/c/6e263aadbaf2

Hmm, should this have been done? Charles proposed a different patch in
this thread that got posted here: abMa8e_2fjRkeOix@shell.armlinux.org.uk
It seems to have less chance for impacting other ethernet controller
drivers negatively.

--+uPr45B8fwICoXaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabPd0QAKCRB4tDGHoIJi
0tfVAP9I333WmJq7wpR0rMaYCHhkgYT0/bo0Rkcn5THZkKdXQgEAzfzHVVnEknNu
pNzTjCPQZKGdEyeqK7AtXYm35uSVdgM=
=ccCh
-----END PGP SIGNATURE-----

--+uPr45B8fwICoXaU--

