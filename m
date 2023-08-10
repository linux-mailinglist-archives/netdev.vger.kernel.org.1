Return-Path: <netdev+bounces-26351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7C777964
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716C228205C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE001FB57;
	Thu, 10 Aug 2023 13:15:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15461E1C1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:15:58 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5B10E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so819512f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691673355; x=1692278155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPAP5lBEX2vcC2T4wWrhVRQlFY/OnfoctTNX8XpZ/HE=;
        b=ymTCsNkFVsFila8z9ze8SHyM6e8A/XzjggqLP6H0LMnAQ7tAlYzx+8IlN74ZFDd1fp
         3HzllhDiNCiUwUzcENRfpUmQ5cEZbNAapAu9IMtw3TJeclhdfCDgZIRe4mv6nGx70ZqC
         vHSuSimIA+hz9EeCuh5aVrymagEgj1NFvPTr/7pQ1KpemvnCPiUVwctuwJMz1M/2/sXc
         l8JMPOSK93rTXwpDUHWbGZfNc+EJDs5rZANVH6Q3S2wCJMljLMFcbh/9afNxzYNSSx0i
         6SwkHZeQhxp1cgxRW7dRth7ktP/E/6oPj9LajRKjFgueTYPT79h3vEqFKwjkVIH0Ncn6
         JqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673355; x=1692278155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPAP5lBEX2vcC2T4wWrhVRQlFY/OnfoctTNX8XpZ/HE=;
        b=TdH7n+Xt3/36VTKPZL2seqUns6USzGKfJiZw1cjCznocLCrybSDC2vJWqnNlbwwmQP
         +7q7jY0bQHGtpToIyryQzuo9VA8UfTLXdzNHgX7DLhRKzNr6Y7kMwOVJMvXVBYORmRFt
         Akxz86MO8cDHHpq4x3E3viX2EsBG80gNAGGtPftrSAvHOu0yhhf4c6TBNlcriiFLOaSv
         hU6V7/Pmvd4FPL4AQdSLgFUDHSMGShycRM1iCyMKRihZY3um4jvOVF4p9Ml2EjBdky4u
         h1ICYA8r4xpbnj91NIbfjdqJ8FujZ6VroPW6zIVvRtQ3wBOxE+vNPLw436TjphVgpB+q
         yXQw==
X-Gm-Message-State: AOJu0YzV06yEzTwhCVd5gCAYixfFTw/1T+pO2OaEoinQDFe+Fx2/iv7h
	QgWfhkEcH/Bdq3qJxKsx5HwlWBNjFW/Bqd6EN1GE7w==
X-Google-Smtp-Source: AGHT+IGH9z1LRGfGMxiA6IHV2GMwn6ugWOcVV6HCbIIrRm134HLbHFwPwa3pmbVM1q8rIZHq3n9WiQ==
X-Received: by 2002:adf:cd11:0:b0:317:60f2:c08b with SMTP id w17-20020adfcd11000000b0031760f2c08bmr2193748wrm.31.1691673355571;
        Thu, 10 Aug 2023 06:15:55 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d6dc2000000b00317f70240afsm2190147wrz.27.2023.08.10.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:15:54 -0700 (PDT)
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
Subject: [patch net-next v3 08/13] devlink: remove duplicate temporary netlink callback prototypes
Date: Thu, 10 Aug 2023 15:15:34 +0200
Message-ID: <20230810131539.1602299-9-jiri@resnulli.us>
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

Remove the duplicate temporary netlink callback prototype as the
generated ones are already in place.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h | 48 -------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f8af6ffdbb3a..7caa385703de 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -185,50 +185,11 @@ int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
 			     struct netlink_ext_ack *extack);
 
 /* Devlink nl cmds */
-int devlink_nl_pre_doit_port(const struct genl_split_ops *ops,
-			     struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
-				      struct sk_buff *skb,
-				      struct genl_info *info);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
-				    struct netlink_callback *cb);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_port_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_linecard_get_dumpit(struct sk_buff *skb,
-				   struct netlink_callback *cb);
-int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_sb_pool_get_dumpit(struct sk_buff *skb,
-				  struct netlink_callback *cb);
-int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_sb_port_pool_get_dumpit(struct sk_buff *skb,
-				       struct netlink_callback *cb);
-int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_sb_tc_pool_bind_get_dumpit(struct sk_buff *skb,
-					  struct netlink_callback *cb);
-int devlink_nl_param_get_doit(struct sk_buff *skb,
-			      struct genl_info *info);
-int devlink_nl_param_get_dumpit(struct sk_buff *skb,
-				struct netlink_callback *cb);
-int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_region_get_dumpit(struct sk_buff *skb,
-				 struct netlink_callback *cb);
-int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
-					struct genl_info *info);
-int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
-					  struct netlink_callback *cb);
 int devlink_nl_cmd_health_reporter_set_doit(struct sk_buff *skb,
 					    struct genl_info *info);
 int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
@@ -241,12 +202,3 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 						   struct genl_info *info);
 int devlink_nl_cmd_health_reporter_test_doit(struct sk_buff *skb,
 					     struct genl_info *info);
-int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-int devlink_nl_trap_group_get_dumpit(struct sk_buff *skb,
-				     struct netlink_callback *cb);
-int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
-				     struct genl_info *info);
-int devlink_nl_trap_policer_get_dumpit(struct sk_buff *skb,
-				       struct netlink_callback *cb);
-- 
2.41.0


