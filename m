Return-Path: <netdev+bounces-31582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664D78EE7B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01299281572
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5E11C9D;
	Thu, 31 Aug 2023 13:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466811C82
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:22:41 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47ECEB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401d67434daso7800745e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693488159; x=1694092959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLucJPRDjS5JeAlu2s6d3E9cWHltRgyGs33l+Nj7uBY=;
        b=B+6TiTHNXnw/fHpI8Wywez/bBdBSvuIRE50uMbVm1bUA1WL2FqMnwR1RBnkg/C6oH9
         cPyD0CdTXcF3v7UkqXR0+1FxvaYxuFn+uCzJRX0NjVLtJA/Jr00OX1MsOVjWRWHPUym1
         uc3L85cZlD5F5s0AHfHPrvEFSe7eEv8J34eI9wFNpsTkLLaMw60u2+IjD/+YEYijr1Jf
         hPO66Cg4gtVgHLUBWu33/HIzpat3doTbYzL+7G1uMHrqqGvcibQgCKS6Q8ZY0appP2Gy
         gUG+qkB76GJr2P7Tfr9invMk4PlcoHjf9fixG+7aoRpGebZbXyOty+7Ut4I71kmpYhHU
         a9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693488159; x=1694092959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLucJPRDjS5JeAlu2s6d3E9cWHltRgyGs33l+Nj7uBY=;
        b=A+nvBdyrVdLq+8ZdckkHBZIahp5Spgw8I18ZVLvszH9wvtsEcITXypD+BaS3fWLTmm
         T9AP4pG9riS2avDb5lB7GcDu9M3fsbvHGxDQa4cESMZLNkhOMfeeHYSj+8T5rIL+cHMR
         Tt/1U1ITfektiRQqNJrQ4TfGIKYOkKDfP58TcpZto4qJedV5ELy4CHEY6MTDKAuMjFtN
         tqpfebuFEry8V9TWbU+st0cPYer4INwiTM3JC46bbqjD1HG0YTwzx3fWMVTI8tnq4Czy
         ZN3jGMIQSXKcJc9r74Jx+0ejGz0uhLEcQ+2cFPhn4N7hpgyHtZdUBLBrDlceo1du1/0x
         O9MQ==
X-Gm-Message-State: AOJu0Yz1h9ZDnaebzB3bU2hu9GUm6SJYmangEC8i5z8VDYQ7fMCpd3Y9
	1nruYrwbpXLwYSsiVRyFq+7ag2wsntf4Br2xXHc=
X-Google-Smtp-Source: AGHT+IGPFmpt8rnQmejMFmsgnH49il6+s+yQc51+YjF/XOlzs0Ym7FYbjGSz03rrNQNrEymwhjAqgg==
X-Received: by 2002:a05:600c:446:b0:401:bbeb:97c4 with SMTP id s6-20020a05600c044600b00401bbeb97c4mr4508873wmb.37.1693488158693;
        Thu, 31 Aug 2023 06:22:38 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600011c900b0031c77c010e1sm2191511wrx.96.2023.08.31.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:22:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 4/6] devlink: return -ENOENT if argument is missing
Date: Thu, 31 Aug 2023 15:22:27 +0200
Message-ID: <20230831132229.471693-5-jiri@resnulli.us>
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

In preparation to the follow-up dump selector patch, make sure that the
command line arguments parsing function returns -ENOENT in case the
option is missing so the caller can distinguish.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 8d2424f58cc2..6a46a4ecf648 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -1048,7 +1048,7 @@ static int strtobool(const char *str, bool *p_val)
 static int ident_str_validate(char *str, unsigned int expected)
 {
 	if (!str)
-		return -EINVAL;
+		return -ENOENT;
 
 	if (get_str_char_count(str, '/') != expected) {
 		pr_err("Wrong identification string format.\n");
@@ -1131,7 +1131,7 @@ static int dl_argv_handle_port(struct dl *dl, char *str, char **p_bus_name,
 
 	if (!str) {
 		pr_err("Port identification (\"bus_name/dev_name/port_index\" or \"netdev ifname\") expected.\n");
-		return -EINVAL;
+		return -ENOENT;
 	}
 	slash_count = get_str_char_count(str, '/');
 	switch (slash_count) {
@@ -1159,7 +1159,7 @@ static int dl_argv_handle_both(struct dl *dl, char *str, char **p_bus_name,
 		pr_err("One of following identifications expected:\n"
 		       "Devlink identification (\"bus_name/dev_name\")\n"
 		       "Port identification (\"bus_name/dev_name/port_index\" or \"netdev ifname\")\n");
-		return -EINVAL;
+		return -ENOENT;
 	}
 	slash_count = get_str_char_count(str, '/');
 	if (slash_count == 1) {
@@ -1681,7 +1681,7 @@ static int dl_args_finding_required_validate(uint64_t o_required,
 		o_flag = dl_args_required[i].o_flag;
 		if ((o_required & o_flag) && !(o_found & o_flag)) {
 			pr_err("%s\n", dl_args_required[i].err_msg);
-			return -EINVAL;
+			return -ENOENT;
 		}
 	}
 	if (o_required & ~o_found) {
-- 
2.41.0


