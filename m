Return-Path: <netdev+bounces-40240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBC7C65E6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792FC2826AC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720EDDB6;
	Thu, 12 Oct 2023 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf+WRz+R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B4DDA7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:51:17 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93B90
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:51:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so1115118a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697093475; x=1697698275; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/Osyk0Lx10uk3lKbedWqTvA+ctik89djOiSvn6731Q=;
        b=Uf+WRz+RhAgb5boHFuc2c5st0KgcMp+xEFIJ9kHCJDr/faD2tCitRow91aRL1wsmy+
         YFylLJaH/JPXRJNzONta0/bwc8oTF/SQzeHoGxQmEDRTSzMZ49SCLAJ1XweXRLbdUq2T
         HFctNEWyMO6lvLA4IQHO1oq4m7KldNhH3FKqaUroLwdrp6jxKScx5KY+9/x6YDzdhbJu
         +JRfWXgfM09K7Wcw4YdW5xvt/CPy3/9Sfehjky1O0A0V86YRp7YVMFGD7TmapPVC1aDm
         DCP5BgxvGSoSwum9/VbVZmKeYCiPupUZvuO8K9R5SWIjx8tDiZdihhRLKCvXpHyRWV2W
         /aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697093475; x=1697698275;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/Osyk0Lx10uk3lKbedWqTvA+ctik89djOiSvn6731Q=;
        b=Tl7fphN3XI+YbO2yahzCGLt/GyqoPOOKz6wG47HX6xVEWILVyIYnlETylKOkOiWzO6
         Ss0piQBS3BX8LyNQEn4jS5iLdKQz8IvXAxpqFv2Vdr+SUgQ0FhYJaFITtTUD/Tv+4aq7
         MnSQ81o53nnVOih/bdoUmP49i6ysGv+XVu7dWtH+MqGOb2C2mAqBMvv2waw+qLhbDaaX
         oxh5H3KPkeUI8vqI/hY9yU8X2xWZh6znivk4iGLl1kex/DVLy09FJMRvXo/0/Itggux2
         nLu9gi09O4lIjq4M4exdNb+5kaetE3m8kAYDo95eQkD5U8xftq3od8RhWN+Bp1ueuThg
         HBMA==
X-Gm-Message-State: AOJu0YwDXtnCM3XpDilFqO3aR4OKZeBiPmgFoIfxq4JjOrMV4L6/0/g6
	tnDAx0K803sS6RsamrlHNVc=
X-Google-Smtp-Source: AGHT+IEEZIHdX6k3EVgtPc1Z87fG46wsImIYIRiB4x3qSMiirpXl8rVC7dXWvCfhY+JDSaVdUrvVCA==
X-Received: by 2002:a17:906:3012:b0:99d:e617:abeb with SMTP id 18-20020a170906301200b0099de617abebmr20525263ejz.23.1697093474443;
        Wed, 11 Oct 2023 23:51:14 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7bee:c400:8df5:13c7:fec1:9238? (dynamic-2a01-0c22-7bee-c400-8df5-13c7-fec1-9238.c22.pool.telefonica.de. [2a01:c22:7bee:c400:8df5:13c7:fec1:9238])
        by smtp.googlemail.com with ESMTPSA id cb22-20020a170906a45600b0099ce025f8ccsm10675802ejb.186.2023.10.11.23.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 23:51:13 -0700 (PDT)
Message-ID: <9edde757-9c3b-4730-be3b-0ef3a374ff71@gmail.com>
Date: Thu, 12 Oct 2023 08:51:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 =?UTF-8?Q?Martin_Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: fix rare issue with broken rx after link-down
 on RTL8125
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In very rare cases (I've seen two reports so far about different
RTL8125 chip versions) it seems the MAC locks up when link goes down
and requires a software reset to get revived.
Realtek doesn't publish hw errata information, therefore the root cause
is unknown. Realtek vendor drivers do a full hw re-initialization on
each link-up event, the slimmed-down variant here was reported to fix
the issue for the reporting user.
It's not fully clear which parts of the NIC are reset as part of the
software reset, therefore I can't rule out side effects.
Therefore apply the fix to net-next only. If no side effects are
reported, it can be submitted for stable later.

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Reported-by: Martin Kjær Jørgensen <me@lagy.org>
Link: https://lore.kernel.org/netdev/97ec2232-3257-316c-c3e7-a08192ce16a6@gmail.com/T/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc1..df0df4d09 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4596,7 +4596,11 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
 		pm_request_resume(d);
+		netif_wake_queue(tp->dev);
 	} else {
+		/* In few cases rx is broken after link-down otherwise */
+		if (rtl_is_8125(tp))
+			rtl_reset_work(tp);
 		pm_runtime_idle(d);
 	}
 
-- 
2.42.0


