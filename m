Return-Path: <netdev+bounces-238707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9078C5E266
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BC05004C0
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131933030B;
	Fri, 14 Nov 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yn6gjF/I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5A33557D
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134165; cv=none; b=MfoOMs9uatI/GEngchPoiST0XfDEOFIIrM9b8BO7BqsO5zQt3cM37qKTuyETB4cHf9aeMnFa478qC6kp3Z40kZK12OPFzPqW6H3smGpZJSywGGpcDOYEZYxr+79vctqajwn6RIb8qAWRNnkMCfe8dHe7qE+M2/iac0UmRGj3jb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134165; c=relaxed/simple;
	bh=cLWvFbw0h81R58dp60LsBO/THtqrbjVXmnyRiS7n2Jk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=T4ACGQPiM5AkTuIRbBCKdqaLzyRJmcrgA/X/ohKIpubl5CV6cqlZl/fIBs34dGn6GCqa3bNG5dkjiAwHotsjN3UwCADi15SwtIYV8pWc/JBd6Vb7R7PArvpLT7E2ZyNjw5o0g92N4a/PYWRmKmOJCqJI5lxm6KV8oDKCUks/Y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yn6gjF/I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3r9VUXikyV6de7PaLfY3kpgLTq1QMxYWUfuS+c81/nY=; b=yn6gjF/IAbqHZZ6uk0OkX+GYqx
	ghXigzEXPu7VHnf4AHSZz9vOeruq9dDP/t73D6SzdxBv5a78aYbsJXB9Ir0viHPGVPoUk9cyUuatO
	sLXNGfyv/p5NRr39/bndki+29q7yq/Bg3hEJ93bVNfhBrKVJVcdvg41QLUxEmamZPgTMVHs4VFecA
	KKIhwwoWFLXXX+V9nHXC7qfzPZBGkFGJhIc04lUewWmas/lRl7P701qhqjE7kEdfQucFBmNgKcDu2
	uGkJycM3xOwIQu9cy48ys0lGXuHWFhyti9G/t17yX5dXTsKzwr1tBhwDCWs38ruWTWsRHwQ0ttUpu
	eFppM5fw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58386 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJvjc-00000000795-2RTO;
	Fri, 14 Nov 2025 15:29:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJvja-0000000EVkI-0zUH;
	Fri, 14 Nov 2025 15:29:10 +0000
In-Reply-To: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
References: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen Wang <unicorn_wang@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	sophgo@lists.linux.dev
Subject: [PATCH net-next 10/11] net: stmmac: remove unnecessary .prio queue
 initialisation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJvja-0000000EVkI-0zUH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:29:10 +0000

stmmac_platform.c explicitly sets .prio to zero if the snps,priority
property is not present in DT for the queue. However, as the struct
is allocated using devm_kzalloc(), all members default to zero unless
explicitly initialised, and of_property_read_u32() will not write to
its argument if the property is not found. Thus, explicitly setting
these to zero is unnecessary. Remove these.

$ grep '\.prio =' *.c
stmmac_platform.c: plat->rx_queues_cfg[queue].prio = 0;
stmmac_platform.c: plat->tx_queues_cfg[queue].prio = 0;

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 4750843cf102..e769638586fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -181,12 +181,9 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 				     &plat->rx_queues_cfg[queue].chan);
 		/* TODO: Dynamic mapping to be included in the future */
 
-		if (of_property_read_u32(q_node, "snps,priority",
-					&plat->rx_queues_cfg[queue].prio)) {
-			plat->rx_queues_cfg[queue].prio = 0;
-		} else {
+		if (!of_property_read_u32(q_node, "snps,priority",
+					  &plat->rx_queues_cfg[queue].prio))
 			plat->rx_queues_cfg[queue].use_prio = true;
-		}
 
 		/* RX queue specific packet type routing */
 		if (of_property_read_bool(q_node, "snps,route-avcp"))
@@ -257,12 +254,9 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 			plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
 		}
 
-		if (of_property_read_u32(q_node, "snps,priority",
-					&plat->tx_queues_cfg[queue].prio)) {
-			plat->tx_queues_cfg[queue].prio = 0;
-		} else {
+		if (!of_property_read_u32(q_node, "snps,priority",
+					  &plat->tx_queues_cfg[queue].prio))
 			plat->tx_queues_cfg[queue].use_prio = true;
-		}
 
 		plat->tx_queues_cfg[queue].coe_unsupported =
 			of_property_read_bool(q_node, "snps,coe-unsupported");
-- 
2.47.3


