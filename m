Return-Path: <netdev+bounces-32234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03E793ACA
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9752812CF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DCE6AB7;
	Wed,  6 Sep 2023 11:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B46AB5
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:20 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFECFA
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so55784651fa.0
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998678; x=1694603478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/49kA7NbRzpxOH1/QLUSTuTSpQSG/IOLebElBTODjac=;
        b=BJ07LgPAauWaLUGLFX8pTynf0AYfMJ6t2LIh/K8sz2/Pl3VFQb7USE4in0URwkkpNm
         UcyIBpGinRI9+6Ez0plW0F3tbduVmSoKhIk/lR3G8CNgXTir1+p1OZLXTmNVOYKZzU+c
         mY96QsjiAvQZiYJZS30D6vfNIn8Nt/t2cBKdt/pyuOE536LSD/xYUjyAhn+jZxJo8Gz5
         CQ9W0/H6LN04Zv5QsYuXOP9v0CYYKEJtQUEFR3FE670HytjDEPvnfpLc/an6Tm2wnqrS
         rBXA8vxcU21x11OoIQcDvkj+dCh11vZ+HaDT3JQspLUYkAVDcPzkqK7SoVTeP7ilbj0i
         FLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998678; x=1694603478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/49kA7NbRzpxOH1/QLUSTuTSpQSG/IOLebElBTODjac=;
        b=Eu2dr+NjXHgxWr+XUufv4IUmVDmsRRvX373w/H59wXP5R38G/ySNHQk76qI6Ob2Cf8
         qLzyrhVNQ6T/4vnw8hDyps2eBlVqfNzJFU2DjWpC8zH6kR5FpWh7QDF71vQ3B7dKfvfy
         VetYuIdOLPbAHu2H/+hQufzspwgEcMPDSrlyPtuFx0iPbjMWM7nwfnRzlVJAhCZYXS6b
         Y8ulm1LeGXkbpFjf/pzEYpNJYJhI5UhlFNePL7KUBzBwmX0xpS4WJbl33UVWmlcV4KnC
         4Rf9mjPo2lmMLZH2N7xR9aCzCFp6rO2zDucASf1gqUloKmEwEe55axsVYf7ZrcuVExL+
         FZLA==
X-Gm-Message-State: AOJu0YzdUwZ5/3wK13EPs/1q38xbVm49gX4MJCdN0MYfs6eaTJggRM7P
	2QWlMH2MtNlMqLz9QSRqRJTBp5Ln5gr3dzj6DMM=
X-Google-Smtp-Source: AGHT+IFjcyBvfVzIGQlwVOMPmFVMXZIMwqDzZ0SUjxCwlpYcQSFHjXfb5mdkd9FzCnVE/5nXX7/8eA==
X-Received: by 2002:a2e:b714:0:b0:2bc:e330:660b with SMTP id j20-20020a2eb714000000b002bce330660bmr1982323ljo.9.1693998677695;
        Wed, 06 Sep 2023 04:11:17 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n18-20020a1c7212000000b003fefaf299b6sm19448707wmc.38.2023.09.06.04.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 1/6] devlink: move DL_OPT_SB into required options
Date: Wed,  6 Sep 2023 13:11:08 +0200
Message-ID: <20230906111113.690815-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906111113.690815-1-jiri@resnulli.us>
References: <20230906111113.690815-1-jiri@resnulli.us>
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

This is basically a cosmetic change. The SB index is not required to be
passed by user and implicitly index 0 is used. This is ensured by
special treating at the end of dl_argv_parse(). Move this option from
optional to required options.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed o_found bit set
---
 devlink/devlink.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 616720a9051f..6643f659a8bd 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2269,13 +2269,13 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 		}
 	}
 
-	opts->present = o_found;
-
-	if ((o_optional & DL_OPT_SB) && !(o_found & DL_OPT_SB)) {
+	if ((o_required & DL_OPT_SB) && !(o_found & DL_OPT_SB)) {
 		opts->sb_index = 0;
-		opts->present |= DL_OPT_SB;
+		o_found |= DL_OPT_SB;
 	}
 
+	opts->present = o_found;
+
 	return dl_args_finding_required_validate(o_required, o_found);
 }
 
@@ -5721,7 +5721,7 @@ static int cmd_sb_show(struct dl *dl)
 		flags |= NLM_F_DUMP;
 	}
 	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE, DL_OPT_SB);
+		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB, 0);
 		if (err)
 			return err;
 	}
@@ -5800,8 +5800,8 @@ static int cmd_sb_pool_show(struct dl *dl)
 		flags |= NLM_F_DUMP;
 	}
 	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB_POOL,
-				    DL_OPT_SB);
+		err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB |
+				    DL_OPT_SB_POOL, 0);
 		if (err)
 			return err;
 	}
@@ -5821,8 +5821,8 @@ static int cmd_sb_pool_set(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB_POOL |
-			    DL_OPT_SB_SIZE | DL_OPT_SB_THTYPE, DL_OPT_SB);
+	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB | DL_OPT_SB_POOL |
+			    DL_OPT_SB_SIZE | DL_OPT_SB_THTYPE, 0);
 	if (err)
 		return err;
 
@@ -5889,8 +5889,8 @@ static int cmd_sb_port_pool_show(struct dl *dl)
 		flags |= NLM_F_DUMP;
 	}
 	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB_POOL,
-				    DL_OPT_SB);
+		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB |
+				    DL_OPT_SB_POOL, 0);
 		if (err)
 			return err;
 	}
@@ -5910,8 +5910,8 @@ static int cmd_sb_port_pool_set(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB_POOL | DL_OPT_SB_TH,
-			    DL_OPT_SB);
+	err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB | DL_OPT_SB_POOL |
+			    DL_OPT_SB_TH, 0);
 	if (err)
 		return err;
 
@@ -5996,8 +5996,8 @@ static int cmd_sb_tc_bind_show(struct dl *dl)
 		flags |= NLM_F_DUMP;
 	}
 	else {
-		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB_TC |
-				    DL_OPT_SB_TYPE, DL_OPT_SB);
+		err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB | DL_OPT_SB_TC |
+				    DL_OPT_SB_TYPE, 0);
 		if (err)
 			return err;
 	}
@@ -6017,9 +6017,8 @@ static int cmd_sb_tc_bind_set(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB_TC |
-			    DL_OPT_SB_TYPE | DL_OPT_SB_POOL | DL_OPT_SB_TH,
-			    DL_OPT_SB);
+	err = dl_argv_parse(dl, DL_OPT_HANDLEP | DL_OPT_SB | DL_OPT_SB_TC |
+			    DL_OPT_SB_TYPE | DL_OPT_SB_POOL | DL_OPT_SB_TH, 0);
 	if (err)
 		return err;
 
@@ -6338,7 +6337,7 @@ static int cmd_sb_occ_show(struct dl *dl)
 	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP;
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_HANDLEP, DL_OPT_SB);
+	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_HANDLEP | DL_OPT_SB, 0);
 	if (err)
 		return err;
 
@@ -6374,7 +6373,7 @@ static int cmd_sb_occ_snapshot(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLE, DL_OPT_SB);
+	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB, 0);
 	if (err)
 		return err;
 
@@ -6391,7 +6390,7 @@ static int cmd_sb_occ_clearmax(struct dl *dl)
 	struct nlmsghdr *nlh;
 	int err;
 
-	err = dl_argv_parse(dl, DL_OPT_HANDLE, DL_OPT_SB);
+	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_SB, 0);
 	if (err)
 		return err;
 
-- 
2.41.0


