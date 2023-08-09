Return-Path: <netdev+bounces-25763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1917755D7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD81C2119B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B08C0D;
	Wed,  9 Aug 2023 08:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0401FA6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:44:00 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D387F0;
	Wed,  9 Aug 2023 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cKdDAwuN7ArSFpLCXAKyPip8XfBoVOsaEIFRLY8h5c4=; b=1WRK5YM/39NWfX9X9AYMRiU8TT
	KRQCraZfpzMNslYyy7mhaOM4AsqzEmk4JsJQnfgsugI9D7bx3iry5jbZIOGzFqd3lDW1+oOYaTjKU
	Uv3t4LFV27snMeyWZovjEzZoOwyyEhHOlFvWMY9IVXRTQyM0zpVaeTrqeTTB4ObTUw1ZGAJSFvPBH
	dhDJrzuowtSaziHZWVcXnb0aheZlGya5bCVCdBCX65spwvexne8YWIxADbFua8bKikBhudLlaZTIG
	tB+b3DU+BS6eQVLt5e4JponNufPSB6bOB8T6gmhb0HIkvnRFv+CcF+CnTj+9pXwtr+U0UMCWqyqhi
	rDbJne6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36380)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTenI-0002Hc-2G;
	Wed, 09 Aug 2023 09:43:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTenF-0000aY-Od; Wed, 09 Aug 2023 09:43:49 +0100
Date: Wed, 9 Aug 2023 09:43:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-clk@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNNRxY4z7HroDurv@shell.armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809060836.GA13300@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809060836.GA13300@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 08:08:36AM +0200, Oleksij Rempel wrote:
> If fully functional external clock provider is need to initialize the
> MAC, just disabling this clock on already initialized HW without doing
> proper re-initialization sequence is usually bad idea. HW may get some
> glitch which will make troubleshooting a pain.

There are cases where the PHY sits on a MDIO bus that is created
by the ethernet MAC driver, which means the PHY only exists during
the ethernet MAC driver probe.

I think that provided the clock is only obtained after we know the
PHY is present, that would probably be fine - but doing it before
the MDIO bus has been created will of course cause problems.

We've had these issues before with stmmac, so this "stmmac needs the
PHY receive clock" is nothing new - it's had problems with system
suspend/resume in the past, and I've made suggestions... and when
there's been two people trying to work on it, I've attempted to get
them to talk to each other which resulted in nothing further
happening.

Another solution could possibly be that we reserve bit 30 on the
PHY dev_flags to indicate that the receive clock must always be
provided. I suspect that would have an advantage in another
situation - for EEE, there's a control bit which allows the
receive clock to be stopped while the link is in low-power state.
If the MAC always needs the receive clock, then obviously that
should be blocked.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

