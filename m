Return-Path: <netdev+bounces-274086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPYzMf4QzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:35:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516337A814
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8744305B494
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E781402B87;
	Wed,  1 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cY/aMbdt"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A53A9D88;
	Wed,  1 Apr 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046369; cv=none; b=C4uMQKcccSljIhmgcOT4V3jleLYTk8dmmDloF3d7q8t5HUvPt0DfRSqklixvmAjHMj+sCfNV/+UsNiT6oOqHHfo4QGqTynvveWUec7ZZtLOUuL6wqrC5gfohB0fg7v9G8EDygbClRWw6aZ9KllT/62TJBsxtOM918/SPrCpjiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046369; c=relaxed/simple;
	bh=67pUq+Zzouat6pnv7Ak0f4xBhOcxS1uB3sfXCVAiQR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9B4m4RAXyVIDKWj+AKMO4OYZJgXhWE6ad2EfvpovArFZYuO8f9PZWGiHpT2V1P6GUOtqvfQU9WjZ/wIgJmPjQae3DTg4m96asq0sGJOFvk5E30dm52j0BbEegfSnpe9+OeyECJ4Di/sHm40uGZg6FHzIdzCl9hvm2X1bvEssRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cY/aMbdt; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iXZKh39YA9QQda5suRG0NPBgfkw/vmM7xN5WKLiYDaU=; b=cY/aMbdtyM7606X2A+IiHSBqXd
	Gx1sHTKTaYJDjkJRa+JgRFvk/dUSEYTeNJbzFdV6Pfy/0gFTKq1l8yHFL+rN+YuaqLlCn+YLXjL5N
	3wexm59ZPQjxoWswaGfuyiybwJekliqtE2RQXPK4URSmkJW1H33stARljCt4FjYwAEpAwhzYTCrS8
	z9HtTjX//SRyMXBKnFS9QUgpngFo6haEyF28w2froKsDDJMzg3k9F5Fvm6QKjS9me8uFAg08QhioA
	+oKadGNiQqS3ETWLLkOnQTn8oyrxbfYZNCY+5T0cYAMJQJszlI/5qHN8IOj7CNJlkZvxMwhZSA6J0
	pCTApuWw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue5-000IRC-1N;
	Wed, 01 Apr 2026 14:26:05 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue4-00089b-35;
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
Subject: [PATCH v3 5/5] arm64: dts: ti: k3-j722s-main: use J722S compatibles for WIZ, gmii-sel and CPSW3G
Date: Wed,  1 Apr 2026 14:25:25 +0200
Message-ID: <55607ba1ca2bcf5c60a7d1e3c88fd20053a8be5c.1775045279.git.nora.schiffer@ew.tq-group.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274086-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:email,tq-group.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ew.tq-group.com:dkim,ew.tq-group.com:mid,0.0.15.230:email,f000000:email]
X-Rspamd-Queue-Id: 8516337A814
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


