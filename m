Return-Path: <netdev+bounces-39522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBFA7BF940
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323A7282234
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86271865A;
	Tue, 10 Oct 2023 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hFC/VeGx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58171182BE
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:44 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D294
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3c8adb27so930757966b.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936120; x=1697540920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnUKkMhJo0s/+/yAOsFA63yVJEQrTW2f15iiMkaYKzw=;
        b=hFC/VeGxCddjE12Q5vmfMusl1mWh3ioqsOYMQ6sXmjb5Mn4Q9fKaDSWFapgHnmuSV0
         vsUmsUC0p105NhWPdB6jwqZpsPbHD1aytUcwIx77cWzkjvpdkghtmCpeVU1YuixTipjg
         +eDGqbIgxDc8aHeFaMCSr2fSbrOcOPUKCk9RZ4CKXSgLz9L237w7p6h59pfG4v93LFfb
         79Etv9CXnnXtSaTY3+D5OWMGZOMTna2fuoF3IE1Jl8c9OlWbsAimEjubgP/eYhegqp3t
         m6MvgD3xOI8SF6WKAOv8BsrSr+svzJt09eWbT6bFpiKGFag0A8jON1Q0+u/wJxZbPchR
         Zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936120; x=1697540920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnUKkMhJo0s/+/yAOsFA63yVJEQrTW2f15iiMkaYKzw=;
        b=b0nC9oOh/2rznV1/s7vvsMBjKupqi9iJVZLBVhgCWPF4H60FFekjw6JXkBPolnMbwW
         3NX2Sgc1uFHLcBgqt7M8KvmsmQNc0WyjeIp1wcksbjo9L7HwrSLQbA78m/j93oYJ4R2d
         IFiF8f464ywGIYxUYNdUFqc5YX2WxgdEXo98WmbY1gBXkPlbAd82KIKYIqtcHtvFIV/e
         67zDZMi3oZBoM4Mc2c0FAscriXSnAmlWrJOuMYQanjRIzGliFBuAkwCmeJKXQVECbGC/
         jxCE9ZUlm13l4p219Okl3bQB52HZR/SnAVrWkUEI2h1IJGjAO72gvCnxz3NbeTWM6GJS
         wrfg==
X-Gm-Message-State: AOJu0YyINrcf5LWFRgAgpImTDCmDtbd5Z+SFdDNQGT5CvSWsySsKids7
	qyeeYIgWcmn8OUgfFL/uWAhh6hklBOthcfeCv+0=
X-Google-Smtp-Source: AGHT+IG/+xB3LmVAuQlIOO1vo15GqGshA8Ww/Qzgfaz63UotpVQZ3cJtLfY/U1k5RTrBgYfK9E31/w==
X-Received: by 2002:a17:906:4d2:b0:9ae:5212:e3b with SMTP id g18-20020a17090604d200b009ae52120e3bmr14096253eja.5.1696936120259;
        Tue, 10 Oct 2023 04:08:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm8226733ejb.58.2023.10.10.04.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:39 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 05/10] netlink: specs: devlink: fix reply command values
Date: Tue, 10 Oct 2023 13:08:24 +0200
Message-ID: <20231010110828.200709-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
index 5308cc54cfc1..dd035a8f5eb4 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -305,7 +305,7 @@ operations:
             - dev-name
             - sb-index
         reply: &sb-get-reply
-          value: 11
+          value: 13
           attributes: *sb-id-attrs
       dump:
         request:
@@ -330,7 +330,7 @@ operations:
             - sb-index
             - sb-pool-index
         reply: &sb-pool-get-reply
-          value: 15
+          value: 17
           attributes: *sb-pool-id-attrs
       dump:
         request:
@@ -356,7 +356,7 @@ operations:
             - sb-index
             - sb-pool-index
         reply: &sb-port-pool-get-reply
-          value: 19
+          value: 21
           attributes: *sb-port-pool-id-attrs
       dump:
         request:
@@ -383,7 +383,7 @@ operations:
             - sb-pool-type
             - sb-tc-index
         reply: &sb-tc-pool-bind-get-reply
-          value: 23
+          value: 25
           attributes: *sb-tc-pool-bind-id-attrs
       dump:
         request:
@@ -503,7 +503,7 @@ operations:
             - dev-name
             - trap-name
         reply: &trap-get-reply
-          value: 61
+          value: 63
           attributes: *trap-id-attrs
       dump:
         request:
@@ -527,7 +527,7 @@ operations:
             - dev-name
             - trap-group-name
         reply: &trap-group-get-reply
-          value: 65
+          value: 67
           attributes: *trap-group-id-attrs
       dump:
         request:
@@ -551,7 +551,7 @@ operations:
             - dev-name
             - trap-policer-id
         reply: &trap-policer-get-reply
-          value: 69
+          value: 71
           attributes: *trap-policer-id-attrs
       dump:
         request:
@@ -576,7 +576,7 @@ operations:
             - port-index
             - rate-node-name
         reply: &rate-get-reply
