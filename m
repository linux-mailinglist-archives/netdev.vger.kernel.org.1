Return-Path: <netdev+bounces-275962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEPDNNzt1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CAB3ADDD2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 167DB301EC59
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453C3AF656;
	Tue,  7 Apr 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZQMAIW06"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE33ACF05;
	Tue,  7 Apr 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562193; cv=none; b=RxHQ1CahiNR4+Q5JTUQPkEDphkc1NxZboDo99b8oJcBCI3SDriSSRqTxtryedMhHkaxBdLQz/2f8HBKC+J3mzg+EcfPkAUcDN2IRjLab9DRTUITXbTtTVdF3UKWfR2uCM19FMqxUbZep+lmu7gtyZuJG8poYzqSX6Jk6F0Kabr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562193; c=relaxed/simple;
	bh=jcplQi3Mocc1VLQA6H9ineVeTMeOKfBlXqPAmboXcHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZFwVDodj5KOWYdfcWTkxFTeTDNvPK1XzT5uDuNoA5Dtg9rJ7ec6YCGTlnQh3Vtcy/Z0DoYUpbiIBV4sZH7adVIhzx1G2F8fGE3m/fRATqZ2rkgA89bJhfdpFinozbJRK4SvKoxcK5kTzecp3WDswIXLbmgzboBgmuj0g58hieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZQMAIW06; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KqcLRKudHgKSmtkMDFCAvoKWKKoLB9Rc1nid7QyUgsk=; b=ZQMAIW06WFwC6TCvlHx/o4QL4L
	ODT71KRlCXZXffBkox00Ze6KySpdr3z/rc6soWF3hiDlReo9bIHoMBakgWZ7wWIXiC0VYNzvosFSz
	KQcJxrxrBVJqoJYDL2XaUZ0dYPMUbFKNm1CIHxpQbuos6Af3P88wHyCZluY4g0f1CThWZ/0qnGpte
	Vb/kHQCXeLSC3UhOFOqUgjnNtpzuA/8GHrHBzTxV31ZXrtXShFIyl58t4p0nl9Euq6STvfxwQ0VD0
	Mvz0QJEPkY+U08HNSh442Dhyc3MS5HcSYYmjKV7paL0cjjbLz3HFRejBQcu2SIovBas6K8ZiOG+0N
	i9vtlTJQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pp-000IJf-2r;
	Tue, 07 Apr 2026 13:43:09 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4po-000PKA-14;
	Tue, 07 Apr 2026 13:43:09 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v4 3/5] phy: ti: phy-j721e-wiz: add support for J722S SoC family
Date: Tue,  7 Apr 2026 13:42:35 +0200
Message-ID: <85e9f67f8673dc7039ab87c34cfc9e4de1c7447c.1775559102.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 87CAB3ADDD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S WIZ is mostly identical to the AM64's, but additionally supports
SGMII.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 6b584706b913a..7531a8a049123 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -331,6 +331,7 @@ enum wiz_type {
 	J721E_WIZ_16G,
 	J721E_WIZ_10G,	/* Also for J7200 SR1.0 */
 	AM64_WIZ_10G,
+	J722S_WIZ_10G,
 	J7200_WIZ_10G,  /* J7200 SR2.0 */
 	J784S4_WIZ_10G,
 	J721S2_WIZ_10G,
@@ -1020,6 +1021,7 @@ static void wiz_clock_cleanup(struct wiz *wiz, struct device_node *node)
 
 	switch (wiz->type) {
 	case AM64_WIZ_10G:
+	case J722S_WIZ_10G:
 	case J7200_WIZ_10G:
 	case J784S4_WIZ_10G:
 	case J721S2_WIZ_10G:
@@ -1089,6 +1091,7 @@ static void wiz_clock_init(struct wiz *wiz)
 
 	switch (wiz->type) {
 	case AM64_WIZ_10G:
+	case J722S_WIZ_10G:
 	case J7200_WIZ_10G:
 		switch (rate) {
 		case REF_CLK_100MHZ:
@@ -1158,6 +1161,7 @@ static int wiz_clock_probe(struct wiz *wiz, struct device_node *node)
 
 	switch (wiz->type) {
 	case AM64_WIZ_10G:
+	case J722S_WIZ_10G:
 	case J7200_WIZ_10G:
 	case J784S4_WIZ_10G:
 	case J721S2_WIZ_10G:
@@ -1246,6 +1250,14 @@ static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
 		if (wiz->lane_phy_type[lane] == PHY_TYPE_SGMII)
 			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x2);
 		break;
+
+	case J722S_WIZ_10G:
+		if (wiz->lane_phy_type[lane] == PHY_TYPE_PCIE)
+			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
+		if (wiz->lane_phy_type[lane] == PHY_TYPE_SGMII)
+			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x2);
+		break;
+
 	default:
 		return 0;
 	}
@@ -1350,6 +1362,15 @@ static struct wiz_data am64_10g_data = {
 	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
 };
 
+static struct wiz_data j722s_10g_data = {
+	.type = J722S_WIZ_10G,
+	.pll0_refclk_mux_sel = &pll0_refclk_mux_sel,
+	.pll1_refclk_mux_sel = &pll1_refclk_mux_sel,
+	.refclk_dig_sel = &refclk_dig_sel_10g,
+	.clk_mux_sel = clk_mux_sel_10g,
+	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
+};
+
 static struct wiz_data j7200_pg2_10g_data = {
 	.type = J7200_WIZ_10G,
 	.pll0_refclk_mux_sel = &sup_pll0_refclk_mux_sel,
@@ -1389,6 +1410,9 @@ static const struct of_device_id wiz_id_table[] = {
 	{
 		.compatible = "ti,am64-wiz-10g", .data = &am64_10g_data,
 	},
+	{
+		.compatible = "ti,j722s-wiz-10g", .data = &j722s_10g_data,
+	},
 	{
 		.compatible = "ti,j7200-wiz-10g", .data = &j7200_pg2_10g_data,
 	},
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


