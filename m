Return-Path: <netdev+bounces-43038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279387D118D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB891B21387
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D05B1D553;
	Fri, 20 Oct 2023 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="c/Q8FSB3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB71D54D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:26:23 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E5D5A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zWH27i+cvXvmcutNDHehRu32MxOdvX+prdLpdMQ5kwI=; b=c/Q8FSB3GNA3R3BWeNJ86Dx1Jp
	T62AEJ97X9Kr5ESupDFAS+oPYivvmF1IDPxgzFifkzq0nkCKZNIZcack4nO62np11DWVaTUtduKlf
	kOpX+tmbbE0WhTScuyXpF/1LscsEzsdjJrDe2f9if5cfmvUJEnWagaee3nFLkwoP//U1m2uZlKXa9
	+ZykZNeIIeVZwBu5Ho7688trfV9GEJrMIkrBtPWzljlOh3d6v3VQbq254FhDtDC1D2sNC3c2JEx7e
	YuPR48IDlM0Opk4qU+oIbqXWeusLKsn2802mzl1iO6EddL/OIQCiotajDXZuAbAMDSacXQp8zXH46
	tu2x3/LQ==;
Received: from [192.168.1.4] (port=55471 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qtqR5-00076K-2F;
	Fri, 20 Oct 2023 16:25:11 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Oct 2023 16:25:11 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <o.rempel@pengutronix.de>, Ante Knezic
	<ante.knezic@helmholz.de>
Subject: [PATCH net-next v4 1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date: Fri, 20 Oct 2023 16:25:03 +0200
Message-ID: <cfeeec0f41a815601439e999a8dc947525b0d938.1697811160.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1697811160.git.ante.knezic@helmholz.de>
References: <cover.1697811160.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

Add documentation for selecting reference rmii clock on KSZ88X3 devices

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 41014f5c01c4..624feb1bb9be 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -72,6 +72,23 @@ properties:
   interrupts:
     maxItems: 1
 
+  microchip,rmii-clk-internal:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set if the RMII reference clock is provided internally. Otherwise
+      reference clock should be provided externally.
+
+if:
+  not:
+    properties:
+      compatible:
+        enum:
+          - microchip,ksz8863
+          - microchip,ksz8873
+then:
+  properties:
+    microchip,rmii-clk-internal: false
+
 required:
   - compatible
   - reg
-- 
2.11.0


