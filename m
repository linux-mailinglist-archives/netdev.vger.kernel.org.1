Return-Path: <netdev+bounces-39527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A27BF984
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF78281E03
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620018B09;
	Tue, 10 Oct 2023 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="twuRsdWv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD818AED
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:18:42 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92639107
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:18:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so9705484a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936716; x=1697541516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5afGkkeJDJQIwueDAOXQKmn2OfT88cQRGV1V2HneC5g=;
        b=twuRsdWvuuMssR92HO4nPDCX3VpPN68bVmWeUmUD8sz0GbOx8T4QlTbClwD7F4cdun
         A+spARkcO5VqiFxVekcmzLWLfOd6b6QeKsGTfs5brxP3fKOw5IyQeIhMOjbK9YX5HIWv
         QrDZVG9XxfaxXDaYwNM1q6NJpyychkk32FNd1GjL+bLU1EffM4YbLfJ5VhxflmOpE9y/
         hYXwPpori33284UyST4vLdhHLAkGXSA7hNCzQTImti8nixY20BhFNUstycCAofNdj9wo
         jaLG5C6JAztfHXjMaxHnTmbkIhARD6NZl02VZ881Zi7D4nWWAwjrKW9ANQKs0jvpOMIf
         n5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936716; x=1697541516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5afGkkeJDJQIwueDAOXQKmn2OfT88cQRGV1V2HneC5g=;
        b=CQDT+Sb0mD5uLGkRAAdm664Yl3Nklw2OiUuABbnrs2dSNTGN9CmZEpYpkD0MpZALIC
         VuQLGmr/W8dp+CuOkymMhu24sIqnIV2i6c1bDSllMxzV+vPi1/xa9GHIJoSKQhD6M/wq
         CgmNnyFwhNP1CvkrwOsiVhc/RRd4La398qfyJ22+J9YsI6pR/yiqctrBSoOVK3G8hU/h
         D5WLi8XVcesaij351jmiPxP13Dlrh4D0M+Y2GnSOf5M38/II4aHzwoplXAHCnvEO840t
         C7ZVZswV3C2Opr79I4QHPWfZKn+1WVpkaNvD0l0YZIUCg81jPkEPlL5/NEdCOfX9pwNm
         ZNdg==
X-Gm-Message-State: AOJu0YyGTGvaCqH4sV6mcj9y2scyM/zoKxzFavftQXkmWlBIxAaGXYgu
	YHIVSYeV/PaTs9c6wFPLdVSvjTUaDlp9/eiN9v8=
X-Google-Smtp-Source: AGHT+IG6y034tv7eLZbMDk/x/B3l3OvBY5lp1kwnYXPR4EvyHbEvFs3acaEJG5AtRI1Ni5Rz+/aFdg==
X-Received: by 2002:a17:906:1d7:b0:9ba:2fa1:a893 with SMTP id 23-20020a17090601d700b009ba2fa1a893mr3663151ejj.76.1696936715780;
        Tue, 10 Oct 2023 04:18:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090637cc00b0099bc80d5575sm8171135ejc.200.2023.10.10.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:18:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 10/10] devlink: remove netlink small_ops
Date: Tue, 10 Oct 2023 13:18:34 +0200
Message-ID: <20231010111834.201467-1-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

All commands are now covered by generated split_ops. Remove the
small_ops entirely alongside with unified devlink netlink policy array.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 328 +-----------------------------------------
 1 file changed, 1 insertion(+), 327 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index ca63e59a5e92..d0b90ebc8b15 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -13,75 +13,6 @@ static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
 };
 
