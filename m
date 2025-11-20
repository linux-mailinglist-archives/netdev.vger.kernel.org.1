Return-Path: <netdev+bounces-240285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D8C721F2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46B7C4E1F8A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B77287505;
	Thu, 20 Nov 2025 03:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BE18DB0D;
	Thu, 20 Nov 2025 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763611058; cv=none; b=K8OwOT6YqJOsgkH6a5jFudrK7hhEHgIPTexqGMWKOOEpo3ar/UV+itstxOp3N0ufbnScfDGf8P445zw0cnM/ZdjynNYDgl8MqxTmDGn5MsYMktDJGAvijpKzII0/YVv3CINzxpQ70F0n7Q44BIZkQitCsu7cfCldo2zl7sF5zjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763611058; c=relaxed/simple;
	bh=wmlwbzLwa1koSK2nuP5aUDcsxGgFbO+ySPwBTpaVBGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HM5dSRTHIkS69H4NMVA9uPz/TaJN+f1qB5kF9CqERoxF2EtfKuTc59rUca8pvgDYUFwNMAlwp610rJpBbJiwHXXYJqFBGegg6HsCzHu+/9ewM3rrVPi+ODgUKbzDby9gcenVo4VcRO22vd23tWMnfb+JsdmYVx4GEDZZCMkeeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 20 Nov
 2025 11:52:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 20 Nov 2025 11:52:26 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 20 Nov 2025 11:52:03 +0800
Subject: [PATCH net-next v2] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251120-aspeed_mdio_ast2700-v2-1-0d722bfb2c54@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAGKQHmkC/32NwQqDMBBEf0X23JRNGtH25H8UkTSudQ8mkoRgE
 f+9wd57HN7Mmx0iBaYIj2qHQJkje1eCulRgZ+PeJHgsGRSqWkrZCBNXonFYRvaDiUk1iMIYbO9
 WT6gbDWW5Bpp4O61PcJSEoy1BX8jMMfnwOe+yPPlfc5ZCipbsC/GmprrW3a+VyM5X6xfoj+P4A
 pggdPvFAAAA
X-Change-ID: 20251117-aspeed_mdio_ast2700-aa089c4f0474
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Andrew Jeffery <andrew@aj.id.au>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763610746; l=1764;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=wmlwbzLwa1koSK2nuP5aUDcsxGgFbO+ySPwBTpaVBGE=;
 b=EQwlHKt16UBrHnbKrYwuae5GVZPaRI0ZvrdLxxtPSwzgIl19qVZQn7nEwAvXm0CflvUE215b4
 ZoofOto8IIyD90g3yw629h1lKDYScsXryAa6gTti/xdU6fbiNeZHY7F
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add "aspeed,ast2700-mdio" compatible to the binding schema with a fallback
to "aspeed,ast2600-mdio".

Although the MDIO controller on AST2700 is functionally the same as the
one on AST2600, it's good practice to add a SoC-specific compatible for
new silicon. This allows future driver updates to handle any 2700-specific
integration issues without requiring devicetree changes or complex
runtime detection logic.

For now, the driver continues to bind via the existing
"aspeed,ast2600-mdio" compatible, so no driver changes are needed.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v2:
- Remove AST2700 description from aspeed,ast2600-mdio.yaml
- Link to v1: https://lore.kernel.org/r/20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com
---
 Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index d6ef468495c5..a105dc07ed12 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -19,7 +19,12 @@ allOf:
 
 properties:
   compatible:
-    const: aspeed,ast2600-mdio
+    oneOf:
+      - const: aspeed,ast2600-mdio
+      - items:
+          - enum:
+              - aspeed,ast2700-mdio
+          - const: aspeed,ast2600-mdio
 
   reg:
     maxItems: 1

---
base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
change-id: 20251117-aspeed_mdio_ast2700-aa089c4f0474

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


