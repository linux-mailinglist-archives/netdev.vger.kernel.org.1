Return-Path: <netdev+bounces-289327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJo6K6EdDGpJWQUAu9opvQ
	(envelope-from <netdev+bounces-289327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E2579E27
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D853300680F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84263E1200;
	Tue, 19 May 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAT1d1pm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B63DCD8E;
	Tue, 19 May 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178873; cv=none; b=siAZXZbbrB4c/yHcvpoTuhpGlm3FwdNU7+Txy5TSy7Qm4YHClh4ZFgWTVYQmw2SjPAsqYmaYn3sOztBco2ncc5r3u962XJbQoyUAxTpltuWWhIWgJzO7oF0exM9qyjx9ZcXUHWMxlt1YKmufF/XuBW3wa+sWyCFP6bE2892NWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178873; c=relaxed/simple;
	bh=tDJ676BMgLDH5QXHQXESWIgejlRC5ysodvGdf6zhXJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jmi9JI12GNy0J6G2CvwPOgxHP4x0k+1eACbUtn2dXCCBOaTO2C/GuwRCmPxWfayBDtJz3v5P1F5vE2l6s3xt4ZM6kKXD6BOIRBUZKjlTgsFmycdLvT8F6oXcJ4oYwkaZH2S/iyAPqGqbTW4NynwxBb5h9YMXf4m9a/TYTIOXHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAT1d1pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47CEC2BCB3;
	Tue, 19 May 2026 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779178873;
	bh=tDJ676BMgLDH5QXHQXESWIgejlRC5ysodvGdf6zhXJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAT1d1pm7N1FFCeffinmDHW6oJul7lkYiUgRe1Mu+RNcWdjjDJh3narpSaCw5Hz2r
	 6NcopBBimft48kpIsCxDvfOaPOEHPvJ+8GT04NR4Fd62mwiGPWosuWQeWky387jWD0
	 /rsVWQn4QroUCBgnBBn0QogA97u+vJsEhvT8mUEAbOIqoo42qa4T0RI23CgUztu6ta
	 W7/SklrsUT5ejmrQ863MP0bFcktZPkslBF+2F2wL7994H+96gTHVBOb8ISrcCEUfnz
	 98QCYHJGIrn5oMnTpKt0gTtiEjzzl/YaWwkQsOA/nSS7zU1wjoVa2Ka7E3oz3HKPY3
	 cnEvMiZBQ32NQ==
Date: Tue, 19 May 2026 10:21:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 03/10] net: airoha: Move airoha_qdma pointer
 in airoha_gdm_dev struct
Message-ID: <agwddqW7CZQfYaPn@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-3-99e0093303e2@kernel.org>
 <20260517055811.39179C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LJ7Nk84mR0QUSsMi"
Content-Disposition: inline
In-Reply-To: <20260517055811.39179C2BCB0@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289327-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 503E2579E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--LJ7Nk84mR0QUSsMi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Deadlock risk due to using `spin_lock` instead of `spin_lock_bh`=
 in `airoha_update_hw_stats`.
> --
>=20
> commit af5b93ea60b28ce8a1ab1016b0911418480e766a
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
>=20
> This commit moves the airoha_qdma pointer from the airoha_gdm_port
> struct to airoha_gdm_dev, since the QDMA block depends on the net_device
> configuration. This is a preliminary patch to support multiple
> net_devices connected to the same port via an external hardware arbiter.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 3ca0dbd19275a..6c9f4b289dba7 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -1560,9 +1564,10 @@ static void airoha_qdma_stop_napi(struct airoha_=
qdma *qdma)
> >  	}
> >  }
> > =20
> > -static void airoha_update_hw_stats(struct airoha_gdm_port *port)
> > +static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
> >  {
> > -	struct airoha_eth *eth =3D port->qdma->eth;
> > +	struct airoha_gdm_port *port =3D dev->port;
> > +	struct airoha_eth *eth =3D dev->eth;
> >  	u32 val, i =3D 0;
> > =20
> >  	spin_lock(&port->stats.lock);
>=20
> This isn't a regression introduced by this patch, but does this spin_lock=
()
> need to use the _bh variant to prevent a deadlock?
>=20
> This function is called from ethtool paths like airoha_ethtool_get_mac_st=
ats()
> and airoha_ethtool_get_rmon_stats(), which run in process context. It is =
also
> called from airoha_dev_get_stats64() via ndo_get_stats64, which can be in=
voked
> from softirq context when queried by a bridging or bonding master or qdis=
c in
> the TX/RX paths.
>=20
> If a process-context ethtool operation is preempted by a softirq on the s=
ame
> CPU that then invokes dev_get_stats(), could the softirq attempt to acqui=
re
> the already-held port->stats.lock and cause a deadlock?

according to my understanding ndo_get_stats64() can't be invoked from softi=
rq
context.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D3

--LJ7Nk84mR0QUSsMi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagwddgAKCRA6cBh0uS2t
rAW/AP0aD9yWvysA4UQZWMt8KYNajMyf11KY05+00GEq79lH5AD/YUZPKzhQdrP7
doMJF/1zsYgfpHeJZmwlhUdhbiqNpgM=
=lPdz
-----END PGP SIGNATURE-----

--LJ7Nk84mR0QUSsMi--

