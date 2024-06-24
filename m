Return-Path: <netdev+bounces-106202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2083915364
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22181C22EED
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9119DF45;
	Mon, 24 Jun 2024 16:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76819B590;
	Mon, 24 Jun 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246117; cv=none; b=bGI3OFXdGEhOs5vgnl1e5bIEUKIkZTa19HfkqjO/Zfi7RCN0e42MT2yMoqdMYbWawSRrezL/oAllOQ7ZCjAO9uBCLh/LBnv2uu3Dlmwe9yx4DU55KosKKKsELa1uDoBY3fPTlozc7jyJEXHOG8c4zW2Aj5TQUh5DB5o5vKY79mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246117; c=relaxed/simple;
	bh=SlQR/YilwGyYw+GewS/RVjILB88L+FJD4Y6bw6oQsLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFkrg5+bjQ1nxq1QBW/yHNb5ubsjP8JOSG8VTShQ6gFcQrOrXQim/4CgdX2g2UR1b5l7aQUEvSk+stYVmkJwY6ubKGjhaU8SFhwe+J1A3SbNJXUOULBAsV/BVOyRy023OliUAIh1LJvKdi/7XsGltiox/4wlmR6/Qv3ff4Ssy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so574128866b.2;
        Mon, 24 Jun 2024 09:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246114; x=1719850914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5dYSmS+UlMvDH3osanHRgj0IFMR5noB3hmhQYLwPF0=;
        b=s2f3/JXfvtISGVVjy4VjBqZVqpd9eggygmZM2bcwSXs1loR0XY7CzuEDcDsz1XqVvy
         GA8CzV8vUYjpYyEVotSD88Jy+MfFUmjA14PT5nIijJa0WULQWU6Q6iVVfg/fhhoqTEzw
         0NMHOgZhKlz9m+KLzMz9erQGvwsqhm/VK3/DzrYewyqtH7Hh15sWs3TgArerg1cdwTrw
         vRKvmb2/bqQfiSY+MIgvFI/IaQHW9YqOIuULiO0ftRJt/hTB2Ql2iuA2vPe4u0fqlM1d
         PqCJZ9QbO6huZeKhKlWaAudlZAshiuwFieHh4AdhKaz78u5fnk2YjoHdYZrED1dwsWYp
         H8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWdI/8jddqBEDUX4S8dG/aLdiiuefXznypN6Tew8chF8v9nrwZrGb5lHdG/KVx87Z14Bd+DgoNFeVFblMmQKFJ/+RvJsRfeHr5Ge0VCSdcvdBCvNbDOubJfxcYv4+6vdHyFUJGr
X-Gm-Message-State: AOJu0YwxUHTBEpZcHIE4zqQAyZy/JH/FM3aqKnUiACjKDjtQgfNYqvMP
	0krzO9LwtvYKy4p/JSJwuWTVNClmJptcWLNsiZpGFxZ7VhtR/wxb
X-Google-Smtp-Source: AGHT+IGAirccbr9ebRQ4r1Bpr+wLTdNcrvrtLbrlxOOhudvRIZe2BWJOZZT0opPHnukDV9nHPaB2Zg==
X-Received: by 2002:a17:907:8e93:b0:a6e:f62d:bd02 with SMTP id a640c23a62f3a-a7245c84f2emr309572466b.7.1719246113524;
        Mon, 24 Jun 2024 09:21:53 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724d8a362fsm173519666b.158.2024.06.24.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:21:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	Roy.Pledge@nxp.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Date: Mon, 24 Jun 2024 09:21:19 -0700
Message-ID: <20240624162128.1665620-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As most of the drivers that depend on ARCH_LAYERSCAPE, make FSL_DPAA
depend on COMPILE_TEST for compilation and testing.

	# grep -r depends.\*ARCH_LAYERSCAPE.\*COMPILE_TEST | wc -l
	29

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index bdecb86bb656..27774ec6ff90 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig FSL_DPAA
 	bool "QorIQ DPAA1 framework support"
-	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE) && ARCH_DMA_ADDR_T_64BIT)
+	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE || COMPILE_TEST) && ARCH_DMA_ADDR_T_64BIT)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.43.0


