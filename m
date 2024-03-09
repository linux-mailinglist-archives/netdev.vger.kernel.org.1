Return-Path: <netdev+bounces-78894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1209876EEE
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0EB1F218AD
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3942EB10;
	Sat,  9 Mar 2024 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="teyFOGLG"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD22E40F;
	Sat,  9 Mar 2024 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709954194; cv=none; b=PjXdm1sYCiMxgKKY94NX8Ad3KVZdtipYQZdeppkT72dI3ecp+wTSZP5cdLh3CYM1nuJhiwaPa+6buX7zKjkdXNug53sNzq2r4agNRjBBAn6Ab6yfU5eVSRJ2lnSWewVUOIKUArvuiRS8P1OftInFHrP++22xvQ99Z5cF1ynpZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709954194; c=relaxed/simple;
	bh=P6Y7ZT025E+fiKDvoHFrdjvRl8r4iOmIWTg1138ovb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJwz7dM/apw1jfm5uHfDUH2umy9n9VN6rPUwugNIG1wzp3WvM6DXdJBSH73XiUsb/NInIrvfQ26QToitlAJNOB50Np9MnA6EvyUuL5////haQ14HzZ9DA30bhQfH3t9Q3HLlH1nymT8/dfPaNW092QjBPhQoQGvgdaKE1YLP9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=teyFOGLG; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B219287D48;
	Sat,  9 Mar 2024 04:16:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709954190;
	bh=/dATcc4kK9LuQYmb68VQ5rlvRpgUqj+FWj4uFyYAPNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teyFOGLGYPvMb7m9TZM+Hv/b+oEphjYkqvLRvSOvLgj2H7W+vDPJUQyBXuPGFRYXA
	 4m7k37LZTD3RvvqCHxfwdI5+Yap9sNEms47Iwt0BrptUQ2NaoKgwnI384Mnf/T8WHW
	 dT3fgLUwAvlDTiiLe0MBEaWBtSMEG9+PyA55huetGcIq6qmjInYrAKfhCgoQNy0aVK
	 lrvqi01g5PddKw+UXwpWRLU18neIgrv7w2NDoytLEL4VKlZKeJbY1p3Ygq1eQkPGfH
	 xw+O9tZh6WdLT+ASDmv+rO4xbxt3Z58Aeqx4S2qU/R5jcYSuu9yrgRZGqsmsI0GmhR
	 IImma8p8zVq4w==
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
Subject: [PATCH 2/2] Bluetooth: hci_bcm: Add CYW43439 support
Date: Sat,  9 Mar 2024 04:15:13 +0100
Message-ID: <20240309031609.270308-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309031609.270308-1-marex@denx.de>
References: <20240309031609.270308-1-marex@denx.de>
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
driver to bind with it, even though the device binding is
most basic.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: This comes up as the following, should the binding be
      for 43439 (the chipset per muRata 1YN docs) or 4343A2?
Bluetooth: hci0: BCM: features 0x0e
Bluetooth: hci0: UART 4343A2 wlbga_BU
Bluetooth: hci0: BCM (001.003.016) build 0000
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
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 874d23089b39b..16b64b6ff7b1d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1608,6 +1608,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
+	{ .compatible = "infineon,cyw43439-bt" },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
 	{ },
 };
-- 
2.43.0


