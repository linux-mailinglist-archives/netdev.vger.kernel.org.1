Return-Path: <netdev+bounces-46374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8ED7E3650
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C41B1C20B07
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B6FD527;
	Tue,  7 Nov 2023 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tk7TRw1x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC212E4B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:19 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9FE8
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso789348466b.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344375; x=1699949175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rny5/tZjlX9ASW7DpqQNMPQyvouS4P/pMU3Z38WXmC0=;
        b=tk7TRw1xpk55frkdgIPDUjsN8VyyKaq8W94+EvADUIsakM/z3yaphuH9sjwOWwEaoI
         xund4QlcqiHaLMNuHve4qfDzlJdmIqwRKmNDE9oqZjqHlD+B777y0eaDzejzzCP/kple
         gbO0z9ERSeXnGjpa/NCdSjVTh4ISzAKHcGLTJscjMAuAb3yho8aUDW/clRvtF938+21K
         8ZYYLpCV3Xm7nfCNtl6eCBYEgAreNTK0YSR49YNX91cFtUtMchlFq7SY47OZGfRxJELH
         0NUwhzw67usfF1IHG7f1jj3GzWXoN2cW0BKrU+EpCLJTm26IYIJdfwpb1QnbzpJA06dc
         VFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344375; x=1699949175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rny5/tZjlX9ASW7DpqQNMPQyvouS4P/pMU3Z38WXmC0=;
        b=ZZ/rGZzMDOdLBfDub5upbqgTWzn0q2cgaQ3gjPAUIfYC1BTZTYuKX5OEBqWbJUmTqF
         za6rd9BpTjhs0LOK+kwsv1cIC2SjQnPXKf8Axvwc7JYWFwexRPjWV2cV9PN1FlA3KO97
         CfE7uE+uIiyVdVPscl8by+/i8LGoP7yS3U2E6MFd4607r0D1ldlE6etFOynH9C4AHLnU
         Wwbyiwk4YXKMQu3ob+rBfyg3GwIcEViuwirt2ewLphc2bNzFsSDWCn4+Tm1OgVyYxaLI
         VY7p+1ZBfKIoPwlmpUpkQLgY2bbN5TwocUuDm/mFC4R7FNv867eEfFFFfudMyiI9YZ3p
         dsOA==
X-Gm-Message-State: AOJu0YzzTJEIOvVjWzJLkJn0ylEQ0WdtybXkt5qoo+6PTgbnOv9WePci
	7j5kBLGlU2Ro9GGW087fZ4gieyKsmUul5R7dTRo=
X-Google-Smtp-Source: AGHT+IFXx7cSK7PGOnNu/jgxOLgP7hSqGz02P4/IFvNg9sbK/aA5fm8pUYfyt3eXv9HDfa4ZiEqphw==
X-Received: by 2002:a17:907:934c:b0:9d3:8d1e:ced with SMTP id bv12-20020a170907934c00b009d38d1e0cedmr16110083ejc.34.1699344375729;
        Tue, 07 Nov 2023 00:06:15 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709061dcc00b009ae3d711fd9sm744433ejh.69.2023.11.07.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:15 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 5/7] devlink: introduce support for netns id for nested handle
Date: Tue,  7 Nov 2023 09:06:05 +0100
Message-ID: <20231107080607.190414-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107080607.190414-1-jiri@resnulli.us>
References: <20231107080607.190414-1-jiri@resnulli.us>
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
index 2843f4bb5742..86000543f99f 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -60,5 +60,6 @@ struct netns_func {
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


