Return-Path: <netdev+bounces-18174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7ED755A7C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E40281214
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C95236;
	Mon, 17 Jul 2023 04:07:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFD4C9B
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:07:13 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64C107;
	Sun, 16 Jul 2023 21:07:10 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id CE08120184; Mon, 17 Jul 2023 12:07:08 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1689566828;
	bh=6909hS4eCXpLD54uVYNkkdYhSqBOb+2n7qQgs3Y0m+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXe0KsEooYHIwcmeipKlZ18RBuObXbqxlm+7YOWpNiZei1uXGDcXUME2+5Iq/LeF9
	 lWmj75Vn2Aiv0rgms4NYhCdxffrSuWld7K8yobAwYUPcVG0Jxrn4++B+cLqXPNqzCx
	 XQhfG5dMJd5F4Z2/KXbCy+0AJClKnO1tUsvOXXfeuqZKX08RMmIocZ9fBEKboNePL+
	 TYOHwc2hzoGdiLW+x3U/iYGjrLRPqyOCySgSOUubT/xvQQTPIUAD4o/CDMk6UVcqD2
	 R26a0PnXmsBMlay6ZMLNhAA5dhlJgrpEE77Ms/JA6zDIYXhvhkFKSkZ9JNBDYyppde
	 ohGcL0hztNA4g==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH net-next v2 1/3] dt-bindings: i3c: Add mctp-controller property
Date: Mon, 17 Jul 2023 12:06:36 +0800
Message-Id: <20230717040638.1292536-2-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230717040638.1292536-1-matt@codeconstruct.com.au>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This property is used to describe a I3C bus with attached MCTP I3C
target devices.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---

v2:

- Reworded DT property description to match I2C

 Documentation/devicetree/bindings/i3c/i3c.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index fdb4212149e7..b052a20d591f 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -55,6 +55,12 @@ properties:
 
       May not be supported by all controllers.
 
+  mctp-controller:
+    type: boolean
+    description: |
+      Indicates that the system is accessible via this bus as an endpoint for
+      MCTP over I3C transport.
+
 required:
   - "#address-cells"
   - "#size-cells"
-- 
2.37.2


