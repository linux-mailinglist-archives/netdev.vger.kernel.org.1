Return-Path: <netdev+bounces-181876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4DA86BC4
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AF116BB96
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AEB1990BA;
	Sat, 12 Apr 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wuFfUaBq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A919ABC3
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445153; cv=none; b=mSpFrGIhPeI/Svir97PpHwQ1LDvvOy2T6bJRRtDp0v1zoJMPfn1fs9KoITh1OrsKa0Obg9ZUGyXuorpyRxFEVoLygeci9EME+waqTgfanjs6GrNQrTUFVptLHkBQBCfFgwz5tqEvA4VxbTZqwDeTMlBR4pThK7ar3tnNxOK3aFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445153; c=relaxed/simple;
	bh=a/yDwIg9ovdt3K9s0TI2hDoeoJl2eOR6Di9Lqq7lzmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e3wze/rrrwmhNxl6RxFbsZujOfmihFKKpF0yeN9CErxV3ysswYcn7C0/iXPegEdCVNBlH+xwmaLezESc69NYwOiHf1+t0IamovgWRWWUM4DINllw3mnyEmT4zcNF9Qxah6Ru5ndvKoh7u20OTJKA652UEjVUFqBUY1CLg6SL0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wuFfUaBq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UHYHoHYB3kC5RVvuD/SFjezcUsEDtCLBmv9TeE4pFp8=; b=wuFfUaBq04t6k0J4ocBtzQaUo1
	/e1YBvGDsfOIgmtsvhQ8J94oQXM7aQbfVQ8z+Cd9BeDq5Q4c+FOOzEGYwQD2LOmj6wJq8QLcU8aLQ
	7yoMeW9SMZZnRqS9PY5FQIDzrxVRNbBGZV9MYBiFY2BmTddur76PVk27cBRE13a8QKe9hmf6Fb5k3
	fviD/akVGnAYlTgYKhBuCJOqSNQh9nMEPEoYuKuInV0pE1W27QaMUS5uwaaLe8qdram+JodPp/4eI
	OEpSoxjF/U49q/u25tE2lgYZc1p4xNrcqBXnw0Y2oe4AS9PRpLK7OZ3SON7Mcy3ucWUUZAbYOdzdI
	BkZ3KCLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55788)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3Vrx-0004LU-2T;
	Sat, 12 Apr 2025 09:05:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3Vru-0005V8-06;
	Sat, 12 Apr 2025 09:05:38 +0100
Date: Sat, 12 Apr 2025 09:05:37 +0100
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
Subject: [PATCH net-next v2 0/5] =?iso-8859-1?Q?net?=
 =?iso-8859-1?Q?=3A_stmmac=3A_remove_unnecessary_initialisation_of_1=B5?=
 =?iso-8859-1?Q?s?= TIC counter
Message-ID: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
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

