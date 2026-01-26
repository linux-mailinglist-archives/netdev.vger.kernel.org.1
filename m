Return-Path: <netdev+bounces-253455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAF7JExVd2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:51:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3287D86
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F8930C45BF
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1968633343B;
	Mon, 26 Jan 2026 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nFHLjqaE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C11DEFE9
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428017; cv=none; b=W/HAK1YW0FXEOboPMelt7shZicYs/EV6XywFtJnLmOZnxK7waszhcljCIsoWQvUSJeCzk1O0phatpoxZq976wi71ETYxFOR9JV+XZk4f/V+O43mO7XX4WX7QyZ5CBu5Mwc/FepiKVUcss6mfghYN6jwEVgwtgLNAsgYHIhu83aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428017; c=relaxed/simple;
	bh=vb8xcz/Stn1lzMkNNBJiH6Q0/QPRVbNYUJPBBgAC0W8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gsl+GEgrkt3ZMU2NU/uQmRfOHaovdUw6MvBOhlF9caNaOrpnd1myHwCTFBXddYT+wLu3rWqg/dnXDr504BbXHFhJZlzbJ7ecf0xGgJevL1O+HU7L/7HxOqEs29/WkfmkAQ6tnxq+WvjF6p8nhe+WOgbqjFWLjZCmStP25ve7No4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nFHLjqaE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pFCqNMcrXS3bpDjc1D7RmTS1XUXTFtoDIg63R2+VCus=; b=nFHLjqaEv4CNVjFPokl8HDfsEF
	AvKwD9KDWaSQ8QkWf+oB3mXwNkx48RBpZZvPJo7vxedO80CKX+O12zWUwK/zVPaLRkOYmtyAFHHMB
	7de9DKg8VUeF6tvkRlN0iswlIzHb/49WnBO5VWZ+OnEifFNZQ7PSD+wQ/aGuMzpwfrdWTLtqkHe6z
	DCH2FIei8y/hlbyQVtCUv/qIiVhyEyWENG+yupy7ZhT95sHidSV3F5kM/k9guKrTyfpOQORV+8DjW
	s65rWvIn7iWhRe/1YF3lWpcIcXqdNhK8o+uMBIOoBp7nBM/jwnGF3UZRf/6ziZ29QlrP2Y/Dda39b
	6jhPJqVA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38878 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL3O-000000004jk-2xVM;
	Mon, 26 Jan 2026 11:46:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL3N-00000005uuA-2GnK;
	Mon, 26 Jan 2026 11:46:45 +0000
In-Reply-To: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 21/22] net: stmmac: rk: use rk_encode_wm16() for
 clock selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL3N-00000005uuA-2GnK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:46:45 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253455-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07E3287D86
X-Rspamd-Action: no action

Use rk_encode_wm16() for RMII clock gating control, and also for the
io_clksel bit used to select the transmit clock between CRU-derived
and IO-derived clock sources.

Both of these were configured via the "set_clock_selection" method in
the SoC specific operations, but there is no requirement to change the
io_clksel except when enabling clocks.

It is also possible that we don't need to ungate the RMII clock if we
are operating in RGMII mode, but this commit makes no change there.

Split up the configuration of these as separate functions, and remove
the set_clock_selection() method. Since these clocking bits are in the
same register that we call the "speed" register, move the logic for
writing that register into rk_write_speed_grf_reg().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 174 ++++++++----------
 1 file changed, 75 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 26fc93854cb0..443d3bd62cae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -27,8 +27,17 @@
 struct rk_priv_data;
 
 struct rk_clock_fields {
+	/* io_clksel_cru_mask - io_clksel bit in clock GRF register which,
+	 * when set, selects the tx clock from CRU.
+	 */
+	u16 io_clksel_cru_mask;
+	/* io_clksel_io_mask - io_clksel bit in clock GRF register which,
+	 * when set, selects the tx clock from IO.
+	 */
+	u16 io_clksel_io_mask;
 	u16 gmii_clk_sel_mask;
 	u16 rmii_clk_sel_mask;
+	u16 rmii_gate_en_mask;
 	u16 mac_speed_mask;
 };
 
@@ -39,8 +48,6 @@ struct rk_gmac_ops {
 	void (*set_to_rmii)(struct rk_priv_data *bsp_priv);
 	int (*set_speed)(struct rk_priv_data *bsp_priv,
 			 phy_interface_t interface, int speed);
-	void (*set_clock_selection)(struct rk_priv_data *bsp_priv, bool input,
-				    bool enable);
 	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
 	void (*integrated_phy_powerdown)(struct rk_priv_data *bsp_priv);
 
@@ -171,6 +178,54 @@ static int rk_write_clock_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
 	return regmap_write(regmap, bsp_priv->clock_grf_reg, val);
 }
 
