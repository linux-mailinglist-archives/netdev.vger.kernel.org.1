Return-Path: <netdev+bounces-287509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONQcNidKBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A46530F99
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1959E3176DE6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73438E5FE;
	Wed, 13 May 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EERnPqSu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690B38757F
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665605; cv=none; b=VZbklV4fLrQBXql4ToOiCrUEP+jGvJHyTywg0gs/Mp9f61U/nBJP+S/rn5JqLuMklD6ijG4NbpEyP/8WcXUqDLkkQjuNaCcXHi4pLxuFdt9NmNWHq6Uy8obL0Z/MPJHSWoHDU3KLW61cJAGlxHJ4n/vKATflCnwZh04r0EkZQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665605; c=relaxed/simple;
	bh=HukMZmpUGcYPY6BIEm2TnA4heyUj0O0oyS03K/N4TII=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=owplY++1xlUVyH1rsnwPfZT7Y3/FO2+irp5DXkpXhGhcwbnO5jtGi/+GoPUbrxSXzxmj8ycnQgGPI97lVcQGW+f224DN4bR+iCrN2k55G2PHe7JX8MrkaKaBA/oULlnwjNPfarChqhmled+Y4YRz5hn28OAoMM5TId2rRls9Q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EERnPqSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B99C2BCF5;
	Wed, 13 May 2026 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778665604;
	bh=HukMZmpUGcYPY6BIEm2TnA4heyUj0O0oyS03K/N4TII=;
	h=Date:From:To:Subject:From;
	b=EERnPqSuhnENTlQldVwNCTMUeGdVg26fUAY80jJaxrCNCBPl248/MTkcErrt4itWI
	 AGsaOXXxIChrlZJGKQma0Kifhz1fDj6HPRakOzCKJ3oexNsJcRn72uAJP6BCRpdgoT
	 ZUTNrYzKlM/3RVrltQzXoCebEGoCbat9iEz7EJ21YNz3817keeq9eRGv3O8wjgA3Ta
	 6rsnrOggv7/XpKiBIuRB/UnEk3/9elqH06dCMtFa83hcPrqkk9nQwnEQfNYiNpOBIb
	 4/oVGl9aL8HkXtHGDwkw1i1d/xjiPxW5rQZnOHVQEiJprVULSmxjT/naFgqAE/6YQY
	 H2sVs5SVqBxaQ==
Date: Wed, 13 May 2026 11:46:41 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Subject: Fwd: Re: [PATCH net-next v6 09/12] net: airoha: Do not stop GDM port
 if it is shared
Message-ID: <agRIgRXTS64UO5fO@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d/PcUqUsNGyTp8Sh"
Content-Disposition: inline
X-Rspamd-Queue-Id: 41A46530F99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:~,7:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--d/PcUqUsNGyTp8Sh
Content-Type: multipart/mixed; boundary="rnuz2TvepxVF2bgU"
Content-Disposition: inline


--rnuz2TvepxVF2bgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

+netdev

Regards,
Lorenzo

--rnuz2TvepxVF2bgU
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: lorenzo.bianconi83@gmail.com
Received: by 2002:a05:6504:d85:b0:2ff:497e:1c93 with SMTP id b5csp3093692lty;
        Wed, 13 May 2026 02:43:55 -0700 (PDT)
