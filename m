Return-Path: <netdev+bounces-239040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F02FDC62B8D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63E7A4E6034
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5B246BC7;
	Mon, 17 Nov 2025 07:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7C2581;
	Mon, 17 Nov 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364624; cv=none; b=ZoTiZbFx5i+zZgfWQkbaiPuxtJRb/uWwpFObatBhhhEzLhjjhRe+DTx6DoanGmGhpgmhLK2r9olA29Sro6zyBxkbAobyZr9Lv8MFQ5I9TBvUz5ikMiTAYdiuK2gtYFJOGiep0KQGoDKXqnmQZhZJMjB47Xw761lLcmdByH5XNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364624; c=relaxed/simple;
	bh=Mj81EjxdRx03SMF1BDIPz2LcJycE1MUESozyiljFuRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VsS0Le+/O3bCExp97w6i/vxUnUeUB0CCSo0Dldsdejhru3LS7B+QEOkLrvn9nrXn/DW0C4YKSKnFJI4XxOKB+dpzGTP3g5qi0XtsJ+FWWZIbLmAJYfw9vLVac8q1zczBJpdD+vrT1deyn4aHtGk7lrR0DG2lvaVwfwSwg7SWqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 17 Nov
 2025 15:30:19 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 17 Nov 2025 15:30:19 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 17 Nov 2025 15:30:18 +0800
Subject: [PATCH net-next] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAAnPGmkC/x3MQQrCMBBG4auUWRuYhEjUq4iUofmrszAtmVAKp
 Xc3uPwW7x1kqAqjx3BQxaamS+nwl4Gmj5Q3nOZuChyu3vvkxFYgj9+syyjWQmJ2Iny7T3HmmCL
 1cq2Ydf9fn1TQXMHe6HWePwe0PEVvAAAA
X-Change-ID: 20251117-aspeed_mdio_ast2700-aa089c4f0474
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Andrew Jeffery <andrew@aj.id.au>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763364619; l=1811;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Mj81EjxdRx03SMF1BDIPz2LcJycE1MUESozyiljFuRA=;
 b=w1pnZrswHVUrLtVnSbCd+/kYz2W6un9gP9YIqrCt17cyhGIyuTN64gvRCKimRyU5NtSUScT/z
 AFYvOFYRWI/AaJbK6RY9ErunXmDpLSkNe1srNsJn009Mm3M63KvZK/6
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

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index d6ef468495c5..1c90e7c15a44 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -13,13 +13,19 @@ description: |+
   The ASPEED AST2600 MDIO controller is the third iteration of ASPEED's MDIO
   bus register interface, this time also separating out the controller from the
   MAC.
+  The ASPEED AST2700 MDIO controller is similar to the AST2600's.
 
 allOf:
   - $ref: mdio.yaml#
 
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


