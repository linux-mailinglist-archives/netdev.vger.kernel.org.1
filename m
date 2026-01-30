Return-Path: <netdev+bounces-255025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KFWAY0yfGlzLQIAu9opvQ
	(envelope-from <netdev+bounces-255025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:24:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46445B7131
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18702300CC39
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610B27877F;
	Fri, 30 Jan 2026 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4IWFi4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6331607A4
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747081; cv=none; b=qbyjQv3hRZ1v66YNuKcGZjqiT3c85YmRQsu7pVJX4mtRBDEKlRU1/sZ1FKYrSWkkLQEmkqMqQYWgXxno/QpjgIzZ4Z1yz5d75NyO1qU+gsXokIYRLdrAwAAH9NwQCjOBfblGWAUpkOyayAHuQfkxFIejVrz+fSFbDCtJyVXzPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747081; c=relaxed/simple;
	bh=XG8z2auvVLPIEbb53B7ae1t5gK554gf/2iUDA2auxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1G+D9Mg0POEjtE8cS2RgVOOe8cWzK8AVNW8LrUyLrT8qKyKG5MbCeqDi4BsP/9LW6h8P3ygEX7nhqdOxmBVfpVIb81aweWtE4VmyerCIT4vC2jYvDHERhHOm1W01qQK7y65ApCEBVd0XAZfU9+13C8DPQBl/k/IhtINqFjXX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4IWFi4F; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502a789834fso13530361cf.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769747079; x=1770351879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+T2Zlo06xiXQn/gacLojfwLwZ7jz+x2wxOefgL6ljo=;
        b=B4IWFi4F6vr+QwnDEt9AhtNsg7tSFNBG8AzL0oZ3Bu+9UCA8SacATka5oOvNcCC54V
         qTV53ia1t+mUi+gjrNy4ol8ZSOh16GHxrjZHhRLM1ARGEf0CiSphlEA/zxvX4TWU1Fzw
         Rv5AQtwli8ya7KdvBa7zCkFxKnsFL6/IwAutmJKSBTz1AZeExRopC5OMbblRP+6pW1vm
         luEJsHw8LJ9P+GzYgHZ1/toLcTHVQLPEXWo7SGt7EHdzuRfJmkmKdo+J4tMrbXgEnCj2
         +hFeY8qoAz8FJwbEyYCsNvL2JEHEINZKiDfCnGsxkpBV2BC3xQVjwpn4IXyeCPRyS2fI
         mv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769747079; x=1770351879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+T2Zlo06xiXQn/gacLojfwLwZ7jz+x2wxOefgL6ljo=;
        b=BmfXjMe5XJZ2msVeYZUzuecQVwXxx/l6VyXtYlxWkH4zEz1RmQRce0QKWNupDATXkt
         DaDsJdyos0RCLew/+PNafcY+uoJ0IKMk06zjSet/FBW81ZPhjiKuTbghet3XE2npOggX
         s2v4K+v69+Qc1NKcyTFlLrlIpP+uPIAHayr8AeBlPuyf6iC1eDFLMc7R5E5h0lYdzovU
         VGCb8lBtfOyE4LgkebwiAUfpMPQ1YLFVJQOFwUjhVTeHLI1twk3xcVHuo/Xug1A7/k6n
         4IG+OICjmz36jFU4LaMFR0jejE6zWaitJDBcqEiExRxAbyxHHOuTW3tP7mDXzKtLsSez
         HdYQ==
X-Gm-Message-State: AOJu0YxbSuxx1j6QYOmVrKvhdBG4nlUkdSIlye/mvA7r8HUVh54eQ1N+
	3CBxe1EH+2hSYZHfSuYyJmluD4lD1AxcjftxDaHwZfNBV4asgt94Oo/v
X-Gm-Gg: AZuq6aJWg0Pf6Lrory5zJo85pK/XcJh1AJkLvgcrP+uCsprG3uttLEgWz0eEHAey+N6
	5G1NIXKw2Qn5UMqjnU+q9PhdW0UwzmVMb1K6IEDuhRiF5NRgP+brRr9eHJ38mMwudBRS015qQnG
	sEaH9xa4tPEwQvqG1WINI5OAc8osyPLEutdLNyx9mSn4GNT/nnMX6qxgBefjuutUqljFWjmb4IX
	0XOeK/llMFX9gtu73EDIh99ozPZzDw2Pxj8v9L1wbpPm2x1ZKfqJ13Rd2pPz56BpLlzbyAiIle6
	wJhNRaGq/VogzEvGYXhboz3G8DhVUfET9zMyRlM7ZV1WF/syS8ql/Rvk3sfU1lo0SpUGXIEgBn7
	VOFgp0z0vpWZ58OwF1N/s3ofck4MQSlKcebJc/oEBlgS0zLAfmVWOg09wjRw1mY3ENDaaddGOCa
	VnndyUfjJ+5B1ohJEYguHT
X-Received: by 2002:a05:693c:2b08:b0:2b0:5834:44d2 with SMTP id 5a478bee46e88-2b7c894932cmr655603eec.39.1769740049721;
        Thu, 29 Jan 2026 18:27:29 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7bb9ca10csm4119874eec.30.2026.01.29.18.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:27:29 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Zhi Li <lizhi2@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v4 1/3] dt-bindings: net: Add support for Spacemit K3 dwmac
Date: Fri, 30 Jan 2026 10:27:02 +0800
Message-ID: <20260130022705.1059214-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130022705.1059214-1-inochiama@gmail.com>
References: <20260130022705.1059214-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255025-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cac80000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 46445B7131
X-Rspamd-Action: no action

The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
MAC (version 5.40a) with some extra clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index dd3c72e8363e..faa598c19bf7 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -108,6 +108,7 @@ properties:
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
         - snps,dwmac-5.30a
+        - snps,dwmac-5.40a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - sophgo,sg2042-dwmac
@@ -653,6 +654,7 @@ allOf:
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
                 - snps,dwmac-5.30a
+                - snps,dwmac-5.40a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
diff --git a/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
new file mode 100644
index 000000000000..fc024a927fcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/spacemit,k3-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K3 DWMAC glue layer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: spacemit,k3-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: spacemit,k3-dwmac
+      - const: snps,dwmac-5.40a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: PTP clock
+      - description: TX clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+      - const: tx
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: MAC interrupt
+      - description: MAC wake interrupt
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: stmmaceth
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the syscon node which control the glue register
+          - description: offset of the control register
+          - description: offset of the dline register
+    description:
+      A phandle to syscon with offset to control registers for this MAC
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - resets
+  - reset-names
+  - spacemit,apmu
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet@cac80000 {
+      compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+      reg = <0xcac80000 0x2000>;
+      clocks = <&syscon_apmu 66>, <&syscon_apmu 68>,
+               <&syscon_apmu 69>;
+      clock-names = "stmmaceth", "ptp_ref", "tx";
+      interrupts = <131 IRQ_TYPE_LEVEL_HIGH>, <276 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_wake_irq";
+      phy-mode = "rgmii-id";
+      phy-handle = <&phy0>;
+      resets = <&syscon_apmu 67>;
+      reset-names = "stmmaceth";
+      spacemit,apmu = <&syscon_apmu 0x384 0x38c>;
+    };
+
-- 
2.52.0


