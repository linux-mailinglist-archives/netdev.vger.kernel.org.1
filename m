Return-Path: <netdev+bounces-27042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC3779FEA
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1519A28108C
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAA7469;
	Sat, 12 Aug 2023 12:16:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71041CCDF
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 12:16:14 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1BE6C
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=plMBHvNM+Okj/L0EifIi8x5Bd6N2+fRE64bG+NfDvN8=; b=JLTkirnPHqy/b9WVq/8G0bRUEN
	aGg9I0cP7M2lTRe942goV7SqJPlcvxN1qb/mR5lpWygEzbWh4unku7fBbelHluOntx27h3Ylkshoj
	SvOuKQUqPsyDdtgwoI/eRt89xOeSipS5/CdXLJMRHH1oof5uLj/PCaZqZ0dEhjxcVsGs4xumlghCA
	6csv7uPk03KscRq312ZYcDUQhqT3Ni9EaOjAE8UfHaoQSEMSZiS53+0khMabCKVEvdUydQsMFiqVY
	wPA4zhL7E7i3B0smYopFRy4YtxwhYTF0la+DD2ljyqeCRE3l5NGLua0nG5/UglN9KfhFXN2KmV4Xu
	Q+6GVCcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37018)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qUnXG-0006e5-0p;
	Sat, 12 Aug 2023 13:16:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qUnXE-0003tH-6x; Sat, 12 Aug 2023 13:16:00 +0100
Date: Sat, 12 Aug 2023 13:16:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810151617.wv5xt5idbfu7wkyn@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 06:16:17PM +0300, Vladimir Oltean wrote:
> Hi Russell,
> 
> On Tue, Aug 08, 2023 at 03:19:20PM +0100, Russell King (Oracle) wrote:
> > On Tue, Aug 08, 2023 at 04:52:15PM +0300, Vladimir Oltean wrote:
> > > On Tue, Aug 08, 2023 at 01:57:43PM +0100, Russell King (Oracle) wrote:
> > > > Thanks for the r-b.
> > > > 
> > > > At risk of delaying this patch through further discussion... so I'll
> > > > say now that we're going off into discussions about future changes.
> > > > 
> > > > I believe all DSA drivers that provide .phylink_get_caps fill in the
> > > > .mac_capabilities member, which leaves just a few drivers that do not,
> > > > which are:
> > > > 
> > > > $ git grep -l dsa_switch_ops.*= drivers/net/dsa/ | xargs grep -L '\.phylink_get_caps'
> > > > drivers/net/dsa/dsa_loop.c
> > > > drivers/net/dsa/mv88e6060.c
> > > > drivers/net/dsa/realtek/rtl8366rb.c
> > > > drivers/net/dsa/vitesse-vsc73xx-core.c
> > > > 
> > > > I've floated the idea to Linus W and Arinc about setting
> > > > .mac_capabilities in the non-phylink_get_caps path as well, suggesting:
> > > 
> > > Not sure what you mean by "in the non-phylink_get_caps path" (what is
> > > that other path). Don't you mean that we should implement phylink_get_caps()
> > > for these drivers, to have a unified code flow for everyone?
> > 
> > I meant this:
> > 
> >                 /* For legacy drivers */
> >                 if (mode != PHY_INTERFACE_MODE_NA) {
> >                         __set_bit(mode, dp->pl_config.supported_interfaces);
> >                 } else {
> >                         __set_bit(PHY_INTERFACE_MODE_INTERNAL,
> >                                   dp->pl_config.supported_interfaces);
> >                         __set_bit(PHY_INTERFACE_MODE_GMII,
> >                                   dp->pl_config.supported_interfaces);
> >                 }
> 
> Ah, ok, you'd like a built-in assumption of the mac_capabilities in
> dsa_port_phylink_create().
> 
> > but ultimately yes, having the DSA phylink_get_caps method mandatory
> > would be excellent, but I don't think we have sufficient information
> > to do that.
> > 
> > For example, what interface modes does the Vitesse DSA switch support?
> > What speeds? Does it support pause? Does it vary depending on port?
> 
> I only have a VSC7395 datasheet which was shared with me by Linus (and
> that link is no longer functional).
> 
> This switch supports MII/REV-MII/GMII/RGMII on MAC 6, and MACs 0-4 are
> connected to internal PHYs (yes, there is no port 5, also see the
> comment in vsc73xx_probe()).
> 
> Based on vsc73xx_init_port() and vsc73xx_adjust_enable_port(), I guess
> all ports support flow control, and thus, PHYs should advertise it.
> 
> I don't have a datasheet for the other switches supported by the driver:
> 
>  * Vitesse VSC7385 SparX-G5 5+1-port Integrated Gigabit Ethernet Switch
>  * Vitesse VSC7388 SparX-G8 8-port Integrated Gigabit Ethernet Switch
>  * Vitesse VSC7395 SparX-G5e 5+1-port Integrated Gigabit Ethernet Switch
>  * Vitesse VSC7398 SparX-G8e 8-port Integrated Gigabit Ethernet Switch
> 
> but based on the common treatment in vsc73xx_init_port(), I'd say that
> on all models, port 6 (CPU_PORT) is the xMII port and all the others are
> internal PHY ports, and all support the same configuration. So a
> phylink_get_caps() implementation could probably also do one of two
> things, based on "if (port == CPU_PORT)".
...
> That could be an option, but I think the volume of switches is low
> enough that we could just consider converting them all.

