Return-Path: <netdev+bounces-156352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476BCA06280
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7041E165125
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270941FECC1;
	Wed,  8 Jan 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wBULUhLm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762442594BC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354893; cv=none; b=U4Q6iBlXfHVB7mxyf8uS0o4rnkt7zSsyf8L+gKND02GwD22B6FyqiKHhNOGkKFh0e7qo4u5ctrvE2T4mZl52KvdQuXYfXMg7pZQyCTMFl68YaiqJcZ2na5LmsF/uT2c1ZXn4FeWujqloWyrYVPRtL7xbNha9Vm7n8bWa+wtKXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354893; c=relaxed/simple;
	bh=XzFIWFSFAYoM3yVGO7igZz7uRnFOYhZiArUnBSPGjCs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CCH0FEMWBACM197T7/rWfQeTog77bhBqV1b+9BvevPtM8Lwplj9go4tzq4TOZxVgBPyq56jB0A/KXYuUvyiyxvZi5IhRc3PgbWdoZxAgaonfqwL8++4R8GH1Rvs7dzkwOpPtrkzu0kO93on7oTUVFlJxd5IQcl/tfpz7EOM7yr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wBULUhLm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+MtoFE7mIggxU2pLuJ181OqtBDlmJXFPdnSDCH11MFk=; b=wBULUhLmCbpzkLBoBjyrrwPz6J
	GO4V71vlYD4TGnMdOAq09hc8WRCnfCJ3cWl75s6EwGxDuWfJUCbfNQE23N/fHiIGsgqUvaerjdmCk
	cYpGHZyQzP/3/D+4RLwzBdgDsys74yq7l3DjG1EzfthMiqDNwZvjlml817NXOOhOsy/MFj7z/qljr
	fywArusI8CpCoJtym4NMgxsDLNbRZW5eppaYpq2xIY6UHI9j2NCRYcVrbV0LFovp/NM3JC7zJq6A2
	E0Y8rOQ2L8RFJaGN9umrJ48Ivfr18ABfeuc8z0AEf2MaArAPg7AH6QtYo1AwqHB9d+C3j34cVOkfB
	I1DlTPnw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47626 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZDv-0000ur-0T;
	Wed, 08 Jan 2025 16:48:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZDc-0002Jx-3b; Wed, 08 Jan 2025 16:47:44 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 03/18] net: stmmac: use correct type for
 tx_lpi_timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZDc-0002Jx-3b@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:47:44 +0000

The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
Use u32 to store this internally within stmmac rather than "int"
which could misinterpret large values.

Correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
rather than int, which is derived from tx_lpi_timer. Even though this
path won't be used with values larger than STMMAC_ET_MAX, this brings
consistency of type usage to the stmmac code for this variable.

We leave eee_timer unchanged for now, with the assumption that values
up to INT_MAX will safely fit in a u32.

Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/hwif.h        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index c36f90a782c5..9ed8620580a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -420,10 +420,10 @@ static void dwmac4_set_eee_pls(struct mac_device_info *hw, int link)
 	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
 }
 
-static void dwmac4_set_eee_lpi_entry_timer(struct mac_device_info *hw, int et)
+static void dwmac4_set_eee_lpi_entry_timer(struct mac_device_info *hw, u32 et)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	int value = et & STMMAC_ET_MAX;
+	u32 value = et & STMMAC_ET_MAX;
 	int regval;
 
 	/* Program LPI entry timer value into register */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 2f7295b6c1c5..0f200b72c225 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -363,7 +363,7 @@ struct stmmac_ops {
 	void (*set_eee_mode)(struct mac_device_info *hw,
 			     bool en_tx_lpi_clockgating);
 	void (*reset_eee_mode)(struct mac_device_info *hw);
-	void (*set_eee_lpi_entry_timer)(struct mac_device_info *hw, int et);
+	void (*set_eee_lpi_entry_timer)(struct mac_device_info *hw, u32 et);
 	void (*set_eee_timer)(struct mac_device_info *hw, int ls, int tw);
 	void (*set_eee_pls)(struct mac_device_info *hw, int link);
 	void (*debug)(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index df386fc948ec..984e708d019f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -307,7 +307,7 @@ struct stmmac_priv {
 	int lpi_irq;
 	int eee_enabled;
 	int eee_active;
-	int tx_lpi_timer;
+	u32 tx_lpi_timer;
 	int tx_lpi_enabled;
 	int eee_tw_timer;
 	bool eee_sw_timer_en;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e80ac74538d2..afdf992cd91a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -394,11 +394,11 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 
 static void stmmac_lpi_entry_timer_config(struct stmmac_priv *priv, bool en)
 {
-	int tx_lpi_timer;
+	u32 tx_lpi_timer;
 
 	/* Clear/set the SW EEE timer flag based on LPI ET enablement */
 	priv->eee_sw_timer_en = en ? 0 : 1;
-	tx_lpi_timer  = en ? priv->tx_lpi_timer : 0;
+	tx_lpi_timer = en ? priv->tx_lpi_timer : 0;
 	stmmac_set_eee_lpi_timer(priv, priv->hw, tx_lpi_timer);
 }
 
-- 
2.30.2


