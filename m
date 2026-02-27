Return-Path: <netdev+bounces-261794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJbfJWpqoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6391B5A42
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD9E3159A02
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16AE35A3A4;
	Fri, 27 Feb 2026 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eldennK8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA51F03D7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186019; cv=none; b=an74SXGK0XOg2zyWnbA9BWJjsm+DEpoUzfFxdNeQh1Uo8DdpBOa8RI14eDfTjoaTsvrRXym0KkRFkPlFfAtUJpnIwgwy2+d+O6p2rtOY4Khcxed5GKGTwECxlTJ0z/lIoIKU5xVuCAQYGffdDYv/rfQsQSvtSfyhhFF5/xyirGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186019; c=relaxed/simple;
	bh=65koTnwhLReAVxZpVQeMf4uIUDr6g98sFJp2/+dQuNs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mli06oVn5L9Qh+rUahKMDXj7a2RA+YOShuozxVoLJ0w0onOpUtAKUxkjTRek51O1XDbB5Cqiio4txQPOk9XAmmQCMRYFscnsUpuCU2bKWiVngBp9RZgidINpX9Zoa3C8wz61OpEDSndH6f5UIupo14j5E0Lg0iHzXNZ6cxk3xug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eldennK8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HpbjwxiELUOxPGAuBvAylWWMUmFWvkZ3ZUdWMaGoq20=; b=eldennK8xmhR/G1rhdaVlU1iJp
	E1RgEodT8Zl8VOw8xFedxN7SSIvTvbDRvElc0u/+edz/wVN2Q1S0h/EE5JLSUSTh14zmBSg0WXuFR
	v/d6bhZuOrSB8ZtuQG+MHM2dfgFIiWQdfYwt386Sxr6FrDbWj7dXkXVr+P/DqNTL6x4jwth+ewhqC
	yxPMRbUSLu31zeJ6JIXNAjbt4LgPGEmEPZS7cO6dPVxIytcNZhu2MTkDqOtZqxUYh1vdHwCQKUU7u
	OuqEuCO7nO32wRjy5TtHJ7LN8SKEQf+00NHzVoGUWMyKwfY0rL7QsfkP7Z4CX6LtpX5nMYTz4f3/k
	un0sENcQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43848 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXG-000000000cf-09tT;
	Fri, 27 Feb 2026 09:53:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXE-0000000Avmr-0eB0;
	Fri, 27 Feb 2026 09:53:24 +0000
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
Subject: [PATCH net-next 04/14] net: stmmac: remove .get_tx_ls()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXE-0000000Avmr-0eB0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:24 +0000
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
	TAGGED_FROM(0.00)[bounces-261794-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: EF6391B5A42
X-Rspamd-Action: no action

No code calls stmmac_get_tx_ls(). Remove this macro, its associated
function pointer, and all implementations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   | 7 -------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ------
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c       | 6 ------
 drivers/net/ethernet/stmicro/stmmac/hwif.h           | 4 ----
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c      | 6 ------
 5 files changed, 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index b8fe4ad883e5..56a88b71def9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -191,12 +191,6 @@ static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 	p->des3 |= cpu_to_le32(flags);
 }
 
-static int dwmac4_get_tx_ls(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des3) & TDES3_LAST_DESCRIPTOR)
-		>> TDES3_LAST_DESCRIPTOR_SHIFT;
-}
-
 static u16 dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
 {
 	return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
@@ -549,7 +543,6 @@ const struct stmmac_desc_ops dwmac4_desc_ops = {
 	.get_tx_len = dwmac4_rd_get_tx_len,
 	.set_tx_owner = dwmac4_set_tx_owner,
 	.set_rx_owner = dwmac4_set_rx_owner,
-	.get_tx_ls = dwmac4_get_tx_ls,
 	.get_rx_vlan_tci = dwmac4_wrback_get_rx_vlan_tci,
 	.get_rx_vlan_valid = dwmac4_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwmac4_wrback_get_rx_frame_len,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 8bf373513930..f5deceb052d7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -60,11 +60,6 @@ static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 	p->des3 |= cpu_to_le32(flags);
 }
 
-static int dwxgmac2_get_tx_ls(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
-}
-
 static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
 {
 	return le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK;
@@ -353,7 +348,6 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.get_tx_len = dwxgmac2_get_tx_len,
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
-	.get_tx_ls = dwxgmac2_get_tx_ls,
 	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
 	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 77b2cb34aa0e..3c241c5699ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -287,11 +287,6 @@ static void enh_desc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
 
-static int enh_desc_get_tx_ls(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des0) & ETDES0_LAST_SEGMENT) >> 29;
-}
-
 static void enh_desc_release_tx_desc(struct dma_desc *p, int mode)
 {
 	int ter = (le32_to_cpu(p->des0) & ETDES0_END_RING) >> 21;
@@ -446,7 +441,6 @@ const struct stmmac_desc_ops enh_desc_ops = {
 	.release_tx_desc = enh_desc_release_tx_desc,
 	.prepare_tx_desc = enh_desc_prepare_tx_desc,
 	.set_tx_ic = enh_desc_set_tx_ic,
-	.get_tx_ls = enh_desc_get_tx_ls,
 	.set_tx_owner = enh_desc_set_tx_owner,
 	.set_rx_owner = enh_desc_set_rx_owner,
 	.get_rx_frame_len = enh_desc_get_rx_frame_len,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 50ca8dcea2fd..e317f64a0fcc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -56,8 +56,6 @@ struct stmmac_desc_ops {
 	/* Clear interrupt on tx frame completion. When this bit is
 	 * set an interrupt happens as soon as the frame is transmitted */
 	void (*set_tx_ic)(struct dma_desc *p);
-	/* Last tx segment reports the transmit status */
-	int (*get_tx_ls)(struct dma_desc *p);
 	/* Get the tag of the descriptor */
 	u16 (*get_rx_vlan_tci)(struct dma_desc *p);
 	/* Get the valid status of descriptor */
@@ -119,8 +117,6 @@ struct stmmac_desc_ops {
 	stmmac_do_void_callback(__priv, desc, release_tx_desc, __args)
 #define stmmac_set_tx_ic(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, set_tx_ic, __args)
-#define stmmac_get_tx_ls(__priv, __args...) \
-	stmmac_do_callback(__priv, desc, get_tx_ls, __args)
 #define stmmac_get_rx_vlan_tci(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, get_rx_vlan_tci, __args)
 #define stmmac_get_rx_vlan_valid(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index e9face06b950..621bc1deb4e5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -151,11 +151,6 @@ static void ndesc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
 
-static int ndesc_get_tx_ls(struct dma_desc *p)
-{
-	return (le32_to_cpu(p->des1) & TDES1_LAST_SEGMENT) >> 30;
-}
-
 static void ndesc_release_tx_desc(struct dma_desc *p, int mode)
 {
 	int ter = (le32_to_cpu(p->des1) & TDES1_END_RING) >> 25;
@@ -292,7 +287,6 @@ const struct stmmac_desc_ops ndesc_ops = {
 	.release_tx_desc = ndesc_release_tx_desc,
 	.prepare_tx_desc = ndesc_prepare_tx_desc,
 	.set_tx_ic = ndesc_set_tx_ic,
-	.get_tx_ls = ndesc_get_tx_ls,
 	.set_tx_owner = ndesc_set_tx_owner,
 	.set_rx_owner = ndesc_set_rx_owner,
 	.get_rx_frame_len = ndesc_get_rx_frame_len,
-- 
2.47.3


