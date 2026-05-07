Return-Path: <netdev+bounces-285205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOSEJLda/GndOQAAu9opvQ
	(envelope-from <netdev+bounces-285205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:26:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF34E5D6B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FBFB300613A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E72392802;
	Thu,  7 May 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Gt2DPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619D3624A9;
	Thu,  7 May 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145971; cv=none; b=EcZrNBUpiHzJzdQFoMM1QJTPlfRECUgARyT91A3CLVEoUPMCoAb71t61in1TpLAa8yHZJSYFqPsW4pMDVB3ndGZeALBDIDHHNW+tQeylmjVW2vwZhbz5aHl6SAAc0IruA3N0ar3qZAOsg6vT9RlKtsAiZfhHRtAlb7fpy6KAKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145971; c=relaxed/simple;
	bh=M8446rQYXm25f4tOwkQac0ktifqMOUyoEgxlb33J5xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FHL2gXQVxni4zVOwJ3o/8fksBxeB/kYQVN9+BFDcEqXSriorY/gSMun0tPNYz/igbiuVuGQ7FHvhdIuFzVdFFuUE6SYA0MpROkPtNH03q58mEZwlDsRCAl+x055sge8ZM18HWXUUpNK0+naRvvv/GkBeIVFYIdHxNPM4rjNAueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Gt2DPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F418C2BCB2;
	Thu,  7 May 2026 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778145971;
	bh=M8446rQYXm25f4tOwkQac0ktifqMOUyoEgxlb33J5xI=;
	h=From:Date:Subject:To:Cc:From;
	b=C8Gt2DPR3kPu9HbsqIvVlCRlfeKMKCmKVuEuwoi/496fGmluE36Kc9OSr3bWL636V
	 JdM9bIMMDkrIJ/aQUaw5t5ahLTRYMDzEYqv4v1+oyP/TvKb3zYZO3Mf7Cs6QDHqVbZ
	 rNvxvHOhMiCV9S5D6/08zUbK9OGar6p3EFxeOQHsfacD46D/yEt3IwNWtDBDGXJ88d
	 BRvKU3jRLf7WuFtMvmfpZ3NDPxlmMa+dK8FmfsNmd29irIHoCtIOr5mY57he2L0txs
	 4IiLEakiKMg2SJ0T8T1jn5b60sQxiXE6Lqm4y+uwyOsMjAG4YJPtMcsw0oserHqk0c
	 VKhsS2A+ld/ng==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 07 May 2026 11:26:01 +0200
Subject: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBsYA4m1V5Euohl1Shklo1II3
 r2xXb7F/xmUEpPCo8qQ6GDlRQrqWwXDHGQiw7EYLFqPDhvzDtJ6b3qWyDIZjKO3Aeu7wxZKtCY
 a+fMbds+/de9fNGzXBc7zC/aDzgNyAAAA
X-Change-ID: 20260507-lan966-binding-0df62a018509
To: Herve Codina <herve.codina@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 36FF34E5D6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285205-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.254];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The dsa.yaml and ethernet-switch.yaml bindings recommend
prefixing ethernet switches and ports with "ethernet-" so
make the LAN966x do the same.

Reported-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
index 306ef9ecf2b9..0f0f35865ef4 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
@@ -17,7 +17,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^switch@[0-9a-f]+$"
+    pattern: "^(ethernet-)?switch@[0-9a-f]+$"
 
   compatible:
     const: microchip,lan966x-switch
@@ -70,7 +70,7 @@ properties:
     additionalProperties: false
 
     patternProperties:
-      "^port@[0-9a-f]+$":
+      "^(ethernet-)?port@[0-9a-f]+$":
         type: object
 
         $ref: /schemas/net/ethernet-controller.yaml#
@@ -138,7 +138,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    switch: switch@e0000000 {
+    switch: ethernet-switch@e0000000 {
       compatible = "microchip,lan966x-switch";
       reg =  <0xe0000000 0x0100000>,
              <0xe2000000 0x0800000>;
@@ -151,14 +151,14 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        port0: port@0 {
+        port0: ethernet-port@0 {
           reg = <0>;
           phy-handle = <&phy0>;
           phys = <&serdes 0 0>;
           phy-mode = "gmii";
         };
 
-        port1: port@1 {
+        port1: ethernet-port@1 {
           reg = <1>;
           sfp = <&sfp_eth1>;
           managed = "in-band-status";

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260507-lan966-binding-0df62a018509

Best regards,
--  
Linus Walleij <linusw@kernel.org>


