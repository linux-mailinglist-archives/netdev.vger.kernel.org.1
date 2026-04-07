Return-Path: <netdev+bounces-275964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLB9Ox3u1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:44:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9B3ADE1F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 671C830193B1
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6056B3B2FF9;
	Tue,  7 Apr 2026 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ajrRcvBo"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED503B0AFC;
	Tue,  7 Apr 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562195; cv=none; b=WrR9GZm9pdA0UFfeMNhs/tpSTwypw/t3CqcV3Mw9hPCqi15zEb7WguAHF2PYCZZgOphf+1akERhFVqN7E6vGJAIyE8hK6bdlYuIkIWJoHqS+RH0frotndCBYc2iqUaXg7i7tu6Z5lBHbm0/cgVV+LAsAFz0PDgAkf3N8CWr2DIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562195; c=relaxed/simple;
	bh=elOkFKDQ2iLnY6Lwi1yUa5fsSkfhgO+93XSNmLHQ0PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URIXz1smeA1X6D+pbnsA8vsdw8moJ/HT2tsi231u21eAuRYFvrJZ4uPHx1V/twV2F0kXyYDZewIin4hUGqHIT6aO9HVZX7C8lqyHoUZ6QIFxQeQgzfURtRJTRLhIQTFhPQ2F2Sx0KVav79+PoEa6KyzSJRj9pnHKEku3X2b7Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ajrRcvBo; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fdD+gNdnYJuuk/C6povOAz6skeNjsbW/eErWFsyNXSU=; b=ajrRcvBo+p1k6zd4SeXtj8Qp8o
	080UcdpqP5fCFOgaJjm/ZJdKW6YaRtLUFAdhvXva50WTF60Cd0rIqB0F5/C1G6kiQnPUDkJZaRXbL
	yLxuwRBDS24G+DNlY36dIj/A67jq4xZ0pdYbzgFgKQgNIX4zCrlagGo4rEGhraUUjp1eb++dib6cX
	BPSn23DYQgK9RK6rivi5oMwo/egN3hp104THxhWRWJ/DEDdX1n1DRCNS7AFT+iF8TNlSn89KDX+qq
	p45k+hjSX5+tvlTFxBrmqnLC+UrqUTQHtJNNW+rulFoA0uu7OxyxrrxxmvsAyNQN3cAHepN7GZFT4
	Hr+FcXEw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pq-000IJz-2W;
	Tue, 07 Apr 2026 13:43:10 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1wA4pp-000PKA-0f;
	Tue, 07 Apr 2026 13:43:10 +0200
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
Subject: [PATCH v4 4/5] phy: ti: gmii-sel: add support for J722S SoC family
Date: Tue,  7 Apr 2026 13:42:36 +0200
Message-ID: <86488589fc055f61ee5341f9e268184f04febe71.1775559102.git.nora.schiffer@ew.tq-group.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: F0F9B3ADE1F
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


