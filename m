Return-Path: <netdev+bounces-221304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7FB50179
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289653BE972
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757122154B;
	Tue,  9 Sep 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F6KmLplR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A82BB17
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431811; cv=none; b=FmYBTrP1AdqGE7jaInt5aNB7KbNJ8q5azsRt5eOH8ZWoo4+64wTYg+FGB6W8+egh03cwqOcNoezyHak8d+/UHSP4R822+1x+C2UagTm8wlWyoo3NIC3Qyb484ZkEDTSeafCmBFeclrDN20j5xI/xnkPNdLJaEpRSXG0Mx66dmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431811; c=relaxed/simple;
	bh=NTL5ej3JWPeHzuZa73WqFQIhay6exkyqe6D2KBonqQM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=kpLA8s3CwCryfm6ypBKsB8gW8XkHkvirffX+HXyIR1XUJ33ETkCxkijSu6MqSUU0kfzRsDAAKyhzWJgz49v9TH8jLg204qIdul9bXH64P2ZdhvliPwYsYfQM4At2jV1AgH7bvIsm/1NSP5UQ7IWcNQYM1vvvU67DiYdawAFvLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F6KmLplR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oAiRTznlFC7vYErTIqTAhemmI7/08xCjg69zADmhAg4=; b=F6KmLplRAg3hdeRbnVi7YGEX7r
	gMzAjLubPLZYtA5BWRoYxaG88C27EzyY5bcYXDaKiywyuFSNKAECFOyYrDqGJAYVeFjuTH2jHC56F
	PcBg/na5NskAZ5u4eDbQLZioejyvggCJnjoI9reAJ7JhxL46jv3UjRv3coqIQX9+eYn3oxNmqkUd6
	yqWw04pfi7HOQ0ZFZRWqIJRpSJufAS8cdFW1JLs6pctlN4THiIqj1zFUJTxWBgHtJJBRaVjIKTLbI
	/yXiH69wvBHq/Z4Tk6vJ8pW5G2zW6sBbVNEuMN92Kkd6uD5xMz5SN7SkA1qK6CbFZdLRw+e0mvVhl
	PV97j8Ag==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53872 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw0IE-000000008Jm-1a80;
	Tue, 09 Sep 2025 16:30:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw0ID-00000004I6z-2ivB;
	Tue, 09 Sep 2025 16:30:01 +0100
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
Subject: [PATCH net-next] net: mvneta: add support for hardware timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 16:30:01 +0100

Add support for hardware timestamps in (e.g.) the PHY by calling
skb_tx_timestamp() as close as reasonably possible to the point that
the hardware is instructed to send the queued packets.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 476e73e502fe..5f4e28085640 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2985,6 +2985,13 @@ static netdev_tx_t mvneta_tx(struct sk_buff *skb, struct net_device *dev)
 		if (txq->count >= txq->tx_stop_threshold)
 			netif_tx_stop_queue(nq);
 
+		/* FIXME: This is not really the true transmit point, since
+		 * we batch up several before hitting the hardware, but is
+		 * the best we can do without more complexity to walk the
+		 * packets in the pending section of the transmit queue.
+		 */
+		skb_tx_timestamp(skb);
+
 		if (!netdev_xmit_more() || netif_xmit_stopped(nq) ||
 		    txq->pending + frags > MVNETA_TXQ_DEC_SENT_MASK)
 			mvneta_txq_pend_desc_add(pp, txq, frags);
-- 
2.47.3


