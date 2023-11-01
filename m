Return-Path: <netdev+bounces-45548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A87DE134
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 14:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA582810E9
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135412B75;
	Wed,  1 Nov 2023 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUtQi+3k"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FF134A3
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 13:04:26 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964ADC
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 06:04:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so491176f8f.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698843863; x=1699448663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ddS1dzfDb0y0/Ppu2eB1oC7DBMR7a5pZAW8Ut40Xh0=;
        b=MUtQi+3kPWDs3mOVor8uTvzZNHzLwbH88DgoZC9OqGIWdd/RQuIGcD38NVHOJTwnyR
         m7MFMMSzsGikprg7VBp9McCNyjZkAYy8gH6vINhmPa6rUppXBLUgn2vqx1GfcB/5aFxx
         VMUduHqSHobaOlspnXG57Hi2rRakFM+moly65MF4zW2co7qOCcOdw3yQ8GfmrJR1iDzD
         k9nRwUh9A/3zpe4u9I8IyHDHu8ImV2moHHDgRzaUzTV/X2hUrAU5dswADydPHuIuZn0r
         Hr1w0zglVztoB4Rp/n7n88VaqtsLlY8g6LmCZpNXum/1EyvY+9wPgngavo91f56sVcfn
         mIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843863; x=1699448663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ddS1dzfDb0y0/Ppu2eB1oC7DBMR7a5pZAW8Ut40Xh0=;
        b=IjmF5RHzrnSWk8e1SFd7nZkAIGJXnMAyFpc2BgkSBVpUcrR4MkTjsKA/TGnCOdGjQK
         aBerjo31/5r7OrhcQ5/95wBrQSsPESZsIk5JVsYEvT/iIbMjGeLmX4oYv7Shxq3njYes
         foa8DLFgmEc1ZV6eHyMfDKrqYrKMyp3FjhLNWwIbOfXevTJWi1CvDx108p4TEQC+1dsu
         BaiOCV4B53sUODYjELM9Wa0/HR9CzWYcglQ/I/Ex214myfbQoHrVmarU2aW+7gVSiso6
         unfxV75gmhEadlP8DiLuwl/R/9NZ1kZ2pXStKGSNOP7hbkx9q/FBQj/bwkEvHeDOfzWE
         WkrA==
X-Gm-Message-State: AOJu0Yyfhnsn5oflLqeR4gxjk2VGbpVP73bjicaZlaAmYh4HE/mXtSJM
	owVP+RAuippthvxI46mG1cD3TM1GL6049Q==
X-Google-Smtp-Source: AGHT+IGUXluReWqw43i8lrprfraA9y2qyAirP25QltzE8e5Ru0OR6aCqD8SmNCNB424ZFX8eHRd4zA==
X-Received: by 2002:a05:6000:1544:b0:32f:7502:fba9 with SMTP id 4-20020a056000154400b0032f7502fba9mr3156244wry.1.1698843863272;
        Wed, 01 Nov 2023 06:04:23 -0700 (PDT)
Received: from localhost.localdomain (buscust41-118.static.cytanet.com.cy. [212.31.107.118])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b004064ac107cfsm1500108wmo.39.2023.11.01.06.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:04:22 -0700 (PDT)
From: George Shuklin <george.shuklin@gmail.com>
To: netdev@vger.kernel.org
Cc: George Shuklin <george.shuklin@gmail.com>
Subject: [PATCH] [PATCH net] tg3: power down device only on SYSTEM_POWER_OFF
Date: Wed,  1 Nov 2023 15:04:18 +0200
Message-ID: <20231101130418.44164-1-george.shuklin@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dell R650xs servers hangs if tg3 driver calls tg3_power_down.

This happens only if network adapters (BCM5720 for R650xs) were
initialized using SNP (e.g. by booting ipxe.efi).

This is partial revert of commit 2ca1c94ce0b.

The actual problem is on Dell side, but this fix allow servers
to come back alive after reboot.
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


