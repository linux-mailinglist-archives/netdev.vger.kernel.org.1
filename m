Return-Path: <netdev+bounces-12755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCA738CB0
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6CB1C20F67
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC719BA2;
	Wed, 21 Jun 2023 17:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB4182C8
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:04:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596D122;
	Wed, 21 Jun 2023 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RMT3blcJBQ0WScjwxyl/3L3fzwNQrAhiDEbiSqUkJxw=; b=EIyDO6pOaeIV6IbjFQ07Da4Bz8
	OCdATmrU/7Ql9Tji5gzXzRkIWuoX/o6eO16LVORTeS6Opdm833hcGT47+itDw5Xf48G6AxNS6O1Sn
	++z1ML3iCjJxxd7Wy9BTpb8n9albTVpANMo3qgGZPB7QxhRsCc5TX6+x+UVOMsQOpbXJrrZavuMTD
	EQ/9zRXNAmd8fX6rF9VS6vveBymFdxKNFdKfPH67Boa6EM/lSH38TIgif9jHR0kIwDzFHmQDrWBE6
	Jl9evMh6Vnl4YdrDipuuYkalYOP0ABxaJTiwTCWgTptwcplleQUL4BW5ltuX769jFSWXsRE7U1xLq
	zL21wj0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60566)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qC1GC-00032K-KA; Wed, 21 Jun 2023 18:04:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qC1GB-0007uv-Kv; Wed, 21 Jun 2023 18:04:47 +0100
Date: Wed, 21 Jun 2023 18:04:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, ansuelsmth@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Manual remove LEDs to ensure correct
 ordering
Message-ID: <ZJMtrw6zdi2YP7b5@shell.armlinux.org.uk>
References: <20230617155500.4005881-1-andrew@lunn.ch>
 <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 03:04:14PM +0100, Florian Fainelli wrote:
> Hi Andrew,
> 
> On 6/17/2023 4:55 PM, Andrew Lunn wrote:
> > If the core is left to remove the LEDs via devm_, it is performed too
> > late, after the PHY driver is removed from the PHY. This results in
> > dereferencing a NULL pointer when the LED core tries to turn the LED
> > off before destroying the LED.
> > 
> > Manually unregister the LEDs at a safe point in phy_remove.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> > Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> > Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Thanks for fixing this, this is an improvement, though I can still hit
> another sort of use after free whereby the GENET driver removes the
> mdio-bcm-unimac platform device and eventually cuts the clock to the MDIO
> block thus causing the following:

Hi Florian,

Can you try setting trigger_data->led_cdev to NULL after the
cancel_delayed_work_sync() in netdev_trig_deactivate() and see
what the effect is?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

