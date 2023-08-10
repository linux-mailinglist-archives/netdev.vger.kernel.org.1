Return-Path: <netdev+bounces-26350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAE777963
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28914282055
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A61FB46;
	Thu, 10 Aug 2023 13:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F731E1C1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:56 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C410E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3175f17a7baso801875f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673350; x=1692278150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8C7D7+aX8P+jYoCsYMh2JmEfGuxehOU1+tyHgllx54=;
        b=p0QgVHXsr9BkwlLDeqnkcdR8Qo31SbKHosJzH9VjbO9+w4wn454LmjO+uKuxgvmgs2
         uSe0dMU9OHSS8BqrnlwszDU5pxvPe234RcJYmJoxHv7GOG5uQVR2S/Cljz9KOw25YRI4
         xp39oQ5cj/9hJV/AGOUpH8kQbSv98ve0/z/mIn+EDJWEWz+Asxag9zFAbX/725iKRa/e
         HB14J7Aw07BxY/PjrxEPYpe177OVDW7wTp+Qv0ay9EkspQzmHhnomLizZRlvn9HEsvLe
         3LahY/0Mdc6KmAn62djtEdYPhScaxTRKCwDH+Nx32vr2EAo2PdwejQxKM/c7rWxccrSQ
         C1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673350; x=1692278150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8C7D7+aX8P+jYoCsYMh2JmEfGuxehOU1+tyHgllx54=;
        b=T23gQt/mVNYngsk0i6drGoo4oIn7LbIyRZ0ZEFnl6VOq9hWyJog7WW9upQVZYm3Rvz
         qpj9jxLU3bg8sVIIPJo8l+KPEfqdbWx/Ibeo234WjJ3ZU4fqjLng4/CnKXB0wLYHIR5y
         P09Y3//mhDivDkID0Il+QjgDYDF2MKPPGkAPsBKqj6gmLvmC57M1jaswTEzscjAopjT1
         l6aRjNL8D2Figw04KM6+WvMeTuv/nmDLKm+c/4/DDrJS652LLM/cxLl3DQWD/RuOMB3U
         GtxqU8GFo88DwEcl4Iqp122a8SpBvHRUlIKTdB184A5droMrDO/WBVEZHfjksIWs/KiX
         AWUg==
X-Gm-Message-State: AOJu0YyhbuHus4sduQZtP/aoztckCn1kcxPyBDURR+xYVxduPhbIQOmH
	hE27q1Rbx2UfLTmpSaVSyLhfdDYaAW2Qzn3DWW6lFA==
X-Google-Smtp-Source: AGHT+IH4+6/oO3Ogrtq0wCGyioyxE7vNXzq3IF1iozu5wD4jia4jt5fcQapqxhT3a5CvvnZRf/ndPw==
X-Received: by 2002:adf:ef42:0:b0:314:10d8:b482 with SMTP id c2-20020adfef42000000b0031410d8b482mr2384499wrp.65.1691673349726;
        Thu, 10 Aug 2023 06:15:49 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d698d000000b003180027d67asm2172787wru.19.2023.08.10.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:49 -0700 (PDT)
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
Subject: [patch net-next v3 05/13] devlink: introduce dumpit callbacks for split ops
Date: Thu, 10 Aug 2023 15:15:31 +0200
Message-ID: <20230810131539.1602299-6-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Introduce dumpit callbacks for generated split ops. Have them
as a thin wrapper around iteration function and allow to pass dump_one()
function pointer directly without need to store in devlink_cmd structs.

Note that the function prototypes are temporary until the generated ones
will replace them in a follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/dev.c           |  15 +--
 net/devlink/devl_internal.h |  45 +++++----
 net/devlink/health.c        |  16 +--
 net/devlink/leftover.c      | 189 ++++++++++++++++++++----------------
 net/devlink/netlink.c       |  26 -----
 5 files changed, 144 insertions(+), 147 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 167fe6188d21..22e8ab3eaaa2 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1229,10 +1229,9 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
-static int
-devlink_nl_cmd_selftests_get_dump_one(struct sk_buff *msg,
-				      struct devlink *devlink,
-				      struct netlink_callback *cb)
+static int devlink_nl_selftests_get_dump_one(struct sk_buff *msg,
+					     struct devlink *devlink,
+					     struct netlink_callback *cb)
 {
 	if (!devlink->ops->selftest_check)
 		return 0;
@@ -1243,9 +1242,11 @@ devlink_nl_cmd_selftests_get_dump_one(struct sk_buff *msg,
 					 cb->extack);
 }
 
