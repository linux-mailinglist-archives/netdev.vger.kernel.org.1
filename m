Return-Path: <netdev+bounces-50269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E9C7F5289
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE42B20DBB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF55D902;
	Wed, 22 Nov 2023 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3ms0IWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C3218E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:25:09 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b063a6420dso7044039f.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700688308; x=1701293108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OK4yjGOQCQ1Of5MUW9eg8KxwFZFuyIMn1rGG5EPO/5s=;
        b=o3ms0IWuFUo90hh2SYWVNSjQjcAmVRiY71xmHKlwRjTNy62wmRBTrYtefHtQPahxTu
         RVjjJHbvW1/t/OG3PJ7VfQBKPYjqw6hSW8LRKaXyN2rSwWy7xFcnJ6SH2dGUPqjxLJfn
         dNYnFQNR2wbMrNtxbUikkhMXi6AvQW+yGFqFb5MEv6QJBioVVrSzuK8suCHbiFwj1QNo
         HoBMoDV8+DZhFOpwp14GZBS3KBOiUaZzvTpvqZF0+z7ah1piiEpfX310CDs8wdThLsgN
         Xjgl4Zt5jFUxvTX8ZDk9WcQdDZHx6sqYH/bx2iJoMwf8FTftQuQ+kfeHu2CbmwjNKGpQ
         ObLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700688308; x=1701293108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK4yjGOQCQ1Of5MUW9eg8KxwFZFuyIMn1rGG5EPO/5s=;
        b=JDAcEnzW32DhpXpnSUPpLeNNMGU+MvR+ITVJyJoGSFUpB+g4etdJTsWTtH3eBJhx/w
         NA3LiizbghuUzaWruXTQiv/w+1NbpYgzxn/PMpgYP6WBSbOLxI6HX52UAIkusRQes0f9
         Byn3dGOuMrhd/r9aBj6HJ4axWu4zpBdYcEAAn9eIniM7W8bX1fUDZpT2QvRnjUro9p1M
         6c5fbDYHddfrhJFfxa6QcCyJBKHczkHmYQrk9opWQMVOSsQfeRQjmmyN0KDE+UK04T+o
         YwlioMXQfCvVFcdfhvNBHMAoHYebmUVNB0WUaCJjRvmKoS2Zu3o8vWxhfQSrbLtcR+xa
         06vA==
X-Gm-Message-State: AOJu0Yzf7x3XBKir26e83AAGjqON5OYd12h3JdLyIDj4fh+3Yzbquva8
	Dh7nNOTBqAJ6vBojdvIPGLbvNQ==
X-Google-Smtp-Source: AGHT+IGfqWQCALQ2sbl53cSx59NR6o3lXjdDQ8ypxQCzXrbtIkKuIukuNRzmX3tbmVN1WRYaJX1GYQ==
X-Received: by 2002:a6b:e217:0:b0:785:d5d4:9f26 with SMTP id z23-20020a6be217000000b00785d5d49f26mr719339ioc.9.1700688308378;
        Wed, 22 Nov 2023 13:25:08 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i3-20020a6bf403000000b007a66df53f71sm3591812iog.38.2023.11.22.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:25:08 -0800 (PST)
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
Subject: [PATCH net] net: ipa: fix one GSI register field width
Date: Wed, 22 Nov 2023 15:25:04 -0600
Message-Id: <20231122212504.714276-1-elder@linaro.org>
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

Fixes: 627659d542c5 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alex Elder <elder@linaro.org>
---
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


