Return-Path: <netdev+bounces-102395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C9C902C51
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650CF1F21EC3
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67513155C80;
	Mon, 10 Jun 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nXpAGqjZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50115279B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061037; cv=none; b=brWhoNO0OXz+GUQbnsFtRsTclVhqnl74ncyuKQRPsYNR9MhDSKnPv9WnevaxwHtZkhRodjwoQX5zjfEh92jx7luKe88+9l6cxrvLkzY5k47tGI95/KjUKmAS90O5zdx477le26xfxltE4efvtcYg1qz3fNc40P3eHJmVrnmZX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061037; c=relaxed/simple;
	bh=JkQhTwDhyHbtRJkcZLwjJAEbRwRVP8gcYsDg6MMuIjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+Y3DsP6vnRW1/sRlcyvFT4kDeublj7lkI0xaKRZgWtOq3mgICpuDODOs+N2KeKse6MlVPEymr6acuZ1wEp8eL5J5/ddMpat7ibSiJDZ0LZqs/A2862DPZO9fA8wNzJTF/HqLo6n46TCKzFNBlA85lXryII9vC60IU9FWmyFHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nXpAGqjZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718061033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozX+svhUE8NPpq8SydPNqxb9OzxvgvSnMKkEEb3sTx8=;
	b=nXpAGqjZepTTsLw+prupAAZ9cSkDJxM8H01JKIp2PzXBa/GACG5rHmu7FHRy58hlWZq7qR
	cGieKAly55vODxYYvni1QL+aXTuNSU1qAfphUpMRoIQs/vfml8e0Ui//T3xim08I8wwJfZ
	2yDHVbl9kxwtS89gvpnD7cLDhhfjK0M=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 2/3] net: xilinx: axienet: Report RxRject as rx_dropped
Date: Mon, 10 Jun 2024 19:10:21 -0400
Message-Id: <20240610231022.2460953-3-sean.anderson@linux.dev>
In-Reply-To: <20240610231022.2460953-1-sean.anderson@linux.dev>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Receive Frame Rejected interrupt is asserted whenever there was a
receive error (bad FCS, bad length, etc.) or whenever the frame was
dropped due to a mismatched address. So this is really a combination of
rx_otherhost_dropped, rx_length_errors, rx_frame_errors, and
rx_crc_errors. Mismatched addresses are common and aren't really errors
at all (much like how fragments are normal on half-duplex links). To
avoid confusion, report these events as rx_dropped. This better
reflects what's going on: the packet was received by the MAC but dropped
before being processed.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5f98daa5b341..cf8908794409 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1296,7 +1296,7 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 		ndev->stats.rx_missed_errors++;
 
 	if (pending & XAE_INT_RXRJECT_MASK)
-		ndev->stats.rx_frame_errors++;
+		ndev->stats.rx_dropped++;
 
 	axienet_iow(lp, XAE_IS_OFFSET, pending);
 	return IRQ_HANDLED;
-- 
2.35.1.1320.gc452695387.dirty


