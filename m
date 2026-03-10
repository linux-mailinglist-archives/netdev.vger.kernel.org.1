Return-Path: <netdev+bounces-266343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF3zDf+MsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:28:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD925844C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E33B321B876
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457BA3EF0AF;
	Tue, 10 Mar 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fAyPTw27"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A123EFD14;
	Tue, 10 Mar 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177801; cv=none; b=uhpzE8NtTTEiK5Ys5xv/6PD6nNq2P2ypouKFm6zhXWbXuXS3OmHOzHrrmTBCjl21mfrhOV/XAJJ5fjt8UtEZUcdDIOI0sF1/GVSPgug9s8vd6XCxGds+VF1276mugrTP193+NIgnySf50SOhIiiuu6z0uXpqt6lUS1q/5jkE4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177801; c=relaxed/simple;
	bh=sKRrvDytTmyt1Z+JFtTYOG5tJuchvMD3m09IgP+uAn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZAVzbwqwmxQXhIhDnnv5RGjx7Dm6QE7km7MzMupYtlMkN/2iJ/kS+10lh6KGpKKQp307p4laBt1TDiSjp6y54OX/Rt7KbL4KR0JsO3AI0B8lXFiAWWj6eNlAXUdFZfNXWyyTgTKXzGXs5S2klB6Cnsm98JsC547YSKqCw1UKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fAyPTw27; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773177793; x=1804713793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKRrvDytTmyt1Z+JFtTYOG5tJuchvMD3m09IgP+uAn8=;
  b=fAyPTw27HEZv5HO8HjM5Q/E/gjOapLabN782aZaxQGjziIyclpQtcQts
   U1TtZoXoE7kxf05gN5427zSK9pIXIpWPSEJH+5S0YEYE2LQWwo8pTFpgd
   llLQX1L4LF0o3j6XhdXxTCIzjo0nXe3roeZ6jjoSlQRpQS0pHGepUZ7w8
   QZzHZEhtQXV0UT1JPKGiNVCcYvpTgFXlhE3ki2QYdBKzJbSAgPq/0TSw1
   j7AGCWkgXLxPR6/fK+OPBn3cvgi4Ej6J+vSqhX1bzyAZpc59BbTUZZMG0
   jykzpQKm2rEf8NYHhzx42GP2azFEg4bxD8ArUugRYTIjZSLLVt22MUB43
   A==;
X-CSE-ConnectionGUID: Fckl8p3GQOSmyEqqzS7I1g==
X-CSE-MsgGUID: UDnyZ/OxQ8q9zwdkeiuS9A==
X-IronPort-AV: E=Sophos;i="6.23,112,1770620400"; 
   d="scan'208";a="62045475"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:23:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Mar 2026 14:22:53 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 10 Mar 2026 14:22:52 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
Date: Tue, 10 Mar 2026 14:22:00 -0700
Message-ID: <20260310212202.3991199-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310212202.3991199-1-charles.perry@microchip.com>
References: <20260310212202.3991199-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 93DD925844C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266343-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Action: no action

Add "microchip,pic64hpsc-gem" for "PIC64-HPSC" and
"microchip,pic64hx-gem" for "PIC64HX", compatible with the former.

The generic compatible "cdns,gem" works but offers limited features.
Keep it as a fallback.

The GEM IPs within pic64hpsc have their MDIO controllers
unconnected from any physical pin. Add a check to prevent adding PHYs
under the GEM node.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 .../devicetree/bindings/net/cdns,macb.yaml    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index cb14c35ba996..b934abd98e20 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -70,6 +70,14 @@ properties:
               - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit ethernet interface
           - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
 
+      - items:
+          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
+          - const: cdns,gem
+      - items:
+          - const: microchip,pic64hx-gem   # Microchip PIC64HX
+          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
+          - const: cdns,gem
+
   reg:
     minItems: 1
     items:
@@ -196,6 +204,17 @@ allOf:
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


