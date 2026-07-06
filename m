Return-Path: <netdev+bounces-305040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AnC7Ilm3S2psZAEAu9opvQ
	(envelope-from <netdev+bounces-305040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83F711C2C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:10:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hzhGtLEI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305040-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305040-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74A8D31920E0
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912043787C;
	Mon,  6 Jul 2026 13:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B0437871;
	Mon,  6 Jul 2026 13:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344093; cv=none; b=I+g+7KMbUckCzw/1vEhzq+qgEi6x0TZ53+bMQD3Rlfp+x+bQuv3uKIthmycNLSz1qaED/YBzIENZc0TRUEwdMButH67wrWAm+vuaNgDPL8ePxd1spAH5FWDFTYbOnFxLCwHRZ0sIRpxc5sN8XHZu4PvIPBCK4j5sulh+OlQ15AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344093; c=relaxed/simple;
	bh=LIBdR4kNPFgAFg6CIvOqngtwtnAfcvSaKkHxpyzx3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIItU7rujn7BPuqVQy1tCTfQbkKtNEJbKs3vXCFN52Y3cDfkAe00hPot5RbpQAbbPPTRQDkJvVJqtGdk53sM58IpI1KdVpP3+YHNWccEUauGVPNYIiLdnTcIE5NL1Aze9h4fWUrxbDASH7rM/Dh7J9US5vRoEjq8pqhnU8uFYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzhGtLEI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E42B1F00ACF;
	Mon,  6 Jul 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344091;
	bh=LIBdR4kNPFgAFg6CIvOqngtwtnAfcvSaKkHxpyzx3/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzhGtLEIi1bGKJUC8u0qeW903kcSL3pljP7AzVrtfkZGGdgUDrJReqcoxx+k3wMrP
	 Zz/RnazFls+zmQ8qsn1GMbrnZ7t5QVR0DM1m1vzifytBeK3QFfRGlZgP8DV/8RcrsY
	 W7sc6enVxVr0saHu8cE8jQyiQuo0kLSlFLwWvsK20bBlrZiotMIxEmcS4aYw0USZaf
	 IJqxLzl1Htxaa7FBiJ6AMgwyHg1HnPrY9B6qOdeY6Z3G1BVSzCC0UgnZd9vfe1Dzmw
	 ukFJvYnBBzWJuKp4++gojDAnCDOmKlaQOIaKuk9fbhj1zMZAFXNcF+lFVH6z+eystA
	 D494h+6Eq+sLw==
Date: Mon, 6 Jul 2026 14:21:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	maxime.chevallier@bootlin.com, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
	weishangjuan@eswincomputing.com, horms@kernel.org, alex@ghiti.fr,
	lee@kernel.org, wens@kernel.org, lizhi2@eswincomputing.com,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 6/6] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <20260706-confess-dagger-e60b5fad57e8@spud>
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063445.1226-1-lizhi2@eswincomputing.com>
 <8e5eb97d-dfaf-47a1-8572-b3252a2c7ed3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ULiKs6VR99TI7WYu"
Content-Disposition: inline
In-Reply-To: <8e5eb97d-dfaf-47a1-8572-b3252a2c7ed3@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:alexandre.torgue@foss.st.com,m:mcoquelin.stm32@gmail.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:maxime.chevallier@bootlin.com,m:linux-arm-kernel@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-riscv@lists.infradead.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:alex@ghiti.fr,m:lee@kernel.org,m:wens@kernel.org,m:lizhi2@eswincomputing.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:rmk+kernel@armlinux.org.uk,m:aou@eecs.berkeley.edu,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305040-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,eswincomputing.com,foss.st.com,gmail.com,einfochips.com,bootlin.com,lists.infradead.org,st-md-mailman.stormreply.com,dabbelt.com,ghiti.fr,vger.kernel.org,lunn.ch,davemloft.net,google.com,armlinux.org.uk,eecs.berkeley.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,eswincomputing.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F83F711C2C

--ULiKs6VR99TI7WYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 03:09:37PM +0200, Paolo Abeni wrote:
> On 6/30/26 8:34 AM, lizhi2@eswincomputing.com wrote:
> > From: Zhi Li <lizhi2@eswincomputing.com>
> >=20
> > Enable the on-board Gigabit Ethernet controller on the
> > HiFive Premier P550 development board.
> >=20
> > This patch is included only to provide the DTS context for reviewing the
> > binding and driver changes in this series.
> >=20
> > The upstream DTS series will be submitted separately after the binding
> > and driver changes are finalized.
> >=20
> > Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
>=20
> @Rob, Krzysztof, Conor: I see this patch is not listed in the devicetree
> PW, but I think it needs explicit acks from relevant SMEs. Could you
> please have a look?

We do not typical provide tags from dts patches, but that's irrelevant
for you, because this (and effectively all other dts) patch(es) should
not go through the net tree to begin with.
Instead, the platform maintainers should review and/or apply it.

Additionally, it seems the contributor's commit message suggests
that they didn't intend this patch to be applied at all?

Cheers,
Conor.

--ULiKs6VR99TI7WYu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakur0wAKCRB4tDGHoIJi
0lJJAQDyznJ0mXwKfkHnFRg/RjkZfn/slGLhUuYfKnvvJnC3yAEA7uHRCP2yagsd
bJ/ACyG7Ej0e3jeZwhPFEWzspucP9go=
=kICX
-----END PGP SIGNATURE-----

--ULiKs6VR99TI7WYu--

