Return-Path: <netdev+bounces-187229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA1AA5DEB
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E059C5AFE
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7301EEA27;
	Thu,  1 May 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hK1Y1QeC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B711187
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746099940; cv=none; b=lr+1CvvVyfSbaxhWUv10k13jsr6b5cvj47upQdYfnHkG23L9M5jm6jC2dBhgWgrR1Eq2G4ncbsBsSuj/aBM16jWw/+kcYxLOYnyPaMVFEXmfzjqLwsoariKIiI8zgLbY/YdjgYUICgDGU6EnKNzLdAuOU8RTawGBGyPQLa5EZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746099940; c=relaxed/simple;
	bh=dm7CcYliIrZ1Rv24/VFqKvDva4teFzCN3hxqeMmtFiw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tvTry71P8SsL2j+iea503Sbf3AT7FTbv/t28BzEOO/3GlNAdntLY5i35dDeKoIXpxzC/E+aq1BByPIzAu43bBDnilWLb67KaXnSE/dVjNkHonyAB5EbPH418fHwG/tZaRLsD+8+9OQzuH/f95GBNT8H3DH5muw/6ZRZeK0X0D9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hK1Y1QeC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jk5Z4QPc9J8CRieYaOp+Msl4krhLC3Zgsoyy7SV1l8k=; b=hK1Y1QeCPApCKnF+ianQWZIXEC
	IHN3gx2RJrK2jKbMQ+4C+nZBiIoR/TszssSm6C0daW1H/8pZjRYR+/4n46MDB3CpWtkr02lXmEJe+
	C80HUytlH6LHmdjrMhtqNsNSAOWARB0rjVygCjLDJPcXxtcyP9TzMN/HkK7jHGp6AclCHlbgv8xHv
	kfR7bIskJRsM1sVLxGc52m1FnpHT3yvVmc5E4ii314vcbHWbP08ogWVJHEGA+6oVUWTBs0Z+23jfk
	OWnvEBtJMMKIajNtFCqtZU/l0ojlUPX1FWHsM2mW+wO69MrCLXhcHl/dswyqlxJLbTnqYukZZjcmr
	l3Fb5Tug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58470)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uASM1-0008WA-25;
	Thu, 01 May 2025 12:45:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uASLx-000865-3B;
	Thu, 01 May 2025 12:45:22 +0100
Date: Thu, 1 May 2025 12:45:21 +0100
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
Subject: [PATCH net-next 0/6] net: stmmac: replace speed_mode_2500() method
Message-ID: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
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

This series replaces the speed_mode_2500() method with a new method
that is more flexible, allowing the platform glue driver to populate
phylink's supported_interfaces and set the PHY-side interface mode.

The only user of this method is currently dwmac-intel, which we
update to use this new method.

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 33 +++++++------
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 56 +++++++++++++----------
 include/linux/stmmac.h                            |  3 +-
 4 files changed, 49 insertions(+), 44 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

