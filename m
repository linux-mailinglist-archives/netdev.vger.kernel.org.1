Return-Path: <netdev+bounces-45892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F47E025D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028901C20A17
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143B154BF;
	Fri,  3 Nov 2023 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjWC1CPV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7D1549C
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 11:51:24 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1FD1A8
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 04:51:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4079ed65471so14314335e9.1
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699012281; x=1699617081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8H5CgNif/6c2EaYqcnpG+FAzUC7z8C6P3V7QT7eDE/Q=;
        b=QjWC1CPVqOFa86TK2/Vt1VEEJABPIpANbNZDuHyibN5Obh0fvHvtS/MacL7pTOrO/y
         wwJtDOZtaYpGiqX5Hi8MhuYs6kGd5Y9Bsy1GkRvlfdQgoRQHGsCwzXh4/OwPtTaBo2xd
         OP5EflouJxoHyg8uGOqVilOcOblCLw7adhz+S29RIPWkCo2bg6JFnU5MQCaZji3tX2F3
         +AKjCsAQ1ecbbu8SpykNWnXNhEieMh1+/slLtG0ilA5lSZqz0puhoqGFPFEe5CyAcNuP
         LUdFUewGC6dhyEssoWpcm4PpHIr+6qCE+Z6VHwutSQDOel9J2Qo34kZnnZrc9XH/CPSi
         M7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699012281; x=1699617081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H5CgNif/6c2EaYqcnpG+FAzUC7z8C6P3V7QT7eDE/Q=;
        b=jpwxt3FftK05suJlxypeWVoebJvxhzNHORz6q9yPMngAWsqhc/h77JHwj/vh8kHuWU
         fmlz+xkEkx4h4Dr6gWyjL78P6MSaz/GKkkPhc+H2pu24F8YFxLjdNW6laO/vFtrnOLGd
         Quk0dg0LTZ+GCTVpP4WjZNv84bAG82c94fYGz5bQvR9sAy+H1eFMivCeJG8BX22TT3zs
         7xSnrt5sHCBJck9NB/EfkQfjKiyoWMbCe9ITTMm8ilGyMTp+raoBYpZTTzo2A3cv7oq8
         4Wtd4LjroG/dO96LyrCG0sqObGtSft6k1U8coOaIoXct+m8jedwuybCwKzAaWCT2Z5G9
         xShQ==
X-Gm-Message-State: AOJu0YyH9OViME7kuiMKjmH3u6sJxFcwmP/rCnCWIR5QDtg3tv+vIjL6
	J5tM9RhiF8b4HhdAvK419ij75/f+2f/hWzGDZFY=
X-Google-Smtp-Source: AGHT+IHKM8q/k7TyKQZHTa9mZSK29lamEGeOrcErAX2dep400jfXffhjHx2E1Iol+77fpKtTDRmK5Q==
X-Received: by 2002:a05:600c:3b9d:b0:408:57bb:ef96 with SMTP id n29-20020a05600c3b9d00b0040857bbef96mr17623461wms.30.1699012281178;
        Fri, 03 Nov 2023 04:51:21 -0700 (PDT)
Received: from localhost.localdomain (buscust41-118.static.cytanet.com.cy. [212.31.107.118])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d460d000000b0032fb46812c2sm1685303wrq.12.2023.11.03.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:51:20 -0700 (PDT)
From: George Shuklin <george.shuklin@gmail.com>
To: netdev@vger.kernel.org
Cc: kai.heng.feng@canonical.com,
	George Shuklin <george.shuklin@gmail.com>
Subject: [PATCH v2] tg3: power down device only on SYSTEM_POWER_OFF
Date: Fri,  3 Nov 2023 13:50:29 +0200
Message-ID: <20231103115029.83273-1-george.shuklin@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dell R650xs servers hangs on reboot if tg3 driver calls
tg3_power_down.

This happens only if network adapters (BCM5720 for R650xs) were
initialized using SNP (e.g. by booting ipxe.efi).

The actual problem is on Dell side, but this fix allows servers
to come back alive after reboot.

Signed-off-by: George Shuklin <george.shuklin@gmail.com>
Fixes: 2ca1c94ce0b6 ("tg3: Disable tg3 device on system reboot to avoid triggering AER")
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..22b00912f7ac 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18078,7 +18078,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	tg3_power_down(tp);
+	if (system_state == SYSTEM_POWER_OFF)
+		tg3_power_down(tp);
 
 	rtnl_unlock();
 
-- 
2.42.0


