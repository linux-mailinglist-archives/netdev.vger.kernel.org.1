Return-Path: <netdev+bounces-263089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMsSJgKopmk7SgAAu9opvQ
	(envelope-from <netdev+bounces-263089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:21:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18271EBC17
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBA430927CC
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA94386445;
	Tue,  3 Mar 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Les66rwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32838C2D5
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529623; cv=none; b=RGQmbVfDlsqRZJm0APn2RGIhocq0lYH7nXfXkbt3KVAgB7hO3E/vFzD/28CyXFriWwg3FAs5vHhACr8h+T0c41jCmyVguURD+dFRrExglzN5e+ZWcnrKrJK90S6sTSkNrU08NdNZxXV8XB28s8AdfJ6k/gkj1FIjpK3tko3w5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529623; c=relaxed/simple;
	bh=w0voN7DAj/dNfGQMeT/43pg3dhBjOLP4K94ToUi4460=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og0CTR9axOuUkJgRxFtPsJQTFkq6zSPlsHWzCgbr06pmD1OKUqaKVeRPzI9a9zUqkQYClWywWrIS55N1grhOJJeJfR1LBLbw5WnsF/hkUM4u3zwE8Bw0djpCEd8y1Au8R1bbo1L/VOXQPqPd4nyWkfEu/5I+tTWDansqbAasO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Les66rwz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab077e3f32so23776875ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529622; x=1773134422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlyHDmizNIkIW1kEBSDJurvUimBBLmNsme12b6R+fQc=;
        b=Les66rwzDW6HzcYz7OuDJg+1ltWtCwAYz6PuU5YoWs7+XRDZq9FXPX0ni32HBWQ9Jq
         YhCtTNc/ZTZ14p71f7jQ7AoiUpVX5BScSC/3yMSw5EN2hImqqvdDSdvFucIq2oYjb5Sq
         NcPb5prP861zS+ITSwQ9dFH2Cbss6oHvRL7QDqZnRUAOtwu6OQn5ufBWga+VZX2F6CtV
         B8Boxet1SEmo+xfyTORH0knYql7ml80GuHy7geBAKQdhzsd15dOJlU+JDU9Oip2oq5JN
         ApNOFpJb8Dk80Q7qqdyJNrtE2GoJPP57FuW+v33/flgiwvWz4OP12gjtmIGvIvd9Xb5r
         vO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529622; x=1773134422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlyHDmizNIkIW1kEBSDJurvUimBBLmNsme12b6R+fQc=;
        b=PC3Q0ERCvqQ13iY4t9FBevqeQQ61kCX5l8ZOpb9CMKuElsO6X3DmSu11bYuEcFW8YF
         Ge98lvYOE6DLxDZlFh4+k4uu+YOYQ7DeFqJU7A7sCusYhQxojX5R4sDAvtZihMKTBteE
         meJ4wl8dcM9zMN3Rs0qT2MY4+CoTf09WsA2eapO9dPhyjVIuDOoGftha/RB9LLezj/QN
         kBw/LrLbF0/+KnXBSNpxXOluCiJEERcdOLYSjpcWcJPw+JevaKBjJDEJrfEuW8a7qWfC
         zBszN5TUm3mi4Fev/88FdfmQPo9D8+z9sXGAU4RNgkwWlYbtwQJZiWHQjlaS2BhQ0iKF
         uqQg==
X-Forwarded-Encrypted: i=1; AJvYcCUiYCaPYtxtfugl1Jp621ddTLiOp06G4APjavZUuxmgSVfgYP4FGsVEEYO6XNpKLSu7SP+N7+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWZbqEOUCaxl+CNuAyipStNOFbdxrBr0KxeM95o6NJ1YYKObq
	i4M7Fyrb/JaIDbmgoY4ybIEJKrNgZCw9eX3rTtYNGdRuhz6pLA7+O0ic
X-Gm-Gg: ATEYQzzoxkHz8PJV30dk6LqQflbCZ1sJd5OYhk3UV6x6GJXlVLwZwVF2rBNweApK+aB
	Chnq/UQKHV10qYTxPQQA6tqIgy1EZdeGb4MvQlJyVChsObhCUeAE6rRA3NkSSha/NTkE0Hgn525
	INP9agxI6s31WUT2BjGMYUF2fBZa5H9C0ne3HeLDaev/MNLlvo1KefhwIv9eV0SW5ZWyOcM4C52
	ti00R3gvc7TGzEH4zN4vcMVp+iV3KBpkEDadP89W/NaepdXjYYQIp5q+LjCoj+mh44mnWkNwdTu
	99AIF5ulXIUyIf2pgwWa9wG0lePvuKpdi7pi7hCBeGgu0E34a2MyN43qJIFWtJPvjUm33oCiTNH
	Z7JYc8JIGNzxCet+eSmNRegDfG2lYOAtdW4jiyhzOfVdxLGk18LDwCVPyBe+bzBBGFTPYoTVKvf
	UprTWb12RgNHZxaa4mA1BGNG+J6jUqJaRCbSou5FbdZI9S9j8jGf5UtPv+6s1myQpmzQakcsAe3
	SSyd+UtTCFA
X-Received: by 2002:a17:903:1b48:b0:2ae:5426:da4f with SMTP id d9443c01a7336-2ae5426dcabmr60869725ad.28.1772529621612;
        Tue, 03 Mar 2026 01:20:21 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f996sm158777475ad.50.2026.03.03.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:20:21 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net-next v13 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Tue,  3 Mar 2026 17:20:04 +0800
Message-ID: <20260303092006.263715-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092006.263715-1-a0987203069@gmail.com>
References: <20260303092006.263715-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F18271EBC17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url,2.100.46.192:email,nuvoton.com:email,0.0.0.0:email]
X-Rspamd-Action: no action

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 131 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..90c28fb13985
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton DWMAC glue layer controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.73a).
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: nuvoton,ma35d1-dwmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    maxItems: 1
+    description:
+      Register range should be one of the GMAC interface.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: MAC clock
+      - description: PTP clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to access syscon registers.
+          - description: GMAC interface ID.
+            enum:
+              - 0
+              - 1
+    description:
+      A phandle to the syscon with one argument that configures system registers
+      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  phy-mode:
+    enum:
+      - rmii
+      - rgmii
+      - rgmii-id
+      - rgmii-txid
+      - rgmii-rxid
+
+  tx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII TX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+  rx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII RX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+required:
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+  - phy-mode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+    ethernet@40120000 {
+        compatible = "nuvoton,ma35d1-dwmac", "snps,dwmac-3.70a";
+        reg = <0x40120000 0x10000>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 0>;
+        resets = <&sys MA35D1_RESET_GMAC0>;
+        reset-names = "stmmaceth";
+        snps,multicast-filter-bins = <0>;
+        snps,perfect-filter-entries = <8>;
+        rx-fifo-depth = <4096>;
+        tx-fifo-depth = <2048>;
+
+        phy-mode = "rgmii-id";
+        phy-handle = <&eth_phy0>;
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eth_phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 38bc34dc4f09..de04cbbab0c6 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -69,6 +69,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,ma35d1-dwmac
         - nxp,s32g2-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
-- 
2.43.0


