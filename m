Return-Path: <netdev+bounces-34131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AF7A23C2
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB92B1C20B77
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E3811C86;
	Fri, 15 Sep 2023 16:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B43107B5
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:43:43 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F52701
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:43:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2746af1b835so1629242a91.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694796221; x=1695401021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m53qMJm4RuVXwBwIzA52N27etyKUHXZb5lwpVSZrmRc=;
        b=Iq4AgKyjEfi/cnti1RY5Veg+BZbtAqy0RFL4H0Q9YjzbmqfRRNuToXMBAbhr9qO2ap
         MClp7u0C9cK+c119Et1ZvKiU+C8nuR4mXMZBvBepH/7KehUBQfWZk8zPnMI9I6AL5EXN
         b3NmyjxGL9PT56xR8wM/H1OiEBVIHHYjdLPgJhr+guo050L0FTO/dBvIRfJujqNjUQ3j
         +gPWoNIX+RXpsbwWI8DWqIZhRqUqrJcH73+26eSvGMat4r381qmNlLIxxPaag17rpdxt
         XWhdcfP0zo078AktaJ8LW4G4ZY/Svx0tg2Wfv72w4Vz2JAzoNHI7bugSxKZHPqQFOHt1
         u41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796221; x=1695401021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m53qMJm4RuVXwBwIzA52N27etyKUHXZb5lwpVSZrmRc=;
        b=AfHGbsSqy9v8N91Ko/IhtmTErbqk11lScysNjWLKsTzinXLiti6XO3vUQhX70jaU4j
         u+bOW2zfzOvRLbc7RcySNKhGLwmI8PyhimdfDSWUVeuI3E4eJhvt9jVDf1f2lJI52M0V
         TXCaaNwCNgo5g9oFIAALlUhFVYCqYbzglFW0Fs4+fpzDk1bm2rep4MUNeMjM6PynbnsK
         DFr3U1IKxMZ0aXsVeYMmY7Jj42GZnIXYFAHS+B3cQmpbXsRUFOJxXTwvMTYPh3Br47AU
         2nr3G7YPMknE2y5lXRz7TFleZ+g8zM1Kr+4TMcbwQ/pWDiEFI/R6b4XExLY4et76a1t4
         x8VA==
X-Gm-Message-State: AOJu0YzvSXXaihNG2+IcNqeKWUetT39VgnIW64Ck5MpajUnO54YEjtzN
	Whe4fPtBsR0V9upcXz8Is1DYD4+bBzLpktdMH6w=
X-Google-Smtp-Source: AGHT+IF+Eo6aQfN5dKcO0ndT8Ae4xIM0dmcr/AoB6qcT06O833vqIhGf5Vky2gBRs7knj4FdnjAXhQ==
X-Received: by 2002:a17:90a:4b06:b0:26f:2c5a:bbb3 with SMTP id g6-20020a17090a4b0600b0026f2c5abbb3mr1878549pjh.40.1694796220625;
        Fri, 15 Sep 2023 09:43:40 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b002680b2d2ab6sm5019701pjt.19.2023.09.15.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:43:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute] allow overriding color option in environment
Date: Fri, 15 Sep 2023 09:43:30 -0700
Message-Id: <20230915164330.59642-1-stephen@networkplumber.org>
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

For ip, tc, and bridge command introduce a new way to enable
automatic colorization via environment variable.

Example:
  $ IP_COLOR=auto ip -br show addr

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/bridge.c   |  3 ++-
 include/color.h   |  1 +
 ip/ip.c           |  2 +-
 lib/color.c       | 36 +++++++++++++++++++++++++++---------
 man/man8/bridge.8 |  7 +++++++
 man/man8/ip.8     | 14 +++++++++-----
 man/man8/tc.8     |  6 ++++++
 tc/tc.c           |  2 +-
 8 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 704be50c70b3..f9a245cb3670 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -23,7 +23,6 @@ int preferred_family = AF_UNSPEC;
 int oneline;
 int show_stats;
 int show_details;
-static int color;
 int compress_vlans;
 int json;
 int timestamp;
@@ -103,6 +102,8 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
+	int color = default_color("BRIDGE_COLOR");
+
 	while (argc > 1) {
 		const char *opt = argv[1];
 
diff --git a/include/color.h b/include/color.h
index 17ec56f3d7b4..8eea534f38e1 100644
--- a/include/color.h
+++ b/include/color.h
@@ -20,6 +20,7 @@ enum color_opt {
 	COLOR_OPT_ALWAYS = 2
 };
 
+int default_color(const char *argv0);
 bool check_enable_color(int color, int json);
 bool matches_color(const char *arg, int *val);
 int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...);
diff --git a/ip/ip.c b/ip/ip.c
index 8c046ef1df14..e15d5fe52d92 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file = NULL;
 	char *basename;
-	int color = 0;
+	int color = default_color("IP_COLOR");
 
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/lib/color.c b/lib/color.c
index 59976847295c..9262fc51c1f2 100644
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
+int default_color(const char *env)
+{
+	int val = COLOR_OPT_NEVER;
+	char *name;
+	size_t i;
+
+	name = getenv(env);
+	if (name && match_color_value(name, &val))
+		return val;
+
+	return COLOR_OPT_NEVER;
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
index c52c9331e2c2..58bb1ddbd26a 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -319,6 +319,13 @@ precedence. This flag is ignored if
 .B \-json
 is also given.
 
+
+The default color setting is
+.B never
+but can be overridden by the
+.B BRIDGE_COLOR
+environment variable.
+
 .TP
 .BR "\-j", " \-json"
 Output results in JavaScript Object Notation (JSON).
diff --git a/man/man8/ip.8 b/man/man8/ip.8
index 72227d44fd30..df572f47d96d 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -197,11 +197,15 @@ precedence. This flag is ignored if
 .B \-json
 is also given.
 
-Used color palette can be influenced by
-.BR COLORFGBG
-environment variable
-(see
-.BR ENVIRONMENT ).
+The default color setting is
+.B never
+but can be overridden by the
+.B IP_COLOR
+environment variable.
+
+The color palette used can be adjusted with
+.B COLORFGBG
+environment variable.
 
 .TP
 .BR "\-t" , " \-timestamp"
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d46472af..39ac6dcd1631 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -805,6 +805,12 @@ precedence. This flag is ignored if
 .B \-json
 is also given.
 
+The default color setting is
+.B never
+but can be overridden by the
+.B TC_COLOR
+environment variable.
+
 .TP
 .BR "\-j", " \-json"
 Display results in JSON format.
diff --git a/tc/tc.c b/tc/tc.c
index 258205004611..b7cd60d68a38 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -35,7 +35,6 @@ int use_iec;
 int force;
 bool use_names;
 int json;
-int color;
 int oneline;
 int brief;
 
@@ -254,6 +253,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file = NULL;
+	int color = default_color("TC_COLOR");
 	int ret;
 
 	while (argc > 1) {
-- 
2.39.2


