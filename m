Return-Path: <netdev+bounces-232036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A831C00484
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AB1A6104B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32783093C1;
	Thu, 23 Oct 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KeHPk39N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40213093C6
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212221; cv=none; b=BGsOl4KANl57kNs11OASD3ILT45610uFlSGq2PC7cb1wjQnIV92Ey7G2jce6WBXZvizzXdBBAdWGFkx8XY5cZ6SI65cZzu4oZ9yfBGjra/YddrzBu6PsJgoeEmGUBxY373gZj86tIJDrMAAVHeG0wSKIKhXPm2O5qm4AuQ/mAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212221; c=relaxed/simple;
	bh=iPCZhzZwGUG/q1kjeSziDlnTwB82n4o0k2qlmg22LxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lrWdATz145djCjUatSCBc/N2TJl6Ht3KGpE7T6/1mH0VItmE7HBwhlpax4k47tHrUrmDRrIucvj8a46N+pukNoY5iG0N7lMp7kUMdWU/lwiw0kSXLeME8HeYpPgpi7+wt1ikqNvdl78/2uiyR/1FROEVR0kXlTPlQ1gplRcVu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KeHPk39N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6DCJK6uJnCbgD2d0vAbxfsTdaOAd3ysv1m0iG7pR4Mk=; b=KeHPk39NCTe+UtVT3YRRER4JIG
	ka52phznonJX4IdnwDithKL2Yl/rPVwsYHzsAZtGL6GKI7ZuzCyxwHq2jitcX5d+iPPGJ1AMEJn35
	/BxDqxz6sJtwIWv04JNnCybhECo4COpAAKGSbTU/7jIB6wu+jV3MchWFjJp4msrImUEeVbxdQNk5E
	q8F7sT0b+yaLmxwQO/7+9qq+7YYQkJqDsc7S2QynYpT8E4CYttP4u6Wg8aJXaUvVsKH1n132K6U55
	7rMXKLVK8/XCkH7f4yChe4z5z2fMGQ1BwPAuf7kNcYeR6QxFydWCi1zrhpUZnSYcBCW3y7GiOwVME
	22pbPQFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBrka-0000000064O-1MLL;
	Thu, 23 Oct 2025 10:36:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBrkX-000000001ZH-3TwL;
	Thu, 23 Oct 2025 10:36:49 +0100
Date: Thu, 23 Oct 2025 10:36:49 +0100
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
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

This series cleans up hwif.c:

- move the reading of the version information out of stmmac_hwif_init()
  into its own function, stmmac_get_version(), storing the result in a
  new struct.

- simplify stmmac_get_version().

- read the version register once, passing it to stmmac_get_id() and
  stmmac_get_dev_id().

- move stmmac_get_id() and stmmac_get_dev_id() into
  stmmac_get_version()

- define version register fields and use FIELD_GET() to decode

- start tackling the big loop in stmmac_hwif_init() - provide a
  function, stmmac_hwif_find(), which looks up the hwif entry, thus
  making a much smaller loop, which improves readability of this code.

- change the use of '^' to '!=' when comparing the dev_id, which is
  what is really meant here.

- reorganise the test after calling stmmac_hwif_init() so that we
  handle the error case in the indented code, and the success case
  with no indent, which is the classical arrangement.

 drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
 2 files changed, 98 insertions(+), 71 deletions(-)
 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

