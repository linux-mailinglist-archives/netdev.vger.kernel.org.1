Return-Path: <netdev+bounces-21582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B3763F2B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC93281E41
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321314CE7F;
	Wed, 26 Jul 2023 19:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA217EE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:02:52 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA1E7
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wXW4zeJ6rlfREB6dHGCPp9zXTWqhL1U69TNjRIothDQ=; b=vFpsbbfGBMkes3CY8idRKZv0Xn
	IGb36va9ijEmQ7dTr4klI+bsegyBoafgJVLOQmpmqqs+3CaHhD6swE/mZGG6pnYwgI0b9I0GQTO1A
	ps7Ub0Wb1MTe1LJLD+VEKnKAFctTFgMt78gNxZZECMQRoNMMv1qO35GBDaG5Id6WukqPBgWkyvugD
	bEUH6/d3Woe6RpSZRxSflFWs+tk2GPwqArQTAg7CIBYlXG7UzUP6BKNAZJ4J851a9VUgtf+OQnQYy
	k7x5hbf/oj7NXcHTYd5OgXBqYBaxGyVWmiim3yt17+9ODQtfqBSXRRBwvP51e9j/5vVsDnMB2N8kF
	VzN2igtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58924)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOjmK-0004rd-1P;
	Wed, 26 Jul 2023 20:02:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOjmF-00036U-As; Wed, 26 Jul 2023 20:02:27 +0100
Date: Wed, 26 Jul 2023 20:02:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Frank Li <frank.li@nxp.com>
Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Message-ID: <ZMFtw0LNozhNjRGF@shell.armlinux.org.uk>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <20230726004338.6i354ue576hb35of@skbuf>
 <PAXPR04MB9185C1A95E101AC2E08639B78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME71epmSHYIB4DZ@shell.armlinux.org.uk>
 <PAXPR04MB91856018959FE0752F1A27888900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFRVtg5WQyGlBJ1@shell.armlinux.org.uk>
 <PAXPR04MB9185108CB4A04C4CD5AE29FC8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9185108CB4A04C4CD5AE29FC8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 06:47:15PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > Sent: Wednesday, July 26, 2023 12:01 PM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: Vladimir Oltean <olteanv@gmail.com>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> > Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> > dl-linux-imx <linux-imx@nxp.com>; Giuseppe Cavallaro
> > <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>;
> > Jose Abreu <joabreu@synopsys.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> > mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> > Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
> > fixed-link
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report this
> > email' button
> >
> >
> > On Wed, Jul 26, 2023 at 03:59:38PM +0000, Shenwei Wang wrote:
> > > > -----Original Message-----
> > > > From: Russell King <linux@armlinux.org.uk>
> > > > Sent: Wednesday, July 26, 2023 10:29 AM
> > > > To: Shenwei Wang <shenwei.wang@nxp.com>
> > > > Cc: Vladimir Oltean <olteanv@gmail.com>; David S. Miller
> > > > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > > > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> > > > Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo
> > > > <shawnguo@kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Giuseppe
> > > > Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> > > > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > > > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > > netdev@vger.kernel.org; linux-stm32@st-md- mailman.stormreply.com;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> > > > Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC
> > > > clock in fixed-link
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Wed, Jul 26, 2023 at 03:10:19PM +0000, Shenwei Wang wrote:
> > > > > > if (of_phy_is_fixed_link(dwmac->dev->of_node)) {
> > > > > >
> > > > >
> > > > > This does not help in this case. What I need to determine is if
> > > > > the PHY currently
> > > > in use is a fixed-link.
> > > > > The dwmac DTS node may have multiple PHY nodes defined, including
> > > > > both
> > > > fixed-link and real PHYs.
> > > >
> > > > ... and this makes me wonder what DT node structure you think would
> > > > describe a fixed-link.
> > > >
> > > > A valid ethernet device node would be:
> > > >
> > > >         dwmac-node {
> > > >                 phy-handle = <&phy1>;
> > > >         };
> > > >
> > > > In this case:
> > > >         dwmac->dev->of_node points at "dwmac-node"
> > > >         plat->phylink_node points at "dwmac-node"
> > > >         plat->phy_node points at "phy1"
> > > >         Your "dn" is NULL.
> > > >         Therefore, your imx_dwmac_is_fixed_link() returns false.
> > > >
> > > >         dwmac-node {
> > > >                 fixed-link {
> > > >                         speed = <...>;
> > > >                         full-duplex;
> > > >                 };
> > > >         };
> > > >
> > > > In this case:
> > > >         dwmac->dev->of_node points at "dwmac-node"
> > > >         plat->phylink_node points at "dwmac-node"
> > > >         plat->phy_node is NULL
> > > >         Your "dn" points at the "fixed-link" node.
> > > >         Therefore, your imx_dwmac_is_fixed_link() also returns false.
> > > >
> > > > Now, as far as your comment "What I need to determine is if the PHY
> > > > currently in use is a fixed-link." I'm just going "Eh? What?" at
> > > > that, because it makes zero sense to me.
> > > >
> > > > stmmac uses phylink. phylink doesn't use a PHY for fixed-links,
> > > > unlike the old phylib-based fixed-link implementation that software-
> > emulated a clause-22 PHY.
> > > > With phylink, when fixed-link is specified, there is _no_ PHY.
> > >
> > > So you mean the fixed-link node will always be the highest priority to
> > > be used in the phylink use case?
> >
> > Yes, because that is how all network drivers have behaved. If you look at the
> > function that Vladimir pointed out, then you will notice that the mere presence
> > of a fixed-link node makes it a "fixed link".
> >
> 
> Then, the way this phylink driver behaves makes the rest of the discussion kind of pointless
> for now, because I don't actually need fix_mac_speed to give me any interface info now.
> The basic of_phy_is_fixed_link check does the job for me.
> 
> Not sure why you think it's inefficient - could you explain that part?

Because of_phy_is_fixed_link() has to chase various pointers, walk
the child nodes and do a string compare on each, whereas you could
just be testing an integer!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

