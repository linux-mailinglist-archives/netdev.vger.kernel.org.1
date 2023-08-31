Return-Path: <netdev+bounces-31584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D61C78EE7D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62AA2815A6
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892FD11C90;
	Thu, 31 Aug 2023 13:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FD125A8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:46 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05C1A2
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401d67434daso7801485e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488163; x=1694092963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcZbvPceAAvMnma0aYg1MIMzCOkiihvnqxJnmWALDQ4=;
        b=MKWehGyfQlnw85AJ7I7H45j27YqwL+gK0u8+rbRCY3O2rHYt4e1biqumctt4ZVcylf
         NMbv3UW/ixYL5WTRcb5zr3QyUw7Pq763f15LVOsEN5t52RgoJNwF7xNPofRi74LIFQl2
         kYv4cklBwVHEdbM+I2CcHZxb/Mm3XRTA6YX/0JTJzHnCQElms9+5+j0FE5nXkF9nThZB
         imWhn2wiKUofjnYIsiNb1eteQcKKNJglHqc/F5veuQpPEG0LNyjhH0j9SHBvnnrRJWMK
         k265f09dul6Acc2qdrqREliREZUBRIR3D5a64WeiC7rMbi41OXGvczJH0V16P4ggQuvo
         JXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488163; x=1694092963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcZbvPceAAvMnma0aYg1MIMzCOkiihvnqxJnmWALDQ4=;
        b=AondChbwRXlSPSvGgDu9i0/E5MvUWHCMYBjWwGSWv3ofDN7bZ9HS2GsEEmn6uR6hlY
         iwfE0FNdRkk21ArRqPbrmtXUUlHBb/gLIPwZumGohrnAzwMD79KRMsqu2nV9HxFJQCVF
         /j57uXlxU4jslZrJ7b/pVIICgLFsm10imqudLOVcHSeAmMFk6Dog7USHuWAJwFL5qFlp
         4Wggg4jETSLenEzz+ki9oseEOrntxhmxO5lE7XyZ0opx4HqTd3nbBmnPxzgyoEtQtoNz
         m1kqtIQyVgHHW7PQLb+ro3RojV76fO66BW4CGTxsI1bYTixbKhqfvDV1zBso1tYjkC7t
         01Rw==
X-Gm-Message-State: AOJu0Yy9Ert4qaJrsn00oS/3wXvsq6D+pRO+6VFdUYQWGu7TpuHPshwh
	aa8QfVbUguc/D003tKaxJMrGW8MU7kNwDkRTMrw=
X-Google-Smtp-Source: AGHT+IEyBcPCwvQEmRmWCZ8s7ZLnru6F/thYtjVT0LMAXXUYzy/mg0UdWFxs+b1SjpqziCbpLNdOWQ==
X-Received: by 2002:a5d:595f:0:b0:317:5b32:b2c3 with SMTP id e31-20020a5d595f000000b003175b32b2c3mr4270405wri.6.1693488162890;
        Thu, 31 Aug 2023 06:22:42 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003fe1a092925sm1978809wmk.19.2023.08.31.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 6/6] devlink: implement dump selector for devlink objects show commands
Date: Thu, 31 Aug 2023 15:22:29 +0200
Message-ID: <20230831132229.471693-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831132229.471693-1-jiri@resnulli.us>
References: <20230831132229.471693-1-jiri@resnulli.us>
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
index 6a46a4ecf648..066aab12c6f8 100644
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


