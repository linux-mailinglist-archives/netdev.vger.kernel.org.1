Return-Path: <netdev+bounces-164661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B907A2EA4C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14EDD7A4C14
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946561CF5C0;
	Mon, 10 Feb 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NN0+SOSY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F671E1C36
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184798; cv=none; b=lCARm5VUv/c9xoP78T9PxYfVFUI/bgksgOh9qg9kT6Vzgn015xWgj0FTipKJGwNUvlbZf2SnfWsLWoLWmzz8lwa89kancOTA6Ikq76ULHLGoVMVN/wYV2U5qMY1FQUrOaWHU/deo8ARfrS4A8IyaIhVPlN3GIqXzdUf7fic/INk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184798; c=relaxed/simple;
	bh=Yjv/Z0lJwcY0615hdVzQTClZVf4NzGSlh62EGVPwWcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SqGDbwr6WuMfHY+Wf97AT0KKelyXGWgh5XGrt3pStpiBet8Dc05DW6suk6QNZlqOXLsWDCX5R0gpjUQimqCsT9XoUjOcuuY5Y36vw54MmcOORE7ZZGhqXpz56ojHnwcxZd1miZBo8pTGbTpde+nESnDZl0bbPLAm5aSXxtTGgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NN0+SOSY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z34HUMIhzyaBlycKqhDV99x6wJM5d6YY7KL/669ZsG8=; b=NN0+SOSYZV+oT+iWN1rq4IgRz5
	fazaCYica3uF+0pW/+dZNAaU2scIF0g4lJlxOKB8vIwH71MOlPDZo7/Y8zJ8qqgfGSvLJxgaxAcBJ
	0p0aGb7qhP8Bdfek/dMbk3NlJOjgE723jH5klp7J+SdPOIVLfZupQNuQ6lwk5MVDxCyL4cKJIN3GP
	FNlsN4Nrpl9Ryr0ti93eJyBkZoERA7kmpG3roqprXUOLY6cmnrt4QkH0NNqz46hAVXyteN+uTFEpA
	LheIa35smPdvZKrTi6w6us5L/dhfYV2NSFRPnW5n9QmiebzcgeInN/E9PQbEDKnfc3j/B2VZZzedT
	O+PmBN6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thRPP-0006Uy-24;
	Mon, 10 Feb 2025 10:52:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thRPM-0007R3-1h;
	Mon, 10 Feb 2025 10:52:56 +0000
Date: Mon, 10 Feb 2025 10:52:56 +0000
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
Subject: [PATCH net-next 0/8] net: phylink,xpcs,stmmac: support PCS EEE
 configuration
Message-ID: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
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

This series adds support for phylink managed EEE at the PCS level,
allowing xpcs_config_eee() to be removed. Sadly, we still end up with
a XPCS specific function to configure the clock multiplier.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 --
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  2 +
 drivers/net/pcs/pcs-xpcs.c                        | 89 +++++++++++++++--------
 drivers/net/pcs/pcs-xpcs.h                        |  1 +
 drivers/net/phy/phylink.c                         | 25 ++++++-
 include/linux/pcs/pcs-xpcs.h                      |  3 +-
 include/linux/phylink.h                           | 22 ++++++
 7 files changed, 107 insertions(+), 42 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

