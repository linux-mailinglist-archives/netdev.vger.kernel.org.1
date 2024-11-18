Return-Path: <netdev+bounces-145829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C699D1142
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2683AB2649E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055961ABEA5;
	Mon, 18 Nov 2024 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TmHIZutI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB21A265E;
	Mon, 18 Nov 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934886; cv=none; b=MxaiG5uirDbJRhfO9ccR2KHgS3FyfSH49532hmV66l4JJEOXvEv0xBxGStM0+pXtls1KKoyJYaTwy2QUCwyADAfT9Q4uBFN62hgvgCYYvagVn5vjkdzpygTPgrDbRbURVVGzmcXQGeyNDtILmX6hmMZMt7oX2TATCqe0g1CerK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934886; c=relaxed/simple;
	bh=o0gsQLUEQBwVaB8DL86kcJ9iRFqkRAgI0i6UZvCJDyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=slCY9CuC6J0+lMTSa6407FcaP2Uv0HmKyLIxDaXWvLRCjCYFWjSzjeDfGgLKmau7RqR7IN5CYLIG5GKyXlkQfHw4M5TVyLUNRqHUP3sPZjTgbCDCE8561i1rD+FclS+EQxGfDynPnzZE2tRRVANLananNQ0iVRFNpuPfTrZAAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TmHIZutI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731934885; x=1763470885;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=o0gsQLUEQBwVaB8DL86kcJ9iRFqkRAgI0i6UZvCJDyI=;
  b=TmHIZutISu5tTFRuV+GlLKmvNNLdecHTdrYsLTklY8RTihLvWJ6vTlPu
   ZRYaINqTEJf1lU06bMx2g9eUjOLqyJuNH/pixSh8/9w6IgqTjZYuQ8SWG
   zRMrHhnHvaqfmYNnkACup+6vRQhlwFfujqzGs8I1EhoDL/mSulc9DFmEy
   vpWRKpopuvWbc4AgLRSPR7Q9LRwRXokk4APm/shiVcXqQGyVpURw1fkHW
   P6TZKzEYx2uuB021/Do0EEVlQhBcNKg/h9Me1lcqthuruUgkCQFrpfOcZ
   wr2Drp1z/NEsrHbEk94dD5ozoRUPjnJiny9jtfAeSPxtB5aE3AmEhDyzW
   g==;
X-CSE-ConnectionGUID: grjwx8pqQyysg5Oh3PusIg==
X-CSE-MsgGUID: HYC7+POhSx6IjTmEcIZbtA==
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="201886260"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2024 06:01:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Nov 2024 06:01:22 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Nov 2024 06:01:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 18 Nov 2024 14:00:54 +0100
Subject: [PATCH net-next v3 8/8] dt-bindings: net: sparx5: document RGMII
 delays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sparx5-lan969x-switch-driver-4-v3-8-3cefee5e7e3a@microchip.com>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
In-Reply-To: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The lan969x switch device supports two RGMII port interfaces that can be
configured for MAC level rx and tx delays.

Document two new properties {rx,tx}-internal-delay-ps. Make them
required properties, if the phy-mode is one of: rgmii, rgmii_id,
rgmii-rxid or rgmii-txid. Also specify accepted values.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../bindings/net/microchip,sparx5-switch.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index dedfad526666..2e9ef0f7bb4b 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -129,6 +129,24 @@ properties:
             minimum: 0
             maximum: 383
 
+          rx-internal-delay-ps:
+            description: |
+              RGMII Receive Clock Delay defined in pico seconds, used to select
+              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
+              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
+              any delay. The Default is no delay.
+            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+            default: 0
+
+          tx-internal-delay-ps:
+            description: |
+              RGMII Transmit Clock Delay defined in pico seconds, used to select
+              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
+              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
+              any delay. The Default is no delay.
+            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+            default: 0
+
         required:
           - reg
           - phys

-- 
2.34.1


