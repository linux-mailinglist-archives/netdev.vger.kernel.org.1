Return-Path: <netdev+bounces-32238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97BA793AD0
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596F8281314
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4BDDD8;
	Wed,  6 Sep 2023 11:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B60101E1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:28 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA1FCF1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40061928e5aso33883445e9.3
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998685; x=1694603485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+nkXB1sUqI8gd72PD8v1L11a4OBB90zkZ3AR6jPFao=;
        b=0XMzkjHTykK7us4yLS9Nil4ZpQBPXxlEgIp6qtGVgShAuOv8Br76Ll+mZNC6DCc6Jo
         OBtkJm2Y5TpGetw/KosH/MyEG/6JL2BTHL+QMdRAmF1W7K5rUMRG3/GyQtbDX5fK71Jk
         uYx3HbBdgrCNlYwLYSukVx+AqifcIZEfEWQkxKDV+ZmSdmULi0GWWFsgu6oHEykkYy43
         2rRlpXoZE6/eH1EBknttPUqaNAnlSqEOgaXW45TyfmnEGAR+jBSyVdGMlVZ7CGTyIcFw
         pCLnkZ1gWv3N1J3rN+AXi4POaV89e0AbfcPGFIMvIPwxqGb9Y9t5hi1jI3qEdFBLlSIs
         syWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998685; x=1694603485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+nkXB1sUqI8gd72PD8v1L11a4OBB90zkZ3AR6jPFao=;
        b=Ims/dDe9ZCnaxSwON+NmoJJSP2/0ybFIJ/coFrLZ4MRLvU47mkEPNX/0lNGwCow22P
         eIyvR7TyVAmSm27amSfg4ThYueFJ6zi33S1kCB0NWs7rfN1AdHDWP43b7CUksDjrrGJc
         R/7Cro/L7MqJBGW8e56z+4Dc++eNCJpydRqJYZzYId5Z7pNXUHzEL03x/jiwr9GmRZWg
         PLpQotYHmxaqupc+8JSsI8/icnetawnJJHLkiy7UHgdeAVy8ujfibYEyKHCxYqhBLHoJ
         +dJakYVNLMwJlxo1pAEYwWd9TtuYF5DXo1HsCJ2FDFqpGz7lYG7fKVdlGj0WCyshQmxx
         CnEw==
X-Gm-Message-State: AOJu0YzyhfWUz0k6QALyRz7YyLqYvho76wQf412qgBjfJ5dyYJnI4CXC
	/iTVnWh7qb+LXEvtaqI0MwMGvNH0jzDaQ0LGE1o=
X-Google-Smtp-Source: AGHT+IHnvgg30lBGlYCDSdmIXVY9hQZHisoRgBItTDupRmi3l79OUKL4Ef1efkIsT3A6WJuwXVbQRA==
X-Received: by 2002:a05:600c:2611:b0:3fe:21b9:806 with SMTP id h17-20020a05600c261100b003fe21b90806mr1970906wma.0.1693998684482;
        Wed, 06 Sep 2023 04:11:24 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c22d900b003fe2b6d64c8sm22744075wmg.21.2023.09.06.04.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 5/6] mnl_utils: introduce a helper to check if dump policy exists for command
Date: Wed,  6 Sep 2023 13:11:12 +0200
Message-ID: <20230906111113.690815-6-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Benefit from GET_POLICY command of ctrl netlink and introduce a helper
that dumps policies and finds out, if there is a separate policy
specified for dump op of specified command.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/mnl_utils.h |   1 +
 lib/mnl_utils.c     | 121 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index 2193934849e1..76fe1dfec938 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -30,5 +30,6 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 			 mnl_cb_t cb, void *data);
 int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
 			     void *data);
+int mnlu_gen_cmd_dump_policy(struct mnlu_gen_socket *nlg, uint8_t cmd);
 
 #endif /* __MNL_UTILS_H__ */
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index f8e07d2f467f..1c78222828ff 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -110,7 +110,7 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 	return err;
 }
 
-static int get_family_attrs_cb(const struct nlattr *attr, void *data)
+static int ctrl_attrs_cb(const struct nlattr *attr, void *data)
 {
 	int type = mnl_attr_get_type(attr);
 	const struct nlattr **tb = data;
@@ -124,6 +124,12 @@ static int get_family_attrs_cb(const struct nlattr *attr, void *data)
 	if (type == CTRL_ATTR_MAXATTR &&
 	    mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
 		return MNL_CB_ERROR;
+	if (type == CTRL_ATTR_POLICY &&
+	    mnl_attr_validate(attr, MNL_TYPE_NESTED) < 0)
+		return MNL_CB_ERROR;
+	if (type == CTRL_ATTR_OP_POLICY &&
+	    mnl_attr_validate(attr, MNL_TYPE_NESTED) < 0)
+		return MNL_CB_ERROR;
 	tb[type] = attr;
 	return MNL_CB_OK;
 }
@@ -134,7 +140,7 @@ static int get_family_cb(const struct nlmsghdr *nlh, void *data)
 	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
 	struct mnlu_gen_socket *nlg = data;
 
-	mnl_attr_parse(nlh, sizeof(*genl), get_family_attrs_cb, tb);
+	mnl_attr_parse(nlh, sizeof(*genl), ctrl_attrs_cb, tb);
 	if (!tb[CTRL_ATTR_FAMILY_ID])
 		return MNL_CB_ERROR;
 	if (!tb[CTRL_ATTR_MAXATTR])
@@ -252,3 +258,114 @@ int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
 				    MNL_SOCKET_BUFFER_SIZE,
 				    cb, data);
 }
