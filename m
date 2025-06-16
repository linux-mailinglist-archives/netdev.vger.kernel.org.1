Return-Path: <netdev+bounces-198065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E8ADB22D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DEA175B04
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BEF2DF3C7;
	Mon, 16 Jun 2025 13:35:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE992DBF72
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080900; cv=none; b=Wv2wrrujQ4GMdJwcxbzW9qM8+zljTbJxZFbswd9PLVO1apKhP5FdQt1jQfTOW3qwd39BP4eR3wpIOo7OxGDsLITA/hpDCHswk/WkuBvE+dxHOLHEwH3zkkZt2lm4OYE6pR8T0C3lGBPltPlzB4TFC1cBmW3Ch9m4QDgP3MmX8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080900; c=relaxed/simple;
	bh=A9wFcAqQwmUZpiuDblwurVpuPc0+SJEASs4pwtKduTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5m+WCioClCO1JDDcnCJz0jJufIUA/weKb4a2+Ceqr+Wlg9g/6xBfqOIjCehrq5a679PfHIxlJQSn8/WVKvqO+52nquzi9VBNcv4c3h2e5QhjnKP7+ZBYruQ51YlWQ5AD9h3DqOT62pJbl2tT8p5ZgCpKyegJscrAG5U2PItYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uR9z2-0001e3-42; Mon, 16 Jun 2025 15:34:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uR9z0-003ocA-2t;
	Mon, 16 Jun 2025 15:34:42 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 66E1F42893E;
	Mon, 16 Jun 2025 13:34:42 +0000 (UTC)
Date: Mon, 16 Jun 2025 15:34:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Message-ID: <20250616-positive-vicugna-of-felicity-9239d9-mkl@pengutronix.de>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-7-ae7c36df185e@pengutronix.de>
 <729dfa8c-6eca-42c6-b9fd-5333208a0a69@lunn.ch>
 <PAXPR04MB8510A1946372F37B5F97E9F28870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <4877c76a-d0c1-41d7-95c6-553542e2d9b1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rzuiur3eqbcevt4"
Content-Disposition: inline
In-Reply-To: <4877c76a-d0c1-41d7-95c6-553542e2d9b1@lunn.ch>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--6rzuiur3eqbcevt4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
MIME-Version: 1.0

On 16.06.2025 15:12:37, Andrew Lunn wrote:
> On Mon, Jun 16, 2025 at 01:42:08AM +0000, Wei Fang wrote:
> > > >  drivers/net/ethernet/freescale/fec_main.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > > > b/drivers/net/ethernet/freescale/fec_main.c
> > > > index 6b456372de9a..f238cb60aa65 100644
> > > > --- a/drivers/net/ethernet/freescale/fec_main.c
> > > > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > > > @@ -1860,8 +1860,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16
> > > queue_id, int budget)
> > > >  		    fep->bufdesc_ex &&
> > > >  		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
> > > >  			/* Push and remove the vlan tag */
> > > > -			struct vlan_hdr *vlan_header =3D
> > > > -					(struct vlan_hdr *) (data + ETH_HLEN);
> > > > +			struct vlan_ethhdr *vlan_header =3D skb_vlan_eth_hdr(skb);
> > >=20
> > > This is not 'obviously correct', so probably the commit message needs=
 expanding.
> > >=20
> > > static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_bu=
ff *skb) {
> > > 	return (struct vlan_ethhdr *)skb->data; }
> > >=20
> > > I can see a few lines early:
> > >=20
> > > 		data =3D skb->data;
> > >=20
> > > but what about the + ETH_HLEN?
> > >=20
> >=20
> > The type of vlan_header has been changed from "struct vlan_hdr *" to
> > "struct vlan_ethhdr *", so it is correct to use skb->data directly.
>=20
> Doh! I missed that, sorry. Maybe extend the commit message, you
> mention skb_vlan_eth_hdr() but you could add something like
>=20
> ... and change the type of vlan_header to struct vlan_ethhdr to take
> into account the ethernet header plus vlan header is returned.
>=20
> With that, please add: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Will do, thanks!

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6rzuiur3eqbcevt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhQHW0ACgkQDHRl3/mQ
kZzv3QgAj3kbtMjU741HDJh5zzIvnio+zZLg4NbUzRfer3lx2Y4qLI8tWZQFyZZt
cOUm/G+zu5zKm6UxIHQ+XmPHonj/sz+dRi+Qj1wDuYBdbhZWOTIqYd7S3T61h4SP
lxwZyhE/j03tE/KeMeSs853eZRvdyCXW4+GYNLN28wR/URs88KdHQZuzwe1pCWYI
0qT8v3SSU/bDaybETJ+e3BHOgbBBG0QURONMRXlUbCI7FScz/5Sc3FJMABUTkn/S
N3KXzyFfQpsh7ePqUm8glFEeStublciZgVPN3Wn1Jeogqp+p1hYWBLbyq+hZjS0P
C8CSppSsEVOLs1HX19284euOGaJtOw==
=UOCy
-----END PGP SIGNATURE-----

--6rzuiur3eqbcevt4--

