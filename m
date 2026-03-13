Return-Path: <netdev+bounces-267422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LRWDI32s2nYdgAAu9opvQ
	(envelope-from <netdev+bounces-267422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:35:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B72824A3
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4384E302CC2E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513E5359A70;
	Fri, 13 Mar 2026 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6JNIl1M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CF345721
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401719; cv=none; b=d9chpzKSCJLsJrGgTnEG82YoJ6SZ+qsBP7JYVVsl+5OMbVr9kbC37TGeMV/1Da2SgGxxQgmcrav4ytRmpeV/xvOgA185NLEZc3yg1OQs9FuFP2Eo60PCQISR9+FIPtI0xI5BYsCeXr3LBecJ2dciFpn/R54+PjQwEFLQpx//SaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401719; c=relaxed/simple;
	bh=6UUBpcPvPMAWRYqT1JRM1Mjfzyj2T0c0/GqtAU3kekg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSM42SMODgQcyma5mkpqyjVmFmNf5LeK5DwoVNBFNX529CNoIdRknMOAZCVDcdCLLWSSRoSLjPH9rT5nlnZtA5TEoeFopMq5p9aD/W0AvY2mBYmJoHaXRBsrkk0o/EOdzIcVQ9tcR3Oy2DHZZ5t1Mg4rpPpj/dzK0esggN++6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6JNIl1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B0C19421;
	Fri, 13 Mar 2026 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401718;
	bh=6UUBpcPvPMAWRYqT1JRM1Mjfzyj2T0c0/GqtAU3kekg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6JNIl1MfZo9S0LPzeyR1gEJNG3JxCj/7FNZtIxtHQ/c0Pln/241h3TeIM0rcKeEs
	 Qr4JPB8imfy4+s02TXe0/iMzV3geD63eEQXQUEfugyZuoYSU5SrKxc3ipDRV9Nxc71
	 MDkaopq+JvPWDzU5AYb5qnTPPh0GVeaHBH7yuuKYMCxYAlngD9rqWw4yX5LpFLi8Yv
	 +tPO9Xbdl4yY0vV2p7YvMfYCu9bUM0P8bAk66FkSbwmjMHD/EJZicJhxmSvyPFEr9M
	 qbwGNS+rcKCnBwOwQPru4ZZT50YABI/4tYzzwCNCV7uuFuA0aMvyytt7/M7RyFgCtS
	 X0k8mFCwIO2vg==
Date: Fri, 13 Mar 2026 12:35:16 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <abP2dLNIw6zqkxL4@lore-desk>
References: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
 <20260312172430.GA1267298@kernel.org>
 <abMsvOMnnuTdoG-9@lore-desk>
 <20260312172248.68742f98@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MeKNmnGIFj0GyFIk"
Content-Disposition: inline
In-Reply-To: <20260312172248.68742f98@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 533B72824A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--MeKNmnGIFj0GyFIk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 12 Mar 2026 22:14:36 +0100 Lorenzo Bianconi wrote:
> > > Is this a bug fix?
> > > If so, perhaps it is for net with a fixes tag. =20
> >=20
> > I guess we do not need to target net tree since airoha_eth driver curre=
ntly
> > supports just the LAN interface via the MT7530 DSA switch connected to =
GDM1
> > and there are no WAN interfaces officially supported (PCS/external phy =
is not
> > merged mainline yet, it is only available in OpenWrt).
> >=20
> > >=20
> > > And at any rate, could you add some description of the before and aft=
er
> > > behaviour? =20
> >=20
> > Theoretically, before this patch, GDM ports were equally distributed be=
tween
> > QDMA0 and QDMA1 while this patch assigns LAN interfaces to QDMA0 and WAN
> > interface to QDMA1. However, for the reason explained above, this chang=
e is
> > not currently visible to the user.
>=20
> Please update the commit message. And please try harder to explain=20
> the patches, this happens a lot with your submissions..

ack, fine. Sorry for not beeing very clear about this (and other
patches), I will pay more attention in the future.
Do you think we should target net-next or net for this patch?

Regards,
Lorenzo

--MeKNmnGIFj0GyFIk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabP2dAAKCRA6cBh0uS2t
rE54AQC1mMaAyrYlZgokGGCJNLPOxAyImBcax4o0k8v1VJY9UwEA0dzu7dEQaV39
KehzNqgq9qHcA+qpmY3Zu8uwmj+WzAc=
=9Tm6
-----END PGP SIGNATURE-----

--MeKNmnGIFj0GyFIk--

