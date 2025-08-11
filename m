Return-Path: <netdev+bounces-212578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA7B214E8
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79041A231D6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40E62E2841;
	Mon, 11 Aug 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jYNMzakz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FF238C16
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938304; cv=none; b=R1xrkoJ68gsSc7JvV8jdm/yajdf7U7k291Zge6t424Nqx6GcAwy4mB/X0gpU6qbtjfz9tjObxvz3Bmk06e0iYSJvqbGP5Q6XnT+jXPUB/SAUJ69Bq46MX7kP1J7bU7w7C0aMfIOSb4Rig2tR15qhmtzpkDMq+6RNeQmoTsADotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938304; c=relaxed/simple;
	bh=q+2e9TeT6019xynzboG1VXjRajTwHnWkub8Hu6b14BE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Qe3K490Bgabb5DC5MhyRW1TW7e0fBsdUULuxzcWAxxXqEBQTyivOIKJFWucCPRfPvhnB2OP9/6wuTtUxqga6sfbP+Bb1y2Tq2TgxCHWQM+AewmFgk7JWflj+5Ke0SPi262fNhsYokD1+4CjGdlW8tTJcwAFEq3gGiG82xfCpvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jYNMzakz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9nIv7jNtZ9HHdC/Wdm1DbcmNwjbQSb5fGpRTic0aOvg=; b=jYNMzakz7+57fTNSZSibLZLiFi
	PlkJpCXOm+piH+krrRpD4Ql/Dh6glhdF9sB5vQnFcp1MFs8YHOmG4bxN3beW6MAX/S9O21bJW6Rbr
	NZrXnQpgQIbFq/qvw17PYTyjvxfqCXijU6h+zbSFItlaQ/YqXWbW7I3tdS3RnulDxBmrScdEaFyYT
	/PElUBici815VU4YTN0R3cWk/U+53zdTd7K5GB78r5f/ws8ZdFTRJRxzzOg22lHEAq81BOd4bbtWP
	cdkeTcF2JHJYh8OOwLbjoUKAV3YDTcc1dW1vQkqPUVqzrjHIxwmqbJHwjrrq45jNxCtigevzwZ00C
	jpkS5WJA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53164 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ulXcL-0003ae-0h;
	Mon, 11 Aug 2025 19:51:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ulXbc-008gqf-GJ; Mon, 11 Aug 2025 19:50:48 +0100
In-Reply-To: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
References: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/9] net: stmmac: provide a set of simple PM ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ulXbc-008gqf-GJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Aug 2025 19:50:48 +0100

Several drivers will want to make use of simple PM operations, so
provide these from the core driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index cda09cf5dcca..bf95f03dd33f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -374,6 +374,8 @@ enum stmmac_state {
 	STMMAC_SERVICE_SCHED,
 };
 
+extern const struct dev_pm_ops stmmac_simple_pm_ops;
+
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2da4f7bb2899..4a82045ea6eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8013,6 +8013,9 @@ int stmmac_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend,
+			     stmmac_resume);
+
 #ifndef MODULE
 static int __init stmmac_cmdline_opt(char *str)
 {
-- 
2.30.2


