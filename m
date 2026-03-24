Return-Path: <netdev+bounces-270950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJDXErBZwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A346A3059B4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62D431C0B2D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642C3DE44B;
	Tue, 24 Mar 2026 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hfX7WMvd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE63DD50B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344105; cv=none; b=PB4A8xiWRXN/VRHQljddNLrOozP/wgiIehJLazA/7D23VhTdFtckZ3ixWKbv+2kUtrvlAhsmVvMakYG7gytsUa4JgrCjj5u3Eiqwst+J5HGnN0WLbmvToF/HXBBRd5oOhCE3XNlDFPVzTmS4WU8AznYZDrbtcObbIgubaSkTZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344105; c=relaxed/simple;
	bh=dMyhJaW1YdqgbH/gPICMvK+c0JpKrr6pXbd/fMpnu4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQU0Tnw7YqyNOt+2Ww4y3EgKU8oVtEHcZM5JvKurdI1rG8/Iy90OzpEVCj2tmTSyZ/cm+2o7xn+y63OX9oNQe+RldKHHBnj9H5iVFbJ9jP43OwwT7KcDb2ZFqMVYxAn0reMgQlGKSLELcSitjQYitDNIEpM6UcLQyzQFUuPXEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hfX7WMvd; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 344C1C58098;
	Tue, 24 Mar 2026 09:21:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0185F6011D;
	Tue, 24 Mar 2026 09:21:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68E8510450A18;
	Tue, 24 Mar 2026 10:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774344085; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lDTQ1Gt3uozCZwLuZf90CgPV5cm4b1e03TcvTltg1FA=;
	b=hfX7WMvd3Fs12xUyTk1i+9Y/5nSUyw5ERcxx/XHj+AMiDa88uo4Zj38y5p4cUtBiNk+m5J
	MxBbrwhwuXnIILYpQBXdLdPzTkl5Htb/6+eYV7n3sbmdZG/h9ovWSUaMrM5eoSVNknrzHV
	8L1x8+b1Ia7I5KrvtjDUvpmvv9RYP3Ap6uSddTJQ76DM/tQVeUUhSy0NnlijXhU2oLSu4K
	CfdJj+vnamHCgx9C6zWEkLsf3ESSJj9gL58mDg1uwrsEAJdXqEJFLYFe3l57totM2GGA+D
	odlXnxThjOYvx+mGc9vJAqsk9NmlJtw0XU11edZi1mTlIMkjFG+daHVzUpNUmw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 2/5] net: stmmac: dwmac-socfpga: Use the socfpga_sgmii_config() helper
Date: Tue, 24 Mar 2026 10:20:57 +0100
Message-ID: <20260324092102.687082-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-270950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A346A3059B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the existing socfpga_sgmii_config() helper in
socfpga_dwmac_fix_mac_speed(), instead of re-coding the register access.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 42da73b92ceb..ed6448c0ad2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -95,8 +95,7 @@ static void socfpga_dwmac_fix_mac_speed(void *bsp_priv,
 	u32 val;
 
 	if (sgmii_adapter_base)
-		writew(SGMII_ADAPTER_DISABLE,
-		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+		socfpga_sgmii_config(dwmac, false);
 
 	if (splitter_base) {
 		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
@@ -121,8 +120,7 @@ static void socfpga_dwmac_fix_mac_speed(void *bsp_priv,
 	if ((priv->plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	     priv->plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) &&
 	     sgmii_adapter_base)
-		writew(SGMII_ADAPTER_ENABLE,
-		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+		socfpga_sgmii_config(dwmac, true);
 }
 
 static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *dev)
-- 
2.49.0


