Return-Path: <netdev+bounces-40591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8837C7C6E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 06:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24FC282CDC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9101C31;
	Fri, 13 Oct 2023 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nKQlGbzr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1E15D0;
	Fri, 13 Oct 2023 04:06:45 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD57B7;
	Thu, 12 Oct 2023 21:06:42 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 8D87820038; Fri, 13 Oct 2023 12:06:37 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1697169997;
	bh=7sMUa1sObnQgRvW7PGlm0vTqpN700RfSw+k2erhxzhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nKQlGbzrXDNyit+Ze+tzE+EqH9yuCvh8R0DuIYQj29tS3vvPwBSvvl8NroRfymTUX
	 0E/KV9QEXogiMWmLuNCoCTKazfNEjpi1GonxfFOXNj/HymkVEQ2w7wXN3kPa1mJEgz
	 LeopLRsOGNgf25IQF9MhxwlJjRI7+MblrXRN9d+VzWs6t0K1ds8nNYD1/h1KsRGpeY
	 EKqq7L/aS8Hw96jnIGHxJdfR/2vEepfZk8VC6wJuJ4zen5H9EjNumn8qGcKWIYBXGy
	 7DvMl4cX8+LCZw+EFEBDG2c4ivMmaopWMSbwtDoKUBqDBPfDC7ClcRJ0qvS7cJgtwd
	 IOI9r074ySCLA==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	miquel.raynal@bootlin.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v6 1/3] dt-bindings: i3c: Add mctp-controller property
Date: Fri, 13 Oct 2023 12:06:23 +0800
Message-ID: <20231013040628.354323-2-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013040628.354323-1-matt@codeconstruct.com.au>
References: <20231013040628.354323-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This property is used to describe a I3C bus with attached MCTP I3C
target devices.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

v2:

- Reworded DT property description to match I2C

 Documentation/devicetree/bindings/i3c/i3c.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index ab69f4115de4..d9483fbd2454 100644
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
2.42.0


