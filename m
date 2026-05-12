Return-Path: <netdev+bounces-287303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHPJMomUA2rY7gEAu9opvQ
	(envelope-from <netdev+bounces-287303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:58:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E197529BDB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E515730832AB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4F3C4B85;
	Tue, 12 May 2026 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aew4b/4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57233C09F0;
	Tue, 12 May 2026 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619524; cv=none; b=U+aqU4VpehfckTv3ZiUgrwAOcjjafo1zKcg17gPQusaOhER1eCyPoLnJrjVeBRsaMa9JewFwd3S/t1Z38kW2u/z5lP8cjA+jAb+xVyizR61LAhrB8FEyu1NNftqU3ffiAmvGcrHosJXohiB0HVSoLJrl8XOBpDJgddsJETzSRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619524; c=relaxed/simple;
	bh=cwRYFJ8mo7xPr/Sm/kd6T4GfCK3h96cELX3tInSSqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzGqhm1eAUi8JgtI9rgbJ02S0Dcn3tzTO+6ArhuvKea1hVSCJSGSxwR9pGGLIX3tklw1cM7EjheVzbpkMrYaYsPeFJZK+kJr5ATdxzZmi7HbiupkqLtCPatFS5yuv4IufbgqVJV7cUTH6OCXXGbWhdpiTw6C6uTYZ+VxSx3eUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aew4b/4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35D8C2BCB0;
	Tue, 12 May 2026 20:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778619524;
	bh=cwRYFJ8mo7xPr/Sm/kd6T4GfCK3h96cELX3tInSSqH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aew4b/4EDTRlqlXHmm4ka53FQbHCXwfJFmy8x01qQqfmuztLbaflyIT6Z3KXDXwK2
	 b5JiZYNgRlvCID3NhkRx3KDtWb4nCuI6wimqtfnIwAD1mAAd9SVaDC/JSFiX7UdSOg
	 nBygmXFpmJNoPfEnWc4ul/IPZDtPZbA/n6+FpygRh3jpuCEYeD5hipGFrI1gxOs8M5
	 mYoOME7LP9wAWubUPs6q5f6D+bABmxyF5wfHBRa4huykaC9maPfJwfYzzR7HaVSHzw
	 ec5dE7LMCOooljRryEym8Iy191vRpFMtPYVbUYxXGVvdndmQCEXS+vjoUznhhOb1qg
	 Oq1FYLT8tvPNg==
Date: Tue, 12 May 2026 22:58:41 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v6 11/12] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <agOUgVn24Ls5jiHq@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-11-c899462c4f75@kernel.org>
 <f4a11830-8a3f-4cc3-ab82-e6f02ca34ae8@genexis.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wnpl3sdvUPuniOKw"
Content-Disposition: inline
In-Reply-To: <f4a11830-8a3f-4cc3-ab82-e6f02ca34ae8@genexis.eu>
X-Rspamd-Queue-Id: 5E197529BDB
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
	TAGGED_FROM(0.00)[bounces-287303-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Action: no action


--Wnpl3sdvUPuniOKw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 12, Benjamin Larsson wrote:
> Hi.
>=20
> On 11/05/2026 12:49, Lorenzo Bianconi wrote:
> > The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/=
WAN
> > MAC addresses, used to determine whether received traffic is destined f=
or
> > this host or should be forwarded to another device.
> > The SoC hardware design assumes all interfaces configured as LAN (or WA=
N)
> > share a common upper MAC address, which is programmed into the
> > REG_FE_{LAN,WAN}_MAC_H register. The lower bytes of 'local' addresses c=
an
> > be expressed as a range via the REG_FE_MAC_LMIN and REG_FE_MAC_LMAX
> > registers.
> > Previously, only a single interface was considered when programming the=
se
> > registers. Extend the logic to derive the correct minimum and maximum
> > values for REG_FE_MAC_LMIN/REG_FE_MAC_LMAX when two or more interfaces =
are
> > configured as LAN or WAN.
> >=20
> > Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/ethernet/airoha/airoha_eth.c | 75 +++++++++++++++++++++++=
++++-----
> >   drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
> >   drivers/net/ethernet/airoha/airoha_ppe.c |  4 +-
> >   3 files changed, 66 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 16c0ff9999da..533ffe20f833 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_i=
rq_bank *irq_bank,
> >   	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
> >   }
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >   {
> >   	struct airoha_eth *eth =3D dev->eth;
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
> Maybe this information should be relayed to the user somehow?

netdev_err()?

Regards,
Lorenzo

>=20
> MvH
>=20
> Benjamin Larsson
>=20

--Wnpl3sdvUPuniOKw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagOUgQAKCRA6cBh0uS2t
rIn+APwKpb4qxMrPaC5ng4+5c/Ub1S62RXR68TIg3As8A6JbIwD/RGedQbqaS9xg
zxmKutUfiYEtLPbAvGErfwePBAN6Gws=
=JHOg
-----END PGP SIGNATURE-----

--Wnpl3sdvUPuniOKw--

