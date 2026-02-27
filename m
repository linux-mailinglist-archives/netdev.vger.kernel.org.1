Return-Path: <netdev+bounces-261795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAhnLXtqoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:57:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFEC1B5A50
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660AC315F223
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B235A3AE;
	Fri, 27 Feb 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A2JgBqgM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2F1F03D7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186024; cv=none; b=rIoTmmNBWN81G8h1YiHu82KXhaHrJCQjxgxuyt2S5OWYq5jJrhJztv0xZ0lyc5BYf6HzOGzjqxwHxShtozJ1ktRvMp66Hd17Br29zKye9Lk07d6xdpR6rVmnkE8z5kzXbrWOwsJ+XouhqbO8KPjpicYKRysAnddnh4b6LLe5l9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186024; c=relaxed/simple;
	bh=K3BpJdU5+Jd1kBV1vnTYEt/igsaELebDjb4YX8rjfpg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dxY3peuB5ejYGzl0kkMNDZi2WbkChawSq5W2uB6xfNw4XqKEChOlSHRO1uRoOV4WY874XE+d2kakqUR4Y+kB9UmJXBkcNfVuBdxq9CwGhppGlZ8awhfgpU62efRCvlVgxd743Xsprz7z5g+6di+U6OD+AN6x3HeFDl6HKCmVu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A2JgBqgM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=31vJg1g4NNHGSCqJsTr8a5NJoJSqe19lfVdZJfDeVP0=; b=A2JgBqgM8+w7rRpLwmo3/O5YZ0
	P92XmDcyKfzR6U7mCIjvSwi0Oz7sBIZwZBfHkKNf1Cv1zKR5alDBnBzvDXHpM0fzCX+p/OmkAjJlu
	8G3fmHSDvYOfd7wZGY11E8Tzr2AUx0fTOAlX9y8IdriJQpZbQr2pT8ozupOTyfnbfGhQGZ/D77LXp
	09/Yno+SIC7EmU7ZVCgnH8rU52nQbkfvt2LW94d+LiJuswTXku54LK2zUbnhBH6VpitAa0+5esJ4u
	6DszAZQefnGkGY1wyV79V/lMjo/kaX/Re9IaUU2XiC52SxWDenLOrmwCRwpjLJvbOLzYqLRh2bC3Y
	KivLqe+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43978 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXL-000000000cw-0U34;
	Fri, 27 Feb 2026 09:53:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXJ-0000000Avmx-1B8Y;
	Fri, 27 Feb 2026 09:53:29 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 05/14] net: stmmac: remove .get_tx_len()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXJ-0000000Avmx-1B8Y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:29 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261795-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 1AFEC1B5A50
X-Rspamd-Action: no action

No code calls stmmac_get_tx_len(). Remove this macro, its associated
function pointer, and all implementations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   | 6 ------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ------
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c       | 6 ------
 drivers/net/ethernet/stmicro/stmmac/hwif.h           | 4 ----
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c      | 6 ------
 5 files changed, 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 56a88b71def9..1bbf02504dad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -171,11 +171,6 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 	return ret;
 }
 
-static int dwmac4_rd_get_tx_len(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des2) & TDES2_BUFFER1_SIZE_MASK);
-}
-
 static void dwmac4_set_tx_owner(struct dma_desc *p)
 {
 	p->des3 |= cpu_to_le32(TDES3_OWN);
@@ -540,7 +535,6 @@ static void dwmac4_set_tbs(struct dma_edesc *p, u32 sec, u32 nsec)
 const struct stmmac_desc_ops dwmac4_desc_ops = {
 	.tx_status = dwmac4_wrback_get_tx_status,
 	.rx_status = dwmac4_wrback_get_rx_status,
-	.get_tx_len = dwmac4_rd_get_tx_len,
 	.set_tx_owner = dwmac4_set_tx_owner,
 	.set_rx_owner = dwmac4_set_rx_owner,
 	.get_rx_vlan_tci = dwmac4_wrback_get_rx_vlan_tci,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index f5deceb052d7..1009ef436a1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -40,11 +40,6 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
 	return good_frame;
 }
 
-static int dwxgmac2_get_tx_len(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des2) & XGMAC_TDES2_B1L);
-}
-
 static void dwxgmac2_set_tx_owner(struct dma_desc *p)
 {
 	p->des3 |= cpu_to_le32(XGMAC_TDES3_OWN);
@@ -345,7 +340,6 @@ static void dwxgmac2_set_tbs(struct dma_edesc *p, u32 sec, u32 nsec)
 const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.tx_status = dwxgmac2_get_tx_status,
 	.rx_status = dwxgmac2_get_rx_status,
-	.get_tx_len = dwxgmac2_get_tx_len,
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 3c241c5699ed..ead468f4b645 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -76,11 +76,6 @@ static int enh_desc_get_tx_status(struct stmmac_extra_stats *x,
 	return ret;
 }
 
-static int enh_desc_get_tx_len(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des1) & ETDES1_BUFFER1_SIZE_MASK);
-}
-
 static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
 {
 	int ret = good_frame;
@@ -435,7 +430,6 @@ static void enh_desc_clear(struct dma_desc *p)
 const struct stmmac_desc_ops enh_desc_ops = {
 	.tx_status = enh_desc_get_tx_status,
 	.rx_status = enh_desc_get_rx_status,
-	.get_tx_len = enh_desc_get_tx_len,
 	.init_rx_desc = enh_desc_init_rx_desc,
 	.init_tx_desc = enh_desc_init_tx_desc,
 	.release_tx_desc = enh_desc_release_tx_desc,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e317f64a0fcc..374f326efa01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -63,8 +63,6 @@ struct stmmac_desc_ops {
 	/* Return the transmit status looking at the TDES1 */
 	int (*tx_status)(struct stmmac_extra_stats *x,
 			 struct dma_desc *p, void __iomem *ioaddr);
-	/* Get the buffer size from the descriptor */
-	int (*get_tx_len)(struct dma_desc *p);
 	/* Handle extra events on specific interrupts hw dependent */
 	void (*set_rx_owner)(struct dma_desc *p, int disable_rx_ic);
 	/* Get the receive frame size */
@@ -123,8 +121,6 @@ struct stmmac_desc_ops {
 	stmmac_do_callback(__priv, desc, get_rx_vlan_valid, __args)
 #define stmmac_tx_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, tx_status, __args)
-#define stmmac_get_tx_len(__priv, __args...) \
-	stmmac_do_callback(__priv, desc, get_tx_len, __args)
 #define stmmac_set_rx_owner(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, set_rx_owner, __args)
 #define stmmac_get_rx_frame_len(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 621bc1deb4e5..7c3a818c33c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -55,11 +55,6 @@ static int ndesc_get_tx_status(struct stmmac_extra_stats *x,
 	return ret;
 }
 
-static int ndesc_get_tx_len(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des1) & RDES1_BUFFER1_SIZE_MASK);
-}
-
 /* This function verifies if each incoming frame has some errors
  * and, if required, updates the multicast statistics.
  * In case of success, it returns good_frame because the GMAC device
@@ -281,7 +276,6 @@ static void ndesc_clear(struct dma_desc *p)
 const struct stmmac_desc_ops ndesc_ops = {
 	.tx_status = ndesc_get_tx_status,
 	.rx_status = ndesc_get_rx_status,
-	.get_tx_len = ndesc_get_tx_len,
 	.init_rx_desc = ndesc_init_rx_desc,
 	.init_tx_desc = ndesc_init_tx_desc,
 	.release_tx_desc = ndesc_release_tx_desc,
-- 
2.47.3


