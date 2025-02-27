Return-Path: <netdev+bounces-170306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C409A481E0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E610B42018C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1F2356CA;
	Thu, 27 Feb 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w/peQvAv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF62376E4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667074; cv=none; b=Q8I1GQrUWTC8+D+dyI9pQioe5ocT+wp6cxPuCxre8HOChH2NQOC2GQQOsH6KIzqs+DT2pjMQl+y6TfXhRAh18wNqaNCwYYVl2AXpmDBNAB+G2ICNbTASVmhTvA9/0br8H7vtmTfIpSkiuGO5RrIsVPWkRzjoZW0DZDpqsH7OvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667074; c=relaxed/simple;
	bh=/UFf2uPyjZR0mel0cgHaEKtpPwtIyrWfIHMBjVt1BLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xl/oHTZAhFFCT1it3xho3gBiF621iEZee3Kvp4qGwX1bf3I9RKlVepDUhYu9t/WsR6wE/f3V9khxr6Fm/NezWSKBQNVUzp84pl0X0kWmZZ5eDU8XUFWV/Ib+xf515QauOzEKVKJRyUPJLpTj6jTEPEjo2KMWVJjpUDOQQ8lRK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w/peQvAv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oiwYDnalcOWLxT6B/Bkzq59HPzR1dq0zPgE4ezlSWq4=; b=w/peQvAvOuCnZFaTMw3cbppWQA
	FovXewpHGfzdvCoXoW23WG2/mbsbKhl3ZC29qTW6Qk+26lwPDeiLaUhd7gqftdl5vTgCKi1LjksAY
	s2gTPyC9hZwrA+BxvoUfSIkdi2VeSYrrU3vR35NLYufhkDXmDZqLucSWCRyNO9CSQwuD3dDp7l8ll
	TWpcrNP+GYhV9Psn4lrP8x+G3Ld4qEB45GRYRhMzGMXe6oXvHn8+AYbuK1RZewXFgUwwycAyTryHJ
	abhygfIMfsyUGC4Wn3sfJxoGBPBMY2QU2hvsxgXkS81wqxdSuwizuuYj0+zuzoKtqAePiJcIrrfGY
	6ryq0f3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnf1D-0007Ps-29;
	Thu, 27 Feb 2025 14:37:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnf1B-0008Cn-2M;
	Thu, 27 Feb 2025 14:37:41 +0000
Date: Thu, 27 Feb 2025 14:37:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC 0/5] net: stmmac: fix resume failures due to RX clock
Message-ID: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
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

This series is likely dependent on the "net: stmmac: cleanup transmit
clock setting" series which was submitted earlier today.

stmmac has a long history of failing to resume due to lack of receive
clock. NVidia have reported that as a result of the EEE changes, they
see a greater chance of resume failure with those patches applied than
before.

The issue is that the DesignWare core requires that the receive clock
is running in order to complete software reset, which causes
stmmac_reset() and stmmac_hw_setup() to fail.

There are several things that are wrong:

1. Calling phylink_start() early can result in a call to mac_link_up()
   which will set TE and RE bits before stmmac_hw_setup() has been
   called. This is evident in the debug logs that NVidia sent while
   debugging the problem.

   This is something I have pointed out in the past, but ithas been
   claimed to be necessary to do things this way to have the PHY
   receive clock running. Enabling RE before DMA is setup is against
   the DesignWare databook documentation.

2. Enabling LPI clock-stop at the PHY (as the driver has done prior
   to my patch set) allows the PHY to stop its receive clock when the
   link enters low-power mode. This means the completion of reset is
   dependent on the current EEE state, which is indeterminable, but
   is likely to be in low power mode on resume.

We solve (1) by moving the call to phylink_resume() later. This patch
on its own probably causes regressions as it may make it more likely
that the link will be in low power state, or maybe the PHY driver does
not respect the PHY_F_RXC_ALWAYS_ON flag - this needs to be tested on
as many different hardware setups that use this driver as possible,
and any issues addressed *without* moving phylink_resume() back.
If we need some way to resume the PHY early, then we need to work out
some way to do that with phylib without calling phy_start() early.

(2) is fixed by introducing phylink_prepare_resume(), which will
disable receive clock-stop in LPI mode at the PHY, and we will restore
the clock-stop setting in phylink_resume(). It is possible that this
solves some of the reason for the early placement of phylink_resume().

phylink_prepare_resume() also provides a convenient site should (1)
need further work.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 27 +++++++--------
 drivers/net/phy/phylink.c                         | 40 ++++++++++++++++++++++-
 include/linux/phylink.h                           |  1 +
 3 files changed, 51 insertions(+), 17 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

