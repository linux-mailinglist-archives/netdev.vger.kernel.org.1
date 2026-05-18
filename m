Return-Path: <netdev+bounces-289188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLNlAA2PC2p1IwUAu9opvQ
	(envelope-from <netdev+bounces-289188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E8574590
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6DC1303ADF2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAE3A8746;
	Mon, 18 May 2026 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq5onsJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4B3A7F61;
	Mon, 18 May 2026 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142358; cv=none; b=neybbxE6nwJq4mXYUkTKlITgAPUgWequ1o3Bi3briZIu9bK8QfC2vQ6PBWdI5nHxS+9XATyaOXjZXIS9uW9bbjPgf66+hTrAkFdPbaknIFm078MKfcLJHPJx2cMtDwNEPR0Elb5LkwFMDI2P8b++Mqt42J9bqJLxO/2M1jcXbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142358; c=relaxed/simple;
	bh=SpNSHREmYK9MboW8xao/l5nmvqGd0LP2u2S/vlfhRZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccvmZX4BtDa06j8xcJ5E38wd1xYJd6EYBb0a2hUIPKz3/2ZMn4d231pN8zyFGzcW3PDTKPtxXfS9uEZ4UXimFO0NHVx4dfTZrW4UU6hw1CS9kSSnxFUhP+qXJnncqIzVSTNJx5RUJoEN8hkL0IXwgr5rVXq78CC69zRS1WYyHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq5onsJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526ACC2BCB7;
	Mon, 18 May 2026 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779142358;
	bh=SpNSHREmYK9MboW8xao/l5nmvqGd0LP2u2S/vlfhRZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oq5onsJHXHSNhfRbB5G20Ieyw3XwN5NhjZTGriT1nuN9il3gUmGmylT+bTUZQbY7l
	 xW+G4xeB7CW32ZYztnYNqv/MX82OIN/NLuxEwt11uLbLJz5MUrsposqB3dYeByMNj0
	 SC0+gUe32tpIFTamWb1pYPw1XxaHhq3G8SfyaludWqHM8z+I/MAMBtSG7NpGXmYn2s
	 axsRZB+CbBqtKM7LKHK1w5K8/LukCJqkL5ThYfXhnPGqERYbc1sMrJRf6rMx4mIBBB
	 kbSEJ6LW/b8STaCD9j8K8M5J+9CYTs9v3cP51X4lTCvMv+uSj0PDZSMC9z4/pFin5G
	 l3jT/YlhuTFVw==
Date: Tue, 19 May 2026 00:12:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: airoha: Do not stop GDM port if
 it is shared
Message-ID: <aguO1JODHEKFnsyk@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-8-99e0093303e2@kernel.org>
 <20260517055814.DB1F8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4fI9wqHOzbR04jOR"
Content-Disposition: inline
In-Reply-To: <20260517055814.DB1F8C2BCB0@smtp.kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 586E8574590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4fI9wqHOzbR04jOR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Flawed hardware MTU recalculation logic in airoha_dev_change_m=
tu() for shared GDM ports
> --
>=20
> commit 28e02ac4611575e19c4f6eef3fa74c11d4debb6e
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Do not stop GDM port if it is shared
>=20
> This commit updates the driver to allow multiple devices to share the same
> GDM port. It stops the port only when no other devices are using it and
> adjusts the hardware MTU to accommodate all active devices.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 8558790eca644..c70e3ace38e25 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> > @@ -1917,13 +1945,18 @@ static void airoha_dev_get_stats64(struct net_d=
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
> > +
>=20
> The commit message states that the driver must "always set in GDM_LONG_LE=
N_MASK
> field of REG_GDM_LEN_CFG register the maximum MTU of all running net_devi=
ces
> connected to the same GDM port."
>=20
> Does this logic successfully recalculate the MTU when the MTU of a running
> device is decreased while sibling devices are also running? In that scena=
rio,
> len > cur_len evaluates to false, which appears to skip the update and le=
ave
> the hardware MTU stuck at the previous larger value.
>=20
> Additionally, if an administratively down device has its MTU increased,
> len > cur_len can evaluate to true. Does this prematurely increase the
> hardware MTU, exposing the running sibling devices to larger frames based
> on a stopped device's configuration?
>=20
> Would it be more accurate to iterate over the devices to compute the
> actual maximum MTU of all active devices here, similar to the approach ta=
ken
> in airoha_dev_stop()?

ack, I will fix it in v8.

Regards,
Lorenzo

>=20
> >  	WRITE_ONCE(netdev->mtu, mtu);
> > =20
> >  	return 0;
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D8

--4fI9wqHOzbR04jOR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaguO1AAKCRA6cBh0uS2t
rMxgAQDiakfXuN/EA6krRVayUEnnJQbuFJCEexGZqaq235AU3AD+Le3t1oYn1xLl
/VNCiOD0wX6ypPz3JFSR2KHEa4TRxgo=
=5jbV
-----END PGP SIGNATURE-----

--4fI9wqHOzbR04jOR--

