Return-Path: <netdev+bounces-179868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC80A7ECB3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE84F443E20
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53792221569;
	Mon,  7 Apr 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X4ecTE21"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA452192FB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052298; cv=none; b=E6pOBlRJMXvsmnenIT0La6P1U/Kqe/7T9BfNBFrH20+cJflcSl0mCS3HZQim4vaVCru7U6d07GivnqI1/cXf0U6i9ThsrDEOhQ6YsQHuJYXHc3ZQm6txbAqUxVqyiha2Srm0g+C5oVBYPTGO/pBiIdEOGCvczxB8qoPGt/lJPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052298; c=relaxed/simple;
	bh=a/yDwIg9ovdt3K9s0TI2hDoeoJl2eOR6Di9Lqq7lzmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BMCvT1KoZDgKXSomQuL3ICbsCq6/kiNUmpj5WlpPp2djSsEtWzpkws7LHzz6r63ws3O826sRj3SbxrhJK/jJrfnCdornmUb+bijWQ+yU5h5AE1y0RibJHAU8EhlKDkFPihCkrpEOfl8xPuP6TCdvDRYYjXNVxDvKhwkUjqzTqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X4ecTE21; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UHYHoHYB3kC5RVvuD/SFjezcUsEDtCLBmv9TeE4pFp8=; b=X4ecTE21p9ByMpioxjJEw+5EpZ
	HXExeUz3BDYo5EPeSvpPo9pYmJ2T3f1nqrA1Jk+T9BTqqqFDL7+bSc5+iiRhYWbew4/M44WuVjiRn
	GCJnSra3zykY7rZ/14ni1YdmXb4FsOwQCPWTfmQ3j1LRI2MO6XhqicXkqryJKyRg+9Te3bTp3s3Xi
	WBcXZdMZZkvbS8Rd5/Vn7f74VtctylSz5VGJcU+PB5P7HUJB+Hw7+mbGVsYp7Gfs2WryKuR5/oqCG
	E76qeYLK2wG22HYfySSqBjKRd5FGmf7DDmqGCj1Rd6jUGnpkMQKpayz31wKF8bxkcXdjtCaD7LzKc
	vMZkOWlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35552)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u1rfZ-00064B-0a;
	Mon, 07 Apr 2025 19:58:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u1rfV-0000dH-2H;
	Mon, 07 Apr 2025 19:58:01 +0100
Date: Mon, 7 Apr 2025 19:58:01 +0100
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 0/5] net: =?iso-8859-1?Q?s?=
 =?iso-8859-1?Q?tmmac=3A_remove_unnecessary_initialisation_of_1=B5?=
 =?iso-8859-1?Q?s?= TIC counter
Message-ID: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
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

In commit 8efbdbfa9938 ("net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER
register"), code to initialise the LPI 1us counter in dwmac4's
initialisation was added, making the initialisation in glue drivers
unnecessary. This series cleans up the now redundant initialisation.

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 24 +---------------------
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |  9 --------
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |  8 --------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  1 -
 include/linux/stmmac.h                             |  1 -
 5 files changed, 1 insertion(+), 42 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

