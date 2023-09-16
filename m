Return-Path: <netdev+bounces-34308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD477A3104
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C50282178
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25B14273;
	Sat, 16 Sep 2023 15:03:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF013AD9
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:03:39 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7796CC9
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 08:03:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c364fb8a4cso29207255ad.1
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694876617; x=1695481417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6uFkpQtUWKcdRr72gbjphjN1goZHLTxWWbNt3YbQ4M=;
        b=he9e6frRoXvxAq+WBRGhZJAaGbrVI/ZVmQbmn2G3c3karWJVewGu/BpHvVA085xrqR
         1oL35aWpYA3uKPyQTmncjfuI1ZO8jXIgogT1x9wKT7h8gQwgJLxwEr5iH2fnd2wu4wW4
         MjOsf5VU/hqlpBD4OatWvvkaMI9LoBXnneqyqUI7i93zEJOUxJXq4+ph4IWmpgdwEbIj
         iSD30SGvkbqUYuh1w67Xj9s98veVuypZQ6Kmf39HjQCS5XY+c/LeH00FZFXCjH7YfB9m
         Oz47kX/VELPRfj4IofBMAWtn25aPv9Gpkdq6z5sl9A3I6WKNVuoCmS7cUvmkCvxXrqgH
         qYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694876617; x=1695481417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6uFkpQtUWKcdRr72gbjphjN1goZHLTxWWbNt3YbQ4M=;
        b=ErPMEH+t+8MeQ4ZfzEFeUx7lzjXcTKFR1pnusHMF1NtiVS+OkT1UQ4E4jeN0SylK1W
         THzWfdZ67d4GiAUBNIS4cuVMk9ycfu+fpNjOE9aDKScxqdT8y8KqOBkHHr9sKYCRnxDO
         936M/1P9E07yt0bGoEQ5VlqOGmkxvuN8gTDN32tqeimBgOtUZ/rf9XZRrgL33a/y5A99
         eXkfv0kCT4LzMca6u5kX9h0SgQqOC4N9be7SqODcNPyUMU3DyWz37rsyiVQnKkVYdLne
         8iGmSE97Cg8aK3vYqpmywRwkRfLZa97kM9sWZkSy9Ws85oNlE5Tc9/U41+9Jkw4DwSJv
         LKcQ==
X-Gm-Message-State: AOJu0YwtMPWk72+odzIghBwhydLnnJ6m1JtMrC007Ip8uKOnZO1AjFno
	UBF6/4Q/eVUco0O/FbnOq8+D5ORvtdr3+11U4Bo=
X-Google-Smtp-Source: AGHT+IHp+TO6brCPRifi3oPfZGhXLhZF4QjPeqFKfVkJbUOCGRxjS242lj73Io+cutCKmxiAzTzb7g==
X-Received: by 2002:a17:902:ac88:b0:1c3:d9ed:d16e with SMTP id h8-20020a170902ac8800b001c3d9edd16emr4902565plr.39.1694876616764;
        Sat, 16 Sep 2023 08:03:36 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001bbc8d65de0sm5348099plg.67.2023.09.16.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 08:03:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 v2] allow overriding color option in environment
Date: Sat, 16 Sep 2023 08:03:26 -0700
Message-Id: <20230916150326.7942-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For ip, tc, and bridge command introduce IPROUTE_COLORS to enable
automatic colorization via environment variable.
Similar to how grep handles color flag.

Example:
  $ IPROUTE_COLORS=auto ip -br addr

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/bridge.c   |  2 +-
 include/color.h   |  1 +
 ip/ip.c           |  2 +-
 lib/color.c       | 36 +++++++++++++++++++++++++++---------
 man/man8/bridge.8 |  8 ++++++--
 man/man8/ip.8     | 14 ++++++++------
 man/man8/tc.8     |  8 ++++++--
 tc/tc.c           |  2 +-
 8 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 339101a874b1..d506f75ebc46 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -102,7 +102,7 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
