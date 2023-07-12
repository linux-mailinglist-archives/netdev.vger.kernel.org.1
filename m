Return-Path: <netdev+bounces-17122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B875063D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047CA281946
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C827711;
	Wed, 12 Jul 2023 11:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523527701
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:38:01 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D11984
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:37:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so10348426e87.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689161833; x=1691753833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2DkpGqV6Y3635SY8i17x6efQ7LmhtEum7ewkubAJMU=;
        b=YNDGUL2U6qFpYNCGQCpQdwWtdpxERPUDrb5lGgUNndd6M4Ec4m4eBbGJRu2ubj3BAa
         nqy0Xyj7eWs35mgezreCVtQ5wlsk+VqgMSTdWDJZoDJJP9VUs1JwdjSErFzRq5CTtx1M
         apkA2p9KcI2IEwMnhlaEShn6A/QSuTtjE8QBZNLhniYfIOA2UNbOM8Wat5wB17/tcebt
         n6GFmIlG7OULxOcld4rMlPIImOOKWLJkDHvLLASZlta+x+UC5/mgq2V6QXrdnleCZ6zz
         aSJu+V6+KsMZIeDKhjIOOY5aX1rt8bQDCfevoFspfcQe3C4ZWc7iriYiOE4nVWIFJElZ
         +psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689161833; x=1691753833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2DkpGqV6Y3635SY8i17x6efQ7LmhtEum7ewkubAJMU=;
        b=WWEUHFsGJOUXQTLhh7VsHGqubZmRlhnhe1zbI+SZiRBw2NmBGqguehhA2GllOWyPYF
         Werb1sS0DnweMHy5HF2a9v3UOfasusGK9XKBLoXAFcxSp9hSCc8zRFwQMCSDD9Bjvagl
         tfo7yDFqI/TgxKd/Z/AbRE5ROAtrgYAMRqT1r32YZRm/+nVPZHjBeCEYnq9FEQ49cPfE
         vu6Kx+JRvIY0GKWlsvq4pcTI+43uP7ZhiuAfiJHnl+LbSRgeAD0SmpHk/6Sxlbk4GHy0
         je7GyqCUlTnyM63IAgAf644ES9ssX7sbPR3T/1Q7QK9uvUvW003VfoXqbayz2YfW+2TL
         m4bA==
X-Gm-Message-State: ABy/qLaDaWB8WH4GsPZCzImAVuSGKgnCOxkbbvIZ67RbIsNaYbFny/wc
	qt61BIwpd4ZdkVwlR8uZCxsqKsicflhfvJLtRuc=
X-Google-Smtp-Source: APBJJlEYTq7LkSL2PscuWh6aU9oKnZKhOgQhyGnilslQPX01K1Ftsn7ucFbOsBSpI9s+yfzfBpEF9w==
X-Received: by 2002:a05:6512:3a84:b0:4f8:770d:6d7d with SMTP id q4-20020a0565123a8400b004f8770d6d7dmr18025385lfu.6.1689161832703;
        Wed, 12 Jul 2023 04:37:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c0b5800b003fc01189b0dsm4819017wmr.42.2023.07.12.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:37:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	idosch@nvidia.com
Subject: [patch net-next] devlink: remove reload failed checks in params get/set callbacks
Date: Wed, 12 Jul 2023 13:37:10 +0200
Message-Id: <20230712113710.2520129-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.39.2
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

The checks in question were introduced by
commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").

Back then, it was a possible fix. Alternative way to fix this was to
make sure drivers register/unregister params in the code where it is
ensured that the data accessed by params callbacks are available.
But that was problematic as the list of params wes static durint
devlink instance being registered.

Eventually this limitation was lifted and also the alternative fix
(which also fixed another issue) was done for mlxsw by
commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").

The checks are no longer relevant, each driver should make sure to
register/unregister params alongside with the data it touches. Remove
the checks.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/leftover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 1f00f874471f..5128b9c7eea8 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -3946,7 +3946,7 @@ static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->get || devlink->reload_failed)
+	if (!param->get)
 		return -EOPNOTSUPP;
 	return param->get(devlink, param->id, ctx);
 }
@@ -3955,7 +3955,7 @@ static int devlink_param_set(struct devlink *devlink,
 			     const struct devlink_param *param,
 			     struct devlink_param_gset_ctx *ctx)
 {
-	if (!param->set || devlink->reload_failed)
+	if (!param->set)
 		return -EOPNOTSUPP;
 	return param->set(devlink, param->id, ctx);
 }
-- 
2.39.2


