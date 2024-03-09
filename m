Return-Path: <netdev+bounces-78893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B3876EEA
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4249A1C20C41
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 03:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793C2E630;
	Sat,  9 Mar 2024 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Idf5SuAR"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66C2033A;
	Sat,  9 Mar 2024 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709954193; cv=none; b=ZZ4bsqdspGsqzbuNnMlpGrzr9hnaQkaxYZ1+8SlB8XC2xSJjMJ9qbYW4TH9YoUD4TI6SlIpZIOGHERPCLbWoHNwSUgg0yFILw/D8V4sD41Z+0juTLhVBRANIUGqwWK5BKa54UMZw19c94AqBIQnCgrFlCxN0F57WQbwxfF1udHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709954193; c=relaxed/simple;
	bh=6oz/c8tuVzvCAxWB8vw3sC38CdKkKexJbHpFIM6YNvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+gV9PVtNjAlqe7ELNP09zLToRnQsal6SU0Oq4br5QYaXEpNalgbt0MfEWlZIP06i7+6OtncvP7G6dhszWmT4qvk3GJqtkAlcxUGfcq8EwTz+ZLIgxOcFVyFU9bLS87DhI32uPbKrBffnHcQrWUYnFQikkCWhvul843yOF/ZMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Idf5SuAR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0896187D46;
	Sat,  9 Mar 2024 04:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709954189;
	bh=UUyIP5v6l38yz4FL82VwcPPfb7PIR/nDthpWPLat13s=;
	h=From:To:Cc:Subject:Date:From;
	b=Idf5SuAR8sooS11ChZBi97oOpOpQ8uXKeWSoQflaHk4jdqOCxGWeWd3YeYoTaEkUQ
	 bmgATmBvoGZZXjYRWwrVFp7fA6Aqi2RCWtyNTe7flZ+m06mSeigIpGoQcKLX8FS3tJ
	 k5wEn0Uc2vM+6smx115l7ji0yg99elo3I0Mm4DcGzhd4VB685j1v7RsV0sSqO1INdJ
	 iPeZnXPkzzzqdR/TEwjpDRMyUvPS4Zd3bN9PPFj9rTD0WwLfsNrcZQY8Z5W9ldSMbv
	 4qYaPGhK5WJGF73xbKveS00PNKw5h9Gq1oNBAcyikNN10z9wiA9MYTV8xH6+5wZrvc
	 FMobs0+JzvP5A==
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
Subject: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
Date: Sat,  9 Mar 2024 04:15:12 +0100
Message-ID: <20240309031609.270308-1-marex@denx.de>
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
This chip is present e.g. on muRata 1YN module. Extend the
binding with its DT compatible.

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
 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index cc70b00c6ce57..670bff0078ed7 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -27,6 +27,7 @@ properties:
       - brcm,bcm4335a0
       - brcm,bcm4349-bt
       - cypress,cyw4373a0-bt
+      - infineon,cyw43439-bt
       - infineon,cyw55572-bt
 
   shutdown-gpios:
-- 
2.43.0


