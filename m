Return-Path: <netdev+bounces-274085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFsHKQMYzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:05:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5337AEB5
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB1B32AA4F9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0A3FA5FF;
	Wed,  1 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="daEpk33G"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99AD2F25F5;
	Wed,  1 Apr 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046369; cv=none; b=dRccF0klu+F76B9gOnyx7RxFPlWChPt5FQHE0S93ODe+fTK/uKotUK1nq1NEQgKwP+eHez9S7E3FrwAb69AkaZaIAQBVdV+l8+B07UlW2C6AjE+yw9VeLG0LBRrAw27bMNE45c4CityhRvxOoK8yRmdWooFYGNmFZn5jjG0jXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046369; c=relaxed/simple;
	bh=elOkFKDQ2iLnY6Lwi1yUa5fsSkfhgO+93XSNmLHQ0PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWXOxebzoKnBnmhP4zTGrDBj8o+a4QC5Zm/I0Kqars8E4EgvTImr5mD32YiaFUlnhyhFpefzEfBuqmVqY+YOgbSkAhdxGEXDrwc7+LoAQcnZrTjU8q+eb3Ixq61TNLSyw/4zJo+jKX1JHcxAKqcSE06Vg2M6eZz6b2nbqglaLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=daEpk33G; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fdD+gNdnYJuuk/C6povOAz6skeNjsbW/eErWFsyNXSU=; b=daEpk33GuNEpIhAxxg/M583qNc
	xZWuid1EuT5B0Id7XqbOvBCBMy+BWiuLdr9rgf98OwOcp/qmQRYbH3x5pqgab5r2HZjKtCqRxrT0a
	XUnQxyIr7RMT1t5qMgZvPOgZQG1rK51G0UVDTPE4Hm1bUzUZsYGyRilME6gBG4TD9X+Mw17eGOX5I
	N+2MvqoVxJq5rtdajdn1GpjRroPlHpdUmkJ27e9TM4woV4ox1WwDw3FPfGfwuNMr4/0YfOtnt39X5
	31cNM3TCHqhk8DBieX0U+/S46J9cwS+RKyTSQr0/qt6aBDPFp5qd7ZO0VQ7s2cscT/awBU7UWQBpE
	c7NZL8GA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue4-000IR7-2k;
	Wed, 01 Apr 2026 14:26:04 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue4-00089b-1B;
	Wed, 01 Apr 2026 14:26:04 +0200
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
Subject: [PATCH v3 4/5] phy: ti: gmii-sel: add support for J722S SoC family
Date: Wed,  1 Apr 2026 14:25:24 +0200
Message-ID: <25a07fea53b0f7de3cef41866e208036ef1de0d9.1775045279.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27958/Wed Apr  1 08:24:34 2026)
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
	TAGGED_FROM(0.00)[bounces-274085-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1D5337AEB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S gmii-sel is mostly identical to the AM64's, but additionally
supports SGMII.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 6213c2b6005a5..c2865a6b1d7fb 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -251,6 +251,15 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
 	.regfields = phy_gmii_sel_fields_am654,
 };
 
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_soc_j722s = {
+	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
+	.regfields = phy_gmii_sel_fields_am654,
+	.extra_modes = BIT(PHY_INTERFACE_MODE_SGMII),
+};
+
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.use_of_data = true,
@@ -307,6 +316,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
 		.compatible	= "ti,am654-phy-gmii-sel",
 		.data		= &phy_gmii_sel_soc_am654,
 	},
+	{
+		.compatible	= "ti,j722s-phy-gmii-sel",
+		.data		= &phy_gmii_sel_soc_j722s,
+	},
 	{
 		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
 		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