+
+static int ctrl_policy_attrs_cb(const struct nlattr *attr, void *data)
+{
+	int type = mnl_attr_get_type(attr);
+	const struct nlattr **tb = data;
+
+	if (mnl_attr_type_valid(attr, CTRL_ATTR_POLICY_DUMP_MAX) < 0)
+		return MNL_CB_ERROR;
+
+	if (type == CTRL_ATTR_POLICY_DO &&
+	    mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
+		return MNL_CB_ERROR;
+	if (type == CTRL_ATTR_POLICY_DUMP &&
+	    mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
+		return MNL_CB_ERROR;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+struct cmd_dump_policy_ctx {
+	uint8_t cmd;
+	uint8_t do_policy_idx_found:1,
+		dump_policy_idx_found:1;
+	uint32_t do_policy_idx;
+	uint32_t dump_policy_idx;
+	uint32_t dump_policy_attr_count;
+};
+
+static void process_dump_op_policy_nest(const struct nlattr *op_policy_nest,
+					struct cmd_dump_policy_ctx *ctx)
+{
+	struct nlattr *tb[CTRL_ATTR_POLICY_DUMP_MAX + 1] = {};
+	const struct nlattr *attr;
+	int err;
+
+	mnl_attr_for_each_nested(attr, op_policy_nest) {
+		if (ctx->cmd != (attr->nla_type & ~NLA_F_NESTED))
+			continue;
+		err = mnl_attr_parse_nested(attr, ctrl_policy_attrs_cb, tb);
+		if (err != MNL_CB_OK)
+			continue;
+		if (tb[CTRL_ATTR_POLICY_DO]) {
+			ctx->do_policy_idx = mnl_attr_get_u32(tb[CTRL_ATTR_POLICY_DO]);
+			ctx->do_policy_idx_found = true;
+		}
+		if (tb[CTRL_ATTR_POLICY_DUMP]) {
+			ctx->dump_policy_idx = mnl_attr_get_u32(tb[CTRL_ATTR_POLICY_DUMP]);
+			ctx->dump_policy_idx_found = true;
+		}
+		break;
+	}
+}
+
+static void process_dump_policy_nest(const struct nlattr *policy_nest,
+				     struct cmd_dump_policy_ctx *ctx)
+{
+	const struct nlattr *attr;
+
+	if (!ctx->dump_policy_idx_found)
+		return;
+
+	mnl_attr_for_each_nested(attr, policy_nest)
+		if (ctx->dump_policy_idx == (attr->nla_type & ~NLA_F_NESTED))
+			ctx->dump_policy_attr_count++;
+}
+
+static int cmd_dump_policy_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
+	struct cmd_dump_policy_ctx *ctx = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), ctrl_attrs_cb, tb);
+	if (!tb[CTRL_ATTR_FAMILY_ID])
+		return MNL_CB_OK;
+
+	if (tb[CTRL_ATTR_OP_POLICY])
+		process_dump_op_policy_nest(tb[CTRL_ATTR_OP_POLICY], ctx);
+
+	if (tb[CTRL_ATTR_POLICY])
+		process_dump_policy_nest(tb[CTRL_ATTR_POLICY], ctx);
+
+	return MNL_CB_OK;
+}
+
+int mnlu_gen_cmd_dump_policy(struct mnlu_gen_socket *nlg, uint8_t cmd)
+{
+	struct cmd_dump_policy_ctx ctx = {
+		.cmd = cmd,
+	};
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = _mnlu_gen_socket_cmd_prepare(nlg, CTRL_CMD_GETPOLICY,
+					   NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP,
+					   GENL_ID_CTRL, 1);
+
+	mnl_attr_put_u16(nlh, CTRL_ATTR_FAMILY_ID, nlg->family);
+
+	err = mnlu_gen_socket_sndrcv(nlg, nlh, cmd_dump_policy_cb, &ctx);
+	if (err)
+		return err;
+
+	if (!ctx.dump_policy_idx_found || !ctx.do_policy_idx_found ||
+	    ctx.do_policy_idx == ctx.dump_policy_idx ||
+	    !ctx.dump_policy_attr_count)
+		return -ENOTSUP;
+
+	return 0;
+}
-- 
2.41.0


