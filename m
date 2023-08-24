Return-Path: <netdev+bounces-30467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C4B7877F6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF60E281674
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BE15AF9;
	Thu, 24 Aug 2023 18:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C515AF6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A871BE9
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thxHPyqpXjBOV26mQw4932uoaf4t0NSsG4y7+rk0Hj4=;
	b=i1Mp3NMvhru5TQEvSKtHYa50rws/P9+SZuykiTODCUiUxO7xnNjJEyc3XCladaGbQ7ZHTC
	fmmU9wfZaF+W4H//iI3x+mS3nBD6y51xA9L4lX+tTV+QnN7U/1lkKDH2znW/JBAUkDrpnk
	YV1AhRwhL2TBJGzS+eyTkRL6zz5ocqo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-wDoeQsRHMhKXaNJmd02Z1g-1; Thu, 24 Aug 2023 14:33:01 -0400
X-MC-Unique: wDoeQsRHMhKXaNJmd02Z1g-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1cc61e461deso102166fac.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901980; x=1693506780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thxHPyqpXjBOV26mQw4932uoaf4t0NSsG4y7+rk0Hj4=;
        b=CGn2FWW7pg/kfGAvLviBrnH1zKKbfg/8LtedsJFO6bIZwKblnzzjvwE6GGbFfQMvUK
         LXxlIPLmthuDIwDmDSAkRkAnJDr+ejH644GJxXSbXUX7AUoWe7zusAzVvspzs9HoQ2aM
         LK9aiUPmCpdIh58quejQDUaYmCfldBA1U1TRQP88XjFKHpLFIBbGmazzmGzXN7descej
         Oubgmvt+h7szaqyO1gzFUV30Qyp2ObCtBR7Fha8krFBG0b7B7UDfgDFP4XfBMFSCiG1i
         rf/WHrW6ksJff4JH8kQ/1+DRPKvnd9K/qbOTwlabaBt8VTx0pW+k3UM0v9NgMukXmZUj
         VuZA==
X-Gm-Message-State: AOJu0Yzf9Wbw6Sf3oRsaa/OPaYvyL0MJo8Xs9PsVkDZrasHf6wnCuPWW
	2Fic5mpL6E7i5Qm9cngXsAiSr9XkghH9XNN2jeFaP/IWpDkJUcpN+qvpkrGe8mJtlx+EwhrYdWe
	k21NihVR7D4XG9Whz
X-Received: by 2002:a05:6870:b30e:b0:1c8:b870:4e62 with SMTP id a14-20020a056870b30e00b001c8b8704e62mr553975oao.52.1692901980221;
        Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNSmaNfEZS7WL931iN10lI15Wz+1s4J2mbWyoGTTDkdpLqrEtuCwFnkDMpqeyKk0MWFoSBXQ==
X-Received: by 2002:a05:6870:b30e:b0:1c8:b870:4e62 with SMTP id a14-20020a056870b30e00b001c8b8704e62mr553945oao.52.1692901979913;
        Thu, 24 Aug 2023 11:32:59 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:32:59 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:53 -0500
Subject: [PATCH net-next 2/7] net: stmmac: Use NSEC_PER_SEC for hwtstamp
 calculations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-2-e0b9f7c18b37@redhat.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This makes it more clear what unit conversions are happening.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 6dcf8582a70e..29fd51bb853d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -36,12 +36,12 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 	 * to mid-range = 2^31 when the remainder of this division is zero,
 	 * which will make the accumulator overflow once every 2 ptp_clock
 	 * cycles, adding twice the number of nanoseconds of a clock cycle :
-	 * 2000000000ULL / ptp_clock.
+	 * 2 * NSEC_PER_SEC / ptp_clock.
 	 */
 	if (value & PTP_TCR_TSCFUPDT)
-		data = (2000000000ULL / ptp_clock);
+		data = (2 * NSEC_PER_SEC / ptp_clock);
 	else
-		data = (1000000000ULL / ptp_clock);
+		data = (NSEC_PER_SEC / ptp_clock);
 
 	/* 0.465ns accuracy */
 	if (!(value & PTP_TCR_TSCTRLSSR))
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 67e4f65f0f68..ba38ca284e26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -849,7 +849,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sub_second_inc);
-	temp = div_u64(1000000000ULL, sub_second_inc);
+	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;

-- 
2.41.0


