Return-Path: <netdev+bounces-180629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4866A81EC4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAE04C00F1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5E25A359;
	Wed,  9 Apr 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P1JDy7Rk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052825A345
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185329; cv=none; b=mAccLGHOewM4jUai+A1DFKGyAZWv3OqbPOr9kpzErgN/1ZPopUWSHKxWJbSAyJRkI4hhpH6HKrmlhvdt8B5gF2f008i/GX8W2PZo6xaFyEuJuObMLpGq+xLuwByPkVO26pAW3EdW6RVp51OWv38rQ/x1R4aIU2lcwv3utL5rHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185329; c=relaxed/simple;
	bh=c7srFhQWaR+LotIvgBxt6hGQP2dyS6n5P8EY0keu6HM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n5zMrZP1Y6SHJCeE+GakwCllgwilBZHeUnoDHltUAq/sbyA0m4aK0ybU4IjAZweDbcoqoPFvXyXA+exb6YNPhqOOR5/2xUKbPOgWPtkKGVpDnJK4BeW8zh3DNkdbV2eHjUCMGHf1B5jmYMSvzlYxIH82S3kRzFaPWFiLdpah1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P1JDy7Rk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SA9itoop5/iE+EV485U+CxtHTM5vwihGMgl1JfL4Y4I=; b=P1JDy7Rk3VtfoV87GrOfn1dMGQ
	5Fg6mfT2AiCpxry/D/z1aSrcZqje31h1/30kNqiH/9HbejMnltbmk5f1KWv6QWyhISLdEXh9SV6Qt
	htQh5eFnmpxJzDgdXC5LfYPuRfr+HgvOZhaa6i3znXLe6jVbPiKArVSwcA5N0n+3OZnmgcEs9a3Jf
	RIlUb/cWusokx3LzLJJQWa30lX/WXyVEoXACO9X8WNzkyHayh50DrLQrPDrQtdJFYEuKWn7QzplR0
	dKREbAlNar+u07ntgYK2yngeTcA9wSNuZEIqpMAzQhnnShHfBMLlMEI2fCmAD+kYWIDGcdrhHvEGp
	+t8cOvpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48580)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2QHB-0000Bi-2z;
	Wed, 09 Apr 2025 08:55:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2QH7-0002OH-12;
	Wed, 09 Apr 2025 08:55:09 +0100
Date: Wed, 9 Apr 2025 08:55:09 +0100
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 0/2] net: stmmac: stmmac_pltfr_find_clk()
Message-ID: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
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

The GBETH glue driver that is being proposed duplicates the clock
finding from the bulk clock data in the stmmac platform data structure.
iLet's provide a generic implementation that glue drivers can use, and
convert dwc-qos-eth to use it.

 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 18 ++------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h   |  3 +++
 3 files changed, 18 insertions(+), 14 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