It's actually better - the vitesse driver uses .adjust_link, which
means it's excluded from phylink for the DSA/CPU ports.

So, I think for Vitesse, we just need to set INTERNAL and GMII
for ports != CPU_PORT, speeds 10..1000Mbps at FD and HD, and also
sym and asym pause.

That leaves the RTL836x driver, for which I've found:

http://realtek.info/pdf/rtl8366_8369_datasheet_1-1.pdf

and that indicates that the user ports use RSGMII which is SGMII with
a clock in one direction. The only dts I can find is:

arch/arm/boot/dts/gemini-dlink-dir-685.dts

which doesn't specify phy-mode for these, so that'll be using the
phylib default of GMII.

Port 5 supports MII/GMII/RGMII by hardware strapping, which has three
modes of operation:

  MII/GMII (mac mode): 1G (GMII) when linked at 1G, otherwise 100M (MII)
  RGMII: only 1G
  MII (phy mode): only 100M FD supported. Flow control by hardware
  strapping but is readable via a register, but omits to say where.

There's also some suggestion that asym flow control is supported in 1G
mode - but it doesn't say whether it's supported in 100M (and since
IEEE 802.3 advertisements do not make this conditional on speed...
yea, sounds like a slightly broken design to me.)

So for realtek, I propose (completely untested):

8<====
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: dsa: realtek: add phylink_get_caps
 implementation

The user ports use RSGMII, but we don't have that, and DT doesn't
specify a phy interface mode, so phylib defaults to GMII. These support
1G, 100M and 10M with flow control. It is unknown whether asymetric
pause is supported at all speeds.

The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
and support speeds specific to each, with full duplex only supported
in some modes. Flow control may be supported again by hardware pin
strapping, and theoretically is readable through a register but no
information is given in the datasheet for that.

So, we do a best efforts - and be lenient.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 25f88022b9e4..76b5c43e1430 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1049,6 +1049,32 @@ static enum dsa_tag_protocol rtl8366_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_RTL4_A;
 }
 
+static void rtl8366rb_phylink_get_caps(struct dsa_switch *ds, int port,
+				       struct phylink_config *config)
+{
+	unsigned long *interfaces = config->supported_interfaces;
+	struct realtek_priv *priv = ds->priv;
+
+	if (port == priv->cpu_port) {
+		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+		/* Only supports 100M FD */
+		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
+		/* Only supports 1G FD */
+		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
+
+		config->mac_capabilities = MAC_1000 | MAC_100 |
+					   MAC_SYM_PAUSE;
+	}
+
+	/* RSGMII port, but we don't have that, and we don't
+	 * specify in DT, so phylib uses the default of GMII
+	 */
+	__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
+	config->mac_capabilities = MAC_1000 | MAC_100 | MAC_10 |
+				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+}
+
 static void
 rtl8366rb_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
 		      phy_interface_t interface, struct phy_device *phydev,
@@ -1796,6 +1822,7 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
+	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
 	.get_strings = rtl8366_get_strings,
@@ -1821,6 +1848,7 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
 	.setup = rtl8366rb_setup,
 	.phy_read = rtl8366rb_dsa_phy_read,
 	.phy_write = rtl8366rb_dsa_phy_write,
+	.phylink_get_caps = rtl8366rb_phylink_get_caps,
 	.phylink_mac_link_up = rtl8366rb_mac_link_up,
 	.phylink_mac_link_down = rtl8366rb_mac_link_down,
 	.get_strings = rtl8366_get_strings,
-- 
2.30.2


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

