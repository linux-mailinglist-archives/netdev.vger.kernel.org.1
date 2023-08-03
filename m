Return-Path: <netdev+bounces-23989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E176E69A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C4328202E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360731F16A;
	Thu,  3 Aug 2023 11:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C21DDFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:14:02 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC810B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:14:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso118533266b.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061238; x=1691666038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69o//OCeLKSkWAV3wkhMe2psFgsCZVnaljp//cCekKE=;
        b=YpuhhDSItR34PPo66IVO/TYYFTrynH60/OtjL+W/8RBtujXRDpH9aBXRagroNHLpbH
         dG/Br/x4LhsW8jds9vSNRJiKex8PDcOnYvovG9pTEOLVbEOBLq5b3P2yXlR2HSoPVh/7
         64WEwSDqOCX00qb/aEASSUYqhna6G8mG5CO5ifYXBTanfyrKCSocc76XMMdxqhqo1DMy
         zMsWpNukFeVyM8xY75SGX+qa4BNvXSQh98wVajJ4y8yW2fduBFscRp+lwA5U0DMgbxak
         NahgAOAOQ3LNZiXF2Fk1RW4BY5cmDDJDd5lff8MXCQkWYOCemyOwXEnHk40E5y+t91Oh
         KQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061238; x=1691666038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69o//OCeLKSkWAV3wkhMe2psFgsCZVnaljp//cCekKE=;
        b=CQCRnNNd6p6HBIp4WEJBkHxgqdel48m9iOO9oQBPd8KdGMGuqARN0UaTaXBy7j0C6w
         utiIh9TLNOmm4zaWyIr8nKne29yxJkH2gfm2h7kMoeQ5BG3Vqi7o6fZ3AcbP2J7NLjeU
         eai5DpOjMvl4V3NoqAWq1V66ur9c8hnQpc4movKhMmoFjvTqW2PnBiHhWgjAfTI1zQiL
         mqPpkVB70Hw2O7BWfcC5QzLR7rA7t0K8otCYxWr5Xf3caaC+2T2EeEdJ7pCscu1/ytZg
         6DvQwXWdF4r5oujxdC6mPKHbC1kiUdLBP2awhhO/5mrHis+BN/o/6soJA5xChPuPH3/L
         +N5A==
X-Gm-Message-State: AOJu0YxsS6AJEfEBkWysus+UeFSStOiGvJbQmp3kvpU1DX3TBjgZaPf0
	1PIZ/P6P84F2/m5lWEdYqMQGkJPMZkDhp0N9/H0+8g==
X-Google-Smtp-Source: AGHT+IHgRymyVqnXz7fL+1YKomuIMuQmdhsURkTtSIgYXPFyd9wsVuNNdClvMyEhb+cBPt4g0VjbiQ==
X-Received: by 2002:a17:906:7782:b0:99c:7915:b84c with SMTP id s2-20020a170906778200b0099c7915b84cmr747668ejm.57.1691061238761;
        Thu, 03 Aug 2023 04:13:58 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709067e5500b0099c157cba46sm5758643ejr.119.2023.08.03.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:58 -0700 (PDT)
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
Subject: [patch net-next v3 11/12] devlink: include the generated netlink header
Date: Thu,  3 Aug 2023 13:13:39 +0200
Message-ID: <20230803111340.1074067-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Put the newly added generated header to the include list. Remove the
duplicated temporary function prototypes.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- moved un-static devlink_nl_pre/post_doit() a separate new patch
- added removal of the temporary function prototypes
---
 net/devlink/devl_internal.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 0befa1869fde..51de0e1fc769 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -12,6 +12,8 @@
 #include <net/devlink.h>
 #include <net/net_namespace.h>
 
+#include "netlink_gen.h"
+
 #define DEVLINK_REGISTERED XA_MARK_1
 
 #define DEVLINK_RELOAD_STATS_ARRAY_SIZE \
@@ -216,18 +218,9 @@ struct devlink_rate *
 devlink_rate_node_get_from_info(struct devlink *devlink,
 				struct genl_info *info);
 /* Devlink nl cmds */
-int devlink_nl_pre_doit(const struct genl_split_ops *ops,
-			struct sk_buff *skb, struct genl_info *info);
-void devlink_nl_post_doit(const struct genl_split_ops *ops,
-			  struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int devlink_nl_cmd_reload(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info);
-int devlink_nl_info_get_dumpit(struct sk_buff *skb,
-			       struct netlink_callback *cb);
 int devlink_nl_cmd_flash_update(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_cmd_selftests_run(struct sk_buff *skb, struct genl_info *info);
-- 
2.41.0


