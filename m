Return-Path: <netdev+bounces-25526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3F77471B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300FE280FA1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523BD171D8;
	Tue,  8 Aug 2023 19:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A411773F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:24 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB856AB3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q0JSWowIBE2LLM2B5JHvw7l7HGjSNR4189vyxXIcWI4=; b=AkC8drsOi6S38c6+c3mwFRX5Wy
	EWSaDzOdri7RMOYN1h5By/k+ggZwMLAVfyzmTGzSonKoc5NWtkuEIpNxcR3V3khjsf+SyrpBA7g8l
	7ou6UVtXeEBxEXAnVr5tRaAdew/uyB5hjWDSVR5ZesolreoQCnBtpM15u8M0tOdQy0W463ZbnBkIB
	CaEyffn9HOoiA4bolMyhjTNhU8ia63wQjJeCeYrFmwu6uCerbvikMMeiskqRdN5ughOCzkKT8O1Uo
	oQq13bbZhsxtraYAhnOgJru23F9E4p8GHD+w7DTxcL1yNVwiTjcZ+gl217AUt58pp4yvYJ24rbOep
	3Qv/Wxdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTLqs-0007ho-12;
	Tue, 08 Aug 2023 13:30:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTLqq-00085h-V6; Tue, 08 Aug 2023 13:30:16 +0100
Date: Tue, 8 Aug 2023 13:30:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808120652.fehnyzporzychfct@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 03:06:52PM +0300, Vladimir Oltean wrote:
> Hi Russell,
> 
> On Tue, Aug 08, 2023 at 12:12:16PM +0100, Russell King (Oracle) wrote:
> > If we successfully parsed an interface mode with a legacy switch
> > driver, populate that mode into phylink's supported interfaces rather
> > than defaulting to the internal and gmii interfaces.
> > 
> > This hasn't caused an issue so far, because when the interface doesn't
> > match a supported one, phylink_validate() doesn't clear the supported
> > mask, but instead returns -EINVAL. phylink_parse_fixedlink() doesn't
> > check this return value, and merely relies on the supported ethtool
> > link modes mask being cleared. Therefore, the fixed link settings end
> > up being allowed despite validation failing.
> > 
> > Before this causes a problem, arrange for DSA to more accurately
> > populate phylink's supported interfaces mask so validation can
> > correctly succeed.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> 
> How did you notice this? Is there any unconverted DSA switch which has a
> phy-mode which isn't PHY_INTERFACE_MODE_INTERNAL or PHY_INTERFACE_MODE_NA?

By looking at some of the legacy drivers, finding their DT compatibles
and then grepping the dts files.

For example, vitesse,vsc73* compatibles show up here:

arch/arm/boot/dts/gemini/gemini-sq201.dts

and generally, the ports are listed as:

                                port@0 {
                                        reg = <0>;
                                        label = "lan1";
                                };

except for the CPU port which has:

                                vsc: port@6 {
                                        reg = <6>;
                                        label = "cpu";
                                        ethernet = <&gmac1>;
                                        phy-mode = "rgmii";
                                        fixed-link {
                                                speed = <1000>;
                                                full-duplex;
                                                pause;
                                        };
                                };

Since the vitesse DSA driver doesn't populate .phylink_get_caps, it
would have been failing as you discovered with dsa_loop before the
previous patch.

Fixing this by setting GMII and INTERNAL worked around the additional
check that was using that failure and will work fine for the LAN
ports as listed above.

However, that CPU port uses "rgmii" which doesn't match the GMII and
INTERNAL bits in the supported mask.

Since phylink_validate() does this:

        const unsigned long *interfaces = pl->config->supported_interfaces;

	if (state->interface == PHY_INTERFACE_MODE_NA)

... it isn't, so we move on...

        if (!test_bit(state->interface, interfaces))
                return -EINVAL;

This will trigger and phylink_validate() in phylink_parse_fixedlink()
will return -EINVAL without touching the passed supported mask.

phylink_parse_fixedlink() does:

        bitmap_fill(pl->supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
        linkmode_copy(pl->link_config.advertising, pl->supported);
        phylink_validate(pl, MLO_AN_FIXED, pl->supported, &pl->link_config);

and then we have:

        s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
                               pl->supported, true);

...
        if (s) {
		... success ...
        } else {
                phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n",
                             pl->link_config.duplex == DUPLEX_FULL ? "full" : "half",
                             pl->link_config.speed);
        }

So, since phylink_validate() with an apparently unsupported interface
exits early with -EINVAL, pl->supported ends up with all bits set,
and phy_lookup_setting() allows any speed.

If someone decides to fix that phylink_validate() error checking, then
this will then lead to a warning/failure.

I want to avoid that happening - fixing that latent bug before it
becomes a problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

