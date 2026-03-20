Return-Path: <netdev+bounces-269870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM7RIWUZvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 305FD2D852E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 789C9300615D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98099359A9B;
	Fri, 20 Mar 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StLJ+aDp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625830F92E;
	Fri, 20 Mar 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000481; cv=none; b=WcwkBQ37blZ2FCimvbunqbPGtFrjl610UKe/K8cA0Jy7aF52pUhP87AVmryF5yCXi2XQm/ojryvGDRYGbBv/jdTBCyflgmoAwucix99uzJbMDZnydLs+dOqS1yzDylsu86Er+oYMSBJyC/TTUIBJPRf49DoBkbi2jCdZkgpHUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000481; c=relaxed/simple;
	bh=Jl2syGIOY+PRgps6OcsmUhCbzfxV9LFWKi72pDr/B7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuHP4JG6VB0h3pfYkhGBjBMFwSmW5wcpcQJKEnnGVvcvF6hF3A5u1y8CQK0B9BEE6uyp8F8mZTYoRkR4C9CqjwFa/2VnvzTpkliQuCZYes+xGssmqP3ovt/5ILIa1aWwtuK/kQwcxM6/0BlCkGO/Ld/hV3zDRC9QNIhmXBu/oGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StLJ+aDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA73BC4CEF7;
	Fri, 20 Mar 2026 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774000481;
	bh=Jl2syGIOY+PRgps6OcsmUhCbzfxV9LFWKi72pDr/B7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StLJ+aDpKTKw/NknAg2kJHhi9QTayNKMtfod/fIYsyuVvk5/tC5QEcdYdVwoIKFqc
	 BU9OOc5I/mHNjPAYG0mafc5o+E1AKW0Of588mtDfoRmP87Xua0UVD5GH5o4Ui3BvJb
	 0JVbJi3/gCwC6VXT30cUCu4a1F8FUMry6vc3kEwN6s7QrJMvQDg/l5EdIIDtCTr+Mq
	 SLVuW29jbjCaOt8WZLTyraAL+9DKNsqdl8Nd4/mI5UtQp4wVZ0UCMjQPEhDw8nSO+R
	 N02yJirk6Y4YT/id1yLJrs452LExaBqzyDocB9ZubvW6sGW1u50ZH6jSR60A4OCjXq
	 mqjdq1WQm/YNA==
Date: Fri, 20 Mar 2026 10:54:38 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] net: airoha: add RCU lock around
 dev_fill_forward_path
Message-ID: <ab0ZXsDsU4y1MTvM@lore-desk>
References: <20260320094315.525126-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ZwJLIw+IKx6fh0d"
Content-Disposition: inline
In-Reply-To: <20260320094315.525126-1-dqfext@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269870-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 305FD2D852E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--0ZwJLIw+IKx6fh0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Since 0417adf367a0 ("ppp: fix race conditions in ppp_fill_forward_path")
> dev_fill_forward_path() should be called with RCU read lock held. This
> fix was applied to net, while the Airoha flowtable commit was applied to
> net-next, so it hadn't been an issue until net was merged into net-next.
>=20
> Fixes: a8bdd935d1dd ("net: airoha: Add wlan flowtable TX offload")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

My acked-by tag is still valid.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> v2: update fixes tag to the flowtable commit
>   - https://lore.kernel.org/netdev/20260319032649.337812-1-dqfext@gmail.c=
om/
>=20
>  drivers/net/ethernet/airoha/airoha_ppe.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index ec5ce41dad80..02deb739a1c7 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -227,7 +227,9 @@ static int airoha_ppe_get_wdma_info(struct net_device=
 *dev, const u8 *addr,
>  	if (!dev)
>  		return -ENODEV;
> =20
> +	rcu_read_lock();
>  	err =3D dev_fill_forward_path(dev, addr, &stack);
> +	rcu_read_unlock();
>  	if (err)
>  		return err;
> =20
> --=20
> 2.43.0
>=20

--0ZwJLIw+IKx6fh0d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCab0ZXgAKCRA6cBh0uS2t
rIHvAQD90h1oFpNB/bcKbl+OiAGcnrq7Sftw2sUNxiaPF+eHCQEA+5pfuDqzlv5O
7FsrkvEOxEwG4zAUe87AZPXpJz1mZQI=
=bKT5
-----END PGP SIGNATURE-----

--0ZwJLIw+IKx6fh0d--

