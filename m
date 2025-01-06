Return-Path: <netdev+bounces-155440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A0A0254E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B359A16344B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616B1DC9B2;
	Mon,  6 Jan 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oImsLya7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F56088F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166336; cv=none; b=LnmmhZtxHnZomwhJcw+xWrGmMohY+xlN7yImBzOakvks92L3lJL37LYJFY85qNAoSI/8irckAOydruANWEelhRa6dRPEaQXaoEV/NqdtwTX409Z5zW5X6hS2P4ZdEWPueH9rvxClcjGN+yH9jYonxEbIyw9s9KwXmPKcP+M+ABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166336; c=relaxed/simple;
	bh=/tWhK5ywRcQzUZMJU7tjGL5nWI1qmZzX4J1S21MqRp4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=slp0WniXopOoLY14+9FWW1gY8OwoBZMcjQWnRMk/WGazeDgFfJ+JHstxAbJg4WrpeFbD5+RuNeaKlOruD4Etj2r/bqU1iO1tXgUO6807xB9CHPouXmlM2E/VwTMdYEEYXI5U5b5SZfUSiw3U7yPHlzDF62rBuQqTlN3+hgqoUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oImsLya7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ch93sjX3yKed7sqxo6SdigJoOaMQciUQxLBCPT3Hs9s=; b=oImsLya7F872LfpIdNFePcggYT
	a91a8ID2tALkdg0mpfYQsNNf8yVW/Y3F1gNfn5r73jRtw0KXcu3Ti4m0J/Vt1NPwoGUND9K/do37L
	zSyk3SwxFzaSgdJFO/nzfeH+bs6ezrrxL05371EKcrWmRRuFUtGtnGb7vYHzoD/W6PASq+pcHiwRG
	UzskXp0Am107P2a56rgLFY/0TjdU14nvcc47cyitfU3k7CPofCSNj91ylZrGdsm5S0PdLZV7behdg
	WtAUDu/hkasLyEv1k8P0mQEkxlxUAi2VwLDh/NVj450KGgARHiREijjrY84hYOQMrf78VilQ4Ag4e
	j6Q/FPdQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40270 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmAh-0005sC-1h;
	Mon, 06 Jan 2025 12:25:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAe-007VXP-Hm; Mon, 06 Jan 2025 12:25:24 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 08/17] net: stmmac: report EEE error statistics if
 EEE is supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAe-007VXP-Hm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:24 +0000

Report the number of EEE error statistics in the xstats even when EEE
is not enabled in hardware, but is supported. The PHY maintains this
counter even when EEE is not enabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 693f59c3c47a..918a32f8fda8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -654,7 +654,7 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 					     (*(u32 *)p);
 			}
 		}
-		if (priv->eee_enabled) {
+		if (priv->dma_cap.eee) {
 			int val = phylink_get_eee_err(priv->phylink);
 			if (val)
 				priv->xstats.phy_eee_wakeup_error_n = val;
-- 
2.30.2


