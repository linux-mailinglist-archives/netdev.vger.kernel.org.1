Return-Path: <netdev+bounces-31579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090D78EE77
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF161281565
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6F1172C;
	Thu, 31 Aug 2023 13:22:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18781172B
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:36 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9CCFE
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so631404f8f.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488153; x=1694092953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKFtUbKKPKW7K/rcbBsZRAnuPjgGSYr12XFfzjq1ADs=;
        b=kf9nhnqPzkeNzCAbW6WzAFcMpXYoiMis+gHqbRxs+F/sEzWiuXtptQctqrZwaCTjcs
         ip/JkyuCvpsw7xGvM77H64GflYmP5mqQzj+3J5lqkCuuw17O+Kg07ZvWt3nzlPgsxDDy
         3hzKMlt/9zoskaFcgeW/k7T80QLohSUkpuUBWPTcuhglVkTwUbreT86ABer2fZ1DhMrm
         UAF7dEVMyabPzpeRKZgXQIgTke+MLNcWXXQNKgK8fnCC/Eyb6On4jnZ6CWwcLVAa+p/m
         +NQxioonNEjepKxT/YtUMuIAoVAsxOQxCLZzFnrDucZQ3yv/sQg49YWhLGgcdn9EZLvS
         Abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488153; x=1694092953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKFtUbKKPKW7K/rcbBsZRAnuPjgGSYr12XFfzjq1ADs=;
        b=jEExvSsjBYW5A6qTTfbf3iC4HcHhRy3Db2Tx0Io0l6z+5NwHF3pwiGUnjVoL1+nsDN
         HGol9ZREFhurVVjY/Y7RDUswIuk2gbEJxAmGlnfale96pwkiidRuH4P+23TEXzM/kEdy
         Icj6fbKAOx3lccqJShXfu2+JbtSOpI/aYD2MvFTXdQ25dxNuWvwUTLJXl5QVqiBGnoyq
         sepHBjFKj0FpSxtdVUSGejlowFkI7ABXScDD9UKK4O4Fe56ASJei//mC2Q1dW0M4ttPr
         4hZySxSDLFRSNkSMHWTzNNA9MG1LNKBJjwxYUVGTKahYYU7WSZk7tF3dqfqLrgL5A/6E
         NDqQ==
X-Gm-Message-State: AOJu0YzkhBYXB0ZC+N9nWhRxqzuCbu56QXtk1h37IYOS6GZgHgSLeevV
	z6aTUFX7y7CuUeHEst350qaxfKb7y4HCdEzXR0s=
X-Google-Smtp-Source: AGHT+IGQxikohTMZlQVymFsctJxHER4F/gFHQpesrDcskYVnmXCenhIilohbeF5Fb56mEQCoHBQnow==
X-Received: by 2002:adf:e7cc:0:b0:31a:ccc6:b8de with SMTP id e12-20020adfe7cc000000b0031accc6b8demr4253729wrn.50.1693488153686;
        Thu, 31 Aug 2023 06:22:33 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id i5-20020adfefc5000000b0031759e6b43fsm2241102wrp.39.2023.08.31.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:33 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 1/6] devlink: move DL_OPT_SB into required options
Date: Thu, 31 Aug 2023 15:22:24 +0200
Message-ID: <20230831132229.471693-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831132229.471693-1-jiri@resnulli.us>
References: <20230831132229.471693-1-jiri@resnulli.us>
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
 devlink/devlink.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 616720a9051f..713ac1f201e2 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2271,7 +2271,7 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 
 	opts->present = o_found;
 
-	if ((o_optional & DL_OPT_SB) && !(o_found & DL_OPT_SB)) {
+	if ((o_required & DL_OPT_SB) && !(o_found & DL_OPT_SB)) {
 		opts->sb_index = 0;
 		opts->present |= DL_OPT_SB;
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


