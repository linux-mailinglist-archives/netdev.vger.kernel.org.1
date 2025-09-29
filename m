Return-Path: <netdev+bounces-227099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86521BA8480
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7B33A8D45
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6702C08C8;
	Mon, 29 Sep 2025 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PvKEk3aw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E12C0287
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131856; cv=none; b=Ypx0Rl5EeIVSyXUxB731DvkY0LzF2iH/QqDLiPJyB1NaaWw2aoJBa8UY69oanNXrR4PaSbhPx8im1dCGS6aocE3w7/8qHiAUVVRGEE1L0yxiDWUKizMc4fljfIPTlWQXXCgvv+PciD6ytG5D9ZZ7pZ0igc9VluA2pOSg5P2Js2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131856; c=relaxed/simple;
	bh=UO5a/mgA//lW4Bj0rdNV2tU7VgeDI3Ae/7NdugpEQIg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=co1jXgIY2dpvY1wFVRgmZ01IO3534AieNl7fkSlHYIEusHuTTq6rEDwfAQjKT8icAx6iIJLmcUbbNP3G/Xp5A9jx3RtI8zrSak+9Rm0gLMWngCQjM2wckE+XAjf5l95QdyIqiaQQrDYx+LEZQVFO6LF2F+yjUQ+LwPWdP5C6xVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PvKEk3aw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AZ7xCl2wQqwqFo37e1wZWKGTGABfy99i1vqF6wtYlaY=; b=PvKEk3awO1om3h6K37Kd+aGVTP
	3iH+zwB8JaNnXrRJKI5aFojaxxzNwuDmpEqKWgXPpGymWoLYxDbwvLw8lcujRbLN/+Bh0DyvDV+WA
	tIIuIKzguIB76P7Arlqz+cjxipozoPL/s37GvxgzOeu2bME+KzXPtrpfWustiAknfkSm3ZRVp+Y8x
	QVKh16WjpClYRLRwuUxcLF1N+VPKEgsXtM+U1CPAZos7pLV21Eml+NnF4f5HO3cHtQwgsS2GXd69P
	EQsj31cl9lzbLFr+k8gApPoPe1Rryr/sxrY6uLeQ+q4ww25s3y/4rd017e470tvbFI4b/T1N9rGJ+
	7jRUoHeg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51940 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v38Y8-000000006KV-2uOd;
	Mon, 29 Sep 2025 08:43:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v38Y7-00000008UCQ-3w27;
	Mon, 29 Sep 2025 08:43:55 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Furong Xu <0x1207@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next] net: stmmac: remove stmmac_hw_setup() excess
 documentation parameter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v38Y7-00000008UCQ-3w27@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 29 Sep 2025 08:43:55 +0100

The kernel build bot reports:

Warning: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3438 Excess function parameter 'ptp_register' description in 'stmmac_hw_setup'

Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 98d8ea566b85 ("net: stmmac: move timestamping/ptp init to stmmac_hw_setup() caller")
Closes: https://lore.kernel.org/oe-kbuild-all/202509290927.svDd6xuw-lkp@intel.com/
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index be064f240895..650d75b73e0b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3400,7 +3400,6 @@ static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
 /**
  * stmmac_hw_setup - setup mac in a usable state.
  *  @dev : pointer to the device structure.
- *  @ptp_register: register PTP if set
  *  Description:
  *  this is the main function to setup the HW in a usable state because the
  *  dma engine is reset, the core registers are configured (e.g. AXI,
-- 
2.47.3


