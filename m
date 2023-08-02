Return-Path: <netdev+bounces-23679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BA76D1BC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F049281A4B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F8C8F2;
	Wed,  2 Aug 2023 15:21:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDED30F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:18 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B234C0D
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso74355935e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989632; x=1691594432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvjR0egsx3QP5ZoVehOstU8TmWV+b/KA1hWFGZTG2ls=;
        b=y2C1b/WtW0Mf1xw8l2HfO8Kd+RSmu2o+zsD6KjFw6RvJR2L0/Qtvc1y9QnwpVaXbvb
         eX/mmeopctUqNoUUu42FkVIId7PFpuoS0afsdtk7vUMx6nnsg2LPDwAeu71ny56N1S44
         Edt87TvWp4ojd9tcR128Surwimbxop2Lw76AC6dT0ykFPiQ734wDIba5sCGVZeiF+VTB
         CxI73/eOWCBczgyJMPdS+5DqXZwXV/iJLDgKpF9wB/0zdGfqipqX3DEJf4TXVkY/4yCW
         +kEyGdI4/AkD8FKS6PeaGjITtVhmHtVE0KKLhNcoAQXwyH7YcX6KH3huIjOWlapqkLg2
         hbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989632; x=1691594432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvjR0egsx3QP5ZoVehOstU8TmWV+b/KA1hWFGZTG2ls=;
        b=f6GfFZ3bEQ4VTW7v+gxkK62Gmivfnu4Qcnn7kAfRzvxbai8Xr+FZn//uz/Dm3wcr1j
         k8VO74oM0nSgUk9mw8+60KIqv2qwAZ7vkSyi7nYmzDSXdDnWDygA65dnyyxB/Ht8LtVE
         oc8e4Rn4diUMUtpfA5n5c6z1igsoULECP7c7ki11XaAV17TeVtPExVrieT/yASV/zf5d
         NmHTvB2R+09poydh5RX/mzeO0PoCMqQfDzCwHUtWSykFGP03/nOsh52XxoD/31mhdv5n
         6U5PvzWcXA1N1lvb+A7XvxjqBYumfxw7PF5OjKDX6FT6NMr3XrBhnJL/pwuvxhn5D6KY
         gnlw==
X-Gm-Message-State: ABy/qLastGg9Y5BAJiK9EMGhq8AbLWCqoRlhCTK19IhJsy5yDJ0AzaOe
	6LhBuCFhk7G5dRpA7DeG/ZeT5hCSnxN0v1REthyO5w==
X-Google-Smtp-Source: APBJJlF/NRu7uNjgaJLMWI9yEE7fHXA5C634ks2STZItS4/DOomkS0S4c5GS1JpjhkbKdoEcrWgR7g==
X-Received: by 2002:a05:600c:2303:b0:3fe:1bef:4034 with SMTP id 3-20020a05600c230300b003fe1bef4034mr5265122wmo.37.1690989632526;
        Wed, 02 Aug 2023 08:20:32 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003fe1afb99b5sm2317312wml.0.2023.08.02.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:31 -0700 (PDT)
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
Subject: [patch net-next v2 04/11] ynl-gen-c.py: render netlink policies static for split ops
Date: Wed,  2 Aug 2023 17:20:16 +0200
Message-ID: <20230802152023.941837-5-jiri@resnulli.us>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

When policies are rendered for split ops, they are consumed in the same
file. No need to expose them for user outside, make them static.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 tools/net/ynl/ynl-gen-c.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 34ee7b8e3f71..d0753cb39901 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1843,13 +1843,13 @@ def print_ntf_type_free(ri):
 
 
 def print_req_policy_fwd(cw, struct, ri=None, terminate=True):
-    if terminate and ri and kernel_can_gen_family_struct(struct.family):
+    if terminate and ri and policy_should_be_static(struct.family):
         return
 
     if terminate:
         prefix = 'extern '
     else:
-        if kernel_can_gen_family_struct(struct.family) and ri:
+        if ri and policy_should_be_static(struct.family):
             prefix = 'static '
         else:
             prefix = ''
@@ -1877,6 +1877,10 @@ def kernel_can_gen_family_struct(family):
     return family.proto == 'genetlink'
 
 
+def policy_should_be_static(family):
+    return family.kernel_policy == 'split' or kernel_can_gen_family_struct(family)
+
+
 def print_kernel_op_table_fwd(family, cw, terminate):
     exported = not kernel_can_gen_family_struct(family)
 
-- 
2.41.0


