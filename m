Return-Path: <netdev+bounces-151784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A79F0D8D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEABC283FE9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C01E3DCF;
	Fri, 13 Dec 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zHqSpPnX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2471E32BD;
	Fri, 13 Dec 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097333; cv=none; b=bjiQ434BJH8P9UUsN8evMuQqG7nUDWZJi7xFR3mBSloZJxMeNFgA/g/CMN/7nSKzithAEmImRw6Ac9aMqPPjH9/JXPTEuPE4DaNEoCmpL/+Pw+3aBtAB2xdtye6Ich5bJdwYUdsH96nhpgU5MXCte44kj5+Z7maIRYOii+3ymwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097333; c=relaxed/simple;
	bh=gAozP5K90a5QtGx5y/pORzNem212AxL/4iPw5UgdVy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s7slhwrxgjgn+fptC0Bt4qTNCP5hrMI2pFYnBRra93AtRhqc1mFDUfJsY4AD9z2szg+prEy299vU7dA8XIOPX66LhjA3CbQV4iWEXUIkSWCZmpu8/qPgqur8tZT056fbMHW+dYCyPI+vvBS+sG3oP9vl0GjTcsTnnobOwCD2K1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zHqSpPnX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734097331; x=1765633331;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gAozP5K90a5QtGx5y/pORzNem212AxL/4iPw5UgdVy4=;
  b=zHqSpPnX0LzhTk5x5JrVjLAw7kgJKLKntW/VOtrvwvxD1dzz/ip24Qxs
   RzHhvIe80WHzopKUTkAP4jRzvtMYs/QTIVpKOB5dq2lQrux27Hykq0pOv
   oAi463lq3VtZz3lXkRDh9OIjNVpFLiduhUFWIOPeH+ecJ2SR/kFov2/D5
   14nmtedamV3gWXhAmkiMh9dNrWWbP5QtiNIxi1WR7rbFJqzk1uu3LPf9B
   +/kZjRl90heRjWc9dcghxpgqZZZ/1ZK2n5rXRL3bKW6PW3KsnNDt5W+32
   uJCgCvBlzwTLOeNL2/niqCCxIbgGpSXNbOOs8YsQFlkvmchdQhiT9F/G/
   A==;
X-CSE-ConnectionGUID: itc9LroWQgSaHh3I2qeP/g==
X-CSE-MsgGUID: 6PGRUvmUQNW2bos1uLvnmw==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="39217656"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 06:42:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 06:41:46 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 06:41:43 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 13 Dec 2024 14:41:08 +0100
Subject: [PATCH net-next v4 9/9] dt-bindings: net: sparx5: document RGMII
 delays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241213-sparx5-lan969x-switch-driver-4-v4-9-d1a72c9c4714@microchip.com>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

The lan969x switch device supports two RGMII port interfaces that can be
configured for MAC level rx and tx delays. Document two new properties
{rx,tx}-internal-delay-ps in the bindings, used to select these delays.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../bindings/net/microchip,sparx5-switch.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index dedfad526666..a73fc5036905 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -129,6 +129,24 @@ properties:
             minimum: 0
             maximum: 383
 
+          rx-internal-delay-ps:
+            description:
+              RGMII Receive Clock Delay defined in pico seconds, used to select
+              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
+              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
+              any delay. The Default is no delay.
+            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+            default: 0
+
+          tx-internal-delay-ps:
+            description:
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


