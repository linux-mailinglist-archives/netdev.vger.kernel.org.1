Return-Path: <netdev+bounces-27391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493577BC8F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA3928106A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1EC2C1;
	Mon, 14 Aug 2023 15:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E9A923
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:12:51 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F4E7E
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kQA0QrAorpjrAzve9okxGLvpuvEGt4sgUJYHLSPn50Q=; b=qPjWyJFYPkvegEmIZNR3fShH8C
	QST80SH/KMv3a6Q71KFBdmRKHCk9rPKiQEluWM8K95aiOu25fDAFrsLUkWplJ6gu3ZwUs45yua+9g
	J+6e+0aJMGIwfRU9iNxVnc11RaNGtoE+VBaYSEybiPPgv9zQgfcgqHB/JAE27DJZHOrsozEE1gKik
	LLScHrSYmkT27ih/gZ/Rrw4lCi/Ug5Njh1oK4rj9yvf51ARVBtnmRL9FV1f3j/SIcvAaYsmU7PDQ0
	G53OsDwMnVnjn/pXoXix3MVB8cedDMCpKfulqPXbheT1gGwaHfHtZ90O9llejye9Vc+hcxOZU8c/e
	453Ha0Nw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qVZFJ-0000Wf-1e;
	Mon, 14 Aug 2023 16:12:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qVZFI-000642-96; Mon, 14 Aug 2023 16:12:40 +0100
Date: Mon, 14 Aug 2023 16:12:40 +0100
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
Message-ID: <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
References: <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814145948.u6ul5dgjpl5bnasp@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 05:59:48PM +0300, Vladimir Oltean wrote:
> On Sat, Aug 12, 2023 at 01:16:00PM +0100, Russell King (Oracle) wrote:
> > So for realtek, I propose (completely untested):
> > 
> > 8<====
> > From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > Subject: [PATCH net-next] net: dsa: realtek: add phylink_get_caps
> >  implementation
> > 
> > The user ports use RSGMII, but we don't have that, and DT doesn't
> > specify a phy interface mode, so phylib defaults to GMII. These support
> > 1G, 100M and 10M with flow control. It is unknown whether asymetric
> > pause is supported at all speeds.
> > 
> > The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
> > and support speeds specific to each, with full duplex only supported
> > in some modes. Flow control may be supported again by hardware pin
> > strapping, and theoretically is readable through a register but no
> > information is given in the datasheet for that.
> > 
> > So, we do a best efforts - and be lenient.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/dsa/realtek/rtl8366rb.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> > index 25f88022b9e4..76b5c43e1430 100644
> > --- a/drivers/net/dsa/realtek/rtl8366rb.c
> > +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> > @@ -1049,6 +1049,32 @@ static enum dsa_tag_protocol rtl8366_get_tag_protocol(struct dsa_switch *ds,
> >  	return DSA_TAG_PROTO_RTL4_A;
> >  }
> >  
> > +static void rtl8366rb_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				       struct phylink_config *config)
> > +{
> > +	unsigned long *interfaces = config->supported_interfaces;
> > +	struct realtek_priv *priv = ds->priv;
> > +
> > +	if (port == priv->cpu_port) {
> > +		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_GMII, interfaces);
> > +		/* Only supports 100M FD */
> > +		__set_bit(PHY_INTERFACE_MODE_REVMII, interfaces);
> > +		/* Only supports 1G FD */
> > +		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
> 
> also, I guess that this should allow all 4 variants of RGMII.

I'm not sure - looking at what's available, the RTL8366 datasheet (not
RB) says that there's pinstrapping for the RGMII delays. It also suggests
that there may be a register that can be modified for this, but the driver
doesn't appear to touch it - in fact, it does nothing with the interface
mode. Moreover, the only in-kernel DT for this has:

                        rtl8366rb_cpu_port: port@5 {
                                reg = <5>;
                                label = "cpu";
                                ethernet = <&gmac0>;
                                phy-mode = "rgmii";
                                fixed-link {
                                        speed = <1000>;
                                        full-duplex;
                                        pause;
                                };
                        };

Whether that can be changed in the RB version of the device or not, I
don't know, so whether it makes sense to allow the other RGMII modes,
again, I don't know.

Annoyingly, gmac0 doesn't exist in this file, it's defined in
gemini.dtsi, which this file references through a heirarchy of nodes
(makes it very much less readable), but it points at:

/ {
...
        soc {
...
                ethernet@60000000 {
...
                        ethernet-port@0 {
                                phy-mode = "rgmii";
                                fixed-link {
                                        speed = <1000>;
                                        full-duplex;
                                        pause;
                                };
                        };

So that also uses "rgmii".

I'm tempted not to allow the others as the driver doesn't make any
adjustments, and we only apparently have the one user.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

