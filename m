Return-Path: <netdev+bounces-286141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIIZGIQH/2lg1QAAu9opvQ
	(envelope-from <netdev+bounces-286141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 12:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AC4FF1A0
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64B303006102
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D039F193;
	Sat,  9 May 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leuQxIIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DE208D0;
	Sat,  9 May 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321281; cv=none; b=gSIL08X5mGCPAiAXCWBEEkWNUKOYUl/19es9/cCcQ01flfR1oHDykK0ijjaLZYDHA86eAFlRRfpVBRQe4zDxhz379+BWhBNO6mNts2YYt0e8ZBBMDgEN1FdHaqEmHoZPeEshApL8/IuwRSAvV7m98M4c/7Vm5gXYOi4Wz23iu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321281; c=relaxed/simple;
	bh=DrVObXvVSvJ6Qh3ggMiOeo7pce3nKF+OLq2GUfFw0YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD7b0STLYD/XUwPb7ScKJdK1cuNZ4vzuuiEBQMW/idtyPpFczmc5aMx8JSin4ZFyxsQCYjCmeJQY6HQn48ZgaIL6PM4dxH/hkjv8QB3CMHLHO1uzLUWFXlqmn/4A/zCZLIPTt1k3Shl/QPY2GubJ/4wUM+PZeIu25wF/tsZezkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leuQxIIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB13C2BCB2;
	Sat,  9 May 2026 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778321281;
	bh=DrVObXvVSvJ6Qh3ggMiOeo7pce3nKF+OLq2GUfFw0YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leuQxIIGtL3ySmiM8r5mjMlZARE6dzdT/vnEblM99cn6q33QGI+M//l8mhH1tVRik
	 qW44qun4uM4o9P/wQC8aR7XEPNxLiuxUZR+d1RuachQXa97iWgYAfgt5YHTbzpcX7c
	 KCzR/czetJFcaiBkWeZjfaDLql0F4scJzYDwQxGUDDcLi2TwHrM+p4Utk2WSPdleY8
	 jCl5i119bdw/3KvuZRhJxETpB3xUK+QDCSXShe32v65GNbScFKbxUSyJCP/3K3mIyQ
	 DasZs8wAvGZ1hQLVr63crBdR95qNDS3JhiIBHWnu0iWTdFMcypVu6Zr4YPLG2Q7frZ
	 8B1qWoWZEUpeA==
Date: Sat, 9 May 2026 12:07:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <af8HfuSZ1hkJGA2O@lore-desk>
References: <20260507-airoha-eth-multi-serdes-v4-10-af613b61ae02@kernel.org>
 <20260509014617.3558185-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lg/EUJE1MTlDMtub"
Content-Disposition: inline
In-Reply-To: <20260509014617.3558185-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 062AC4FF1A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286141-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--lg/EUJE1MTlDMtub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: airoha: Support multiple LAN/WAN interfaces for hw MAC address confi=
guration
>=20
> This patch extends airoha_set_macaddr() to derive REG_FE_MAC_LMIN and
> REG_FE_MAC_LMAX by iterating over all sibling LAN/WAN net_devices, and
> rejects addresses whose upper 3 bytes do not match the already-registered
> peers. airoha_dev_set_macaddr() is also changed to split eth_mac_addr()
> into eth_prepare_mac_addr_change() and eth_commit_mac_addr_change() around
> the hardware programming step.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 8617dd4f7932..fbfefd0ec355 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_i=
rq_bank *irq_bank,
> >  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
> >  }
> > =20
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >  {
> >  	struct airoha_eth *eth =3D dev->eth;
> > -	u32 val, reg;
> > +	u8 ref_addr[ETH_ALEN] =3D {};
> > +	u32 reg, val, lmin, lmax;
> > +	int i;
> > +
> > +	lmin =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
> > +	lmax =3D lmin;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> > +		struct airoha_gdm_port *port =3D eth->ports[i];
> > +		int j;
> > +
> > +		if (!port)
> > +			continue;
> > +
> > +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> > +			struct airoha_gdm_dev *iter_dev;
> > +			struct net_device *netdev;
> > +
> > +			iter_dev =3D port->devs[j];
> > +			if (!iter_dev || iter_dev =3D=3D dev)
> > +				continue;
> > +
> > +			if (airoha_is_lan_gdm_dev(iter_dev) !=3D
> > +			    airoha_is_lan_gdm_dev(dev))
> > +				continue;
> > +
> > +			netdev =3D iter_dev->dev;
> > +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> > +				continue;
> > +
> > +			ether_addr_copy(ref_addr, netdev->dev_addr);
> > +			val =3D (netdev->dev_addr[3] << 16) |
> > +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> > +			if (val < lmin)
> > +				lmin =3D val;
> > +			if (val > lmax)
> > +				lmax =3D val;
> > +		}
> > +	}
> > +
> > +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
> > +		/* According to the HW design, hw mac address MS bits
> > +		 * must be the same for each net_device with the same
> > +		 * LAN/WAN configuration.
> > +		 */
> > +		return -EINVAL;
> > +	}
>=20
> [Medium]
> The NETREG_REGISTERED filter here means the check only sees peers that
> have already completed register_netdev(). airoha_dev_init() is invoked
> as ndo_init from register_netdev() before dev->reg_state transitions
> to NETREG_REGISTERED, so the constraint is only enforced across
> already-registered siblings.
>=20
> When the device tree does not supply a mac-address property,
> airoha_alloc_gdm_device() falls back to eth_hw_addr_random() and each
> sibling gets an independently generated random MAC. With two or more
> LAN (or two or more WAN) net_devices going through this fallback, the
> second and later siblings' upper 3 bytes will almost always differ
> from the first, so airoha_set_macaddr() returns -EINVAL:
>=20
> 	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3))
> 		return -EINVAL;
>=20
> airoha_dev_init() now propagates that error, which fails
> register_netdev() and airoha_register_gdm_devices(), aborting probe.
>=20
> Before this patch the same configuration still came up (with the single
> REG_FE_{LAN,WAN}_MAC_H being last-writer-wins). Should the random
> fallback path derive sibling MACs from a shared base, or should the
> upper-3-bytes constraint only be enforced for user-triggered
> ndo_set_mac_address rather than for init-time programming?

