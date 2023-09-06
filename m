Return-Path: <netdev+bounces-32237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8681793ACF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E501C20A14
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00CDF41;
	Wed,  6 Sep 2023 11:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DEDDDD8
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:26 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7DCF1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so2896969f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998683; x=1694603483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhCH3rFxab4LPPoCgYcfHxD+gg+P5LWvlw29Xgd+vFI=;
        b=CfrWyUNvAPRYmrQ5zvChD3gL/fOmeCcHjT1vF4KoKcHCgaOWdxxfZDneTyOYgC+c9Z
         zbt2NAYvISlZjpm/0DUD6/bu0xCht/8iakdOzEttfYxirfrbw2tvU1w+g1IuXtjaUO03
         d/MelXUDQO/ewXkwPnjOsh08MiuNJlh1FeSgDHWqWyyPPN+2baW0us4xFaOGSNpkFKIC
         hTqXlokOn6VGByAmPbfIS0GYmc14oZnUZLOv1l8Qx/s57rjX8KC45OP0iZ3Hkn/EZnUE
         YoT6m3XhEfobL4szy4RghJq/CZKv0trr5mg40SU2SRrOSTPspUGxSUT3+yufXQRsuYGM
         OPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998683; x=1694603483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhCH3rFxab4LPPoCgYcfHxD+gg+P5LWvlw29Xgd+vFI=;
        b=PvxiLDgQ4X82GrvQ0oi1txKAx64fOXgkhXlHoD4/YfqOXyF58B6jpzpHAfsgN5fArN
         Hz5jYMEVWtpk3kFWvI9zEHjpOUx30mhxuRv9dkzLEK4LsZ0vpNUZuqqfzow+oJGPwnhT
         d/JVVzVRNHippnCyvFRMdkd4DkO4DxhcXVaw4HcYmP6Ug9BAsx4e13Q93zibah0yKu3m
         11YYUdT0TFVKp5PbhSMD7piLz9tkjZEKUpaj45n3U1MfEnPIG14lYR7UFwEfZYtlV72i
         sCGe33phOcZj+nNkCM51X97bk1O9Q/5ddq6txyJz3eJ1F/bXw83U+tR4ppTG8NYpQTIm
         uuBw==
X-Gm-Message-State: AOJu0Yz47Dq1sRR6Kp1hhC7k5VBhX8U8QYOwd2hk3wj1uB9rX7LXm1Zx
	VxFcdq+B9gedlubzIXobZmwwecUHkFnrnl1mygI=
X-Google-Smtp-Source: AGHT+IE7LbQorIXmBGqwu1UFG9FOoUtqj7aM3pO4FUKeMNN5KCmMEqcf8+8rRxr4RXgWoUXQbOWsww==
X-Received: by 2002:a5d:54c2:0:b0:313:e8b6:1699 with SMTP id x2-20020a5d54c2000000b00313e8b61699mr1750374wrv.55.1693998682791;
        Wed, 06 Sep 2023 04:11:22 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b0031971ab70c9sm20153435wro.73.2023.09.06.04.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 4/6] devlink: return -ENOENT if argument is missing
Date: Wed,  6 Sep 2023 13:11:11 +0200
Message-ID: <20230906111113.690815-5-jiri@resnulli.us>
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

In preparation to the follow-up dump selector patch, make sure that the
command line arguments parsing function returns -ENOENT in case the
option is missing so the caller can distinguish.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 083a30d7536c..7888173fb4bc 100644
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