+static int rk_set_rmii_gate_en(struct rk_priv_data *bsp_priv, bool state)
+{
+	u32 val;
+
+	if (!bsp_priv->clock.rmii_gate_en_mask)
+		return 0;
+
+	val = rk_encode_wm16(state, bsp_priv->clock.rmii_gate_en_mask);
+
+	return rk_write_clock_grf_reg(bsp_priv, val);
+}
+
+static int rk_ungate_rmii_clock(struct rk_priv_data *bsp_priv)
+{
+	return rk_set_rmii_gate_en(bsp_priv, false);
+}
+
+static int rk_gate_rmii_clock(struct rk_priv_data *bsp_priv)
+{
+	return rk_set_rmii_gate_en(bsp_priv, true);
+}
+
+static int rk_configure_io_clksel(struct rk_priv_data *bsp_priv)
+{
+	bool io, cru;
+	u32 val;
+
+	if (!bsp_priv->clock.io_clksel_io_mask &&
+	    !bsp_priv->clock.io_clksel_cru_mask)
+		return 0;
+
+	io = bsp_priv->clock_input;
+	cru = !io;
+
+	/* The io_clksel configuration can be either:
+	 *  0=CRU, 1=IO (rk3506, rk3520, rk3576) or
+	 *  0=IO, 1=CRU (rk3588)
+	 * where CRU means the transmit clock comes from the CRU and IO
+	 * means the transmit clock comes from IO.
+	 *
+	 * Handle this by having two masks.
+	 */
+	val = rk_encode_wm16(io, bsp_priv->clock.io_clksel_io_mask) |
+	      rk_encode_wm16(cru, bsp_priv->clock.io_clksel_cru_mask);
+
+	return rk_write_clock_grf_reg(bsp_priv, val);
+}
+
 static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 				phy_interface_t interface, int speed)
 {
@@ -637,12 +692,6 @@ static const struct rk_gmac_ops rk3399_ops = {
 
 #define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
 
-#define RK3506_GMAC_CLK_SELECT_CRU	GRF_CLR_BIT(5)
-#define RK3506_GMAC_CLK_SELECT_IO	GRF_BIT(5)
-
-#define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
-#define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
-
 static int rk3506_init(struct rk_priv_data *bsp_priv)
 {
 	switch (bsp_priv->id) {
@@ -667,26 +716,13 @@ static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
 }
 
-static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
-				       bool input, bool enable)
-{
-	unsigned int value, offset, id = bsp_priv->id;
-
-	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
-
-	value = input ? RK3506_GMAC_CLK_SELECT_IO :
-			RK3506_GMAC_CLK_SELECT_CRU;
-	value |= enable ? RK3506_GMAC_CLK_RMII_NOGATE :
-			  RK3506_GMAC_CLK_RMII_GATE;
-	regmap_write(bsp_priv->grf, offset, value);
-}
-
 static const struct rk_gmac_ops rk3506_ops = {
 	.init = rk3506_init,
 	.set_to_rmii = rk3506_set_to_rmii,
-	.set_clock_selection = rk3506_set_clock_selection,
 
+	.clock.io_clksel_io_mask = BIT_U16(5),
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
+	.clock.rmii_gate_en_mask = BIT_U16(2),
 
 	.regs_valid = true,
 	.regs = {
@@ -714,27 +750,22 @@ static const struct rk_gmac_ops rk3506_ops = {
 #define RK3528_GMAC1_PHY_INTF_SEL_RGMII	GRF_CLR_BIT(8)
 #define RK3528_GMAC1_PHY_INTF_SEL_RMII	GRF_BIT(8)
 
-#define RK3528_GMAC1_CLK_SELECT_CRU	GRF_CLR_BIT(12)
-#define RK3528_GMAC1_CLK_SELECT_IO	GRF_BIT(12)
-
-#define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
-#define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
-#define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
-#define RK3528_GMAC1_CLK_RMII_NOGATE	GRF_CLR_BIT(9)
-
 static int rk3528_init(struct rk_priv_data *bsp_priv)
 {
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->clock_grf_reg = RK3528_VO_GRF_GMAC_CON;
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(3);
+		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(2);
 		bsp_priv->supports_rgmii = false;
 		return 0;
 
 	case 1:
 		bsp_priv->clock_grf_reg = RK3528_VPU_GRF_GMAC_CON5;
+		bsp_priv->clock.io_clksel_io_mask = BIT_U16(12);
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(11, 10);
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(10);
+		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(9);
 		return 0;
 
 	default:
@@ -766,24 +797,6 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 			     RK3528_GMAC0_PHY_INTF_SEL_RMII);
 }
 
-static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
-				       bool input, bool enable)
-{
-	unsigned int val;
-
-	if (bsp_priv->id == 1) {
-		val = input ? RK3528_GMAC1_CLK_SELECT_IO :
-			      RK3528_GMAC1_CLK_SELECT_CRU;
-		val |= enable ? RK3528_GMAC1_CLK_RMII_NOGATE :
-				RK3528_GMAC1_CLK_RMII_GATE;
-		regmap_write(bsp_priv->grf, RK3528_VPU_GRF_GMAC_CON5, val);
-	} else {
-		val = enable ? RK3528_GMAC0_CLK_RMII_NOGATE :
-			       RK3528_GMAC0_CLK_RMII_GATE;
-		regmap_write(bsp_priv->grf, RK3528_VO_GRF_GMAC_CON, val);
-	}
-}
-
 static void rk3528_integrated_phy_powerup(struct rk_priv_data *bsp_priv)
 {
 	rk_gmac_integrated_fephy_powerup(bsp_priv, RK3528_VO_GRF_MACPHY_CON0);
@@ -798,7 +811,6 @@ static const struct rk_gmac_ops rk3528_ops = {
 	.init = rk3528_init,
 	.set_to_rgmii = rk3528_set_to_rgmii,
 	.set_to_rmii = rk3528_set_to_rmii,
-	.set_clock_selection = rk3528_set_clock_selection,
 	.integrated_phy_powerup = rk3528_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk3528_integrated_phy_powerdown,
 	.regs_valid = true,
@@ -896,12 +908,6 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3576_GRF_GMAC_CON0			0X0020
 #define RK3576_GRF_GMAC_CON1			0X0024
 
-#define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
-#define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
-
-#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
-#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
-
 static int rk3576_init(struct rk_priv_data *bsp_priv)
 {
 	switch (bsp_priv->id) {
@@ -943,31 +949,16 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
 }
 
-static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
-				       bool enable)
-{
-	unsigned int val = input ? RK3576_GMAC_CLK_SELECT_IO :
-				   RK3576_GMAC_CLK_SELECT_CRU;
-	unsigned int offset_con;
-
-	val |= enable ? RK3576_GMAC_CLK_RMII_NOGATE :
-			RK3576_GMAC_CLK_RMII_GATE;
-
-	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
-					 RK3576_GRF_GMAC_CON0;
-
-	regmap_write(bsp_priv->grf, offset_con, val);
-}
-
 static const struct rk_gmac_ops rk3576_ops = {
 	.init = rk3576_init,
 	.set_to_rgmii = rk3576_set_to_rgmii,
-	.set_clock_selection = rk3576_set_clock_selection,
 
 	.gmac_rmii_mode_mask = BIT_U16(3),
 
+	.clock.io_clksel_io_mask = BIT_U16(7),
 	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
 	.clock.rmii_clk_sel_mask = BIT_U16(5),
+	.clock.rmii_gate_en_mask = BIT_U16(4),
 
 	.supports_rmii = true,
 
@@ -1000,25 +991,23 @@ static const struct rk_gmac_ops rk3576_ops = {
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
 
-#define RK3588_GMAC_CLK_SELECT_CRU(id)		GRF_BIT(5 * (id) + 4)
-#define RK3588_GMAC_CLK_SELECT_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
-
-#define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
-#define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
-
 static int rk3588_init(struct rk_priv_data *bsp_priv)
 {
 	switch (bsp_priv->id) {
 	case 0:
 		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
+		bsp_priv->clock.io_clksel_cru_mask = BIT_U16(4);
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(3, 2);
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(2);
+		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(1);
 		return 0;
 
 	case 1:
 		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
+		bsp_priv->clock.io_clksel_cru_mask = BIT_U16(10);
 		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(8, 7);
 		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(7);
+		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(6);
 		return 0;
 
 	default:
@@ -1052,23 +1041,10 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
-static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
-				       bool enable)
-{
-	unsigned int val = input ? RK3588_GMAC_CLK_SELECT_IO(bsp_priv->id) :
-				   RK3588_GMAC_CLK_SELECT_CRU(bsp_priv->id);
-
-	val |= enable ? RK3588_GMAC_CLK_RMII_NOGATE(bsp_priv->id) :
-			RK3588_GMAC_CLK_RMII_GATE(bsp_priv->id);
-
-	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1, val);
-}
-
 static const struct rk_gmac_ops rk3588_ops = {
 	.init = rk3588_init,
 	.set_to_rgmii = rk3588_set_to_rgmii,
 	.set_to_rmii = rk3588_set_to_rmii,
-	.set_clock_selection = rk3588_set_clock_selection,
 
 	.gmac_grf_reg_in_php = true,
 	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,
@@ -1216,19 +1192,15 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 			if (ret)
 				return ret;
 
-			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection)
-				bsp_priv->ops->set_clock_selection(bsp_priv,
-					       bsp_priv->clock_input, true);
+			rk_configure_io_clksel(bsp_priv);
+			rk_ungate_rmii_clock(bsp_priv);
 
 			mdelay(5);
 			bsp_priv->clk_enabled = true;
 		}
 	} else {
 		if (bsp_priv->clk_enabled) {
-			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection) {
-				bsp_priv->ops->set_clock_selection(bsp_priv,
-					      bsp_priv->clock_input, false);
-			}
+			rk_gate_rmii_clock(bsp_priv);
 
 			clk_bulk_disable_unprepare(bsp_priv->num_clks,
 						   bsp_priv->clks);
@@ -1394,6 +1366,10 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 		}
 	}
 
+	if (bsp_priv->clock.io_clksel_cru_mask &&
+	    bsp_priv->clock.io_clksel_io_mask)
+		dev_warn(dev, "both CRU and IO io_clksel masks should not be populated - driver may malfunction\n");
+
 	return bsp_priv;
 }
 
-- 
2.47.3


