Return-Path: <netdev+bounces-26495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266B777F44
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BE12819E5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0298214E0;
	Thu, 10 Aug 2023 17:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C11E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:38:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E6E26AA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6xDm4XlYlbe6Z0azw/hZ7dF7GIcNm4Q2rtxweNUAuzo=; b=S6jKz0rffK8YTK2hmeuUNxjNp/
	UiCsbkIxfwacQi0mfrolXN3ksDcl5OlyqfJ625y4ScMmkmcqVfW5Vk6L/yxP2+5iyGIhbiaBtxMGz
	aCs3KGkMsDseAAnB15dszjWwqQvCr3pPhFju0wKKuFQTjp9ZsZ3WowGFAz8daGvfv/zdTNj5zrbus
	DUUhi913udhzUu2NgP/L1z9+CvtddSq3yIz0eyHKwZeVzdCVugrOwjVIYlJ09jSkSeSLVcVWHaxqA
	z/jpORFTbPfTV7Tpe8O7Sl0El3Vbhd/VFDQS1EaVl3St0EBXONkFtAXR8H2T4pUEJhF6cb+6NNriJ
	E3gKrA+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41704)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU9cF-0004Km-0F;
	Thu, 10 Aug 2023 18:38:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU9cE-0001zV-13; Thu, 10 Aug 2023 18:38:30 +0100
Date: Thu, 10 Aug 2023 18:38:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <ZNUglYF2Xy63l4aZ@shell.armlinux.org.uk>
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <20230810164441.udjyn7avp3afcwgo@skbuf>
 <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk>
 <20230810171100.dvnsjgjo67hax4ld@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810171100.dvnsjgjo67hax4ld@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 08:11:00PM +0300, Vladimir Oltean wrote:
> On Thu, Aug 10, 2023 at 05:52:41PM +0100, Russell King (Oracle) wrote:
> > I wonder whether we have any implementation using SNI mode. I couldn't
> > find anything in the in-kernel dts files for this driver, the only
> > dts we have is one that was posted on-list recently, and that was using
> > MII at 100Mbps:
> > 
> > https://lore.kernel.org/r/CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com
> > 
> > No one would be able to specify "sni" in their dts, so maybe for the
> > sake of simplicity, we shouldn't detect whether it's in SNI mode, and
> > just use MII, and limit the speed to just 10Mbps?
> 
> Based on the fact that "marvell,mv88e6060" is in
> dsa_switches_apply_workarounds[], it is technically possible that there
> exist boards which use the SNI mode but have no phy-mode and other
> phylink properties on the CPU port, and thus they work fine while
> skipping phylink. Of course, "possible" != "real".

What I meant is that there are no in-tree users of the Marvell 88E6060
DSA driver. It looks like it was contributed in 2008. Whether it had
users between the date that it was contributed and today I don't know.

All that I can see is that the only users of it are out-of-tree users,
which means we have the maintenance burden from the driver but no
apparent platforms that make use of it, and no way to test it (other
than if one of those out-of-tree users pops up, such as like last
month.)

I know that Arnd tends to strip out code that a platform uses when the
platform is removed, was there a reason that this got left behind,
assuming that it was used by a board?

> Maybe if we don't want to introduce PHY_INTERFACE_MODE_SNI for fear of a
> lack of real users, we could at least detect PortMode=0, and not
> populate supported_interfaces, leading to an intentional validation
> failure and a comment above that check, stating that phy-mode = "sni" is
> not yet implemented?

It would probably be better for mv88e6060_phylink_get_caps() to detect
it and print the warning, leaving supported_interfaces empty - which
will then cause phylink_create() to fail. Maybe that's what you meant,
but I interpreted it as modifying the check in phylink_create().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

