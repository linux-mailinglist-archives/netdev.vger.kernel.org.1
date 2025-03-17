Return-Path: <netdev+bounces-175166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB0A63C9A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 04:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E50A16BBE2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3919D081;
	Mon, 17 Mar 2025 02:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78018FDBE;
	Mon, 17 Mar 2025 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180378; cv=none; b=r6FJ/ZcfYU3GqO3F457DTBvDHZDQQh0ywpdAj1F5XIkb+/rIz1YclREDPu3C1el6req/9uIyeMVpb+koQA7/u+9waWOMV9nZRA1N2rVQcfJhMQQtPn+Lo1Zqdj9D1twmSp+0Tf2gEybw3jTUBilPvgRyqPyta+mDqT/ggYcyAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180378; c=relaxed/simple;
	bh=079BKpVziC3jsx7LXamG6iEwiPaLW3laD5D7Qe1sT3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJgHHnUOaEs0JY75Q2gCqYD9upCrNvbSdLim6URQcaqga2lZehha4417hGNvOPhMd4was0H5L5FzF0gLNRzCXdyY8HCGXJs4nyGqhMLy8LTro+8clKZIBlVGvlMMa95SMLDZtn7gl/8gOZ6/ts7s8SOYIqdblbJj2YEsXDj8XVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 2/4] ARM: dts: ast2600-evb: add default RGMII delay
Date: Mon, 17 Mar 2025 10:59:20 +0800
Message-ID: <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use tx-internal-delay-ps and rx-internal-delay-ps to
configure the RGMII delay on MAC.
And add default value for AST2600 MAC in dts.
Refer to faraday,ftgmac100yaml to know how to configure
the RGMII delay.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..1db1f2a02d91 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -126,6 +126,9 @@ &mac0 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy0>;
 
+	tx-internal-delay-ps = <16>;
+	rx-internal-delay-ps = <10>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default>;
 };
@@ -137,6 +140,9 @@ &mac1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy1>;
 
+	tx-internal-delay-ps = <16>;
+	rx-internal-delay-ps = <10>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default>;
 };
@@ -147,6 +153,9 @@ &mac2 {
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy2>;
 
+	tx-internal-delay-ps = <8>;
+	rx-internal-delay-ps = <4>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
 };
@@ -157,6 +166,9 @@ &mac3 {
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy3>;
 
+	tx-internal-delay-ps = <8>;
+	rx-internal-delay-ps = <4>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
-- 
2.34.1


