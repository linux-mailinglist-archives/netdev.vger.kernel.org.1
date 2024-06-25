Return-Path: <netdev+bounces-106625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66191707E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA451C24EC7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B217D8A1;
	Tue, 25 Jun 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sGPoYBh8"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C617C7BB;
	Tue, 25 Jun 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341061; cv=none; b=rKCGEag23j0EQdwzzbF5q96jCjiKxD+bdAmndYUVelpbzKpQRLDruVf9rp6JjHNa5tjHa0+BuIxq+9KoQ2TYQTYD7EtCLO7et9L7r6OYufSoMn+FkoXxWFP3dP7i2KejMbDcjrULrCWJoi83kbgqi3LHxIGLeoKg2HuXMJVz68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341061; c=relaxed/simple;
	bh=OFnL8+6rFqHfVb45JjyyjMy/lYgmP++CSsZKPWX8lIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ4Ae1XVEV3YLa3ZION8wsxdPWi/kq/RVV0cYXb0Dd9G34OW2ALx7Jqu5ZJMVbat16/EpdCXxhZ1s4+x6tOX8615b/ZgcRJdm5qrUemMg2/NZZk5MpDVAsPm9T5ucl5+AVDyJoCbpbrtb2J9sqnyJojGZtgCmyO6VrWtTZ9lAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sGPoYBh8; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2E26187B1A;
	Tue, 25 Jun 2024 20:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719341052;
	bh=GzliCsk6Gh2LlTif0QMixDMv4RHi+mVAjTNOi48YBMY=;
	h=From:To:Cc:Subject:Date:From;
	b=sGPoYBh8NIdfB0jcLqOPPOAQD2US1vHN27q1NT8dXerHmhJeqV4HZ7atl+i0Cqb4D
	 vHVUR+CQL6lq8NAr50ocLdNLoVsIpY4YNxuf32WFSh1GQ2AvmZn2LvMSCDUzU9nzOY
	 G8ULuHq5QSRuzU1oabatp2H6S1LS8BBEQmXOrPenWZoDZfjkKSD7QGy0CP3aS/bZLi
	 l4g2IANVU20XSPxvoNeCxtWdDmnQbzjhL+Y0ROCiMaUCydGtXOmSqniKk6dx8+d27T
	 V3FP0InPL8FFDSghUGemYIj08YTGW2tar0S4+klDkLKLQMqFHvWRdycOg7W6nVcMyH
	 jZYIKJazFFfHA==
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
Subject: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document known PHY IDs as compatible strings
Date: Tue, 25 Jun 2024 20:42:28 +0200
Message-ID: <20240625184359.153423-1-marex@denx.de>
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
V2: Drop ethernet-phy-id0000.8201 entry
---
 .../bindings/net/realtek,rtl82xx.yaml         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index bb94a2388520b..18ee72f5c74a8 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -18,6 +18,29 @@ allOf:
   - $ref: ethernet-phy.yaml#
 
 properties:
+  compatible:
+    enum:
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


