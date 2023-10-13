Return-Path: <netdev+bounces-40686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926C7C8566
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432DB28270D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2A14281;
	Fri, 13 Oct 2023 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DvPAIB28"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8514A8A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:40 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB54A9
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso21433045e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199037; x=1697803837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX3CFWk+KxItnDnCryM3nsfjHIR+y9KEaBmefgYyiZE=;
        b=DvPAIB28VIcneUPUJeI/0XWD/f1y9a32MgwhRybYMBDJ6xLeXNP8IcTnmeTSoWglad
         Pzfk4J6iixeu51Efsbl6WeGD7DBVs9twFmK6RAPfQrtioxqj1laxeiQkFM4ALrumI/v+
         4CRTUqBah5WweceJe2hR7vL7OBaDXI+2tfw8Ej/tRTl/3GxFBjdqLHWT9GJWDLE3ZwL5
         u8OrOvhnfYSL9luOO67mDfp2M/PPiWEimUq8CrWTGAo55oeKw2nqTbAnFquH+X22xNTP
         KNkYq3mllsUQDuwyMJ9bPD4GPRDEm4eJ/VOIZx2+L/x+vPSE0zwUAR49O57rVBZJadar
         b2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199037; x=1697803837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX3CFWk+KxItnDnCryM3nsfjHIR+y9KEaBmefgYyiZE=;
        b=KrEY0V1UkbcE18zZ568BRNsDPkHsB/k9lWKqYcrJTNIulDKfIY/L4OK2VcHeHe4Kd0
         AFFJ5dEkrof3kXFKx3Tw4ERn5nyE9TDrQPv+aKP66hqJVnx6iHMUl9PulSMzkQrctjX3
         Xa0H9fH8hZ8g2LyFE+JEo94LIDC+cFV5QqHnDNiGQYHB3sGiEUsiWZu1NDb7hBC7W3WK
         Cwlmt6LgUQrpXKcECDORGITpKgCOD+0+aPT9FVXbXJILY3GpA+WEefMiFRW+pySuiUoY
         xN515QCBqfDt6m58HtN66rv5/sZA1AAPXzL4qNRRKD71g4QTEhtuktZjp4q2HwunNrha
         3B2g==
X-Gm-Message-State: AOJu0Ywlwkkaja39vpph7WvcSaGoWj6k/JrEjkRs2PQwGMkUYQR0MxIL
	L+55rYcRjB4fXRgDu8EthicEeRy3BAYJ2Z5I29I=
X-Google-Smtp-Source: AGHT+IEZGzLjQVBxxCp2tA0FY4tCb+vYHpR0zI5Fow301vOCBJJvzwlXuLx8eA+wHF1EW1lvjv1rLw==
X-Received: by 2002:a05:6000:118c:b0:32d:9787:53bc with SMTP id g12-20020a056000118c00b0032d978753bcmr2481862wrx.62.1697199036921;
        Fri, 13 Oct 2023 05:10:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm20572360wrw.103.2023.10.13.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:36 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 3/7] devlink: take device reference for devlink object
Date: Fri, 13 Oct 2023 14:10:25 +0200
Message-ID: <20231013121029.353351-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
References: <20231013121029.353351-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In preparation to allow to access device pointer without devlink
instance lock held, make sure the device pointer is usable until
devlink_release() is called.

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- moved the device reference related bits from "devlink: don't take
  instance lock for nested handle put"
---
 net/devlink/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index bcbbb952569f..c47c9e6c744f 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -310,6 +310,7 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
+	put_device(devlink->dev);
 	kfree(devlink);
 }
 
@@ -425,7 +426,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = dev;
+	devlink->dev = get_device(dev);
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
-- 
2.41.0


