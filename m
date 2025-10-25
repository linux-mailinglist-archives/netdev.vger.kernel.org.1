Return-Path: <netdev+bounces-232791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9BC08E5C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F104E2C4C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0612DA755;
	Sat, 25 Oct 2025 09:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECD2D9EE2
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383980; cv=none; b=EK/YdLplwE0F2GvFaF8opsHy0Xvbro2QY6K3Cxjs7/op4HePx/ZC1YcZvCsgrpIwy/ohQMWGPChsGHWrrLPGB3pVbUJw36C8XAKUb081T8DvaNoEj/bZnCTTZYA2hdYF65c9/Nu2nJGbEUAjzroi40lKDWWMbbKHMrOISfjCUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383980; c=relaxed/simple;
	bh=HONwtuD6EIQPd3bdIrsre/LYS82ez4l+wh32OW9JNik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POcKi9FV8Z7ECWCdrIswyehcKw+yAnJbeFoKDQJUE1Pl+nLWFRqvZTrWtSTURgBM2se9LahLZHqlNmq6S+chBNB3qaidpHSfBBDNDBQLZVjPf89qT1H6upifqARVmd4tGGwE3KVtUuCZuzcYnJUEdd3ek7bxxF1B/Ntu/d1nIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vCaQp-0001p1-ES; Sat, 25 Oct 2025 11:19:27 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCaQn-005Mjq-2Z;
	Sat, 25 Oct 2025 11:19:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCaQn-00H0pU-27;
	Sat, 25 Oct 2025 11:19:25 +0200
Date: Sat, 25 Oct 2025 11:19:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <aPyWHRphEYOdk2MG@pengutronix.de>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <aPyN7z8Vk4EiS20b@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPyN7z8Vk4EiS20b@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Oct 25, 2025 at 09:44:31AM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 23, 2025 at 04:48:53PM +0200, Emanuele Ghidoli wrote:
> > While the DP83867 PHYs report EEE capability through their feature
> > registers, the actual hardware does not support EEE (see Links).
> > When the connected MAC enables EEE, it causes link instability and
> > communication failures.
> > 
> > The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
> > Since the introduction of phylink-managed EEE support in the stmmac driver,
> > EEE is now enabled by default, leading to issues on systems using the
> > DP83867 PHY.
> 
> Wasn't it enabled before? See commit 4218647d4556 ("net: stmmac:
> convert to phylink managed EEE support").
> 
> stmmac's mac_link_up() was:
> 
> -       if (phy && priv->dma_cap.eee) {
> -               phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
> -                                            STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
> -               priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
> -               stmmac_eee_init(priv, phy->enable_tx_lpi);
>                 stmmac_set_eee_pls(priv, priv->hw, true);
> -       }
> 
> So, if EEE is enabled in the core synthesis, then EEE will be
> configured depending on what phylib says.
> 
> In stmmac_init_phy(), there was this:
> 
> -               if (priv->dma_cap.eee)
> -                       phy_support_eee(phydev);
> -
>                 ret = phylink_connect_phy(priv->phylink, phydev);
> 
> So phylib was told to enable EEE support on the PHY if the dwmac
> core supports EEE.
> 
> So, from what I can see, converting to phylink managed EEE didn't
> change this. So what really did change?

I suspect it is a change in board designs. iMX8MP EVB variants are using
Realtek PHYs with the SmartEEE variant. Therefore, the MAC is not able
to control LPI behavior. Designs based on the EVB design (with the
Realtek PHY) are not affected. I mean, any bug on the MAC or software
side will stay invisible.

Some new designs with special requirements for TSN, for example
low-latency TI PHYs, are a different story. They promise "Extra low
latency TX < 90ns, RX < 290ns" and also announce EEE support. These two
promises are not compatible with each other anyway, and at the same
time, even if LPI does work, it will most probably fail with the FEC
driver. I do not know about STMMAC.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

