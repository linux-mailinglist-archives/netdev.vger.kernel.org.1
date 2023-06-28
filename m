Return-Path: <netdev+bounces-14465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D19741C86
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 01:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DDD280D0B
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC311190;
	Wed, 28 Jun 2023 23:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DEB11185
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:38:19 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4E1BDF
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b80ddce748so661635ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687995497; x=1690587497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+7VmZFDHYdTl/J7POY8Q85vpg2oR4oUgRKjOWkmrcQ=;
        b=bWKr/eOf67zNMKDTWsMNLC9U/VX/qZ9T+sL93jrCi3BXD9XKBhIal8UQAokECwjtik
         JsZgOh+3zpiC+G9zgfrBTttcWwy75k56h+4KBtohkkb97F2OXiwaJYzDwFgH7EPMjqWC
         ItNjcyGxMcVsP4bIqDoFn534bRsu1JgZ5eF1GGzn18i8fozpjpiMDLKdYwlM6xFH+jYT
         x1m6yjALxo8JNQmKsdyb3bUl9+9tyJyOT7tUIypmc1Uj8Bxag3GIEGS37k7qBAmQsWky
         O4u4kQTq9WIK6zewmXh43FBhWXZBQ+ImsHok1lY9pY8v6zoMbHG6t+0R5u34Kw0n90cq
         qBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995497; x=1690587497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+7VmZFDHYdTl/J7POY8Q85vpg2oR4oUgRKjOWkmrcQ=;
        b=cN72MhJBW0MO1B1SvOuoeI5J1nq4tx+b7GGgLyhj/fba6Pol5aY+O8OH4GG2A9aeYX
         yjkF335yPQg+LbSqqQ5Nb1nqF4APfJGoqBEIPfKPFcny0wM7RY0Eo4X0Dyeh1ootxh8L
         MtIWLgg2tDyZBUk2BXLMFtYHOLjHnrv9cgWdOPr2NQ5drsnv7CW34ir3XHjcjXQiDKbJ
         f/PwrObouZnnFgWGPx0EqiBfc97rwJbxkYl+hRU4njiWTcKFVDONNzYKc1X2so6b+cdY
         gnVMbJ+lwasrNcVVHztftlcSaxTQ6hAhb1U4/vL3QvRA0Bg1qc+/TJkQ5RNJv5GUXAam
         Nw0w==
X-Gm-Message-State: AC+VfDwVeFCffSoBHWUv0/VyuLqZr9K0CSfvyhGjoMiqdZMyc8MH1GEo
	QOY7cK+AwlscI5t4z4OJhQ6kyYZCyz0xCZamZx6FnQ==
X-Google-Smtp-Source: ACHHUZ7pvaMXIGblilwJCRl+wfu7npl7dJzWXvFGJ7euCvihE+UshanpnhC9aCr/9dFnCf7g7+0Nhw==
X-Received: by 2002:a17:902:7591:b0:1b1:76c2:296a with SMTP id j17-20020a170902759100b001b176c2296amr8985472pll.60.1687995497381;
        Wed, 28 Jun 2023 16:38:17 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm6437196plq.258.2023.06.28.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:38:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/5] dcb: fully initialize flag table
Date: Wed, 28 Jun 2023 16:38:09 -0700
Message-Id: <20230628233813.6564-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628233813.6564-1-stephen@networkplumber.org>
References: <20230628233813.6564-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

And make the flag table const since only used for lookup.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 dcb/dcb_dcbx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dcb/dcb_dcbx.c b/dcb/dcb_dcbx.c
index 244b671b893b..9e3dd2a0af87 100644
--- a/dcb/dcb_dcbx.c
+++ b/dcb/dcb_dcbx.c
@@ -42,12 +42,12 @@ struct dcb_dcbx_flag {
 	const char *key_json;
 };
 
-static struct dcb_dcbx_flag dcb_dcbx_flags[] = {
-	{DCB_CAP_DCBX_HOST, "host"},
-	{DCB_CAP_DCBX_LLD_MANAGED, "lld-managed", "lld_managed"},
-	{DCB_CAP_DCBX_VER_CEE, "cee"},
-	{DCB_CAP_DCBX_VER_IEEE, "ieee"},
-	{DCB_CAP_DCBX_STATIC, "static"},
+static const struct dcb_dcbx_flag dcb_dcbx_flags[] = {
+	{DCB_CAP_DCBX_HOST, "host", NULL },
+	{DCB_CAP_DCBX_LLD_MANAGED, "lld-managed", "lld_managed" },
+	{DCB_CAP_DCBX_VER_CEE, "cee", NULL },
+	{DCB_CAP_DCBX_VER_IEEE, "ieee", NULL },
+	{DCB_CAP_DCBX_STATIC, "static", NULL },
 };
 
 static void dcb_dcbx_print(__u8 dcbx)
@@ -60,7 +60,7 @@ static void dcb_dcbx_print(__u8 dcbx)
 
 		bit--;
 		for (i = 0; i < ARRAY_SIZE(dcb_dcbx_flags); i++) {
-			struct dcb_dcbx_flag *flag = &dcb_dcbx_flags[i];
+			const struct dcb_dcbx_flag *flag = &dcb_dcbx_flags[i];
 
 			if (flag->value == 1 << bit) {
 				print_bool(PRINT_JSON, flag->key_json ?: flag->key_fp,
@@ -123,7 +123,7 @@ static int dcb_cmd_dcbx_set(struct dcb *dcb, const char *dev, int argc, char **a
 		}
 
 		for (i = 0; i < ARRAY_SIZE(dcb_dcbx_flags); i++) {
-			struct dcb_dcbx_flag *flag = &dcb_dcbx_flags[i];
+			const struct dcb_dcbx_flag *flag = &dcb_dcbx_flags[i];
 
 			if (matches(*argv, flag->key_fp) == 0) {
 				dcbx |= flag->value;
-- 
2.39.2


