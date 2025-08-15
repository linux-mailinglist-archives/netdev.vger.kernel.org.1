Return-Path: <netdev+bounces-214195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F4B28723
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A483B07251
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AFC2C08B3;
	Fri, 15 Aug 2025 20:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9323D7CF;
	Fri, 15 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289277; cv=none; b=dWC0l2WOei452KlVWHMWj3AZiXVIWaeasMqK14XqLw9hU6Gu55rpz+FzawYsKTV5GX//197X9uQseh+QgAXGNhmmCV7o+u2swmZU3P91iaQYKXjB9IVLK79xT1NrfVyp/AcDhm2Cd6VBgwcrg/RiDlEq7dnrGZYUREWWhzWKN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289277; c=relaxed/simple;
	bh=0ifgqMN+tqomLlaRqFekU12k4KdryuUStvROFfV9+gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUSnbpS1KuqTDAjCV7/1dVzG9KlCdl1QPdD7OXNuFulrkNyJ5Bs0J3V5GTAWGdp57ms/D00WRy2vjt4X5dUEe6bMeKkxTwtyosQYUwwOXp1AO9z1HcQOwm29Wh42INgkPRIsF6k1z9/b9rl4wl9xCbfTGMpE62T+N4nBIcmpJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 08C17586B47;
	Fri, 15 Aug 2025 19:49:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D7BB442AC;
	Fri, 15 Aug 2025 19:49:43 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Rob Landley <rob@landley.net>,
	Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
Date: Fri, 15 Aug 2025 21:48:05 +0200
Message-ID: <20250815194806.1202589-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194806.1202589-1-contact@artur-rojek.eu>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetrhhtuhhrucftohhjvghkuceotghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghuqeenucggtffrrghtthgvrhhnpedvkefgieefkeeutefhffefieffffffieffhfduleeiledvteefhfdtteegheeiveenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeefuddrudeftddruddtfedruddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrudeftddruddtfedruddvledphhgvlhhopehptgdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheprhhosgeslhgrnhgulhgvhidrnhgvthdprhgtphhtthhopehjvghffhestghorhgvshgvmhhirdhiohdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtoheprghnughrvgifo
 dhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: contact@artur-rojek.eu

Add a documentation file to describe the Device Tree bindings for the
Ethernet Media Access Controller found in the J-Core family of SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 .../devicetree/bindings/net/jcore,emac.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/jcore,emac.yaml

diff --git a/Documentation/devicetree/bindings/net/jcore,emac.yaml b/Documentation/devicetree/bindings/net/jcore,emac.yaml
new file mode 100644
index 000000000000..a4384f7ed83d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/jcore,emac.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/jcore,emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: J-Core Ethernet Media Access Controller
+
+description: |
+  This node provides properties for configuring the Ethernet MAC found
+  in the J-Core family of SoCs.
+
+maintainers:
+  - Artur Rojek <contact@artur-rojek.eu>
+
+properties:
+  compatible:
+    const: jcore,emac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    ethernet@10000 {
+      compatible = "jcore,emac";
+      reg = <0x10000 0x2000>;
+      interrupts = <0x11>;
+    };
-- 
2.50.1


