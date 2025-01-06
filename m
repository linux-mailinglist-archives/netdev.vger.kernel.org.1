Return-Path: <netdev+bounces-155416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6163A02491
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546483A3C80
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07461D8DFB;
	Mon,  6 Jan 2025 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BZTwCfG3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD01A76C7
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164318; cv=none; b=iGVOVpLjhADAEW5C4JawoJ49FJcRCyCPIjdJ6nPt8usE39yFCvDDl23NXdPojVhpR9o5bsLhK+4KT4atmvVcT+EImT31vLXBmAn6x1gyRoWg2tvW0Kxpz2Hgf6O1yvMERCesCrqQSKrJgXhNWWV29eHa+XeMz0ly7h4d3c5p31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164318; c=relaxed/simple;
	bh=akvpcnh4PQqqehsWxdyG+fFQB/OT7GrQsbAcTyDY54E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EN3wmNOnyhBQuQyPfnhqxlpaIICyyJ6UAH/thVLIikp7f1UJGYQgZEHIhTpbnDTth0KMZ7BtNpzspXF7QBHPd9TH3b8w+jDQz+sNQkGUbJf9uArLLUbpFTkTF06/ZxYPuZdkKQvn1VOINVQ2nDRekW+V++JKSt3nHhrHo4twdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BZTwCfG3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ukh1qgZ0Pyc6AEGHQTNHG7mtyRNJrHvmAWhwQAtmx+I=; b=BZTwCfG3bkIuyi+CJHakP1R3ns
	hTOmH653YysrU0BwA2ihN6FdnGy9C88m67hLbo0EOuvbP8Kp88Zv2CTfAJdcBkJnGyXGFGMvkh+bk
	+cOJvlNNwQQM8kpvtGTrA0jYHsC2y/yT3TfAcKqGRrKzNSYLqkmytQMW4OkyQ7irrWMA9Qa0JR4t7
	cgyjMQcXdoYqbK8tZ9q2y4nt4/mgoECoFqIYzYJnWtS71NjP/B09cQOpx2Spwq1wZU54xV4p8wrXV
	HkOrYgMN3vcXMb47pb6aUCc/ymUE28abFG3LuyXmobO9y7tYFKkplj+92baoYb4r7uJQZWKvnyH1J
	7rYZpjDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35088)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUldx-0005jL-2L;
	Mon, 06 Jan 2025 11:51:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUldr-0004FT-16;
	Mon, 06 Jan 2025 11:51:31 +0000
Date: Mon, 6 Jan 2025 11:51:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 0/9] net: dsa: cleanup EEE (part 2)
Message-ID: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This is part 2 of the DSA EEE cleanups, removing what has become dead
code as a result of the EEE management phylib now does.

Patch 1 removes the useless setting of tx_lpi parameters in the
ksz driver.

Patch 2 does the same for mt753x.

Patch 3 removes the DSA core code that calls the get_mac_eee() operation.
This needs to be done before removing the implementations because doing
otherwise would cause dsa_user_get_eee() to return -EOPNOTSUPP.

Patches 4..8 remove the trivial get_mac_eee() implementations from DSA
drivers.

Patch 9 finally removes the get_mac_eee() method from struct
dsa_switch_ops.

 drivers/net/dsa/b53/b53_common.c       |  7 -------
 drivers/net/dsa/b53/b53_priv.h         |  1 -
 drivers/net/dsa/bcm_sf2.c              |  1 -
 drivers/net/dsa/microchip/ksz_common.c | 15 ---------------
 drivers/net/dsa/mt7530.c               | 13 -------------
 drivers/net/dsa/mv88e6xxx/chip.c       |  8 --------
 drivers/net/dsa/qca/qca8k-8xxx.c       |  1 -
 drivers/net/dsa/qca/qca8k-common.c     |  7 -------
 drivers/net/dsa/qca/qca8k.h            |  1 -
 include/net/dsa.h                      |  2 --
 net/dsa/user.c                         |  8 --------
 11 files changed, 64 deletions(-)

Changes since RFC:
- Removed removal of phydev check in net/dsa/user.c
- Addition of mt753x changes

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

