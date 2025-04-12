Return-Path: <netdev+bounces-181880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17919A86BCF
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E753A4648C1
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F419ABDE;
	Sat, 12 Apr 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tyWewPOv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156819ABC3
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445373; cv=none; b=Cb5jRWR+kwVTR+s/6/xxIa/wtkoYhHR1Uz4FdblZTvQg9UyjaF7TjhlrWvVGrOqpABbmfGYhM/HxjePsBlClkd4HZWDz89mZWst1aCOXJej1fVs3SQpCFUGTXHTb3QjRZSNRV0VgsfYcGFQbKljj6PfsBp/QpFwE0k4csqkUupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445373; c=relaxed/simple;
	bh=/gfhFgCIXiQbIzPRcDV+OX7eKDVr3NB9QTsY0/UOi40=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ud2HT2D6pyOpw02oyafyo/RUxg4TmmKRfkq0zT5iZC/pathVUOLZ4myljIZ2x8vWvOHH37O6SkdiXwih28WfKta0tRRIEipXlwHBp5eYTQrduSOBZOF50FIp3z1Ck1h9tgzb7fMMFED95S76nZodApGmmD9yvoN/N6kqexNtj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tyWewPOv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7oUr2hcCjGg3jEIX+23EL5ydP7tjG/UO6W9TUaokiLM=; b=tyWewPOvnkhVW1eMV98TyPrXOs
	Ztf8QDyc8Y/770DupqK8LpdI6arUl7DQrbjVP4GXbMKsojfQDA7wWAlMv/HgoU8rYqt3ebMJF1ig/
	yTPzLyj9KvlA2JqqZiqZU+1UFZ/ZMaatz1v3BYuY5yJw7emziw2FgkoDFmo4pqtwJXGpdtn87ZYGZ
	0KVfhXiW0VfBOGetrE8bmCFSrxZ0y1dhD0IcsmLBoFexE6uQmQzex0/iDj3/SPYKw5ff6fvDmZG2u
	vkuAjItPxpK+/G4TjGDuf+WUMuCA6KeDpcWE1Uw2217qOFu1nMF0hlorJBtxnkbtG6A4yiYQkuWtB
	KaaJU27w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33814 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3VvW-0004Me-2R;
	Sat, 12 Apr 2025 09:09:22 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Vuv-000E7y-9k; Sat, 12 Apr 2025 09:08:45 +0100
In-Reply-To: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
References: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 4/5] net: stmmac: remove eee_usecs_rate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Vuv-000E7y-9k@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 09:08:45 +0100

plat_dat->eee_users_rate is now unused, so remove this member.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/stmmac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c4ec8bb8144e..8aed09d65b4a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -276,7 +276,6 @@ struct plat_stmmacenet_data {
 	int mac_port_sel_speed;
 	int has_xgmac;
 	u8 vlan_fail_q;
-	unsigned long eee_usecs_rate;
 	struct pci_dev *pdev;
 	int int_snapshot_num;
 	int msi_mac_vec;
-- 
2.30.2


