Return-Path: <netdev+bounces-21465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE3763A7A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E32812C3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144FBA23;
	Wed, 26 Jul 2023 15:10:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F41DA20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:10:42 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294219A0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qcHFQShJ8xCCYx3UKOG0Q26bZQ+J+tHO+1k/rGHDKCQ=; b=S1GUr1kR7Q/3LxtDXdrTCah/j4
	39q6JeAVM3oOO7Oap3k4TzOIyNaVRR2kuG5hsxppgMbg8UqD/puqwhf4xfWa1fOERICIHIUah5rHM
	dTYmwpBmbDwdx4sE626QH/FrCr1WDRCrVcXBx5u0q1aKKdbyjd2+a9J+esp8YbWgYmCGNEcT3GFMs
	gpf+WchZxYnw4fkmVETZDkcCWcknVk0/Ga8LFWp9NCzxnXSUt4LoCzS7N3eJ+UE4UpBfdDSLVHk19
	WiS8klNRJEjEoQXsbM5TSny/xZRoWrt6ExXkVk8/tP90Zp76ufLC4dwIfCimEpSEZSA6TaBDwYbq7
	HvEdsGLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55868)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOg8m-0004c9-0o;
	Wed, 26 Jul 2023 16:09:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOg8j-0002y4-0o; Wed, 26 Jul 2023 16:09:25 +0100
Date: Wed, 26 Jul 2023 16:09:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 03:00:49PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > Sent: Tuesday, July 25, 2023 4:05 PM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> > Shawn Guo <shawnguo@kernel.org>; dl-linux-imx <linux-imx@nxp.com>;
> > Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>; Sascha
> > Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> > arm-kernel@lists.infradead.org; imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
> > Subject: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
> > fixed-link
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report this
> > email' button
> >
> >
> > On Tue, Jul 25, 2023 at 02:49:31PM -0500, Shenwei Wang wrote:
> > > +static bool imx_dwmac_is_fixed_link(struct imx_priv_data *dwmac) {
> > > +     struct plat_stmmacenet_data *plat_dat;
> > > +     struct device_node *dn;
> > > +
> > > +     if (!dwmac || !dwmac->plat_dat)
> > > +             return false;
> > > +
> > > +     plat_dat = dwmac->plat_dat;
> > > +     dn = of_get_child_by_name(dwmac->dev->of_node, "fixed-link");
> > > +     if (!dn)
> > > +             return false;
> > > +
> > > +     if (plat_dat->phy_node == dn || plat_dat->phylink_node == dn)
> > > +             return true;
> >
> > Why would the phy_node or the phylink_node ever be pointing at the fixed-link
> > node?
> >
> 
> The logic was learned from the function of stmmac_probe_config_dt, and it normally
> save the phy handle to those two members: phy_node and phylink_node. But seems
> checking phy_node is enough here, right?
> 
>         plat->phy_node = of_parse_phandle(np, "phy-handle", 0);
> 
>         /* PHYLINK automatically parses the phy-handle property */
>         plat->phylink_node = np;

So, plat->phy_node will never ever be equal to your "dn" above.
plat->phylink_node is the same as dwmac->dev->of_node above, and
so plat->phylink_node will never be your "dn" above either.

Those two together means that imx_dwmac_is_fixed_link() will _always_
return false, and thus most of the code you're adding is rather
useless.

It also means the code you're submitting probably hasn't been properly
tested.

Have you confirmed that imx_dwmac_is_fixed_link() will actually return
true in your testing? Under what conditions did your testing reveal a
true return value from this function?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

