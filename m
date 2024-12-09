Return-Path: <netdev+bounces-150068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB19E8CE6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F97C2815C0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76B215190;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7g/GugB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6EC215188;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731309; cv=none; b=c/4Km46ns3tzPfTlDjW7LyjRZpW5DyaejnPkDGyQTZCMJZjh8D43oMI/tmDEAny5aUN+EMQRqHWyg8bG8EjR524zudqX/A5FhZnXW/k6RPSimKFyGJoou5oh9MiZADLLjRk1htP/yDHL3mG944D0POY6c0fjLAZKE7O+6LCPMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731309; c=relaxed/simple;
	bh=4gzYsX5DOfJVDxZcD+g7jTzyct3WDgauHlFyvdfIIgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u82SkzZ7VyhpSij4IXB3ezpb+oS4Qh/VCoGHEsCChIrZh/s0RVj32vIAr05Bye3OyzN21xLPTIkMkbAPUfQd/ib+S7Ak+eGwNSVVMKQASDPTG4eRu2JZ9QShfOnx5TD0bhERFLLEBzTd4FEGDKix7vTy9JMeAfVjZzJoLwyHMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7g/GugB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 071CDC4CEE3;
	Mon,  9 Dec 2024 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733731309;
	bh=4gzYsX5DOfJVDxZcD+g7jTzyct3WDgauHlFyvdfIIgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R7g/GugBhTcjzczec1uD+aR72YIFIQm0G5B1tCcoE/S2F6z8ZIJqQiscolcbb1FnA
	 JuSiDCoBCZiS/SZEcrvfYHdTnf3N+4YFTExT1LeSpbEjJUrHaVwQSXPNvJEZOHxpFS
	 CCtIdhRJ0+8Pyfuv4ofKxXcoM7GOJi6YNYDhZO9Ai5mRIKnxZuBLDmb9cynxOevaRb
	 zf0b0cmKnLn3leg4E/FDryUjsijn8lvrjFmIO60m/6trms8A3xpY4DhXrOZHxRSAaQ
	 bz75mjqOwq/RYjMAPHKzP8OcSaIKgx7Xhe/9eeaL1ZmiljpwSromjpnaXR0iGJwvnk
	 bmzZnnMw1vouQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F6E7717D;
	Mon,  9 Dec 2024 08:01:48 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 09 Dec 2024 09:01:27 +0100
Subject: [PATCH net-next 1/2] dt-bindings: net: dp83822: Add support for
 GPIO2 clock output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dp83822-gpio2-clk-out-v1-1-fd3c8af59ff5@liebherr.com>
References: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
In-Reply-To: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733731307; l=2015;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=UwvludAxxAD5J0tfbp9WDwPSofbmqEDrg/Gfp7I54q8=;
 b=LdpfO8fqYeWXeb+Xk1BRmMc6F/ygdzdJMowWAKIcBs2pn2POy2wbWE+HHvrr/nb7r9xL/BdyM
 Q9S2vU7ndHgDqoiQpZQEl757rOl6kd+dl1DWk4XaoDlYzDnxq787dhs
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



