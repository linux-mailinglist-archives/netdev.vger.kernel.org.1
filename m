Return-Path: <netdev+bounces-48017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE67EC4EE
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8924C1F2733B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED028DCC;
	Wed, 15 Nov 2023 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ha8/mHik"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C928DBA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:31 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9BC5
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso698166a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057849; x=1700662649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZA5Ca1hKuCyZmXptnnWStM0rrf33hfZQmGrv/TQuI4=;
        b=Ha8/mHikjEFE4pDpr1yy1GDFa7UWcUkntKKPI9L/3Phw5NVzDtoNDT2TL8xWXY1jRb
         liB30aDInVlmXJJcoi+KXVn17t8DoaD90QBVH6XDLuZtpNrpdbtMutgRsiNzLOrOBdck
         mxFSC8Qvynp8FRHlHze0tyudg/ARr9IYnuLs+fZMUKipM78crKYM8ksnyXFBUAF0q+bA
         ebzuVBImARcWvtBAlmT0KGwQ9c2PjYJqOhfqIZBDlQ1pGj3XQHW3t1c0jYN0adASpBJF
         A+QduzjmLvxdazy9ewVVyL+GGRSjrXO4IQTj801XUCtQgvom2mVi8OXOdxLK59yOY29x
         bPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057849; x=1700662649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZA5Ca1hKuCyZmXptnnWStM0rrf33hfZQmGrv/TQuI4=;
        b=NCNyAxat+UK+qxpS16KMta+6a68/qFRC+xSdM0IeYM8B4E+ybdAO3axYzTgjG+w8a/
         ggbldDQDnLRFDAD/cP8VjR5JYUCn+1l2aIZ3hUBGpa7HHptqjkhABWRzSNEIj95ppYvf
         TDtyE1avAy80D6LUuV/754x3hMkmR6HAdvQrsQ0aP2phOO5g/DAzOi770Qa8P14RL5j0
         mfYX1c55xP762HxlK7Iizc3aG16raxwUiVzX2FOfuxXOVd9du6AU/eeRwz36jB4Gw0xT
         xN4OWOn1mYgtH+qZa3KKjRHPYpYG4kvPx4yxP67bRxuMgwlULq+n4ILjLFLcEkc1RDek
         VCUA==
X-Gm-Message-State: AOJu0YyhVoPOUQDnCaCZcVqWJVbz4sSj+01xHn/PM2NKoWCHMFpm9urz
	9ut+M+I3gU6n4m4+gA6A6UQBKqSivj4ULQPzd2E=
X-Google-Smtp-Source: AGHT+IFTRJuiXZrprtIWLghWRInGcKwC8f9lb4ozw0KSGfwMcGpwuKB0RW/p6y/9tWnTZCt3l5uDCw==
X-Received: by 2002:aa7:c6d7:0:b0:543:57dd:503 with SMTP id b23-20020aa7c6d7000000b0054357dd0503mr5177660eds.3.1700057848972;
        Wed, 15 Nov 2023 06:17:28 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 29-20020a508e5d000000b005412c0ba2f9sm6650947edx.13.2023.11.15.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:28 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next 1/8] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Wed, 15 Nov 2023 15:17:17 +0100
Message-ID: <20231115141724.411507-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115141724.411507-1-jiri@resnulli.us>
References: <20231115141724.411507-1-jiri@resnulli.us>
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
index 4fc7adb32663..4667ab3e9ff1 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -201,7 +201,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	WARN_ON(!devl_is_registered(devlink));
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -977,7 +977,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
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
2.41.0


