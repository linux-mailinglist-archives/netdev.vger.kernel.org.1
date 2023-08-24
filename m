Return-Path: <netdev+bounces-30468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32577877F8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6B01C20EA8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBBA17AB4;
	Thu, 24 Aug 2023 18:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BF174E3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677CB1BEC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQSvh9slhSAVrK9RWa2tfsuNvxEUSp0MXiAFYeXPuAw=;
	b=XJfc4y6N2faFmurv6tTIlm1ifXhNdcbkV5RcYj9ST7tFrp7hrZakhqKF9te/G2q/psf3ds
	KOcTdHPhDXmfSuaSws3mxTP7cmsxArBiwjd2x4iKwZNPr7+Rg/zWnZTKP28hEMCKXogyaI
	EY+Or76eHK0L7xAWRvgUtnMFBSwZe8w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-BZmBse4DOk228aOzJL7VeQ-1; Thu, 24 Aug 2023 14:33:03 -0400
X-MC-Unique: BZmBse4DOk228aOzJL7VeQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63faa1e03a8so1450276d6.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901982; x=1693506782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQSvh9slhSAVrK9RWa2tfsuNvxEUSp0MXiAFYeXPuAw=;
        b=AQS4LGpSfxFbgQ6QNehOp2Fou9zd7/dXQs2Xx7dZKwFtmRNl01Qb0v9O1C3UCi8+h+
         ucFxiZWk2FIPMeNfkK8Yg7q59rcGgAGzGd1o5CSHb/4YaAm4LYWU8rHdb77Iq5VTzmFI
         iKzkm8Y9X1TYWm1+9/uwS1kLEeDi0x8W/bLey3zHOfNsMddkNLyB38wgp1jSmOt6QGID
         drxWoSiKFCdOqnZZKYROt1u7pSNVLjU6otP/SHuR87NhYzGDGLklpltN6AVFW5XBL7HC
         ctKjZ3Sj20aIL5PkSL6hBtXgba53Bq9Zf0bN6tZG40grtVYvSxYW4aWhuTeGutdOQj3k
         5QJQ==
X-Gm-Message-State: AOJu0Yzkw9UG+GQftJugKo6rbYeImnct6So2o4QWLVB1XyE0ISuEuItq
	g2XduaY7Deng9UGXKnw30ADwmeDZhYRbxS6JHnqsq2sLjiNdQLmzUHWhbvD29MhiAr2zwFAGkOn
	LH3pqWpemFUik7PCT
X-Received: by 2002:a0c:a99b:0:b0:63a:5ebc:6e7a with SMTP id a27-20020a0ca99b000000b0063a5ebc6e7amr15574212qvb.31.1692901982708;
        Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj5ZJm6hpe0krNTRRf2s5iyapXzQ1FpiG0EpY/VpNEjLrDgHOUR63fuY3Iw6CLeMnPKpjAVQ==
X-Received: by 2002:a0c:a99b:0:b0:63a:5ebc:6e7a with SMTP id a27-20020a0ca99b000000b0063a5ebc6e7amr15574200qvb.31.1692901982497;
        Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 24 Aug 2023 13:32:55 -0500
Subject: [PATCH net-next 4/7] net: stmmac: Remove a pointless cast
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-4-e0b9f7c18b37@redhat.com>
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

The type is already u64, there's no reason to cast it again.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f0e585e6ef76..20ef068b3e6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -859,7 +859,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	 * where, freq_div_ratio = 1e9ns/sub_second_inc
 	 */
 	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
-	temp = (u64)(temp << 32);
+	temp = temp << 32;
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
 	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
 

-- 
2.41.0


