Return-Path: <netdev+bounces-274979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Km3AhqWz2nmxQYAu9opvQ
	(envelope-from <netdev+bounces-274979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E13934B0
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F13A30E100A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D353A6B69;
	Fri,  3 Apr 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuWoeCS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAC3A75A9;
	Fri,  3 Apr 2026 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211519; cv=none; b=sFk0WK/XDvcvSVLjb6haQEgiIIAWHs1GNx5uF7E1XOoLIxJxACaXzB4DPT1lz3WqLs9WizxcQ3dQRvWuG8/2kv0gG7l1P78s6OIkx2iLE9d5UFkhseiSVpKWdXSXZqMBTEFKQiO0IjFv1QDBlnseKMjKRn4zJGI7mHtx1iGkPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211519; c=relaxed/simple;
	bh=88tMHoUUWmi1PJoD+n4oQI0lN0JAMMrQTdtZ93Vgmsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmOV1/0u8F9hph2fWhumuKFxmhH7nrKf6wN274FyV78DNzY+3tHOfibfHJY1jRX3zT4dS+Gdq1KI+4GNz37dYe6dQ1nXBdKG3a3iGoDr5bVpFf7HTuqpHDJeGk1BkawpV/IeODeDRoWLYNwo641kSxcKNfqTjQ9VZLjeXJYwXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuWoeCS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6909C19423;
	Fri,  3 Apr 2026 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775211518;
	bh=88tMHoUUWmi1PJoD+n4oQI0lN0JAMMrQTdtZ93Vgmsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuWoeCS7h902ubwxZePg8q5liA2YqnbSs0vmMCtIEJa4iZ9g6uh5qAe78HA66zVSo
	 zcHGAYJQl1TKeG2vOqOBI/egUoFcJMv4IpEvwF5795bTFnIvVeOOb1keeWbY8SBlVH
	 kePPWevvdj/vORgWSlfo4lqMVwxLX1LyBbbSrGWPiRG6qFZPcbWHMkxaOerkmd6jVH
	 acN0LgbwBO98ypTpPGIa/echLsWZ83d3mu1rsQFv1xqLifJTr/LOFX2DSZKBnb27z7
	 vuAfuPCKz1/CjrIelV9L4h4t7DiAlx9sNq3qdVaJlbtypRwc8vjWN5Jf+TYXal7OKL
	 pDnJhVBUYxFaQ==
Date: Fri, 3 Apr 2026 12:18:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/11] net: airoha: Do not stop GDM port if
 it is shared
Message-ID: <ac-T-4gbX9Fmhbtb@lore-desk>
References: <20260401-airoha-eth-multi-serdes-v2-10-ac427ae4beeb@kernel.org>
 <20260403011229.1785808-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8drteVwn+iFzTVzY"
Content-Disposition: inline
In-Reply-To: <20260403011229.1785808-1-kuba@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274979-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 545E13934B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--8drteVwn+iFzTVzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: airoha: Do not stop GDM port if it is shared
>=20
> This patch introduces a port->users reference counter to prevent setting
> the GDM port forward configuration to FE_PSE_PORT_DROP if another net_dev=
ice
> is still using the shared GDM port.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 0780fb8aacfb..3f9bce8c5370 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -1681,9 +1682,6 @@ static int airoha_dev_stop(struct net_device *net=
dev)
> >  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx); i++)
> >  		netdev_tx_reset_subqueue(netdev, i);
> > =20
> > -	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
> > -				    FE_PSE_PORT_DROP);
> > -
> >  	if (atomic_dec_and_test(&qdma->users)) {
> >  		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> >  				  GLOBAL_CFG_TX_DMA_EN_MASK |
>=20
> While this patch aims to support shared GDM ports, does the remaining
> unconditional call to airoha_set_vip_for_gdm_port(dev, false) at the start
> of airoha_dev_stop() break other active devices sharing the port?
>=20
> static int airoha_dev_stop(struct net_device *netdev)
> {
>         ...
>         err =3D airoha_set_vip_for_gdm_port(dev, false);
>         ...
> }
>=20
> This appears to clear the REG_FE_VIP_PORT_EN and REG_FE_IFC_PORT_EN hardw=
are
> bits for the physical port, which might instantly kill traffic for any ot=
her
> active interface using the shared port.
>=20
> Similarly, in airoha_dev_open() and airoha_dev_change_mtu(), the
> REG_GDM_LEN_CFG (MTU) is overwritten unconditionally. If a device with a
> smaller MTU is brought up, will it overwrite the shared port's MTU limit
> and cause the hardware to silently drop larger packets for the other devi=
ce?

ack, I will fix it in v3.

>=20
> [ ... ]
> > @@ -1697,6 +1695,11 @@ static int airoha_dev_stop(struct net_device *ne=
tdev)
> >  		}
> >  	}
> > =20
> > +	if (atomic_dec_and_test(&port->users))
> > +		airoha_set_gdm_port_fwd_cfg(qdma->eth,
> > +					    REG_GDM_FWD_CFG(port->id),
> > +					    FE_PSE_PORT_DROP);
> > +
> >  	return 0;
> >  }
>=20
> Does moving this FE_PSE_PORT_DROP configuration to the end of airoha_dev_=
stop()
> cause a race condition when stopping the device?
>=20
> In airoha_dev_open(), the driver correctly enables the QDMA engine before
> configuring the GDM port to forward packets. A safe teardown typically
> mirrors this by first stopping the packet source (setting FE_PSE_PORT_DRO=
P)
> and then disabling the destination DMA engine.
>=20
> By moving airoha_set_gdm_port_fwd_cfg() after the airoha_qdma_clear() blo=
ck,
> when both qdma->users and port->users reach zero, the QDMA engine and its
> queues are shut down while the GDM port is still actively forwarding pack=
ets.
>=20
> Could incoming packets be forwarded to a disabled DMA engine during this
> window, risking hardware lockups or buffer leaks?

ack, I will fix it in v3.

Regards,
Lorenzo

--8drteVwn+iFzTVzY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCac+T+wAKCRA6cBh0uS2t
rBm2AQCvBVHq6iuxtRf5otgmibRNOjubyAtWc+9ULdeW0GtT6AD+M6TIdwlOOCIg
GsdGbqFmP8JPFncb7+dbSHLUnEJBuQc=
=qvfH
-----END PGP SIGNATURE-----

--8drteVwn+iFzTVzY--

