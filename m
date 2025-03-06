Return-Path: <netdev+bounces-172476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB5A54EDC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC293AE8EF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DD189916;
	Thu,  6 Mar 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hwdu5oWW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17611158520
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274659; cv=none; b=nTc3OvzmL2a1ZlwtihnLDB9iOxLf9tnl1N5XLkI2Wv/5UYKUESckB0wVN1ht4Wyng1sxxdKvDIL4pNPKC5KfFGu4t0L4eoenW+LCM/BH6fKQT2KjsvhT5rNC9QWO8p6bZysqXmMXoM7p8k0H7H4m/96ZkKoPQeb9MpB9s4WktEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274659; c=relaxed/simple;
	bh=EBcK/6fn5LDbfW/09K727NXz2AWpv//Y8LlFDuLscvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JC3i73CoHNQO69rZcsrhEuNY+6+uEWRVkzRzSqnngtsfzcbQYx2eX3t9CtwuloDn7hs+T/mM3qbehmVqMzBuf+4Ht5J+pZ6dCHQe1VERidFyHbqtQf1ei+D6smDCZDKrILfRT7rspfltFT0GmWj07V1ZYJ3lYjRTSXjt4GRBUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hwdu5oWW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R2zhQ4Pm2jNY/eOab+WCiVsh8dTyvXui2Cp/FvWzXlI=; b=hwdu5oWWDsv1M1nPGXWRtmOoBa
	ZTzMnK3JxL54nbJSZPSc12uQI8Is7OP+DnjUU1HtB1gGdm45wIEF5o5Aj9OZG9GPOdpBkVCZvEIDC
	G9nTJhOKDMtc18p5uq+PficPxFkNowL/jDwSy398f+R7d2rd2x5swVQQjrUaSmUxBSZ/UxTGpk7iw
	P+jM4++UFdAkIX5aympIv4ymay6a9twZ9OWHtxyCctY4Tf4H5igv4M2TJErGD0wXpxZThv1cS2kP4
	Hu758r1IIkdEgRtQ6TxRpxZa8qGQ1pYgbiguJXz3xjyUXpAhmemv5jwWQzvln6vfO1SfDRkmtFaWI
	wgHSgPBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqD4n-00064v-2p;
	Thu, 06 Mar 2025 15:23:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqD4j-0006tm-31;
	Thu, 06 Mar 2025 15:23:53 +0000
Date: Thu, 6 Mar 2025 15:23:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next v2 0/3] net: stmmac: approach 2 to solve EEE LPI
 reset issues
Message-ID: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This is a second approach to solving the STMMAC reset issues caused by
the lack of receive clock from the PHY where the media is in low power
mode with a PHY that supports receive clock-stop.

The first approach centred around only addressing the issue in the
resume path, but it seems to also happen when the platform glue module
is removed and re-inserted (Jon - can you check whether that's also
the case for you please?)

As this is more targetted, I've dropped the patches from this series
which move the call to phylink_resume(), so the link may still come
up too early on resume - but that's something I also intend to fix.

This is experimental - so I value test reports for this change.

As mentioned recently, the reset timeout will only occur if the PHY
receive clock is actually stopped at the moment that stmmac_reset()
is called and remains stopped for the duration of the timeout.
Network activity can wake up the link, causing the PHY to restart
its receive clock and allow reset to complete. So, careful testing
with and without these patches is necessary.

v2: add EXPORT_SYMBOL_GPL(), fix if() statement, add kerneldoc

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ++
 drivers/net/phy/phylink.c                         | 54 ++++++++++++++++++++++-
 include/linux/phylink.h                           |  3 ++
 3 files changed, 59 insertions(+), 1 deletion(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

