Return-Path: <netdev+bounces-204889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0668AFC6A3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F151F563F34
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4F2C08AC;
	Tue,  8 Jul 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dSCtaprT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA321771B;
	Tue,  8 Jul 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965429; cv=none; b=B9ongL6vKpc0c0RbewZDCIP1Wqp57ojOSMkM2qQyWrcOD0yKUKhRjRrUeshglGney1mfiVQTINywwz8aqKIsuIF+ZHIcwqvB51X/Ui4EHHu73DgycUvUM9v48MqjDns+c8M74FXlSiQ2VQG3VbFG3VSle697m9sBkuch8JWpD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965429; c=relaxed/simple;
	bh=p+GiKNZEBjzwpW+24vs2OU5pct4CwH8dO9pwT1J4sxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv1+BkywHszoVlSwyUjPu7xdtaExCHUH7LHHX0hLPUIaMTCRupyiNh7mri7YxyeLZciDKlbXDtgvuCJzms0nNTAb3KVR1k71GXOR80lJYKEd4xMUbJS8YHxCC6I5DfoyIbgalMZIu84PSAHc6ipZmK+DKGF76gAB+ye9Gv+xv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dSCtaprT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h+bWulu03KvFIGJmJBpyzA89Qr4HtoUlW6fYCdRBZow=; b=dSCtaprTc7WU1iUPHnQifBdu0E
	BafsQAVvLIfXzFS7Sqw0KiWoaukmHObyWgf4G6pWv6M4fjUP515+srl0ocfkEWJXznYHyZ+c5lkVq
	yxC009IiQGgLmZ6suwwE7/VBXetj3wKZJJ3I/gM9LGhMpc71NM40w8NJmt4ifQSy9QIQBuCCqhVPc
	CzftoIv7pX7gz0LTtF+Q+GPGl6cVyQK+UtbZWh7KQRmBq0P2LIuCm0Afg4v9dFTpbcAVAI0i2Atcv
	FSJF3kcx+LyVN+fzqN1ty4sZ6SjNoLFibyWo/BUPn8Q+kfiH4SsxFbdjhk/EL43cyN5zZJsfkWF2S
	GthD4zBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54124)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZ4Ef-0006KQ-1m;
	Tue, 08 Jul 2025 10:03:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZ4EZ-0001Ub-2X;
	Tue, 08 Jul 2025 10:03:27 +0100
Date: Tue, 8 Jul 2025 10:03:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 1/4] net: phy: MII-Lite PHY interface mode
Message-ID: <aGze3wgnHBcboFfq@shell.armlinux.org.uk>
References: <20250708090140.61355-1-kamilh@axis.com>
 <20250708090140.61355-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708090140.61355-2-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 08, 2025 at 11:01:37AM +0200, Kamil Horák - 2N wrote:
> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
> 
> Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

