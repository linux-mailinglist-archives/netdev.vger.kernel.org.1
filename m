Return-Path: <netdev+bounces-20505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA53475FC3A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4581C20C30
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0462F8BFD;
	Mon, 24 Jul 2023 16:33:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED808F9E1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:33:20 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D510C3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:32:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584126c65d1so5990547b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216376; x=1690821176;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0ItjzEnrcDip1nnMuQcurhIQbGXc9szh+Rx70ZZ7TY=;
        b=wihX5zPG/UR91h/7OURkTz7sD5iWGc0GNzIxCS+ROGzUSkqk70KOVqc5cn77v3tO1E
         6WuzVvq4a6ZNaJX7gvmJ/biDcDy9o3nCyNldHHD1aCLNC1bYTR2qLcSwu6HcAYO8MEDk
         JqJfqFm4lzsbSJiOnyz1seV46EsMFvY5VqZ9k4bW0uMFYC4xTRJL6fpwLcgShNJOegQ6
         LCBVlUJowTA6SdUORfVLTfoL3dMDP2tMOukl64DY//TUOd3x6a48KNVxt47jc1BAkSfl
         u4yl2kZUkQDKfEgLpi/pyQ/2TANcZxCWdf/NBLdxSETYmp4p+Rin5yiYipRF0q95ZVQO
         6EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216376; x=1690821176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0ItjzEnrcDip1nnMuQcurhIQbGXc9szh+Rx70ZZ7TY=;
        b=EPtVRkyYR6oZbZ3f1ifmkgxM4iy4thVq4iyHCj3GHNvGz9I1i8nGZmr865V2YhQFJs
         3xSYMGrpFfGt1i3yxWHQlqDhkDsBn6kTE5ALRqAW/cAVE2kySRa/Ra/VHA6rYYoIBH5M
         V7BeVNco4ZkX++csQ4wmrHlaNY5VhwPmICPy4XNfbPXSZW5Vb6o4E2E2v1CHTywjZGCe
         pD2p7KaUkftPtsjM03x/6g3kgA1v3bvp42LNlaMC0FAd2qQdgicM1ZBIVp0UcOwlL3Fe
         62/urScUKE78AcDryQXFfwIX+YacyawgzOFI22wapHy3lF3E7GwZmyLcvRH/7r5hVJ9c
         5UFw==
X-Gm-Message-State: ABy/qLaDN06Tnimv/hyysNY6O9JzctsbVGKb3YhWFn4LHRzHUA6qREHR
	f/1WTjqIFtnqw0DZqBsCOju78WHptx913w==
X-Google-Smtp-Source: APBJJlGONzEb0nO+X6zCU2xT1S2V5jXa3ezxvdv9LQ2B5/yHuvqrQS/YodxdmAoDvGsGWNdm4dXSweDHCS759Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b71d:0:b0:576:f61f:adbc with SMTP id
 v29-20020a81b71d000000b00576f61fadbcmr76383ywh.1.1690216376470; Mon, 24 Jul
 2023 09:32:56 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:32:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724163254.106178-1-edumazet@google.com>
Subject: [PATCH net] net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Simon Horman <simon.horman@corigine.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Typical misuse of

	nla_parse_nested(array, XXX_MAX, ...);

array must be declared as

	struct nlattr *array[XXX_MAX + 1];

Fixes: 7cfffd5fed3e ("net: flower: add support for matching cfm fields")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/sched/cls_flower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 8da9d039d964ea417700a2f59ad95a9ce52f5eab..3c7a272bf7c7cf7d4ae21b5370cbc428086d6979 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1709,7 +1709,7 @@ static int fl_set_key_cfm(struct nlattr **tb,
 			  struct fl_flow_key *mask,
 			  struct netlink_ext_ack *extack)
 {
-	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX];
+	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
 	int err;
 
 	if (!tb[TCA_FLOWER_KEY_CFM])
-- 
2.41.0.487.g6d72f3e995-goog


