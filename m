Return-Path: <netdev+bounces-48019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B37EC4F0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACEC1C20975
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC92D042;
	Wed, 15 Nov 2023 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NlR0eLw+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00828DBA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:37 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67AEE6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:35 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c72e275d96so92242571fa.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057854; x=1700662654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPzmn/EmadmfWB1rVwrbIlsgYs3l2OVtocc7X4wxK5c=;
        b=NlR0eLw+5O7Paj0k+wMuCdGh6PoN08vDBgm6SHnk+wKNTRgHCizl++9WDr+duFp812
         0Utkr+SCjytBCGdQ12vqiCBt2wO7p8nMiuOnHRo3uv1cMOSgNJEEBnS85VaYDRKkYH0f
         MbIY+pXBfcmB5JsFmEErXpNqr8BzPAhvpVYS4CBT01D0IjYhfd1sP+0O1lPurUvcHNui
         PxXNspInfd3TCeAfWKxLQ46Y1rQCxQ/2AsshltOLHyzfIYeAr+Hwvh7iIe6JMZbq4LWv
         XyIRqw5jmMAtEJ6QWEmEZ9FAN/8uLQTQQztEnOklRr80P/GATLxv0vsc0QYMk6V70BOQ
         hNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057854; x=1700662654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPzmn/EmadmfWB1rVwrbIlsgYs3l2OVtocc7X4wxK5c=;
        b=T8nJhj5bhqpuBL5NfXBcFKlHg7bR7Fk0QRMLz8KzKuzjzski9Zlq9ab6XXjgSNOX3z
         uCAxrAQyyKrFGgMWDB4IrSlU1XvNRB9ppudEPRtcPQBN622vBrbp5wKOElcbedw3+2mh
         tHYWrMoLCxfEZQLh8rrwBz0CI7/TOVuJAU/AUrn/00qvl2xwu5CSVQQGaX+Y5tPwYqKo
         qMIbTHDH3ppzfC5XphChwgh4gJwoZmL4AH1C/1fNfCDKr7IUYAHxb5mntpcsEGKCPVRD
         OELqRCPWeBN/C0ivaWM+T3+XqWvDTi4jN0YEB/OasP2qPF75dUFzDx70B8JkSoRlsjhU
         +Prw==
X-Gm-Message-State: AOJu0YxKLIvbrajYqz+EKY6GfGxL8IMIZtb2iOaKdX16bITw0h0HNeYR
	EyeFUdf2QAXBhCuFvNhoVAS2VDGRR5gMxDLQj9A=
X-Google-Smtp-Source: AGHT+IHyUfn//33fU5fbFj3ClXCnGOtvPFaAmYPQ/rPpNs/9ycEKnwuaKrwk47CjjrzUq30Wpz+gyw==
X-Received: by 2002:a05:6512:4899:b0:509:8e13:48e0 with SMTP id eq25-20020a056512489900b005098e1348e0mr8376932lfb.37.1700057854193;
        Wed, 15 Nov 2023 06:17:34 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c505000000b00532eba07773sm6494032edq.25.2023.11.15.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:33 -0800 (PST)
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
Subject: [patch net-next 3/8] devlink: send notifications only if there are listeners
Date: Wed, 15 Nov 2023 15:17:19 +0100
Message-ID: <20231115141724.411507-4-jiri@resnulli.us>
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

Introduce devlink_nl_notify_need() helper and using it to check at the
beginning of notification functions to avoid overhead of composing
notification messages in case nobody listens.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
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
index 4667ab3e9ff1..582b5177f403 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -203,6 +203,9 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
 	WARN_ON(!devl_is_registered(devlink));
 
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return;
@@ -977,7 +980,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!devl_is_registered(devlink))
+	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 381b8e62d906..8b48a07eb7b7 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -172,6 +172,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
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
index 695df61f8ac2..93eae8b5d2d3 100644
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
index d74df09311a9..6bb6aee5d937 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	 * will replay the notifications if the params are added/removed
 	 * outside of the lifetime of the instance.
 	 */
-	if (!devl_is_registered(devlink))
+	if (!devlink_nl_notify_need(devlink) || !devl_is_registered(devlink))
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
index 396930324da4..f1402da66277 100644
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
2.41.0


