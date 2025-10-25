Return-Path: <netdev+bounces-232936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD8C09FD2
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 466AD34BE7F
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C873244665;
	Sat, 25 Oct 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0apOYUXW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE422A7F2
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425275; cv=none; b=glWiL5tu2Xk+7F48DolrFMuH/w7BJ9lNToT0mxn4Vvq7TMfpmOiAV7vOkIo9AX9mRSOaU7DWovaC2sCZMSP6BZ/Ok92iYGx+NJ5tD/Ze8WAMMUCrDggch3qB6oE6AgPOty4EXdSzL7Am+lDNxExWaI/qXOl29A4azFCGy8vN4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425275; c=relaxed/simple;
	bh=IOOwqNOR52G2lVC5bhJSetwFoqVJupJyKv0dVYaQWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=husuTGYixQ6j7I05CnKDycKV14cdNsNI2KMvs7Cs1VI5cLv90Y8RhTxYiPRwb7B2+X0/wz714hCDWOvw4Bp6JocnsHsQUqsTty/sjnuqfWdyOqksWdd0ibgPIfWiy2dyUnEHjDrUdurNZwCPTAFM8p+Uj32XaF6avFx/vMctlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0apOYUXW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ayxxfxIY5fsLtWo41Y9SbHVbcp1WanXcGUkI0uNNLcQ=; b=0apOYUXWT+GcUfjPhxLn23kONS
	tYzlIo+tgSeVtWo7DzYXnkiwsx8hDfZh0nusT3aysO3Bu0EOMb2U6x3UTh6zWWqmIa1wuvzxkxcnM
	1pEdFosUEW8iTzFxAuUgD0aatIYQ/IeihGd/32MKps42vq2ChgFC3H8XZmUVXaL+o4RN2ug2kOJmr
	OKY9NEltosxKWy32affrOOxpR3z9i65orpwhsn6fH7NsQ9Dour2N3V5lwiRjzMl3oLF8nIlJ7JWs9
	IYMI6tUDjzTohb1KFUGP1bNNTVhtjEtxKi9rgHhBoKKWuiAVlDAEfukgZZHAULkuOfTjUd8mZSCya
	OWDYZjZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41266)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vClAq-000000000PG-2Hyf;
	Sat, 25 Oct 2025 21:47:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vClAn-0000000040y-1mZl;
	Sat, 25 Oct 2025 21:47:37 +0100
Date: Sat, 25 Oct 2025 21:47:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
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

This series is currently the last of the phylink PCS conversion for
stmmac. This series contains changes that will cause potential breakage,
so I suggest to netdev maintainers that it is only applied if there is
a significant response from testers using the PCS.

Paritcularly, dwmac-qcom-ethqos.c users need to test this, since this
platform glue driver manipulates the PCS state. Patch 2 is designed to
print a warning to the kernel log if this glue driver calls
stmmac_pcs_ctrl_ane() to set the AN state differently to how phylink
has set it. If this happens, we need to do some pre-work to prevent
these prints.

 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  7 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  7 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 29 +++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  8 +++++-
 4 files changed, 44 insertions(+), 7 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

