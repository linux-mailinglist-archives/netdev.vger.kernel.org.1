Return-Path: <netdev+bounces-271030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMYhAuCIwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:51:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AB308AC2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5257F303A8C4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0A3F99D9;
	Tue, 24 Mar 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="c76tjtOf"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C573F87FF;
	Tue, 24 Mar 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355429; cv=none; b=OI1/xD7KxMwzu7Z8IFzfV5V0eVyDnJAzOe5uGshi1e2EA++ug8nGdmnPlMMc7apuWEE3HT/29BYWbz3z9+t6UZBzCOwZ6Fu25YraQe9mh6HZ8pN8ru1ANhj/9zDB5kViZzCS6Jti4TudxoumHLDE6yTQ4Kp2tU9paBAJClBMiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355429; c=relaxed/simple;
	bh=jcplQi3Mocc1VLQA6H9ineVeTMeOKfBlXqPAmboXcHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbM0QM1j6nUPyjM+TMq6xVUbz/2vF16EyUy0CL9orCaNDplog/MPQ0EFs/Iod+F10YISlfZCWyQTr6qMZyCdmYcdOquM5T7+9sQJ1VRzJMD/UNWjEFvKhFwLW0rXrhSFRgsGz+7Dyy1jPI1PGBMaKLyTo3Nw5cXNGErK22gxSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=c76tjtOf; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KqcLRKudHgKSmtkMDFCAvoKWKKoLB9Rc1nid7QyUgsk=; b=c76tjtOf9ZadDn52buaIMXYV9x
	I3eh3Ugqpq5lz/jLCzFReaKfl/3oZh6fCQas8DZU7GjxfkFu4j8uAkpIfWr9c7qtk+CK5xW6zrfUA
	ADBXdZTWSh3e/FeNjpTckiSLhzxmI2DxK7iTXaXE7XglyuAgMJ4AZkP0oV3BtHc7NeCuQMhrOGPAQ
	dzGYHyvblvMy6fi3tWQP6HH8/rlGVDsVwGm5Y2zniBg0/U9geuCP2J0y20pd8QFFxRZdXeucSU24W
	PZOAdKXbVG0mhbvHTO6of1VvcPxP74wto3ytmI4kA+gEoOkHn8ailBGaPZm4kmeFAu1U4rtYwRC9o
	91AVNbCQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tr-0005qM-2r;
	Tue, 24 Mar 2026 13:30:23 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tr-000Pna-2M;
	Tue, 24 Mar 2026 13:30:23 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 4/7] phy: ti: phy-j721e-wiz: add support for J722S SoC family
Date: Tue, 24 Mar 2026 13:29:40 +0100
Message-ID: <2e7975baed312b8428199a88e92be47442af964f.1774354734.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
References: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27950/Tue Mar 24 07:24:19 2026)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271030-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ew.tq-group.com:dkim,ew.tq-group.com:mid,tq-group.com:email,tq-group.com:url]
X-Rspamd-Queue-Id: 6B9AB308AC2
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


