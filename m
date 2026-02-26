Return-Path: <netdev+bounces-261583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDdmEyOroGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:20:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5E1AF028
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 144FC30117E8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3F4657E8;
	Thu, 26 Feb 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXmgb9Cq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6545BD7F;
	Thu, 26 Feb 2026 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137248; cv=none; b=Fbo55PsMETqzEBYhjpgBRkif46t7vj39E0ZPj5iCaUUMB+CfOryfpsCNmhNnJ75yxvFpH3KuKFpOKlPf0CF6Y5yTTvNfIeX8qu5spJ6VaEnL0jiSH5Q82KATRS9PpCFiXVXiDnDwXGW0AeW7vF3RSdfWwraBoWAlDIFW8UQiTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137248; c=relaxed/simple;
	bh=9tViS64b8gEVVdrMLaLiKuoKotqZvA4sQPDhm5E8C2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6EP1Se4KP3CarKjelcdhqJNNb2pr4hcNvuo4k53m1t0bZr0/QaE/T/Dx3ftU2KkULZ6JldoOyXtCjqQT8rS63H0OYOa2e+4EeQH/Ag9+KB0wIy7aRsmWs3ebJTAjOvtvWz7EpnK4u/L9r9MzgPvnF2k0FPhCYahkbxjYKX7JBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXmgb9Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7AC116C6;
	Thu, 26 Feb 2026 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772137247;
	bh=9tViS64b8gEVVdrMLaLiKuoKotqZvA4sQPDhm5E8C2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXmgb9CqaL84FXbRfzA5ifUPZJBM6XL+uESaLq1y+ae6nSyrsLDdOTDosrEFBgXz1
	 Cn95f1Tvutj4I8twdJyatGKstpJPGpx0BNEw8dWD0scVrU8IYIOF/rIIZORC9BVj76
	 gSV32uW8lc4aY4UWOGy5MkiQ6Z0wq64rTBTnfd/q4nBM/1CQkF8ZV+t60PcbO/gOW6
	 Xgytq/vNbcnQ5osEJnM3gSVg5P2/Jk6KUvA2w6t33dMzk5anUcacsujscqdJ5c0CMg
	 M5GDlRSlr4Xoc1NiSk2e0FIgBneEodu9DUhkZ15FZxFaEGOB2UbrtOOsvQ58awX86w
	 6d0lFO+szzzDQ==
Date: Thu, 26 Feb 2026 20:20:41 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <20260226-perennial-sanctity-25c6adae5ec0@spud>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
 <20260226-folic-excitable-82eff83a125a@spud>
 <aaCd_zV5kY-s1RBL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1GdmJnZTOEkH8cCG"
Content-Disposition: inline
In-Reply-To: <aaCd_zV5kY-s1RBL@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.7:email,0.0.0.8:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.3:email]
X-Rspamd-Queue-Id: C2F5E1AF028
X-Rspamd-Action: no action


--1GdmJnZTOEkH8cCG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 07:24:47PM +0000, Russell King (Oracle) wrote:
> On Thu, Feb 26, 2026 at 10:46:24AM +0000, Conor Dooley wrote:
> > On Thu, Oct 23, 2025 at 06:22:55PM +0200, Th=E9o Lebrun wrote:
> > > Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, usi=
ng
> > > compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> > > that must grab a generic PHY and initialise it.
> > >=20
> > > We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding=
 a
> > > phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> > > the first users of bp->phy that use it in non-SGMII cases.
> > >=20
> > > The phy_set_mode_ext() call is made unconditionally. It cannot cause
> > > issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
> > > those cases, the call is a no-op (returning zero). From reading
> > > upstream DTS, we can figure out that no platform has a bp->phy and a
> > > PHY driver that has a .set_mode() implementation:
> > >  - cdns,zynqmp-gem: no DTS upstream.
> > >  - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attache=
d.
> > >  - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
> > >  - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
> > >    drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().
> >=20
> > Ran into this patch while looking at other stuff. Theo could you explain
> > this analysis to someone not really au fait with phys? Looking at
> > soc.dtsi files won't show you phys, since that's a board level decision,
> > but you have found one for the zynqmp-gem so I guess that's just the way
> > you presented the data?
> > mpfs definitely has phys attached, so is you not finding one for it but
> > finding for zynqmp, an indication that you were only looking for rgmii
> > phys? Also, is the analysis of the connected phy driver accurate for
> > zynmqmp?
> > zynqmp-zc1751-xm018-dc4.dts seems to have 4 ethernet phys:
> > 		ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
> > 			reg =3D <0>;
> > 		};
> > 		ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
> > 			reg =3D <7>;
> > 		};
> > 		ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
> > 			reg =3D <3>;
> > 		};
> > 		ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
> > 			reg =3D <8>;
> > 		};
>=20
> Ethernet PHYs (drivers/net/phy/) are different from generic PHYs
> (drivers/phy/). Ethernet PHYs are completely different beast with a
> completely separate subsystem, which doesn't have a "set_mode" method.
>=20
> Th=E9o is referring to generic PHYs not Ethernet PHYs.

Right, that's pretty much what I figured and cos of that the patch
itself seemed like it was fine to me. It is the analysis of users in
devicetrees that I don't understand - the "no PHY attached" bits
seemed to me like they should be saying "ethernet-only PHY attached, so
no .set_mode()". Ultimately, I think it makes no difference to the patch
itself, I just wanted to understand the commit message.

--1GdmJnZTOEkH8cCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaCrGQAKCRB4tDGHoIJi
0nTjAQCH0/tL9+Upo5KDdhvASVVInTsPL0DxGV3pcGQ5JROE2AD+LnW9GGHFwz62
BtWC5TxLeE4pRDy7lOFTyb0BapCM1AA=
=MJtW
-----END PGP SIGNATURE-----

--1GdmJnZTOEkH8cCG--

