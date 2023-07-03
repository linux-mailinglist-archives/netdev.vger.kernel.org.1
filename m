Return-Path: <netdev+bounces-15023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C2745506
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 07:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A14280C5E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 05:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC6818;
	Mon,  3 Jul 2023 05:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476F7E3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:41:32 +0000 (UTC)
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 22:41:29 PDT
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D4398;
	Sun,  2 Jul 2023 22:41:29 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 73FDE202AC; Mon,  3 Jul 2023 13:31:44 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1688362304;
	bh=KPlTtwQXzcm8osPuB08R4KJIMh3H7wCTHPv/bCpkWrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQr8r/g0Ni4ZCux/QoLJqjSOi4yFumwmImF7mp7JICFy+Hhn7zG+ILW8xpDkFq/Yi
	 c6pzwTSTWKTyjW7tkSxqFowLWfgepz8QA2Xfo2MUvuN1J0kzqMd8R4mtO09u31uDZG
	 dejRX5UntuHSuCswyJ0lCv20n1kF0Rn17SchcQEQqx0jbx1KAbls3oxrWxHg9p0bVM
	 kY4oFDU8pLU44k7jHjLA+uJ2FyCCO1/yXSCp/+tQf9yTSXVpZrRndV0FtknrlQkLfc
	 CS91xUw85CQm0p7K+7qVLQw6f/TDeopvd1bt/v1yRRLIBE1QGD79LcTcuZw7umJu+Z
	 9AEPNINOU74GA==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: i3c: Add mctp-controller property
Date: Mon,  3 Jul 2023 13:30:46 +0800
Message-Id: <20230703053048.275709-2-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230703053048.275709-1-matt@codeconstruct.com.au>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This property is used to describe a I3C bus with attached MCTP I3C
target devices.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/i3c/i3c.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index fdb4212149e7..08731e2484f2 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -55,6 +55,10 @@ properties:
 
       May not be supported by all controllers.
 
+  mctp-controller:
+    description: |
+      Indicates that this bus hosts MCTP-over-I3C target devices.
+
 required:
   - "#address-cells"
   - "#size-cells"
-- 
2.37.2


