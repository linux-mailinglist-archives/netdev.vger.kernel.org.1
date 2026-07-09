Return-Path: <netdev+bounces-306239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7x3vCa+pT2pUmQIAu9opvQ
	(envelope-from <netdev+bounces-306239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:01:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD03731E9A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=eqijHIa0;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306239-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306239-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D3A431565ED
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1F03FF889;
	Thu,  9 Jul 2026 13:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A093E3163;
	Thu,  9 Jul 2026 13:43:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604586; cv=none; b=oIyT0EqVk2Z46AfRv+ihnrXOE5LllKpb2RKZtzVCWEDGsRsZGGpZV4e5/UUPYKvp+hKYSdLClvuuH4H6VqFkpZYEKsHIxJdEcKDxtEGRrdSgaAObgLji4yrRKvjI4KY7pKBSYATVh9xMOnFvoPGHYm+aBQaVF4jnQdkNKTdf6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604586; c=relaxed/simple;
	bh=qMgplM08fdHmTkbr6eTMNGZ1PSsHUFpShvy07TgPSFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORW/oweYAQgpqwaHQO75Ms0PXIP7W559RocDf4VLP2qWqcUWsxhmEZiRHKUygIot892U6FAcJ0uGtfB1GXDmoeD72vpuCb7naPOa7GDP2BS7BOY8GX086VNvmNTUWOBMdhsi3egNx94QcyjXfYJJ3b5hd8yet8pcpHnoAizFLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eqijHIa0; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783604583;
	bh=qMgplM08fdHmTkbr6eTMNGZ1PSsHUFpShvy07TgPSFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eqijHIa0wdmEBaZmHrWDgQGPM9XZxXaois/5v8VUrFjJ2OfN27mbrhpFvD7FXNsul
	 NUFslYxfPlBNqS1yJEm1Z15xklXOG2LBtoYdWD1msQJyk4ezVWdohCw9C9zXXXtjml
	 3jw2pDrT2+e1KCq0Tm63JyZ43AOZcFNjgWNZee+OOjjgce/UofPYLbFWtZ288zZI0z
	 Gsn+W4Q2YrDW+yLyUQzE/wUvRBb/dLbWPO0AjprMHV1BYBWBnjqU2UwDix1ALJ0qmf
	 hBGnlZfxgoJsWGhWBqsqnVWp4pqZEVYrSiDOyY2nsTsevcoYAWVFiiDz2B9SNmGqdA
	 f9eQtQmSGr/Mg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 31B5417E05E8;
	Thu, 09 Jul 2026 15:43:02 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 09 Jul 2026 15:42:46 +0200
Subject: [PATCH v2 06/18] dt-bindings: clock: mediatek: regroup MT8192
 dt-bindings into MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8189-clocks-system-base-v2-6-2926da3db6cf@collabora.com>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783604575; l=10194;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=qMgplM08fdHmTkbr6eTMNGZ1PSsHUFpShvy07TgPSFM=;
 b=S4SpXmXZkNY7uEW676VEDRMOq7zy6AXGI/JQ28SrgmBfRJZBehJFNga6AvmXP21Sq7ghpzZTt
 IEjJlyhYaaaBrQZjWiORo47hgw2p+0ySHFj0egXFV9+o7rSp2kQgL8C
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306239-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:louisalexis.eyraud@collabora.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,mediatek.com:email,vger.kernel.org:from_smtp,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BD03731E9A

Regroup the MT8192 clock and system clock dt-bindings into MT8186 ones
to ease maintainability and have common files for several currently
supported SoC or new future ones, that have the same kind of clock
controller design.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml      |  20 +++
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   4 +
 .../bindings/clock/mediatek,mt8192-clock.yaml      | 192 ---------------------
 .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |  69 --------
 4 files changed, 24 insertions(+), 261 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index 0bc2da60a601..b5988d122e4d 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -58,6 +58,26 @@ properties:
           - mediatek,mt8188-vencsys
           - mediatek,mt8188-wpesys
           - mediatek,mt8188-wpesys-vpp0
+          - mediatek,mt8192-camsys
+          - mediatek,mt8192-camsys_rawa
+          - mediatek,mt8192-camsys_rawb
+          - mediatek,mt8192-camsys_rawc
+          - mediatek,mt8192-imgsys
+          - mediatek,mt8192-imgsys2
+          - mediatek,mt8192-imp_iic_wrap_c
+          - mediatek,mt8192-imp_iic_wrap_e
+          - mediatek,mt8192-imp_iic_wrap_s
+          - mediatek,mt8192-imp_iic_wrap_ws
+          - mediatek,mt8192-imp_iic_wrap_w
+          - mediatek,mt8192-imp_iic_wrap_n
+          - mediatek,mt8192-ipesys
+          - mediatek,mt8192-mdpsys
+          - mediatek,mt8192-mfgcfg
+          - mediatek,mt8192-msdc_top
+          - mediatek,mt8192-scp_adsp
+          - mediatek,mt8192-vdecsys_soc
+          - mediatek,mt8192-vdecsys
+          - mediatek,mt8192-vencsys
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 199eac2034f2..41b8c61132e2 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -35,6 +35,10 @@ properties:
           - mediatek,mt8188-infracfg-ao
           - mediatek,mt8188-pericfg-ao
           - mediatek,mt8188-topckgen
+          - mediatek,mt8192-apmixedsys
+          - mediatek,mt8192-infracfg
+          - mediatek,mt8192-pericfg
+          - mediatek,mt8192-topckgen
       - const: syscon
 
   reg:
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
deleted file mode 100644
index 65e4c2fddf5b..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
+++ /dev/null
@@ -1,192 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8192-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek Functional Clock Controller for MT8192
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The Mediatek functional clock controller provides various clocks on MT8192.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8192-scp_adsp
-          - mediatek,mt8192-imp_iic_wrap_c
-          - mediatek,mt8192-imp_iic_wrap_e
-          - mediatek,mt8192-imp_iic_wrap_s
-          - mediatek,mt8192-imp_iic_wrap_ws
-          - mediatek,mt8192-imp_iic_wrap_w
-          - mediatek,mt8192-imp_iic_wrap_n
-          - mediatek,mt8192-msdc_top
-          - mediatek,mt8192-mfgcfg
-          - mediatek,mt8192-imgsys
-          - mediatek,mt8192-imgsys2
-          - mediatek,mt8192-vdecsys_soc
-          - mediatek,mt8192-vdecsys
-          - mediatek,mt8192-vencsys
-          - mediatek,mt8192-camsys
-          - mediatek,mt8192-camsys_rawa
-          - mediatek,mt8192-camsys_rawb
-          - mediatek,mt8192-camsys_rawc
-          - mediatek,mt8192-ipesys
-          - mediatek,mt8192-mdpsys
-
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
-    const: 1
-
-required:
-  - compatible
-  - reg
-  - '#clock-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    scp_adsp: clock-controller@10720000 {
-        compatible = "mediatek,mt8192-scp_adsp";
-        reg = <0x10720000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_c: clock-controller@11007000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_c";
-        reg = <0x11007000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_e: clock-controller@11cb1000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_e";
-        reg = <0x11cb1000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_s: clock-controller@11d03000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_s";
-        reg = <0x11d03000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_ws: clock-controller@11d23000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_ws";
-        reg = <0x11d23000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_w: clock-controller@11e01000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_w";
-        reg = <0x11e01000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_n: clock-controller@11f02000 {
-        compatible = "mediatek,mt8192-imp_iic_wrap_n";
-        reg = <0x11f02000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    msdc_top: clock-controller@11f10000 {
-        compatible = "mediatek,mt8192-msdc_top";
-        reg = <0x11f10000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    mfgcfg: clock-controller@13fbf000 {
-        compatible = "mediatek,mt8192-mfgcfg";
-        reg = <0x13fbf000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys: clock-controller@15020000 {
-        compatible = "mediatek,mt8192-imgsys";
-        reg = <0x15020000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys2: clock-controller@15820000 {
-        compatible = "mediatek,mt8192-imgsys2";
-        reg = <0x15820000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys_soc: clock-controller@1600f000 {
-        compatible = "mediatek,mt8192-vdecsys_soc";
-        reg = <0x1600f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys: clock-controller@1602f000 {
-        compatible = "mediatek,mt8192-vdecsys";
-        reg = <0x1602f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vencsys: clock-controller@17000000 {
-        compatible = "mediatek,mt8192-vencsys";
-        reg = <0x17000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys: clock-controller@1a000000 {
-        compatible = "mediatek,mt8192-camsys";
-        reg = <0x1a000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawa: clock-controller@1a04f000 {
-        compatible = "mediatek,mt8192-camsys_rawa";
-        reg = <0x1a04f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawb: clock-controller@1a06f000 {
-        compatible = "mediatek,mt8192-camsys_rawb";
-        reg = <0x1a06f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawc: clock-controller@1a08f000 {
-        compatible = "mediatek,mt8192-camsys_rawc";
-        reg = <0x1a08f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    ipesys: clock-controller@1b000000 {
-        compatible = "mediatek,mt8192-ipesys";
-        reg = <0x1b000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    mdpsys: clock-controller@1f000000 {
-        compatible = "mediatek,mt8192-mdpsys";
-        reg = <0x1f000000 0x1000>;
-        #clock-cells = <1>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
deleted file mode 100644
index 0ebd0d60e2f6..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
+++ /dev/null
@@ -1,69 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8192-sys-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek System Clock Controller for MT8192
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The Mediatek system clock controller provides various clocks and system configuration
-  like reset and bus protection on MT8192.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8192-topckgen
-          - mediatek,mt8192-infracfg
-          - mediatek,mt8192-pericfg
-          - mediatek,mt8192-apmixedsys
-      - const: syscon
-
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-required:
-  - compatible
-  - reg
-  - '#clock-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    topckgen: syscon@10000000 {
-        compatible = "mediatek,mt8192-topckgen", "syscon";
-        reg = <0x10000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    infracfg: syscon@10001000 {
-        compatible = "mediatek,mt8192-infracfg", "syscon";
-        reg = <0x10001000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    pericfg: syscon@10003000 {
-        compatible = "mediatek,mt8192-pericfg", "syscon";
-        reg = <0x10003000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    apmixedsys: syscon@1000c000 {
-        compatible = "mediatek,mt8192-apmixedsys", "syscon";
-        reg = <0x1000c000 0x1000>;
-        #clock-cells = <1>;
-    };

-- 
2.55.0


