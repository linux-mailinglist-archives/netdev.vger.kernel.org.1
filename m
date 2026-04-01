Return-Path: <netdev+bounces-274077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIlIAXcTzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:45:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7D37AAC1
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25092318C5E0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A3401A06;
	Wed,  1 Apr 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="brDjBLXn"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5273F7E98;
	Wed,  1 Apr 2026 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045207; cv=none; b=a8clB2VjaWlLHrNfMW5RJGLpXLGuZtwYwhjhwEgslpPw8m+xubq0d2atcJIhc0kHhF3FUhtDjVpmPxP3FgxEXAYtxlwDQwS+wV3/gKOKSmWMOzkD3dhcEwJLtF2ffOOQXxMuPrqptNuDsM65BVMNmOm53dJ6vHSfacoSCTAIncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045207; c=relaxed/simple;
	bh=MTmvBtZd/sjRcIktgSvHy1gERFiqdGjvRNbfBBKS54M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwOCEbP5LKHWQDuojOUTfFNMtoTEbHjdUHlcOaO2TJe76K2kBicnh1IJ7KmE3CHmYkj6mdcm/Y5Su7trnKKigcGL6zL4k/If93vMuOwtCBu9oNWW3XmhtG4visYosBixRtIotMvzEJ+c+wpshaY5DQHmm8w4Do/A3/bPYZkLgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=brDjBLXn; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Xz26XmtLPh8Q2Btds6GvvjYzsY1TXEbe251OyLODAwU=; b=brDjBLXn/qdmzEzVOCUUZqcQ8B
	c611c7W5boiORR/heLJgtZPx6iK6ej3Us/6D6DYXUcf0IyxHpvL+oO06G8TftLKTmSNCKpaicdGFy
	vFoYZUT0/p4Wi8QxuTGq5bzG74yD6uqP4U+8rJP0oWSnLYvKt+VeQNriSavl8mClgZsCJ0akiT+wT
	45yR5Ryp31PxjE13ahZbJW1MTryHgFplznyycLTUAgrgvJ/A07qltrnrANgR4O+0ZkAA5/oO7D26v
	lTtjibK1ts6JIu8+E+hvRcAXw2fYNVMu1zEogQvCWGY6bOZhk1DuyRuZxdC/DDrhSvDRHnHFYU4SH
	d2x0PA8A==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7uLI-000FD0-13;
	Wed, 01 Apr 2026 14:06:40 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7uLH-000JGT-2r;
	Wed, 01 Apr 2026 14:06:39 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH net-next v3 2/2] net: ethernet: ti: am65-cpsw: add support for J722S SoC family
Date: Wed,  1 Apr 2026 14:05:43 +0200
Message-ID: <a6e31f3bf2f540d3c97574fbfdc0f2a4c1db72ce.1774958552.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e7ec1b928357d1240a962a88dc6ac67fd2c92357.1774958552.git.nora.schiffer@ew.tq-group.com>
References: <e7ec1b928357d1240a962a88dc6ac67fd2c92357.1774958552.git.nora.schiffer@ew.tq-group.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ew.tq-group.com:dkim,ew.tq-group.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email,tq-group.com:url]
X-Rspamd-Queue-Id: 4BF7D37AAC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW3G is mostly identical to the AM64's, but additionally
supports SGMII.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---

v2: drop AM64_CPSW_QUIRK_CUT_THRU flag, which is a downstream ti-linux feature
v3: resubmission for net-next, no changes

SGMII operation also requires changes to the phy-j721e-wiz and gmii-sel drivers.
The full series was previously posted here:
https://lore.kernel.org/lkml/cover.1774354734.git.nora.schiffer@ew.tq-group.com/

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index d9400599e80a4..7ac75fc8cdcf4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3468,6 +3468,13 @@ static const struct am65_cpsw_pdata am64x_cpswxg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
 };
 
+static const struct am65_cpsw_pdata j722s_cpswxg_pdata = {
+	.quirks = AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ,
+	.ale_dev_id = "am64-cpswxg",
+	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
+	.extra_modes = BIT(PHY_INTERFACE_MODE_SGMII),
+};
+
 static const struct am65_cpsw_pdata j7200_cpswxg_pdata = {
 	.quirks = 0,
 	.ale_dev_id = "am64-cpswxg",
@@ -3495,6 +3502,7 @@ static const struct of_device_id am65_cpsw_nuss_of_mtable[] = {
 	{ .compatible = "ti,am654-cpsw-nuss", .data = &am65x_sr1_0},
 	{ .compatible = "ti,j721e-cpsw-nuss", .data = &j721e_pdata},
 	{ .compatible = "ti,am642-cpsw-nuss", .data = &am64x_cpswxg_pdata},
+	{ .compatible = "ti,j722s-cpsw-nuss", .data = &j722s_cpswxg_pdata},
 	{ .compatible = "ti,j7200-cpswxg-nuss", .data = &j7200_cpswxg_pdata},
 	{ .compatible = "ti,j721e-cpswxg-nuss", .data = &j721e_cpswxg_pdata},
 	{ .compatible = "ti,j784s4-cpswxg-nuss", .data = &j784s4_cpswxg_pdata},
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

