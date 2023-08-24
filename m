Return-Path: <netdev+bounces-30466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B97877F4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E657281634
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893721549C;
	Thu, 24 Aug 2023 18:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5A15AC7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608AA19BE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6l23XMepM0Sh/iOcowpX76UCT+vWOCxLFJ6fQYXhTVo=;
	b=X0y107lxiVSyYEmIPUufzreSZ7fAZXPY6VHZIVHtZyobUFY1zBYE41vOxI/IghliVsVQXO
	jjepjQmwzAhZp5kDJste6kkkTLQjMyhvh55CxNyQoulYBTVEcDIi4EsA+BznCaHUZxiFJ1
	LVOWyBxc1BGxKg2uzlUpDWJB/lxDqyo=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-8q1nb6KeOHqMJ5RN7OcHAg-1; Thu, 24 Aug 2023 14:33:02 -0400
X-MC-Unique: 8q1nb6KeOHqMJ5RN7OcHAg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1befca4fdfaso117711fac.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901981; x=1693506781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l23XMepM0Sh/iOcowpX76UCT+vWOCxLFJ6fQYXhTVo=;
        b=AxaXpgP1bzs0yidL2sjqhtvsznpyxJbq2qHGyvzCOxHumoVyEyyxKCkt4Huqlojf24
         tY3bbiw40OnRJ0UkehX8S80H2fwoMbtSR3l27ZE3YbnwfVq/VOdzkNxGAHBAW14Zwttq
         GjsdDMcvcJqHUNbC95grR5z2D0O5iUIRtRJLEHl0elb3AS/6vzXQMNqwLglmVYP5ENWy
         s2EAMj1X9CnNBQ/HYuUQvAqMJ4VLiYw72uh/mvibB5P7omFW40BXKZKlWDj1IW64qxYr
         PiH+ukYDxhZecjQut3oa6pvuCHBVfl8NDo7Hqpc/nCvQPTUKl2D5Pif3SzFKz/reC8te
         CEIg==
X-Gm-Message-State: AOJu0YzbGVSfNh1jYFN5X24i6x0QZn0rK7Q+9PkeY4m/jfnGaAsVmC+1
	29Eggkf1ykpsRStR4odKIODJyoNn6DTLVgzdrOiSBveRb+GcGwj+plYf0S8bI2QvC0XMkCsUHSA
	7qDSUSXyUlkg2J2iP
X-Received: by 2002:a05:6870:e253:b0:1be:f8d9:7bdd with SMTP id d19-20020a056870e25300b001bef8d97bddmr627371oac.6.1692901981455;
        Thu, 24 Aug 2023 11:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS3fEn/UFcZp7p1JhHHa0Wzb/ax2PIiQ32dL4ujO6wuTfaKPgzGkO+lp3kAWh66sAyZwY+xw==
X-Received: by 2002:a05:6870:e253:b0:1be:f8d9:7bdd with SMTP id d19-20020a056870e25300b001bef8d97bddmr627359oac.6.1692901981225;
        Thu, 24 Aug 2023 11:33:01 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:54 -0500
Subject: [PATCH net-next 3/7] net: stmmac: Precede entire addend
 calculation with its comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-3-e0b9f7c18b37@redhat.com>
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

The addend calculation is currently split. The variable to be programmed
is first altered, then a comment explaining the full calculation is
seen, then the variable is altered further before the calculation is
finished.

Make the comment the first thing read. This makes the conversion of
sub_second_increment from nanoseconds to hertz much easier to
understand and reads logically.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ba38ca284e26..f0e585e6ef76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -849,7 +849,6 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sub_second_inc);
-	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;
@@ -859,6 +858,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	 * addend = (2^32)/freq_div_ratio;
 	 * where, freq_div_ratio = 1e9ns/sub_second_inc
 	 */
+	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 	temp = (u64)(temp << 32);
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
 	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);

-- 
2.41.0