X-Forwarded-Encrypted: i=2; AFNElJ8elgz5DMuuxmE8lkV0QkKdEYtrsnsBUAYfIGGoCm3IdWg5oMNNiKLpFDGe2HQQ9gq1Nt4g/J5L9ey/EgxpyYPp2J0=@gmail.com
X-Received: by 2002:a05:6214:4283:b0:8ac:aeed:b1e7 with SMTP id 6a1803df08f44-8c7df30e468mr34825786d6.30.1778665434983;
        Wed, 13 May 2026 02:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778665434; cv=none;
        d=google.com; s=arc-20240605;
        b=AzX5TtpiN6GFGX4JfU4/JpbXPCM7cQCLc+CO6DAp7o53k3Qa53HRjFiA8ITKObp8WS
         f7ynX37/NfiUBdVDlrT/8gCu79vHB48Bez8ZfvpKjtqBU2WyH/YVLXYK558MdrAozgUd
         6Gyw6xOlizFMrPb2dqRNcrTj76CIIhgkyqMyUkrpiJ9W85n69Ca5dAuE+gc/oN1hFCGR
         EAPHvorxz5o/shOsln+37wTXOBazr6hzFgOOVRNnGygakX4E8/cL4u+OOXltjnFS6Was
         06EAElW5CXMGg1ZBLXhYfbfEKKc4DbMFpYHlg4vwz9Xh8i+R6yjrP4RVaFZ/YBQby/3J
         P9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:delivered-to;
        bh=4AUp8SmhIpUjbn3TQC1mVizaWQ8nRCz5hQvlEfFFrJM=;
        fh=oM/FUfO9VzU1XIzinFCRfvEjImk+uFgK/v3o/+pnRTg=;
        b=lGxC5DfPpLzWkVq03UfblxXWsLhyyt5oz2l/ko44lzaII5tdR/SQxFPbP0QrVTeehV
         S88AR0HNPKJBVqmranRfsZ+T659F1u6cG/Iip0SZn1DRjWNRqjJkLaa9GyTTABt9KNCO
         UmZLDmCx2r/wxHAwyW3oX4QtnqKK87S2+knBjK3Smdq/q2f3JsMY/koDF0J64TyhrxbQ
         FsW9kVzq9rVUl9EyGeUZG/jSgBraWnlG6X/DgnbqlOhoiD/YeqK5Q745iL05XkjsCMoq
         l8JUoaFDKsy51dG3L/BQUSSxIcSqsO1FOch+54SwqUfA5CW5iSYrI3PczdKlJcqBMi3x
         okXA==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=K6mUypW6;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 172.105.4.254 as permitted sender) smtp.mailfrom=lorenzo@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Return-Path: <lorenzo@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org. [172.105.4.254])
        by mx.google.com with ESMTPS id 6a1803df08f44-8b730adba0asi358265006d6.545.2026.05.13.02.43.54
        for <lorenzo.bianconi83@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:43:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of lorenzo@kernel.org designates 172.105.4.254 as permitted sender) client-ip=172.105.4.254;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=K6mUypW6;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 172.105.4.254 as permitted sender) smtp.mailfrom=lorenzo@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 83B3C6013B
	for <lorenzo.bianconi83@gmail.com>; Wed, 13 May 2026 09:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 4C5A6C4AF09; Wed, 13 May 2026 09:43:54 +0000 (UTC)
Delivered-To: lorenzo@kernel.org
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C1FC2BCB7;
	Wed, 13 May 2026 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778665434;
	bh=Ub62bfMWlc5R306323COfpZrvhEMCoZst8dt+8UYDFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6mUypW6tPKXXJCcJqDZGBHIkwqhuVK5e2zNWl/FfNF89h9GALT+5TECc3xGo5cLe
	 lwkzdaiP3cihxgij1lcEXDrajzJbGz+zV3r1MwhNh7kQZ8FJI+yjr8NNBi0L9efyvv
	 Lox6nsDCpzXaSYaOiz3nLLCEQBgSLGnXxg88DJjJDhERyrxMdWAmvQj3lCTLV6qG4F
	 dN+dgxa35w5q+BJpCtxa+04G95Xz5BRMEQD1PKZZ25ZmEEAHKJLfplYEMcWsXXbC+I
	 zglX4GXfTGz1fsH8ngHJJE5SmUwPsK+n/OD6LBA0w19T0BLsQHqCDmOg4TUh5joTtR
	 JU2XQnYIm6MEA==
Date: Wed, 13 May 2026 11:43:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH net-next v6 09/12] net: airoha: Do not stop GDM port if
 it is shared
Message-ID: <agRH12v6OeetUmtJ@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-9-c899462c4f75@kernel.org>
 <20260512213116.7414FC2BCB0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fA35iJO0kV4N5A4K"
Content-Disposition: inline
In-Reply-To: <20260512213116.7414FC2BCB0@smtp.kernel.org>
X-TUID: 4dQs7dXunW7S


--fA35iJO0kV4N5A4K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Stopping a net_device leaves its packets in the shared QDMA hard=
ware TX ring, causing a BUG_ON kernel panic or Use-After-Free when the hard=
ware later transmits them.
> - [Medium] When decreasing the MTU on a shared GDM port with multiple act=
ive users, the hardware MTU is not reduced to match the new global maximum.
> - [Low] The function parameter `netdev` is overwritten in a loop within `=
airoha_dev_stop()`.
> --
>=20
> commit 30071ffd90f181adfa0fb1ab6717d5d5cfa7e0e8
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Do not stop GDM port if it is shared
>=20
> Theoretically, in the current codebase, two independent net_devices can
> be connected to the same GDM port so we need to check the GDM port is not
> used by any other running net_device before setting the forward
> configuration to FE_PSE_PORT_DROP.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 4efd36779453e..aed182c7a5e17 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -1759,6 +1769,7 @@ static int airoha_dev_stop(struct net_device *net=
dev)
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> >  	struct airoha_gdm_port *port =3D dev->port;
> >  	struct airoha_qdma *qdma =3D dev->qdma;
> > +	u32 len =3D 0;
> >  	int i;
> > =20
> >  	netif_tx_disable(netdev);
> > @@ -1766,8 +1777,23 @@ static int airoha_dev_stop(struct net_device *ne=
tdev)
> >  	for (i =3D 0; i < netdev->num_tx_queues; i++)
> >  		netdev_tx_reset_subqueue(netdev, i);
>=20
> If another device is still using the QDMA (qdma->users > 1), the hardware=
 TX
