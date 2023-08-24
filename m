Return-Path: <netdev+bounces-30465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05F7877F3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF811C20EEB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205615AC8;
	Thu, 24 Aug 2023 18:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C71549C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8A1BC2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MSPeUOmvEq1eUUgwQ2syHQsuZQFtArlwfrE4/FiNFk=;
	b=MlFwLBFWJG6gjowEuFQCKNzg9JVCfTrGVQgaLU9iWtUcx6YAE/byFaQzduOJ8eq40QIEYL
	U/y0CXWakzmuxFykx5wNhtp3oMCy2S8oRXjdu3RVAivM0dool/YSaTvV8BBqzgr5cK+w9N
	7K5vl69YJnVD4EVnYD3wg5otyWehKKg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-hpf9l0MAMN6VxulcMpg0rg-1; Thu, 24 Aug 2023 14:32:59 -0400
X-MC-Unique: hpf9l0MAMN6VxulcMpg0rg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-649fac91500so11618446d6.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901979; x=1693506779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MSPeUOmvEq1eUUgwQ2syHQsuZQFtArlwfrE4/FiNFk=;
        b=dEd6b1b+u9AqC+4/RAJHlGJ/B5Oeb3NpVZJIxhM/T9J58cIIWV71nrirS93faGpPRu
         MuYQmIpJqEXnOpkQBSs2AkE4NCL7SjU8/7SAggHSXP6rkUfG+PK4bLYWm2JDqNFRylw6
         sRPVXWWW9huY14Tu9ASxPOLuvq0G4m5n/eulKrGI3mcgucJ/mj7FTJVwG+mW/scoWIiV
         kywixoebeBnFqDVBLFCJ5zi4NhmFuJyd49nSMZA5EMsmXghdojydeVYMU4BhMq3w4ihA
         ju8eN0yM2wWQ17NOymBR2+PdASmZ+AHYz6ag5bW0qPm2b+aiiqIufSXSUd7eLYaS+KCp
         XoPw==
X-Gm-Message-State: AOJu0YzZrsYAYbW43jqRtPU+0attGyaznZLarx3/A6Ob+DNNUvWXYf7b
	G8NwbI0e1UEGO/ELDXp//c4brNIEmUkKqsD7DfOSBVUdX4MZRs64KPsMZCJVa7fFe952IX1RVA5
	U2Lx3O7+/FfzV52eh
X-Received: by 2002:a0c:e246:0:b0:647:2653:bcc with SMTP id x6-20020a0ce246000000b0064726530bccmr18915150qvl.13.1692901978978;
        Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOnxZtOm4Zbo/1b64keu9y2z8jyW5dWXMkNKbfmN/AXxPf8v016bCHVXCzjBnQUDUxKTav6w==
X-Received: by 2002:a0c:e246:0:b0:647:2653:bcc with SMTP id x6-20020a0ce246000000b0064726530bccmr18915120qvl.13.1692901978737;
        Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:52 -0500
Subject: [PATCH net-next 1/7] net: stmmac: Use consistent variable name for
 subsecond increment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-1-e0b9f7c18b37@redhat.com>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
In-Reply-To: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Subsecond increment is the name of the field being programmed.
Let's stop using a bunch of variations of that name and just
use sub_second_inc throughout.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h            |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 238f17c50a1e..bd607da65037 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -524,7 +524,7 @@ struct stmmac_ops {
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
 	void (*config_sub_second_increment)(void __iomem *ioaddr, u32 ptp_clock,
-					   int gmac4, u32 *ssinc);
+					   int gmac4, u32 *sub_second_inc);
 	int (*init_systime) (void __iomem *ioaddr, u32 sec, u32 nsec);
 	int (*config_addend) (void __iomem *ioaddr, u32 addend);
 	int (*adjust_systime) (void __iomem *ioaddr, u32 sec, u32 nsec,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 540f6a4ec0b8..6dcf8582a70e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -24,7 +24,7 @@ static void config_hw_tstamping(void __iomem *ioaddr, u32 data)
 }
 
 static void config_sub_second_increment(void __iomem *ioaddr,
-		u32 ptp_clock, int gmac4, u32 *ssinc)
+		u32 ptp_clock, int gmac4, u32 *sub_second_inc)
 {
 	u32 value = readl(ioaddr + PTP_TCR);
 	unsigned long data;
@@ -56,8 +56,8 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 
 	writel(reg_value, ioaddr + PTP_SSIR);
 
-	if (ssinc)
-		*ssinc = data;
+	if (sub_second_inc)
+		*sub_second_inc = data;
 }
 
 static void hwtstamp_correct_latency(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7a9bbcf03ea5..67e4f65f0f68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -836,7 +836,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 {
 	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
 	struct timespec64 now;
-	u32 sec_inc = 0;
+	u32 sub_second_inc = 0;
 	u64 temp = 0;
 
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
@@ -848,16 +848,16 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	/* program Sub Second Increment reg */
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
-					   xmac, &sec_inc);
-	temp = div_u64(1000000000ULL, sec_inc);
+					   xmac, &sub_second_inc);
+	temp = div_u64(1000000000ULL, sub_second_inc);
 
 	/* Store sub second increment for later use */
-	priv->sub_second_inc = sec_inc;
+	priv->sub_second_inc = sub_second_inc;
 
 	/* calculate default added value:
 	 * formula is :
 	 * addend = (2^32)/freq_div_ratio;
-	 * where, freq_div_ratio = 1e9ns/sec_inc
+	 * where, freq_div_ratio = 1e9ns/sub_second_inc
 	 */
 	temp = (u64)(temp << 32);
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);

-- 
2.41.0


