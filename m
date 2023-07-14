Return-Path: <netdev+bounces-17880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A3753625
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80E41C215D4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFDD51F;
	Fri, 14 Jul 2023 09:11:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D5D507
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:11:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3301BD
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KPCmfSZJJk1fn8yM9S62V6Eybb9c/BJs6GiVlhq2wRg=; b=eXaEPijFO6/KMJtLkSSI7tOdDU
	52N9Ke6yAv7MagBrBJ4ib/4yd+29agCwHM5JnhD/c5GijONqD9T3dtvWfaAAsj1pegN8leEB6GN1o
	HYlLJsv9MfM9yjM141EFwmkssbmEVnsQpft5J5Up7A4mW8cyNaI0Iz9Jd4GR+leIg2moV9MGVuwsD
	1stIIjMGYSY1FYlnG2bocCSE0mrKDEkGJoGbJEpvmOeFt93wR976nmc/Cxwgf6zkwx55XpxFAH/mb
	Yord0MG18jkq/KICcFU6K6q1lbvtuvOV8Yb32ZzKVN/VwXyL7GjTguNOFaQl2n9NqvKTw25eRbTz7
	2zTuku+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39354)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qKEpt-0000NJ-0N;
	Fri, 14 Jul 2023 10:11:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qKEpn-00075h-FW; Fri, 14 Jul 2023 10:11:31 +0100
Date: Fri, 14 Jul 2023 10:11:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 0/3] Remove some unused phylink legacy
Message-ID: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I believe we are now in a position where some of the legacy phylink code
can be removed!

I believe that all DSA drivers do not make use of any pre-March 2020
phylink behaviour - all drivers now seem to set legacy_pre_march2020 to
false, and the conditions that DSA sets it to true are no longer
satisifed by any driver.

Moreover, no one uses the .mac_an_restart() method, so this can also be
removed.

 drivers/net/dsa/b53/b53_common.c       |  6 -----
 drivers/net/dsa/lan9303-core.c         |  6 -----
 drivers/net/dsa/microchip/ksz_common.c |  2 --
 drivers/net/dsa/mt7530.c               |  6 -----
 drivers/net/dsa/mv88e6xxx/chip.c       |  4 ----
 drivers/net/dsa/ocelot/felix.c         |  6 -----
 drivers/net/dsa/qca/qca8k-8xxx.c       |  2 --
 drivers/net/dsa/sja1105/sja1105_main.c |  6 -----
 drivers/net/phy/phylink.c              | 22 ++++++++----------
 include/linux/phylink.h                | 12 ----------
 include/net/dsa.h                      |  3 ---
 net/dsa/port.c                         | 41 ----------------------------------
 12 files changed, 9 insertions(+), 107 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

