Return-Path: <netdev+bounces-243628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB783CA4BB5
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D360430552E1
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08372346A10;
	Thu,  4 Dec 2025 16:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 9.mo561.mail-out.ovh.net (9.mo561.mail-out.ovh.net [87.98.184.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093426E6F3
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.184.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866393; cv=none; b=tLhHatUghCWK6/2Z1XL2nV1O2HmnHkILZ111wp4vm2cS+w8LGHUYJDr7kfc9U5HJFMSlifaqgiStCmfxHPK0cRO7V9SqXDz46qmAVwpovNJHYSRB8dJCLp7DcpRpwsZw7/EWm9uIZtZ5Md87XWvAWdhpZIn0vE585D/28KjyREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866393; c=relaxed/simple;
	bh=YgsFnZuDSq0GL2hrNLtRnqJd46AcXwGsEsQYq7gDQkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKCk6hxPiuQHWM4e9LqbqK8ac0UvvVv6k35Im2aueVV7ukPIMfq9qDZjPwKDfa56LaHlmgWGapj0JXggsRZnOBigm1yZQWdidTd7CDaDxBxgr2FdxzlRuB2ZfbJshyV6ZjBWr1TTHYDEQCGjiFznDNjk4wO0D5JbK3cJ0yekMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com; spf=fail smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=87.98.184.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bp.renesas.com
Received: from director6.ghost.mail-out.ovh.net (unknown [10.110.0.68])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4dMg4l5jLbz6VGD
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:31:35 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-mkpf7 (unknown [10.111.182.250])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 965B3802FB;
	Thu,  4 Dec 2025 16:31:34 +0000 (UTC)
Received: from labcsmart.com ([37.59.142.99])
	by ghost-submission-7d8d68f679-mkpf7 with ESMTPSA
	id GduLDmO3MWnQjQQATXHgnQ:T3
	(envelope-from <john.madieu.xa@bp.renesas.com>); Thu, 04 Dec 2025 16:31:34 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-99G003460cefc4-7799-47b2-966c-ddc2d12940b4,
                    E90FA267686E4F2ED65044873A5FD8D85CF2A6B0) smtp.auth=john.madieu@labcsmart.com
X-OVh-ClientIp:141.94.163.193
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be
Cc: biju.das.jz@bp.renesas.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	magnus.damm@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH net-next 2/3] dt-bindings: net: renesas-gbeth: Add port-id property
Date: Thu,  4 Dec 2025 16:31:21 +0000
Message-Id: <20251204163122.3032995-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251204163122.3032995-1-john.madieu.xa@bp.renesas.com>
References: <20251204163122.3032995-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13215531634329355653
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGTG1S+3Oe5+8Q7M5Xj6P3TY9ZSd28daoqwJLfe4PAzxlZip2ovKqHAZR0UEgCCF584RfnTnm80GuzRzUgxrdRG/nU8CQ35rlXvkCLxVojFBBYDzeRh2XlZwewCG6Sh+IhIXNlqqye8HH6vGv+5xuoLyoXf5eKj5tfXOTcMgYnHKKznzQd/71usWeslfg2b77GUiupjYLNkgufd/jyA42aCrWkhDsfDOjF2UtRx6s+IRt7iEWIy8E0dtI4cvw5d0O8hGPjuMBtOifeyTXEqNtTujffvjjlMY6LUU1br14Ia1rr+ibexdAS4IBukdxwB+yZ+kTJbCrtNA5vh9kt19x5YAUsyCQwnlyDDdeA5aGO69LqAzCY2sUk6FXaduIKbl5xSKheidUOtNZ1hOuLzORIR8a1Tpt+9K1X5aIsBMxydKo1RhdDay8fRLXtDbsg4d8XH4ZNBPiij6mZG3x3L1qJZGZ6vrbZV0zvLytVkvAOMkUSQV01U6f8qV0NDtIrFZjVOvYsTu/gE9MWYGOhJtCMmrLgqJaWKTZme2WC9hLfQCycpcYIqruuLBuf6L4vj0qKvw+Gw77BWwQUwrqbgLGblGM4C9koUCN+9CByslBOzyjxOBHZIPd7em5kl25Ikth84sSLKsd32jM6tLIy6dMIeotH2MF+YC1dw9Stx5BQuIw

Add optional port-id property to identify ethernet ports on RZ/V2H
SoCs. The hardware doesn't provide unique identification registers
for multiple ethernet instances, so this property allows explicit
port identification from the device tree.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index bd53ab300f500..bb59c6a925d3f 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -117,6 +117,23 @@ properties:
           - description: AXI power-on system reset
           - description: AHB reset
 
+  renesas,port-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Optional unique port identifier for this ethernet interface.
+      Used for physical port identification (phys_port_id, phys_port_name).
+      If not specified, the ethernet alias index is used as fallback.
+    minimum: 0
+    maximum: 255
+
+  renesas,port-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Optional custom name for the physical port. Used by
+      ndo_get_phys_port_name() for interface naming.
+      If not specified, "p<N>" format is used where N is the port-id
+      or ethernet alias index.
+
   pcs-handle:
     description:
       phandle pointing to a PCS sub-node compatible with
@@ -230,6 +247,8 @@ examples:
         snps,txpbl = <32>;
         snps,rxpbl = <32>;
         phy-handle = <&phy0>;
+        renesas,port-id = <0>;
+        renesas,port-name = "mgmt";
 
         stmmac_axi_setup: stmmac-axi-config {
             snps,lpi_en;
-- 
2.25.1