-const struct devlink_cmd devl_cmd_selftests_get = {
-	.dump_one		= devlink_nl_cmd_selftests_get_dump_one,
-};
+int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_selftests_get_dump_one);
+}
 
 static int devlink_selftest_result_put(struct sk_buff *skb, unsigned int id,
 				       enum devlink_selftest_status test_status)
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f29ec0bfc559..500c91c61b2d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -117,10 +117,6 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 				       struct devlink *devlink,
 				       struct netlink_callback *cb);
 
-struct devlink_cmd {
-	devlink_nl_dump_one_func_t *dump_one;
-};
-
 extern const struct genl_small_ops devlink_nl_small_ops[54];
 
 struct devlink *
@@ -131,7 +127,6 @@ void devlink_notify_register(struct devlink *devlink);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg, struct netlink_callback *cb);
 
 static inline struct devlink_nl_dump_state *
 devlink_dump_state(struct netlink_callback *cb)
@@ -151,22 +146,6 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 	return 0;
 }
 
-/* Commands */
-extern const struct devlink_cmd devl_cmd_port_get;
-extern const struct devlink_cmd devl_cmd_sb_get;
-extern const struct devlink_cmd devl_cmd_sb_pool_get;
-extern const struct devlink_cmd devl_cmd_sb_port_pool_get;
-extern const struct devlink_cmd devl_cmd_sb_tc_pool_bind_get;
-extern const struct devlink_cmd devl_cmd_param_get;
-extern const struct devlink_cmd devl_cmd_region_get;
-extern const struct devlink_cmd devl_cmd_health_reporter_get;
-extern const struct devlink_cmd devl_cmd_trap_get;
-extern const struct devlink_cmd devl_cmd_trap_group_get;
-extern const struct devlink_cmd devl_cmd_trap_policer_get;
-extern const struct devlink_cmd devl_cmd_rate_get;
-extern const struct devlink_cmd devl_cmd_linecard_get;
-extern const struct devlink_cmd devl_cmd_selftests_get;
-
 /* Notify */
 void devlink_notify(struct devlink *devlink, enum devlink_command cmd);
 
@@ -215,21 +194,40 @@ int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_port_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
 int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_sb_pool_get_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb);
 int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
 				     struct genl_info *info);
+int devlink_nl_sb_port_pool_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb);
 int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int devlink_nl_sb_tc_pool_bind_get_dumpit(struct sk_buff *skb,
+					  struct netlink_callback *cb);
 int devlink_nl_param_get_doit(struct sk_buff *skb,
 			      struct genl_info *info);
+int devlink_nl_param_get_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb);
 int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_region_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb);
 int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
+					  struct netlink_callback *cb);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
@@ -243,6 +241,11 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
 int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_trap_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int devlink_nl_trap_group_get_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb);
 int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
 				     struct genl_info *info);
+int devlink_nl_trap_policer_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 6df4e343d8c2..dbe2d6a1df3b 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -384,10 +384,9 @@ int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
 	return genlmsg_reply(msg, info);
 }
 
-static int
-devlink_nl_cmd_health_reporter_get_dump_one(struct sk_buff *msg,
-					    struct devlink *devlink,
-					    struct netlink_callback *cb)
+static int devlink_nl_health_reporter_get_dump_one(struct sk_buff *msg,
+						   struct devlink *devlink,
+						   struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
@@ -434,9 +433,12 @@ devlink_nl_cmd_health_reporter_get_dump_one(struct sk_buff *msg,
 	return 0;
 }
 
-const struct devlink_cmd devl_cmd_health_reporter_get = {
-	.dump_one		= devlink_nl_cmd_health_reporter_get_dump_one,
-};
+int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
+					  struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb,
+				 devlink_nl_health_reporter_get_dump_one);
+}
 
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info)
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index bd8fa2f9a05b..21f1058ef14d 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -1005,8 +1005,8 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 }
 
 static int
