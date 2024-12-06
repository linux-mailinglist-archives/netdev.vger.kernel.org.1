Return-Path: <netdev+bounces-149714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830F9E6E7C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD75188485B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13369202F6F;
	Fri,  6 Dec 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lWrWWtWt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2119202F6B;
	Fri,  6 Dec 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488832; cv=none; b=ChaqeCa1ZQTpMtDJNVUkjUvCUfxsvXoihmrsJUkeJXDNpiKxbN6bbLZoH0Yhs73FdufpWTQasppKgF3r2kxz8Ri6Y/HN1oFrA36joprkD8yurwtCkhvc/prwXRZFSfVRBoRsrOW9YNPVElH7gQGv2MMvtJfVd6MxYXa828pGOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488832; c=relaxed/simple;
	bh=l8UOAxY9kjPFIk47or/L1lXuq+hDy/1XauW267Ijgmk=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=ZbzN04JGf1Yzf2mZfvSlNvnVCgB/7S7OYJkeqr4QsZPMeF+A+4iL6i7j3Qa/u+Cwd5Kl5w3N83pyv5GGWtYi0H2zzYEJtzAXzi6tPmibWmDEAkQeSapcOWHRW9nRRhn28cF/K9FCpQ9dAmgmLokfiqleif7dAUMV5G72TDXH00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lWrWWtWt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fOGpSJqozf26dVxmBeF8vIRHibOPe4MJoalCqug07Qc=; b=lWrWWtWtS6V8FLcQmZwm+noR35
	caPPCLFIo+KloRv5ELucm544Cratny6sAhIU1iCcOxXbPSJ0DMF8sAInugAWqMwlnxdT4hgjI/ObL
	0SmvTOIdcnl6L8XQbucsfe4erswIwnipyAIfKTbFqLPtGGYn8WiFlD0rhK2d6Nw/5tUZsea8hnnSN
	jC3RHvpam93LPXgHMqz/jj77I2j2lzpOaT3gbxYVMw9zJa+mQm7ZFINypFJELKn+TsTHf373i92Gj
	hgyTGP4LgIA9cYT/danRMYVkMYHZaLidpkK9Azb21EfwDt6unjj434eX7W6AwojJGb5WxObeof53M
	gJaw1ETA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59856 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJXcz-0006FN-0B;
	Fri, 06 Dec 2024 12:40:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJXcx-006N4Z-PC; Fri, 06 Dec 2024 12:40:11 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org,
	 linux-stm32@st-md-mailman.stormreply.com,
	 linux-arm-kernel@lists.infradead.org,
	 linux-kernel@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	 Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	 "David S. Miller" <davem@davemloft.net>,
	 Eric Dumazet <edumazet@google.com>,
	 Jakub Kicinski <kuba@kernel.org>,
	 Paolo Abeni <pabeni@redhat.com>,
	 MaximeCoquelin <mcoquelin.stm32@gmail.com>,
	 xfr@outlook.com,
	 Furong Xu<0x1207@gmail.com>,
	 Jon Hunter <jonathanh@nvidia.com>,
	 Thierry Reding <thierry.reding@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: [PATCH net] net: stmmac: fix TSO DMA API usage causing oops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJXcx-006N4Z-PC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 06 Dec 2024 12:40:11 +0000

Commit 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap
for non-paged SKB data") moved the assignment of tx_skbuff_dma[]'s
members to be later in stmmac_tso_xmit().

The buf (dma cookie) and len stored in this structure are passed to
dma_unmap_single() by stmmac_tx_clean(). The DMA API requires that
the dma cookie passed to dma_unmap_single() is the same as the value
returned from dma_map_single(). However, by moving the assignment
later, this is not the case when priv->dma_cap.addr64 > 32 as "des"
is offset by proto_hdr_len.

This causes problems such as:

  dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed

and with DMA_API_DEBUG enabled:

  DMA-API: dwc-eth-dwmac 2490000.ethernet: device driver tries to +free DMA memory it has not allocated [device address=0x000000ffffcf65c0] [size=66 bytes]

Fix this by maintaining "des" as the original DMA cookie, and use
tso_des to pass the offset DMA cookie to stmmac_tso_allocator().

Full details of the crashes can be found at:
https://lore.kernel.org/all/d8112193-0386-4e14-b516-37c2d838171a@nvidia.com/
https://lore.kernel.org/all/klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw/

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Fixes: 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data")
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9b262cdad60b..c81ea8cdfe6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct stmmac_txq_stats *txq_stats;
 	struct stmmac_tx_queue *tx_q;
 	u32 pay_len, mss, queue;
+	dma_addr_t tso_des, des;
 	u8 proto_hdr_len, hdr;
-	dma_addr_t des;
 	bool set_ic;
 	int i;
 
@@ -4289,14 +4289,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		/* If needed take extra descriptors to fill the remaining payload */
 		tmp_pay_len = pay_len - TSO_MAX_BUFF_SIZE;
+		tso_des = des;
 	} else {
 		stmmac_set_desc_addr(priv, first, des);
 		tmp_pay_len = pay_len;
-		des += proto_hdr_len;
+		tso_des = des + proto_hdr_len;
 		pay_len = 0;
 	}
 
-	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
+	stmmac_tso_allocator(priv, tso_des, tmp_pay_len, (nfrags == 0), queue);
 
 	/* In case two or more DMA transmit descriptors are allocated for this
 	 * non-paged SKB data, the DMA buffer address should be saved to
-- 
2.30.2


