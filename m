Return-Path: <netdev+bounces-21568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A6763E91
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BC01C213DB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA901C9F1;
	Wed, 26 Jul 2023 18:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA71C9ED
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:31:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED6213A
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jIV6AmWAKvlXQAvN+OUg88bWM7t0rkFdL5Jdx9PUGYA=; b=5yv9hLd5UQydF8TOhelG0ygWZ4
	K7PJWSXjDtHCsOn4vcyO9DrsDSI5ouAHRN70gz7ZfrG1r0wL9O/BJqIFIWB+WXQ1iLUVlxMXmTad4
	YvODt+mjCdAmKoKw7fX6BmrgafLQmG/7t/6TttrYHuNQKgCTW69s8SRzzWbbsBf2jlsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOjHl-002NtT-2e; Wed, 26 Jul 2023 20:30:57 +0200
Date: Wed, 26 Jul 2023 20:30:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>,
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
Message-ID: <ea1a6423-64ff-426e-888c-0fb92c86581a@lunn.ch>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
 <PAXPR04MB9185A31E1E3DEBABE03C60F78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFJ6ls0LHrUWahz@shell.armlinux.org.uk>
 <PAXPR04MB918588615923BBE76EFAD4048900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB918588615923BBE76EFAD4048900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > +&eqos {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&pinctrl_eqos_rgmii>;
> > > +       phy-mode = "rgmii-rxid";
> > > +       phy-handle = <&fixed0>;
> > > +       status = "okay";
> > > +
> > > +       fixed0: fixed-link {
> > > +               speed = <1000>;
> > > +               full-duplex;
> > > +       };
> >
> > This is just totally botched up.
> >
> > "fixed0" is _not_ a PHY, therefore you should NOT be referencing it in phy-
> > handle. Please see the DT binding document:
> >
> 
> If there is a hidden rule here, it should be added to the CHECK_DTBS schema target.
> That way, users would get a warning or syntax error when running the tools, reminding
> them to follow the undisclosed rule.

I've no idea how to actually express that in yaml. phy-handle is just
a pointer to another node. There is no type associated to it, so i
don't see how we can say it needs to point to a node within an MDIO
bus. I wounder if it is possible to do a pattern match on the name of
the reference? It probably should match "*phy*".

    Andrew