> ring is not cleaned up. NAPI polling is bound to a dummy device and conti=
nues
> running.
>=20
> When NAPI later processes the stopped device's pending TX completions, it
> unconditionally calls netdev_tx_completed_queue() which invokes
> dql_completed().
>=20
> Since BQL was reset here, will this trigger a BUG_ON in
> lib/dynamic_queue_limits.c? Furthermore, if the device was unregistered,
> would the skb->dev access in the completion handler result in a
> use-after-free?

This issue is not introduced in this patch.

>=20
> > =20
> > -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> > -				    FE_PSE_PORT_DROP);
> > +	for (i =3D 0; i < ARRAY_SIZE(port->devs); i++) {
> > +		if (!port->devs[i])
> > +			continue;
> > +
> > +		netdev =3D port->devs[i]->dev;
>=20
> This isn't a bug, but this loop reassigns the local parameter netdev. Whi=
le
> it might be functionally harmless right now because netdev isn't derefere=
nced
> later in this function, could this create issues for future modifications
> expecting netdev to still point to the device being stopped?

ack, I will fix it in v7.

>=20
> > +		if (netif_running(netdev))
> > +			len =3D max_t(u32, len, netdev->mtu);
> > +	}
> > +	len +=3D ETH_HLEN + ETH_FCS_LEN;
> > +	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
> > +		      GDM_LONG_LEN_MASK,
> > +		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> > +
> [ ... ]
> > @@ -1919,13 +1945,18 @@ static void airoha_dev_get_stats64(struct net_d=
evice *netdev,
> >  static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +	u32 cur_len, len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
> >  	struct airoha_gdm_port *port =3D dev->port;
> > -	u32 len =3D ETH_HLEN + mtu + ETH_FCS_LEN;
> >  	struct airoha_eth *eth =3D dev->eth;
> > =20
> > -	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
> > -		      GDM_LONG_LEN_MASK,
> > -		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
> > +	cur_len =3D airoha_fe_get(eth, REG_GDM_LEN_CFG(port->id),
> > +				GDM_LONG_LEN_MASK);
> > +	if (len > cur_len || !port->users ||
> > +	    (port->users =3D=3D 1 && netif_running(netdev)))
> > +		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
> > +			      GDM_LONG_LEN_MASK,
> > +			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
>=20
> If there are multiple running devices on the shared port and they all low=
er
> their MTU, this condition prevents the hardware MTU from being updated to
> match the new global maximum. Should this iterate over port->devs to comp=
ute
> the actual maximum MTU of all running devices, similar to how it is handl=
ed
> in airoha_dev_stop()?

According to my understanding, airoha_dev_change_mtu() is running with RTNL
lock held so we will always have the max configured mtu in cur_len.

Regards,
Lorenzo

>=20
> > +
> >  	WRITE_ONCE(netdev->mtu, mtu);
> > =20
> >  	return 0;
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260511-airoha-eth-=
multi-serdes-v6-0-c899462c4f75@kernel.org?part=3D9

--fA35iJO0kV4N5A4K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagRH1wAKCRA6cBh0uS2t
rM31AQDunwBJ0DVCS5kAHpHwul4CaN/W8nGCUKRkGWyRHdTNNAD9HDklGrcRS6YR
qT2san+wDl2cbYm9Qr6rnVWH8iYZ8QM=
=oOYX
-----END PGP SIGNATURE-----

--fA35iJO0kV4N5A4K--

--rnuz2TvepxVF2bgU--

--d/PcUqUsNGyTp8Sh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagRIgQAKCRA6cBh0uS2t
rM9+AP9944+6LpcBvQ3ONeJjZedzFcvl93rGY8woeDtjQXwwiQEAkabyx2unc1Do
JXzWCNqJe3ITJiQC4mrpHZSPOb5nJws=
=jRva
-----END PGP SIGNATURE-----

--d/PcUqUsNGyTp8Sh--

