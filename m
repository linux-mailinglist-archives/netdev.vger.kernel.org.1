Return-Path: <netdev+bounces-153696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC49F93B2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396C91897767
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AD6219A69;
	Fri, 20 Dec 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EdGpuhZK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC9215F78;
	Fri, 20 Dec 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702593; cv=none; b=mCHMSgqp47nxmRRuK+uOvZEO1pxOV8relGMppy53Tm8XuBhIhxirLmnfExwxk7LEmv7WdO9DaK1+eZs+qnsnXCqMhRHc2Gj3Mq/kpY1DasiXmpqvybFQ8JSpn7BvvtnmWZIS3l4KeXy2vmMWnWxRbjpxLK6nnszHNdZHO9sw/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702593; c=relaxed/simple;
	bh=FRo8Ufl7iucYReatrCym9BzetwbYuzm+buoOeBMYDqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fmZ3CQSJZEQ8w03ILWNwLH/7E7vy6F9ghhMhixKTZY0LNjXyKqgOEgnQNNjw0EMwrf3Mz4PMCgz1jrUX/HPPS5FXouT+J7PXcXox3xXgt78Mn8PevM73rIMj2MRwnvBWD+UlL0mKaT66nV3U+Vryqik6SvUEFJD6MdfnC62EVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EdGpuhZK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734702592; x=1766238592;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FRo8Ufl7iucYReatrCym9BzetwbYuzm+buoOeBMYDqQ=;
  b=EdGpuhZKxw7uhoxlJoEok/zDu8ahJTxrCuTsFBNsteqJ7UypJvwN1xlP
   eM7tWJ/q5T2P8cbp3wNzsmzZuHxxpYdCXH3ZnhgeCId/pJ/e0RKkh4L7g
   QJyN758LCTwu1XpNR6A62xnpLTlHMwdtkSmvl/fMsMEbVWfLITipgTY+h
   KKwO4yWVvhYXKz0gKZ/C/uKskvFNSpZOLBsuhNviJzTsxesGKwAe3iEpT
   SHhcUYY8iPAL8C2fxree65rNAjIw87kXhVPDmFQU7V3H7gHc+b+B2gmq+
   ChVMSE/3nBGP9immah6EOAlxDIO2DHd86bf9QtZrLsmLFpUXT6l+pdjSF
   g==;
X-CSE-ConnectionGUID: Lq5BqadMRMm7eOW5EpI9IQ==
X-CSE-MsgGUID: RxHNOPDOTBWY8CZmwd/bZg==
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35794900"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 06:49:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 06:49:21 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 06:49:18 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Dec 2024 14:48:48 +0100
Subject: [PATCH net-next v5 9/9] dt-bindings: net: sparx5: document RGMII
 delays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-sparx5-lan969x-switch-driver-4-v5-9-fa8ba5dff732@microchip.com>
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

The lan969x switch device supports two RGMII port interfaces that can be
configured for MAC level rx and tx delays. Document two new properties
{rx,tx}-internal-delay-ps in the bindings, used to select these delays.

Tested-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../bindings/net/microchip,sparx5-switch.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index dedfad526666..a73fc5036905 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -129,6 +129,24 @@ properties:
             minimum: 0
             maximum: 383
 
+          rx-internal-delay-ps:
+            description:
+              RGMII Receive Clock Delay defined in pico seconds, used to select
+              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
+              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
+              any delay. The Default is no delay.
+            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+            default: 0
+
+          tx-internal-delay-ps:
+            description:
+              RGMII Transmit Clock Delay defined in pico seconds, used to select
+              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
+              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
+              any delay. The Default is no delay.
+            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+            default: 0
+
         required:
           - reg
           - phys

-- 
2.34.1


