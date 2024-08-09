Return-Path: <netdev+bounces-117317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3394D936
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCC72839AB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0D16D9C5;
	Fri,  9 Aug 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VoArZE6V"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9115A853;
	Fri,  9 Aug 2024 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246727; cv=none; b=VVSvRchEMMCd/dWq/2RlA/qDsxQW8iIMcK7qD7RyUIIr97oyoN/xGRkeaEXP4+fCi3+zyauNS5CDLpt7Oq8YnnzdlULrtniJRMgJ4D2OQNumLJMn8DgmnvtFHcuXBMiskFBdYaTQQxlP0MxLRgNRMDs/99o4grIoXEZAkUvzdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246727; c=relaxed/simple;
	bh=3WrnZoU+f/9BA3WWEBzHKplOCR5zmV8u+njmgKhCut0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxcA04CN3qdz4EyfJ6jdPF/pfYCGJyj/RAXxv4SX0eDv0U2Ir9lhU2LbKrQowwEwj0GzqCRgdqeah5LSzXMw+GkBjjpKjbC7aIVmfbgTbnZg56PpVnsk64J3q7sG5FYe+pIg25DIAY63wJeG+fAAp3v34XuFxzmD0MD9yhYpBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VoArZE6V; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723246725; x=1754782725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3WrnZoU+f/9BA3WWEBzHKplOCR5zmV8u+njmgKhCut0=;
  b=VoArZE6VlLWPHXYYT/qWSG+5wCNGPCftb3e3ke4wkt2MLBSSUREIuiQv
   9qFqL8C/9nDiU+vl7mpCMaJ+sgEWxFlgsHWkLVQw+6KKEzu3I7D9XNI/A
   aYo8B+hQ3icgaV8Zwf+tSaG0o5B4PinNEPHaCLMoP75zk1eK5doItvXXS
   GGlzmJwKiPvARrUyZb3cbn4bHR/z/NWivml3fd/6zAvnICSZEovH5jqwO
   rpGhkJSKagKqfhjURN/rnV+otFzMnObaR2lfl2qfHNj86Kp+c8r2tDe9T
   Kao5LxFckH1vAQv8KBaM6IuHW0CxIbPJntax1joUiVWIqPvWDr5U3Ldqu
   g==;
X-CSE-ConnectionGUID: zHerXwjfR2qUoEM/PnTZ/A==
X-CSE-MsgGUID: BwBPT4FbTimBpsCAKJRPZw==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30988809"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 16:38:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 16:38:41 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 16:38:40 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII port support to KSZ9477 switch
Date: Fri, 9 Aug 2024 16:38:37 -0700
Message-ID: <20240809233840.59953-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809233840.59953-1-Tristram.Ha@microchip.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.

SFP is typically used so the default is 1.  The driver can detect
10/100/1000 SFP and change the mode to 2.  For direct connect this mode
has to be explicitly set to 0 as driver cannot detect that
configuration.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..b4a9746556bf 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -71,6 +71,13 @@ properties:
     enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
     default: 8000
 
+  microchip,sgmii-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      SGMII mode to use for the SGMII port
+    enum: [0, 1, 2]
+    default: 1
+
   interrupts:
     maxItems: 1
 
@@ -137,6 +144,7 @@ examples:
             compatible = "microchip,ksz9477";
             reg = <0>;
             reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+            sgmii-mode = <1>;
 
             spi-max-frequency = <44000000>;
 
@@ -173,6 +181,10 @@ examples:
                         full-duplex;
                     };
                 };
+                port@6 {
+                    reg = <6>;
+                    label = "lan6";
+                };
             };
         };
 
-- 
2.34.1


