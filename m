Return-Path: <netdev+bounces-23979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C676E681
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06292820AB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1632D18AEB;
	Thu,  3 Aug 2023 11:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C8182D1
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:51 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6A196
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1897141a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061223; x=1691666023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN4tj6ro1FneEJbRj7B8hPejpVe40Jja+XIMGYax1bc=;
        b=ViZKaG35m/RVktKxjSfoMr1R/MpX8GeTflhXDjZIGsJ5TsweEND2OQBmVB/De2OyPl
         xdPHVLCicERaK7Ghn2wJ5Dbs6SI9lZgMFnLalvzvqJIks/j3PF6SI0BKRVSNEEoNpwk1
         O9uvzFgxHacSlB87eUmEmbiHr/1ouM3z1mF0YEeMXNjTPt59KplS6iOr2GHePDsAzZCN
         9cCaitR3npys6RI2IvuaXrJ7i+Zi952M2n/yIM0cn9iVGdEEvJq8MRUaQlp0hKE0M0Fh
         P1fSPe36NkycHfnC3G1S/B/7t/CfDwCTZE8l3zF6ehM5YQ6c5ZE4eeHNJqCpwKu3Xoj2
         dgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061223; x=1691666023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN4tj6ro1FneEJbRj7B8hPejpVe40Jja+XIMGYax1bc=;
        b=lG0L+xc0s4X/3hyz08hA2MTUn9SPJjZyQpjoP+XHiL9i9tcmFPt3IuSUrXy3wywXxb
         kfrch9sZH3Yko/xpCLnzOhflio8VPnRnVTLM2NeJ4nZ0UgkFlihKIx/msBIM/id8/HpW
         0ox2MWWwTAi18TtTX/pQEzYgSH8AFEjrdrq/dOvyK31/fJidUGdKn1+nmzgpLzen/vOc
         mje+hisgEEWBJuBm15Osnu3I9Hi8uBnPXJOu8FCXIKtDjzl5Ub+MFOp3YSThY9vDZw/+
         U9AfW164o8CrTmMy9S7DJaFxpDTzan2tBNJvg9kFAZnzl6V0cWPoEn/oNPlRoqm8V943
         w3NQ==
X-Gm-Message-State: AOJu0Yzk1uMbIB2L4VRVUluxTa2NdXgW75jQ49HiH8sef9sksjYcrbVb
	ORfc7iT3gQ+j+G0hiZLQ39i0meQoKUw11mgcPpZutg==
X-Google-Smtp-Source: AGHT+IFfKEDSdHtXB84nQN575Q7J6SQA2UgXD+6kQHjjqzA6iGfePKlJOeFdiGlYEK/nvI1HidGi5g==
X-Received: by 2002:aa7:c694:0:b0:523:100b:70da with SMTP id n20-20020aa7c694000000b00523100b70damr953683edq.4.1691061223330;
        Thu, 03 Aug 2023 04:13:43 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402044400b00521d2f7459fsm10098432edw.49.2023.08.03.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:42 -0700 (PDT)
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
Subject: [patch net-next v3 01/12] netlink: specs: add dump-strict flag for dont-validate property
Date: Thu,  3 Aug 2023 13:13:29 +0200
Message-ID: <20230803111340.1074067-2-jiri@resnulli.us>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Allow user to specify GENL_DONT_VALIDATE_DUMP_STRICT flag for validation
and add this flag to netlink spec schema.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 57d1c1c4918f..4c1f8c22627b 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -274,7 +274,7 @@ properties:
               description: Kernel attribute validation flags.
               type: array
               items:
-                enum: [ strict, dump ]
+                enum: [ strict, dump, dump-strict ]
             do: &subop-type
               description: Main command handler.
               type: object
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 43b769c98fb2..196076dfa309 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -321,7 +321,7 @@ properties:
               description: Kernel attribute validation flags.
               type: array
               items:
-                enum: [ strict, dump ]
+                enum: [ strict, dump, dump-strict ]
             # Start genetlink-legacy
             fixed-header: *fixed-header
             # End genetlink-legacy
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 1cbb448d2f1c..3d338c48bf21 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -243,7 +243,7 @@ properties:
               description: Kernel attribute validation flags.
               type: array
               items:
-                enum: [ strict, dump ]
+                enum: [ strict, dump, dump-strict ]
             do: &subop-type
               description: Main command handler.
               type: object
-- 
2.41.0


