Return-Path: <netdev+bounces-271036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BR4OceEwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:34:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214A30852B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0370D3061919
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776E3FB076;
	Tue, 24 Mar 2026 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="L9OxChIf"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1C3F7E6E;
	Tue, 24 Mar 2026 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355433; cv=none; b=UIcjSSOuyQNJy8ND2G0fBbJlcoFOTxfoBA9GldbGe+80Fj5fswyEPmQNd57sYipqZM2PA75x492x3hI1PP9SXQ/fqm6IRyY+fZBJOr0cQNLoFAQxaAGoTG+CMeolUk/fx95yOvN4kHzw4gN+RRPRG3L2fA+PFnZ7JWjbLF6mGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355433; c=relaxed/simple;
	bh=67pUq+Zzouat6pnv7Ak0f4xBhOcxS1uB3sfXCVAiQR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOAgTGnipk1MTOo7mFTmWOhckw/o1wbhZ8SQJlN63a7svz9bI+EnWIcQS9KdJmd27ulrWAb0M7AfXP/77xhn0iHIj6tOUXDtIGptKdBSXgDhL725Ijl3u/6kfiUR6AFCmQZ4JgiMtADz++L10HYKSWTxgI6ccHHRJd5yeKHeGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=L9OxChIf; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iXZKh39YA9QQda5suRG0NPBgfkw/vmM7xN5WKLiYDaU=; b=L9OxChIfuhMcJbtZretGycJO+z
	JSbzBTUdCha7XnaSzSAiqoFcCDkr+ijHtD8MktLNAkhXIAnlt2HzODXXJZRxMJ8uSYHoPFTtUInq5
	000sJiTlP9o4p+1CURJZzAPGjdTgx1a95cd/aF7PqSjZrvdWqFa9wJpAIQ9QXaaCQEQFQxsXcyWlJ
	cjmh9oFIEy3Dd/unvAeYjTEb9l/HbHY/3I5SHAFj5bBCfylVR6LpY3P2Di37MGy/VdFAvmivyhzdJ
	s9V5pwaZFJXPxk5sit8JRZOBi/XOmE/pGLEJsE0EIx4HysbBREMYkCvQTSYqaZkdVvmpuxevTKlDh
	flE7j8MA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tt-0005r6-1s;
	Tue, 24 Mar 2026 13:30:25 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tt-000Pna-1M;
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
Subject: [PATCH v2 7/7] arm64: dts: ti: k3-j722s-main: use J722S compatibles for WIZ, gmii-sel and CPSW3G
Date: Tue, 24 Mar 2026 13:29:43 +0100
Message-ID: <f978c27ab4ad2b9bd9828ce50be13a72a1b58942.1774354734.git.nora.schiffer@ew.tq-group.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271036-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:email,tq-group.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ew.tq-group.com:dkim,ew.tq-group.com:mid,f010000:email,f000000:email,0.0.15.230:email]
X-Rspamd-Queue-Id: 6214A30852B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update WIZ, gmii-sel and CPSW3G to use the J722S-specific compatible
strings, enabling SGMII support. The fallback compatibles preserve
compatibility of the updated Device Trees with older kernels.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 9ee5d0c8ffd1e..70f430aa3a944 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -18,7 +18,7 @@ serdes_refclk: clk-0 {
 
 &cbass_main {
 	serdes_wiz0: phy@f000000 {
-		compatible = "ti,am64-wiz-10g";
+		compatible = "ti,j722s-wiz-10g", "ti,am64-wiz-10g";
 		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -56,7 +56,7 @@ serdes0: serdes@f000000 {
 	};
 
 	serdes_wiz1: phy@f010000 {
-		compatible = "ti,am64-wiz-10g";
+		compatible = "ti,j722s-wiz-10g", "ti,am64-wiz-10g";
 		ranges = <0x0f010000 0x0 0x0f010000 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -451,6 +451,14 @@ pcie0_ctrl: pcie0-ctrl@4070 {
 	};
 };
 
+&cpsw3g {
+	compatible = "ti,j722s-cpsw-nuss", "ti,am642-cpsw-nuss";
+};
+
+&phy_gmii_sel {
+	compatible = "ti,j722s-phy-gmii-sel", "ti,am654-phy-gmii-sel";
+};
+
 &oc_sram {
 	reg = <0x00 0x70000000 0x00 0x40000>;
 	ranges = <0x00 0x00 0x70000000 0x40000>;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


