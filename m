Return-Path: <netdev+bounces-58219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DD8158F9
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6083328599E
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DC28E02;
	Sat, 16 Dec 2023 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jTgMcHq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD819BA5
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso15135445e9.1
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729805; x=1703334605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33J8BP2HLxzySsghbviJPGk4M7islA6m5mnPAfoHhcc=;
        b=jTgMcHq5ab1oiMEOcRELLrJ9FnxoNNXhC8wKnkCa2nLuOZs+M9JVI+k95YXYkgWr4y
         15LhoeVYWAyRZ8WwnMXMYYUQowWKE1cq7dDXOMJlXmX5Y/9+lX6bHgLooFQLmYM9ePG8
         2VgiEBA0XhupFUAPtEff1twAHw+5euU2nMwe53XP9M44BtgsiYKqeSej4RHKGb5WKtiv
         jbrzfxmuBYvLqCQOT5jXN9ismTwbCOYY7/ZRlFMfClZduDk3/mf9vIqa4edaMeYlXMPl
         AgEfP8IfIJN64m/yIq/La1gIwJ1vjhKQmeCXQuAD2NaohLQpbBsgPAPg/IKUzNLWpak9
         ulfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729805; x=1703334605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33J8BP2HLxzySsghbviJPGk4M7islA6m5mnPAfoHhcc=;
        b=ocjvWUi8TbVP+QzARAes3gUc8yTR2ZW+bpq57hOj6AQ3JJhoagWJ6VwVAIVbi7ScBo
         +2i4WM4c1QiKTpK8jXAK5A5qfeQsxzx6ZbIo8/Mn65MS4yHAEGSZgGKYp3/SAsBrxz6l
         d/xAL7enLt2EBc5Y3+rAKTG02pOutb36WfOHU6j5YspvUmUwCKW6gyRcA0dP0tkjQ6MI
         wP/c0rom7B78YYhyqycRFcgBFCOXpDBi09hadux3ph9C3z4I1oVetaB/sMqJRPjSnxhs
         UPzDv+Q2+hKSjxHdgFiFgL0AhZib33w/VFI2UV8M2krz/6YYnCfpXcgYq0BGJ9RzPwD8
         JEzQ==
X-Gm-Message-State: AOJu0YzwyJOPvFSTZTnAsDxiL5lN+/602FhIzKcsItqgxhssYIPRXNb+
	qAVa6nS1KU65q2sJTvxEp0q8k4gQBe8EoqOfXIw=
X-Google-Smtp-Source: AGHT+IGYZTswU2HK06vCp3j/IB6r4PRrmxZ0FF+jhOPGKjOsCkhI72bT+70K2Wqg3v29Vh5g4X3uAA==
X-Received: by 2002:a05:600c:3ca2:b0:40c:50d5:f7a6 with SMTP id bg34-20020a05600c3ca200b0040c50d5f7a6mr5245859wmb.121.1702729804401;
        Sat, 16 Dec 2023 04:30:04 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a1cc1be1158sm11829412ejc.165.2023.12.16.04.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:03 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v8 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Sat, 16 Dec 2023 13:29:53 +0100
Message-ID: <20231216123001.1293639-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of checking the xarray mark directly using xa_get_mark() helper
use devl_is_registered() helper which wraps it up. Note that there are
couple more users of xa_get_mark() left which are going to be handled
by the next patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c  | 4 ++--
 net/devlink/rate.c | 2 +-
 net/devlink/trap.c | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 918a0395b03e..3fe93c8a9fe2 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -202,7 +202,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	WARN_ON(!devl_is_registered(devlink));
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -999,7 +999,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 94b289b93ff2..e2190cf22beb 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -146,7 +146,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index c26313e7ca08..908085e2c990 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1173,7 +1173,8 @@ devlink_trap_group_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1234,7 +1235,8 @@ static void devlink_trap_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1710,7 +1712,8 @@ devlink_trap_policer_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.43.0


