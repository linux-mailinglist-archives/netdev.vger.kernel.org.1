Return-Path: <netdev+bounces-271032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLaD2OGwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:41:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8CB30872D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4016E3073DE0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98243F99FC;
	Tue, 24 Mar 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="N1fh9Lq2"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252E3E3DB4;
	Tue, 24 Mar 2026 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355429; cv=none; b=GCfI1p8vu/XCqZ1wTd1oAGGOiwaB7r9Mz1VEOJiDM1PKSs7tBVqvVPhNXmOsfNRyHDP6TPbfW+GkMdf6e9ZVDGmKrjOKrPSNAyqnvkXiNzjh3HEYHybgT35ptoJcNGygAvvIRMzHs9mz41QmPKY9rdbSKLPIT63g7gbsj0sruBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355429; c=relaxed/simple;
	bh=k91RI3qYa2PuIIQYFtlEKrp5JQu5p3SeLNM5R1y3tNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNDD7CuSCY3/F4C/L1Wca+DncYEctePDdL2QmmMZH5JCgXBwLYDDoa89sJW5eac3WoKq2PkwimtR6rAUcNdjIWuAAQQpmmXK8nBFsdFlmPshM5T2V8W9Pvhvl2VG1W0U5OlXosn5eJcGNYuMWZU4ubBTWNLsplR9RKg1MMOJfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=N1fh9Lq2; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2V1nSrzkw8whgF6Q+7w667AJP3xXFU3VQ4vWMQ71LF8=; b=N1fh9Lq2ubwiOVhwvENsVtEux7
	1lzXIuNjTNljmOQLaFFdXGO7pC17VYM6yj3jArQfaC24cFUTP0k7hZT72ytmjaasMsjvErsZGwqs6
	oHA/I/IK+FjP6INca2SfynvLQIA0j/i60Z21oHNwbbpq0VKxxzfdcBRyu9z1V81L4ACZiskAZbJfn
	wGJ9YVsatW9zfV9+JLQ+EznvYQWI6dhuOvpiIxR6h3im256MDnMPpfq97NWTCPgcwmKpf1IiwisFj
	ACfMIXyB14ScShtxH0TVYEGlQ2O3qIrgKB8Vvk2jqmxBOKWVwZm/E3/rr91ZrGoRqj362O3hUMKXu
	ev05gPVg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tt-0005qU-08;
	Tue, 24 Mar 2026 13:30:25 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50ts-000Pna-2i;
	Tue, 24 Mar 2026 13:30:24 +0100
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
Subject: [PATCH v2 6/7] net: ethernet: ti: am65-cpsw: add support for J722S SoC family
Date: Tue, 24 Mar 2026 13:29:42 +0100
Message-ID: <0cef90aa0bf1bfc8f0bc8e3f751991aa617f0700.1774354734.git.nora.schiffer@ew.tq-group.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271032-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tq-group.com:email,tq-group.com:url,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: 3E8CB30872D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The J722S CPSW3G is mostly identical to the AM64's, but additionally
supports SGMII.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
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


