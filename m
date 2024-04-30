Return-Path: <netdev+bounces-92285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D008B6730
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D727285003
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694217F5;
	Tue, 30 Apr 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="mdTZSD/M"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED910E4;
	Tue, 30 Apr 2024 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439396; cv=none; b=lP/g57aegnXvuHXIqv/kJA9okL+tgPSaqLOVg6KOvzZ/9OAVS5Qgq4dJSNW1riMR9MC3o02duEuQIXt4CXEOhlzBraXpBpBrfXXKgamx5X88y5aR6w90m3v6S7mh9aX90q1NYLIaYpS1u8CS0IxjMJeFdgJdskLBHVRvoJP1qZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439396; c=relaxed/simple;
	bh=/sJXoKozAupCSWpu1W8lTQ5x4rwf/UN0w7tfG7JDwG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTW/P7efFg9pE/EyCj+1YhVXgBPebYO6F7ozoF9dE6SFdCgMeCV5tVqSfN0t0Ns/uYQkAXkoYYdmjrQDUX/BWcjXEQ1GJBFaHPjXMXIV3pcqyORNlFFxQibt8xBhcOmg5wFokZqvzclLvclk66dRC1uvQLUgT2KeKOQXpGXJKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=mdTZSD/M; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D34A98870E;
	Tue, 30 Apr 2024 03:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714439390;
	bh=GVX4kDqJpQ6ZldhzzqP9pD28pwvHfzCAr0kztvdSrEg=;
	h=From:To:Cc:Subject:Date:From;
	b=mdTZSD/MQasKkyg9YIdStVbjqzr43D5KDzDDSbi7g36NLmMiznbfKdFgEqcJdKowT
	 D6hPoRr8fjZlWGpb7p/0i8vkYeWyHuJdSKqhvc5AJtXbO+x/GD9336acgjgEO5++CI
	 PUH4TJhSIj4+3bcnuYsIP+eux8dSjO9GiFLT3s8/MzhK4iFI6WfiTsQ/npaHWsqi6s
	 ZFbKD0DiJN4Drldzt3+9EaWyoh9qIGgdhZDuxUEJW3wApHCRqJT9MyYc5EeQuc4oVI
	 NttY3JHuV7QIYDlJg5qIBTcEn0yMkbQ3gaM+fvan1KaSENGvcHQ6vJGiU4rwqVbxrh
	 4qAfNepoNOQBw==
From: Marek Vasut <marex@denx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [bluetooth-next PATCH v3] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
Date: Tue, 30 Apr 2024 03:08:42 +0200
Message-ID: <20240430010914.110179-1-marex@denx.de>
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

CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
This chip is present e.g. on muRata 1YN module.

Extend the binding with its DT compatible using fallback
compatible string to "brcm,bcm4329-bt" which seems to be
the oldest compatible device. This should also prevent the
growth of compatible string tables in drivers. The existing
block of compatible strings is retained.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - Introduce fallback compatible string
    - Reword the second half of commit message to reflect that
V3: - Add AB from Krzysztof
---
 .../bindings/net/broadcom-bluetooth.yaml      | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index cc70b00c6ce57..4a1bfc2b35849 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -14,20 +14,25 @@ description:
 
 properties:
   compatible:
-    enum:
-      - brcm,bcm20702a1
-      - brcm,bcm4329-bt
-      - brcm,bcm4330-bt
-      - brcm,bcm4334-bt
-      - brcm,bcm43430a0-bt
-      - brcm,bcm43430a1-bt
-      - brcm,bcm43438-bt
-      - brcm,bcm4345c5
-      - brcm,bcm43540-bt
-      - brcm,bcm4335a0
-      - brcm,bcm4349-bt
-      - cypress,cyw4373a0-bt
-      - infineon,cyw55572-bt
+    oneOf:
+      - items:
+          - enum:
+              - infineon,cyw43439-bt
+          - const: brcm,bcm4329-bt
+      - enum:
+          - brcm,bcm20702a1
+          - brcm,bcm4329-bt
+          - brcm,bcm4330-bt
+          - brcm,bcm4334-bt
+          - brcm,bcm43430a0-bt
+          - brcm,bcm43430a1-bt
+          - brcm,bcm43438-bt
+          - brcm,bcm4345c5
+          - brcm,bcm43540-bt
+          - brcm,bcm4335a0
+          - brcm,bcm4349-bt
+          - cypress,cyw4373a0-bt
+          - infineon,cyw55572-bt
 
   shutdown-gpios:
     maxItems: 1
-- 
2.43.0


