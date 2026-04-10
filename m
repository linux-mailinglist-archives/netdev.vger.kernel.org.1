Return-Path: <netdev+bounces-277421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP3gOBj42GkYkQgAu9opvQ
	(envelope-from <netdev+bounces-277421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:16:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052763D807A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF48E30D0536
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F573D2FEC;
	Fri, 10 Apr 2026 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xexf2kxT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE803CEB99
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826480; cv=none; b=m2RtqYyICGtsfDc/ADZFuWBPt2LdOO4aUZ540TmsemamikKmj3iL9g1PxBorFIh3Sio5k+HRqytovKT5uDi9HdpWA2xAL8XawAzATLRgtV2NHX1MxyrAps+ew4flQZKltVZKolD/y9sl3sdVRNKcOMst/hyQxa9VgfdSjo74ZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826480; c=relaxed/simple;
	bh=W2SA8vHiOi/NTz09wp1ZzyEbuRyKA9hbS8uI+0vIPLE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=B7uIVKxeXZE0Tc4dH7Fo7OYUW9h0s3HyzMFcNlf1o3rRqiKHxs8Wsl22ea+Lbr78HRmlk3aoYarCgs4cVQxJHIHnTPUw6xnwfCJDyfM1ameY5s853GdvHDWnGT4g7d8OiAxemmP4fnxvNDZwojSbeoRBD05cIgRnqSFSS+EVJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xexf2kxT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KAmExev6QREqTu9zo7T3RzeKjeGOvRTDyJ1tg+D3lYI=; b=xexf2kxTPDrbMyYxOBx+Da6zK2
	QqFHWAFjua9yf/IB+3akKUPG7JTrHa8hMEym0SmTgRp9p8PVALgL9xZKPWHZ6b4VUMwtTQ1fhWILz
	I2EZj0Gekcg1lnBU2Be/tobXR40ZGUMnGvxSDB+gjIE/NpLdQ4PdNYo6f4MiSBGjL7l31r9vxw8Mx
	FDwkYcIk1oTeAS4/j5ptdYhDEzy5ojgjq59zglqvk4tX0oUpYy6m25AFE+zYcQSPwDMxAT8QzUJD8
	wDnbeIx9sPGDaMi7DF8TOgQmDFCsgYcEFdcAi03tD9+jR7Ug6u2H+3Pyy+J7x6He8FShvG5XCqYJv
	Tb5xElCg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51554 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1wBBaS-0000000050J-0ZTQ;
	Fri, 10 Apr 2026 14:07:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1wBBaR-0000000GZHR-1dbM;
	Fri, 10 Apr 2026 14:07:51 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sam Edwards <cfsworks@gmail.com>
Subject: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 10 Apr 2026 14:07:51 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277421-lists,netdev=lfdr.de,kernel];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 052763D807A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable receive process stopped and receive buffer unavailable
interrupts, so that the statistic counters can be updated.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Since we are seeing receive buffer exhaustion on several platforms,
let's enable the interrupts so the statistics we publish via ethtool -S
actually work to aid diagnosis. I've been in two minds about whether
to send this patch, but given the problems with stmmac at the moment,
I think it should be merged.

 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index af6580332d49..43b036d4e95b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -99,6 +99,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
 #define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
 #define DMA_CHAN_INTR_ENA_FBE		BIT(12)
+#define DMA_CHAN_INTR_ENA_RPS		BIT(8)
+#define DMA_CHAN_INTR_ENA_RBU		BIT(7)
 #define DMA_CHAN_INTR_ENA_RIE		BIT(6)
 #define DMA_CHAN_INTR_ENA_TIE		BIT(0)
 
@@ -107,6 +109,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
+					 DMA_CHAN_INTR_ENA_RPS | \
+					 DMA_CHAN_INTR_ENA_RBU | \
 					 DMA_CHAN_INTR_ENA_FBE)
 /* DMA default interrupt mask for 4.00 */
 #define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
@@ -117,6 +121,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
+					 DMA_CHAN_INTR_ENA_RPS | \
+					 DMA_CHAN_INTR_ENA_RBU | \
 					 DMA_CHAN_INTR_ENA_FBE)
 /* DMA default interrupt mask for 4.10a */
 #define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \
-- 
2.47.3


