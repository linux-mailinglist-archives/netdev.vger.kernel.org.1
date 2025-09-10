Return-Path: <netdev+bounces-221659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B85B5173F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41C34681F1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58FB2DCF51;
	Wed, 10 Sep 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IDMDnpcq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5394226D1F
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508653; cv=none; b=GCNgiAaD69eZHI4BHuQ8F9vO2gc4EwrS3qPxk9dRF+AAYrq3l+aZ2lOA5sAGLb9ddDjfoSG8dR9+UGziPeJcuB7nccKu998WqhW3rag+0I57FwzDVmx9O/w9hgkxUMNOx0Bb3usUXpqXknL1qwicsNRO/Tb6B4OZtFk7U/i/Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508653; c=relaxed/simple;
	bh=grTq8KxRMg3coiWEIWyramJs9nx7gmzXTsUJmAJjaFI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=IU9NwFG4c5y74urzUOCKgZvHs5eUxI4yYlQUQfihljYfQh8ozUAi9u0n96bSIS0VEVwO2uzaOSMxe/wRbSoOGp22mFF710PXDsRNxHGnQsDWwxmhFN6Bpcqb2HcBmFEMLFPdXLJdK4tvjWJP6BtxgLXxUo39UQRGE6L6K+fXtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IDMDnpcq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rnV6PVfecQWdaEN3bABGCOl8s59kCgMUps2w8sfp+hU=; b=IDMDnpcqu/UZwSv6tqyO7KmYJT
	JzTNafyHFkyqLSgHRAzmn9Omk10EuCK0c638HkfZ/NubnhAZd6p+icNi8BjiaWHEXjqskAK1hl+2B
	vpVPLeivq68YRTfJDtBI8ucHeVslyoNo2TWPlMDUfPukrwuHcEoExRMSwqkYaeeHiFOweSngVhTYo
	IxsyIBD7dxcE6kLXqGjISoMChfdqh+wrHGO/cmSqlwaFmlGhW9fFHt4Rgu+NnGUpmZReyQJQnneR3
	6RNnWCtCjseBWo3AirCr18YrBI5desLm5/Ey+pH1p9VVxRmlwbElidg8yTE/QCOSU5Sz/3Ou/jZTY
	iiRzaAUQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55448 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwKHf-000000001dF-2UGS;
	Wed, 10 Sep 2025 13:50:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwKHe-00000004glk-3nkJ;
	Wed, 10 Sep 2025 13:50:46 +0100
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2] net: mvneta: add support for hardware timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 10 Sep 2025 13:50:46 +0100

Add support for hardware timestamps in (e.g.) the PHY by calling
skb_tx_timestamp() as close as reasonably possible to the point that
the hardware is instructed to send the queued packets.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
v2: add ethtool_op_get_ts_info(), remove FIXME from comment.

 drivers/net/ethernet/marvell/mvneta.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 476e73e502fe..01eedc3e54d9 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2985,6 +2985,13 @@ static netdev_tx_t mvneta_tx(struct sk_buff *skb, struct net_device *dev)
 		if (txq->count >= txq->tx_stop_threshold)
 			netif_tx_stop_queue(nq);
 
+		/* This is not really the true transmit point, since we batch
+		 * up several before hitting the hardware, but is the best we
+		 * can do without more complexity to walk the packets in the
+		 * pending section of the transmit queue.
+		 */
+		skb_tx_timestamp(skb);
+
 		if (!netdev_xmit_more() || netif_xmit_stopped(nq) ||
 		    txq->pending + frags > MVNETA_TXQ_DEC_SENT_MASK)
 			mvneta_txq_pend_desc_add(pp, txq, frags);
@@ -5357,6 +5364,7 @@ static const struct ethtool_ops mvneta_eth_tool_ops = {
 	.set_link_ksettings = mvneta_ethtool_set_link_ksettings,
 	.get_wol        = mvneta_ethtool_get_wol,
 	.set_wol        = mvneta_ethtool_set_wol,
+	.get_ts_info	= ethtool_op_get_ts_info,
 	.get_eee	= mvneta_ethtool_get_eee,
 	.set_eee	= mvneta_ethtool_set_eee,
 };
-- 
2.47.3


