Return-Path: <netdev+bounces-277368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLgtA/Hl2GmZjggAu9opvQ
	(envelope-from <netdev+bounces-277368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:58:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D0C3D6780
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2A83008D37
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866E3BC692;
	Fri, 10 Apr 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQeciTH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADA3BBA0D;
	Fri, 10 Apr 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821888; cv=none; b=XSfCcP/EBGLhaf6kqXg36OgXCY0RcdQi1HHxHGiG/nxLGF8CT0DF3s2dBoxJPgBn3XIiedtuxUzgJ2FEUveWQMkww+g4fTcDP6W5om+0YCuBxmDo8LKWx1y3K44X/JKjToLRQK91FxoP5F4zhKu5gy3Lj3WHYjRvl8nsfplF4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821888; c=relaxed/simple;
	bh=/v9RdEAhzS37lCkkSXoeeZkAOF1mvH24IcozDlYc1Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwuSwFuAG7Ddpjichn6cAKCNSfPkY6d/hk7LWCYEnB4E0foZrQXC78ghYGfS97U+YYtcaB6CMycSQyGGEDvZdzLDPg2BNWtsNp+zkjmDWTXbV7PpSjXxRI/mpxOuE9m+TqY23mmpBajWurIFNGhwl3hyLoScqpHXz7Fo83S9c5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQeciTH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941C8C19421;
	Fri, 10 Apr 2026 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821888;
	bh=/v9RdEAhzS37lCkkSXoeeZkAOF1mvH24IcozDlYc1Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQeciTH0wbDVxWHCfhuS6Y+LIbp5to6StlVHunODdUah0VDc4u/jwg+o7W3Voy080
	 LkSxAjQphEBPvs0gRrMpCLXGplUiVEvBLQuC9fAuPy79tEjvwAtQ7DqzCKvDt7Al+g
	 K79MgjIo4vgMuGGAWor9mF8IVp4WtYDlqN8NSJtIEHMTjHnLgloM1Y49UxTuSpknrL
	 sWTf+er889DEsqaUIQebfp3BgNbwgnS/4+3JGbDSQR9INnlrnBuJ0WQX90BWIxZmyo
	 YlFy+6K7ZW9UkTSYQ9DMaS0eX9fHNMO9zf4IRWOIIZnmF4D93WmJPT7xNwCP6QpkiJ
	 RtN2KLgdUMx/w==
Date: Fri, 10 Apr 2026 13:51:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/12] net: airoha: Rely on net_device
 pointer in HTB callbacks
Message-ID: <adjkPSK-qR5UAuA-@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-4-ab6ea49d59ff@kernel.org>
 <20260410025722.1809973-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7W5gcngAA2i51Gam"
Content-Disposition: inline
In-Reply-To: <20260410025722.1809973-1-kuba@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277368-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93D0C3D6780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7W5gcngAA2i51Gam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email says "For your consideration."
> ---
> net: airoha: Introduce WAN device flag
>=20
> This commit introduces a WAN flag to specify whether a device is used to
> transmit or receive WAN or LAN traffic. It enables specifying multiple LAN
> devices but limits the configuration to a single WAN device.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 5b0cd37b155e4..9988011dca53f 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1796,36 +1796,77 @@ static int airoha_set_gdm2_loopback(struct airo=
ha_gdm_dev *dev)
>=20
> [ ... ]
>=20
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
> If a board's Device Tree enables both GDM3 and GDM4, and GDM2 is not pres=
ent,
> does this sequence permanently assign the WAN role to GDM3 since it is
> initialized first? Is there a Device Tree property or fallback configurat=
ion
> mechanism to allow users to specify GDM4 as the WAN port instead?

This issue will be fixed with following series that allows to dynamically
select LAN or WAN configuration at runtime.

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
>=20
> Since the commit message notes it is possible to specify multiple LAN
> devices, does unconditionally calling airoha_set_macaddr() for each
> device overwrite the single shared hardware LAN MAC register?
>=20
> If so, could this cause only the last initialized LAN device to have its =
MAC
> correctly programmed into the hardware, leading to dropped unicast
> packets for the other LAN interfaces?
>=20
> > +
> > +	if (!airoha_is_lan_gdm_dev(dev) &&
> > +	    (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4_I=
DX)) {
> > +		int err;
>=20
> [ ... ]

--7W5gcngAA2i51Gam
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadjkPQAKCRA6cBh0uS2t
rHwtAQCeVEB7opEH1jTAFAZgyCK8krbgv67AHGuqZexgJaekzQEApxT1RtXkOtbj
ZispmFs1Ej3NlAgqNDlkItlht8fBzwM=
=cCJU
-----END PGP SIGNATURE-----

--7W5gcngAA2i51Gam--