-static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
-	[DEVLINK_ATTR_UNSPEC] = { .strict_start_type =
-		DEVLINK_ATTR_TRAP_POLICER_ID },
-	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_PORT_TYPE] = NLA_POLICY_RANGE(NLA_U16, DEVLINK_PORT_TYPE_AUTO,
-						    DEVLINK_PORT_TYPE_IB),
-	[DEVLINK_ATTR_PORT_SPLIT_COUNT] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16 },
-	[DEVLINK_ATTR_SB_POOL_TYPE] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_SB_POOL_SIZE] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_SB_THRESHOLD] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_SB_TC_INDEX] = { .type = NLA_U16 },
-	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_RANGE(NLA_U16, DEVLINK_ESWITCH_MODE_LEGACY,
-						       DEVLINK_ESWITCH_MODE_SWITCHDEV),
-	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_RESOURCE_ID] = { .type = NLA_U64},
-	[DEVLINK_ATTR_RESOURCE_SIZE] = { .type = NLA_U64},
-	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_PARAM_TYPE] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_REGION_CHUNK_ADDR] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_REGION_CHUNK_LEN] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK] =
-		NLA_POLICY_BITFIELD32(DEVLINK_SUPPORTED_FLASH_OVERWRITE_SECTIONS),
-	[DEVLINK_ATTR_TRAP_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_TRAP_ACTION] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_NETNS_PID] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_NETNS_FD] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_NETNS_ID] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .type = NLA_U8 },
-	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_TRAP_POLICER_RATE] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_TRAP_POLICER_BURST] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_PORT_FUNCTION] = { .type = NLA_NESTED },
-	[DEVLINK_ATTR_RELOAD_ACTION] = NLA_POLICY_RANGE(NLA_U8, DEVLINK_RELOAD_ACTION_DRIVER_REINIT,
-							DEVLINK_RELOAD_ACTION_MAX),
-	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(DEVLINK_RELOAD_LIMITS_VALID_MASK),
-	[DEVLINK_ATTR_PORT_FLAVOUR] = { .type = NLA_U16 },
-	[DEVLINK_ATTR_PORT_PCI_PF_NUMBER] = { .type = NLA_U16 },
-	[DEVLINK_ATTR_PORT_PCI_SF_NUMBER] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_PORT_CONTROLLER_NUMBER] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_RATE_TYPE] = { .type = NLA_U16 },
-	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64 },
-	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_LINECARD_INDEX] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_LINECARD_TYPE] = { .type = NLA_NUL_STRING },
-	[DEVLINK_ATTR_SELFTESTS] = { .type = NLA_NESTED },
-	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32 },
-	[DEVLINK_ATTR_REGION_DIRECT] = { .type = NLA_FLAG },
-};
-
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype)
 {
@@ -191,7 +122,7 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 			struct sk_buff *skb, struct genl_info *info)
 {
-	return __devlink_nl_pre_doit(skb, info, ops->internal_flags);
+	return __devlink_nl_pre_doit(skb, info, 0);
 }
 
 int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
@@ -287,269 +218,12 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		return devlink_nl_inst_iter_dumpit(msg, cb, flags, dump_one);
 }
 
-static const struct genl_small_ops devlink_nl_small_ops[40] = {
-	{
-		.cmd = DEVLINK_CMD_PORT_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_port_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_SET,
-		.doit = devlink_nl_rate_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_NEW,
-		.doit = devlink_nl_rate_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RATE_DEL,
-		.doit = devlink_nl_rate_del_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_SPLIT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_port_split_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_UNSPLIT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_port_unsplit_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_NEW,
-		.doit = devlink_nl_port_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_DEL,
-		.doit = devlink_nl_port_del_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-
-	{
-		.cmd = DEVLINK_CMD_LINECARD_SET,
-		.doit = devlink_nl_linecard_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_POOL_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_pool_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_PORT_POOL_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_port_pool_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_tc_pool_bind_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_OCC_SNAPSHOT,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_occ_snapshot_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SB_OCC_MAX_CLEAR,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_sb_occ_max_clear_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_ESWITCH_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_eswitch_get_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_ESWITCH_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_eswitch_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_TABLE_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_dpipe_table_get_doit,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_dpipe_entries_get_doit,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_HEADERS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_dpipe_headers_get_doit,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_dpipe_table_counters_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RESOURCE_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_resource_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_RESOURCE_DUMP,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_resource_dump_doit,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_RELOAD,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_reload_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PARAM_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_param_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_PARAM_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_port_param_get_doit,
-		.dumpit = devlink_nl_port_param_get_dumpit,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-		/* can be retrieved by unprivileged users */
-	},
-	{
-		.cmd = DEVLINK_CMD_PORT_PARAM_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_port_param_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_NEW,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_region_new_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_DEL,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_region_del_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_REGION_READ,
-		.validate = GENL_DONT_VALIDATE_STRICT |
-			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_region_read_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_SET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_health_reporter_set_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_RECOVER,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_health_reporter_recover_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_health_reporter_diagnose_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT |
-			    GENL_DONT_VALIDATE_DUMP_STRICT,
-		.dumpit = devlink_nl_health_reporter_dump_get_dumpit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_health_reporter_dump_clear_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_HEALTH_REPORTER_TEST,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_health_reporter_test_doit,
-		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
-	},
-	{
-		.cmd = DEVLINK_CMD_FLASH_UPDATE,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = devlink_nl_flash_update_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_SET,
-		.doit = devlink_nl_trap_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_GROUP_SET,
-		.doit = devlink_nl_trap_group_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_TRAP_POLICER_SET,
-		.doit = devlink_nl_trap_policer_set_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	{
-		.cmd = DEVLINK_CMD_SELFTESTS_RUN,
-		.doit = devlink_nl_selftests_run_doit,
-		.flags = GENL_ADMIN_PERM,
-	},
-	/* -- No new ops here! Use split ops going forward! -- */
-};
-
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
-	.maxattr	= DEVLINK_ATTR_MAX,
-	.policy		= devlink_nl_policy,
 	.netnsok	= true,
 	.parallel_ops	= true,
-	.pre_doit	= devlink_nl_pre_doit,
-	.post_doit	= devlink_nl_post_doit,
 	.module		= THIS_MODULE,
-	.small_ops	= devlink_nl_small_ops,
-	.n_small_ops	= ARRAY_SIZE(devlink_nl_small_ops),
 	.split_ops	= devlink_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
 	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
-- 
2.41.0


