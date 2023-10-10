Return-Path: <netdev+bounces-39524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD46B7BF942
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46431C20ED4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B718AED;
	Tue, 10 Oct 2023 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="poghKVYK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A0182BE
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:52 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EDC9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a645e54806so929113266b.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936128; x=1697540928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ziq3GIN9G3gkYphOjQYNZfoJbbuUQBt/lpMfUEh2/Qw=;
        b=poghKVYK/9qhvvBCw/LhRFH0RmYXcYiSQFsQRU421Cof8mJ0WdNV47LYrT7xA3Tdv6
         U5xvycoVwyhAurZgWiQFSwDX+70TAKlqS0hqWza8ktmTGzF7qnsQfx3qxkHlhlTlv7y3
         FGz1BaYTDWtFRnbeBzFN+G5s9Wi1nbzMOOfpGJwpk8NixughpFZM3/yXYZzO8qHFQdcH
         NTsCfDGPODYmGy4zOOGgjktiNVErXOwJWqeoRafFqk8ixoEE4W9WmgcP4sg1V/0tjPVO
         cI21GfUy0dodWmRcfNPMNt0uJtccK1tQbyPz+xiD7YauexkXmxKefZpYUhmatU3s45Uh
         za3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936128; x=1697540928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ziq3GIN9G3gkYphOjQYNZfoJbbuUQBt/lpMfUEh2/Qw=;
        b=VqBRJr8MUodamTqnJKlsexZtc/ca9+uOqImx7edsWJCnYlhXr4/G1igLsWdW3+kdl5
         t7w53vyFbrfETlDE2RYUn1RPxuj9F7rLOipakQ9m0FvCyyGiVFbt3dbipdZdsOqTWbvy
         iQSrxA6wGenEDORzu3pA858HPejdwcvkVUPF9tSQKmtB56r+g4NOdYit9pbBdKwQ3M2D
         mcYRnb5AFEnoAvclbhZBvUZ1CWfSLvSvM73FXw3LrWZ35RiHZypyBJ4lmWLt1DJLhxKG
         MYdY9p7MNNTdmTDlZhPbp0lpHAUvH7QArAvC9zOr0GHsW4SVR6zi7/bh+QcC/IPgp6wX
         9i2A==
X-Gm-Message-State: AOJu0YzZs+V0IWO1ErMHdSC034pOKK43fFW4PmAsfyuoZ3VARq0xkfq7
	lr4v+GXejQ96cBMolTVXzQiLvmyyJCGP2axF800=
X-Google-Smtp-Source: AGHT+IFXXWKa/WEYlO6XvKFQr5dLpY+adbQ72Or/JoDiO8SN9N3xCynlJkEwr+FJiG3I9jEliIOR6Q==
X-Received: by 2002:a17:906:3050:b0:9b2:be5e:7545 with SMTP id d16-20020a170906305000b009b2be5e7545mr15123841ejd.36.1696936128610;
        Tue, 10 Oct 2023 04:08:48 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906831100b0098e78ff1a87sm8159890ejx.120.2023.10.10.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 09/10] devlink: remove duplicated netlink callback prototypes
Date: Tue, 10 Oct 2023 13:08:28 +0200
Message-ID: <20231010110828.200709-10-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


