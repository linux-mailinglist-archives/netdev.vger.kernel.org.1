Return-Path: <netdev+bounces-50291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99767F545F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 00:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644D9281336
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346631DA39;
	Wed, 22 Nov 2023 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kno2ufhd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B36D8
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:17:12 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35749078a59so1033565ab.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700695032; x=1701299832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1zcqtTqhZ4Ynym9UE3ui8YaDfpYk7NuHJ7599B7McE=;
        b=Kno2ufhdPL3SIdPahYr7OYEUBQEzF0iEc1TVm7UAmED/0Zx/hq6OLpgntHsoRQoXyU
         WVzIu7wDQHyHUqJ8S3yWl0oZ88vIWWqOlNsGwkxvVhE0EeVX81kIDgu3njVGijwpEe1a
         4pjKasKmSxv643/8HqNj2Oy9ZAMi6aC5VEcnEVU7zgMJC7bSgBgTjCutxQAUx9FDYYzh
         ERnvobp2nvMRmkM5jtq1sgWX4tqWE4WjfrHhhcYQmLozt8mqWYyfLgzAuoDZKj21MoGg
         xeMPYwWEJtlGkoM6PZlUYLOqlUNmGSi0D/HOz+h+r5fQWLHpAP9KW9MWRxEAHiFo+6S4
         Yfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695032; x=1701299832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1zcqtTqhZ4Ynym9UE3ui8YaDfpYk7NuHJ7599B7McE=;
        b=MfSajduVTZqZmLM/YY8+k+AHb2gHeoQHn8pMbx2dJTSYCLNZkGjM6Y+75kcXTov5Ox
         q1Ush8JpeUmEv/U0tPuKXR7mx5M2BV7l5nnherEPwOzrJugyw9nGHfzt6qHVsHY3+Ceq
         Rg5H4H9ExC6trfQz5oPmTG35bGPZ2GUOhwZXQzgrPETTgO30K0P6v3mmHSIQ/XpNUVr6
         6yFjtzn76F875Dx6ZiLblZwnjAqGVakiC/bqo5OuEY7aLXcQCTncxg9JPxNBMb1guZhN
         eTMRXo2orMtJv1uvctYpnYrUi5dyrbQCWor4A5LTUkPtVzp0EQLc80DvCBc2A6x9yMgB
         lZYQ==
X-Gm-Message-State: AOJu0YwUwa4jFNA4JhbjI7mtxYstrqTrrtaNl7+5Cqw6i1Y1+NBsdBCc
	aYEiuvnukHTxAs7KLl2YNa5rAg==
X-Google-Smtp-Source: AGHT+IEONm3/0yle1mIzMytvh9Hjkg6xElFdJTDJzge/HIBKtNQ8pLGn46mQVQ+ZJ0HcXemIm4IMdw==
X-Received: by 2002:a05:6e02:1285:b0:359:ca5f:5103 with SMTP id y5-20020a056e02128500b00359ca5f5103mr3775252ilq.6.1700695032097;
        Wed, 22 Nov 2023 15:17:12 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id cb12-20020a056e02318c00b00359b09f0710sm195468ilb.6.2023.11.22.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:17:11 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ipa: fix one GSI register field width
Date: Wed, 22 Nov 2023 17:17:08 -0600
Message-Id: <20231122231708.896632-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The width of the R_LENGTH field of the EV_CH_E_CNTXT_1 GSI register
is 24 bits (not 20 bits) starting with IPA v5.0.  Fix this.

Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Fixed erroneous commit hash in the "Fixes" tag.

 drivers/net/ipa/reg/gsi_reg-v5.0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index d7b81a36d673b..145eb0bd096d6 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -78,7 +78,7 @@ REG_STRIDE_FIELDS(EV_CH_E_CNTXT_0, ev_ch_e_cntxt_0,
 		  0x0001c000 + 0x12000 * GSI_EE_AP, 0x80);
 
 static const u32 reg_ev_ch_e_cntxt_1_fmask[] = {
-	[R_LENGTH]					= GENMASK(19, 0),
+	[R_LENGTH]					= GENMASK(23, 0),
 };
 
 REG_STRIDE_FIELDS(EV_CH_E_CNTXT_1, ev_ch_e_cntxt_1,
-- 
2.34.1


