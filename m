Return-Path: <netdev+bounces-43799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655367D4D3B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888541C20C1D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE426287;
	Tue, 24 Oct 2023 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RFG+xRoo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0725116
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:15 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D650AEA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9adb9fa7200so893764966b.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141852; x=1698746652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN5skjm3FQLBaaFGgLJ1QaTSvXrhhqX4sfb8M9dwKFc=;
        b=RFG+xRooNBD7XkyOthAGIcJcXgJt/23Qd6SmQ+MlqYO8+rxksfbNr6hYYVuzXsyyzU
         77mfxyS4lUmByxZSmxD8XNN4feR+AGpuIBo4p2wPrDnGw9vsh6AChE0gxtfG99pxhaUQ
         ZUiqChSdDf7vnyzRT2M8LbgybpL2sA2N2HDCkK3qx/dBX9VD4nIrCaWe3FIIz4uhsYAk
         EdBdZECnOFbjBuHr+qkAY8iJvpWdqW8PXQnVph745qDdfSiYRvGPoOT8PsMPNH2gGCQR
         9B0pGmWuysq05a3p5y6DgCggrtUllYzh2ao2p4v0ujn6QQcnf6xVhK4N8Swz5eTHZJiX
         +eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141852; x=1698746652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN5skjm3FQLBaaFGgLJ1QaTSvXrhhqX4sfb8M9dwKFc=;
        b=p2o2PfxEuFYFF46A4rikOZl8sglo5IQDX/ODwDWKQfTOXrRU21Nb9+f6UeTJZLr2tm
         aTPIml3fucjEUeXPtx3E2H72rYQMFzHZ53vdlPd+FTM8c+6g25zFuAtgdqKMBoMAktlc
         soniU48z0FiGzDdxXujmowKEHbDfhq8od/R2JBHp9WQ1y8FfLkUGWdAyZb7iHY/EP8xB
         UxSf0T+rygRDEbjfLEaQQwrNgROWOwh2vUOyIKhMLXySfJOuK56qjIRK/gBrdeXHDweG
         YPq5OMOAnItdaYjw4CqcaAhosM3XSA3MKAroMvju0kr97xk0fy5cEoiRmtPGN5N5kk00
         Da4A==
X-Gm-Message-State: AOJu0Yzw3Vf5Fz56fTqqKs+d1m6RNRTWNB8qw5AJttWGNLka3yuqCUhO
	PqDLmhOBpEe2prA6Qzabu4lz7z2kPlZa6SMv7tEYRw==
X-Google-Smtp-Source: AGHT+IGoTH263BxDbZR4LHNSSHDXyXEGogvQ7nrS1UZGjXoTx9CCeLeDBQkE+DcdiNii3Its8adNrw==
X-Received: by 2002:a17:907:728f:b0:9a5:7dec:fab9 with SMTP id dt15-20020a170907728f00b009a57decfab9mr13943879ejc.9.1698141852307;
        Tue, 24 Oct 2023 03:04:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906050c00b009c764341f74sm8022871eja.71.2023.10.24.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 4/6] devlink: introduce support for netns id for nested handle
Date: Tue, 24 Oct 2023 12:04:01 +0200
Message-ID: <20231024100403.762862-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024100403.762862-1-jiri@resnulli.us>
References: <20231024100403.762862-1-jiri@resnulli.us>
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
index f7325477f271..7ba2d0dcac72 100644
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
@@ -2865,7 +2867,26 @@ static void __pr_out_nested_handle(struct dl *dl, struct nlattr *nla_nested_dl,
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
index e860a4b8ee5b..fbdfbc9a1c3b 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -61,5 +61,6 @@ struct netns_func {
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


