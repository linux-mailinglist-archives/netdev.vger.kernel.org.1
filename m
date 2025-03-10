Return-Path: <netdev+bounces-173529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E0A5948B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D69162782
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0417A2E7;
	Mon, 10 Mar 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ctlpD0Fd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED051E4AB
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609914; cv=none; b=lNvTwy3f2oIKcvSmSRyr8YWKbDGUNTRoSY97ZvLw8F1P5i/jTQq4IDpN0FaDCWYKy4BfDWJfxQC1ZIWkmgZH5kH04WlVWWKmpMH7bm36D1ssU/pAY5xGgSFkRTaLF2vLcuHPR2kGIJBeE59EFCHpK+KWY253JWj7b4yCMEQnXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609914; c=relaxed/simple;
	bh=1sP3XHwIQIDGMOM69P7DN2twEdFUfgOy2yKQoif4qBY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bxnZ6sk84jirSr40JRF8Zi5LOHVuFFdJi1STAmyegNWU8oAPX6beLA7A/OxTcETIS9QWsQYtfkPT4JMBvHLxUc2yWOhzeq5aPkZMgCVzBol6keal6UPbZX7962v3F/DwCKMvnMaWC4c6qIO282YWS+QUCNwtahwABwktep2BxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ctlpD0Fd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UDOJjloH2trDjnCVarjV86T+ZpZnVfpEtrSMCzlD+kA=; b=ctlpD0FdbQi+2oO6KQz05AHAyO
	TtfODzyMM5cnq8kkJVQ8cnyB2rq0SmZJ2Qqa7e02Q2P5xdVLqzyRJEIs7IeEdrGgT125HQGQZQKv6
	I1cOuQw1+4pYYLMOwqLZgq+MoMlEfdAP9DTclyk6OyoDweIsJxdLmLfEvW5vrSSvPuhF//+gHKgHN
	o5bOEiYLts3f3K9MVx7GfPkQYv497OocLwR0Ui7K8+xaXlPbZQD2TbQDkTZNqogfzedO6o3mNtdij
	oGzAZbHNsJSeH/BL3sisRjPTkEus/9Jgjbj6AuK7KVfv//DqQeYZw2pvl48TS0sJax+00Njx3kc9V
	fImZ235Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51236 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trcIL-0002dw-29;
	Mon, 10 Mar 2025 12:31:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trcI1-005rn2-CZ; Mon, 10 Mar 2025 12:31:25 +0000
In-Reply-To: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
References: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] net: stmmac: remove redundant racy tear-down in
 stmmac_dvr_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1trcI1-005rn2-CZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Mar 2025 12:31:25 +0000

While the network device is registered, it is published to userspace,
and thus userspace can change its state. This means calling
functions such as stmmac_stop_all_dma() and stmmac_mac_set() are
racy.

Moreover, unregister_netdev() will unpublish the network device, and
then if appropriate call the .ndo_stop() method, which is
stmmac_release(). This will first call phylink_stop() which will
synchronously take the link down, resulting in stmmac_mac_link_down()
and stmmac_mac_set(, false) being called.

stmmac_release() will also call stmmac_stop_all_dma().

Consequently, neither of these two functions need to called prior
to unregister_netdev() as that will safely call paths that will
result in this work being done if necessary.

Remove these redundant racy calls.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa1d7d3a2f43..c2ee6c0af3fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7768,8 +7768,6 @@ void stmmac_dvr_remove(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 
-	stmmac_stop_all_dma(priv);
-	stmmac_mac_set(priv, priv->ioaddr, false);
 	unregister_netdev(ndev);
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.30.2


