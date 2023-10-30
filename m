Return-Path: <netdev+bounces-45143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA97DB25A
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 04:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2142813B5
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 03:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E66ECF;
	Mon, 30 Oct 2023 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/S2rZ5+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5CEC7
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 03:56:15 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E19B;
	Sun, 29 Oct 2023 20:56:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5cd27b1acso35906405ad.2;
        Sun, 29 Oct 2023 20:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698638173; x=1699242973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2LKPRDN6GCfDpHNmFLj1e87YJK73PiRp76sihBNMTM=;
        b=G/S2rZ5+JEMyqHAyowQAJHhBu5/E3DmDo/fS7Gi3+8QHuj9QYLAWDg+6DKMS2AYnIN
         59WuepT1I+tLXZrU1fCfR3GmOCc8l3AG/fyYRglAizWPB3J9sMMMX5DELiUWdtkF+XBK
         hQFFJAVaGKKX+D4CxN4yIvT/qSoXHf44GT5BcbIz3QRkshwJWsO4KQnntrpPUGJKhGCW
         5VDQh/nKj3jXrI5qdMr1AcwoqI5mAY+3pCJ5VWFEURU/CZB8qemYSDxuSJQ4z9HLtBV+
         J+xP5F5j63Qn4TH/rv3hVDeNS7Gg2pe+Fz1gdIR1pfA7DoMhWuTPG2v1PXDv1KLu8JoE
         Iqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698638173; x=1699242973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2LKPRDN6GCfDpHNmFLj1e87YJK73PiRp76sihBNMTM=;
        b=cydBVcAicUIThvXQJizcVgpRutfo/SlEDyvoMs/VP78t5CQMXW22tfip/XB87LjTlJ
         fRatRdNgiPDMPH1XLmEbed8Ry/IH9pIaekgE26ugpX5el5cNK3JubKMhDo/2Cp4pWnsa
         zGYtUq0Pd6ooxlbAnsCE2DZnD4dzDQaLqv9efP1cK9RPUkjQ6G2pYxLPp7zOvLxo1fYV
         1Ylwo0C2f74Sz1UxiBkDLqOwPybrMhjvabYiJ1G7VVVHMk2X8u8ni4GYtwYk0qzJvt8E
         3JhLaNZo2MWv6cZJNC8nZB91j5cotNg05RvrfW/su8xC9ctXBmsXi9YDNoAhk7ONyW41
         2mdw==
X-Gm-Message-State: AOJu0YwiDUIRIdcyvH0h+3VE/lnlqMvIdk9JIRvsD2nmHr3C4QM5H52R
	56icS4D2VoY/lUJFwoLEAm8=
X-Google-Smtp-Source: AGHT+IFtziW0YEt+qaY773vj4t1QmwQ2WxPAPa4J4C8WbaX4O7OoKTqUrQZRKxurTVOpf3PHJN/cmQ==
X-Received: by 2002:a17:903:2054:b0:1cc:4146:9ecb with SMTP id q20-20020a170903205400b001cc41469ecbmr2679315pla.47.1698638173229;
        Sun, 29 Oct 2023 20:56:13 -0700 (PDT)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id f7-20020a170902860700b001ca773d674bsm5159445plo.278.2023.10.29.20.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 20:56:12 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2] net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs
Date: Mon, 30 Oct 2023 11:55:50 +0800
Message-Id: <20231030035550.2340514-1-0x1207@gmail.com>
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
XGMAC Core prior 3.20, only PPSEN0(bit 4) is writable. PPSEN{1,2,3} are
read-only reserved, and they are already in Flexible mode by default, our
new code always set PPSEN{1,2,3} do not make things worse ;-)

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
Changes in v2:
  - Add comment for XGMAC_PPSEN description among different XGMAC core versions.
  - Update commit message, thanks Serge Semin and Jacob Keller for your advices.
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index f352be269deb..453e88b75be0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1178,7 +1178,19 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+
+	/* XGMAC Core has 4 PPS outputs at most.
+	 *
+	 * Prior XGMAC Core 3.20, Fixed mode or Flexible mode are selectable for
+	 * PPS0 only via PPSEN0. PPS{1,2,3} are in Flexible mode by default,
+	 * and can not be switched to Fixed mode, since PPSEN{1,2,3} are
+	 * read-only reserved to 0.
+	 * But we always set PPSEN{1,2,3} do not make things worse ;-)
+	 *
+	 * From XGMAC Core 3.20 and later, PPSEN{0,1,2,3} are writable and must
+	 * be set, or the PPS outputs stay in Fixed PPS mode by default.
+	 */
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
-- 
2.34.1


