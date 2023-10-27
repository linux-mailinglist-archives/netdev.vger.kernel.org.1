Return-Path: <netdev+bounces-44709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA27D94EB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20D02823AD
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE418649;
	Fri, 27 Oct 2023 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZE6Ixxrw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3318049
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:18 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43687194
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2919643a12.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401654; x=1699006454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/iH+OcilrDlqznkxaiZFecCShpMj3BOZHOw3HA1hkM=;
        b=ZE6IxxrwL4vFhFzcBh+cxu3rR3X9OyFFcRpZPV3N4SHaJY51cazmbFXqExKqsl553p
         J+2ivV8j+pXJ/oNGswgMnV+0mnsM9RpwYYxO8lXc4z/HNVE/3KjQmj1zjWnp7Mb/b5rT
         MxtgF//IccJBzOpYOFpCzSJn7pYm65IJffA5mF1tAc7Js2hVuCLCK6ado1IB3797UD+Q
         z59EL9l+OvAdVN4Qil6hAXCTPss6479PZUsvsDbOBak0iqKHlQaMlsB849iB6FA6tQXu
         GJtqF4diFeTrC/g94TqFg1qIl4vLTvps+9Hp10I7OznRO3zwcZBOt1Lmny/3b0NSOLK/
         2V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401654; x=1699006454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/iH+OcilrDlqznkxaiZFecCShpMj3BOZHOw3HA1hkM=;
        b=SfuozUH0OEDen5+Z1WqOl3Q1+fgYENIiLJbtXfmlAV1LqbkxIg1TXu8TdYzMcYex1c
         fuyT3p4QHhz7jRnXCEKmfkvdZvAopeVXbi3huboJR1Le5hmJr1rrBOzwMcds1tbfgqWC
         wPySfdCJpLT/8mWbB6ucKTKUG25MfLT/rjXYcOdoHB/fIKki6FO23g4NemUodvzLSo8g
         11q54Y5KNeGZ7Sv0ZE/rby+U/tV2l+3lmX/Phwkzr99RfnDZVCshGzD4wZxFhFkcdIlH
         nHulRRk294Jbjvv5pGq6wxNA2RWS+Vb7Pvz8nOIvYbcLe1eGC1quTkDVp9MHDTFJ7pAs
         d7Fw==
X-Gm-Message-State: AOJu0YxH7PDs+J0UHlCkbZkLCFshiZpGRBoPdEQwMCzGvQ4U0RoLjMvq
	yea46UqVQ3NVbgDPhqI0XHbswTxi2/RwFPvvrhUhwg==
X-Google-Smtp-Source: AGHT+IHGCGA6XN4wVXikAvl1hqDGROUKAduEMQImPHQqauOkxbGfFrQ7EDWufY4Fki0Uo+IAITAxGw==
X-Received: by 2002:aa7:d4d3:0:b0:540:3286:d2e8 with SMTP id t19-20020aa7d4d3000000b005403286d2e8mr1877809edr.18.1698401654708;
        Fri, 27 Oct 2023 03:14:14 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u30-20020a50a41e000000b0052febc781bfsm1034163edb.36.2023.10.27.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 5/7] devlink: introduce support for netns id for nested handle
Date: Fri, 27 Oct 2023 12:14:01 +0200
Message-ID: <20231027101403.958745-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027101403.958745-1-jiri@resnulli.us>
References: <20231027101403.958745-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Nested handle may contain DEVLINK_ATTR_NETNS_ID attribute that indicates
the network namespace where the nested devlink instance resides. Process
this converting to netns name if possible and print to user.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- moved netns_name_by_id() into lib/namespace.c
- s/netns_name_by_id/netns_name_from_id/
- rebased on top of new patch "devlink: extend pr_out_nested_handle() to
  print object"
v1->v2:
- use previously introduced netns_netnsid_from_name() instead of code
  duplication for the same function.
- s/nesns_name_by_id_func/netns_name_by_id_func/
---
 devlink/devlink.c   | 23 ++++++++++++++++++++++-
 include/namespace.h |  1 +
 lib/namespace.c     | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f06f3069e80a..f276026b9ba7 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -24,6 +24,7 @@
 #include <linux/genetlink.h>
 #include <linux/devlink.h>
 #include <linux/netlink.h>
+#include <linux/net_namespace.h>
 #include <libmnl/libmnl.h>
 #include <netinet/ether.h>
 #include <sys/select.h>
@@ -722,6 +723,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_NESTED_DEVLINK] = MNL_TYPE_NESTED,
 	[DEVLINK_ATTR_SELFTESTS] = MNL_TYPE_NESTED,
+	[DEVLINK_ATTR_NETNS_ID] = MNL_TYPE_U32,
 };
 
 static const enum mnl_attr_data_type
@@ -2866,7 +2868,26 @@ static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
 		return;
 	}
 
-	__pr_out_handle_start(dl, tb, false, false);
+	__pr_out_handle_start(dl, tb, tb[DEVLINK_ATTR_NETNS_ID], false);
+	if (tb[DEVLINK_ATTR_NETNS_ID]) {
+		int32_t id = mnl_attr_get_u32(tb[DEVLINK_ATTR_NETNS_ID]);
+
+		if (id >= 0) {
+			char *name = netns_name_from_id(id);
+
+			if (name) {
+				print_string(PRINT_ANY, "netns",
+					     " netns %s", name);
+				free(name);
+			} else {
+				print_int(PRINT_ANY, "netnsid",
+					  " netnsid %d", id);
+			}
+		} else {
+			print_string(PRINT_FP, NULL, " netnsid %s", "unknown");
+			print_int(PRINT_JSON, "netnsid", NULL, id);
+		}
+	}
 	pr_out_handle_end(dl);
 }
 
diff --git a/include/namespace.h b/include/namespace.h
index 6483630b8082..4ae294749962 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -59,5 +59,6 @@ struct netns_func {
 };
 
 int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
+char *netns_name_from_id(int32_t id);
 
 #endif /* __NAMESPACE_H__ */
diff --git a/lib/namespace.c b/lib/namespace.c
index f03f4bbabceb..d3aeb9658e73 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -188,3 +188,37 @@ out:
 	free(answer);
 	return ret;
 }
+
+struct netns_name_from_id_ctx {
+	int32_t id;
+	char *name;
+	struct rtnl_handle *rth;
+};
+
+static int netns_name_from_id_func(char *nsname, void *arg)
+{
+	struct netns_name_from_id_ctx *ctx = arg;
+	int32_t ret;
+
+	ret = netns_id_from_name(ctx->rth, nsname);
+	if (ret < 0 || ret != ctx->id)
+		return 0;
+	ctx->name = strdup(nsname);
+	return 1;
+}
+
+char *netns_name_from_id(int32_t id)
+{
+	struct rtnl_handle rth;
+	struct netns_name_from_id_ctx ctx = {
+		.id = id,
+		.rth = &rth,
+	};
+
+	if (rtnl_open(&rth, 0) < 0)
+		return NULL;
+	netns_foreach(netns_name_from_id_func, &ctx);
+	rtnl_close(&rth);
+
+	return ctx.name;
+}
-- 
2.41.0


