Return-Path: <netdev+bounces-56342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8580E8E8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861A4B20E48
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCC75C063;
	Tue, 12 Dec 2023 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PuuAeGLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F667A6
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1f8510883aso386233466b.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376263; x=1702981063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbWsBPpBXJN/mSeDiH7uhOyWgGTchnVsa58K3LTnlgY=;
        b=PuuAeGLrJNvZ/FT/QP6XH1it/KUW28fDCqlw7OGRPyyZeW2/KX2QGNcgrwfSal1AV1
         FI2RFJ8JoPSUt1rrutzkXTVZBQ2A2UjR30WNgo3YB6HFp8gG/7lQohCSYLb+51skwFtF
         +0Ru8f2wk2QOj4eeJ/ht6rJcHWVYx3iwr+MndE5Da1SM3aitbUMGBBdyJHnNRKGrIVz8
         V01AQplg+ae1e/9+oY8Ha1i5l7fZ4eqobdRzkwBkq950Nh6C8db9qhuiE2Z3MjGneH2N
         j6Oq6tF6xTMQlTcRIIY4BWo5yG3GgfW4/2vfppkWpm4KSaw6hGnjguflyHKzgpLnflJH
         On0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376263; x=1702981063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbWsBPpBXJN/mSeDiH7uhOyWgGTchnVsa58K3LTnlgY=;
        b=ApQBMbJic1yeFvp2QorbMb9ezMZUrD7jSHJUiwgsxPym2MYWWQ0U3dLPrkZk8lJ1V+
         XTx7xtDp6W9ARDrt1axCV26FOPw4E7IaJ7zdAMlpIDKMiek/lfbkJM/OMfU6ooqBxk1Z
         COutWHGxl9f4UlXbJKZa6IIxWKdrEpYvyCBIjKHSAnSJNT83K5mTVBD79t+xLJ7zJXE5
         OfXTedI2R6Mn+gjsxjFPub2iNkSSw4Yr0bVRqtAKMk97SukvbszlsqIdlNmVpTkuGiSK
         r0kRBwjq/cqiesZs1nZsXmfsNuJBfWHqee3wVg5AtmGc3Uw/xsI4cqEIt1xeplqzQQVU
         Mh3w==
X-Gm-Message-State: AOJu0Yy0XTsFb7ucNIuBFli1zAILKSMvUApfy0fKDdmBGduW6rLqsaJi
	Q4ZYk/SAsDYWxEeFxeqwyIx+J/Gf5hmZ6XOQx3E=
X-Google-Smtp-Source: AGHT+IG9Tjh0NsdJjSd3ziOkEHQ5sAilLBVk2qZRb2oIxq4kcmW/OzJ7kRJ7o2YMSAEj7EG+7VHatw==
X-Received: by 2002:a17:907:31cd:b0:a1c:9f65:a414 with SMTP id xf13-20020a17090731cd00b00a1c9f65a414mr1772737ejb.152.1702376262801;
        Tue, 12 Dec 2023 02:17:42 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id tn9-20020a170907c40900b00a1f7ab65d3fsm4949107ejc.131.2023.12.12.02.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:42 -0800 (PST)
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
Subject: [patch net-next v6 3/9] devlink: send notifications only if there are listeners
Date: Tue, 12 Dec 2023 11:17:30 +0100
Message-ID: <20231212101736.1112671-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212101736.1112671-1-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce devlink_nl_notify_need() helper and using it to check at the
beginning of notification functions to avoid overhead of composing
notification messages in case nobody listens.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v4->v5:
- swapped order in test in param.c
---
 net/devlink/dev.c           | 5 ++++-
 net/devlink/devl_internal.h | 6 ++++++
 net/devlink/health.c        | 3 +++
 net/devlink/linecard.c      | 2 +-
 net/devlink/param.c         | 2 +-
 net/devlink/port.c          | 2 +-
 net/devlink/rate.c          | 2 +-
 net/devlink/region.c        | 2 +-
 net/devlink/trap.c          | 6 +++---
 9 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 3fe93c8a9fe2..63fe3e02c928 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -204,6 +204,9 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
 	WARN_ON(!devl_is_registered(devlink));
 
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
@@ -999,7 +1002,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 59ae4761d10a..510990de094e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -185,6 +185,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype);
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
 
+static inline bool devlink_nl_notify_need(struct devlink *devlink)
+{
+	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
+				  DEVLINK_MCGRP_CONFIG);
+}
+
 /* Notify */
 void devlink_notify_register(struct devlink *devlink);
 void devlink_notify_unregister(struct devlink *devlink);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 71ae121dc739..0795dcf22ca8 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 	ASSERT_DEVLINK_REGISTERED(devlink);
 
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 9d080ac1734b..45b36975ee6f 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
 		cmd != DEVLINK_CMD_LINECARD_DEL);
 
-	if (!__devl_is_registered(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/param.c b/net/devlink/param.c
index d74df09311a9..7516b524ffb7 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	 * will replay the notifications if the params are added/removed
 	 * outside of the lifetime of the instance.
 	 */
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index f229a8699214..32f4d0331e63 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -512,7 +512,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 
 	WARN_ON(cmd != DEVLINK_CMD_PORT_NEW && cmd != DEVLINK_CMD_PORT_DEL);
 
-	if (!__devl_is_registered(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index e2190cf22beb..0371a2dd3e0a 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -146,7 +146,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/region.c b/net/devlink/region.c
index b65181aa269a..bf61312f64bd 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -235,7 +235,7 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 
 	WARN_ON(cmd != DEVLINK_CMD_REGION_NEW && cmd != DEVLINK_CMD_REGION_DEL);
 
-	if (!__devl_is_registered(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = devlink_nl_region_notify_build(region, snapshot, cmd, 0, 0);
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 908085e2c990..3ca1ca7e2e64 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1174,7 +1174,7 @@ devlink_trap_group_notify(struct devlink *devlink,
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1236,7 +1236,7 @@ static void devlink_trap_notify(struct devlink *devlink,
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1713,7 +1713,7 @@ devlink_trap_policer_notify(struct devlink *devlink,
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.43.0


