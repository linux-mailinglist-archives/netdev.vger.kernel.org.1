Return-Path: <netdev+bounces-159735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C5A16ABB
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB143A39EB
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075011B4237;
	Mon, 20 Jan 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sFCtRfHD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE11B413E
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368960; cv=none; b=Yx2H74a85W+jkZURggG9fXmuIiNIQU2rpd/bK+yLnfN6bDnNibSw7/BUh+EFcUy6jui2frohOSQlQeMSk0nuNrkSeFVJjROB1SoavMU1o9FGyaAahcCv4rPGQQdV8g+nxDo3aVdFmAPTK6Ffrd9U006x33mHIUdI+btXt4acmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368960; c=relaxed/simple;
	bh=HPc6ifRMbYAFiFWkHbzc2PYL9+XpEbLf41GfGKua4Gc=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=KWSVXPJEc4Id76XfK1kTHz/o9K5a0SetL/+5F2RwBnwEIVDjR+S3KhcGp8DZ8ZwoR55f6PCURqoJUA/B6Bbd7v9ZkDdgv4cUpxmSK/8RQmFczuTVlbtuIe2jHjqskWFNl9ZTWfdWtEPgMkxt6WMqFjA9HxBOSBEwQ4O1VwcgfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sFCtRfHD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=04fEvNxUL6Ml4Wfev+Ih4FDU2xJbRJRhT8q4mP4cOZo=; b=sFCtRfHDZDYt7rdsWziZEllqw6
	LFJazTV6YuLNPokuOzTgP842RjiWkD3iUDkHHnsjpPQisSs387znWA46r4zZ5Bqjw2XWfxC3nsGC8
	D6j+RxIcHxgR26txenFWQn+3WlCfzIC23MRFlPSa2cfYNc+vdRa8M3VlKJcY/VdZIKuobbMIfAEDA
	0X8CBxHPQ+WvlMwDlRgqs/Cm08o+RG6981z7KfB4VB/V29FnD/2PBR4blWQJU5DdxUCOEf8MbKUcu
	vr5b+Dqh94PacEzCMRU4hJhEOcvJiRQHmQ9OV/aMMh8zAwoAiynfbIObs+EdHYJiiAZEnPoinWNyD
	DbTyM0Tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45418 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tZp1t-00062A-1R;
	Mon, 20 Jan 2025 10:29:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tZp1a-001V62-DT; Mon, 20 Jan 2025 10:28:54 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylink: fix regression when binding a PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tZp1a-001V62-DT@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 20 Jan 2025 10:28:54 +0000

Some PHYs don't support clause 45 access, and return -EOPNOTSUPP from
phy_modify_mmd(), which causes phylink_bringup_phy() to fail. Prevent
this failure by allowing -EOPNOTSUPP to also mean success.

Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 66eea3f963d3..56d411bb2547 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2268,7 +2268,11 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	/* Explicitly configure whether the PHY is allowed to stop it's
 	 * receive clock.
 	 */
-	return phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
+	ret = phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+
+	return ret;
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
-- 
2.30.2


