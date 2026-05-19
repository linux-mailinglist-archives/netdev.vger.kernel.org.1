Return-Path: <netdev+bounces-289337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB5JGDYoDGq/XgUAu9opvQ
	(envelope-from <netdev+bounces-289337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:07:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254157AE53
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB0C5305666D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1F3F58DA;
	Tue, 19 May 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kca+IgSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE93F4120;
	Tue, 19 May 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181102; cv=none; b=f4gOmQD8ghN9VLMycbggIaWP/nT+qch4hWOc9hzAhLVAXcrFnsmUDxK+/AMmgD2h/CLvhBjsc97/vxzQDUlYBvoLAqO/UgM3gkNYhd1eamg5if8BkdYbJEhECFYovdPMRd8dRBVWyeDVSSXSDrJiAsiopiadw3142mgWmry21Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181102; c=relaxed/simple;
	bh=UtsK2QBTB6PMpF7a38ma3yHKUUxqwno/B5pp2VQGoK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYA3IUR9YOhCi3gF86RVyOplUQ0VhMPxcp0qVGl0WELxPEjYHLxM5I2iL5kZO1GgLcHEAWLm48EM0qDKxPJojXIXq0QeGlAnVDILM2SvaG7FIHkcsv443UQg6Y7nlzEeckqDEP2Yc7I9JBVv7vwYoEYAntyOrtU+Uds98YOwpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kca+IgSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0E2C2BCC6;
	Tue, 19 May 2026 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181102;
	bh=UtsK2QBTB6PMpF7a38ma3yHKUUxqwno/B5pp2VQGoK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kca+IgSPWAKP+Hk8/qBV2heaTHp6kxS8/KHSTbCa0IAr8BUrMmOwV26UJPcByTmlY
	 OqrR2GEdkaeIS6aPUQ19SK6FPKv6G8KrL+gpxNxzEP3HkpBBOdcRIDZv1ELr3MMP6s
	 OD57SS5UvARmB195EMBMfXuEfLg2y+tgKm9aIadqeGbNuWLcjEgZ5cbGvVdquQ0PiI
	 I38XC1Wn3Fn92I8zfCU3JsydmbyrcycNL6Mgq5gEcEL9YLUpfxS68SV6lcO8ShrThl
	 CQ4hUoixoqm/PM8MlygWc1QIOh8mlEYIIKhIKZPGtyQ+IrVGBh9t21DRngFGzriTcJ
	 P09ELzaSWm5Nw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 May 2026 10:57:44 +0200
Subject: [PATCH net-next v8 01/10] dt-bindings: net: airoha: Add GDM port
 ethernet child node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-airoha-eth-multi-serdes-v8-1-6bd70e329df6@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289337-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,0.0.0.1:email,0.0.0.0:email,0.0.0.4:email]
X-Rspamd-Queue-Id: 0254157AE53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
As a result multiple net_devices can connect to the same GDM{3,4} port
and there is a theoretical "1:n" relation between GDM ports and
net_devices.
Introduce the ethernet node child of a specific GDM port in order to model
a given net_device that is connected via the external arbiter to the
GDM{3,4} port. This new ethernet node is defined by the "airoha,eth-port"
compatible string. Please note GDM1 and GDM2 does not support the
connection with the external arbiter and they are represented by an
ethernet node defined by the "airoha,eth-mac" compatible string.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 56 +++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index fbe2ddcdd909..17fe2edf4886 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -130,6 +130,42 @@ patternProperties:
         maximum: 4
         description: GMAC port identifier
 
+    allOf:
+      - if:
+          properties:
+            reg:
+              contains:
+                items:
+                  - enum:
+                      - 3
+                      - 4
+        then:
+          properties:
+            '#address-cells':
+              const: 1
+
+            '#size-cells':
+              const: 0
+
+          patternProperties:
+            "^ethernet@[0-5]$":
+              type: object
+              unevaluatedProperties: false
+              $ref: ethernet-controller.yaml#
+              description: External ethernet port ID available on the GDM port
+
+              properties:
+                compatible:
+                  const: airoha,eth-port
+
+                reg:
+                  maximum: 5
+                  description: External ethernet port identifier
+
+              required:
+                - reg
+                - compatible
+
     required:
       - reg
       - compatible
@@ -191,9 +227,27 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        mac: ethernet@1 {
+        ethernet@1 {
           compatible = "airoha,eth-mac";
           reg = <1>;
         };
+
+        ethernet@4 {
+          compatible = "airoha,eth-mac";
+          reg = <4>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          ethernet@0 {
+            compatible = "airoha,eth-port";
+            reg = <0>;
+          };
+
+          ethernet@1 {
+            compatible = "airoha,eth-port";
+            reg = <1>;
+          };
+        };
       };
     };

-- 
2.54.0


