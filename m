Return-Path: <netdev+bounces-36521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366C7B03A9
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C2E512829F6
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1628691;
	Wed, 27 Sep 2023 12:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15F266DF
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:14:16 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60D513A
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ule30H4ne7GbYXZKo+WbKjrzor6H5Pa/Yz/nAE86P2s=; b=Wr3B9nyR6QmLXW8k0ksxGfnWLb
	wVgPLQxS6DmZULfQcpm1XwOR2lRqr+4XTMpMDhgnLqjmEOhWYOvR/munGREimjoPweeach0zL6xtx
	Y5fVzerPlAtqeIjEqvunAoj+Rqf4nrzl/8GXt/N+rFk7pG1k+x2rTvF+Yz4zKuS/oVRqXL3u57OuN
	Au4Iv/+DEYspIlRalH1FfdJlASPHsoT85jYPAsdJa5A1BdR4OaRgPDMBzWwyoB8Gga834chM4NFUk
	5B4hvmjzLuryI8ubH+5AOfaqgEkglOTdA5TxOTKgThO0K0LadcIbp03loxqXYU0MZNtkKEhXqB2IF
	hPSZfNXw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44226 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qlTQS-0003rn-08;
	Wed, 27 Sep 2023 13:13:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qlTQS-008BWe-Va; Wed, 27 Sep 2023 13:13:57 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: dsa: mt753x: remove
 mt753x_phylink_pcs_link_up()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 27 Sep 2023 13:13:56 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the mt753x_phylink_pcs_link_up() function for two reasons:

1) priv->pcs[i].pcs.neg_mode is set true, meaning it doesn't take a
   MLO_AN_FIXED anymore, but one of PHYLINK_PCS_NEG_*. However, this
   is inconsequential due to...
2) priv->pcs[port].pcs.ops is always initialised to point at
   mt7530_pcs_ops, which does not have a pcs_link_up() member.

So, let's remove mt753x_phylink_pcs_link_up() entirely.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mt7530.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 035a34b50f31..0d62c69dfbb6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2824,15 +2824,6 @@ static void mt753x_phylink_mac_link_down(struct dsa_switch *ds, int port,
 	mt7530_clear(priv, MT7530_PMCR_P(port), PMCR_LINK_SETTINGS_MASK);
 }
 
-static void mt753x_phylink_pcs_link_up(struct phylink_pcs *pcs,
-				       unsigned int mode,
-				       phy_interface_t interface,
-				       int speed, int duplex)
-{
-	if (pcs->ops->pcs_link_up)
-		pcs->ops->pcs_link_up(pcs, mode, interface, speed, duplex);
-}
-
 static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 				       unsigned int mode,
 				       phy_interface_t interface,
@@ -2921,8 +2912,6 @@ mt7531_cpu_port_config(struct dsa_switch *ds, int port)
 		return ret;
 	mt7530_write(priv, MT7530_PMCR_P(port),
 		     PMCR_CPU_PORT_SETTING(priv->id));
-	mt753x_phylink_pcs_link_up(&priv->pcs[port].pcs, MLO_AN_FIXED,
-				   interface, speed, DUPLEX_FULL);
 	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED, interface, NULL,
 				   speed, DUPLEX_FULL, true, true);
 
-- 
2.30.2


