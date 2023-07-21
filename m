Return-Path: <netdev+bounces-20040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1575D76C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5F1C217D5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863823BC7;
	Fri, 21 Jul 2023 22:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995C21516
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 22:23:26 +0000 (UTC)
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B83A96
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:23:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1689977807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiQgZ4Wm6yEDAcXzCVAc5MydP04eah8gErZxesi/BMI=;
	b=h1WWdtgAFYH6OTid6DgJ/kiMQnM+F7MkjMrv6GPWbln+iLdcheLmGVdwBIVOOISf0XTySI
	+1fzFfEeL3UgMrOD4m45O+r+Gg8wfM9V+QdPjmU2ct5YJnpjqbyiRIAPjPU8sZQ5WviVyt
	OSv6a78m625Yv9CDsJvl1O0yE6Yyu/+vkjUhiT10oZE3TZz0LBfQf43xPQJH3YVXv+jOyn
	c+n+EvgjDheGV5fayu/lnvqio57hk86rTGJzakwlfh4WwYsXjEB9ZTlUxmfOw6lMAqVwEB
	EiPUS4TUY+TvZwfp4XxaxECEuUA60Ns6GL8FZqrUcgm+mTa+IIbhlN4yXvMZYA==
From: John Watts <contact@jookia.org>
To: linux-sunxi@lists.linux.dev
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	John Watts <contact@jookia.org>
Subject: [PATCH v2 1/4] dt-bindings: net: can: Add support for Allwinner D1 CAN controller
Date: Sat, 22 Jul 2023 08:15:50 +1000
Message-ID: <20230721221552.1973203-3-contact@jookia.org>
In-Reply-To: <20230721221552.1973203-2-contact@jookia.org>
References: <20230721221552.1973203-2-contact@jookia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Allwinner D1 has two CAN controllers, both a variant of the R40
controller. Unfortunately the registers for the D1 controllers are
moved around enough to be incompatible and require a new compatible.

Introduce the "allwinner,sun20i-d1-can" compatible to support this.

Signed-off-by: John Watts <contact@jookia.org>
---
 .../bindings/net/can/allwinner,sun4i-a10-can.yaml           | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
index 9c494957a07a..e42ea28d6ab4 100644
--- a/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
@@ -21,6 +21,7 @@ properties:
           - const: allwinner,sun4i-a10-can
       - const: allwinner,sun4i-a10-can
       - const: allwinner,sun8i-r40-can
+      - const: allwinner,sun20i-d1-can
 
   reg:
     maxItems: 1
@@ -37,8 +38,9 @@ properties:
 if:
   properties:
     compatible:
-      contains:
-        const: allwinner,sun8i-r40-can
+      enum:
+        - allwinner,sun8i-r40-can
+        - allwinner,sun20i-d1-can
 
 then:
   required:
-- 
2.41.0


