Return-Path: <netdev+bounces-260411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAAXOhJqnWnYPwQAu9opvQ
	(envelope-from <netdev+bounces-260411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:06:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E91843CA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC4C30BB505
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD734D915;
	Tue, 24 Feb 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1aCWlMMJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1022A4EE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923719; cv=none; b=H2SEOzpTHQkGt69B7BueeG3r+TgKBV+QX056Cv6ugFeQimznzozCcahJfKGh54EiEon67Kuzg+fskHHV1oxYSy0vh++oaUqkHZfyQg3Dlcf5aFxy0NWt3qdEQCj+2Tx5aloFxLczBuEim+zaTyb4KeUk/0FenJ4rXW38GVJjY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923719; c=relaxed/simple;
	bh=Vd/GKnxZhyS6Wde3FQneQx/VqBmXBcDuRHcntPE2u2E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TIxm9/oSPXYOElKaNtD0O/ugVNmrpsA7iieWL4Ql65+BAKu4tZbkN18oWBGAfSueUkNgW4xNP45MB0/C83RC1vlcimuwvJebiNKsENktvAxcz+q4BO5zU4155w7Cnxl4/C5Z4rl0a5p+iOjjoXaCnweOLMpZTyf5gbPXRax/E0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1aCWlMMJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w0Xla7YvpmY0GVAfkZRw6ajF/x6+DgW95hZFJKTbQfA=; b=1aCWlMMJBacFbSbFPTBQdkRKLN
	A0dtOVoLdZA2uO+DfN02/Rl0qYJMP0hjWjHhU0cEItXKbXoWKUC7DgM3ax1RJMJEyW+Rn3BfZlASL
	Xdy/d9R7PuBNn74bWevkBnFX9FoV5uNMZaYh+2if5FM/pzTpZwx+zSf1zHr9mwtla3jNP55F2j5fA
	75FTZwiEmVey/R7+pjgGy6b3jsgMnUH4i/9Zc3GXM2JzAzgJ+ACKuh3dTpncSIqbLoJvUPBw31qv7
	MWmo/YR2si/Nb0wXQQrTyRufAV6WgBE+l+LCbYwcb3f2+KDAJc88ocDHpF6dy3PoI+k0wS7a1zTKa
	z6EYTX1g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41976 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuoIg-000000004yF-3QIo;
	Tue, 24 Feb 2026 09:01:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuoIg-0000000Aout-0LyS;
	Tue, 24 Feb 2026 09:01:50 +0000
In-Reply-To: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
References: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/2] net: stmmac: use circ_buf helpers for
 descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuoIg-0000000Aout-0LyS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Feb 2026 09:01:50 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260411-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stlinux.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 497E91843CA
X-Rspamd-Action: no action

The stmmac descriptor queues are circular buffers, operated as far as
the hardware is concerned as either a ring, or a chain that loops back
on itself. From the software perspective, it forms a circular buffer.

We have a few places which calculate the number of in-use and free
entries in these circular buffers, for which we have macros for.
Use CIRC_CNT() and CIRC_SPACE() as appropriate to calculate these
values.

Validating, for stmmac_tx_avail(), which uses CIRC_SPACE():

  dirty_tx = 1, cur_tx = 0 -> 0
  dirty_tx = 0, cur_tx = 0 -> dma_tx_size - 1
  dirty_tx = 0, cur_tx = 1 -> dma_tx_size - 2

dirty_tx passed as end, reduced by one. cur_tx passed as start.
Output on sane computers is identical.

For stmmac_rx_dirty(), which uses CIRC_CNT():

  dirty_rx = 1, cur_rx = 0 -> dma_rx_size - 1
  dirty_rx = 0, cur_rx = 0 -> 0
  dirty_rx = 0, cur_rx = 1 -> 1

dirty_rx passed as start, cur_rx passed as end. Output is identical.

Same validation performed on the is_last_segment calculation, which
also gets converted to CIRC_CNT().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 ++++++-------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a2a0985e8c37..2d74fe98ad61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -14,6 +14,7 @@
 	https://bugzilla.stlinux.com/
 *******************************************************************************/
 
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -355,14 +356,9 @@ static void print_pkt(unsigned char *buf, int len)
 static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
-	u32 avail;
 
-	if (tx_q->dirty_tx > tx_q->cur_tx)
-		avail = tx_q->dirty_tx - tx_q->cur_tx - 1;
-	else
-		avail = priv->dma_conf.dma_tx_size - tx_q->cur_tx + tx_q->dirty_tx - 1;
-
-	return avail;
+	return CIRC_SPACE(tx_q->cur_tx, tx_q->dirty_tx,
+			  priv->dma_conf.dma_tx_size);
 }
 
 /**
@@ -373,14 +369,9 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
-	u32 dirty;
-
-	if (rx_q->dirty_rx <= rx_q->cur_rx)
-		dirty = rx_q->cur_rx - rx_q->dirty_rx;
-	else
-		dirty = priv->dma_conf.dma_rx_size - rx_q->dirty_rx + rx_q->cur_rx;
 
-	return dirty;
+	return CIRC_CNT(rx_q->cur_rx, rx_q->dirty_rx,
+			priv->dma_conf.dma_rx_size);
 }
 
 static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
@@ -4571,8 +4562,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* If we only have one entry used, then the first entry is the last
 	 * segment.
 	 */
-	is_last_segment = ((tx_q->cur_tx - first_entry) &
-			   (priv->dma_conf.dma_tx_size - 1)) == 1;
+	is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry,
+				   priv->dma_conf.dma_tx_size) == 1;
 
 	/* Complete the first descriptor before granting the DMA */
 	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
-- 
2.47.3


