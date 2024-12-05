Return-Path: <netdev+bounces-149246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9699E4E37
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245DD168A13
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3221B3920;
	Thu,  5 Dec 2024 07:26:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C71AF0CA;
	Thu,  5 Dec 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383563; cv=none; b=CTBnZqDEO/uIy0Vhsg9onz69KAcE7usQofREJs5Y5QswL+kB9mwv6Hl8ZFiWlFrVgT2/e/+O9q9XJdd8ingAp6mgLV9dX+H5N0x5Lab0RIUh6t7rd//mbMRhd1d7UImcrk+OA7oWy1giC0FQkFFbZW4E9LP1Mov3jh+EJS67TIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383563; c=relaxed/simple;
	bh=2dNPKqiux3/kj1Fj+yBtelMlWhVcE7qftmpzglA4vfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rve5vmt+r369dSOIjcWs3+k8xPnIeF2U++9msFClfr1iAL0P1oQXr8nsqH1AdF+Xd1ZqFTa6IoWalNsSzN/Mgfvafb58So512DkSgFuQt5/mazu8QBKP7LFejRMZTh8TXPY4/IL0PHQ1UQHv3+w27UOlx1iub0lOrOYjvx3pK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Dec
 2024 15:20:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Dec 2024 15:20:48 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: support for AST2700
Date: Thu, 5 Dec 2024 15:20:42 +0800
Message-ID: <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 is the 7th generation SoC from Aspeed.
Add compatible support and resets property for AST2700 in
yaml.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/net/faraday,ftgmac100.yaml         | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 9bcbacb6640d..3bba8eee83d6 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -21,6 +21,7 @@ properties:
               - aspeed,ast2400-mac
               - aspeed,ast2500-mac
               - aspeed,ast2600-mac
+              - aspeed,ast2700-mac
           - const: faraday,ftgmac100
 
   reg:
@@ -33,7 +34,7 @@ properties:
     minItems: 1
     items:
       - description: MAC IP clock
-      - description: RMII RCLK gate for AST2500/2600
+      - description: RMII RCLK gate for AST2500/2600/2700
 
   clock-names:
     minItems: 1
@@ -73,6 +74,20 @@ required:
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-mac
+then:
+  properties:
+    resets:
+      maxItems: 1
+      items:
+        - description: MAC IP reset for AST2700
+  required:
+    - resets
+
 examples:
   - |
     ethernet@1e660000 {
-- 
2.25.1


