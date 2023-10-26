Return-Path: <netdev+bounces-44446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C367D7FF7
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60CB1C20A8C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C828DAD;
	Thu, 26 Oct 2023 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNjiGQOf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100F28687
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:49:13 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E99D;
	Thu, 26 Oct 2023 02:49:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cacde97002so4977745ad.2;
        Thu, 26 Oct 2023 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698313752; x=1698918552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trQmZAbaoRQLYbgSGHo4E3o4LgBwFck38x5wYn9EorM=;
        b=FNjiGQOfChB8nJFNbg3MbEMKsXgc1oONjFLFRsVfwYVBzwmuxkSe8Negrdo7IR7nRB
         R1NlgucrmrLzPnNaLNjXVr4lm30Q1ZJWU7RkJ6cqUPNuyhZHS3ZlstrJV/mUdioY8FXO
         5aQs3n2PZBeB2KPtTHKBDiI1lmdSYr/tkIpCm7ZoTkZFobKgCbMhOseTVumwzqnkhFcj
         dGLO2J/qKgwIGWcVK2G11/+qeRqLQzjw907Bh+VWOu05Gpuk9jV4i13ha8I/BwBN2DFo
         sEo5Eo/7XxpiJE8nfF9b4uVleqLe8sUrQNm/A8MUpeoIXiTqw0FHFkQE81OM1rwzqdZA
         jAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313752; x=1698918552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trQmZAbaoRQLYbgSGHo4E3o4LgBwFck38x5wYn9EorM=;
        b=Z6OcUt5R0i7WA4fti9j/GbFGgg+z8cxQKCjliIyELnJA12VzN2flgDgo/aE7rUYl6F
         Y/DqXPHndZObiAPbcF7kLFTMJ5MgaRLCYX+6xzCivGJNp3UGudUpMqdqrEN+zT/z2RgK
         vG99T07GPhkA47+ADWrfMqEy3W4eSFj5CQwYvhQ5wUQgmB1hdEH03CFAFyeOFgSy7PuT
         VLjrBouA7Wiovbm4AWNNOo22pncF0p133eDY3YE+iXQFmSDBcTFKTvM3U1S0TeKN+ly7
         KVYPIw7swgEAFqjemaKDjtVcVu8S9UWdZiz3galNEQARu77LxArp/qISw/pB0SCd3yFg
         +33g==
X-Gm-Message-State: AOJu0YxABW5YZTSGfgKQw98/XGM5a9yAFvA/UGge5f7vdk7nlmPjc8zx
	Sqr8Lq1zmsjbWJC1fn8mG0I=
X-Google-Smtp-Source: AGHT+IEY6OtenDK7uCoSvT5qxvLDxbjXEYrpn2zBZno+Rv6P5yQzWR32ht2pgfIh/xPY2jg4eMpn8A==
X-Received: by 2002:a17:903:41c7:b0:1ca:b26a:9724 with SMTP id u7-20020a17090341c700b001cab26a9724mr17622651ple.12.1698313751680;
        Thu, 26 Oct 2023 02:49:11 -0700 (PDT)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id ji5-20020a170903324500b001b06c106844sm10674264plb.151.2023.10.26.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:49:11 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 1/1] net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs
Date: Thu, 26 Oct 2023 17:48:56 +0800
Message-Id: <20231026094856.986796-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
in Fixed PPS mode by default.
XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
always set PPSEN do not make things worse ;)

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 7a8f47e7b728..a4e8b498dea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -259,7 +259,7 @@
 	((val) << XGMAC_PPS_MINIDX(x))
 #define XGMAC_PPSCMD_START		0x2
 #define XGMAC_PPSCMD_STOP		0x5
-#define XGMAC_PPSEN0			BIT(4)
+#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
 #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
 #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
 #define XGMAC_TRGTBUSY0			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f352be269deb..53bb8f16c481 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1178,7 +1178,7 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
-- 
2.34.1


