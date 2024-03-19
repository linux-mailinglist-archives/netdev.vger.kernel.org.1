Return-Path: <netdev+bounces-80501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6887F656
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 05:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA44B221F1
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B15B1E3;
	Tue, 19 Mar 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="wsCyFyhd"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137C1EB4A;
	Tue, 19 Mar 2024 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822076; cv=none; b=KYaep8b/JdOjrwS7YcSfZelWr+oUMlZ2Ifn37WzKhcfR6g2cTxM+86WMj7UCb6ycMgNdiVnoY5AgN+lwlACKucdfmTz9Go5pDQEKIpA0NmMUdJqC2AKmsqI01eMHugcthtjXlRkNZaMQ8YJWvfHK1W/GdwSYSJ67/4d1DEWwk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822076; c=relaxed/simple;
	bh=uHYyRQ2mhUExRd5wmElp9/X/N4+vsxARJCSyVxITKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqWceKpCqKgMQ4TGjpxra/yg9YxcMHS34ad1+Y5Xc2yTrAzhh1xQFkREiPXyooG9G00uj59G0jde0Zq5RPSrLllMrRNacODYEvDh2y96Eg64s9xXIYuZi+n29Vdo9wT0XDNoK29ernVUdZT7uepcHe3N+9DYauhXis04X+VYMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=wsCyFyhd; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8B14D87666;
	Tue, 19 Mar 2024 05:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710822072;
	bh=oRy+2PBzu8Mn0QXSPx0fnRejhAqRzKthrztDSHhFpx4=;
	h=From:To:Cc:Subject:Date:From;
	b=wsCyFyhdJbZ+sc+aLTm8B9CPeBxMbP230tjQ2ptH2nvkmEOpGrg1dn56+bGsn3SY/
	 rNVLUy8cCedYaCYffojFZuJzIsD4B6MbsBeKZMYvz2zJc6Bh9MhFHOQ1JgJZTkHXTS
	 OvyVyMpnII6V4kjf2QpCeikSVUeZFk/xBfErOiW1HO5yNlGSfJOEDauTDvP8JxXx0D
	 hpSd5Mh0/MMJfvRaoJkPE/TE6i8oJ75VvP6ZRvqU42eCjmwSIJTvFKRXRJhPYHiJem
	 /dNv6pwWRszSK0CPXLAb6Wjzmxjwoo8Xi6jyWBv9hTODwuwyB1rUdyyPwu3IyvOr1I
	 Qlt5BzNmHEZBw==
From: Marek Vasut <marex@denx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
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
Subject: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
Date: Tue, 19 Mar 2024 05:20:35 +0100
Message-ID: <20240319042058.133885-1-marex@denx.de>
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


