Return-Path: <netdev+bounces-18563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5294757A32
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B292814FF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D1C2FF;
	Tue, 18 Jul 2023 11:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB7C2FE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:12:46 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B7E10DF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:12:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992ca792065so770317566b.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689678763; x=1692270763;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuBvS5kRKpThC2bSoBoqzJHzt9QvszOv1UPOwkEOThU=;
        b=bCxL9+oSfqilKG29JbYyiLXWrMcF47XlgJXkySu276iOuesx7iBjkkhMbCBSyjzy65
         7kaoDmsAwY9CE6OLVkZimYEtqpi3LCKUETY+T74V1fZ1RYll9dHrez/pA2YyySY2PDp6
         pyw8rzo3QYUgeBL5CpGjmj07Jl5swMlQIxfvtWq8gA6ihtJoZweI9D9SkhUVyTTg9Ykp
         X/s9OLnlPuqNqPDBMJn1vymgs/wD/VyB7dap+C3d8myWfrVic5qTd3pU+2ozTxu6J8AJ
         WpsWmdC2FkycAHEjFnVyfcr439fGVb68d1FLPq5qEh/pm8ImYfTTxSAJkCN4WScABk36
         TXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689678763; x=1692270763;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuBvS5kRKpThC2bSoBoqzJHzt9QvszOv1UPOwkEOThU=;
        b=aw5IYAi+u3vMESbTwgsg8vkebSYGnmx0bX1iIRqU/2RMuzZJYmiEUetg+G98WgoApP
         tDbZ9S0Ki5+yOS+uM46ioK0C3JzTvyhDszjq0U/FzY6i40zfvXEdKWPXe8X4GVLHJ9+z
         G+C7dsUvQT/wk8D2zlawIcCzDktAifXKq/YeMGAqqzhUl17tB/wTUPSSPrDE76PdP5dA
         pp2tJQRPNOo7dXIYDVFFSm+AzSqLDJxnCT0DtgoXYRaLQqD7fEx688qf3eeAFYI3w55L
         sFrW27QNS/WQoa83sShRcUS75A4ZyxI60wQKR+Ct7UVMPldLC5A4NSscnOK6sCWf9M4h
         rGUQ==
X-Gm-Message-State: ABy/qLZzFPAOaShh99LbAmKTC6evpziv6bYH2OlsuItPjVl8Jrn2ZVIC
	9Ha+F8u4VrEcq3ShCMKBIdk=
X-Google-Smtp-Source: APBJJlHb4hnTz978Nx6RoiZt7J4fi2L4j0VgMuqisrYa7sn4rUx8B2mvBbWIydFmKylkP/SDYKRgSw==
X-Received: by 2002:a17:906:1d8:b0:993:d7c4:1a78 with SMTP id 24-20020a17090601d800b00993d7c41a78mr12027603ejj.10.1689678763477;
        Tue, 18 Jul 2023 04:12:43 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7315:d100:15fd:b3ca:86:923? (dynamic-2a01-0c22-7315-d100-15fd-b3ca-0086-0923.c22.pool.telefonica.de. [2a01:c22:7315:d100:15fd:b3ca:86:923])
        by smtp.googlemail.com with ESMTPSA id b18-20020a170906195200b00992ddf46e65sm893120eje.46.2023.07.18.04.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:12:42 -0700 (PDT)
Message-ID: <055c6bc2-74fa-8c67-9897-3f658abb5ae7@gmail.com>
Date: Tue, 18 Jul 2023 13:12:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH net 2/2] Revert "r8169: disable ASPM during NAPI poll"
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <ddadceae-19c9-81b8-47b5-a4ff85e2563a@gmail.com>
In-Reply-To: <ddadceae-19c9-81b8-47b5-a4ff85e2563a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit e1ed3e4d91112027b90c7ee61479141b3f948e6a.

Turned out the change causes a performance regression.

Link: https://lore.kernel.org/netdev/20230713124914.GA12924@green245/T/
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 8a8b7d8a5..5eb50b265 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4523,10 +4523,6 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	}
 
 	if (napi_schedule_prep(&tp->napi)) {
-		rtl_unlock_config_regs(tp);
-		rtl_hw_aspm_clkreq_enable(tp, false);
-		rtl_lock_config_regs(tp);
-
 		rtl_irq_disable(tp);
 		__napi_schedule(&tp->napi);
 	}
@@ -4586,14 +4582,9 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	work_done = rtl_rx(dev, tp, budget);
 
-	if (work_done < budget && napi_complete_done(napi, work_done)) {
+	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
 
-		rtl_unlock_config_regs(tp);
-		rtl_hw_aspm_clkreq_enable(tp, true);
-		rtl_lock_config_regs(tp);
-	}
-
 	return work_done;
 }
 
-- 
2.41.0



