Return-Path: <netdev+bounces-286830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDGLN69HAmqPpwEAu9opvQ
	(envelope-from <netdev+bounces-286830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EDA516353
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001BD3080103
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887C4D2EFE;
	Mon, 11 May 2026 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osm7Zj4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464737D131
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534103; cv=none; b=FfEI1DyPrje6/E7ru2oUo12bX1+xeKnEfRpaY8pdKYNEY5ZBNBwCVSxedDdo/wUY4LW7gOg8pwtGliR4ZopZwX8UVzHDs7Wt/ESl4TvpqxC6wJtcbGYy0/TlKyw2hQXa8fxFI4v+k6MEpoI/Iv/G52XBEWcMrr2PAhr0S0orIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534103; c=relaxed/simple;
	bh=Zc31T/QO9EegTI6B6vuxwKR2XMOEi+0n4zCsru7FsDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNC1sB0sHDSRoNp10+5rrpLGBj4YwOFYMT2VKZPqVsQ6j4kB2mL1NjDyca2tT9DRGZeCFyDX1aJxnVQL/nstu38KVMT998rHA7AdkJxf4Ofbszi53BNLuS+zBJ70Cs/2+bUJvjbIoCZtVmB8DCG2PRcbDdEt/BPNzbPlgP9UOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osm7Zj4R; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so47591067b3.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778534100; x=1779138900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6ldejdVN081D7fwNeDF8ZPrc/XeSO77Rq/+gN7cxYg=;
        b=Osm7Zj4R4/Yzhii2ocOlG/VyNmsAe0XBXV4RnOPCIbZfldkh/ut3mp5kdKnb3p4nHk
         gc1BCNDD968g1NfckmAoMUdBtv+53YSdLNEiL9EQSttel/6n3gK01xA6cUsPCsw4HDHx
         Y21uR1jI4usx89SDMEWraPFEcgiATHoYUsidJjQieVT4jW3u+IYwPLumFoLL06KQxSWj
         lZLTecb9aJJimgQp/2Q/VLNhZzNkmaFYU2zXE4wYtu5KFRbBvIX4FPveWpbfTtAD2PR0
         Ncrh6C+Gs1n1HHjMoE44zMbwugQ5uwVq+JDaIsuiCZB/4CXU7WUecEAAfckdWI7llWuz
         xTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778534100; x=1779138900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6ldejdVN081D7fwNeDF8ZPrc/XeSO77Rq/+gN7cxYg=;
        b=aUGtlRXUgSSxrqPJo7NeDlcZxghaHs0zLuk3iG5132QeAm4uU12ReT6sMmkJhkdUxP
         JIQqmlmNd3XdRobPmR3R23NSzdVaPbAP8mgYqd3+8HKwpgfMglYXE61ykultWLemc8B5
         lq7DT0ZsVMVoTKsu3iAPlyTx5dMJJyHqiTFKlHo1HjJXe6vt9f0S9UMPgO0g3JkDG0Xi
         CZlIsTgtlM3tnG26f9cbokgDCjShvguxK3IQbB/NK7DM15Y4LZLhu9d3scDtKxajxiUr
         4+tJJo/TLo2S2nUCrfpXKcRqsOqN6rrBxGgpcyV8qHPvMnyDJ4dpWcRGYn+DS6Wr8oDY
         hy/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9m4PRBAQtIt5oUe3xW12BFQ5E+3L08ecNrqIbfll3Yv31ajjz1dhVQKW7w+eXWtgVR9ltnmD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0B/i6eN5mRI6TrCO1IhKC5939lWEPlyEy8TfHU/kqVwkljfd/
	Kf3/5bk2g8FJ5V+evQYFSD2Ua77H/D0Czn9JEuaPxA97mMfJzrDnZVI=
X-Gm-Gg: Acq92OGQrPI43R9yUVrP8MXJ8RTFt3L65mxpMEkRkSV8rxRtEvV4Uas7WxALKC+es2J
	LF/yt9yLPsW7/3GurLP7W6iQxLMUmhbjQ3sXLadWAnZMAMgsbolyCSG6hfm8OKjc0T99EnP414E
	7OnyBdXnvVWdn4iPpFtajBLWE6yf53xH5xOSUL5JsFJqQ2/IoJsQbbmOTNMjer9Vk8zENEdx96M
	mTVCBBwaKAM6REHe9LjiPLB9HsqAd9QSPfl7fzPBVfxeDbrOazSoYYWzhExDiG4NvoScBzp8kxJ
	uEGC5qeff2B5RbsmLv2XMIVjCJtv4MB1+AkSkv7pFupiCXBF87aAf9kBFnxPNpiWOQjEoOwC5KM
	P2ZHhPn7LkqbbAdt8GrRHIZP3Oiro2yr0pz0VNWNYnRTDcIONlBAEtzqnQJoViMB6hy0mf+2MMY
	R+WpTc2mz4+rF2QdvXLs9z9BA8526OUeXjKZ4evLgqmYtPmA==
X-Received: by 2002:a05:690c:399:b0:7bd:9f34:59a3 with SMTP id 00721157ae682-7bdf5debfdemr271707107b3.11.1778534099874;
        Mon, 11 May 2026 14:14:59 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm154634767b3.11.2026.05.11.14.14.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 14:14:59 -0700 (PDT)
From: Ali Rouhi <rouhi.ali@gmail.com>
X-Google-Original-From: Ali Rouhi <arouhi@sitime.com>
To: jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x clock generator
Date: Mon, 11 May 2026 14:14:52 -0700
Message-Id: <20260511211453.20671-1-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260511211143.19792-1-arouhi@sitime.com>
References: <20260511211143.19792-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72EDA516353
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286830-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,sitime.com:email,sitime.com:mid,0.0.0.68:email]
X-Rspamd-Action: no action

Add device tree binding documentation for the SiTime SiT95316
and SiT95317 DPLL clock generators.

Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 .../bindings/dpll/sitime,sit9531x.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml

diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
new file mode 100644
index 000000000000..0b05f0de65b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiTime SiT9531x DPLL Clock Generator
+
+maintainers:
+  - Ali Rouhi <arouhi@sitime.com>
+
+description: |
+  The SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
+  generators with integrated DPLL for synchronization applications.  Both
+  variants contain four PLLs with automatic/manual reference selection,
+  DCO frequency adjustment, and phase offset measurement via an on-chip
+  TDC (Time-to-Digital Converter).
+
+  The SiT95317 provides 4 inputs and 8 outputs; the SiT95316 provides
+  4 inputs and 12 outputs.
+
+  Runtime configuration (reference selection, frequency, phase) is managed
+  through the kernel DPLL netlink subsystem; the device tree describes only
+  the hardware wiring.
+
+properties:
+  compatible:
+    enum:
+      - sitime,sit95316
+      - sitime,sit95317
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the chip's active-low reset pin.  If present, the
+      driver holds the line deasserted at probe.  Optional; boards that do
+      not route the reset line omit this property.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt from the chip's active-low INTRB output.  When wired, the
+      driver uses it to trigger immediate status readback instead of
+      relying solely on periodic polling.  Optional.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        clock-generator@68 {
+            compatible = "sitime,sit95317";
+            reg = <0x68>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        clock-generator@68 {
+            compatible = "sitime,sit95316";
+            reg = <0x68>;
+            reset-gpios = <&gpio 78 GPIO_ACTIVE_LOW>;
+            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.43.0


