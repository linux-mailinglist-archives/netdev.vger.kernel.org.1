Return-Path: <netdev+bounces-40346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCA7C6D84
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AD71C20D2B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06DF25100;
	Thu, 12 Oct 2023 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qqD5C9Xs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887622EE6
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:58:20 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DC49FF
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:58:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3231df054c4so737059f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697111893; x=1697716693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0O/p4AugECy2iQRH6nAXf9jta+GYorzXCSVQlHwhOA4=;
        b=qqD5C9XsL2cetvsPYLp93tNIUZa+gMzomqjDWAsGQmWCfNgUcybY7ZRmxwfmcfKZ0v
         qYDv85plDrB7Lw6uo7McwrMKH7coQpWbu8MAsPq5gbqvc6/pn/CubtOnQaCjCdOsAX1T
         rSqsudJO1dgqAhvsyFd12F5bR5RcvbgloTj2byvMayfoA9sZlo/tP0KlK/eYRv3OxAMe
         6JUXO7y7POeW6DGs/5H1nqEZdD/uI/elh+BfnYUtPZNYNl8X4m7OA13sAx6fVkPsRMOh
         dpX8yQBiZHeKI3q225slMRHnVIyF9HErthk9oij4JtLsv15A2H2gb+4XJS/G8xpqpN3A
         dV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111893; x=1697716693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0O/p4AugECy2iQRH6nAXf9jta+GYorzXCSVQlHwhOA4=;
        b=GXmnO43XOXZOJmguskzc3845KYh3J1VyHhimyHSPFoQYHx6LEXHS31NbrxIrmEF0CD
         wdtgNbfucpSdLlXaQEw+S/+gsNHov8p2is5smlpgRfdJ7h0mdvasJIAGY7geLwI7OtKh
         0BOu/REp2Z6gzHSLegYYq9c+mFlRH0ouqZXoSVz1hdGihWP9r+KeolPdt4+rB9SJt1aC
         QRUDcYHtA6/ahO1NvZip223v9WFlMzvHDahkUdBGU1HN/ePemiLEb+vj5wA8hFBz3Kmm
         xc30LiS8YoMdwtMCYlMJuIbfjKN+gKVgc102zzP37nQdbepIdvY1hgOk9uLwsR/DgG8e
         Nl/g==
X-Gm-Message-State: AOJu0Yxhvmyx4vdAgROPXpCHb+I4FWK6JcMQ2Zzk3XyT1CldmNoN3Mpk
	iEdldPj80j5k+w1xZ1oWcVstrCpECOS0eLc3x/U=
X-Google-Smtp-Source: AGHT+IFRELJ/Vu2CkTpKxD8IFXMM24K9GKaBVqnf7Qdn+4t+wr0V9mbDa8Log4JJyEPCnA3zOb4oWg==
X-Received: by 2002:adf:ce90:0:b0:321:cec8:e64d with SMTP id r16-20020adfce90000000b00321cec8e64dmr21548710wrn.62.1697111893468;
        Thu, 12 Oct 2023 04:58:13 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm18109303wrw.104.2023.10.12.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:58:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net] netlink: specs: devlink: fix reply command values
Date: Thu, 12 Oct 2023 13:58:11 +0200
Message-ID: <20231012115811.298129-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
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

Make sure that the command values used for replies are correct. This is
only affecting generated userspace helpers, no change on kernel code.

Fixes: 7199c86247e9 ("netlink: specs: devlink: add commands that do per-instance dump")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 18 ++++----
 tools/net/ynl/generated/devlink-user.c   | 54 ++++++++++++------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index d1ebcd927149..065661acb878 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -323,7 +323,7 @@ operations:
             - dev-name
             - sb-index
         reply: &sb-get-reply
-          value: 11
+          value: 13
           attributes: *sb-id-attrs
       dump:
         request:
@@ -350,7 +350,7 @@ operations:
             - sb-index
             - sb-pool-index
         reply: &sb-pool-get-reply
-          value: 15
+          value: 17
           attributes: *sb-pool-id-attrs
       dump:
         request:
@@ -378,7 +378,7 @@ operations:
             - sb-index
             - sb-pool-index
         reply: &sb-port-pool-get-reply
-          value: 19
+          value: 21
           attributes: *sb-port-pool-id-attrs
       dump:
         request:
@@ -407,7 +407,7 @@ operations:
             - sb-pool-type
             - sb-tc-index
         reply: &sb-tc-pool-bind-get-reply
-          value: 23
+          value: 25
           attributes: *sb-tc-pool-bind-id-attrs
       dump:
         request:
@@ -538,7 +538,7 @@ operations:
             - dev-name
             - trap-name
         reply: &trap-get-reply
-          value: 61
+          value: 63
           attributes: *trap-id-attrs
       dump:
         request:
@@ -564,7 +564,7 @@ operations:
             - dev-name
             - trap-group-name
         reply: &trap-group-get-reply
-          value: 65
+          value: 67
           attributes: *trap-group-id-attrs
       dump:
         request:
@@ -590,7 +590,7 @@ operations:
             - dev-name
             - trap-policer-id
         reply: &trap-policer-get-reply
-          value: 69
+          value: 71
           attributes: *trap-policer-id-attrs
       dump:
         request:
@@ -617,7 +617,7 @@ operations:
             - port-index
             - rate-node-name
         reply: &rate-get-reply
-          value: 74
+          value: 76
           attributes: *rate-id-attrs
       dump:
         request:
@@ -643,7 +643,7 @@ operations:
             - dev-name
             - linecard-index
         reply: &linecard-get-reply
