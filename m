Return-Path: <netdev+bounces-206779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E3B04592
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B554A0E6E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C871263C8A;
	Mon, 14 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M0dD65X5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D725BF1E;
	Mon, 14 Jul 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511033; cv=none; b=fc5qqAzFyL74/HO5+m49QQ3mom1PO5QMZ4DbXf6sySyIzeYSG3eTocsEjQCQ+BLxCKH0m0aMk0DlhCI8hOGSDb9K6xKVebR3Xr+ui6F26HqT6aegt7MSMLZBBWUP/NQla4nFgM8pakNp9IN5xIGfTYT866nu4uoYs/1xKpeXjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511033; c=relaxed/simple;
	bh=tTBbCPNjh3kndWKdQLLOC9WO7P6uncnMXrl9fKN6diI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc7hscSrcNOECZPzNDzaFB92PTHDDS7fc6R7/ADNs3ywBhecHYPRK47twg8oAccK4IrNtWlfrlUXVWZFzUMcZRFiFWRdPVMtrME/XBNr1oi3CqgK0EGc8DcdS2UXatnKenhCbWSkTZk4etAL+IfB/L446GCDT4M2UgYs8dNGlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M0dD65X5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752511031; x=1784047031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTBbCPNjh3kndWKdQLLOC9WO7P6uncnMXrl9fKN6diI=;
  b=M0dD65X53D7YKq5Z5hKnxOaSv0TwsmDAsoNQGOJBMSaxmYuP2O3HOVUW
   wGguN8SR0/oxcU49PddK2bsAbThHFlFRvqUCTtkOjrZKy1ygRAgtEuI0r
   XyXtQ8u1EXyp+TGtE616ZznSeZVscsOjvz7zVaVeAGWysKq6Dns+OR/CB
   olKD6KZ596ubltWrh1hHnpLVQNYagF7OfWqhA4RB+okD0uQkFvXOamNy4
   f/7MBaki6CJJsfP0whFcZbq5sqiCHB2oKgRJXapWOrr1R5rvrCmOx4GDz
   JvGxwIThFjU5ge8g9oMDlyjCsv84PZuMPsAaAww/aNULGFzeXoMWw1/LR
   A==;
X-CSE-ConnectionGUID: hBq1ljEWSkqL674rDMJkcA==
X-CSE-MsgGUID: ImMng/ZlRaCQ7+lJv5BLcQ==
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="211399321"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 09:37:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Jul 2025 09:36:28 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Jul 2025 09:36:28 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: net: cdns,macb: Add external REFCLK property
Date: Mon, 14 Jul 2025 09:36:59 -0700
Message-ID: <d558467c4d5b27fb3135ffdead800b14cd9c6c0a.1752510727.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752510727.git.Ryan.Wanner@microchip.com>
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

REFCLK can be provided by an external source so this should be exposed
by a DT property. The REFCLK is used for RMII and in some SoCs that use
this driver the RGMII 125MHz clk can also be provided by an external
source.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 8d69846b2e09..e69f60c37793 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -114,6 +114,13 @@ properties:
   power-domains:
     maxItems: 1
 
+  cdns,refclk-ext:
+    type: boolean
+    description:
+      This selects if the REFCLK for RMII is provided by an external source.
+      For RGMII mode this selects if the 125MHz REF clock is provided by an external
+      source.
+
   cdns,rx-watermark:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.43.0


