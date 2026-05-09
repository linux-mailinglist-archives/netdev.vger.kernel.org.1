Return-Path: <netdev+bounces-286133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHOQNHYB/2mW1AAAu9opvQ
	(envelope-from <netdev+bounces-286133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:42:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1174FF06A
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A2DB3015A58
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA73914E2;
	Sat,  9 May 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk+pKtRg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CD3845A9;
	Sat,  9 May 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319723; cv=none; b=U34VKonyK6xyiFKSOqVEYCnGMkLHj3qtpqfrEbPOsnTzxExTc5cHO01iTVPwDxtTuPKyuAwXCE7UqrQ5XW6cW7e/1EbuxkDPXhMUPib9bKUEKRfp4H+Lh+L3WgazE5T3UMiJLniUQkHhhhh+F3aogczoUHfORtFTVAVt9cZKKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319723; c=relaxed/simple;
	bh=K7XW3fDrAi/SJUEYupM1iZBtmsSrwJ2WcBoDs0GiXxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t++gXGExnCew1/yZhGjd6Nyi+qpoJAbN0l174mSm+i3q2G/tf8hEgI4SOU1D+3Pz8xryJhe6j8TXTxYNWiH4TonkXFYbDIGggkAamFA72BALKXDE/NBY31k46e+CpOxJMk8RDfs5t8EqF/TIQDCAChxHcArcGMKzGVK9v/WR1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk+pKtRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F23C2BCB2;
	Sat,  9 May 2026 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778319723;
	bh=K7XW3fDrAi/SJUEYupM1iZBtmsSrwJ2WcBoDs0GiXxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk+pKtRgFMongdzhfKR4yRp3XwmtqK900PBJqUpGpyvNcTkt8ZYsevmTxvRsL3O2z
	 o7lW7WOaYHmWG1Ya+c/32+njK33gfkUEpVz5aRhqZ9DldJwXvKXzes+L6vSOLitcnh
	 JvDMNOenzFLp6IhorBIwVUlEzOheS4ILqATLz2B/WEqmThCKq7aTskkgoV/Y4Hjejl
	 wBtjkZdAWTT+jFwGvt9d86cfq39OINSSfEejj/uO9y9Ahrf6gVZr1X0rEncKSA1CkH
	 yMTDRkk13xaMIgZvflOLW01hRock4FvFRM3wbN1NyNBl/ZUy3IzrEkyno5l3zGgaY3
	 2dB7F7C5Vq1Yg==
Date: Sat, 9 May 2026 11:42:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 09/10] net: airoha: Introduce WAN device flag
Message-ID: <af8BaMnL9oXttB1t@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-9-af613b61ae02@kernel.org>
 <20260509014615.3558164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cVtlXQ1B6cbL+hCZ"
Content-Disposition: inline
In-Reply-To: <20260509014615.3558164-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 8A1174FF06A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286133-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--cVtlXQ1B6cbL+hCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: airoha: Introduce WAN device flag
>=20
> This commit replaces the port->id =3D=3D 1 LAN/WAN test with a per-dev
> PRIV_FLAG_WAN bit that is set during airoha_dev_init() based on the
> port id and the presence of other WAN devices. It also extracts the
> QDMA selection/PPE cpu port programming into a new helper and reworks
> the GDM2 loopback path to key off the new flag.
>=20
> A few questions about the new policy and error paths.
>=20
> [Medium]
> The commit message says:
>=20
>     Introduce WAN flag to specify if a given device is used to
>     transmit/receive WAN or LAN traffic. [...] Please note it is possible
>     to specify multiple LAN devices but just a single WAN one.
>=20
> Under the old helper (port->id =3D=3D 1), GDM2/GDM3/GDM4 were all treated=
 as
> WAN. Under the new logic, when GDM2 (eth->ports[1]) is present, the
> GDM3/GDM4 case breaks out of the switch without setting PRIV_FLAG_WAN, so
> GDM3 and GDM4 are now classified as LAN. That flips the MAC register
> (REG_FE_WAN_MAC_H -> REG_FE_LAN_MAC_H in airoha_set_macaddr()), the QDMA
> binding (qdma[1] -> qdma[0] in airoha_dev_set_qdma()), and the PPE cpu
> port (CDM2 -> CDM1). Is that role change intentional, and could the
> commit message call it out so bisecting a board that relied on the old
> GDM3/GDM4=3DWAN semantics is easier?

