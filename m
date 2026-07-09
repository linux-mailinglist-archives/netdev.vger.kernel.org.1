Return-Path: <netdev+bounces-306240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vgj1NaqoT2qZlwIAu9opvQ
	(envelope-from <netdev+bounces-306240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3E731D78
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b="OtUD0fn/";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306240-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306240-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF53130B0F9A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338D40E8F1;
	Thu,  9 Jul 2026 13:43:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35803839B6;
	Thu,  9 Jul 2026 13:43:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604587; cv=none; b=IgRqyng92PGmgtpdzwUS76r1dwumB9E8dweNNItVuEj4l4TNgSVZmCB4fnv64lfyIC5tYkkFOhSW8nYpUmCzrX8G5qg8wZ7nbqoP4VlfvuuFGRmShC4eDvg2mwU1HwK1rOZHZyueLfFzEx5OTtBeShFJidkw3lDWgyLGIc6aguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604587; c=relaxed/simple;
	bh=fgQqAzGMCiJ1T4D5LK2Bar9Z6Kgw/sGL/1SyBtF1V0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lv12UobGaBJvAklUz7TeqfWnIbFFAGwQnwk1CYTL8IjaDwr5vKZgd6n+kqsu+072x9s74KJgfv6WhMXGOCaoGuQScXw5Q/itnGv/KJ3/O9dvZZrJ/DDM67DuzH+xzhin42EbWsvnSlR/NTHOeZM7Bz5tHkEOieWS7dzVEToilrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OtUD0fn/; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783604584;
	bh=fgQqAzGMCiJ1T4D5LK2Bar9Z6Kgw/sGL/1SyBtF1V0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OtUD0fn/JNTcGlMj0Ya0XjlJUGaz/OyLDT7Xx3RtlxCsyv2nj4UDrYDnPyua9hEYD
	 vERD5kopHTD81ER/o3XHsUU9yYYorb6bFTIzE+ctz9kf1o3IAfAqraIM6LUccOeydt
	 C3MtmMUdkSnFbcRtNrQS2fcoUJo6uNHBX+2AWNI5xXZD0riZNvsRQVBKj4unl093Dj
	 KJpY/VSGmqVoCNXi/RfyjWMj4nuj3lv6++bCRxLblyOEufS5cMiHyDn4ERt8SE+XDC
	 sc3pEo8/bTuQ+WTG4VcGVEQ3hLW1uuZCedJgjS2ZMzvbqTJRac4GGlNyO+zwaNKa3a
	 n9RQCxycSuhhQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 52E9317E0D33;
	Thu, 09 Jul 2026 15:43:03 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 09 Jul 2026 15:42:47 +0200
Subject: [PATCH v2 07/18] dt-bindings: clock: mediatek: regroup MT8195
 dt-bindings into MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8189-clocks-system-base-v2-7-2926da3db6cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783604575; l=12181;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=fgQqAzGMCiJ1T4D5LK2Bar9Z6Kgw/sGL/1SyBtF1V0k=;
 b=doaQxay0EGYMpuK3X96oODmgZdbq93KPsX1gaXW3n3VnioH28Xev94mOSD0H7ATwpw5k4Ah2v
 hwwRd4/3ntPDAvZiOoY8x68ANS5taknEGQPV5FAMeOeZ0E/UavyYXCP
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306240-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email,devicetree.org:url,vger.kernel.org:from_smtp,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53A3E731D78

Regroup the MT8195 clock and system clock dt-bindings into MT8186 ones
to ease maintainability and have common files for several currently
supported SoC or new future ones, that have the same kind of clock
controller design.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml      |  25 +++
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   4 +
 .../bindings/clock/mediatek,mt8195-clock.yaml      | 239 ---------------------
 .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |  77 -------
 4 files changed, 29 insertions(+), 316 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index b5988d122e4d..ab9f8cb7dd6e 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -78,6 +78,31 @@ properties:
           - mediatek,mt8192-vdecsys_soc
           - mediatek,mt8192-vdecsys
           - mediatek,mt8192-vencsys
+          - mediatek,mt8195-apusys_pll
+          - mediatek,mt8195-camsys
+          - mediatek,mt8195-camsys_rawa
+          - mediatek,mt8195-camsys_yuva
+          - mediatek,mt8195-camsys_rawb
+          - mediatek,mt8195-camsys_yuvb
+          - mediatek,mt8195-camsys_mraw
+          - mediatek,mt8195-ccusys
+          - mediatek,mt8195-imgsys
+          - mediatek,mt8195-imgsys1_dip_top
+          - mediatek,mt8195-imgsys1_dip_nr
+          - mediatek,mt8195-imgsys1_wpe
+          - mediatek,mt8195-imp_iic_wrap_s
+          - mediatek,mt8195-imp_iic_wrap_w
+          - mediatek,mt8195-ipesys
+          - mediatek,mt8195-mfgcfg
+          - mediatek,mt8195-scp_adsp
+          - mediatek,mt8195-vdecsys_soc
+          - mediatek,mt8195-vdecsys
+          - mediatek,mt8195-vdecsys_core1
+          - mediatek,mt8195-vencsys
+          - mediatek,mt8195-vencsys_core1
+          - mediatek,mt8195-wpesys
+          - mediatek,mt8195-wpesys_vpp0
+          - mediatek,mt8195-wpesys_vpp1
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 41b8c61132e2..4a9d3eea4316 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -39,6 +39,10 @@ properties:
           - mediatek,mt8192-infracfg
           - mediatek,mt8192-pericfg
           - mediatek,mt8192-topckgen
+          - mediatek,mt8195-apmixedsys
+          - mediatek,mt8195-infracfg_ao
+          - mediatek,mt8195-pericfg_ao
+          - mediatek,mt8195-topckgen
       - const: syscon
 
   reg:
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
deleted file mode 100644
index 94dd29c2396c..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
+++ /dev/null
@@ -1,239 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8195-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek Functional Clock Controller for MT8195
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The clock architecture in Mediatek like below
-  PLLs -->
-          dividers -->
-                      muxes
-                           -->
-                              clock gate
-
-  The devices except apusys_pll provide clock gate control in different IP blocks.
-  The apusys_pll provides Plls which generated from SoC 26m for AI Processing Unit.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8195-scp_adsp
-          - mediatek,mt8195-imp_iic_wrap_s
-          - mediatek,mt8195-imp_iic_wrap_w
-          - mediatek,mt8195-mfgcfg
-          - mediatek,mt8195-wpesys
-          - mediatek,mt8195-wpesys_vpp0
-          - mediatek,mt8195-wpesys_vpp1
-          - mediatek,mt8195-imgsys
-          - mediatek,mt8195-imgsys1_dip_top
-          - mediatek,mt8195-imgsys1_dip_nr
-          - mediatek,mt8195-imgsys1_wpe
-          - mediatek,mt8195-ipesys
-          - mediatek,mt8195-camsys
-          - mediatek,mt8195-camsys_rawa
-          - mediatek,mt8195-camsys_yuva
-          - mediatek,mt8195-camsys_rawb
-          - mediatek,mt8195-camsys_yuvb
-          - mediatek,mt8195-camsys_mraw
-          - mediatek,mt8195-ccusys
-          - mediatek,mt8195-vdecsys_soc
-          - mediatek,mt8195-vdecsys
-          - mediatek,mt8195-vdecsys_core1
-          - mediatek,mt8195-vencsys
-          - mediatek,mt8195-vencsys_core1
-          - mediatek,mt8195-apusys_pll
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
-        compatible = "mediatek,mt8195-scp_adsp";
-        reg = <0x10720000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_s: clock-controller@11d03000 {
-        compatible = "mediatek,mt8195-imp_iic_wrap_s";
-        reg = <0x11d03000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imp_iic_wrap_w: clock-controller@11e05000 {
-        compatible = "mediatek,mt8195-imp_iic_wrap_w";
-        reg = <0x11e05000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    mfgcfg: clock-controller@13fbf000 {
-        compatible = "mediatek,mt8195-mfgcfg";
-        reg = <0x13fbf000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    wpesys: clock-controller@14e00000 {
-        compatible = "mediatek,mt8195-wpesys";
-        reg = <0x14e00000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    wpesys_vpp0: clock-controller@14e02000 {
-        compatible = "mediatek,mt8195-wpesys_vpp0";
-        reg = <0x14e02000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    wpesys_vpp1: clock-controller@14e03000 {
-        compatible = "mediatek,mt8195-wpesys_vpp1";
-        reg = <0x14e03000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys: clock-controller@15000000 {
-        compatible = "mediatek,mt8195-imgsys";
-        reg = <0x15000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys1_dip_top: clock-controller@15110000 {
-        compatible = "mediatek,mt8195-imgsys1_dip_top";
-        reg = <0x15110000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys1_dip_nr: clock-controller@15130000 {
-        compatible = "mediatek,mt8195-imgsys1_dip_nr";
-        reg = <0x15130000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    imgsys1_wpe: clock-controller@15220000 {
-        compatible = "mediatek,mt8195-imgsys1_wpe";
-        reg = <0x15220000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    ipesys: clock-controller@15330000 {
-        compatible = "mediatek,mt8195-ipesys";
-        reg = <0x15330000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys: clock-controller@16000000 {
-        compatible = "mediatek,mt8195-camsys";
-        reg = <0x16000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawa: clock-controller@1604f000 {
-        compatible = "mediatek,mt8195-camsys_rawa";
-        reg = <0x1604f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_yuva: clock-controller@1606f000 {
-        compatible = "mediatek,mt8195-camsys_yuva";
-        reg = <0x1606f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_rawb: clock-controller@1608f000 {
-        compatible = "mediatek,mt8195-camsys_rawb";
-        reg = <0x1608f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_yuvb: clock-controller@160af000 {
-        compatible = "mediatek,mt8195-camsys_yuvb";
-        reg = <0x160af000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    camsys_mraw: clock-controller@16140000 {
-        compatible = "mediatek,mt8195-camsys_mraw";
-        reg = <0x16140000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    ccusys: clock-controller@17200000 {
-        compatible = "mediatek,mt8195-ccusys";
-        reg = <0x17200000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys_soc: clock-controller@1800f000 {
-        compatible = "mediatek,mt8195-vdecsys_soc";
-        reg = <0x1800f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys: clock-controller@1802f000 {
-        compatible = "mediatek,mt8195-vdecsys";
-        reg = <0x1802f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vdecsys_core1: clock-controller@1803f000 {
-        compatible = "mediatek,mt8195-vdecsys_core1";
-        reg = <0x1803f000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vencsys: clock-controller@1a000000 {
-        compatible = "mediatek,mt8195-vencsys";
-        reg = <0x1a000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    vencsys_core1: clock-controller@1b000000 {
-        compatible = "mediatek,mt8195-vencsys_core1";
-        reg = <0x1b000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    apusys_pll: clock-controller@190f3000 {
-        compatible = "mediatek,mt8195-apusys_pll";
-        reg = <0x190f3000 0x1000>;
-        #clock-cells = <1>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
deleted file mode 100644
index ba1b36fa0169..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
+++ /dev/null
@@ -1,77 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek System Clock Controller for MT8195
-
-maintainers:
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The clock architecture in Mediatek like below
-  PLLs -->
-          dividers -->
-                      muxes
-                           -->
-                              clock gate
-
-  The apmixedsys provides most of PLLs which generated from SoC 26m.
-  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
-  The infracfg_ao and pericfg_ao provides clock gate in peripheral and infrastructure IP blocks.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt8195-topckgen
-          - mediatek,mt8195-infracfg_ao
-          - mediatek,mt8195-apmixedsys
-          - mediatek,mt8195-pericfg_ao
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
-        compatible = "mediatek,mt8195-topckgen", "syscon";
-        reg = <0x10000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    infracfg_ao: syscon@10001000 {
-        compatible = "mediatek,mt8195-infracfg_ao", "syscon";
-        reg = <0x10001000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    apmixedsys: syscon@1000c000 {
-        compatible = "mediatek,mt8195-apmixedsys", "syscon";
-        reg = <0x1000c000 0x1000>;
-        #clock-cells = <1>;
-    };
-
-  - |
-    pericfg_ao: syscon@11003000 {
-        compatible = "mediatek,mt8195-pericfg_ao", "syscon";
-        reg = <0x11003000 0x1000>;
-        #clock-cells = <1>;
-    };

-- 
2.55.0