-          value: 74
+          value: 76
           attributes: *rate-id-attrs
       dump:
         request:
@@ -600,7 +600,7 @@ operations:
             - dev-name
             - linecard-index
         reply: &linecard-get-reply
-          value: 78
+          value: 80
           attributes: *linecard-id-attrs
       dump:
         request:
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 34ed9319a2b2..a002f71d6068 100644
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
 
@@ -833,7 +833,7 @@ devlink_sb_get(struct ynl_sock *ys, struct devlink_sb_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_GET;
+	yrs.rsp_cmd = 13;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -871,7 +871,7 @@ devlink_sb_get_dump(struct ynl_sock *ys, struct devlink_sb_get_req_dump *req)
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_get_list);
 	yds.cb = devlink_sb_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_GET;
+	yds.rsp_cmd = 13;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_GET, 1);
@@ -982,7 +982,7 @@ devlink_sb_pool_get(struct ynl_sock *ys, struct devlink_sb_pool_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_pool_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_POOL_GET;
+	yrs.rsp_cmd = 17;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -1021,7 +1021,7 @@ devlink_sb_pool_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_pool_get_list);
 	yds.cb = devlink_sb_pool_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_POOL_GET;
+	yds.rsp_cmd = 17;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_POOL_GET, 1);
@@ -1142,7 +1142,7 @@ devlink_sb_port_pool_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_port_pool_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_PORT_POOL_GET;
+	yrs.rsp_cmd = 21;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -1182,7 +1182,7 @@ devlink_sb_port_pool_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_port_pool_get_list);
 	yds.cb = devlink_sb_port_pool_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_PORT_POOL_GET;
+	yds.rsp_cmd = 21;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_PORT_POOL_GET, 1);
@@ -1311,7 +1311,7 @@ devlink_sb_tc_pool_bind_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_sb_tc_pool_bind_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET;
+	yrs.rsp_cmd = 25;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -1351,7 +1351,7 @@ devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_sb_tc_pool_bind_get_list);
 	yds.cb = devlink_sb_tc_pool_bind_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET;
+	yds.rsp_cmd = 25;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_TC_POOL_BIND_GET, 1);
@@ -2178,7 +2178,7 @@ devlink_trap_get(struct ynl_sock *ys, struct devlink_trap_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_trap_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_TRAP_GET;
+	yrs.rsp_cmd = 63;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2218,7 +2218,7 @@ devlink_trap_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_trap_get_list);
 	yds.cb = devlink_trap_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_TRAP_GET;
+	yds.rsp_cmd = 63;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GET, 1);
@@ -2331,7 +2331,7 @@ devlink_trap_group_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_trap_group_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_TRAP_GROUP_GET;
+	yrs.rsp_cmd = 67;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2371,7 +2371,7 @@ devlink_trap_group_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_trap_group_get_list);
 	yds.cb = devlink_trap_group_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_TRAP_GROUP_GET;
+	yds.rsp_cmd = 67;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GROUP_GET, 1);
@@ -2478,7 +2478,7 @@ devlink_trap_policer_get(struct ynl_sock *ys,
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_trap_policer_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_TRAP_POLICER_GET;
+	yrs.rsp_cmd = 71;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2518,7 +2518,7 @@ devlink_trap_policer_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_trap_policer_get_list);
 	yds.cb = devlink_trap_policer_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_TRAP_POLICER_GET;
+	yds.rsp_cmd = 71;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_POLICER_GET, 1);
@@ -2637,7 +2637,7 @@ devlink_rate_get(struct ynl_sock *ys, struct devlink_rate_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_rate_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_RATE_GET;
+	yrs.rsp_cmd = 76;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2677,7 +2677,7 @@ devlink_rate_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_rate_get_list);
 	yds.cb = devlink_rate_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_RATE_GET;
+	yds.rsp_cmd = 76;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_RATE_GET, 1);
@@ -2781,7 +2781,7 @@ devlink_linecard_get(struct ynl_sock *ys, struct devlink_linecard_get_req *req)
 	rsp = calloc(1, sizeof(*rsp));
 	yrs.yarg.data = rsp;
 	yrs.cb = devlink_linecard_get_rsp_parse;
-	yrs.rsp_cmd = DEVLINK_CMD_LINECARD_GET;
+	yrs.rsp_cmd = 80;
 
 	err = ynl_exec(ys, nlh, &yrs);
 	if (err < 0)
@@ -2820,7 +2820,7 @@ devlink_linecard_get_dump(struct ynl_sock *ys,
 	yds.ys = ys;
 	yds.alloc_sz = sizeof(struct devlink_linecard_get_list);
 	yds.cb = devlink_linecard_get_rsp_parse;
-	yds.rsp_cmd = DEVLINK_CMD_LINECARD_GET;
+	yds.rsp_cmd = 80;
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_LINECARD_GET, 1);
-- 
2.41.0


