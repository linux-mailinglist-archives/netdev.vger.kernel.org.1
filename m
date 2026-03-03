Return-Path: <netdev+bounces-263348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E4kLMkip2mMegAAu9opvQ
	(envelope-from <netdev+bounces-263348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:04:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A8E1F4ED3
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FFFF3065F02
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9D377EAA;
	Tue,  3 Mar 2026 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j2ajA9sQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14ED3264CE;
	Tue,  3 Mar 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561085; cv=none; b=HXjN9hJbhdJEByD9ztxB+p2rLOXCOGYX2Qp6wDFJLLAvQSRDFPP3ulbuTANPl14/LcQPnOwVHxAdzP7GpFQNGfChccEbMayLoxLGnt+iXnH4bw+9OUHbSpzZ8SRlQuMoUJD4utT48fz1KYLaJPoOQr2UTpfRnD+GkNnQp3FcRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561085; c=relaxed/simple;
	bh=t4zK7NTHUyQbdGFZkkU3CbwoIF9aUvQz3CB5fTHlilg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8GVjEQyOI2kfbQDeUr5opeVUgCktaHnF5cmY+Ck/UwMUzVCXaWfQYgOqEb4utQc42ifDvMc2Isu4NkVQHYcsk3u9vqkxE0XRTvace+QQdBc7E27IJ9UADg8sPEISUsxH8ftt9Q9lGR5EOCg0GoJbyWtzRou1nzAYXIq5AJ2iVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j2ajA9sQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772561083; x=1804097083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4zK7NTHUyQbdGFZkkU3CbwoIF9aUvQz3CB5fTHlilg=;
  b=j2ajA9sQc2HsqAfvoKjHER/H6ZnUcRflA0h51Jc51Y5LQILVIbGsNiRU
   6GX0T2Dpg3NtOGe4x3jkmYcNoYpOtVdMCwq39/9Kdk6OoF/qcHyENtPAb
   LaTW9SCPHZJ4WIgUrebT3HH6/AlcEAoa55MaO/4vuCdV3exPJORIq6sWV
   XtjZc5j2c0XYyjWD2Q/tmDtsbQVIRYlP5zDpQ9l/ntGRx26vkLM/s9mMq
   tEeWYUBIC+Q4I101Fq+0M2XCpINVGvJwMF0lnx4CwLBRGF8OtwT4wTgTJ
   rRp+65QEEkNPRcACL4U19neDwilwIBKRaFEB4BsPLJ2hBHhJlRMjv65Gw
   A==;
X-CSE-ConnectionGUID: R0Y1SJ/2TCKiAbvM64J+LA==
X-CSE-MsgGUID: UiADTrq8QEON33fQEzWX1w==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="53419561"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 11:04:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 11:04:19 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:04:18 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/4] dt-bindings: net: cdns,macb: forbid phy nodes for Microchip p64h
Date: Tue, 3 Mar 2026 10:03:16 -0800
Message-ID: <20260303180318.1814791-3-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303180318.1814791-1-charles.perry@microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 29A8E1F4ED3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-263348-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,80.111.88.32:email]
X-Rspamd-Action: no action

The GEM IPs within Microchip p64h have their MDIO controllers
unconnected from any physical pin.

When compiling a p64h device tree with a phy on a GEM node with
CHECK_DTBS=1, this generates an error like:

```
linux/arch/riscv/boot/dts/microchip/p64h-hb130x.dtb:
ethernet@40004180000 (microchip,p64h-gem): ethernet-phy@0: False
schema does not allow {'reg': [[0]]}
	from schema $id:
http://devicetree.org/schemas/net/cdns,macb.yaml#
```

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index dff350302098..be66cc9a42fd 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -197,6 +197,17 @@ allOf:
       required:
         - phys
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,p64h-gem
+    then:
+      patternProperties:
+        "^ethernet-phy@[0-9a-f]$": false
+      properties:
+        mdio: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.3


