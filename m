Return-Path: <netdev+bounces-289330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL8pF64jDGpqXAUAu9opvQ
	(envelope-from <netdev+bounces-289330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D561557A733
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59876306B55D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ABB3E1CFD;
	Tue, 19 May 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzr8mfJn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028C3E173D;
	Tue, 19 May 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179876; cv=none; b=S43kV6zlg14G2ZawL2BvDNrbh5OboIYm70l7oVSIhHXe5pLOXhvCzcPthATVz7UJCRkAMHFiPlSbxMbev0Op+o7oomZSbrKy7yIte8nmq2UtRbKOt/nOesfZzMsRA5iL2l89uQRIDMh571VorY51F4zgLHjQv4e36GZh3rNkHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179876; c=relaxed/simple;
	bh=IhCg9hQ7TA0OsyArZ3MT3Wx1G3TYybLj1nvD4TQ0T/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbg3Sb+EbUjyGWzIxaRAJJ2JGU+4ZwRMpkc5NRltrvF6loUqYaVZA3ojPGB9+zD7JCiYZWfu7w3NyrOc19Ns3KVMkp+o7xJVqVDRKYJTTm87oEaBRKZ7TWwOrBDN810S2x2rt/HJuATSCQ2wP4WV+QfqK9a4ECsgICDibDZS2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzr8mfJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6734C2BCB3;
	Tue, 19 May 2026 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179876;
	bh=IhCg9hQ7TA0OsyArZ3MT3Wx1G3TYybLj1nvD4TQ0T/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bzr8mfJnKGmNmn3/YOA1EICKhRqvkYz+S3+GN0uDBsA1XvcQEuFPfnlsQaRwjvfQ4
	 TNx6Hg3Z3sQYZsPDfstP1HIKMQUoMxQ7djSsZ3UlNX7+U7pdvwDOL/WcDrIbDqW6tT
	 IHdA+r01i/do+dbYWV04m+89FtKeoTfP7p8Z/mYis3J5x4vpAraghwp15/F4CoBz9x
	 AUeXpeZkOCxr6bktyYBbzP+m7n25xIdG542nNbaL4JevmILYaqzVnLVJ/AHCDhVpOq
	 wpW27EcN7ykJhsRaSeAgTZjzA55EtbaoiSBnhDIdO7Ib7u12Y3OQUoSEsBg3xRBTy8
	 WczD+qkJ/sMuA==
Date: Tue, 19 May 2026 10:37:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <agwhYWN-6-c7syDK@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-10-99e0093303e2@kernel.org>
 <20260517055815.89B7CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qQqzhGnGkjNnj5Yx"
Content-Disposition: inline
In-Reply-To: <20260517055815.89B7CC2BCB0@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D561557A733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qQqzhGnGkjNnj5Yx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Device probe fails when multiple LAN/WAN interfaces are assigned=
 randomly generated MAC addresses.
> --
>=20
> commit 7861c44e7e1da4203e80f67d02418deac7e491b4
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple LAN/WAN interfaces for hw MAC address confi=
guration
>=20
> This commit extends the hardware MAC address configuration logic in the a=
iroha
> driver to support multiple LAN or WAN interfaces by deriving minimum and
> maximum values for the lower MAC bytes, while expecting the upper MAC byt=
es to
> be shared.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -71,20 +71,69 @@ static void airoha_qdma_irq_disable(struct airoha_i=
rq_bank *irq_bank,
> >  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
> >  }
> > =20
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >  {
> > +	u8 ref_addr[ETH_ALEN] __aligned(2);
> >  	struct airoha_eth *eth =3D dev->eth;
>=20
> [ ... ]
>=20
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
>=20
> If the device tree lacks a MAC address for an interface and the driver as=
signs
> a random one via eth_hw_addr_random(), will this comparison fail during d=
evice
> probe?
>=20
> Since eth_hw_addr_random() generates independent random bytes for each
> interface, the upper 3 bytes will likely mismatch. This returns -EINVAL a=
nd
> propagates up to register_netdev(), which causes the driver probe to abor=
t.
>=20
> Prior to this patch, the hardware MAC register was overwritten with the n=
ewest
> interface's MAC, but the probe continued successfully. Can this be adjust=
ed to
> handle randomly generated MAC addresses without aborting the probe?

As already pointed out this is a requirement imposed by the hw design. Plea=
se
note we are not introducing any regression since this is required just when=
 we
have multiple net_devices configured as LAN and this feature is introduced =
by
this patch.

Regards,
Lorenzo

>=20
> > +		/* According to the HW design, hw mac address MS bits
> > +		 * must be the same for each net_device with the same
> > +		 * LAN/WAN configuration.
> > +		 */
> > +		netdev_err(dev->dev, "wrong mac addr for shared GDM port\n");
> > +		return -EINVAL;
> > +	}
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D10

--qQqzhGnGkjNnj5Yx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagwhYQAKCRA6cBh0uS2t
rNHeAPsEf3993KpAQ/Rp9ao/wfzefUN6thROAQvEF6FNAXo2vwD9FkDO3+fb9e8j
Z7HZtR2wULBvMURHYFMooMMxPGEOjA8=
=J5Ge
-----END PGP SIGNATURE-----

--qQqzhGnGkjNnj5Yx--