This change is intentional and this is currently not visible to the user
since airoha_eth driver currently supports just the internal phy available
via the MT7530 DSA switch and there are no WAN interfaces officially
supported since PCS/external phy is not merged mainline yet (it is posted j=
ust
as RFC in [0]). I will add this info in the commimit log in v5.

[0] https://lore.kernel.org/netdev/20260505182713.27644-1-ansuelsmth@gmail.=
com/

>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 1c4927c1aeb0..8617dd4f7932 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1863,36 +1863,77 @@ static int airoha_set_gdm2_loopback(struct airo=
ha_gdm_dev *dev)
> >  	return 0;
> >  }
> > =20
> > -static int airoha_dev_init(struct net_device *netdev)
> > +static struct airoha_gdm_dev *
> > +airoha_get_wan_gdm_dev(struct airoha_eth *eth)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> > +		struct airoha_gdm_port *port =3D eth->ports[i];
> > +		int j;
> > +
> > +		if (!port)
> > +			continue;
> > +
> > +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> > +			struct airoha_gdm_dev *dev =3D port->devs[j];
> > +
> > +			if (dev && !airoha_is_lan_gdm_dev(dev))
> > +				return dev;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
>=20
> [High]
> airoha_register_gdm_devices() invokes airoha_dev_init() for each dev in
> port->devs[] sequentially. On EN7581 GDM3 supports two devs (nbq 4/5 for
> PCIE0/PCIE1 in airoha_alloc_gdm_device()). When both devs are registered,
> devs[0] sets PRIV_FLAG_WAN and then devs[1] sees the first via
> airoha_get_wan_gdm_dev() and falls through to LAN. Is that the intended
> result for two devs on the same physical GDM3/GDM4 port?
>=20
> The two devs then diverge:
>=20
>   airoha_dev_set_qdma()
>     dev->qdma =3D &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
>=20
> so devs[1] binds to qdma[0] while devs[0] is on qdma[1];
>=20
>   airoha_set_macaddr()
>     reg =3D airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H
>                                      : REG_FE_WAN_MAC_H;
>=20
> so devs[1] writes into the LAN MAC range that belongs to GDM1; and in
> airoha_ppe_foe_entry_prepare() pse_port becomes port->id instead of 2
> (GDM2 loopback) only for devs[1]. Is there an assumption that sibling
> devs on the same port must share the WAN/LAN classification?

A subsequent patch in the series adds suppport for multiple net_device that
share the same LAN/WAN mac address register space.
Moreover, I will post subsequent patches (not in the series) to dynamically
set/get net_device LAN/WAN configuration.

