Return-Path: <netdev+bounces-16557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723874DD22
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3391C1C20A02
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA914293;
	Mon, 10 Jul 2023 18:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A114268
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:14:30 +0000 (UTC)
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 11:14:29 PDT
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF1128;
	Mon, 10 Jul 2023 11:14:29 -0700 (PDT)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
	by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 51387601EE21;
	Mon, 10 Jul 2023 20:58:18 +0300 (EEST)
Received: from yocto-vm.localdomain ([172.24.253.44]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	 Mon, 10 Jul 2023 20:58:18 +0300
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: 
Cc: vesa.jaaskelainen@vaisala.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: dp83822: Add line driver class selection
Date: Mon, 10 Jul 2023 20:56:19 +0300
Message-Id: <20230710175621.8612-2-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 17:58:18.0211 (UTC) FILETIME=[1B630B30:01D9B358]
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to specify either class A or class B (default) for line driver.

Class A: full MLT-3 on both Tx+ and Tx–
Class B: reduced MLT-3

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index db74474207ed..62943a1e8941 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -27,6 +27,14 @@ properties:
   reg:
     maxItems: 1
 
+  ti,line-driver-class-a:
+    type: boolean
+    description: |
+       DP83822 PHY's line driver selection to class A.
+       Sets the DP83822 line driver as class A i.e. program full MLT-3 on both
+       Tx+ and Tx-.
+       If not defined class B will be configured (default) i.e. reduced MLT-3.
+
   ti,link-loss-low:
     type: boolean
     description: |
-- 
2.34.1


