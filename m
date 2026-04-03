Return-Path: <netdev+bounces-275168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKGQDAEP0GlQ2wYAu9opvQ
	(envelope-from <netdev+bounces-275168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:03:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2C39778E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E357304D147
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CB3D4102;
	Fri,  3 Apr 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="szKzb5ej"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45535DA61;
	Fri,  3 Apr 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242970; cv=none; b=OTK/vqVZDZoNtuRaDxHhB0hzW45Lp9mW7uaDx3zZyQOabOK0m/cUR4kq2Sbei/0CgY0OeNkIWuMcc9JQtzdP+rJB6hecAgsWRXrnAMpr6Y2+gbNoxssTdvujYYXEgrGZbRcuP+SYtYQViOmNbMof5HwH4XPtn6TUAtOJpa6M3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242970; c=relaxed/simple;
	bh=82E1gNqQHbMmQCdl7prDr0d+QbB+S0A7xhvVfG/XcdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgEChUIyAX5WDRbBaF43aTGuj1Z0biGyxVCAQQQiosFFunfnKT4SsDWYYaD4DAVpaL3V0RP2wtiEUOyCwLzt6c/LVnamMIx7LAxPNG9D7/8xcTf88JJjb3Zky+t66j+tFHrxOYNaYgy7dY4q3yKMDJV5VnEFhnt4LG0kfS99x2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=szKzb5ej; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87E5EC59F63;
	Fri,  3 Apr 2026 19:03:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D11E603C1;
	Fri,  3 Apr 2026 19:02:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3625C10450100;
	Fri,  3 Apr 2026 21:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775242966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2gFAv0dcUzXb0YHZi0Q5hVFzBQwFov8rssI1Wgkp5+g=;
	b=szKzb5ejqSC8vuo21XdOCnskZXlaCPQhacWmUb0f/c4E8e/pBCAScYiD0wtvQXbl2VHXRp
	/qdGQICv6I7Wgdmm1QKoIdA4gzDF32XegR/fUrtSf3RHr1Pi405Uh58mJGEl9nIsdwgvBk
	Owo18Ta5CuItWl5z2R5UE9QJ3bNoDGinz3EaGQqvk+r5xEki6Ffm02/8xTtRaWc2GKCR++
	/o8PMUnaRtrjnrbIlqbNjAT+0RMBR1Y3t4MxZGdBcvlBG+P3oEes04KRoIvHOqOtGiYgQ/
	8oqsKz0WspqOhTmK5Qm0gkHQF8bNAozabOfSJGAQ+DS78tgL2Cue8LiNymgpaw==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 03 Apr 2026 21:02:23 +0200
Subject: [PATCH 1/2] dt-bindings: net: Add schema for LAN75XX compatible
 USB Ethernet controllers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275168-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BF2C39778E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Create schema for LAN75XX compatible USB Ethernet controllers. The smsc75xx
driver only supports LAN7500 and LAN7505 devices.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b84022976044ffec2024cff9fc0aa5016723abed
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan75xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN7500/LAN7505 USB Ethernet Controllers
+
+maintainers:
+  - Thomas Richard <thomas.richard@bootlin.com>
+
+description:
+  Device tree properties for LAN75XX compatible USB Ethernet controller.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - usb424,7500
+          - usb424,7505
+
+  reg:
+    maxItems: 1
+
+  local-mac-address: true
+  mac-address: true
+  nvmem-cells: true
+  nvmem-cell-names: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1 {
+            compatible = "usb424,7500";
+            reg = <1>;
+            local-mac-address = [00 00 00 00 00 00];
+        };
+    };

-- 
2.53.0


