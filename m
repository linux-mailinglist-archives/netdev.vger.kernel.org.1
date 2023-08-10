Return-Path: <netdev+bounces-26355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B877796D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA411C20A19
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BF1E1D0;
	Thu, 10 Aug 2023 13:16:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D01E1A1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:16:05 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1D10E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-3110ab7110aso850975f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673360; x=1692278160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVx5QoL3N/B6l5cozLy9xY0xvhpe+q9qrN0u61Edphw=;
        b=Dmc7Zq2toYseG3eXpHBrOd1ZKTGskzI06mmGKq2WHVc6w4gwfiRKKbHWPycaZUXRmr
         Kw5bWucb2HnOHOPGTiT6nQ7E2TH+Ovx/iAS865fmmdjogi5w05YQC46bgtq29t3JAO3l
         bVhjHyWWdIBhJAi/gQVndRCBQhy7wXveT7gDHGhfq6EE7X/MqXpafmIjdOUewdXHgOYm
         tx5idy+QYEfcWeVG9T6VsB8zbUUyYY474hSj0uDc9nB2SZ/YNKnzKDXBqrGJl77gEEw0
         S3yWoM0Ajo+Uf0PYFeWYwehAW8tq8X5LI+HDQwtcCAKwtyfnnFnhpP51S2soak5Vs0Ne
         8EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673360; x=1692278160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVx5QoL3N/B6l5cozLy9xY0xvhpe+q9qrN0u61Edphw=;
        b=TvoQNw8kuEPCK47fujCQryrcxQHh/5I91mOEOjSW2uD5aygQZWLra8YT6a7TfWpATG
         m72YDeE/1TAGkr5WY5wc0xPKP11BlZeN8ybm+sCG01GR0baMjXNcq3DiLnAnhwnXEQ45
         KTCwPK8muuTfK6VkiPnbtlodzkywT3uwU0OYphur/NMJd04eRhasNkjlqWFpq1tS1sOy
         T9+2tPKTTvE8NMigbRczv2F1aanC19oskdqconYL5fwvg4gYX07b8UGuggCDmdEGmNo8
         WiP9k9nKePvWMH7Lf9mBjcQUQ2mhV4OenlgxtEsRUdMAkvgaLvrZB4FHhGDR9RbLUT7c
         t1WQ==
X-Gm-Message-State: AOJu0YynngTdedQk4yc6FAshWEWlJDliI3UMcxqMa1dF6bPHitxjBh/d
	UZV5kNcH9Gy4tgXSqaExNftJ8JSJL/3RsP2a6H/MkBT1
X-Google-Smtp-Source: AGHT+IF1/BOE17fxaraZpOaOoy+FVmmRKdPlXtZkq6BLn/BQUAt55xV/PIIJ0AZ7XgA5KBpRH7b7yA==
X-Received: by 2002:adf:f74c:0:b0:313:f5e9:13ec with SMTP id z12-20020adff74c000000b00313f5e913ecmr1969853wrp.68.1691673360530;
        Thu, 10 Aug 2023 06:16:00 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id m13-20020a056000008d00b0031779e82414sm2162605wrx.79.2023.08.10.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:16:00 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v3 11/13] netlink: specs: devlink: extend per-instance dump commands to accept instance attributes
Date: Thu, 10 Aug 2023 15:15:37 +0200
Message-ID: <20230810131539.1602299-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810131539.1602299-1-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
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

Extend per-instance dump command definitions to accept instance
attributes. Allow parsing of devlink handle attributes so they could
be used for instance selection.

Re-generate the related code.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 Documentation/netlink/specs/devlink.yaml |  39 +-
 net/devlink/netlink_gen.c                | 169 +++++--
 tools/net/ynl/generated/devlink-user.c   | 123 ++++-
 tools/net/ynl/generated/devlink-user.h   | 546 ++++++++++++++++++++++-
 4 files changed, 799 insertions(+), 78 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 4f2aa48017a7..6dbebeebd63e 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -284,7 +284,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit-port
@@ -299,6 +298,8 @@ operations:
           value: 7
           attributes: *port-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply:
           value: 3  # due to a bug, port dump returns DEVLINK_CMD_NEW
           attributes: *port-id-attrs
@@ -311,7 +312,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -326,6 +326,8 @@ operations:
           value: 11
           attributes: *sb-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *sb-get-reply
 
       # TODO: fill in the operations in between
@@ -336,7 +338,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -352,6 +353,8 @@ operations:
           value: 15
           attributes: *sb-pool-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *sb-pool-get-reply
 
       # TODO: fill in the operations in between
@@ -362,7 +365,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit-port
@@ -379,6 +381,8 @@ operations:
           value: 19
           attributes: *sb-port-pool-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *sb-port-pool-get-reply
 
       # TODO: fill in the operations in between
@@ -389,7 +393,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit-port
@@ -407,6 +410,8 @@ operations:
           value: 23
           attributes: *sb-tc-pool-bind-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *sb-tc-pool-bind-get-reply
 
       # TODO: fill in the operations in between
