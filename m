Return-Path: <netdev+bounces-258607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l/g/D50Zj2k0IwEAu9opvQ
	(envelope-from <netdev+bounces-258607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BC1360CF
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81CF8304BC20
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEDC219FC;
	Fri, 13 Feb 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="U/ZhNYWr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB11CAB3
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770985882; cv=none; b=Db1A2bGT09uMCGfr2+t4Z5P19OUjrllUiC4BSwncrRVxuurw7O9RnvNHFq97suqsRHIyCXIaKrO6b0quAsHy3bD4jky5Vr4Iz6yUh+GXVw49eenP2t4gjPr+FA8vNnpVpxCk70DS1Rty9DyufPCvItWEjO5Sl7izjvf/uCTY4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770985882; c=relaxed/simple;
	bh=JCybOdYfkIAtmKfxe2B1EWdRDDi2YeK8FhNMeVwJcrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbgXhV4keztJ2O5T9aC3i/RRfifWYg0FdULXH2O0xoSGtpKxan+UZXIq/li/NANhSagDeKyq+zGkGdbzG2sDcdtvG2ED8+giuk84sziPv6vJRUnq3V/oBV2IGoeKOgZCBf1TtvFJNevLP7EoJ7yxb+Y6NowyDYUnQnX1bNYlzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=U/ZhNYWr; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so7362655e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1770985879; x=1771590679; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jyueh1MgFCFNJjnlw3S82ddx4djOycAy6cidCAWWAl0=;
        b=U/ZhNYWrp/Bt6U3ELuC0xlxCZN7egtindxCg9/uc8UEecjNJk4sNoh2EYUQXum7phD
         ktzmnC9Cqv5KUuRpnKozaRSZzN20qTLSstNEIGHLnuG4G2pt2N+aosJpVYoD/MheSj0z
         pvNyodXuwBcftQToYu1z7b0twAyF9k2GT3MaCmMtEEx9PSNy8n84HmjniGV4+CTFObCO
         qNLuheBNVaHQVGeDYRj7DuLr604scPkisXzMkkcXMK0A/C3WSlKHRqYmLhrFzyCWW296
         WXDV+hr9C+2mq9nICriOytWONvvuztsRHMns3oDAWUFL9wiXuH0S1EUQkGxDV9CbEv8y
         1rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770985879; x=1771590679;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jyueh1MgFCFNJjnlw3S82ddx4djOycAy6cidCAWWAl0=;
        b=BYWpDVvFMxAl5tZU3L7SnJZwgpV4fp2Y5TlbD0RDEgNCv6AC9jqL4bLYiBVJw/LjJa
         z5/7OVgjl6ihHTTRgp6PNsB5SdeCyK7OCdOESp4/sVbLQbDxyWnROLVKBnhildAos5cv
         TGlMsnQn3hK4shk3oUclIZhXCWOJGqpXORwGIfbu3q4lBugkYj3iiGdrIpcKa3Q0ZGo8
         tzTiOcNYxPJgBmFaDr5SNYik5Fgz1cEqWPuo5pVX/19qjsFw7kry8qGTO406HCug8eD4
         Qa37Q+uXrcFufK23xB+BeVtk4W5n6kRwdM/qptRcmox0ZoxRrZzx9kxk+Er9MvQ0pjPF
         H8sA==
X-Forwarded-Encrypted: i=1; AJvYcCWOqDcQYNPvtJWyj1pYDpndAuJddc08EAwjGTlsoLIRiTuiIO+W9JDpdltT1G9ax+Ri+sVeH+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6x2fOp/Uu0vniAxtkBW4wTQhqep5X5Rc1vr5J1RFQva2tkfS
	ry4izwvQSR2brQE2LIom5vcHPP+oWVW9Rv54I8j9o0ESjEgJbia9qfz+/P7J4456JeDVhwtk5T6
	hrbntxbEo
X-Gm-Gg: AZuq6aI7Dl3RlwFHopx/BlOxUWhEa3O3b+h0X2mP3GWQTAgYM2S3enE1z8ozzKZjhAW
	O6p12t0v4jIOVb9fTRM6egFzqsieobZDGC1ZSgsZEXxU8xW1+3bdhwmKDUW/fG9BnL7dU4bUF8D
	9vv4k3u8Kw7GeLZe4cvnSEZ4i3dLBPCJUwn3Y91gJ7rEsFxddrhJa18YTj4Lr9yRZbpCFsF+H7g
	vTOB+BY/+9Q56019KpXJr3fUH9mUrt5Y5xSJL0IHzKUCe+Q3dv+XLHfFfu+KEOmupCl3QZdLxc/
	jWyZ1vKpBNlXTBRvzr3dD9LsSOMJSKGOCM/W8f3Jiuod0Cz5909n6p1VngGe2Tdn4mUMp34RBSh
	qxgyDSoIg7sVqbIu1cIdn56Hl6K3XEsqTx3eXSkbjf2vD292iLGJeFuOwKBLbPB4OVedMGBnITm
	CqNzyhfeS917SbJvyP5zeNVyfcXmpWbL8=
X-Received: by 2002:a05:600c:8411:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-48371051b20mr34456175e9.11.1770985878927;
        Fri, 13 Feb 2026 04:31:18 -0800 (PST)
Received: from [192.168.2.3] ([109.227.152.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm324215255e9.9.2026.02.13.04.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:31:18 -0800 (PST)
Message-ID: <92f5169580c0292ae666e20d52b891b45e0731ea.camel@hazent.com>
Subject: Re: [PATCH net-next v2 0/3] net: phy: dp83869: Support 1000Base-X
 SFP
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: Romain Gantois <romain.gantois@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>,  Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvaro@linenoise.info
Date: Fri, 13 Feb 2026 13:31:17 +0100
In-Reply-To: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hazent-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-258607-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hazent-com.20230601.gappssmtp.com:+];
	DMARC_NA(0.00)[hazent.com];
	FREEMAIL_TO(0.00)[bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvaro.gamez@hazent.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,40c00000:email,hazent-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8F8BC1360CF
X-Rspamd-Action: no action

On Mon, 10 Nov 2025 10:24:52 +0100
Romain Gantois <romain.gantois@bootlin.com> wrote:
> Hi everyone,
>=20
> This is version two of my series which adds support for using the
> DP83869 PHY as a transceiver between an RGMII upper MAC and a
> downstream 1000Base-X SFP module.

Hi Romain,

I am quite interested in this too, as we have a new version of a PCB in
which we replaced a dp83848 (which only works with 100base-tx) with
dp83869 with the intent of using 1000base-sx or similar SFPs.

The are two different SFPs that I was able to use with dp83848 and
would like to use them with the dp83869 as well:

- RJ45 based:
    - Robofiber SFP-5000-RJ45A: 10/100Base-Tx SFP RJ45
    - H!Fiber ASF-GE-T1 1000Base-T SFP RJ-25

Both of these already work with dp83869 with kernel 6.12, provided I
set mode to DP83869_RGMII_100_BASE. If I try to make the 1000Base-T
work at 1Gbps by setting op mode to DP83869_RGMII_1000_BASE it will
still set speed to 100Mbps and will work just fine, but if I try to set
speed to 1000, all data transfer stops.

Personally, I could live with this, but I assume it should be possible
for this SFP to work at 1Gbps.

- Fiber based:
    - CISCO-FINISAR G155B3520KCD which I believe reports bit
      ETHTOOL_LINK_MODE_10000baseSR_Full_BIT
    - AVAGO AFBR-709SMZ which reports as 10gbase-r
    - ATGBICS AFBR-5710ALZ-C 1000BASE-SX

The first two, even if they report as 10Gbase, did work with dp83848 at
100Mbps out of the box, but do not seem to work in any case with
dp83869. The last one, 1000base-sx, is the one that I expected to
work either out of the box or by using this set of patches of yours.
However, none of them do work.

What I did next, as the 10gbase was simply refused, was to apply the
following patch above your series, which is more or less based on one
of your previous patches from 2025. The key here is that I try hard to
fallback to 100Mbps on every instance of non working SFP. So, I need
that if linkmode_empty(sfp_support) because the 10/100 SFPs simply do
not have any bit active to signal that capability, and I also set mode
to RGMII_100_BASE in every case. So, with this patch:

sfp amba_pl:sfp: module AVAGO            AFBR-709SMZ      rev G4.1 sn
AA17053045F      dc 170204 =20
TI DP83869 axienet-40c00000:01: dp83869_module_insert SFP compatible link m=
ode:
10gbase-r
TI DP83869 axienet-40c00000:01: incompatible PHY-to-SFP module link mode
10gbase-r! Try simply 10/100
Configuring network: xilinx_axienet 40c00000.ethernet eth0: PHY [axienet-
40c00000:01] driver [TI DP83869] (irq=3DPOLL)
xilinx_axienet 40c00000.ethernet eth0: configuring for phy/1000base-x link =
mode
xilinx_axienet 40c00000.ethernet eth0: Link is Up - 100Mbps/Full - flow con=
trol
off

And finally I have my other device answer to ping! So it seems that the
DP83869, as is, won't be able to run at 1Gbps no matter what.

From the datasheet... wouldn't it be necessary to update OP_MODE_DECODE
Register (Offset =3D 1DFh) [Reset =3D 0040h] CFG_OPMODE bits 2-0 to set val=
ue 1
RGMII to 1000Base-X?

diff --git c/dp83869.c w/dp83869.c
index 31a2d4f..3857577 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/sfp.h>
 #include <linux/delay.h>
 #include <linux/bitfield.h>
@@ -894,22 +895,63 @@ static void dp83869_module_remove(void *upstream)
 static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_i=
d
*id)
 {
 	struct phy_device *phydev =3D upstream;
-	const struct sfp_module_caps *caps;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	struct dp83869_private *dp83869;
+	phy_interface_t interface;
 	int ret;
=20
-	caps =3D sfp_get_module_caps(phydev->sfp_bus);
+	linkmode_zero(phy_support);
+	phylink_set(phy_support, 10000baseSR_Full);
+	phylink_set(phy_support, 1000baseT_Full);
+	phylink_set(phy_support, 1000baseX_Full);
+	phylink_set(phy_support, 100baseFX_Full);
+	phylink_set(phy_support, 100baseFX_Half);
=20
-	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
-			       caps->link_modes)) {
-		phydev_err(phydev, "incompatible SFP module inserted\n");
-		return -EINVAL;
+	linkmode_zero(sfp_support);
+	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
+
+	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
+	linkmode_and(sfp_support, phy_support, sfp_support);
+
+	if (linkmode_empty(sfp_support)) {
+		phydev_err(phydev, "incompatible SFP module inserted, let's
assume 10/100\n");
+
+		linkmode_zero(sfp_support);
+		sfp_parse_support(phydev->sfp_bus, id, sfp_support,
interfaces);
+		phylink_set(sfp_support, 100baseFX_Full);
+		linkmode_and(sfp_support, phy_support, sfp_support);
+
+		if (linkmode_empty(sfp_support)) {
+			phydev_err(phydev, "incompatible SFP module inserted,
10/100 didn't work either\n");
+			return -EINVAL;
+		}
 	}
=20
+	interface =3D sfp_select_interface(phydev->sfp_bus, sfp_support);
+	phydev_info(phydev, "%s SFP compatible link mode: %s\n", __func__,
+		phy_modes(interface));
+
 	dp83869 =3D phydev->priv;
=20
-	dp83869->mode =3D DP83869_RGMII_1000_BASE;
-	phydev->port =3D PORT_FIBRE;
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_100BASEX:
+		dp83869->mode =3D DP83869_RGMII_100_BASE;
+		phydev->port =3D PORT_FIBRE;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		dp83869->mode =3D DP83869_RGMII_1000_BASE;
+		phydev->port =3D PORT_FIBRE;
+		break;
+	default:
+		phydev_err(phydev, "incompatible PHY-to-SFP module link mode
%s! Try simply 10/100\n",
+			   phy_modes(interface));
+		dp83869->mode =3D DP83869_RGMII_100_BASE;
+		phydev->port =3D PORT_FIBRE;
+		break;
+	}
=20
 	ret =3D dp83869_configure_mode(phydev, dp83869);
 	if (ret)


It is absolutely possible that I misconfigured something, so here are
the relevant parts of my DTS. Sadly, as you can see, we don't have GPIO
access to the SFP pins, but at least they are properly pulled to the
value that enables the SFP and the transmitter at all times.

sfp0: sfp {
	compatible =3D "sff,sfp";
	i2c-bus =3D <&axi_iic_0>;
};

axi_ethernet_eth: ethernet@40c00000 {
	compatible =3D "xlnx,axi-ethernet-1.00.a";
	reg =3D <0x40c00000 0x40000>;
	phy-handle =3D <&phy0>;
	interrupt-parent =3D <&microblaze_0_axi_intc>;
	interrupts =3D <3>;
	xlnx,rxmem =3D <0x1000>;
	phy-mode =3D "1000base-x";
	max-speed =3D <1000>;
	xlnx,txcsum =3D <0x2>;
	xlnx,rxcsum =3D <0x2>;
	clock-names =3D "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
	clocks =3D <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>, <&clk_bus_0>;
	axistream-connected =3D <&axi_ethernet_0_dma>;
	dma-names =3D "tx_chan0", "rx_chan0";
	mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		phy0: ethernet-phy@0 {
			sfp =3D <&sfp0>;
			reg =3D <1>;
		};
	};
};

Thanks

Best regards,

--=20
Alvaro G. M.


