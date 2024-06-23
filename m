Return-Path: <netdev+bounces-105954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0FC913DC2
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 21:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6ED1F21AE2
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2531836C3;
	Sun, 23 Jun 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BmR84q8J"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E244C86;
	Sun, 23 Jun 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719171760; cv=none; b=aVufSlRvJrMtyUlPJ9KHiq3fz1DWKRjjVNpziXigGV8ErJPcOpe9ploqkMCNMLIHHLbA/rjGBRCukbMe/aYk/+4zuBk4t1dk7BujMsj3D4T2sK/y1uC4jUHZy/EzCozyMWOuX1bB5t7HiyCbd0yumblF0HYObdx7ItNCtpDooVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719171760; c=relaxed/simple;
	bh=qBy6E0Lt5lm0+EGGL1s5KUxPNyFltjn6X4AitXHZDp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDV5fI0YFQQ2tiDnAJGHUAPpnlzh80pSF8pjZjOw7vyBeeRYfQzops2Cb9VneCsw/ZSjcJet/YJKlf82IEZ1elXs8vOZP7GZbd9aKQW8VQgEzqbaDzGdKgYrBU158b0Df0McucCUHW6nGbQkdLq54t9XCysjygyqsraj+kgc8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BmR84q8J; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F0A11866F6;
	Sun, 23 Jun 2024 21:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719171756;
	bh=tF4ZX0gxmH3srM1ImeZD/IcaP1acA+OK16igdhxP9jo=;
	h=From:To:Cc:Subject:Date:From;
	b=BmR84q8JHI3yiyz6aQrqOuQggZzAdp+2pU+4FXWVPJZ1KEX892oKfwWLWjUFuNbpE
	 5Dg+Qx7OOiXqQzZtnAieW0Qvy8py8ezhOPmFgZ7P/6Yz1XN47BE9H+8IbS3x4Rs4H9
	 mHDD15jWKvCdPKGsqnBOCnSW6nvtY+KOx9dsDXEN5H0vYjGccwbsltVMameqEOQQ0/
	 bCPcOsI/0DbsiMazjgpSkI3YfkSr4vAMzLfLA1BD0td61ebSWJ8OBZ3APamJd2k+/7
	 5B2f8+6pdKcy06qfxEzQ8qU+y0VWNsV5/avtiYc5O26p2sGuYbazYkhU7cPskSB6te
	 kgxtkbZ321WGQ==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	kernel@dh-electronics.com
Subject: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document known PHY IDs as compatible strings
Date: Sun, 23 Jun 2024 21:41:37 +0200
Message-ID: <20240623194225.76667-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Extract known PHY IDs from Linux kernel realtek PHY driver
and convert them into supported compatible string list for
this DT binding document.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: kernel@dh-electronics.com
Cc: netdev@vger.kernel.org
---
 .../bindings/net/realtek,rtl82xx.yaml         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index bb94a2388520b..8db4d66f1a961 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -18,6 +18,30 @@ allOf:
   - $ref: ethernet-phy.yaml#
 
 properties:
+  compatible:
+    enum:
+      - ethernet-phy-id0000.8201
+      - ethernet-phy-id001c.c800
+      - ethernet-phy-id001c.c816
+      - ethernet-phy-id001c.c838
+      - ethernet-phy-id001c.c840
+      - ethernet-phy-id001c.c848
+      - ethernet-phy-id001c.c849
+      - ethernet-phy-id001c.c84a
+      - ethernet-phy-id001c.c862
+      - ethernet-phy-id001c.c878
+      - ethernet-phy-id001c.c880
+      - ethernet-phy-id001c.c910
+      - ethernet-phy-id001c.c912
+      - ethernet-phy-id001c.c913
+      - ethernet-phy-id001c.c914
+      - ethernet-phy-id001c.c915
+      - ethernet-phy-id001c.c916
+      - ethernet-phy-id001c.c942
+      - ethernet-phy-id001c.c961
+      - ethernet-phy-id001c.cad0
+      - ethernet-phy-id001c.cb00
+
   realtek,clkout-disable:
     type: boolean
     description:
-- 
2.43.0


