Return-Path: <netdev+bounces-32239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647EF793AD2
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1A1C20A31
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766E101FB;
	Wed,  6 Sep 2023 11:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C8101E1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:30 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFCECFA
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bce552508fso54396831fa.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998686; x=1694603486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhJ3igHyFf50XEFrCB5QXH0nBBuzfYn//fqbq8APXEo=;
        b=KYJKkzAsYNYI5ebW2iAghl8ovV+w1GLd12r8nuCfCOUkm8jsGWTt7W9nkgA94eOZgD
         U5eil9ijgiNJZdTNs6t8jHowPBaiOro8gfOxBuGv5iOYJDTGYpX54dZ9cJ3C514sKHZz
         5IrBUDQShLMxfDe21/qcJpMyxTDikRg/a5520m+uG8DYcPCGQTJ9gi7SX7GvTseghgN0
         rn9Q5cxeBjHRfsiqDi69i/mP0I9nGE5impCaqrezgeP5qwVbW7BcQCxGRv3gzIjfwig1
         tuE4BS3M76nvnFvU57UUYWavihLScVOchJPlXwMMXFSFch+ehnhmADcjkVJ7d9srdDNT
         +o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998686; x=1694603486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhJ3igHyFf50XEFrCB5QXH0nBBuzfYn//fqbq8APXEo=;
        b=UPa5M802K6nOPmH9KQri90CUYKhnIJNuHJWaczpfTuPa1xKdPuG64NGtfar2wKjyTF
         dCTgHyOyYL1kpvVV5J2JIcZrHagp5awzPvmH0nnN43PU8MBWsJiynOhAkeyNZce+jt5p
         vvCRp4snM0RxjEduFNtQY02X1p4O4X2iOJ1/SBDplQ1FP87TZ4eJTOOycVbTzCNfbW2L
         I6XHCMiNXSHzln+elShIiHllBO4XdJsw9HwJKwWpKONnFyK2JJnBk2E0epXrDGnWYxpJ
         8KfvKTMnml+CkCVgw4r4M5fgzrXvXCSgioEJ6i0x7TnWXtGmGU6mZlZVo5UQltgQ6sKq
         tLQQ==
X-Gm-Message-State: AOJu0YzgIe9GAx+Ryc0VBtslaqm+SDP74usFyRur8V96F73+no2xWxH3
	x3QYF59OV95lZLTfeJc6leO4XPMD9w53qAXgsbw=
X-Google-Smtp-Source: AGHT+IF55hZWWHyEL2XS2WZNEtHyDb2l2EIuX+D6DUDAAVLFxhqHUJGg+1FPR8jAFPCGfHFDCXI3zQ==
X-Received: by 2002:a2e:9044:0:b0:2ba:7b3b:4b7d with SMTP id n4-20020a2e9044000000b002ba7b3b4b7dmr1918721ljg.17.1693998686394;
        Wed, 06 Sep 2023 04:11:26 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c224e00b003fbe4cecc3bsm22628105wmm.16.2023.09.06.04.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:25 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 6/6] devlink: implement dump selector for devlink objects show commands
Date: Wed,  6 Sep 2023 13:11:13 +0200
Message-ID: <20230906111113.690815-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906111113.690815-1-jiri@resnulli.us>
References: <20230906111113.690815-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce a new helper dl_argv_parse_with_selector() to be used
by show() functions instead of dl_argv().

Implement it to check if all needed options got get commands are
specified. In case they are not, ask kernel for dump passing only
the options (attributes) that are present, creating sort of partial
key to instruct kernel to do partial dump.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 283 +++++++++++++++++++++++++++-------------------
 1 file changed, 164 insertions(+), 119 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 7888173fb4bc..d1795f616ca0 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2302,6 +2302,88 @@ static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
 	return err;
 }
 