@@ -417,7 +422,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -432,6 +436,8 @@ operations:
           value: 38
           attributes: *param-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *param-get-reply
 
       # TODO: fill in the operations in between
@@ -442,7 +448,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit-port-optional
@@ -458,6 +463,8 @@ operations:
           value: 42
           attributes: *region-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *region-get-reply
 
       # TODO: fill in the operations in between
@@ -495,7 +502,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit-port-optional
@@ -509,6 +515,8 @@ operations:
         reply: &health-reporter-get-reply
           attributes: *health-reporter-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *health-reporter-get-reply
 
       # TODO: fill in the operations in between
@@ -519,7 +527,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -534,6 +541,8 @@ operations:
           value: 61
           attributes: *trap-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *trap-get-reply
 
       # TODO: fill in the operations in between
@@ -544,7 +553,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -559,6 +567,8 @@ operations:
           value: 65
           attributes: *trap-group-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *trap-group-get-reply
 
       # TODO: fill in the operations in between
@@ -569,7 +579,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -584,6 +593,8 @@ operations:
           value: 69
           attributes: *trap-policer-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *trap-policer-get-reply
 
       # TODO: fill in the operations in between
@@ -594,7 +605,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -610,6 +620,8 @@ operations:
           value: 74
           attributes: *rate-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *rate-get-reply
 
       # TODO: fill in the operations in between
@@ -620,7 +632,6 @@ operations:
       attribute-set: devlink
       dont-validate:
         - strict
-        - dump
 
       do:
         pre: devlink-nl-pre-doit
@@ -635,6 +646,8 @@ operations:
           value: 78
           attributes: *linecard-id-attrs
       dump:
+        request:
+          attributes: *dev-id-attrs
         reply: *linecard-get-reply
 
       # TODO: fill in the operations in between
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index e384b91b2e3b..5f3e980c6a7c 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -17,29 +17,47 @@ static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1]
 };
 
 /* DEVLINK_CMD_PORT_GET - do */
-static const struct nla_policy devlink_port_get_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_PORT_GET - dump */
+static const struct nla_policy devlink_port_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_SB_GET - do */
-static const struct nla_policy devlink_sb_get_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_get_do_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_SB_GET - dump */
+static const struct nla_policy devlink_sb_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_SB_POOL_GET - do */
-static const struct nla_policy devlink_sb_pool_get_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
+static const struct nla_policy devlink_sb_pool_get_do_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 };
 
+/* DEVLINK_CMD_SB_POOL_GET - dump */
+static const struct nla_policy devlink_sb_pool_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_SB_PORT_POOL_GET - do */
-static const struct nla_policy devlink_sb_port_pool_get_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
+static const struct nla_policy devlink_sb_port_pool_get_do_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -47,8 +65,14 @@ static const struct nla_policy devlink_sb_port_pool_get_nl_policy[DEVLINK_ATTR_S
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 };
 