-devlink_nl_cmd_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				 struct netlink_callback *cb)
+devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			     struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_rate *devlink_rate;
@@ -1034,9 +1034,10 @@ devlink_nl_cmd_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_rate_get = {
-	.dump_one		= devlink_nl_cmd_rate_get_dump_one,
-};
+int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_rate_get_dump_one);
+}
 
 int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
@@ -1098,8 +1099,8 @@ int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_cmd_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				 struct netlink_callback *cb)
+devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			     struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_port *devlink_port;
@@ -1121,9 +1122,10 @@ devlink_nl_cmd_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_port_get = {
-	.dump_one		= devlink_nl_cmd_port_get_dump_one,
-};
+int devlink_nl_port_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_port_get_dump_one);
+}
 
 static int devlink_port_type_set(struct devlink_port *devlink_port,
 				 enum devlink_port_type port_type)
@@ -1852,9 +1854,9 @@ int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
-static int devlink_nl_cmd_linecard_get_dump_one(struct sk_buff *msg,
-						struct devlink *devlink,
-						struct netlink_callback *cb)
+static int devlink_nl_linecard_get_dump_one(struct sk_buff *msg,
+					    struct devlink *devlink,
+					    struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_linecard *linecard;
@@ -1884,9 +1886,11 @@ static int devlink_nl_cmd_linecard_get_dump_one(struct sk_buff *msg,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_linecard_get = {
-	.dump_one		= devlink_nl_cmd_linecard_get_dump_one,
-};
+int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_linecard_get_dump_one);
+}
 
 static struct devlink_linecard_type *
 devlink_linecard_type_lookup(struct devlink_linecard *linecard,
@@ -2115,8 +2119,8 @@ int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-devlink_nl_cmd_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-			       struct netlink_callback *cb)
+devlink_nl_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+			   struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2143,9 +2147,10 @@ devlink_nl_cmd_sb_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_sb_get = {
-	.dump_one		= devlink_nl_cmd_sb_get_dump_one,
-};
+int devlink_nl_sb_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_get_dump_one);
+}
 
 static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
 				   struct devlink_sb *devlink_sb,
@@ -2252,9 +2257,8 @@ static int __sb_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 }
 
 static int
-devlink_nl_cmd_sb_pool_get_dump_one(struct sk_buff *msg,
-				    struct devlink *devlink,
-				    struct netlink_callback *cb)
+devlink_nl_sb_pool_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
+				struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2280,9 +2284,11 @@ devlink_nl_cmd_sb_pool_get_dump_one(struct sk_buff *msg,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_sb_pool_get = {
-	.dump_one		= devlink_nl_cmd_sb_pool_get_dump_one,
-};
+int devlink_nl_sb_pool_get_dumpit(struct sk_buff *skb,
+				  struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_pool_get_dump_one);
+}
 
 static int devlink_sb_pool_set(struct devlink *devlink, unsigned int sb_index,
 			       u16 pool_index, u32 size,
@@ -2460,9 +2466,9 @@ static int __sb_port_pool_get_dumpit(struct sk_buff *msg, int start, int *p_idx,
 }
 
 static int
-devlink_nl_cmd_sb_port_pool_get_dump_one(struct sk_buff *msg,
-					 struct devlink *devlink,
-					 struct netlink_callback *cb)
+devlink_nl_sb_port_pool_get_dump_one(struct sk_buff *msg,
+				     struct devlink *devlink,
+				     struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2488,9 +2494,11 @@ devlink_nl_cmd_sb_port_pool_get_dump_one(struct sk_buff *msg,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_sb_port_pool_get = {
-	.dump_one		= devlink_nl_cmd_sb_port_pool_get_dump_one,
-};
+int devlink_nl_sb_port_pool_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_sb_port_pool_get_dump_one);
+}
 
 static int devlink_sb_port_pool_set(struct devlink_port *devlink_port,
 				    unsigned int sb_index, u16 pool_index,
@@ -2694,10 +2702,9 @@ static int __sb_tc_pool_bind_get_dumpit(struct sk_buff *msg,
 	return 0;
 }
 
-static int
-devlink_nl_cmd_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
-					    struct devlink *devlink,
-					    struct netlink_callback *cb)
+static int devlink_nl_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
+						   struct devlink *devlink,
+						   struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_sb *devlink_sb;
@@ -2723,9 +2730,12 @@ devlink_nl_cmd_sb_tc_pool_bind_get_dump_one(struct sk_buff *msg,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_sb_tc_pool_bind_get = {
-	.dump_one		= devlink_nl_cmd_sb_tc_pool_bind_get_dump_one,
-};
+int devlink_nl_sb_tc_pool_bind_get_dumpit(struct sk_buff *skb,
+					  struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb,
+				 devlink_nl_sb_tc_pool_bind_get_dump_one);
+}
 
 static int devlink_sb_tc_pool_bind_set(struct devlink_port *devlink_port,
 				       unsigned int sb_index, u16 tc_index,
@@ -4173,9 +4183,9 @@ static void devlink_param_notify(struct devlink *devlink,
 				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
 }
 
-static int
-devlink_nl_cmd_param_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				  struct netlink_callback *cb)
+static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
+					 struct devlink *devlink,
+					 struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_param_item *param_item;
@@ -4199,9 +4209,11 @@ devlink_nl_cmd_param_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_param_get = {
-	.dump_one		= devlink_nl_cmd_param_get_dump_one,
-};
+int devlink_nl_param_get_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_param_get_dump_one);
+}
 
 static int
 devlink_param_type_get_from_info(struct genl_info *info,
@@ -4861,9 +4873,9 @@ static int devlink_nl_cmd_region_get_port_dumpit(struct sk_buff *msg,
 	return err;
 }
 
-static int
-devlink_nl_cmd_region_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				   struct netlink_callback *cb)
+static int devlink_nl_region_get_dump_one(struct sk_buff *msg,
+					  struct devlink *devlink,
+					  struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_region *region;
@@ -4901,9 +4913,11 @@ devlink_nl_cmd_region_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return 0;
 }
 
