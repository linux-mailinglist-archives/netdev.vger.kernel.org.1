Return-Path: <netdev+bounces-32236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED6793ACC
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E156281282
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8E8485;
	Wed,  6 Sep 2023 11:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AAD302
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:11:23 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1714CF1
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:11:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so33603035e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693998681; x=1694603481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc07gUrEa1v0ePDe/KW2kJ9soi813zSDeGup9nFhHEI=;
        b=WvSWQgNiPTLfXH0wJ0oAshiB7PoApOsOUXfCovvqSHjmPYzw947u3NddcMdBjddoaK
         IjYr4iZ8DMWxup/Au7JjjCRnrbjsdbw/bf3BHIJBGiZDILywqI6jKCPpwJ1wM+KmS7bs
         H99yQu6w+/BC5SAX/j7iDwhtd+w2gn9/msl+umRx7NqrqJI0TMkDTQ2cUize/8YJmsQ6
         RZo0GYEYH+WJmQtZzTuRvq99jbQYb0FsFE7h4z9Qe6Nt4mjpJxJMfkUAxfAX856fWBgR
         kXAKKvqKuG7q1iVdoMfghHUHi7iunokeRatWdNhrbR42lsciWD37guxs19EytBYAt5wT
         r5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998681; x=1694603481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc07gUrEa1v0ePDe/KW2kJ9soi813zSDeGup9nFhHEI=;
        b=VyTGncydDsk2nhihEM6C54BhTSbwKXOqE3vs+nxJuHMHXDZrXl2IrMSAK/rH/JLdUP
         Fze1mQAjobTXEsnz4To/k1hrsFa+DBoYYL+aFlvWRrPSl47Xy9fQ+VJaWgrll2psqJ4O
         0SH0NrlpBBWvgFDRnWF/m8GPAQ/mtMK9/AHtJIIYRMcVDHaJDszyeBHotx0/DGMz+sHP
         +J0FFgtRMMLhvFkhEd24UIJkpsboryJwEm3uM1cneLSuxdvlE/K+GGV2MegWoTgjFZe6
         InsJFzQ+XndoXrU0qkFvjmoL+frhmRD9Sqr5BKDNgwCCxpK5R86bNkNt65K1blxJtkZA
         PyQQ==
X-Gm-Message-State: AOJu0YywG3RW7zcfyZOKYowTqPeol07wihwSs46X7vopsqsLngkStyLR
	1QPlUBeVZJvru3dKB7mC2x8F+pQMWgzrQaCakw8=
X-Google-Smtp-Source: AGHT+IFg8mwj2o6F0QaHLS+v7yv6x3S5vpwWKSIr2Js+zS3VQuY8iSUZ5iDu0zD/X9MvC9rGCLdmaA==
X-Received: by 2002:a7b:cb8c:0:b0:401:906b:7e9d with SMTP id m12-20020a7bcb8c000000b00401906b7e9dmr2240838wmi.18.1693998681224;
        Wed, 06 Sep 2023 04:11:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003fe1a092925sm19452428wmk.19.2023.09.06.04.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:11:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next v2 3/6] devlink: implement command line args dry parsing
Date: Wed,  6 Sep 2023 13:11:10 +0200
Message-ID: <20230906111113.690815-4-jiri@resnulli.us>
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

In preparation to the follow-up dump selector patch, introduce function
dl_argv_dry_parse() which allows to do dry parsing of command line
arguments without printing out any error messages to the user.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f383028ec560..083a30d7536c 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -64,6 +64,7 @@
 static int g_new_line_count;
 static int g_indent_level;
 static bool g_indent_newline;
+static bool g_err_suspended;
 
 #define INDENT_STR_STEP 2
 #define INDENT_STR_MAXLEN 32
@@ -74,6 +75,8 @@ pr_err(const char *fmt, ...)
 {
 	va_list ap;
 
+	if (g_err_suspended)
+		return;
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
 	va_end(ap);
@@ -2284,6 +2287,21 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 	return dl_args_finding_required_validate(o_required, o_found);
 }
 
+static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
+			     uint64_t o_optional)
+{
+	char **argv = dl->argv;
+	int argc = dl->argc;
+	int err;
+
+	g_err_suspended = true;
+	err = dl_argv_parse(dl, o_required, o_optional);
+	g_err_suspended = false;
+	dl->argv = argv;
+	dl->argc = argc;
+	return err;
+}
+
 static void
 dl_function_attr_put(struct nlmsghdr *nlh, const struct dl_opts *opts)
 {
-- 
2.41.0


