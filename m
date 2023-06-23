Return-Path: <netdev+bounces-13430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8773B9B7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E87D280D73
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F4AD23;
	Fri, 23 Jun 2023 14:16:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE8A926
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:16:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7442135
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=82rInuCvL9xAeabMebQ9Lh4wrm60BVdO9VOZwhsHwtw=; b=QWr4Mnq42Q5VaRp/cAOAzZoOOE
	9ulNjwhn4LJM5YnHEVt7GkdNfeMYYhkcQH95mnd3mZqS8MnPVhehc6JTrnpikd9+hacvu0L8sw9zW
	y+k8F9Tiky73mEFnvckzb8lwLT1pCFshyCOLANjbLOGVJwsXwcBKTA2rNmq5ziJ2rJ5qVmqHEcyfi
	zFQlWUkOF0TRR+x4WUtzxLGduvkvTJiVyO7UK94NNsaRDvFHvxozlkAj57g9/+zjdLiY5SPgZoQ/2
	3aeXHsfhe3G5dnGtFnQ1IA0llfpH7Hb4D/bNZyq3GfyfjOOfz5MxmgA/W+ispFqXXB8GR3EMgZ9k1
	DGAp/lXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51774)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qChZw-0005NS-VQ; Fri, 23 Jun 2023 15:16:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qChZo-0001X0-LF; Fri, 23 Jun 2023 15:15:52 +0100
Date: Fri, 23 Jun 2023 15:15:52 +0100
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
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 00/14] dsa/88e6xxx/phylink changes after the
 next merge window
Message-ID: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
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

This patch series contains the minimum set of patches that I would like
to get in for the following merge window.

The first four patches are laying the groundwork for converting the
mv88e6xxx driver to use phylink PCS support. Patches 5 through 11
perform that conversion.

At that point, DSA becomes entirely phylink-legacy free, since all
drivers either set the "legacy_pre_march2020" boolean false, or use
the legacy adjust_link mechanism and thus don't implement phylink.
That then allows patches 12 and 13 which removes all setting of
legacy_pre_march2020 from DSA, since it becomes no longer relevant.

This leaves the final user of that boolean as mtk_eth_soc, which
makes use of state->speed in its mac_config() method which has
*always* been against the phylink API documentation, and has never
been guaranteed to hold a correct value in this function. Moreover,
I consider this to be broken, because it only configures the RGMII
clock rate based on state->speed when the interface changes from
something non-RGMII to RGMII. So, RGMII is probably rather broken
on the SoCs where this code path is used. I have placed a comment
in mtk_eth_soc about this, I have asked several times on lists and
Cc people about it, but I'm getting nowhere. DTS grepping seems to
indicate that there is no board that the mainline kernel supports
that would even use this code path.

The other issue with mtk_eth_soc's legacy requirement is its
implementation of mtk_mac_pcs_get_state(), and this prevents at
the moment either getting rid of the mac_pcs_get_state() method
from phylink, or marking the driver non-legacy even if we don't
care about the RGMII state->speed issue.

However, with mtk_eth_soc using phylink_pcs, we can at least kill
the old mac_an_restart function, which is what the last patch does.

I am not intending to submit this all as a single series; this is
merely being sent out as a preview for posting the first batch in
maybe three weeks time.

In the mean time, it would be great to have testing, particularly
with a range of different 88e6xxx switches (I only have a limited
subset.) Thanks.

 drivers/net/dsa/b53/b53_common.c       |    6 -
 drivers/net/dsa/mt7530.c               |    6 -
 drivers/net/dsa/mv88e6xxx/Makefile     |    3 +
 drivers/net/dsa/mv88e6xxx/chip.c       |  424 ++----------
 drivers/net/dsa/mv88e6xxx/chip.h       |   33 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c   |  190 ++++++
 drivers/net/dsa/mv88e6xxx/pcs-6352.c   |  390 +++++++++++
 drivers/net/dsa/mv88e6xxx/pcs-639x.c   |  898 ++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.c       |   30 -
 drivers/net/dsa/mv88e6xxx/serdes.c     | 1106 +-------------------------------
 drivers/net/dsa/mv88e6xxx/serdes.h     |  108 +---
 drivers/net/dsa/ocelot/felix.c         |    6 -
 drivers/net/dsa/qca/qca8k-8xxx.c       |    2 -
 drivers/net/dsa/sja1105/sja1105_main.c |    6 -
 drivers/net/phy/mdio_bus.c             |   24 +-
 drivers/net/phy/phylink.c              |  132 +++-
 include/linux/mdio.h                   |   26 +
 include/linux/phylink.h                |   41 +-
 include/net/dsa.h                      |    3 -
 net/dsa/port.c                         |   41 --
 20 files changed, 1742 insertions(+), 1733 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-6185.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-6352.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/pcs-639x.c

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

