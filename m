Return-Path: <netdev+bounces-26231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFFC7773B3
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E17281E53
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9632C1E522;
	Thu, 10 Aug 2023 09:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AF1DDFE
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:08:47 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE0C211E;
	Thu, 10 Aug 2023 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yQ8hlwMYrDg6ST28m32+/PAD0xXq2o0xJouvIduOZYs=; b=HnTzeCu9uLUI04oB5RiPKLQ1/X
	21LRsT4x9tFFcxFnwTHlCTIvxmCMW/VeK47hQwUepkJnG9CpPC4ipEMh/keAzyiATcHQDsMWezwVp
	Cy/X6QO7ZWyem2aH8Q2UB0Hr9Vxi79xOimVJkIoCtCh7X+QKEehB0Mk5UjBex+Lahmg7X54irMbae
	TBfg2IL7o86SMIMUS8ePV2qt67CV968CivloAjAxXQlQjfoV1k0o5YK4UeFUU7nM+OZ0xL79p0Fdc
	gr4aq0z7c93NcAOJxVFepucBN7opapY5J1o/5ifPq2ekuKe+kwWMDBeSD9tIQG1OA9tI+XKjvrSyE
	dpL2T/Rw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU1el-0003g2-2X;
	Thu, 10 Aug 2023 10:08:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU1ej-0001dE-DA; Thu, 10 Aug 2023 10:08:33 +0100
Date: Thu, 10 Aug 2023 10:08:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNSpEbDVFe5MdyqD@shell.armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809060836.GA13300@pengutronix.de>
 <AM5PR04MB3139D7984B4DAADCB25597778813A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR04MB3139D7984B4DAADCB25597778813A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 03:28:13AM +0000, Wei Fang wrote:
> > > Furthermore,
> > > we would expect the hibernation mode is enabled when the ethernet
> > > interface is brought up but the cable is not plugged, that is to say,
> > > we only need the PHY to provide the clock for a while to make the MAC
> > reset successfully.
> > 
> > Means, if external clock is not provided, MAC is not fully functional.
> > Correct?
> > 
> The MAC will failed to do software reset if the PHY input clocks are not
> present.

Yes, that's well known to me - it's been brought up before with stmmac
and phylink. I said earlier in this thread about this.

> > For example, if stmmac_open() fails without external clock, will
> > stmmac_release() work properly?
> Actually, I don't know much about stmmac driver and the dwmac IP,
> Because I'm not responsible for this IP on NXP i.MX platform. But I
> have a look at the code of stmmac_release(), I think stmmac_release()
> will work properly, because it invokes phylink_stop() and phylink_disconnect_phy()
> first which will disable the clock from PHY.

When tearing down a network device, there should be no reason to call
phylink_stop() - unregistering the netdev will take the network device
down, and thus call the .ndo_stop method if the device was up. .ndo_stop
should already be calling phylink_stop().

I just don't get why driver authors don't check things like this...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

