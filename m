Return-Path: <netdev+bounces-98640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB578D1EDF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C44B22DBC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED416F913;
	Tue, 28 May 2024 14:30:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDEE16FF29;
	Tue, 28 May 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906636; cv=none; b=hZG4idtZ7C1Lb+dTr0hRhOQZCjxMv1LMW+8jFkboiOaPWt2WaMFXsZk947lpIr7NecvkUiyDFSQzt/KKUl/WUEt8rZn8HrJYB0TG/G7j+DSnOg666MoCUtzM/RNPRgCzZxQKNoYk6KTUYDjKNncCFDlsE9JFZRMrRDZFi0aR+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906636; c=relaxed/simple;
	bh=nUmlA3tNFi8AorheeUsBw4qMpRyWQa7L93IQZaiBjO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8eoBaT/dgwCWLCkhlegbPs4W4ktOL9WavIo3GaThhgNosGaxsunbmCAFiK10PQB5ZrOQOyoYDxvG2WTx9sU3Rb47Qv4DMjsHF8wOTYQHG1oohfHdKVw9JkzGWkKhb4rnnLxY9o1dfLJJtOd+kKsM26UsEAEzoRjIV5/Y8ken1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c07:2740:1619:be25:bafb:489])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6E3047E038D;
	Tue, 28 May 2024 22:30:12 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document reset-gpios
Date: Tue, 28 May 2024 22:30:09 +0800
Message-Id: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkJCVktCTxhJS0NCHhlIGlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kWGg8SFR0UWU
	FZT0tIVUpISkJIS1VKS0tVS1kG
X-HM-Tid: 0a8fbf9bd7a003a2kunm6e3047e038d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDI6EAw*EzNRVg0CF0MjP1E8
	FikaCRxVSlVKTEpNQktNTUpJQkxNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0xBSUxPS0FKTUpCQRkeSU5BGRodGUFPQ0JZV1kIAVlBSUxKSzcG

Some 5G WWAN modems have multiple gpio controls. When using rfkill command
to manage it, we need to at least change the status of reset and shutdown
gpios at the same time. Also, it might be incorrect to put the reset gpio
at usb when the module is connected via USB M2 slot, there may be other
devices connected under some USB node, but the reset gpio is only used for
the WWAN module. So document the reset-gpios to rfkill-gpio as an optional
property and add it to a new example.

For example:
  - reset: modem Reset#
  - shutdown: modem WWAN_DISABLE# or FULL_CARD_POWER_OFF#

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../devicetree/bindings/net/rfkill-gpio.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
index 9630c8466fac..7f297efdc976 100644
--- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
@@ -29,6 +29,9 @@ properties:
       - wlan
       - wwan
 
+  reset-gpios:
+    maxItems: 1
+
   shutdown-gpios:
     maxItems: 1
 
@@ -49,3 +52,14 @@ examples:
         radio-type = "wlan";
         shutdown-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
     };
+
+  - | # 5G WWAN modem
+    #include <dt-bindings/gpio/gpio.h>
+
+    rfkill {
+        compatible = "rfkill-gpio";
+        label = "rfkill-modem";
+        radio-type = "wwan";
+        reset-gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+        shutdown-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.25.1