-const struct devlink_cmd devl_cmd_region_get = {
-	.dump_one		= devlink_nl_cmd_region_get_dump_one,
-};
+int devlink_nl_region_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_region_get_dump_one);
+}
 
 static int devlink_nl_cmd_region_del(struct sk_buff *skb,
 				     struct genl_info *info)
@@ -5683,9 +5697,9 @@ int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int
-devlink_nl_cmd_trap_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
-				 struct netlink_callback *cb)
+static int devlink_nl_trap_get_dump_one(struct sk_buff *msg,
+					struct devlink *devlink,
+					struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_item *trap_item;
@@ -5712,9 +5726,10 @@ devlink_nl_cmd_trap_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_trap_get = {
-	.dump_one		= devlink_nl_cmd_trap_get_dump_one,
-};
+int devlink_nl_trap_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_get_dump_one);
+}
 
 static int __devlink_trap_action_set(struct devlink *devlink,
 				     struct devlink_trap_item *trap_item,
@@ -5893,10 +5908,9 @@ int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int
-devlink_nl_cmd_trap_group_get_dump_one(struct sk_buff *msg,
-				       struct devlink *devlink,
-				       struct netlink_callback *cb)
+static int devlink_nl_trap_group_get_dump_one(struct sk_buff *msg,
+					      struct devlink *devlink,
+					      struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_group_item *group_item;
@@ -5924,9 +5938,11 @@ devlink_nl_cmd_trap_group_get_dump_one(struct sk_buff *msg,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_trap_group_get = {
-	.dump_one		= devlink_nl_cmd_trap_group_get_dump_one,
-};
+int devlink_nl_trap_group_get_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_group_get_dump_one);
+}
 
 static int
 __devlink_trap_group_action_set(struct devlink *devlink,
@@ -6187,10 +6203,9 @@ int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
 	return err;
 }
 
-static int
-devlink_nl_cmd_trap_policer_get_dump_one(struct sk_buff *msg,
-					 struct devlink *devlink,
-					 struct netlink_callback *cb)
+static int devlink_nl_trap_policer_get_dump_one(struct sk_buff *msg,
+						struct devlink *devlink,
+						struct netlink_callback *cb)
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_trap_policer_item *policer_item;
@@ -6217,9 +6232,11 @@ devlink_nl_cmd_trap_policer_get_dump_one(struct sk_buff *msg,
 	return err;
 }
 
-const struct devlink_cmd devl_cmd_trap_policer_get = {
-	.dump_one		= devlink_nl_cmd_trap_policer_get_dump_one,
-};
+int devlink_nl_trap_policer_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb, devlink_nl_trap_policer_get_dump_one);
+}
 
 static int
 devlink_trap_policer_set(struct devlink *devlink,
@@ -6298,7 +6315,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_PORT_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_port_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_port_get_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6312,7 +6329,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_RATE_GET,
 		.doit = devlink_nl_rate_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_rate_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6358,7 +6375,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_LINECARD_GET,
 		.doit = devlink_nl_linecard_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_linecard_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6370,14 +6387,14 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_SB_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_sb_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_sb_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
 		.cmd = DEVLINK_CMD_SB_POOL_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_sb_pool_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_sb_pool_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6390,7 +6407,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_SB_PORT_POOL_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_sb_port_pool_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_sb_port_pool_get_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6405,7 +6422,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_SB_TC_POOL_BIND_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_sb_tc_pool_bind_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_sb_tc_pool_bind_get_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_PORT,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6486,7 +6503,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_PARAM_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_param_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_param_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6514,7 +6531,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_REGION_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_region_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_region_get_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
@@ -6540,7 +6557,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = devlink_nl_health_reporter_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_health_reporter_get_dumpit,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT,
 		/* can be retrieved by unprivileged users */
 	},
