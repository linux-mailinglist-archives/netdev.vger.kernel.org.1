Return-Path: <netdev+bounces-30299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF84786CE5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADEE281549
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E25689;
	Thu, 24 Aug 2023 10:39:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7B24550
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 10:39:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1ED19BA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bd9ObF5yMryn1R9YSIxTJTCgwM9L1it8cN+fWSWpN5M=; b=psXyNZvI5Np55L+RpucSDCB+HA
	cgUdNAjvw/3EKhGEdZSbRqkutatnhXtVvKqGMReYnbfuQeZsx5tBtXYXA/+oEYhtG7eJWDt0Re7C7
	IRy2aoTBqVrgB9RuXM4Xrz4fXLDZ6Ot4qLw8RxRUr0jY+D5guMY4J7a5xPC0OG/nfnCQdBxWCQ+OH
	Ry8Jvp4GLcRb7qO0EKqbPp9Rw0JUI3VTbBOfWi0+FxI1R0tDusORiWO+nMrb4ftG8fzki9kgEhKHh
	OCt6fcydMeUzij2zGPKiKkx+Lq0/AmgcUQrO+FGZdwKs433zeZj23hKDZV3SmXvFzl3aBA17sFjYT
	F4n68GSA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45678)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qZ7jq-00040J-06;
	Thu, 24 Aug 2023 11:38:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qZ7jl-0007mV-UL; Thu, 24 Aug 2023 11:38:49 +0100
Date: Thu, 24 Aug 2023 11:38:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/9] net: stmmac: use phylink_limit_mac_speed()
Message-ID: <ZOczOWMLJnzAdwV1@shell.armlinux.org.uk>
References: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
 <E1qYWSO-005fXx-6w@rmk-PC.armlinux.org.uk>
 <20230823193457.35052bf8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823193457.35052bf8@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 07:34:57PM -0700, Jakub Kicinski wrote:
> On Tue, 22 Aug 2023 19:50:24 +0100 Russell King (Oracle) wrote:
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index b51cf92392d2..0d7354955d62 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -440,7 +440,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed)
> >  
> >  	for (i = 0; i < ARRAY_SIZE(phylink_caps_params) &&
> >  		    phylink_caps_params[i].speed > max_speed; i++)
> > -		config->mac_speed &= ~phylink_caps_params.mask;
> > +		config->mac_capabilities &= ~phylink_caps_params[i].mask;
> >  }
> >  EXPORT_SYMBOL_GPL(phylink_limit_mac_speed);
> 
> This chunk belongs to patch 1?

Thanks for spotting that, you're absolutely right. I wonder why I didn't
merge that fix into the correct patch...

In any case, I added a 10th patch to the patch set which converts the
half-duplex capabilities to be positive logic. I'll resend it later
today.

I also have a raft of other stmmac cleanup patches which are steadily
growing at the moment!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

