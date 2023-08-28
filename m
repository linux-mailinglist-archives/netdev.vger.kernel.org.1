Return-Path: <netdev+bounces-30995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC878A5B1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26544280D31
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D46119;
	Mon, 28 Aug 2023 06:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B016117
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:48 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768F1BC
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40078c4855fso26542475e9.3
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203442; x=1693808242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsg1Dl28Trm7HwC5JE4oqtOd3hQO3PKwmc1tCz45ibM=;
        b=0bTG5TlHylQ3ELTyEPiYQqGRi3HrrgekjWp4cWe3rnQCtcjhZoU+pbeF+7Vr39ldIq
         CNnh3EmzoWaqAG77HDD4XXQWulX4wDixUyQB5naRnO6dqfhFRd7t/w8Zv5h+KR5IaKxp
         LcM9JwMt1DEQNAvCMoHw/y4B3G/Si4G5trLjZD0pZxm/DG+0ih87MoMXCsIrDiYrHeaz
         jswfaakYkEVxidNi7TyKz49vcUXeXQ7ak1y/fa1bJNKXPY4Bsd7ZjC8XZNM5gVnSfCS/
         2xAaRRM9cuDOGNYF7Lw9Zt5nPoyAMHSN3AIxWYnGwWB7vYKmpclVPLNkfO/+BGvOEe6D
         9ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203442; x=1693808242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsg1Dl28Trm7HwC5JE4oqtOd3hQO3PKwmc1tCz45ibM=;
        b=YtI0Yuf9thzWDWud2+zLwmC/INsAeaNMggWv3Guo1Dsgk4dVHXHoqNb0Tdcii2K8Q9
         kF0h2KoL4rOcIRQmcvC4uO50F3e5/wcMdR66icOiFMQFQwK0TMH6xCg1bDHIFtRhLbpF
         y6qAsdb9+tAbIf8eaQBdtWGgZGkRgWAfUkp3BPhmL8z1OxQzg2npy/WZjXLlnq+aSpRU
         9CtZKJUKAXHmQiAH69N1zcHtJUez/EVazK0FVc/emhnIGIgt8cALR9mQwJf22SLZGKsV
         I73c6694nXgxpWipgTqQJHTx0wdZL2UFP8OXU22SKe3FlRSvhnKrKQpTJlIDsakp3v2I
         BL/Q==
X-Gm-Message-State: AOJu0YwSU39UeKo5cGhoy/4MdHdxOE0QZwGnXz51aGxZMCZ/jB24z+XI
	9hqwTxbYUiOeWrJhQI2flxziwy6FdyyJw3p6dME7ig==
X-Google-Smtp-Source: AGHT+IHSY8DE0E6REO5Qlxdi9yAHIn3SnCe5C/IMAnqLwGCFVfEYSjuRgDUKj6n6Q3lk6ycDkXhs3w==
X-Received: by 2002:a05:600c:2217:b0:401:b53e:6c3b with SMTP id z23-20020a05600c221700b00401b53e6c3bmr5803027wml.6.1693203442757;
        Sun, 27 Aug 2023 23:17:22 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003fee8502999sm12754190wmc.18.2023.08.27.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 13/15] devlink: move tracepoint definitions into core.c
Date: Mon, 28 Aug 2023 08:16:55 +0200
Message-ID: <20230828061657.300667-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828061657.300667-1-jiri@resnulli.us>
References: <20230828061657.300667-1-jiri@resnulli.us>
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

Move remaining tracepoint definitions to most suitable file core.c.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/core.c     | 6 ++++++
 net/devlink/leftover.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index c23ebabadc52..6cec4afb01fb 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -5,9 +5,15 @@
  */
 
 #include <net/genetlink.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/devlink.h>
 
 #include "devl_internal.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
+EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
+EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
+
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
 void *devlink_priv(struct devlink *devlink)
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 98ccb3a8393d..a477cdbab940 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -28,15 +28,9 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/devlink.h>
-#define CREATE_TRACE_POINTS
-#include <trace/events/devlink.h>
 
 #include "devl_internal.h"
 
-EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwmsg);
-EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_hwerr);
-EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
-
 const struct genl_small_ops devlink_nl_small_ops[40] = {
 	{
 		.cmd = DEVLINK_CMD_PORT_SET,
-- 
2.41.0


