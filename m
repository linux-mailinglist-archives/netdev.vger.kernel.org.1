Return-Path: <netdev+bounces-32183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CF793572
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 08:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AE11C209A8
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291CE7F5;
	Wed,  6 Sep 2023 06:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E00362
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 06:40:51 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B654BCF6;
	Tue,  5 Sep 2023 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lEKa32vDz9dRLHtkiqwBJfqS+z/ud40G6jgqmrjZXvA=; b=Yvk14RBqPGC7nXQfcqb7XiHuZi
	eb3DC2GRdqxshCc+KqXsoouVITXuQ6FUZKqwatwkrHm8dvS2XMzCjva0xt3kij2fS06x8Ngi0zMH5
	HsAhHlA5mzGgnywW593Ukc8DPPyGUrsbk7BqUFpP47K4hua6U2rxg/IuZ6nldsC1v7BwW1vsLasSD
	CjiCIsbm4VzSEtnPxt/dsRb7dZRyKUN9wuE5vyFY7YZ9qUBDbgsmKfSc+37l5Qx7rI4/6RuSpW3gz
	d1msfTMk9d/Aqy0RC+fkL6hixKC3dejD9ly7MLQBr+KhV3ia0loqT/lBRR/tX8YNBK0uzngUvxTmu
	sL1T4XXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qdmD8-0000Fd-38;
	Wed, 06 Sep 2023 07:40:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qdmD6-0004Xt-8o; Wed, 06 Sep 2023 07:40:20 +0100
Date: Wed, 6 Sep 2023 07:40:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
Message-ID: <ZPge1LuqIRk9N2P0@shell.armlinux.org.uk>
References: <20230905093315.784052-1-lukma@denx.de>
 <20230905222945.h7tuzlraxdp5imbh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905222945.h7tuzlraxdp5imbh@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 01:29:45AM +0300, Vladimir Oltean wrote:
> It's probably not causing practical harm, but currently, we tell
> genphy_config_eee_advert() to include reserved bits of the MMD EEE
> Advertising Register (MMD 0x07 : 0x3C) into its modification mask.

Ah, you've fallen into that trap. genphy_config_eee_advert() is
obsolete and redundant. Nothing calls it, and it should be removed.

What's actually used is genphy_c45_an_config_eee_aneg() and
genphy_c45_write_eee_adv(). The latter will not modify any reserved
bits in the register.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

