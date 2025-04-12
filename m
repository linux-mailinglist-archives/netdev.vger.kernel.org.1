Return-Path: <netdev+bounces-181906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6ACA86D96
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 16:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D5D7B4BDF
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB616139D0A;
	Sat, 12 Apr 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oLiq7EDT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FC1804A
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467445; cv=none; b=DGWHx3fzB4y3Cp5vy4riMGbJCs5zt5jmaQJTXWggtcvmeBdM+9i88uuoh95M2Y4PxBDu8ZF2cZy6vVUvtgN9tL1Sijkf6kDDwLbCO5oRUfGw4n+uXrwS8yLjAuPjw2Ki5udwrfCDqFhYcHr9hbdT1rdIXjexu22gah3l2l/eJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467445; c=relaxed/simple;
	bh=EZKCGa5fX1t/sn4OYoSIu2gMzIrcqFPcEKYd0UQS1qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O2wCkOeUZXLB1FsDYoODEkMH8lbEEAxE08xhmpUvYi86IluCfuzZ8IMLDm/pTFt8enw+DI5ScKQDv5y6NkNpZ0v+fVfVUtgIUm1m70gS4/WQxQQ8ko4av+kwy5Kh7PUxpw0HI0z+rAy2alCwD9zMAd0t6J+2+DiSKZqlfuYxlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oLiq7EDT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OtjDlLbUztiJngJj615sfGvrPHCmRzt+Ij9++qW0iv0=; b=oLiq7EDTmcuh7vV+BKaStrDDI+
	6KczhnhqWmmOl5mf0KDMGjzKiKUtbq6DniZR4ZHsk3imdeKIZ4qyHXQpnJTTr0SxSs3zOrefBVFmH
	1evwFHWCYpVkMaySIeGh+t4E3+h+KSzbQvIdgMLc4f/uE6oMnkJnSSYq2hfXDFXfqzPxqZlxwKZ8B
	8a0YtQjCUzmQIIlZzszOvVt+MfG96xjdGMGOC03CyuUwBeS4AxUXSn4n1goYb+T5Mtryjxn09UE+h
	PQSicZcI2r1ZVR+we6ejQU+YvUn46F2h9yRv/QYbIj2pDhcf7bf5pfdZkIsqxtdPaUz1qMT8PJRPB
	FrR/K1vA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44230)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3bfY-0004bl-34;
	Sat, 12 Apr 2025 15:17:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3bfW-0005jD-2S;
	Sat, 12 Apr 2025 15:17:14 +0100
Date: Sat, 12 Apr 2025 15:17:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] net: stmmac: anarion: cleanups
Message-ID: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

A series of cleanups to the anarion glue driver.

Clean up anarion_config_dt() error handling, printing a human readable
error rather than the numeric errno, and use ERR_CAST().

Using a switch statement with incorrect "fallthrough;" for RGMII vs
non-RGMII is unnecessary when we have phy_interface_mode_is_rgmii().
Convert to use the helper.

Use stmmac_pltfr_probe() rahter than open-coding the call to the
init function (which stmmac_pltfr_probe() will do for us.)

Finally, convert to use devm_stmmac_pltfr_probe() which allows the
removal of the .remove initialiser in the driver structure.

 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    | 25 +++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

