Return-Path: <netdev+bounces-17513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FB751D9E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D68D1C2130E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F399100DB;
	Thu, 13 Jul 2023 09:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14359100C7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:44:24 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C62127
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:44:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so3799617a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689241461; x=1691833461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WF01g77rvTakuBVRU1mzsD6krXsErLBlaQLu2CdouQ=;
        b=lVqrsFtQCTffxF7Ro9t9SoMEiAtDHF3LAaoD+XX2N81+pI5nnCEJqowa/QJmM+iJCn
         O7ADQgMqtp49EOnJoS0PA0hMFbeuVhnr8178mEntc0IpJBfxIot22Axo7fw9Ti9VMs/7
         mhpcSTNiLSc9Vd1CzWZsXLwJVMFprgoFKJVE8i35EChMqr8r4Eg8MIYfOOi7VzQJjqt7
         wIH7LZnTc59rrNig0v0cUOr93lGz0DejO601UmnqjoANazfp6q+uFZxjiF0WjDUHn1yK
         ODRx4F3IqhnMq1oZRxqd1k7JX28xNnAJolVmVHvriewlhaKebWyx85Kp9nxUgDvK+rYF
         2fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241461; x=1691833461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WF01g77rvTakuBVRU1mzsD6krXsErLBlaQLu2CdouQ=;
        b=P63PJVieu2iWcOzFs6EjjUr5pFvdesOBIDv6IEl5wOemyfwKpu/Qja8yoeNsCNdT7K
         whSka2ojg5vZ/AgyqqiE956ATqcLDkPBDS/43YMoKVeLmo+ENubJafK+JGRwQfIRPx8h
         xgvQ+g5g7cK9YV4YPNvMm8mZnd3yEvW2FAdxTcntGU5KlfvsF0ZXhO3Pg8C1V4qFjfCo
         BjoMZ/2FKm3x1pR2rkwiuz0cY6plsy4dWmnXAIII6hCs49JX5NCEAdUAAKd5NrbAP3VZ
         OXTqt8UPSHwWrk5HI38USm8dgCwP9Dllfwa2d3sC6qQMl/vdBVHWN+/yeCHera8yEVUN
         kDaQ==
X-Gm-Message-State: ABy/qLZqUElSbRSJ+IHx81EMTVbw7N7pAKLVbjT6RaHCG+KVrfp6KbYP
	wc4sCX0tbeXjM6PFt2sBItcWvQhM1Y954pS5RF8=
X-Google-Smtp-Source: APBJJlEcvUThalS8/XrPjIHcGnTl0DaUMbnWs4yu6/ULHVnqJmmH8GtdJwK4iK7xvCcGiiSdvamfRQ==
X-Received: by 2002:a05:6402:35cd:b0:51e:5206:d69e with SMTP id z13-20020a05640235cd00b0051e5206d69emr5622445edc.10.1689241461034;
        Thu, 13 Jul 2023 02:44:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w22-20020a056402071600b0051de3c6c5e5sm3985451edx.94.2023.07.13.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:44:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	idosch@nvidia.com
Subject: [patch net-next v2] devlink: remove reload failed checks in params get/set callbacks
Date: Thu, 13 Jul 2023 11:44:19 +0200
Message-Id: <20230713094419.2534581-1-jiri@resnulli.us>
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

The checks in question were introduced by:
commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
That fixed an issue of reload with mlxsw driver.

Back then, that was a valid fix, because there was a limitation
in place that prevented drivers from registering/unregistering params
when devlink instance was registered.

It was possible to do the fix differently by changing drivers to
register/unregister params in appropriate places making sure the ops
operate only on memory which is allocated and initialized. But that,
as a dependency, would require to remove the limitation mentioned above.

Eventually, this limitation was lifted by:
commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")

Also, the alternative fix (which also fixed another issue) was done by:
commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").

Therefore, the checks are no longer relevant. Each driver should make
sure to have the params registered only when the memory the ops
are working with is allocated and initialized.

So remove the checks.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rephrased some bits of the patch description
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


