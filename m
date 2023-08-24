Return-Path: <netdev+bounces-30469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B37877FB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8799E280E7D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCA617FFE;
	Thu, 24 Aug 2023 18:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AB17FFA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552419BE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLlThC3R9OImoZ+MRsaHGOa2SVCnd5iJ51KhprNayB4=;
	b=WI7GAb87tP7mnRpBeTH91Znyjn1cl6S5pWbLfXl89I62rPWiJ1mi3ExG69AI3NceGiB2+B
	J+r/tGPsVW2Q3QaaR8Ud/ot4DDrI5hX42/1NXmIoPqsiOyTyGfF5DNCdFwayx+jvefuhME
	2HG/A67KcfqLKLhgQHXLJRAH4KLlS3U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-_Oj6L3MhPoOlVcCcQPgjYQ-1; Thu, 24 Aug 2023 14:33:04 -0400
X-MC-Unique: _Oj6L3MhPoOlVcCcQPgjYQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-649fac91500so11618866d6.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901984; x=1693506784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLlThC3R9OImoZ+MRsaHGOa2SVCnd5iJ51KhprNayB4=;
        b=dMDzojsLZ6XQOV14LAR8qnTPdIFwskyc4atyCP7LbO6vrFaV4Bva2kVjd9YgOLEJtI
         jmR0i08p1E2N4+XRDg1qTitMWuv/5ZMgPq1BneSqGWb8v9le4kxtJefKVykAIsa9zMWs
         eyk8LJ4BD66ZtMyLEKvfTBG01ylLj6lLWcNoErAAEf2Bv7AeqMBCHqK7CqhOmcfX35CP
         jVUqqD7C34ORnpk1EgxPkZTTNGS2H07vHftSz18SB7gJIYuw6SXmbi8WQha9D5QieMBd
         56saO3jzXdQSHt/fzkE4pjbxQb0OYtFeXQ8fHpdKlIVoj8N9XPEfru2e8ZDo8VqdgbSD
         X0Zg==
X-Gm-Message-State: AOJu0YwqoLINxOTjwacvFNbYiJ/MDdexs4o3CgqOog/tp9zgMylrwsPF
	uGa55eGe0TP5tjDujgMBuMco7kBZJ5V7pZeHn3duBj1y2D1HOTLbUvbqZfZa/fh2B57BQONmObo
	+nFij+MRxaD1hph2Y
X-Received: by 2002:a05:6214:ac9:b0:64b:926a:e7fc with SMTP id g9-20020a0562140ac900b0064b926ae7fcmr19233936qvi.21.1692901984166;
        Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/pC6Ozwx0rjBhGbBoQuQPKXeDRWWo7/yf47bHb2XuaionNEwEaUXyApPQsLo9pKSgtTNXGg==
X-Received: by 2002:a05:6214:ac9:b0:64b:926a:e7fc with SMTP id g9-20020a0562140ac900b0064b926ae7fcmr19233915qvi.21.1692901983920;
        Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:56 -0500
Subject: [PATCH net-next 5/7] net: stmmac: Correct addend typo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-5-e0b9f7c18b37@redhat.com>
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

added should be addend in this context.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 20ef068b3e6b..dfead0df6163 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -853,7 +853,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;
 
-	/* calculate default added value:
+	/* calculate default addend value:
 	 * formula is :
 	 * addend = (2^32)/freq_div_ratio;
 	 * where, freq_div_ratio = 1e9ns/sub_second_inc

-- 
2.41.0