-	int color = CONF_COLOR;
+	int color = default_color();
 
 	while (argc > 1) {
 		const char *opt = argv[1];
diff --git a/include/color.h b/include/color.h
index 17ec56f3d7b4..1ddd1bda5797 100644
--- a/include/color.h
+++ b/include/color.h
@@ -20,6 +20,7 @@ enum color_opt {
 	COLOR_OPT_ALWAYS = 2
 };
 
+int default_color(void);
 bool check_enable_color(int color, int json);
 bool matches_color(const char *arg, int *val);
 int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...);
diff --git a/ip/ip.c b/ip/ip.c
index 860ff957c3b3..0befe14e3d66 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file = NULL;
 	char *basename;
-	int color = CONF_COLOR;
+	int color = default_color();
 
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/lib/color.c b/lib/color.c
index 59976847295c..e2ffefaf75a8 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -93,6 +93,32 @@ bool check_enable_color(int color, int json)
 	return false;
 }
 
+static bool match_color_value(const char *arg, int *val)
+{
+	if (*arg == '\0' || !strcmp(arg, "always"))
+		*val = COLOR_OPT_ALWAYS;
+	else if (!strcmp(arg, "auto"))
+		*val = COLOR_OPT_AUTO;
+	else if (!strcmp(arg, "never"))
+		*val = COLOR_OPT_NEVER;
+	else
+		return false;
+	return true;
+}
+
+int default_color(void)
+{
+	const char *name;
+	int val;
+
+	name = getenv("IPROUTE_COLORS");
+	if (name && *name && match_color_value(name, &val))
+		return val;
+
+	/* default is from config */
+	return CONF_COLOR;
+}
+
 bool matches_color(const char *arg, int *val)
 {
 	char *dup, *p;
@@ -108,15 +134,7 @@ bool matches_color(const char *arg, int *val)
 	if (matches(dup, "-color"))
 		return false;
 
-	if (*p == '\0' || !strcmp(p, "always"))
-		*val = COLOR_OPT_ALWAYS;
-	else if (!strcmp(p, "auto"))
-		*val = COLOR_OPT_AUTO;
-	else if (!strcmp(p, "never"))
-		*val = COLOR_OPT_NEVER;
-	else
-		return false;
-	return true;
+	return match_color_value(p, val);
 }
 
 static void set_color_palette(void)
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index c52c9331e2c2..6ad34e4d704a 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -315,10 +315,14 @@ color output is enabled regardless of stdout state. If parameter is
 stdout is checked to be a terminal before enabling color output. If parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
-precedence. This flag is ignored if
+precedence.
+The default color setting is
+.B never
+but can be overridden by the
+.B IPROUTE_COLORS
+environment variable. This flag is ignored if
 .B \-json
 is also given.
-
 .TP
 .BR "\-j", " \-json"
 Output results in JavaScript Object Notation (JSON).
diff --git a/man/man8/ip.8 b/man/man8/ip.8
index 72227d44fd30..63858edc318d 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -193,15 +193,17 @@ stdout is checked to be a terminal before enabling color output. If
 parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
-precedence. This flag is ignored if
+precedence.The default color setting is
+.B never
+but can be overridden by the
+.B IPROUTE_COLORS
+environment variable. This flag is ignored if
 .B \-json
 is also given.
 
-Used color palette can be influenced by
-.BR COLORFGBG
-environment variable
-(see
-.BR ENVIRONMENT ).
+The color palette used can be adjusted with
+.B COLORFGBG
+environment variable.
 
 .TP
 .BR "\-t" , " \-timestamp"
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d46472af..e47817704e4c 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -801,10 +801,14 @@ color output is enabled regardless of stdout state. If parameter is
 stdout is checked to be a terminal before enabling color output. If parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
-precedence. This flag is ignored if
+precedence.
+The default color setting is
+.B never
+but can be overridden by the
+.B IPROUTE_COLORS
+environment variable. This flag is ignored if
 .B \-json
 is also given.
-
 .TP
 .BR "\-j", " \-json"
 Display results in JSON format.
diff --git a/tc/tc.c b/tc/tc.c
index 082c6677d34a..e8b214802d1f 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -253,7 +253,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file = NULL;
-	int color = CONF_COLOR;
+	int color = default_color();
 	int ret;
 
 	while (argc > 1) {
-- 
2.39.2


