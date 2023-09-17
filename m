Return-Path: <netdev+bounces-34342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D37A3597
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1031C2083E
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0753FC8;
	Sun, 17 Sep 2023 12:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44162187D;
	Sun, 17 Sep 2023 12:48:03 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7CFD9;
	Sun, 17 Sep 2023 05:48:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E7C3C0004;
	Sun, 17 Sep 2023 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1694954879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aq+pwsYFiwStYxtjQVnBxBzcUNTCMXjBxquvlKd5ZhI=;
	b=dU+jbPVzpXt3H6VtNT2P6FcrQlOnsf4Df+ssXytXV5pjq0RstMNPtNcn+RQlbMT2Lxp7Gj
	fmDzLM73gjnxTvIlafkC2FAIen6ClA4zYbIXRFXCNQIuVNOqbv7WpQKYt6vLZY6cqd5u9B
	rv8vWvHVRhfzWhQ11K9XFOWmH4Hk0COyGvL7V/PYohpp0q/HbzoyD4JlI1r9eRpGje8O+k
	TMxcTeTe1i+2knSZEEZw+JipkIkP2Cle/TB3lBp4nzJ7kNIV0u2NuABQ7pVgic/GYOF5qX
	l5DEMpOqjXCFaQWXWTfuRTn0/uqnsjLT5za0jh8ZMoQ3kgMLkaIkSmy0nEWIEQ==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Daniel Golle <daniel@makrotopia.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 1/2] dt-bindings: net: mediatek,net: remove reference on top level schema
Date: Sun, 17 Sep 2023 15:47:22 +0300
Message-Id: <20230917124723.143202-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The top level schema does not represent an ethernet controller, the
subschema defining the MAC nodes does. Remove the reference to
ethernet-controller.yaml on the top level schema.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index e74502a0afe8..0b2cb1897310 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -105,7 +105,6 @@ properties:
     const: 0
 
 allOf:
-  - $ref: ethernet-controller.yaml#
   - if:
       properties:
         compatible:
-- 
2.39.2


