Return-Path: <netdev+bounces-125514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E631796D77A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A8F28441C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55719A2B0;
	Thu,  5 Sep 2024 11:48:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A44199EA8;
	Thu,  5 Sep 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536887; cv=none; b=Zs80Lc42Q0S3dioTzq9+uQj/pyDFkip6mx1yN/+Arjy2HdYfWRz+wBdzvMwjZSHkBxUi0FPfn4UWx10wUxK57qkBJPK59yF2Dhmi1SFqISLLocmUloVsmrTqD0nCpdw55xruNl+GAfui3c5pJVP7C7O+A7OgE1uI0pbOZIel3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536887; c=relaxed/simple;
	bh=/OMIFkkJlOlaJ445F5TAwaUZayMaiWQuRjMGsorIwLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJMNS7SuXVqHGZxqCZqMB335Gvx0vIH5uCHz4xv950JNepihPuy5LB6cpzMbdGu2asRVT+QODeU2UOFKwQDvC8ZkXhTrcoMnkyE4ykTLnDxEfbyOafM5PDMh/bFr3xBTWlRWmyQSg0UY2eY7cBEL0WZsvzb+cJnOrJjM37sZw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Sep
 2024 19:47:54 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Sep 2024 19:47:54 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH 1/2] dt-bindings: net: aspeed: Add binding for ASPEED AST2700 MDIO
Date: Thu, 5 Sep 2024 19:47:53 +0800
Message-ID: <20240905114754.519609-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
References: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a new compatible for ASPEED AST2700 MDIO.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index d6ef468495c5..6dadca099875 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -19,7 +19,9 @@ allOf:
 
 properties:
   compatible:
-    const: aspeed,ast2600-mdio
+    enum:
+      - aspeed,ast2600-mdio
+      - aspeed,ast2700-mdio
 
   reg:
     maxItems: 1
-- 
2.25.1


