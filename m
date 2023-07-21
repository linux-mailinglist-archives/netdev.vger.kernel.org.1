Return-Path: <netdev+bounces-19799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000E75C5EB
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099022821F6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0861D2F7;
	Fri, 21 Jul 2023 11:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71D14F87
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:34:19 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8962D4D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iItSOdqqfSgaHaVttPNHC8a08UlOwZdEhpHuVWdhpGE=; b=0RXfcyA8km5soyBIeESvbsuQbU
	8Ug+GTC9bUzujdfG/M19pdrz94nRjBagXuQqpl+yBW4/L9YGyJKPzBG97jTARieRmq9hIZdonzrpb
	/HkUOHtfwlDgOK07F1qGCusEAVmCu1V3IZwsMHJZZdIx85aGwuJk+TcFTQGtTdT7XCp2vlzM4W4c3
	WAJhhjokbAfr+lVzcNk41jxy3YBI22O2CWG4rJmvTZzGj4y8tQx6BB3vLhbWkLdTMzht4KSVXb7wk
	K3l1AjxAbZdl2Wh/Y2VGzNdQDON01kY8+e+pW4HyswSxYhcvmz/1H5DHCxojGTf7INnJNLmD1F+q7
	WpcvwrXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39288)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qMoOT-0003nN-2d;
	Fri, 21 Jul 2023 12:33:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qMoOO-00065a-4i; Fri, 21 Jul 2023 12:33:52 +0100
Date: Fri, 21 Jul 2023 12:33:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	DanielGolle <daniel@makrotopia.org>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>,
	Jakub Kicinski <kuba@kernel.org>, John Crispin <john@phrozen.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 0/4] Remove legacy phylink behaviour
Message-ID: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
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

This series removes the - as far as I can tell - unreachable code in
mtk_eth_soc that relies upon legacy phylink behaviour, and then removes
the support in phylink for this legacy behaviour.

Patch 1 removes the clocking configuration from mtk_eth_soc for non-
TRGMII, non-serdes based interface modes, and disables those interface
modes prior to phylink configuration.

Patch 2 removes the mac_pcs_get_state() method from mtk_eth_soc which
I believe is also not used - mtk_eth_soc appears not to be used with
SFPs (which would use a kind of in-band mode) nor does any DT appear
to specify in-band mode for any non-serdes based interface mode.

With both of those dealt with, the kernel is now free of any driver
relying on the phylink legacy mode. Therefore, patch 3 removes support
for this.

Finally, with the advent of a new driver being submitted today that
makes use of state->speed in the mac_config() path, patch 4 ensures that
any phylink_link_state member that should not be used in mac_config is
either cleared or set to an invalid value.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 94 +++++------------------------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  1 +
 drivers/net/phy/phylink.c                   | 48 ++++++---------
 include/linux/phylink.h                     | 45 ++------------
 4 files changed, 42 insertions(+), 146 deletions(-)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

