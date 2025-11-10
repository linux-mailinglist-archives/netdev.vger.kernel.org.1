Return-Path: <netdev+bounces-237150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604FC46266
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E679E347CCA
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98D30BB8D;
	Mon, 10 Nov 2025 11:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75E30AAD3;
	Mon, 10 Nov 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773014; cv=none; b=JqYkERl+YBLQFKBraSV6/Abdk2mQkrFQBO3LhRuLVVYs/ONZ6gPcVHWRDQXGSgUxX+cL9bjSAVmDVli1oraQVAu5BkqMI42xDMhu4i/e3x4EdhKWnk9MaMzIKDnTEa2TmXo/9vlXSDDjdFY1rbjfvRYQ+C7PtPXfvAs1tk9Nv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773014; c=relaxed/simple;
	bh=YdhWtldgK+x4gz0hMpUXUNmL81whKPQJ/baoTpGSTTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DtQvQJWxz8/kcYsTyN/xVQs+HqWpu7bOT92SbAhs7BnXvub+BemERDaonLlhmV0u81uFRuOpngPchNRkL6VUDk1+bp4A+7tiCCRPeuL6+7oywhEWgcR+IcihtHCJwrIR7NaOJuSgELj3EGA5r0ZvYIvzFcYLa2OZVcdJTuPegMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 10 Nov 2025 19:09:27 +0800
Subject: [PATCH net-next v4 3/4] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251110-rgmii_delay_2600-v4-3-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=1846;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=YdhWtldgK+x4gz0hMpUXUNmL81whKPQJ/baoTpGSTTk=;
 b=uFQ673lRe8/ngw4JWe4Xv4O1M2pMV5gWW3jULRMOSbequaVBXzdyXcDhUwsH6qFJaiMbQ6CAZ
 42oiAFhhrXlC0HPRJVdV+Fafs/n9lDQ6lEZWL2xWkyMl4/ownUAdRj+
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This change sets the rx-internal-delay-ps and tx-internal-delay-ps
properties to control the RGMII signal delay.
The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
internal delay on the PHY and disable the corresponding delay
on the MAC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..f8f0d5c98514 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -123,42 +123,54 @@ ethphy3: ethernet-phy@0 {
 &mac0 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 
 &mac1 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 &mac2 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 &mac3 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy3>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 &emmc_controller {

-- 
2.34.1


