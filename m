Return-Path: <netdev+bounces-267520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEbAOEUttGlYigAAu9opvQ
	(envelope-from <netdev+bounces-267520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:29:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEFB285FE4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF623019F1C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447539DBEC;
	Fri, 13 Mar 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv+rSfGY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DC38F649
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415543; cv=none; b=EouEnDzj2TabWzIEz2AvYMKDuK0NyP1i/qe47k8sVz955RjF1hZb3ZHH0UXFm8l5sC2bxkKi7SOphqVAHPJkBUXxrp4ptLol7tS0ITHLQdHM+QtMzVZ2ygDoCc8kb9TKMUDXkADmOdI05wqM7uV9de8bW1QJvELThc1LKGv28VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415543; c=relaxed/simple;
	bh=QN552TZqrouE4+tCPS0mMoQgQIkZUkN7DTnt9deeNgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MThFLP7lLm7f1t2yfC6VHj/w8jIZakUaVLLMGJtKvTKqjqM0Yy7Hyz+jtVU5KUkKWcpZKwp/ylbgq9m5wZqIzYQs8FNB37+/SOXsUu6US0MEMyns2eDaqvUZ4sMef/vToTge44Hq9bSiHwahE/5NokkhtF0xyb7QUa7n85JhEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv+rSfGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16977C19425;
	Fri, 13 Mar 2026 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773415542;
	bh=QN552TZqrouE4+tCPS0mMoQgQIkZUkN7DTnt9deeNgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fv+rSfGYabwP29m0niuzYlLhX9bOxuPNCmBYvMs+Ek1Dz3+5ljQy9LX0Cd2Dsx6As
	 Q1OaGBzr6TzuiTRXxmFZHiXnz79grkRBVLyFXAeOnsHZO8frG+9i3VYFaTTpICT2Ar
	 AtYKENf4NqVPykJDonzFGRhX2TD5cMBF1Og7tUv5RPKq9TOkyJetHCps0o3AYetZs0
	 pV3DyvRCNjiRvL/ExWJbryBjn2OU6+ZmqPcRPAW3FhRp+v8+tjbSB5Y0x+NmTQJqTR
	 cUMXJZdl5U+qAJDqjWPDxOtdUvurTS054bCgDfwMjYkRQWrMDwxY6RziW9bb2rkRad
	 vtUc20nJA39oQ==
Date: Fri, 13 Mar 2026 16:25:39 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <abQsc6sPZ4d4tekm@lore-desk>
References: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
 <20260312172430.GA1267298@kernel.org>
 <abMsvOMnnuTdoG-9@lore-desk>
 <20260312172248.68742f98@kernel.org>
 <abP2dLNIw6zqkxL4@lore-desk>
 <20260313143018.GD461701@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GSGfyO71opm8Yq0x"
Content-Disposition: inline
In-Reply-To: <20260313143018.GD461701@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267520-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FEFB285FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--GSGfyO71opm8Yq0x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Mar 13, 2026 at 12:35:16PM +0100, Lorenzo Bianconi wrote:
> > > On Thu, 12 Mar 2026 22:14:36 +0100 Lorenzo Bianconi wrote:
> > > > > Is this a bug fix?
> > > > > If so, perhaps it is for net with a fixes tag. =20
> > > >=20
> > > > I guess we do not need to target net tree since airoha_eth driver c=
urrently
> > > > supports just the LAN interface via the MT7530 DSA switch connected=
 to GDM1
> > > > and there are no WAN interfaces officially supported (PCS/external =
phy is not
> > > > merged mainline yet, it is only available in OpenWrt).
> > > >=20
> > > > >=20
> > > > > And at any rate, could you add some description of the before and=
 after
> > > > > behaviour? =20
> > > >=20
> > > > Theoretically, before this patch, GDM ports were equally distribute=
d between
> > > > QDMA0 and QDMA1 while this patch assigns LAN interfaces to QDMA0 an=
d WAN
> > > > interface to QDMA1. However, for the reason explained above, this c=
hange is
> > > > not currently visible to the user.
> > >=20
> > > Please update the commit message. And please try harder to explain=20
> > > the patches, this happens a lot with your submissions..
> >=20
> > ack, fine. Sorry for not beeing very clear about this (and other
> > patches), I will pay more attention in the future.
> > Do you think we should target net-next or net for this patch?
>=20
> Hi Lorenzo,
>=20
> As per your explanation above it seems to me that there is
> no user-visible change. And I assume that implies no bug manifests.
>=20
> If so, net-next sounds right to me.

ack, I will rework the commit log and repost to net-next.

Regards,
Lorenzo

--GSGfyO71opm8Yq0x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabQscwAKCRA6cBh0uS2t
rCrfAQCuZd7o/lQVJ85m7ozENElbP9fJ7xRXRRkm8z78rsSGewEAt4L9X5zunMFy
HP3y/+3pF9RbCTIWqcdw6i6Z4JT7yAA=
=y/aX
-----END PGP SIGNATURE-----

--GSGfyO71opm8Yq0x--

