Return-Path: <netdev+bounces-182083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C877A87B6F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB36D3A2B7B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81BA2580DD;
	Mon, 14 Apr 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kgb3xxE+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05B25A2DE
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621574; cv=none; b=c978luxQafj4z1l5wWC5vxpuo4iwBXgigZP3GCjrx+KznxWZuSj1nE48e7fgOF8rter+vvFSdJRqh/xMUJAkXSHn/prMstNPuqPujXYCRIgAgPB02uwZW8/cTLjlSl65hwPaKGuRaltlHOg6jKonKiwE7Tq6GZ7QHqU5fRe+JBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621574; c=relaxed/simple;
	bh=Q3fsHT+DJ5ypFErijp7VmxB91Vyz0k4CULXXQ3IXaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aJKFNgO+cLsYJ+2uC1fTB05AlZ3cf+tt5wkr5VVT//AMu5Kjrpm/+2PqufGyen0fFDTSfV5jSaPrGIvrRte+nqTU2sVKQlL6TfcFlLTGv4FHPymiyI/8R54fcSW6L3v2yfZJf+R/Fd71k5+qTnsjkYO6n1rqel+0bLJIPNczRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kgb3xxE+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gnja6srub3n8tJYS03csOlPaZZrQF5QqUXIS5NZAuvw=; b=Kgb3xxE+36KP1bFTLvCdZqc0HL
	e/Fh3IlAjOp4ZAvzc4UcuLthtIZD34391hP9VimUS8hvGE+b3sKLTkM2RJhz2ICgBX2q/L3W2N8PU
	tK23bjbOibkojsSFIa9MszfDB3ZqiVdtK5IetR771Sb9pCDCnCzMZ/cLZV7Yi7A5i5iefVyOMj6y0
	xLUXAV3hdJFU+iXPVjzBmlESzekW1wK6ZlrGTDjPBvL7IjmK2yfljrSDtaRHX2j43UO6l13L1SM+4
	i+Z6Aby5Njc4n79Je8xr+hSKWDIAiJDOUBWqyWFah6Syxj5YpL7SjxZ+Wgt92r7IPxQ2USKmRZg23
	LAP1tBMA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58320)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4FlQ-0006CB-22;
	Mon, 14 Apr 2025 10:06:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4FlM-0007cR-16;
	Mon, 14 Apr 2025 10:05:56 +0100
Date: Mon, 14 Apr 2025 10:05:56 +0100
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
Subject: [PATCH v2 net-next 0/4] net: stmmac: anarion: cleanups
Message-ID: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

A series of cleanups to the anarion glue driver.

Clean up anarion_config_dt() error handling, printing a human readable
error rather than the numeric errno, and use ERR_CAST().

Using a switch statement with incorrect "fallthrough;" for RGMII vs
non-RGMII is unnecessary when we have phy_interface_mode_is_rgmii().
Convert to use the helper.

Use stmmac_pltfr_probe() rahter than open-coding the call to the
init function (which stmmac_pltfr_probe() will do for us.)

Finally, convert to use devm_stmmac_pltfr_probe() which allows the
removal of the .remove initialiser in the driver structure.

Not tested on hardware.

v2: fix build error, add Andrew's r-bs.

 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    | 25 +++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

