Return-Path: <netdev+bounces-282053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCcmI8QE8WnhbwEAu9opvQ
	(envelope-from <netdev+bounces-282053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:04:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554B48AF72
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77883054BA5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38632777F3;
	Tue, 28 Apr 2026 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="ojYg24Xu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="W19nUQ+O"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99A47B423
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402539; cv=none; b=G71Uw8yPZFiaKZ1Y3xZmCYSV+EOE4DeVFs1TBPguiQysO+hcQuRm4FFCwUzg9MupxqlejfbdMvRfTEx0nq/4YePV8FI7YmyVNdN1qshCU4sWjhSSP3cFzuzOoJTVOhUyeSNx3AwwVMRigUpXgjcITNDTl7PwfOjIp8rquVncscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402539; c=relaxed/simple;
	bh=6EZYpQSXfzKmoLY4VWb8hjjLCe/U9oTEFrcavIOHvNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFPQ4WYiKCW2Wj1mPrInBc+s2AgHL6B04Qk7CZf0g18RcZx5t++gqB4Jl8R8sM5k9ZiOvJVUTHaMRC5+leBU1s7eZmNtYJK3KLRVXRPghJtdPb4xMrk+uZJBoYXWx4F8Q+CwtM6vqSmTKDs/bRE2sMd/i/D7yW3/wg1cQ2BbwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=ojYg24Xu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=W19nUQ+O; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ojYg24XuqYMbKYezVbuB/sbqXSG/T6Kj57GMA9sxE934Xy4xoCuYjop3V6XCxx9NTqSaCIiyUhJLASlm+zqOebP4s52WqkyIJ21y1BO3caSFBpfR7NVDphqp2p7IiBJQpeLJHk69ltDO/2rKSIMzs25KByY72SI0ZTr8ReR2KO/negJXYb/RbXTBmpITyleINjCk8mGMPB/JqNGMEISvi5l1S876wN/7WO2tUcuRpgzeJs0qe6Prz9OK3yGQyA9EU8tIzyZcxwCJCkfHyREjmm4De1sLkbk/UTnegSOo65g6BMl4HhYIVRxpJwanpzwEZIBKRgHmuB5BPOlcQUIH2w==; s=purelymail2; d=tinyisr.com; v=1; bh=6EZYpQSXfzKmoLY4VWb8hjjLCe/U9oTEFrcavIOHvNY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=W19nUQ+O58BfiUCu+2f3EYoG0dHmcX8apPhBSb1rr0GGs3BvUyDn7AZkD1MW7mAuzI9+ZW6hEHNsgR8GPNmMTWde3foTn5aviaihrXcqOXbTxbYE1+8U3FXqXy2DcvupMSIhYG2dxksYPQeXjSR4JJNR1J+hlv+6I/Biq+RLwEpsKjLtCiP1v2XywNdF4Evf97zPfLRoQ5/qQkRT03lqhtJhBJ0C76C4+D1TD6qFMK6+Q3jZ76ENXwYDo1YjZa5Ke6HT4d1O8xqNsJnB816jprml0JFPrr8LaqqcOjZwfX6HMTS2TR3fVGKiP8kJHRgvZawIV4gcoApcxfj5i5pssg==; s=purelymail2; d=purelymail.com; v=1; bh=6EZYpQSXfzKmoLY4VWb8hjjLCe/U9oTEFrcavIOHvNY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -825627856;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Apr 2026 18:55:35 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v3 1/4] dt-bindings: net: dsa: add MT7628 ESW
Date: Tue, 28 Apr 2026 21:55:07 +0300
Message-ID: <20260428185510.261521-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428185510.261521-1-joey@tinyisr.com>
References: <20260428185510.261521-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 2554B48AF72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282053-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[tinyisr.com,reject];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.980];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add bindings for MT7628 SoC's Embedded Switch.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
new file mode 100644
index 000000000000..a9db9057ee54
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/mediatek,mt7628-esw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT7628 Embedded Ethernet Switch
+
+maintainers:
+  - Joris Vaisvila <joey@tinyisr.com>
+
+description:
+  The MT7628 SoC's built-in Ethernet Switch is a five port switch with
+  integrated 10/100 PHYs. The switch registers are directly mapped in the =
SoC's
+  memory. The switch has an internally connected 1G CPU port and 5 user po=
rts
+  connected to the built-in Fast Ethernet PHYs.
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: mediatek,mt7628-esw
+
+  reg:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: internal switch block reset
+      - description: internal phy package reset
+
+  reset-names:
+    items:
+      - const: esw
+      - const: ephy
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+  - ethernet-ports
+
+examples:
+  - |
+    switch0: switch@10110000 {
+        compatible =3D "mediatek,mt7628-esw";
+
+        reg =3D <0x10110000 0x8000>;
+
+        resets =3D <&sysc 23>, <&sysc 24>;
+        reset-names =3D "esw", "ephy";
+
+        ethernet-ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            ethernet-port@0 {
+                reg =3D <0>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@1 {
+                reg =3D <1>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@2 {
+                reg =3D <2>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@3 {
+                reg =3D <3>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@4 {
+                reg =3D <4>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@6 {
+                reg =3D <6>;
+                phy-mode =3D "internal";
+                ethernet =3D <&ethernet>;
+
+                fixed-link {
+                    speed =3D <1000>;
+                    full-duplex;
+                };
+            };
+        };
+    };
--=20
2.54.0