-          value: 78
+          value: 80
           attributes: *linecard-id-attrs
       dump:
         request:
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 3a8d8499fab6..2cb2518500cb 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -16,19 +16,19 @@
 static const char * const devlink_op_strmap[] = {
 	[3] = "get",
 	[7] = "port-get",
-	[DEVLINK_CMD_SB_GET] = "sb-get",
-	[DEVLINK_CMD_SB_POOL_GET] = "sb-pool-get",
-	[DEVLINK_CMD_SB_PORT_POOL_GET] = "sb-port-pool-get",
-	[DEVLINK_CMD_SB_TC_POOL_BIND_GET] = "sb-tc-pool-bind-get",
+	[13] = "sb-get",
+	[17] = "sb-pool-get",
+	[21] = "sb-port-pool-get",
+	[25] = "sb-tc-pool-bind-get",
 	[DEVLINK_CMD_PARAM_GET] = "param-get",
 	[DEVLINK_CMD_REGION_GET] = "region-get",
 	[DEVLINK_CMD_INFO_GET] = "info-get",
 	[DEVLINK_CMD_HEALTH_REPORTER_GET] = "health-reporter-get",
-	[DEVLINK_CMD_TRAP_GET] = "trap-get",
-	[DEVLINK_CMD_TRAP_GROUP_GET] = "trap-group-get",
-	[DEVLINK_CMD_TRAP_POLICER_GET] = "trap-policer-get",
-	[DEVLINK_CMD_RATE_GET] = "rate-get",
-	[DEVLINK_CMD_LINECARD_GET] = "linecard-get",
+	[63] = "trap-get",
+	[67] = "trap-group-get",
+	[71] = "trap-policer-get",
+	[76] = "rate-get",
+	[80] = "linecard-get",
 	[DEVLINK_CMD_SELFTESTS_GET] = "selftests-get",
 };
 
@@ -838,7 +838,7 @@ devlink_sb_get(struct ynl_sock *ys, struct devlink_sb_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_GET;
+	yrs.rsp_cmd = 13;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -876,7 +876,7 @@ devlink_sb_get_dump(struct ynl_sock *ys, struct devlink_sb_get_req_dump *req)
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_get_list);
 	yds.cb = devlink_sb_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_GET;
+	yds.rsp_cmd = 13;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_GET, 1);
@@ -987,7 +987,7 @@ devlink_sb_pool_get(struct ynl_sock *ys, struct devlink_sb_pool_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_pool_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_POOL_GET;
+	yrs.rsp_cmd = 17;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -1026,7 +1026,7 @@ devlink_sb_pool_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_pool_get_list);
 	yds.cb = devlink_sb_pool_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_POOL_GET;
+	yds.rsp_cmd = 17;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_POOL_GET, 1);
@@ -1147,7 +1147,7 @@ devlink_sb_port_pool_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_port_pool_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_PORT_POOL_GET;
+	yrs.rsp_cmd = 21;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -1187,7 +1187,7 @@ devlink_sb_port_pool_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_port_pool_get_list);
 	yds.cb = devlink_sb_port_pool_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_PORT_POOL_GET;
+	yds.rsp_cmd = 21;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_PORT_POOL_GET, 1);
@@ -1316,7 +1316,7 @@ devlink_sb_tc_pool_bind_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_tc_pool_bind_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET;
+	yrs.rsp_cmd = 25;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -1356,7 +1356,7 @@ devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_tc_pool_bind_get_list);
 	yds.cb = devlink_sb_tc_pool_bind_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET;
+	yds.rsp_cmd = 25;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_TC_POOL_BIND_GET, 1);
@@ -2183,7 +2183,7 @@ devlink_trap_get(struct ynl_sock *ys, struct devlink_trap_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_trap_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_TRAP_GET;
+	yrs.rsp_cmd = 63;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2223,7 +2223,7 @@ devlink_trap_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_trap_get_list);
 	yds.cb = devlink_trap_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_TRAP_GET;
+	yds.rsp_cmd = 63;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GET, 1);
@@ -2336,7 +2336,7 @@ devlink_trap_group_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_trap_group_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_TRAP_GROUP_GET;
+	yrs.rsp_cmd = 67;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2376,7 +2376,7 @@ devlink_trap_group_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_trap_group_get_list);
 	yds.cb = devlink_trap_group_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_TRAP_GROUP_GET;
+	yds.rsp_cmd = 67;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GROUP_GET, 1);
@@ -2483,7 +2483,7 @@ devlink_trap_policer_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_trap_policer_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_TRAP_POLICER_GET;
+	yrs.rsp_cmd = 71;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2523,7 +2523,7 @@ devlink_trap_policer_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_trap_policer_get_list);
 	yds.cb = devlink_trap_policer_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_TRAP_POLICER_GET;
+	yds.rsp_cmd = 71;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_POLICER_GET, 1);
@@ -2642,7 +2642,7 @@ devlink_rate_get(struct ynl_sock *ys, struct devlink_rate_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_rate_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_RATE_GET;
+	yrs.rsp_cmd = 76;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2682,7 +2682,7 @@ devlink_rate_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_rate_get_list);
 	yds.cb = devlink_rate_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_RATE_GET;
+	yds.rsp_cmd = 76;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_RATE_GET, 1);
@@ -2786,7 +2786,7 @@ devlink_linecard_get(struct ynl_sock *ys, struct devlink_linecard_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_linecard_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_LINECARD_GET;
+	yrs.rsp_cmd = 80;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2825,7 +2825,7 @@ devlink_linecard_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_linecard_get_list);
 	yds.cb = devlink_linecard_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_LINECARD_GET;
+	yds.rsp_cmd = 80;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_LINECARD_GET, 1);
-- 
2.41.0


