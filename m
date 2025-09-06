Return-Path: <netdev+bounces-220620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E37B47721
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 22:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA8A055BC
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C242820CE;
	Sat,  6 Sep 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cJVc4Zpm"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012515853B;
	Sat,  6 Sep 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757190371; cv=pass; b=ryHplZHKfAhGYRC85Sib9H3zy6qCMGkXtmKwXsZF/RtFAKSuJC7NEmwkox5+6oiQU6vN7cHRI178SmQz8WyEZmMMe26eVKzSOslE7ZEmvcwFlBQeniFgN7EzKviULvhkpMavGeMtq3mv4hwT6WKuPBQKIbuW37XXJBZaYm0bt+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757190371; c=relaxed/simple;
	bh=Dba0VwlgwTl/0lxoZNPwJbwMeUyMEhy+W9+MLvg4jAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofVVEnLPfExIK5fpEJtRt5tU7fdrAN2rjPiDAgw9FIqy1cyKYwc6MsvUDh93SJlZFK6ox+hHbHS2CiMqGzTevc/vTBpbKq2fFvTkPAKvzBcanK51nXu1H4uBdwFzRPrBlE31DtT09of94p29jbKn3fh4phM2VrFEUnB+/R/SKGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=cJVc4Zpm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757190330; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AIJzMu/ZRJXDGonBMSOiXh0RNaH/kR5wwozxFNW5ko/qSgZ+3JfO5njNY2dHaDp4LRUhilC7Q15M6zJBmrJKy29LIy73sRpBBBPFYKhnkwuBtZMRCu3ZeaVYV2l3XLRIFI9N1Bdx5K8IrJdZybA2T0YiCl9ZLWXk3+rXYOr8hWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757190330; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gaueM132UXDRu16dNJaiRHmHlASjwQR0RfI2PxcL64g=; 
	b=CdVDiyJlzEQixCLxnf9+h6LmfnlzvvqXyXrKmrbl8+aD6pNzwHSv0iZx04Wl61XOvVucl/GGgCZQFG4c9cCOfDIY32CEjEpQD/3qNCrL6//emlX33zOthl/vFfQIeMklMnBIKbSLFiHJ9IB0gAlUT8e2NFvORCJU+Pvm5lCqxUU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757190330;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=gaueM132UXDRu16dNJaiRHmHlASjwQR0RfI2PxcL64g=;
	b=cJVc4ZpmICLZ3Rn0dxvIMumpZwhP+wuCBDR2ZrLy7dhJZXc8vTbhFcTF9V+E4Xmm
	3dzIfiYaogrkXjsNO+R7zL/LrKY9/kMwY0Lr5wRxbOib7vc8cyQeNs6kVzzjDq3qhKM
	PTmIIYhIPPCSPdOpHDyKo6OzeHCw0BkgpfeQ0Nz0=
Received: by mx.zohomail.com with SMTPS id 1757190327049402.40879686448466;
	Sat, 6 Sep 2025 13:25:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A89F6180B18; Sat, 06 Sep 2025 22:25:20 +0200 (CEST)
Date: Sat, 6 Sep 2025 22:25:20 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Yao Zi <ziyao@disroot.org>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
	David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <wgau7accvif4pcblnkpppyve4isstvmxyljlojt2yu4cwnyqvf@od4zasgpwdjr>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
 <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
 <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
 <aLly7lJ05xQjqCWn@shell.armlinux.org.uk>
 <aLvIbPfWWNa6TwNv@pie>
 <5d691f5b-460e-46cb-9658-9c391058342f@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h6lnwepm5yz4el3j"
Content-Disposition: inline
In-Reply-To: <5d691f5b-460e-46cb-9658-9c391058342f@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.176.7
X-ZohoMailClient: External


--h6lnwepm5yz4el3j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
MIME-Version: 1.0

Hi,