+/* DEVLINK_CMD_SB_PORT_POOL_GET - dump */
+static const struct nla_policy devlink_sb_port_pool_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - do */
-static const struct nla_policy devlink_sb_tc_pool_bind_get_nl_policy[DEVLINK_ATTR_SB_TC_INDEX + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_ATTR_SB_TC_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -57,21 +81,39 @@ static const struct nla_policy devlink_sb_tc_pool_bind_get_nl_policy[DEVLINK_ATT
 	[DEVLINK_ATTR_SB_TC_INDEX] = { .type = NLA_U16, },
 };
 
+/* DEVLINK_CMD_SB_TC_POOL_BIND_GET - dump */
+static const struct nla_policy devlink_sb_tc_pool_bind_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_PARAM_GET - do */
-static const struct nla_policy devlink_param_get_nl_policy[DEVLINK_ATTR_PARAM_NAME + 1] = {
+static const struct nla_policy devlink_param_get_do_nl_policy[DEVLINK_ATTR_PARAM_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+/* DEVLINK_CMD_PARAM_GET - dump */
+static const struct nla_policy devlink_param_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_REGION_GET - do */
-static const struct nla_policy devlink_region_get_nl_policy[DEVLINK_ATTR_REGION_NAME + 1] = {
+static const struct nla_policy devlink_region_get_do_nl_policy[DEVLINK_ATTR_REGION_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+/* DEVLINK_CMD_REGION_GET - dump */
+static const struct nla_policy devlink_region_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_INFO_GET - do */
 static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
@@ -79,49 +121,85 @@ static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - do */
-static const struct nla_policy devlink_health_reporter_get_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_get_do_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+/* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
+static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_TRAP_GET - do */
-static const struct nla_policy devlink_trap_get_nl_policy[DEVLINK_ATTR_TRAP_NAME + 1] = {
+static const struct nla_policy devlink_trap_get_do_nl_policy[DEVLINK_ATTR_TRAP_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+/* DEVLINK_CMD_TRAP_GET - dump */
+static const struct nla_policy devlink_trap_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_TRAP_GROUP_GET - do */
-static const struct nla_policy devlink_trap_group_get_nl_policy[DEVLINK_ATTR_TRAP_GROUP_NAME + 1] = {
+static const struct nla_policy devlink_trap_group_get_do_nl_policy[DEVLINK_ATTR_TRAP_GROUP_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+/* DEVLINK_CMD_TRAP_GROUP_GET - dump */
+static const struct nla_policy devlink_trap_group_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_TRAP_POLICER_GET - do */
-static const struct nla_policy devlink_trap_policer_get_nl_policy[DEVLINK_ATTR_TRAP_POLICER_ID + 1] = {
+static const struct nla_policy devlink_trap_policer_get_do_nl_policy[DEVLINK_ATTR_TRAP_POLICER_ID + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_TRAP_POLICER_GET - dump */
+static const struct nla_policy devlink_trap_policer_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_RATE_GET - do */
-static const struct nla_policy devlink_rate_get_nl_policy[DEVLINK_ATTR_RATE_NODE_NAME + 1] = {
+static const struct nla_policy devlink_rate_get_do_nl_policy[DEVLINK_ATTR_RATE_NODE_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+/* DEVLINK_CMD_RATE_GET - dump */
+static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_LINECARD_GET - do */
-static const struct nla_policy devlink_linecard_get_nl_policy[DEVLINK_ATTR_LINECARD_INDEX + 1] = {
+static const struct nla_policy devlink_linecard_get_do_nl_policy[DEVLINK_ATTR_LINECARD_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_LINECARD_GET - dump */
+static const struct nla_policy devlink_linecard_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* DEVLINK_CMD_SELFTESTS_GET - do */
 static const struct nla_policy devlink_selftests_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
@@ -152,14 +230,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit_port,
 		.doit		= devlink_nl_port_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_port_get_nl_policy,
+		.policy		= devlink_port_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_PORT_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_port_get_dumpit,
+		.policy		= devlink_port_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -168,14 +247,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_sb_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_sb_get_nl_policy,
+		.policy		= devlink_sb_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_SB_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_sb_get_dumpit,
+		.policy		= devlink_sb_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -184,14 +264,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_sb_pool_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_sb_pool_get_nl_policy,
+		.policy		= devlink_sb_pool_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_SB_POOL_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_POOL_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_sb_pool_get_dumpit,
+		.policy		= devlink_sb_pool_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -200,14 +281,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit_port,
 		.doit		= devlink_nl_sb_port_pool_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_sb_port_pool_get_nl_policy,
+		.policy		= devlink_sb_port_pool_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_SB_POOL_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_PORT_POOL_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_sb_port_pool_get_dumpit,
+		.policy		= devlink_sb_port_pool_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -216,14 +298,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit_port,
 		.doit		= devlink_nl_sb_tc_pool_bind_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_sb_tc_pool_bind_get_nl_policy,
+		.policy		= devlink_sb_tc_pool_bind_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_SB_TC_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_TC_POOL_BIND_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_sb_tc_pool_bind_get_dumpit,
+		.policy		= devlink_sb_tc_pool_bind_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -232,14 +315,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_param_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_param_get_nl_policy,
+		.policy		= devlink_param_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_PARAM_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_PARAM_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_param_get_dumpit,
+		.policy		= devlink_param_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -248,14 +332,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit_port_optional,
 		.doit		= devlink_nl_region_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_region_get_nl_policy,
+		.policy		= devlink_region_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_REGION_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_REGION_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_region_get_dumpit,
+		.policy		= devlink_region_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -280,14 +365,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit_port_optional,
 		.doit		= devlink_nl_health_reporter_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_health_reporter_get_nl_policy,
+		.policy		= devlink_health_reporter_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_HEALTH_REPORTER_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_health_reporter_get_dumpit,
+		.policy		= devlink_health_reporter_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -296,14 +382,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_trap_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_trap_get_nl_policy,
+		.policy		= devlink_trap_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_TRAP_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_TRAP_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_trap_get_dumpit,
+		.policy		= devlink_trap_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -312,14 +399,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_trap_group_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_trap_group_get_nl_policy,
+		.policy		= devlink_trap_group_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_TRAP_GROUP_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_TRAP_GROUP_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_trap_group_get_dumpit,
+		.policy		= devlink_trap_group_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -328,14 +416,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_trap_policer_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_trap_policer_get_nl_policy,
+		.policy		= devlink_trap_policer_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_TRAP_POLICER_ID,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_TRAP_POLICER_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_trap_policer_get_dumpit,
+		.policy		= devlink_trap_policer_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -344,14 +433,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_rate_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_rate_get_nl_policy,
+		.policy		= devlink_rate_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_RATE_NODE_NAME,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_rate_get_dumpit,
+		.policy		= devlink_rate_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -360,14 +450,15 @@ const struct genl_split_ops devlink_nl_ops[32] = {
 		.pre_doit	= devlink_nl_pre_doit,
 		.doit		= devlink_nl_linecard_get_doit,
 		.post_doit	= devlink_nl_post_doit,
-		.policy		= devlink_linecard_get_nl_policy,
+		.policy		= devlink_linecard_get_do_nl_policy,
 		.maxattr	= DEVLINK_ATTR_LINECARD_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_LINECARD_GET,
-		.validate	= GENL_DONT_VALIDATE_DUMP,
 		.dumpit		= devlink_nl_linecard_get_dumpit,
+		.policy		= devlink_linecard_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index e9ab98b5ffe3..80ee9d24eb16 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -723,7 +723,9 @@ void devlink_port_get_rsp_list_free(struct devlink_port_get_rsp_list *rsp)
 	}
 }
 
-struct devlink_port_get_rsp_list *devlink_port_get_dump(struct ynl_sock *ys)
+struct devlink_port_get_rsp_list *
+devlink_port_get_dump(struct ynl_sock *ys,
+		      struct devlink_port_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -736,6 +738,12 @@ struct devlink_port_get_rsp_list *devlink_port_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_PORT_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -858,7 +866,8 @@ void devlink_sb_get_list_free(struct devlink_sb_get_list *rsp)
 	}
 }
 
-struct devlink_sb_get_list *devlink_sb_get_dump(struct ynl_sock *ys)
+struct devlink_sb_get_list *
+devlink_sb_get_dump(struct ynl_sock *ys, struct devlink_sb_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -871,6 +880,12 @@ struct devlink_sb_get_list *devlink_sb_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -1000,7 +1015,9 @@ void devlink_sb_pool_get_list_free(struct devlink_sb_pool_get_list *rsp)
 	}
 }
 
-struct devlink_sb_pool_get_list *devlink_sb_pool_get_dump(struct ynl_sock *ys)
+struct devlink_sb_pool_get_list *
+devlink_sb_pool_get_dump(struct ynl_sock *ys,
+			 struct devlink_sb_pool_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -1013,6 +1030,12 @@ struct devlink_sb_pool_get_list *devlink_sb_pool_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_POOL_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -1154,7 +1177,8 @@ devlink_sb_port_pool_get_list_free(struct devlink_sb_port_pool_get_list *rsp)
 }
 
 struct devlink_sb_port_pool_get_list *
-devlink_sb_port_pool_get_dump(struct ynl_sock *ys)
+devlink_sb_port_pool_get_dump(struct ynl_sock *ys,
+			      struct devlink_sb_port_pool_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -1167,6 +1191,12 @@ devlink_sb_port_pool_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_PORT_POOL_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -1316,7 +1346,8 @@ devlink_sb_tc_pool_bind_get_list_free(struct devlink_sb_tc_pool_bind_get_list *r
 }
 
 struct devlink_sb_tc_pool_bind_get_list *
-devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys)
+devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys,
+				 struct devlink_sb_tc_pool_bind_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -1329,6 +1360,12 @@ devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_TC_POOL_BIND_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -1460,7 +1497,9 @@ void devlink_param_get_list_free(struct devlink_param_get_list *rsp)
 	}
 }
 
-struct devlink_param_get_list *devlink_param_get_dump(struct ynl_sock *ys)
+struct devlink_param_get_list *
+devlink_param_get_dump(struct ynl_sock *ys,
+		       struct devlink_param_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -1473,6 +1512,12 @@ struct devlink_param_get_list *devlink_param_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_PARAM_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -1611,7 +1656,9 @@ void devlink_region_get_list_free(struct devlink_region_get_list *rsp)
 	}
 }
 
-struct devlink_region_get_list *devlink_region_get_dump(struct ynl_sock *ys)
+struct devlink_region_get_list *
+devlink_region_get_dump(struct ynl_sock *ys,
+			struct devlink_region_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -1624,6 +1671,12 @@ struct devlink_region_get_list *devlink_region_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_REGION_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -2006,7 +2059,8 @@ devlink_health_reporter_get_list_free(struct devlink_health_reporter_get_list *r
 }
 
 struct devlink_health_reporter_get_list *
-devlink_health_reporter_get_dump(struct ynl_sock *ys)
+devlink_health_reporter_get_dump(struct ynl_sock *ys,
+				 struct devlink_health_reporter_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -2019,6 +2073,12 @@ devlink_health_reporter_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -2150,7 +2210,9 @@ void devlink_trap_get_list_free(struct devlink_trap_get_list *rsp)
 	}
 }
 
-struct devlink_trap_get_list *devlink_trap_get_dump(struct ynl_sock *ys)
+struct devlink_trap_get_list *
+devlink_trap_get_dump(struct ynl_sock *ys,
+		      struct devlink_trap_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -2163,6 +2225,12 @@ struct devlink_trap_get_list *devlink_trap_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -2296,7 +2364,8 @@ void devlink_trap_group_get_list_free(struct devlink_trap_group_get_list *rsp)
 }
 
 struct devlink_trap_group_get_list *
-devlink_trap_group_get_dump(struct ynl_sock *ys)
+devlink_trap_group_get_dump(struct ynl_sock *ys,
+			    struct devlink_trap_group_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -2309,6 +2378,12 @@ devlink_trap_group_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GROUP_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -2436,7 +2511,8 @@ devlink_trap_policer_get_list_free(struct devlink_trap_policer_get_list *rsp)
 }
 
 struct devlink_trap_policer_get_list *
-devlink_trap_policer_get_dump(struct ynl_sock *ys)
+devlink_trap_policer_get_dump(struct ynl_sock *ys,
+			      struct devlink_trap_policer_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -2449,6 +2525,12 @@ devlink_trap_policer_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_POLICER_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -2587,7 +2669,9 @@ void devlink_rate_get_list_free(struct devlink_rate_get_list *rsp)
 	}
 }
 
-struct devlink_rate_get_list *devlink_rate_get_dump(struct ynl_sock *ys)
+struct devlink_rate_get_list *
+devlink_rate_get_dump(struct ynl_sock *ys,
+		      struct devlink_rate_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -2600,6 +2684,12 @@ struct devlink_rate_get_list *devlink_rate_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_RATE_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
@@ -2723,7 +2813,8 @@ void devlink_linecard_get_list_free(struct devlink_linecard_get_list *rsp)
 }
 
 struct devlink_linecard_get_list *
-devlink_linecard_get_dump(struct ynl_sock *ys)
+devlink_linecard_get_dump(struct ynl_sock *ys,
+			  struct devlink_linecard_get_req_dump *req)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
@@ -2736,6 +2827,12 @@ devlink_linecard_get_dump(struct ynl_sock *ys)
 	yds.rsp_policy = &devlink_nest;
 
 	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_LINECARD_GET, 1);
+	ys->req_policy = &devlink_nest;
+
+	if (req->_present.bus_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
+	if (req->_present.dev_name_len)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
 
 	err = ynl_exec_dump(ys, nlh, &yds);
 	if (err < 0)
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index f6ec5b6e5d26..12530f1795ca 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -210,6 +210,44 @@ struct devlink_port_get_rsp *
 devlink_port_get(struct ynl_sock *ys, struct devlink_port_get_req *req);
 
 /* DEVLINK_CMD_PORT_GET - dump */
+struct devlink_port_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_port_get_req_dump *
+devlink_port_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_port_get_req_dump));
+}
+void devlink_port_get_req_dump_free(struct devlink_port_get_req_dump *req);
+
+static inline void
+devlink_port_get_req_dump_set_bus_name(struct devlink_port_get_req_dump *req,
+				       const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_port_get_req_dump_set_dev_name(struct devlink_port_get_req_dump *req,
+				       const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_port_get_rsp_dump {
 	struct {
 		__u32 bus_name_len;
@@ -229,7 +267,9 @@ struct devlink_port_get_rsp_list {
 
 void devlink_port_get_rsp_list_free(struct devlink_port_get_rsp_list *rsp);
 
-struct devlink_port_get_rsp_list *devlink_port_get_dump(struct ynl_sock *ys);
+struct devlink_port_get_rsp_list *
+devlink_port_get_dump(struct ynl_sock *ys,
+		      struct devlink_port_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_SB_GET ============== */
 /* DEVLINK_CMD_SB_GET - do */
@@ -299,6 +339,44 @@ struct devlink_sb_get_rsp *
 devlink_sb_get(struct ynl_sock *ys, struct devlink_sb_get_req *req);
 
 /* DEVLINK_CMD_SB_GET - dump */
+struct devlink_sb_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_sb_get_req_dump *
+devlink_sb_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_sb_get_req_dump));
+}
+void devlink_sb_get_req_dump_free(struct devlink_sb_get_req_dump *req);
+
+static inline void
+devlink_sb_get_req_dump_set_bus_name(struct devlink_sb_get_req_dump *req,
+				     const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_sb_get_req_dump_set_dev_name(struct devlink_sb_get_req_dump *req,
+				     const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_sb_get_list {
 	struct devlink_sb_get_list *next;
 	struct devlink_sb_get_rsp obj __attribute__ ((aligned (8)));
@@ -306,7 +384,8 @@ struct devlink_sb_get_list {
 
 void devlink_sb_get_list_free(struct devlink_sb_get_list *rsp);
 
-struct devlink_sb_get_list *devlink_sb_get_dump(struct ynl_sock *ys);
+struct devlink_sb_get_list *
+devlink_sb_get_dump(struct ynl_sock *ys, struct devlink_sb_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_SB_POOL_GET ============== */
 /* DEVLINK_CMD_SB_POOL_GET - do */
@@ -389,6 +468,45 @@ struct devlink_sb_pool_get_rsp *
 devlink_sb_pool_get(struct ynl_sock *ys, struct devlink_sb_pool_get_req *req);
 
 /* DEVLINK_CMD_SB_POOL_GET - dump */
+struct devlink_sb_pool_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_sb_pool_get_req_dump *
+devlink_sb_pool_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_sb_pool_get_req_dump));
+}
+void
+devlink_sb_pool_get_req_dump_free(struct devlink_sb_pool_get_req_dump *req);
+
+static inline void
+devlink_sb_pool_get_req_dump_set_bus_name(struct devlink_sb_pool_get_req_dump *req,
+					  const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_sb_pool_get_req_dump_set_dev_name(struct devlink_sb_pool_get_req_dump *req,
+					  const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_sb_pool_get_list {
 	struct devlink_sb_pool_get_list *next;
 	struct devlink_sb_pool_get_rsp obj __attribute__ ((aligned (8)));
@@ -396,7 +514,9 @@ struct devlink_sb_pool_get_list {
 
 void devlink_sb_pool_get_list_free(struct devlink_sb_pool_get_list *rsp);
 
-struct devlink_sb_pool_get_list *devlink_sb_pool_get_dump(struct ynl_sock *ys);
+struct devlink_sb_pool_get_list *
+devlink_sb_pool_get_dump(struct ynl_sock *ys,
+			 struct devlink_sb_pool_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_SB_PORT_POOL_GET ============== */
 /* DEVLINK_CMD_SB_PORT_POOL_GET - do */
@@ -493,6 +613,45 @@ devlink_sb_port_pool_get(struct ynl_sock *ys,
 			 struct devlink_sb_port_pool_get_req *req);
 
 /* DEVLINK_CMD_SB_PORT_POOL_GET - dump */
+struct devlink_sb_port_pool_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_sb_port_pool_get_req_dump *
+devlink_sb_port_pool_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_sb_port_pool_get_req_dump));
+}
+void
+devlink_sb_port_pool_get_req_dump_free(struct devlink_sb_port_pool_get_req_dump *req);
+
+static inline void
+devlink_sb_port_pool_get_req_dump_set_bus_name(struct devlink_sb_port_pool_get_req_dump *req,
+					       const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_sb_port_pool_get_req_dump_set_dev_name(struct devlink_sb_port_pool_get_req_dump *req,
+					       const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_sb_port_pool_get_list {
 	struct devlink_sb_port_pool_get_list *next;
 	struct devlink_sb_port_pool_get_rsp obj __attribute__ ((aligned (8)));
@@ -502,7 +661,8 @@ void
 devlink_sb_port_pool_get_list_free(struct devlink_sb_port_pool_get_list *rsp);
 
 struct devlink_sb_port_pool_get_list *
-devlink_sb_port_pool_get_dump(struct ynl_sock *ys);
+devlink_sb_port_pool_get_dump(struct ynl_sock *ys,
+			      struct devlink_sb_port_pool_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_SB_TC_POOL_BIND_GET ============== */
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - do */
@@ -610,6 +770,45 @@ devlink_sb_tc_pool_bind_get(struct ynl_sock *ys,
 			    struct devlink_sb_tc_pool_bind_get_req *req);
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - dump */
+struct devlink_sb_tc_pool_bind_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_sb_tc_pool_bind_get_req_dump *
+devlink_sb_tc_pool_bind_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_sb_tc_pool_bind_get_req_dump));
+}
+void
+devlink_sb_tc_pool_bind_get_req_dump_free(struct devlink_sb_tc_pool_bind_get_req_dump *req);
+
+static inline void
+devlink_sb_tc_pool_bind_get_req_dump_set_bus_name(struct devlink_sb_tc_pool_bind_get_req_dump *req,
+						  const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_sb_tc_pool_bind_get_req_dump_set_dev_name(struct devlink_sb_tc_pool_bind_get_req_dump *req,
+						  const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_sb_tc_pool_bind_get_list {
 	struct devlink_sb_tc_pool_bind_get_list *next;
 	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__ ((aligned (8)));
@@ -619,7 +818,8 @@ void
 devlink_sb_tc_pool_bind_get_list_free(struct devlink_sb_tc_pool_bind_get_list *rsp);
 
 struct devlink_sb_tc_pool_bind_get_list *
-devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys);
+devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys,
+				 struct devlink_sb_tc_pool_bind_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_PARAM_GET ============== */
 /* DEVLINK_CMD_PARAM_GET - do */
@@ -693,6 +893,44 @@ struct devlink_param_get_rsp *
 devlink_param_get(struct ynl_sock *ys, struct devlink_param_get_req *req);
 
 /* DEVLINK_CMD_PARAM_GET - dump */
+struct devlink_param_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_param_get_req_dump *
+devlink_param_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_param_get_req_dump));
+}
+void devlink_param_get_req_dump_free(struct devlink_param_get_req_dump *req);
+
+static inline void
+devlink_param_get_req_dump_set_bus_name(struct devlink_param_get_req_dump *req,
+					const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_param_get_req_dump_set_dev_name(struct devlink_param_get_req_dump *req,
+					const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_param_get_list {
 	struct devlink_param_get_list *next;
 	struct devlink_param_get_rsp obj __attribute__ ((aligned (8)));
@@ -700,7 +938,9 @@ struct devlink_param_get_list {
 
 void devlink_param_get_list_free(struct devlink_param_get_list *rsp);
 
-struct devlink_param_get_list *devlink_param_get_dump(struct ynl_sock *ys);
+struct devlink_param_get_list *
+devlink_param_get_dump(struct ynl_sock *ys,
+		       struct devlink_param_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_REGION_GET ============== */
 /* DEVLINK_CMD_REGION_GET - do */
@@ -785,6 +1025,44 @@ struct devlink_region_get_rsp *
 devlink_region_get(struct ynl_sock *ys, struct devlink_region_get_req *req);
 
 /* DEVLINK_CMD_REGION_GET - dump */
+struct devlink_region_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_region_get_req_dump *
+devlink_region_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_region_get_req_dump));
+}
+void devlink_region_get_req_dump_free(struct devlink_region_get_req_dump *req);
+
+static inline void
+devlink_region_get_req_dump_set_bus_name(struct devlink_region_get_req_dump *req,
+					 const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_region_get_req_dump_set_dev_name(struct devlink_region_get_req_dump *req,
+					 const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_region_get_list {
 	struct devlink_region_get_list *next;
 	struct devlink_region_get_rsp obj __attribute__ ((aligned (8)));
@@ -792,7 +1070,9 @@ struct devlink_region_get_list {
 
 void devlink_region_get_list_free(struct devlink_region_get_list *rsp);
 
-struct devlink_region_get_list *devlink_region_get_dump(struct ynl_sock *ys);
+struct devlink_region_get_list *
+devlink_region_get_dump(struct ynl_sock *ys,
+			struct devlink_region_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_INFO_GET ============== */
 /* DEVLINK_CMD_INFO_GET - do */
@@ -958,6 +1238,45 @@ devlink_health_reporter_get(struct ynl_sock *ys,
 			    struct devlink_health_reporter_get_req *req);
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
+struct devlink_health_reporter_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_health_reporter_get_req_dump *
+devlink_health_reporter_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_health_reporter_get_req_dump));
+}
+void
+devlink_health_reporter_get_req_dump_free(struct devlink_health_reporter_get_req_dump *req);
+
+static inline void
+devlink_health_reporter_get_req_dump_set_bus_name(struct devlink_health_reporter_get_req_dump *req,
+						  const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_health_reporter_get_req_dump_set_dev_name(struct devlink_health_reporter_get_req_dump *req,
+						  const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_health_reporter_get_list {
 	struct devlink_health_reporter_get_list *next;
 	struct devlink_health_reporter_get_rsp obj __attribute__ ((aligned (8)));
@@ -967,7 +1286,8 @@ void
 devlink_health_reporter_get_list_free(struct devlink_health_reporter_get_list *rsp);
 
 struct devlink_health_reporter_get_list *
-devlink_health_reporter_get_dump(struct ynl_sock *ys);
+devlink_health_reporter_get_dump(struct ynl_sock *ys,
+				 struct devlink_health_reporter_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_TRAP_GET ============== */
 /* DEVLINK_CMD_TRAP_GET - do */
@@ -1041,6 +1361,44 @@ struct devlink_trap_get_rsp *
 devlink_trap_get(struct ynl_sock *ys, struct devlink_trap_get_req *req);
 
 /* DEVLINK_CMD_TRAP_GET - dump */
+struct devlink_trap_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_trap_get_req_dump *
+devlink_trap_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_trap_get_req_dump));
+}
+void devlink_trap_get_req_dump_free(struct devlink_trap_get_req_dump *req);
+
+static inline void
+devlink_trap_get_req_dump_set_bus_name(struct devlink_trap_get_req_dump *req,
+				       const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_trap_get_req_dump_set_dev_name(struct devlink_trap_get_req_dump *req,
+				       const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_trap_get_list {
 	struct devlink_trap_get_list *next;
 	struct devlink_trap_get_rsp obj __attribute__ ((aligned (8)));
@@ -1048,7 +1406,9 @@ struct devlink_trap_get_list {
 
 void devlink_trap_get_list_free(struct devlink_trap_get_list *rsp);
 
-struct devlink_trap_get_list *devlink_trap_get_dump(struct ynl_sock *ys);
+struct devlink_trap_get_list *
+devlink_trap_get_dump(struct ynl_sock *ys,
+		      struct devlink_trap_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_TRAP_GROUP_GET ============== */
 /* DEVLINK_CMD_TRAP_GROUP_GET - do */
@@ -1124,6 +1484,45 @@ devlink_trap_group_get(struct ynl_sock *ys,
 		       struct devlink_trap_group_get_req *req);
 
 /* DEVLINK_CMD_TRAP_GROUP_GET - dump */
+struct devlink_trap_group_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_trap_group_get_req_dump *
+devlink_trap_group_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_trap_group_get_req_dump));
+}
+void
+devlink_trap_group_get_req_dump_free(struct devlink_trap_group_get_req_dump *req);
+
+static inline void
+devlink_trap_group_get_req_dump_set_bus_name(struct devlink_trap_group_get_req_dump *req,
+					     const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_trap_group_get_req_dump_set_dev_name(struct devlink_trap_group_get_req_dump *req,
+					     const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_trap_group_get_list {
 	struct devlink_trap_group_get_list *next;
 	struct devlink_trap_group_get_rsp obj __attribute__ ((aligned (8)));
@@ -1132,7 +1531,8 @@ struct devlink_trap_group_get_list {
 void devlink_trap_group_get_list_free(struct devlink_trap_group_get_list *rsp);
 
 struct devlink_trap_group_get_list *
-devlink_trap_group_get_dump(struct ynl_sock *ys);
+devlink_trap_group_get_dump(struct ynl_sock *ys,
+			    struct devlink_trap_group_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_TRAP_POLICER_GET ============== */
 /* DEVLINK_CMD_TRAP_POLICER_GET - do */
@@ -1207,6 +1607,45 @@ devlink_trap_policer_get(struct ynl_sock *ys,
 			 struct devlink_trap_policer_get_req *req);
 
 /* DEVLINK_CMD_TRAP_POLICER_GET - dump */
+struct devlink_trap_policer_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_trap_policer_get_req_dump *
+devlink_trap_policer_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_trap_policer_get_req_dump));
+}
+void
+devlink_trap_policer_get_req_dump_free(struct devlink_trap_policer_get_req_dump *req);
+
+static inline void
+devlink_trap_policer_get_req_dump_set_bus_name(struct devlink_trap_policer_get_req_dump *req,
+					       const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_trap_policer_get_req_dump_set_dev_name(struct devlink_trap_policer_get_req_dump *req,
+					       const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_trap_policer_get_list {
 	struct devlink_trap_policer_get_list *next;
 	struct devlink_trap_policer_get_rsp obj __attribute__ ((aligned (8)));
@@ -1216,7 +1655,8 @@ void
 devlink_trap_policer_get_list_free(struct devlink_trap_policer_get_list *rsp);
 
 struct devlink_trap_policer_get_list *
-devlink_trap_policer_get_dump(struct ynl_sock *ys);
+devlink_trap_policer_get_dump(struct ynl_sock *ys,
+			      struct devlink_trap_policer_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_RATE_GET ============== */
 /* DEVLINK_CMD_RATE_GET - do */
@@ -1301,6 +1741,44 @@ struct devlink_rate_get_rsp *
 devlink_rate_get(struct ynl_sock *ys, struct devlink_rate_get_req *req);
 
 /* DEVLINK_CMD_RATE_GET - dump */
+struct devlink_rate_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_rate_get_req_dump *
+devlink_rate_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_rate_get_req_dump));
+}
+void devlink_rate_get_req_dump_free(struct devlink_rate_get_req_dump *req);
+
+static inline void
+devlink_rate_get_req_dump_set_bus_name(struct devlink_rate_get_req_dump *req,
+				       const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_rate_get_req_dump_set_dev_name(struct devlink_rate_get_req_dump *req,
+				       const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_rate_get_list {
 	struct devlink_rate_get_list *next;
 	struct devlink_rate_get_rsp obj __attribute__ ((aligned (8)));
@@ -1308,7 +1786,9 @@ struct devlink_rate_get_list {
 
 void devlink_rate_get_list_free(struct devlink_rate_get_list *rsp);
 
-struct devlink_rate_get_list *devlink_rate_get_dump(struct ynl_sock *ys);
+struct devlink_rate_get_list *
+devlink_rate_get_dump(struct ynl_sock *ys,
+		      struct devlink_rate_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_LINECARD_GET ============== */
 /* DEVLINK_CMD_LINECARD_GET - do */
@@ -1380,6 +1860,45 @@ struct devlink_linecard_get_rsp *
 devlink_linecard_get(struct ynl_sock *ys, struct devlink_linecard_get_req *req);
 
 /* DEVLINK_CMD_LINECARD_GET - dump */
+struct devlink_linecard_get_req_dump {
+	struct {
+		__u32 bus_name_len;
+		__u32 dev_name_len;
+	} _present;
+
+	char *bus_name;
+	char *dev_name;
+};
+
+static inline struct devlink_linecard_get_req_dump *
+devlink_linecard_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct devlink_linecard_get_req_dump));
+}
+void
+devlink_linecard_get_req_dump_free(struct devlink_linecard_get_req_dump *req);
+
+static inline void
+devlink_linecard_get_req_dump_set_bus_name(struct devlink_linecard_get_req_dump *req,
+					   const char *bus_name)
+{
+	free(req->bus_name);
+	req->_present.bus_name_len = strlen(bus_name);
+	req->bus_name = malloc(req->_present.bus_name_len + 1);
+	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
+	req->bus_name[req->_present.bus_name_len] = 0;
+}
+static inline void
+devlink_linecard_get_req_dump_set_dev_name(struct devlink_linecard_get_req_dump *req,
+					   const char *dev_name)
+{
+	free(req->dev_name);
+	req->_present.dev_name_len = strlen(dev_name);
+	req->dev_name = malloc(req->_present.dev_name_len + 1);
+	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
+	req->dev_name[req->_present.dev_name_len] = 0;
+}
+
 struct devlink_linecard_get_list {
 	struct devlink_linecard_get_list *next;
 	struct devlink_linecard_get_rsp obj __attribute__ ((aligned (8)));
@@ -1388,7 +1907,8 @@ struct devlink_linecard_get_list {
 void devlink_linecard_get_list_free(struct devlink_linecard_get_list *rsp);
 
 struct devlink_linecard_get_list *
-devlink_linecard_get_dump(struct ynl_sock *ys);
+devlink_linecard_get_dump(struct ynl_sock *ys,
+			  struct devlink_linecard_get_req_dump *req);
 
 /* ============== DEVLINK_CMD_SELFTESTS_GET ============== */
 /* DEVLINK_CMD_SELFTESTS_GET - do */
-- 
2.41.0


