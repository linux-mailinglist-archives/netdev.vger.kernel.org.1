Return-Path: <netdev+bounces-266674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK6BIXKFsWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:08:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BFB2660A2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A803300BCA1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837F3C7E11;
	Wed, 11 Mar 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEFW2rBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F013624D9
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241484; cv=none; b=TzfmKIv2UrYor9bGJUH0/+K8PBojzZoEEt3nOVP0iTUYjymFeaACBErm7Eddaw5Qaa5kc7HqYR81NFOyK57/7TjzowJnGx+eZi4d1DA/Mkqzo10TUpTXroUxupUtMj3hRVUyORX13Fi4A9HLmFKnXbOWqoG5P0ZN2eKNIUIigKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241484; c=relaxed/simple;
	bh=53BuFNhQ9dMA1mFBm97JmySa0Hqa6teur/dpUR+YJGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5AF0UVPxo3BnWFSzcTUpVjwZlReSceNmVS3LAfmXIoWEcBAHQRnBSPFC/jIsXB+1AVPorsmXT/9rchiLNfmxFO1rLZdKrRtdxCaE7YUHgzcazK9TtCXfXIAw9KxBitog6sTWAF6PVhBNgrxJauJyncL8AbpvhkHEQw2eJ0pggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEFW2rBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8686C4CEF7;
	Wed, 11 Mar 2026 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773241484;
	bh=53BuFNhQ9dMA1mFBm97JmySa0Hqa6teur/dpUR+YJGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEFW2rBpgno7kB5ZBy7EZ1OhXkegBVPptWqlSknFQq7HmQdPxaydaJNCNFYFl2Qxs
	 /4XOBcj0XmeCd31bkndRLiGc6zd0kWtWy7HS8wV4wnaRAuJUKIcBAgClrdqDUd+Xx8
	 vU8IxUUFdCtTU2wW9APzOj+Y+Rgc6nDH/5DxdXOgM7bumA7EBU04g2nUPJZOBXcTnE
	 QauLbbWH1XncLB/c3K/moMgc0VTnpJP72evSh8aIdDdZnhsT9YOk0ZMOkYkgGV7rBU
	 0+uaWRQWpKotaaGl1XF02m4jrWd6VP0o5nGGtBOzILvItK4aBsBt6+VKT0ZSA0IMWl
	 0BXF7pdsRmbIQ==
Date: Wed, 11 Mar 2026 15:04:40 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	Charles Perry <charles.perry@microchip.com>
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <20260311-clang-zesty-6ba9d364f695@spud>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <20260311140135.937544-1-geert+renesas@glider.be>
 <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="elmeAvJkKPUeUoIM"
Content-Disposition: inline
In-Reply-To: <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266674-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: D7BFB2660A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--elmeAvJkKPUeUoIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 02:26:11PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 11, 2026 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > 	Hi Russell,
> >=20
> > On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrote:
> > > Add support for VSC8662 reporting its inband capabilities, and also
> > > hook to configure the PHY's inband mode.
> > >
> > > This fixes a regression in the macb driver caused by commit
> > > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> >=20
> > Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disable=
d")
> >=20
> > > Reported-by: Conor Dooley <conor@kernel.org>
> > > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2=
ba1@spud
> >=20
> > s/Link/Closes/
>=20
> I avoided it because any other PHY used with macb that is also connected
> via SGMII will run into this same issue. It just happens that adding
> this support fixes the above commit.
>=20
> Conversely, we have stmmac, which unconditionally enables SGMII inband
> at the MAC end no matter what phylink says to do, and should this
> PHY be used with this patch in a stmmac system, it will cause that to
> break, because we end up with either end misconfigured.
>=20
> Also, if this commit is applied without the macb change, you'll
> probably also find that macb breaks (please test that.)=20

I just did, and it does break.

> So, while this is a solution and a step forward, I'd rather not suggest
> that it is an official fix to the macb issue - it's merely filling in
> a missing piece of the jigsaw.

Yeah, and the other thing to bear in mind is that this is just one PHY,
right? I kinda tunnel visioned on this fixing the board right in front
of me, but of course every other board with this particular SoC uses a
different PHY. The other board I have on hand is mpfs-beaglev-fire.dts,
which uses a rtl8211, and that remains non-functional with your patch
applied, for obvious reasons.

> Sadly, this is a fundamental issue with SGMII implementations today:
> whether SGMII inband is used/required is completely random both at the
> MAC/PCS end but also at the PHY end. If one ends up with a mismatch,
> then things stop working.
>=20
> As I say, the problem with fixing the PHY end of the link is that
> it could cause a different network driver to regress.
>=20
> So yes, this is a solution to the macb problem, but I regard it as
> high risk.
>=20
> That said, given the SGMII mess, there is no easy way forward.

Ye, what do we do? Should the old behaviour be retained for all but the
new platform that Charles Perry is adding support for? Otherwise we are
just playing phy driver whack-a-mole, and (as you said) hoping we don't
introduce regressions elsewhere.

--elmeAvJkKPUeUoIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabGEiAAKCRB4tDGHoIJi
0joJAP0R26ZvHcrmL4Cw/FLYqTdPcjqZi9R+vDjIntI1YHZjYgEA6ZveD1UZVP3u
uItXilVCV/xd15eHkdIRAq4qh8PRiA8=
=QMf2
-----END PGP SIGNATURE-----

--elmeAvJkKPUeUoIM--