+/* List of extented handles with two slashes. */
+static const uint64_t dl_opt_extended_handle[] = {
+	DL_OPT_HANDLEP,
+	DL_OPT_HANDLE_REGION,
+	DL_OPT_PORT_FN_RATE_NODE_NAME,
+};
+
+static int dl_argv_parse_with_selector(struct dl *dl, uint16_t *flags,
+				       uint8_t cmd,
+				       uint64_t o_required,
+				       uint64_t o_optional,
+				       uint64_t o_dump_required,
+				       uint64_t o_dump_optional)
+{
+	int err;
+	int i;
+
+	if (dl_no_arg(dl))
+		goto flag_set;
+
+	/* In case the handle suggests it, do dry parsing first
+	 * to see if all required options are there. Proceed with
+	 * dump selector in case there are missing options on the
+	 * command line. That means user provided partial
+	 * object identification.
+	 */
+
+	if ((o_required & (DL_OPT_HANDLE | DL_OPT_HANDLEP)) ==
+	    (DL_OPT_HANDLE | DL_OPT_HANDLEP)) {
+		/* Handle case when both devlink handle and port handle
+		 * are allowed. Try both alone, if parsing of either
+		 * is successful, we have a do parse case.
+		 */
+		err = dl_argv_dry_parse(dl, o_required & ~DL_OPT_HANDLEP,
+					o_optional);
+		if (err == -ENOENT)
+			goto dump_parse;
+		else if (!err)
+			goto do_parse;
+		err = dl_argv_dry_parse(dl, o_required & ~DL_OPT_HANDLE,
+					o_optional);
+		if (err == -ENOENT)
+			goto dump_parse;
+		goto do_parse;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dl_opt_extended_handle); i++) {
+		uint64_t handle = dl_opt_extended_handle[i];
+
+		if ((o_required & handle) == handle) {
+			err = dl_argv_dry_parse(dl, (o_required & ~handle) |
+						DL_OPT_HANDLE,
+						o_optional);
+			if (err == -ENOENT || !err)
+				goto dump_parse;
+			goto do_parse;
+		}
+	}
+
+	err = dl_argv_dry_parse(dl, o_required, o_optional);
+	if (err == -ENOENT)
+		goto dump_parse;
+
+do_parse:
+	return dl_argv_parse(dl, o_required, o_optional);
+
+dump_parse:
+	err = mnlu_gen_cmd_dump_policy(&dl->nlg, cmd);
+	if (err) {
+		pr_err("Dump selectors are not supported by kernel for this command\n");
+		return -ENOTSUP;
+	}
+
+	err = dl_argv_parse(dl, o_dump_required, o_dump_optional);
+	if (err)
+		return err;
+
+flag_set:
+	*flags |= NLM_F_DUMP;
+	return 0;
+}
+
 static void
 dl_function_attr_put(struct nlmsghdr *nlh, const struct dl_opts *opts)
 {
@@ -3580,13 +3662,11 @@ static int cmd_dev_param_show(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	} else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_PARAM_NAME, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_PARAM_GET,
+					  DL_OPT_HANDLE | DL_OPT_PARAM_NAME, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PARAM_GET, flags);
 
@@ -4784,14 +4864,11 @@ static int cmd_port_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLEP, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_PORT_GET,
+					  DL_OPT_HANDLEP, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PORT_GET, flags);
 
@@ -4860,14 +4937,12 @@ static int cmd_port_param_show(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_PARAM_NAME, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags,
+					  DEVLINK_CMD_PORT_PARAM_GET,
+					  DL_OPT_HANDLE | DL_OPT_PARAM_NAME, 0,
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_PORT_PARAM_GET,
 					  flags);
@@ -5234,16 +5309,9 @@ static int cmd_port_fn_rate_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl,
-				    DL_OPT_HANDLEP | DL_OPT_PORT_FN_RATE_NODE_NAME,
-				    0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RATE_GET,
+					  DL_OPT_HANDLEP | DL_OPT_PORT_FN_RATE_NODE_NAME,
+					  0, DL_OPT_HANDLE, 0);
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_RATE_GET, flags);
 
@@ -5622,14 +5690,11 @@ static int cmd_linecard_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE, DL_OPT_LINECARD);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_LINECARD_GET,
+					  DL_OPT_HANDLE | DL_OPT_LINECARD, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_LINECARD_GET,
 					  flags);
