Return-Path: <netdev+bounces-239511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD2C69000
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06BC4345B1F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2D30F93D;
	Tue, 18 Nov 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MN7DkEzl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43870280CE0
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464296; cv=none; b=V1f5EL1+9L9TjYsCh2QWr67dH7z26XGVWb7LO7Box8Kyfpxxh8cu4A/LAx44t0E3oVc7Em7sDnUQNV6i5nLpsNN6fsyEcwY6limRQxc3S2gsBJgDiAjVRqbF3I1F1wdhXTWW00Yi4XnoryZz5+CPGlb5YtrjONQcZ/zboU83u6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464296; c=relaxed/simple;
	bh=0cB9moXF+9zWyn5aaWAXSYpXE77uwjPUw1uKzVREvlE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Qv9kd/2gLNHItp9cl+m+RGBoyGq4WS8NMlFTKT/atgWQbY+l4bwrM75GWslVie+i/V3VxeotjiV/uKRqqVITbPIlQBnXbbpn0/l/EOwUJpCR1Db459EaJ99UGpCEOIo/PaMRPitIwBqhi2XJzFHaju2CP3YQ6SU03aZAn7S13h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MN7DkEzl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NTa574HkLl4KDyxXIf08bFd9xl+XV9qO5xzIy1sFatA=; b=MN7DkEzlF9+jrfcda8eoCuAWTg
	miq3i3aKDlP0/sdtc+vjbQetJZgk9k45Q2DZnklKivliniL5MAZTrdN5q9rElBpEQnx/lqltbwHyz
	bvWJyVXi3qwVel5+kBhTFWuopUs4zX8YY8SwAoxlvNx1ORI9m2RbxL+wargpl2Gf8uPaHLunF3f0D
	F6vDfvDOelOB9epaE47cruDj62iEKLAm4KmxOcp6WZT5khdFJzTNPh10ELPLMnVbDSXP800kOOwcf
	z+zLZ/xpPVhLAcVFy0YsllPxOQdosG+AcIA6jMAioH+OBtY9P6Ret55y34w1QfGc1N8y23zzCKKAq
	+uqzD8tQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58818 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLJcL-00000000380-3It2;
	Tue, 18 Nov 2025 11:11:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLJcL-0000000ExBL-0GFe;
	Tue, 18 Nov 2025 11:11:25 +0000
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
Subject: [PATCH RFC net-next] net: stmmac: document (buggy?) maximum MTU setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLJcL-0000000ExBL-0GFe@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Nov 2025 11:11:25 +0000

Add documentation for the ndev->max_mtu determination. I'm not sure
this is currect - specifically, having the "everything else" case
depend on the kernel's page size, which is a build-time choice for
some architectures and could be e.g. 4KiB, 16KiB or 64KiB.

E.g. when standard descriptors are used (enh_desc is false) and the
core is younger than v4.00, the buffer length is limited to 11 bits by
the format of the buffer size fields in the descriptors (TBS1/TBS2 in
TDES1 and RBS1/RBS2 in RDES1). So, when page size is greater than 4KiB,
a packet of max_mtu will not fit.

Also, dwmac4 cores (indicated with core_type == DWMAC_CORE_GMAC4) use
the descriptor format in dwmac4_descs.c, even when priv->synopsys_id
is less than DWMAC_CORE_4_00 (see the first DWMAC_CORE_GMAC4 entry in
the stmmac_hw table in hwif.c.)

So, I think this max_mtu is buggy.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 15b0c08ebd87..644dccb29f75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7813,6 +7813,12 @@ int stmmac_dvr_probe(struct device *device,
 	/* MTU range: 46 - hw-specific max */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
 
+	/* Set the maximum MTU.
+	 *  For XGMAC cores, 16KiB.
+	 *  For cores using enhanced descriptors or GMAC cores >= v4.00, 9kB.
+	 *  For everything else, PAGE_SIZE - NET_SKB_PAD - NET_IP_ALIGN -
+	 *   aligned skb_shared_info.
+	 */
 	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		ndev->max_mtu = XGMAC_JUMBO_LEN;
 	else if (priv->plat->enh_desc || priv->synopsys_id >= DWMAC_CORE_4_00)
-- 
2.47.3


