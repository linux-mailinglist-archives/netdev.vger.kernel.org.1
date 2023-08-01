Return-Path: <netdev+bounces-23261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A576B738
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A81C20E7D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF7253A7;
	Tue,  1 Aug 2023 14:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518622F1F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:20 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62001184
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so11190531fa.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899557; x=1691504357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijBgMWxuFtml0C6g7UT+aYSZs/zH2hddHHLPUS4ODZ4=;
        b=4oyXKxf4OaDY943jzMmR0wAv31mZLjVLo1fiRl4qOs3i8GACaJCxWEa3l0SvG51SE8
         cStMG8+4kloZGysh9IT4r7fo2YqGnkJ6XX/YVL6hsmGqecia+TgA/EifaKQyQ21O6ba9
         tBsXczyPAhEoTlFgMIirlGfvbo1wtIxUlXTSv1+kVdHicabVzz31SNjoDtKSTYQ+p5Vv
         C3ad6NsNhOuP32VSIGl8AqcFkig5apeOis2v3n5U0geUuObIUImJsnuEPvOhwxe6s2RQ
         Dsy4Kor5K25GyC3MPL6XpIAIj9hP8VS9W87rmCaFPSX7s10lrNHtFAhWxbjag2+shDi/
         5l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899557; x=1691504357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijBgMWxuFtml0C6g7UT+aYSZs/zH2hddHHLPUS4ODZ4=;
        b=PS77F0hlUcCzAEb2k7TOPdge5ENHBwicra+Dawd6ky+x4OGQ2PakoPtrMeNB4etb8K
         DzLqic61c1rGd6XnH8LTIOLQwNp2q8HzS5q6X+ge+MD/VpNAy1+/BGarJyMxs7drsx89
         a5NdszRxk0cExxoaqPRtzBZ+C0+rVbmth9xnPJuTPciTc0c/+nXBKd9/eizhwyI3m1L/
         hZ1nfYQ4+aRr48HsOoOu9bbxXqI3NiDl4jAso7EdrzmHvQFVNwh/iAwfQn9o4Qg0eClk
         HCsUWobPwu4PN3/Mt4BfBj7r/oV1sW5s/Ztt8yP6prTIslCfkb6JD5GTRJwwHAPhZKvP
         8GKw==
X-Gm-Message-State: ABy/qLbzKRznt+S0F2T/sIlzOsIXUdhzQQxLkA9vSQpNV4ylKhbwEVtj
	ntkEyfoLwLlAhZoEO9OocAeMY05/D+UMbtW4AThh9w==
X-Google-Smtp-Source: APBJJlHjiLimn7GrJhRZ/irPrD3Ayy7Yxm1Qi8LBzU51S4w/quXjgLRckYCKuovZi1EfSZqMLjOscQ==
X-Received: by 2002:a2e:a306:0:b0:2b9:f0b4:eab7 with SMTP id l6-20020a2ea306000000b002b9f0b4eab7mr3013016lje.18.1690899557588;
        Tue, 01 Aug 2023 07:19:17 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0099bc038eb2bsm7672797eji.58.2023.08.01.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:17 -0700 (PDT)
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
Subject: [patch net-next 5/8] devlink: include the generated netlink header
Date: Tue,  1 Aug 2023 16:19:04 +0200
Message-ID: <20230801141907.816280-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801141907.816280-1-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
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