@@ -6595,7 +6612,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_TRAP_GET,
 		.doit = devlink_nl_trap_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_trap_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6606,7 +6623,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_TRAP_GROUP_GET,
 		.doit = devlink_nl_trap_group_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_trap_group_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6617,7 +6634,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_TRAP_POLICER_GET,
 		.doit = devlink_nl_trap_policer_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_trap_policer_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
@@ -6628,7 +6645,7 @@ const struct genl_small_ops devlink_nl_small_ops[54] = {
 	{
 		.cmd = DEVLINK_CMD_SELFTESTS_GET,
 		.doit = devlink_nl_selftests_get_doit,
-		.dumpit = devlink_nl_instance_iter_dumpit,
+		.dumpit = devlink_nl_selftests_get_dumpit,
 		/* can be retrieved by unprivileged users */
 	},
 	{
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 3c59b9c49150..13388665f319 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -170,23 +170,6 @@ void devlink_nl_post_doit(const struct genl_split_ops *ops,
 	devlink_put(devlink);
 }
 
-static const struct devlink_cmd *devl_cmds[] = {
-	[DEVLINK_CMD_PORT_GET]		= &devl_cmd_port_get,
-	[DEVLINK_CMD_SB_GET]		= &devl_cmd_sb_get,
-	[DEVLINK_CMD_SB_POOL_GET]	= &devl_cmd_sb_pool_get,
-	[DEVLINK_CMD_SB_PORT_POOL_GET]	= &devl_cmd_sb_port_pool_get,
-	[DEVLINK_CMD_SB_TC_POOL_BIND_GET] = &devl_cmd_sb_tc_pool_bind_get,
-	[DEVLINK_CMD_PARAM_GET]		= &devl_cmd_param_get,
-	[DEVLINK_CMD_REGION_GET]	= &devl_cmd_region_get,
-	[DEVLINK_CMD_HEALTH_REPORTER_GET] = &devl_cmd_health_reporter_get,
-	[DEVLINK_CMD_TRAP_GET]		= &devl_cmd_trap_get,
-	[DEVLINK_CMD_TRAP_GROUP_GET]	= &devl_cmd_trap_group_get,
-	[DEVLINK_CMD_TRAP_POLICER_GET]	= &devl_cmd_trap_policer_get,
-	[DEVLINK_CMD_RATE_GET]		= &devl_cmd_rate_get,
-	[DEVLINK_CMD_LINECARD_GET]	= &devl_cmd_linecard_get,
-	[DEVLINK_CMD_SELFTESTS_GET]	= &devl_cmd_selftests_get,
-};
-
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one)
 {
@@ -220,15 +203,6 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 	return msg->len;
 }
 
-int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
-				    struct netlink_callback *cb)
-{
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
-	const struct devlink_cmd *cmd = devl_cmds[info->op.cmd];
-
-	return devlink_nl_dumpit(msg, cb, cmd->dump_one);
-}
-
 struct genl_family devlink_nl_family __ro_after_init = {
 	.name		= DEVLINK_GENL_NAME,
 	.version	= DEVLINK_GENL_VERSION,
-- 
2.41.0


