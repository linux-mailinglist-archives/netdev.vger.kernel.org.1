Return-Path: <netdev+bounces-264405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJPqBOKQqWkSAAEAu9opvQ
	(envelope-from <netdev+bounces-264405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:19:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 646F721322A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED38302BA78
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9FC81724;
	Thu,  5 Mar 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzqGKCMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DD175A79;
	Thu,  5 Mar 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720351; cv=none; b=JFwGNMgG2Xb0J1wSHD0YjpN26hBnvm4EArJxnIEyoz5lVujKzwzflzXb53sP+qxe7oO2Z1SXzSPUVY5Cf00XVVq/vPCDKJbXxb2XLU6AIjIguq+5eFj1iAqHBet+n2vBs+ti/RhFSgHetS9czVI3SuomTbyrF2F9lwf1P8wQDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720351; c=relaxed/simple;
	bh=EvatmDmj88KOJU1HIlc4Yiiu3HnrBNJ8QQwK687vZaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8RBMWiIxx7cGVu7sUEj7cMYCTZDMkszi3Idr7cfClDTp5SgtgP4lEk78P60jyDDM1BTQY1ejPKZCHx9sc+cHHDLZvm8AqvB+zNl53kEMyZFPSqxZ83kN/5LLFwkFEulVOcK/QaHntCJjI/YFlDUwEaQ5C6gc3eUXsyKYm9O9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzqGKCMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C28C116C6;
	Thu,  5 Mar 2026 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772720350;
	bh=EvatmDmj88KOJU1HIlc4Yiiu3HnrBNJ8QQwK687vZaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzqGKCMHkemvjzZaBS0aMZaKGHRhSCXIASPSSJCeE1diSAHRaktPTG4iDRuXWowOa
	 bBfdO/8sgyhBvXvv1/jcrkX3QCu+hH4nZwlQeubhV62xTtl5IjFPPico04YMtltBXc
	 E3jOQXQNJeF8HWj0uGiia6X2kbu9r0QAUB0F+1SLbNcX+OOPi9mI+GqvGQV+PwP5I2
	 oS99fkAQYhhIRRaRqeXdarVvYttbIFSfNJ/ViLei/63xw7NSG3z5e4cJCtCigYU1HA
	 ufduTkmJnuaGFjkyQozaB5e6Z2bc4N6SHB1oHOVg5KPCLxulpuG2FLgyHB0iE6AboV
	 Au4IByVhdcHsw==
Date: Thu, 5 Mar 2026 14:19:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <20260305-municipal-passing-b7a45b1337ba@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
 <20260304-mandarin-alumni-4b38a7743ee1@spud>
 <aah8akCJPTNkBrxs@shell.armlinux.org.uk>
 <aamJdvgstMd8LGRX@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wBJGOHlutGJTN6Vk"
Content-Disposition: inline
In-Reply-To: <aamJdvgstMd8LGRX@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: 646F721322A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--wBJGOHlutGJTN6Vk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 05:47:34AM -0800, Charles Perry wrote:
> On Wed, Mar 04, 2026 at 06:39:38PM +0000, Russell King (Oracle) wrote:
> > On Wed, Mar 04, 2026 at 06:06:20PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 04, 2026 at 04:55:37PM +0000, Russell King (Oracle) wrote:
> > > > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > > > > On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> > > > > > On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > > > > > > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > > > > > > Make it possible to connect a PHY which does not use inband
> > > > > > > > autoneg to a gem MAC using phylink's information.
> > > > > > > >=20
> > > > > > > > The previous implementation relied on whether or not the li=
nk
> > > > > > > > was a fixed-link to disable SGMII autoneg. This commit exte=
nd
> > > > > > > > this to all link which are not configured for inband
> > > > > > > > autonegotiation.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > > > > >=20
> > > > > > > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> > > > > > >=20
> > > > > > > [    7.189102] mpfs-sys-controller syscontroller: Registered =
MPFS system controller
> > > > > > > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.eth=
ernet-ffffffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > > > [    7.273881] macb 20110000.ethernet eth0: configuring for p=
hy/sgmii link mode
> > > > > > > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp cloc=
k registered.
> > > > > > > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.eth=
ernet-ffffffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > > > [    7.358082] macb 20112000.ethernet eth1: configuring for p=
hy/sgmii link mode
> > > > > > > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp cloc=
k registered.
> > > > > > > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbp=
s/Full - flow control off
> > > > > > > [   11.398403] Sending DHCP requests .
> > > > > > > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbp=
s/Full - flow control off
> > > > > > > [   13.938425] ..... timed out!
> > > > > > > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > > > > > > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp cloc=
k unregistered.
> > > > > > > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > > > > > > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp cloc=
k unregistered.
> > > > > > > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > > > > > > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.eth=
ernet-ffffffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > > > [   93.770655] macb 20110000.ethernet eth0: configuring for p=
hy/sgmii link mode
> > > > > > > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbp=
s/Full - flow control off
> > > > > > > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp cloc=
k registered.
> > > > > > > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.eth=
ernet-ffffffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > > > [   93.856769] macb 20112000.ethernet eth1: configuring for p=
hy/sgmii link mode
> > > > > > > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbp=
s/Full - flow control off
> > > > > > > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp cloc=
k registered.
> > > > > > >=20
> > > > > >=20
> > > > > > Hello Conor,
> > > > > >=20
> > > > > > I checked the driver for the VSC8662 and it doesn't have the
> > > > > > ->inband_caps() and ->config_inband() callbacks so Linux leaves=
 whatever
> > > > > > the bootloader puts or uses the defaults. Looking at the datash=
eet, this
> > > > > > should be register 23 (Extended PHY Control Set 1) bit 13 (MAC =
interface
> > > > > > auto-negotiation)
> > > > > >=20
> > > > > > My guess is that this bit is set and since this patch disable i=
nband
> > > > > > autonegotiation (because phylink decides it), there is a mismat=
ch.
> > > > > >=20
> > > > > > Can you add 'managed =3D "in-band-status"' in your device tree =
under the macb
> > > > > > node? That's not necessarily the fix, I just want to confirm my=
 theory.
> > > > >=20
> > > > > No, it just produces a different error:
> > > > > [    5.769864] mpfs-sys-controller syscontroller: Registered MPFS=
 system controller
> > > > > [    5.829146] macb 20110000.ethernet eth0: Could not attach PHY =
(-19)
> > > > > [    5.854232] IP-Config: Failed to open eth0
> > > > > [    5.897152] macb 20112000.ethernet eth1: Could not attach PHY =
(-19)
> > > > > [    5.921061] IP-Config: Failed to open eth1
> > > > > [    5.925592] IP-Config: No network devices available
> > > > > [    5.938800] clk: Disabling unused clocks
> > > > > [    5.944156] PM: genpd: Disabling unused power domains
> > > > > [    5.961029] check access for rdinit=3D/usr/sbin/init failed: -=
2, ignoring
> > > >=20
> > > > -19 is -ENODEV (I wish everyone would use %pe so we get english
> > > > error messages rather than having to look up errno codes in the
> > > > header files.)
> > > >=20
> > > > macb uses either phylink_of_phy_connect() or phylink_connect_phy().
> > > > I don't think phylink_connect_phy() would return -ENODEV, but
> > > > phylink_of_phy_connect() would - but I can't see that adding
> > > > 'managed =3D "in-band-status";' to DT would cause that. The only
> > > > case I can see is that fwnode_phy_find_device() fails to find the
> > > > phydev, but there is a PHY node specified in DT, but that would
> > > > fail without in-band-status.
> > >=20
> > > It's as you say, and fwnode_phy_find_device() is the source.
> > > fwnode_mdio_find_device() is what fails, returning NULL.
> >=20
> > Ah, I've just found the reason:
> >=20
> >         /* With fixed-link, we don't need to register the MDIO bus,
> >          * except if we have a child named "mdio" in the device tree.
> >          * In that case, some devices may be attached to the MACB's MDI=
O bus.
> >          */
> >         mdio_np =3D of_get_child_by_name(np, "mdio");
> >         if (!mdio_np && of_phy_is_fixed_link(np))
> >                 return macb_mii_probe(bp->dev);
> >=20
> > of_phy_is_fixed_link() will return true as soon as you add that managed
> > property, and as the mac1 node just lists the PHYs without using a
> > mdio child:
> >=20
> > &mac1 {
> >         phy-mode =3D "sgmii";
> >         phy-handle =3D <&phy1>;
> >         status =3D "okay";
> >=20
> >         phy1: ethernet-phy@9 {
> >                 reg =3D <9>;
> >         };
> >=20
> >         phy0: ethernet-phy@8 {
> >                 reg =3D <8>;
> >         };
> > };
> >=20
> > it means mdio_np is NULL above. Hence, no MDIO bus will be created.
>=20
> Thank you Russell for finding this.
>=20
> Conor, can you try with this:
>=20
> ````
> &mac0 {
> 	phy-mode =3D "sgmii";
> 	phy-handle =3D <&phy0>;
> 	status =3D "okay";
> 	managed =3D "in-band-status";
> };
>=20
> &mac1 {
> 	phy-mode =3D "sgmii";
> 	phy-handle =3D <&phy1>;
> 	status =3D "okay";
> 	managed =3D "in-band-status";
>=20
> 	mdio {
> 		phy1: ethernet-phy@9 {
> 			reg =3D <9>;
> 		};
> =09
> 		phy0: ethernet-phy@8 {
> 			reg =3D <8>;
> 		};
> 	};
> };
> ````
>=20
> I think we're almost there.

With this, I can boot. Is that enough information for you to resolve the
problem?

--wBJGOHlutGJTN6Vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaamQ2gAKCRB4tDGHoIJi
0nZQAQDFxb4EL/Aq+JbMQcf3qVrokNeYYA/P95EN1BUAgRMlBAD/URw/CmsMc5hM
iQ0s6VY1uLdmun9j/Qrg2c1KfEufhQc=
=K3KE
-----END PGP SIGNATURE-----

--wBJGOHlutGJTN6Vk--

