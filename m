Return-Path: <netdev+bounces-151019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A89EC682
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F52D18865A5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4701D2B0E;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toat3qSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8F1C5CD6;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904293; cv=none; b=T98+0tKFIxWcZvuBLPw/XgBEiiEPN6aa6RcsTBfhzKLK9+O6W7h1i4LS4ecHxocWY4DnekJ8NASOIjeBu1vlnLrLeWVNT/oCLXDwztromDwtMcKc9RIwmv8m/BwqHAePcxk0ZTH1c8XCixCZ312Fefdiw7IJ/Uaz3xOBLGNZoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904293; c=relaxed/simple;
	bh=4gzYsX5DOfJVDxZcD+g7jTzyct3WDgauHlFyvdfIIgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8hhDYfUWn+kB9jQu9UXK/u4y6Zh/fgBawWTsbqFQnHk/HpRZVtUEoz+dwbEmD6fuY2vVkgYRTOx3QBRQOECJ1ZxRqWqALm4r4csp0HI45ZzXgp+ya2ivBk7fwMT7aeDNDHeiRYfoMvbzgH2PnDusQIxTPMo+e4RBqBQ8w7nuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toat3qSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F5C2C4CEE0;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733904293;
	bh=4gzYsX5DOfJVDxZcD+g7jTzyct3WDgauHlFyvdfIIgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Toat3qSg9Z6DoZ18gRpeqBpL3DR/OxqphuReM+YWFKcjXBuLqk28HLwpHap7sBF2c
	 w2VnD+cbMrkgHlW0OOuj4iZ6e5ayN2bV57cqf+714YyUOsBf4NifdJGKSVBR59GnQe
	 hc4h2SzTnxhl2J6PMppv7SeBXcN3f474nlkUxK0yBfXO3eRGElvv8G84eC25lyYgEN
	 dv3Ua228QlndPiYnCVLWodakp4z7LILAHY17yaZOUApxLUzgOIBH2ILcVSk26Dx4WF
	 nBwPAv01IxyYetQuP/YYnTGTIlBMTdDjZwhaQGYs9II27O2zBQC3N6FhpcpGMDw5Yl
	 qVtAy+VzoplTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325ABE77180;
	Wed, 11 Dec 2024 08:04:53 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 11 Dec 2024 09:04:39 +0100
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dp83822: Add support for
 GPIO2 clock output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dp83822-gpio2-clk-out-v2-1-614a54f6acab@liebherr.com>
References: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
In-Reply-To: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733904292; l=2015;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=UwvludAxxAD5J0tfbp9WDwPSofbmqEDrg/Gfp7I54q8=;
 b=aaFtX/2uzrz07LlMHrp6aXO+OB5NYErym0t0TQvVgO7y0REfZGWQGKft5dOIyd1ABr9fCry/R
 lk/zcVqmv1CCJf1MPRBA4wMFF8JWpMkC0HXXYmoSVVM3u+oAzPubNfD
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The GPIO2 pin on the DP83822 can be configured as clock output. Add
binding to support this feature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/net/ti,dp83822.yaml         |  7 +++++++
 include/dt-bindings/net/ti-dp83822.h                | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 784866ea392b2083e93d8dc9aaea93b70dc80934..4a4dc794f21162c6a61c3daeeffa08e666034679 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -96,6 +96,13 @@ properties:
       - master
       - slave
 
+  ti,gpio2-clk-out:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+       DP83822 PHY only.
+       Muxing option for GPIO2 pin. See dt-bindings/net/ti-dp83822.h for
+       applicable values. When omitted, the PHY's default will be left as is.
+
 required:
   - reg
 
diff --git a/include/dt-bindings/net/ti-dp83822.h b/include/dt-bindings/net/ti-dp83822.h
new file mode 100644
index 0000000000000000000000000000000000000000..d569c90618b7bcae9ffe44eb041f7dae2e74e5d1
--- /dev/null
+++ b/include/dt-bindings/net/ti-dp83822.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Device Tree constants for the Texas Instruments DP83822 PHY
+ *
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ *
+ * Author: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+ */
+
+#ifndef _DT_BINDINGS_TI_DP83822_H
+#define _DT_BINDINGS_TI_DP83822_H
+
+/* IO_MUX_GPIO_CTRL - Clock source selection */
+#define DP83822_CLK_SRC_MAC_IF			0x0
+#define DP83822_CLK_SRC_XI			0x1
+#define DP83822_CLK_SRC_INT_REF			0x2
+#define DP83822_CLK_SRC_RMII_MASTER_MODE_REF	0x4
+#define DP83822_CLK_SRC_FREE_RUNNING		0x6
+#define DP83822_CLK_SRC_RECOVERED		0x7
+
+#endif

-- 
2.39.5



