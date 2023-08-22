Return-Path: <netdev+bounces-29761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B133784996
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21296281170
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839E1DA2C;
	Tue, 22 Aug 2023 18:50:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B02B55A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:50:02 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4BCD1
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=blH/hqqKqMi+gy0guzeEpc4bpRaUzWv6qZAMAVdyYUQ=; b=QXF9ZXHiJwEJYjjC/ZVXCMSte8
	/O58QCUo0VyBOox5unGFleYn4FN+iT6dZJ/+LSulXbiXdkAv0bfie2m2fbzZTg5TTpG4ddbA5K842
	xu/194PYLkv0ArzZCFZtmrKUMR+eWBgyqQUidvEK1kCF8see+xmVYyUxntG72QmEVDEdjR6S5b/d6
	h55XUE3mvZ8lH4k+W109dM9GKmOBk5z4oPF3q0pN2bR26bCjkKcIB6tO/o5QAQRS5jQAT1t2bsJqV
	Leh1HRiO28WHDJHnUqtppFOznOjWu96Y72N4l8wclr0eFgl2cz9RplUy7ZGh8DnaA+k1woyCDbwVZ
	R1aUS6tg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41746)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qYWRl-0001qs-2l;
	Tue, 22 Aug 2023 19:49:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qYWRi-00062L-Ep; Tue, 22 Aug 2023 19:49:42 +0100
Date: Tue, 22 Aug 2023 19:49:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/9] stmmac cleanups
Message-ID: <ZOUDRkBXzY884SJ1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

One of the comments I had on Feiyang Chen's series was concerning the
initialisation of phylink... and so I've decided to do something about
it, cleaning it up a bit.

This series:

1) adds a new phylink function to limit the MAC capabilities according
   to a maximum speed. This allows us to greatly simplify stmmac's
   initialisation of phylink's mac capabilities.

2) everywhere that uses priv->plat->phylink_node first converts this
   to a fwnode before doing anything with it. This is silly. Let's
   instead store it as a fwnode to eliminate these conversions in
   multiple places.

3) clean up passing the fwnode to phylink - it might as well happen
   at the phylink_create() callsite, rather than being scattered
   throughout the entire function.

4) same for mdio_bus_data

5) use phylink_limit_mac_speed() to handle the priv->plat->max_speed
   restriction.

6) add a method to get the MAC-specific capabilities from the code
   dealing with the MACs, and arrange to call it at an appropriate
   time.

7) convert the gmac4 users to use the MAC specific method.

8) same for xgmac.

9) lastly, group all the simple phylink_config initialisations together.


While looking into all of this, this raised eyebrows:

        if (priv->plat->tx_queues_to_use > 1)
                priv->phylink_config.mac_capabilities &=
                        ~(MAC_10HD | MAC_100HD | MAC_1000HD);

priv->plat->tx_queues_to_use is initialised by platforms to either 1,
4 or 8, and can be controlled from userspace via the --set-channels
ethtool op. The implementation of this op in this driver limits the
number of channels to priv->dma_cap.number_tx_queues, which is derived
from the DMA hwcap.

So, the obvious questions are:

1) what guarantees that the static initialisation of tx_queues_to_use
will always be less than or equal to number_tx_queues from the DMA hw
cap?

2) tx_queues_to_use starts off as 1, but number_tx_queues is larger,
we will leave the half-duplex capabilities in place, but userspace can
increase tx_queues_to_use above 1. Does that mean half-duplex is then
not supported?

3) Should we be basing the decision whether half-duplex is supported
off the DMA capabilities?

4) What about priv->dma_cap.half_duplex? Doesn't that get a say in
whether half-duplex is supported or not? Why isn't this used? Why is
it only reported via debugfs? If it's not being used by the driver,
what's the point of reporting it via debugfs?

 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  8 ++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 10 ++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 53 ++++++++--------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  2 +-
 drivers/net/phy/phylink.c                          | 18 ++++++++
 include/linux/phylink.h                            |  2 +
 include/linux/stmmac.h                             |  2 +-
 9 files changed, 66 insertions(+), 36 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

