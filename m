Return-Path: <netdev+bounces-42270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B46297CDF66
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4496DB212DF
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5D437140;
	Wed, 18 Oct 2023 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziRE6AGi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD386374F5
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:21:37 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4F9000
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:20:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d849cc152so6175382f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697638816; x=1698243616; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMwfTW5sLakF4hd5w4/oY7o5mpcFlkM3nBeiv13a35Y=;
        b=ziRE6AGiXzQE+pPOFRVDq9a0lYmPHXfkG7//tc488N1x6hhebXjWusjXX8zdjGfi1a
         B1UPITjiwVyIpPrC4wm04cp7aHpUqwMKn1RNSZSf5wYSg16gJw1zNL+y1u1ZPOzR2l+d
         msmPnYIbe+8QwBiSnmt8oOtN0bJ11uYKPOJKinCbvOKP8ZMUAprre30cPicM4Hz+D8a9
         EWgo+IOXkZcqGtZEiS0NxHwTncjO6QhJ+UgVtFtjSEflgfh77+/9uFVWNJoD+4tcBfxX
         ZXRjUiCpVP5oJo0wP88MqI/nWtL0nbRfGJqpaFIyNcO/KQew50LBCHi0v4kaic/yoj/j
         3O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638816; x=1698243616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMwfTW5sLakF4hd5w4/oY7o5mpcFlkM3nBeiv13a35Y=;
        b=PQXYPHMGMT43DU9kywyzQHsAZyauSVBbIxjIfYJ1N9yn/nuiuuCvPsbnuN9wumFmQV
         ft/w+mYNxP1RlsiSLfs76AmB+MQI+FDqFNGYyIGF1XqRVqKCq805HgfgOobcPY/YccTf
         rHl6+kxxsSYwqVvmi3v+kUz2nVfWJny8UqY6eRULk0ZdUN5l6YJW2NKNltSphZtATwY9
         1fcI9TTxTPN6Sd17FpiUkmMlY8uVJ9EFyy6v5MiKoUBmnuhuZVzPWlriq1nX6Qq27nhw
         KBNcqFQkWVCE6lswzcfwEt9X0kZSlxLDQhqiCfuJ2Jwi4K99StWEUmT1Euwji777SyIr
         Szwg==
X-Gm-Message-State: AOJu0Yxu+Uaz9WqAHDvj0aeJ21BbGJ1fLj9GcNssRe+Beokzj/pdUM60
	yE0WgOHYIgnfh02KE86G7r2B+XN62JRazRTqoRM=
X-Google-Smtp-Source: AGHT+IFnFsKqE7pLQfOFoMoo7c2gVgpY0VQGFq1MNOxPSVPFDy/2kfATaJYsqON657eh+It9ATQN/Q==
X-Received: by 2002:a5d:568b:0:b0:317:393f:8633 with SMTP id f11-20020a5d568b000000b00317393f8633mr4087284wrv.58.1697638815705;
        Wed, 18 Oct 2023 07:20:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p14-20020adfcc8e000000b0032db1d741a6sm2222382wrj.99.2023.10.18.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:20:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 17:20:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ptp: prevent string overflow
Message-ID: <d4b1a995-a0cb-4125-aa1d-5fd5044aba1d@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ida_alloc_max() function can return up to INT_MAX so this buffer is
not large enough.  Also use snprintf() for extra safety.

Fixes: 403376ddb422 ("ptp: add debugfs interface to see applied channel masks")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ptp/ptp_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 2e801cd33220..3d1b0a97301c 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -220,7 +220,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	struct ptp_clock *ptp;
 	struct timestamp_event_queue *queue = NULL;
 	int err = 0, index, major = MAJOR(ptp_devt);
-	char debugfsname[8];
+	char debugfsname[16];
 	size_t size;
 
 	if (info->n_alarm > PTP_MAX_ALARMS)
@@ -343,7 +343,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	}
 
 	/* Debugfs initialization */
-	sprintf(debugfsname, "ptp%d", ptp->index);
+	snprintf(debugfsname, sizeof(debugfsname), "ptp%d", ptp->index);
 	ptp->debugfs_root = debugfs_create_dir(debugfsname, NULL);
 
 	return ptp;
-- 
2.42.0