Hw design requires that if two (or more) net_devices are configured as LAN
(or theoretically as WAN), they need to share the mac address upper-3-bytes.
If the user wants to use multiple devices with the same LAN/WAN configurati=
on,
he/she will need to properly store the net_device mac address int the device
eeprom/nvme or in the dts.
Please note this series is not introducing any regression since the user was
not able to run this configuration before this series.

>=20
> > =20
> >  	reg =3D airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MA=
C_H;
> >  	val =3D (addr[0] << 16) | (addr[1] << 8) | addr[2];
> >  	airoha_fe_wr(eth, reg, val);
> > =20
> > -	val =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
> > -	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
> > -	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
> > +	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), lmin);
> > +	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), lmax);
> > =20
> >  	airoha_ppe_init_upd_mem(dev);
> > +
> > +	return 0;
> >  }
> > =20
> >  static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 ad=
dr,
> > @@ -1792,13 +1839,18 @@ static int airoha_dev_stop(struct net_device *n=
etdev)
> >  static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
> >  {
> >  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> > +	struct sockaddr *addr =3D p;
> >  	int err;
> > =20
> > -	err =3D eth_mac_addr(netdev, p);
> > +	err =3D eth_prepare_mac_addr_change(netdev, p);
> >  	if (err)
> >  		return err;
> > =20
> > -	airoha_set_macaddr(dev, netdev->dev_addr);
> > +	err =3D airoha_set_macaddr(dev, addr->sa_data);
> > +	if (err)
> > +		return err;
> > +
> > +	eth_commit_mac_addr_change(netdev, p);
> > =20
> >  	return 0;
> >  }
>=20
> [High]
> After this reordering, does airoha_ppe_init_upd_mem() end up
> programming the PPE update memory with the old MAC rather than the new
> one?
>=20
> eth_prepare_mac_addr_change() only validates the sockaddr and does not
> touch netdev->dev_addr; the actual write to netdev->dev_addr happens in
> eth_commit_mac_addr_change() via eth_hw_addr_set():
>=20
> net/ethernet/eth.c:eth_prepare_mac_addr_change() {
> 	if (!(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev))
> 		return -EBUSY;
> 	if (!is_valid_ether_addr(addr->sa_data))
> 		return -EADDRNOTAVAIL;
> 	return 0;
> }
>=20
> net/ethernet/eth.c:eth_commit_mac_addr_change() {
> 	eth_hw_addr_set(dev, addr->sa_data);
> }
>=20
> airoha_set_macaddr() is invoked between those two, so when it reaches
> airoha_ppe_init_upd_mem(dev) the commit has not yet run. That helper
> reads netdev->dev_addr directly rather than using the addr argument:
>=20
> drivers/net/ethernet/airoha/airoha_ppe.c:airoha_ppe_init_upd_mem() {
> 	const u8 *addr =3D netdev->dev_addr;
> 	...
> 	val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
> 	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> 	...
> 	val =3D (addr[0] << 8) | addr[1];
> 	airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> 	...
> }
>=20
> So the FE registers REG_FE_{LAN,WAN}_MAC_H / REG_FE_MAC_LMIN /
> REG_FE_MAC_LMAX are written from the new addr parameter, but the PPE
> REG_UPDMEM_DATA/REG_UPDMEM_CTRL entries are written from the still-old
> netdev->dev_addr.
>=20
> Previously eth_mac_addr() (prepare + commit combined) ran first, so
> netdev->dev_addr was the new MAC by the time airoha_set_macaddr() and
> airoha_ppe_init_upd_mem() ran, keeping the two blocks in sync.
>=20
> Would it be cleaner to either pass addr through to
> airoha_ppe_init_upd_mem(), or invoke eth_commit_mac_addr_change() before
> airoha_set_macaddr() (with a rollback path if the hardware programming
> fails)?

ack, I will fix it in v5.

Regards,
Lorenzo

>=20
> > @@ -1903,6 +1955,7 @@ static int airoha_dev_init(struct net_device *net=
dev)
> [ ... ]

--lg/EUJE1MTlDMtub
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaf8HfgAKCRA6cBh0uS2t
rCrFAQC4cypXPyLYpkfCjZ+8fARSlLo1SxcqMz7kvKN7sd0RnAEAx5U4W8tYhksn
GK2mSoplDd6MwDsxrrEmtIg5gaY9ogw=
=61qR
-----END PGP SIGNATURE-----

--lg/EUJE1MTlDMtub--

