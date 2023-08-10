Return-Path: <netdev+bounces-26391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F9777B31
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A852815E8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA3200B5;
	Thu, 10 Aug 2023 14:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C571E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:45:02 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB2E53;
	Thu, 10 Aug 2023 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1691678701; x=1723214701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/8fr/hvcmqsJO94upZmC0Hy1/wTw9sh/EMCxiuhZshE=;
  b=IopXsbLzlzRrJjxXRe5mOx1fV5wOEBcBcpmFhL6mzEWL+1rcPRwcjdXt
   JTNJfyixoUaSvysPLdydtqBWGkvQ7hp98cAvWCnNBi8UKQjpabwYp/a/V
   bhyQIBRYF5lGDaOsvQzjY6sXf3IkcRPOslQgVRuHFqFVZa5YVaDvOVVGR
   7PCT1ztMzZZQvmEZiUR2ot9a8LF+RsqlSTEXEvge9yd1GcoJmwuTqxLAL
   JIy8gop/mI6uI6fKO8Z2MRdPKiisJiItbCk0vwUiZVt+5I2JRTyQFJzci
   lvcIUQLHpFsul3c8C6Ii1UfnHqiZoUu0JfHm86PKlsjSZyfAO1rsqZpFZ
   w==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="32396720"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Aug 2023 16:44:58 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C94C328008D;
	Thu, 10 Aug 2023 16:44:57 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: imx-thermal: Add #thermal-sensor-cells property
Date: Thu, 10 Aug 2023 16:44:47 +0200
Message-Id: <20230810144451.1459985-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This property is defined in thermal-sensor.yaml. Reference this file and
constraint '#thermal-sensor-cells' to 0 for imx-thermal.
Fixes the warning:
arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: tempmon:
 '#thermal-sensor-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
 From schema: Documentation/devicetree/bindings/thermal/imx-thermal.yaml

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 3aecea77869f..a746f6a6395a 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -60,6 +60,9 @@ properties:
   clocks:
     maxItems: 1
 
+  "#thermal-sensor-cells":
+    const: 0
+
 required:
   - compatible
   - interrupts
@@ -67,6 +70,9 @@ required:
   - nvmem-cells
   - nvmem-cell-names
 
+allOf:
+  - $ref: thermal-sensor.yaml#
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