@@ -5740,14 +5805,11 @@ static int cmd_sb_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_SB_GET,
+					  DL_OPT_HANDLE | DL_OPT_SB, 0,
+					  DL_OPT_HANDLE, DL_OPT_SB);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_SB_GET, flags);
 
@@ -5819,15 +5881,12 @@ static int cmd_sb_pool_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB |
-				    DL_OPT_SB_POOL, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_SB_POOL_GET,
+					  DL_OPT_HANDLE | DL_OPT_SB |
+					  DL_OPT_SB_POOL, 0,
+					  DL_OPT_HANDLE, DL_OPT_SB);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_SB_POOL_GET, flags);
 
@@ -5908,15 +5967,13 @@ static int cmd_sb_port_pool_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB |
-				    DL_OPT_SB_POOL, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags,
+					  DEVLINK_CMD_SB_PORT_POOL_GET,
+					  DL_OPT_HANDLEP | DL_OPT_SB |
+					  DL_OPT_SB_POOL, 0,
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP, DL_OPT_SB);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_SB_PORT_POOL_GET, flags);
 
@@ -6015,15 +6072,14 @@ static int cmd_sb_tc_bind_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB | DL_OPT_SB_TC |
-				    DL_OPT_SB_TYPE, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags,
+					  DEVLINK_CMD_SB_TC_POOL_BIND_GET,
+					  DL_OPT_HANDLEP | DL_OPT_SB |
+					  DL_OPT_SB_TC | DL_OPT_SB_TYPE, 0,
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP,
+					  DL_OPT_SB);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_SB_TC_POOL_BIND_GET, flags);
 
@@ -8697,14 +8753,11 @@ static int cmd_region_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE_REGION, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_REGION_GET,
+					  DL_OPT_HANDLE_REGION, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_REGION_GET, flags);
 
@@ -9388,19 +9441,20 @@ static int __cmd_health_show(struct dl *dl, bool show_device, bool show_port)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	} else {
+	err = dl_argv_parse_with_selector(dl, &flags,
+					  DEVLINK_CMD_HEALTH_REPORTER_GET,
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP |
+					  DL_OPT_HEALTH_REPORTER_NAME, 0,
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP, 0);
+	if (err)
+		return err;
+
+	if (!(flags & NLM_F_DUMP))
 		ctx.show_port = true;
-		err = dl_argv_parse(dl,
-				    DL_OPT_HANDLE | DL_OPT_HANDLEP |
-				    DL_OPT_HEALTH_REPORTER_NAME, 0);
-		if (err)
-			return err;
-	}
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_HEALTH_REPORTER_GET,
 			       flags);
+
 	dl_opts_put(nlh, dl);
 
 	pr_out_section_start(dl, "health");
@@ -9582,14 +9636,11 @@ static int cmd_trap_show(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_TRAP_NAME, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_TRAP_GET,
+					  DL_OPT_HANDLE | DL_OPT_TRAP_NAME, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_TRAP_GET, flags);
 
@@ -9660,15 +9711,12 @@ static int cmd_trap_group_show(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl,
-				    DL_OPT_HANDLE | DL_OPT_TRAP_GROUP_NAME, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags,
+					  DEVLINK_CMD_TRAP_GROUP_GET,
+					  DL_OPT_HANDLE | DL_OPT_TRAP_GROUP_NAME, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_TRAP_GROUP_GET, flags);
 
@@ -9759,15 +9807,12 @@ static int cmd_trap_policer_show(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	if (dl_no_arg(dl)) {
-		flags |= NLM_F_DUMP;
-	}
-	else {
-		err = dl_argv_parse(dl,
-				    DL_OPT_HANDLE | DL_OPT_TRAP_POLICER_ID, 0);
-		if (err)
-			return err;
-	}
+	err = dl_argv_parse_with_selector(dl, &flags,
+					  DEVLINK_CMD_TRAP_POLICER_GET,
+					  DL_OPT_HANDLE | DL_OPT_TRAP_POLICER_ID, 0,
+					  DL_OPT_HANDLE, 0);
+	if (err)
+		return err;
 
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_TRAP_POLICER_GET, flags);
 
-- 
2.41.0