>=20
> > +
> > +static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
> >  {
> > -	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > -	struct airoha_gdm_port *port =3D dev->port;
> >  	struct airoha_eth *eth =3D dev->eth;
> >  	int i;
> > =20
> >  	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
> >  	dev->qdma =3D &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
> >  	dev->dev->irq =3D dev->qdma->irq_banks[0].irq;
> > -	airoha_set_macaddr(dev, netdev->dev_addr);
> > +
> > +	for (i =3D 0; i < eth->soc->num_ppe; i++)
> > +		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> > +}
> > +
> > +static int airoha_dev_init(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +	struct airoha_gdm_port *port =3D dev->port;
> > =20
> >  	switch (port->id) {
> >  	case AIROHA_GDM3_IDX:
> > -	case AIROHA_GDM4_IDX:
> > -		/* If GDM2 is active we can't enable loopback */
> > -		if (!eth->ports[1]) {
> > -			int err;
> > +	case AIROHA_GDM4_IDX: {
> > +		struct airoha_eth *eth =3D dev->eth;
> > =20
> > -			err =3D airoha_set_gdm2_loopback(dev);
> > -			if (err)
> > -				return err;
> > -		}
> > +		if (eth->ports[1] || airoha_get_wan_gdm_dev(eth))
> > +			break;
>=20
> [Medium]
> Is the eth->ports[1] check equivalent to asking whether a GDM2 dev
> actually exists? airoha_alloc_gdm_port() assigns eth->ports[p] before
> iterating the "airoha,eth-port" child nodes, so with all GDM2 child nodes
> marked status=3D"disabled" and GDM3 or GDM4 enabled, eth->ports[1] is
> non-NULL but port->devs[] is empty. In that case this branch still breaks
> out of the switch and the uplink GDM3/GDM4 dev ends up LAN. Would checking
> for an actual dev under eth->ports[1] be safer than checking the port
> pointer alone?

ack, I will fix it in v5.

>=20
> [Medium, Low]
> The policy that "just a single WAN one" is allowed is enforced by silently
> breaking here when airoha_get_wan_gdm_dev() returns non-NULL. Would a
> netdev_warn() or -EINVAL help an administrator notice that a second WAN
> candidate was demoted to LAN? Also, with both GDM3 and GDM4 enabled and
> GDM2 absent, the winner of PRIV_FLAG_WAN depends on eth->ports[] iteration
> order and the port/dev allocation order; is there a deterministic,
> documented way to choose which dev becomes WAN (DT property, for example)?

We can't return -EINVAL here since we still need to run airoha_dev_set_qdma=
()
and airoha_set_macaddr(). Moreover, I will post subsequent patches (not in =
the
series) to dynamically set/get net_device LAN/WAN configuration.

>=20
> > +		fallthrough;
> > +	}
> > +	case AIROHA_GDM2_IDX:
> > +		/* GDM2 is always used as wan */
> > +		dev->flags |=3D PRIV_FLAG_WAN;
> >  		break;
> >  	default:
> >  		break;
> >  	}
> > =20
> > -	for (i =3D 0; i < eth->soc->num_ppe; i++)
> > -		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
> > +	airoha_dev_set_qdma(dev);
> > +	airoha_set_macaddr(dev, netdev->dev_addr);
> > +
> > +	if (!airoha_is_lan_gdm_dev(dev) &&
> > +	    (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4_I=
DX)) {
> > +		int err;
> > +
> > +		err =3D airoha_set_gdm2_loopback(dev);
> > +		if (err) {
> > +			dev->flags &=3D ~PRIV_FLAG_WAN;
> > +			return err;
> > +		}
> > +	}
>=20
> [Medium]
> On the error path, is clearing PRIV_FLAG_WAN sufficient? By the time
> airoha_set_gdm2_loopback() returns a failure, airoha_dev_set_qdma() has
> already pointed dev->qdma at &eth->qdma[1] and set dev->dev->irq to the
> WAN IRQ, airoha_set_macaddr() has written into REG_FE_WAN_MAC_H,
> airoha_ppe_set_cpu_port() has programmed CDM2 as the PPE cpu port, and
> airoha_set_gdm2_loopback() itself may have already programmed
> REG_GDM_FWD_CFG(GDM2), REG_GDM_TXCHN_EN/RXCHN_EN, REG_GDM_LPBK_CFG,
> REG_GDM_LEN_CFG, REG_FE_VIP_PORT_EN and REG_FE_IFC_PORT_EN before the
> get_sport() branch failed.
>=20
> After clearing the flag airoha_is_lan_gdm_dev(dev) reports LAN but
> dev->qdma and the hardware registers above still describe the WAN setup.
> Would it be cleaner to either unwind those steps or drop the flag clear?

In this case net_device registration will fail and the pending hw configura=
tion
will not affect other running devices. I guess we can avoid to add unnecess=
ary
code complexity.

>=20
> > =20
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index 3a313ac439e7..5715b03e630b 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -540,12 +540,17 @@ struct airoha_qdma {
> >  	u64 fwd_tx_packets;
> >  };
> > =20
> > +enum airoha_priv_flags {
> > +	PRIV_FLAG_WAN =3D BIT(0),
> > +};
>=20
> [Low]
> This isn't a bug, but PRIV_FLAG_WAN and the u32 flags field below overlap
> conceptually with struct net_device::priv_flags and the IFF_* namespace.
> Would a driver-prefixed name such as AIROHA_DEV_F_WAN make the
> driver-local scope obvious to future readers?

ack, I will fix it in v5.

Regards,
Lorenzo

>=20
> > +
> >  struct airoha_gdm_dev {
> >  	struct airoha_gdm_port *port;
> >  	struct airoha_qdma *qdma;
> >  	struct airoha_eth *eth;
> >  	struct net_device *dev;
> > =20
> > +	u32 flags;
> >  	int nbq;
> >  };
>=20
> [ ... ]

--cVtlXQ1B6cbL+hCZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf8BaAAKCRA6cBh0uS2t
rJSeAP0QBnXEgLvI07F2C7GkDzkU+BlJ80LyIyCiwOmzBYCIZAEAtQDBtjNFBFVg
QO9/RuVlx3Ku7yx9L95neIwOm3mJDws=
=k9t2
-----END PGP SIGNATURE-----

--cVtlXQ1B6cbL+hCZ--

