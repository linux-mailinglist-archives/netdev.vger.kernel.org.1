Return-Path: <netdev+bounces-147596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875869DA78D
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 13:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9A5285CA5
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B51FAC5A;
	Wed, 27 Nov 2024 12:16:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7A1FBCB5
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709787; cv=none; b=PIOsLMktjnubhrHFlFlRa87s0LseYiVsumQIViWs3adrLRa7mXWwn4U8RvKeZ7X2gb3eV8oPe694vzh6qyvvC6n+x/T9oM5e53z8Fq2rNf+SUVW2I88K1Q8Gdu3sLgM0X8i1nYA2+yV2aw8ngWrIX9koHbQOF7dm2DAza/W8hPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709787; c=relaxed/simple;
	bh=fhE42bJ91n8ZQ4lpGemc+mmysh0EBCu2Ha7LnlAz7qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grKzyTaS9S/nJyWkWKQEoQyGnQ/T0bNNdgGrgcqDMHx/hJ+nYGW7fKcKKXHj/QuldFaCJ7uVOPrqWxdmg+xNN7/a5yYY16UlmtK1ywAGllqmfqCaTPgI+u/KmrraTGOauuBP2QovxMtIZ01lMWt/4idoBLERf/Yu+x0IJ7kcJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGGxc-0004FC-Pe; Wed, 27 Nov 2024 13:16:00 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGGxY-000QYm-2q;
	Wed, 27 Nov 2024 13:15:57 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGGxZ-000xja-1h;
	Wed, 27 Nov 2024 13:15:57 +0100
Date: Wed, 27 Nov 2024 13:15:57 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: net: sxgbe: using lpi_timer for Twake timer
Message-ID: <Z0cNfdxInR0XDQaV@pengutronix.de>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

For archive:

static void  sxgbe_set_eee_timer(void __iomem *ioaddr,
				 const int ls, const int tw)
{
	int value = ((tw & 0xffff)) | ((ls & 0x7ff) << 16);

	/* Program the timers in the LPI timer control register:
	 * LS: minimum time (ms) for which the link
	 *  status from PHY should be ok before transmitting
	 *  the LPI pattern.
	 * TW: minimum time (us) for which the core waits
	 *  after it has stopped transmitting the LPI pattern.
	 */
	writel(value, ioaddr + SXGBE_CORE_LPI_TIMER_CTRL);
}

bool sxgbe_eee_init(struct sxgbe_priv_data * const priv)
{
....
	/* MAC core supports the EEE feature. */
	if (priv->hw_cap.eee) {
		/* Check if the PHY supports EEE */
		if (phy_init_eee(ndev->phydev, true))
			return false;

		timer_setup(&priv->eee_ctrl_timer, sxgbe_eee_ctrl_timer, 0);
		priv->eee_ctrl_timer.expires = SXGBE_LPI_TIMER(eee_timer);
		add_timer(&priv->eee_ctrl_timer);

		priv->hw->mac->set_eee_timer(priv->ioaddr,
					     SXGBE_DEFAULT_LPI_TIMER,
					     priv->tx_lpi_timer);
                                                   ^^^^^^^^^^^^
                                                   LPI timer is used for
						   Twake timer.
}

In case user configures lpi_timer value to too low, it will case frame
corruption instead of expected performance drop.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