On Sat, Sep 06, 2025 at 02:26:31PM +0800, Chaoyi Chen wrote:
> On 9/6/2025 1:36 PM, Yao Zi wrote:
>=20
> > On Thu, Sep 04, 2025 at 12:07:26PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Sep 04, 2025 at 12:05:19PM +0100, Russell King (Oracle) wrote:
> > > > On Thu, Sep 04, 2025 at 07:03:10PM +0800, Chaoyi Chen wrote:
> > > > > On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
> > > > > > On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > > > > > >    	if (plat->phy_node) {
> > > > > > >    		bsp_priv->clk_phy =3D of_clk_get(plat->phy_node, 0);
> > > > > > >    		ret =3D PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > > > > > > -		/* If it is not integrated_phy, clk_phy is optional */
> > > > > > > +		/*
> > > > > > > +		 * If it is not integrated_phy, clk_phy is optional. But w=
e must
> > > > > > > +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded=
, or
> > > > > > > +		 * the error code could be wrongly taken as an invalid poi=
nter.
> > > > > > > +		 */
> > > > > > I'm concerned by this. This code is getting the first clock fro=
m the DT
> > > > > > description of the PHY. We don't know what type of PHY it is, o=
r what
> > > > > > the DT description of that PHY might suggest that the first clo=
ck would
> > > > > > be.
> > > > > >=20
> > > > > > However, we're geting it and setting it to 50MHz. What if the c=
lock is
> > > > > > not what we think it is?
> > > > > We only set integrated_phy to 50M, which are all known targets. F=
or external PHYs, we do not perform frequency settings.
> > > > Same question concerning enabling and disabling another device's cl=
ock
> > > > that the other device should be handling.
> > > Let me be absolutely clear: I consider *everything* that is going on
> > > with clk_phy here to be a dirty hack.
> > >=20
> > > Resources used by a device that has its own driver should be managed
> > > by _that_ driver alone, not by some other random driver.
> > Agree on this. Should we drop the patch, or fix it up for now to at
> > least prevent the oops? Chaoyi, I guess there's no user of the feature
> > for now, is it?
>=20
> This at least needs fixing. Sorry, I have no idea how to implement
> this in the PHY.

I think the proper fix is to revert da114122b8314 ("net: ethernet:
stmmac: dwmac-rk: Make the clk_phy could be used for external phy"),
which has only recently been merged. External PHYs should reference
their clocks themself instead of the MAC doing it.

Chaoyi Chen: Have a look at the ROCK 4D devicetree:

&mdio0 {
	rgmii_phy0: ethernet-phy@1 {
		compatible =3D "ethernet-phy-id001c.c916";
		reg =3D <0x1>;
		clocks =3D <&cru REFCLKO25M_GMAC0_OUT>;
		assigned-clocks =3D <&cru REFCLKO25M_GMAC0_OUT>;
		assigned-clock-rates =3D <25000000>;
        ...
    };
};

The clock is enabled by the RTL8211F PHY driver (check for
devm_clk_get_optional_enabled in drivers/net/phy/realtek/realtek_main.c),
as the PHY is the one needing the clock and not the Rockchip MAC. For
this to work it is important to set the right compatible string, so
that the kernel can probe the right driver without needing to read the
identification registers (as that would require the clock to be already
configured before the driver is being probed).

Greetings,

-- Sebastian

--h6lnwepm5yz4el3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmi8mKwACgkQ2O7X88g7
+ppSnA/+Ms1Z3gR5BjMQO2fm9plU7SLZz3gyjXx/ZSEY3eFXQD1CAWUJxwvs744K
T+KWiaF3oAMez0hYw2TqEnAg0dr84oUocN20+TBw34vhLes8+el1sHWEggUlIMek
pnDi7A51K56YtqMhI1sJttSKi2i54oupF8NU861kZtdCQ28YYgwoY6Nd1TkxUXkX
yajonEzmjcnFZr40V5/VE6QQaG+P+tXwN/tIuRG/9sAVurIzEse8tWYz/vLuL0wf
QIyJy3OqP4X/HERft8xN0x9NYbEoyw+RfajAAs7/OBER7SGHwViFdTXMNZ6CahHO
ROn0kIuEWz4DEoy05m7bTlXlYSBYl7RTs52H4GaX6ClP9UV2EHhli/YxfNGt7cQr
h+lABlRV9wt6RoZJVuoUOlRVgf8d76c/kbKNCV475IJ7luQTF4GXruX+EQDUE45O
gEpz2hvmwFXg1UhcaPlNNlL7uT3zxALR7tcfEXIZriXOmyL+1+pGGR0fflFkoaSr
cipZsP/fgzgvZl3pL6ZKjPdm0ygIgfqu3aOpg4AwdLdGG6B+pRMe5uBkvUdaiiKq
qtEAHlFSX02ZgFgZrTkgsgOlA8x/k49ODMIkY5O12QUVKJy+/9z5QkllvMTb9nJs
ZOqsndKePDI4p+WkZY+xB4nZsmtZjoYc89PK8MgZ4Tcmqaw9g+E=
=fhP2
-----END PGP SIGNATURE-----

--h6lnwepm5yz4el3j--

