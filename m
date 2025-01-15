Return-Path: <netdev+bounces-158636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508DA12CD1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC403A5B03
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8861D7E50;
	Wed, 15 Jan 2025 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yf/i3LX0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A601D6199
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973763; cv=none; b=U/XgIf+r828yf0vDIzFlRa3MN1Tvui+zFW6+EATFDuYlGzad9mATXgHURUyIqU/JrQyNTGclMMXyKEIDNV18o1E6ouKODeVyub8N5wO+bHuhQv99s6AFtBxTSLn+nnPV4G/hFi9OuY7gcBFvQ0BAHti8YFy0X9PRwzAXCTLx1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973763; c=relaxed/simple;
	bh=8nVyPV5oJN2ppauJvDUSm6gZf0eTEUOcvMiU7BMw+04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uZ0Ib75l5HzfSyqWM7UBXChGZtRKA9048AVpqtKdAlFimhu34TcUrDTx2emTmZ2FygFAxqlUOs6hqQCe0fQ+pywF82IhZs1EeHKQLs5VG3UwKr5+1nuySfSxywPkz3SlV4rrFLxKRuH4nEbeSHsSip5zDlrhYsMol35qy7huX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yf/i3LX0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i99JrEwvVL6vZ28JyF12/j0Oq/JzEnb/KviOot0d0XM=; b=Yf/i3LX0LboP0eiOYuh54qyiIB
	0zqiJ5iJEDXjO+ofCI0Axrb+gMWGHL59zLCdnWGKAcqXADAue7Frf1odUnuIcLDzwhusuSOdWoV8X
	LKKXXwPHr26c14wi8jfrgM9zkdNY+pftU2Hy0G5rDqlHOPNQInyDzgHWFHiNkWVNz6NNzAmoO7uvK
	2aDIo3a4Ztx6HX/G5ru1ZsldrYRJAEl++0pYhKoVBxqteiOTcmmDwMqoZZI7DLoTDkN7+9WR2+q9s
	HRHO7LxDY1HdMdXINBLyejEUvawFaPT/c9ae5kI6uPD4tFPz7wAN0TKAd3FqBeNBmd2pPswJ2llnV
	IfSsD1EQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tYADe-0001hw-3D;
	Wed, 15 Jan 2025 20:42:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tYADc-0006UU-1C;
	Wed, 15 Jan 2025 20:42:28 +0000
Date: Wed, 15 Jan 2025 20:42:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 0/9] net: add phylink managed EEE support
Message-ID: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
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

Adding managed EEE support to phylink has been on the cards ever since
the idea in phylib was mooted. This overly large series attempts to do
so. I've included all the patches as it's important to get the driver
patches out there.

Patch 1 adds a definition for the clock stop capable bit in the PCS
MMD status register.

Patch 2 adds a phylib API to query whether the PHY allows the transmit
xMII clock to be stopped while in LPI mode. This capability is for MAC
drivers to save power when LPI is active, to allow them to stop their
transmit clock.

Patch 3 extracts a phylink internal helper for determining whether the
link is up.

Patch 4 adds basic phylink managed EEE support. Two new MAC APIs are
added, to enable and disable LPI. The enable method is passed the LPI
timer setting which it is expected to program into the hardware, and
also a flag ehther the transmit clock should be stopped.

I have taken the decision to make enable_tx_lpi() to return an error
code, but not do much with it other than report it - the intention
being that we can later use it to extend functionality if needed
without reworking loads of drivers.

I have also dropped the validation/limitation of the LPI timer, and
left that in the driver code prior to calling phylink_ethtool_set_eee().

The remainder of the patches convert mvneta, lan743x and stmmac, and
add support for mvneta.

Since yesterday's RFC:
- fixed the mvpp2 GENMASK()
- dropped the DSA patch
- changed how phylink restricts EEE advertisement, and the EEE support
  reported to userspace which fixes a bug.

 drivers/net/ethernet/marvell/mvneta.c             | 107 ++++++++++------
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h        |   5 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c   |  86 +++++++++++++
 drivers/net/ethernet/microchip/lan743x_ethtool.c  |  21 ---
 drivers/net/ethernet/microchip/lan743x_main.c     |  46 ++++++-
 drivers/net/ethernet/microchip/lan743x_main.h     |   1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  57 +++++++--
 drivers/net/phy/phy.c                             |  20 +++
 drivers/net/phy/phylink.c                         | 149 ++++++++++++++++++++--
 include/linux/phy.h                               |   1 +
 include/linux/phylink.h                           |  45 +++++++
 include/uapi/linux/mdio.h                         |   1 +
 12 files changed, 446 insertions(+), 93 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

