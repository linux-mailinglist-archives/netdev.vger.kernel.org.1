Return-Path: <netdev+bounces-40688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282267C8568
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3CFB20B03
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2415E9E;
	Fri, 13 Oct 2023 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wMUTTtCi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539815E85
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:43 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B68BF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so20803365e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199040; x=1697803840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH6Db1nTJ41ItQd67j8/vw2ujOmqrcYuZLY5GzdIGUY=;
        b=wMUTTtCi/r/7b9O/cjhuyfFGZTAeykcScI7wGdkSz3HboPcOg2nFZIGlYtAB/cZGMC
         /cY1qZv7xF1toQAiGK9t/C0hugt2DUwvKAEGqzlpEbUKn7me37HvYdOfP4o+kDuUjQ8d
         Qod3A8giDmZu5eEZUFFKdc5hF3EleDE6EhfdXWORp0F8B3M04N1PU1DCTWx0f484xENN
         Iexr30urWAflSO/7yUZ1xQYU9RJD6rRdxaYYYerjRtUP5AAQCcSqA4a8eJkxaFgecxbx
         UzTRZAkatd7+B5IikyT7bPGobSKOYh1QGxlUa6dwD5MwUgu7mBDCVY7YHfaER6MFFK+B
         DGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199040; x=1697803840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH6Db1nTJ41ItQd67j8/vw2ujOmqrcYuZLY5GzdIGUY=;
        b=LTvJcfTm00hdbgZR5a5blbyoFJv+XIgf9JPhcIiFnkI3WnnIYFcDq3J8l/Tx7zstyw
         yzRtYAZe6vN0T0R/e8SlrXp4poN9N9XbmfXliGOlSpO29F0BPXISIllY2DewCcsIbhfA
         RR393KnZy4iazS4EfiaxZMbjAoKOA1ZFIL5YD0JCtWKD7+lJrJudTuMAO6usX6HADsBQ
         rBBuAcuZmz0aK/Kbv6qw4oSzpUgZVw2xcxtqdd1epX596lk1OaD0+ONE+o6e9odseFrU
         gnHEXOyy2e5/ee0aA4icM0hnS6QhsDCqT194S6zJr4Y3PJe09k9dNikw0t5WUmtI/EZn
         fL7Q==
X-Gm-Message-State: AOJu0Yz7HcUJgrV7MK4n4FrDEONpodwHCBUKicD7JPtRwTQa7zhffG+1
	so7Rji2LDhPCv/or8f+q4QLcB6yds9R566//Okw=
X-Google-Smtp-Source: AGHT+IEAh413Wf/KR7aYVAOtCpGOq74KFZOF8x4Hlzy5M1EZHPVcMOw0837gz7xkbDrD9BF/rWtE3g==
X-Received: by 2002:a05:600c:ac7:b0:403:b6bc:d90d with SMTP id c7-20020a05600c0ac700b00403b6bcd90dmr23844861wmr.20.1697199040310;
        Fri, 13 Oct 2023 05:10:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bcbc8000000b00405c7591b09sm2394698wmi.35.2023.10.13.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:39 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 5/7] Documentation: devlink: add nested instance section
Date: Fri, 13 Oct 2023 14:10:27 +0200
Message-ID: <20231013121029.353351-6-jiri@resnulli.us>
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

Add a part talking about nested devlink instances describing
the helpers and locking ordering.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 Documentation/networking/devlink/index.rst | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index b49749e2b9a6..52e52a1b603d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -18,6 +18,30 @@ netlink commands.
 
 Drivers are encouraged to use the devlink instance lock for their own needs.
 
+Nested instances
+----------------
+
+Some objects, like linecards or port functions, could have another
+devlink instances created underneath. In that case, drivers should make
+sure to respect following rules:
+
+ - Lock ordering should be maintained. If driver needs to take instance
+   lock of both nested and parent instances at the same time, devlink
+   instance lock of the parent instance should be taken first, only then
+   instance lock of the nested instance could be taken.
+ - Driver should use object-specific helpers to setup the
+   nested relationship:
+
+   - ``devl_nested_devlink_set()`` - called to setup devlink -> nested
+     devlink relationship (could be user for multiple nested instances.
+   - ``devl_port_fn_devlink_set()`` - called to setup port function ->
+     nested devlink relationship.
+   - ``devlink_linecard_nested_dl_set()`` - called to setup linecard ->
+     nested devlink relationship.
+
+The nested devlink info is exposed to the userspace over object-specific
+attributes of devlink netlink.
+
 Interface documentation
 -----------------------
 
-- 
2.41.0


