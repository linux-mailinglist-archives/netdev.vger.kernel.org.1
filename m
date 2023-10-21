Return-Path: <netdev+bounces-43230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BE7D1CD4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E49B215B1
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1048DF58;
	Sat, 21 Oct 2023 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m5klNpWn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E125C7
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:32 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76D41A4
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so267538866b.3
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887649; x=1698492449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ziq3GIN9G3gkYphOjQYNZfoJbbuUQBt/lpMfUEh2/Qw=;
        b=m5klNpWnOhhW5fg8kXovA/qstgnWN8nBRfCjIxNVWkSJqv/nl+63jrTyXL4wUq+tNu
         CgT2q0S8xJE2BbT39zEqgQI2zFCKUVAc2b8lXWrnXP7a70IMQRS9WjbY274ItZvWJfUs
         zVgUzUTfSfyZ4CqU6C5Lpo6Po/PZUbFw4Tqzv3ur1q0idCwgY+Hjc3G0ukv7ezMNBo2E
         BV1Bb77k4aMCCuCVfvbK1njgd7k4eQbKke2LKv+yodVlLMEMc5xXQiT32K7GcWyCBzIT
         5okjY/x9w0fg2aPlc66/Jrb+R725PuOT9B4uGeFMhol6JHzbfq+ct9b2g3Vq9dI3LvSQ
         Sy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887649; x=1698492449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ziq3GIN9G3gkYphOjQYNZfoJbbuUQBt/lpMfUEh2/Qw=;
        b=OWt4hSDW7qDr0r7IyFdt9MwMFKd68S57ADf1pj4luroMfquFQ1DK25nSgXWnxK0Yg/
         gih9I9oRKR248n0HNrmV4daPjo40rgss4wDuVGr/deAva4LYwRs22TyL1O4S/E1LPwYl
         x3rIxQ74wA1fogX15/ADP3njZ2Sj2HOygXLTqNJ9X9DtHINBmepbQjtf4zDTvUVoS0p0
         XbQrX9l95EP/YDOuaW7EH/ez2NeqeyFgoe5wrDOaKrAMhLW3cNzMZpU15kgmjhoaO+Sk
         s5J4zV1pbluQKj0Q2av71MZuLlcw/BZF83Dm5n2Lcr/qxlUPz0yJf6MEFeCe6ggayUWX
         KjdA==
X-Gm-Message-State: AOJu0YyZMeAFaL4n+BgnZBMN2yM5IagqJigDnral0oJvSZsA+OPSgK9m
	MGtPSND8tYDdyJDjGzZXZm31fCiI6OgJFWXbu9c=
X-Google-Smtp-Source: AGHT+IFFJxkmNbO8hcH8RwCwR0YmlF7G2tWQu24XeFTZ2qO/t7r89d0Rz0zk1Ycxt19/hQiQ6qAtdA==
X-Received: by 2002:a17:907:9487:b0:9bf:20e0:bfe9 with SMTP id dm7-20020a170907948700b009bf20e0bfe9mr3818441ejc.15.1697887649336;
        Sat, 21 Oct 2023 04:27:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906b08900b0099ce188be7fsm3453843ejy.3.2023.10.21.04.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 09/10] devlink: remove duplicated netlink callback prototypes
Date: Sat, 21 Oct 2023 13:27:10 +0200
Message-ID: <20231021112711.660606-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
References: <20231021112711.660606-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The prototypes are now generated, remove the old ones.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h | 62 -------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index daf4c696a618..183dbe3807ab 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -227,65 +227,3 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
-
-/* Devlink nl cmds */
-int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_unsplit_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_port_pool_set_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb,
-				    struct genl_info *info);
-int devlink_nl_sb_occ_max_clear_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_dpipe_table_get_doit(struct sk_buff *skb,
-				    struct genl_info *info);
-int devlink_nl_dpipe_entries_get_doit(struct sk_buff *skb,
-				      struct genl_info *info);
-int devlink_nl_dpipe_headers_get_doit(struct sk_buff *skb,
-				      struct genl_info *info);
-int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
-					     struct genl_info *info);
-int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_param_get_dumpit(struct sk_buff *msg,
-				     struct netlink_callback *cb);
-int devlink_nl_port_param_get_doit(struct sk_buff *skb,
-				   struct genl_info *info);
-int devlink_nl_port_param_set_doit(struct sk_buff *skb,
-				   struct genl_info *info);
-int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_region_read_dumpit(struct sk_buff *skb,
-				  struct netlink_callback *cb);
-int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_health_reporter_recover_doit(struct sk_buff *skb,
-					    struct genl_info *info);
-int devlink_nl_health_reporter_diagnose_doit(struct sk_buff *skb,
-					     struct genl_info *info);
-int devlink_nl_health_reporter_dump_get_dumpit(struct sk_buff *skb,
-					       struct netlink_callback *cb);
-int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
-					       struct genl_info *info);
-int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
-					 struct genl_info *info);
-int devlink_nl_trap_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_group_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_policer_set_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_linecard_set_doit(struct sk_buff *skb, struct genl_info *info);
-- 
2.41.0


