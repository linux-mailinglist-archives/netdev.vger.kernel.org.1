Return-Path: <netdev+bounces-304662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fq84MQgbSGqLmQAAu9opvQ
	(envelope-from <netdev+bounces-304662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:26:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 629107057A9
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:26:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304662-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304662-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C23130103A3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF933FE0F;
	Fri,  3 Jul 2026 20:26:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MTA-14-3.privateemail.com (mta-14-3.privateemail.com [198.54.127.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75F326945;
	Fri,  3 Jul 2026 20:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110404; cv=none; b=YMQZ3Clty7WIXqyDReVYfuvkvEmoPIas5MwSwWhCkbMCKbL4VgzRyaQ75S6v1DHU/68JNVoVg66B09kPfp9694l7OEMx/vfxMMuAyo8N1XZBIQYvHH9aTclb0/1QGARZ/d63fAjCo8YKMWYvyEO+FTi78XoZ1CJJDuEcYjA2yDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110404; c=relaxed/simple;
	bh=MhJYzX+IS9Ez004ql3MXyllQeQr4sWb4T59nN00QNsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNdBNPxVUbEAnIpJwKLLWITcgpR2JiyefsWvgJHTLhfS874CjlnAlffprUS/djcvi8YTovzPLwTk3pdt6TNVKPjMtogFQOYooDjbSm7csRa8Nvu5K7PXmrYNuBbEK5KUjto0Ivh2WoznYUHK/XjPLSfTiT7j+cNPVc9IbWvQIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.110
Received: from mail.privateemail.com (K8S-PROD-WORKER-02 [87.215.145.39])
	by mta-14.privateemail.com (Postfix) with ESMTPA id 4gsQJK5RVCz3hhTP;
	Fri,  3 Jul 2026 16:26:24 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH net-next 1/2] dt-bindings: net: nfc: samsung,s3fwrn5: add S3NRN4V and clk-req-gpios
Date: Fri,  3 Jul 2026 22:26:00 +0200
Message-ID: <20260703202601.78563-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703202601.78563-1-jorijnvdgraaf@catcrafts.net>
References: <20260703202601.78563-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304662-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[catcrafts.net];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:david@ixit.cz,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jorijnvdgraaf@catcrafts.net,m:andrew@lunn.ch,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jorijnvdgraaf@catcrafts.net,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorijnvdgraaf@catcrafts.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,catcrafts.net:from_mime,catcrafts.net:email,catcrafts.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 629107057A9

The S3NRN4V is an S3FWRN5-family NFC + eSE controller found e.g. on the
Fairphone 6 (SM7635). Add a compatible for it and document the optional
clk-req-gpios property: when wired, the controller drives this line to
request its reference clock (needed to generate the poll carrier), and the
driver gates the clock on it instead of leaving it always-on.

The line is modelled as a GPIO rather than an interrupt because the driver
reads its level to (re)synchronise the clock state, not just react to its
edges. It is only meaningful on the S3NRN4V, so it is restricted to that
compatible.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 .../bindings/net/nfc/samsung,s3fwrn5.yaml     | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
index 12baee457..3ebcd0933 100644
--- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
@@ -14,12 +14,20 @@ properties:
     enum:
       - samsung,s3fwrn5-i2c
       - samsung,s3fwrn82
+      - samsung,s3nrn4v-i2c
 
   en-gpios:
     maxItems: 1
     description:
       Output GPIO pin used for enabling/disabling the chip
 
+  clk-req-gpios:
+    maxItems: 1
+    description:
+      Input GPIO pin connected to the controller's clock-request output. When
+      present, the reference clock is enabled in response to this signal
+      instead of being left always-on.
+
   interrupts:
     maxItems: 1
 
@@ -58,12 +66,25 @@ allOf:
       properties:
         compatible:
           contains:
-            const: samsung,s3fwrn5-i2c
+            enum:
+              - samsung,s3fwrn5-i2c
+              - samsung,s3nrn4v-i2c
     then:
       required:
         - interrupts
         - reg
 
+  # The clock-request handshake only exists on the S3NRN4V.
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: samsung,s3nrn4v-i2c
+    then:
+      properties:
+        clk-req-gpios: false
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-- 
2.55.0


