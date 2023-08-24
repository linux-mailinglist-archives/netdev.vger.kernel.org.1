Return-Path: <netdev+bounces-30471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524F787807
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665BC1C20E5D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18C18045;
	Thu, 24 Aug 2023 18:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EEA18032
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348E1BF5
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzwAY3qfQtSXBG/JoTJUgqmvExN/Fjeet/g8tdk5k1I=;
	b=TL9fvLw+yqz3s/7odtWIpAK6orDDc5L4WsTsgNyPMRhkB8P+WF01UC5wKRMeyqXG55V0r8
	p1y8Em/jvelAmvKMOMD1fxDswIj8jfFcqeRUbsOZeqsG/skBuaLFUZoEaqB8zFn+zurMVZ
	vr0AsIYmcKuwi0lc58z4llPjbAB0YqM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-88no-JMuOY-Z9lmRyFZ33g-1; Thu, 24 Aug 2023 14:33:07 -0400
X-MC-Unique: 88no-JMuOY-Z9lmRyFZ33g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-64b7c2a0d5dso1330006d6.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901987; x=1693506787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzwAY3qfQtSXBG/JoTJUgqmvExN/Fjeet/g8tdk5k1I=;
        b=MerHMC2zoce7B19sfsrMqp/Lf2HaaNlnpVHMvnzp+wnPzDwS9w9CUL/CSUcrpuRCKx
         VtKHEH//5OyTTE3Yr7MwKze0ZwwaeVpSeEdnkB8WKAkkYsSKx15SVpQKYyzW8Dv/pDYQ
         RKKNiyCw5mb5DB7GmcfQA6JZVtgOsGjOM0Fif5x6/pi2NHasO23F+AlmQ6DG/d8QzQox
         /YFxF6fzJ/+owroTjk6QrVG6aLYBwKrocUbk+vC4hkAk4vgkEu552xEuB0ODclAqhw7F
         r7aAEDb7L+tQF7gQVkH8dWy8mtbHkLBkD+tjHzTA5dSOcK2qytEqp0WwVREd5C2jppnV
         bosA==
X-Gm-Message-State: AOJu0Yz+NU3FPA4vJ9Z/Es3YtkfEEjE++C9ad1KjewxSLV/sQRxnPmlE
	bYOnHzS3Vlt8fn+7aQxezGgNi+6Q6wkQgzMph3mQgt3inji6xRsx/IcTQSqaBhraYp5FuQnvs2f
	/IX+E00GRRxduhWFACiMvPqeq
X-Received: by 2002:a0c:cb8a:0:b0:64b:997f:5a73 with SMTP id p10-20020a0ccb8a000000b0064b997f5a73mr17312062qvk.0.1692901986874;
        Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0V6Mej9o119R+pmyxj+YFe+lm4pgu3DlavB9TMY9jyVspWXod0xr56aTpa4++K5uMfm7xpg==
X-Received: by 2002:a0c:cb8a:0:b0:64b:997f:5a73 with SMTP id p10-20020a0ccb8a000000b0064b997f5a73mr17312048qvk.0.1692901986627;
        Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:58 -0500
Subject: [PATCH net-next 7/7] net: stmmac: Make PTP reference clock
 references more clear
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-7-e0b9f7c18b37@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ptp_clock is an overloaded term, and in some instances it is used to
represent the clk_ptp_rate variable. Just use that name as it is
clear that it represents the rate of the PTP reference clock.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h            |  5 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index bd607da65037..ba92b10cff0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -523,8 +523,9 @@ struct stmmac_ops {
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
-	void (*config_sub_second_increment)(void __iomem *ioaddr, u32 ptp_clock,
-					   int gmac4, u32 *sub_second_inc);
+	void (*config_sub_second_increment)(void __iomem *ioaddr,
+					    u32 clk_ptp_rate,
+					    int gmac4, u32 *sub_second_inc);
 	int (*init_systime) (void __iomem *ioaddr, u32 sec, u32 nsec);
 	int (*config_addend) (void __iomem *ioaddr, u32 addend);
 	int (*adjust_systime) (void __iomem *ioaddr, u32 sec, u32 nsec,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 29fd51bb853d..cc0386ee6dee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -24,7 +24,7 @@ static void config_hw_tstamping(void __iomem *ioaddr, u32 data)
 }
 
 static void config_sub_second_increment(void __iomem *ioaddr,
-		u32 ptp_clock, int gmac4, u32 *sub_second_inc)
+		u32 clk_ptp_rate, int gmac4, u32 *sub_second_inc)
 {
 	u32 value = readl(ioaddr + PTP_TCR);
 	unsigned long data;
@@ -34,14 +34,14 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 	 * increment to twice the number of nanoseconds of a clock cycle.
 	 * The calculation of the default_addend value by the caller will set it
 	 * to mid-range = 2^31 when the remainder of this division is zero,
-	 * which will make the accumulator overflow once every 2 ptp_clock
+	 * which will make the accumulator overflow once every 2 clk_ptp_rate
 	 * cycles, adding twice the number of nanoseconds of a clock cycle :
-	 * 2 * NSEC_PER_SEC / ptp_clock.
+	 * 2 * NSEC_PER_SEC / clk_ptp_rate.
 	 */
 	if (value & PTP_TCR_TSCFUPDT)
-		data = (2 * NSEC_PER_SEC / ptp_clock);
+		data = (2 * NSEC_PER_SEC / clk_ptp_rate);
 	else
-		data = (NSEC_PER_SEC / ptp_clock);
+		data = (NSEC_PER_SEC / clk_ptp_rate);
 
 	/* 0.465ns accuracy */
 	if (!(value & PTP_TCR_TSCTRLSSR))

-- 
2.41.0


