Return-Path: <netdev+bounces-37865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569047B76CB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 05:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 61A851C20909
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 03:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FEC10E4;
	Wed,  4 Oct 2023 03:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF13EC0;
	Wed,  4 Oct 2023 03:13:29 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFDCAF;
	Tue,  3 Oct 2023 20:13:26 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 41BD2202B1; Wed,  4 Oct 2023 11:13:24 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1696389204;
	bh=tovb2S87x1y3o+Y2Y18g/y5Y4b9kXOk48cxQwfY5Fgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QkTKThmRS8+45BDeL1JvAc7YKP+KR+qp3wRu2y5GI0P/EdEvMUfJOMSWJapJYOD53
	 HV3XQclsS1LimPD6/VHbgyk+Gp+LAuVYBQyR0u5YO96T+Q3dBXAnUztkxNmDvEdpEt
	 JdOtVgt6oyuD9Sxt5NsWeRkMccneTNH7XfQNhcYcc3yv4CmH130ibYi65NdkIYRCk+
	 OUIBqV2Wm75v1Y2Ld/dnDzY71IT/y+ededSocag7qStryFhDInM8gRcvO/0OyHi1Lj
	 BDr3F2TJ+6Bm4OcYeNCr5czieIOjO+IfK7KfbMargndTtVsPgm2eW+SvbdwMC8hsZe
	 KPdPisyd+du3A==
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v4 1/3] dt-bindings: i3c: Add mctp-controller property
Date: Wed,  4 Oct 2023 11:13:14 +0800
Message-Id: <20231004031316.725107-2-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004031316.725107-1-matt@codeconstruct.com.au>
References: <20231004031316.725107-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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
2.39.2


