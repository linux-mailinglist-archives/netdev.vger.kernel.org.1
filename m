Return-Path: <netdev+bounces-23683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38E76D1C3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823B61C20853
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30892DDB3;
	Wed,  2 Aug 2023 15:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253138C15
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:26 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441994EF6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317715ec496so7112427f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989639; x=1691594439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijBgMWxuFtml0C6g7UT+aYSZs/zH2hddHHLPUS4ODZ4=;
        b=W7sQX946qKJ5oJGFudzxQ+yK0f/Y9W6x4kLCaZlSIEo7gtFrHptxKbsmfN6qcFO2Au
         uzjyCiLDjrItORt1+ek8ERxKCb6YAMPmbTaTVHPygPHCEWXLeIFhz6xSEKViH28KD/Fe
         VnV3XGV4p2Qy4OldqpmMU4Ij0pfduImbx2qgrtblcucfYaQsRuH5onBlE4BD/9S26KLw
         3G1eaJU3+K+m3MMK616VGA5EIqu8YFPrCdljpmAWIzIE6mJYT1PVUShtaHiWd1Ss53dA
         hUOwWqcoPQFCxmOv1fkbDYWxct1fRb/W/8KUR4fLQgpRO6zq1ZvrTlIBD1l9YX3aC3ad
         LtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989639; x=1691594439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijBgMWxuFtml0C6g7UT+aYSZs/zH2hddHHLPUS4ODZ4=;
        b=FbZzynv4I2ZH25KKzdVSc3+xu2IG9k2/xAfwtEsWFB5y+rbRvqBf19zSNkwNbpBu/1
         o0nRKQkFkZI5zpcBd/DQgf1cOEVxf991QLRxd3nhclW69h7iXS3fbcQYBpvrwNFaPnYI
         HCSMA3Z4kDn3d2HzaxJziB+cguBqSATbYUR1byn63BXv/KjOBQ50PuHrxVbiHpGysMO6
         gU2k7ztNbP6EPYFOKQ/uY5LC3b8khVHiOXHz75uV/4jKGJlatrFq323ZjFuZ5kpoX+pa
         H5hIsfd6HK6eSbhp0R0A2rrvfbmmx+UT/wNFTlnLmzSSjeh0b5iHd7vEEYef5pannWh1
         DsRg==
X-Gm-Message-State: ABy/qLYkAh/G0KhOtcZQVMmuEaUQy8e/CIq9OZgE1ovs6wb8oH7Pc4hq
	nXP6bkgy11OHn3D/DDdY7P7xD1NQCZillNBmiM4VBg==
X-Google-Smtp-Source: APBJJlHtu8oigFNHu7V1TRKvwy12DBYEtNcg9iqq29h3hJzslQq6Ptdapx7q2G3f2PyevAwIJGD99A==
X-Received: by 2002:a5d:484d:0:b0:317:55de:d8 with SMTP id n13-20020a5d484d000000b0031755de00d8mr5081499wrs.14.1690989639025;
        Wed, 02 Aug 2023 08:20:39 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d50c3000000b00317909f9985sm14858917wrt.113.2023.08.02.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:38 -0700 (PDT)
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
Subject: [patch net-next v2 08/11] devlink: include the generated netlink header
Date: Wed,  2 Aug 2023 17:20:20 +0200
Message-ID: <20230802152023.941837-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Put the newly added generated header to the include list. Un-static the
pre-doit and post-doit functions as they are used in the generated
files.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h | 2 ++
 net/devlink/netlink.c       | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index c67f074641d4..f5ad66d5773c 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -12,6 +12,8 @@
 #include <net/devlink.h>
 #include <net/net_namespace.h>
 
+#include "netlink_gen.h"
+
 #define DEVLINK_REGISTERED XA_MARK_1
 
 #define DEVLINK_RELOAD_STATS_ARRAY_SIZE \
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 82a3238d5344..39e07a5a69af 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -109,8 +109,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
 	return ERR_PTR(-ENODEV);
 }
 
-static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
-			       struct sk_buff *skb, struct genl_info *info)
+int devlink_nl_pre_doit(const struct genl_split_ops *ops,
+			struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink_linecard *linecard;
 	struct devlink_port *devlink_port;
@@ -167,8 +167,8 @@ static int devlink_nl_pre_doit(const struct genl_split_ops *ops,
 	return err;
 }
 
-static void devlink_nl_post_doit(const struct genl_split_ops *ops,
-				 struct sk_buff *skb, struct genl_info *info)
+void devlink_nl_post_doit(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink;
 
-- 
2.41.0


